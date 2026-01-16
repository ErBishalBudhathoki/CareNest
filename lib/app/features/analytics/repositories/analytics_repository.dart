import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../backend/api_method.dart';
import '../models/analytics_models.dart';

class AnalyticsRepository {
  final ApiMethod _api;

  AnalyticsRepository(this._api);

  /// Fetch Financial Metrics (Revenue vs Labor Cost)
  Future<List<FinancialMetric>> fetchFinancials({
    required String organizationId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final response = await _api.get(
        'api/analytics/financials?organizationId=$organizationId&startDate=${startDate.toIso8601String()}&endDate=${endDate.toIso8601String()}',
      );

      if (response['success'] == true && response['data'] != null) {
        return (response['data'] as List)
            .map((e) => FinancialMetric.fromJson(e))
            .toList();
      }
      return [];
    } catch (e) {
      print('Error fetching financials: $e');
      return [];
    }
  }

  /// Fetch Utilization Metrics
  Future<List<UtilizationMetric>> fetchUtilization({
    required String organizationId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final response = await _api.get(
        'api/analytics/utilization?organizationId=$organizationId&startDate=${startDate.toIso8601String()}&endDate=${endDate.toIso8601String()}',
      );

      if (response['success'] == true && response['data'] != null) {
        return (response['data'] as List)
            .map((e) => UtilizationMetric.fromJson(e))
            .toList();
      }
      return [];
    } catch (e) {
      print('Error fetching utilization: $e');
      return [];
    }
  }

  /// Fetch Overtime Metrics
  Future<List<OvertimeMetric>> fetchOvertime({
    required String organizationId,
    required DateTime weekStart,
  }) async {
    try {
      // Format weekStart as YYYY-MM-DD
      final dateStr = weekStart.toIso8601String().split('T')[0];
      
      final response = await _api.get(
        'api/analytics/overtime?organizationId=$organizationId&weekStart=$dateStr',
      );

      if (response['success'] == true && response['data'] != null) {
        return (response['data'] as List)
            .map((e) => OvertimeMetric.fromJson(e))
            .toList();
      }
      return [];
    } catch (e) {
      print('Error fetching overtime: $e');
      return [];
    }
  }

  /// Fetch Reliability Metrics
  Future<List<ReliabilityMetric>> fetchReliability({
    required String organizationId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final response = await _api.get(
        'api/analytics/reliability?organizationId=$organizationId&startDate=${startDate.toIso8601String()}&endDate=${endDate.toIso8601String()}',
      );

      if (response['success'] == true && response['data'] != null) {
        return (response['data'] as List)
            .map((e) => ReliabilityMetric.fromJson(e))
            .toList();
      }
      return [];
    } catch (e) {
      print('Error fetching reliability: $e');
      return [];
    }
  }
}

final analyticsRepositoryProvider = Provider((ref) {
  return AnalyticsRepository(ApiMethod());
});
