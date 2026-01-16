import 'package:carenest/backend/api_method.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final businessStatsProvider =
    FutureProvider.family<Map<String, dynamic>, String>((ref, organizationId) async {
  final api = ApiMethod();
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

