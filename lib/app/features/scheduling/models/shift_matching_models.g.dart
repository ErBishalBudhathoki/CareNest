// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_matching_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkerMatch _$WorkerMatchFromJson(Map<String, dynamic> json) => _WorkerMatch(
      workerId: json['workerId'] as String,
      workerName: json['workerName'] as String,
      workerEmail: json['workerEmail'] as String,
      matchScore: (json['matchScore'] as num).toDouble(),
      matchLevel: json['matchLevel'] as String,
      factors: (json['factors'] as List<dynamic>)
          .map((e) => MatchFactor.fromJson(e as Map<String, dynamic>))
          .toList(),
      conflicts:
          (json['conflicts'] as List<dynamic>).map((e) => e as String).toList(),
      distance: (json['distance'] as num?)?.toDouble(),
      travelTime: (json['travelTime'] as num?)?.toDouble(),
      noShowProbability: (json['noShowProbability'] as num?)?.toDouble(),
      workerProfile: json['workerProfile'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$WorkerMatchToJson(_WorkerMatch instance) =>
    <String, dynamic>{
      'workerId': instance.workerId,
      'workerName': instance.workerName,
      'workerEmail': instance.workerEmail,
      'matchScore': instance.matchScore,
      'matchLevel': instance.matchLevel,
      'factors': instance.factors,
      'conflicts': instance.conflicts,
      'distance': instance.distance,
      'travelTime': instance.travelTime,
      'noShowProbability': instance.noShowProbability,
      'workerProfile': instance.workerProfile,
    };

_MatchFactor _$MatchFactorFromJson(Map<String, dynamic> json) => _MatchFactor(
      factor: json['factor'] as String,
      score: (json['score'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      description: json['description'] as String,
    );

Map<String, dynamic> _$MatchFactorToJson(_MatchFactor instance) =>
    <String, dynamic>{
      'factor': instance.factor,
      'score': instance.score,
      'weight': instance.weight,
      'description': instance.description,
    };

_ShiftRecommendation _$ShiftRecommendationFromJson(Map<String, dynamic> json) =>
    _ShiftRecommendation(
      shiftId: json['shiftId'] as String,
      shiftDate: DateTime.parse(json['shiftDate'] as String),
      shiftTime: json['shiftTime'] as String,
      service: json['service'] as String,
      clientName: json['clientName'] as String,
      recommendedWorkers: (json['recommendedWorkers'] as List<dynamic>)
          .map((e) => WorkerMatch.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentAssignment: json['currentAssignment'] as String?,
      isUrgent: json['isUrgent'] as bool?,
    );

Map<String, dynamic> _$ShiftRecommendationToJson(
        _ShiftRecommendation instance) =>
    <String, dynamic>{
      'shiftId': instance.shiftId,
      'shiftDate': instance.shiftDate.toIso8601String(),
      'shiftTime': instance.shiftTime,
      'service': instance.service,
      'clientName': instance.clientName,
      'recommendedWorkers': instance.recommendedWorkers,
      'currentAssignment': instance.currentAssignment,
      'isUrgent': instance.isUrgent,
    };

_AutoFillRequest _$AutoFillRequestFromJson(Map<String, dynamic> json) =>
    _AutoFillRequest(
      organizationId: json['organizationId'] as String,
      shiftIds:
          (json['shiftIds'] as List<dynamic>).map((e) => e as String).toList(),
      criteria:
          MatchingCriteria.fromJson(json['criteria'] as Map<String, dynamic>),
      allowConflicts: json['allowConflicts'] as bool?,
      optimizeRoute: json['optimizeRoute'] as bool?,
    );

Map<String, dynamic> _$AutoFillRequestToJson(_AutoFillRequest instance) =>
    <String, dynamic>{
      'organizationId': instance.organizationId,
      'shiftIds': instance.shiftIds,
      'criteria': instance.criteria,
      'allowConflicts': instance.allowConflicts,
      'optimizeRoute': instance.optimizeRoute,
    };

_AutoFillResult _$AutoFillResultFromJson(Map<String, dynamic> json) =>
    _AutoFillResult(
      totalShifts: (json['totalShifts'] as num).toInt(),
      filledShifts: (json['filledShifts'] as num).toInt(),
      unfilledShifts: (json['unfilledShifts'] as num).toInt(),
      assignments: (json['assignments'] as List<dynamic>)
          .map((e) => ShiftAssignment.fromJson(e as Map<String, dynamic>))
          .toList(),
      unfilledShiftIds: (json['unfilledShiftIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      optimizationSummary: json['optimizationSummary'] as String?,
    );

Map<String, dynamic> _$AutoFillResultToJson(_AutoFillResult instance) =>
    <String, dynamic>{
      'totalShifts': instance.totalShifts,
      'filledShifts': instance.filledShifts,
      'unfilledShifts': instance.unfilledShifts,
      'assignments': instance.assignments,
      'unfilledShiftIds': instance.unfilledShiftIds,
      'optimizationSummary': instance.optimizationSummary,
    };

_ShiftAssignment _$ShiftAssignmentFromJson(Map<String, dynamic> json) =>
    _ShiftAssignment(
      shiftId: json['shiftId'] as String,
      workerId: json['workerId'] as String,
      workerName: json['workerName'] as String,
      matchScore: (json['matchScore'] as num).toDouble(),
      reason: json['reason'] as String,
      warnings: (json['warnings'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ShiftAssignmentToJson(_ShiftAssignment instance) =>
    <String, dynamic>{
      'shiftId': instance.shiftId,
      'workerId': instance.workerId,
      'workerName': instance.workerName,
      'matchScore': instance.matchScore,
      'reason': instance.reason,
      'warnings': instance.warnings,
    };

_MatchingCriteria _$MatchingCriteriaFromJson(Map<String, dynamic> json) =>
    _MatchingCriteria(
      requireSkillMatch: json['requireSkillMatch'] as bool? ?? true,
      checkAvailability: json['checkAvailability'] as bool? ?? true,
      considerDistance: json['considerDistance'] as bool? ?? true,
      checkPreferences: json['checkPreferences'] as bool? ?? true,
      allowOvertime: json['allowOvertime'] as bool? ?? false,
      maxDistance: (json['maxDistance'] as num?)?.toDouble() ?? 30.0,
      minMatchScore: (json['minMatchScore'] as num?)?.toDouble() ?? 0.6,
      priorityFactors: (json['priorityFactors'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$MatchingCriteriaToJson(_MatchingCriteria instance) =>
    <String, dynamic>{
      'requireSkillMatch': instance.requireSkillMatch,
      'checkAvailability': instance.checkAvailability,
      'considerDistance': instance.considerDistance,
      'checkPreferences': instance.checkPreferences,
      'allowOvertime': instance.allowOvertime,
      'maxDistance': instance.maxDistance,
      'minMatchScore': instance.minMatchScore,
      'priorityFactors': instance.priorityFactors,
    };

_RouteOptimization _$RouteOptimizationFromJson(Map<String, dynamic> json) =>
    _RouteOptimization(
      workerId: json['workerId'] as String,
      workerName: json['workerName'] as String,
      shifts: (json['shifts'] as List<dynamic>)
          .map((e) => OptimizedShift.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalDistance: (json['totalDistance'] as num).toDouble(),
      totalTravelTime: (json['totalTravelTime'] as num).toDouble(),
      efficiencyScore: (json['efficiencyScore'] as num).toDouble(),
      recommendations: json['recommendations'] as String?,
    );

Map<String, dynamic> _$RouteOptimizationToJson(_RouteOptimization instance) =>
    <String, dynamic>{
      'workerId': instance.workerId,
      'workerName': instance.workerName,
      'shifts': instance.shifts,
      'totalDistance': instance.totalDistance,
      'totalTravelTime': instance.totalTravelTime,
      'efficiencyScore': instance.efficiencyScore,
      'recommendations': instance.recommendations,
    };

_OptimizedShift _$OptimizedShiftFromJson(Map<String, dynamic> json) =>
    _OptimizedShift(
      shiftId: json['shiftId'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      location: json['location'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      distanceFromPrevious: (json['distanceFromPrevious'] as num?)?.toDouble(),
      travelTimeFromPrevious:
          (json['travelTimeFromPrevious'] as num?)?.toDouble(),
      sequenceOrder: (json['sequenceOrder'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OptimizedShiftToJson(_OptimizedShift instance) =>
    <String, dynamic>{
      'shiftId': instance.shiftId,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'location': instance.location,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'distanceFromPrevious': instance.distanceFromPrevious,
      'travelTimeFromPrevious': instance.travelTimeFromPrevious,
      'sequenceOrder': instance.sequenceOrder,
    };

_ScheduleOptimization _$ScheduleOptimizationFromJson(
        Map<String, dynamic> json) =>
    _ScheduleOptimization(
      organizationId: json['organizationId'] as String,
      date: DateTime.parse(json['date'] as String),
      totalShifts: (json['totalShifts'] as num).toInt(),
      assignedShifts: (json['assignedShifts'] as num).toInt(),
      overallEfficiency: (json['overallEfficiency'] as num).toDouble(),
      workerRoutes: (json['workerRoutes'] as List<dynamic>)
          .map((e) => RouteOptimization.fromJson(e as Map<String, dynamic>))
          .toList(),
      warnings:
          (json['warnings'] as List<dynamic>).map((e) => e as String).toList(),
      summary: json['summary'] as String?,
    );

Map<String, dynamic> _$ScheduleOptimizationToJson(
        _ScheduleOptimization instance) =>
    <String, dynamic>{
      'organizationId': instance.organizationId,
      'date': instance.date.toIso8601String(),
      'totalShifts': instance.totalShifts,
      'assignedShifts': instance.assignedShifts,
      'overallEfficiency': instance.overallEfficiency,
      'workerRoutes': instance.workerRoutes,
      'warnings': instance.warnings,
      'summary': instance.summary,
    };

_NoShowPrediction _$NoShowPredictionFromJson(Map<String, dynamic> json) =>
    _NoShowPrediction(
      workerId: json['workerId'] as String,
      shiftId: json['shiftId'] as String,
      probability: (json['probability'] as num).toDouble(),
      riskLevel: json['riskLevel'] as String,
      riskFactors: (json['riskFactors'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      recommendation: json['recommendation'] as String?,
    );

Map<String, dynamic> _$NoShowPredictionToJson(_NoShowPrediction instance) =>
    <String, dynamic>{
      'workerId': instance.workerId,
      'shiftId': instance.shiftId,
      'probability': instance.probability,
      'riskLevel': instance.riskLevel,
      'riskFactors': instance.riskFactors,
      'recommendation': instance.recommendation,
    };
