import 'package:carenest/app/features/analytics/models/analytics_models.dart';
import 'package:carenest/app/features/analytics/repositories/analytics_repository.dart';
import 'package:carenest/app/features/auth/providers/user_provider.dart';
import 'package:carenest/app/features/auth/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// State class to hold all predictions
class PredictiveInsightsState {
  final List<ForecastMetric> revenueForecast;
  final List<ChurnPrediction> churnPredictions;
  final List<DemandForecast> demandForecast;
  final ComplianceRisk? complianceRisk;
  final List<ClientRisk> clientRisks; // NEW Phase 5
  final ServiceDemandResult? serviceDemand; // NEW Phase 5
  final List<AIRecommendation> recommendations; // NEW Phase 5
  final ScenarioResult? scenarioResult; // NEW Phase 5
  final bool isLoading;
  final String? error;

  PredictiveInsightsState({
    this.revenueForecast = const [],
    this.churnPredictions = const [],
    this.demandForecast = const [],
    this.complianceRisk,
    this.clientRisks = const [], // NEW Phase 5
    this.serviceDemand, // NEW Phase 5
    this.recommendations = const [], // NEW Phase 5
    this.scenarioResult, // NEW Phase 5
    this.isLoading = false,
    this.error,
  });

  PredictiveInsightsState copyWith({
    List<ForecastMetric>? revenueForecast,
    List<ChurnPrediction>? churnPredictions,
    List<DemandForecast>? demandForecast,
    ComplianceRisk? complianceRisk,
    List<ClientRisk>? clientRisks, // NEW Phase 5
    ServiceDemandResult? serviceDemand, // NEW Phase 5
    List<AIRecommendation>? recommendations, // NEW Phase 5
    ScenarioResult? scenarioResult, // NEW Phase 5
    bool? isLoading,
    String? error,
  }) {
    return PredictiveInsightsState(
      revenueForecast: revenueForecast ?? this.revenueForecast,
      churnPredictions: churnPredictions ?? this.churnPredictions,
      demandForecast: demandForecast ?? this.demandForecast,
      complianceRisk: complianceRisk ?? this.complianceRisk,
      clientRisks: clientRisks ?? this.clientRisks, // NEW Phase 5
      serviceDemand: serviceDemand ?? this.serviceDemand, // NEW Phase 5
      recommendations: recommendations ?? this.recommendations, // NEW Phase 5
      scenarioResult: scenarioResult ?? this.scenarioResult, // NEW Phase 5
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

final predictiveInsightsViewModelProvider =
    NotifierProvider<PredictiveInsightsViewModel, PredictiveInsightsState>(
      PredictiveInsightsViewModel.new,
    );

class PredictiveInsightsViewModel extends Notifier<PredictiveInsightsState> {
  late final AnalyticsRepository _repository;
  User? _user;

  @override
  PredictiveInsightsState build() {
    _repository = ref.watch(analyticsRepositoryProvider);
    final userAsync = ref.watch(currentUserProvider);
    _user = userAsync.value;

    if (_user != null) {
      Future.microtask(() => fetchAllPredictions());
    }

    return PredictiveInsightsState(
      isLoading: userAsync.isLoading,
      error: userAsync.error?.toString(),
    );
  }

  // Fetch all predictions at once
  Future<void> fetchAllPredictions() async {
    if (_user == null) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      // Fetch all predictions in parallel
      final results = await Future.wait([
        fetchRevenueForecast(),
        fetchChurnPredictions(),
        fetchDemandForecast(),
        fetchComplianceRisk(),
        fetchClientRisks(), // NEW Phase 5
        fetchServiceDemand(), // NEW Phase 5
        fetchRecommendations(), // NEW Phase 5
      ]);

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> fetchRevenueForecast({
    String metric = 'revenue',
    int daysAhead = 30,
  }) async {
    if (_user == null) return;
    try {
      final result = await _repository.fetchForecast(
        organizationId: _user!.organizationId,
        metric: metric,
        daysAhead: daysAhead,
      );
      state = state.copyWith(revenueForecast: result);
    } catch (e) {
      state = state.copyWith(error: 'Failed to fetch revenue forecast: $e');
    }
  }

  Future<void> fetchChurnPredictions() async {
    if (_user == null) return;
    try {
      final result = await _repository.fetchChurnPredictions(
        organizationId: _user!.organizationId,
      );
      state = state.copyWith(churnPredictions: result);
    } catch (e) {
      state = state.copyWith(error: 'Failed to fetch churn predictions: $e');
    }
  }

  Future<void> fetchDemandForecast({int daysAhead = 7}) async {
    if (_user == null) return;
    try {
      final result = await _repository.fetchDemandForecast(
        organizationId: _user!.organizationId,
        daysAhead: daysAhead,
      );
      state = state.copyWith(demandForecast: result);
    } catch (e) {
      state = state.copyWith(error: 'Failed to fetch demand forecast: $e');
    }
  }

  Future<void> fetchComplianceRisk() async {
    if (_user == null) return;
    try {
      final result = await _repository.fetchComplianceRisk(
        organizationId: _user!.organizationId,
      );
      state = state.copyWith(complianceRisk: result);
    } catch (e) {
      state = state.copyWith(error: 'Failed to fetch compliance risk: $e');
    }
  }

  // NEW Phase 5: Fetch client risk predictions
  Future<void> fetchClientRisks() async {
    if (_user == null) return;
    try {
      final result = await _repository.fetchClientRisk(
        organizationId: _user!.organizationId,
      );
      state = state.copyWith(clientRisks: result);
    } catch (e) {
      state = state.copyWith(error: 'Failed to fetch client risks: $e');
    }
  }

  // NEW Phase 5: Fetch service demand predictions
  Future<void> fetchServiceDemand({int daysAhead = 30}) async {
    if (_user == null) return;
    try {
      final result = await _repository.fetchServiceDemand(
        organizationId: _user!.organizationId,
        daysAhead: daysAhead,
      );
      state = state.copyWith(serviceDemand: result);
    } catch (e) {
      state = state.copyWith(error: 'Failed to fetch service demand: $e');
    }
  }

  // NEW Phase 5: Run scenario model
  Future<void> runScenario(Map<String, dynamic> scenario) async {
    if (_user == null) return;
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.runScenarioModel(
        organizationId: _user!.organizationId,
        scenario: scenario,
      );
      state = state.copyWith(isLoading: false, scenarioResult: result);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to run scenario: $e',
      );
    }
  }

  // NEW Phase 5: Fetch AI recommendations
  Future<void> fetchRecommendations() async {
    if (_user == null) return;
    try {
      final result = await _repository.fetchRecommendations(
        organizationId: _user!.organizationId,
      );
      state = state.copyWith(recommendations: result);
    } catch (e) {
      state = state.copyWith(error: 'Failed to fetch recommendations: $e');
    }
  }
}
