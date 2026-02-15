// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'care_intelligence_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

IntelligenceReport _$IntelligenceReportFromJson(Map<String, dynamic> json) {
  return _IntelligenceReport.fromJson(json);
}

/// @nodoc
mixin _$IntelligenceReport {
  String get clientId => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get generatedAt => throw _privateConstructorUsedError;
  int get intelligenceScore => throw _privateConstructorUsedError;
  RiskSummary get riskSummary => throw _privateConstructorUsedError;
  List<Recommendation> get recommendations =>
      throw _privateConstructorUsedError;
  OutcomePredictions get outcomePredictions =>
      throw _privateConstructorUsedError;
  List<Alert> get alerts => throw _privateConstructorUsedError;
  List<NextAction> get nextActions => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IntelligenceReportCopyWith<IntelligenceReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntelligenceReportCopyWith<$Res> {
  factory $IntelligenceReportCopyWith(
          IntelligenceReport value, $Res Function(IntelligenceReport) then) =
      _$IntelligenceReportCopyWithImpl<$Res, IntelligenceReport>;
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
class _$IntelligenceReportCopyWithImpl<$Res, $Val extends IntelligenceReport>
    implements $IntelligenceReportCopyWith<$Res> {
  _$IntelligenceReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      intelligenceScore: null == intelligenceScore
          ? _value.intelligenceScore
          : intelligenceScore // ignore: cast_nullable_to_non_nullable
              as int,
      riskSummary: null == riskSummary
          ? _value.riskSummary
          : riskSummary // ignore: cast_nullable_to_non_nullable
              as RiskSummary,
      recommendations: null == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<Recommendation>,
      outcomePredictions: null == outcomePredictions
          ? _value.outcomePredictions
          : outcomePredictions // ignore: cast_nullable_to_non_nullable
              as OutcomePredictions,
      alerts: null == alerts
          ? _value.alerts
          : alerts // ignore: cast_nullable_to_non_nullable
              as List<Alert>,
      nextActions: null == nextActions
          ? _value.nextActions
          : nextActions // ignore: cast_nullable_to_non_nullable
              as List<NextAction>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RiskSummaryCopyWith<$Res> get riskSummary {
    return $RiskSummaryCopyWith<$Res>(_value.riskSummary, (value) {
      return _then(_value.copyWith(riskSummary: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $OutcomePredictionsCopyWith<$Res> get outcomePredictions {
    return $OutcomePredictionsCopyWith<$Res>(_value.outcomePredictions,
        (value) {
      return _then(_value.copyWith(outcomePredictions: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$IntelligenceReportImplCopyWith<$Res>
    implements $IntelligenceReportCopyWith<$Res> {
  factory _$$IntelligenceReportImplCopyWith(_$IntelligenceReportImpl value,
          $Res Function(_$IntelligenceReportImpl) then) =
      __$$IntelligenceReportImplCopyWithImpl<$Res>;
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
class __$$IntelligenceReportImplCopyWithImpl<$Res>
    extends _$IntelligenceReportCopyWithImpl<$Res, _$IntelligenceReportImpl>
    implements _$$IntelligenceReportImplCopyWith<$Res> {
  __$$IntelligenceReportImplCopyWithImpl(_$IntelligenceReportImpl _value,
      $Res Function(_$IntelligenceReportImpl) _then)
      : super(_value, _then);

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
    return _then(_$IntelligenceReportImpl(
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      intelligenceScore: null == intelligenceScore
          ? _value.intelligenceScore
          : intelligenceScore // ignore: cast_nullable_to_non_nullable
              as int,
      riskSummary: null == riskSummary
          ? _value.riskSummary
          : riskSummary // ignore: cast_nullable_to_non_nullable
              as RiskSummary,
      recommendations: null == recommendations
          ? _value._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<Recommendation>,
      outcomePredictions: null == outcomePredictions
          ? _value.outcomePredictions
          : outcomePredictions // ignore: cast_nullable_to_non_nullable
              as OutcomePredictions,
      alerts: null == alerts
          ? _value._alerts
          : alerts // ignore: cast_nullable_to_non_nullable
              as List<Alert>,
      nextActions: null == nextActions
          ? _value._nextActions
          : nextActions // ignore: cast_nullable_to_non_nullable
              as List<NextAction>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IntelligenceReportImpl implements _IntelligenceReport {
  const _$IntelligenceReportImpl(
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

  factory _$IntelligenceReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$IntelligenceReportImplFromJson(json);

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

  @override
  String toString() {
    return 'IntelligenceReport(clientId: $clientId, organizationId: $organizationId, generatedAt: $generatedAt, intelligenceScore: $intelligenceScore, riskSummary: $riskSummary, recommendations: $recommendations, outcomePredictions: $outcomePredictions, alerts: $alerts, nextActions: $nextActions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntelligenceReportImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IntelligenceReportImplCopyWith<_$IntelligenceReportImpl> get copyWith =>
      __$$IntelligenceReportImplCopyWithImpl<_$IntelligenceReportImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IntelligenceReportImplToJson(
      this,
    );
  }
}

abstract class _IntelligenceReport implements IntelligenceReport {
  const factory _IntelligenceReport(
      {required final String clientId,
      required final String organizationId,
      required final String generatedAt,
      required final int intelligenceScore,
      required final RiskSummary riskSummary,
      required final List<Recommendation> recommendations,
      required final OutcomePredictions outcomePredictions,
      required final List<Alert> alerts,
      required final List<NextAction> nextActions}) = _$IntelligenceReportImpl;

  factory _IntelligenceReport.fromJson(Map<String, dynamic> json) =
      _$IntelligenceReportImpl.fromJson;

  @override
  String get clientId;
  @override
  String get organizationId;
  @override
  String get generatedAt;
  @override
  int get intelligenceScore;
  @override
  RiskSummary get riskSummary;
  @override
  List<Recommendation> get recommendations;
  @override
  OutcomePredictions get outcomePredictions;
  @override
  List<Alert> get alerts;
  @override
  List<NextAction> get nextActions;
  @override
  @JsonKey(ignore: true)
  _$$IntelligenceReportImplCopyWith<_$IntelligenceReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RiskSummary _$RiskSummaryFromJson(Map<String, dynamic> json) {
  return _RiskSummary.fromJson(json);
}

/// @nodoc
mixin _$RiskSummary {
  double get overallRisk => throw _privateConstructorUsedError;
  List<String> get highRiskAreas => throw _privateConstructorUsedError;
  String get trendDirection => throw _privateConstructorUsedError;
  String get lastAssessment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RiskSummaryCopyWith<RiskSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RiskSummaryCopyWith<$Res> {
  factory $RiskSummaryCopyWith(
          RiskSummary value, $Res Function(RiskSummary) then) =
      _$RiskSummaryCopyWithImpl<$Res, RiskSummary>;
  @useResult
  $Res call(
      {double overallRisk,
      List<String> highRiskAreas,
      String trendDirection,
      String lastAssessment});
}

/// @nodoc
class _$RiskSummaryCopyWithImpl<$Res, $Val extends RiskSummary>
    implements $RiskSummaryCopyWith<$Res> {
  _$RiskSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? overallRisk = null,
    Object? highRiskAreas = null,
    Object? trendDirection = null,
    Object? lastAssessment = null,
  }) {
    return _then(_value.copyWith(
      overallRisk: null == overallRisk
          ? _value.overallRisk
          : overallRisk // ignore: cast_nullable_to_non_nullable
              as double,
      highRiskAreas: null == highRiskAreas
          ? _value.highRiskAreas
          : highRiskAreas // ignore: cast_nullable_to_non_nullable
              as List<String>,
      trendDirection: null == trendDirection
          ? _value.trendDirection
          : trendDirection // ignore: cast_nullable_to_non_nullable
              as String,
      lastAssessment: null == lastAssessment
          ? _value.lastAssessment
          : lastAssessment // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RiskSummaryImplCopyWith<$Res>
    implements $RiskSummaryCopyWith<$Res> {
  factory _$$RiskSummaryImplCopyWith(
          _$RiskSummaryImpl value, $Res Function(_$RiskSummaryImpl) then) =
      __$$RiskSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double overallRisk,
      List<String> highRiskAreas,
      String trendDirection,
      String lastAssessment});
}

/// @nodoc
class __$$RiskSummaryImplCopyWithImpl<$Res>
    extends _$RiskSummaryCopyWithImpl<$Res, _$RiskSummaryImpl>
    implements _$$RiskSummaryImplCopyWith<$Res> {
  __$$RiskSummaryImplCopyWithImpl(
      _$RiskSummaryImpl _value, $Res Function(_$RiskSummaryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? overallRisk = null,
    Object? highRiskAreas = null,
    Object? trendDirection = null,
    Object? lastAssessment = null,
  }) {
    return _then(_$RiskSummaryImpl(
      overallRisk: null == overallRisk
          ? _value.overallRisk
          : overallRisk // ignore: cast_nullable_to_non_nullable
              as double,
      highRiskAreas: null == highRiskAreas
          ? _value._highRiskAreas
          : highRiskAreas // ignore: cast_nullable_to_non_nullable
              as List<String>,
      trendDirection: null == trendDirection
          ? _value.trendDirection
          : trendDirection // ignore: cast_nullable_to_non_nullable
              as String,
      lastAssessment: null == lastAssessment
          ? _value.lastAssessment
          : lastAssessment // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RiskSummaryImpl implements _RiskSummary {
  const _$RiskSummaryImpl(
      {required this.overallRisk,
      required final List<String> highRiskAreas,
      required this.trendDirection,
      required this.lastAssessment})
      : _highRiskAreas = highRiskAreas;

  factory _$RiskSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$RiskSummaryImplFromJson(json);

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

  @override
  String toString() {
    return 'RiskSummary(overallRisk: $overallRisk, highRiskAreas: $highRiskAreas, trendDirection: $trendDirection, lastAssessment: $lastAssessment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RiskSummaryImpl &&
            (identical(other.overallRisk, overallRisk) ||
                other.overallRisk == overallRisk) &&
            const DeepCollectionEquality()
                .equals(other._highRiskAreas, _highRiskAreas) &&
            (identical(other.trendDirection, trendDirection) ||
                other.trendDirection == trendDirection) &&
            (identical(other.lastAssessment, lastAssessment) ||
                other.lastAssessment == lastAssessment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      overallRisk,
      const DeepCollectionEquality().hash(_highRiskAreas),
      trendDirection,
      lastAssessment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RiskSummaryImplCopyWith<_$RiskSummaryImpl> get copyWith =>
      __$$RiskSummaryImplCopyWithImpl<_$RiskSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RiskSummaryImplToJson(
      this,
    );
  }
}

abstract class _RiskSummary implements RiskSummary {
  const factory _RiskSummary(
      {required final double overallRisk,
      required final List<String> highRiskAreas,
      required final String trendDirection,
      required final String lastAssessment}) = _$RiskSummaryImpl;

  factory _RiskSummary.fromJson(Map<String, dynamic> json) =
      _$RiskSummaryImpl.fromJson;

  @override
  double get overallRisk;
  @override
  List<String> get highRiskAreas;
  @override
  String get trendDirection;
  @override
  String get lastAssessment;
  @override
  @JsonKey(ignore: true)
  _$$RiskSummaryImplCopyWith<_$RiskSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Recommendation _$RecommendationFromJson(Map<String, dynamic> json) {
  return _Recommendation.fromJson(json);
}

/// @nodoc
mixin _$Recommendation {
  String get category => throw _privateConstructorUsedError;
  String get recommendation => throw _privateConstructorUsedError;
  String get priority => throw _privateConstructorUsedError;
  String get expectedImpact => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecommendationCopyWith<Recommendation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecommendationCopyWith<$Res> {
  factory $RecommendationCopyWith(
          Recommendation value, $Res Function(Recommendation) then) =
      _$RecommendationCopyWithImpl<$Res, Recommendation>;
  @useResult
  $Res call(
      {String category,
      String recommendation,
      String priority,
      String expectedImpact});
}

/// @nodoc
class _$RecommendationCopyWithImpl<$Res, $Val extends Recommendation>
    implements $RecommendationCopyWith<$Res> {
  _$RecommendationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = null,
    Object? recommendation = null,
    Object? priority = null,
    Object? expectedImpact = null,
  }) {
    return _then(_value.copyWith(
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      recommendation: null == recommendation
          ? _value.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      expectedImpact: null == expectedImpact
          ? _value.expectedImpact
          : expectedImpact // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecommendationImplCopyWith<$Res>
    implements $RecommendationCopyWith<$Res> {
  factory _$$RecommendationImplCopyWith(_$RecommendationImpl value,
          $Res Function(_$RecommendationImpl) then) =
      __$$RecommendationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String category,
      String recommendation,
      String priority,
      String expectedImpact});
}

/// @nodoc
class __$$RecommendationImplCopyWithImpl<$Res>
    extends _$RecommendationCopyWithImpl<$Res, _$RecommendationImpl>
    implements _$$RecommendationImplCopyWith<$Res> {
  __$$RecommendationImplCopyWithImpl(
      _$RecommendationImpl _value, $Res Function(_$RecommendationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = null,
    Object? recommendation = null,
    Object? priority = null,
    Object? expectedImpact = null,
  }) {
    return _then(_$RecommendationImpl(
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      recommendation: null == recommendation
          ? _value.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      expectedImpact: null == expectedImpact
          ? _value.expectedImpact
          : expectedImpact // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecommendationImpl implements _Recommendation {
  const _$RecommendationImpl(
      {required this.category,
      required this.recommendation,
      required this.priority,
      required this.expectedImpact});

  factory _$RecommendationImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecommendationImplFromJson(json);

  @override
  final String category;
  @override
  final String recommendation;
  @override
  final String priority;
  @override
  final String expectedImpact;

  @override
  String toString() {
    return 'Recommendation(category: $category, recommendation: $recommendation, priority: $priority, expectedImpact: $expectedImpact)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecommendationImpl &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.recommendation, recommendation) ||
                other.recommendation == recommendation) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.expectedImpact, expectedImpact) ||
                other.expectedImpact == expectedImpact));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, category, recommendation, priority, expectedImpact);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecommendationImplCopyWith<_$RecommendationImpl> get copyWith =>
      __$$RecommendationImplCopyWithImpl<_$RecommendationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecommendationImplToJson(
      this,
    );
  }
}

abstract class _Recommendation implements Recommendation {
  const factory _Recommendation(
      {required final String category,
      required final String recommendation,
      required final String priority,
      required final String expectedImpact}) = _$RecommendationImpl;

  factory _Recommendation.fromJson(Map<String, dynamic> json) =
      _$RecommendationImpl.fromJson;

  @override
  String get category;
  @override
  String get recommendation;
  @override
  String get priority;
  @override
  String get expectedImpact;
  @override
  @JsonKey(ignore: true)
  _$$RecommendationImplCopyWith<_$RecommendationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OutcomePredictions _$OutcomePredictionsFromJson(Map<String, dynamic> json) {
  return _OutcomePredictions.fromJson(json);
}

/// @nodoc
mixin _$OutcomePredictions {
  GoalAchievementPrediction get goalAchievement =>
      throw _privateConstructorUsedError;
  HealthStabilityPrediction get healthStability =>
      throw _privateConstructorUsedError;
  ServiceUtilizationPrediction get serviceUtilization =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OutcomePredictionsCopyWith<OutcomePredictions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutcomePredictionsCopyWith<$Res> {
  factory $OutcomePredictionsCopyWith(
          OutcomePredictions value, $Res Function(OutcomePredictions) then) =
      _$OutcomePredictionsCopyWithImpl<$Res, OutcomePredictions>;
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
class _$OutcomePredictionsCopyWithImpl<$Res, $Val extends OutcomePredictions>
    implements $OutcomePredictionsCopyWith<$Res> {
  _$OutcomePredictionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? goalAchievement = null,
    Object? healthStability = null,
    Object? serviceUtilization = null,
  }) {
    return _then(_value.copyWith(
      goalAchievement: null == goalAchievement
          ? _value.goalAchievement
          : goalAchievement // ignore: cast_nullable_to_non_nullable
              as GoalAchievementPrediction,
      healthStability: null == healthStability
          ? _value.healthStability
          : healthStability // ignore: cast_nullable_to_non_nullable
              as HealthStabilityPrediction,
      serviceUtilization: null == serviceUtilization
          ? _value.serviceUtilization
          : serviceUtilization // ignore: cast_nullable_to_non_nullable
              as ServiceUtilizationPrediction,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GoalAchievementPredictionCopyWith<$Res> get goalAchievement {
    return $GoalAchievementPredictionCopyWith<$Res>(_value.goalAchievement,
        (value) {
      return _then(_value.copyWith(goalAchievement: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $HealthStabilityPredictionCopyWith<$Res> get healthStability {
    return $HealthStabilityPredictionCopyWith<$Res>(_value.healthStability,
        (value) {
      return _then(_value.copyWith(healthStability: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ServiceUtilizationPredictionCopyWith<$Res> get serviceUtilization {
    return $ServiceUtilizationPredictionCopyWith<$Res>(
        _value.serviceUtilization, (value) {
      return _then(_value.copyWith(serviceUtilization: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OutcomePredictionsImplCopyWith<$Res>
    implements $OutcomePredictionsCopyWith<$Res> {
  factory _$$OutcomePredictionsImplCopyWith(_$OutcomePredictionsImpl value,
          $Res Function(_$OutcomePredictionsImpl) then) =
      __$$OutcomePredictionsImplCopyWithImpl<$Res>;
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
class __$$OutcomePredictionsImplCopyWithImpl<$Res>
    extends _$OutcomePredictionsCopyWithImpl<$Res, _$OutcomePredictionsImpl>
    implements _$$OutcomePredictionsImplCopyWith<$Res> {
  __$$OutcomePredictionsImplCopyWithImpl(_$OutcomePredictionsImpl _value,
      $Res Function(_$OutcomePredictionsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? goalAchievement = null,
    Object? healthStability = null,
    Object? serviceUtilization = null,
  }) {
    return _then(_$OutcomePredictionsImpl(
      goalAchievement: null == goalAchievement
          ? _value.goalAchievement
          : goalAchievement // ignore: cast_nullable_to_non_nullable
              as GoalAchievementPrediction,
      healthStability: null == healthStability
          ? _value.healthStability
          : healthStability // ignore: cast_nullable_to_non_nullable
              as HealthStabilityPrediction,
      serviceUtilization: null == serviceUtilization
          ? _value.serviceUtilization
          : serviceUtilization // ignore: cast_nullable_to_non_nullable
              as ServiceUtilizationPrediction,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OutcomePredictionsImpl implements _OutcomePredictions {
  const _$OutcomePredictionsImpl(
      {required this.goalAchievement,
      required this.healthStability,
      required this.serviceUtilization});

  factory _$OutcomePredictionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$OutcomePredictionsImplFromJson(json);

  @override
  final GoalAchievementPrediction goalAchievement;
  @override
  final HealthStabilityPrediction healthStability;
  @override
  final ServiceUtilizationPrediction serviceUtilization;

  @override
  String toString() {
    return 'OutcomePredictions(goalAchievement: $goalAchievement, healthStability: $healthStability, serviceUtilization: $serviceUtilization)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutcomePredictionsImpl &&
            (identical(other.goalAchievement, goalAchievement) ||
                other.goalAchievement == goalAchievement) &&
            (identical(other.healthStability, healthStability) ||
                other.healthStability == healthStability) &&
            (identical(other.serviceUtilization, serviceUtilization) ||
                other.serviceUtilization == serviceUtilization));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, goalAchievement, healthStability, serviceUtilization);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OutcomePredictionsImplCopyWith<_$OutcomePredictionsImpl> get copyWith =>
      __$$OutcomePredictionsImplCopyWithImpl<_$OutcomePredictionsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OutcomePredictionsImplToJson(
      this,
    );
  }
}

abstract class _OutcomePredictions implements OutcomePredictions {
  const factory _OutcomePredictions(
          {required final GoalAchievementPrediction goalAchievement,
          required final HealthStabilityPrediction healthStability,
          required final ServiceUtilizationPrediction serviceUtilization}) =
      _$OutcomePredictionsImpl;

  factory _OutcomePredictions.fromJson(Map<String, dynamic> json) =
      _$OutcomePredictionsImpl.fromJson;

  @override
  GoalAchievementPrediction get goalAchievement;
  @override
  HealthStabilityPrediction get healthStability;
  @override
  ServiceUtilizationPrediction get serviceUtilization;
  @override
  @JsonKey(ignore: true)
  _$$OutcomePredictionsImplCopyWith<_$OutcomePredictionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GoalAchievementPrediction _$GoalAchievementPredictionFromJson(
    Map<String, dynamic> json) {
  return _GoalAchievementPrediction.fromJson(json);
}

/// @nodoc
mixin _$GoalAchievementPrediction {
  double get probability => throw _privateConstructorUsedError;
  String get timeline => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GoalAchievementPredictionCopyWith<GoalAchievementPrediction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoalAchievementPredictionCopyWith<$Res> {
  factory $GoalAchievementPredictionCopyWith(GoalAchievementPrediction value,
          $Res Function(GoalAchievementPrediction) then) =
      _$GoalAchievementPredictionCopyWithImpl<$Res, GoalAchievementPrediction>;
  @useResult
  $Res call({double probability, String timeline, double confidence});
}

/// @nodoc
class _$GoalAchievementPredictionCopyWithImpl<$Res,
        $Val extends GoalAchievementPrediction>
    implements $GoalAchievementPredictionCopyWith<$Res> {
  _$GoalAchievementPredictionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? probability = null,
    Object? timeline = null,
    Object? confidence = null,
  }) {
    return _then(_value.copyWith(
      probability: null == probability
          ? _value.probability
          : probability // ignore: cast_nullable_to_non_nullable
              as double,
      timeline: null == timeline
          ? _value.timeline
          : timeline // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GoalAchievementPredictionImplCopyWith<$Res>
    implements $GoalAchievementPredictionCopyWith<$Res> {
  factory _$$GoalAchievementPredictionImplCopyWith(
          _$GoalAchievementPredictionImpl value,
          $Res Function(_$GoalAchievementPredictionImpl) then) =
      __$$GoalAchievementPredictionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double probability, String timeline, double confidence});
}

/// @nodoc
class __$$GoalAchievementPredictionImplCopyWithImpl<$Res>
    extends _$GoalAchievementPredictionCopyWithImpl<$Res,
        _$GoalAchievementPredictionImpl>
    implements _$$GoalAchievementPredictionImplCopyWith<$Res> {
  __$$GoalAchievementPredictionImplCopyWithImpl(
      _$GoalAchievementPredictionImpl _value,
      $Res Function(_$GoalAchievementPredictionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? probability = null,
    Object? timeline = null,
    Object? confidence = null,
  }) {
    return _then(_$GoalAchievementPredictionImpl(
      probability: null == probability
          ? _value.probability
          : probability // ignore: cast_nullable_to_non_nullable
              as double,
      timeline: null == timeline
          ? _value.timeline
          : timeline // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GoalAchievementPredictionImpl implements _GoalAchievementPrediction {
  const _$GoalAchievementPredictionImpl(
      {required this.probability,
      required this.timeline,
      required this.confidence});

  factory _$GoalAchievementPredictionImpl.fromJson(Map<String, dynamic> json) =>
      _$$GoalAchievementPredictionImplFromJson(json);

  @override
  final double probability;
  @override
  final String timeline;
  @override
  final double confidence;

  @override
  String toString() {
    return 'GoalAchievementPrediction(probability: $probability, timeline: $timeline, confidence: $confidence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoalAchievementPredictionImpl &&
            (identical(other.probability, probability) ||
                other.probability == probability) &&
            (identical(other.timeline, timeline) ||
                other.timeline == timeline) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, probability, timeline, confidence);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GoalAchievementPredictionImplCopyWith<_$GoalAchievementPredictionImpl>
      get copyWith => __$$GoalAchievementPredictionImplCopyWithImpl<
          _$GoalAchievementPredictionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GoalAchievementPredictionImplToJson(
      this,
    );
  }
}

abstract class _GoalAchievementPrediction implements GoalAchievementPrediction {
  const factory _GoalAchievementPrediction(
      {required final double probability,
      required final String timeline,
      required final double confidence}) = _$GoalAchievementPredictionImpl;

  factory _GoalAchievementPrediction.fromJson(Map<String, dynamic> json) =
      _$GoalAchievementPredictionImpl.fromJson;

  @override
  double get probability;
  @override
  String get timeline;
  @override
  double get confidence;
  @override
  @JsonKey(ignore: true)
  _$$GoalAchievementPredictionImplCopyWith<_$GoalAchievementPredictionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

HealthStabilityPrediction _$HealthStabilityPredictionFromJson(
    Map<String, dynamic> json) {
  return _HealthStabilityPrediction.fromJson(json);
}

/// @nodoc
mixin _$HealthStabilityPrediction {
  double get probability => throw _privateConstructorUsedError;
  List<String> get factors => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HealthStabilityPredictionCopyWith<HealthStabilityPrediction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthStabilityPredictionCopyWith<$Res> {
  factory $HealthStabilityPredictionCopyWith(HealthStabilityPrediction value,
          $Res Function(HealthStabilityPrediction) then) =
      _$HealthStabilityPredictionCopyWithImpl<$Res, HealthStabilityPrediction>;
  @useResult
  $Res call({double probability, List<String> factors, double confidence});
}

/// @nodoc
class _$HealthStabilityPredictionCopyWithImpl<$Res,
        $Val extends HealthStabilityPrediction>
    implements $HealthStabilityPredictionCopyWith<$Res> {
  _$HealthStabilityPredictionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? probability = null,
    Object? factors = null,
    Object? confidence = null,
  }) {
    return _then(_value.copyWith(
      probability: null == probability
          ? _value.probability
          : probability // ignore: cast_nullable_to_non_nullable
              as double,
      factors: null == factors
          ? _value.factors
          : factors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HealthStabilityPredictionImplCopyWith<$Res>
    implements $HealthStabilityPredictionCopyWith<$Res> {
  factory _$$HealthStabilityPredictionImplCopyWith(
          _$HealthStabilityPredictionImpl value,
          $Res Function(_$HealthStabilityPredictionImpl) then) =
      __$$HealthStabilityPredictionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double probability, List<String> factors, double confidence});
}

/// @nodoc
class __$$HealthStabilityPredictionImplCopyWithImpl<$Res>
    extends _$HealthStabilityPredictionCopyWithImpl<$Res,
        _$HealthStabilityPredictionImpl>
    implements _$$HealthStabilityPredictionImplCopyWith<$Res> {
  __$$HealthStabilityPredictionImplCopyWithImpl(
      _$HealthStabilityPredictionImpl _value,
      $Res Function(_$HealthStabilityPredictionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? probability = null,
    Object? factors = null,
    Object? confidence = null,
  }) {
    return _then(_$HealthStabilityPredictionImpl(
      probability: null == probability
          ? _value.probability
          : probability // ignore: cast_nullable_to_non_nullable
              as double,
      factors: null == factors
          ? _value._factors
          : factors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HealthStabilityPredictionImpl implements _HealthStabilityPrediction {
  const _$HealthStabilityPredictionImpl(
      {required this.probability,
      required final List<String> factors,
      required this.confidence})
      : _factors = factors;

  factory _$HealthStabilityPredictionImpl.fromJson(Map<String, dynamic> json) =>
      _$$HealthStabilityPredictionImplFromJson(json);

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

  @override
  String toString() {
    return 'HealthStabilityPrediction(probability: $probability, factors: $factors, confidence: $confidence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HealthStabilityPredictionImpl &&
            (identical(other.probability, probability) ||
                other.probability == probability) &&
            const DeepCollectionEquality().equals(other._factors, _factors) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, probability,
      const DeepCollectionEquality().hash(_factors), confidence);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HealthStabilityPredictionImplCopyWith<_$HealthStabilityPredictionImpl>
      get copyWith => __$$HealthStabilityPredictionImplCopyWithImpl<
          _$HealthStabilityPredictionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HealthStabilityPredictionImplToJson(
      this,
    );
  }
}

abstract class _HealthStabilityPrediction implements HealthStabilityPrediction {
  const factory _HealthStabilityPrediction(
      {required final double probability,
      required final List<String> factors,
      required final double confidence}) = _$HealthStabilityPredictionImpl;

  factory _HealthStabilityPrediction.fromJson(Map<String, dynamic> json) =
      _$HealthStabilityPredictionImpl.fromJson;

  @override
  double get probability;
  @override
  List<String> get factors;
  @override
  double get confidence;
  @override
  @JsonKey(ignore: true)
  _$$HealthStabilityPredictionImplCopyWith<_$HealthStabilityPredictionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ServiceUtilizationPrediction _$ServiceUtilizationPredictionFromJson(
    Map<String, dynamic> json) {
  return _ServiceUtilizationPrediction.fromJson(json);
}

/// @nodoc
mixin _$ServiceUtilizationPrediction {
  String get predictedChange => throw _privateConstructorUsedError;
  int get percentage => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ServiceUtilizationPredictionCopyWith<ServiceUtilizationPrediction>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceUtilizationPredictionCopyWith<$Res> {
  factory $ServiceUtilizationPredictionCopyWith(
          ServiceUtilizationPrediction value,
          $Res Function(ServiceUtilizationPrediction) then) =
      _$ServiceUtilizationPredictionCopyWithImpl<$Res,
          ServiceUtilizationPrediction>;
  @useResult
  $Res call({String predictedChange, int percentage, double confidence});
}

/// @nodoc
class _$ServiceUtilizationPredictionCopyWithImpl<$Res,
        $Val extends ServiceUtilizationPrediction>
    implements $ServiceUtilizationPredictionCopyWith<$Res> {
  _$ServiceUtilizationPredictionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? predictedChange = null,
    Object? percentage = null,
    Object? confidence = null,
  }) {
    return _then(_value.copyWith(
      predictedChange: null == predictedChange
          ? _value.predictedChange
          : predictedChange // ignore: cast_nullable_to_non_nullable
              as String,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as int,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServiceUtilizationPredictionImplCopyWith<$Res>
    implements $ServiceUtilizationPredictionCopyWith<$Res> {
  factory _$$ServiceUtilizationPredictionImplCopyWith(
          _$ServiceUtilizationPredictionImpl value,
          $Res Function(_$ServiceUtilizationPredictionImpl) then) =
      __$$ServiceUtilizationPredictionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String predictedChange, int percentage, double confidence});
}

/// @nodoc
class __$$ServiceUtilizationPredictionImplCopyWithImpl<$Res>
    extends _$ServiceUtilizationPredictionCopyWithImpl<$Res,
        _$ServiceUtilizationPredictionImpl>
    implements _$$ServiceUtilizationPredictionImplCopyWith<$Res> {
  __$$ServiceUtilizationPredictionImplCopyWithImpl(
      _$ServiceUtilizationPredictionImpl _value,
      $Res Function(_$ServiceUtilizationPredictionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? predictedChange = null,
    Object? percentage = null,
    Object? confidence = null,
  }) {
    return _then(_$ServiceUtilizationPredictionImpl(
      predictedChange: null == predictedChange
          ? _value.predictedChange
          : predictedChange // ignore: cast_nullable_to_non_nullable
              as String,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as int,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceUtilizationPredictionImpl
    implements _ServiceUtilizationPrediction {
  const _$ServiceUtilizationPredictionImpl(
      {required this.predictedChange,
      required this.percentage,
      required this.confidence});

  factory _$ServiceUtilizationPredictionImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ServiceUtilizationPredictionImplFromJson(json);

  @override
  final String predictedChange;
  @override
  final int percentage;
  @override
  final double confidence;

  @override
  String toString() {
    return 'ServiceUtilizationPrediction(predictedChange: $predictedChange, percentage: $percentage, confidence: $confidence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceUtilizationPredictionImpl &&
            (identical(other.predictedChange, predictedChange) ||
                other.predictedChange == predictedChange) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, predictedChange, percentage, confidence);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceUtilizationPredictionImplCopyWith<
          _$ServiceUtilizationPredictionImpl>
      get copyWith => __$$ServiceUtilizationPredictionImplCopyWithImpl<
          _$ServiceUtilizationPredictionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceUtilizationPredictionImplToJson(
      this,
    );
  }
}

abstract class _ServiceUtilizationPrediction
    implements ServiceUtilizationPrediction {
  const factory _ServiceUtilizationPrediction(
      {required final String predictedChange,
      required final int percentage,
      required final double confidence}) = _$ServiceUtilizationPredictionImpl;

  factory _ServiceUtilizationPrediction.fromJson(Map<String, dynamic> json) =
      _$ServiceUtilizationPredictionImpl.fromJson;

  @override
  String get predictedChange;
  @override
  int get percentage;
  @override
  double get confidence;
  @override
  @JsonKey(ignore: true)
  _$$ServiceUtilizationPredictionImplCopyWith<
          _$ServiceUtilizationPredictionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

Alert _$AlertFromJson(Map<String, dynamic> json) {
  return _Alert.fromJson(json);
}

/// @nodoc
mixin _$Alert {
  String get severity => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get action => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AlertCopyWith<Alert> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlertCopyWith<$Res> {
  factory $AlertCopyWith(Alert value, $Res Function(Alert) then) =
      _$AlertCopyWithImpl<$Res, Alert>;
  @useResult
  $Res call({String severity, String type, String message, String action});
}

/// @nodoc
class _$AlertCopyWithImpl<$Res, $Val extends Alert>
    implements $AlertCopyWith<$Res> {
  _$AlertCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? severity = null,
    Object? type = null,
    Object? message = null,
    Object? action = null,
  }) {
    return _then(_value.copyWith(
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AlertImplCopyWith<$Res> implements $AlertCopyWith<$Res> {
  factory _$$AlertImplCopyWith(
          _$AlertImpl value, $Res Function(_$AlertImpl) then) =
      __$$AlertImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String severity, String type, String message, String action});
}

/// @nodoc
class __$$AlertImplCopyWithImpl<$Res>
    extends _$AlertCopyWithImpl<$Res, _$AlertImpl>
    implements _$$AlertImplCopyWith<$Res> {
  __$$AlertImplCopyWithImpl(
      _$AlertImpl _value, $Res Function(_$AlertImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? severity = null,
    Object? type = null,
    Object? message = null,
    Object? action = null,
  }) {
    return _then(_$AlertImpl(
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AlertImpl implements _Alert {
  const _$AlertImpl(
      {required this.severity,
      required this.type,
      required this.message,
      required this.action});

  factory _$AlertImpl.fromJson(Map<String, dynamic> json) =>
      _$$AlertImplFromJson(json);

  @override
  final String severity;
  @override
  final String type;
  @override
  final String message;
  @override
  final String action;

  @override
  String toString() {
    return 'Alert(severity: $severity, type: $type, message: $message, action: $action)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlertImpl &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.action, action) || other.action == action));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, severity, type, message, action);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AlertImplCopyWith<_$AlertImpl> get copyWith =>
      __$$AlertImplCopyWithImpl<_$AlertImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AlertImplToJson(
      this,
    );
  }
}

abstract class _Alert implements Alert {
  const factory _Alert(
      {required final String severity,
      required final String type,
      required final String message,
      required final String action}) = _$AlertImpl;

  factory _Alert.fromJson(Map<String, dynamic> json) = _$AlertImpl.fromJson;

  @override
  String get severity;
  @override
  String get type;
  @override
  String get message;
  @override
  String get action;
  @override
  @JsonKey(ignore: true)
  _$$AlertImplCopyWith<_$AlertImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NextAction _$NextActionFromJson(Map<String, dynamic> json) {
  return _NextAction.fromJson(json);
}

/// @nodoc
mixin _$NextAction {
  String get action => throw _privateConstructorUsedError;
  String get priority => throw _privateConstructorUsedError;
  String get deadline => throw _privateConstructorUsedError;
  String get assignedTo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NextActionCopyWith<NextAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NextActionCopyWith<$Res> {
  factory $NextActionCopyWith(
          NextAction value, $Res Function(NextAction) then) =
      _$NextActionCopyWithImpl<$Res, NextAction>;
  @useResult
  $Res call(
      {String action, String priority, String deadline, String assignedTo});
}

/// @nodoc
class _$NextActionCopyWithImpl<$Res, $Val extends NextAction>
    implements $NextActionCopyWith<$Res> {
  _$NextActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
    Object? priority = null,
    Object? deadline = null,
    Object? assignedTo = null,
  }) {
    return _then(_value.copyWith(
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      deadline: null == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as String,
      assignedTo: null == assignedTo
          ? _value.assignedTo
          : assignedTo // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NextActionImplCopyWith<$Res>
    implements $NextActionCopyWith<$Res> {
  factory _$$NextActionImplCopyWith(
          _$NextActionImpl value, $Res Function(_$NextActionImpl) then) =
      __$$NextActionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String action, String priority, String deadline, String assignedTo});
}

/// @nodoc
class __$$NextActionImplCopyWithImpl<$Res>
    extends _$NextActionCopyWithImpl<$Res, _$NextActionImpl>
    implements _$$NextActionImplCopyWith<$Res> {
  __$$NextActionImplCopyWithImpl(
      _$NextActionImpl _value, $Res Function(_$NextActionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
    Object? priority = null,
    Object? deadline = null,
    Object? assignedTo = null,
  }) {
    return _then(_$NextActionImpl(
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      deadline: null == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as String,
      assignedTo: null == assignedTo
          ? _value.assignedTo
          : assignedTo // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NextActionImpl implements _NextAction {
  const _$NextActionImpl(
      {required this.action,
      required this.priority,
      required this.deadline,
      required this.assignedTo});

  factory _$NextActionImpl.fromJson(Map<String, dynamic> json) =>
      _$$NextActionImplFromJson(json);

  @override
  final String action;
  @override
  final String priority;
  @override
  final String deadline;
  @override
  final String assignedTo;

  @override
  String toString() {
    return 'NextAction(action: $action, priority: $priority, deadline: $deadline, assignedTo: $assignedTo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NextActionImpl &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            (identical(other.assignedTo, assignedTo) ||
                other.assignedTo == assignedTo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, action, priority, deadline, assignedTo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NextActionImplCopyWith<_$NextActionImpl> get copyWith =>
      __$$NextActionImplCopyWithImpl<_$NextActionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NextActionImplToJson(
      this,
    );
  }
}

abstract class _NextAction implements NextAction {
  const factory _NextAction(
      {required final String action,
      required final String priority,
      required final String deadline,
      required final String assignedTo}) = _$NextActionImpl;

  factory _NextAction.fromJson(Map<String, dynamic> json) =
      _$NextActionImpl.fromJson;

  @override
  String get action;
  @override
  String get priority;
  @override
  String get deadline;
  @override
  String get assignedTo;
  @override
  @JsonKey(ignore: true)
  _$$NextActionImplCopyWith<_$NextActionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CarePatterns _$CarePatternsFromJson(Map<String, dynamic> json) {
  return _CarePatterns.fromJson(json);
}

/// @nodoc
mixin _$CarePatterns {
  ServiceUtilization get serviceUtilization =>
      throw _privateConstructorUsedError;
  HealthTrends get healthTrends => throw _privateConstructorUsedError;
  BehaviorPatterns get behaviorPatterns => throw _privateConstructorUsedError;
  GoalProgress get goalProgress => throw _privateConstructorUsedError;
  FamilyEngagement get familyEngagement => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CarePatternsCopyWith<CarePatterns> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CarePatternsCopyWith<$Res> {
  factory $CarePatternsCopyWith(
          CarePatterns value, $Res Function(CarePatterns) then) =
      _$CarePatternsCopyWithImpl<$Res, CarePatterns>;
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
class _$CarePatternsCopyWithImpl<$Res, $Val extends CarePatterns>
    implements $CarePatternsCopyWith<$Res> {
  _$CarePatternsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceUtilization = null,
    Object? healthTrends = null,
    Object? behaviorPatterns = null,
    Object? goalProgress = null,
    Object? familyEngagement = null,
  }) {
    return _then(_value.copyWith(
      serviceUtilization: null == serviceUtilization
          ? _value.serviceUtilization
          : serviceUtilization // ignore: cast_nullable_to_non_nullable
              as ServiceUtilization,
      healthTrends: null == healthTrends
          ? _value.healthTrends
          : healthTrends // ignore: cast_nullable_to_non_nullable
              as HealthTrends,
      behaviorPatterns: null == behaviorPatterns
          ? _value.behaviorPatterns
          : behaviorPatterns // ignore: cast_nullable_to_non_nullable
              as BehaviorPatterns,
      goalProgress: null == goalProgress
          ? _value.goalProgress
          : goalProgress // ignore: cast_nullable_to_non_nullable
              as GoalProgress,
      familyEngagement: null == familyEngagement
          ? _value.familyEngagement
          : familyEngagement // ignore: cast_nullable_to_non_nullable
              as FamilyEngagement,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ServiceUtilizationCopyWith<$Res> get serviceUtilization {
    return $ServiceUtilizationCopyWith<$Res>(_value.serviceUtilization,
        (value) {
      return _then(_value.copyWith(serviceUtilization: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $HealthTrendsCopyWith<$Res> get healthTrends {
    return $HealthTrendsCopyWith<$Res>(_value.healthTrends, (value) {
      return _then(_value.copyWith(healthTrends: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $BehaviorPatternsCopyWith<$Res> get behaviorPatterns {
    return $BehaviorPatternsCopyWith<$Res>(_value.behaviorPatterns, (value) {
      return _then(_value.copyWith(behaviorPatterns: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $GoalProgressCopyWith<$Res> get goalProgress {
    return $GoalProgressCopyWith<$Res>(_value.goalProgress, (value) {
      return _then(_value.copyWith(goalProgress: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $FamilyEngagementCopyWith<$Res> get familyEngagement {
    return $FamilyEngagementCopyWith<$Res>(_value.familyEngagement, (value) {
      return _then(_value.copyWith(familyEngagement: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CarePatternsImplCopyWith<$Res>
    implements $CarePatternsCopyWith<$Res> {
  factory _$$CarePatternsImplCopyWith(
          _$CarePatternsImpl value, $Res Function(_$CarePatternsImpl) then) =
      __$$CarePatternsImplCopyWithImpl<$Res>;
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
class __$$CarePatternsImplCopyWithImpl<$Res>
    extends _$CarePatternsCopyWithImpl<$Res, _$CarePatternsImpl>
    implements _$$CarePatternsImplCopyWith<$Res> {
  __$$CarePatternsImplCopyWithImpl(
      _$CarePatternsImpl _value, $Res Function(_$CarePatternsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceUtilization = null,
    Object? healthTrends = null,
    Object? behaviorPatterns = null,
    Object? goalProgress = null,
    Object? familyEngagement = null,
  }) {
    return _then(_$CarePatternsImpl(
      serviceUtilization: null == serviceUtilization
          ? _value.serviceUtilization
          : serviceUtilization // ignore: cast_nullable_to_non_nullable
              as ServiceUtilization,
      healthTrends: null == healthTrends
          ? _value.healthTrends
          : healthTrends // ignore: cast_nullable_to_non_nullable
              as HealthTrends,
      behaviorPatterns: null == behaviorPatterns
          ? _value.behaviorPatterns
          : behaviorPatterns // ignore: cast_nullable_to_non_nullable
              as BehaviorPatterns,
      goalProgress: null == goalProgress
          ? _value.goalProgress
          : goalProgress // ignore: cast_nullable_to_non_nullable
              as GoalProgress,
      familyEngagement: null == familyEngagement
          ? _value.familyEngagement
          : familyEngagement // ignore: cast_nullable_to_non_nullable
              as FamilyEngagement,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CarePatternsImpl implements _CarePatterns {
  const _$CarePatternsImpl(
      {required this.serviceUtilization,
      required this.healthTrends,
      required this.behaviorPatterns,
      required this.goalProgress,
      required this.familyEngagement});

  factory _$CarePatternsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CarePatternsImplFromJson(json);

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

  @override
  String toString() {
    return 'CarePatterns(serviceUtilization: $serviceUtilization, healthTrends: $healthTrends, behaviorPatterns: $behaviorPatterns, goalProgress: $goalProgress, familyEngagement: $familyEngagement)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CarePatternsImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, serviceUtilization, healthTrends,
      behaviorPatterns, goalProgress, familyEngagement);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CarePatternsImplCopyWith<_$CarePatternsImpl> get copyWith =>
      __$$CarePatternsImplCopyWithImpl<_$CarePatternsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CarePatternsImplToJson(
      this,
    );
  }
}

abstract class _CarePatterns implements CarePatterns {
  const factory _CarePatterns(
      {required final ServiceUtilization serviceUtilization,
      required final HealthTrends healthTrends,
      required final BehaviorPatterns behaviorPatterns,
      required final GoalProgress goalProgress,
      required final FamilyEngagement familyEngagement}) = _$CarePatternsImpl;

  factory _CarePatterns.fromJson(Map<String, dynamic> json) =
      _$CarePatternsImpl.fromJson;

  @override
  ServiceUtilization get serviceUtilization;
  @override
  HealthTrends get healthTrends;
  @override
  BehaviorPatterns get behaviorPatterns;
  @override
  GoalProgress get goalProgress;
  @override
  FamilyEngagement get familyEngagement;
  @override
  @JsonKey(ignore: true)
  _$$CarePatternsImplCopyWith<_$CarePatternsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ServiceUtilization _$ServiceUtilizationFromJson(Map<String, dynamic> json) {
  return _ServiceUtilization.fromJson(json);
}

/// @nodoc
mixin _$ServiceUtilization {
  String get trend => throw _privateConstructorUsedError;
  int get averageHoursPerWeek => throw _privateConstructorUsedError;
  List<String> get peakDays => throw _privateConstructorUsedError;
  List<String> get preferredTimes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ServiceUtilizationCopyWith<ServiceUtilization> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceUtilizationCopyWith<$Res> {
  factory $ServiceUtilizationCopyWith(
          ServiceUtilization value, $Res Function(ServiceUtilization) then) =
      _$ServiceUtilizationCopyWithImpl<$Res, ServiceUtilization>;
  @useResult
  $Res call(
      {String trend,
      int averageHoursPerWeek,
      List<String> peakDays,
      List<String> preferredTimes});
}

/// @nodoc
class _$ServiceUtilizationCopyWithImpl<$Res, $Val extends ServiceUtilization>
    implements $ServiceUtilizationCopyWith<$Res> {
  _$ServiceUtilizationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trend = null,
    Object? averageHoursPerWeek = null,
    Object? peakDays = null,
    Object? preferredTimes = null,
  }) {
    return _then(_value.copyWith(
      trend: null == trend
          ? _value.trend
          : trend // ignore: cast_nullable_to_non_nullable
              as String,
      averageHoursPerWeek: null == averageHoursPerWeek
          ? _value.averageHoursPerWeek
          : averageHoursPerWeek // ignore: cast_nullable_to_non_nullable
              as int,
      peakDays: null == peakDays
          ? _value.peakDays
          : peakDays // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preferredTimes: null == preferredTimes
          ? _value.preferredTimes
          : preferredTimes // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServiceUtilizationImplCopyWith<$Res>
    implements $ServiceUtilizationCopyWith<$Res> {
  factory _$$ServiceUtilizationImplCopyWith(_$ServiceUtilizationImpl value,
          $Res Function(_$ServiceUtilizationImpl) then) =
      __$$ServiceUtilizationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String trend,
      int averageHoursPerWeek,
      List<String> peakDays,
      List<String> preferredTimes});
}

/// @nodoc
class __$$ServiceUtilizationImplCopyWithImpl<$Res>
    extends _$ServiceUtilizationCopyWithImpl<$Res, _$ServiceUtilizationImpl>
    implements _$$ServiceUtilizationImplCopyWith<$Res> {
  __$$ServiceUtilizationImplCopyWithImpl(_$ServiceUtilizationImpl _value,
      $Res Function(_$ServiceUtilizationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trend = null,
    Object? averageHoursPerWeek = null,
    Object? peakDays = null,
    Object? preferredTimes = null,
  }) {
    return _then(_$ServiceUtilizationImpl(
      trend: null == trend
          ? _value.trend
          : trend // ignore: cast_nullable_to_non_nullable
              as String,
      averageHoursPerWeek: null == averageHoursPerWeek
          ? _value.averageHoursPerWeek
          : averageHoursPerWeek // ignore: cast_nullable_to_non_nullable
              as int,
      peakDays: null == peakDays
          ? _value._peakDays
          : peakDays // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preferredTimes: null == preferredTimes
          ? _value._preferredTimes
          : preferredTimes // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceUtilizationImpl implements _ServiceUtilization {
  const _$ServiceUtilizationImpl(
      {required this.trend,
      required this.averageHoursPerWeek,
      required final List<String> peakDays,
      required final List<String> preferredTimes})
      : _peakDays = peakDays,
        _preferredTimes = preferredTimes;

  factory _$ServiceUtilizationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceUtilizationImplFromJson(json);

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

  @override
  String toString() {
    return 'ServiceUtilization(trend: $trend, averageHoursPerWeek: $averageHoursPerWeek, peakDays: $peakDays, preferredTimes: $preferredTimes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceUtilizationImpl &&
            (identical(other.trend, trend) || other.trend == trend) &&
            (identical(other.averageHoursPerWeek, averageHoursPerWeek) ||
                other.averageHoursPerWeek == averageHoursPerWeek) &&
            const DeepCollectionEquality().equals(other._peakDays, _peakDays) &&
            const DeepCollectionEquality()
                .equals(other._preferredTimes, _preferredTimes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      trend,
      averageHoursPerWeek,
      const DeepCollectionEquality().hash(_peakDays),
      const DeepCollectionEquality().hash(_preferredTimes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceUtilizationImplCopyWith<_$ServiceUtilizationImpl> get copyWith =>
      __$$ServiceUtilizationImplCopyWithImpl<_$ServiceUtilizationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceUtilizationImplToJson(
      this,
    );
  }
}

abstract class _ServiceUtilization implements ServiceUtilization {
  const factory _ServiceUtilization(
      {required final String trend,
      required final int averageHoursPerWeek,
      required final List<String> peakDays,
      required final List<String> preferredTimes}) = _$ServiceUtilizationImpl;

  factory _ServiceUtilization.fromJson(Map<String, dynamic> json) =
      _$ServiceUtilizationImpl.fromJson;

  @override
  String get trend;
  @override
  int get averageHoursPerWeek;
  @override
  List<String> get peakDays;
  @override
  List<String> get preferredTimes;
  @override
  @JsonKey(ignore: true)
  _$$ServiceUtilizationImplCopyWith<_$ServiceUtilizationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HealthTrends _$HealthTrendsFromJson(Map<String, dynamic> json) {
  return _HealthTrends.fromJson(json);
}

/// @nodoc
mixin _$HealthTrends {
  double get vitalStability => throw _privateConstructorUsedError;
  double get medicationCompliance => throw _privateConstructorUsedError;
  int get incidentFrequency => throw _privateConstructorUsedError;
  String get overallTrend => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HealthTrendsCopyWith<HealthTrends> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthTrendsCopyWith<$Res> {
  factory $HealthTrendsCopyWith(
          HealthTrends value, $Res Function(HealthTrends) then) =
      _$HealthTrendsCopyWithImpl<$Res, HealthTrends>;
  @useResult
  $Res call(
      {double vitalStability,
      double medicationCompliance,
      int incidentFrequency,
      String overallTrend});
}

/// @nodoc
class _$HealthTrendsCopyWithImpl<$Res, $Val extends HealthTrends>
    implements $HealthTrendsCopyWith<$Res> {
  _$HealthTrendsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vitalStability = null,
    Object? medicationCompliance = null,
    Object? incidentFrequency = null,
    Object? overallTrend = null,
  }) {
    return _then(_value.copyWith(
      vitalStability: null == vitalStability
          ? _value.vitalStability
          : vitalStability // ignore: cast_nullable_to_non_nullable
              as double,
      medicationCompliance: null == medicationCompliance
          ? _value.medicationCompliance
          : medicationCompliance // ignore: cast_nullable_to_non_nullable
              as double,
      incidentFrequency: null == incidentFrequency
          ? _value.incidentFrequency
          : incidentFrequency // ignore: cast_nullable_to_non_nullable
              as int,
      overallTrend: null == overallTrend
          ? _value.overallTrend
          : overallTrend // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HealthTrendsImplCopyWith<$Res>
    implements $HealthTrendsCopyWith<$Res> {
  factory _$$HealthTrendsImplCopyWith(
          _$HealthTrendsImpl value, $Res Function(_$HealthTrendsImpl) then) =
      __$$HealthTrendsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double vitalStability,
      double medicationCompliance,
      int incidentFrequency,
      String overallTrend});
}

/// @nodoc
class __$$HealthTrendsImplCopyWithImpl<$Res>
    extends _$HealthTrendsCopyWithImpl<$Res, _$HealthTrendsImpl>
    implements _$$HealthTrendsImplCopyWith<$Res> {
  __$$HealthTrendsImplCopyWithImpl(
      _$HealthTrendsImpl _value, $Res Function(_$HealthTrendsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vitalStability = null,
    Object? medicationCompliance = null,
    Object? incidentFrequency = null,
    Object? overallTrend = null,
  }) {
    return _then(_$HealthTrendsImpl(
      vitalStability: null == vitalStability
          ? _value.vitalStability
          : vitalStability // ignore: cast_nullable_to_non_nullable
              as double,
      medicationCompliance: null == medicationCompliance
          ? _value.medicationCompliance
          : medicationCompliance // ignore: cast_nullable_to_non_nullable
              as double,
      incidentFrequency: null == incidentFrequency
          ? _value.incidentFrequency
          : incidentFrequency // ignore: cast_nullable_to_non_nullable
              as int,
      overallTrend: null == overallTrend
          ? _value.overallTrend
          : overallTrend // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HealthTrendsImpl implements _HealthTrends {
  const _$HealthTrendsImpl(
      {required this.vitalStability,
      required this.medicationCompliance,
      required this.incidentFrequency,
      required this.overallTrend});

  factory _$HealthTrendsImpl.fromJson(Map<String, dynamic> json) =>
      _$$HealthTrendsImplFromJson(json);

  @override
  final double vitalStability;
  @override
  final double medicationCompliance;
  @override
  final int incidentFrequency;
  @override
  final String overallTrend;

  @override
  String toString() {
    return 'HealthTrends(vitalStability: $vitalStability, medicationCompliance: $medicationCompliance, incidentFrequency: $incidentFrequency, overallTrend: $overallTrend)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HealthTrendsImpl &&
            (identical(other.vitalStability, vitalStability) ||
                other.vitalStability == vitalStability) &&
            (identical(other.medicationCompliance, medicationCompliance) ||
                other.medicationCompliance == medicationCompliance) &&
            (identical(other.incidentFrequency, incidentFrequency) ||
                other.incidentFrequency == incidentFrequency) &&
            (identical(other.overallTrend, overallTrend) ||
                other.overallTrend == overallTrend));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, vitalStability,
      medicationCompliance, incidentFrequency, overallTrend);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HealthTrendsImplCopyWith<_$HealthTrendsImpl> get copyWith =>
      __$$HealthTrendsImplCopyWithImpl<_$HealthTrendsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HealthTrendsImplToJson(
      this,
    );
  }
}

abstract class _HealthTrends implements HealthTrends {
  const factory _HealthTrends(
      {required final double vitalStability,
      required final double medicationCompliance,
      required final int incidentFrequency,
      required final String overallTrend}) = _$HealthTrendsImpl;

  factory _HealthTrends.fromJson(Map<String, dynamic> json) =
      _$HealthTrendsImpl.fromJson;

  @override
  double get vitalStability;
  @override
  double get medicationCompliance;
  @override
  int get incidentFrequency;
  @override
  String get overallTrend;
  @override
  @JsonKey(ignore: true)
  _$$HealthTrendsImplCopyWith<_$HealthTrendsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BehaviorPatterns _$BehaviorPatternsFromJson(Map<String, dynamic> json) {
  return _BehaviorPatterns.fromJson(json);
}

/// @nodoc
mixin _$BehaviorPatterns {
  int get positiveInteractions => throw _privateConstructorUsedError;
  int get challengingBehaviors => throw _privateConstructorUsedError;
  List<String> get triggerPatterns => throw _privateConstructorUsedError;
  double get responseEffectiveness => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BehaviorPatternsCopyWith<BehaviorPatterns> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BehaviorPatternsCopyWith<$Res> {
  factory $BehaviorPatternsCopyWith(
          BehaviorPatterns value, $Res Function(BehaviorPatterns) then) =
      _$BehaviorPatternsCopyWithImpl<$Res, BehaviorPatterns>;
  @useResult
  $Res call(
      {int positiveInteractions,
      int challengingBehaviors,
      List<String> triggerPatterns,
      double responseEffectiveness});
}

/// @nodoc
class _$BehaviorPatternsCopyWithImpl<$Res, $Val extends BehaviorPatterns>
    implements $BehaviorPatternsCopyWith<$Res> {
  _$BehaviorPatternsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? positiveInteractions = null,
    Object? challengingBehaviors = null,
    Object? triggerPatterns = null,
    Object? responseEffectiveness = null,
  }) {
    return _then(_value.copyWith(
      positiveInteractions: null == positiveInteractions
          ? _value.positiveInteractions
          : positiveInteractions // ignore: cast_nullable_to_non_nullable
              as int,
      challengingBehaviors: null == challengingBehaviors
          ? _value.challengingBehaviors
          : challengingBehaviors // ignore: cast_nullable_to_non_nullable
              as int,
      triggerPatterns: null == triggerPatterns
          ? _value.triggerPatterns
          : triggerPatterns // ignore: cast_nullable_to_non_nullable
              as List<String>,
      responseEffectiveness: null == responseEffectiveness
          ? _value.responseEffectiveness
          : responseEffectiveness // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BehaviorPatternsImplCopyWith<$Res>
    implements $BehaviorPatternsCopyWith<$Res> {
  factory _$$BehaviorPatternsImplCopyWith(_$BehaviorPatternsImpl value,
          $Res Function(_$BehaviorPatternsImpl) then) =
      __$$BehaviorPatternsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int positiveInteractions,
      int challengingBehaviors,
      List<String> triggerPatterns,
      double responseEffectiveness});
}

/// @nodoc
class __$$BehaviorPatternsImplCopyWithImpl<$Res>
    extends _$BehaviorPatternsCopyWithImpl<$Res, _$BehaviorPatternsImpl>
    implements _$$BehaviorPatternsImplCopyWith<$Res> {
  __$$BehaviorPatternsImplCopyWithImpl(_$BehaviorPatternsImpl _value,
      $Res Function(_$BehaviorPatternsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? positiveInteractions = null,
    Object? challengingBehaviors = null,
    Object? triggerPatterns = null,
    Object? responseEffectiveness = null,
  }) {
    return _then(_$BehaviorPatternsImpl(
      positiveInteractions: null == positiveInteractions
          ? _value.positiveInteractions
          : positiveInteractions // ignore: cast_nullable_to_non_nullable
              as int,
      challengingBehaviors: null == challengingBehaviors
          ? _value.challengingBehaviors
          : challengingBehaviors // ignore: cast_nullable_to_non_nullable
              as int,
      triggerPatterns: null == triggerPatterns
          ? _value._triggerPatterns
          : triggerPatterns // ignore: cast_nullable_to_non_nullable
              as List<String>,
      responseEffectiveness: null == responseEffectiveness
          ? _value.responseEffectiveness
          : responseEffectiveness // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BehaviorPatternsImpl implements _BehaviorPatterns {
  const _$BehaviorPatternsImpl(
      {required this.positiveInteractions,
      required this.challengingBehaviors,
      required final List<String> triggerPatterns,
      required this.responseEffectiveness})
      : _triggerPatterns = triggerPatterns;

  factory _$BehaviorPatternsImpl.fromJson(Map<String, dynamic> json) =>
      _$$BehaviorPatternsImplFromJson(json);

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

  @override
  String toString() {
    return 'BehaviorPatterns(positiveInteractions: $positiveInteractions, challengingBehaviors: $challengingBehaviors, triggerPatterns: $triggerPatterns, responseEffectiveness: $responseEffectiveness)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BehaviorPatternsImpl &&
            (identical(other.positiveInteractions, positiveInteractions) ||
                other.positiveInteractions == positiveInteractions) &&
            (identical(other.challengingBehaviors, challengingBehaviors) ||
                other.challengingBehaviors == challengingBehaviors) &&
            const DeepCollectionEquality()
                .equals(other._triggerPatterns, _triggerPatterns) &&
            (identical(other.responseEffectiveness, responseEffectiveness) ||
                other.responseEffectiveness == responseEffectiveness));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      positiveInteractions,
      challengingBehaviors,
      const DeepCollectionEquality().hash(_triggerPatterns),
      responseEffectiveness);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BehaviorPatternsImplCopyWith<_$BehaviorPatternsImpl> get copyWith =>
      __$$BehaviorPatternsImplCopyWithImpl<_$BehaviorPatternsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BehaviorPatternsImplToJson(
      this,
    );
  }
}

abstract class _BehaviorPatterns implements BehaviorPatterns {
  const factory _BehaviorPatterns(
      {required final int positiveInteractions,
      required final int challengingBehaviors,
      required final List<String> triggerPatterns,
      required final double responseEffectiveness}) = _$BehaviorPatternsImpl;

  factory _BehaviorPatterns.fromJson(Map<String, dynamic> json) =
      _$BehaviorPatternsImpl.fromJson;

  @override
  int get positiveInteractions;
  @override
  int get challengingBehaviors;
  @override
  List<String> get triggerPatterns;
  @override
  double get responseEffectiveness;
  @override
  @JsonKey(ignore: true)
  _$$BehaviorPatternsImplCopyWith<_$BehaviorPatternsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GoalProgress _$GoalProgressFromJson(Map<String, dynamic> json) {
  return _GoalProgress.fromJson(json);
}

/// @nodoc
mixin _$GoalProgress {
  int get onTrack => throw _privateConstructorUsedError;
  int get needsAttention => throw _privateConstructorUsedError;
  int get achieved => throw _privateConstructorUsedError;
  double get averageProgress => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GoalProgressCopyWith<GoalProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoalProgressCopyWith<$Res> {
  factory $GoalProgressCopyWith(
          GoalProgress value, $Res Function(GoalProgress) then) =
      _$GoalProgressCopyWithImpl<$Res, GoalProgress>;
  @useResult
  $Res call(
      {int onTrack, int needsAttention, int achieved, double averageProgress});
}

/// @nodoc
class _$GoalProgressCopyWithImpl<$Res, $Val extends GoalProgress>
    implements $GoalProgressCopyWith<$Res> {
  _$GoalProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onTrack = null,
    Object? needsAttention = null,
    Object? achieved = null,
    Object? averageProgress = null,
  }) {
    return _then(_value.copyWith(
      onTrack: null == onTrack
          ? _value.onTrack
          : onTrack // ignore: cast_nullable_to_non_nullable
              as int,
      needsAttention: null == needsAttention
          ? _value.needsAttention
          : needsAttention // ignore: cast_nullable_to_non_nullable
              as int,
      achieved: null == achieved
          ? _value.achieved
          : achieved // ignore: cast_nullable_to_non_nullable
              as int,
      averageProgress: null == averageProgress
          ? _value.averageProgress
          : averageProgress // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GoalProgressImplCopyWith<$Res>
    implements $GoalProgressCopyWith<$Res> {
  factory _$$GoalProgressImplCopyWith(
          _$GoalProgressImpl value, $Res Function(_$GoalProgressImpl) then) =
      __$$GoalProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int onTrack, int needsAttention, int achieved, double averageProgress});
}

/// @nodoc
class __$$GoalProgressImplCopyWithImpl<$Res>
    extends _$GoalProgressCopyWithImpl<$Res, _$GoalProgressImpl>
    implements _$$GoalProgressImplCopyWith<$Res> {
  __$$GoalProgressImplCopyWithImpl(
      _$GoalProgressImpl _value, $Res Function(_$GoalProgressImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onTrack = null,
    Object? needsAttention = null,
    Object? achieved = null,
    Object? averageProgress = null,
  }) {
    return _then(_$GoalProgressImpl(
      onTrack: null == onTrack
          ? _value.onTrack
          : onTrack // ignore: cast_nullable_to_non_nullable
              as int,
      needsAttention: null == needsAttention
          ? _value.needsAttention
          : needsAttention // ignore: cast_nullable_to_non_nullable
              as int,
      achieved: null == achieved
          ? _value.achieved
          : achieved // ignore: cast_nullable_to_non_nullable
              as int,
      averageProgress: null == averageProgress
          ? _value.averageProgress
          : averageProgress // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GoalProgressImpl implements _GoalProgress {
  const _$GoalProgressImpl(
      {required this.onTrack,
      required this.needsAttention,
      required this.achieved,
      required this.averageProgress});

  factory _$GoalProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$GoalProgressImplFromJson(json);

  @override
  final int onTrack;
  @override
  final int needsAttention;
  @override
  final int achieved;
  @override
  final double averageProgress;

  @override
  String toString() {
    return 'GoalProgress(onTrack: $onTrack, needsAttention: $needsAttention, achieved: $achieved, averageProgress: $averageProgress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoalProgressImpl &&
            (identical(other.onTrack, onTrack) || other.onTrack == onTrack) &&
            (identical(other.needsAttention, needsAttention) ||
                other.needsAttention == needsAttention) &&
            (identical(other.achieved, achieved) ||
                other.achieved == achieved) &&
            (identical(other.averageProgress, averageProgress) ||
                other.averageProgress == averageProgress));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, onTrack, needsAttention, achieved, averageProgress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GoalProgressImplCopyWith<_$GoalProgressImpl> get copyWith =>
      __$$GoalProgressImplCopyWithImpl<_$GoalProgressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GoalProgressImplToJson(
      this,
    );
  }
}

abstract class _GoalProgress implements GoalProgress {
  const factory _GoalProgress(
      {required final int onTrack,
      required final int needsAttention,
      required final int achieved,
      required final double averageProgress}) = _$GoalProgressImpl;

  factory _GoalProgress.fromJson(Map<String, dynamic> json) =
      _$GoalProgressImpl.fromJson;

  @override
  int get onTrack;
  @override
  int get needsAttention;
  @override
  int get achieved;
  @override
  double get averageProgress;
  @override
  @JsonKey(ignore: true)
  _$$GoalProgressImplCopyWith<_$GoalProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FamilyEngagement _$FamilyEngagementFromJson(Map<String, dynamic> json) {
  return _FamilyEngagement.fromJson(json);
}

/// @nodoc
mixin _$FamilyEngagement {
  String get communicationFrequency => throw _privateConstructorUsedError;
  double get satisfactionScore => throw _privateConstructorUsedError;
  int get concernsRaised => throw _privateConstructorUsedError;
  double get participationLevel => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FamilyEngagementCopyWith<FamilyEngagement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FamilyEngagementCopyWith<$Res> {
  factory $FamilyEngagementCopyWith(
          FamilyEngagement value, $Res Function(FamilyEngagement) then) =
      _$FamilyEngagementCopyWithImpl<$Res, FamilyEngagement>;
  @useResult
  $Res call(
      {String communicationFrequency,
      double satisfactionScore,
      int concernsRaised,
      double participationLevel});
}

/// @nodoc
class _$FamilyEngagementCopyWithImpl<$Res, $Val extends FamilyEngagement>
    implements $FamilyEngagementCopyWith<$Res> {
  _$FamilyEngagementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? communicationFrequency = null,
    Object? satisfactionScore = null,
    Object? concernsRaised = null,
    Object? participationLevel = null,
  }) {
    return _then(_value.copyWith(
      communicationFrequency: null == communicationFrequency
          ? _value.communicationFrequency
          : communicationFrequency // ignore: cast_nullable_to_non_nullable
              as String,
      satisfactionScore: null == satisfactionScore
          ? _value.satisfactionScore
          : satisfactionScore // ignore: cast_nullable_to_non_nullable
              as double,
      concernsRaised: null == concernsRaised
          ? _value.concernsRaised
          : concernsRaised // ignore: cast_nullable_to_non_nullable
              as int,
      participationLevel: null == participationLevel
          ? _value.participationLevel
          : participationLevel // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FamilyEngagementImplCopyWith<$Res>
    implements $FamilyEngagementCopyWith<$Res> {
  factory _$$FamilyEngagementImplCopyWith(_$FamilyEngagementImpl value,
          $Res Function(_$FamilyEngagementImpl) then) =
      __$$FamilyEngagementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String communicationFrequency,
      double satisfactionScore,
      int concernsRaised,
      double participationLevel});
}

/// @nodoc
class __$$FamilyEngagementImplCopyWithImpl<$Res>
    extends _$FamilyEngagementCopyWithImpl<$Res, _$FamilyEngagementImpl>
    implements _$$FamilyEngagementImplCopyWith<$Res> {
  __$$FamilyEngagementImplCopyWithImpl(_$FamilyEngagementImpl _value,
      $Res Function(_$FamilyEngagementImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? communicationFrequency = null,
    Object? satisfactionScore = null,
    Object? concernsRaised = null,
    Object? participationLevel = null,
  }) {
    return _then(_$FamilyEngagementImpl(
      communicationFrequency: null == communicationFrequency
          ? _value.communicationFrequency
          : communicationFrequency // ignore: cast_nullable_to_non_nullable
              as String,
      satisfactionScore: null == satisfactionScore
          ? _value.satisfactionScore
          : satisfactionScore // ignore: cast_nullable_to_non_nullable
              as double,
      concernsRaised: null == concernsRaised
          ? _value.concernsRaised
          : concernsRaised // ignore: cast_nullable_to_non_nullable
              as int,
      participationLevel: null == participationLevel
          ? _value.participationLevel
          : participationLevel // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FamilyEngagementImpl implements _FamilyEngagement {
  const _$FamilyEngagementImpl(
      {required this.communicationFrequency,
      required this.satisfactionScore,
      required this.concernsRaised,
      required this.participationLevel});

  factory _$FamilyEngagementImpl.fromJson(Map<String, dynamic> json) =>
      _$$FamilyEngagementImplFromJson(json);

  @override
  final String communicationFrequency;
  @override
  final double satisfactionScore;
  @override
  final int concernsRaised;
  @override
  final double participationLevel;

  @override
  String toString() {
    return 'FamilyEngagement(communicationFrequency: $communicationFrequency, satisfactionScore: $satisfactionScore, concernsRaised: $concernsRaised, participationLevel: $participationLevel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FamilyEngagementImpl &&
            (identical(other.communicationFrequency, communicationFrequency) ||
                other.communicationFrequency == communicationFrequency) &&
            (identical(other.satisfactionScore, satisfactionScore) ||
                other.satisfactionScore == satisfactionScore) &&
            (identical(other.concernsRaised, concernsRaised) ||
                other.concernsRaised == concernsRaised) &&
            (identical(other.participationLevel, participationLevel) ||
                other.participationLevel == participationLevel));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, communicationFrequency,
      satisfactionScore, concernsRaised, participationLevel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FamilyEngagementImplCopyWith<_$FamilyEngagementImpl> get copyWith =>
      __$$FamilyEngagementImplCopyWithImpl<_$FamilyEngagementImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FamilyEngagementImplToJson(
      this,
    );
  }
}

abstract class _FamilyEngagement implements FamilyEngagement {
  const factory _FamilyEngagement(
      {required final String communicationFrequency,
      required final double satisfactionScore,
      required final int concernsRaised,
      required final double participationLevel}) = _$FamilyEngagementImpl;

  factory _FamilyEngagement.fromJson(Map<String, dynamic> json) =
      _$FamilyEngagementImpl.fromJson;

  @override
  String get communicationFrequency;
  @override
  double get satisfactionScore;
  @override
  int get concernsRaised;
  @override
  double get participationLevel;
  @override
  @JsonKey(ignore: true)
  _$$FamilyEngagementImplCopyWith<_$FamilyEngagementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RiskAssessment _$RiskAssessmentFromJson(Map<String, dynamic> json) {
  return _RiskAssessment.fromJson(json);
}

/// @nodoc
mixin _$RiskAssessment {
  String get clientId => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get assessmentDate => throw _privateConstructorUsedError;
  int get overallRisk => throw _privateConstructorUsedError;
  RiskCategory get fallsRisk => throw _privateConstructorUsedError;
  RiskCategory get behaviorRisk => throw _privateConstructorUsedError;
  RiskCategory get healthRisk => throw _privateConstructorUsedError;
  RiskCategory get medicationRisk => throw _privateConstructorUsedError;
  RiskCategory get socialRisk => throw _privateConstructorUsedError;
  RiskCategory get financialRisk => throw _privateConstructorUsedError;
  RiskTrends get trends => throw _privateConstructorUsedError;
  List<RiskRecommendation> get recommendations =>
      throw _privateConstructorUsedError;
  String get nextAssessment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RiskAssessmentCopyWith<RiskAssessment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RiskAssessmentCopyWith<$Res> {
  factory $RiskAssessmentCopyWith(
          RiskAssessment value, $Res Function(RiskAssessment) then) =
      _$RiskAssessmentCopyWithImpl<$Res, RiskAssessment>;
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
class _$RiskAssessmentCopyWithImpl<$Res, $Val extends RiskAssessment>
    implements $RiskAssessmentCopyWith<$Res> {
  _$RiskAssessmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      assessmentDate: null == assessmentDate
          ? _value.assessmentDate
          : assessmentDate // ignore: cast_nullable_to_non_nullable
              as String,
      overallRisk: null == overallRisk
          ? _value.overallRisk
          : overallRisk // ignore: cast_nullable_to_non_nullable
              as int,
      fallsRisk: null == fallsRisk
          ? _value.fallsRisk
          : fallsRisk // ignore: cast_nullable_to_non_nullable
              as RiskCategory,
      behaviorRisk: null == behaviorRisk
          ? _value.behaviorRisk
          : behaviorRisk // ignore: cast_nullable_to_non_nullable
              as RiskCategory,
      healthRisk: null == healthRisk
          ? _value.healthRisk
          : healthRisk // ignore: cast_nullable_to_non_nullable
              as RiskCategory,
      medicationRisk: null == medicationRisk
          ? _value.medicationRisk
          : medicationRisk // ignore: cast_nullable_to_non_nullable
              as RiskCategory,
      socialRisk: null == socialRisk
          ? _value.socialRisk
          : socialRisk // ignore: cast_nullable_to_non_nullable
              as RiskCategory,
      financialRisk: null == financialRisk
          ? _value.financialRisk
          : financialRisk // ignore: cast_nullable_to_non_nullable
              as RiskCategory,
      trends: null == trends
          ? _value.trends
          : trends // ignore: cast_nullable_to_non_nullable
              as RiskTrends,
      recommendations: null == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<RiskRecommendation>,
      nextAssessment: null == nextAssessment
          ? _value.nextAssessment
          : nextAssessment // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RiskCategoryCopyWith<$Res> get fallsRisk {
    return $RiskCategoryCopyWith<$Res>(_value.fallsRisk, (value) {
      return _then(_value.copyWith(fallsRisk: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RiskCategoryCopyWith<$Res> get behaviorRisk {
    return $RiskCategoryCopyWith<$Res>(_value.behaviorRisk, (value) {
      return _then(_value.copyWith(behaviorRisk: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RiskCategoryCopyWith<$Res> get healthRisk {
    return $RiskCategoryCopyWith<$Res>(_value.healthRisk, (value) {
      return _then(_value.copyWith(healthRisk: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RiskCategoryCopyWith<$Res> get medicationRisk {
    return $RiskCategoryCopyWith<$Res>(_value.medicationRisk, (value) {
      return _then(_value.copyWith(medicationRisk: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RiskCategoryCopyWith<$Res> get socialRisk {
    return $RiskCategoryCopyWith<$Res>(_value.socialRisk, (value) {
      return _then(_value.copyWith(socialRisk: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RiskCategoryCopyWith<$Res> get financialRisk {
    return $RiskCategoryCopyWith<$Res>(_value.financialRisk, (value) {
      return _then(_value.copyWith(financialRisk: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RiskTrendsCopyWith<$Res> get trends {
    return $RiskTrendsCopyWith<$Res>(_value.trends, (value) {
      return _then(_value.copyWith(trends: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RiskAssessmentImplCopyWith<$Res>
    implements $RiskAssessmentCopyWith<$Res> {
  factory _$$RiskAssessmentImplCopyWith(_$RiskAssessmentImpl value,
          $Res Function(_$RiskAssessmentImpl) then) =
      __$$RiskAssessmentImplCopyWithImpl<$Res>;
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
class __$$RiskAssessmentImplCopyWithImpl<$Res>
    extends _$RiskAssessmentCopyWithImpl<$Res, _$RiskAssessmentImpl>
    implements _$$RiskAssessmentImplCopyWith<$Res> {
  __$$RiskAssessmentImplCopyWithImpl(
      _$RiskAssessmentImpl _value, $Res Function(_$RiskAssessmentImpl) _then)
      : super(_value, _then);

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
    return _then(_$RiskAssessmentImpl(
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      assessmentDate: null == assessmentDate
          ? _value.assessmentDate
          : assessmentDate // ignore: cast_nullable_to_non_nullable
              as String,
      overallRisk: null == overallRisk
          ? _value.overallRisk
          : overallRisk // ignore: cast_nullable_to_non_nullable
              as int,
      fallsRisk: null == fallsRisk
          ? _value.fallsRisk
          : fallsRisk // ignore: cast_nullable_to_non_nullable
              as RiskCategory,
      behaviorRisk: null == behaviorRisk
          ? _value.behaviorRisk
          : behaviorRisk // ignore: cast_nullable_to_non_nullable
              as RiskCategory,
      healthRisk: null == healthRisk
          ? _value.healthRisk
          : healthRisk // ignore: cast_nullable_to_non_nullable
              as RiskCategory,
      medicationRisk: null == medicationRisk
          ? _value.medicationRisk
          : medicationRisk // ignore: cast_nullable_to_non_nullable
              as RiskCategory,
      socialRisk: null == socialRisk
          ? _value.socialRisk
          : socialRisk // ignore: cast_nullable_to_non_nullable
              as RiskCategory,
      financialRisk: null == financialRisk
          ? _value.financialRisk
          : financialRisk // ignore: cast_nullable_to_non_nullable
              as RiskCategory,
      trends: null == trends
          ? _value.trends
          : trends // ignore: cast_nullable_to_non_nullable
              as RiskTrends,
      recommendations: null == recommendations
          ? _value._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<RiskRecommendation>,
      nextAssessment: null == nextAssessment
          ? _value.nextAssessment
          : nextAssessment // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RiskAssessmentImpl implements _RiskAssessment {
  const _$RiskAssessmentImpl(
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

  factory _$RiskAssessmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$RiskAssessmentImplFromJson(json);

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

  @override
  String toString() {
    return 'RiskAssessment(clientId: $clientId, organizationId: $organizationId, assessmentDate: $assessmentDate, overallRisk: $overallRisk, fallsRisk: $fallsRisk, behaviorRisk: $behaviorRisk, healthRisk: $healthRisk, medicationRisk: $medicationRisk, socialRisk: $socialRisk, financialRisk: $financialRisk, trends: $trends, recommendations: $recommendations, nextAssessment: $nextAssessment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RiskAssessmentImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RiskAssessmentImplCopyWith<_$RiskAssessmentImpl> get copyWith =>
      __$$RiskAssessmentImplCopyWithImpl<_$RiskAssessmentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RiskAssessmentImplToJson(
      this,
    );
  }
}

abstract class _RiskAssessment implements RiskAssessment {
  const factory _RiskAssessment(
      {required final String clientId,
      required final String organizationId,
      required final String assessmentDate,
      required final int overallRisk,
      required final RiskCategory fallsRisk,
      required final RiskCategory behaviorRisk,
      required final RiskCategory healthRisk,
      required final RiskCategory medicationRisk,
      required final RiskCategory socialRisk,
      required final RiskCategory financialRisk,
      required final RiskTrends trends,
      required final List<RiskRecommendation> recommendations,
      required final String nextAssessment}) = _$RiskAssessmentImpl;

  factory _RiskAssessment.fromJson(Map<String, dynamic> json) =
      _$RiskAssessmentImpl.fromJson;

  @override
  String get clientId;
  @override
  String get organizationId;
  @override
  String get assessmentDate;
  @override
  int get overallRisk;
  @override
  RiskCategory get fallsRisk;
  @override
  RiskCategory get behaviorRisk;
  @override
  RiskCategory get healthRisk;
  @override
  RiskCategory get medicationRisk;
  @override
  RiskCategory get socialRisk;
  @override
  RiskCategory get financialRisk;
  @override
  RiskTrends get trends;
  @override
  List<RiskRecommendation> get recommendations;
  @override
  String get nextAssessment;
  @override
  @JsonKey(ignore: true)
  _$$RiskAssessmentImplCopyWith<_$RiskAssessmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RiskCategory _$RiskCategoryFromJson(Map<String, dynamic> json) {
  return _RiskCategory.fromJson(json);
}

/// @nodoc
mixin _$RiskCategory {
  int get score => throw _privateConstructorUsedError;
  String get level => throw _privateConstructorUsedError;
  String? get lastIncident => throw _privateConstructorUsedError;
  int? get recentIncidents => throw _privateConstructorUsedError;
  int? get conditions => throw _privateConstructorUsedError;
  int? get medications => throw _privateConstructorUsedError;
  int? get isolationIndicators => throw _privateConstructorUsedError;
  int? get concerns => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RiskCategoryCopyWith<RiskCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RiskCategoryCopyWith<$Res> {
  factory $RiskCategoryCopyWith(
          RiskCategory value, $Res Function(RiskCategory) then) =
      _$RiskCategoryCopyWithImpl<$Res, RiskCategory>;
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
class _$RiskCategoryCopyWithImpl<$Res, $Val extends RiskCategory>
    implements $RiskCategoryCopyWith<$Res> {
  _$RiskCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as String,
      lastIncident: freezed == lastIncident
          ? _value.lastIncident
          : lastIncident // ignore: cast_nullable_to_non_nullable
              as String?,
      recentIncidents: freezed == recentIncidents
          ? _value.recentIncidents
          : recentIncidents // ignore: cast_nullable_to_non_nullable
              as int?,
      conditions: freezed == conditions
          ? _value.conditions
          : conditions // ignore: cast_nullable_to_non_nullable
              as int?,
      medications: freezed == medications
          ? _value.medications
          : medications // ignore: cast_nullable_to_non_nullable
              as int?,
      isolationIndicators: freezed == isolationIndicators
          ? _value.isolationIndicators
          : isolationIndicators // ignore: cast_nullable_to_non_nullable
              as int?,
      concerns: freezed == concerns
          ? _value.concerns
          : concerns // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RiskCategoryImplCopyWith<$Res>
    implements $RiskCategoryCopyWith<$Res> {
  factory _$$RiskCategoryImplCopyWith(
          _$RiskCategoryImpl value, $Res Function(_$RiskCategoryImpl) then) =
      __$$RiskCategoryImplCopyWithImpl<$Res>;
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
class __$$RiskCategoryImplCopyWithImpl<$Res>
    extends _$RiskCategoryCopyWithImpl<$Res, _$RiskCategoryImpl>
    implements _$$RiskCategoryImplCopyWith<$Res> {
  __$$RiskCategoryImplCopyWithImpl(
      _$RiskCategoryImpl _value, $Res Function(_$RiskCategoryImpl) _then)
      : super(_value, _then);

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
    return _then(_$RiskCategoryImpl(
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as String,
      lastIncident: freezed == lastIncident
          ? _value.lastIncident
          : lastIncident // ignore: cast_nullable_to_non_nullable
              as String?,
      recentIncidents: freezed == recentIncidents
          ? _value.recentIncidents
          : recentIncidents // ignore: cast_nullable_to_non_nullable
              as int?,
      conditions: freezed == conditions
          ? _value.conditions
          : conditions // ignore: cast_nullable_to_non_nullable
              as int?,
      medications: freezed == medications
          ? _value.medications
          : medications // ignore: cast_nullable_to_non_nullable
              as int?,
      isolationIndicators: freezed == isolationIndicators
          ? _value.isolationIndicators
          : isolationIndicators // ignore: cast_nullable_to_non_nullable
              as int?,
      concerns: freezed == concerns
          ? _value.concerns
          : concerns // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RiskCategoryImpl implements _RiskCategory {
  const _$RiskCategoryImpl(
      {required this.score,
      required this.level,
      this.lastIncident,
      this.recentIncidents,
      this.conditions,
      this.medications,
      this.isolationIndicators,
      this.concerns});

  factory _$RiskCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$RiskCategoryImplFromJson(json);

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

  @override
  String toString() {
    return 'RiskCategory(score: $score, level: $level, lastIncident: $lastIncident, recentIncidents: $recentIncidents, conditions: $conditions, medications: $medications, isolationIndicators: $isolationIndicators, concerns: $concerns)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RiskCategoryImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, score, level, lastIncident,
      recentIncidents, conditions, medications, isolationIndicators, concerns);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RiskCategoryImplCopyWith<_$RiskCategoryImpl> get copyWith =>
      __$$RiskCategoryImplCopyWithImpl<_$RiskCategoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RiskCategoryImplToJson(
      this,
    );
  }
}

abstract class _RiskCategory implements RiskCategory {
  const factory _RiskCategory(
      {required final int score,
      required final String level,
      final String? lastIncident,
      final int? recentIncidents,
      final int? conditions,
      final int? medications,
      final int? isolationIndicators,
      final int? concerns}) = _$RiskCategoryImpl;

  factory _RiskCategory.fromJson(Map<String, dynamic> json) =
      _$RiskCategoryImpl.fromJson;

  @override
  int get score;
  @override
  String get level;
  @override
  String? get lastIncident;
  @override
  int? get recentIncidents;
  @override
  int? get conditions;
  @override
  int? get medications;
  @override
  int? get isolationIndicators;
  @override
  int? get concerns;
  @override
  @JsonKey(ignore: true)
  _$$RiskCategoryImplCopyWith<_$RiskCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RiskTrends _$RiskTrendsFromJson(Map<String, dynamic> json) {
  return _RiskTrends.fromJson(json);
}

/// @nodoc
mixin _$RiskTrends {
  String get direction => throw _privateConstructorUsedError;
  int get changePercentage => throw _privateConstructorUsedError;
  String get period => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RiskTrendsCopyWith<RiskTrends> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RiskTrendsCopyWith<$Res> {
  factory $RiskTrendsCopyWith(
          RiskTrends value, $Res Function(RiskTrends) then) =
      _$RiskTrendsCopyWithImpl<$Res, RiskTrends>;
  @useResult
  $Res call({String direction, int changePercentage, String period});
}

/// @nodoc
class _$RiskTrendsCopyWithImpl<$Res, $Val extends RiskTrends>
    implements $RiskTrendsCopyWith<$Res> {
  _$RiskTrendsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? direction = null,
    Object? changePercentage = null,
    Object? period = null,
  }) {
    return _then(_value.copyWith(
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as String,
      changePercentage: null == changePercentage
          ? _value.changePercentage
          : changePercentage // ignore: cast_nullable_to_non_nullable
              as int,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RiskTrendsImplCopyWith<$Res>
    implements $RiskTrendsCopyWith<$Res> {
  factory _$$RiskTrendsImplCopyWith(
          _$RiskTrendsImpl value, $Res Function(_$RiskTrendsImpl) then) =
      __$$RiskTrendsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String direction, int changePercentage, String period});
}

/// @nodoc
class __$$RiskTrendsImplCopyWithImpl<$Res>
    extends _$RiskTrendsCopyWithImpl<$Res, _$RiskTrendsImpl>
    implements _$$RiskTrendsImplCopyWith<$Res> {
  __$$RiskTrendsImplCopyWithImpl(
      _$RiskTrendsImpl _value, $Res Function(_$RiskTrendsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? direction = null,
    Object? changePercentage = null,
    Object? period = null,
  }) {
    return _then(_$RiskTrendsImpl(
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as String,
      changePercentage: null == changePercentage
          ? _value.changePercentage
          : changePercentage // ignore: cast_nullable_to_non_nullable
              as int,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RiskTrendsImpl implements _RiskTrends {
  const _$RiskTrendsImpl(
      {required this.direction,
      required this.changePercentage,
      required this.period});

  factory _$RiskTrendsImpl.fromJson(Map<String, dynamic> json) =>
      _$$RiskTrendsImplFromJson(json);

  @override
  final String direction;
  @override
  final int changePercentage;
  @override
  final String period;

  @override
  String toString() {
    return 'RiskTrends(direction: $direction, changePercentage: $changePercentage, period: $period)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RiskTrendsImpl &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.changePercentage, changePercentage) ||
                other.changePercentage == changePercentage) &&
            (identical(other.period, period) || other.period == period));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, direction, changePercentage, period);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RiskTrendsImplCopyWith<_$RiskTrendsImpl> get copyWith =>
      __$$RiskTrendsImplCopyWithImpl<_$RiskTrendsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RiskTrendsImplToJson(
      this,
    );
  }
}

abstract class _RiskTrends implements RiskTrends {
  const factory _RiskTrends(
      {required final String direction,
      required final int changePercentage,
      required final String period}) = _$RiskTrendsImpl;

  factory _RiskTrends.fromJson(Map<String, dynamic> json) =
      _$RiskTrendsImpl.fromJson;

  @override
  String get direction;
  @override
  int get changePercentage;
  @override
  String get period;
  @override
  @JsonKey(ignore: true)
  _$$RiskTrendsImplCopyWith<_$RiskTrendsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RiskRecommendation _$RiskRecommendationFromJson(Map<String, dynamic> json) {
  return _RiskRecommendation.fromJson(json);
}

/// @nodoc
mixin _$RiskRecommendation {
  String get priority => throw _privateConstructorUsedError;
  String get recommendation => throw _privateConstructorUsedError;
  String get timeline => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RiskRecommendationCopyWith<RiskRecommendation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RiskRecommendationCopyWith<$Res> {
  factory $RiskRecommendationCopyWith(
          RiskRecommendation value, $Res Function(RiskRecommendation) then) =
      _$RiskRecommendationCopyWithImpl<$Res, RiskRecommendation>;
  @useResult
  $Res call({String priority, String recommendation, String timeline});
}

/// @nodoc
class _$RiskRecommendationCopyWithImpl<$Res, $Val extends RiskRecommendation>
    implements $RiskRecommendationCopyWith<$Res> {
  _$RiskRecommendationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? priority = null,
    Object? recommendation = null,
    Object? timeline = null,
  }) {
    return _then(_value.copyWith(
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      recommendation: null == recommendation
          ? _value.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as String,
      timeline: null == timeline
          ? _value.timeline
          : timeline // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RiskRecommendationImplCopyWith<$Res>
    implements $RiskRecommendationCopyWith<$Res> {
  factory _$$RiskRecommendationImplCopyWith(_$RiskRecommendationImpl value,
          $Res Function(_$RiskRecommendationImpl) then) =
      __$$RiskRecommendationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String priority, String recommendation, String timeline});
}

/// @nodoc
class __$$RiskRecommendationImplCopyWithImpl<$Res>
    extends _$RiskRecommendationCopyWithImpl<$Res, _$RiskRecommendationImpl>
    implements _$$RiskRecommendationImplCopyWith<$Res> {
  __$$RiskRecommendationImplCopyWithImpl(_$RiskRecommendationImpl _value,
      $Res Function(_$RiskRecommendationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? priority = null,
    Object? recommendation = null,
    Object? timeline = null,
  }) {
    return _then(_$RiskRecommendationImpl(
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      recommendation: null == recommendation
          ? _value.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as String,
      timeline: null == timeline
          ? _value.timeline
          : timeline // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RiskRecommendationImpl implements _RiskRecommendation {
  const _$RiskRecommendationImpl(
      {required this.priority,
      required this.recommendation,
      required this.timeline});

  factory _$RiskRecommendationImpl.fromJson(Map<String, dynamic> json) =>
      _$$RiskRecommendationImplFromJson(json);

  @override
  final String priority;
  @override
  final String recommendation;
  @override
  final String timeline;

  @override
  String toString() {
    return 'RiskRecommendation(priority: $priority, recommendation: $recommendation, timeline: $timeline)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RiskRecommendationImpl &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.recommendation, recommendation) ||
                other.recommendation == recommendation) &&
            (identical(other.timeline, timeline) ||
                other.timeline == timeline));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, priority, recommendation, timeline);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RiskRecommendationImplCopyWith<_$RiskRecommendationImpl> get copyWith =>
      __$$RiskRecommendationImplCopyWithImpl<_$RiskRecommendationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RiskRecommendationImplToJson(
      this,
    );
  }
}

abstract class _RiskRecommendation implements RiskRecommendation {
  const factory _RiskRecommendation(
      {required final String priority,
      required final String recommendation,
      required final String timeline}) = _$RiskRecommendationImpl;

  factory _RiskRecommendation.fromJson(Map<String, dynamic> json) =
      _$RiskRecommendationImpl.fromJson;

  @override
  String get priority;
  @override
  String get recommendation;
  @override
  String get timeline;
  @override
  @JsonKey(ignore: true)
  _$$RiskRecommendationImplCopyWith<_$RiskRecommendationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FallsRiskAssessment _$FallsRiskAssessmentFromJson(Map<String, dynamic> json) {
  return _FallsRiskAssessment.fromJson(json);
}

/// @nodoc
mixin _$FallsRiskAssessment {
  int get riskScore => throw _privateConstructorUsedError;
  String get riskLevel => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  List<ContributingFactor> get contributingFactors =>
      throw _privateConstructorUsedError;
  List<String> get preventionStrategies => throw _privateConstructorUsedError;
  MonitoringPlan get monitoringPlan => throw _privateConstructorUsedError;
  List<String> get interventions => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FallsRiskAssessmentCopyWith<FallsRiskAssessment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FallsRiskAssessmentCopyWith<$Res> {
  factory $FallsRiskAssessmentCopyWith(
          FallsRiskAssessment value, $Res Function(FallsRiskAssessment) then) =
      _$FallsRiskAssessmentCopyWithImpl<$Res, FallsRiskAssessment>;
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
class _$FallsRiskAssessmentCopyWithImpl<$Res, $Val extends FallsRiskAssessment>
    implements $FallsRiskAssessmentCopyWith<$Res> {
  _$FallsRiskAssessmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      riskScore: null == riskScore
          ? _value.riskScore
          : riskScore // ignore: cast_nullable_to_non_nullable
              as int,
      riskLevel: null == riskLevel
          ? _value.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      contributingFactors: null == contributingFactors
          ? _value.contributingFactors
          : contributingFactors // ignore: cast_nullable_to_non_nullable
              as List<ContributingFactor>,
      preventionStrategies: null == preventionStrategies
          ? _value.preventionStrategies
          : preventionStrategies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      monitoringPlan: null == monitoringPlan
          ? _value.monitoringPlan
          : monitoringPlan // ignore: cast_nullable_to_non_nullable
              as MonitoringPlan,
      interventions: null == interventions
          ? _value.interventions
          : interventions // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MonitoringPlanCopyWith<$Res> get monitoringPlan {
    return $MonitoringPlanCopyWith<$Res>(_value.monitoringPlan, (value) {
      return _then(_value.copyWith(monitoringPlan: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FallsRiskAssessmentImplCopyWith<$Res>
    implements $FallsRiskAssessmentCopyWith<$Res> {
  factory _$$FallsRiskAssessmentImplCopyWith(_$FallsRiskAssessmentImpl value,
          $Res Function(_$FallsRiskAssessmentImpl) then) =
      __$$FallsRiskAssessmentImplCopyWithImpl<$Res>;
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
class __$$FallsRiskAssessmentImplCopyWithImpl<$Res>
    extends _$FallsRiskAssessmentCopyWithImpl<$Res, _$FallsRiskAssessmentImpl>
    implements _$$FallsRiskAssessmentImplCopyWith<$Res> {
  __$$FallsRiskAssessmentImplCopyWithImpl(_$FallsRiskAssessmentImpl _value,
      $Res Function(_$FallsRiskAssessmentImpl) _then)
      : super(_value, _then);

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
    return _then(_$FallsRiskAssessmentImpl(
      riskScore: null == riskScore
          ? _value.riskScore
          : riskScore // ignore: cast_nullable_to_non_nullable
              as int,
      riskLevel: null == riskLevel
          ? _value.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      contributingFactors: null == contributingFactors
          ? _value._contributingFactors
          : contributingFactors // ignore: cast_nullable_to_non_nullable
              as List<ContributingFactor>,
      preventionStrategies: null == preventionStrategies
          ? _value._preventionStrategies
          : preventionStrategies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      monitoringPlan: null == monitoringPlan
          ? _value.monitoringPlan
          : monitoringPlan // ignore: cast_nullable_to_non_nullable
              as MonitoringPlan,
      interventions: null == interventions
          ? _value._interventions
          : interventions // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FallsRiskAssessmentImpl implements _FallsRiskAssessment {
  const _$FallsRiskAssessmentImpl(
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

  factory _$FallsRiskAssessmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$FallsRiskAssessmentImplFromJson(json);

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

  @override
  String toString() {
    return 'FallsRiskAssessment(riskScore: $riskScore, riskLevel: $riskLevel, confidence: $confidence, contributingFactors: $contributingFactors, preventionStrategies: $preventionStrategies, monitoringPlan: $monitoringPlan, interventions: $interventions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FallsRiskAssessmentImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FallsRiskAssessmentImplCopyWith<_$FallsRiskAssessmentImpl> get copyWith =>
      __$$FallsRiskAssessmentImplCopyWithImpl<_$FallsRiskAssessmentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FallsRiskAssessmentImplToJson(
      this,
    );
  }
}

abstract class _FallsRiskAssessment implements FallsRiskAssessment {
  const factory _FallsRiskAssessment(
      {required final int riskScore,
      required final String riskLevel,
      required final double confidence,
      required final List<ContributingFactor> contributingFactors,
      required final List<String> preventionStrategies,
      required final MonitoringPlan monitoringPlan,
      required final List<String> interventions}) = _$FallsRiskAssessmentImpl;

  factory _FallsRiskAssessment.fromJson(Map<String, dynamic> json) =
      _$FallsRiskAssessmentImpl.fromJson;

  @override
  int get riskScore;
  @override
  String get riskLevel;
  @override
  double get confidence;
  @override
  List<ContributingFactor> get contributingFactors;
  @override
  List<String> get preventionStrategies;
  @override
  MonitoringPlan get monitoringPlan;
  @override
  List<String> get interventions;
  @override
  @JsonKey(ignore: true)
  _$$FallsRiskAssessmentImplCopyWith<_$FallsRiskAssessmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ContributingFactor _$ContributingFactorFromJson(Map<String, dynamic> json) {
  return _ContributingFactor.fromJson(json);
}

/// @nodoc
mixin _$ContributingFactor {
  String get factor => throw _privateConstructorUsedError;
  double get weight => throw _privateConstructorUsedError;
  bool get present => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ContributingFactorCopyWith<ContributingFactor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContributingFactorCopyWith<$Res> {
  factory $ContributingFactorCopyWith(
          ContributingFactor value, $Res Function(ContributingFactor) then) =
      _$ContributingFactorCopyWithImpl<$Res, ContributingFactor>;
  @useResult
  $Res call({String factor, double weight, bool present});
}

/// @nodoc
class _$ContributingFactorCopyWithImpl<$Res, $Val extends ContributingFactor>
    implements $ContributingFactorCopyWith<$Res> {
  _$ContributingFactorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? factor = null,
    Object? weight = null,
    Object? present = null,
  }) {
    return _then(_value.copyWith(
      factor: null == factor
          ? _value.factor
          : factor // ignore: cast_nullable_to_non_nullable
              as String,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      present: null == present
          ? _value.present
          : present // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContributingFactorImplCopyWith<$Res>
    implements $ContributingFactorCopyWith<$Res> {
  factory _$$ContributingFactorImplCopyWith(_$ContributingFactorImpl value,
          $Res Function(_$ContributingFactorImpl) then) =
      __$$ContributingFactorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String factor, double weight, bool present});
}

/// @nodoc
class __$$ContributingFactorImplCopyWithImpl<$Res>
    extends _$ContributingFactorCopyWithImpl<$Res, _$ContributingFactorImpl>
    implements _$$ContributingFactorImplCopyWith<$Res> {
  __$$ContributingFactorImplCopyWithImpl(_$ContributingFactorImpl _value,
      $Res Function(_$ContributingFactorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? factor = null,
    Object? weight = null,
    Object? present = null,
  }) {
    return _then(_$ContributingFactorImpl(
      factor: null == factor
          ? _value.factor
          : factor // ignore: cast_nullable_to_non_nullable
              as String,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      present: null == present
          ? _value.present
          : present // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContributingFactorImpl implements _ContributingFactor {
  const _$ContributingFactorImpl(
      {required this.factor, required this.weight, required this.present});

  factory _$ContributingFactorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContributingFactorImplFromJson(json);

  @override
  final String factor;
  @override
  final double weight;
  @override
  final bool present;

  @override
  String toString() {
    return 'ContributingFactor(factor: $factor, weight: $weight, present: $present)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContributingFactorImpl &&
            (identical(other.factor, factor) || other.factor == factor) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.present, present) || other.present == present));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, factor, weight, present);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContributingFactorImplCopyWith<_$ContributingFactorImpl> get copyWith =>
      __$$ContributingFactorImplCopyWithImpl<_$ContributingFactorImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContributingFactorImplToJson(
      this,
    );
  }
}

abstract class _ContributingFactor implements ContributingFactor {
  const factory _ContributingFactor(
      {required final String factor,
      required final double weight,
      required final bool present}) = _$ContributingFactorImpl;

  factory _ContributingFactor.fromJson(Map<String, dynamic> json) =
      _$ContributingFactorImpl.fromJson;

  @override
  String get factor;
  @override
  double get weight;
  @override
  bool get present;
  @override
  @JsonKey(ignore: true)
  _$$ContributingFactorImplCopyWith<_$ContributingFactorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MonitoringPlan _$MonitoringPlanFromJson(Map<String, dynamic> json) {
  return _MonitoringPlan.fromJson(json);
}

/// @nodoc
mixin _$MonitoringPlan {
  String get frequency => throw _privateConstructorUsedError;
  List<String> get indicators => throw _privateConstructorUsedError;
  bool get alerts => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MonitoringPlanCopyWith<MonitoringPlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonitoringPlanCopyWith<$Res> {
  factory $MonitoringPlanCopyWith(
          MonitoringPlan value, $Res Function(MonitoringPlan) then) =
      _$MonitoringPlanCopyWithImpl<$Res, MonitoringPlan>;
  @useResult
  $Res call({String frequency, List<String> indicators, bool alerts});
}

/// @nodoc
class _$MonitoringPlanCopyWithImpl<$Res, $Val extends MonitoringPlan>
    implements $MonitoringPlanCopyWith<$Res> {
  _$MonitoringPlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? frequency = null,
    Object? indicators = null,
    Object? alerts = null,
  }) {
    return _then(_value.copyWith(
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as String,
      indicators: null == indicators
          ? _value.indicators
          : indicators // ignore: cast_nullable_to_non_nullable
              as List<String>,
      alerts: null == alerts
          ? _value.alerts
          : alerts // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MonitoringPlanImplCopyWith<$Res>
    implements $MonitoringPlanCopyWith<$Res> {
  factory _$$MonitoringPlanImplCopyWith(_$MonitoringPlanImpl value,
          $Res Function(_$MonitoringPlanImpl) then) =
      __$$MonitoringPlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String frequency, List<String> indicators, bool alerts});
}

/// @nodoc
class __$$MonitoringPlanImplCopyWithImpl<$Res>
    extends _$MonitoringPlanCopyWithImpl<$Res, _$MonitoringPlanImpl>
    implements _$$MonitoringPlanImplCopyWith<$Res> {
  __$$MonitoringPlanImplCopyWithImpl(
      _$MonitoringPlanImpl _value, $Res Function(_$MonitoringPlanImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? frequency = null,
    Object? indicators = null,
    Object? alerts = null,
  }) {
    return _then(_$MonitoringPlanImpl(
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as String,
      indicators: null == indicators
          ? _value._indicators
          : indicators // ignore: cast_nullable_to_non_nullable
              as List<String>,
      alerts: null == alerts
          ? _value.alerts
          : alerts // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MonitoringPlanImpl implements _MonitoringPlan {
  const _$MonitoringPlanImpl(
      {required this.frequency,
      required final List<String> indicators,
      required this.alerts})
      : _indicators = indicators;

  factory _$MonitoringPlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$MonitoringPlanImplFromJson(json);

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

  @override
  String toString() {
    return 'MonitoringPlan(frequency: $frequency, indicators: $indicators, alerts: $alerts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonitoringPlanImpl &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            const DeepCollectionEquality()
                .equals(other._indicators, _indicators) &&
            (identical(other.alerts, alerts) || other.alerts == alerts));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, frequency,
      const DeepCollectionEquality().hash(_indicators), alerts);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MonitoringPlanImplCopyWith<_$MonitoringPlanImpl> get copyWith =>
      __$$MonitoringPlanImplCopyWithImpl<_$MonitoringPlanImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MonitoringPlanImplToJson(
      this,
    );
  }
}

abstract class _MonitoringPlan implements MonitoringPlan {
  const factory _MonitoringPlan(
      {required final String frequency,
      required final List<String> indicators,
      required final bool alerts}) = _$MonitoringPlanImpl;

  factory _MonitoringPlan.fromJson(Map<String, dynamic> json) =
      _$MonitoringPlanImpl.fromJson;

  @override
  String get frequency;
  @override
  List<String> get indicators;
  @override
  bool get alerts;
  @override
  @JsonKey(ignore: true)
  _$$MonitoringPlanImplCopyWith<_$MonitoringPlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BehaviorEscalationPrediction _$BehaviorEscalationPredictionFromJson(
    Map<String, dynamic> json) {
  return _BehaviorEscalationPrediction.fromJson(json);
}

/// @nodoc
mixin _$BehaviorEscalationPrediction {
  double get escalationProbability => throw _privateConstructorUsedError;
  String get timeframe => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  List<Trigger> get triggers => throw _privateConstructorUsedError;
  List<String> get earlyWarningSignals => throw _privateConstructorUsedError;
  List<String> get deEscalationStrategies => throw _privateConstructorUsedError;
  List<String> get preventiveMeasures => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BehaviorEscalationPredictionCopyWith<BehaviorEscalationPrediction>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BehaviorEscalationPredictionCopyWith<$Res> {
  factory $BehaviorEscalationPredictionCopyWith(
          BehaviorEscalationPrediction value,
          $Res Function(BehaviorEscalationPrediction) then) =
      _$BehaviorEscalationPredictionCopyWithImpl<$Res,
          BehaviorEscalationPrediction>;
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
class _$BehaviorEscalationPredictionCopyWithImpl<$Res,
        $Val extends BehaviorEscalationPrediction>
    implements $BehaviorEscalationPredictionCopyWith<$Res> {
  _$BehaviorEscalationPredictionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      escalationProbability: null == escalationProbability
          ? _value.escalationProbability
          : escalationProbability // ignore: cast_nullable_to_non_nullable
              as double,
      timeframe: null == timeframe
          ? _value.timeframe
          : timeframe // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      triggers: null == triggers
          ? _value.triggers
          : triggers // ignore: cast_nullable_to_non_nullable
              as List<Trigger>,
      earlyWarningSignals: null == earlyWarningSignals
          ? _value.earlyWarningSignals
          : earlyWarningSignals // ignore: cast_nullable_to_non_nullable
              as List<String>,
      deEscalationStrategies: null == deEscalationStrategies
          ? _value.deEscalationStrategies
          : deEscalationStrategies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preventiveMeasures: null == preventiveMeasures
          ? _value.preventiveMeasures
          : preventiveMeasures // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BehaviorEscalationPredictionImplCopyWith<$Res>
    implements $BehaviorEscalationPredictionCopyWith<$Res> {
  factory _$$BehaviorEscalationPredictionImplCopyWith(
          _$BehaviorEscalationPredictionImpl value,
          $Res Function(_$BehaviorEscalationPredictionImpl) then) =
      __$$BehaviorEscalationPredictionImplCopyWithImpl<$Res>;
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
class __$$BehaviorEscalationPredictionImplCopyWithImpl<$Res>
    extends _$BehaviorEscalationPredictionCopyWithImpl<$Res,
        _$BehaviorEscalationPredictionImpl>
    implements _$$BehaviorEscalationPredictionImplCopyWith<$Res> {
  __$$BehaviorEscalationPredictionImplCopyWithImpl(
      _$BehaviorEscalationPredictionImpl _value,
      $Res Function(_$BehaviorEscalationPredictionImpl) _then)
      : super(_value, _then);

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
    return _then(_$BehaviorEscalationPredictionImpl(
      escalationProbability: null == escalationProbability
          ? _value.escalationProbability
          : escalationProbability // ignore: cast_nullable_to_non_nullable
              as double,
      timeframe: null == timeframe
          ? _value.timeframe
          : timeframe // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      triggers: null == triggers
          ? _value._triggers
          : triggers // ignore: cast_nullable_to_non_nullable
              as List<Trigger>,
      earlyWarningSignals: null == earlyWarningSignals
          ? _value._earlyWarningSignals
          : earlyWarningSignals // ignore: cast_nullable_to_non_nullable
              as List<String>,
      deEscalationStrategies: null == deEscalationStrategies
          ? _value._deEscalationStrategies
          : deEscalationStrategies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preventiveMeasures: null == preventiveMeasures
          ? _value._preventiveMeasures
          : preventiveMeasures // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BehaviorEscalationPredictionImpl
    implements _BehaviorEscalationPrediction {
  const _$BehaviorEscalationPredictionImpl(
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

  factory _$BehaviorEscalationPredictionImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$BehaviorEscalationPredictionImplFromJson(json);

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

  @override
  String toString() {
    return 'BehaviorEscalationPrediction(escalationProbability: $escalationProbability, timeframe: $timeframe, confidence: $confidence, triggers: $triggers, earlyWarningSignals: $earlyWarningSignals, deEscalationStrategies: $deEscalationStrategies, preventiveMeasures: $preventiveMeasures)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BehaviorEscalationPredictionImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BehaviorEscalationPredictionImplCopyWith<
          _$BehaviorEscalationPredictionImpl>
      get copyWith => __$$BehaviorEscalationPredictionImplCopyWithImpl<
          _$BehaviorEscalationPredictionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BehaviorEscalationPredictionImplToJson(
      this,
    );
  }
}

abstract class _BehaviorEscalationPrediction
    implements BehaviorEscalationPrediction {
  const factory _BehaviorEscalationPrediction(
          {required final double escalationProbability,
          required final String timeframe,
          required final double confidence,
          required final List<Trigger> triggers,
          required final List<String> earlyWarningSignals,
          required final List<String> deEscalationStrategies,
          required final List<String> preventiveMeasures}) =
      _$BehaviorEscalationPredictionImpl;

  factory _BehaviorEscalationPrediction.fromJson(Map<String, dynamic> json) =
      _$BehaviorEscalationPredictionImpl.fromJson;

  @override
  double get escalationProbability;
  @override
  String get timeframe;
  @override
  double get confidence;
  @override
  List<Trigger> get triggers;
  @override
  List<String> get earlyWarningSignals;
  @override
  List<String> get deEscalationStrategies;
  @override
  List<String> get preventiveMeasures;
  @override
  @JsonKey(ignore: true)
  _$$BehaviorEscalationPredictionImplCopyWith<
          _$BehaviorEscalationPredictionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

Trigger _$TriggerFromJson(Map<String, dynamic> json) {
  return _Trigger.fromJson(json);
}

/// @nodoc
mixin _$Trigger {
  String get trigger => throw _privateConstructorUsedError;
  double get likelihood => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TriggerCopyWith<Trigger> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TriggerCopyWith<$Res> {
  factory $TriggerCopyWith(Trigger value, $Res Function(Trigger) then) =
      _$TriggerCopyWithImpl<$Res, Trigger>;
  @useResult
  $Res call({String trigger, double likelihood});
}

/// @nodoc
class _$TriggerCopyWithImpl<$Res, $Val extends Trigger>
    implements $TriggerCopyWith<$Res> {
  _$TriggerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trigger = null,
    Object? likelihood = null,
  }) {
    return _then(_value.copyWith(
      trigger: null == trigger
          ? _value.trigger
          : trigger // ignore: cast_nullable_to_non_nullable
              as String,
      likelihood: null == likelihood
          ? _value.likelihood
          : likelihood // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TriggerImplCopyWith<$Res> implements $TriggerCopyWith<$Res> {
  factory _$$TriggerImplCopyWith(
          _$TriggerImpl value, $Res Function(_$TriggerImpl) then) =
      __$$TriggerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String trigger, double likelihood});
}

/// @nodoc
class __$$TriggerImplCopyWithImpl<$Res>
    extends _$TriggerCopyWithImpl<$Res, _$TriggerImpl>
    implements _$$TriggerImplCopyWith<$Res> {
  __$$TriggerImplCopyWithImpl(
      _$TriggerImpl _value, $Res Function(_$TriggerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trigger = null,
    Object? likelihood = null,
  }) {
    return _then(_$TriggerImpl(
      trigger: null == trigger
          ? _value.trigger
          : trigger // ignore: cast_nullable_to_non_nullable
              as String,
      likelihood: null == likelihood
          ? _value.likelihood
          : likelihood // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TriggerImpl implements _Trigger {
  const _$TriggerImpl({required this.trigger, required this.likelihood});

  factory _$TriggerImpl.fromJson(Map<String, dynamic> json) =>
      _$$TriggerImplFromJson(json);

  @override
  final String trigger;
  @override
  final double likelihood;

  @override
  String toString() {
    return 'Trigger(trigger: $trigger, likelihood: $likelihood)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TriggerImpl &&
            (identical(other.trigger, trigger) || other.trigger == trigger) &&
            (identical(other.likelihood, likelihood) ||
                other.likelihood == likelihood));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, trigger, likelihood);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TriggerImplCopyWith<_$TriggerImpl> get copyWith =>
      __$$TriggerImplCopyWithImpl<_$TriggerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TriggerImplToJson(
      this,
    );
  }
}

abstract class _Trigger implements Trigger {
  const factory _Trigger(
      {required final String trigger,
      required final double likelihood}) = _$TriggerImpl;

  factory _Trigger.fromJson(Map<String, dynamic> json) = _$TriggerImpl.fromJson;

  @override
  String get trigger;
  @override
  double get likelihood;
  @override
  @JsonKey(ignore: true)
  _$$TriggerImplCopyWith<_$TriggerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CarePlan _$CarePlanFromJson(Map<String, dynamic> json) {
  return _CarePlan.fromJson(json);
}

/// @nodoc
mixin _$CarePlan {
  String get clientId => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get planId => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  Assessment get assessment => throw _privateConstructorUsedError;
  List<SmartGoal> get goals => throw _privateConstructorUsedError;
  List<ServiceRecommendation> get services =>
      throw _privateConstructorUsedError;
  Resources get resources => throw _privateConstructorUsedError;
  Timeline get timeline => throw _privateConstructorUsedError;
  List<Review> get reviewSchedule => throw _privateConstructorUsedError;
  List<SuccessMetric> get successMetrics => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CarePlanCopyWith<CarePlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CarePlanCopyWith<$Res> {
  factory $CarePlanCopyWith(CarePlan value, $Res Function(CarePlan) then) =
      _$CarePlanCopyWithImpl<$Res, CarePlan>;
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
class _$CarePlanCopyWithImpl<$Res, $Val extends CarePlan>
    implements $CarePlanCopyWith<$Res> {
  _$CarePlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      planId: null == planId
          ? _value.planId
          : planId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      assessment: null == assessment
          ? _value.assessment
          : assessment // ignore: cast_nullable_to_non_nullable
              as Assessment,
      goals: null == goals
          ? _value.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as List<SmartGoal>,
      services: null == services
          ? _value.services
          : services // ignore: cast_nullable_to_non_nullable
              as List<ServiceRecommendation>,
      resources: null == resources
          ? _value.resources
          : resources // ignore: cast_nullable_to_non_nullable
              as Resources,
      timeline: null == timeline
          ? _value.timeline
          : timeline // ignore: cast_nullable_to_non_nullable
              as Timeline,
      reviewSchedule: null == reviewSchedule
          ? _value.reviewSchedule
          : reviewSchedule // ignore: cast_nullable_to_non_nullable
              as List<Review>,
      successMetrics: null == successMetrics
          ? _value.successMetrics
          : successMetrics // ignore: cast_nullable_to_non_nullable
              as List<SuccessMetric>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AssessmentCopyWith<$Res> get assessment {
    return $AssessmentCopyWith<$Res>(_value.assessment, (value) {
      return _then(_value.copyWith(assessment: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ResourcesCopyWith<$Res> get resources {
    return $ResourcesCopyWith<$Res>(_value.resources, (value) {
      return _then(_value.copyWith(resources: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TimelineCopyWith<$Res> get timeline {
    return $TimelineCopyWith<$Res>(_value.timeline, (value) {
      return _then(_value.copyWith(timeline: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CarePlanImplCopyWith<$Res>
    implements $CarePlanCopyWith<$Res> {
  factory _$$CarePlanImplCopyWith(
          _$CarePlanImpl value, $Res Function(_$CarePlanImpl) then) =
      __$$CarePlanImplCopyWithImpl<$Res>;
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
class __$$CarePlanImplCopyWithImpl<$Res>
    extends _$CarePlanCopyWithImpl<$Res, _$CarePlanImpl>
    implements _$$CarePlanImplCopyWith<$Res> {
  __$$CarePlanImplCopyWithImpl(
      _$CarePlanImpl _value, $Res Function(_$CarePlanImpl) _then)
      : super(_value, _then);

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
    return _then(_$CarePlanImpl(
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      planId: null == planId
          ? _value.planId
          : planId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      assessment: null == assessment
          ? _value.assessment
          : assessment // ignore: cast_nullable_to_non_nullable
              as Assessment,
      goals: null == goals
          ? _value._goals
          : goals // ignore: cast_nullable_to_non_nullable
              as List<SmartGoal>,
      services: null == services
          ? _value._services
          : services // ignore: cast_nullable_to_non_nullable
              as List<ServiceRecommendation>,
      resources: null == resources
          ? _value.resources
          : resources // ignore: cast_nullable_to_non_nullable
              as Resources,
      timeline: null == timeline
          ? _value.timeline
          : timeline // ignore: cast_nullable_to_non_nullable
              as Timeline,
      reviewSchedule: null == reviewSchedule
          ? _value._reviewSchedule
          : reviewSchedule // ignore: cast_nullable_to_non_nullable
              as List<Review>,
      successMetrics: null == successMetrics
          ? _value._successMetrics
          : successMetrics // ignore: cast_nullable_to_non_nullable
              as List<SuccessMetric>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CarePlanImpl implements _CarePlan {
  const _$CarePlanImpl(
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

  factory _$CarePlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$CarePlanImplFromJson(json);

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

  @override
  String toString() {
    return 'CarePlan(clientId: $clientId, organizationId: $organizationId, planId: $planId, createdAt: $createdAt, status: $status, assessment: $assessment, goals: $goals, services: $services, resources: $resources, timeline: $timeline, reviewSchedule: $reviewSchedule, successMetrics: $successMetrics)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CarePlanImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CarePlanImplCopyWith<_$CarePlanImpl> get copyWith =>
      __$$CarePlanImplCopyWithImpl<_$CarePlanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CarePlanImplToJson(
      this,
    );
  }
}

abstract class _CarePlan implements CarePlan {
  const factory _CarePlan(
      {required final String clientId,
      required final String organizationId,
      required final String planId,
      required final String createdAt,
      required final String status,
      required final Assessment assessment,
      required final List<SmartGoal> goals,
      required final List<ServiceRecommendation> services,
      required final Resources resources,
      required final Timeline timeline,
      required final List<Review> reviewSchedule,
      required final List<SuccessMetric> successMetrics}) = _$CarePlanImpl;

  factory _CarePlan.fromJson(Map<String, dynamic> json) =
      _$CarePlanImpl.fromJson;

  @override
  String get clientId;
  @override
  String get organizationId;
  @override
  String get planId;
  @override
  String get createdAt;
  @override
  String get status;
  @override
  Assessment get assessment;
  @override
  List<SmartGoal> get goals;
  @override
  List<ServiceRecommendation> get services;
  @override
  Resources get resources;
  @override
  Timeline get timeline;
  @override
  List<Review> get reviewSchedule;
  @override
  List<SuccessMetric> get successMetrics;
  @override
  @JsonKey(ignore: true)
  _$$CarePlanImplCopyWith<_$CarePlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Assessment _$AssessmentFromJson(Map<String, dynamic> json) {
  return _Assessment.fromJson(json);
}

/// @nodoc
mixin _$Assessment {
  List<String> get strengths => throw _privateConstructorUsedError;
  List<String> get needs => throw _privateConstructorUsedError;
  List<String> get preferences => throw _privateConstructorUsedError;
  List<String> get riskFactors => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AssessmentCopyWith<Assessment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssessmentCopyWith<$Res> {
  factory $AssessmentCopyWith(
          Assessment value, $Res Function(Assessment) then) =
      _$AssessmentCopyWithImpl<$Res, Assessment>;
  @useResult
  $Res call(
      {List<String> strengths,
      List<String> needs,
      List<String> preferences,
      List<String> riskFactors});
}

/// @nodoc
class _$AssessmentCopyWithImpl<$Res, $Val extends Assessment>
    implements $AssessmentCopyWith<$Res> {
  _$AssessmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? strengths = null,
    Object? needs = null,
    Object? preferences = null,
    Object? riskFactors = null,
  }) {
    return _then(_value.copyWith(
      strengths: null == strengths
          ? _value.strengths
          : strengths // ignore: cast_nullable_to_non_nullable
              as List<String>,
      needs: null == needs
          ? _value.needs
          : needs // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preferences: null == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as List<String>,
      riskFactors: null == riskFactors
          ? _value.riskFactors
          : riskFactors // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AssessmentImplCopyWith<$Res>
    implements $AssessmentCopyWith<$Res> {
  factory _$$AssessmentImplCopyWith(
          _$AssessmentImpl value, $Res Function(_$AssessmentImpl) then) =
      __$$AssessmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> strengths,
      List<String> needs,
      List<String> preferences,
      List<String> riskFactors});
}

/// @nodoc
class __$$AssessmentImplCopyWithImpl<$Res>
    extends _$AssessmentCopyWithImpl<$Res, _$AssessmentImpl>
    implements _$$AssessmentImplCopyWith<$Res> {
  __$$AssessmentImplCopyWithImpl(
      _$AssessmentImpl _value, $Res Function(_$AssessmentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? strengths = null,
    Object? needs = null,
    Object? preferences = null,
    Object? riskFactors = null,
  }) {
    return _then(_$AssessmentImpl(
      strengths: null == strengths
          ? _value._strengths
          : strengths // ignore: cast_nullable_to_non_nullable
              as List<String>,
      needs: null == needs
          ? _value._needs
          : needs // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preferences: null == preferences
          ? _value._preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as List<String>,
      riskFactors: null == riskFactors
          ? _value._riskFactors
          : riskFactors // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AssessmentImpl implements _Assessment {
  const _$AssessmentImpl(
      {required final List<String> strengths,
      required final List<String> needs,
      required final List<String> preferences,
      required final List<String> riskFactors})
      : _strengths = strengths,
        _needs = needs,
        _preferences = preferences,
        _riskFactors = riskFactors;

  factory _$AssessmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssessmentImplFromJson(json);

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

  @override
  String toString() {
    return 'Assessment(strengths: $strengths, needs: $needs, preferences: $preferences, riskFactors: $riskFactors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssessmentImpl &&
            const DeepCollectionEquality()
                .equals(other._strengths, _strengths) &&
            const DeepCollectionEquality().equals(other._needs, _needs) &&
            const DeepCollectionEquality()
                .equals(other._preferences, _preferences) &&
            const DeepCollectionEquality()
                .equals(other._riskFactors, _riskFactors));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_strengths),
      const DeepCollectionEquality().hash(_needs),
      const DeepCollectionEquality().hash(_preferences),
      const DeepCollectionEquality().hash(_riskFactors));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AssessmentImplCopyWith<_$AssessmentImpl> get copyWith =>
      __$$AssessmentImplCopyWithImpl<_$AssessmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AssessmentImplToJson(
      this,
    );
  }
}

abstract class _Assessment implements Assessment {
  const factory _Assessment(
      {required final List<String> strengths,
      required final List<String> needs,
      required final List<String> preferences,
      required final List<String> riskFactors}) = _$AssessmentImpl;

  factory _Assessment.fromJson(Map<String, dynamic> json) =
      _$AssessmentImpl.fromJson;

  @override
  List<String> get strengths;
  @override
  List<String> get needs;
  @override
  List<String> get preferences;
  @override
  List<String> get riskFactors;
  @override
  @JsonKey(ignore: true)
  _$$AssessmentImplCopyWith<_$AssessmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SmartGoal _$SmartGoalFromJson(Map<String, dynamic> json) {
  return _SmartGoal.fromJson(json);
}

/// @nodoc
mixin _$SmartGoal {
  String get goalId => throw _privateConstructorUsedError;
  String get outcomeArea => throw _privateConstructorUsedError;
  String get goal => throw _privateConstructorUsedError;
  String get specific => throw _privateConstructorUsedError;
  String get measurable => throw _privateConstructorUsedError;
  String get achievable => throw _privateConstructorUsedError;
  String get relevant => throw _privateConstructorUsedError;
  String get timeBound => throw _privateConstructorUsedError;
  String get priority => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int get progress => throw _privateConstructorUsedError;
  List<Milestone> get milestones => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SmartGoalCopyWith<SmartGoal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmartGoalCopyWith<$Res> {
  factory $SmartGoalCopyWith(SmartGoal value, $Res Function(SmartGoal) then) =
      _$SmartGoalCopyWithImpl<$Res, SmartGoal>;
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
class _$SmartGoalCopyWithImpl<$Res, $Val extends SmartGoal>
    implements $SmartGoalCopyWith<$Res> {
  _$SmartGoalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      goalId: null == goalId
          ? _value.goalId
          : goalId // ignore: cast_nullable_to_non_nullable
              as String,
      outcomeArea: null == outcomeArea
          ? _value.outcomeArea
          : outcomeArea // ignore: cast_nullable_to_non_nullable
              as String,
      goal: null == goal
          ? _value.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as String,
      specific: null == specific
          ? _value.specific
          : specific // ignore: cast_nullable_to_non_nullable
              as String,
      measurable: null == measurable
          ? _value.measurable
          : measurable // ignore: cast_nullable_to_non_nullable
              as String,
      achievable: null == achievable
          ? _value.achievable
          : achievable // ignore: cast_nullable_to_non_nullable
              as String,
      relevant: null == relevant
          ? _value.relevant
          : relevant // ignore: cast_nullable_to_non_nullable
              as String,
      timeBound: null == timeBound
          ? _value.timeBound
          : timeBound // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      milestones: null == milestones
          ? _value.milestones
          : milestones // ignore: cast_nullable_to_non_nullable
              as List<Milestone>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SmartGoalImplCopyWith<$Res>
    implements $SmartGoalCopyWith<$Res> {
  factory _$$SmartGoalImplCopyWith(
          _$SmartGoalImpl value, $Res Function(_$SmartGoalImpl) then) =
      __$$SmartGoalImplCopyWithImpl<$Res>;
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
class __$$SmartGoalImplCopyWithImpl<$Res>
    extends _$SmartGoalCopyWithImpl<$Res, _$SmartGoalImpl>
    implements _$$SmartGoalImplCopyWith<$Res> {
  __$$SmartGoalImplCopyWithImpl(
      _$SmartGoalImpl _value, $Res Function(_$SmartGoalImpl) _then)
      : super(_value, _then);

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
    return _then(_$SmartGoalImpl(
      goalId: null == goalId
          ? _value.goalId
          : goalId // ignore: cast_nullable_to_non_nullable
              as String,
      outcomeArea: null == outcomeArea
          ? _value.outcomeArea
          : outcomeArea // ignore: cast_nullable_to_non_nullable
              as String,
      goal: null == goal
          ? _value.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as String,
      specific: null == specific
          ? _value.specific
          : specific // ignore: cast_nullable_to_non_nullable
              as String,
      measurable: null == measurable
          ? _value.measurable
          : measurable // ignore: cast_nullable_to_non_nullable
              as String,
      achievable: null == achievable
          ? _value.achievable
          : achievable // ignore: cast_nullable_to_non_nullable
              as String,
      relevant: null == relevant
          ? _value.relevant
          : relevant // ignore: cast_nullable_to_non_nullable
              as String,
      timeBound: null == timeBound
          ? _value.timeBound
          : timeBound // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      milestones: null == milestones
          ? _value._milestones
          : milestones // ignore: cast_nullable_to_non_nullable
              as List<Milestone>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SmartGoalImpl implements _SmartGoal {
  const _$SmartGoalImpl(
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

  factory _$SmartGoalImpl.fromJson(Map<String, dynamic> json) =>
      _$$SmartGoalImplFromJson(json);

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

  @override
  String toString() {
    return 'SmartGoal(goalId: $goalId, outcomeArea: $outcomeArea, goal: $goal, specific: $specific, measurable: $measurable, achievable: $achievable, relevant: $relevant, timeBound: $timeBound, priority: $priority, status: $status, progress: $progress, milestones: $milestones)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmartGoalImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SmartGoalImplCopyWith<_$SmartGoalImpl> get copyWith =>
      __$$SmartGoalImplCopyWithImpl<_$SmartGoalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SmartGoalImplToJson(
      this,
    );
  }
}

abstract class _SmartGoal implements SmartGoal {
  const factory _SmartGoal(
      {required final String goalId,
      required final String outcomeArea,
      required final String goal,
      required final String specific,
      required final String measurable,
      required final String achievable,
      required final String relevant,
      required final String timeBound,
      required final String priority,
      required final String status,
      required final int progress,
      required final List<Milestone> milestones}) = _$SmartGoalImpl;

  factory _SmartGoal.fromJson(Map<String, dynamic> json) =
      _$SmartGoalImpl.fromJson;

  @override
  String get goalId;
  @override
  String get outcomeArea;
  @override
  String get goal;
  @override
  String get specific;
  @override
  String get measurable;
  @override
  String get achievable;
  @override
  String get relevant;
  @override
  String get timeBound;
  @override
  String get priority;
  @override
  String get status;
  @override
  int get progress;
  @override
  List<Milestone> get milestones;
  @override
  @JsonKey(ignore: true)
  _$$SmartGoalImplCopyWith<_$SmartGoalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Milestone _$MilestoneFromJson(Map<String, dynamic> json) {
  return _Milestone.fromJson(json);
}

/// @nodoc
mixin _$Milestone {
  String get milestone => throw _privateConstructorUsedError;
  String get target => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MilestoneCopyWith<Milestone> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MilestoneCopyWith<$Res> {
  factory $MilestoneCopyWith(Milestone value, $Res Function(Milestone) then) =
      _$MilestoneCopyWithImpl<$Res, Milestone>;
  @useResult
  $Res call({String milestone, String target, String date});
}

/// @nodoc
class _$MilestoneCopyWithImpl<$Res, $Val extends Milestone>
    implements $MilestoneCopyWith<$Res> {
  _$MilestoneCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? milestone = null,
    Object? target = null,
    Object? date = null,
  }) {
    return _then(_value.copyWith(
      milestone: null == milestone
          ? _value.milestone
          : milestone // ignore: cast_nullable_to_non_nullable
              as String,
      target: null == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MilestoneImplCopyWith<$Res>
    implements $MilestoneCopyWith<$Res> {
  factory _$$MilestoneImplCopyWith(
          _$MilestoneImpl value, $Res Function(_$MilestoneImpl) then) =
      __$$MilestoneImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String milestone, String target, String date});
}

/// @nodoc
class __$$MilestoneImplCopyWithImpl<$Res>
    extends _$MilestoneCopyWithImpl<$Res, _$MilestoneImpl>
    implements _$$MilestoneImplCopyWith<$Res> {
  __$$MilestoneImplCopyWithImpl(
      _$MilestoneImpl _value, $Res Function(_$MilestoneImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? milestone = null,
    Object? target = null,
    Object? date = null,
  }) {
    return _then(_$MilestoneImpl(
      milestone: null == milestone
          ? _value.milestone
          : milestone // ignore: cast_nullable_to_non_nullable
              as String,
      target: null == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MilestoneImpl implements _Milestone {
  const _$MilestoneImpl(
      {required this.milestone, required this.target, required this.date});

  factory _$MilestoneImpl.fromJson(Map<String, dynamic> json) =>
      _$$MilestoneImplFromJson(json);

  @override
  final String milestone;
  @override
  final String target;
  @override
  final String date;

  @override
  String toString() {
    return 'Milestone(milestone: $milestone, target: $target, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MilestoneImpl &&
            (identical(other.milestone, milestone) ||
                other.milestone == milestone) &&
            (identical(other.target, target) || other.target == target) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, milestone, target, date);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MilestoneImplCopyWith<_$MilestoneImpl> get copyWith =>
      __$$MilestoneImplCopyWithImpl<_$MilestoneImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MilestoneImplToJson(
      this,
    );
  }
}

abstract class _Milestone implements Milestone {
  const factory _Milestone(
      {required final String milestone,
      required final String target,
      required final String date}) = _$MilestoneImpl;

  factory _Milestone.fromJson(Map<String, dynamic> json) =
      _$MilestoneImpl.fromJson;

  @override
  String get milestone;
  @override
  String get target;
  @override
  String get date;
  @override
  @JsonKey(ignore: true)
  _$$MilestoneImplCopyWith<_$MilestoneImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ServiceRecommendation _$ServiceRecommendationFromJson(
    Map<String, dynamic> json) {
  return _ServiceRecommendation.fromJson(json);
}

/// @nodoc
mixin _$ServiceRecommendation {
  String get serviceType => throw _privateConstructorUsedError;
  String get frequency => throw _privateConstructorUsedError;
  String get duration => throw _privateConstructorUsedError;
  String get priority => throw _privateConstructorUsedError;
  String get rationale => throw _privateConstructorUsedError;
  int get estimatedCost => throw _privateConstructorUsedError;
  List<Provider> get providers => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ServiceRecommendationCopyWith<ServiceRecommendation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceRecommendationCopyWith<$Res> {
  factory $ServiceRecommendationCopyWith(ServiceRecommendation value,
          $Res Function(ServiceRecommendation) then) =
      _$ServiceRecommendationCopyWithImpl<$Res, ServiceRecommendation>;
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
class _$ServiceRecommendationCopyWithImpl<$Res,
        $Val extends ServiceRecommendation>
    implements $ServiceRecommendationCopyWith<$Res> {
  _$ServiceRecommendationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      serviceType: null == serviceType
          ? _value.serviceType
          : serviceType // ignore: cast_nullable_to_non_nullable
              as String,
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      rationale: null == rationale
          ? _value.rationale
          : rationale // ignore: cast_nullable_to_non_nullable
              as String,
      estimatedCost: null == estimatedCost
          ? _value.estimatedCost
          : estimatedCost // ignore: cast_nullable_to_non_nullable
              as int,
      providers: null == providers
          ? _value.providers
          : providers // ignore: cast_nullable_to_non_nullable
              as List<Provider>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServiceRecommendationImplCopyWith<$Res>
    implements $ServiceRecommendationCopyWith<$Res> {
  factory _$$ServiceRecommendationImplCopyWith(
          _$ServiceRecommendationImpl value,
          $Res Function(_$ServiceRecommendationImpl) then) =
      __$$ServiceRecommendationImplCopyWithImpl<$Res>;
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
class __$$ServiceRecommendationImplCopyWithImpl<$Res>
    extends _$ServiceRecommendationCopyWithImpl<$Res,
        _$ServiceRecommendationImpl>
    implements _$$ServiceRecommendationImplCopyWith<$Res> {
  __$$ServiceRecommendationImplCopyWithImpl(_$ServiceRecommendationImpl _value,
      $Res Function(_$ServiceRecommendationImpl) _then)
      : super(_value, _then);

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
    return _then(_$ServiceRecommendationImpl(
      serviceType: null == serviceType
          ? _value.serviceType
          : serviceType // ignore: cast_nullable_to_non_nullable
              as String,
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      rationale: null == rationale
          ? _value.rationale
          : rationale // ignore: cast_nullable_to_non_nullable
              as String,
      estimatedCost: null == estimatedCost
          ? _value.estimatedCost
          : estimatedCost // ignore: cast_nullable_to_non_nullable
              as int,
      providers: null == providers
          ? _value._providers
          : providers // ignore: cast_nullable_to_non_nullable
              as List<Provider>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceRecommendationImpl implements _ServiceRecommendation {
  const _$ServiceRecommendationImpl(
      {required this.serviceType,
      required this.frequency,
      required this.duration,
      required this.priority,
      required this.rationale,
      required this.estimatedCost,
      required final List<Provider> providers})
      : _providers = providers;

  factory _$ServiceRecommendationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceRecommendationImplFromJson(json);

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

  @override
  String toString() {
    return 'ServiceRecommendation(serviceType: $serviceType, frequency: $frequency, duration: $duration, priority: $priority, rationale: $rationale, estimatedCost: $estimatedCost, providers: $providers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceRecommendationImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceRecommendationImplCopyWith<_$ServiceRecommendationImpl>
      get copyWith => __$$ServiceRecommendationImplCopyWithImpl<
          _$ServiceRecommendationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceRecommendationImplToJson(
      this,
    );
  }
}

abstract class _ServiceRecommendation implements ServiceRecommendation {
  const factory _ServiceRecommendation(
      {required final String serviceType,
      required final String frequency,
      required final String duration,
      required final String priority,
      required final String rationale,
      required final int estimatedCost,
      required final List<Provider> providers}) = _$ServiceRecommendationImpl;

  factory _ServiceRecommendation.fromJson(Map<String, dynamic> json) =
      _$ServiceRecommendationImpl.fromJson;

  @override
  String get serviceType;
  @override
  String get frequency;
  @override
  String get duration;
  @override
  String get priority;
  @override
  String get rationale;
  @override
  int get estimatedCost;
  @override
  List<Provider> get providers;
  @override
  @JsonKey(ignore: true)
  _$$ServiceRecommendationImplCopyWith<_$ServiceRecommendationImpl>
      get copyWith => throw _privateConstructorUsedError;
}

Provider _$ProviderFromJson(Map<String, dynamic> json) {
  return _Provider.fromJson(json);
}

/// @nodoc
mixin _$Provider {
  String get name => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  String get availability => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProviderCopyWith<Provider> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProviderCopyWith<$Res> {
  factory $ProviderCopyWith(Provider value, $Res Function(Provider) then) =
      _$ProviderCopyWithImpl<$Res, Provider>;
  @useResult
  $Res call({String name, double rating, String availability});
}

/// @nodoc
class _$ProviderCopyWithImpl<$Res, $Val extends Provider>
    implements $ProviderCopyWith<$Res> {
  _$ProviderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? rating = null,
    Object? availability = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      availability: null == availability
          ? _value.availability
          : availability // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProviderImplCopyWith<$Res>
    implements $ProviderCopyWith<$Res> {
  factory _$$ProviderImplCopyWith(
          _$ProviderImpl value, $Res Function(_$ProviderImpl) then) =
      __$$ProviderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, double rating, String availability});
}

/// @nodoc
class __$$ProviderImplCopyWithImpl<$Res>
    extends _$ProviderCopyWithImpl<$Res, _$ProviderImpl>
    implements _$$ProviderImplCopyWith<$Res> {
  __$$ProviderImplCopyWithImpl(
      _$ProviderImpl _value, $Res Function(_$ProviderImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? rating = null,
    Object? availability = null,
  }) {
    return _then(_$ProviderImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      availability: null == availability
          ? _value.availability
          : availability // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProviderImpl implements _Provider {
  const _$ProviderImpl(
      {required this.name, required this.rating, required this.availability});

  factory _$ProviderImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProviderImplFromJson(json);

  @override
  final String name;
  @override
  final double rating;
  @override
  final String availability;

  @override
  String toString() {
    return 'Provider(name: $name, rating: $rating, availability: $availability)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProviderImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.availability, availability) ||
                other.availability == availability));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, rating, availability);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProviderImplCopyWith<_$ProviderImpl> get copyWith =>
      __$$ProviderImplCopyWithImpl<_$ProviderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProviderImplToJson(
      this,
    );
  }
}

abstract class _Provider implements Provider {
  const factory _Provider(
      {required final String name,
      required final double rating,
      required final String availability}) = _$ProviderImpl;

  factory _Provider.fromJson(Map<String, dynamic> json) =
      _$ProviderImpl.fromJson;

  @override
  String get name;
  @override
  double get rating;
  @override
  String get availability;
  @override
  @JsonKey(ignore: true)
  _$$ProviderImplCopyWith<_$ProviderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Resources _$ResourcesFromJson(Map<String, dynamic> json) {
  return _Resources.fromJson(json);
}

/// @nodoc
mixin _$Resources {
  int get workers => throw _privateConstructorUsedError;
  List<String> get equipment => throw _privateConstructorUsedError;
  Budget get budget => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResourcesCopyWith<Resources> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResourcesCopyWith<$Res> {
  factory $ResourcesCopyWith(Resources value, $Res Function(Resources) then) =
      _$ResourcesCopyWithImpl<$Res, Resources>;
  @useResult
  $Res call({int workers, List<String> equipment, Budget budget});

  $BudgetCopyWith<$Res> get budget;
}

/// @nodoc
class _$ResourcesCopyWithImpl<$Res, $Val extends Resources>
    implements $ResourcesCopyWith<$Res> {
  _$ResourcesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workers = null,
    Object? equipment = null,
    Object? budget = null,
  }) {
    return _then(_value.copyWith(
      workers: null == workers
          ? _value.workers
          : workers // ignore: cast_nullable_to_non_nullable
              as int,
      equipment: null == equipment
          ? _value.equipment
          : equipment // ignore: cast_nullable_to_non_nullable
              as List<String>,
      budget: null == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as Budget,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BudgetCopyWith<$Res> get budget {
    return $BudgetCopyWith<$Res>(_value.budget, (value) {
      return _then(_value.copyWith(budget: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ResourcesImplCopyWith<$Res>
    implements $ResourcesCopyWith<$Res> {
  factory _$$ResourcesImplCopyWith(
          _$ResourcesImpl value, $Res Function(_$ResourcesImpl) then) =
      __$$ResourcesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int workers, List<String> equipment, Budget budget});

  @override
  $BudgetCopyWith<$Res> get budget;
}

/// @nodoc
class __$$ResourcesImplCopyWithImpl<$Res>
    extends _$ResourcesCopyWithImpl<$Res, _$ResourcesImpl>
    implements _$$ResourcesImplCopyWith<$Res> {
  __$$ResourcesImplCopyWithImpl(
      _$ResourcesImpl _value, $Res Function(_$ResourcesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workers = null,
    Object? equipment = null,
    Object? budget = null,
  }) {
    return _then(_$ResourcesImpl(
      workers: null == workers
          ? _value.workers
          : workers // ignore: cast_nullable_to_non_nullable
              as int,
      equipment: null == equipment
          ? _value._equipment
          : equipment // ignore: cast_nullable_to_non_nullable
              as List<String>,
      budget: null == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as Budget,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResourcesImpl implements _Resources {
  const _$ResourcesImpl(
      {required this.workers,
      required final List<String> equipment,
      required this.budget})
      : _equipment = equipment;

  factory _$ResourcesImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResourcesImplFromJson(json);

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

  @override
  String toString() {
    return 'Resources(workers: $workers, equipment: $equipment, budget: $budget)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResourcesImpl &&
            (identical(other.workers, workers) || other.workers == workers) &&
            const DeepCollectionEquality()
                .equals(other._equipment, _equipment) &&
            (identical(other.budget, budget) || other.budget == budget));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, workers,
      const DeepCollectionEquality().hash(_equipment), budget);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResourcesImplCopyWith<_$ResourcesImpl> get copyWith =>
      __$$ResourcesImplCopyWithImpl<_$ResourcesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResourcesImplToJson(
      this,
    );
  }
}

abstract class _Resources implements Resources {
  const factory _Resources(
      {required final int workers,
      required final List<String> equipment,
      required final Budget budget}) = _$ResourcesImpl;

  factory _Resources.fromJson(Map<String, dynamic> json) =
      _$ResourcesImpl.fromJson;

  @override
  int get workers;
  @override
  List<String> get equipment;
  @override
  Budget get budget;
  @override
  @JsonKey(ignore: true)
  _$$ResourcesImplCopyWith<_$ResourcesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Budget _$BudgetFromJson(Map<String, dynamic> json) {
  return _Budget.fromJson(json);
}

/// @nodoc
mixin _$Budget {
  int get weekly => throw _privateConstructorUsedError;
  int get monthly => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BudgetCopyWith<Budget> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BudgetCopyWith<$Res> {
  factory $BudgetCopyWith(Budget value, $Res Function(Budget) then) =
      _$BudgetCopyWithImpl<$Res, Budget>;
  @useResult
  $Res call({int weekly, int monthly});
}

/// @nodoc
class _$BudgetCopyWithImpl<$Res, $Val extends Budget>
    implements $BudgetCopyWith<$Res> {
  _$BudgetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weekly = null,
    Object? monthly = null,
  }) {
    return _then(_value.copyWith(
      weekly: null == weekly
          ? _value.weekly
          : weekly // ignore: cast_nullable_to_non_nullable
              as int,
      monthly: null == monthly
          ? _value.monthly
          : monthly // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BudgetImplCopyWith<$Res> implements $BudgetCopyWith<$Res> {
  factory _$$BudgetImplCopyWith(
          _$BudgetImpl value, $Res Function(_$BudgetImpl) then) =
      __$$BudgetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int weekly, int monthly});
}

/// @nodoc
class __$$BudgetImplCopyWithImpl<$Res>
    extends _$BudgetCopyWithImpl<$Res, _$BudgetImpl>
    implements _$$BudgetImplCopyWith<$Res> {
  __$$BudgetImplCopyWithImpl(
      _$BudgetImpl _value, $Res Function(_$BudgetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weekly = null,
    Object? monthly = null,
  }) {
    return _then(_$BudgetImpl(
      weekly: null == weekly
          ? _value.weekly
          : weekly // ignore: cast_nullable_to_non_nullable
              as int,
      monthly: null == monthly
          ? _value.monthly
          : monthly // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BudgetImpl implements _Budget {
  const _$BudgetImpl({required this.weekly, required this.monthly});

  factory _$BudgetImpl.fromJson(Map<String, dynamic> json) =>
      _$$BudgetImplFromJson(json);

  @override
  final int weekly;
  @override
  final int monthly;

  @override
  String toString() {
    return 'Budget(weekly: $weekly, monthly: $monthly)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BudgetImpl &&
            (identical(other.weekly, weekly) || other.weekly == weekly) &&
            (identical(other.monthly, monthly) || other.monthly == monthly));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, weekly, monthly);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BudgetImplCopyWith<_$BudgetImpl> get copyWith =>
      __$$BudgetImplCopyWithImpl<_$BudgetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BudgetImplToJson(
      this,
    );
  }
}

abstract class _Budget implements Budget {
  const factory _Budget(
      {required final int weekly, required final int monthly}) = _$BudgetImpl;

  factory _Budget.fromJson(Map<String, dynamic> json) = _$BudgetImpl.fromJson;

  @override
  int get weekly;
  @override
  int get monthly;
  @override
  @JsonKey(ignore: true)
  _$$BudgetImplCopyWith<_$BudgetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Timeline _$TimelineFromJson(Map<String, dynamic> json) {
  return _Timeline.fromJson(json);
}

/// @nodoc
mixin _$Timeline {
  String get startDate => throw _privateConstructorUsedError;
  String get endDate => throw _privateConstructorUsedError;
  List<Phase> get phases => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimelineCopyWith<Timeline> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimelineCopyWith<$Res> {
  factory $TimelineCopyWith(Timeline value, $Res Function(Timeline) then) =
      _$TimelineCopyWithImpl<$Res, Timeline>;
  @useResult
  $Res call({String startDate, String endDate, List<Phase> phases});
}

/// @nodoc
class _$TimelineCopyWithImpl<$Res, $Val extends Timeline>
    implements $TimelineCopyWith<$Res> {
  _$TimelineCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = null,
    Object? endDate = null,
    Object? phases = null,
  }) {
    return _then(_value.copyWith(
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String,
      phases: null == phases
          ? _value.phases
          : phases // ignore: cast_nullable_to_non_nullable
              as List<Phase>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimelineImplCopyWith<$Res>
    implements $TimelineCopyWith<$Res> {
  factory _$$TimelineImplCopyWith(
          _$TimelineImpl value, $Res Function(_$TimelineImpl) then) =
      __$$TimelineImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String startDate, String endDate, List<Phase> phases});
}

/// @nodoc
class __$$TimelineImplCopyWithImpl<$Res>
    extends _$TimelineCopyWithImpl<$Res, _$TimelineImpl>
    implements _$$TimelineImplCopyWith<$Res> {
  __$$TimelineImplCopyWithImpl(
      _$TimelineImpl _value, $Res Function(_$TimelineImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = null,
    Object? endDate = null,
    Object? phases = null,
  }) {
    return _then(_$TimelineImpl(
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String,
      phases: null == phases
          ? _value._phases
          : phases // ignore: cast_nullable_to_non_nullable
              as List<Phase>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimelineImpl implements _Timeline {
  const _$TimelineImpl(
      {required this.startDate,
      required this.endDate,
      required final List<Phase> phases})
      : _phases = phases;

  factory _$TimelineImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimelineImplFromJson(json);

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

  @override
  String toString() {
    return 'Timeline(startDate: $startDate, endDate: $endDate, phases: $phases)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimelineImpl &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            const DeepCollectionEquality().equals(other._phases, _phases));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, startDate, endDate,
      const DeepCollectionEquality().hash(_phases));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimelineImplCopyWith<_$TimelineImpl> get copyWith =>
      __$$TimelineImplCopyWithImpl<_$TimelineImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimelineImplToJson(
      this,
    );
  }
}

abstract class _Timeline implements Timeline {
  const factory _Timeline(
      {required final String startDate,
      required final String endDate,
      required final List<Phase> phases}) = _$TimelineImpl;

  factory _Timeline.fromJson(Map<String, dynamic> json) =
      _$TimelineImpl.fromJson;

  @override
  String get startDate;
  @override
  String get endDate;
  @override
  List<Phase> get phases;
  @override
  @JsonKey(ignore: true)
  _$$TimelineImplCopyWith<_$TimelineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Phase _$PhaseFromJson(Map<String, dynamic> json) {
  return _Phase.fromJson(json);
}

/// @nodoc
mixin _$Phase {
  String get phase => throw _privateConstructorUsedError;
  String get duration => throw _privateConstructorUsedError;
  String get focus => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PhaseCopyWith<Phase> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhaseCopyWith<$Res> {
  factory $PhaseCopyWith(Phase value, $Res Function(Phase) then) =
      _$PhaseCopyWithImpl<$Res, Phase>;
  @useResult
  $Res call({String phase, String duration, String focus});
}

/// @nodoc
class _$PhaseCopyWithImpl<$Res, $Val extends Phase>
    implements $PhaseCopyWith<$Res> {
  _$PhaseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phase = null,
    Object? duration = null,
    Object? focus = null,
  }) {
    return _then(_value.copyWith(
      phase: null == phase
          ? _value.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String,
      focus: null == focus
          ? _value.focus
          : focus // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PhaseImplCopyWith<$Res> implements $PhaseCopyWith<$Res> {
  factory _$$PhaseImplCopyWith(
          _$PhaseImpl value, $Res Function(_$PhaseImpl) then) =
      __$$PhaseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String phase, String duration, String focus});
}

/// @nodoc
class __$$PhaseImplCopyWithImpl<$Res>
    extends _$PhaseCopyWithImpl<$Res, _$PhaseImpl>
    implements _$$PhaseImplCopyWith<$Res> {
  __$$PhaseImplCopyWithImpl(
      _$PhaseImpl _value, $Res Function(_$PhaseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phase = null,
    Object? duration = null,
    Object? focus = null,
  }) {
    return _then(_$PhaseImpl(
      phase: null == phase
          ? _value.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String,
      focus: null == focus
          ? _value.focus
          : focus // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PhaseImpl implements _Phase {
  const _$PhaseImpl(
      {required this.phase, required this.duration, required this.focus});

  factory _$PhaseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PhaseImplFromJson(json);

  @override
  final String phase;
  @override
  final String duration;
  @override
  final String focus;

  @override
  String toString() {
    return 'Phase(phase: $phase, duration: $duration, focus: $focus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhaseImpl &&
            (identical(other.phase, phase) || other.phase == phase) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.focus, focus) || other.focus == focus));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, phase, duration, focus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PhaseImplCopyWith<_$PhaseImpl> get copyWith =>
      __$$PhaseImplCopyWithImpl<_$PhaseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PhaseImplToJson(
      this,
    );
  }
}

abstract class _Phase implements Phase {
  const factory _Phase(
      {required final String phase,
      required final String duration,
      required final String focus}) = _$PhaseImpl;

  factory _Phase.fromJson(Map<String, dynamic> json) = _$PhaseImpl.fromJson;

  @override
  String get phase;
  @override
  String get duration;
  @override
  String get focus;
  @override
  @JsonKey(ignore: true)
  _$$PhaseImplCopyWith<_$PhaseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Review _$ReviewFromJson(Map<String, dynamic> json) {
  return _Review.fromJson(json);
}

/// @nodoc
mixin _$Review {
  String get type => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReviewCopyWith<Review> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewCopyWith<$Res> {
  factory $ReviewCopyWith(Review value, $Res Function(Review) then) =
      _$ReviewCopyWithImpl<$Res, Review>;
  @useResult
  $Res call({String type, String date});
}

/// @nodoc
class _$ReviewCopyWithImpl<$Res, $Val extends Review>
    implements $ReviewCopyWith<$Res> {
  _$ReviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? date = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReviewImplCopyWith<$Res> implements $ReviewCopyWith<$Res> {
  factory _$$ReviewImplCopyWith(
          _$ReviewImpl value, $Res Function(_$ReviewImpl) then) =
      __$$ReviewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, String date});
}

/// @nodoc
class __$$ReviewImplCopyWithImpl<$Res>
    extends _$ReviewCopyWithImpl<$Res, _$ReviewImpl>
    implements _$$ReviewImplCopyWith<$Res> {
  __$$ReviewImplCopyWithImpl(
      _$ReviewImpl _value, $Res Function(_$ReviewImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? date = null,
  }) {
    return _then(_$ReviewImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReviewImpl implements _Review {
  const _$ReviewImpl({required this.type, required this.date});

  factory _$ReviewImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewImplFromJson(json);

  @override
  final String type;
  @override
  final String date;

  @override
  String toString() {
    return 'Review(type: $type, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, date);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewImplCopyWith<_$ReviewImpl> get copyWith =>
      __$$ReviewImplCopyWithImpl<_$ReviewImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewImplToJson(
      this,
    );
  }
}

abstract class _Review implements Review {
  const factory _Review(
      {required final String type, required final String date}) = _$ReviewImpl;

  factory _Review.fromJson(Map<String, dynamic> json) = _$ReviewImpl.fromJson;

  @override
  String get type;
  @override
  String get date;
  @override
  @JsonKey(ignore: true)
  _$$ReviewImplCopyWith<_$ReviewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SuccessMetric _$SuccessMetricFromJson(Map<String, dynamic> json) {
  return _SuccessMetric.fromJson(json);
}

/// @nodoc
mixin _$SuccessMetric {
  String get metric => throw _privateConstructorUsedError;
  String get target => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SuccessMetricCopyWith<SuccessMetric> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SuccessMetricCopyWith<$Res> {
  factory $SuccessMetricCopyWith(
          SuccessMetric value, $Res Function(SuccessMetric) then) =
      _$SuccessMetricCopyWithImpl<$Res, SuccessMetric>;
  @useResult
  $Res call({String metric, String target});
}

/// @nodoc
class _$SuccessMetricCopyWithImpl<$Res, $Val extends SuccessMetric>
    implements $SuccessMetricCopyWith<$Res> {
  _$SuccessMetricCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? metric = null,
    Object? target = null,
  }) {
    return _then(_value.copyWith(
      metric: null == metric
          ? _value.metric
          : metric // ignore: cast_nullable_to_non_nullable
              as String,
      target: null == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SuccessMetricImplCopyWith<$Res>
    implements $SuccessMetricCopyWith<$Res> {
  factory _$$SuccessMetricImplCopyWith(
          _$SuccessMetricImpl value, $Res Function(_$SuccessMetricImpl) then) =
      __$$SuccessMetricImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String metric, String target});
}

/// @nodoc
class __$$SuccessMetricImplCopyWithImpl<$Res>
    extends _$SuccessMetricCopyWithImpl<$Res, _$SuccessMetricImpl>
    implements _$$SuccessMetricImplCopyWith<$Res> {
  __$$SuccessMetricImplCopyWithImpl(
      _$SuccessMetricImpl _value, $Res Function(_$SuccessMetricImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? metric = null,
    Object? target = null,
  }) {
    return _then(_$SuccessMetricImpl(
      metric: null == metric
          ? _value.metric
          : metric // ignore: cast_nullable_to_non_nullable
              as String,
      target: null == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SuccessMetricImpl implements _SuccessMetric {
  const _$SuccessMetricImpl({required this.metric, required this.target});

  factory _$SuccessMetricImpl.fromJson(Map<String, dynamic> json) =>
      _$$SuccessMetricImplFromJson(json);

  @override
  final String metric;
  @override
  final String target;

  @override
  String toString() {
    return 'SuccessMetric(metric: $metric, target: $target)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessMetricImpl &&
            (identical(other.metric, metric) || other.metric == metric) &&
            (identical(other.target, target) || other.target == target));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, metric, target);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessMetricImplCopyWith<_$SuccessMetricImpl> get copyWith =>
      __$$SuccessMetricImplCopyWithImpl<_$SuccessMetricImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SuccessMetricImplToJson(
      this,
    );
  }
}

abstract class _SuccessMetric implements SuccessMetric {
  const factory _SuccessMetric(
      {required final String metric,
      required final String target}) = _$SuccessMetricImpl;

  factory _SuccessMetric.fromJson(Map<String, dynamic> json) =
      _$SuccessMetricImpl.fromJson;

  @override
  String get metric;
  @override
  String get target;
  @override
  @JsonKey(ignore: true)
  _$$SuccessMetricImplCopyWith<_$SuccessMetricImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Incident _$IncidentFromJson(Map<String, dynamic> json) {
  return _Incident.fromJson(json);
}

/// @nodoc
mixin _$Incident {
  String get incidentId => throw _privateConstructorUsedError;
  String get reportedAt => throw _privateConstructorUsedError;
  String get severity => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  List<String> get immediateActions => throw _privateConstructorUsedError;
  NotificationRouting get notifications => throw _privateConstructorUsedError;
  Investigation get investigation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IncidentCopyWith<Incident> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IncidentCopyWith<$Res> {
  factory $IncidentCopyWith(Incident value, $Res Function(Incident) then) =
      _$IncidentCopyWithImpl<$Res, Incident>;
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
class _$IncidentCopyWithImpl<$Res, $Val extends Incident>
    implements $IncidentCopyWith<$Res> {
  _$IncidentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      incidentId: null == incidentId
          ? _value.incidentId
          : incidentId // ignore: cast_nullable_to_non_nullable
              as String,
      reportedAt: null == reportedAt
          ? _value.reportedAt
          : reportedAt // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      immediateActions: null == immediateActions
          ? _value.immediateActions
          : immediateActions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notifications: null == notifications
          ? _value.notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as NotificationRouting,
      investigation: null == investigation
          ? _value.investigation
          : investigation // ignore: cast_nullable_to_non_nullable
              as Investigation,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NotificationRoutingCopyWith<$Res> get notifications {
    return $NotificationRoutingCopyWith<$Res>(_value.notifications, (value) {
      return _then(_value.copyWith(notifications: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $InvestigationCopyWith<$Res> get investigation {
    return $InvestigationCopyWith<$Res>(_value.investigation, (value) {
      return _then(_value.copyWith(investigation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$IncidentImplCopyWith<$Res>
    implements $IncidentCopyWith<$Res> {
  factory _$$IncidentImplCopyWith(
          _$IncidentImpl value, $Res Function(_$IncidentImpl) then) =
      __$$IncidentImplCopyWithImpl<$Res>;
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
class __$$IncidentImplCopyWithImpl<$Res>
    extends _$IncidentCopyWithImpl<$Res, _$IncidentImpl>
    implements _$$IncidentImplCopyWith<$Res> {
  __$$IncidentImplCopyWithImpl(
      _$IncidentImpl _value, $Res Function(_$IncidentImpl) _then)
      : super(_value, _then);

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
    return _then(_$IncidentImpl(
      incidentId: null == incidentId
          ? _value.incidentId
          : incidentId // ignore: cast_nullable_to_non_nullable
              as String,
      reportedAt: null == reportedAt
          ? _value.reportedAt
          : reportedAt // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      immediateActions: null == immediateActions
          ? _value._immediateActions
          : immediateActions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notifications: null == notifications
          ? _value.notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as NotificationRouting,
      investigation: null == investigation
          ? _value.investigation
          : investigation // ignore: cast_nullable_to_non_nullable
              as Investigation,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IncidentImpl implements _Incident {
  const _$IncidentImpl(
      {required this.incidentId,
      required this.reportedAt,
      required this.severity,
      required this.category,
      required final List<String> immediateActions,
      required this.notifications,
      required this.investigation})
      : _immediateActions = immediateActions;

  factory _$IncidentImpl.fromJson(Map<String, dynamic> json) =>
      _$$IncidentImplFromJson(json);

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

  @override
  String toString() {
    return 'Incident(incidentId: $incidentId, reportedAt: $reportedAt, severity: $severity, category: $category, immediateActions: $immediateActions, notifications: $notifications, investigation: $investigation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IncidentImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IncidentImplCopyWith<_$IncidentImpl> get copyWith =>
      __$$IncidentImplCopyWithImpl<_$IncidentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IncidentImplToJson(
      this,
    );
  }
}

abstract class _Incident implements Incident {
  const factory _Incident(
      {required final String incidentId,
      required final String reportedAt,
      required final String severity,
      required final String category,
      required final List<String> immediateActions,
      required final NotificationRouting notifications,
      required final Investigation investigation}) = _$IncidentImpl;

  factory _Incident.fromJson(Map<String, dynamic> json) =
      _$IncidentImpl.fromJson;

  @override
  String get incidentId;
  @override
  String get reportedAt;
  @override
  String get severity;
  @override
  String get category;
  @override
  List<String> get immediateActions;
  @override
  NotificationRouting get notifications;
  @override
  Investigation get investigation;
  @override
  @JsonKey(ignore: true)
  _$$IncidentImplCopyWith<_$IncidentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NotificationRouting _$NotificationRoutingFromJson(Map<String, dynamic> json) {
  return _NotificationRouting.fromJson(json);
}

/// @nodoc
mixin _$NotificationRouting {
  bool get family => throw _privateConstructorUsedError;
  bool get supervisor => throw _privateConstructorUsedError;
  bool get careCoordinator => throw _privateConstructorUsedError;
  bool get regulator => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationRoutingCopyWith<NotificationRouting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationRoutingCopyWith<$Res> {
  factory $NotificationRoutingCopyWith(
          NotificationRouting value, $Res Function(NotificationRouting) then) =
      _$NotificationRoutingCopyWithImpl<$Res, NotificationRouting>;
  @useResult
  $Res call(
      {bool family, bool supervisor, bool careCoordinator, bool regulator});
}

/// @nodoc
class _$NotificationRoutingCopyWithImpl<$Res, $Val extends NotificationRouting>
    implements $NotificationRoutingCopyWith<$Res> {
  _$NotificationRoutingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? family = null,
    Object? supervisor = null,
    Object? careCoordinator = null,
    Object? regulator = null,
  }) {
    return _then(_value.copyWith(
      family: null == family
          ? _value.family
          : family // ignore: cast_nullable_to_non_nullable
              as bool,
      supervisor: null == supervisor
          ? _value.supervisor
          : supervisor // ignore: cast_nullable_to_non_nullable
              as bool,
      careCoordinator: null == careCoordinator
          ? _value.careCoordinator
          : careCoordinator // ignore: cast_nullable_to_non_nullable
              as bool,
      regulator: null == regulator
          ? _value.regulator
          : regulator // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationRoutingImplCopyWith<$Res>
    implements $NotificationRoutingCopyWith<$Res> {
  factory _$$NotificationRoutingImplCopyWith(_$NotificationRoutingImpl value,
          $Res Function(_$NotificationRoutingImpl) then) =
      __$$NotificationRoutingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool family, bool supervisor, bool careCoordinator, bool regulator});
}

/// @nodoc
class __$$NotificationRoutingImplCopyWithImpl<$Res>
    extends _$NotificationRoutingCopyWithImpl<$Res, _$NotificationRoutingImpl>
    implements _$$NotificationRoutingImplCopyWith<$Res> {
  __$$NotificationRoutingImplCopyWithImpl(_$NotificationRoutingImpl _value,
      $Res Function(_$NotificationRoutingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? family = null,
    Object? supervisor = null,
    Object? careCoordinator = null,
    Object? regulator = null,
  }) {
    return _then(_$NotificationRoutingImpl(
      family: null == family
          ? _value.family
          : family // ignore: cast_nullable_to_non_nullable
              as bool,
      supervisor: null == supervisor
          ? _value.supervisor
          : supervisor // ignore: cast_nullable_to_non_nullable
              as bool,
      careCoordinator: null == careCoordinator
          ? _value.careCoordinator
          : careCoordinator // ignore: cast_nullable_to_non_nullable
              as bool,
      regulator: null == regulator
          ? _value.regulator
          : regulator // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationRoutingImpl implements _NotificationRouting {
  const _$NotificationRoutingImpl(
      {required this.family,
      required this.supervisor,
      required this.careCoordinator,
      required this.regulator});

  factory _$NotificationRoutingImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationRoutingImplFromJson(json);

  @override
  final bool family;
  @override
  final bool supervisor;
  @override
  final bool careCoordinator;
  @override
  final bool regulator;

  @override
  String toString() {
    return 'NotificationRouting(family: $family, supervisor: $supervisor, careCoordinator: $careCoordinator, regulator: $regulator)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationRoutingImpl &&
            (identical(other.family, family) || other.family == family) &&
            (identical(other.supervisor, supervisor) ||
                other.supervisor == supervisor) &&
            (identical(other.careCoordinator, careCoordinator) ||
                other.careCoordinator == careCoordinator) &&
            (identical(other.regulator, regulator) ||
                other.regulator == regulator));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, family, supervisor, careCoordinator, regulator);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationRoutingImplCopyWith<_$NotificationRoutingImpl> get copyWith =>
      __$$NotificationRoutingImplCopyWithImpl<_$NotificationRoutingImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationRoutingImplToJson(
      this,
    );
  }
}

abstract class _NotificationRouting implements NotificationRouting {
  const factory _NotificationRouting(
      {required final bool family,
      required final bool supervisor,
      required final bool careCoordinator,
      required final bool regulator}) = _$NotificationRoutingImpl;

  factory _NotificationRouting.fromJson(Map<String, dynamic> json) =
      _$NotificationRoutingImpl.fromJson;

  @override
  bool get family;
  @override
  bool get supervisor;
  @override
  bool get careCoordinator;
  @override
  bool get regulator;
  @override
  @JsonKey(ignore: true)
  _$$NotificationRoutingImplCopyWith<_$NotificationRoutingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Investigation _$InvestigationFromJson(Map<String, dynamic> json) {
  return _Investigation.fromJson(json);
}

/// @nodoc
mixin _$Investigation {
  String get investigator => throw _privateConstructorUsedError;
  String get dueDate => throw _privateConstructorUsedError;
  List<String> get steps => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InvestigationCopyWith<Investigation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvestigationCopyWith<$Res> {
  factory $InvestigationCopyWith(
          Investigation value, $Res Function(Investigation) then) =
      _$InvestigationCopyWithImpl<$Res, Investigation>;
  @useResult
  $Res call({String investigator, String dueDate, List<String> steps});
}

/// @nodoc
class _$InvestigationCopyWithImpl<$Res, $Val extends Investigation>
    implements $InvestigationCopyWith<$Res> {
  _$InvestigationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? investigator = null,
    Object? dueDate = null,
    Object? steps = null,
  }) {
    return _then(_value.copyWith(
      investigator: null == investigator
          ? _value.investigator
          : investigator // ignore: cast_nullable_to_non_nullable
              as String,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as String,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvestigationImplCopyWith<$Res>
    implements $InvestigationCopyWith<$Res> {
  factory _$$InvestigationImplCopyWith(
          _$InvestigationImpl value, $Res Function(_$InvestigationImpl) then) =
      __$$InvestigationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String investigator, String dueDate, List<String> steps});
}

/// @nodoc
class __$$InvestigationImplCopyWithImpl<$Res>
    extends _$InvestigationCopyWithImpl<$Res, _$InvestigationImpl>
    implements _$$InvestigationImplCopyWith<$Res> {
  __$$InvestigationImplCopyWithImpl(
      _$InvestigationImpl _value, $Res Function(_$InvestigationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? investigator = null,
    Object? dueDate = null,
    Object? steps = null,
  }) {
    return _then(_$InvestigationImpl(
      investigator: null == investigator
          ? _value.investigator
          : investigator // ignore: cast_nullable_to_non_nullable
              as String,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as String,
      steps: null == steps
          ? _value._steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvestigationImpl implements _Investigation {
  const _$InvestigationImpl(
      {required this.investigator,
      required this.dueDate,
      required final List<String> steps})
      : _steps = steps;

  factory _$InvestigationImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvestigationImplFromJson(json);

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

  @override
  String toString() {
    return 'Investigation(investigator: $investigator, dueDate: $dueDate, steps: $steps)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvestigationImpl &&
            (identical(other.investigator, investigator) ||
                other.investigator == investigator) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            const DeepCollectionEquality().equals(other._steps, _steps));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, investigator, dueDate,
      const DeepCollectionEquality().hash(_steps));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InvestigationImplCopyWith<_$InvestigationImpl> get copyWith =>
      __$$InvestigationImplCopyWithImpl<_$InvestigationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvestigationImplToJson(
      this,
    );
  }
}

abstract class _Investigation implements Investigation {
  const factory _Investigation(
      {required final String investigator,
      required final String dueDate,
      required final List<String> steps}) = _$InvestigationImpl;

  factory _Investigation.fromJson(Map<String, dynamic> json) =
      _$InvestigationImpl.fromJson;

  @override
  String get investigator;
  @override
  String get dueDate;
  @override
  List<String> get steps;
  @override
  @JsonKey(ignore: true)
  _$$InvestigationImplCopyWith<_$InvestigationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RootCauseAnalysis _$RootCauseAnalysisFromJson(Map<String, dynamic> json) {
  return _RootCauseAnalysis.fromJson(json);
}

/// @nodoc
mixin _$RootCauseAnalysis {
  String get incidentId => throw _privateConstructorUsedError;
  String get analyzedAt => throw _privateConstructorUsedError;
  List<RootCause> get rootCauses => throw _privateConstructorUsedError;
  List<ContributingFactorAnalysis> get contributingFactors =>
      throw _privateConstructorUsedError;
  List<String> get systemicIssues => throw _privateConstructorUsedError;
  List<SimilarIncident> get similarIncidents =>
      throw _privateConstructorUsedError;
  List<String> get recommendations => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RootCauseAnalysisCopyWith<RootCauseAnalysis> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RootCauseAnalysisCopyWith<$Res> {
  factory $RootCauseAnalysisCopyWith(
          RootCauseAnalysis value, $Res Function(RootCauseAnalysis) then) =
      _$RootCauseAnalysisCopyWithImpl<$Res, RootCauseAnalysis>;
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
class _$RootCauseAnalysisCopyWithImpl<$Res, $Val extends RootCauseAnalysis>
    implements $RootCauseAnalysisCopyWith<$Res> {
  _$RootCauseAnalysisCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      incidentId: null == incidentId
          ? _value.incidentId
          : incidentId // ignore: cast_nullable_to_non_nullable
              as String,
      analyzedAt: null == analyzedAt
          ? _value.analyzedAt
          : analyzedAt // ignore: cast_nullable_to_non_nullable
              as String,
      rootCauses: null == rootCauses
          ? _value.rootCauses
          : rootCauses // ignore: cast_nullable_to_non_nullable
              as List<RootCause>,
      contributingFactors: null == contributingFactors
          ? _value.contributingFactors
          : contributingFactors // ignore: cast_nullable_to_non_nullable
              as List<ContributingFactorAnalysis>,
      systemicIssues: null == systemicIssues
          ? _value.systemicIssues
          : systemicIssues // ignore: cast_nullable_to_non_nullable
              as List<String>,
      similarIncidents: null == similarIncidents
          ? _value.similarIncidents
          : similarIncidents // ignore: cast_nullable_to_non_nullable
              as List<SimilarIncident>,
      recommendations: null == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RootCauseAnalysisImplCopyWith<$Res>
    implements $RootCauseAnalysisCopyWith<$Res> {
  factory _$$RootCauseAnalysisImplCopyWith(_$RootCauseAnalysisImpl value,
          $Res Function(_$RootCauseAnalysisImpl) then) =
      __$$RootCauseAnalysisImplCopyWithImpl<$Res>;
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
class __$$RootCauseAnalysisImplCopyWithImpl<$Res>
    extends _$RootCauseAnalysisCopyWithImpl<$Res, _$RootCauseAnalysisImpl>
    implements _$$RootCauseAnalysisImplCopyWith<$Res> {
  __$$RootCauseAnalysisImplCopyWithImpl(_$RootCauseAnalysisImpl _value,
      $Res Function(_$RootCauseAnalysisImpl) _then)
      : super(_value, _then);

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
    return _then(_$RootCauseAnalysisImpl(
      incidentId: null == incidentId
          ? _value.incidentId
          : incidentId // ignore: cast_nullable_to_non_nullable
              as String,
      analyzedAt: null == analyzedAt
          ? _value.analyzedAt
          : analyzedAt // ignore: cast_nullable_to_non_nullable
              as String,
      rootCauses: null == rootCauses
          ? _value._rootCauses
          : rootCauses // ignore: cast_nullable_to_non_nullable
              as List<RootCause>,
      contributingFactors: null == contributingFactors
          ? _value._contributingFactors
          : contributingFactors // ignore: cast_nullable_to_non_nullable
              as List<ContributingFactorAnalysis>,
      systemicIssues: null == systemicIssues
          ? _value._systemicIssues
          : systemicIssues // ignore: cast_nullable_to_non_nullable
              as List<String>,
      similarIncidents: null == similarIncidents
          ? _value._similarIncidents
          : similarIncidents // ignore: cast_nullable_to_non_nullable
              as List<SimilarIncident>,
      recommendations: null == recommendations
          ? _value._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RootCauseAnalysisImpl implements _RootCauseAnalysis {
  const _$RootCauseAnalysisImpl(
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

  factory _$RootCauseAnalysisImpl.fromJson(Map<String, dynamic> json) =>
      _$$RootCauseAnalysisImplFromJson(json);

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

  @override
  String toString() {
    return 'RootCauseAnalysis(incidentId: $incidentId, analyzedAt: $analyzedAt, rootCauses: $rootCauses, contributingFactors: $contributingFactors, systemicIssues: $systemicIssues, similarIncidents: $similarIncidents, recommendations: $recommendations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RootCauseAnalysisImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RootCauseAnalysisImplCopyWith<_$RootCauseAnalysisImpl> get copyWith =>
      __$$RootCauseAnalysisImplCopyWithImpl<_$RootCauseAnalysisImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RootCauseAnalysisImplToJson(
      this,
    );
  }
}

abstract class _RootCauseAnalysis implements RootCauseAnalysis {
  const factory _RootCauseAnalysis(
      {required final String incidentId,
      required final String analyzedAt,
      required final List<RootCause> rootCauses,
      required final List<ContributingFactorAnalysis> contributingFactors,
      required final List<String> systemicIssues,
      required final List<SimilarIncident> similarIncidents,
      required final List<String> recommendations}) = _$RootCauseAnalysisImpl;

  factory _RootCauseAnalysis.fromJson(Map<String, dynamic> json) =
      _$RootCauseAnalysisImpl.fromJson;

  @override
  String get incidentId;
  @override
  String get analyzedAt;
  @override
  List<RootCause> get rootCauses;
  @override
  List<ContributingFactorAnalysis> get contributingFactors;
  @override
  List<String> get systemicIssues;
  @override
  List<SimilarIncident> get similarIncidents;
  @override
  List<String> get recommendations;
  @override
  @JsonKey(ignore: true)
  _$$RootCauseAnalysisImplCopyWith<_$RootCauseAnalysisImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RootCause _$RootCauseFromJson(Map<String, dynamic> json) {
  return _RootCause.fromJson(json);
}

/// @nodoc
mixin _$RootCause {
  String get cause => throw _privateConstructorUsedError;
  String get likelihood => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RootCauseCopyWith<RootCause> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RootCauseCopyWith<$Res> {
  factory $RootCauseCopyWith(RootCause value, $Res Function(RootCause) then) =
      _$RootCauseCopyWithImpl<$Res, RootCause>;
  @useResult
  $Res call({String cause, String likelihood});
}

/// @nodoc
class _$RootCauseCopyWithImpl<$Res, $Val extends RootCause>
    implements $RootCauseCopyWith<$Res> {
  _$RootCauseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cause = null,
    Object? likelihood = null,
  }) {
    return _then(_value.copyWith(
      cause: null == cause
          ? _value.cause
          : cause // ignore: cast_nullable_to_non_nullable
              as String,
      likelihood: null == likelihood
          ? _value.likelihood
          : likelihood // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RootCauseImplCopyWith<$Res>
    implements $RootCauseCopyWith<$Res> {
  factory _$$RootCauseImplCopyWith(
          _$RootCauseImpl value, $Res Function(_$RootCauseImpl) then) =
      __$$RootCauseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String cause, String likelihood});
}

/// @nodoc
class __$$RootCauseImplCopyWithImpl<$Res>
    extends _$RootCauseCopyWithImpl<$Res, _$RootCauseImpl>
    implements _$$RootCauseImplCopyWith<$Res> {
  __$$RootCauseImplCopyWithImpl(
      _$RootCauseImpl _value, $Res Function(_$RootCauseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cause = null,
    Object? likelihood = null,
  }) {
    return _then(_$RootCauseImpl(
      cause: null == cause
          ? _value.cause
          : cause // ignore: cast_nullable_to_non_nullable
              as String,
      likelihood: null == likelihood
          ? _value.likelihood
          : likelihood // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RootCauseImpl implements _RootCause {
  const _$RootCauseImpl({required this.cause, required this.likelihood});

  factory _$RootCauseImpl.fromJson(Map<String, dynamic> json) =>
      _$$RootCauseImplFromJson(json);

  @override
  final String cause;
  @override
  final String likelihood;

  @override
  String toString() {
    return 'RootCause(cause: $cause, likelihood: $likelihood)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RootCauseImpl &&
            (identical(other.cause, cause) || other.cause == cause) &&
            (identical(other.likelihood, likelihood) ||
                other.likelihood == likelihood));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, cause, likelihood);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RootCauseImplCopyWith<_$RootCauseImpl> get copyWith =>
      __$$RootCauseImplCopyWithImpl<_$RootCauseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RootCauseImplToJson(
      this,
    );
  }
}

abstract class _RootCause implements RootCause {
  const factory _RootCause(
      {required final String cause,
      required final String likelihood}) = _$RootCauseImpl;

  factory _RootCause.fromJson(Map<String, dynamic> json) =
      _$RootCauseImpl.fromJson;

  @override
  String get cause;
  @override
  String get likelihood;
  @override
  @JsonKey(ignore: true)
  _$$RootCauseImplCopyWith<_$RootCauseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ContributingFactorAnalysis _$ContributingFactorAnalysisFromJson(
    Map<String, dynamic> json) {
  return _ContributingFactorAnalysis.fromJson(json);
}

/// @nodoc
mixin _$ContributingFactorAnalysis {
  String get factor => throw _privateConstructorUsedError;
  String get contribution => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ContributingFactorAnalysisCopyWith<ContributingFactorAnalysis>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContributingFactorAnalysisCopyWith<$Res> {
  factory $ContributingFactorAnalysisCopyWith(ContributingFactorAnalysis value,
          $Res Function(ContributingFactorAnalysis) then) =
      _$ContributingFactorAnalysisCopyWithImpl<$Res,
          ContributingFactorAnalysis>;
  @useResult
  $Res call({String factor, String contribution});
}

/// @nodoc
class _$ContributingFactorAnalysisCopyWithImpl<$Res,
        $Val extends ContributingFactorAnalysis>
    implements $ContributingFactorAnalysisCopyWith<$Res> {
  _$ContributingFactorAnalysisCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? factor = null,
    Object? contribution = null,
  }) {
    return _then(_value.copyWith(
      factor: null == factor
          ? _value.factor
          : factor // ignore: cast_nullable_to_non_nullable
              as String,
      contribution: null == contribution
          ? _value.contribution
          : contribution // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContributingFactorAnalysisImplCopyWith<$Res>
    implements $ContributingFactorAnalysisCopyWith<$Res> {
  factory _$$ContributingFactorAnalysisImplCopyWith(
          _$ContributingFactorAnalysisImpl value,
          $Res Function(_$ContributingFactorAnalysisImpl) then) =
      __$$ContributingFactorAnalysisImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String factor, String contribution});
}

/// @nodoc
class __$$ContributingFactorAnalysisImplCopyWithImpl<$Res>
    extends _$ContributingFactorAnalysisCopyWithImpl<$Res,
        _$ContributingFactorAnalysisImpl>
    implements _$$ContributingFactorAnalysisImplCopyWith<$Res> {
  __$$ContributingFactorAnalysisImplCopyWithImpl(
      _$ContributingFactorAnalysisImpl _value,
      $Res Function(_$ContributingFactorAnalysisImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? factor = null,
    Object? contribution = null,
  }) {
    return _then(_$ContributingFactorAnalysisImpl(
      factor: null == factor
          ? _value.factor
          : factor // ignore: cast_nullable_to_non_nullable
              as String,
      contribution: null == contribution
          ? _value.contribution
          : contribution // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContributingFactorAnalysisImpl implements _ContributingFactorAnalysis {
  const _$ContributingFactorAnalysisImpl(
      {required this.factor, required this.contribution});

  factory _$ContributingFactorAnalysisImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ContributingFactorAnalysisImplFromJson(json);

  @override
  final String factor;
  @override
  final String contribution;

  @override
  String toString() {
    return 'ContributingFactorAnalysis(factor: $factor, contribution: $contribution)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContributingFactorAnalysisImpl &&
            (identical(other.factor, factor) || other.factor == factor) &&
            (identical(other.contribution, contribution) ||
                other.contribution == contribution));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, factor, contribution);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContributingFactorAnalysisImplCopyWith<_$ContributingFactorAnalysisImpl>
      get copyWith => __$$ContributingFactorAnalysisImplCopyWithImpl<
          _$ContributingFactorAnalysisImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContributingFactorAnalysisImplToJson(
      this,
    );
  }
}

abstract class _ContributingFactorAnalysis
    implements ContributingFactorAnalysis {
  const factory _ContributingFactorAnalysis(
      {required final String factor,
      required final String contribution}) = _$ContributingFactorAnalysisImpl;

  factory _ContributingFactorAnalysis.fromJson(Map<String, dynamic> json) =
      _$ContributingFactorAnalysisImpl.fromJson;

  @override
  String get factor;
  @override
  String get contribution;
  @override
  @JsonKey(ignore: true)
  _$$ContributingFactorAnalysisImplCopyWith<_$ContributingFactorAnalysisImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SimilarIncident _$SimilarIncidentFromJson(Map<String, dynamic> json) {
  return _SimilarIncident.fromJson(json);
}

/// @nodoc
mixin _$SimilarIncident {
  String get incidentId => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  double get similarity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SimilarIncidentCopyWith<SimilarIncident> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimilarIncidentCopyWith<$Res> {
  factory $SimilarIncidentCopyWith(
          SimilarIncident value, $Res Function(SimilarIncident) then) =
      _$SimilarIncidentCopyWithImpl<$Res, SimilarIncident>;
  @useResult
  $Res call({String incidentId, String date, double similarity});
}

/// @nodoc
class _$SimilarIncidentCopyWithImpl<$Res, $Val extends SimilarIncident>
    implements $SimilarIncidentCopyWith<$Res> {
  _$SimilarIncidentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? incidentId = null,
    Object? date = null,
    Object? similarity = null,
  }) {
    return _then(_value.copyWith(
      incidentId: null == incidentId
          ? _value.incidentId
          : incidentId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      similarity: null == similarity
          ? _value.similarity
          : similarity // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SimilarIncidentImplCopyWith<$Res>
    implements $SimilarIncidentCopyWith<$Res> {
  factory _$$SimilarIncidentImplCopyWith(_$SimilarIncidentImpl value,
          $Res Function(_$SimilarIncidentImpl) then) =
      __$$SimilarIncidentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String incidentId, String date, double similarity});
}

/// @nodoc
class __$$SimilarIncidentImplCopyWithImpl<$Res>
    extends _$SimilarIncidentCopyWithImpl<$Res, _$SimilarIncidentImpl>
    implements _$$SimilarIncidentImplCopyWith<$Res> {
  __$$SimilarIncidentImplCopyWithImpl(
      _$SimilarIncidentImpl _value, $Res Function(_$SimilarIncidentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? incidentId = null,
    Object? date = null,
    Object? similarity = null,
  }) {
    return _then(_$SimilarIncidentImpl(
      incidentId: null == incidentId
          ? _value.incidentId
          : incidentId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      similarity: null == similarity
          ? _value.similarity
          : similarity // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SimilarIncidentImpl implements _SimilarIncident {
  const _$SimilarIncidentImpl(
      {required this.incidentId, required this.date, required this.similarity});

  factory _$SimilarIncidentImpl.fromJson(Map<String, dynamic> json) =>
      _$$SimilarIncidentImplFromJson(json);

  @override
  final String incidentId;
  @override
  final String date;
  @override
  final double similarity;

  @override
  String toString() {
    return 'SimilarIncident(incidentId: $incidentId, date: $date, similarity: $similarity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SimilarIncidentImpl &&
            (identical(other.incidentId, incidentId) ||
                other.incidentId == incidentId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.similarity, similarity) ||
                other.similarity == similarity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, incidentId, date, similarity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SimilarIncidentImplCopyWith<_$SimilarIncidentImpl> get copyWith =>
      __$$SimilarIncidentImplCopyWithImpl<_$SimilarIncidentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SimilarIncidentImplToJson(
      this,
    );
  }
}

abstract class _SimilarIncident implements SimilarIncident {
  const factory _SimilarIncident(
      {required final String incidentId,
      required final String date,
      required final double similarity}) = _$SimilarIncidentImpl;

  factory _SimilarIncident.fromJson(Map<String, dynamic> json) =
      _$SimilarIncidentImpl.fromJson;

  @override
  String get incidentId;
  @override
  String get date;
  @override
  double get similarity;
  @override
  @JsonKey(ignore: true)
  _$$SimilarIncidentImplCopyWith<_$SimilarIncidentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IncidentPatterns _$IncidentPatternsFromJson(Map<String, dynamic> json) {
  return _IncidentPatterns.fromJson(json);
}

/// @nodoc
mixin _$IncidentPatterns {
  String get organizationId => throw _privateConstructorUsedError;
  String get timeframe => throw _privateConstructorUsedError;
  String get analyzedAt => throw _privateConstructorUsedError;
  FrequencyPatterns get frequencyPatterns => throw _privateConstructorUsedError;
  List<RecurringIssue> get recurringIssues =>
      throw _privateConstructorUsedError;
  Trends get trends => throw _privateConstructorUsedError;
  List<HighRiskArea> get highRiskAreas => throw _privateConstructorUsedError;
  List<String> get preventiveActions => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IncidentPatternsCopyWith<IncidentPatterns> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IncidentPatternsCopyWith<$Res> {
  factory $IncidentPatternsCopyWith(
          IncidentPatterns value, $Res Function(IncidentPatterns) then) =
      _$IncidentPatternsCopyWithImpl<$Res, IncidentPatterns>;
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
class _$IncidentPatternsCopyWithImpl<$Res, $Val extends IncidentPatterns>
    implements $IncidentPatternsCopyWith<$Res> {
  _$IncidentPatternsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      timeframe: null == timeframe
          ? _value.timeframe
          : timeframe // ignore: cast_nullable_to_non_nullable
              as String,
      analyzedAt: null == analyzedAt
          ? _value.analyzedAt
          : analyzedAt // ignore: cast_nullable_to_non_nullable
              as String,
      frequencyPatterns: null == frequencyPatterns
          ? _value.frequencyPatterns
          : frequencyPatterns // ignore: cast_nullable_to_non_nullable
              as FrequencyPatterns,
      recurringIssues: null == recurringIssues
          ? _value.recurringIssues
          : recurringIssues // ignore: cast_nullable_to_non_nullable
              as List<RecurringIssue>,
      trends: null == trends
          ? _value.trends
          : trends // ignore: cast_nullable_to_non_nullable
              as Trends,
      highRiskAreas: null == highRiskAreas
          ? _value.highRiskAreas
          : highRiskAreas // ignore: cast_nullable_to_non_nullable
              as List<HighRiskArea>,
      preventiveActions: null == preventiveActions
          ? _value.preventiveActions
          : preventiveActions // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FrequencyPatternsCopyWith<$Res> get frequencyPatterns {
    return $FrequencyPatternsCopyWith<$Res>(_value.frequencyPatterns, (value) {
      return _then(_value.copyWith(frequencyPatterns: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TrendsCopyWith<$Res> get trends {
    return $TrendsCopyWith<$Res>(_value.trends, (value) {
      return _then(_value.copyWith(trends: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$IncidentPatternsImplCopyWith<$Res>
    implements $IncidentPatternsCopyWith<$Res> {
  factory _$$IncidentPatternsImplCopyWith(_$IncidentPatternsImpl value,
          $Res Function(_$IncidentPatternsImpl) then) =
      __$$IncidentPatternsImplCopyWithImpl<$Res>;
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
class __$$IncidentPatternsImplCopyWithImpl<$Res>
    extends _$IncidentPatternsCopyWithImpl<$Res, _$IncidentPatternsImpl>
    implements _$$IncidentPatternsImplCopyWith<$Res> {
  __$$IncidentPatternsImplCopyWithImpl(_$IncidentPatternsImpl _value,
      $Res Function(_$IncidentPatternsImpl) _then)
      : super(_value, _then);

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
    return _then(_$IncidentPatternsImpl(
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      timeframe: null == timeframe
          ? _value.timeframe
          : timeframe // ignore: cast_nullable_to_non_nullable
              as String,
      analyzedAt: null == analyzedAt
          ? _value.analyzedAt
          : analyzedAt // ignore: cast_nullable_to_non_nullable
              as String,
      frequencyPatterns: null == frequencyPatterns
          ? _value.frequencyPatterns
          : frequencyPatterns // ignore: cast_nullable_to_non_nullable
              as FrequencyPatterns,
      recurringIssues: null == recurringIssues
          ? _value._recurringIssues
          : recurringIssues // ignore: cast_nullable_to_non_nullable
              as List<RecurringIssue>,
      trends: null == trends
          ? _value.trends
          : trends // ignore: cast_nullable_to_non_nullable
              as Trends,
      highRiskAreas: null == highRiskAreas
          ? _value._highRiskAreas
          : highRiskAreas // ignore: cast_nullable_to_non_nullable
              as List<HighRiskArea>,
      preventiveActions: null == preventiveActions
          ? _value._preventiveActions
          : preventiveActions // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IncidentPatternsImpl implements _IncidentPatterns {
  const _$IncidentPatternsImpl(
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

  factory _$IncidentPatternsImpl.fromJson(Map<String, dynamic> json) =>
      _$$IncidentPatternsImplFromJson(json);

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

  @override
  String toString() {
    return 'IncidentPatterns(organizationId: $organizationId, timeframe: $timeframe, analyzedAt: $analyzedAt, frequencyPatterns: $frequencyPatterns, recurringIssues: $recurringIssues, trends: $trends, highRiskAreas: $highRiskAreas, preventiveActions: $preventiveActions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IncidentPatternsImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IncidentPatternsImplCopyWith<_$IncidentPatternsImpl> get copyWith =>
      __$$IncidentPatternsImplCopyWithImpl<_$IncidentPatternsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IncidentPatternsImplToJson(
      this,
    );
  }
}

abstract class _IncidentPatterns implements IncidentPatterns {
  const factory _IncidentPatterns(
      {required final String organizationId,
      required final String timeframe,
      required final String analyzedAt,
      required final FrequencyPatterns frequencyPatterns,
      required final List<RecurringIssue> recurringIssues,
      required final Trends trends,
      required final List<HighRiskArea> highRiskAreas,
      required final List<String> preventiveActions}) = _$IncidentPatternsImpl;

  factory _IncidentPatterns.fromJson(Map<String, dynamic> json) =
      _$IncidentPatternsImpl.fromJson;

  @override
  String get organizationId;
  @override
  String get timeframe;
  @override
  String get analyzedAt;
  @override
  FrequencyPatterns get frequencyPatterns;
  @override
  List<RecurringIssue> get recurringIssues;
  @override
  Trends get trends;
  @override
  List<HighRiskArea> get highRiskAreas;
  @override
  List<String> get preventiveActions;
  @override
  @JsonKey(ignore: true)
  _$$IncidentPatternsImplCopyWith<_$IncidentPatternsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FrequencyPatterns _$FrequencyPatternsFromJson(Map<String, dynamic> json) {
  return _FrequencyPatterns.fromJson(json);
}

/// @nodoc
mixin _$FrequencyPatterns {
  Map<String, int> get byType => throw _privateConstructorUsedError;
  Map<String, int> get byLocation => throw _privateConstructorUsedError;
  Map<String, int> get byTimeOfDay => throw _privateConstructorUsedError;
  Map<String, int> get byDayOfWeek => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FrequencyPatternsCopyWith<FrequencyPatterns> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FrequencyPatternsCopyWith<$Res> {
  factory $FrequencyPatternsCopyWith(
          FrequencyPatterns value, $Res Function(FrequencyPatterns) then) =
      _$FrequencyPatternsCopyWithImpl<$Res, FrequencyPatterns>;
  @useResult
  $Res call(
      {Map<String, int> byType,
      Map<String, int> byLocation,
      Map<String, int> byTimeOfDay,
      Map<String, int> byDayOfWeek});
}

/// @nodoc
class _$FrequencyPatternsCopyWithImpl<$Res, $Val extends FrequencyPatterns>
    implements $FrequencyPatternsCopyWith<$Res> {
  _$FrequencyPatternsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? byType = null,
    Object? byLocation = null,
    Object? byTimeOfDay = null,
    Object? byDayOfWeek = null,
  }) {
    return _then(_value.copyWith(
      byType: null == byType
          ? _value.byType
          : byType // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      byLocation: null == byLocation
          ? _value.byLocation
          : byLocation // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      byTimeOfDay: null == byTimeOfDay
          ? _value.byTimeOfDay
          : byTimeOfDay // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      byDayOfWeek: null == byDayOfWeek
          ? _value.byDayOfWeek
          : byDayOfWeek // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FrequencyPatternsImplCopyWith<$Res>
    implements $FrequencyPatternsCopyWith<$Res> {
  factory _$$FrequencyPatternsImplCopyWith(_$FrequencyPatternsImpl value,
          $Res Function(_$FrequencyPatternsImpl) then) =
      __$$FrequencyPatternsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, int> byType,
      Map<String, int> byLocation,
      Map<String, int> byTimeOfDay,
      Map<String, int> byDayOfWeek});
}

/// @nodoc
class __$$FrequencyPatternsImplCopyWithImpl<$Res>
    extends _$FrequencyPatternsCopyWithImpl<$Res, _$FrequencyPatternsImpl>
    implements _$$FrequencyPatternsImplCopyWith<$Res> {
  __$$FrequencyPatternsImplCopyWithImpl(_$FrequencyPatternsImpl _value,
      $Res Function(_$FrequencyPatternsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? byType = null,
    Object? byLocation = null,
    Object? byTimeOfDay = null,
    Object? byDayOfWeek = null,
  }) {
    return _then(_$FrequencyPatternsImpl(
      byType: null == byType
          ? _value._byType
          : byType // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      byLocation: null == byLocation
          ? _value._byLocation
          : byLocation // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      byTimeOfDay: null == byTimeOfDay
          ? _value._byTimeOfDay
          : byTimeOfDay // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      byDayOfWeek: null == byDayOfWeek
          ? _value._byDayOfWeek
          : byDayOfWeek // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FrequencyPatternsImpl implements _FrequencyPatterns {
  const _$FrequencyPatternsImpl(
      {required final Map<String, int> byType,
      required final Map<String, int> byLocation,
      required final Map<String, int> byTimeOfDay,
      required final Map<String, int> byDayOfWeek})
      : _byType = byType,
        _byLocation = byLocation,
        _byTimeOfDay = byTimeOfDay,
        _byDayOfWeek = byDayOfWeek;

  factory _$FrequencyPatternsImpl.fromJson(Map<String, dynamic> json) =>
      _$$FrequencyPatternsImplFromJson(json);

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

  @override
  String toString() {
    return 'FrequencyPatterns(byType: $byType, byLocation: $byLocation, byTimeOfDay: $byTimeOfDay, byDayOfWeek: $byDayOfWeek)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FrequencyPatternsImpl &&
            const DeepCollectionEquality().equals(other._byType, _byType) &&
            const DeepCollectionEquality()
                .equals(other._byLocation, _byLocation) &&
            const DeepCollectionEquality()
                .equals(other._byTimeOfDay, _byTimeOfDay) &&
            const DeepCollectionEquality()
                .equals(other._byDayOfWeek, _byDayOfWeek));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_byType),
      const DeepCollectionEquality().hash(_byLocation),
      const DeepCollectionEquality().hash(_byTimeOfDay),
      const DeepCollectionEquality().hash(_byDayOfWeek));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FrequencyPatternsImplCopyWith<_$FrequencyPatternsImpl> get copyWith =>
      __$$FrequencyPatternsImplCopyWithImpl<_$FrequencyPatternsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FrequencyPatternsImplToJson(
      this,
    );
  }
}

abstract class _FrequencyPatterns implements FrequencyPatterns {
  const factory _FrequencyPatterns(
      {required final Map<String, int> byType,
      required final Map<String, int> byLocation,
      required final Map<String, int> byTimeOfDay,
      required final Map<String, int> byDayOfWeek}) = _$FrequencyPatternsImpl;

  factory _FrequencyPatterns.fromJson(Map<String, dynamic> json) =
      _$FrequencyPatternsImpl.fromJson;

  @override
  Map<String, int> get byType;
  @override
  Map<String, int> get byLocation;
  @override
  Map<String, int> get byTimeOfDay;
  @override
  Map<String, int> get byDayOfWeek;
  @override
  @JsonKey(ignore: true)
  _$$FrequencyPatternsImplCopyWith<_$FrequencyPatternsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RecurringIssue _$RecurringIssueFromJson(Map<String, dynamic> json) {
  return _RecurringIssue.fromJson(json);
}

/// @nodoc
mixin _$RecurringIssue {
  String get issue => throw _privateConstructorUsedError;
  int get frequency => throw _privateConstructorUsedError;
  String get trend => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecurringIssueCopyWith<RecurringIssue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecurringIssueCopyWith<$Res> {
  factory $RecurringIssueCopyWith(
          RecurringIssue value, $Res Function(RecurringIssue) then) =
      _$RecurringIssueCopyWithImpl<$Res, RecurringIssue>;
  @useResult
  $Res call({String issue, int frequency, String trend});
}

/// @nodoc
class _$RecurringIssueCopyWithImpl<$Res, $Val extends RecurringIssue>
    implements $RecurringIssueCopyWith<$Res> {
  _$RecurringIssueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? issue = null,
    Object? frequency = null,
    Object? trend = null,
  }) {
    return _then(_value.copyWith(
      issue: null == issue
          ? _value.issue
          : issue // ignore: cast_nullable_to_non_nullable
              as String,
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as int,
      trend: null == trend
          ? _value.trend
          : trend // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecurringIssueImplCopyWith<$Res>
    implements $RecurringIssueCopyWith<$Res> {
  factory _$$RecurringIssueImplCopyWith(_$RecurringIssueImpl value,
          $Res Function(_$RecurringIssueImpl) then) =
      __$$RecurringIssueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String issue, int frequency, String trend});
}

/// @nodoc
class __$$RecurringIssueImplCopyWithImpl<$Res>
    extends _$RecurringIssueCopyWithImpl<$Res, _$RecurringIssueImpl>
    implements _$$RecurringIssueImplCopyWith<$Res> {
  __$$RecurringIssueImplCopyWithImpl(
      _$RecurringIssueImpl _value, $Res Function(_$RecurringIssueImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? issue = null,
    Object? frequency = null,
    Object? trend = null,
  }) {
    return _then(_$RecurringIssueImpl(
      issue: null == issue
          ? _value.issue
          : issue // ignore: cast_nullable_to_non_nullable
              as String,
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as int,
      trend: null == trend
          ? _value.trend
          : trend // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecurringIssueImpl implements _RecurringIssue {
  const _$RecurringIssueImpl(
      {required this.issue, required this.frequency, required this.trend});

  factory _$RecurringIssueImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecurringIssueImplFromJson(json);

  @override
  final String issue;
  @override
  final int frequency;
  @override
  final String trend;

  @override
  String toString() {
    return 'RecurringIssue(issue: $issue, frequency: $frequency, trend: $trend)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecurringIssueImpl &&
            (identical(other.issue, issue) || other.issue == issue) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.trend, trend) || other.trend == trend));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, issue, frequency, trend);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecurringIssueImplCopyWith<_$RecurringIssueImpl> get copyWith =>
      __$$RecurringIssueImplCopyWithImpl<_$RecurringIssueImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecurringIssueImplToJson(
      this,
    );
  }
}

abstract class _RecurringIssue implements RecurringIssue {
  const factory _RecurringIssue(
      {required final String issue,
      required final int frequency,
      required final String trend}) = _$RecurringIssueImpl;

  factory _RecurringIssue.fromJson(Map<String, dynamic> json) =
      _$RecurringIssueImpl.fromJson;

  @override
  String get issue;
  @override
  int get frequency;
  @override
  String get trend;
  @override
  @JsonKey(ignore: true)
  _$$RecurringIssueImplCopyWith<_$RecurringIssueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Trends _$TrendsFromJson(Map<String, dynamic> json) {
  return _Trends.fromJson(json);
}

/// @nodoc
mixin _$Trends {
  String get direction => throw _privateConstructorUsedError;
  int get changePercentage => throw _privateConstructorUsedError;
  String get significance => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TrendsCopyWith<Trends> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrendsCopyWith<$Res> {
  factory $TrendsCopyWith(Trends value, $Res Function(Trends) then) =
      _$TrendsCopyWithImpl<$Res, Trends>;
  @useResult
  $Res call({String direction, int changePercentage, String significance});
}

/// @nodoc
class _$TrendsCopyWithImpl<$Res, $Val extends Trends>
    implements $TrendsCopyWith<$Res> {
  _$TrendsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? direction = null,
    Object? changePercentage = null,
    Object? significance = null,
  }) {
    return _then(_value.copyWith(
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as String,
      changePercentage: null == changePercentage
          ? _value.changePercentage
          : changePercentage // ignore: cast_nullable_to_non_nullable
              as int,
      significance: null == significance
          ? _value.significance
          : significance // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrendsImplCopyWith<$Res> implements $TrendsCopyWith<$Res> {
  factory _$$TrendsImplCopyWith(
          _$TrendsImpl value, $Res Function(_$TrendsImpl) then) =
      __$$TrendsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String direction, int changePercentage, String significance});
}

/// @nodoc
class __$$TrendsImplCopyWithImpl<$Res>
    extends _$TrendsCopyWithImpl<$Res, _$TrendsImpl>
    implements _$$TrendsImplCopyWith<$Res> {
  __$$TrendsImplCopyWithImpl(
      _$TrendsImpl _value, $Res Function(_$TrendsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? direction = null,
    Object? changePercentage = null,
    Object? significance = null,
  }) {
    return _then(_$TrendsImpl(
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as String,
      changePercentage: null == changePercentage
          ? _value.changePercentage
          : changePercentage // ignore: cast_nullable_to_non_nullable
              as int,
      significance: null == significance
          ? _value.significance
          : significance // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrendsImpl implements _Trends {
  const _$TrendsImpl(
      {required this.direction,
      required this.changePercentage,
      required this.significance});

  factory _$TrendsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrendsImplFromJson(json);

  @override
  final String direction;
  @override
  final int changePercentage;
  @override
  final String significance;

  @override
  String toString() {
    return 'Trends(direction: $direction, changePercentage: $changePercentage, significance: $significance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrendsImpl &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.changePercentage, changePercentage) ||
                other.changePercentage == changePercentage) &&
            (identical(other.significance, significance) ||
                other.significance == significance));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, direction, changePercentage, significance);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TrendsImplCopyWith<_$TrendsImpl> get copyWith =>
      __$$TrendsImplCopyWithImpl<_$TrendsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrendsImplToJson(
      this,
    );
  }
}

abstract class _Trends implements Trends {
  const factory _Trends(
      {required final String direction,
      required final int changePercentage,
      required final String significance}) = _$TrendsImpl;

  factory _Trends.fromJson(Map<String, dynamic> json) = _$TrendsImpl.fromJson;

  @override
  String get direction;
  @override
  int get changePercentage;
  @override
  String get significance;
  @override
  @JsonKey(ignore: true)
  _$$TrendsImplCopyWith<_$TrendsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HighRiskArea _$HighRiskAreaFromJson(Map<String, dynamic> json) {
  return _HighRiskArea.fromJson(json);
}

/// @nodoc
mixin _$HighRiskArea {
  String get area => throw _privateConstructorUsedError;
  String get riskLevel => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HighRiskAreaCopyWith<HighRiskArea> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HighRiskAreaCopyWith<$Res> {
  factory $HighRiskAreaCopyWith(
          HighRiskArea value, $Res Function(HighRiskArea) then) =
      _$HighRiskAreaCopyWithImpl<$Res, HighRiskArea>;
  @useResult
  $Res call({String area, String riskLevel});
}

/// @nodoc
class _$HighRiskAreaCopyWithImpl<$Res, $Val extends HighRiskArea>
    implements $HighRiskAreaCopyWith<$Res> {
  _$HighRiskAreaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? area = null,
    Object? riskLevel = null,
  }) {
    return _then(_value.copyWith(
      area: null == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as String,
      riskLevel: null == riskLevel
          ? _value.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HighRiskAreaImplCopyWith<$Res>
    implements $HighRiskAreaCopyWith<$Res> {
  factory _$$HighRiskAreaImplCopyWith(
          _$HighRiskAreaImpl value, $Res Function(_$HighRiskAreaImpl) then) =
      __$$HighRiskAreaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String area, String riskLevel});
}

/// @nodoc
class __$$HighRiskAreaImplCopyWithImpl<$Res>
    extends _$HighRiskAreaCopyWithImpl<$Res, _$HighRiskAreaImpl>
    implements _$$HighRiskAreaImplCopyWith<$Res> {
  __$$HighRiskAreaImplCopyWithImpl(
      _$HighRiskAreaImpl _value, $Res Function(_$HighRiskAreaImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? area = null,
    Object? riskLevel = null,
  }) {
    return _then(_$HighRiskAreaImpl(
      area: null == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as String,
      riskLevel: null == riskLevel
          ? _value.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HighRiskAreaImpl implements _HighRiskArea {
  const _$HighRiskAreaImpl({required this.area, required this.riskLevel});

  factory _$HighRiskAreaImpl.fromJson(Map<String, dynamic> json) =>
      _$$HighRiskAreaImplFromJson(json);

  @override
  final String area;
  @override
  final String riskLevel;

  @override
  String toString() {
    return 'HighRiskArea(area: $area, riskLevel: $riskLevel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HighRiskAreaImpl &&
            (identical(other.area, area) || other.area == area) &&
            (identical(other.riskLevel, riskLevel) ||
                other.riskLevel == riskLevel));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, area, riskLevel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HighRiskAreaImplCopyWith<_$HighRiskAreaImpl> get copyWith =>
      __$$HighRiskAreaImplCopyWithImpl<_$HighRiskAreaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HighRiskAreaImplToJson(
      this,
    );
  }
}

abstract class _HighRiskArea implements HighRiskArea {
  const factory _HighRiskArea(
      {required final String area,
      required final String riskLevel}) = _$HighRiskAreaImpl;

  factory _HighRiskArea.fromJson(Map<String, dynamic> json) =
      _$HighRiskAreaImpl.fromJson;

  @override
  String get area;
  @override
  String get riskLevel;
  @override
  @JsonKey(ignore: true)
  _$$HighRiskAreaImplCopyWith<_$HighRiskAreaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DrugInteraction _$DrugInteractionFromJson(Map<String, dynamic> json) {
  return _DrugInteraction.fromJson(json);
}

/// @nodoc
mixin _$DrugInteraction {
  List<String> get medications => throw _privateConstructorUsedError;
  String get severity => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get recommendation => throw _privateConstructorUsedError;
  List<String> get references => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DrugInteractionCopyWith<DrugInteraction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DrugInteractionCopyWith<$Res> {
  factory $DrugInteractionCopyWith(
          DrugInteraction value, $Res Function(DrugInteraction) then) =
      _$DrugInteractionCopyWithImpl<$Res, DrugInteraction>;
  @useResult
  $Res call(
      {List<String> medications,
      String severity,
      String description,
      String recommendation,
      List<String> references});
}

/// @nodoc
class _$DrugInteractionCopyWithImpl<$Res, $Val extends DrugInteraction>
    implements $DrugInteractionCopyWith<$Res> {
  _$DrugInteractionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? medications = null,
    Object? severity = null,
    Object? description = null,
    Object? recommendation = null,
    Object? references = null,
  }) {
    return _then(_value.copyWith(
      medications: null == medications
          ? _value.medications
          : medications // ignore: cast_nullable_to_non_nullable
              as List<String>,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      recommendation: null == recommendation
          ? _value.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as String,
      references: null == references
          ? _value.references
          : references // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DrugInteractionImplCopyWith<$Res>
    implements $DrugInteractionCopyWith<$Res> {
  factory _$$DrugInteractionImplCopyWith(_$DrugInteractionImpl value,
          $Res Function(_$DrugInteractionImpl) then) =
      __$$DrugInteractionImplCopyWithImpl<$Res>;
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
class __$$DrugInteractionImplCopyWithImpl<$Res>
    extends _$DrugInteractionCopyWithImpl<$Res, _$DrugInteractionImpl>
    implements _$$DrugInteractionImplCopyWith<$Res> {
  __$$DrugInteractionImplCopyWithImpl(
      _$DrugInteractionImpl _value, $Res Function(_$DrugInteractionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? medications = null,
    Object? severity = null,
    Object? description = null,
    Object? recommendation = null,
    Object? references = null,
  }) {
    return _then(_$DrugInteractionImpl(
      medications: null == medications
          ? _value._medications
          : medications // ignore: cast_nullable_to_non_nullable
              as List<String>,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      recommendation: null == recommendation
          ? _value.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as String,
      references: null == references
          ? _value._references
          : references // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DrugInteractionImpl implements _DrugInteraction {
  const _$DrugInteractionImpl(
      {required final List<String> medications,
      required this.severity,
      required this.description,
      required this.recommendation,
      required final List<String> references})
      : _medications = medications,
        _references = references;

  factory _$DrugInteractionImpl.fromJson(Map<String, dynamic> json) =>
      _$$DrugInteractionImplFromJson(json);

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

  @override
  String toString() {
    return 'DrugInteraction(medications: $medications, severity: $severity, description: $description, recommendation: $recommendation, references: $references)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DrugInteractionImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_medications),
      severity,
      description,
      recommendation,
      const DeepCollectionEquality().hash(_references));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DrugInteractionImplCopyWith<_$DrugInteractionImpl> get copyWith =>
      __$$DrugInteractionImplCopyWithImpl<_$DrugInteractionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DrugInteractionImplToJson(
      this,
    );
  }
}

abstract class _DrugInteraction implements DrugInteraction {
  const factory _DrugInteraction(
      {required final List<String> medications,
      required final String severity,
      required final String description,
      required final String recommendation,
      required final List<String> references}) = _$DrugInteractionImpl;

  factory _DrugInteraction.fromJson(Map<String, dynamic> json) =
      _$DrugInteractionImpl.fromJson;

  @override
  List<String> get medications;
  @override
  String get severity;
  @override
  String get description;
  @override
  String get recommendation;
  @override
  List<String> get references;
  @override
  @JsonKey(ignore: true)
  _$$DrugInteractionImplCopyWith<_$DrugInteractionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MedicationCompliance _$MedicationComplianceFromJson(Map<String, dynamic> json) {
  return _MedicationCompliance.fromJson(json);
}

/// @nodoc
mixin _$MedicationCompliance {
  String get clientId => throw _privateConstructorUsedError;
  String get period => throw _privateConstructorUsedError;
  String get analyzedAt => throw _privateConstructorUsedError;
  double get overallCompliance => throw _privateConstructorUsedError;
  List<MedicationComplianceDetail> get byMedication =>
      throw _privateConstructorUsedError;
  CompliancePatterns get patterns => throw _privateConstructorUsedError;
  ComplianceRiskAssessment get riskAssessment =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MedicationComplianceCopyWith<MedicationCompliance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MedicationComplianceCopyWith<$Res> {
  factory $MedicationComplianceCopyWith(MedicationCompliance value,
          $Res Function(MedicationCompliance) then) =
      _$MedicationComplianceCopyWithImpl<$Res, MedicationCompliance>;
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
class _$MedicationComplianceCopyWithImpl<$Res,
        $Val extends MedicationCompliance>
    implements $MedicationComplianceCopyWith<$Res> {
  _$MedicationComplianceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      analyzedAt: null == analyzedAt
          ? _value.analyzedAt
          : analyzedAt // ignore: cast_nullable_to_non_nullable
              as String,
      overallCompliance: null == overallCompliance
          ? _value.overallCompliance
          : overallCompliance // ignore: cast_nullable_to_non_nullable
              as double,
      byMedication: null == byMedication
          ? _value.byMedication
          : byMedication // ignore: cast_nullable_to_non_nullable
              as List<MedicationComplianceDetail>,
      patterns: null == patterns
          ? _value.patterns
          : patterns // ignore: cast_nullable_to_non_nullable
              as CompliancePatterns,
      riskAssessment: null == riskAssessment
          ? _value.riskAssessment
          : riskAssessment // ignore: cast_nullable_to_non_nullable
              as ComplianceRiskAssessment,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CompliancePatternsCopyWith<$Res> get patterns {
    return $CompliancePatternsCopyWith<$Res>(_value.patterns, (value) {
      return _then(_value.copyWith(patterns: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ComplianceRiskAssessmentCopyWith<$Res> get riskAssessment {
    return $ComplianceRiskAssessmentCopyWith<$Res>(_value.riskAssessment,
        (value) {
      return _then(_value.copyWith(riskAssessment: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MedicationComplianceImplCopyWith<$Res>
    implements $MedicationComplianceCopyWith<$Res> {
  factory _$$MedicationComplianceImplCopyWith(_$MedicationComplianceImpl value,
          $Res Function(_$MedicationComplianceImpl) then) =
      __$$MedicationComplianceImplCopyWithImpl<$Res>;
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
class __$$MedicationComplianceImplCopyWithImpl<$Res>
    extends _$MedicationComplianceCopyWithImpl<$Res, _$MedicationComplianceImpl>
    implements _$$MedicationComplianceImplCopyWith<$Res> {
  __$$MedicationComplianceImplCopyWithImpl(_$MedicationComplianceImpl _value,
      $Res Function(_$MedicationComplianceImpl) _then)
      : super(_value, _then);

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
    return _then(_$MedicationComplianceImpl(
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      analyzedAt: null == analyzedAt
          ? _value.analyzedAt
          : analyzedAt // ignore: cast_nullable_to_non_nullable
              as String,
      overallCompliance: null == overallCompliance
          ? _value.overallCompliance
          : overallCompliance // ignore: cast_nullable_to_non_nullable
              as double,
      byMedication: null == byMedication
          ? _value._byMedication
          : byMedication // ignore: cast_nullable_to_non_nullable
              as List<MedicationComplianceDetail>,
      patterns: null == patterns
          ? _value.patterns
          : patterns // ignore: cast_nullable_to_non_nullable
              as CompliancePatterns,
      riskAssessment: null == riskAssessment
          ? _value.riskAssessment
          : riskAssessment // ignore: cast_nullable_to_non_nullable
              as ComplianceRiskAssessment,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MedicationComplianceImpl implements _MedicationCompliance {
  const _$MedicationComplianceImpl(
      {required this.clientId,
      required this.period,
      required this.analyzedAt,
      required this.overallCompliance,
      required final List<MedicationComplianceDetail> byMedication,
      required this.patterns,
      required this.riskAssessment})
      : _byMedication = byMedication;

  factory _$MedicationComplianceImpl.fromJson(Map<String, dynamic> json) =>
      _$$MedicationComplianceImplFromJson(json);

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

  @override
  String toString() {
    return 'MedicationCompliance(clientId: $clientId, period: $period, analyzedAt: $analyzedAt, overallCompliance: $overallCompliance, byMedication: $byMedication, patterns: $patterns, riskAssessment: $riskAssessment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MedicationComplianceImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MedicationComplianceImplCopyWith<_$MedicationComplianceImpl>
      get copyWith =>
          __$$MedicationComplianceImplCopyWithImpl<_$MedicationComplianceImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MedicationComplianceImplToJson(
      this,
    );
  }
}

abstract class _MedicationCompliance implements MedicationCompliance {
  const factory _MedicationCompliance(
          {required final String clientId,
          required final String period,
          required final String analyzedAt,
          required final double overallCompliance,
          required final List<MedicationComplianceDetail> byMedication,
          required final CompliancePatterns patterns,
          required final ComplianceRiskAssessment riskAssessment}) =
      _$MedicationComplianceImpl;

  factory _MedicationCompliance.fromJson(Map<String, dynamic> json) =
      _$MedicationComplianceImpl.fromJson;

  @override
  String get clientId;
  @override
  String get period;
  @override
  String get analyzedAt;
  @override
  double get overallCompliance;
  @override
  List<MedicationComplianceDetail> get byMedication;
  @override
  CompliancePatterns get patterns;
  @override
  ComplianceRiskAssessment get riskAssessment;
  @override
  @JsonKey(ignore: true)
  _$$MedicationComplianceImplCopyWith<_$MedicationComplianceImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MedicationComplianceDetail _$MedicationComplianceDetailFromJson(
    Map<String, dynamic> json) {
  return _MedicationComplianceDetail.fromJson(json);
}

/// @nodoc
mixin _$MedicationComplianceDetail {
  String get medication => throw _privateConstructorUsedError;
  int get prescribed => throw _privateConstructorUsedError;
  int get administered => throw _privateConstructorUsedError;
  int get missed => throw _privateConstructorUsedError;
  double get compliance => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MedicationComplianceDetailCopyWith<MedicationComplianceDetail>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MedicationComplianceDetailCopyWith<$Res> {
  factory $MedicationComplianceDetailCopyWith(MedicationComplianceDetail value,
          $Res Function(MedicationComplianceDetail) then) =
      _$MedicationComplianceDetailCopyWithImpl<$Res,
          MedicationComplianceDetail>;
  @useResult
  $Res call(
      {String medication,
      int prescribed,
      int administered,
      int missed,
      double compliance});
}

/// @nodoc
class _$MedicationComplianceDetailCopyWithImpl<$Res,
        $Val extends MedicationComplianceDetail>
    implements $MedicationComplianceDetailCopyWith<$Res> {
  _$MedicationComplianceDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? medication = null,
    Object? prescribed = null,
    Object? administered = null,
    Object? missed = null,
    Object? compliance = null,
  }) {
    return _then(_value.copyWith(
      medication: null == medication
          ? _value.medication
          : medication // ignore: cast_nullable_to_non_nullable
              as String,
      prescribed: null == prescribed
          ? _value.prescribed
          : prescribed // ignore: cast_nullable_to_non_nullable
              as int,
      administered: null == administered
          ? _value.administered
          : administered // ignore: cast_nullable_to_non_nullable
              as int,
      missed: null == missed
          ? _value.missed
          : missed // ignore: cast_nullable_to_non_nullable
              as int,
      compliance: null == compliance
          ? _value.compliance
          : compliance // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MedicationComplianceDetailImplCopyWith<$Res>
    implements $MedicationComplianceDetailCopyWith<$Res> {
  factory _$$MedicationComplianceDetailImplCopyWith(
          _$MedicationComplianceDetailImpl value,
          $Res Function(_$MedicationComplianceDetailImpl) then) =
      __$$MedicationComplianceDetailImplCopyWithImpl<$Res>;
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
class __$$MedicationComplianceDetailImplCopyWithImpl<$Res>
    extends _$MedicationComplianceDetailCopyWithImpl<$Res,
        _$MedicationComplianceDetailImpl>
    implements _$$MedicationComplianceDetailImplCopyWith<$Res> {
  __$$MedicationComplianceDetailImplCopyWithImpl(
      _$MedicationComplianceDetailImpl _value,
      $Res Function(_$MedicationComplianceDetailImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? medication = null,
    Object? prescribed = null,
    Object? administered = null,
    Object? missed = null,
    Object? compliance = null,
  }) {
    return _then(_$MedicationComplianceDetailImpl(
      medication: null == medication
          ? _value.medication
          : medication // ignore: cast_nullable_to_non_nullable
              as String,
      prescribed: null == prescribed
          ? _value.prescribed
          : prescribed // ignore: cast_nullable_to_non_nullable
              as int,
      administered: null == administered
          ? _value.administered
          : administered // ignore: cast_nullable_to_non_nullable
              as int,
      missed: null == missed
          ? _value.missed
          : missed // ignore: cast_nullable_to_non_nullable
              as int,
      compliance: null == compliance
          ? _value.compliance
          : compliance // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MedicationComplianceDetailImpl implements _MedicationComplianceDetail {
  const _$MedicationComplianceDetailImpl(
      {required this.medication,
      required this.prescribed,
      required this.administered,
      required this.missed,
      required this.compliance});

  factory _$MedicationComplianceDetailImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$MedicationComplianceDetailImplFromJson(json);

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

  @override
  String toString() {
    return 'MedicationComplianceDetail(medication: $medication, prescribed: $prescribed, administered: $administered, missed: $missed, compliance: $compliance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MedicationComplianceDetailImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, medication, prescribed, administered, missed, compliance);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MedicationComplianceDetailImplCopyWith<_$MedicationComplianceDetailImpl>
      get copyWith => __$$MedicationComplianceDetailImplCopyWithImpl<
          _$MedicationComplianceDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MedicationComplianceDetailImplToJson(
      this,
    );
  }
}

abstract class _MedicationComplianceDetail
    implements MedicationComplianceDetail {
  const factory _MedicationComplianceDetail(
      {required final String medication,
      required final int prescribed,
      required final int administered,
      required final int missed,
      required final double compliance}) = _$MedicationComplianceDetailImpl;

  factory _MedicationComplianceDetail.fromJson(Map<String, dynamic> json) =
      _$MedicationComplianceDetailImpl.fromJson;

  @override
  String get medication;
  @override
  int get prescribed;
  @override
  int get administered;
  @override
  int get missed;
  @override
  double get compliance;
  @override
  @JsonKey(ignore: true)
  _$$MedicationComplianceDetailImplCopyWith<_$MedicationComplianceDetailImpl>
      get copyWith => throw _privateConstructorUsedError;
}

CompliancePatterns _$CompliancePatternsFromJson(Map<String, dynamic> json) {
  return _CompliancePatterns.fromJson(json);
}

/// @nodoc
mixin _$CompliancePatterns {
  MissedDoses get missedDoses => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CompliancePatternsCopyWith<CompliancePatterns> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompliancePatternsCopyWith<$Res> {
  factory $CompliancePatternsCopyWith(
          CompliancePatterns value, $Res Function(CompliancePatterns) then) =
      _$CompliancePatternsCopyWithImpl<$Res, CompliancePatterns>;
  @useResult
  $Res call({MissedDoses missedDoses});

  $MissedDosesCopyWith<$Res> get missedDoses;
}

/// @nodoc
class _$CompliancePatternsCopyWithImpl<$Res, $Val extends CompliancePatterns>
    implements $CompliancePatternsCopyWith<$Res> {
  _$CompliancePatternsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? missedDoses = null,
  }) {
    return _then(_value.copyWith(
      missedDoses: null == missedDoses
          ? _value.missedDoses
          : missedDoses // ignore: cast_nullable_to_non_nullable
              as MissedDoses,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MissedDosesCopyWith<$Res> get missedDoses {
    return $MissedDosesCopyWith<$Res>(_value.missedDoses, (value) {
      return _then(_value.copyWith(missedDoses: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CompliancePatternsImplCopyWith<$Res>
    implements $CompliancePatternsCopyWith<$Res> {
  factory _$$CompliancePatternsImplCopyWith(_$CompliancePatternsImpl value,
          $Res Function(_$CompliancePatternsImpl) then) =
      __$$CompliancePatternsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({MissedDoses missedDoses});

  @override
  $MissedDosesCopyWith<$Res> get missedDoses;
}

/// @nodoc
class __$$CompliancePatternsImplCopyWithImpl<$Res>
    extends _$CompliancePatternsCopyWithImpl<$Res, _$CompliancePatternsImpl>
    implements _$$CompliancePatternsImplCopyWith<$Res> {
  __$$CompliancePatternsImplCopyWithImpl(_$CompliancePatternsImpl _value,
      $Res Function(_$CompliancePatternsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? missedDoses = null,
  }) {
    return _then(_$CompliancePatternsImpl(
      missedDoses: null == missedDoses
          ? _value.missedDoses
          : missedDoses // ignore: cast_nullable_to_non_nullable
              as MissedDoses,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CompliancePatternsImpl implements _CompliancePatterns {
  const _$CompliancePatternsImpl({required this.missedDoses});

  factory _$CompliancePatternsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompliancePatternsImplFromJson(json);

  @override
  final MissedDoses missedDoses;

  @override
  String toString() {
    return 'CompliancePatterns(missedDoses: $missedDoses)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompliancePatternsImpl &&
            (identical(other.missedDoses, missedDoses) ||
                other.missedDoses == missedDoses));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, missedDoses);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CompliancePatternsImplCopyWith<_$CompliancePatternsImpl> get copyWith =>
      __$$CompliancePatternsImplCopyWithImpl<_$CompliancePatternsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompliancePatternsImplToJson(
      this,
    );
  }
}

abstract class _CompliancePatterns implements CompliancePatterns {
  const factory _CompliancePatterns({required final MissedDoses missedDoses}) =
      _$CompliancePatternsImpl;

  factory _CompliancePatterns.fromJson(Map<String, dynamic> json) =
      _$CompliancePatternsImpl.fromJson;

  @override
  MissedDoses get missedDoses;
  @override
  @JsonKey(ignore: true)
  _$$CompliancePatternsImplCopyWith<_$CompliancePatternsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MissedDoses _$MissedDosesFromJson(Map<String, dynamic> json) {
  return _MissedDoses.fromJson(json);
}

/// @nodoc
mixin _$MissedDoses {
  List<String> get timeOfDay => throw _privateConstructorUsedError;
  List<String> get dayOfWeek => throw _privateConstructorUsedError;
  List<String> get reasons => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MissedDosesCopyWith<MissedDoses> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MissedDosesCopyWith<$Res> {
  factory $MissedDosesCopyWith(
          MissedDoses value, $Res Function(MissedDoses) then) =
      _$MissedDosesCopyWithImpl<$Res, MissedDoses>;
  @useResult
  $Res call(
      {List<String> timeOfDay, List<String> dayOfWeek, List<String> reasons});
}

/// @nodoc
class _$MissedDosesCopyWithImpl<$Res, $Val extends MissedDoses>
    implements $MissedDosesCopyWith<$Res> {
  _$MissedDosesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timeOfDay = null,
    Object? dayOfWeek = null,
    Object? reasons = null,
  }) {
    return _then(_value.copyWith(
      timeOfDay: null == timeOfDay
          ? _value.timeOfDay
          : timeOfDay // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dayOfWeek: null == dayOfWeek
          ? _value.dayOfWeek
          : dayOfWeek // ignore: cast_nullable_to_non_nullable
              as List<String>,
      reasons: null == reasons
          ? _value.reasons
          : reasons // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MissedDosesImplCopyWith<$Res>
    implements $MissedDosesCopyWith<$Res> {
  factory _$$MissedDosesImplCopyWith(
          _$MissedDosesImpl value, $Res Function(_$MissedDosesImpl) then) =
      __$$MissedDosesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> timeOfDay, List<String> dayOfWeek, List<String> reasons});
}

/// @nodoc
class __$$MissedDosesImplCopyWithImpl<$Res>
    extends _$MissedDosesCopyWithImpl<$Res, _$MissedDosesImpl>
    implements _$$MissedDosesImplCopyWith<$Res> {
  __$$MissedDosesImplCopyWithImpl(
      _$MissedDosesImpl _value, $Res Function(_$MissedDosesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timeOfDay = null,
    Object? dayOfWeek = null,
    Object? reasons = null,
  }) {
    return _then(_$MissedDosesImpl(
      timeOfDay: null == timeOfDay
          ? _value._timeOfDay
          : timeOfDay // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dayOfWeek: null == dayOfWeek
          ? _value._dayOfWeek
          : dayOfWeek // ignore: cast_nullable_to_non_nullable
              as List<String>,
      reasons: null == reasons
          ? _value._reasons
          : reasons // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MissedDosesImpl implements _MissedDoses {
  const _$MissedDosesImpl(
      {required final List<String> timeOfDay,
      required final List<String> dayOfWeek,
      required final List<String> reasons})
      : _timeOfDay = timeOfDay,
        _dayOfWeek = dayOfWeek,
        _reasons = reasons;

  factory _$MissedDosesImpl.fromJson(Map<String, dynamic> json) =>
      _$$MissedDosesImplFromJson(json);

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

  @override
  String toString() {
    return 'MissedDoses(timeOfDay: $timeOfDay, dayOfWeek: $dayOfWeek, reasons: $reasons)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MissedDosesImpl &&
            const DeepCollectionEquality()
                .equals(other._timeOfDay, _timeOfDay) &&
            const DeepCollectionEquality()
                .equals(other._dayOfWeek, _dayOfWeek) &&
            const DeepCollectionEquality().equals(other._reasons, _reasons));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_timeOfDay),
      const DeepCollectionEquality().hash(_dayOfWeek),
      const DeepCollectionEquality().hash(_reasons));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MissedDosesImplCopyWith<_$MissedDosesImpl> get copyWith =>
      __$$MissedDosesImplCopyWithImpl<_$MissedDosesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MissedDosesImplToJson(
      this,
    );
  }
}

abstract class _MissedDoses implements MissedDoses {
  const factory _MissedDoses(
      {required final List<String> timeOfDay,
      required final List<String> dayOfWeek,
      required final List<String> reasons}) = _$MissedDosesImpl;

  factory _MissedDoses.fromJson(Map<String, dynamic> json) =
      _$MissedDosesImpl.fromJson;

  @override
  List<String> get timeOfDay;
  @override
  List<String> get dayOfWeek;
  @override
  List<String> get reasons;
  @override
  @JsonKey(ignore: true)
  _$$MissedDosesImplCopyWith<_$MissedDosesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ComplianceRiskAssessment _$ComplianceRiskAssessmentFromJson(
    Map<String, dynamic> json) {
  return _ComplianceRiskAssessment.fromJson(json);
}

/// @nodoc
mixin _$ComplianceRiskAssessment {
  double get nonComplianceRisk => throw _privateConstructorUsedError;
  List<String> get factors => throw _privateConstructorUsedError;
  List<String> get recommendations => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ComplianceRiskAssessmentCopyWith<ComplianceRiskAssessment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComplianceRiskAssessmentCopyWith<$Res> {
  factory $ComplianceRiskAssessmentCopyWith(ComplianceRiskAssessment value,
          $Res Function(ComplianceRiskAssessment) then) =
      _$ComplianceRiskAssessmentCopyWithImpl<$Res, ComplianceRiskAssessment>;
  @useResult
  $Res call(
      {double nonComplianceRisk,
      List<String> factors,
      List<String> recommendations});
}

/// @nodoc
class _$ComplianceRiskAssessmentCopyWithImpl<$Res,
        $Val extends ComplianceRiskAssessment>
    implements $ComplianceRiskAssessmentCopyWith<$Res> {
  _$ComplianceRiskAssessmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nonComplianceRisk = null,
    Object? factors = null,
    Object? recommendations = null,
  }) {
    return _then(_value.copyWith(
      nonComplianceRisk: null == nonComplianceRisk
          ? _value.nonComplianceRisk
          : nonComplianceRisk // ignore: cast_nullable_to_non_nullable
              as double,
      factors: null == factors
          ? _value.factors
          : factors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recommendations: null == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ComplianceRiskAssessmentImplCopyWith<$Res>
    implements $ComplianceRiskAssessmentCopyWith<$Res> {
  factory _$$ComplianceRiskAssessmentImplCopyWith(
          _$ComplianceRiskAssessmentImpl value,
          $Res Function(_$ComplianceRiskAssessmentImpl) then) =
      __$$ComplianceRiskAssessmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double nonComplianceRisk,
      List<String> factors,
      List<String> recommendations});
}

/// @nodoc
class __$$ComplianceRiskAssessmentImplCopyWithImpl<$Res>
    extends _$ComplianceRiskAssessmentCopyWithImpl<$Res,
        _$ComplianceRiskAssessmentImpl>
    implements _$$ComplianceRiskAssessmentImplCopyWith<$Res> {
  __$$ComplianceRiskAssessmentImplCopyWithImpl(
      _$ComplianceRiskAssessmentImpl _value,
      $Res Function(_$ComplianceRiskAssessmentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nonComplianceRisk = null,
    Object? factors = null,
    Object? recommendations = null,
  }) {
    return _then(_$ComplianceRiskAssessmentImpl(
      nonComplianceRisk: null == nonComplianceRisk
          ? _value.nonComplianceRisk
          : nonComplianceRisk // ignore: cast_nullable_to_non_nullable
              as double,
      factors: null == factors
          ? _value._factors
          : factors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recommendations: null == recommendations
          ? _value._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ComplianceRiskAssessmentImpl implements _ComplianceRiskAssessment {
  const _$ComplianceRiskAssessmentImpl(
      {required this.nonComplianceRisk,
      required final List<String> factors,
      required final List<String> recommendations})
      : _factors = factors,
        _recommendations = recommendations;

  factory _$ComplianceRiskAssessmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$ComplianceRiskAssessmentImplFromJson(json);

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

  @override
  String toString() {
    return 'ComplianceRiskAssessment(nonComplianceRisk: $nonComplianceRisk, factors: $factors, recommendations: $recommendations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComplianceRiskAssessmentImpl &&
            (identical(other.nonComplianceRisk, nonComplianceRisk) ||
                other.nonComplianceRisk == nonComplianceRisk) &&
            const DeepCollectionEquality().equals(other._factors, _factors) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      nonComplianceRisk,
      const DeepCollectionEquality().hash(_factors),
      const DeepCollectionEquality().hash(_recommendations));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ComplianceRiskAssessmentImplCopyWith<_$ComplianceRiskAssessmentImpl>
      get copyWith => __$$ComplianceRiskAssessmentImplCopyWithImpl<
          _$ComplianceRiskAssessmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ComplianceRiskAssessmentImplToJson(
      this,
    );
  }
}

abstract class _ComplianceRiskAssessment implements ComplianceRiskAssessment {
  const factory _ComplianceRiskAssessment(
          {required final double nonComplianceRisk,
          required final List<String> factors,
          required final List<String> recommendations}) =
      _$ComplianceRiskAssessmentImpl;

  factory _ComplianceRiskAssessment.fromJson(Map<String, dynamic> json) =
      _$ComplianceRiskAssessmentImpl.fromJson;

  @override
  double get nonComplianceRisk;
  @override
  List<String> get factors;
  @override
  List<String> get recommendations;
  @override
  @JsonKey(ignore: true)
  _$$ComplianceRiskAssessmentImplCopyWith<_$ComplianceRiskAssessmentImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MedicationAlert _$MedicationAlertFromJson(Map<String, dynamic> json) {
  return _MedicationAlert.fromJson(json);
}

/// @nodoc
mixin _$MedicationAlert {
  String get type => throw _privateConstructorUsedError;
  String get severity => throw _privateConstructorUsedError;
  String? get medication => throw _privateConstructorUsedError;
  List<String>? get medications => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get action => throw _privateConstructorUsedError;
  String? get dueDate => throw _privateConstructorUsedError;
  String? get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MedicationAlertCopyWith<MedicationAlert> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MedicationAlertCopyWith<$Res> {
  factory $MedicationAlertCopyWith(
          MedicationAlert value, $Res Function(MedicationAlert) then) =
      _$MedicationAlertCopyWithImpl<$Res, MedicationAlert>;
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
class _$MedicationAlertCopyWithImpl<$Res, $Val extends MedicationAlert>
    implements $MedicationAlertCopyWith<$Res> {
  _$MedicationAlertCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
      medication: freezed == medication
          ? _value.medication
          : medication // ignore: cast_nullable_to_non_nullable
              as String?,
      medications: freezed == medications
          ? _value.medications
          : medications // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MedicationAlertImplCopyWith<$Res>
    implements $MedicationAlertCopyWith<$Res> {
  factory _$$MedicationAlertImplCopyWith(_$MedicationAlertImpl value,
          $Res Function(_$MedicationAlertImpl) then) =
      __$$MedicationAlertImplCopyWithImpl<$Res>;
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
class __$$MedicationAlertImplCopyWithImpl<$Res>
    extends _$MedicationAlertCopyWithImpl<$Res, _$MedicationAlertImpl>
    implements _$$MedicationAlertImplCopyWith<$Res> {
  __$$MedicationAlertImplCopyWithImpl(
      _$MedicationAlertImpl _value, $Res Function(_$MedicationAlertImpl) _then)
      : super(_value, _then);

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
    return _then(_$MedicationAlertImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
      medication: freezed == medication
          ? _value.medication
          : medication // ignore: cast_nullable_to_non_nullable
              as String?,
      medications: freezed == medications
          ? _value._medications
          : medications // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MedicationAlertImpl implements _MedicationAlert {
  const _$MedicationAlertImpl(
      {required this.type,
      required this.severity,
      this.medication,
      final List<String>? medications,
      required this.message,
      required this.action,
      this.dueDate,
      this.timestamp})
      : _medications = medications;

  factory _$MedicationAlertImpl.fromJson(Map<String, dynamic> json) =>
      _$$MedicationAlertImplFromJson(json);

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

  @override
  String toString() {
    return 'MedicationAlert(type: $type, severity: $severity, medication: $medication, medications: $medications, message: $message, action: $action, dueDate: $dueDate, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MedicationAlertImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MedicationAlertImplCopyWith<_$MedicationAlertImpl> get copyWith =>
      __$$MedicationAlertImplCopyWithImpl<_$MedicationAlertImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MedicationAlertImplToJson(
      this,
    );
  }
}

abstract class _MedicationAlert implements MedicationAlert {
  const factory _MedicationAlert(
      {required final String type,
      required final String severity,
      final String? medication,
      final List<String>? medications,
      required final String message,
      required final String action,
      final String? dueDate,
      final String? timestamp}) = _$MedicationAlertImpl;

  factory _MedicationAlert.fromJson(Map<String, dynamic> json) =
      _$MedicationAlertImpl.fromJson;

  @override
  String get type;
  @override
  String get severity;
  @override
  String? get medication;
  @override
  List<String>? get medications;
  @override
  String get message;
  @override
  String get action;
  @override
  String? get dueDate;
  @override
  String? get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$MedicationAlertImplCopyWith<_$MedicationAlertImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
