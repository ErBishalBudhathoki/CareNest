import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/invoice/models/invoice_list_model.dart';
import 'package:carenest/app/features/invoice/services/invoice_management_service.dart';

import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;

// State class for invoice list
class InvoiceListState {
  late final List<InvoiceListModel> invoices;
  late final bool isLoading;
  late final String? error;
  final Map<String, dynamic>? stats;

  InvoiceListState({
    this.invoices = const [],
    this.isLoading = false,
    this.error,
    this.stats,
  });

  InvoiceListState copyWith({
    List<InvoiceListModel>? invoices,
    bool? isLoading,
    String? error,
    Map<String, dynamic>? stats,
  }) {
    return InvoiceListState(
      invoices: invoices ?? this.invoices,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      stats: stats ?? this.stats,
    );
  }
}

// StateNotifier for managing invoice list state
class InvoiceListViewModel extends Notifier<InvoiceListState> {
  late final InvoiceManagementService _invoiceService;

  
  @override
  InvoiceListState build() {
    final invoiceService = ref.watch(invoiceManagementServiceProvider);
    
    return InvoiceListState();
  }

  Future<void> loadInvoices(
    String organizationId, {
    int page = 1,
    int limit = 20,
    String? status,
    String? invoiceType,
    String? search,
  }) async {
    debugPrint(
        '🔍 DEBUG: Loading invoices for organizationId: $organizationId');
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _invoiceService.getInvoicesList(
        organizationId: organizationId,
        page: page,
        limit: limit,
        status: status,
        invoiceType: invoiceType,
        search: search,
      );

      debugPrint('🔍 DEBUG: Backend response: $result');

      if (result['success'] == true) {
        final List<dynamic> invoicesData = result['data']?['invoices'] ?? [];
        debugPrint('🔍 DEBUG: Raw invoices data count: ${invoicesData.length}');
        debugPrint('🔍 DEBUG: Raw invoices data: $invoicesData');

        final List<InvoiceListModel> invoices = invoicesData.map((json) {
          debugPrint('🔍 DEBUG: Parsing invoice JSON: $json');
          return InvoiceListModel.fromJson(json);
        }).toList();

        debugPrint('🔍 DEBUG: Parsed invoices count: ${invoices.length}');
        debugPrint('🔍 DEBUG: Parsed invoices: $invoices');

        state = state.copyWith(
          invoices: invoices,
          isLoading: false,
          stats: result['data']?['pagination'],
        );
      } else {
        debugPrint('🔍 DEBUG: Backend returned error: ${result['message']}');
        state = state.copyWith(
          isLoading: false,
          error: result['message'] ?? 'Failed to load invoices',
        );
      }
    } catch (e) {
      debugPrint('🔍 DEBUG: Exception occurred: $e');
      state = state.copyWith(
        isLoading: false,
        error: 'Error loading invoices: $e',
      );
    }
  }

  Future<void> markAsPaid(
    String invoiceId,
    String organizationId,
    double amount, {
    String? updatedBy,
  }) async {
    try {
      final result = await _invoiceService.updatePaymentStatus(
        invoiceId: invoiceId,
        organizationId: organizationId,
        status: 'paid',
        paidAmount: amount,
        updatedBy: updatedBy,
      );

      if (result['success'] == true) {
        // Update local state
        final updatedInvoices = state.invoices.map((invoice) {
          if (invoice.id == invoiceId) {
            // We need to create a copy with new status.
            // Assuming InvoiceListModel has copyWith or we re-fetch.
            // Since InvoiceListModel is likely immutable and might not have copyWith exposed cleanly,
            // we will reload the list for simplicity and data consistency.
            return invoice;
          }
          return invoice;
        }).toList();

        // Actually, let's just reload to get fresh data
        loadInvoices(organizationId);
      } else {
        state = state.copyWith(
          error: result['message'] ?? 'Failed to update payment status',
        );
      }
    } catch (e) {
      state = state.copyWith(
        error: 'Error updating payment status: $e',
      );
    }
  }

  Future<void> shareInvoice(String invoiceId, String organizationId) async {
    try {
      final result = await _invoiceService.shareInvoice(
        invoiceId: invoiceId,
        organizationId: organizationId,
        shareMethod: 'link',
      );

      if (result['success'] != true) {
        state = state.copyWith(
          error:
              result['message'] ?? result['error'] ?? 'Failed to share invoice',
        );
      }
      // On success, you might want to show a success message or update the UI
    } catch (e) {
      state = state.copyWith(
        error: 'Error sharing invoice: $e',
      );
    }
  }

  Future<void> deleteInvoice(String invoiceId, String organizationId) async {
    try {
      final result = await _invoiceService.deleteInvoice(
        invoiceId: invoiceId,
        organizationId: organizationId,
      );

      if (result['success'] == true) {
        // Remove the deleted invoice from the list
        final updatedInvoices =
            state.invoices.where((invoice) => invoice.id != invoiceId).toList();

        state = state.copyWith(invoices: updatedInvoices);
      } else {
        state = state.copyWith(
          error: result['message'] ?? 'Failed to delete invoice',
        );
      }
    } catch (e) {
      state = state.copyWith(
        error: 'Error deleting invoice: $e',
      );
    }
  }

  Future<void> loadInvoiceStats(String organizationId) async {
    try {
      final result = await _invoiceService.getInvoiceStats(
        organizationId: organizationId,
      );

      if (result['success'] == true) {
        state = state.copyWith(stats: result['stats']);
      }
    } catch (e) {
      // Stats loading failure shouldn't affect the main UI
      debugPrint('Error loading invoice stats: $e');
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Provider for the invoice management service
final invoiceManagementServiceProvider =
    Provider<InvoiceManagementService>((ref) {
  return InvoiceManagementService(
      apiMethod: ref.read(app_providers.apiMethodProvider));
});

// Provider for the invoice list view model
final invoiceListViewModelProvider = NotifierProvider<InvoiceListViewModel, InvoiceListState>(InvoiceListViewModel.new);
