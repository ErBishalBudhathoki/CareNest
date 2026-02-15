import 'package:carenest/backend/api_method.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import '../models/analytics_models.dart';

class AnalyticsRepository {
  final ApiMethod _apiMethod;

  AnalyticsRepository(this._apiMethod);

  // Helper for authenticated GET request using ApiMethod
  Future<dynamic> _get(String endpoint, Map<String, String> params) async {
    // Construct query string manually as ApiMethod.get() takes a single string endpoint
    final queryString = params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');

    final fullEndpoint =
        queryString.isNotEmpty ? '$endpoint?$queryString' : endpoint;

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

  Future<List<CrossOrgMetric>> fetchCrossOrgRevenue({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final data = await _get('api/analytics/cross-org-revenue', {
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    });

    return (data as List).map((e) => CrossOrgMetric.fromJson(e)).toList();
  }

  Future<List<ForecastMetric>> fetchForecast({
    required String organizationId,
    required String metric,
    required int daysAhead,
  }) async {
    final data = await _get('api/analytics/forecast', {
      'organizationId': organizationId,
      'metric': metric,
      'daysAhead': daysAhead.toString(),
    });

    return (data as List).map((e) => ForecastMetric.fromJson(e)).toList();
  }

  // NEW: Fetch worker churn predictions
  Future<List<ChurnPrediction>> fetchChurnPredictions({
    required String organizationId,
  }) async {
    final data = await _get('api/analytics/churn-prediction', {
      'organizationId': organizationId,
    });

    return (data as List).map((e) => ChurnPrediction.fromJson(e)).toList();
  }

  // NEW: Fetch demand forecast
  Future<List<DemandForecast>> fetchDemandForecast({
    required String organizationId,
    required int daysAhead,
  }) async {
    final data = await _get('api/analytics/demand-forecast', {
      'organizationId': organizationId,
      'daysAhead': daysAhead.toString(),
    });

    return (data as List).map((e) => DemandForecast.fromJson(e)).toList();
  }

  // NEW: Fetch compliance risk assessment
  Future<ComplianceRisk> fetchComplianceRisk({
    required String organizationId,
  }) async {
    final data = await _get('api/analytics/compliance-risk', {
      'organizationId': organizationId,
    });

    return ComplianceRisk.fromJson(data);
  }

  // NEW Phase 5: Fetch client risk predictions
  Future<List<ClientRisk>> fetchClientRisk({
    required String organizationId,
  }) async {
    final data = await _get('api/analytics/client-risk', {
      'organizationId': organizationId,
    });

    return (data as List).map((e) => ClientRisk.fromJson(e)).toList();
  }

  // NEW Phase 5: Fetch service demand predictions
  Future<ServiceDemandResult> fetchServiceDemand({
    required String organizationId,
    int daysAhead = 30,
  }) async {
    final data = await _get('api/analytics/service-demand', {
      'organizationId': organizationId,
      'daysAhead': daysAhead.toString(),
    });

    return ServiceDemandResult.fromJson(data);
  }

  // NEW Phase 5: Run scenario model
  Future<ScenarioResult> runScenarioModel({
    required String organizationId,
    required Map<String, dynamic> scenario,
  }) async {
    final response = await _apiMethod.post(
      'api/analytics/scenario-model',
      body: {
        'organizationId': organizationId,
        'scenario': scenario,
      },
    );

    if (response['success'] == true) {
      return ScenarioResult.fromJson(response['data']);
    } else {
      throw Exception(response['message'] ?? 'API Error');
    }
  }

  // NEW Phase 5: Fetch AI recommendations
  Future<List<AIRecommendation>> fetchRecommendations({
    required String organizationId,
  }) async {
    final data = await _get('api/analytics/recommendations', {
      'organizationId': organizationId,
    });

    return (data as List).map((e) => AIRecommendation.fromJson(e)).toList();
  }
}

final analyticsRepositoryProvider = Provider<AnalyticsRepository>((ref) {
  return AnalyticsRepository(ref.read(app_providers.apiMethodProvider));
});
