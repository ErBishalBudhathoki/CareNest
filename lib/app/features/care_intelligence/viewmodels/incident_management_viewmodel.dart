import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/care_intelligence/models/care_intelligence_models.dart' hide Provider;
import 'package:carenest/app/features/care_intelligence/repositories/care_intelligence_repository.dart';
import 'package:carenest/app/features/care_intelligence/viewmodels/intelligence_viewmodel.dart';

// State class for Incident Management
class IncidentManagementState {
  final bool isLoading;
  final Incident? incident;
  final RootCauseAnalysis? rootCauseAnalysis;
  final IncidentPatternData? patterns;
  final Map<String, dynamic>? recurrencePrediction;
  final Map<String, dynamic>? correctiveActions;
  final String? error;

  IncidentManagementState({
    this.isLoading = false,
    this.incident,
    this.rootCauseAnalysis,
    this.patterns,
    this.recurrencePrediction,
    this.correctiveActions,
    this.error,
  });

  IncidentManagementState copyWith({
    bool? isLoading,
    Incident? incident,
    RootCauseAnalysis? rootCauseAnalysis,
    IncidentPatternData? patterns,
    Map<String, dynamic>? recurrencePrediction,
    Map<String, dynamic>? correctiveActions,
    String? error,
  }) {
    return IncidentManagementState(
      isLoading: isLoading ?? this.isLoading,
      incident: incident ?? this.incident,
      rootCauseAnalysis: rootCauseAnalysis ?? this.rootCauseAnalysis,
      patterns: patterns ?? this.patterns,
      recurrencePrediction: recurrencePrediction ?? this.recurrencePrediction,
      correctiveActions: correctiveActions ?? this.correctiveActions,
      error: error,
    );
  }
}

// StateNotifier for Incident Management
class IncidentManagementViewModel extends StateNotifier<IncidentManagementState> {
  final CareIntelligenceRepository _repository;

  IncidentManagementViewModel(this._repository) : super(IncidentManagementState());

  // Report incident
  Future<void> reportIncident({
    required String clientId,
    required String organizationId,
    required Map<String, dynamic> incidentData,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.reportIncident(
        clientId: clientId,
        organizationId: organizationId,
        incidentData: incidentData,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          incident: result['incident'] as Incident?,
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

  // Analyze root cause
  Future<void> analyzeRootCause({
    required String incidentId,
    required String organizationId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.analyzeRootCause(
        incidentId: incidentId,
        organizationId: organizationId,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          rootCauseAnalysis: result['analysis'] as RootCauseAnalysis?,
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

  // Detect incident patterns
  Future<void> detectIncidentPatterns({
    required String organizationId,
    String? startDate,
    String? endDate,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.detectIncidentPatterns(
        organizationId: organizationId,
        startDate: startDate,
        endDate: endDate,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          patterns: result['patterns'] as IncidentPatternData?,
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

  // Predict incident recurrence
  Future<void> predictIncidentRecurrence({
    required String incidentId,
    required String organizationId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.predictIncidentRecurrence(
        incidentId: incidentId,
        organizationId: organizationId,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          recurrencePrediction: result['prediction'] as Map<String, dynamic>?,
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

  // Generate corrective actions
  Future<void> generateCorrectiveActions({
    required String incidentId,
    required String organizationId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.generateCorrectiveActions(
        incidentId: incidentId,
        organizationId: organizationId,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          correctiveActions: result['actions'] as Map<String, dynamic>?,
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
    state = IncidentManagementState();
  }
}

// Provider for IncidentManagementViewModel
final incidentManagementViewModelProvider =
    StateNotifierProvider<IncidentManagementViewModel, IncidentManagementState>((ref) {
  final repository = ref.watch(careIntelligenceRepositoryProvider);
  return IncidentManagementViewModel(repository);
});
