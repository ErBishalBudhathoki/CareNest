import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:carenest/app/features/care_intelligence/repositories/care_intelligence_repository.dart';
import 'package:carenest/app/features/care_intelligence/viewmodels/intelligence_viewmodel.dart';

// State class for Health Monitoring
class HealthMonitoringState {
  final bool isLoading;
  final Map<String, dynamic>? healthTrends;
  final Map<String, dynamic>? vitalSigns;
  final Map<String, dynamic>? deteriorationPrediction;
  final Map<String, dynamic>? alerts;
  final String? error;

  HealthMonitoringState({
    this.isLoading = false,
    this.healthTrends,
    this.vitalSigns,
    this.deteriorationPrediction,
    this.alerts,
    this.error,
  });

  HealthMonitoringState copyWith({
    bool? isLoading,
    Map<String, dynamic>? healthTrends,
    Map<String, dynamic>? vitalSigns,
    Map<String, dynamic>? deteriorationPrediction,
    Map<String, dynamic>? alerts,
    String? error,
  }) {
    return HealthMonitoringState(
      isLoading: isLoading ?? this.isLoading,
      healthTrends: healthTrends ?? this.healthTrends,
      vitalSigns: vitalSigns ?? this.vitalSigns,
      deteriorationPrediction: deteriorationPrediction ?? this.deteriorationPrediction,
      alerts: alerts ?? this.alerts,
      error: error,
    );
  }
}

// StateNotifier for Health Monitoring
class HealthMonitoringViewModel extends StateNotifier<HealthMonitoringState> {
  final CareIntelligenceRepository _repository;

  HealthMonitoringViewModel(this._repository) : super(HealthMonitoringState());

  // Analyze health trends (uses care patterns analysis)
  Future<void> analyzeHealthTrends({
    required String clientId,
    required String organizationId,
    String? startDate,
    String? endDate,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.analyzeCarePatterns(
        clientId: clientId,
        organizationId: organizationId,
        startDate: startDate,
        endDate: endDate,
      );

      if (result['success'] == true) {
        final patterns = result['patterns'];
        state = state.copyWith(
          isLoading: false,
          healthTrends: {
            'patterns': patterns,
          },
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

  // Predict health deterioration
  Future<void> predictHealthDeterioration({
    required String clientId,
    required String organizationId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.predictHealthDeterioration(
        clientId: clientId,
        organizationId: organizationId,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          deteriorationPrediction: result['healthPrediction'] as Map<String, dynamic>?,
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

  // Get health alerts (uses intelligence report)
  Future<void> getHealthAlerts({
    required String clientId,
    required String organizationId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.generateIntelligenceReport(
        clientId: clientId,
        organizationId: organizationId,
      );

      if (result['success'] == true) {
        final report = result['report'];
        state = state.copyWith(
          isLoading: false,
          alerts: {
            'report': report,
          },
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
    state = HealthMonitoringState();
  }
}

// Provider for HealthMonitoringViewModel
final healthMonitoringViewModelProvider =
    StateNotifierProvider<HealthMonitoringViewModel, HealthMonitoringState>((ref) {
  final repository = ref.watch(careIntelligenceRepositoryProvider);
  return HealthMonitoringViewModel(repository);
});
