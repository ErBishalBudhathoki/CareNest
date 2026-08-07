import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/core_providers.dart';

final complianceRepositoryProvider = Provider<ComplianceRepository>((ref) {
  final apiMethod = ref.read(apiMethodProvider);
  return ComplianceRepository(apiMethod);
});

class ComplianceRepository {
  final ApiMethod _apiMethod;

  ComplianceRepository(this._apiMethod);

  Future<Map<String, dynamic>> getComplianceSummary() async {
    // Assuming backend endpoint is /api/compliance/summary
    final response = await _apiMethod.get('compliance/summary');

    if (response['success'] == true) {
      return response['data'];
    } else {
      throw Exception(
        response['message'] ?? 'Failed to fetch compliance summary',
      );
    }
  }
}
