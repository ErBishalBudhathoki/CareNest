import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/core_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/pricing_analytics_models.dart';

final pricingRepositoryProvider = Provider<PricingRepository>((ref) {
  final apiMethod = ref.read(apiMethodProvider);
  return PricingRepository(apiMethod);
});

class PricingRepository {
  final ApiMethod _apiMethod;

  PricingRepository(this._apiMethod);

  // Helper for authenticated GET request using ApiMethod
  Future<dynamic> _get(String endpoint, Map<String, String> params) async {
    // Construct query string manually as ApiMethod.get() takes a single string endpoint
    final queryString = params.entries
        .map(
          (e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');

    final fullEndpoint = queryString.isNotEmpty
        ? '$endpoint?$queryString'
        : endpoint;

    final response = await _apiMethod.get(fullEndpoint);

    if (response['success'] == true) {
      return response['data'];
    } else {
      throw Exception(response['message'] ?? 'API Error');
    }
  }

  /// Fetch pricing analytics for an organization
  Future<PricingAnalytics> fetchPricingAnalytics({
    required String organizationId,
    DateTime? startDate,
    DateTime? endDate,
    String? clientId,
  }) async {
    final params = <String, String>{'organizationId': organizationId};

    if (startDate != null) {
      params['startDate'] = startDate.toIso8601String();
    }
    if (endDate != null) {
      params['endDate'] = endDate.toIso8601String();
    }
    if (clientId != null) {
      params['clientId'] = clientId;
    }

    final data = await _get('analytics/pricing/$organizationId', params);

    return PricingAnalytics.fromBackend(data);
  }

  /// Fetch pricing compliance report for an organization
  Future<PricingComplianceReport> fetchPricingComplianceReport({
    required String organizationId,
    DateTime? startDate,
    DateTime? endDate,
    double threshold = 0.95,
  }) async {
    final params = <String, String>{'organizationId': organizationId};

    if (startDate != null) {
      params['startDate'] = startDate.toIso8601String();
    }
    if (endDate != null) {
      params['endDate'] = endDate.toIso8601String();
    }
    params['threshold'] = threshold.toString();

    final data = await _get(
      'analytics/pricing/compliance/$organizationId',
      params,
    );

    return PricingComplianceReport.fromBackend(data);
  }
}
