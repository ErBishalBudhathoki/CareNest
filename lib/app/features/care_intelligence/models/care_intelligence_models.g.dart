// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'care_intelligence_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntelligenceReport _$IntelligenceReportFromJson(Map<String, dynamic> json) =>
    _IntelligenceReport(
      clientId: json['clientId'] as String,
      organizationId: json['organizationId'] as String,
      generatedAt: json['generatedAt'] as String,
      intelligenceScore: (json['intelligenceScore'] as num).toInt(),
      riskSummary:
          RiskSummary.fromJson(json['riskSummary'] as Map<String, dynamic>),
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => Recommendation.fromJson(e as Map<String, dynamic>))
          .toList(),
      outcomePredictions: OutcomePredictions.fromJson(
          json['outcomePredictions'] as Map<String, dynamic>),
      alerts: (json['alerts'] as List<dynamic>)
          .map((e) => Alert.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextActions: (json['nextActions'] as List<dynamic>)
          .map((e) => NextAction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$IntelligenceReportToJson(_IntelligenceReport instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'organizationId': instance.organizationId,
      'generatedAt': instance.generatedAt,
      'intelligenceScore': instance.intelligenceScore,
      'riskSummary': instance.riskSummary,
      'recommendations': instance.recommendations,
      'outcomePredictions': instance.outcomePredictions,
      'alerts': instance.alerts,
      'nextActions': instance.nextActions,
    };

_RiskSummary _$RiskSummaryFromJson(Map<String, dynamic> json) => _RiskSummary(
      overallRisk: (json['overallRisk'] as num).toDouble(),
      highRiskAreas: (json['highRiskAreas'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      trendDirection: json['trendDirection'] as String,
      lastAssessment: json['lastAssessment'] as String,
    );

Map<String, dynamic> _$RiskSummaryToJson(_RiskSummary instance) =>
    <String, dynamic>{
      'overallRisk': instance.overallRisk,
      'highRiskAreas': instance.highRiskAreas,
      'trendDirection': instance.trendDirection,
      'lastAssessment': instance.lastAssessment,
    };

_Recommendation _$RecommendationFromJson(Map<String, dynamic> json) =>
    _Recommendation(
      category: json['category'] as String,
      recommendation: json['recommendation'] as String,
      priority: json['priority'] as String,
      expectedImpact: json['expectedImpact'] as String,
    );

Map<String, dynamic> _$RecommendationToJson(_Recommendation instance) =>
    <String, dynamic>{
      'category': instance.category,
      'recommendation': instance.recommendation,
      'priority': instance.priority,
      'expectedImpact': instance.expectedImpact,
    };

_OutcomePredictions _$OutcomePredictionsFromJson(Map<String, dynamic> json) =>
    _OutcomePredictions(
      goalAchievement: GoalAchievementPrediction.fromJson(
          json['goalAchievement'] as Map<String, dynamic>),
      healthStability: HealthStabilityPrediction.fromJson(
          json['healthStability'] as Map<String, dynamic>),
      serviceUtilization: ServiceUtilizationPrediction.fromJson(
          json['serviceUtilization'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OutcomePredictionsToJson(_OutcomePredictions instance) =>
    <String, dynamic>{
      'goalAchievement': instance.goalAchievement,
      'healthStability': instance.healthStability,
      'serviceUtilization': instance.serviceUtilization,
    };

_GoalAchievementPrediction _$GoalAchievementPredictionFromJson(
        Map<String, dynamic> json) =>
    _GoalAchievementPrediction(
      probability: (json['probability'] as num).toDouble(),
      timeline: json['timeline'] as String,
      confidence: (json['confidence'] as num).toDouble(),
    );

Map<String, dynamic> _$GoalAchievementPredictionToJson(
        _GoalAchievementPrediction instance) =>
    <String, dynamic>{
      'probability': instance.probability,
      'timeline': instance.timeline,
      'confidence': instance.confidence,
    };

_HealthStabilityPrediction _$HealthStabilityPredictionFromJson(
        Map<String, dynamic> json) =>
    _HealthStabilityPrediction(
      probability: (json['probability'] as num).toDouble(),
      factors:
          (json['factors'] as List<dynamic>).map((e) => e as String).toList(),
      confidence: (json['confidence'] as num).toDouble(),
    );

Map<String, dynamic> _$HealthStabilityPredictionToJson(
        _HealthStabilityPrediction instance) =>
    <String, dynamic>{
      'probability': instance.probability,
      'factors': instance.factors,
      'confidence': instance.confidence,
    };

_ServiceUtilizationPrediction _$ServiceUtilizationPredictionFromJson(
        Map<String, dynamic> json) =>
    _ServiceUtilizationPrediction(
      predictedChange: json['predictedChange'] as String,
      percentage: (json['percentage'] as num).toInt(),
      confidence: (json['confidence'] as num).toDouble(),
    );

Map<String, dynamic> _$ServiceUtilizationPredictionToJson(
        _ServiceUtilizationPrediction instance) =>
    <String, dynamic>{
      'predictedChange': instance.predictedChange,
      'percentage': instance.percentage,
      'confidence': instance.confidence,
    };

_Alert _$AlertFromJson(Map<String, dynamic> json) => _Alert(
      severity: json['severity'] as String,
      type: json['type'] as String,
      message: json['message'] as String,
      action: json['action'] as String,
    );

Map<String, dynamic> _$AlertToJson(_Alert instance) => <String, dynamic>{
      'severity': instance.severity,
      'type': instance.type,
      'message': instance.message,
      'action': instance.action,
    };

_NextAction _$NextActionFromJson(Map<String, dynamic> json) => _NextAction(
      action: json['action'] as String,
      priority: json['priority'] as String,
      deadline: json['deadline'] as String,
      assignedTo: json['assignedTo'] as String,
    );

Map<String, dynamic> _$NextActionToJson(_NextAction instance) =>
    <String, dynamic>{
      'action': instance.action,
      'priority': instance.priority,
      'deadline': instance.deadline,
      'assignedTo': instance.assignedTo,
    };

_CarePatterns _$CarePatternsFromJson(Map<String, dynamic> json) =>
    _CarePatterns(
      serviceUtilization: ServiceUtilization.fromJson(
          json['serviceUtilization'] as Map<String, dynamic>),
      healthTrends:
          HealthTrends.fromJson(json['healthTrends'] as Map<String, dynamic>),
      behaviorPatterns: BehaviorPatterns.fromJson(
          json['behaviorPatterns'] as Map<String, dynamic>),
      goalProgress:
          GoalProgress.fromJson(json['goalProgress'] as Map<String, dynamic>),
      familyEngagement: FamilyEngagement.fromJson(
          json['familyEngagement'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CarePatternsToJson(_CarePatterns instance) =>
    <String, dynamic>{
      'serviceUtilization': instance.serviceUtilization,
      'healthTrends': instance.healthTrends,
      'behaviorPatterns': instance.behaviorPatterns,
      'goalProgress': instance.goalProgress,
      'familyEngagement': instance.familyEngagement,
    };

_ServiceUtilization _$ServiceUtilizationFromJson(Map<String, dynamic> json) =>
    _ServiceUtilization(
      trend: json['trend'] as String,
      averageHoursPerWeek: (json['averageHoursPerWeek'] as num).toInt(),
      peakDays:
          (json['peakDays'] as List<dynamic>).map((e) => e as String).toList(),
      preferredTimes: (json['preferredTimes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ServiceUtilizationToJson(_ServiceUtilization instance) =>
    <String, dynamic>{
      'trend': instance.trend,
      'averageHoursPerWeek': instance.averageHoursPerWeek,
      'peakDays': instance.peakDays,
      'preferredTimes': instance.preferredTimes,
    };

_HealthTrends _$HealthTrendsFromJson(Map<String, dynamic> json) =>
    _HealthTrends(
      vitalStability: (json['vitalStability'] as num).toDouble(),
      medicationCompliance: (json['medicationCompliance'] as num).toDouble(),
      incidentFrequency: (json['incidentFrequency'] as num).toInt(),
      overallTrend: json['overallTrend'] as String,
    );

Map<String, dynamic> _$HealthTrendsToJson(_HealthTrends instance) =>
    <String, dynamic>{
      'vitalStability': instance.vitalStability,
      'medicationCompliance': instance.medicationCompliance,
      'incidentFrequency': instance.incidentFrequency,
      'overallTrend': instance.overallTrend,
    };

_BehaviorPatterns _$BehaviorPatternsFromJson(Map<String, dynamic> json) =>
    _BehaviorPatterns(
      positiveInteractions: (json['positiveInteractions'] as num).toInt(),
      challengingBehaviors: (json['challengingBehaviors'] as num).toInt(),
      triggerPatterns: (json['triggerPatterns'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      responseEffectiveness: (json['responseEffectiveness'] as num).toDouble(),
    );

Map<String, dynamic> _$BehaviorPatternsToJson(_BehaviorPatterns instance) =>
    <String, dynamic>{
      'positiveInteractions': instance.positiveInteractions,
      'challengingBehaviors': instance.challengingBehaviors,
      'triggerPatterns': instance.triggerPatterns,
      'responseEffectiveness': instance.responseEffectiveness,
    };

_GoalProgress _$GoalProgressFromJson(Map<String, dynamic> json) =>
    _GoalProgress(
      onTrack: (json['onTrack'] as num).toInt(),
      needsAttention: (json['needsAttention'] as num).toInt(),
      achieved: (json['achieved'] as num).toInt(),
      averageProgress: (json['averageProgress'] as num).toDouble(),
    );

Map<String, dynamic> _$GoalProgressToJson(_GoalProgress instance) =>
    <String, dynamic>{
      'onTrack': instance.onTrack,
      'needsAttention': instance.needsAttention,
      'achieved': instance.achieved,
      'averageProgress': instance.averageProgress,
    };

_FamilyEngagement _$FamilyEngagementFromJson(Map<String, dynamic> json) =>
    _FamilyEngagement(
      communicationFrequency: json['communicationFrequency'] as String,
      satisfactionScore: (json['satisfactionScore'] as num).toDouble(),
      concernsRaised: (json['concernsRaised'] as num).toInt(),
      participationLevel: (json['participationLevel'] as num).toDouble(),
    );

Map<String, dynamic> _$FamilyEngagementToJson(_FamilyEngagement instance) =>
    <String, dynamic>{
      'communicationFrequency': instance.communicationFrequency,
      'satisfactionScore': instance.satisfactionScore,
      'concernsRaised': instance.concernsRaised,
      'participationLevel': instance.participationLevel,
    };

_RiskAssessment _$RiskAssessmentFromJson(Map<String, dynamic> json) =>
    _RiskAssessment(
      clientId: json['clientId'] as String,
      organizationId: json['organizationId'] as String,
      assessmentDate: json['assessmentDate'] as String,
      overallRisk: (json['overallRisk'] as num).toInt(),
      fallsRisk:
          RiskCategory.fromJson(json['fallsRisk'] as Map<String, dynamic>),
      behaviorRisk:
          RiskCategory.fromJson(json['behaviorRisk'] as Map<String, dynamic>),
      healthRisk:
          RiskCategory.fromJson(json['healthRisk'] as Map<String, dynamic>),
      medicationRisk:
          RiskCategory.fromJson(json['medicationRisk'] as Map<String, dynamic>),
      socialRisk:
          RiskCategory.fromJson(json['socialRisk'] as Map<String, dynamic>),
      financialRisk:
          RiskCategory.fromJson(json['financialRisk'] as Map<String, dynamic>),
      trends: RiskTrends.fromJson(json['trends'] as Map<String, dynamic>),
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => RiskRecommendation.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextAssessment: json['nextAssessment'] as String,
    );

Map<String, dynamic> _$RiskAssessmentToJson(_RiskAssessment instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'organizationId': instance.organizationId,
      'assessmentDate': instance.assessmentDate,
      'overallRisk': instance.overallRisk,
      'fallsRisk': instance.fallsRisk,
      'behaviorRisk': instance.behaviorRisk,
      'healthRisk': instance.healthRisk,
      'medicationRisk': instance.medicationRisk,
      'socialRisk': instance.socialRisk,
      'financialRisk': instance.financialRisk,
      'trends': instance.trends,
      'recommendations': instance.recommendations,
      'nextAssessment': instance.nextAssessment,
    };

_RiskCategory _$RiskCategoryFromJson(Map<String, dynamic> json) =>
    _RiskCategory(
      score: (json['score'] as num).toInt(),
      level: json['level'] as String,
      lastIncident: json['lastIncident'] as String?,
      recentIncidents: (json['recentIncidents'] as num?)?.toInt(),
      conditions: (json['conditions'] as num?)?.toInt(),
      medications: (json['medications'] as num?)?.toInt(),
      isolationIndicators: (json['isolationIndicators'] as num?)?.toInt(),
      concerns: (json['concerns'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RiskCategoryToJson(_RiskCategory instance) =>
    <String, dynamic>{
      'score': instance.score,
      'level': instance.level,
      'lastIncident': instance.lastIncident,
      'recentIncidents': instance.recentIncidents,
      'conditions': instance.conditions,
      'medications': instance.medications,
      'isolationIndicators': instance.isolationIndicators,
      'concerns': instance.concerns,
    };

_RiskTrends _$RiskTrendsFromJson(Map<String, dynamic> json) => _RiskTrends(
      direction: json['direction'] as String,
      changePercentage: (json['changePercentage'] as num).toInt(),
      period: json['period'] as String,
    );

Map<String, dynamic> _$RiskTrendsToJson(_RiskTrends instance) =>
    <String, dynamic>{
      'direction': instance.direction,
      'changePercentage': instance.changePercentage,
      'period': instance.period,
    };

_RiskRecommendation _$RiskRecommendationFromJson(Map<String, dynamic> json) =>
    _RiskRecommendation(
      priority: json['priority'] as String,
      recommendation: json['recommendation'] as String,
      timeline: json['timeline'] as String,
    );

Map<String, dynamic> _$RiskRecommendationToJson(_RiskRecommendation instance) =>
    <String, dynamic>{
      'priority': instance.priority,
      'recommendation': instance.recommendation,
      'timeline': instance.timeline,
    };

_FallsRiskAssessment _$FallsRiskAssessmentFromJson(Map<String, dynamic> json) =>
    _FallsRiskAssessment(
      riskScore: (json['riskScore'] as num).toInt(),
      riskLevel: json['riskLevel'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      contributingFactors: (json['contributingFactors'] as List<dynamic>)
          .map((e) => ContributingFactor.fromJson(e as Map<String, dynamic>))
          .toList(),
      preventionStrategies: (json['preventionStrategies'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      monitoringPlan: MonitoringPlan.fromJson(
          json['monitoringPlan'] as Map<String, dynamic>),
      interventions: (json['interventions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$FallsRiskAssessmentToJson(
        _FallsRiskAssessment instance) =>
    <String, dynamic>{
      'riskScore': instance.riskScore,
      'riskLevel': instance.riskLevel,
      'confidence': instance.confidence,
      'contributingFactors': instance.contributingFactors,
      'preventionStrategies': instance.preventionStrategies,
      'monitoringPlan': instance.monitoringPlan,
      'interventions': instance.interventions,
    };

_ContributingFactor _$ContributingFactorFromJson(Map<String, dynamic> json) =>
    _ContributingFactor(
      factor: json['factor'] as String,
      weight: (json['weight'] as num).toDouble(),
      present: json['present'] as bool,
    );

Map<String, dynamic> _$ContributingFactorToJson(_ContributingFactor instance) =>
    <String, dynamic>{
      'factor': instance.factor,
      'weight': instance.weight,
      'present': instance.present,
    };

_MonitoringPlan _$MonitoringPlanFromJson(Map<String, dynamic> json) =>
    _MonitoringPlan(
      frequency: json['frequency'] as String,
      indicators: (json['indicators'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      alerts: json['alerts'] as bool,
    );

Map<String, dynamic> _$MonitoringPlanToJson(_MonitoringPlan instance) =>
    <String, dynamic>{
      'frequency': instance.frequency,
      'indicators': instance.indicators,
      'alerts': instance.alerts,
    };

_BehaviorEscalationPrediction _$BehaviorEscalationPredictionFromJson(
        Map<String, dynamic> json) =>
    _BehaviorEscalationPrediction(
      escalationProbability: (json['escalationProbability'] as num).toDouble(),
      timeframe: json['timeframe'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      triggers: (json['triggers'] as List<dynamic>)
          .map((e) => Trigger.fromJson(e as Map<String, dynamic>))
          .toList(),
      earlyWarningSignals: (json['earlyWarningSignals'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      deEscalationStrategies: (json['deEscalationStrategies'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      preventiveMeasures: (json['preventiveMeasures'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$BehaviorEscalationPredictionToJson(
        _BehaviorEscalationPrediction instance) =>
    <String, dynamic>{
      'escalationProbability': instance.escalationProbability,
      'timeframe': instance.timeframe,
      'confidence': instance.confidence,
      'triggers': instance.triggers,
      'earlyWarningSignals': instance.earlyWarningSignals,
      'deEscalationStrategies': instance.deEscalationStrategies,
      'preventiveMeasures': instance.preventiveMeasures,
    };

_Trigger _$TriggerFromJson(Map<String, dynamic> json) => _Trigger(
      trigger: json['trigger'] as String,
      likelihood: (json['likelihood'] as num).toDouble(),
    );

Map<String, dynamic> _$TriggerToJson(_Trigger instance) => <String, dynamic>{
      'trigger': instance.trigger,
      'likelihood': instance.likelihood,
    };

_CarePlan _$CarePlanFromJson(Map<String, dynamic> json) => _CarePlan(
      clientId: json['clientId'] as String,
      organizationId: json['organizationId'] as String,
      planId: json['planId'] as String,
      createdAt: json['createdAt'] as String,
      status: json['status'] as String,
      assessment:
          Assessment.fromJson(json['assessment'] as Map<String, dynamic>),
      goals: (json['goals'] as List<dynamic>)
          .map((e) => SmartGoal.fromJson(e as Map<String, dynamic>))
          .toList(),
      services: (json['services'] as List<dynamic>)
          .map((e) => ServiceRecommendation.fromJson(e as Map<String, dynamic>))
          .toList(),
      resources: Resources.fromJson(json['resources'] as Map<String, dynamic>),
      timeline: Timeline.fromJson(json['timeline'] as Map<String, dynamic>),
      reviewSchedule: (json['reviewSchedule'] as List<dynamic>)
          .map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
      successMetrics: (json['successMetrics'] as List<dynamic>)
          .map((e) => SuccessMetric.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CarePlanToJson(_CarePlan instance) => <String, dynamic>{
      'clientId': instance.clientId,
      'organizationId': instance.organizationId,
      'planId': instance.planId,
      'createdAt': instance.createdAt,
      'status': instance.status,
      'assessment': instance.assessment,
      'goals': instance.goals,
      'services': instance.services,
      'resources': instance.resources,
      'timeline': instance.timeline,
      'reviewSchedule': instance.reviewSchedule,
      'successMetrics': instance.successMetrics,
    };

_Assessment _$AssessmentFromJson(Map<String, dynamic> json) => _Assessment(
      strengths:
          (json['strengths'] as List<dynamic>).map((e) => e as String).toList(),
      needs: (json['needs'] as List<dynamic>).map((e) => e as String).toList(),
      preferences: (json['preferences'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      riskFactors: (json['riskFactors'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AssessmentToJson(_Assessment instance) =>
    <String, dynamic>{
      'strengths': instance.strengths,
      'needs': instance.needs,
      'preferences': instance.preferences,
      'riskFactors': instance.riskFactors,
    };

_SmartGoal _$SmartGoalFromJson(Map<String, dynamic> json) => _SmartGoal(
      goalId: json['goalId'] as String,
      outcomeArea: json['outcomeArea'] as String,
      goal: json['goal'] as String,
      specific: json['specific'] as String,
      measurable: json['measurable'] as String,
      achievable: json['achievable'] as String,
      relevant: json['relevant'] as String,
      timeBound: json['timeBound'] as String,
      priority: json['priority'] as String,
      status: json['status'] as String,
      progress: (json['progress'] as num).toInt(),
      milestones: (json['milestones'] as List<dynamic>)
          .map((e) => Milestone.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SmartGoalToJson(_SmartGoal instance) =>
    <String, dynamic>{
      'goalId': instance.goalId,
      'outcomeArea': instance.outcomeArea,
      'goal': instance.goal,
      'specific': instance.specific,
      'measurable': instance.measurable,
      'achievable': instance.achievable,
      'relevant': instance.relevant,
      'timeBound': instance.timeBound,
      'priority': instance.priority,
      'status': instance.status,
      'progress': instance.progress,
      'milestones': instance.milestones,
    };

_Milestone _$MilestoneFromJson(Map<String, dynamic> json) => _Milestone(
      milestone: json['milestone'] as String,
      target: json['target'] as String,
      date: json['date'] as String,
    );

Map<String, dynamic> _$MilestoneToJson(_Milestone instance) =>
    <String, dynamic>{
      'milestone': instance.milestone,
      'target': instance.target,
      'date': instance.date,
    };

_ServiceRecommendation _$ServiceRecommendationFromJson(
        Map<String, dynamic> json) =>
    _ServiceRecommendation(
      serviceType: json['serviceType'] as String,
      frequency: json['frequency'] as String,
      duration: json['duration'] as String,
      priority: json['priority'] as String,
      rationale: json['rationale'] as String,
      estimatedCost: (json['estimatedCost'] as num).toInt(),
      providers: (json['providers'] as List<dynamic>)
          .map((e) => Provider.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServiceRecommendationToJson(
        _ServiceRecommendation instance) =>
    <String, dynamic>{
      'serviceType': instance.serviceType,
      'frequency': instance.frequency,
      'duration': instance.duration,
      'priority': instance.priority,
      'rationale': instance.rationale,
      'estimatedCost': instance.estimatedCost,
      'providers': instance.providers,
    };

_Provider _$ProviderFromJson(Map<String, dynamic> json) => _Provider(
      name: json['name'] as String,
      rating: (json['rating'] as num).toDouble(),
      availability: json['availability'] as String,
    );

Map<String, dynamic> _$ProviderToJson(_Provider instance) => <String, dynamic>{
      'name': instance.name,
      'rating': instance.rating,
      'availability': instance.availability,
    };

_Resources _$ResourcesFromJson(Map<String, dynamic> json) => _Resources(
      workers: (json['workers'] as num).toInt(),
      equipment:
          (json['equipment'] as List<dynamic>).map((e) => e as String).toList(),
      budget: Budget.fromJson(json['budget'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResourcesToJson(_Resources instance) =>
    <String, dynamic>{
      'workers': instance.workers,
      'equipment': instance.equipment,
      'budget': instance.budget,
    };

_Budget _$BudgetFromJson(Map<String, dynamic> json) => _Budget(
      weekly: (json['weekly'] as num).toInt(),
      monthly: (json['monthly'] as num).toInt(),
    );

Map<String, dynamic> _$BudgetToJson(_Budget instance) => <String, dynamic>{
      'weekly': instance.weekly,
      'monthly': instance.monthly,
    };

_Timeline _$TimelineFromJson(Map<String, dynamic> json) => _Timeline(
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      phases: (json['phases'] as List<dynamic>)
          .map((e) => Phase.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TimelineToJson(_Timeline instance) => <String, dynamic>{
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'phases': instance.phases,
    };

_Phase _$PhaseFromJson(Map<String, dynamic> json) => _Phase(
      phase: json['phase'] as String,
      duration: json['duration'] as String,
      focus: json['focus'] as String,
    );

Map<String, dynamic> _$PhaseToJson(_Phase instance) => <String, dynamic>{
      'phase': instance.phase,
      'duration': instance.duration,
      'focus': instance.focus,
    };

_Review _$ReviewFromJson(Map<String, dynamic> json) => _Review(
      type: json['type'] as String,
      date: json['date'] as String,
    );

Map<String, dynamic> _$ReviewToJson(_Review instance) => <String, dynamic>{
      'type': instance.type,
      'date': instance.date,
    };

_SuccessMetric _$SuccessMetricFromJson(Map<String, dynamic> json) =>
    _SuccessMetric(
      metric: json['metric'] as String,
      target: json['target'] as String,
    );

Map<String, dynamic> _$SuccessMetricToJson(_SuccessMetric instance) =>
    <String, dynamic>{
      'metric': instance.metric,
      'target': instance.target,
    };

_Incident _$IncidentFromJson(Map<String, dynamic> json) => _Incident(
      incidentId: json['incidentId'] as String,
      reportedAt: json['reportedAt'] as String,
      severity: json['severity'] as String,
      category: json['category'] as String,
      immediateActions: (json['immediateActions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      notifications: NotificationRouting.fromJson(
          json['notifications'] as Map<String, dynamic>),
      investigation:
          Investigation.fromJson(json['investigation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IncidentToJson(_Incident instance) => <String, dynamic>{
      'incidentId': instance.incidentId,
      'reportedAt': instance.reportedAt,
      'severity': instance.severity,
      'category': instance.category,
      'immediateActions': instance.immediateActions,
      'notifications': instance.notifications,
      'investigation': instance.investigation,
    };

_NotificationRouting _$NotificationRoutingFromJson(Map<String, dynamic> json) =>
    _NotificationRouting(
      family: json['family'] as bool,
      supervisor: json['supervisor'] as bool,
      careCoordinator: json['careCoordinator'] as bool,
      regulator: json['regulator'] as bool,
    );

Map<String, dynamic> _$NotificationRoutingToJson(
        _NotificationRouting instance) =>
    <String, dynamic>{
      'family': instance.family,
      'supervisor': instance.supervisor,
      'careCoordinator': instance.careCoordinator,
      'regulator': instance.regulator,
    };

_Investigation _$InvestigationFromJson(Map<String, dynamic> json) =>
    _Investigation(
      investigator: json['investigator'] as String,
      dueDate: json['dueDate'] as String,
      steps: (json['steps'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$InvestigationToJson(_Investigation instance) =>
    <String, dynamic>{
      'investigator': instance.investigator,
      'dueDate': instance.dueDate,
      'steps': instance.steps,
    };

_RootCauseAnalysis _$RootCauseAnalysisFromJson(Map<String, dynamic> json) =>
    _RootCauseAnalysis(
      incidentId: json['incidentId'] as String,
      analyzedAt: json['analyzedAt'] as String,
      rootCauses: (json['rootCauses'] as List<dynamic>)
          .map((e) => RootCause.fromJson(e as Map<String, dynamic>))
          .toList(),
      contributingFactors: (json['contributingFactors'] as List<dynamic>)
          .map((e) =>
              ContributingFactorAnalysis.fromJson(e as Map<String, dynamic>))
          .toList(),
      systemicIssues: (json['systemicIssues'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      similarIncidents: (json['similarIncidents'] as List<dynamic>)
          .map((e) => SimilarIncident.fromJson(e as Map<String, dynamic>))
          .toList(),
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$RootCauseAnalysisToJson(_RootCauseAnalysis instance) =>
    <String, dynamic>{
      'incidentId': instance.incidentId,
      'analyzedAt': instance.analyzedAt,
      'rootCauses': instance.rootCauses,
      'contributingFactors': instance.contributingFactors,
      'systemicIssues': instance.systemicIssues,
      'similarIncidents': instance.similarIncidents,
      'recommendations': instance.recommendations,
    };

_RootCause _$RootCauseFromJson(Map<String, dynamic> json) => _RootCause(
      cause: json['cause'] as String,
      likelihood: json['likelihood'] as String,
    );

Map<String, dynamic> _$RootCauseToJson(_RootCause instance) =>
    <String, dynamic>{
      'cause': instance.cause,
      'likelihood': instance.likelihood,
    };

_ContributingFactorAnalysis _$ContributingFactorAnalysisFromJson(
        Map<String, dynamic> json) =>
    _ContributingFactorAnalysis(
      factor: json['factor'] as String,
      contribution: json['contribution'] as String,
    );

Map<String, dynamic> _$ContributingFactorAnalysisToJson(
        _ContributingFactorAnalysis instance) =>
    <String, dynamic>{
      'factor': instance.factor,
      'contribution': instance.contribution,
    };

_SimilarIncident _$SimilarIncidentFromJson(Map<String, dynamic> json) =>
    _SimilarIncident(
      incidentId: json['incidentId'] as String,
      date: json['date'] as String,
      similarity: (json['similarity'] as num).toDouble(),
    );

Map<String, dynamic> _$SimilarIncidentToJson(_SimilarIncident instance) =>
    <String, dynamic>{
      'incidentId': instance.incidentId,
      'date': instance.date,
      'similarity': instance.similarity,
    };

_IncidentPatterns _$IncidentPatternsFromJson(Map<String, dynamic> json) =>
    _IncidentPatterns(
      organizationId: json['organizationId'] as String,
      timeframe: json['timeframe'] as String,
      analyzedAt: json['analyzedAt'] as String,
      frequencyPatterns: FrequencyPatterns.fromJson(
          json['frequencyPatterns'] as Map<String, dynamic>),
      recurringIssues: (json['recurringIssues'] as List<dynamic>)
          .map((e) => RecurringIssue.fromJson(e as Map<String, dynamic>))
          .toList(),
      trends: Trends.fromJson(json['trends'] as Map<String, dynamic>),
      highRiskAreas: (json['highRiskAreas'] as List<dynamic>)
          .map((e) => HighRiskArea.fromJson(e as Map<String, dynamic>))
          .toList(),
      preventiveActions: (json['preventiveActions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$IncidentPatternsToJson(_IncidentPatterns instance) =>
    <String, dynamic>{
      'organizationId': instance.organizationId,
      'timeframe': instance.timeframe,
      'analyzedAt': instance.analyzedAt,
      'frequencyPatterns': instance.frequencyPatterns,
      'recurringIssues': instance.recurringIssues,
      'trends': instance.trends,
      'highRiskAreas': instance.highRiskAreas,
      'preventiveActions': instance.preventiveActions,
    };

_FrequencyPatterns _$FrequencyPatternsFromJson(Map<String, dynamic> json) =>
    _FrequencyPatterns(
      byType: Map<String, int>.from(json['byType'] as Map),
      byLocation: Map<String, int>.from(json['byLocation'] as Map),
      byTimeOfDay: Map<String, int>.from(json['byTimeOfDay'] as Map),
      byDayOfWeek: Map<String, int>.from(json['byDayOfWeek'] as Map),
    );

Map<String, dynamic> _$FrequencyPatternsToJson(_FrequencyPatterns instance) =>
    <String, dynamic>{
      'byType': instance.byType,
      'byLocation': instance.byLocation,
      'byTimeOfDay': instance.byTimeOfDay,
      'byDayOfWeek': instance.byDayOfWeek,
    };

_RecurringIssue _$RecurringIssueFromJson(Map<String, dynamic> json) =>
    _RecurringIssue(
      issue: json['issue'] as String,
      frequency: (json['frequency'] as num).toInt(),
      trend: json['trend'] as String,
    );

Map<String, dynamic> _$RecurringIssueToJson(_RecurringIssue instance) =>
    <String, dynamic>{
      'issue': instance.issue,
      'frequency': instance.frequency,
      'trend': instance.trend,
    };

_Trends _$TrendsFromJson(Map<String, dynamic> json) => _Trends(
      direction: json['direction'] as String,
      changePercentage: (json['changePercentage'] as num).toInt(),
      significance: json['significance'] as String,
    );

Map<String, dynamic> _$TrendsToJson(_Trends instance) => <String, dynamic>{
      'direction': instance.direction,
      'changePercentage': instance.changePercentage,
      'significance': instance.significance,
    };

_HighRiskArea _$HighRiskAreaFromJson(Map<String, dynamic> json) =>
    _HighRiskArea(
      area: json['area'] as String,
      riskLevel: json['riskLevel'] as String,
    );

Map<String, dynamic> _$HighRiskAreaToJson(_HighRiskArea instance) =>
    <String, dynamic>{
      'area': instance.area,
      'riskLevel': instance.riskLevel,
    };

_DrugInteraction _$DrugInteractionFromJson(Map<String, dynamic> json) =>
    _DrugInteraction(
      medications: (json['medications'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      severity: json['severity'] as String,
      description: json['description'] as String,
      recommendation: json['recommendation'] as String,
      references: (json['references'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$DrugInteractionToJson(_DrugInteraction instance) =>
    <String, dynamic>{
      'medications': instance.medications,
      'severity': instance.severity,
      'description': instance.description,
      'recommendation': instance.recommendation,
      'references': instance.references,
    };

_MedicationCompliance _$MedicationComplianceFromJson(
        Map<String, dynamic> json) =>
    _MedicationCompliance(
      clientId: json['clientId'] as String,
      period: json['period'] as String,
      analyzedAt: json['analyzedAt'] as String,
      overallCompliance: (json['overallCompliance'] as num).toDouble(),
      byMedication: (json['byMedication'] as List<dynamic>)
          .map((e) =>
              MedicationComplianceDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      patterns:
          CompliancePatterns.fromJson(json['patterns'] as Map<String, dynamic>),
      riskAssessment: ComplianceRiskAssessment.fromJson(
          json['riskAssessment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MedicationComplianceToJson(
        _MedicationCompliance instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'period': instance.period,
      'analyzedAt': instance.analyzedAt,
      'overallCompliance': instance.overallCompliance,
      'byMedication': instance.byMedication,
      'patterns': instance.patterns,
      'riskAssessment': instance.riskAssessment,
    };

_MedicationComplianceDetail _$MedicationComplianceDetailFromJson(
        Map<String, dynamic> json) =>
    _MedicationComplianceDetail(
      medication: json['medication'] as String,
      prescribed: (json['prescribed'] as num).toInt(),
      administered: (json['administered'] as num).toInt(),
      missed: (json['missed'] as num).toInt(),
      compliance: (json['compliance'] as num).toDouble(),
    );

Map<String, dynamic> _$MedicationComplianceDetailToJson(
        _MedicationComplianceDetail instance) =>
    <String, dynamic>{
      'medication': instance.medication,
      'prescribed': instance.prescribed,
      'administered': instance.administered,
      'missed': instance.missed,
      'compliance': instance.compliance,
    };

_CompliancePatterns _$CompliancePatternsFromJson(Map<String, dynamic> json) =>
    _CompliancePatterns(
      missedDoses:
          MissedDoses.fromJson(json['missedDoses'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CompliancePatternsToJson(_CompliancePatterns instance) =>
    <String, dynamic>{
      'missedDoses': instance.missedDoses,
    };

_MissedDoses _$MissedDosesFromJson(Map<String, dynamic> json) => _MissedDoses(
      timeOfDay:
          (json['timeOfDay'] as List<dynamic>).map((e) => e as String).toList(),
      dayOfWeek:
          (json['dayOfWeek'] as List<dynamic>).map((e) => e as String).toList(),
      reasons:
          (json['reasons'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$MissedDosesToJson(_MissedDoses instance) =>
    <String, dynamic>{
      'timeOfDay': instance.timeOfDay,
      'dayOfWeek': instance.dayOfWeek,
      'reasons': instance.reasons,
    };

_ComplianceRiskAssessment _$ComplianceRiskAssessmentFromJson(
        Map<String, dynamic> json) =>
    _ComplianceRiskAssessment(
      nonComplianceRisk: (json['nonComplianceRisk'] as num).toDouble(),
      factors:
          (json['factors'] as List<dynamic>).map((e) => e as String).toList(),
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ComplianceRiskAssessmentToJson(
        _ComplianceRiskAssessment instance) =>
    <String, dynamic>{
      'nonComplianceRisk': instance.nonComplianceRisk,
      'factors': instance.factors,
      'recommendations': instance.recommendations,
    };

_MedicationAlert _$MedicationAlertFromJson(Map<String, dynamic> json) =>
    _MedicationAlert(
      type: json['type'] as String,
      severity: json['severity'] as String,
      medication: json['medication'] as String?,
      medications: (json['medications'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      message: json['message'] as String,
      action: json['action'] as String,
      dueDate: json['dueDate'] as String?,
      timestamp: json['timestamp'] as String?,
    );

Map<String, dynamic> _$MedicationAlertToJson(_MedicationAlert instance) =>
    <String, dynamic>{
      'type': instance.type,
      'severity': instance.severity,
      'medication': instance.medication,
      'medications': instance.medications,
      'message': instance.message,
      'action': instance.action,
      'dueDate': instance.dueDate,
      'timestamp': instance.timestamp,
    };
