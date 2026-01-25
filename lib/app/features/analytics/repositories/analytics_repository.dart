import 'package:carenest/backend/api_method.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/analytics_models.dart';

class AnalyticsRepository {
  final ApiMethod _apiMethod;

  AnalyticsRepository(this._apiMethod);

  // Helper for authenticated GET request using ApiMethod
  Future<dynamic> _get(String endpoint, Map<String, String> params) async {
    // Construct query string manually as ApiMethod.get() takes a single string endpoint
    final queryString = params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
    
    final fullEndpoint = queryString.isNotEmpty ? '$endpoint?$queryString' : endpoint;

    final response = await _apiMethod.get(fullEndpoint);

    if (response['success'] == true) {
      return response['data'];
    } else {
      throw Exception(response['message'] ?? 'API Error');
    }
  }

  Future<List<FinancialMetric>> fetchFinancials({
    required String organizationId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final data = await _get('api/analytics/financials', {
      'organizationId': organizationId,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    });
    
    return (data as List).map((e) => FinancialMetric.fromJson(e)).toList();
  }

  Future<List<UtilizationMetric>> fetchUtilization({
    required String organizationId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final data = await _get('api/analytics/utilization', {
      'organizationId': organizationId,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    });
    
    return (data as List).map((e) => UtilizationMetric.fromJson(e)).toList();
  }

  Future<List<OvertimeMetric>> fetchOvertime({
    required String organizationId,
    required DateTime weekStart,
  }) async {
    final data = await _get('api/analytics/overtime', {
      'organizationId': organizationId,
      'weekStart': weekStart.toIso8601String().split('T')[0], // YYYY-MM-DD
    });
    
    return (data as List).map((e) => OvertimeMetric.fromJson(e)).toList();
  }

  Future<List<ReliabilityMetric>> fetchReliability({
    required String organizationId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final data = await _get('api/analytics/reliability', {
      'organizationId': organizationId,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    });
    
    return (data as List).map((e) => ReliabilityMetric.fromJson(e)).toList();
  }
}

final analyticsRepositoryProvider = Provider<AnalyticsRepository>((ref) {
  return AnalyticsRepository(ApiMethod()); 
});
