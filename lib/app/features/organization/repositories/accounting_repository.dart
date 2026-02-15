import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/core_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountingRepositoryProvider = Provider<AccountingRepository>((ref) {
  final apiMethod = ref.read(apiMethodProvider);
  return AccountingRepository(apiMethod);
});

class AccountingRepository {
  final ApiMethod _apiMethod;

  AccountingRepository(this._apiMethod);

  Future<Map<String, dynamic>> connectProvider({
    required String provider, // 'xero' or 'myob'
    required String organizationId,
  }) async {
    final response = await _apiMethod.post(
      'accounting/connect',
      body: {
        'provider': provider,
        'organizationId': organizationId,
      },
    );

    if (response['success'] == true) {
      return response['data'];
    } else {
      throw Exception(response['message'] ?? 'Failed to initiate connection');
    }
  }

  Future<Map<String, dynamic>> syncInvoices({
    required String organizationId,
    required List<String> invoiceIds,
  }) async {
    final response = await _apiMethod.post(
      'accounting/sync',
      body: {
        'organizationId': organizationId,
        'invoiceIds': invoiceIds,
      },
    );

    if (response['success'] == true) {
      return response['data'];
    } else {
      throw Exception(response['message'] ?? 'Failed to sync invoices');
    }
  }
}
