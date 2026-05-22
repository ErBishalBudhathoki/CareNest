import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:carenest/app/features/workforce_optimization/models/workforce_models.dart';
import 'package:carenest/app/features/workforce_optimization/repositories/workforce_repository.dart';
import 'package:carenest/app/features/workforce_optimization/viewmodels/workforce_planning_viewmodel.dart';

// State class for Performance Analytics
class PerformanceAnalyticsState {
  final bool isLoading;
  final List<PerformanceAnalytics> analytics;
  final Map<String, dynamic>? trends;
  final Map<String, dynamic>? prediction;
  final List<SkillProficiency> skillProficiency;
  final String? error;

  PerformanceAnalyticsState({
    this.isLoading = false,
    this.analytics = const [],
    this.trends,
    this.prediction,
    this.skillProficiency = const [],
    this.error,
  });

  PerformanceAnalyticsState copyWith({
    bool? isLoading,
    List<PerformanceAnalytics>? analytics,
    Map<String, dynamic>? trends,
    Map<String, dynamic>? prediction,
    List<SkillProficiency>? skillProficiency,
    String? error,
  }) {
    return PerformanceAnalyticsState(
      isLoading: isLoading ?? this.isLoading,
      analytics: analytics ?? this.analytics,
      trends: trends ?? this.trends,
      prediction: prediction ?? this.prediction,
      skillProficiency: skillProficiency ?? this.skillProficiency,
      error: error,
    );
  }
}

// StateNotifier for Performance Analytics
class PerformanceAnalyticsViewModel extends StateNotifier<PerformanceAnalyticsState> {
  final WorkforceRepository _repository;

  PerformanceAnalyticsViewModel(this._repository) : super(PerformanceAnalyticsState());

  // Get performance analytics
  Future<void> getPerformanceAnalytics({
    required String organizationId,
    String? employeeId,
    required String startDate,
    required String endDate,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.getPerformanceAnalytics(
        organizationId: organizationId,
        employeeId: employeeId,
        startDate: startDate,
        endDate: endDate,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          analytics: result['analytics'] as List<PerformanceAnalytics>,
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

  // Analyze performance trends
  Future<void> analyzePerformanceTrends({
    required String employeeId,
    required String organizationId,
    String period = 'monthly',
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.analyzePerformanceTrends(
        employeeId: employeeId,
        organizationId: organizationId,
        period: period,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          trends: result,
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

  // Predict performance
  Future<void> predictPerformance({
    required String employeeId,
    required Map<String, dynamic> features,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.predictPerformance(
        employeeId: employeeId,
        features: features,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          prediction: result['prediction'] as Map<String, dynamic>?,
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

  // Track skill proficiency
  Future<void> trackSkillProficiency({
    required String employeeId,
    required String organizationId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.trackSkillProficiency(
        employeeId: employeeId,
        organizationId: organizationId,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          skillProficiency: result['proficiency'] as List<SkillProficiency>,
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
    state = PerformanceAnalyticsState();
  }
}

// Provider for PerformanceAnalyticsViewModel
final performanceAnalyticsViewModelProvider =
    StateNotifierProvider<PerformanceAnalyticsViewModel, PerformanceAnalyticsState>((ref) {
  final repository = ref.watch(workforceRepositoryProvider);
  return PerformanceAnalyticsViewModel(repository);
});
