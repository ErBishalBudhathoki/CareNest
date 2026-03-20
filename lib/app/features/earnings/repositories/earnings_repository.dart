import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/features/earnings/models/earnings_data.dart';
import 'package:carenest/app/features/earnings/services/earnings_cache_service.dart';

final earningsRepositoryProvider = Provider<EarningsRepository>((ref) {
  return EarningsRepository(ref.read(app_providers.apiMethodProvider));
});

class EarningsRepository {
  final ApiMethod _apiMethod;
  final EarningsCacheService _cache = EarningsCacheService();

  EarningsRepository(this._apiMethod);

  Future<EarningsSummary> getEarningsSummary(String userEmail,
      {String? startDate, String? endDate, bool forceRefresh = false}) async {
    String query = '';
    if (startDate != null && endDate != null) {
      query = '?startDate=$startDate&endDate=$endDate';
    }

    if (!forceRefresh) {
      final cached = await _cache.getCachedSummary(
        userEmail,
        startDate: startDate,
        endDate: endDate,
      );
      if (cached != null) {
        return EarningsSummary.fromJson(cached);
      }
    }

    final response = await _apiMethod.get('earnings/summary/$userEmail$query');

    if (response['success'] == true) {
      await _cache.cacheSummary(
        userEmail,
        response['data'],
        startDate: startDate,
        endDate: endDate,
      );
      return EarningsSummary.fromJson(response['data']);
    } else {
      throw Exception(
          response['message'] ?? 'Failed to fetch earnings summary');
    }
  }

  Future<ProjectedEarnings> getProjectedEarnings(String userEmail,
      {String? startDate}) async {
    String query = '';
    if (startDate != null) {
      query = '?startDate=$startDate';
    }

    final response =
        await _apiMethod.get('earnings/projected/$userEmail$query');

    if (response['success'] == true) {
      return ProjectedEarnings.fromJson(response['data']);
    } else {
      throw Exception(
          response['message'] ?? 'Failed to fetch projected earnings');
    }
  }

  Future<EarningsPeriodHistory> getEarningsHistory(
    String userEmail, {
    required String startDate,
    required String endDate,
    required String bucket,
  }) async {
    final query = '?startDate=$startDate&endDate=$endDate&bucket=$bucket';
    final response = await _apiMethod.get('earnings/history/$userEmail$query');

    if (response['success'] == true) {
      return EarningsPeriodHistory.fromJson(response['data']);
    } else {
      throw Exception(
          response['message'] ?? 'Failed to fetch earnings history');
    }
  }

  Future<Map<String, dynamic>> getTaxSettings() async {
    final cached = await _cache.getCachedTaxConfig();
    if (cached != null) return cached;

    final response = await _apiMethod.getTaxSettings();
    if (response['success'] == true) {
      final data = response['data'] as Map<String, dynamic>;
      await _cache.cacheTaxConfig(data);
      return data;
    }
    throw Exception('Failed to fetch tax settings');
  }

  Future<void> setPayRate(String userEmail, double rate, String type,
      [dynamic rates,
      String? classificationLevel,
      String? payPoint,
      String? stream,
      String? employmentType,
      List<String>? activeAllowances,
      String? organizationId,
      String? adminEmail]) async {
    final body = {'rate': rate, 'type': type};

    if (classificationLevel != null)
      body['classificationLevel'] = classificationLevel;
    if (payPoint != null) body['payPoint'] = payPoint;
    if (stream != null) body['stream'] = stream;
    if (employmentType != null) body['employmentType'] = employmentType;
    if (activeAllowances != null) body['activeAllowances'] = activeAllowances;
    if (organizationId != null && organizationId.trim().isNotEmpty) {
      body['organizationId'] = organizationId.trim();
    }
    if (adminEmail != null && adminEmail.trim().isNotEmpty) {
      body['adminEmail'] = adminEmail.trim();
    }

    if (rates != null) {
      body['rates'] = {
        'baseRate': rates.baseRate,
        'saturdayRate': rates.saturdayRate,
        'sundayRate': rates.sundayRate,
        'publicHolidayRate': rates.publicHolidayRate,
        'overtimeRate': rates.overtimeRate,
        'overtimeRate2': rates.overtimeRate2,
        'nightShiftRate': rates.nightShiftRate,
        'eveningShiftRate': rates.eveningShiftRate,
      };
    }

    final response = await _apiMethod.post(
      'earnings/rate/$userEmail',
      body: body,
    );

    if (response['success'] != true) {
      throw Exception(response['message'] ?? 'Failed to set pay rate');
    }
  }
}
