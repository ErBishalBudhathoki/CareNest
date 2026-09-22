import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/accounting_repository.dart';

final accountingViewModelProvider =
    NotifierProvider<AccountingViewModel, AsyncValue<void>>(
      AccountingViewModel.new,
    );

class AccountingViewModel extends Notifier<AsyncValue<void>> {
  // NOTE: never cache providers in `late final` fields here — build() can
  // re-run on the same notifier instance and reassigning a late final
  // throws LateInitializationError.
  AccountingRepository get _repository =>
      ref.read(accountingRepositoryProvider);

  @override
  AsyncValue<void> build() {
    ref.watch(accountingRepositoryProvider);
    return const AsyncData(null);
  }

  Future<String?> connectProvider({
    required String provider,
    required String organizationId,
  }) async {
    state = const AsyncLoading();
    try {
      final result = await _repository.connectProvider(
        provider: provider,
        organizationId: organizationId,
      );
      state = const AsyncData(null);
      return result['url'] as String?;
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }

  Future<void> syncInvoices({
    required String organizationId,
    required List<String> invoiceIds,
  }) async {
    state = const AsyncLoading();
    try {
      await _repository.syncInvoices(
        organizationId: organizationId,
        invoiceIds: invoiceIds,
      );
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}
