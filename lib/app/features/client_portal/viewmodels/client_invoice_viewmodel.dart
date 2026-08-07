import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/features/invoice/models/invoice_list_model.dart';
import 'package:carenest/app/features/invoice/viewmodels/invoice_detail_viewmodel.dart'
    as invoice_providers;
import '../repositories/client_portal_repository.dart';
import '../models/client_portal_models.dart';

final clientInvoicesProvider = FutureProvider.autoDispose<List<ClientInvoice>>((
  ref,
) async {
  final repository = ref.watch(clientPortalRepositoryProvider);
  final response = await repository.getInvoices();
  return response
      .map((e) => ClientInvoice.fromJson(e as Map<String, dynamic>))
      .toList();
});

final clientInvoiceDetailProvider = FutureProvider.autoDispose
    .family<ClientInvoice, String>((ref, id) async {
      final repository = ref.watch(clientPortalRepositoryProvider);
      final response = await repository.getInvoiceDetail(id);
      if (response['success'] == true && response['data'] != null) {
        return ClientInvoice.fromJson(response['data']);
      }
      throw Exception(response['message'] ?? 'Failed to load invoice detail');
    });

final clientInvoiceReceiptUrlsProvider = FutureProvider.autoDispose
    .family<List<String>, String>((ref, invoiceId) async {
      final providerOrgId =
          ref.watch(app_providers.organizationIdProvider) ?? '';
      final prefsOrgId =
          ref
              .watch(app_providers.sharedPreferencesProvider)
              .getOrganizationId() ??
          '';
      final organizationId = providerOrgId.trim().isNotEmpty
          ? providerOrgId.trim()
          : prefsOrgId.trim();

      if (organizationId.isEmpty) return const [];

      try {
        final invoiceService = ref.watch(
          invoice_providers.invoiceManagementServiceProvider,
        );
        final details = await invoiceService.getInvoiceDetails(
          invoiceId: invoiceId,
          organizationId: organizationId,
        );

        if (details['success'] == true && details['data'] is Map) {
          final parsed = InvoiceListModel.fromJson(
            Map<String, dynamic>.from(details['data'] as Map),
          );
          return parsed.receiptUrls.toSet().toList();
        }
      } catch (_) {}

      return const [];
    });

class InvoiceActionsViewModel extends AsyncNotifier<void> {
  late final ClientPortalRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.watch(clientPortalRepositoryProvider);
    return null;
  }

  Future<void> approve(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repository.approveInvoice(id));
  }

  Future<void> dispute(String id, String reason) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _repository.disputeInvoice(id, reason),
    );
  }
}

final invoiceActionsViewModelProvider =
    AsyncNotifierProvider<InvoiceActionsViewModel, void>(
      InvoiceActionsViewModel.new,
    );
