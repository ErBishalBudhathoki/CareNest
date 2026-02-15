import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/client_portal_repository.dart';
import '../models/client_portal_models.dart';

final clientInvoicesProvider = FutureProvider.autoDispose<List<ClientInvoice>>((ref) async {
  final repository = ref.watch(clientPortalRepositoryProvider);
  final response = await repository.getInvoices();
  return response.map((e) => ClientInvoice.fromJson(e as Map<String, dynamic>)).toList();
});

final clientInvoiceDetailProvider = FutureProvider.autoDispose.family<ClientInvoice, String>((ref, id) async {
  final repository = ref.watch(clientPortalRepositoryProvider);
  final response = await repository.getInvoiceDetail(id);
  if (response['success'] == true && response['data'] != null) {
    return ClientInvoice.fromJson(response['data']);
  }
  throw Exception(response['message'] ?? 'Failed to load invoice detail');
});

class InvoiceActionsViewModel extends StateNotifier<AsyncValue<void>> {
  final ClientPortalRepository _repository;

  InvoiceActionsViewModel(this._repository) : super(const AsyncValue.data(null));

  Future<void> approve(String id) async {
    state = const AsyncValue.loading();
    try {
      await _repository.approveInvoice(id);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> dispute(String id, String reason) async {
    state = const AsyncValue.loading();
    try {
      await _repository.disputeInvoice(id, reason);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final invoiceActionsViewModelProvider = StateNotifierProvider<InvoiceActionsViewModel, AsyncValue<void>>((ref) {
  final repository = ref.watch(clientPortalRepositoryProvider);
  return InvoiceActionsViewModel(repository);
});
