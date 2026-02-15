import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/care_intelligence/models/care_intelligence_models.dart' hide Provider;
import 'package:carenest/app/features/care_intelligence/repositories/care_intelligence_repository.dart';
import 'package:carenest/app/features/care_intelligence/viewmodels/intelligence_viewmodel.dart';

// State class for Medication Management
class MedicationState {
  final bool isLoading;
  final List<DrugInteraction> interactions;
  final double? safetyScore;
  final MedicationCompliance? compliance;
  final List<MedicationAlert> alerts;
  final Map<String, dynamic>? schedule;
  final Map<String, dynamic>? sideEffectMonitoring;
  final String? error;

  MedicationState({
    this.isLoading = false,
    this.interactions = const [],
    this.safetyScore,
    this.compliance,
    this.alerts = const [],
    this.schedule,
    this.sideEffectMonitoring,
    this.error,
  });

  MedicationState copyWith({
    bool? isLoading,
    List<DrugInteraction>? interactions,
    double? safetyScore,
    MedicationCompliance? compliance,
    List<MedicationAlert>? alerts,
    Map<String, dynamic>? schedule,
    Map<String, dynamic>? sideEffectMonitoring,
    String? error,
  }) {
    return MedicationState(
      isLoading: isLoading ?? this.isLoading,
      interactions: interactions ?? this.interactions,
      safetyScore: safetyScore ?? this.safetyScore,
      compliance: compliance ?? this.compliance,
      alerts: alerts ?? this.alerts,
      schedule: schedule ?? this.schedule,
      sideEffectMonitoring: sideEffectMonitoring ?? this.sideEffectMonitoring,
      error: error,
    );
  }
}

// StateNotifier for Medication Management
class MedicationViewModel extends StateNotifier<MedicationState> {
  final CareIntelligenceRepository _repository;

  MedicationViewModel(this._repository) : super(MedicationState());

  // Check medication interactions
  Future<void> checkMedicationInteractions({
    required String clientId,
    required String organizationId,
    required List<String> medications,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.checkMedicationInteractions(
        clientId: clientId,
        organizationId: organizationId,
        medications: medications,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          interactions: result['interactions'] as List<DrugInteraction>,
          safetyScore: result['safetyScore'] as double?,
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

  // Track medication compliance
  Future<void> trackMedicationCompliance({
    required String clientId,
    required String organizationId,
    String? startDate,
    String? endDate,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.trackMedicationCompliance(
        clientId: clientId,
        organizationId: organizationId,
        startDate: startDate,
        endDate: endDate,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          compliance: result['compliance'] as MedicationCompliance?,
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

  // Get medication alerts
  Future<void> getMedicationAlerts({
    required String clientId,
    required String organizationId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.getMedicationAlerts(
        clientId: clientId,
        organizationId: organizationId,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          alerts: result['alerts'] as List<MedicationAlert>,
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

  // Optimize medication schedule
  Future<void> optimizeMedicationSchedule({
    required String clientId,
    required String organizationId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.optimizeMedicationSchedule(
        clientId: clientId,
        organizationId: organizationId,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          schedule: result['schedule'] as Map<String, dynamic>?,
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

  // Monitor medication side effects
  Future<void> monitorMedicationSideEffects({
    required String clientId,
    required String organizationId,
    required Map<String, dynamic> sideEffectData,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.monitorMedicationSideEffects(
        clientId: clientId,
        organizationId: organizationId,
        sideEffectData: sideEffectData,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          sideEffectMonitoring: result['monitoring'] as Map<String, dynamic>?,
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
    state = MedicationState();
  }
}

// Provider for MedicationViewModel
final medicationViewModelProvider =
    StateNotifierProvider<MedicationViewModel, MedicationState>((ref) {
  final repository = ref.watch(careIntelligenceRepositoryProvider);
  return MedicationViewModel(repository);
});
