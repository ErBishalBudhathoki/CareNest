import 'package:freezed_annotation/freezed_annotation.dart';

part 'workforce_models.freezed.dart';
part 'workforce_models.g.dart';

// ============================================================================
// Workforce Planning Models
// ============================================================================

@freezed
abstract class DemandForecast with _$DemandForecast {
  const factory DemandForecast({
    required DateTime date,
    required int predicted,
    required int lower,
    required int upper,
  }) = _DemandForecast;

  factory DemandForecast.fromJson(Map<String, dynamic> json) =>
      _$DemandForecastFromJson(json);
}

@freezed
abstract class SeasonalPattern with _$SeasonalPattern {
  const factory SeasonalPattern({
    required int day,
    required double average,
    required double variance,
  }) = _SeasonalPattern;

  factory SeasonalPattern.fromJson(Map<String, dynamic> json) =>
      _$SeasonalPatternFromJson(json);
}

@freezed
abstract class ForecastConfidence with _$ForecastConfidence {
  const factory ForecastConfidence({
    required double mae,
    required double rmse,
    required double accuracy,
  }) = _ForecastConfidence;

  factory ForecastConfidence.fromJson(Map<String, dynamic> json) =>
      _$ForecastConfidenceFromJson(json);
}

@freezed
abstract class WorkforcePlan with _$WorkforcePlan {
  const factory WorkforcePlan({
    required int currentCapacity,
    required int requiredCapacity,
    required int surplus,
    required double utilizationRate,
    required String recommendation,
  }) = _WorkforcePlan;

  factory WorkforcePlan.fromJson(Map<String, dynamic> json) =>
      _$WorkforcePlanFromJson(json);
}

@freezed
abstract class SkillGap with _$SkillGap {
  const factory SkillGap({
    required String skill,
    required int current,
    required int required,
    required int gap,
  }) = _SkillGap;

  factory SkillGap.fromJson(Map<String, dynamic> json) =>
      _$SkillGapFromJson(json);
}

@freezed
abstract class TurnoverPrediction with _$TurnoverPrediction {
  const factory TurnoverPrediction({
    required String employeeId,
    required double riskScore,
    required String riskLevel,
    required List<String> factors,
    required List<String> recommendations,
  }) = _TurnoverPrediction;

  factory TurnoverPrediction.fromJson(Map<String, dynamic> json) =>
      _$TurnoverPredictionFromJson(json);
}

@freezed
abstract class ScenarioAnalysis with _$ScenarioAnalysis {
  const factory ScenarioAnalysis({
    required String name,
    required double projectedRevenue,
    required double projectedCost,
    required double netBenefit,
    required String feasibility,
    required double roi,
  }) = _ScenarioAnalysis;

  factory ScenarioAnalysis.fromJson(Map<String, dynamic> json) =>
      _$ScenarioAnalysisFromJson(json);
}

// ============================================================================
// Resource Allocation Models
// ============================================================================

@freezed
abstract class ResourceAllocation with _$ResourceAllocation {
  const factory ResourceAllocation({
    required String appointmentId,
    required String workerId,
    required double score,
    required double cost,
  }) = _ResourceAllocation;

  factory ResourceAllocation.fromJson(Map<String, dynamic> json) =>
      _$ResourceAllocationFromJson(json);
}

@freezed
abstract class AllocationMetrics with _$AllocationMetrics {
  const factory AllocationMetrics({
    required int totalAllocations,
    required double averageScore,
    required double totalCost,
    required double utilizationRate,
    required int unassignedCount,
    required int conflictCount,
  }) = _AllocationMetrics;

  factory AllocationMetrics.fromJson(Map<String, dynamic> json) =>
      _$AllocationMetricsFromJson(json);
}

@freezed
abstract class WorkerRecommendation with _$WorkerRecommendation {
  const factory WorkerRecommendation({
    required String workerId,
    required String workerName,
    required double score,
    required Map<String, dynamic> factors,
    required bool availability,
  }) = _WorkerRecommendation;

  factory WorkerRecommendation.fromJson(Map<String, dynamic> json) =>
      _$WorkerRecommendationFromJson(json);
}

@freezed
abstract class WorkloadAnalysis with _$WorkloadAnalysis {
  const factory WorkloadAnalysis({
    required String workerId,
    required String workerName,
    required int appointments,
    required double hours,
    required double utilization,
  }) = _WorkloadAnalysis;

  factory WorkloadAnalysis.fromJson(Map<String, dynamic> json) =>
      _$WorkloadAnalysisFromJson(json);
}

// ============================================================================
// Performance Analytics Models
// ============================================================================

@freezed
abstract class PerformanceMetrics with _$PerformanceMetrics {
  const factory PerformanceMetrics({
    required int totalAppointments,
    required double avgRating,
    required double completionRate,
    required double revenue,
    required double revenuePerAppointment,
    required double punctualityScore,
    required double qualityScore,
  }) = _PerformanceMetrics;

  factory PerformanceMetrics.fromJson(Map<String, dynamic> json) =>
      _$PerformanceMetricsFromJson(json);
}

@freezed
abstract class PerformanceAnalytics with _$PerformanceAnalytics {
  const factory PerformanceAnalytics({
    required String employeeId,
    required String employeeName,
    required PerformanceMetrics metrics,
    required PerformanceTrend trends,
    required PeerComparison comparison,
    required double score,
  }) = _PerformanceAnalytics;

  factory PerformanceAnalytics.fromJson(Map<String, dynamic> json) =>
      _$PerformanceAnalyticsFromJson(json);
}

@freezed
abstract class PerformanceTrend with _$PerformanceTrend {
  const factory PerformanceTrend({
    required String direction,
    required double growth,
    required double volatility,
  }) = _PerformanceTrend;

  factory PerformanceTrend.fromJson(Map<String, dynamic> json) =>
      _$PerformanceTrendFromJson(json);
}

@freezed
abstract class PeerComparison with _$PeerComparison {
  const factory PeerComparison({
    required double avgPeerScore,
    required double percentile,
    required String ranking,
  }) = _PeerComparison;

  factory PeerComparison.fromJson(Map<String, dynamic> json) =>
      _$PeerComparisonFromJson(json);
}

@freezed
abstract class SkillProficiency with _$SkillProficiency {
  const factory SkillProficiency({
    required String skill,
    required String level,
    required List<String> certifications,
    required DateTime lastAssessed,
    required double growthRate,
    required String recommendation,
  }) = _SkillProficiency;

  factory SkillProficiency.fromJson(Map<String, dynamic> json) =>
      _$SkillProficiencyFromJson(json);
}

// ============================================================================
// Quality Assurance Models
// ============================================================================

@freezed
abstract class QualityScore with _$QualityScore {
  const factory QualityScore({
    required String appointmentId,
    required double overallScore,
    required QualityFactors factors,
    required String grade,
    required List<QualityIssue> issues,
    required List<String> recommendations,
    required DateTime assessedAt,
  }) = _QualityScore;

  factory QualityScore.fromJson(Map<String, dynamic> json) =>
      _$QualityScoreFromJson(json);
}

@freezed
abstract class QualityFactors with _$QualityFactors {
  const factory QualityFactors({
    required double punctuality,
    required double completion,
    required double clientSatisfaction,
    required double documentation,
    required double compliance,
  }) = _QualityFactors;

  factory QualityFactors.fromJson(Map<String, dynamic> json) =>
      _$QualityFactorsFromJson(json);
}

@freezed
abstract class QualityIssue with _$QualityIssue {
  const factory QualityIssue({
    required String type,
    required String severity,
    required String message,
  }) = _QualityIssue;

  factory QualityIssue.fromJson(Map<String, dynamic> json) =>
      _$QualityIssueFromJson(json);
}

@freezed
abstract class ComplianceCheck with _$ComplianceCheck {
  const factory ComplianceCheck({
    required String appointmentId,
    required Map<String, ComplianceResult> checks,
    required bool compliant,
    required List<ComplianceViolation> violations,
    required String riskLevel,
  }) = _ComplianceCheck;

  factory ComplianceCheck.fromJson(Map<String, dynamic> json) =>
      _$ComplianceCheckFromJson(json);
}

@freezed
abstract class ComplianceResult with _$ComplianceResult {
  const factory ComplianceResult({required bool passed, String? reason}) =
      _ComplianceResult;

  factory ComplianceResult.fromJson(Map<String, dynamic> json) =>
      _$ComplianceResultFromJson(json);
}

@freezed
abstract class ComplianceViolation with _$ComplianceViolation {
  const factory ComplianceViolation({
    required String check,
    required String reason,
  }) = _ComplianceViolation;

  factory ComplianceViolation.fromJson(Map<String, dynamic> json) =>
      _$ComplianceViolationFromJson(json);
}

@freezed
abstract class SentimentAnalysis with _$SentimentAnalysis {
  const factory SentimentAnalysis({
    required String appointmentId,
    required String feedback,
    required String sentiment,
    required double score,
    required double confidence,
    required List<String> keywords,
    required List<String> topics,
    required double rating,
  }) = _SentimentAnalysis;

  factory SentimentAnalysis.fromJson(Map<String, dynamic> json) =>
      _$SentimentAnalysisFromJson(json);
}

@freezed
abstract class RiskAssessment with _$RiskAssessment {
  const factory RiskAssessment({
    required String appointmentId,
    required double riskScore,
    required String riskLevel,
    required RiskFactors factors,
    required List<String> mitigations,
    required bool requiresApproval,
  }) = _RiskAssessment;

  factory RiskAssessment.fromJson(Map<String, dynamic> json) =>
      _$RiskAssessmentFromJson(json);
}

@freezed
abstract class RiskFactors with _$RiskFactors {
  const factory RiskFactors({
    required double workerExperience,
    required double clientComplexity,
    required double serviceType,
    required double location,
    required double timeOfDay,
  }) = _RiskFactors;

  factory RiskFactors.fromJson(Map<String, dynamic> json) =>
      _$RiskFactorsFromJson(json);
}

@freezed
abstract class IncidentPattern with _$IncidentPattern {
  const factory IncidentPattern({
    required int totalIncidents,
    required Map<String, dynamic> patterns,
    required List<RecurringIssue> recurringIssues,
    required List<PreventiveAction> preventiveActions,
  }) = _IncidentPattern;

  factory IncidentPattern.fromJson(Map<String, dynamic> json) =>
      _$IncidentPatternFromJson(json);
}

@freezed
abstract class RecurringIssue with _$RecurringIssue {
  const factory RecurringIssue({
    required String type,
    required String description,
    required String severity,
  }) = _RecurringIssue;

  factory RecurringIssue.fromJson(Map<String, dynamic> json) =>
      _$RecurringIssueFromJson(json);
}

@freezed
abstract class PreventiveAction with _$PreventiveAction {
  const factory PreventiveAction({
    required String action,
    required String priority,
    required String expectedImpact,
  }) = _PreventiveAction;

  factory PreventiveAction.fromJson(Map<String, dynamic> json) =>
      _$PreventiveActionFromJson(json);
}

// ============================================================================
// Business Intelligence Models
// ============================================================================

@freezed
abstract class ExecutiveDashboard with _$ExecutiveDashboard {
  const factory ExecutiveDashboard({
    required DashboardKPIs kpis,
    required RevenueMetrics revenue,
    required OperationalMetrics operations,
    required ClientMetrics clients,
    required WorkforceMetrics workforce,
    required Map<String, TrendData> trends,
    required String period,
    required DateTime generatedAt,
  }) = _ExecutiveDashboard;

  factory ExecutiveDashboard.fromJson(Map<String, dynamic> json) =>
      _$ExecutiveDashboardFromJson(json);
}

@freezed
abstract class DashboardKPIs with _$DashboardKPIs {
  const factory DashboardKPIs({
    required double totalRevenue,
    required int totalAppointments,
    required int completedAppointments,
    required double completionRate,
    required double avgRevenuePerAppointment,
    required double growth,
  }) = _DashboardKPIs;

  factory DashboardKPIs.fromJson(Map<String, dynamic> json) =>
      _$DashboardKPIsFromJson(json);
}

@freezed
abstract class RevenueMetrics with _$RevenueMetrics {
  const factory RevenueMetrics({
    required double total,
    required int count,
    required double avg,
  }) = _RevenueMetrics;

  factory RevenueMetrics.fromJson(Map<String, dynamic> json) =>
      _$RevenueMetricsFromJson(json);
}

@freezed
abstract class OperationalMetrics with _$OperationalMetrics {
  const factory OperationalMetrics({
    required double utilization,
    required double efficiency,
    required double onTimeRate,
    required double cancellationRate,
  }) = _OperationalMetrics;

  factory OperationalMetrics.fromJson(Map<String, dynamic> json) =>
      _$OperationalMetricsFromJson(json);
}

@freezed
abstract class ClientMetrics with _$ClientMetrics {
  const factory ClientMetrics({
    required int total,
    required int active,
    required double retention,
    required double satisfaction,
    required int nps,
  }) = _ClientMetrics;

  factory ClientMetrics.fromJson(Map<String, dynamic> json) =>
      _$ClientMetricsFromJson(json);
}

@freezed
abstract class WorkforceMetrics with _$WorkforceMetrics {
  const factory WorkforceMetrics({
    required int total,
    required double utilization,
    required double productivity,
    required double satisfaction,
    required double turnover,
  }) = _WorkforceMetrics;

  factory WorkforceMetrics.fromJson(Map<String, dynamic> json) =>
      _$WorkforceMetricsFromJson(json);
}

@freezed
abstract class TrendData with _$TrendData {
  const factory TrendData({required String direction, required double change}) =
      _TrendData;

  factory TrendData.fromJson(Map<String, dynamic> json) =>
      _$TrendDataFromJson(json);
}

@freezed
abstract class RevenueForecast with _$RevenueForecast {
  const factory RevenueForecast({
    required int period,
    required double predicted,
    required double lower,
    required double upper,
  }) = _RevenueForecast;

  factory RevenueForecast.fromJson(Map<String, dynamic> json) =>
      _$RevenueForecastFromJson(json);
}

@freezed
abstract class ChurnPrediction with _$ChurnPrediction {
  const factory ChurnPrediction({
    required String clientId,
    required String clientName,
    required double churnScore,
    required String churnRisk,
    required ChurnFactors factors,
    required List<ChurnIntervention> interventions,
    required double lifetimeValue,
  }) = _ChurnPrediction;

  factory ChurnPrediction.fromJson(Map<String, dynamic> json) =>
      _$ChurnPredictionFromJson(json);
}

@freezed
abstract class ChurnFactors with _$ChurnFactors {
  const factory ChurnFactors({
    required double recency,
    required double frequency,
    required double monetary,
    required double satisfaction,
    required double engagement,
  }) = _ChurnFactors;

  factory ChurnFactors.fromJson(Map<String, dynamic> json) =>
      _$ChurnFactorsFromJson(json);
}

@freezed
abstract class ChurnIntervention with _$ChurnIntervention {
  const factory ChurnIntervention({
    required String action,
    required String priority,
    required String expectedImpact,
  }) = _ChurnIntervention;

  factory ChurnIntervention.fromJson(Map<String, dynamic> json) =>
      _$ChurnInterventionFromJson(json);
}

@freezed
abstract class ProfitabilityAnalysis with _$ProfitabilityAnalysis {
  const factory ProfitabilityAnalysis({
    required String dimension,
    required double revenue,
    required double cost,
    required double profit,
    required double margin,
    required int count,
  }) = _ProfitabilityAnalysis;

  factory ProfitabilityAnalysis.fromJson(Map<String, dynamic> json) =>
      _$ProfitabilityAnalysisFromJson(json);
}

@freezed
abstract class WhatIfScenario with _$WhatIfScenario {
  const factory WhatIfScenario({
    required String name,
    required ScenarioMetrics baseline,
    required ScenarioMetrics projected,
    required ScenarioImpact impact,
    required ScenarioFeasibility feasibility,
    required ScenarioRecommendation recommendation,
  }) = _WhatIfScenario;

  factory WhatIfScenario.fromJson(Map<String, dynamic> json) =>
      _$WhatIfScenarioFromJson(json);
}

@freezed
abstract class ScenarioMetrics with _$ScenarioMetrics {
  const factory ScenarioMetrics({
    required int appointments,
    required int workers,
    required double revenue,
    required double avgRevenuePerWorker,
  }) = _ScenarioMetrics;

  factory ScenarioMetrics.fromJson(Map<String, dynamic> json) =>
      _$ScenarioMetricsFromJson(json);
}

@freezed
abstract class ScenarioImpact with _$ScenarioImpact {
  const factory ScenarioImpact({
    required double revenueChange,
    required String revenueChangePercent,
    required int appointmentChange,
    required int workerChange,
    required double productivityChange,
  }) = _ScenarioImpact;

  factory ScenarioImpact.fromJson(Map<String, dynamic> json) =>
      _$ScenarioImpactFromJson(json);
}

@freezed
abstract class ScenarioFeasibility with _$ScenarioFeasibility {
  const factory ScenarioFeasibility({
    required Map<String, double> scores,
    required double overall,
    required String rating,
  }) = _ScenarioFeasibility;

  factory ScenarioFeasibility.fromJson(Map<String, dynamic> json) =>
      _$ScenarioFeasibilityFromJson(json);
}

@freezed
abstract class ScenarioRecommendation with _$ScenarioRecommendation {
  const factory ScenarioRecommendation({
    required String decision,
    required String confidence,
    required String reasoning,
  }) = _ScenarioRecommendation;

  factory ScenarioRecommendation.fromJson(Map<String, dynamic> json) =>
      _$ScenarioRecommendationFromJson(json);
}

@freezed
abstract class CustomerLifetimeValue with _$CustomerLifetimeValue {
  const factory CustomerLifetimeValue({
    required String clientId,
    required String clientName,
    required double clv,
    required String segment,
    required CLVMetrics metrics,
    required List<String> recommendations,
  }) = _CustomerLifetimeValue;

  factory CustomerLifetimeValue.fromJson(Map<String, dynamic> json) =>
      _$CustomerLifetimeValueFromJson(json);
}

@freezed
abstract class CLVMetrics with _$CLVMetrics {
  const factory CLVMetrics({
    required double totalRevenue,
    required int appointmentCount,
    required double avgOrderValue,
    required double frequency,
    required double tenure,
    required double churnProbability,
  }) = _CLVMetrics;

  factory CLVMetrics.fromJson(Map<String, dynamic> json) =>
      _$CLVMetricsFromJson(json);
}

// ============================================================================
// ML Model Models
// ============================================================================

@freezed
abstract class MLModel with _$MLModel {
  const factory MLModel({
    required String id,
    required String name,
    required String type,
    required String version,
    required String status,
    required DateTime trainedAt,
    required MLMetrics metrics,
    required List<String> features,
    required Map<String, dynamic> hyperparameters,
  }) = _MLModel;

  factory MLModel.fromJson(Map<String, dynamic> json) =>
      _$MLModelFromJson(json);
}

@freezed
abstract class MLMetrics with _$MLMetrics {
  const factory MLMetrics({
    required double accuracy,
    required double precision,
    required double recall,
    required double f1Score,
  }) = _MLMetrics;

  factory MLMetrics.fromJson(Map<String, dynamic> json) =>
      _$MLMetricsFromJson(json);
}

@freezed
abstract class MLPrediction with _$MLPrediction {
  const factory MLPrediction({
    required String modelId,
    required PredictionResult prediction,
    required double confidence,
    required Map<String, dynamic> features,
    required DateTime timestamp,
  }) = _MLPrediction;

  factory MLPrediction.fromJson(Map<String, dynamic> json) =>
      _$MLPredictionFromJson(json);
}

@freezed
abstract class PredictionResult with _$PredictionResult {
  const factory PredictionResult({
    required String predictedClass,
    required double score,
    required Map<String, double> probabilities,
  }) = _PredictionResult;

  factory PredictionResult.fromJson(Map<String, dynamic> json) =>
      _$PredictionResultFromJson(json);
}
