import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import '../repositories/financial_intelligence_repository.dart';

class PaymentProcessingState {
  late final bool isLoading;
  final Map<String, dynamic>? payment;
  final Map<String, dynamic>? analytics;
  final Map<String, dynamic>? fraudCheck;
  late final String? error;

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

class PaymentProcessingViewModel extends Notifier<PaymentProcessingState> {
  late final FinancialIntelligenceRepository _repository;

  @override
  PaymentProcessingState build() {
    final apiMethod = ref.read(app_providers.apiMethodProvider);

    return PaymentProcessingState();
  }

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
        state = state.copyWith(
          isLoading: false,
          analytics: result['analytics'],
        );
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
      final result = await _repository.checkPaymentFraud(
        paymentData: paymentData,
      );
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
    NotifierProvider<PaymentProcessingViewModel, PaymentProcessingState>(
      PaymentProcessingViewModel.new,
    );
