import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/accounting_repository.dart';

final accountingViewModelProvider = StateNotifierProvider<AccountingViewModel, AsyncValue<void>>((ref) {
  final repository = ref.watch(accountingRepositoryProvider);
  return AccountingViewModel(repository);
});

class AccountingViewModel extends StateNotifier<AsyncValue<void>> {
  final AccountingRepository _repository;

  AccountingViewModel(this._repository) : super(const AsyncValue.data(null));

  Future<String?> connectProvider({
    required String provider,
    required String organizationId,
  }) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.connectProvider(
        provider: provider,
        organizationId: organizationId,
      );
      state = const AsyncValue.data(null);
      return result['url'] as String?;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> syncInvoices({
    required String organizationId,
    required List<String> invoiceIds,
  }) async {
    state = const AsyncValue.loading();
    try {
      await _repository.syncInvoices(
        organizationId: organizationId,
        invoiceIds: invoiceIds,
      );
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}
