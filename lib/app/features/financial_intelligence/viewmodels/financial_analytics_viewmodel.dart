import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import '../repositories/financial_intelligence_repository.dart';

class FinancialAnalyticsState {
  late final bool isLoading;
  final Map<String, dynamic>? dashboard;
  final Map<String, dynamic>? profitability;
  final Map<String, dynamic>? kpis;
  final Map<String, dynamic>? trends;
  late final String? error;

  FinancialAnalyticsState({
    this.isLoading = false,
    this.dashboard,
    this.profitability,
    this.kpis,
    this.trends,
    this.error,
  });

  FinancialAnalyticsState copyWith({
    bool? isLoading,
    Map<String, dynamic>? dashboard,
    Map<String, dynamic>? profitability,
    Map<String, dynamic>? kpis,
    Map<String, dynamic>? trends,
    String? error,
  }) {
    return FinancialAnalyticsState(
      isLoading: isLoading ?? this.isLoading,
      dashboard: dashboard ?? this.dashboard,
      profitability: profitability ?? this.profitability,
      kpis: kpis ?? this.kpis,
      trends: trends ?? this.trends,
      error: error,
    );
  }
}

class FinancialAnalyticsViewModel
    extends Notifier<FinancialAnalyticsState> {
  late final FinancialIntelligenceRepository _repository;

  
  @override
  FinancialAnalyticsState build() {
    final apiMethod = ref.read(app_providers.apiMethodProvider);
    
    return FinancialAnalyticsState();
  }

  Future<void> getDashboard({
    required String organizationId,
    String period = '30d',
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.getFinancialDashboard(
        organizationId: organizationId,
        period: period,
      );

      if (result['success'] == true) {
        state =
            state.copyWith(isLoading: false, dashboard: result['dashboard']);
      } else {
        state = state.copyWith(isLoading: false, error: result['message']);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> analyzeProfitability({
    required String organizationId,
    required List<String> dimensions,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.analyzeProfitability(
        organizationId: organizationId,
        dimensions: dimensions,
      );

      if (result['success'] == true) {
        state =
            state.copyWith(isLoading: false, profitability: result['analysis']);
      } else {
        state = state.copyWith(isLoading: false, error: result['message']);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> getKPIs(String organizationId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result =
          await _repository.getFinancialKPIs(organizationId: organizationId);
      if (result['success'] == true) {
        state = state.copyWith(isLoading: false, kpis: result['kpis']);
      } else {
        state = state.copyWith(isLoading: false, error: result['message']);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> analyzeTrends({
    required String organizationId,
    required List<String> metrics,
    int period = 365,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.analyzeFinancialTrends(
        organizationId: organizationId,
        metrics: metrics,
        period: period,
      );

      if (result['success'] == true) {
        state = state.copyWith(isLoading: false, trends: result['trends']);
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

final financialAnalyticsViewModelProvider = NotifierProvider<FinancialAnalyticsViewModel, FinancialAnalyticsState>(FinancialAnalyticsViewModel.new);
