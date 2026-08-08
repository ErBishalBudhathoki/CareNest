import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import '../models/dashboard_models.dart';
import 'package:flutter/foundation.dart' show debugPrint;

class DashboardViewModel extends Notifier<DashboardState> {
  late final ApiMethod _apiMethod;
  late final String _organizationId;

  @override
  DashboardState build() {
    _apiMethod = ref.watch(app_providers.apiMethodProvider);
    Future.microtask(() => loadDashboardData());
    return DashboardState.initial();
  }

  /// Load all dashboard data
  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Fetch all data in parallel
      final results = await Future.wait([
        _fetchTodaySummary(),
        _fetchWorkerLocations(),
        _fetchQuickActions(),
        _fetchComplianceAlerts(),
        _fetchRevenueComparison(),
      ]);

      state = DashboardState(
        todaySummary: results[0] as TodaySummary?,
        workerLocations: results[1] as List<WorkerLocation>?,
        quickActions: results[2] as List<QuickAction>?,
        complianceAlerts: results[3] as List<ComplianceAlert>?,
        revenueComparison: results[4] as RevenueComparison?,
        isLoading: false,
        lastRefreshed: DateTime.now(),
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Refresh dashboard data
  Future<void> refresh() async {
    await loadDashboardData();
  }

  /// Fetch today's summary
  Future<TodaySummary?> _fetchTodaySummary() async {
    try {
      final response = await _apiMethod.get(
        'api/dashboard/today-summary?organizationId=$_organizationId',
      );

      if (response['success'] == true && response['data'] != null) {
        return TodaySummary.fromJson(response['data']);
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching today summary: $e');
      return null;
    }
  }

  /// Fetch worker locations
  Future<List<WorkerLocation>?> _fetchWorkerLocations() async {
    try {
      final response = await _apiMethod.get(
        'api/dashboard/worker-locations?organizationId=$_organizationId',
      );

      if (response['success'] == true && response['data'] != null) {
        return (response['data'] as List)
            .map((e) => WorkerLocation.fromJson(e))
            .toList();
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching worker locations: $e');
      return null;
    }
  }

  /// Fetch quick actions
  Future<List<QuickAction>?> _fetchQuickActions() async {
    try {
      final response = await _apiMethod.get(
        'api/dashboard/quick-actions?organizationId=$_organizationId',
      );

      if (response['success'] == true && response['data'] != null) {
        return (response['data'] as List)
            .map((e) => QuickAction.fromJson(e))
            .toList();
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching quick actions: $e');
      return null;
    }
  }

  /// Fetch compliance alerts
  Future<List<ComplianceAlert>?> _fetchComplianceAlerts() async {
    try {
      final response = await _apiMethod.get(
        'api/dashboard/compliance-alerts?organizationId=$_organizationId',
      );

      if (response['success'] == true && response['data'] != null) {
        return (response['data'] as List)
            .map((e) => ComplianceAlert.fromJson(e))
            .toList();
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching compliance alerts: $e');
      return null;
    }
  }

  /// Fetch revenue comparison
  Future<RevenueComparison?> _fetchRevenueComparison() async {
    try {
      final response = await _apiMethod.get(
        'api/dashboard/revenue-comparison?organizationId=$_organizationId',
      );

      if (response['success'] == true && response['data'] != null) {
        return RevenueComparison.fromJson(response['data']);
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching revenue comparison: $e');
      return null;
    }
  }
}

final dashboardViewModelProvider =
    NotifierProvider<DashboardViewModel, DashboardState>(
      DashboardViewModel.new,
    );
