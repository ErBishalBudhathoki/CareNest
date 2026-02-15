import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final businessStatsProvider =
    FutureProvider.family<Map<String, dynamic>, String>(
        (ref, organizationId) async {
  final api = ref.read(app_providers.apiMethodProvider);
  final response = await api.getInvoiceStats(organizationId);

  if (response['success'] == true && response['data'] != null) {
    return Map<String, dynamic>.from(response['data'] as Map);
  }

  return const {
    'activeBusinesses': 0,
    'totalClients': 0,
    'totalInvoices': 0,
    'totalRevenue': '\$0.00',
    'pendingInvoices': 0,
    'activeInvoices': 0,
  };
});
