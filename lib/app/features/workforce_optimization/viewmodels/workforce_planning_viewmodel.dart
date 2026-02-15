import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/workforce_optimization/models/workforce_models.dart';
import 'package:carenest/app/features/workforce_optimization/repositories/workforce_repository.dart';
import 'package:carenest/backend/api_method.dart';

// Provider for WorkforceRepository
final workforceRepositoryProvider = Provider<WorkforceRepository>((ref) {
  return WorkforceRepository(ApiMethod());
});

// State class for Workforce Planning
class WorkforcePlanningState {
  final bool isLoading;
  final List<DemandForecast> forecast;
  final ForecastConfidence? confidence;
  final WorkforcePlan? optimization;
  final List<SkillGap> skillGaps;
  final List<TurnoverPrediction> turnoverPredictions;
  final List<ScenarioAnalysis> scenarios;
  final String? error;

  WorkforcePlanningState({
    this.isLoading = false,
    this.forecast = const [],
    this.confidence,
    this.optimization,
    this.skillGaps = const [],
    this.turnoverPredictions = const [],
    this.scenarios = const [],
    this.error,
  });

  WorkforcePlanningState copyWith({
    bool? isLoading,
    List<DemandForecast>? forecast,
    ForecastConfidence? confidence,
    WorkforcePlan? optimization,
    List<SkillGap>? skillGaps,
    List<TurnoverPrediction>? turnoverPredictions,
    List<ScenarioAnalysis>? scenarios,
    String? error,
  }) {
    return WorkforcePlanningState(
      isLoading: isLoading ?? this.isLoading,
      forecast: forecast ?? this.forecast,
      confidence: confidence ?? this.confidence,
      optimization: optimization ?? this.optimization,
      skillGaps: skillGaps ?? this.skillGaps,
      turnoverPredictions: turnoverPredictions ?? this.turnoverPredictions,
      scenarios: scenarios ?? this.scenarios,
      error: error,
    );
  }
}

// StateNotifier for Workforce Planning
class WorkforcePlanningViewModel extends StateNotifier<WorkforcePlanningState> {
  final WorkforceRepository _repository;

  WorkforcePlanningViewModel(this._repository) : super(WorkforcePlanningState());

  // Forecast demand
  Future<void> forecastDemand({
    required String organizationId,
    required String startDate,
    required String endDate,
    int horizon = 30,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.forecastDemand(
        organizationId: organizationId,
        startDate: startDate,
        endDate: endDate,
        horizon: horizon,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          forecast: result['forecast'] as List<DemandForecast>,
          confidence: result['confidence'] as ForecastConfidence?,
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

  // Optimize staffing
  Future<void> optimizeStaffing({
    required String organizationId,
    required List<Map<String, dynamic>> forecastData,
    required Map<String, dynamic> constraints,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.optimizeStaffing(
        organizationId: organizationId,
        forecastData: forecastData,
        constraints: constraints,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          optimization: result['optimization'] as WorkforcePlan?,
          skillGaps: result['skillGaps'] as List<SkillGap>,
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

  // Predict turnover
  Future<void> predictTurnover({
    required String organizationId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.predictTurnover(
        organizationId: organizationId,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          turnoverPredictions: result['predictions'] as List<TurnoverPrediction>,
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

  // Analyze scenarios
  Future<void> analyzeScenarios({
    required String organizationId,
    required List<Map<String, dynamic>> scenarios,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.analyzeScenarios(
        organizationId: organizationId,
        scenarios: scenarios,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          scenarios: result['scenarios'] as List<ScenarioAnalysis>,
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
    state = WorkforcePlanningState();
  }
}

// Provider for WorkforcePlanningViewModel
final workforcePlanningViewModelProvider =
    StateNotifierProvider<WorkforcePlanningViewModel, WorkforcePlanningState>((ref) {
  final repository = ref.watch(workforceRepositoryProvider);
  return WorkforcePlanningViewModel(repository);
});
