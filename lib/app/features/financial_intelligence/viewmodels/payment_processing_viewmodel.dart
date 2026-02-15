import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';
import '../repositories/financial_intelligence_repository.dart';

class PaymentProcessingState {
  final bool isLoading;
  final Map<String, dynamic>? payment;
  final Map<String, dynamic>? analytics;
  final Map<String, dynamic>? fraudCheck;
  final String? error;

  PaymentProcessingState({
    this.isLoading = false,
    this.payment,
    this.analytics,
    this.fraudCheck,
    this.error,
  });

  PaymentProcessingState copyWith({
    bool? isLoading,
    Map<String, dynamic>? payment,
    Map<String, dynamic>? analytics,
    Map<String, dynamic>? fraudCheck,
    String? error,
  }) {
    return PaymentProcessingState(
      isLoading: isLoading ?? this.isLoading,
      payment: payment ?? this.payment,
      analytics: analytics ?? this.analytics,
      fraudCheck: fraudCheck ?? this.fraudCheck,
      error: error,
    );
  }
}

class PaymentProcessingViewModel extends StateNotifier<PaymentProcessingState> {
  final FinancialIntelligenceRepository _repository;

  PaymentProcessingViewModel(this._repository) : super(PaymentProcessingState());

  Future<void> processPayment(Map<String, dynamic> paymentData) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.processPayment(paymentData: paymentData);
      if (result['success'] == true) {
        state = state.copyWith(isLoading: false, payment: result['payment']);
      } else {
        state = state.copyWith(isLoading: false, error: result['message']);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> getAnalytics({
    required String organizationId,
    String period = '30d',
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.getPaymentAnalytics(
        organizationId: organizationId,
        period: period,
      );
      
      if (result['success'] == true) {
        state = state.copyWith(isLoading: false, analytics: result['analytics']);
      } else {
        state = state.copyWith(isLoading: false, error: result['message']);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> checkFraud(Map<String, dynamic> paymentData) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.checkPaymentFraud(paymentData: paymentData);
      if (result['success'] == true) {
        state = state.copyWith(isLoading: false, fraudCheck: result['check']);
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

final paymentProcessingViewModelProvider =
    StateNotifierProvider<PaymentProcessingViewModel, PaymentProcessingState>((ref) {
  final apiMethod = ApiMethod();
  final repository = FinancialIntelligenceRepository(apiMethod);
  return PaymentProcessingViewModel(repository);
});
