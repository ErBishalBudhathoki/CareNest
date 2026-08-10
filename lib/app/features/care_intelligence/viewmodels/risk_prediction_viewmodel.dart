import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/care_intelligence/models/care_intelligence_models.dart'
    hide Provider;
import 'package:carenest/app/features/care_intelligence/repositories/care_intelligence_repository.dart';

// State class for Risk Prediction
class RiskPredictionState {
  late final bool isLoading;
  late final RiskAssessment? assessment;
  late final FallsRiskAssessment? fallsRisk;
  late final BehaviorEscalationPrediction? behaviorPrediction;
  final Map<String, dynamic>? healthPrediction;
  final Map<String, dynamic>? medicationRisk;
  final Map<String, dynamic>? trends;
  late final String? error;

  RiskPredictionState({
    this.isLoading = false,
    this.assessment,
    this.fallsRisk,
    this.behaviorPrediction,
    this.healthPrediction,
    this.medicationRisk,
    this.trends,
    this.error,
  });

  RiskPredictionState copyWith({
    bool? isLoading,
    RiskAssessment? assessment,
    FallsRiskAssessment? fallsRisk,
    BehaviorEscalationPrediction? behaviorPrediction,
    Map<String, dynamic>? healthPrediction,
    Map<String, dynamic>? medicationRisk,
    Map<String, dynamic>? trends,
    String? error,
  }) {
    return RiskPredictionState(
      isLoading: isLoading ?? this.isLoading,
      assessment: assessment ?? this.assessment,
      fallsRisk: fallsRisk ?? this.fallsRisk,
      behaviorPrediction: behaviorPrediction ?? this.behaviorPrediction,
      healthPrediction: healthPrediction ?? this.healthPrediction,
      medicationRisk: medicationRisk ?? this.medicationRisk,
      trends: trends ?? this.trends,
      error: error,
    );
  }
}

// StateNotifier for Risk Prediction
class RiskPredictionViewModel extends Notifier<RiskPredictionState> {
  late final CareIntelligenceRepository _repository;

  @override
  RiskPredictionState build() {

    return RiskPredictionState();
  }

  // Predict all risks
  Future<void> predictAllRisks({
    required String clientId,
    required String organizationId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.predictAllRisks(
        clientId: clientId,
        organizationId: organizationId,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          assessment: result['assessment'] as RiskAssessment?,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result['message'] as String?,
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Predict falls risk
  Future<void> predictFallsRisk({
    required String clientId,
    required String organizationId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.predictFallsRisk(
        clientId: clientId,
        organizationId: organizationId,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          fallsRisk: result['fallsRisk'] as FallsRiskAssessment?,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result['message'] as String?,
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Predict behavior escalation
  Future<void> predictBehaviorEscalation({
    required String clientId,
    required String organizationId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.predictBehaviorEscalation(
        clientId: clientId,
        organizationId: organizationId,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          behaviorPrediction:
              result['behaviorPrediction'] as BehaviorEscalationPrediction?,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result['message'] as String?,
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
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
          healthPrediction: result['healthPrediction'] as Map<String, dynamic>?,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result['message'] as String?,
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Predict medication risk
  Future<void> predictMedicationRisk({
    required String clientId,
    required String organizationId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.predictMedicationRisk(
        clientId: clientId,
        organizationId: organizationId,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          medicationRisk: result['medicationRisk'] as Map<String, dynamic>?,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result['message'] as String?,
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Analyze risk trends
  Future<void> analyzeRiskTrends({
    required String clientId,
    required String organizationId,
    String? startDate,
    String? endDate,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.analyzeRiskTrends(
        clientId: clientId,
        organizationId: organizationId,
        startDate: startDate,
        endDate: endDate,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          trends: result['trends'] as Map<String, dynamic>?,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result['message'] as String?,
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }

  // Reset state
  void reset() {
    state = RiskPredictionState();
  }
}

// Provider for RiskPredictionViewModel
final riskPredictionViewModelProvider =
    NotifierProvider<RiskPredictionViewModel, RiskPredictionState>(
      RiskPredictionViewModel.new,
    );
