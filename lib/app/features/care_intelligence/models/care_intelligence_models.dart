import 'package:freezed_annotation/freezed_annotation.dart';

part 'care_intelligence_models.freezed.dart';
part 'care_intelligence_models.g.dart';

// ============================================================================
// Care Intelligence Models
// ============================================================================

@freezed
class IntelligenceReport with _$IntelligenceReport {
  const factory IntelligenceReport({
    required String clientId,
    required String organizationId,
    required String generatedAt,
    required int intelligenceScore,
    required RiskSummary riskSummary,
    required List<Recommendation> recommendations,
    required OutcomePredictions outcomePredictions,
    required List<Alert> alerts,
    required List<NextAction> nextActions,
  }) = _IntelligenceReport;

  factory IntelligenceReport.fromJson(Map<String, dynamic> json) =>
      _$IntelligenceReportFromJson(json);
}

@freezed
class RiskSummary with _$RiskSummary {
  const factory RiskSummary({
    required double overallRisk,
    required List<String> highRiskAreas,
    required String trendDirection,
    required String lastAssessment,
  }) = _RiskSummary;

  factory RiskSummary.fromJson(Map<String, dynamic> json) =>
      _$RiskSummaryFromJson(json);
}

@freezed
class Recommendation with _$Recommendation {
  const factory Recommendation({
    required String category,
    required String recommendation,
    required String priority,
    required String expectedImpact,
  }) = _Recommendation;

  factory Recommendation.fromJson(Map<String, dynamic> json) =>
      _$RecommendationFromJson(json);
}

@freezed
class OutcomePredictions with _$OutcomePredictions {
  const factory OutcomePredictions({
    required GoalAchievementPrediction goalAchievement,
    required HealthStabilityPrediction healthStability,
    required ServiceUtilizationPrediction serviceUtilization,
  }) = _OutcomePredictions;

  factory OutcomePredictions.fromJson(Map<String, dynamic> json) =>
      _$OutcomePredictionsFromJson(json);
}

@freezed
class GoalAchievementPrediction with _$GoalAchievementPrediction {
  const factory GoalAchievementPrediction({
    required double probability,
    required String timeline,
    required double confidence,
  }) = _GoalAchievementPrediction;

  factory GoalAchievementPrediction.fromJson(Map<String, dynamic> json) =>
      _$GoalAchievementPredictionFromJson(json);
}

@freezed
class HealthStabilityPrediction with _$HealthStabilityPrediction {
  const factory HealthStabilityPrediction({
    required double probability,
    required List<String> factors,
    required double confidence,
  }) = _HealthStabilityPrediction;

  factory HealthStabilityPrediction.fromJson(Map<String, dynamic> json) =>
      _$HealthStabilityPredictionFromJson(json);
}

@freezed
class ServiceUtilizationPrediction with _$ServiceUtilizationPrediction {
  const factory ServiceUtilizationPrediction({
    required String predictedChange,
    required int percentage,
    required double confidence,
  }) = _ServiceUtilizationPrediction;

  factory ServiceUtilizationPrediction.fromJson(Map<String, dynamic> json) =>
      _$ServiceUtilizationPredictionFromJson(json);
}

@freezed
class Alert with _$Alert {
  const factory Alert({
    required String severity,
    required String type,
    required String message,
    required String action,
  }) = _Alert;

  factory Alert.fromJson(Map<String, dynamic> json) =>
      _$AlertFromJson(json);
}

@freezed
class NextAction with _$NextAction {
  const factory NextAction({
    required String action,
    required String priority,
    required String deadline,
    required String assignedTo,
  }) = _NextAction;

  factory NextAction.fromJson(Map<String, dynamic> json) =>
      _$NextActionFromJson(json);
}

@freezed
class CarePatterns with _$CarePatterns {
  const factory CarePatterns({
    required ServiceUtilization serviceUtilization,
    required HealthTrends healthTrends,
    required BehaviorPatterns behaviorPatterns,
    required GoalProgress goalProgress,
    required FamilyEngagement familyEngagement,
  }) = _CarePatterns;

  factory CarePatterns.fromJson(Map<String, dynamic> json) =>
      _$CarePatternsFromJson(json);
}

@freezed
class ServiceUtilization with _$ServiceUtilization {
  const factory ServiceUtilization({
    required String trend,
    required int averageHoursPerWeek,
    required List<String> peakDays,
    required List<String> preferredTimes,
  }) = _ServiceUtilization;

  factory ServiceUtilization.fromJson(Map<String, dynamic> json) =>
      _$ServiceUtilizationFromJson(json);
}

@freezed
class HealthTrends with _$HealthTrends {
  const factory HealthTrends({
    required double vitalStability,
    required double medicationCompliance,
    required int incidentFrequency,
    required String overallTrend,
  }) = _HealthTrends;

  factory HealthTrends.fromJson(Map<String, dynamic> json) =>
      _$HealthTrendsFromJson(json);
}

@freezed
class BehaviorPatterns with _$BehaviorPatterns {
  const factory BehaviorPatterns({
    required int positiveInteractions,
    required int challengingBehaviors,
    required List<String> triggerPatterns,
    required double responseEffectiveness,
  }) = _BehaviorPatterns;

  factory BehaviorPatterns.fromJson(Map<String, dynamic> json) =>
      _$BehaviorPatternsFromJson(json);
}

@freezed
class GoalProgress with _$GoalProgress {
  const factory GoalProgress({
    required int onTrack,
    required int needsAttention,
    required int achieved,
    required double averageProgress,
  }) = _GoalProgress;

  factory GoalProgress.fromJson(Map<String, dynamic> json) =>
      _$GoalProgressFromJson(json);
}

@freezed
class FamilyEngagement with _$FamilyEngagement {
  const factory FamilyEngagement({
    required String communicationFrequency,
    required double satisfactionScore,
    required int concernsRaised,
    required double participationLevel,
  }) = _FamilyEngagement;

  factory FamilyEngagement.fromJson(Map<String, dynamic> json) =>
      _$FamilyEngagementFromJson(json);
}

// ============================================================================
// Risk Prediction Models
// ============================================================================

@freezed
class RiskAssessment with _$RiskAssessment {
  const factory RiskAssessment({
    required String clientId,
    required String organizationId,
    required String assessmentDate,
    required int overallRisk,
    required RiskCategory fallsRisk,
    required RiskCategory behaviorRisk,
    required RiskCategory healthRisk,
    required RiskCategory medicationRisk,
    required RiskCategory socialRisk,
    required RiskCategory financialRisk,
    required RiskTrends trends,
    required List<RiskRecommendation> recommendations,
    required String nextAssessment,
  }) = _RiskAssessment;

  factory RiskAssessment.fromJson(Map<String, dynamic> json) =>
      _$RiskAssessmentFromJson(json);
}

@freezed
class RiskCategory with _$RiskCategory {
  const factory RiskCategory({
    required int score,
    required String level,
    String? lastIncident,
    int? recentIncidents,
    int? conditions,
    int? medications,
    int? isolationIndicators,
    int? concerns,
  }) = _RiskCategory;

  factory RiskCategory.fromJson(Map<String, dynamic> json) =>
      _$RiskCategoryFromJson(json);
}

@freezed
class RiskTrends with _$RiskTrends {
  const factory RiskTrends({
    required String direction,
    required int changePercentage,
    required String period,
  }) = _RiskTrends;

  factory RiskTrends.fromJson(Map<String, dynamic> json) =>
      _$RiskTrendsFromJson(json);
}

@freezed
class RiskRecommendation with _$RiskRecommendation {
  const factory RiskRecommendation({
    required String priority,
    required String recommendation,
    required String timeline,
  }) = _RiskRecommendation;

  factory RiskRecommendation.fromJson(Map<String, dynamic> json) =>
      _$RiskRecommendationFromJson(json);
}

@freezed
class FallsRiskAssessment with _$FallsRiskAssessment {
  const factory FallsRiskAssessment({
    required int riskScore,
    required String riskLevel,
    required double confidence,
    required List<ContributingFactor> contributingFactors,
    required List<String> preventionStrategies,
    required MonitoringPlan monitoringPlan,
    required List<String> interventions,
  }) = _FallsRiskAssessment;

  factory FallsRiskAssessment.fromJson(Map<String, dynamic> json) =>
      _$FallsRiskAssessmentFromJson(json);
}

@freezed
class ContributingFactor with _$ContributingFactor {
  const factory ContributingFactor({
    required String factor,
    required double weight,
    required bool present,
  }) = _ContributingFactor;

  factory ContributingFactor.fromJson(Map<String, dynamic> json) =>
      _$ContributingFactorFromJson(json);
}

@freezed
class MonitoringPlan with _$MonitoringPlan {
  const factory MonitoringPlan({
    required String frequency,
    required List<String> indicators,
    required bool alerts,
  }) = _MonitoringPlan;

  factory MonitoringPlan.fromJson(Map<String, dynamic> json) =>
      _$MonitoringPlanFromJson(json);
}

@freezed
class BehaviorEscalationPrediction with _$BehaviorEscalationPrediction {
  const factory BehaviorEscalationPrediction({
    required double escalationProbability,
    required String timeframe,
    required double confidence,
    required List<Trigger> triggers,
    required List<String> earlyWarningSignals,
    required List<String> deEscalationStrategies,
    required List<String> preventiveMeasures,
  }) = _BehaviorEscalationPrediction;

  factory BehaviorEscalationPrediction.fromJson(Map<String, dynamic> json) =>
      _$BehaviorEscalationPredictionFromJson(json);
}

@freezed
class Trigger with _$Trigger {
  const factory Trigger({
    required String trigger,
    required double likelihood,
  }) = _Trigger;

  factory Trigger.fromJson(Map<String, dynamic> json) =>
      _$TriggerFromJson(json);
}

// ============================================================================
// Care Plan Models
// ============================================================================

@freezed
class CarePlan with _$CarePlan {
  const factory CarePlan({
    required String clientId,
    required String organizationId,
    required String planId,
    required String createdAt,
    required String status,
    required Assessment assessment,
    required List<SmartGoal> goals,
    required List<ServiceRecommendation> services,
    required Resources resources,
    required Timeline timeline,
    required List<Review> reviewSchedule,
    required List<SuccessMetric> successMetrics,
  }) = _CarePlan;

  factory CarePlan.fromJson(Map<String, dynamic> json) =>
      _$CarePlanFromJson(json);
}

@freezed
class Assessment with _$Assessment {
  const factory Assessment({
    required List<String> strengths,
    required List<String> needs,
    required List<String> preferences,
    required List<String> riskFactors,
  }) = _Assessment;

  factory Assessment.fromJson(Map<String, dynamic> json) =>
      _$AssessmentFromJson(json);
}

@freezed
class SmartGoal with _$SmartGoal {
  const factory SmartGoal({
    required String goalId,
    required String outcomeArea,
    required String goal,
    required String specific,
    required String measurable,
    required String achievable,
    required String relevant,
    required String timeBound,
    required String priority,
    required String status,
    required int progress,
    required List<Milestone> milestones,
  }) = _SmartGoal;

  factory SmartGoal.fromJson(Map<String, dynamic> json) =>
      _$SmartGoalFromJson(json);
}

@freezed
class Milestone with _$Milestone {
  const factory Milestone({
    required String milestone,
    required String target,
    required String date,
  }) = _Milestone;

  factory Milestone.fromJson(Map<String, dynamic> json) =>
      _$MilestoneFromJson(json);
}

@freezed
class ServiceRecommendation with _$ServiceRecommendation {
  const factory ServiceRecommendation({
    required String serviceType,
    required String frequency,
    required String duration,
    required String priority,
    required String rationale,
    required int estimatedCost,
    required List<Provider> providers,
  }) = _ServiceRecommendation;

  factory ServiceRecommendation.fromJson(Map<String, dynamic> json) =>
      _$ServiceRecommendationFromJson(json);
}

@freezed
class Provider with _$Provider {
  const factory Provider({
    required String name,
    required double rating,
    required String availability,
  }) = _Provider;

  factory Provider.fromJson(Map<String, dynamic> json) =>
      _$ProviderFromJson(json);
}

@freezed
class Resources with _$Resources {
  const factory Resources({
    required int workers,
    required List<String> equipment,
    required Budget budget,
  }) = _Resources;

  factory Resources.fromJson(Map<String, dynamic> json) =>
      _$ResourcesFromJson(json);
}

@freezed
class Budget with _$Budget {
  const factory Budget({
    required int weekly,
    required int monthly,
  }) = _Budget;

  factory Budget.fromJson(Map<String, dynamic> json) =>
      _$BudgetFromJson(json);
}

@freezed
class Timeline with _$Timeline {
  const factory Timeline({
    required String startDate,
    required String endDate,
    required List<Phase> phases,
  }) = _Timeline;

  factory Timeline.fromJson(Map<String, dynamic> json) =>
      _$TimelineFromJson(json);
}

@freezed
class Phase with _$Phase {
  const factory Phase({
    required String phase,
    required String duration,
    required String focus,
  }) = _Phase;

  factory Phase.fromJson(Map<String, dynamic> json) =>
      _$PhaseFromJson(json);
}

@freezed
class Review with _$Review {
  const factory Review({
    required String type,
    required String date,
  }) = _Review;

  factory Review.fromJson(Map<String, dynamic> json) =>
      _$ReviewFromJson(json);
}

@freezed
class SuccessMetric with _$SuccessMetric {
  const factory SuccessMetric({
    required String metric,
    required String target,
  }) = _SuccessMetric;

  factory SuccessMetric.fromJson(Map<String, dynamic> json) =>
      _$SuccessMetricFromJson(json);
}

// ============================================================================
// Incident Management Models
// ============================================================================

@freezed
class Incident with _$Incident {
  const factory Incident({
    required String incidentId,
    required String reportedAt,
    required String severity,
    required String category,
    required List<String> immediateActions,
    required NotificationRouting notifications,
    required Investigation investigation,
  }) = _Incident;

  factory Incident.fromJson(Map<String, dynamic> json) =>
      _$IncidentFromJson(json);
}

@freezed
class NotificationRouting with _$NotificationRouting {
  const factory NotificationRouting({
    required bool family,
    required bool supervisor,
    required bool careCoordinator,
    required bool regulator,
  }) = _NotificationRouting;

  factory NotificationRouting.fromJson(Map<String, dynamic> json) =>
      _$NotificationRoutingFromJson(json);
}

@freezed
class Investigation with _$Investigation {
  const factory Investigation({
    required String investigator,
    required String dueDate,
    required List<String> steps,
  }) = _Investigation;

  factory Investigation.fromJson(Map<String, dynamic> json) =>
      _$InvestigationFromJson(json);
}

@freezed
class RootCauseAnalysis with _$RootCauseAnalysis {
  const factory RootCauseAnalysis({
    required String incidentId,
    required String analyzedAt,
    required List<RootCause> rootCauses,
    required List<ContributingFactorAnalysis> contributingFactors,
    required List<String> systemicIssues,
    required List<SimilarIncident> similarIncidents,
    required List<String> recommendations,
  }) = _RootCauseAnalysis;

  factory RootCauseAnalysis.fromJson(Map<String, dynamic> json) =>
      _$RootCauseAnalysisFromJson(json);
}

@freezed
class RootCause with _$RootCause {
  const factory RootCause({
    required String cause,
    required String likelihood,
  }) = _RootCause;

  factory RootCause.fromJson(Map<String, dynamic> json) =>
      _$RootCauseFromJson(json);
}

@freezed
class ContributingFactorAnalysis with _$ContributingFactorAnalysis {
  const factory ContributingFactorAnalysis({
    required String factor,
    required String contribution,
  }) = _ContributingFactorAnalysis;

  factory ContributingFactorAnalysis.fromJson(Map<String, dynamic> json) =>
      _$ContributingFactorAnalysisFromJson(json);
}

@freezed
class SimilarIncident with _$SimilarIncident {
  const factory SimilarIncident({
    required String incidentId,
    required String date,
    required double similarity,
  }) = _SimilarIncident;

  factory SimilarIncident.fromJson(Map<String, dynamic> json) =>
      _$SimilarIncidentFromJson(json);
}

@freezed
class IncidentPatterns with _$IncidentPatterns {
  const factory IncidentPatterns({
    required String organizationId,
    required String timeframe,
    required String analyzedAt,
    required FrequencyPatterns frequencyPatterns,
    required List<RecurringIssue> recurringIssues,
    required Trends trends,
    required List<HighRiskArea> highRiskAreas,
    required List<String> preventiveActions,
  }) = _IncidentPatterns;

  factory IncidentPatterns.fromJson(Map<String, dynamic> json) =>
      _$IncidentPatternsFromJson(json);
}

@freezed
class FrequencyPatterns with _$FrequencyPatterns {
  const factory FrequencyPatterns({
    required Map<String, int> byType,
    required Map<String, int> byLocation,
    required Map<String, int> byTimeOfDay,
    required Map<String, int> byDayOfWeek,
  }) = _FrequencyPatterns;

  factory FrequencyPatterns.fromJson(Map<String, dynamic> json) =>
      _$FrequencyPatternsFromJson(json);
}

@freezed
class RecurringIssue with _$RecurringIssue {
  const factory RecurringIssue({
    required String issue,
    required int frequency,
    required String trend,
  }) = _RecurringIssue;

  factory RecurringIssue.fromJson(Map<String, dynamic> json) =>
      _$RecurringIssueFromJson(json);
}

@freezed
class Trends with _$Trends {
  const factory Trends({
    required String direction,
    required int changePercentage,
    required String significance,
  }) = _Trends;

  factory Trends.fromJson(Map<String, dynamic> json) =>
      _$TrendsFromJson(json);
}

@freezed
class HighRiskArea with _$HighRiskArea {
  const factory HighRiskArea({
    required String area,
    required String riskLevel,
  }) = _HighRiskArea;

  factory HighRiskArea.fromJson(Map<String, dynamic> json) =>
      _$HighRiskAreaFromJson(json);
}

// ============================================================================
// Medication Management Models
// ============================================================================

@freezed
class DrugInteraction with _$DrugInteraction {
  const factory DrugInteraction({
    required List<String> medications,
    required String severity,
    required String description,
    required String recommendation,
    required List<String> references,
  }) = _DrugInteraction;

  factory DrugInteraction.fromJson(Map<String, dynamic> json) =>
      _$DrugInteractionFromJson(json);
}

@freezed
class MedicationCompliance with _$MedicationCompliance {
  const factory MedicationCompliance({
    required String clientId,
    required String period,
    required String analyzedAt,
    required double overallCompliance,
    required List<MedicationComplianceDetail> byMedication,
    required CompliancePatterns patterns,
    required ComplianceRiskAssessment riskAssessment,
  }) = _MedicationCompliance;

  factory MedicationCompliance.fromJson(Map<String, dynamic> json) =>
      _$MedicationComplianceFromJson(json);
}

@freezed
class MedicationComplianceDetail with _$MedicationComplianceDetail {
  const factory MedicationComplianceDetail({
    required String medication,
    required int prescribed,
    required int administered,
    required int missed,
    required double compliance,
  }) = _MedicationComplianceDetail;

  factory MedicationComplianceDetail.fromJson(Map<String, dynamic> json) =>
      _$MedicationComplianceDetailFromJson(json);
}

@freezed
class CompliancePatterns with _$CompliancePatterns {
  const factory CompliancePatterns({
    required MissedDoses missedDoses,
  }) = _CompliancePatterns;

  factory CompliancePatterns.fromJson(Map<String, dynamic> json) =>
      _$CompliancePatternsFromJson(json);
}

@freezed
class MissedDoses with _$MissedDoses {
  const factory MissedDoses({
    required List<String> timeOfDay,
    required List<String> dayOfWeek,
    required List<String> reasons,
  }) = _MissedDoses;

  factory MissedDoses.fromJson(Map<String, dynamic> json) =>
      _$MissedDosesFromJson(json);
}

@freezed
class ComplianceRiskAssessment with _$ComplianceRiskAssessment {
  const factory ComplianceRiskAssessment({
    required double nonComplianceRisk,
    required List<String> factors,
    required List<String> recommendations,
  }) = _ComplianceRiskAssessment;

  factory ComplianceRiskAssessment.fromJson(Map<String, dynamic> json) =>
      _$ComplianceRiskAssessmentFromJson(json);
}

@freezed
class MedicationAlert with _$MedicationAlert {
  const factory MedicationAlert({
    required String type,
    required String severity,
    String? medication,
    List<String>? medications,
    required String message,
    required String action,
    String? dueDate,
    String? timestamp,
  }) = _MedicationAlert;

  factory MedicationAlert.fromJson(Map<String, dynamic> json) =>
      _$MedicationAlertFromJson(json);
}
