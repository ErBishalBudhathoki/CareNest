import 'package:freezed_annotation/freezed_annotation.dart';

part 'compliance_automation_models.freezed.dart';
part 'compliance_automation_models.g.dart';

/// Compliance scan results
@freezed
abstract class ComplianceScan with _$ComplianceScan {
  const factory ComplianceScan({
    required String organizationId,
    required String scanDate,
    required ComplianceScore complianceScore,
    required List<ComplianceIssue> issues,
    required List<ComplianceIssue> warnings,
    required ComplianceSummary summary,
  }) = _ComplianceScan;

  factory ComplianceScan.fromJson(Map<String, dynamic> json) =>
      _$ComplianceScanFromJson(json);
}

/// Compliance score with breakdown
@freezed
abstract class ComplianceScore with _$ComplianceScore {
  const factory ComplianceScore({
    required int score,
    required String riskLevel,
    required ScoreBreakdown breakdown,
  }) = _ComplianceScore;

  factory ComplianceScore.fromJson(Map<String, dynamic> json) =>
      _$ComplianceScoreFromJson(json);
}

/// Score breakdown details
@freezed
abstract class ScoreBreakdown with _$ScoreBreakdown {
  const factory ScoreBreakdown({
    required int baseScore,
    required int issueDeduction,
    required int warningDeduction,
    required int compliantWorkers,
    required int totalWorkers,
    required int complianceRate,
  }) = _ScoreBreakdown;

  factory ScoreBreakdown.fromJson(Map<String, dynamic> json) =>
      _$ScoreBreakdownFromJson(json);
}

/// Compliance issue or warning
@freezed
abstract class ComplianceIssue with _$ComplianceIssue {
  const factory ComplianceIssue({
    required String type,
    required int count,
    required String message,
    required String severity,
  }) = _ComplianceIssue;

  factory ComplianceIssue.fromJson(Map<String, dynamic> json) =>
      _$ComplianceIssueFromJson(json);
}

/// Compliance summary
@freezed
abstract class ComplianceSummary with _$ComplianceSummary {
  const factory ComplianceSummary({
    required int totalIssues,
    required int totalWarnings,
    required int criticalCount,
    required int highCount,
    required int mediumCount,
  }) = _ComplianceSummary;

  factory ComplianceSummary.fromJson(Map<String, dynamic> json) =>
      _$ComplianceSummaryFromJson(json);
}

/// Expiring document
@freezed
abstract class ExpiringDocument with _$ExpiringDocument {
  const factory ExpiringDocument({
    required String workerId,
    required String workerName,
    required String documentType,
    required String expiryDate,
    required int daysUntilExpiry,
    required String severity,
  }) = _ExpiringDocument;

  factory ExpiringDocument.fromJson(Map<String, dynamic> json) =>
      _$ExpiringDocumentFromJson(json);
}

/// Compliance alert
@freezed
abstract class ComplianceAlert with _$ComplianceAlert {
  const factory ComplianceAlert({
    required String alertId,
    required String type,
    required String message,
    required String severity,
    required String createdAt,
    String? sentDate,
    String? status,
  }) = _ComplianceAlert;

  factory ComplianceAlert.fromJson(Map<String, dynamic> json) =>
      _$ComplianceAlertFromJson(json);
}

/// Compliance report
@freezed
abstract class ComplianceReport with _$ComplianceReport {
  const factory ComplianceReport({
    required String reportId,
    required String organizationId,
    required String reportType,
    required String generatedDate,
    required ComplianceScore complianceScore,
    required ComplianceSummary summary,
    required List<ExpiringDocument> expiringDocuments,
    required List<ComplianceRecommendation> recommendations,
    List<ComplianceIssue>? issues,
    List<ComplianceIssue>? warnings,
    AuditTrail? auditTrail,
  }) = _ComplianceReport;

  factory ComplianceReport.fromJson(Map<String, dynamic> json) =>
      _$ComplianceReportFromJson(json);
}

/// Compliance recommendation
@freezed
abstract class ComplianceRecommendation with _$ComplianceRecommendation {
  const factory ComplianceRecommendation({
    required String priority,
    required String action,
    required String description,
  }) = _ComplianceRecommendation;

  factory ComplianceRecommendation.fromJson(Map<String, dynamic> json) =>
      _$ComplianceRecommendationFromJson(json);
}

/// Audit trail
@freezed
abstract class AuditTrail with _$AuditTrail {
  const factory AuditTrail({
    required String lastAuditDate,
    required String nextAuditDate,
    required List<dynamic> complianceHistory,
  }) = _AuditTrail;

  factory AuditTrail.fromJson(Map<String, dynamic> json) =>
      _$AuditTrailFromJson(json);
}

/// Compliance trend data
@freezed
abstract class ComplianceTrend with _$ComplianceTrend {
  const factory ComplianceTrend({
    required String month,
    required int score,
    required int issues,
    required int warnings,
    required int compliantWorkers,
  }) = _ComplianceTrend;

  factory ComplianceTrend.fromJson(Map<String, dynamic> json) =>
      _$ComplianceTrendFromJson(json);
}

/// Compliance trends response
@freezed
abstract class ComplianceTrends with _$ComplianceTrends {
  const factory ComplianceTrends({
    required String organizationId,
    required String period,
    required String trendDirection,
    required List<ComplianceTrend> trends,
    required TrendSummary summary,
  }) = _ComplianceTrends;

  factory ComplianceTrends.fromJson(Map<String, dynamic> json) =>
      _$ComplianceTrendsFromJson(json);
}

/// Trend summary
@freezed
abstract class TrendSummary with _$TrendSummary {
  const factory TrendSummary({
    required int averageScore,
    required int highestScore,
    required int lowestScore,
    required int improvement,
  }) = _TrendSummary;

  factory TrendSummary.fromJson(Map<String, dynamic> json) =>
      _$TrendSummaryFromJson(json);
}
