// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workforce_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DemandForecast _$DemandForecastFromJson(Map<String, dynamic> json) =>
    _DemandForecast(
      date: DateTime.parse(json['date'] as String),
      predicted: (json['predicted'] as num).toInt(),
      lower: (json['lower'] as num).toInt(),
      upper: (json['upper'] as num).toInt(),
    );

Map<String, dynamic> _$DemandForecastToJson(_DemandForecast instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'predicted': instance.predicted,
      'lower': instance.lower,
      'upper': instance.upper,
    };

_SeasonalPattern _$SeasonalPatternFromJson(Map<String, dynamic> json) =>
    _SeasonalPattern(
      day: (json['day'] as num).toInt(),
      average: (json['average'] as num).toDouble(),
      variance: (json['variance'] as num).toDouble(),
    );

Map<String, dynamic> _$SeasonalPatternToJson(_SeasonalPattern instance) =>
    <String, dynamic>{
      'day': instance.day,
      'average': instance.average,
      'variance': instance.variance,
    };

_ForecastConfidence _$ForecastConfidenceFromJson(Map<String, dynamic> json) =>
    _ForecastConfidence(
      mae: (json['mae'] as num).toDouble(),
      rmse: (json['rmse'] as num).toDouble(),
      accuracy: (json['accuracy'] as num).toDouble(),
    );

Map<String, dynamic> _$ForecastConfidenceToJson(_ForecastConfidence instance) =>
    <String, dynamic>{
      'mae': instance.mae,
      'rmse': instance.rmse,
      'accuracy': instance.accuracy,
    };

_WorkforcePlan _$WorkforcePlanFromJson(Map<String, dynamic> json) =>
    _WorkforcePlan(
      currentCapacity: (json['currentCapacity'] as num).toInt(),
      requiredCapacity: (json['requiredCapacity'] as num).toInt(),
      surplus: (json['surplus'] as num).toInt(),
      utilizationRate: (json['utilizationRate'] as num).toDouble(),
      recommendation: json['recommendation'] as String,
    );

Map<String, dynamic> _$WorkforcePlanToJson(_WorkforcePlan instance) =>
    <String, dynamic>{
      'currentCapacity': instance.currentCapacity,
      'requiredCapacity': instance.requiredCapacity,
      'surplus': instance.surplus,
      'utilizationRate': instance.utilizationRate,
      'recommendation': instance.recommendation,
    };

_SkillGap _$SkillGapFromJson(Map<String, dynamic> json) => _SkillGap(
      skill: json['skill'] as String,
      current: (json['current'] as num).toInt(),
      required: (json['required'] as num).toInt(),
      gap: (json['gap'] as num).toInt(),
    );

Map<String, dynamic> _$SkillGapToJson(_SkillGap instance) => <String, dynamic>{
      'skill': instance.skill,
      'current': instance.current,
      'required': instance.required,
      'gap': instance.gap,
    };

_TurnoverPrediction _$TurnoverPredictionFromJson(Map<String, dynamic> json) =>
    _TurnoverPrediction(
      employeeId: json['employeeId'] as String,
      riskScore: (json['riskScore'] as num).toDouble(),
      riskLevel: json['riskLevel'] as String,
      factors:
          (json['factors'] as List<dynamic>).map((e) => e as String).toList(),
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$TurnoverPredictionToJson(_TurnoverPrediction instance) =>
    <String, dynamic>{
      'employeeId': instance.employeeId,
      'riskScore': instance.riskScore,
      'riskLevel': instance.riskLevel,
      'factors': instance.factors,
      'recommendations': instance.recommendations,
    };

_ScenarioAnalysis _$ScenarioAnalysisFromJson(Map<String, dynamic> json) =>
    _ScenarioAnalysis(
      name: json['name'] as String,
      projectedRevenue: (json['projectedRevenue'] as num).toDouble(),
      projectedCost: (json['projectedCost'] as num).toDouble(),
      netBenefit: (json['netBenefit'] as num).toDouble(),
      feasibility: json['feasibility'] as String,
      roi: (json['roi'] as num).toDouble(),
    );

Map<String, dynamic> _$ScenarioAnalysisToJson(_ScenarioAnalysis instance) =>
    <String, dynamic>{
      'name': instance.name,
      'projectedRevenue': instance.projectedRevenue,
      'projectedCost': instance.projectedCost,
      'netBenefit': instance.netBenefit,
      'feasibility': instance.feasibility,
      'roi': instance.roi,
    };

_ResourceAllocation _$ResourceAllocationFromJson(Map<String, dynamic> json) =>
    _ResourceAllocation(
      appointmentId: json['appointmentId'] as String,
      workerId: json['workerId'] as String,
      score: (json['score'] as num).toDouble(),
      cost: (json['cost'] as num).toDouble(),
    );

Map<String, dynamic> _$ResourceAllocationToJson(_ResourceAllocation instance) =>
    <String, dynamic>{
      'appointmentId': instance.appointmentId,
      'workerId': instance.workerId,
      'score': instance.score,
      'cost': instance.cost,
    };

_AllocationMetrics _$AllocationMetricsFromJson(Map<String, dynamic> json) =>
    _AllocationMetrics(
      totalAllocations: (json['totalAllocations'] as num).toInt(),
      averageScore: (json['averageScore'] as num).toDouble(),
      totalCost: (json['totalCost'] as num).toDouble(),
      utilizationRate: (json['utilizationRate'] as num).toDouble(),
      unassignedCount: (json['unassignedCount'] as num).toInt(),
      conflictCount: (json['conflictCount'] as num).toInt(),
    );

Map<String, dynamic> _$AllocationMetricsToJson(_AllocationMetrics instance) =>
    <String, dynamic>{
      'totalAllocations': instance.totalAllocations,
      'averageScore': instance.averageScore,
      'totalCost': instance.totalCost,
      'utilizationRate': instance.utilizationRate,
      'unassignedCount': instance.unassignedCount,
      'conflictCount': instance.conflictCount,
    };

_WorkerRecommendation _$WorkerRecommendationFromJson(
        Map<String, dynamic> json) =>
    _WorkerRecommendation(
      workerId: json['workerId'] as String,
      workerName: json['workerName'] as String,
      score: (json['score'] as num).toDouble(),
      factors: json['factors'] as Map<String, dynamic>,
      availability: json['availability'] as bool,
    );

Map<String, dynamic> _$WorkerRecommendationToJson(
        _WorkerRecommendation instance) =>
    <String, dynamic>{
      'workerId': instance.workerId,
      'workerName': instance.workerName,
      'score': instance.score,
      'factors': instance.factors,
      'availability': instance.availability,
    };

_WorkloadAnalysis _$WorkloadAnalysisFromJson(Map<String, dynamic> json) =>
    _WorkloadAnalysis(
      workerId: json['workerId'] as String,
      workerName: json['workerName'] as String,
      appointments: (json['appointments'] as num).toInt(),
      hours: (json['hours'] as num).toDouble(),
      utilization: (json['utilization'] as num).toDouble(),
    );

Map<String, dynamic> _$WorkloadAnalysisToJson(_WorkloadAnalysis instance) =>
    <String, dynamic>{
      'workerId': instance.workerId,
      'workerName': instance.workerName,
      'appointments': instance.appointments,
      'hours': instance.hours,
      'utilization': instance.utilization,
    };

_PerformanceMetrics _$PerformanceMetricsFromJson(Map<String, dynamic> json) =>
    _PerformanceMetrics(
      totalAppointments: (json['totalAppointments'] as num).toInt(),
      avgRating: (json['avgRating'] as num).toDouble(),
      completionRate: (json['completionRate'] as num).toDouble(),
      revenue: (json['revenue'] as num).toDouble(),
      revenuePerAppointment: (json['revenuePerAppointment'] as num).toDouble(),
      punctualityScore: (json['punctualityScore'] as num).toDouble(),
      qualityScore: (json['qualityScore'] as num).toDouble(),
    );

Map<String, dynamic> _$PerformanceMetricsToJson(_PerformanceMetrics instance) =>
    <String, dynamic>{
      'totalAppointments': instance.totalAppointments,
      'avgRating': instance.avgRating,
      'completionRate': instance.completionRate,
      'revenue': instance.revenue,
      'revenuePerAppointment': instance.revenuePerAppointment,
      'punctualityScore': instance.punctualityScore,
      'qualityScore': instance.qualityScore,
    };

_PerformanceAnalytics _$PerformanceAnalyticsFromJson(
        Map<String, dynamic> json) =>
    _PerformanceAnalytics(
      employeeId: json['employeeId'] as String,
      employeeName: json['employeeName'] as String,
      metrics:
          PerformanceMetrics.fromJson(json['metrics'] as Map<String, dynamic>),
      trends: PerformanceTrend.fromJson(json['trends'] as Map<String, dynamic>),
      comparison:
          PeerComparison.fromJson(json['comparison'] as Map<String, dynamic>),
      score: (json['score'] as num).toDouble(),
    );

Map<String, dynamic> _$PerformanceAnalyticsToJson(
        _PerformanceAnalytics instance) =>
    <String, dynamic>{
      'employeeId': instance.employeeId,
      'employeeName': instance.employeeName,
      'metrics': instance.metrics,
      'trends': instance.trends,
      'comparison': instance.comparison,
      'score': instance.score,
    };

_PerformanceTrend _$PerformanceTrendFromJson(Map<String, dynamic> json) =>
    _PerformanceTrend(
      direction: json['direction'] as String,
      growth: (json['growth'] as num).toDouble(),
      volatility: (json['volatility'] as num).toDouble(),
    );

Map<String, dynamic> _$PerformanceTrendToJson(_PerformanceTrend instance) =>
    <String, dynamic>{
      'direction': instance.direction,
      'growth': instance.growth,
      'volatility': instance.volatility,
    };

_PeerComparison _$PeerComparisonFromJson(Map<String, dynamic> json) =>
    _PeerComparison(
      avgPeerScore: (json['avgPeerScore'] as num).toDouble(),
      percentile: (json['percentile'] as num).toDouble(),
      ranking: json['ranking'] as String,
    );

Map<String, dynamic> _$PeerComparisonToJson(_PeerComparison instance) =>
    <String, dynamic>{
      'avgPeerScore': instance.avgPeerScore,
      'percentile': instance.percentile,
      'ranking': instance.ranking,
    };

_SkillProficiency _$SkillProficiencyFromJson(Map<String, dynamic> json) =>
    _SkillProficiency(
      skill: json['skill'] as String,
      level: json['level'] as String,
      certifications: (json['certifications'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      lastAssessed: DateTime.parse(json['lastAssessed'] as String),
      growthRate: (json['growthRate'] as num).toDouble(),
      recommendation: json['recommendation'] as String,
    );

Map<String, dynamic> _$SkillProficiencyToJson(_SkillProficiency instance) =>
    <String, dynamic>{
      'skill': instance.skill,
      'level': instance.level,
      'certifications': instance.certifications,
      'lastAssessed': instance.lastAssessed.toIso8601String(),
      'growthRate': instance.growthRate,
      'recommendation': instance.recommendation,
    };

_QualityScore _$QualityScoreFromJson(Map<String, dynamic> json) =>
    _QualityScore(
      appointmentId: json['appointmentId'] as String,
      overallScore: (json['overallScore'] as num).toDouble(),
      factors: QualityFactors.fromJson(json['factors'] as Map<String, dynamic>),
      grade: json['grade'] as String,
      issues: (json['issues'] as List<dynamic>)
          .map((e) => QualityIssue.fromJson(e as Map<String, dynamic>))
          .toList(),
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      assessedAt: DateTime.parse(json['assessedAt'] as String),
    );

Map<String, dynamic> _$QualityScoreToJson(_QualityScore instance) =>
    <String, dynamic>{
      'appointmentId': instance.appointmentId,
      'overallScore': instance.overallScore,
      'factors': instance.factors,
      'grade': instance.grade,
      'issues': instance.issues,
      'recommendations': instance.recommendations,
      'assessedAt': instance.assessedAt.toIso8601String(),
    };

_QualityFactors _$QualityFactorsFromJson(Map<String, dynamic> json) =>
    _QualityFactors(
      punctuality: (json['punctuality'] as num).toDouble(),
      completion: (json['completion'] as num).toDouble(),
      clientSatisfaction: (json['clientSatisfaction'] as num).toDouble(),
      documentation: (json['documentation'] as num).toDouble(),
      compliance: (json['compliance'] as num).toDouble(),
    );

Map<String, dynamic> _$QualityFactorsToJson(_QualityFactors instance) =>
    <String, dynamic>{
      'punctuality': instance.punctuality,
      'completion': instance.completion,
      'clientSatisfaction': instance.clientSatisfaction,
      'documentation': instance.documentation,
      'compliance': instance.compliance,
    };

_QualityIssue _$QualityIssueFromJson(Map<String, dynamic> json) =>
    _QualityIssue(
      type: json['type'] as String,
      severity: json['severity'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$QualityIssueToJson(_QualityIssue instance) =>
    <String, dynamic>{
      'type': instance.type,
      'severity': instance.severity,
      'message': instance.message,
    };

_ComplianceCheck _$ComplianceCheckFromJson(Map<String, dynamic> json) =>
    _ComplianceCheck(
      appointmentId: json['appointmentId'] as String,
      checks: (json['checks'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, ComplianceResult.fromJson(e as Map<String, dynamic>)),
      ),
      compliant: json['compliant'] as bool,
      violations: (json['violations'] as List<dynamic>)
          .map((e) => ComplianceViolation.fromJson(e as Map<String, dynamic>))
          .toList(),
      riskLevel: json['riskLevel'] as String,
    );

Map<String, dynamic> _$ComplianceCheckToJson(_ComplianceCheck instance) =>
    <String, dynamic>{
      'appointmentId': instance.appointmentId,
      'checks': instance.checks,
      'compliant': instance.compliant,
      'violations': instance.violations,
      'riskLevel': instance.riskLevel,
    };

_ComplianceResult _$ComplianceResultFromJson(Map<String, dynamic> json) =>
    _ComplianceResult(
      passed: json['passed'] as bool,
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$ComplianceResultToJson(_ComplianceResult instance) =>
    <String, dynamic>{
      'passed': instance.passed,
      'reason': instance.reason,
    };

_ComplianceViolation _$ComplianceViolationFromJson(Map<String, dynamic> json) =>
    _ComplianceViolation(
      check: json['check'] as String,
      reason: json['reason'] as String,
    );

Map<String, dynamic> _$ComplianceViolationToJson(
        _ComplianceViolation instance) =>
    <String, dynamic>{
      'check': instance.check,
      'reason': instance.reason,
    };

_SentimentAnalysis _$SentimentAnalysisFromJson(Map<String, dynamic> json) =>
    _SentimentAnalysis(
      appointmentId: json['appointmentId'] as String,
      feedback: json['feedback'] as String,
      sentiment: json['sentiment'] as String,
      score: (json['score'] as num).toDouble(),
      confidence: (json['confidence'] as num).toDouble(),
      keywords:
          (json['keywords'] as List<dynamic>).map((e) => e as String).toList(),
      topics:
          (json['topics'] as List<dynamic>).map((e) => e as String).toList(),
      rating: (json['rating'] as num).toDouble(),
    );

Map<String, dynamic> _$SentimentAnalysisToJson(_SentimentAnalysis instance) =>
    <String, dynamic>{
      'appointmentId': instance.appointmentId,
      'feedback': instance.feedback,
      'sentiment': instance.sentiment,
      'score': instance.score,
      'confidence': instance.confidence,
      'keywords': instance.keywords,
      'topics': instance.topics,
      'rating': instance.rating,
    };

_RiskAssessment _$RiskAssessmentFromJson(Map<String, dynamic> json) =>
    _RiskAssessment(
      appointmentId: json['appointmentId'] as String,
      riskScore: (json['riskScore'] as num).toDouble(),
      riskLevel: json['riskLevel'] as String,
      factors: RiskFactors.fromJson(json['factors'] as Map<String, dynamic>),
      mitigations: (json['mitigations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      requiresApproval: json['requiresApproval'] as bool,
    );

Map<String, dynamic> _$RiskAssessmentToJson(_RiskAssessment instance) =>
    <String, dynamic>{
      'appointmentId': instance.appointmentId,
      'riskScore': instance.riskScore,
      'riskLevel': instance.riskLevel,
      'factors': instance.factors,
      'mitigations': instance.mitigations,
      'requiresApproval': instance.requiresApproval,
    };

_RiskFactors _$RiskFactorsFromJson(Map<String, dynamic> json) => _RiskFactors(
      workerExperience: (json['workerExperience'] as num).toDouble(),
      clientComplexity: (json['clientComplexity'] as num).toDouble(),
      serviceType: (json['serviceType'] as num).toDouble(),
      location: (json['location'] as num).toDouble(),
      timeOfDay: (json['timeOfDay'] as num).toDouble(),
    );

Map<String, dynamic> _$RiskFactorsToJson(_RiskFactors instance) =>
    <String, dynamic>{
      'workerExperience': instance.workerExperience,
      'clientComplexity': instance.clientComplexity,
      'serviceType': instance.serviceType,
      'location': instance.location,
      'timeOfDay': instance.timeOfDay,
    };

_IncidentPattern _$IncidentPatternFromJson(Map<String, dynamic> json) =>
    _IncidentPattern(
      totalIncidents: (json['totalIncidents'] as num).toInt(),
      patterns: json['patterns'] as Map<String, dynamic>,
      recurringIssues: (json['recurringIssues'] as List<dynamic>)
          .map((e) => RecurringIssue.fromJson(e as Map<String, dynamic>))
          .toList(),
      preventiveActions: (json['preventiveActions'] as List<dynamic>)
          .map((e) => PreventiveAction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$IncidentPatternToJson(_IncidentPattern instance) =>
    <String, dynamic>{
      'totalIncidents': instance.totalIncidents,
      'patterns': instance.patterns,
      'recurringIssues': instance.recurringIssues,
      'preventiveActions': instance.preventiveActions,
    };

_RecurringIssue _$RecurringIssueFromJson(Map<String, dynamic> json) =>
    _RecurringIssue(
      type: json['type'] as String,
      description: json['description'] as String,
      severity: json['severity'] as String,
    );

Map<String, dynamic> _$RecurringIssueToJson(_RecurringIssue instance) =>
    <String, dynamic>{
      'type': instance.type,
      'description': instance.description,
      'severity': instance.severity,
    };

_PreventiveAction _$PreventiveActionFromJson(Map<String, dynamic> json) =>
    _PreventiveAction(
      action: json['action'] as String,
      priority: json['priority'] as String,
      expectedImpact: json['expectedImpact'] as String,
    );

Map<String, dynamic> _$PreventiveActionToJson(_PreventiveAction instance) =>
    <String, dynamic>{
      'action': instance.action,
      'priority': instance.priority,
      'expectedImpact': instance.expectedImpact,
    };

_ExecutiveDashboard _$ExecutiveDashboardFromJson(Map<String, dynamic> json) =>
    _ExecutiveDashboard(
      kpis: DashboardKPIs.fromJson(json['kpis'] as Map<String, dynamic>),
      revenue: RevenueMetrics.fromJson(json['revenue'] as Map<String, dynamic>),
      operations: OperationalMetrics.fromJson(
          json['operations'] as Map<String, dynamic>),
      clients: ClientMetrics.fromJson(json['clients'] as Map<String, dynamic>),
      workforce:
          WorkforceMetrics.fromJson(json['workforce'] as Map<String, dynamic>),
      trends: (json['trends'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, TrendData.fromJson(e as Map<String, dynamic>)),
      ),
      period: json['period'] as String,
      generatedAt: DateTime.parse(json['generatedAt'] as String),
    );

Map<String, dynamic> _$ExecutiveDashboardToJson(_ExecutiveDashboard instance) =>
    <String, dynamic>{
      'kpis': instance.kpis,
      'revenue': instance.revenue,
      'operations': instance.operations,
      'clients': instance.clients,
      'workforce': instance.workforce,
      'trends': instance.trends,
      'period': instance.period,
      'generatedAt': instance.generatedAt.toIso8601String(),
    };

_DashboardKPIs _$DashboardKPIsFromJson(Map<String, dynamic> json) =>
    _DashboardKPIs(
      totalRevenue: (json['totalRevenue'] as num).toDouble(),
      totalAppointments: (json['totalAppointments'] as num).toInt(),
      completedAppointments: (json['completedAppointments'] as num).toInt(),
      completionRate: (json['completionRate'] as num).toDouble(),
      avgRevenuePerAppointment:
          (json['avgRevenuePerAppointment'] as num).toDouble(),
      growth: (json['growth'] as num).toDouble(),
    );

Map<String, dynamic> _$DashboardKPIsToJson(_DashboardKPIs instance) =>
    <String, dynamic>{
      'totalRevenue': instance.totalRevenue,
      'totalAppointments': instance.totalAppointments,
      'completedAppointments': instance.completedAppointments,
      'completionRate': instance.completionRate,
      'avgRevenuePerAppointment': instance.avgRevenuePerAppointment,
      'growth': instance.growth,
    };

_RevenueMetrics _$RevenueMetricsFromJson(Map<String, dynamic> json) =>
    _RevenueMetrics(
      total: (json['total'] as num).toDouble(),
      count: (json['count'] as num).toInt(),
      avg: (json['avg'] as num).toDouble(),
    );

Map<String, dynamic> _$RevenueMetricsToJson(_RevenueMetrics instance) =>
    <String, dynamic>{
      'total': instance.total,
      'count': instance.count,
      'avg': instance.avg,
    };

_OperationalMetrics _$OperationalMetricsFromJson(Map<String, dynamic> json) =>
    _OperationalMetrics(
      utilization: (json['utilization'] as num).toDouble(),
      efficiency: (json['efficiency'] as num).toDouble(),
      onTimeRate: (json['onTimeRate'] as num).toDouble(),
      cancellationRate: (json['cancellationRate'] as num).toDouble(),
    );

Map<String, dynamic> _$OperationalMetricsToJson(_OperationalMetrics instance) =>
    <String, dynamic>{
      'utilization': instance.utilization,
      'efficiency': instance.efficiency,
      'onTimeRate': instance.onTimeRate,
      'cancellationRate': instance.cancellationRate,
    };

_ClientMetrics _$ClientMetricsFromJson(Map<String, dynamic> json) =>
    _ClientMetrics(
      total: (json['total'] as num).toInt(),
      active: (json['active'] as num).toInt(),
      retention: (json['retention'] as num).toDouble(),
      satisfaction: (json['satisfaction'] as num).toDouble(),
      nps: (json['nps'] as num).toInt(),
    );

Map<String, dynamic> _$ClientMetricsToJson(_ClientMetrics instance) =>
    <String, dynamic>{
      'total': instance.total,
      'active': instance.active,
      'retention': instance.retention,
      'satisfaction': instance.satisfaction,
      'nps': instance.nps,
    };

_WorkforceMetrics _$WorkforceMetricsFromJson(Map<String, dynamic> json) =>
    _WorkforceMetrics(
      total: (json['total'] as num).toInt(),
      utilization: (json['utilization'] as num).toDouble(),
      productivity: (json['productivity'] as num).toDouble(),
      satisfaction: (json['satisfaction'] as num).toDouble(),
      turnover: (json['turnover'] as num).toDouble(),
    );

Map<String, dynamic> _$WorkforceMetricsToJson(_WorkforceMetrics instance) =>
    <String, dynamic>{
      'total': instance.total,
      'utilization': instance.utilization,
      'productivity': instance.productivity,
      'satisfaction': instance.satisfaction,
      'turnover': instance.turnover,
    };

_TrendData _$TrendDataFromJson(Map<String, dynamic> json) => _TrendData(
      direction: json['direction'] as String,
      change: (json['change'] as num).toDouble(),
    );

Map<String, dynamic> _$TrendDataToJson(_TrendData instance) =>
    <String, dynamic>{
      'direction': instance.direction,
      'change': instance.change,
    };

_RevenueForecast _$RevenueForecastFromJson(Map<String, dynamic> json) =>
    _RevenueForecast(
      period: (json['period'] as num).toInt(),
      predicted: (json['predicted'] as num).toDouble(),
      lower: (json['lower'] as num).toDouble(),
      upper: (json['upper'] as num).toDouble(),
    );

Map<String, dynamic> _$RevenueForecastToJson(_RevenueForecast instance) =>
    <String, dynamic>{
      'period': instance.period,
      'predicted': instance.predicted,
      'lower': instance.lower,
      'upper': instance.upper,
    };

_ChurnPrediction _$ChurnPredictionFromJson(Map<String, dynamic> json) =>
    _ChurnPrediction(
      clientId: json['clientId'] as String,
      clientName: json['clientName'] as String,
      churnScore: (json['churnScore'] as num).toDouble(),
      churnRisk: json['churnRisk'] as String,
      factors: ChurnFactors.fromJson(json['factors'] as Map<String, dynamic>),
      interventions: (json['interventions'] as List<dynamic>)
          .map((e) => ChurnIntervention.fromJson(e as Map<String, dynamic>))
          .toList(),
      lifetimeValue: (json['lifetimeValue'] as num).toDouble(),
    );

Map<String, dynamic> _$ChurnPredictionToJson(_ChurnPrediction instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'clientName': instance.clientName,
      'churnScore': instance.churnScore,
      'churnRisk': instance.churnRisk,
      'factors': instance.factors,
      'interventions': instance.interventions,
      'lifetimeValue': instance.lifetimeValue,
    };

_ChurnFactors _$ChurnFactorsFromJson(Map<String, dynamic> json) =>
    _ChurnFactors(
      recency: (json['recency'] as num).toDouble(),
      frequency: (json['frequency'] as num).toDouble(),
      monetary: (json['monetary'] as num).toDouble(),
      satisfaction: (json['satisfaction'] as num).toDouble(),
      engagement: (json['engagement'] as num).toDouble(),
    );

Map<String, dynamic> _$ChurnFactorsToJson(_ChurnFactors instance) =>
    <String, dynamic>{
      'recency': instance.recency,
      'frequency': instance.frequency,
      'monetary': instance.monetary,
      'satisfaction': instance.satisfaction,
      'engagement': instance.engagement,
    };

_ChurnIntervention _$ChurnInterventionFromJson(Map<String, dynamic> json) =>
    _ChurnIntervention(
      action: json['action'] as String,
      priority: json['priority'] as String,
      expectedImpact: json['expectedImpact'] as String,
    );

Map<String, dynamic> _$ChurnInterventionToJson(_ChurnIntervention instance) =>
    <String, dynamic>{
      'action': instance.action,
      'priority': instance.priority,
      'expectedImpact': instance.expectedImpact,
    };

_ProfitabilityAnalysis _$ProfitabilityAnalysisFromJson(
        Map<String, dynamic> json) =>
    _ProfitabilityAnalysis(
      dimension: json['dimension'] as String,
      revenue: (json['revenue'] as num).toDouble(),
      cost: (json['cost'] as num).toDouble(),
      profit: (json['profit'] as num).toDouble(),
      margin: (json['margin'] as num).toDouble(),
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$ProfitabilityAnalysisToJson(
        _ProfitabilityAnalysis instance) =>
    <String, dynamic>{
      'dimension': instance.dimension,
      'revenue': instance.revenue,
      'cost': instance.cost,
      'profit': instance.profit,
      'margin': instance.margin,
      'count': instance.count,
    };

_WhatIfScenario _$WhatIfScenarioFromJson(Map<String, dynamic> json) =>
    _WhatIfScenario(
      name: json['name'] as String,
      baseline:
          ScenarioMetrics.fromJson(json['baseline'] as Map<String, dynamic>),
      projected:
          ScenarioMetrics.fromJson(json['projected'] as Map<String, dynamic>),
      impact: ScenarioImpact.fromJson(json['impact'] as Map<String, dynamic>),
      feasibility: ScenarioFeasibility.fromJson(
          json['feasibility'] as Map<String, dynamic>),
      recommendation: ScenarioRecommendation.fromJson(
          json['recommendation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WhatIfScenarioToJson(_WhatIfScenario instance) =>
    <String, dynamic>{
      'name': instance.name,
      'baseline': instance.baseline,
      'projected': instance.projected,
      'impact': instance.impact,
      'feasibility': instance.feasibility,
      'recommendation': instance.recommendation,
    };

_ScenarioMetrics _$ScenarioMetricsFromJson(Map<String, dynamic> json) =>
    _ScenarioMetrics(
      appointments: (json['appointments'] as num).toInt(),
      workers: (json['workers'] as num).toInt(),
      revenue: (json['revenue'] as num).toDouble(),
      avgRevenuePerWorker: (json['avgRevenuePerWorker'] as num).toDouble(),
    );

Map<String, dynamic> _$ScenarioMetricsToJson(_ScenarioMetrics instance) =>
    <String, dynamic>{
      'appointments': instance.appointments,
      'workers': instance.workers,
      'revenue': instance.revenue,
      'avgRevenuePerWorker': instance.avgRevenuePerWorker,
    };

_ScenarioImpact _$ScenarioImpactFromJson(Map<String, dynamic> json) =>
    _ScenarioImpact(
      revenueChange: (json['revenueChange'] as num).toDouble(),
      revenueChangePercent: json['revenueChangePercent'] as String,
      appointmentChange: (json['appointmentChange'] as num).toInt(),
      workerChange: (json['workerChange'] as num).toInt(),
      productivityChange: (json['productivityChange'] as num).toDouble(),
    );

Map<String, dynamic> _$ScenarioImpactToJson(_ScenarioImpact instance) =>
    <String, dynamic>{
      'revenueChange': instance.revenueChange,
      'revenueChangePercent': instance.revenueChangePercent,
      'appointmentChange': instance.appointmentChange,
      'workerChange': instance.workerChange,
      'productivityChange': instance.productivityChange,
    };

_ScenarioFeasibility _$ScenarioFeasibilityFromJson(Map<String, dynamic> json) =>
    _ScenarioFeasibility(
      scores: (json['scores'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      overall: (json['overall'] as num).toDouble(),
      rating: json['rating'] as String,
    );

Map<String, dynamic> _$ScenarioFeasibilityToJson(
        _ScenarioFeasibility instance) =>
    <String, dynamic>{
      'scores': instance.scores,
      'overall': instance.overall,
      'rating': instance.rating,
    };

_ScenarioRecommendation _$ScenarioRecommendationFromJson(
        Map<String, dynamic> json) =>
    _ScenarioRecommendation(
      decision: json['decision'] as String,
      confidence: json['confidence'] as String,
      reasoning: json['reasoning'] as String,
    );

Map<String, dynamic> _$ScenarioRecommendationToJson(
        _ScenarioRecommendation instance) =>
    <String, dynamic>{
      'decision': instance.decision,
      'confidence': instance.confidence,
      'reasoning': instance.reasoning,
    };

_CustomerLifetimeValue _$CustomerLifetimeValueFromJson(
        Map<String, dynamic> json) =>
    _CustomerLifetimeValue(
      clientId: json['clientId'] as String,
      clientName: json['clientName'] as String,
      clv: (json['clv'] as num).toDouble(),
      segment: json['segment'] as String,
      metrics: CLVMetrics.fromJson(json['metrics'] as Map<String, dynamic>),
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CustomerLifetimeValueToJson(
        _CustomerLifetimeValue instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'clientName': instance.clientName,
      'clv': instance.clv,
      'segment': instance.segment,
      'metrics': instance.metrics,
      'recommendations': instance.recommendations,
    };

_CLVMetrics _$CLVMetricsFromJson(Map<String, dynamic> json) => _CLVMetrics(
      totalRevenue: (json['totalRevenue'] as num).toDouble(),
      appointmentCount: (json['appointmentCount'] as num).toInt(),
      avgOrderValue: (json['avgOrderValue'] as num).toDouble(),
      frequency: (json['frequency'] as num).toDouble(),
      tenure: (json['tenure'] as num).toDouble(),
      churnProbability: (json['churnProbability'] as num).toDouble(),
    );

Map<String, dynamic> _$CLVMetricsToJson(_CLVMetrics instance) =>
    <String, dynamic>{
      'totalRevenue': instance.totalRevenue,
      'appointmentCount': instance.appointmentCount,
      'avgOrderValue': instance.avgOrderValue,
      'frequency': instance.frequency,
      'tenure': instance.tenure,
      'churnProbability': instance.churnProbability,
    };

_MLModel _$MLModelFromJson(Map<String, dynamic> json) => _MLModel(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      version: json['version'] as String,
      status: json['status'] as String,
      trainedAt: DateTime.parse(json['trainedAt'] as String),
      metrics: MLMetrics.fromJson(json['metrics'] as Map<String, dynamic>),
      features:
          (json['features'] as List<dynamic>).map((e) => e as String).toList(),
      hyperparameters: json['hyperparameters'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$MLModelToJson(_MLModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'version': instance.version,
      'status': instance.status,
      'trainedAt': instance.trainedAt.toIso8601String(),
      'metrics': instance.metrics,
      'features': instance.features,
      'hyperparameters': instance.hyperparameters,
    };

_MLMetrics _$MLMetricsFromJson(Map<String, dynamic> json) => _MLMetrics(
      accuracy: (json['accuracy'] as num).toDouble(),
      precision: (json['precision'] as num).toDouble(),
      recall: (json['recall'] as num).toDouble(),
      f1Score: (json['f1Score'] as num).toDouble(),
    );

Map<String, dynamic> _$MLMetricsToJson(_MLMetrics instance) =>
    <String, dynamic>{
      'accuracy': instance.accuracy,
      'precision': instance.precision,
      'recall': instance.recall,
      'f1Score': instance.f1Score,
    };

_MLPrediction _$MLPredictionFromJson(Map<String, dynamic> json) =>
    _MLPrediction(
      modelId: json['modelId'] as String,
      prediction:
          PredictionResult.fromJson(json['prediction'] as Map<String, dynamic>),
      confidence: (json['confidence'] as num).toDouble(),
      features: json['features'] as Map<String, dynamic>,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$MLPredictionToJson(_MLPrediction instance) =>
    <String, dynamic>{
      'modelId': instance.modelId,
      'prediction': instance.prediction,
      'confidence': instance.confidence,
      'features': instance.features,
      'timestamp': instance.timestamp.toIso8601String(),
    };

_PredictionResult _$PredictionResultFromJson(Map<String, dynamic> json) =>
    _PredictionResult(
      predictedClass: json['predictedClass'] as String,
      score: (json['score'] as num).toDouble(),
      probabilities: (json['probabilities'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
    );

Map<String, dynamic> _$PredictionResultToJson(_PredictionResult instance) =>
    <String, dynamic>{
      'predictedClass': instance.predictedClass,
      'score': instance.score,
      'probabilities': instance.probabilities,
    };
