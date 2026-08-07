import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/care_intelligence/models/care_intelligence_models.dart'
    hide Provider;
import 'package:carenest/app/features/care_intelligence/repositories/care_intelligence_repository.dart';
import 'package:carenest/app/features/care_intelligence/viewmodels/intelligence_viewmodel.dart';

// State class for Care Plan
class CarePlanState {
  late final bool isLoading;
  late final CarePlan? carePlan;
  late final List<SmartGoal> goals;
  late final List<ServiceRecommendation> serviceRecommendations;
  final Map<String, dynamic>? progress;
  final Map<String, dynamic>? evidenceBasedRecommendations;
  late final String? error;

  CarePlanState({
    this.isLoading = false,
    this.carePlan,
    this.goals = const [],
    this.serviceRecommendations = const [],
    this.progress,
    this.evidenceBasedRecommendations,
    this.error,
  });

  CarePlanState copyWith({
    bool? isLoading,
    CarePlan? carePlan,
    List<SmartGoal>? goals,
    List<ServiceRecommendation>? serviceRecommendations,
    Map<String, dynamic>? progress,
    Map<String, dynamic>? evidenceBasedRecommendations,
    String? error,
  }) {
    return CarePlanState(
      isLoading: isLoading ?? this.isLoading,
      carePlan: carePlan ?? this.carePlan,
      goals: goals ?? this.goals,
      serviceRecommendations:
          serviceRecommendations ?? this.serviceRecommendations,
      progress: progress ?? this.progress,
      evidenceBasedRecommendations:
          evidenceBasedRecommendations ?? this.evidenceBasedRecommendations,
      error: error,
    );
  }
}

// StateNotifier for Care Plan
class CarePlanViewModel extends Notifier<CarePlanState> {
  late final CareIntelligenceRepository _repository;

  @override
  CarePlanState build() {
    final repository = ref.watch(careIntelligenceRepositoryProvider);

    return CarePlanState();
  }

  // Generate care plan
  Future<void> generateCarePlan({
    required String clientId,
    required String organizationId,
    Map<String, dynamic>? preferences,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.generateCarePlan(
        clientId: clientId,
        organizationId: organizationId,
        preferences: preferences,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          carePlan: result['carePlan'] as CarePlan?,
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

  // Generate SMART goals
  Future<void> generateSmartGoals({
    required String clientId,
    required String organizationId,
    List<String>? outcomeAreas,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.generateSmartGoals(
        clientId: clientId,
        organizationId: organizationId,
        outcomeAreas: outcomeAreas,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          goals: result['goals'] as List<SmartGoal>,
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

  // Recommend services
  Future<void> recommendServices({
    required String clientId,
    required String organizationId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.recommendServices(
        clientId: clientId,
        organizationId: organizationId,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          serviceRecommendations:
              result['recommendations'] as List<ServiceRecommendation>,
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

  // Adapt care plan
  Future<void> adaptCarePlan({
    required String planId,
    required String organizationId,
    required Map<String, dynamic> progressData,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.adaptCarePlan(
        planId: planId,
        organizationId: organizationId,
        progressData: progressData,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          carePlan: result['adaptedPlan'] as CarePlan?,
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

  // Track goal progress
  Future<void> trackGoalProgress({
    required String goalId,
    required String organizationId,
    required Map<String, dynamic> progressUpdate,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.trackGoalProgress(
        goalId: goalId,
        organizationId: organizationId,
        progressUpdate: progressUpdate,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          progress: result['progress'] as Map<String, dynamic>?,
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

  // Generate evidence-based recommendations
  Future<void> generateEvidenceBasedRecommendations({
    required String clientId,
    required String organizationId,
    String? condition,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.generateEvidenceBasedRecommendations(
        clientId: clientId,
        organizationId: organizationId,
        condition: condition,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          evidenceBasedRecommendations:
              result['recommendations'] as Map<String, dynamic>?,
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
    state = CarePlanState();
  }
}

// Provider for CarePlanViewModel
final carePlanViewModelProvider =
    NotifierProvider<CarePlanViewModel, CarePlanState>(CarePlanViewModel.new);
