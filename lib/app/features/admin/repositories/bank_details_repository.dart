import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/core_providers.dart';

final bankDetailsRepositoryProvider = Provider<BankDetailsRepository>((ref) {
  final apiMethod = ref.read(apiMethodProvider);
  return BankDetailsRepository(apiMethod);
});

class BankDetailsRepository {
  final ApiMethod _apiMethod;

  BankDetailsRepository(this._apiMethod);

  Future<Map<String, dynamic>> saveBankDetails({
    required String bankName,
    required String accountName,
    required String bsb,
    required String accountNumber,
  }) async {
    // Assuming ApiMethod.saveBankDetails uses post('saveBankDetails', ...)
    // If not, we should use generic post here to be consistent.
    // I'll use generic post to 'saveBankDetails' which maps to backend route.

    final response = await _apiMethod.post(
      'saveBankDetails',
      body: {
        'bankName': bankName,
        'accountName': accountName,
        'bsb': bsb,
        'accountNumber': accountNumber,
      },
    );

    if (response['success'] == true || response['statusCode'] == 201) {
      return response['data'] ?? {};
    }

    throw Exception(response['message'] ?? 'Failed to save bank details');
  }

  Future<Map<String, dynamic>?> getBankDetails() async {
    final response = await _apiMethod.get('getBankDetails');

    if (response['success'] == true || response['statusCode'] == 200) {
      return response['data'];
    }

    // 404 is handled gracefully by returning null if structure matches
    if (response['statusCode'] == 404) return null;

    throw Exception(response['message'] ?? 'Failed to fetch bank details');
  }
}
