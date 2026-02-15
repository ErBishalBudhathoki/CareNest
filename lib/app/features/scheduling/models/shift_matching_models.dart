import 'package:freezed_annotation/freezed_annotation.dart';

part 'shift_matching_models.freezed.dart';
part 'shift_matching_models.g.dart';

// ============================================================================
// Worker Match Models
// ============================================================================

@freezed
class WorkerMatch with _$WorkerMatch {
  const factory WorkerMatch({
    required String workerId,
    required String workerName,
    required String workerEmail,
    required double matchScore,
    required String matchLevel,
    required List<MatchFactor> factors,
    required List<String> conflicts,
    double? distance,
    double? travelTime,
    double? noShowProbability,
    Map<String, dynamic>? workerProfile,
  }) = _WorkerMatch;

  factory WorkerMatch.fromJson(Map<String, dynamic> json) =>
      _$WorkerMatchFromJson(json);
}

@freezed
class MatchFactor with _$MatchFactor {
  const factory MatchFactor({
    required String factor,
    required double score,
    required double weight,
    required String description,
  }) = _MatchFactor;

  factory MatchFactor.fromJson(Map<String, dynamic> json) =>
      _$MatchFactorFromJson(json);
}

enum MatchLevel {
  excellent,
  good,
  fair,
  poor,
}

// ============================================================================
// Shift Recommendation Models
// ============================================================================

@freezed
class ShiftRecommendation with _$ShiftRecommendation {
  const factory ShiftRecommendation({
    required String shiftId,
    required DateTime shiftDate,
    required String shiftTime,
    required String service,
    required String clientName,
    required List<WorkerMatch> recommendedWorkers,
    String? currentAssignment,
    bool? isUrgent,
  }) = _ShiftRecommendation;

  factory ShiftRecommendation.fromJson(Map<String, dynamic> json) =>
      _$ShiftRecommendationFromJson(json);
}

// ============================================================================
// Auto-Fill Models
// ============================================================================

@freezed
class AutoFillRequest with _$AutoFillRequest {
  const factory AutoFillRequest({
    required String organizationId,
    required List<String> shiftIds,
    required MatchingCriteria criteria,
    bool? allowConflicts,
    bool? optimizeRoute,
  }) = _AutoFillRequest;

  factory AutoFillRequest.fromJson(Map<String, dynamic> json) =>
      _$AutoFillRequestFromJson(json);
}

@freezed
class AutoFillResult with _$AutoFillResult {
  const factory AutoFillResult({
    required int totalShifts,
    required int filledShifts,
    required int unfilledShifts,
    required List<ShiftAssignment> assignments,
    required List<String> unfilledShiftIds,
    String? optimizationSummary,
  }) = _AutoFillResult;

  factory AutoFillResult.fromJson(Map<String, dynamic> json) =>
      _$AutoFillResultFromJson(json);
}

@freezed
class ShiftAssignment with _$ShiftAssignment {
  const factory ShiftAssignment({
    required String shiftId,
    required String workerId,
    required String workerName,
    required double matchScore,
    required String reason,
    List<String>? warnings,
  }) = _ShiftAssignment;

  factory ShiftAssignment.fromJson(Map<String, dynamic> json) =>
      _$ShiftAssignmentFromJson(json);
}

// ============================================================================
// Matching Criteria Models
// ============================================================================

@freezed
class MatchingCriteria with _$MatchingCriteria {
  const factory MatchingCriteria({
    @Default(true) bool requireSkillMatch,
    @Default(true) bool checkAvailability,
    @Default(true) bool considerDistance,
    @Default(true) bool checkPreferences,
    @Default(false) bool allowOvertime,
    @Default(30.0) double maxDistance,
    @Default(0.6) double minMatchScore,
    List<String>? priorityFactors,
  }) = _MatchingCriteria;

  factory MatchingCriteria.fromJson(Map<String, dynamic> json) =>
      _$MatchingCriteriaFromJson(json);
}

// ============================================================================
// Route Optimization Models
// ============================================================================

@freezed
class RouteOptimization with _$RouteOptimization {
  const factory RouteOptimization({
    required String workerId,
    required String workerName,
    required List<OptimizedShift> shifts,
    required double totalDistance,
    required double totalTravelTime,
    required double efficiencyScore,
    String? recommendations,
  }) = _RouteOptimization;

  factory RouteOptimization.fromJson(Map<String, dynamic> json) =>
      _$RouteOptimizationFromJson(json);
}

@freezed
class OptimizedShift with _$OptimizedShift {
  const factory OptimizedShift({
    required String shiftId,
    required DateTime startTime,
    required DateTime endTime,
    required String location,
    required double latitude,
    required double longitude,
    double? distanceFromPrevious,
    double? travelTimeFromPrevious,
    int? sequenceOrder,
  }) = _OptimizedShift;

  factory OptimizedShift.fromJson(Map<String, dynamic> json) =>
      _$OptimizedShiftFromJson(json);
}

// ============================================================================
// Schedule Optimization Models
// ============================================================================

@freezed
class ScheduleOptimization with _$ScheduleOptimization {
  const factory ScheduleOptimization({
    required String organizationId,
    required DateTime date,
    required int totalShifts,
    required int assignedShifts,
    required double overallEfficiency,
    required List<RouteOptimization> workerRoutes,
    required List<String> warnings,
    String? summary,
  }) = _ScheduleOptimization;

  factory ScheduleOptimization.fromJson(Map<String, dynamic> json) =>
      _$ScheduleOptimizationFromJson(json);
}

// ============================================================================
// No-Show Prediction Models
// ============================================================================

@freezed
class NoShowPrediction with _$NoShowPrediction {
  const factory NoShowPrediction({
    required String workerId,
    required String shiftId,
    required double probability,
    required String riskLevel,
    required List<String> riskFactors,
    String? recommendation,
  }) = _NoShowPrediction;

  factory NoShowPrediction.fromJson(Map<String, dynamic> json) =>
      _$NoShowPredictionFromJson(json);
}
