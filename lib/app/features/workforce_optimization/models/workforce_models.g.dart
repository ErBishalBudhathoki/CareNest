// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workforce_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DemandForecastImpl _$$DemandForecastImplFromJson(Map<String, dynamic> json) =>
    _$DemandForecastImpl(
      date: DateTime.parse(json['date'] as String),
      predicted: (json['predicted'] as num).toInt(),
      lower: (json['lower'] as num).toInt(),
      upper: (json['upper'] as num).toInt(),
    );

Map<String, dynamic> _$$DemandForecastImplToJson(
        _$DemandForecastImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'predicted': instance.predicted,
      'lower': instance.lower,
      'upper': instance.upper,
    };

_$SeasonalPatternImpl _$$SeasonalPatternImplFromJson(
        Map<String, dynamic> json) =>
    _$SeasonalPatternImpl(
      day: (json['day'] as num).toInt(),
      average: (json['average'] as num).toDouble(),
      variance: (json['variance'] as num).toDouble(),
    );

Map<String, dynamic> _$$SeasonalPatternImplToJson(
        _$SeasonalPatternImpl instance) =>
    <String, dynamic>{
      'day': instance.day,
      'average': instance.average,
      'variance': instance.variance,
    };

_$ForecastConfidenceImpl _$$ForecastConfidenceImplFromJson(
        Map<String, dynamic> json) =>
    _$ForecastConfidenceImpl(
      mae: (json['mae'] as num).toDouble(),
      rmse: (json['rmse'] as num).toDouble(),
      accuracy: (json['accuracy'] as num).toDouble(),
    );

Map<String, dynamic> _$$ForecastConfidenceImplToJson(
        _$ForecastConfidenceImpl instance) =>
    <String, dynamic>{
      'mae': instance.mae,
      'rmse': instance.rmse,
      'accuracy': instance.accuracy,
    };

_$WorkforcePlanImpl _$$WorkforcePlanImplFromJson(Map<String, dynamic> json) =>
    _$WorkforcePlanImpl(
      currentCapacity: (json['currentCapacity'] as num).toInt(),
      requiredCapacity: (json['requiredCapacity'] as num).toInt(),
      surplus: (json['surplus'] as num).toInt(),
      utilizationRate: (json['utilizationRate'] as num).toDouble(),
      recommendation: json['recommendation'] as String,
    );

Map<String, dynamic> _$$WorkforcePlanImplToJson(_$WorkforcePlanImpl instance) =>
    <String, dynamic>{
      'currentCapacity': instance.currentCapacity,
      'requiredCapacity': instance.requiredCapacity,
      'surplus': instance.surplus,
      'utilizationRate': instance.utilizationRate,
      'recommendation': instance.recommendation,
    };

_$SkillGapImpl _$$SkillGapImplFromJson(Map<String, dynamic> json) =>
    _$SkillGapImpl(
      skill: json['skill'] as String,
      current: (json['current'] as num).toInt(),
      required: (json['required'] as num).toInt(),
      gap: (json['gap'] as num).toInt(),
    );

Map<String, dynamic> _$$SkillGapImplToJson(_$SkillGapImpl instance) =>
    <String, dynamic>{
      'skill': instance.skill,
      'current': instance.current,
      'required': instance.required,
      'gap': instance.gap,
    };

_$TurnoverPredictionImpl _$$TurnoverPredictionImplFromJson(
        Map<String, dynamic> json) =>
    _$TurnoverPredictionImpl(
      employeeId: json['employeeId'] as String,
      riskScore: (json['riskScore'] as num).toDouble(),
      riskLevel: json['riskLevel'] as String,
      factors:
          (json['factors'] as List<dynamic>).map((e) => e as String).toList(),
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$TurnoverPredictionImplToJson(
        _$TurnoverPredictionImpl instance) =>
    <String, dynamic>{
      'employeeId': instance.employeeId,
      'riskScore': instance.riskScore,
      'riskLevel': instance.riskLevel,
      'factors': instance.factors,
      'recommendations': instance.recommendations,
    };

_$ScenarioAnalysisImpl _$$ScenarioAnalysisImplFromJson(
        Map<String, dynamic> json) =>
    _$ScenarioAnalysisImpl(
      name: json['name'] as String,
      projectedRevenue: (json['projectedRevenue'] as num).toDouble(),
      projectedCost: (json['projectedCost'] as num).toDouble(),
      netBenefit: (json['netBenefit'] as num).toDouble(),
      feasibility: json['feasibility'] as String,
      roi: (json['roi'] as num).toDouble(),
    );

Map<String, dynamic> _$$ScenarioAnalysisImplToJson(
        _$ScenarioAnalysisImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'projectedRevenue': instance.projectedRevenue,
      'projectedCost': instance.projectedCost,
      'netBenefit': instance.netBenefit,
      'feasibility': instance.feasibility,
      'roi': instance.roi,
    };

_$ResourceAllocationImpl _$$ResourceAllocationImplFromJson(
        Map<String, dynamic> json) =>
    _$ResourceAllocationImpl(
      appointmentId: json['appointmentId'] as String,
      workerId: json['workerId'] as String,
      score: (json['score'] as num).toDouble(),
      cost: (json['cost'] as num).toDouble(),
    );

Map<String, dynamic> _$$ResourceAllocationImplToJson(
        _$ResourceAllocationImpl instance) =>
    <String, dynamic>{
      'appointmentId': instance.appointmentId,
      'workerId': instance.workerId,
      'score': instance.score,
      'cost': instance.cost,
    };

_$AllocationMetricsImpl _$$AllocationMetricsImplFromJson(
        Map<String, dynamic> json) =>
    _$AllocationMetricsImpl(
      totalAllocations: (json['totalAllocations'] as num).toInt(),
      averageScore: (json['averageScore'] as num).toDouble(),
      totalCost: (json['totalCost'] as num).toDouble(),
      utilizationRate: (json['utilizationRate'] as num).toDouble(),
      unassignedCount: (json['unassignedCount'] as num).toInt(),
      conflictCount: (json['conflictCount'] as num).toInt(),
    );

Map<String, dynamic> _$$AllocationMetricsImplToJson(
        _$AllocationMetricsImpl instance) =>
    <String, dynamic>{
      'totalAllocations': instance.totalAllocations,
      'averageScore': instance.averageScore,
      'totalCost': instance.totalCost,
      'utilizationRate': instance.utilizationRate,
      'unassignedCount': instance.unassignedCount,
      'conflictCount': instance.conflictCount,
    };

_$WorkerRecommendationImpl _$$WorkerRecommendationImplFromJson(
        Map<String, dynamic> json) =>
    _$WorkerRecommendationImpl(
      workerId: json['workerId'] as String,
      workerName: json['workerName'] as String,
      score: (json['score'] as num).toDouble(),
      factors: json['factors'] as Map<String, dynamic>,
      availability: json['availability'] as bool,
    );

Map<String, dynamic> _$$WorkerRecommendationImplToJson(
        _$WorkerRecommendationImpl instance) =>
    <String, dynamic>{
      'workerId': instance.workerId,
      'workerName': instance.workerName,
      'score': instance.score,
      'factors': instance.factors,
      'availability': instance.availability,
    };

_$WorkloadAnalysisImpl _$$WorkloadAnalysisImplFromJson(
        Map<String, dynamic> json) =>
    _$WorkloadAnalysisImpl(
      workerId: json['workerId'] as String,
      workerName: json['workerName'] as String,
      appointments: (json['appointments'] as num).toInt(),
      hours: (json['hours'] as num).toDouble(),
      utilization: (json['utilization'] as num).toDouble(),
    );

Map<String, dynamic> _$$WorkloadAnalysisImplToJson(
        _$WorkloadAnalysisImpl instance) =>
    <String, dynamic>{
      'workerId': instance.workerId,
      'workerName': instance.workerName,
      'appointments': instance.appointments,
      'hours': instance.hours,
      'utilization': instance.utilization,
    };

_$PerformanceMetricsImpl _$$PerformanceMetricsImplFromJson(
        Map<String, dynamic> json) =>
    _$PerformanceMetricsImpl(
      totalAppointments: (json['totalAppointments'] as num).toInt(),
      avgRating: (json['avgRating'] as num).toDouble(),
      completionRate: (json['completionRate'] as num).toDouble(),
      revenue: (json['revenue'] as num).toDouble(),
      revenuePerAppointment: (json['revenuePerAppointment'] as num).toDouble(),
      punctualityScore: (json['punctualityScore'] as num).toDouble(),
      qualityScore: (json['qualityScore'] as num).toDouble(),
    );

Map<String, dynamic> _$$PerformanceMetricsImplToJson(
        _$PerformanceMetricsImpl instance) =>
    <String, dynamic>{
      'totalAppointments': instance.totalAppointments,
      'avgRating': instance.avgRating,
      'completionRate': instance.completionRate,
      'revenue': instance.revenue,
      'revenuePerAppointment': instance.revenuePerAppointment,
      'punctualityScore': instance.punctualityScore,
      'qualityScore': instance.qualityScore,
    };

_$PerformanceAnalyticsImpl _$$PerformanceAnalyticsImplFromJson(
        Map<String, dynamic> json) =>
    _$PerformanceAnalyticsImpl(
      employeeId: json['employeeId'] as String,
      employeeName: json['employeeName'] as String,
      metrics:
          PerformanceMetrics.fromJson(json['metrics'] as Map<String, dynamic>),
      trends: PerformanceTrend.fromJson(json['trends'] as Map<String, dynamic>),
      comparison:
          PeerComparison.fromJson(json['comparison'] as Map<String, dynamic>),
      score: (json['score'] as num).toDouble(),
    );

Map<String, dynamic> _$$PerformanceAnalyticsImplToJson(
        _$PerformanceAnalyticsImpl instance) =>
    <String, dynamic>{
      'employeeId': instance.employeeId,
      'employeeName': instance.employeeName,
      'metrics': instance.metrics,
      'trends': instance.trends,
      'comparison': instance.comparison,
      'score': instance.score,
    };

_$PerformanceTrendImpl _$$PerformanceTrendImplFromJson(
        Map<String, dynamic> json) =>
    _$PerformanceTrendImpl(
      direction: json['direction'] as String,
      growth: (json['growth'] as num).toDouble(),
      volatility: (json['volatility'] as num).toDouble(),
    );

Map<String, dynamic> _$$PerformanceTrendImplToJson(
        _$PerformanceTrendImpl instance) =>
    <String, dynamic>{
      'direction': instance.direction,
      'growth': instance.growth,
      'volatility': instance.volatility,
    };

_$PeerComparisonImpl _$$PeerComparisonImplFromJson(Map<String, dynamic> json) =>
    _$PeerComparisonImpl(
      avgPeerScore: (json['avgPeerScore'] as num).toDouble(),
      percentile: (json['percentile'] as num).toDouble(),
      ranking: json['ranking'] as String,
    );

Map<String, dynamic> _$$PeerComparisonImplToJson(
        _$PeerComparisonImpl instance) =>
    <String, dynamic>{
      'avgPeerScore': instance.avgPeerScore,
      'percentile': instance.percentile,
      'ranking': instance.ranking,
    };

_$SkillProficiencyImpl _$$SkillProficiencyImplFromJson(
        Map<String, dynamic> json) =>
    _$SkillProficiencyImpl(
      skill: json['skill'] as String,
      level: json['level'] as String,
      certifications: (json['certifications'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      lastAssessed: DateTime.parse(json['lastAssessed'] as String),
      growthRate: (json['growthRate'] as num).toDouble(),
      recommendation: json['recommendation'] as String,
    );

Map<String, dynamic> _$$SkillProficiencyImplToJson(
        _$SkillProficiencyImpl instance) =>
    <String, dynamic>{
      'skill': instance.skill,
      'level': instance.level,
      'certifications': instance.certifications,
      'lastAssessed': instance.lastAssessed.toIso8601String(),
      'growthRate': instance.growthRate,
      'recommendation': instance.recommendation,
    };

_$QualityScoreImpl _$$QualityScoreImplFromJson(Map<String, dynamic> json) =>
    _$QualityScoreImpl(
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

Map<String, dynamic> _$$QualityScoreImplToJson(_$QualityScoreImpl instance) =>
    <String, dynamic>{
      'appointmentId': instance.appointmentId,
      'overallScore': instance.overallScore,
      'factors': instance.factors,
      'grade': instance.grade,
      'issues': instance.issues,
      'recommendations': instance.recommendations,
      'assessedAt': instance.assessedAt.toIso8601String(),
    };

_$QualityFactorsImpl _$$QualityFactorsImplFromJson(Map<String, dynamic> json) =>
    _$QualityFactorsImpl(
      punctuality: (json['punctuality'] as num).toDouble(),
      completion: (json['completion'] as num).toDouble(),
      clientSatisfaction: (json['clientSatisfaction'] as num).toDouble(),
      documentation: (json['documentation'] as num).toDouble(),
      compliance: (json['compliance'] as num).toDouble(),
    );

Map<String, dynamic> _$$QualityFactorsImplToJson(
        _$QualityFactorsImpl instance) =>
    <String, dynamic>{
      'punctuality': instance.punctuality,
      'completion': instance.completion,
      'clientSatisfaction': instance.clientSatisfaction,
      'documentation': instance.documentation,
      'compliance': instance.compliance,
    };

_$QualityIssueImpl _$$QualityIssueImplFromJson(Map<String, dynamic> json) =>
    _$QualityIssueImpl(
      type: json['type'] as String,
      severity: json['severity'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$$QualityIssueImplToJson(_$QualityIssueImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'severity': instance.severity,
      'message': instance.message,
    };

_$ComplianceCheckImpl _$$ComplianceCheckImplFromJson(
        Map<String, dynamic> json) =>
    _$ComplianceCheckImpl(
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

Map<String, dynamic> _$$ComplianceCheckImplToJson(
        _$ComplianceCheckImpl instance) =>
    <String, dynamic>{
      'appointmentId': instance.appointmentId,
      'checks': instance.checks,
      'compliant': instance.compliant,
      'violations': instance.violations,
      'riskLevel': instance.riskLevel,
    };

_$ComplianceResultImpl _$$ComplianceResultImplFromJson(
        Map<String, dynamic> json) =>
    _$ComplianceResultImpl(
      passed: json['passed'] as bool,
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$$ComplianceResultImplToJson(
        _$ComplianceResultImpl instance) =>
    <String, dynamic>{
      'passed': instance.passed,
      'reason': instance.reason,
    };

_$ComplianceViolationImpl _$$ComplianceViolationImplFromJson(
        Map<String, dynamic> json) =>
    _$ComplianceViolationImpl(
      check: json['check'] as String,
      reason: json['reason'] as String,
    );

Map<String, dynamic> _$$ComplianceViolationImplToJson(
        _$ComplianceViolationImpl instance) =>
    <String, dynamic>{
      'check': instance.check,
      'reason': instance.reason,
    };

_$SentimentAnalysisImpl _$$SentimentAnalysisImplFromJson(
        Map<String, dynamic> json) =>
    _$SentimentAnalysisImpl(
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

Map<String, dynamic> _$$SentimentAnalysisImplToJson(
        _$SentimentAnalysisImpl instance) =>
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

_$RiskAssessmentImpl _$$RiskAssessmentImplFromJson(Map<String, dynamic> json) =>
    _$RiskAssessmentImpl(
      appointmentId: json['appointmentId'] as String,
      riskScore: (json['riskScore'] as num).toDouble(),
      riskLevel: json['riskLevel'] as String,
      factors: RiskFactors.fromJson(json['factors'] as Map<String, dynamic>),
      mitigations: (json['mitigations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      requiresApproval: json['requiresApproval'] as bool,
    );

Map<String, dynamic> _$$RiskAssessmentImplToJson(
        _$RiskAssessmentImpl instance) =>
    <String, dynamic>{
      'appointmentId': instance.appointmentId,
      'riskScore': instance.riskScore,
      'riskLevel': instance.riskLevel,
      'factors': instance.factors,
      'mitigations': instance.mitigations,
      'requiresApproval': instance.requiresApproval,
    };

_$RiskFactorsImpl _$$RiskFactorsImplFromJson(Map<String, dynamic> json) =>
    _$RiskFactorsImpl(
      workerExperience: (json['workerExperience'] as num).toDouble(),
      clientComplexity: (json['clientComplexity'] as num).toDouble(),
      serviceType: (json['serviceType'] as num).toDouble(),
      location: (json['location'] as num).toDouble(),
      timeOfDay: (json['timeOfDay'] as num).toDouble(),
    );

Map<String, dynamic> _$$RiskFactorsImplToJson(_$RiskFactorsImpl instance) =>
    <String, dynamic>{
      'workerExperience': instance.workerExperience,
      'clientComplexity': instance.clientComplexity,
      'serviceType': instance.serviceType,
      'location': instance.location,
      'timeOfDay': instance.timeOfDay,
    };

_$IncidentPatternImpl _$$IncidentPatternImplFromJson(
        Map<String, dynamic> json) =>
    _$IncidentPatternImpl(
      totalIncidents: (json['totalIncidents'] as num).toInt(),
      patterns: json['patterns'] as Map<String, dynamic>,
      recurringIssues: (json['recurringIssues'] as List<dynamic>)
          .map((e) => RecurringIssue.fromJson(e as Map<String, dynamic>))
          .toList(),
      preventiveActions: (json['preventiveActions'] as List<dynamic>)
          .map((e) => PreventiveAction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$IncidentPatternImplToJson(
        _$IncidentPatternImpl instance) =>
    <String, dynamic>{
      'totalIncidents': instance.totalIncidents,
      'patterns': instance.patterns,
      'recurringIssues': instance.recurringIssues,
      'preventiveActions': instance.preventiveActions,
    };

_$RecurringIssueImpl _$$RecurringIssueImplFromJson(Map<String, dynamic> json) =>
    _$RecurringIssueImpl(
      type: json['type'] as String,
      description: json['description'] as String,
      severity: json['severity'] as String,
    );

Map<String, dynamic> _$$RecurringIssueImplToJson(
        _$RecurringIssueImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'description': instance.description,
      'severity': instance.severity,
    };

_$PreventiveActionImpl _$$PreventiveActionImplFromJson(
        Map<String, dynamic> json) =>
    _$PreventiveActionImpl(
      action: json['action'] as String,
      priority: json['priority'] as String,
      expectedImpact: json['expectedImpact'] as String,
    );

Map<String, dynamic> _$$PreventiveActionImplToJson(
        _$PreventiveActionImpl instance) =>
    <String, dynamic>{
      'action': instance.action,
      'priority': instance.priority,
      'expectedImpact': instance.expectedImpact,
    };

_$ExecutiveDashboardImpl _$$ExecutiveDashboardImplFromJson(
        Map<String, dynamic> json) =>
    _$ExecutiveDashboardImpl(
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

Map<String, dynamic> _$$ExecutiveDashboardImplToJson(
        _$ExecutiveDashboardImpl instance) =>
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

_$DashboardKPIsImpl _$$DashboardKPIsImplFromJson(Map<String, dynamic> json) =>
    _$DashboardKPIsImpl(
      totalRevenue: (json['totalRevenue'] as num).toDouble(),
      totalAppointments: (json['totalAppointments'] as num).toInt(),
      completedAppointments: (json['completedAppointments'] as num).toInt(),
      completionRate: (json['completionRate'] as num).toDouble(),
      avgRevenuePerAppointment:
          (json['avgRevenuePerAppointment'] as num).toDouble(),
      growth: (json['growth'] as num).toDouble(),
    );

Map<String, dynamic> _$$DashboardKPIsImplToJson(_$DashboardKPIsImpl instance) =>
    <String, dynamic>{
      'totalRevenue': instance.totalRevenue,
      'totalAppointments': instance.totalAppointments,
      'completedAppointments': instance.completedAppointments,
      'completionRate': instance.completionRate,
      'avgRevenuePerAppointment': instance.avgRevenuePerAppointment,
      'growth': instance.growth,
    };

_$RevenueMetricsImpl _$$RevenueMetricsImplFromJson(Map<String, dynamic> json) =>
    _$RevenueMetricsImpl(
      total: (json['total'] as num).toDouble(),
      count: (json['count'] as num).toInt(),
      avg: (json['avg'] as num).toDouble(),
    );

Map<String, dynamic> _$$RevenueMetricsImplToJson(
        _$RevenueMetricsImpl instance) =>
    <String, dynamic>{
      'total': instance.total,
      'count': instance.count,
      'avg': instance.avg,
    };

_$OperationalMetricsImpl _$$OperationalMetricsImplFromJson(
        Map<String, dynamic> json) =>
    _$OperationalMetricsImpl(
      utilization: (json['utilization'] as num).toDouble(),
      efficiency: (json['efficiency'] as num).toDouble(),
      onTimeRate: (json['onTimeRate'] as num).toDouble(),
      cancellationRate: (json['cancellationRate'] as num).toDouble(),
    );

Map<String, dynamic> _$$OperationalMetricsImplToJson(
        _$OperationalMetricsImpl instance) =>
    <String, dynamic>{
      'utilization': instance.utilization,
      'efficiency': instance.efficiency,
      'onTimeRate': instance.onTimeRate,
      'cancellationRate': instance.cancellationRate,
    };

_$ClientMetricsImpl _$$ClientMetricsImplFromJson(Map<String, dynamic> json) =>
    _$ClientMetricsImpl(
      total: (json['total'] as num).toInt(),
      active: (json['active'] as num).toInt(),
      retention: (json['retention'] as num).toDouble(),
      satisfaction: (json['satisfaction'] as num).toDouble(),
      nps: (json['nps'] as num).toInt(),
    );

Map<String, dynamic> _$$ClientMetricsImplToJson(_$ClientMetricsImpl instance) =>
    <String, dynamic>{
      'total': instance.total,
      'active': instance.active,
      'retention': instance.retention,
      'satisfaction': instance.satisfaction,
      'nps': instance.nps,
    };

_$WorkforceMetricsImpl _$$WorkforceMetricsImplFromJson(
        Map<String, dynamic> json) =>
    _$WorkforceMetricsImpl(
      total: (json['total'] as num).toInt(),
      utilization: (json['utilization'] as num).toDouble(),
      productivity: (json['productivity'] as num).toDouble(),
      satisfaction: (json['satisfaction'] as num).toDouble(),
      turnover: (json['turnover'] as num).toDouble(),
    );

Map<String, dynamic> _$$WorkforceMetricsImplToJson(
        _$WorkforceMetricsImpl instance) =>
    <String, dynamic>{
      'total': instance.total,
      'utilization': instance.utilization,
      'productivity': instance.productivity,
      'satisfaction': instance.satisfaction,
      'turnover': instance.turnover,
    };

_$TrendDataImpl _$$TrendDataImplFromJson(Map<String, dynamic> json) =>
    _$TrendDataImpl(
      direction: json['direction'] as String,
      change: (json['change'] as num).toDouble(),
    );

Map<String, dynamic> _$$TrendDataImplToJson(_$TrendDataImpl instance) =>
    <String, dynamic>{
      'direction': instance.direction,
      'change': instance.change,
    };

_$RevenueForecastImpl _$$RevenueForecastImplFromJson(
        Map<String, dynamic> json) =>
    _$RevenueForecastImpl(
      period: (json['period'] as num).toInt(),
      predicted: (json['predicted'] as num).toDouble(),
      lower: (json['lower'] as num).toDouble(),
      upper: (json['upper'] as num).toDouble(),
    );

Map<String, dynamic> _$$RevenueForecastImplToJson(
        _$RevenueForecastImpl instance) =>
    <String, dynamic>{
      'period': instance.period,
      'predicted': instance.predicted,
      'lower': instance.lower,
      'upper': instance.upper,
    };

_$ChurnPredictionImpl _$$ChurnPredictionImplFromJson(
        Map<String, dynamic> json) =>
    _$ChurnPredictionImpl(
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

Map<String, dynamic> _$$ChurnPredictionImplToJson(
        _$ChurnPredictionImpl instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'clientName': instance.clientName,
      'churnScore': instance.churnScore,
      'churnRisk': instance.churnRisk,
      'factors': instance.factors,
      'interventions': instance.interventions,
      'lifetimeValue': instance.lifetimeValue,
    };

_$ChurnFactorsImpl _$$ChurnFactorsImplFromJson(Map<String, dynamic> json) =>
    _$ChurnFactorsImpl(
      recency: (json['recency'] as num).toDouble(),
      frequency: (json['frequency'] as num).toDouble(),
      monetary: (json['monetary'] as num).toDouble(),
      satisfaction: (json['satisfaction'] as num).toDouble(),
      engagement: (json['engagement'] as num).toDouble(),
    );

Map<String, dynamic> _$$ChurnFactorsImplToJson(_$ChurnFactorsImpl instance) =>
    <String, dynamic>{
      'recency': instance.recency,
      'frequency': instance.frequency,
      'monetary': instance.monetary,
      'satisfaction': instance.satisfaction,
      'engagement': instance.engagement,
    };

_$ChurnInterventionImpl _$$ChurnInterventionImplFromJson(
        Map<String, dynamic> json) =>
    _$ChurnInterventionImpl(
      action: json['action'] as String,
      priority: json['priority'] as String,
      expectedImpact: json['expectedImpact'] as String,
    );

Map<String, dynamic> _$$ChurnInterventionImplToJson(
        _$ChurnInterventionImpl instance) =>
    <String, dynamic>{
      'action': instance.action,
      'priority': instance.priority,
      'expectedImpact': instance.expectedImpact,
    };

_$ProfitabilityAnalysisImpl _$$ProfitabilityAnalysisImplFromJson(
        Map<String, dynamic> json) =>
    _$ProfitabilityAnalysisImpl(
      dimension: json['dimension'] as String,
      revenue: (json['revenue'] as num).toDouble(),
      cost: (json['cost'] as num).toDouble(),
      profit: (json['profit'] as num).toDouble(),
      margin: (json['margin'] as num).toDouble(),
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$$ProfitabilityAnalysisImplToJson(
        _$ProfitabilityAnalysisImpl instance) =>
    <String, dynamic>{
      'dimension': instance.dimension,
      'revenue': instance.revenue,
      'cost': instance.cost,
      'profit': instance.profit,
      'margin': instance.margin,
      'count': instance.count,
    };

_$WhatIfScenarioImpl _$$WhatIfScenarioImplFromJson(Map<String, dynamic> json) =>
    _$WhatIfScenarioImpl(
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

Map<String, dynamic> _$$WhatIfScenarioImplToJson(
        _$WhatIfScenarioImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'baseline': instance.baseline,
      'projected': instance.projected,
      'impact': instance.impact,
      'feasibility': instance.feasibility,
      'recommendation': instance.recommendation,
    };

_$ScenarioMetricsImpl _$$ScenarioMetricsImplFromJson(
        Map<String, dynamic> json) =>
    _$ScenarioMetricsImpl(
      appointments: (json['appointments'] as num).toInt(),
      workers: (json['workers'] as num).toInt(),
      revenue: (json['revenue'] as num).toDouble(),
      avgRevenuePerWorker: (json['avgRevenuePerWorker'] as num).toDouble(),
    );

Map<String, dynamic> _$$ScenarioMetricsImplToJson(
        _$ScenarioMetricsImpl instance) =>
    <String, dynamic>{
      'appointments': instance.appointments,
      'workers': instance.workers,
      'revenue': instance.revenue,
      'avgRevenuePerWorker': instance.avgRevenuePerWorker,
    };

_$ScenarioImpactImpl _$$ScenarioImpactImplFromJson(Map<String, dynamic> json) =>
    _$ScenarioImpactImpl(
      revenueChange: (json['revenueChange'] as num).toDouble(),
      revenueChangePercent: json['revenueChangePercent'] as String,
      appointmentChange: (json['appointmentChange'] as num).toInt(),
      workerChange: (json['workerChange'] as num).toInt(),
      productivityChange: (json['productivityChange'] as num).toDouble(),
    );

Map<String, dynamic> _$$ScenarioImpactImplToJson(
        _$ScenarioImpactImpl instance) =>
    <String, dynamic>{
      'revenueChange': instance.revenueChange,
      'revenueChangePercent': instance.revenueChangePercent,
      'appointmentChange': instance.appointmentChange,
      'workerChange': instance.workerChange,
      'productivityChange': instance.productivityChange,
    };

_$ScenarioFeasibilityImpl _$$ScenarioFeasibilityImplFromJson(
        Map<String, dynamic> json) =>
    _$ScenarioFeasibilityImpl(
      scores: (json['scores'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      overall: (json['overall'] as num).toDouble(),
      rating: json['rating'] as String,
    );

Map<String, dynamic> _$$ScenarioFeasibilityImplToJson(
        _$ScenarioFeasibilityImpl instance) =>
    <String, dynamic>{
      'scores': instance.scores,
      'overall': instance.overall,
      'rating': instance.rating,
    };

_$ScenarioRecommendationImpl _$$ScenarioRecommendationImplFromJson(
        Map<String, dynamic> json) =>
    _$ScenarioRecommendationImpl(
      decision: json['decision'] as String,
      confidence: json['confidence'] as String,
      reasoning: json['reasoning'] as String,
    );

Map<String, dynamic> _$$ScenarioRecommendationImplToJson(
        _$ScenarioRecommendationImpl instance) =>
    <String, dynamic>{
      'decision': instance.decision,
      'confidence': instance.confidence,
      'reasoning': instance.reasoning,
    };

_$CustomerLifetimeValueImpl _$$CustomerLifetimeValueImplFromJson(
        Map<String, dynamic> json) =>
    _$CustomerLifetimeValueImpl(
      clientId: json['clientId'] as String,
      clientName: json['clientName'] as String,
      clv: (json['clv'] as num).toDouble(),
      segment: json['segment'] as String,
      metrics: CLVMetrics.fromJson(json['metrics'] as Map<String, dynamic>),
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$CustomerLifetimeValueImplToJson(
        _$CustomerLifetimeValueImpl instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'clientName': instance.clientName,
      'clv': instance.clv,
      'segment': instance.segment,
      'metrics': instance.metrics,
      'recommendations': instance.recommendations,
    };

_$CLVMetricsImpl _$$CLVMetricsImplFromJson(Map<String, dynamic> json) =>
    _$CLVMetricsImpl(
      totalRevenue: (json['totalRevenue'] as num).toDouble(),
      appointmentCount: (json['appointmentCount'] as num).toInt(),
      avgOrderValue: (json['avgOrderValue'] as num).toDouble(),
      frequency: (json['frequency'] as num).toDouble(),
      tenure: (json['tenure'] as num).toDouble(),
      churnProbability: (json['churnProbability'] as num).toDouble(),
    );

Map<String, dynamic> _$$CLVMetricsImplToJson(_$CLVMetricsImpl instance) =>
    <String, dynamic>{
      'totalRevenue': instance.totalRevenue,
      'appointmentCount': instance.appointmentCount,
      'avgOrderValue': instance.avgOrderValue,
      'frequency': instance.frequency,
      'tenure': instance.tenure,
      'churnProbability': instance.churnProbability,
    };

_$MLModelImpl _$$MLModelImplFromJson(Map<String, dynamic> json) =>
    _$MLModelImpl(
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

Map<String, dynamic> _$$MLModelImplToJson(_$MLModelImpl instance) =>
    <String, dynamic>{
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

_$MLMetricsImpl _$$MLMetricsImplFromJson(Map<String, dynamic> json) =>
    _$MLMetricsImpl(
      accuracy: (json['accuracy'] as num).toDouble(),
      precision: (json['precision'] as num).toDouble(),
      recall: (json['recall'] as num).toDouble(),
      f1Score: (json['f1Score'] as num).toDouble(),
    );

Map<String, dynamic> _$$MLMetricsImplToJson(_$MLMetricsImpl instance) =>
    <String, dynamic>{
      'accuracy': instance.accuracy,
      'precision': instance.precision,
      'recall': instance.recall,
      'f1Score': instance.f1Score,
    };

_$MLPredictionImpl _$$MLPredictionImplFromJson(Map<String, dynamic> json) =>
    _$MLPredictionImpl(
      modelId: json['modelId'] as String,
      prediction:
          PredictionResult.fromJson(json['prediction'] as Map<String, dynamic>),
      confidence: (json['confidence'] as num).toDouble(),
      features: json['features'] as Map<String, dynamic>,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$MLPredictionImplToJson(_$MLPredictionImpl instance) =>
    <String, dynamic>{
      'modelId': instance.modelId,
      'prediction': instance.prediction,
      'confidence': instance.confidence,
      'features': instance.features,
      'timestamp': instance.timestamp.toIso8601String(),
    };

_$PredictionResultImpl _$$PredictionResultImplFromJson(
        Map<String, dynamic> json) =>
    _$PredictionResultImpl(
      predictedClass: json['predictedClass'] as String,
      score: (json['score'] as num).toDouble(),
      probabilities: (json['probabilities'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
    );

Map<String, dynamic> _$$PredictionResultImplToJson(
        _$PredictionResultImpl instance) =>
    <String, dynamic>{
      'predictedClass': instance.predictedClass,
      'score': instance.score,
      'probabilities': instance.probabilities,
    };
