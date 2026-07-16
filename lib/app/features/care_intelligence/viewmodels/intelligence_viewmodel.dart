import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/care_intelligence/models/care_intelligence_models.dart'
    hide Provider;
import 'package:carenest/app/features/care_intelligence/repositories/care_intelligence_repository.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;

// Provider for CareIntelligenceRepository
final careIntelligenceRepositoryProvider =
    Provider<CareIntelligenceRepository>((ref) {
  return CareIntelligenceRepository(ref.read(app_providers.apiMethodProvider));
});

// State class for Care Intelligence
class IntelligenceState {
  late final bool isLoading;
  late final IntelligenceReport? report;
  late final CarePatterns? patterns;
  final Map<String, dynamic>? predictions;
  final Map<String, dynamic>? optimization;
  final Map<String, dynamic>? insights;
  late final String? error;

  IntelligenceState({
    this.isLoading = false,
    this.report,
    this.patterns,
    this.predictions,
    this.optimization,
    this.insights,
    this.error,
  });

  IntelligenceState copyWith({
    bool? isLoading,
    IntelligenceReport? report,
    CarePatterns? patterns,
    Map<String, dynamic>? predictions,
    Map<String, dynamic>? optimization,
    Map<String, dynamic>? insights,
    String? error,
  }) {
    return IntelligenceState(
      isLoading: isLoading ?? this.isLoading,
      report: report ?? this.report,
      patterns: patterns ?? this.patterns,
      predictions: predictions ?? this.predictions,
      optimization: optimization ?? this.optimization,
      insights: insights ?? this.insights,
      error: error,
    );
  }
}

// StateNotifier for Care Intelligence
class IntelligenceViewModel extends Notifier<IntelligenceState> {
  late final CareIntelligenceRepository _repository;

  
  @override
  IntelligenceState build() {
    final repository = ref.watch(careIntelligenceRepositoryProvider);
    
    return IntelligenceState();
  }

  // Generate intelligence report
  Future<void> generateIntelligenceReport({
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
        state = state.copyWith(
          isLoading: false,
          report: result['report'] as IntelligenceReport?,
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

  // Analyze care patterns
  Future<void> analyzeCarePatterns({
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
        state = state.copyWith(
          isLoading: false,
          patterns: result['patterns'] as CarePatterns?,
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

  // Predict care needs
  Future<void> predictCareNeeds({
    required String clientId,
    required String organizationId,
    int horizon = 30,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.predictCareNeeds(
        clientId: clientId,
        organizationId: organizationId,
        horizon: horizon,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          predictions: result['predictions'] as Map<String, dynamic>?,
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

  // Optimize care delivery
  Future<void> optimizeCareDelivery({
    required String clientId,
    required String organizationId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.optimizeCareDelivery(
        clientId: clientId,
        organizationId: organizationId,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          optimization: result['optimization'] as Map<String, dynamic>?,
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

  // Generate personalized insights
  Future<void> generatePersonalizedInsights({
    required String clientId,
    required String organizationId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.generatePersonalizedInsights(
        clientId: clientId,
        organizationId: organizationId,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          insights: result['insights'] as Map<String, dynamic>?,
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
    state = IntelligenceState();
  }
}

// Provider for IntelligenceViewModel
final intelligenceViewModelProvider = NotifierProvider<IntelligenceViewModel, IntelligenceState>(IntelligenceViewModel.new);
