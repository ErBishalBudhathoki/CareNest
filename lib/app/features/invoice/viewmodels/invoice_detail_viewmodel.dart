import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/invoice/models/invoice_list_model.dart';
import 'package:carenest/app/features/invoice/services/invoice_management_service.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;

// State class for invoice detail
class InvoiceDetailState {
  final InvoiceListModel? invoice;
  final bool isLoading;
  final String? error;
  final String? warning;
  final bool isSharing;
  final bool isDeleting;

  const InvoiceDetailState({
    this.invoice,
    this.isLoading = false,
    this.error,
    this.warning,
    this.isSharing = false,
    this.isDeleting = false,
  });

  InvoiceDetailState copyWith({
    InvoiceListModel? invoice,
    bool? isLoading,
    String? error,
    String? warning,
    bool? isSharing,
    bool? isDeleting,
  }) {
    return InvoiceDetailState(
      invoice: invoice ?? this.invoice,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      warning: warning ?? this.warning,
      isSharing: isSharing ?? this.isSharing,
      isDeleting: isDeleting ?? this.isDeleting,
    );
  }

  InvoiceDetailState clearError() {
    return copyWith(error: null, warning: null);
  }
}

// ViewModel for invoice detail
class InvoiceDetailViewModel extends StateNotifier<InvoiceDetailState> {
  final InvoiceManagementService _invoiceService;

  InvoiceDetailViewModel(this._invoiceService)
      : super(const InvoiceDetailState());

  void setInitialInvoice(InvoiceListModel invoice) {
    state = state.copyWith(invoice: invoice, error: null, warning: null);
  }

  // Load invoice details
  Future<void> loadInvoiceDetails(
      String invoiceId, String organizationId) async {
    state = state.copyWith(isLoading: true, error: null, warning: null);

    try {
      final result = await _invoiceService.getInvoiceDetails(
        invoiceId: invoiceId,
        organizationId: organizationId,
      );

      if (result['success'] == true && result['data'] != null) {
        final invoice = InvoiceListModel.fromJson(result['data']);
        state = state.copyWith(
          invoice: invoice,
          isLoading: false,
          error: null,
          warning: null,
        );
      } else {
        final message = result['message'] ?? 'Failed to load invoice details';
        if (state.invoice != null) {
          state = state.copyWith(
            isLoading: false,
            warning: '$message. Showing cached invoice data.',
            error: null,
          );
          return;
        }
        state = state.copyWith(
          isLoading: false,
          error: message,
        );
      }
    } catch (e) {
      if (state.invoice != null) {
        state = state.copyWith(
          isLoading: false,
          warning:
              'Failed to refresh invoice details. Showing cached invoice data.',
          error: null,
        );
        return;
      }
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load invoice details: ${e.toString()}',
      );
    }
  }

  // Share invoice
  Future<void> shareInvoice(String invoiceId, String organizationId) async {
    state = state.copyWith(isSharing: true, error: null);

    try {
      await _invoiceService.shareInvoice(
        invoiceId: invoiceId,
        organizationId: organizationId,
        shareMethod: 'link',
      );

      state = state.copyWith(isSharing: false);
    } catch (e) {
      state = state.copyWith(
        isSharing: false,
        error: 'Failed to share invoice: ${e.toString()}',
      );
    }
  }

  // Delete invoice
  Future<void> deleteInvoice(String invoiceId, String organizationId) async {
    state = state.copyWith(isDeleting: true, error: null);

    try {
      await _invoiceService.deleteInvoice(
        invoiceId: invoiceId,
        organizationId: organizationId,
      );

      state = state.copyWith(isDeleting: false);
    } catch (e) {
      state = state.copyWith(
        isDeleting: false,
        error: 'Failed to delete invoice: ${e.toString()}',
      );
    }
  }

  // Clear any errors
  void clearError() {
    state = state.clearError();
  }

  // Refresh invoice details
  Future<void> refresh(String invoiceId, String organizationId) async {
    await loadInvoiceDetails(invoiceId, organizationId);
  }
}

// Providers
final invoiceDetailViewModelProvider =
    StateNotifierProvider<InvoiceDetailViewModel, InvoiceDetailState>(
  (ref) {
    final invoiceService = ref.watch(invoiceManagementServiceProvider);
    return InvoiceDetailViewModel(invoiceService);
  },
);

// Provider for invoice service
final invoiceManagementServiceProvider = Provider<InvoiceManagementService>(
  (ref) => InvoiceManagementService(
      apiMethod: ref.read(app_providers.apiMethodProvider)),
);
