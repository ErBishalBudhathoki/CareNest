// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'compliance_automation_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ComplianceScan _$ComplianceScanFromJson(Map<String, dynamic> json) {
  return _ComplianceScan.fromJson(json);
}

/// @nodoc
mixin _$ComplianceScan {
  String get organizationId => throw _privateConstructorUsedError;
  String get scanDate => throw _privateConstructorUsedError;
  ComplianceScore get complianceScore => throw _privateConstructorUsedError;
  List<ComplianceIssue> get issues => throw _privateConstructorUsedError;
  List<ComplianceIssue> get warnings => throw _privateConstructorUsedError;
  ComplianceSummary get summary => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ComplianceScanCopyWith<ComplianceScan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComplianceScanCopyWith<$Res> {
  factory $ComplianceScanCopyWith(
          ComplianceScan value, $Res Function(ComplianceScan) then) =
      _$ComplianceScanCopyWithImpl<$Res, ComplianceScan>;
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
class _$ComplianceScanCopyWithImpl<$Res, $Val extends ComplianceScan>
    implements $ComplianceScanCopyWith<$Res> {
  _$ComplianceScanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      scanDate: null == scanDate
          ? _value.scanDate
          : scanDate // ignore: cast_nullable_to_non_nullable
              as String,
      complianceScore: null == complianceScore
          ? _value.complianceScore
          : complianceScore // ignore: cast_nullable_to_non_nullable
              as ComplianceScore,
      issues: null == issues
          ? _value.issues
          : issues // ignore: cast_nullable_to_non_nullable
              as List<ComplianceIssue>,
      warnings: null == warnings
          ? _value.warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<ComplianceIssue>,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as ComplianceSummary,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ComplianceScoreCopyWith<$Res> get complianceScore {
    return $ComplianceScoreCopyWith<$Res>(_value.complianceScore, (value) {
      return _then(_value.copyWith(complianceScore: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ComplianceSummaryCopyWith<$Res> get summary {
    return $ComplianceSummaryCopyWith<$Res>(_value.summary, (value) {
      return _then(_value.copyWith(summary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ComplianceScanImplCopyWith<$Res>
    implements $ComplianceScanCopyWith<$Res> {
  factory _$$ComplianceScanImplCopyWith(_$ComplianceScanImpl value,
          $Res Function(_$ComplianceScanImpl) then) =
      __$$ComplianceScanImplCopyWithImpl<$Res>;
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
class __$$ComplianceScanImplCopyWithImpl<$Res>
    extends _$ComplianceScanCopyWithImpl<$Res, _$ComplianceScanImpl>
    implements _$$ComplianceScanImplCopyWith<$Res> {
  __$$ComplianceScanImplCopyWithImpl(
      _$ComplianceScanImpl _value, $Res Function(_$ComplianceScanImpl) _then)
      : super(_value, _then);

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
    return _then(_$ComplianceScanImpl(
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      scanDate: null == scanDate
          ? _value.scanDate
          : scanDate // ignore: cast_nullable_to_non_nullable
              as String,
      complianceScore: null == complianceScore
          ? _value.complianceScore
          : complianceScore // ignore: cast_nullable_to_non_nullable
              as ComplianceScore,
      issues: null == issues
          ? _value._issues
          : issues // ignore: cast_nullable_to_non_nullable
              as List<ComplianceIssue>,
      warnings: null == warnings
          ? _value._warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<ComplianceIssue>,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as ComplianceSummary,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ComplianceScanImpl implements _ComplianceScan {
  const _$ComplianceScanImpl(
      {required this.organizationId,
      required this.scanDate,
      required this.complianceScore,
      required final List<ComplianceIssue> issues,
      required final List<ComplianceIssue> warnings,
      required this.summary})
      : _issues = issues,
        _warnings = warnings;

  factory _$ComplianceScanImpl.fromJson(Map<String, dynamic> json) =>
      _$$ComplianceScanImplFromJson(json);

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

  @override
  String toString() {
    return 'ComplianceScan(organizationId: $organizationId, scanDate: $scanDate, complianceScore: $complianceScore, issues: $issues, warnings: $warnings, summary: $summary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComplianceScanImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      organizationId,
      scanDate,
      complianceScore,
      const DeepCollectionEquality().hash(_issues),
      const DeepCollectionEquality().hash(_warnings),
      summary);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ComplianceScanImplCopyWith<_$ComplianceScanImpl> get copyWith =>
      __$$ComplianceScanImplCopyWithImpl<_$ComplianceScanImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ComplianceScanImplToJson(
      this,
    );
  }
}

abstract class _ComplianceScan implements ComplianceScan {
  const factory _ComplianceScan(
      {required final String organizationId,
      required final String scanDate,
      required final ComplianceScore complianceScore,
      required final List<ComplianceIssue> issues,
      required final List<ComplianceIssue> warnings,
      required final ComplianceSummary summary}) = _$ComplianceScanImpl;

  factory _ComplianceScan.fromJson(Map<String, dynamic> json) =
      _$ComplianceScanImpl.fromJson;

  @override
  String get organizationId;
  @override
  String get scanDate;
  @override
  ComplianceScore get complianceScore;
  @override
  List<ComplianceIssue> get issues;
  @override
  List<ComplianceIssue> get warnings;
  @override
  ComplianceSummary get summary;
  @override
  @JsonKey(ignore: true)
  _$$ComplianceScanImplCopyWith<_$ComplianceScanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ComplianceScore _$ComplianceScoreFromJson(Map<String, dynamic> json) {
  return _ComplianceScore.fromJson(json);
}

/// @nodoc
mixin _$ComplianceScore {
  int get score => throw _privateConstructorUsedError;
  String get riskLevel => throw _privateConstructorUsedError;
  ScoreBreakdown get breakdown => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ComplianceScoreCopyWith<ComplianceScore> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComplianceScoreCopyWith<$Res> {
  factory $ComplianceScoreCopyWith(
          ComplianceScore value, $Res Function(ComplianceScore) then) =
      _$ComplianceScoreCopyWithImpl<$Res, ComplianceScore>;
  @useResult
  $Res call({int score, String riskLevel, ScoreBreakdown breakdown});

  $ScoreBreakdownCopyWith<$Res> get breakdown;
}

/// @nodoc
class _$ComplianceScoreCopyWithImpl<$Res, $Val extends ComplianceScore>
    implements $ComplianceScoreCopyWith<$Res> {
  _$ComplianceScoreCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? score = null,
    Object? riskLevel = null,
    Object? breakdown = null,
  }) {
    return _then(_value.copyWith(
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      riskLevel: null == riskLevel
          ? _value.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as String,
      breakdown: null == breakdown
          ? _value.breakdown
          : breakdown // ignore: cast_nullable_to_non_nullable
              as ScoreBreakdown,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ScoreBreakdownCopyWith<$Res> get breakdown {
    return $ScoreBreakdownCopyWith<$Res>(_value.breakdown, (value) {
      return _then(_value.copyWith(breakdown: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ComplianceScoreImplCopyWith<$Res>
    implements $ComplianceScoreCopyWith<$Res> {
  factory _$$ComplianceScoreImplCopyWith(_$ComplianceScoreImpl value,
          $Res Function(_$ComplianceScoreImpl) then) =
      __$$ComplianceScoreImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int score, String riskLevel, ScoreBreakdown breakdown});

  @override
  $ScoreBreakdownCopyWith<$Res> get breakdown;
}

/// @nodoc
class __$$ComplianceScoreImplCopyWithImpl<$Res>
    extends _$ComplianceScoreCopyWithImpl<$Res, _$ComplianceScoreImpl>
    implements _$$ComplianceScoreImplCopyWith<$Res> {
  __$$ComplianceScoreImplCopyWithImpl(
      _$ComplianceScoreImpl _value, $Res Function(_$ComplianceScoreImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? score = null,
    Object? riskLevel = null,
    Object? breakdown = null,
  }) {
    return _then(_$ComplianceScoreImpl(
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      riskLevel: null == riskLevel
          ? _value.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as String,
      breakdown: null == breakdown
          ? _value.breakdown
          : breakdown // ignore: cast_nullable_to_non_nullable
              as ScoreBreakdown,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ComplianceScoreImpl implements _ComplianceScore {
  const _$ComplianceScoreImpl(
      {required this.score, required this.riskLevel, required this.breakdown});

  factory _$ComplianceScoreImpl.fromJson(Map<String, dynamic> json) =>
      _$$ComplianceScoreImplFromJson(json);

  @override
  final int score;
  @override
  final String riskLevel;
  @override
  final ScoreBreakdown breakdown;

  @override
  String toString() {
    return 'ComplianceScore(score: $score, riskLevel: $riskLevel, breakdown: $breakdown)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComplianceScoreImpl &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.riskLevel, riskLevel) ||
                other.riskLevel == riskLevel) &&
            (identical(other.breakdown, breakdown) ||
                other.breakdown == breakdown));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, score, riskLevel, breakdown);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ComplianceScoreImplCopyWith<_$ComplianceScoreImpl> get copyWith =>
      __$$ComplianceScoreImplCopyWithImpl<_$ComplianceScoreImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ComplianceScoreImplToJson(
      this,
    );
  }
}

abstract class _ComplianceScore implements ComplianceScore {
  const factory _ComplianceScore(
      {required final int score,
      required final String riskLevel,
      required final ScoreBreakdown breakdown}) = _$ComplianceScoreImpl;

  factory _ComplianceScore.fromJson(Map<String, dynamic> json) =
      _$ComplianceScoreImpl.fromJson;

  @override
  int get score;
  @override
  String get riskLevel;
  @override
  ScoreBreakdown get breakdown;
  @override
  @JsonKey(ignore: true)
  _$$ComplianceScoreImplCopyWith<_$ComplianceScoreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ScoreBreakdown _$ScoreBreakdownFromJson(Map<String, dynamic> json) {
  return _ScoreBreakdown.fromJson(json);
}

/// @nodoc
mixin _$ScoreBreakdown {
  int get baseScore => throw _privateConstructorUsedError;
  int get issueDeduction => throw _privateConstructorUsedError;
  int get warningDeduction => throw _privateConstructorUsedError;
  int get compliantWorkers => throw _privateConstructorUsedError;
  int get totalWorkers => throw _privateConstructorUsedError;
  int get complianceRate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScoreBreakdownCopyWith<ScoreBreakdown> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScoreBreakdownCopyWith<$Res> {
  factory $ScoreBreakdownCopyWith(
          ScoreBreakdown value, $Res Function(ScoreBreakdown) then) =
      _$ScoreBreakdownCopyWithImpl<$Res, ScoreBreakdown>;
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
class _$ScoreBreakdownCopyWithImpl<$Res, $Val extends ScoreBreakdown>
    implements $ScoreBreakdownCopyWith<$Res> {
  _$ScoreBreakdownCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      baseScore: null == baseScore
          ? _value.baseScore
          : baseScore // ignore: cast_nullable_to_non_nullable
              as int,
      issueDeduction: null == issueDeduction
          ? _value.issueDeduction
          : issueDeduction // ignore: cast_nullable_to_non_nullable
              as int,
      warningDeduction: null == warningDeduction
          ? _value.warningDeduction
          : warningDeduction // ignore: cast_nullable_to_non_nullable
              as int,
      compliantWorkers: null == compliantWorkers
          ? _value.compliantWorkers
          : compliantWorkers // ignore: cast_nullable_to_non_nullable
              as int,
      totalWorkers: null == totalWorkers
          ? _value.totalWorkers
          : totalWorkers // ignore: cast_nullable_to_non_nullable
              as int,
      complianceRate: null == complianceRate
          ? _value.complianceRate
          : complianceRate // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScoreBreakdownImplCopyWith<$Res>
    implements $ScoreBreakdownCopyWith<$Res> {
  factory _$$ScoreBreakdownImplCopyWith(_$ScoreBreakdownImpl value,
          $Res Function(_$ScoreBreakdownImpl) then) =
      __$$ScoreBreakdownImplCopyWithImpl<$Res>;
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
class __$$ScoreBreakdownImplCopyWithImpl<$Res>
    extends _$ScoreBreakdownCopyWithImpl<$Res, _$ScoreBreakdownImpl>
    implements _$$ScoreBreakdownImplCopyWith<$Res> {
  __$$ScoreBreakdownImplCopyWithImpl(
      _$ScoreBreakdownImpl _value, $Res Function(_$ScoreBreakdownImpl) _then)
      : super(_value, _then);

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
    return _then(_$ScoreBreakdownImpl(
      baseScore: null == baseScore
          ? _value.baseScore
          : baseScore // ignore: cast_nullable_to_non_nullable
              as int,
      issueDeduction: null == issueDeduction
          ? _value.issueDeduction
          : issueDeduction // ignore: cast_nullable_to_non_nullable
              as int,
      warningDeduction: null == warningDeduction
          ? _value.warningDeduction
          : warningDeduction // ignore: cast_nullable_to_non_nullable
              as int,
      compliantWorkers: null == compliantWorkers
          ? _value.compliantWorkers
          : compliantWorkers // ignore: cast_nullable_to_non_nullable
              as int,
      totalWorkers: null == totalWorkers
          ? _value.totalWorkers
          : totalWorkers // ignore: cast_nullable_to_non_nullable
              as int,
      complianceRate: null == complianceRate
          ? _value.complianceRate
          : complianceRate // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScoreBreakdownImpl implements _ScoreBreakdown {
  const _$ScoreBreakdownImpl(
      {required this.baseScore,
      required this.issueDeduction,
      required this.warningDeduction,
      required this.compliantWorkers,
      required this.totalWorkers,
      required this.complianceRate});

  factory _$ScoreBreakdownImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScoreBreakdownImplFromJson(json);

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

  @override
  String toString() {
    return 'ScoreBreakdown(baseScore: $baseScore, issueDeduction: $issueDeduction, warningDeduction: $warningDeduction, compliantWorkers: $compliantWorkers, totalWorkers: $totalWorkers, complianceRate: $complianceRate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScoreBreakdownImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, baseScore, issueDeduction,
      warningDeduction, compliantWorkers, totalWorkers, complianceRate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScoreBreakdownImplCopyWith<_$ScoreBreakdownImpl> get copyWith =>
      __$$ScoreBreakdownImplCopyWithImpl<_$ScoreBreakdownImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScoreBreakdownImplToJson(
      this,
    );
  }
}

abstract class _ScoreBreakdown implements ScoreBreakdown {
  const factory _ScoreBreakdown(
      {required final int baseScore,
      required final int issueDeduction,
      required final int warningDeduction,
      required final int compliantWorkers,
      required final int totalWorkers,
      required final int complianceRate}) = _$ScoreBreakdownImpl;

  factory _ScoreBreakdown.fromJson(Map<String, dynamic> json) =
      _$ScoreBreakdownImpl.fromJson;

  @override
  int get baseScore;
  @override
  int get issueDeduction;
  @override
  int get warningDeduction;
  @override
  int get compliantWorkers;
  @override
  int get totalWorkers;
  @override
  int get complianceRate;
  @override
  @JsonKey(ignore: true)
  _$$ScoreBreakdownImplCopyWith<_$ScoreBreakdownImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ComplianceIssue _$ComplianceIssueFromJson(Map<String, dynamic> json) {
  return _ComplianceIssue.fromJson(json);
}

/// @nodoc
mixin _$ComplianceIssue {
  String get type => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get severity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ComplianceIssueCopyWith<ComplianceIssue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComplianceIssueCopyWith<$Res> {
  factory $ComplianceIssueCopyWith(
          ComplianceIssue value, $Res Function(ComplianceIssue) then) =
      _$ComplianceIssueCopyWithImpl<$Res, ComplianceIssue>;
  @useResult
  $Res call({String type, int count, String message, String severity});
}

/// @nodoc
class _$ComplianceIssueCopyWithImpl<$Res, $Val extends ComplianceIssue>
    implements $ComplianceIssueCopyWith<$Res> {
  _$ComplianceIssueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? count = null,
    Object? message = null,
    Object? severity = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ComplianceIssueImplCopyWith<$Res>
    implements $ComplianceIssueCopyWith<$Res> {
  factory _$$ComplianceIssueImplCopyWith(_$ComplianceIssueImpl value,
          $Res Function(_$ComplianceIssueImpl) then) =
      __$$ComplianceIssueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, int count, String message, String severity});
}

/// @nodoc
class __$$ComplianceIssueImplCopyWithImpl<$Res>
    extends _$ComplianceIssueCopyWithImpl<$Res, _$ComplianceIssueImpl>
    implements _$$ComplianceIssueImplCopyWith<$Res> {
  __$$ComplianceIssueImplCopyWithImpl(
      _$ComplianceIssueImpl _value, $Res Function(_$ComplianceIssueImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? count = null,
    Object? message = null,
    Object? severity = null,
  }) {
    return _then(_$ComplianceIssueImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ComplianceIssueImpl implements _ComplianceIssue {
  const _$ComplianceIssueImpl(
      {required this.type,
      required this.count,
      required this.message,
      required this.severity});

  factory _$ComplianceIssueImpl.fromJson(Map<String, dynamic> json) =>
      _$$ComplianceIssueImplFromJson(json);

  @override
  final String type;
  @override
  final int count;
  @override
  final String message;
  @override
  final String severity;

  @override
  String toString() {
    return 'ComplianceIssue(type: $type, count: $count, message: $message, severity: $severity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComplianceIssueImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.severity, severity) ||
                other.severity == severity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, count, message, severity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ComplianceIssueImplCopyWith<_$ComplianceIssueImpl> get copyWith =>
      __$$ComplianceIssueImplCopyWithImpl<_$ComplianceIssueImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ComplianceIssueImplToJson(
      this,
    );
  }
}

abstract class _ComplianceIssue implements ComplianceIssue {
  const factory _ComplianceIssue(
      {required final String type,
      required final int count,
      required final String message,
      required final String severity}) = _$ComplianceIssueImpl;

  factory _ComplianceIssue.fromJson(Map<String, dynamic> json) =
      _$ComplianceIssueImpl.fromJson;

  @override
  String get type;
  @override
  int get count;
  @override
  String get message;
  @override
  String get severity;
  @override
  @JsonKey(ignore: true)
  _$$ComplianceIssueImplCopyWith<_$ComplianceIssueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ComplianceSummary _$ComplianceSummaryFromJson(Map<String, dynamic> json) {
  return _ComplianceSummary.fromJson(json);
}

/// @nodoc
mixin _$ComplianceSummary {
  int get totalIssues => throw _privateConstructorUsedError;
  int get totalWarnings => throw _privateConstructorUsedError;
  int get criticalCount => throw _privateConstructorUsedError;
  int get highCount => throw _privateConstructorUsedError;
  int get mediumCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ComplianceSummaryCopyWith<ComplianceSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComplianceSummaryCopyWith<$Res> {
  factory $ComplianceSummaryCopyWith(
          ComplianceSummary value, $Res Function(ComplianceSummary) then) =
      _$ComplianceSummaryCopyWithImpl<$Res, ComplianceSummary>;
  @useResult
  $Res call(
      {int totalIssues,
      int totalWarnings,
      int criticalCount,
      int highCount,
      int mediumCount});
}

/// @nodoc
class _$ComplianceSummaryCopyWithImpl<$Res, $Val extends ComplianceSummary>
    implements $ComplianceSummaryCopyWith<$Res> {
  _$ComplianceSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalIssues = null,
    Object? totalWarnings = null,
    Object? criticalCount = null,
    Object? highCount = null,
    Object? mediumCount = null,
  }) {
    return _then(_value.copyWith(
      totalIssues: null == totalIssues
          ? _value.totalIssues
          : totalIssues // ignore: cast_nullable_to_non_nullable
              as int,
      totalWarnings: null == totalWarnings
          ? _value.totalWarnings
          : totalWarnings // ignore: cast_nullable_to_non_nullable
              as int,
      criticalCount: null == criticalCount
          ? _value.criticalCount
          : criticalCount // ignore: cast_nullable_to_non_nullable
              as int,
      highCount: null == highCount
          ? _value.highCount
          : highCount // ignore: cast_nullable_to_non_nullable
              as int,
      mediumCount: null == mediumCount
          ? _value.mediumCount
          : mediumCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ComplianceSummaryImplCopyWith<$Res>
    implements $ComplianceSummaryCopyWith<$Res> {
  factory _$$ComplianceSummaryImplCopyWith(_$ComplianceSummaryImpl value,
          $Res Function(_$ComplianceSummaryImpl) then) =
      __$$ComplianceSummaryImplCopyWithImpl<$Res>;
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
class __$$ComplianceSummaryImplCopyWithImpl<$Res>
    extends _$ComplianceSummaryCopyWithImpl<$Res, _$ComplianceSummaryImpl>
    implements _$$ComplianceSummaryImplCopyWith<$Res> {
  __$$ComplianceSummaryImplCopyWithImpl(_$ComplianceSummaryImpl _value,
      $Res Function(_$ComplianceSummaryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalIssues = null,
    Object? totalWarnings = null,
    Object? criticalCount = null,
    Object? highCount = null,
    Object? mediumCount = null,
  }) {
    return _then(_$ComplianceSummaryImpl(
      totalIssues: null == totalIssues
          ? _value.totalIssues
          : totalIssues // ignore: cast_nullable_to_non_nullable
              as int,
      totalWarnings: null == totalWarnings
          ? _value.totalWarnings
          : totalWarnings // ignore: cast_nullable_to_non_nullable
              as int,
      criticalCount: null == criticalCount
          ? _value.criticalCount
          : criticalCount // ignore: cast_nullable_to_non_nullable
              as int,
      highCount: null == highCount
          ? _value.highCount
          : highCount // ignore: cast_nullable_to_non_nullable
              as int,
      mediumCount: null == mediumCount
          ? _value.mediumCount
          : mediumCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ComplianceSummaryImpl implements _ComplianceSummary {
  const _$ComplianceSummaryImpl(
      {required this.totalIssues,
      required this.totalWarnings,
      required this.criticalCount,
      required this.highCount,
      required this.mediumCount});

  factory _$ComplianceSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ComplianceSummaryImplFromJson(json);

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

  @override
  String toString() {
    return 'ComplianceSummary(totalIssues: $totalIssues, totalWarnings: $totalWarnings, criticalCount: $criticalCount, highCount: $highCount, mediumCount: $mediumCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComplianceSummaryImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, totalIssues, totalWarnings,
      criticalCount, highCount, mediumCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ComplianceSummaryImplCopyWith<_$ComplianceSummaryImpl> get copyWith =>
      __$$ComplianceSummaryImplCopyWithImpl<_$ComplianceSummaryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ComplianceSummaryImplToJson(
      this,
    );
  }
}

abstract class _ComplianceSummary implements ComplianceSummary {
  const factory _ComplianceSummary(
      {required final int totalIssues,
      required final int totalWarnings,
      required final int criticalCount,
      required final int highCount,
      required final int mediumCount}) = _$ComplianceSummaryImpl;

  factory _ComplianceSummary.fromJson(Map<String, dynamic> json) =
      _$ComplianceSummaryImpl.fromJson;

  @override
  int get totalIssues;
  @override
  int get totalWarnings;
  @override
  int get criticalCount;
  @override
  int get highCount;
  @override
  int get mediumCount;
  @override
  @JsonKey(ignore: true)
  _$$ComplianceSummaryImplCopyWith<_$ComplianceSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExpiringDocument _$ExpiringDocumentFromJson(Map<String, dynamic> json) {
  return _ExpiringDocument.fromJson(json);
}

/// @nodoc
mixin _$ExpiringDocument {
  String get workerId => throw _privateConstructorUsedError;
  String get workerName => throw _privateConstructorUsedError;
  String get documentType => throw _privateConstructorUsedError;
  String get expiryDate => throw _privateConstructorUsedError;
  int get daysUntilExpiry => throw _privateConstructorUsedError;
  String get severity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExpiringDocumentCopyWith<ExpiringDocument> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpiringDocumentCopyWith<$Res> {
  factory $ExpiringDocumentCopyWith(
          ExpiringDocument value, $Res Function(ExpiringDocument) then) =
      _$ExpiringDocumentCopyWithImpl<$Res, ExpiringDocument>;
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
class _$ExpiringDocumentCopyWithImpl<$Res, $Val extends ExpiringDocument>
    implements $ExpiringDocumentCopyWith<$Res> {
  _$ExpiringDocumentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      workerId: null == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _value.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      documentType: null == documentType
          ? _value.documentType
          : documentType // ignore: cast_nullable_to_non_nullable
              as String,
      expiryDate: null == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as String,
      daysUntilExpiry: null == daysUntilExpiry
          ? _value.daysUntilExpiry
          : daysUntilExpiry // ignore: cast_nullable_to_non_nullable
              as int,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExpiringDocumentImplCopyWith<$Res>
    implements $ExpiringDocumentCopyWith<$Res> {
  factory _$$ExpiringDocumentImplCopyWith(_$ExpiringDocumentImpl value,
          $Res Function(_$ExpiringDocumentImpl) then) =
      __$$ExpiringDocumentImplCopyWithImpl<$Res>;
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
class __$$ExpiringDocumentImplCopyWithImpl<$Res>
    extends _$ExpiringDocumentCopyWithImpl<$Res, _$ExpiringDocumentImpl>
    implements _$$ExpiringDocumentImplCopyWith<$Res> {
  __$$ExpiringDocumentImplCopyWithImpl(_$ExpiringDocumentImpl _value,
      $Res Function(_$ExpiringDocumentImpl) _then)
      : super(_value, _then);

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
    return _then(_$ExpiringDocumentImpl(
      workerId: null == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _value.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      documentType: null == documentType
          ? _value.documentType
          : documentType // ignore: cast_nullable_to_non_nullable
              as String,
      expiryDate: null == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as String,
      daysUntilExpiry: null == daysUntilExpiry
          ? _value.daysUntilExpiry
          : daysUntilExpiry // ignore: cast_nullable_to_non_nullable
              as int,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExpiringDocumentImpl implements _ExpiringDocument {
  const _$ExpiringDocumentImpl(
      {required this.workerId,
      required this.workerName,
      required this.documentType,
      required this.expiryDate,
      required this.daysUntilExpiry,
      required this.severity});

  factory _$ExpiringDocumentImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExpiringDocumentImplFromJson(json);

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

  @override
  String toString() {
    return 'ExpiringDocument(workerId: $workerId, workerName: $workerName, documentType: $documentType, expiryDate: $expiryDate, daysUntilExpiry: $daysUntilExpiry, severity: $severity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpiringDocumentImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, workerId, workerName,
      documentType, expiryDate, daysUntilExpiry, severity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpiringDocumentImplCopyWith<_$ExpiringDocumentImpl> get copyWith =>
      __$$ExpiringDocumentImplCopyWithImpl<_$ExpiringDocumentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExpiringDocumentImplToJson(
      this,
    );
  }
}

abstract class _ExpiringDocument implements ExpiringDocument {
  const factory _ExpiringDocument(
      {required final String workerId,
      required final String workerName,
      required final String documentType,
      required final String expiryDate,
      required final int daysUntilExpiry,
      required final String severity}) = _$ExpiringDocumentImpl;

  factory _ExpiringDocument.fromJson(Map<String, dynamic> json) =
      _$ExpiringDocumentImpl.fromJson;

  @override
  String get workerId;
  @override
  String get workerName;
  @override
  String get documentType;
  @override
  String get expiryDate;
  @override
  int get daysUntilExpiry;
  @override
  String get severity;
  @override
  @JsonKey(ignore: true)
  _$$ExpiringDocumentImplCopyWith<_$ExpiringDocumentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ComplianceAlert _$ComplianceAlertFromJson(Map<String, dynamic> json) {
  return _ComplianceAlert.fromJson(json);
}

/// @nodoc
mixin _$ComplianceAlert {
  String get alertId => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get severity => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String? get sentDate => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ComplianceAlertCopyWith<ComplianceAlert> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComplianceAlertCopyWith<$Res> {
  factory $ComplianceAlertCopyWith(
          ComplianceAlert value, $Res Function(ComplianceAlert) then) =
      _$ComplianceAlertCopyWithImpl<$Res, ComplianceAlert>;
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
class _$ComplianceAlertCopyWithImpl<$Res, $Val extends ComplianceAlert>
    implements $ComplianceAlertCopyWith<$Res> {
  _$ComplianceAlertCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      alertId: null == alertId
          ? _value.alertId
          : alertId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      sentDate: freezed == sentDate
          ? _value.sentDate
          : sentDate // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ComplianceAlertImplCopyWith<$Res>
    implements $ComplianceAlertCopyWith<$Res> {
  factory _$$ComplianceAlertImplCopyWith(_$ComplianceAlertImpl value,
          $Res Function(_$ComplianceAlertImpl) then) =
      __$$ComplianceAlertImplCopyWithImpl<$Res>;
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
class __$$ComplianceAlertImplCopyWithImpl<$Res>
    extends _$ComplianceAlertCopyWithImpl<$Res, _$ComplianceAlertImpl>
    implements _$$ComplianceAlertImplCopyWith<$Res> {
  __$$ComplianceAlertImplCopyWithImpl(
      _$ComplianceAlertImpl _value, $Res Function(_$ComplianceAlertImpl) _then)
      : super(_value, _then);

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
    return _then(_$ComplianceAlertImpl(
      alertId: null == alertId
          ? _value.alertId
          : alertId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      sentDate: freezed == sentDate
          ? _value.sentDate
          : sentDate // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ComplianceAlertImpl implements _ComplianceAlert {
  const _$ComplianceAlertImpl(
      {required this.alertId,
      required this.type,
      required this.message,
      required this.severity,
      required this.createdAt,
      this.sentDate,
      this.status});

  factory _$ComplianceAlertImpl.fromJson(Map<String, dynamic> json) =>
      _$$ComplianceAlertImplFromJson(json);

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

  @override
  String toString() {
    return 'ComplianceAlert(alertId: $alertId, type: $type, message: $message, severity: $severity, createdAt: $createdAt, sentDate: $sentDate, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComplianceAlertImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, alertId, type, message, severity,
      createdAt, sentDate, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ComplianceAlertImplCopyWith<_$ComplianceAlertImpl> get copyWith =>
      __$$ComplianceAlertImplCopyWithImpl<_$ComplianceAlertImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ComplianceAlertImplToJson(
      this,
    );
  }
}

abstract class _ComplianceAlert implements ComplianceAlert {
  const factory _ComplianceAlert(
      {required final String alertId,
      required final String type,
      required final String message,
      required final String severity,
      required final String createdAt,
      final String? sentDate,
      final String? status}) = _$ComplianceAlertImpl;

  factory _ComplianceAlert.fromJson(Map<String, dynamic> json) =
      _$ComplianceAlertImpl.fromJson;

  @override
  String get alertId;
  @override
  String get type;
  @override
  String get message;
  @override
  String get severity;
  @override
  String get createdAt;
  @override
  String? get sentDate;
  @override
  String? get status;
  @override
  @JsonKey(ignore: true)
  _$$ComplianceAlertImplCopyWith<_$ComplianceAlertImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ComplianceReport _$ComplianceReportFromJson(Map<String, dynamic> json) {
  return _ComplianceReport.fromJson(json);
}

/// @nodoc
mixin _$ComplianceReport {
  String get reportId => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get reportType => throw _privateConstructorUsedError;
  String get generatedDate => throw _privateConstructorUsedError;
  ComplianceScore get complianceScore => throw _privateConstructorUsedError;
  ComplianceSummary get summary => throw _privateConstructorUsedError;
  List<ExpiringDocument> get expiringDocuments =>
      throw _privateConstructorUsedError;
  List<ComplianceRecommendation> get recommendations =>
      throw _privateConstructorUsedError;
  List<ComplianceIssue>? get issues => throw _privateConstructorUsedError;
  List<ComplianceIssue>? get warnings => throw _privateConstructorUsedError;
  AuditTrail? get auditTrail => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ComplianceReportCopyWith<ComplianceReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComplianceReportCopyWith<$Res> {
  factory $ComplianceReportCopyWith(
          ComplianceReport value, $Res Function(ComplianceReport) then) =
      _$ComplianceReportCopyWithImpl<$Res, ComplianceReport>;
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
class _$ComplianceReportCopyWithImpl<$Res, $Val extends ComplianceReport>
    implements $ComplianceReportCopyWith<$Res> {
  _$ComplianceReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      reportId: null == reportId
          ? _value.reportId
          : reportId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      reportType: null == reportType
          ? _value.reportType
          : reportType // ignore: cast_nullable_to_non_nullable
              as String,
      generatedDate: null == generatedDate
          ? _value.generatedDate
          : generatedDate // ignore: cast_nullable_to_non_nullable
              as String,
      complianceScore: null == complianceScore
          ? _value.complianceScore
          : complianceScore // ignore: cast_nullable_to_non_nullable
              as ComplianceScore,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as ComplianceSummary,
      expiringDocuments: null == expiringDocuments
          ? _value.expiringDocuments
          : expiringDocuments // ignore: cast_nullable_to_non_nullable
              as List<ExpiringDocument>,
      recommendations: null == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<ComplianceRecommendation>,
      issues: freezed == issues
          ? _value.issues
          : issues // ignore: cast_nullable_to_non_nullable
              as List<ComplianceIssue>?,
      warnings: freezed == warnings
          ? _value.warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<ComplianceIssue>?,
      auditTrail: freezed == auditTrail
          ? _value.auditTrail
          : auditTrail // ignore: cast_nullable_to_non_nullable
              as AuditTrail?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ComplianceScoreCopyWith<$Res> get complianceScore {
    return $ComplianceScoreCopyWith<$Res>(_value.complianceScore, (value) {
      return _then(_value.copyWith(complianceScore: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ComplianceSummaryCopyWith<$Res> get summary {
    return $ComplianceSummaryCopyWith<$Res>(_value.summary, (value) {
      return _then(_value.copyWith(summary: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AuditTrailCopyWith<$Res>? get auditTrail {
    if (_value.auditTrail == null) {
      return null;
    }

    return $AuditTrailCopyWith<$Res>(_value.auditTrail!, (value) {
      return _then(_value.copyWith(auditTrail: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ComplianceReportImplCopyWith<$Res>
    implements $ComplianceReportCopyWith<$Res> {
  factory _$$ComplianceReportImplCopyWith(_$ComplianceReportImpl value,
          $Res Function(_$ComplianceReportImpl) then) =
      __$$ComplianceReportImplCopyWithImpl<$Res>;
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
class __$$ComplianceReportImplCopyWithImpl<$Res>
    extends _$ComplianceReportCopyWithImpl<$Res, _$ComplianceReportImpl>
    implements _$$ComplianceReportImplCopyWith<$Res> {
  __$$ComplianceReportImplCopyWithImpl(_$ComplianceReportImpl _value,
      $Res Function(_$ComplianceReportImpl) _then)
      : super(_value, _then);

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
    return _then(_$ComplianceReportImpl(
      reportId: null == reportId
          ? _value.reportId
          : reportId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      reportType: null == reportType
          ? _value.reportType
          : reportType // ignore: cast_nullable_to_non_nullable
              as String,
      generatedDate: null == generatedDate
          ? _value.generatedDate
          : generatedDate // ignore: cast_nullable_to_non_nullable
              as String,
      complianceScore: null == complianceScore
          ? _value.complianceScore
          : complianceScore // ignore: cast_nullable_to_non_nullable
              as ComplianceScore,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as ComplianceSummary,
      expiringDocuments: null == expiringDocuments
          ? _value._expiringDocuments
          : expiringDocuments // ignore: cast_nullable_to_non_nullable
              as List<ExpiringDocument>,
      recommendations: null == recommendations
          ? _value._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<ComplianceRecommendation>,
      issues: freezed == issues
          ? _value._issues
          : issues // ignore: cast_nullable_to_non_nullable
              as List<ComplianceIssue>?,
      warnings: freezed == warnings
          ? _value._warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<ComplianceIssue>?,
      auditTrail: freezed == auditTrail
          ? _value.auditTrail
          : auditTrail // ignore: cast_nullable_to_non_nullable
              as AuditTrail?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ComplianceReportImpl implements _ComplianceReport {
  const _$ComplianceReportImpl(
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

  factory _$ComplianceReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$ComplianceReportImplFromJson(json);

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

  @override
  String toString() {
    return 'ComplianceReport(reportId: $reportId, organizationId: $organizationId, reportType: $reportType, generatedDate: $generatedDate, complianceScore: $complianceScore, summary: $summary, expiringDocuments: $expiringDocuments, recommendations: $recommendations, issues: $issues, warnings: $warnings, auditTrail: $auditTrail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComplianceReportImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ComplianceReportImplCopyWith<_$ComplianceReportImpl> get copyWith =>
      __$$ComplianceReportImplCopyWithImpl<_$ComplianceReportImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ComplianceReportImplToJson(
      this,
    );
  }
}

abstract class _ComplianceReport implements ComplianceReport {
  const factory _ComplianceReport(
      {required final String reportId,
      required final String organizationId,
      required final String reportType,
      required final String generatedDate,
      required final ComplianceScore complianceScore,
      required final ComplianceSummary summary,
      required final List<ExpiringDocument> expiringDocuments,
      required final List<ComplianceRecommendation> recommendations,
      final List<ComplianceIssue>? issues,
      final List<ComplianceIssue>? warnings,
      final AuditTrail? auditTrail}) = _$ComplianceReportImpl;

  factory _ComplianceReport.fromJson(Map<String, dynamic> json) =
      _$ComplianceReportImpl.fromJson;

  @override
  String get reportId;
  @override
  String get organizationId;
  @override
  String get reportType;
  @override
  String get generatedDate;
  @override
  ComplianceScore get complianceScore;
  @override
  ComplianceSummary get summary;
  @override
  List<ExpiringDocument> get expiringDocuments;
  @override
  List<ComplianceRecommendation> get recommendations;
  @override
  List<ComplianceIssue>? get issues;
  @override
  List<ComplianceIssue>? get warnings;
  @override
  AuditTrail? get auditTrail;
  @override
  @JsonKey(ignore: true)
  _$$ComplianceReportImplCopyWith<_$ComplianceReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ComplianceRecommendation _$ComplianceRecommendationFromJson(
    Map<String, dynamic> json) {
  return _ComplianceRecommendation.fromJson(json);
}

/// @nodoc
mixin _$ComplianceRecommendation {
  String get priority => throw _privateConstructorUsedError;
  String get action => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ComplianceRecommendationCopyWith<ComplianceRecommendation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComplianceRecommendationCopyWith<$Res> {
  factory $ComplianceRecommendationCopyWith(ComplianceRecommendation value,
          $Res Function(ComplianceRecommendation) then) =
      _$ComplianceRecommendationCopyWithImpl<$Res, ComplianceRecommendation>;
  @useResult
  $Res call({String priority, String action, String description});
}

/// @nodoc
class _$ComplianceRecommendationCopyWithImpl<$Res,
        $Val extends ComplianceRecommendation>
    implements $ComplianceRecommendationCopyWith<$Res> {
  _$ComplianceRecommendationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? priority = null,
    Object? action = null,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ComplianceRecommendationImplCopyWith<$Res>
    implements $ComplianceRecommendationCopyWith<$Res> {
  factory _$$ComplianceRecommendationImplCopyWith(
          _$ComplianceRecommendationImpl value,
          $Res Function(_$ComplianceRecommendationImpl) then) =
      __$$ComplianceRecommendationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String priority, String action, String description});
}

/// @nodoc
class __$$ComplianceRecommendationImplCopyWithImpl<$Res>
    extends _$ComplianceRecommendationCopyWithImpl<$Res,
        _$ComplianceRecommendationImpl>
    implements _$$ComplianceRecommendationImplCopyWith<$Res> {
  __$$ComplianceRecommendationImplCopyWithImpl(
      _$ComplianceRecommendationImpl _value,
      $Res Function(_$ComplianceRecommendationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? priority = null,
    Object? action = null,
    Object? description = null,
  }) {
    return _then(_$ComplianceRecommendationImpl(
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ComplianceRecommendationImpl implements _ComplianceRecommendation {
  const _$ComplianceRecommendationImpl(
      {required this.priority,
      required this.action,
      required this.description});

  factory _$ComplianceRecommendationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ComplianceRecommendationImplFromJson(json);

  @override
  final String priority;
  @override
  final String action;
  @override
  final String description;

  @override
  String toString() {
    return 'ComplianceRecommendation(priority: $priority, action: $action, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComplianceRecommendationImpl &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, priority, action, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ComplianceRecommendationImplCopyWith<_$ComplianceRecommendationImpl>
      get copyWith => __$$ComplianceRecommendationImplCopyWithImpl<
          _$ComplianceRecommendationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ComplianceRecommendationImplToJson(
      this,
    );
  }
}

abstract class _ComplianceRecommendation implements ComplianceRecommendation {
  const factory _ComplianceRecommendation(
      {required final String priority,
      required final String action,
      required final String description}) = _$ComplianceRecommendationImpl;

  factory _ComplianceRecommendation.fromJson(Map<String, dynamic> json) =
      _$ComplianceRecommendationImpl.fromJson;

  @override
  String get priority;
  @override
  String get action;
  @override
  String get description;
  @override
  @JsonKey(ignore: true)
  _$$ComplianceRecommendationImplCopyWith<_$ComplianceRecommendationImpl>
      get copyWith => throw _privateConstructorUsedError;
}

AuditTrail _$AuditTrailFromJson(Map<String, dynamic> json) {
  return _AuditTrail.fromJson(json);
}

/// @nodoc
mixin _$AuditTrail {
  String get lastAuditDate => throw _privateConstructorUsedError;
  String get nextAuditDate => throw _privateConstructorUsedError;
  List<dynamic> get complianceHistory => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuditTrailCopyWith<AuditTrail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuditTrailCopyWith<$Res> {
  factory $AuditTrailCopyWith(
          AuditTrail value, $Res Function(AuditTrail) then) =
      _$AuditTrailCopyWithImpl<$Res, AuditTrail>;
  @useResult
  $Res call(
      {String lastAuditDate,
      String nextAuditDate,
      List<dynamic> complianceHistory});
}

/// @nodoc
class _$AuditTrailCopyWithImpl<$Res, $Val extends AuditTrail>
    implements $AuditTrailCopyWith<$Res> {
  _$AuditTrailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastAuditDate = null,
    Object? nextAuditDate = null,
    Object? complianceHistory = null,
  }) {
    return _then(_value.copyWith(
      lastAuditDate: null == lastAuditDate
          ? _value.lastAuditDate
          : lastAuditDate // ignore: cast_nullable_to_non_nullable
              as String,
      nextAuditDate: null == nextAuditDate
          ? _value.nextAuditDate
          : nextAuditDate // ignore: cast_nullable_to_non_nullable
              as String,
      complianceHistory: null == complianceHistory
          ? _value.complianceHistory
          : complianceHistory // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuditTrailImplCopyWith<$Res>
    implements $AuditTrailCopyWith<$Res> {
  factory _$$AuditTrailImplCopyWith(
          _$AuditTrailImpl value, $Res Function(_$AuditTrailImpl) then) =
      __$$AuditTrailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String lastAuditDate,
      String nextAuditDate,
      List<dynamic> complianceHistory});
}

/// @nodoc
class __$$AuditTrailImplCopyWithImpl<$Res>
    extends _$AuditTrailCopyWithImpl<$Res, _$AuditTrailImpl>
    implements _$$AuditTrailImplCopyWith<$Res> {
  __$$AuditTrailImplCopyWithImpl(
      _$AuditTrailImpl _value, $Res Function(_$AuditTrailImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastAuditDate = null,
    Object? nextAuditDate = null,
    Object? complianceHistory = null,
  }) {
    return _then(_$AuditTrailImpl(
      lastAuditDate: null == lastAuditDate
          ? _value.lastAuditDate
          : lastAuditDate // ignore: cast_nullable_to_non_nullable
              as String,
      nextAuditDate: null == nextAuditDate
          ? _value.nextAuditDate
          : nextAuditDate // ignore: cast_nullable_to_non_nullable
              as String,
      complianceHistory: null == complianceHistory
          ? _value._complianceHistory
          : complianceHistory // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuditTrailImpl implements _AuditTrail {
  const _$AuditTrailImpl(
      {required this.lastAuditDate,
      required this.nextAuditDate,
      required final List<dynamic> complianceHistory})
      : _complianceHistory = complianceHistory;

  factory _$AuditTrailImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuditTrailImplFromJson(json);

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

  @override
  String toString() {
    return 'AuditTrail(lastAuditDate: $lastAuditDate, nextAuditDate: $nextAuditDate, complianceHistory: $complianceHistory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuditTrailImpl &&
            (identical(other.lastAuditDate, lastAuditDate) ||
                other.lastAuditDate == lastAuditDate) &&
            (identical(other.nextAuditDate, nextAuditDate) ||
                other.nextAuditDate == nextAuditDate) &&
            const DeepCollectionEquality()
                .equals(other._complianceHistory, _complianceHistory));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, lastAuditDate, nextAuditDate,
      const DeepCollectionEquality().hash(_complianceHistory));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuditTrailImplCopyWith<_$AuditTrailImpl> get copyWith =>
      __$$AuditTrailImplCopyWithImpl<_$AuditTrailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuditTrailImplToJson(
      this,
    );
  }
}

abstract class _AuditTrail implements AuditTrail {
  const factory _AuditTrail(
      {required final String lastAuditDate,
      required final String nextAuditDate,
      required final List<dynamic> complianceHistory}) = _$AuditTrailImpl;

  factory _AuditTrail.fromJson(Map<String, dynamic> json) =
      _$AuditTrailImpl.fromJson;

  @override
  String get lastAuditDate;
  @override
  String get nextAuditDate;
  @override
  List<dynamic> get complianceHistory;
  @override
  @JsonKey(ignore: true)
  _$$AuditTrailImplCopyWith<_$AuditTrailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ComplianceTrend _$ComplianceTrendFromJson(Map<String, dynamic> json) {
  return _ComplianceTrend.fromJson(json);
}

/// @nodoc
mixin _$ComplianceTrend {
  String get month => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  int get issues => throw _privateConstructorUsedError;
  int get warnings => throw _privateConstructorUsedError;
  int get compliantWorkers => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ComplianceTrendCopyWith<ComplianceTrend> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComplianceTrendCopyWith<$Res> {
  factory $ComplianceTrendCopyWith(
          ComplianceTrend value, $Res Function(ComplianceTrend) then) =
      _$ComplianceTrendCopyWithImpl<$Res, ComplianceTrend>;
  @useResult
  $Res call(
      {String month,
      int score,
      int issues,
      int warnings,
      int compliantWorkers});
}

/// @nodoc
class _$ComplianceTrendCopyWithImpl<$Res, $Val extends ComplianceTrend>
    implements $ComplianceTrendCopyWith<$Res> {
  _$ComplianceTrendCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? score = null,
    Object? issues = null,
    Object? warnings = null,
    Object? compliantWorkers = null,
  }) {
    return _then(_value.copyWith(
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      issues: null == issues
          ? _value.issues
          : issues // ignore: cast_nullable_to_non_nullable
              as int,
      warnings: null == warnings
          ? _value.warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as int,
      compliantWorkers: null == compliantWorkers
          ? _value.compliantWorkers
          : compliantWorkers // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ComplianceTrendImplCopyWith<$Res>
    implements $ComplianceTrendCopyWith<$Res> {
  factory _$$ComplianceTrendImplCopyWith(_$ComplianceTrendImpl value,
          $Res Function(_$ComplianceTrendImpl) then) =
      __$$ComplianceTrendImplCopyWithImpl<$Res>;
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
class __$$ComplianceTrendImplCopyWithImpl<$Res>
    extends _$ComplianceTrendCopyWithImpl<$Res, _$ComplianceTrendImpl>
    implements _$$ComplianceTrendImplCopyWith<$Res> {
  __$$ComplianceTrendImplCopyWithImpl(
      _$ComplianceTrendImpl _value, $Res Function(_$ComplianceTrendImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? score = null,
    Object? issues = null,
    Object? warnings = null,
    Object? compliantWorkers = null,
  }) {
    return _then(_$ComplianceTrendImpl(
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      issues: null == issues
          ? _value.issues
          : issues // ignore: cast_nullable_to_non_nullable
              as int,
      warnings: null == warnings
          ? _value.warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as int,
      compliantWorkers: null == compliantWorkers
          ? _value.compliantWorkers
          : compliantWorkers // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ComplianceTrendImpl implements _ComplianceTrend {
  const _$ComplianceTrendImpl(
      {required this.month,
      required this.score,
      required this.issues,
      required this.warnings,
      required this.compliantWorkers});

  factory _$ComplianceTrendImpl.fromJson(Map<String, dynamic> json) =>
      _$$ComplianceTrendImplFromJson(json);

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

  @override
  String toString() {
    return 'ComplianceTrend(month: $month, score: $score, issues: $issues, warnings: $warnings, compliantWorkers: $compliantWorkers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComplianceTrendImpl &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.issues, issues) || other.issues == issues) &&
            (identical(other.warnings, warnings) ||
                other.warnings == warnings) &&
            (identical(other.compliantWorkers, compliantWorkers) ||
                other.compliantWorkers == compliantWorkers));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, month, score, issues, warnings, compliantWorkers);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ComplianceTrendImplCopyWith<_$ComplianceTrendImpl> get copyWith =>
      __$$ComplianceTrendImplCopyWithImpl<_$ComplianceTrendImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ComplianceTrendImplToJson(
      this,
    );
  }
}

abstract class _ComplianceTrend implements ComplianceTrend {
  const factory _ComplianceTrend(
      {required final String month,
      required final int score,
      required final int issues,
      required final int warnings,
      required final int compliantWorkers}) = _$ComplianceTrendImpl;

  factory _ComplianceTrend.fromJson(Map<String, dynamic> json) =
      _$ComplianceTrendImpl.fromJson;

  @override
  String get month;
  @override
  int get score;
  @override
  int get issues;
  @override
  int get warnings;
  @override
  int get compliantWorkers;
  @override
  @JsonKey(ignore: true)
  _$$ComplianceTrendImplCopyWith<_$ComplianceTrendImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ComplianceTrends _$ComplianceTrendsFromJson(Map<String, dynamic> json) {
  return _ComplianceTrends.fromJson(json);
}

/// @nodoc
mixin _$ComplianceTrends {
  String get organizationId => throw _privateConstructorUsedError;
  String get period => throw _privateConstructorUsedError;
  String get trendDirection => throw _privateConstructorUsedError;
  List<ComplianceTrend> get trends => throw _privateConstructorUsedError;
  TrendSummary get summary => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ComplianceTrendsCopyWith<ComplianceTrends> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComplianceTrendsCopyWith<$Res> {
  factory $ComplianceTrendsCopyWith(
          ComplianceTrends value, $Res Function(ComplianceTrends) then) =
      _$ComplianceTrendsCopyWithImpl<$Res, ComplianceTrends>;
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
class _$ComplianceTrendsCopyWithImpl<$Res, $Val extends ComplianceTrends>
    implements $ComplianceTrendsCopyWith<$Res> {
  _$ComplianceTrendsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organizationId = null,
    Object? period = null,
    Object? trendDirection = null,
    Object? trends = null,
    Object? summary = null,
  }) {
    return _then(_value.copyWith(
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      trendDirection: null == trendDirection
          ? _value.trendDirection
          : trendDirection // ignore: cast_nullable_to_non_nullable
              as String,
      trends: null == trends
          ? _value.trends
          : trends // ignore: cast_nullable_to_non_nullable
              as List<ComplianceTrend>,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as TrendSummary,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TrendSummaryCopyWith<$Res> get summary {
    return $TrendSummaryCopyWith<$Res>(_value.summary, (value) {
      return _then(_value.copyWith(summary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ComplianceTrendsImplCopyWith<$Res>
    implements $ComplianceTrendsCopyWith<$Res> {
  factory _$$ComplianceTrendsImplCopyWith(_$ComplianceTrendsImpl value,
          $Res Function(_$ComplianceTrendsImpl) then) =
      __$$ComplianceTrendsImplCopyWithImpl<$Res>;
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
class __$$ComplianceTrendsImplCopyWithImpl<$Res>
    extends _$ComplianceTrendsCopyWithImpl<$Res, _$ComplianceTrendsImpl>
    implements _$$ComplianceTrendsImplCopyWith<$Res> {
  __$$ComplianceTrendsImplCopyWithImpl(_$ComplianceTrendsImpl _value,
      $Res Function(_$ComplianceTrendsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organizationId = null,
    Object? period = null,
    Object? trendDirection = null,
    Object? trends = null,
    Object? summary = null,
  }) {
    return _then(_$ComplianceTrendsImpl(
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      trendDirection: null == trendDirection
          ? _value.trendDirection
          : trendDirection // ignore: cast_nullable_to_non_nullable
              as String,
      trends: null == trends
          ? _value._trends
          : trends // ignore: cast_nullable_to_non_nullable
              as List<ComplianceTrend>,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as TrendSummary,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ComplianceTrendsImpl implements _ComplianceTrends {
  const _$ComplianceTrendsImpl(
      {required this.organizationId,
      required this.period,
      required this.trendDirection,
      required final List<ComplianceTrend> trends,
      required this.summary})
      : _trends = trends;

  factory _$ComplianceTrendsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ComplianceTrendsImplFromJson(json);

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

  @override
  String toString() {
    return 'ComplianceTrends(organizationId: $organizationId, period: $period, trendDirection: $trendDirection, trends: $trends, summary: $summary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComplianceTrendsImpl &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.trendDirection, trendDirection) ||
                other.trendDirection == trendDirection) &&
            const DeepCollectionEquality().equals(other._trends, _trends) &&
            (identical(other.summary, summary) || other.summary == summary));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, organizationId, period,
      trendDirection, const DeepCollectionEquality().hash(_trends), summary);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ComplianceTrendsImplCopyWith<_$ComplianceTrendsImpl> get copyWith =>
      __$$ComplianceTrendsImplCopyWithImpl<_$ComplianceTrendsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ComplianceTrendsImplToJson(
      this,
    );
  }
}

abstract class _ComplianceTrends implements ComplianceTrends {
  const factory _ComplianceTrends(
      {required final String organizationId,
      required final String period,
      required final String trendDirection,
      required final List<ComplianceTrend> trends,
      required final TrendSummary summary}) = _$ComplianceTrendsImpl;

  factory _ComplianceTrends.fromJson(Map<String, dynamic> json) =
      _$ComplianceTrendsImpl.fromJson;

  @override
  String get organizationId;
  @override
  String get period;
  @override
  String get trendDirection;
  @override
  List<ComplianceTrend> get trends;
  @override
  TrendSummary get summary;
  @override
  @JsonKey(ignore: true)
  _$$ComplianceTrendsImplCopyWith<_$ComplianceTrendsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TrendSummary _$TrendSummaryFromJson(Map<String, dynamic> json) {
  return _TrendSummary.fromJson(json);
}

/// @nodoc
mixin _$TrendSummary {
  int get averageScore => throw _privateConstructorUsedError;
  int get highestScore => throw _privateConstructorUsedError;
  int get lowestScore => throw _privateConstructorUsedError;
  int get improvement => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TrendSummaryCopyWith<TrendSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrendSummaryCopyWith<$Res> {
  factory $TrendSummaryCopyWith(
          TrendSummary value, $Res Function(TrendSummary) then) =
      _$TrendSummaryCopyWithImpl<$Res, TrendSummary>;
  @useResult
  $Res call(
      {int averageScore, int highestScore, int lowestScore, int improvement});
}

/// @nodoc
class _$TrendSummaryCopyWithImpl<$Res, $Val extends TrendSummary>
    implements $TrendSummaryCopyWith<$Res> {
  _$TrendSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? averageScore = null,
    Object? highestScore = null,
    Object? lowestScore = null,
    Object? improvement = null,
  }) {
    return _then(_value.copyWith(
      averageScore: null == averageScore
          ? _value.averageScore
          : averageScore // ignore: cast_nullable_to_non_nullable
              as int,
      highestScore: null == highestScore
          ? _value.highestScore
          : highestScore // ignore: cast_nullable_to_non_nullable
              as int,
      lowestScore: null == lowestScore
          ? _value.lowestScore
          : lowestScore // ignore: cast_nullable_to_non_nullable
              as int,
      improvement: null == improvement
          ? _value.improvement
          : improvement // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrendSummaryImplCopyWith<$Res>
    implements $TrendSummaryCopyWith<$Res> {
  factory _$$TrendSummaryImplCopyWith(
          _$TrendSummaryImpl value, $Res Function(_$TrendSummaryImpl) then) =
      __$$TrendSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int averageScore, int highestScore, int lowestScore, int improvement});
}

/// @nodoc
class __$$TrendSummaryImplCopyWithImpl<$Res>
    extends _$TrendSummaryCopyWithImpl<$Res, _$TrendSummaryImpl>
    implements _$$TrendSummaryImplCopyWith<$Res> {
  __$$TrendSummaryImplCopyWithImpl(
      _$TrendSummaryImpl _value, $Res Function(_$TrendSummaryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? averageScore = null,
    Object? highestScore = null,
    Object? lowestScore = null,
    Object? improvement = null,
  }) {
    return _then(_$TrendSummaryImpl(
      averageScore: null == averageScore
          ? _value.averageScore
          : averageScore // ignore: cast_nullable_to_non_nullable
              as int,
      highestScore: null == highestScore
          ? _value.highestScore
          : highestScore // ignore: cast_nullable_to_non_nullable
              as int,
      lowestScore: null == lowestScore
          ? _value.lowestScore
          : lowestScore // ignore: cast_nullable_to_non_nullable
              as int,
      improvement: null == improvement
          ? _value.improvement
          : improvement // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrendSummaryImpl implements _TrendSummary {
  const _$TrendSummaryImpl(
      {required this.averageScore,
      required this.highestScore,
      required this.lowestScore,
      required this.improvement});

  factory _$TrendSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrendSummaryImplFromJson(json);

  @override
  final int averageScore;
  @override
  final int highestScore;
  @override
  final int lowestScore;
  @override
  final int improvement;

  @override
  String toString() {
    return 'TrendSummary(averageScore: $averageScore, highestScore: $highestScore, lowestScore: $lowestScore, improvement: $improvement)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrendSummaryImpl &&
            (identical(other.averageScore, averageScore) ||
                other.averageScore == averageScore) &&
            (identical(other.highestScore, highestScore) ||
                other.highestScore == highestScore) &&
            (identical(other.lowestScore, lowestScore) ||
                other.lowestScore == lowestScore) &&
            (identical(other.improvement, improvement) ||
                other.improvement == improvement));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, averageScore, highestScore, lowestScore, improvement);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TrendSummaryImplCopyWith<_$TrendSummaryImpl> get copyWith =>
      __$$TrendSummaryImplCopyWithImpl<_$TrendSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrendSummaryImplToJson(
      this,
    );
  }
}

abstract class _TrendSummary implements TrendSummary {
  const factory _TrendSummary(
      {required final int averageScore,
      required final int highestScore,
      required final int lowestScore,
      required final int improvement}) = _$TrendSummaryImpl;

  factory _TrendSummary.fromJson(Map<String, dynamic> json) =
      _$TrendSummaryImpl.fromJson;

  @override
  int get averageScore;
  @override
  int get highestScore;
  @override
  int get lowestScore;
  @override
  int get improvement;
  @override
  @JsonKey(ignore: true)
  _$$TrendSummaryImplCopyWith<_$TrendSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
