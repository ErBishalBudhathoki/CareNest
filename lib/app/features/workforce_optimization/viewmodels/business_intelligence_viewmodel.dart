import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/workforce_optimization/models/workforce_models.dart';
import 'package:carenest/app/features/workforce_optimization/repositories/workforce_repository.dart';
import 'package:carenest/app/features/workforce_optimization/viewmodels/workforce_planning_viewmodel.dart';

// State class for Business Intelligence
class BusinessIntelligenceState {
  final bool isLoading;
  final ExecutiveDashboard? dashboard;
  final List<RevenueForecast> revenueForecast;
  final List<ChurnPrediction> churnPredictions;
  final List<ProfitabilityAnalysis> profitabilityAnalysis;
  final WhatIfScenario? whatIfScenario;
  final List<CustomerLifetimeValue> clvAnalysis;
  final String? error;

  BusinessIntelligenceState({
    this.isLoading = false,
    this.dashboard,
    this.revenueForecast = const [],
    this.churnPredictions = const [],
    this.profitabilityAnalysis = const [],
    this.whatIfScenario,
    this.clvAnalysis = const [],
    this.error,
  });

  BusinessIntelligenceState copyWith({
    bool? isLoading,
    ExecutiveDashboard? dashboard,
    List<RevenueForecast>? revenueForecast,
    List<ChurnPrediction>? churnPredictions,
    List<ProfitabilityAnalysis>? profitabilityAnalysis,
    WhatIfScenario? whatIfScenario,
    List<CustomerLifetimeValue>? clvAnalysis,
    String? error,
  }) {
    return BusinessIntelligenceState(
      isLoading: isLoading ?? this.isLoading,
      dashboard: dashboard ?? this.dashboard,
      revenueForecast: revenueForecast ?? this.revenueForecast,
      churnPredictions: churnPredictions ?? this.churnPredictions,
      profitabilityAnalysis: profitabilityAnalysis ?? this.profitabilityAnalysis,
      whatIfScenario: whatIfScenario ?? this.whatIfScenario,
      clvAnalysis: clvAnalysis ?? this.clvAnalysis,
      error: error,
    );
  }
}

// StateNotifier for Business Intelligence
class BusinessIntelligenceViewModel extends StateNotifier<BusinessIntelligenceState> {
  final WorkforceRepository _repository;

  BusinessIntelligenceViewModel(this._repository) : super(BusinessIntelligenceState());

  // Get executive dashboard
  Future<void> getExecutiveDashboard({
    required String organizationId,
    String period = 'month',
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.getExecutiveDashboard(
        organizationId: organizationId,
        period: period,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          dashboard: result['dashboard'] as ExecutiveDashboard?,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result['message'] as String?,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Forecast revenue
  Future<void> forecastRevenue({
    required String organizationId,
    int horizon = 12,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.forecastRevenue(
        organizationId: organizationId,
        horizon: horizon,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          revenueForecast: result['forecast'] as List<RevenueForecast>,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result['message'] as String?,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Predict churn
  Future<void> predictChurn({
    required String organizationId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.predictChurn(
        organizationId: organizationId,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          churnPredictions: result['predictions'] as List<ChurnPrediction>,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result['message'] as String?,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Analyze profitability
  Future<void> analyzeProfitability({
    required String organizationId,
    String dimension = 'service',
    required String startDate,
    required String endDate,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.analyzeProfitability(
        organizationId: organizationId,
        dimension: dimension,
        startDate: startDate,
        endDate: endDate,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          profitabilityAnalysis: result['analysis'] as List<ProfitabilityAnalysis>,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result['message'] as String?,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Analyze what-if scenario
  Future<void> analyzeWhatIfScenario({
    required String organizationId,
    required Map<String, dynamic> scenario,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.analyzeWhatIfScenario(
        organizationId: organizationId,
        scenario: scenario,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          whatIfScenario: result['scenario'] as WhatIfScenario?,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result['message'] as String?,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Calculate customer lifetime value
  Future<void> calculateCustomerLifetimeValue({
    required String organizationId,
    String? clientId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.calculateCustomerLifetimeValue(
        organizationId: organizationId,
        clientId: clientId,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          clvAnalysis: result['clvAnalysis'] as List<CustomerLifetimeValue>,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result['message'] as String?,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }

  // Reset state
  void reset() {
    state = BusinessIntelligenceState();
  }
}

// Provider for BusinessIntelligenceViewModel
final businessIntelligenceViewModelProvider =
    StateNotifierProvider<BusinessIntelligenceViewModel, BusinessIntelligenceState>((ref) {
  final repository = ref.watch(workforceRepositoryProvider);
  return BusinessIntelligenceViewModel(repository);
});
