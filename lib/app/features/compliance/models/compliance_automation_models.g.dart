// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compliance_automation_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ComplianceScanImpl _$$ComplianceScanImplFromJson(Map<String, dynamic> json) =>
    _$ComplianceScanImpl(
      organizationId: json['organizationId'] as String,
      scanDate: json['scanDate'] as String,
      complianceScore: ComplianceScore.fromJson(
          json['complianceScore'] as Map<String, dynamic>),
      issues: (json['issues'] as List<dynamic>)
          .map((e) => ComplianceIssue.fromJson(e as Map<String, dynamic>))
          .toList(),
      warnings: (json['warnings'] as List<dynamic>)
          .map((e) => ComplianceIssue.fromJson(e as Map<String, dynamic>))
          .toList(),
      summary:
          ComplianceSummary.fromJson(json['summary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ComplianceScanImplToJson(
        _$ComplianceScanImpl instance) =>
    <String, dynamic>{
      'organizationId': instance.organizationId,
      'scanDate': instance.scanDate,
      'complianceScore': instance.complianceScore,
      'issues': instance.issues,
      'warnings': instance.warnings,
      'summary': instance.summary,
    };

_$ComplianceScoreImpl _$$ComplianceScoreImplFromJson(
        Map<String, dynamic> json) =>
    _$ComplianceScoreImpl(
      score: (json['score'] as num).toInt(),
      riskLevel: json['riskLevel'] as String,
      breakdown:
          ScoreBreakdown.fromJson(json['breakdown'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ComplianceScoreImplToJson(
        _$ComplianceScoreImpl instance) =>
    <String, dynamic>{
      'score': instance.score,
      'riskLevel': instance.riskLevel,
      'breakdown': instance.breakdown,
    };

_$ScoreBreakdownImpl _$$ScoreBreakdownImplFromJson(Map<String, dynamic> json) =>
    _$ScoreBreakdownImpl(
      baseScore: (json['baseScore'] as num).toInt(),
      issueDeduction: (json['issueDeduction'] as num).toInt(),
      warningDeduction: (json['warningDeduction'] as num).toInt(),
      compliantWorkers: (json['compliantWorkers'] as num).toInt(),
      totalWorkers: (json['totalWorkers'] as num).toInt(),
      complianceRate: (json['complianceRate'] as num).toInt(),
    );

Map<String, dynamic> _$$ScoreBreakdownImplToJson(
        _$ScoreBreakdownImpl instance) =>
    <String, dynamic>{
      'baseScore': instance.baseScore,
      'issueDeduction': instance.issueDeduction,
      'warningDeduction': instance.warningDeduction,
      'compliantWorkers': instance.compliantWorkers,
      'totalWorkers': instance.totalWorkers,
      'complianceRate': instance.complianceRate,
    };

_$ComplianceIssueImpl _$$ComplianceIssueImplFromJson(
        Map<String, dynamic> json) =>
    _$ComplianceIssueImpl(
      type: json['type'] as String,
      count: (json['count'] as num).toInt(),
      message: json['message'] as String,
      severity: json['severity'] as String,
    );

Map<String, dynamic> _$$ComplianceIssueImplToJson(
        _$ComplianceIssueImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'count': instance.count,
      'message': instance.message,
      'severity': instance.severity,
    };

_$ComplianceSummaryImpl _$$ComplianceSummaryImplFromJson(
        Map<String, dynamic> json) =>
    _$ComplianceSummaryImpl(
      totalIssues: (json['totalIssues'] as num).toInt(),
      totalWarnings: (json['totalWarnings'] as num).toInt(),
      criticalCount: (json['criticalCount'] as num).toInt(),
      highCount: (json['highCount'] as num).toInt(),
      mediumCount: (json['mediumCount'] as num).toInt(),
    );

Map<String, dynamic> _$$ComplianceSummaryImplToJson(
        _$ComplianceSummaryImpl instance) =>
    <String, dynamic>{
      'totalIssues': instance.totalIssues,
      'totalWarnings': instance.totalWarnings,
      'criticalCount': instance.criticalCount,
      'highCount': instance.highCount,
      'mediumCount': instance.mediumCount,
    };

_$ExpiringDocumentImpl _$$ExpiringDocumentImplFromJson(
        Map<String, dynamic> json) =>
    _$ExpiringDocumentImpl(
      workerId: json['workerId'] as String,
      workerName: json['workerName'] as String,
      documentType: json['documentType'] as String,
      expiryDate: json['expiryDate'] as String,
      daysUntilExpiry: (json['daysUntilExpiry'] as num).toInt(),
      severity: json['severity'] as String,
    );

Map<String, dynamic> _$$ExpiringDocumentImplToJson(
        _$ExpiringDocumentImpl instance) =>
    <String, dynamic>{
      'workerId': instance.workerId,
      'workerName': instance.workerName,
      'documentType': instance.documentType,
      'expiryDate': instance.expiryDate,
      'daysUntilExpiry': instance.daysUntilExpiry,
      'severity': instance.severity,
    };

_$ComplianceAlertImpl _$$ComplianceAlertImplFromJson(
        Map<String, dynamic> json) =>
    _$ComplianceAlertImpl(
      alertId: json['alertId'] as String,
      type: json['type'] as String,
      message: json['message'] as String,
      severity: json['severity'] as String,
      createdAt: json['createdAt'] as String,
      sentDate: json['sentDate'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$ComplianceAlertImplToJson(
        _$ComplianceAlertImpl instance) =>
    <String, dynamic>{
      'alertId': instance.alertId,
      'type': instance.type,
      'message': instance.message,
      'severity': instance.severity,
      'createdAt': instance.createdAt,
      'sentDate': instance.sentDate,
      'status': instance.status,
    };

_$ComplianceReportImpl _$$ComplianceReportImplFromJson(
        Map<String, dynamic> json) =>
    _$ComplianceReportImpl(
      reportId: json['reportId'] as String,
      organizationId: json['organizationId'] as String,
      reportType: json['reportType'] as String,
      generatedDate: json['generatedDate'] as String,
      complianceScore: ComplianceScore.fromJson(
          json['complianceScore'] as Map<String, dynamic>),
      summary:
          ComplianceSummary.fromJson(json['summary'] as Map<String, dynamic>),
      expiringDocuments: (json['expiringDocuments'] as List<dynamic>)
          .map((e) => ExpiringDocument.fromJson(e as Map<String, dynamic>))
          .toList(),
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) =>
              ComplianceRecommendation.fromJson(e as Map<String, dynamic>))
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

Map<String, dynamic> _$$ComplianceReportImplToJson(
        _$ComplianceReportImpl instance) =>
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

_$ComplianceRecommendationImpl _$$ComplianceRecommendationImplFromJson(
        Map<String, dynamic> json) =>
    _$ComplianceRecommendationImpl(
      priority: json['priority'] as String,
      action: json['action'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$$ComplianceRecommendationImplToJson(
        _$ComplianceRecommendationImpl instance) =>
    <String, dynamic>{
      'priority': instance.priority,
      'action': instance.action,
      'description': instance.description,
    };

_$AuditTrailImpl _$$AuditTrailImplFromJson(Map<String, dynamic> json) =>
    _$AuditTrailImpl(
      lastAuditDate: json['lastAuditDate'] as String,
      nextAuditDate: json['nextAuditDate'] as String,
      complianceHistory: json['complianceHistory'] as List<dynamic>,
    );

Map<String, dynamic> _$$AuditTrailImplToJson(_$AuditTrailImpl instance) =>
    <String, dynamic>{
      'lastAuditDate': instance.lastAuditDate,
      'nextAuditDate': instance.nextAuditDate,
      'complianceHistory': instance.complianceHistory,
    };

_$ComplianceTrendImpl _$$ComplianceTrendImplFromJson(
        Map<String, dynamic> json) =>
    _$ComplianceTrendImpl(
      month: json['month'] as String,
      score: (json['score'] as num).toInt(),
      issues: (json['issues'] as num).toInt(),
      warnings: (json['warnings'] as num).toInt(),
      compliantWorkers: (json['compliantWorkers'] as num).toInt(),
    );

Map<String, dynamic> _$$ComplianceTrendImplToJson(
        _$ComplianceTrendImpl instance) =>
    <String, dynamic>{
      'month': instance.month,
      'score': instance.score,
      'issues': instance.issues,
      'warnings': instance.warnings,
      'compliantWorkers': instance.compliantWorkers,
    };

_$ComplianceTrendsImpl _$$ComplianceTrendsImplFromJson(
        Map<String, dynamic> json) =>
    _$ComplianceTrendsImpl(
      organizationId: json['organizationId'] as String,
      period: json['period'] as String,
      trendDirection: json['trendDirection'] as String,
      trends: (json['trends'] as List<dynamic>)
          .map((e) => ComplianceTrend.fromJson(e as Map<String, dynamic>))
          .toList(),
      summary: TrendSummary.fromJson(json['summary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ComplianceTrendsImplToJson(
        _$ComplianceTrendsImpl instance) =>
    <String, dynamic>{
      'organizationId': instance.organizationId,
      'period': instance.period,
      'trendDirection': instance.trendDirection,
      'trends': instance.trends,
      'summary': instance.summary,
    };

_$TrendSummaryImpl _$$TrendSummaryImplFromJson(Map<String, dynamic> json) =>
    _$TrendSummaryImpl(
      averageScore: (json['averageScore'] as num).toInt(),
      highestScore: (json['highestScore'] as num).toInt(),
      lowestScore: (json['lowestScore'] as num).toInt(),
      improvement: (json['improvement'] as num).toInt(),
    );

Map<String, dynamic> _$$TrendSummaryImplToJson(_$TrendSummaryImpl instance) =>
    <String, dynamic>{
      'averageScore': instance.averageScore,
      'highestScore': instance.highestScore,
      'lowestScore': instance.lowestScore,
      'improvement': instance.improvement,
    };
