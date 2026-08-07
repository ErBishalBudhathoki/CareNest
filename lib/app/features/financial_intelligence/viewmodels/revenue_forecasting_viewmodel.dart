import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import '../repositories/financial_intelligence_repository.dart';

/// Revenue Forecasting State
class RevenueForecastingState {
  late final bool isLoading;
  final Map<String, dynamic>? forecast;
  final Map<String, dynamic>? drivers;
  final Map<String, dynamic>? scenarios;
  final Map<String, dynamic>? trends;
  late final String? error;

  RevenueForecastingState({
    this.isLoading = false,
    this.forecast,
    this.drivers,
    this.scenarios,
    this.trends,
    this.error,
  });

  RevenueForecastingState copyWith({
    bool? isLoading,
    Map<String, dynamic>? forecast,
    Map<String, dynamic>? drivers,
    Map<String, dynamic>? scenarios,
    Map<String, dynamic>? trends,
    String? error,
  }) {
    return RevenueForecastingState(
      isLoading: isLoading ?? this.isLoading,
      forecast: forecast ?? this.forecast,
      drivers: drivers ?? this.drivers,
      scenarios: scenarios ?? this.scenarios,
      trends: trends ?? this.trends,
      error: error,
    );
  }
}

/// Revenue Forecasting ViewModel
class RevenueForecastingViewModel extends Notifier<RevenueForecastingState> {
  late final FinancialIntelligenceRepository _repository;

  @override
  RevenueForecastingState build() {
    final apiMethod = ref.read(app_providers.apiMethodProvider);

    return RevenueForecastingState();
  }

  /// Generate revenue forecast
  Future<void> generateForecast({
    required String organizationId,
    int horizon = 90,
    Map<String, dynamic>? options,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.generateRevenueForecast(
        organizationId: organizationId,
        horizon: horizon,
        options: options,
      );

      if (result['success'] == true) {
        state = state.copyWith(isLoading: false, forecast: result['forecast']);
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result['message'] ?? 'Failed to generate forecast',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Analyze revenue drivers
  Future<void> analyzeDrivers({
    required String organizationId,
    int period = 90,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.analyzeRevenueDrivers(
        organizationId: organizationId,
        period: period,
      );

      if (result['success'] == true) {
        state = state.copyWith(isLoading: false, drivers: result['drivers']);
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result['message'] ?? 'Failed to analyze drivers',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Generate scenarios
  Future<void> generateScenarios({
    required String organizationId,
    int horizon = 90,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.generateRevenueScenarios(
        organizationId: organizationId,
        horizon: horizon,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          scenarios: result['scenarios'],
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result['message'] ?? 'Failed to generate scenarios',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Perform what-if analysis
  Future<void> performWhatIfAnalysis({
    required String organizationId,
    required Map<String, dynamic> changes,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.performWhatIfAnalysis(
        organizationId: organizationId,
        changes: changes,
      );

      if (result['success'] == true) {
        state = state.copyWith(isLoading: false);
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result['message'] ?? 'Failed to perform analysis',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Get revenue trends
  Future<void> getTrends({
    required String organizationId,
    int period = 365,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.getRevenueTrends(
        organizationId: organizationId,
        period: period,
      );

      if (result['success'] == true) {
        state = state.copyWith(isLoading: false, trends: result['trends']);
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result['message'] ?? 'Failed to get trends',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Update ML models
  Future<void> updateModels({
    required String organizationId,
    List<Map<String, dynamic>>? trainingData,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.updateRevenueModels(
        organizationId: organizationId,
        trainingData: trainingData,
      );

      if (result['success'] == true) {
        state = state.copyWith(isLoading: false);
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result['message'] ?? 'Failed to update models',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// Provider for Revenue Forecasting ViewModel
final revenueForecastingViewModelProvider =
    NotifierProvider<RevenueForecastingViewModel, RevenueForecastingState>(
      RevenueForecastingViewModel.new,
    );
