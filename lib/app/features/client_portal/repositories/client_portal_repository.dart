import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';
import '../models/client_portal_models.dart';

class ClientPortalRepository {
  final ApiMethod _apiMethod;

  ClientPortalRepository(this._apiMethod);

  Future<List<ClientInvoice>> getInvoices({int page = 1, int limit = 10, String? status}) async {
    final query = 'page=$page&limit=$limit${status != null ? '&status=$status' : ''}';
    final response = await _apiMethod.get('api/client-portal/invoices?$query');
    
    if (response['success'] == true) {
      final data = response['data'] as Map<String, dynamic>;
      final list = data['invoices'] as List;
      return list.map((e) => ClientInvoice.fromJson(e)).toList();
    } else {
      throw Exception(response['message'] ?? 'Failed to fetch invoices');
    }
  }

  Future<ClientInvoice> getInvoiceDetail(String id) async {
    final response = await _apiMethod.get('api/client-portal/invoices/$id');
    
    if (response['success'] == true) {
      return ClientInvoice.fromJson(response['data']);
    } else {
      throw Exception(response['message'] ?? 'Failed to fetch invoice');
    }
  }

  Future<void> approveInvoice(String id) async {
    final response = await _apiMethod.post('api/client-portal/invoices/$id/approve', body: {});
    if (response['success'] != true) {
      throw Exception(response['message']);
    }
  }

  Future<void> disputeInvoice(String id, String reason) async {
    final response = await _apiMethod.post('api/client-portal/invoices/$id/dispute', body: {'reason': reason});
    if (response['success'] != true) {
      throw Exception(response['message']);
    }
  }

  Future<List<ClientAppointment>> getAppointments() async {
    final response = await _apiMethod.get('api/client-portal/appointments');
    
    if (response['success'] == true) {
      final list = response['data'] as List;
      return list.map((e) => ClientAppointment.fromJson(e)).toList();
    } else {
      throw Exception(response['message']);
    }
  }
}

final clientPortalRepositoryProvider = Provider<ClientPortalRepository>((ref) {
  // We need to provide ApiMethod. It's likely a provider or a singleton.
  // In `InvoiceRepository`, it's passed in constructor.
  // I need to find where InvoiceRepository is provided.
  // Likely in `lib/app/core/providers/invoice_providers.dart`.
  return ClientPortalRepository(ApiMethod()); // ApiMethod() seems to be a class we can instantiate.
  // However, ApiMethod extends ChangeNotifier.
  // Ideally we should use the same instance if it holds state (like token).
  // But ApiMethod reads token from SharedPreferences in `get()`.
  // So a new instance is fine.
});
