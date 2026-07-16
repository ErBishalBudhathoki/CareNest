import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import '../repositories/financial_intelligence_repository.dart';

class CashFlowState {
  late final bool isLoading;
  final Map<String, dynamic>? forecast;
  final Map<String, dynamic>? position;
  late final List<dynamic>? alerts;
  final Map<String, dynamic>? optimization;
  late final String? error;

  CashFlowState({
    this.isLoading = false,
    this.forecast,
    this.position,
    this.alerts,
    this.optimization,
    this.error,
  });

  CashFlowState copyWith({
    bool? isLoading,
    Map<String, dynamic>? forecast,
    Map<String, dynamic>? position,
    List<dynamic>? alerts,
    Map<String, dynamic>? optimization,
    String? error,
  }) {
    return CashFlowState(
      isLoading: isLoading ?? this.isLoading,
      forecast: forecast ?? this.forecast,
      position: position ?? this.position,
      alerts: alerts ?? this.alerts,
      optimization: optimization ?? this.optimization,
      error: error,
    );
  }
}

class CashFlowViewModel extends Notifier<CashFlowState> {
  late final FinancialIntelligenceRepository _repository;

  
  @override
  CashFlowState build() {
    final apiMethod = ref.read(app_providers.apiMethodProvider);
    
    return CashFlowState();
  }

  Future<void> forecastCashFlow({
    required String organizationId,
    int horizon = 60,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.forecastCashFlow(
        organizationId: organizationId,
        horizon: horizon,
      );

      if (result['success'] == true) {
        state = state.copyWith(isLoading: false, forecast: result['forecast']);
      } else {
        state = state.copyWith(isLoading: false, error: result['message']);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> getCurrentPosition(String organizationId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.getCurrentCashPosition(
          organizationId: organizationId);
      if (result['success'] == true) {
        state = state.copyWith(isLoading: false, position: result['position']);
      } else {
        state = state.copyWith(isLoading: false, error: result['message']);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> getAlerts(String organizationId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result =
          await _repository.getCashFlowAlerts(organizationId: organizationId);
      if (result['success'] == true) {
        state = state.copyWith(isLoading: false, alerts: result['alerts']);
      } else {
        state = state.copyWith(isLoading: false, error: result['message']);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> optimizeCash({
    required String organizationId,
    Map<String, dynamic>? constraints,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.optimizeCash(
        organizationId: organizationId,
        constraints: constraints,
      );

      if (result['success'] == true) {
        state = state.copyWith(
            isLoading: false, optimization: result['optimization']);
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

final cashFlowViewModelProvider = NotifierProvider<CashFlowViewModel, CashFlowState>(CashFlowViewModel.new);
