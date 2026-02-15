import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';
import '../repositories/financial_intelligence_repository.dart';

class BillingAutomationState {
  final bool isLoading;
  final Map<String, dynamic>? invoices;
  final Map<String, dynamic>? validation;
  final Map<String, dynamic>? anomalies;
  final List<dynamic>? pendingInvoices;
  final String? error;

  BillingAutomationState({
    this.isLoading = false,
    this.invoices,
    this.validation,
    this.anomalies,
    this.pendingInvoices,
    this.error,
  });

  BillingAutomationState copyWith({
    bool? isLoading,
    Map<String, dynamic>? invoices,
    Map<String, dynamic>? validation,
    Map<String, dynamic>? anomalies,
    List<dynamic>? pendingInvoices,
    String? error,
  }) {
    return BillingAutomationState(
      isLoading: isLoading ?? this.isLoading,
      invoices: invoices ?? this.invoices,
      validation: validation ?? this.validation,
      anomalies: anomalies ?? this.anomalies,
      pendingInvoices: pendingInvoices ?? this.pendingInvoices,
      error: error,
    );
  }
}

class BillingAutomationViewModel extends StateNotifier<BillingAutomationState> {
  final FinancialIntelligenceRepository _repository;

  BillingAutomationViewModel(this._repository) : super(BillingAutomationState());

  Future<void> generateInvoices({
    required String organizationId,
    required String billingPeriod,
    Map<String, dynamic>? options,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.generateInvoices(
        organizationId: organizationId,
        billingPeriod: billingPeriod,
        options: options,
      );
      
      if (result['success'] == true) {
        state = state.copyWith(isLoading: false, invoices: result);
      } else {
        state = state.copyWith(isLoading: false, error: result['message']);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> validateBilling(Map<String, dynamic> billingData) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.validateBilling(billingData: billingData);
      if (result['success'] == true) {
        state = state.copyWith(isLoading: false, validation: result['validation']);
      } else {
        state = state.copyWith(isLoading: false, error: result['message']);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> detectAnomalies(Map<String, dynamic> invoiceData) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.detectBillingAnomalies(invoiceData: invoiceData);
      if (result['success'] == true) {
        state = state.copyWith(isLoading: false, anomalies: result);
      } else {
        state = state.copyWith(isLoading: false, error: result['message']);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> getPendingInvoices(String organizationId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.getPendingInvoices(organizationId: organizationId);
      if (result['success'] == true) {
        state = state.copyWith(isLoading: false, pendingInvoices: result['pending']);
      } else {
        state = state.copyWith(isLoading: false, error: result['message']);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

final billingAutomationViewModelProvider =
    StateNotifierProvider<BillingAutomationViewModel, BillingAutomationState>((ref) {
  final apiMethod = ApiMethod();
  final repository = FinancialIntelligenceRepository(apiMethod);
  return BillingAutomationViewModel(repository);
});
