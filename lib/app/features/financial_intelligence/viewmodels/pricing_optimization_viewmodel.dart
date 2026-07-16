import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import '../repositories/financial_intelligence_repository.dart';

/// Pricing Optimization State
class PricingOptimizationState {
  final bool isLoading;
  final Map<String, dynamic>? optimizations;
  final Map<String, dynamic>? recommendations;
  final Map<String, dynamic>? margins;
  final Map<String, dynamic>? elasticity;
  final String? error;

  PricingOptimizationState({
    this.isLoading = false,
    this.optimizations,
    this.recommendations,
    this.margins,
    this.elasticity,
    this.error,
  });

  PricingOptimizationState copyWith({
    bool? isLoading,
    Map<String, dynamic>? optimizations,
    Map<String, dynamic>? recommendations,
    Map<String, dynamic>? margins,
    Map<String, dynamic>? elasticity,
    String? error,
  }) {
    return PricingOptimizationState(
      isLoading: isLoading ?? this.isLoading,
      optimizations: optimizations ?? this.optimizations,
      recommendations: recommendations ?? this.recommendations,
      margins: margins ?? this.margins,
      elasticity: elasticity ?? this.elasticity,
      error: error,
    );
  }
}

/// Pricing Optimization ViewModel
class PricingOptimizationViewModel
    extends Notifier<PricingOptimizationState> {
  late final FinancialIntelligenceRepository _repository;

  @override
  PricingOptimizationState build() {
    final apiMethod = ref.read(app_providers.apiMethodProvider);
    _repository = FinancialIntelligenceRepository(apiMethod);
    return PricingOptimizationState();
  }

  /// Optimize prices
  Future<void> optimizePrices({
    required String organizationId,
    required List<Map<String, dynamic>> services,
    Map<String, dynamic>? constraints,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.optimizePrices(
        organizationId: organizationId,
        services: services,
        constraints: constraints,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          optimizations: result,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result['message'] ?? 'Failed to optimize prices',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Setup A/B test
  Future<void> setupABTest({
    required String organizationId,
    required Map<String, dynamic> testConfig,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.setupPricingABTest(
        organizationId: organizationId,
        testConfig: testConfig,
      );

      if (result['success'] == true) {
        state = state.copyWith(isLoading: false);
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result['message'] ?? 'Failed to setup A/B test',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Get pricing recommendations
  Future<void> getRecommendations({
    required String serviceId,
    Map<String, dynamic>? marketData,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.getPricingRecommendations(
        serviceId: serviceId,
        marketData: marketData,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          recommendations: result['recommendations'],
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result['message'] ?? 'Failed to get recommendations',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Analyze margins
  Future<void> analyzeMargins({
    required String organizationId,
    required List<Map<String, dynamic>> services,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.analyzeMargins(
        organizationId: organizationId,
        services: services,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          margins: result['analysis'],
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result['message'] ?? 'Failed to analyze margins',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Calculate price elasticity
  Future<void> calculateElasticity({
    required String serviceId,
    List<Map<String, dynamic>>? historicalData,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.calculatePriceElasticity(
        serviceId: serviceId,
        historicalData: historicalData,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          elasticity: result['elasticity'],
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result['message'] ?? 'Failed to calculate elasticity',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// Provider for Pricing Optimization ViewModel
final pricingOptimizationViewModelProvider = NotifierProvider<PricingOptimizationViewModel, PricingOptimizationState>(PricingOptimizationViewModel.new);
