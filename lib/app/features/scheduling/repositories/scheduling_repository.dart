import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/scheduling/models/shift_matching_models.dart';

class SchedulingRepository {
  final ApiMethod _apiMethod;

  SchedulingRepository(this._apiMethod);

  /// Match workers to a shift
  Future<List<WorkerMatch>> matchWorkers({
    required String shiftId,
    required String organizationId,
    MatchingCriteria? criteria,
  }) async {
    try {
      final response = await _apiMethod.matchWorkers(
        shiftId: shiftId,
        organizationId: organizationId,
        criteria: criteria?.toJson(),
      );

      if (response['success'] == true && response['data'] != null) {
        final matches = response['data']['matches'] as List;
        return matches.map((m) => WorkerMatch.fromJson(m)).toList();
      }

      throw Exception(response['message'] ?? 'Failed to match workers');
    } catch (e) {
      throw Exception('Error matching workers: $e');
    }
  }

  /// Auto-fill multiple shifts with optimal workers
  Future<AutoFillResult> autoFillShifts({
    required List<String> shiftIds,
    required String organizationId,
    MatchingCriteria? criteria,
  }) async {
    try {
      final response = await _apiMethod.autoFillShifts(
        shiftIds: shiftIds,
        organizationId: organizationId,
        criteria: criteria?.toJson(),
      );

      if (response['success'] == true && response['data'] != null) {
        return AutoFillResult.fromJson(response['data']);
      }

      throw Exception(response['message'] ?? 'Failed to auto-fill shifts');
    } catch (e) {
      throw Exception('Error auto-filling shifts: $e');
    }
  }

  /// Optimize route for a worker's shifts
  Future<RouteOptimization> optimizeRoute({
    required String workerId,
    required DateTime date,
    required String organizationId,
  }) async {
    try {
      final response = await _apiMethod.optimizeRoute(
        workerId: workerId,
        date: date.toIso8601String().split('T')[0],
        organizationId: organizationId,
      );

      if (response['success'] == true && response['data'] != null) {
        return RouteOptimization.fromJson(response['data']);
      }

      throw Exception(response['message'] ?? 'Failed to optimize route');
    } catch (e) {
      throw Exception('Error optimizing route: $e');
    }
  }

  /// Get shift recommendations for a specific shift
  Future<ShiftRecommendation> getShiftRecommendations({
    required String shiftId,
    required String organizationId,
  }) async {
    try {
      final response = await _apiMethod.getShiftRecommendations(
        shiftId: shiftId,
        organizationId: organizationId,
      );

      if (response['success'] == true && response['data'] != null) {
        return ShiftRecommendation.fromJson(response['data']);
      }

      throw Exception(response['message'] ?? 'Failed to get recommendations');
    } catch (e) {
      throw Exception('Error getting recommendations: $e');
    }
  }
}
