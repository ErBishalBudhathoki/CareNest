// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compliance_automation_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ComplianceScan _$ComplianceScanFromJson(Map<String, dynamic> json) =>
    _ComplianceScan(
      organizationId: json['organizationId'] as String,
      scanDate: json['scanDate'] as String,
      complianceScore: ComplianceScore.fromJson(
        json['complianceScore'] as Map<String, dynamic>,
      ),
      issues: (json['issues'] as List<dynamic>)
          .map((e) => ComplianceIssue.fromJson(e as Map<String, dynamic>))
          .toList(),
      warnings: (json['warnings'] as List<dynamic>)
          .map((e) => ComplianceIssue.fromJson(e as Map<String, dynamic>))
          .toList(),
      summary: ComplianceSummary.fromJson(
        json['summary'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ComplianceScanToJson(_ComplianceScan instance) =>
    <String, dynamic>{
      'organizationId': instance.organizationId,
      'scanDate': instance.scanDate,
      'complianceScore': instance.complianceScore,
      'issues': instance.issues,
      'warnings': instance.warnings,
      'summary': instance.summary,
    };

_ComplianceScore _$ComplianceScoreFromJson(Map<String, dynamic> json) =>
    _ComplianceScore(
      score: (json['score'] as num).toInt(),
      riskLevel: json['riskLevel'] as String,
      breakdown: ScoreBreakdown.fromJson(
        json['breakdown'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ComplianceScoreToJson(_ComplianceScore instance) =>
    <String, dynamic>{
      'score': instance.score,
      'riskLevel': instance.riskLevel,
      'breakdown': instance.breakdown,
    };

_ScoreBreakdown _$ScoreBreakdownFromJson(Map<String, dynamic> json) =>
    _ScoreBreakdown(
      baseScore: (json['baseScore'] as num).toInt(),
      issueDeduction: (json['issueDeduction'] as num).toInt(),
      warningDeduction: (json['warningDeduction'] as num).toInt(),
      compliantWorkers: (json['compliantWorkers'] as num).toInt(),
      totalWorkers: (json['totalWorkers'] as num).toInt(),
      complianceRate: (json['complianceRate'] as num).toInt(),
    );

Map<String, dynamic> _$ScoreBreakdownToJson(_ScoreBreakdown instance) =>
    <String, dynamic>{
      'baseScore': instance.baseScore,
      'issueDeduction': instance.issueDeduction,
      'warningDeduction': instance.warningDeduction,
      'compliantWorkers': instance.compliantWorkers,
      'totalWorkers': instance.totalWorkers,
      'complianceRate': instance.complianceRate,
    };

_ComplianceIssue _$ComplianceIssueFromJson(Map<String, dynamic> json) =>
    _ComplianceIssue(
      type: json['type'] as String,
      count: (json['count'] as num).toInt(),
      message: json['message'] as String,
      severity: json['severity'] as String,
    );

Map<String, dynamic> _$ComplianceIssueToJson(_ComplianceIssue instance) =>
    <String, dynamic>{
      'type': instance.type,
      'count': instance.count,
      'message': instance.message,
      'severity': instance.severity,
    };

_ComplianceSummary _$ComplianceSummaryFromJson(Map<String, dynamic> json) =>
    _ComplianceSummary(
      totalIssues: (json['totalIssues'] as num).toInt(),
      totalWarnings: (json['totalWarnings'] as num).toInt(),
      criticalCount: (json['criticalCount'] as num).toInt(),
      highCount: (json['highCount'] as num).toInt(),
      mediumCount: (json['mediumCount'] as num).toInt(),
    );

Map<String, dynamic> _$ComplianceSummaryToJson(_ComplianceSummary instance) =>
    <String, dynamic>{
      'totalIssues': instance.totalIssues,
      'totalWarnings': instance.totalWarnings,
      'criticalCount': instance.criticalCount,
      'highCount': instance.highCount,
      'mediumCount': instance.mediumCount,
    };

_ExpiringDocument _$ExpiringDocumentFromJson(Map<String, dynamic> json) =>
    _ExpiringDocument(
      workerId: json['workerId'] as String,
      workerName: json['workerName'] as String,
      documentType: json['documentType'] as String,
      expiryDate: json['expiryDate'] as String,
      daysUntilExpiry: (json['daysUntilExpiry'] as num).toInt(),
      severity: json['severity'] as String,
    );

Map<String, dynamic> _$ExpiringDocumentToJson(_ExpiringDocument instance) =>
    <String, dynamic>{
      'workerId': instance.workerId,
      'workerName': instance.workerName,
      'documentType': instance.documentType,
      'expiryDate': instance.expiryDate,
      'daysUntilExpiry': instance.daysUntilExpiry,
      'severity': instance.severity,
    };

_ComplianceAlert _$ComplianceAlertFromJson(Map<String, dynamic> json) =>
    _ComplianceAlert(
      alertId: json['alertId'] as String,
      type: json['type'] as String,
      message: json['message'] as String,
      severity: json['severity'] as String,
      createdAt: json['createdAt'] as String,
      sentDate: json['sentDate'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$ComplianceAlertToJson(_ComplianceAlert instance) =>
    <String, dynamic>{
      'alertId': instance.alertId,
      'type': instance.type,
      'message': instance.message,
      'severity': instance.severity,
      'createdAt': instance.createdAt,
      'sentDate': instance.sentDate,
      'status': instance.status,
    };

_ComplianceReport _$ComplianceReportFromJson(
  Map<String, dynamic> json,
) => _ComplianceReport(
  reportId: json['reportId'] as String,
  organizationId: json['organizationId'] as String,
  reportType: json['reportType'] as String,
  generatedDate: json['generatedDate'] as String,
  complianceScore: ComplianceScore.fromJson(
    json['complianceScore'] as Map<String, dynamic>,
  ),
  summary: ComplianceSummary.fromJson(json['summary'] as Map<String, dynamic>),
  expiringDocuments: (json['expiringDocuments'] as List<dynamic>)
      .map((e) => ExpiringDocument.fromJson(e as Map<String, dynamic>))
      .toList(),
  recommendations: (json['recommendations'] as List<dynamic>)
      .map((e) => ComplianceRecommendation.fromJson(e as Map<String, dynamic>))
      .toList(),
  issues: (json['issues'] as List<dynamic>?)
      ?.map((e) => ComplianceIssue.fromJson(e as Map<String, dynamic>))
      .toList(),
  warnings: (json['warnings'] as List<dynamic>?)
      ?.map((e) => ComplianceIssue.fromJson(e as Map<String, dynamic>))
      .toList(),
  auditTrail: json['auditTrail'] == null
      ? null
      : AuditTrail.fromJson(json['auditTrail'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ComplianceReportToJson(_ComplianceReport instance) =>
    <String, dynamic>{
      'reportId': instance.reportId,
      'organizationId': instance.organizationId,
      'reportType': instance.reportType,
      'generatedDate': instance.generatedDate,
      'complianceScore': instance.complianceScore,
      'summary': instance.summary,
      'expiringDocuments': instance.expiringDocuments,
      'recommendations': instance.recommendations,
      'issues': instance.issues,
      'warnings': instance.warnings,
      'auditTrail': instance.auditTrail,
    };

_ComplianceRecommendation _$ComplianceRecommendationFromJson(
  Map<String, dynamic> json,
) => _ComplianceRecommendation(
  priority: json['priority'] as String,
  action: json['action'] as String,
  description: json['description'] as String,
);

Map<String, dynamic> _$ComplianceRecommendationToJson(
  _ComplianceRecommendation instance,
) => <String, dynamic>{
  'priority': instance.priority,
  'action': instance.action,
  'description': instance.description,
};

_AuditTrail _$AuditTrailFromJson(Map<String, dynamic> json) => _AuditTrail(
  lastAuditDate: json['lastAuditDate'] as String,
  nextAuditDate: json['nextAuditDate'] as String,
  complianceHistory: json['complianceHistory'] as List<dynamic>,
);

Map<String, dynamic> _$AuditTrailToJson(_AuditTrail instance) =>
    <String, dynamic>{
      'lastAuditDate': instance.lastAuditDate,
      'nextAuditDate': instance.nextAuditDate,
      'complianceHistory': instance.complianceHistory,
    };

_ComplianceTrend _$ComplianceTrendFromJson(Map<String, dynamic> json) =>
    _ComplianceTrend(
      month: json['month'] as String,
      score: (json['score'] as num).toInt(),
      issues: (json['issues'] as num).toInt(),
      warnings: (json['warnings'] as num).toInt(),
      compliantWorkers: (json['compliantWorkers'] as num).toInt(),
    );

Map<String, dynamic> _$ComplianceTrendToJson(_ComplianceTrend instance) =>
    <String, dynamic>{
      'month': instance.month,
      'score': instance.score,
      'issues': instance.issues,
      'warnings': instance.warnings,
      'compliantWorkers': instance.compliantWorkers,
    };

_ComplianceTrends _$ComplianceTrendsFromJson(Map<String, dynamic> json) =>
    _ComplianceTrends(
      organizationId: json['organizationId'] as String,
      period: json['period'] as String,
      trendDirection: json['trendDirection'] as String,
      trends: (json['trends'] as List<dynamic>)
          .map((e) => ComplianceTrend.fromJson(e as Map<String, dynamic>))
          .toList(),
      summary: TrendSummary.fromJson(json['summary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ComplianceTrendsToJson(_ComplianceTrends instance) =>
    <String, dynamic>{
      'organizationId': instance.organizationId,
      'period': instance.period,
      'trendDirection': instance.trendDirection,
      'trends': instance.trends,
      'summary': instance.summary,
    };

_TrendSummary _$TrendSummaryFromJson(Map<String, dynamic> json) =>
    _TrendSummary(
      averageScore: (json['averageScore'] as num).toInt(),
      highestScore: (json['highestScore'] as num).toInt(),
      lowestScore: (json['lowestScore'] as num).toInt(),
      improvement: (json['improvement'] as num).toInt(),
    );

Map<String, dynamic> _$TrendSummaryToJson(_TrendSummary instance) =>
    <String, dynamic>{
      'averageScore': instance.averageScore,
      'highestScore': instance.highestScore,
      'lowestScore': instance.lowestScore,
      'improvement': instance.improvement,
    };
