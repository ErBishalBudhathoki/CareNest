// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'care_intelligence_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IntelligenceReportImpl _$$IntelligenceReportImplFromJson(
        Map<String, dynamic> json) =>
    _$IntelligenceReportImpl(
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

Map<String, dynamic> _$$IntelligenceReportImplToJson(
        _$IntelligenceReportImpl instance) =>
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

_$RiskSummaryImpl _$$RiskSummaryImplFromJson(Map<String, dynamic> json) =>
    _$RiskSummaryImpl(
      overallRisk: (json['overallRisk'] as num).toDouble(),
      highRiskAreas: (json['highRiskAreas'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      trendDirection: json['trendDirection'] as String,
      lastAssessment: json['lastAssessment'] as String,
    );

Map<String, dynamic> _$$RiskSummaryImplToJson(_$RiskSummaryImpl instance) =>
    <String, dynamic>{
      'overallRisk': instance.overallRisk,
      'highRiskAreas': instance.highRiskAreas,
      'trendDirection': instance.trendDirection,
      'lastAssessment': instance.lastAssessment,
    };

_$RecommendationImpl _$$RecommendationImplFromJson(Map<String, dynamic> json) =>
    _$RecommendationImpl(
      category: json['category'] as String,
      recommendation: json['recommendation'] as String,
      priority: json['priority'] as String,
      expectedImpact: json['expectedImpact'] as String,
    );

Map<String, dynamic> _$$RecommendationImplToJson(
        _$RecommendationImpl instance) =>
    <String, dynamic>{
      'category': instance.category,
      'recommendation': instance.recommendation,
      'priority': instance.priority,
      'expectedImpact': instance.expectedImpact,
    };

_$OutcomePredictionsImpl _$$OutcomePredictionsImplFromJson(
        Map<String, dynamic> json) =>
    _$OutcomePredictionsImpl(
      goalAchievement: GoalAchievementPrediction.fromJson(
          json['goalAchievement'] as Map<String, dynamic>),
      healthStability: HealthStabilityPrediction.fromJson(
          json['healthStability'] as Map<String, dynamic>),
      serviceUtilization: ServiceUtilizationPrediction.fromJson(
          json['serviceUtilization'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$OutcomePredictionsImplToJson(
        _$OutcomePredictionsImpl instance) =>
    <String, dynamic>{
      'goalAchievement': instance.goalAchievement,
      'healthStability': instance.healthStability,
      'serviceUtilization': instance.serviceUtilization,
    };

_$GoalAchievementPredictionImpl _$$GoalAchievementPredictionImplFromJson(
        Map<String, dynamic> json) =>
    _$GoalAchievementPredictionImpl(
      probability: (json['probability'] as num).toDouble(),
      timeline: json['timeline'] as String,
      confidence: (json['confidence'] as num).toDouble(),
    );

Map<String, dynamic> _$$GoalAchievementPredictionImplToJson(
        _$GoalAchievementPredictionImpl instance) =>
    <String, dynamic>{
      'probability': instance.probability,
      'timeline': instance.timeline,
      'confidence': instance.confidence,
    };

_$HealthStabilityPredictionImpl _$$HealthStabilityPredictionImplFromJson(
        Map<String, dynamic> json) =>
    _$HealthStabilityPredictionImpl(
      probability: (json['probability'] as num).toDouble(),
      factors:
          (json['factors'] as List<dynamic>).map((e) => e as String).toList(),
      confidence: (json['confidence'] as num).toDouble(),
    );

Map<String, dynamic> _$$HealthStabilityPredictionImplToJson(
        _$HealthStabilityPredictionImpl instance) =>
    <String, dynamic>{
      'probability': instance.probability,
      'factors': instance.factors,
      'confidence': instance.confidence,
    };

_$ServiceUtilizationPredictionImpl _$$ServiceUtilizationPredictionImplFromJson(
        Map<String, dynamic> json) =>
    _$ServiceUtilizationPredictionImpl(
      predictedChange: json['predictedChange'] as String,
      percentage: (json['percentage'] as num).toInt(),
      confidence: (json['confidence'] as num).toDouble(),
    );

Map<String, dynamic> _$$ServiceUtilizationPredictionImplToJson(
        _$ServiceUtilizationPredictionImpl instance) =>
    <String, dynamic>{
      'predictedChange': instance.predictedChange,
      'percentage': instance.percentage,
      'confidence': instance.confidence,
    };

_$AlertImpl _$$AlertImplFromJson(Map<String, dynamic> json) => _$AlertImpl(
      severity: json['severity'] as String,
      type: json['type'] as String,
      message: json['message'] as String,
      action: json['action'] as String,
    );

Map<String, dynamic> _$$AlertImplToJson(_$AlertImpl instance) =>
    <String, dynamic>{
      'severity': instance.severity,
      'type': instance.type,
      'message': instance.message,
      'action': instance.action,
    };

_$NextActionImpl _$$NextActionImplFromJson(Map<String, dynamic> json) =>
    _$NextActionImpl(
      action: json['action'] as String,
      priority: json['priority'] as String,
      deadline: json['deadline'] as String,
      assignedTo: json['assignedTo'] as String,
    );

Map<String, dynamic> _$$NextActionImplToJson(_$NextActionImpl instance) =>
    <String, dynamic>{
      'action': instance.action,
      'priority': instance.priority,
      'deadline': instance.deadline,
      'assignedTo': instance.assignedTo,
    };

_$CarePatternsImpl _$$CarePatternsImplFromJson(Map<String, dynamic> json) =>
    _$CarePatternsImpl(
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

Map<String, dynamic> _$$CarePatternsImplToJson(_$CarePatternsImpl instance) =>
    <String, dynamic>{
      'serviceUtilization': instance.serviceUtilization,
      'healthTrends': instance.healthTrends,
      'behaviorPatterns': instance.behaviorPatterns,
      'goalProgress': instance.goalProgress,
      'familyEngagement': instance.familyEngagement,
    };

_$ServiceUtilizationImpl _$$ServiceUtilizationImplFromJson(
        Map<String, dynamic> json) =>
    _$ServiceUtilizationImpl(
      trend: json['trend'] as String,
      averageHoursPerWeek: (json['averageHoursPerWeek'] as num).toInt(),
      peakDays:
          (json['peakDays'] as List<dynamic>).map((e) => e as String).toList(),
      preferredTimes: (json['preferredTimes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$ServiceUtilizationImplToJson(
        _$ServiceUtilizationImpl instance) =>
    <String, dynamic>{
      'trend': instance.trend,
      'averageHoursPerWeek': instance.averageHoursPerWeek,
      'peakDays': instance.peakDays,
      'preferredTimes': instance.preferredTimes,
    };

_$HealthTrendsImpl _$$HealthTrendsImplFromJson(Map<String, dynamic> json) =>
    _$HealthTrendsImpl(
      vitalStability: (json['vitalStability'] as num).toDouble(),
      medicationCompliance: (json['medicationCompliance'] as num).toDouble(),
      incidentFrequency: (json['incidentFrequency'] as num).toInt(),
      overallTrend: json['overallTrend'] as String,
    );

Map<String, dynamic> _$$HealthTrendsImplToJson(_$HealthTrendsImpl instance) =>
    <String, dynamic>{
      'vitalStability': instance.vitalStability,
      'medicationCompliance': instance.medicationCompliance,
      'incidentFrequency': instance.incidentFrequency,
      'overallTrend': instance.overallTrend,
    };

_$BehaviorPatternsImpl _$$BehaviorPatternsImplFromJson(
        Map<String, dynamic> json) =>
    _$BehaviorPatternsImpl(
      positiveInteractions: (json['positiveInteractions'] as num).toInt(),
      challengingBehaviors: (json['challengingBehaviors'] as num).toInt(),
      triggerPatterns: (json['triggerPatterns'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      responseEffectiveness: (json['responseEffectiveness'] as num).toDouble(),
    );

Map<String, dynamic> _$$BehaviorPatternsImplToJson(
        _$BehaviorPatternsImpl instance) =>
    <String, dynamic>{
      'positiveInteractions': instance.positiveInteractions,
      'challengingBehaviors': instance.challengingBehaviors,
      'triggerPatterns': instance.triggerPatterns,
      'responseEffectiveness': instance.responseEffectiveness,
    };

_$GoalProgressImpl _$$GoalProgressImplFromJson(Map<String, dynamic> json) =>
    _$GoalProgressImpl(
      onTrack: (json['onTrack'] as num).toInt(),
      needsAttention: (json['needsAttention'] as num).toInt(),
      achieved: (json['achieved'] as num).toInt(),
      averageProgress: (json['averageProgress'] as num).toDouble(),
    );

Map<String, dynamic> _$$GoalProgressImplToJson(_$GoalProgressImpl instance) =>
    <String, dynamic>{
      'onTrack': instance.onTrack,
      'needsAttention': instance.needsAttention,
      'achieved': instance.achieved,
      'averageProgress': instance.averageProgress,
    };

_$FamilyEngagementImpl _$$FamilyEngagementImplFromJson(
        Map<String, dynamic> json) =>
    _$FamilyEngagementImpl(
      communicationFrequency: json['communicationFrequency'] as String,
      satisfactionScore: (json['satisfactionScore'] as num).toDouble(),
      concernsRaised: (json['concernsRaised'] as num).toInt(),
      participationLevel: (json['participationLevel'] as num).toDouble(),
    );

Map<String, dynamic> _$$FamilyEngagementImplToJson(
        _$FamilyEngagementImpl instance) =>
    <String, dynamic>{
      'communicationFrequency': instance.communicationFrequency,
      'satisfactionScore': instance.satisfactionScore,
      'concernsRaised': instance.concernsRaised,
      'participationLevel': instance.participationLevel,
    };

_$RiskAssessmentImpl _$$RiskAssessmentImplFromJson(Map<String, dynamic> json) =>
    _$RiskAssessmentImpl(
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

Map<String, dynamic> _$$RiskAssessmentImplToJson(
        _$RiskAssessmentImpl instance) =>
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

_$RiskCategoryImpl _$$RiskCategoryImplFromJson(Map<String, dynamic> json) =>
    _$RiskCategoryImpl(
      score: (json['score'] as num).toInt(),
      level: json['level'] as String,
      lastIncident: json['lastIncident'] as String?,
      recentIncidents: (json['recentIncidents'] as num?)?.toInt(),
      conditions: (json['conditions'] as num?)?.toInt(),
      medications: (json['medications'] as num?)?.toInt(),
      isolationIndicators: (json['isolationIndicators'] as num?)?.toInt(),
      concerns: (json['concerns'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$RiskCategoryImplToJson(_$RiskCategoryImpl instance) =>
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

_$RiskTrendsImpl _$$RiskTrendsImplFromJson(Map<String, dynamic> json) =>
    _$RiskTrendsImpl(
      direction: json['direction'] as String,
      changePercentage: (json['changePercentage'] as num).toInt(),
      period: json['period'] as String,
    );

Map<String, dynamic> _$$RiskTrendsImplToJson(_$RiskTrendsImpl instance) =>
    <String, dynamic>{
      'direction': instance.direction,
      'changePercentage': instance.changePercentage,
      'period': instance.period,
    };

_$RiskRecommendationImpl _$$RiskRecommendationImplFromJson(
        Map<String, dynamic> json) =>
    _$RiskRecommendationImpl(
      priority: json['priority'] as String,
      recommendation: json['recommendation'] as String,
      timeline: json['timeline'] as String,
    );

Map<String, dynamic> _$$RiskRecommendationImplToJson(
        _$RiskRecommendationImpl instance) =>
    <String, dynamic>{
      'priority': instance.priority,
      'recommendation': instance.recommendation,
      'timeline': instance.timeline,
    };

_$FallsRiskAssessmentImpl _$$FallsRiskAssessmentImplFromJson(
        Map<String, dynamic> json) =>
    _$FallsRiskAssessmentImpl(
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

Map<String, dynamic> _$$FallsRiskAssessmentImplToJson(
        _$FallsRiskAssessmentImpl instance) =>
    <String, dynamic>{
      'riskScore': instance.riskScore,
      'riskLevel': instance.riskLevel,
      'confidence': instance.confidence,
      'contributingFactors': instance.contributingFactors,
      'preventionStrategies': instance.preventionStrategies,
      'monitoringPlan': instance.monitoringPlan,
      'interventions': instance.interventions,
    };

_$ContributingFactorImpl _$$ContributingFactorImplFromJson(
        Map<String, dynamic> json) =>
    _$ContributingFactorImpl(
      factor: json['factor'] as String,
      weight: (json['weight'] as num).toDouble(),
      present: json['present'] as bool,
    );

Map<String, dynamic> _$$ContributingFactorImplToJson(
        _$ContributingFactorImpl instance) =>
    <String, dynamic>{
      'factor': instance.factor,
      'weight': instance.weight,
      'present': instance.present,
    };

_$MonitoringPlanImpl _$$MonitoringPlanImplFromJson(Map<String, dynamic> json) =>
    _$MonitoringPlanImpl(
      frequency: json['frequency'] as String,
      indicators: (json['indicators'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      alerts: json['alerts'] as bool,
    );

Map<String, dynamic> _$$MonitoringPlanImplToJson(
        _$MonitoringPlanImpl instance) =>
    <String, dynamic>{
      'frequency': instance.frequency,
      'indicators': instance.indicators,
      'alerts': instance.alerts,
    };

_$BehaviorEscalationPredictionImpl _$$BehaviorEscalationPredictionImplFromJson(
        Map<String, dynamic> json) =>
    _$BehaviorEscalationPredictionImpl(
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

Map<String, dynamic> _$$BehaviorEscalationPredictionImplToJson(
        _$BehaviorEscalationPredictionImpl instance) =>
    <String, dynamic>{
      'escalationProbability': instance.escalationProbability,
      'timeframe': instance.timeframe,
      'confidence': instance.confidence,
      'triggers': instance.triggers,
      'earlyWarningSignals': instance.earlyWarningSignals,
      'deEscalationStrategies': instance.deEscalationStrategies,
      'preventiveMeasures': instance.preventiveMeasures,
    };

_$TriggerImpl _$$TriggerImplFromJson(Map<String, dynamic> json) =>
    _$TriggerImpl(
      trigger: json['trigger'] as String,
      likelihood: (json['likelihood'] as num).toDouble(),
    );

Map<String, dynamic> _$$TriggerImplToJson(_$TriggerImpl instance) =>
    <String, dynamic>{
      'trigger': instance.trigger,
      'likelihood': instance.likelihood,
    };

_$CarePlanImpl _$$CarePlanImplFromJson(Map<String, dynamic> json) =>
    _$CarePlanImpl(
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

Map<String, dynamic> _$$CarePlanImplToJson(_$CarePlanImpl instance) =>
    <String, dynamic>{
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

_$AssessmentImpl _$$AssessmentImplFromJson(Map<String, dynamic> json) =>
    _$AssessmentImpl(
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

Map<String, dynamic> _$$AssessmentImplToJson(_$AssessmentImpl instance) =>
    <String, dynamic>{
      'strengths': instance.strengths,
      'needs': instance.needs,
      'preferences': instance.preferences,
      'riskFactors': instance.riskFactors,
    };

_$SmartGoalImpl _$$SmartGoalImplFromJson(Map<String, dynamic> json) =>
    _$SmartGoalImpl(
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

Map<String, dynamic> _$$SmartGoalImplToJson(_$SmartGoalImpl instance) =>
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

_$MilestoneImpl _$$MilestoneImplFromJson(Map<String, dynamic> json) =>
    _$MilestoneImpl(
      milestone: json['milestone'] as String,
      target: json['target'] as String,
      date: json['date'] as String,
    );

Map<String, dynamic> _$$MilestoneImplToJson(_$MilestoneImpl instance) =>
    <String, dynamic>{
      'milestone': instance.milestone,
      'target': instance.target,
      'date': instance.date,
    };

_$ServiceRecommendationImpl _$$ServiceRecommendationImplFromJson(
        Map<String, dynamic> json) =>
    _$ServiceRecommendationImpl(
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

Map<String, dynamic> _$$ServiceRecommendationImplToJson(
        _$ServiceRecommendationImpl instance) =>
    <String, dynamic>{
      'serviceType': instance.serviceType,
      'frequency': instance.frequency,
      'duration': instance.duration,
      'priority': instance.priority,
      'rationale': instance.rationale,
      'estimatedCost': instance.estimatedCost,
      'providers': instance.providers,
    };

_$ProviderImpl _$$ProviderImplFromJson(Map<String, dynamic> json) =>
    _$ProviderImpl(
      name: json['name'] as String,
      rating: (json['rating'] as num).toDouble(),
      availability: json['availability'] as String,
    );

Map<String, dynamic> _$$ProviderImplToJson(_$ProviderImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'rating': instance.rating,
      'availability': instance.availability,
    };

_$ResourcesImpl _$$ResourcesImplFromJson(Map<String, dynamic> json) =>
    _$ResourcesImpl(
      workers: (json['workers'] as num).toInt(),
      equipment:
          (json['equipment'] as List<dynamic>).map((e) => e as String).toList(),
      budget: Budget.fromJson(json['budget'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ResourcesImplToJson(_$ResourcesImpl instance) =>
    <String, dynamic>{
      'workers': instance.workers,
      'equipment': instance.equipment,
      'budget': instance.budget,
    };

_$BudgetImpl _$$BudgetImplFromJson(Map<String, dynamic> json) => _$BudgetImpl(
      weekly: (json['weekly'] as num).toInt(),
      monthly: (json['monthly'] as num).toInt(),
    );

Map<String, dynamic> _$$BudgetImplToJson(_$BudgetImpl instance) =>
    <String, dynamic>{
      'weekly': instance.weekly,
      'monthly': instance.monthly,
    };

_$TimelineImpl _$$TimelineImplFromJson(Map<String, dynamic> json) =>
    _$TimelineImpl(
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      phases: (json['phases'] as List<dynamic>)
          .map((e) => Phase.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TimelineImplToJson(_$TimelineImpl instance) =>
    <String, dynamic>{
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'phases': instance.phases,
    };

_$PhaseImpl _$$PhaseImplFromJson(Map<String, dynamic> json) => _$PhaseImpl(
      phase: json['phase'] as String,
      duration: json['duration'] as String,
      focus: json['focus'] as String,
    );

Map<String, dynamic> _$$PhaseImplToJson(_$PhaseImpl instance) =>
    <String, dynamic>{
      'phase': instance.phase,
      'duration': instance.duration,
      'focus': instance.focus,
    };

_$ReviewImpl _$$ReviewImplFromJson(Map<String, dynamic> json) => _$ReviewImpl(
      type: json['type'] as String,
      date: json['date'] as String,
    );

Map<String, dynamic> _$$ReviewImplToJson(_$ReviewImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'date': instance.date,
    };

_$SuccessMetricImpl _$$SuccessMetricImplFromJson(Map<String, dynamic> json) =>
    _$SuccessMetricImpl(
      metric: json['metric'] as String,
      target: json['target'] as String,
    );

Map<String, dynamic> _$$SuccessMetricImplToJson(_$SuccessMetricImpl instance) =>
    <String, dynamic>{
      'metric': instance.metric,
      'target': instance.target,
    };

_$IncidentImpl _$$IncidentImplFromJson(Map<String, dynamic> json) =>
    _$IncidentImpl(
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

Map<String, dynamic> _$$IncidentImplToJson(_$IncidentImpl instance) =>
    <String, dynamic>{
      'incidentId': instance.incidentId,
      'reportedAt': instance.reportedAt,
      'severity': instance.severity,
      'category': instance.category,
      'immediateActions': instance.immediateActions,
      'notifications': instance.notifications,
      'investigation': instance.investigation,
    };

_$NotificationRoutingImpl _$$NotificationRoutingImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationRoutingImpl(
      family: json['family'] as bool,
      supervisor: json['supervisor'] as bool,
      careCoordinator: json['careCoordinator'] as bool,
      regulator: json['regulator'] as bool,
    );

Map<String, dynamic> _$$NotificationRoutingImplToJson(
        _$NotificationRoutingImpl instance) =>
    <String, dynamic>{
      'family': instance.family,
      'supervisor': instance.supervisor,
      'careCoordinator': instance.careCoordinator,
      'regulator': instance.regulator,
    };

_$InvestigationImpl _$$InvestigationImplFromJson(Map<String, dynamic> json) =>
    _$InvestigationImpl(
      investigator: json['investigator'] as String,
      dueDate: json['dueDate'] as String,
      steps: (json['steps'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$InvestigationImplToJson(_$InvestigationImpl instance) =>
    <String, dynamic>{
      'investigator': instance.investigator,
      'dueDate': instance.dueDate,
      'steps': instance.steps,
    };

_$RootCauseAnalysisImpl _$$RootCauseAnalysisImplFromJson(
        Map<String, dynamic> json) =>
    _$RootCauseAnalysisImpl(
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

Map<String, dynamic> _$$RootCauseAnalysisImplToJson(
        _$RootCauseAnalysisImpl instance) =>
    <String, dynamic>{
      'incidentId': instance.incidentId,
      'analyzedAt': instance.analyzedAt,
      'rootCauses': instance.rootCauses,
      'contributingFactors': instance.contributingFactors,
      'systemicIssues': instance.systemicIssues,
      'similarIncidents': instance.similarIncidents,
      'recommendations': instance.recommendations,
    };

_$RootCauseImpl _$$RootCauseImplFromJson(Map<String, dynamic> json) =>
    _$RootCauseImpl(
      cause: json['cause'] as String,
      likelihood: json['likelihood'] as String,
    );

Map<String, dynamic> _$$RootCauseImplToJson(_$RootCauseImpl instance) =>
    <String, dynamic>{
      'cause': instance.cause,
      'likelihood': instance.likelihood,
    };

_$ContributingFactorAnalysisImpl _$$ContributingFactorAnalysisImplFromJson(
        Map<String, dynamic> json) =>
    _$ContributingFactorAnalysisImpl(
      factor: json['factor'] as String,
      contribution: json['contribution'] as String,
    );

Map<String, dynamic> _$$ContributingFactorAnalysisImplToJson(
        _$ContributingFactorAnalysisImpl instance) =>
    <String, dynamic>{
      'factor': instance.factor,
      'contribution': instance.contribution,
    };

_$SimilarIncidentImpl _$$SimilarIncidentImplFromJson(
        Map<String, dynamic> json) =>
    _$SimilarIncidentImpl(
      incidentId: json['incidentId'] as String,
      date: json['date'] as String,
      similarity: (json['similarity'] as num).toDouble(),
    );

Map<String, dynamic> _$$SimilarIncidentImplToJson(
        _$SimilarIncidentImpl instance) =>
    <String, dynamic>{
      'incidentId': instance.incidentId,
      'date': instance.date,
      'similarity': instance.similarity,
    };

_$IncidentPatternsImpl _$$IncidentPatternsImplFromJson(
        Map<String, dynamic> json) =>
    _$IncidentPatternsImpl(
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

Map<String, dynamic> _$$IncidentPatternsImplToJson(
        _$IncidentPatternsImpl instance) =>
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

_$FrequencyPatternsImpl _$$FrequencyPatternsImplFromJson(
        Map<String, dynamic> json) =>
    _$FrequencyPatternsImpl(
      byType: Map<String, int>.from(json['byType'] as Map),
      byLocation: Map<String, int>.from(json['byLocation'] as Map),
      byTimeOfDay: Map<String, int>.from(json['byTimeOfDay'] as Map),
      byDayOfWeek: Map<String, int>.from(json['byDayOfWeek'] as Map),
    );

Map<String, dynamic> _$$FrequencyPatternsImplToJson(
        _$FrequencyPatternsImpl instance) =>
    <String, dynamic>{
      'byType': instance.byType,
      'byLocation': instance.byLocation,
      'byTimeOfDay': instance.byTimeOfDay,
      'byDayOfWeek': instance.byDayOfWeek,
    };

_$RecurringIssueImpl _$$RecurringIssueImplFromJson(Map<String, dynamic> json) =>
    _$RecurringIssueImpl(
      issue: json['issue'] as String,
      frequency: (json['frequency'] as num).toInt(),
      trend: json['trend'] as String,
    );

Map<String, dynamic> _$$RecurringIssueImplToJson(
        _$RecurringIssueImpl instance) =>
    <String, dynamic>{
      'issue': instance.issue,
      'frequency': instance.frequency,
      'trend': instance.trend,
    };

_$TrendsImpl _$$TrendsImplFromJson(Map<String, dynamic> json) => _$TrendsImpl(
      direction: json['direction'] as String,
      changePercentage: (json['changePercentage'] as num).toInt(),
      significance: json['significance'] as String,
    );

Map<String, dynamic> _$$TrendsImplToJson(_$TrendsImpl instance) =>
    <String, dynamic>{
      'direction': instance.direction,
      'changePercentage': instance.changePercentage,
      'significance': instance.significance,
    };

_$HighRiskAreaImpl _$$HighRiskAreaImplFromJson(Map<String, dynamic> json) =>
    _$HighRiskAreaImpl(
      area: json['area'] as String,
      riskLevel: json['riskLevel'] as String,
    );

Map<String, dynamic> _$$HighRiskAreaImplToJson(_$HighRiskAreaImpl instance) =>
    <String, dynamic>{
      'area': instance.area,
      'riskLevel': instance.riskLevel,
    };

_$DrugInteractionImpl _$$DrugInteractionImplFromJson(
        Map<String, dynamic> json) =>
    _$DrugInteractionImpl(
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

Map<String, dynamic> _$$DrugInteractionImplToJson(
        _$DrugInteractionImpl instance) =>
    <String, dynamic>{
      'medications': instance.medications,
      'severity': instance.severity,
      'description': instance.description,
      'recommendation': instance.recommendation,
      'references': instance.references,
    };

_$MedicationComplianceImpl _$$MedicationComplianceImplFromJson(
        Map<String, dynamic> json) =>
    _$MedicationComplianceImpl(
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

Map<String, dynamic> _$$MedicationComplianceImplToJson(
        _$MedicationComplianceImpl instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'period': instance.period,
      'analyzedAt': instance.analyzedAt,
      'overallCompliance': instance.overallCompliance,
      'byMedication': instance.byMedication,
      'patterns': instance.patterns,
      'riskAssessment': instance.riskAssessment,
    };

_$MedicationComplianceDetailImpl _$$MedicationComplianceDetailImplFromJson(
        Map<String, dynamic> json) =>
    _$MedicationComplianceDetailImpl(
      medication: json['medication'] as String,
      prescribed: (json['prescribed'] as num).toInt(),
      administered: (json['administered'] as num).toInt(),
      missed: (json['missed'] as num).toInt(),
      compliance: (json['compliance'] as num).toDouble(),
    );

Map<String, dynamic> _$$MedicationComplianceDetailImplToJson(
        _$MedicationComplianceDetailImpl instance) =>
    <String, dynamic>{
      'medication': instance.medication,
      'prescribed': instance.prescribed,
      'administered': instance.administered,
      'missed': instance.missed,
      'compliance': instance.compliance,
    };

_$CompliancePatternsImpl _$$CompliancePatternsImplFromJson(
        Map<String, dynamic> json) =>
    _$CompliancePatternsImpl(
      missedDoses:
          MissedDoses.fromJson(json['missedDoses'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CompliancePatternsImplToJson(
        _$CompliancePatternsImpl instance) =>
    <String, dynamic>{
      'missedDoses': instance.missedDoses,
    };

_$MissedDosesImpl _$$MissedDosesImplFromJson(Map<String, dynamic> json) =>
    _$MissedDosesImpl(
      timeOfDay:
          (json['timeOfDay'] as List<dynamic>).map((e) => e as String).toList(),
      dayOfWeek:
          (json['dayOfWeek'] as List<dynamic>).map((e) => e as String).toList(),
      reasons:
          (json['reasons'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$MissedDosesImplToJson(_$MissedDosesImpl instance) =>
    <String, dynamic>{
      'timeOfDay': instance.timeOfDay,
      'dayOfWeek': instance.dayOfWeek,
      'reasons': instance.reasons,
    };

_$ComplianceRiskAssessmentImpl _$$ComplianceRiskAssessmentImplFromJson(
        Map<String, dynamic> json) =>
    _$ComplianceRiskAssessmentImpl(
      nonComplianceRisk: (json['nonComplianceRisk'] as num).toDouble(),
      factors:
          (json['factors'] as List<dynamic>).map((e) => e as String).toList(),
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$ComplianceRiskAssessmentImplToJson(
        _$ComplianceRiskAssessmentImpl instance) =>
    <String, dynamic>{
      'nonComplianceRisk': instance.nonComplianceRisk,
      'factors': instance.factors,
      'recommendations': instance.recommendations,
    };

_$MedicationAlertImpl _$$MedicationAlertImplFromJson(
        Map<String, dynamic> json) =>
    _$MedicationAlertImpl(
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

Map<String, dynamic> _$$MedicationAlertImplToJson(
        _$MedicationAlertImpl instance) =>
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
