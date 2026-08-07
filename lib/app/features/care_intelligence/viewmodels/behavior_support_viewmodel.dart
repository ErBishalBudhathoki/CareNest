import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/care_intelligence/repositories/care_intelligence_repository.dart';
import 'package:carenest/app/features/care_intelligence/viewmodels/intelligence_viewmodel.dart';

// State class for Behavior Support
class BehaviorSupportState {
  late final bool isLoading;
  final Map<String, dynamic>? behaviorAnalysis;
  final Map<String, dynamic>? triggers;
  final Map<String, dynamic>? strategies;
  final Map<String, dynamic>? escalationPrediction;
  late final String? error;

  BehaviorSupportState({
    this.isLoading = false,
    this.behaviorAnalysis,
    this.triggers,
    this.strategies,
    this.escalationPrediction,
    this.error,
  });

  BehaviorSupportState copyWith({
    bool? isLoading,
    Map<String, dynamic>? behaviorAnalysis,
    Map<String, dynamic>? triggers,
    Map<String, dynamic>? strategies,
    Map<String, dynamic>? escalationPrediction,
    String? error,
  }) {
    return BehaviorSupportState(
      isLoading: isLoading ?? this.isLoading,
      behaviorAnalysis: behaviorAnalysis ?? this.behaviorAnalysis,
      triggers: triggers ?? this.triggers,
      strategies: strategies ?? this.strategies,
      escalationPrediction: escalationPrediction ?? this.escalationPrediction,
      error: error,
    );
  }
}

// StateNotifier for Behavior Support
class BehaviorSupportViewModel extends Notifier<BehaviorSupportState> {
  late final CareIntelligenceRepository _repository;

  @override
  BehaviorSupportState build() {
    final repository = ref.watch(careIntelligenceRepositoryProvider);

    return BehaviorSupportState();
  }

  // Analyze behavior patterns (uses care patterns analysis)
  Future<void> analyzeBehaviorPatterns({
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
          behaviorAnalysis: {'patterns': patterns},
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
          escalationPrediction: {'prediction': result['behaviorPrediction']},
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
    state = BehaviorSupportState();
  }
}

// Provider for BehaviorSupportViewModel
final behaviorSupportViewModelProvider =
    NotifierProvider<BehaviorSupportViewModel, BehaviorSupportState>(
      BehaviorSupportViewModel.new,
    );
