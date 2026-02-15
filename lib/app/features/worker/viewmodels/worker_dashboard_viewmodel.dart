import 'package:carenest/app/features/worker/models/worker_dashboard_data.dart';
import 'package:carenest/app/features/worker/repositories/worker_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Worker Dashboard ViewModel Provider
///
/// Manages the state of the worker dashboard using Riverpod 2.x StateNotifier pattern
///
/// States handled:
/// - Loading: Initial load or refresh in progress
/// - Data: Successfully loaded dashboard data
/// - Error: Failed to load (with error message and stack trace)
///
/// The UI uses AsyncValue.when() or AsyncValue.map() to handle all states:
/// ```dart
/// final dashboardState = ref.watch(workerDashboardViewModelProvider);
///
/// dashboardState.when(
///   loading: () => LoadingWidget(),
///   data: (dashboard) => DashboardContent(dashboard),
///   error: (error, stack) => ErrorWidget(error),
/// );
/// ```
final workerDashboardViewModelProvider = StateNotifierProvider<
    WorkerDashboardViewModel, AsyncValue<WorkerDashboardData>>((ref) {
  final repository = ref.read(workerRepositoryProvider);
  return WorkerDashboardViewModel(repository);
});

/// Worker Dashboard ViewModel
///
/// Responsibilities:
/// - Fetch dashboard data from repository
/// - Manage loading/success/error states
/// - Provide refresh functionality
/// - Handle errors gracefully
class WorkerDashboardViewModel
    extends StateNotifier<AsyncValue<WorkerDashboardData>> {
  final WorkerRepository _repository;

  WorkerDashboardViewModel(this._repository)
      : super(const AsyncValue.loading()) {
    // Auto-load dashboard on initialization
    loadDashboard();
  }

  /// Load dashboard data
  ///
  /// Sets state to loading, then calls repository to fetch data
  /// On success: Sets state to AsyncValue.data(dashboard)
  /// On error: Sets state to AsyncValue.error(error, stackTrace)
  Future<void> loadDashboard() async {
    // Set loading state (preserves previous data if available for optimistic UI)
    state = const AsyncValue.loading();

    try {
      // Fetch data from repository (which uses ApiMethod)
      final data = await _repository.getDashboardData();

      // Check if still mounted (user might have navigated away)
      if (!mounted) return;

      // Update state with fetched data
      state = AsyncValue.data(data);
    } catch (error, stackTrace) {
      // Check if still mounted
      if (!mounted) return;

      // Update state with error
      state = AsyncValue.error(error, stackTrace);

      // Log error for debugging (in production, this would go to error tracking service)
      print('Worker dashboard load error: $error');
      print('Stack trace: $stackTrace');
    }
  }

  /// Refresh dashboard data
  ///
  /// Same as loadDashboard but can be called explicitly by pull-to-refresh
  /// Shows loading state while refreshing
  Future<void> refresh() async {
    await loadDashboard();
  }

  /// Refresh dashboard silently (without showing loading state)
  ///
  /// Useful for background refreshes where you don't want to show a loading spinner
  /// Preserves current data while fetching new data
  Future<void> refreshSilently() async {
    try {
      // Don't set loading state - keep current data visible
      final data = await _repository.getDashboardData();

      if (!mounted) return;

      state = AsyncValue.data(data);
    } catch (error) {
      if (!mounted) return;

      // On error, keep current state (don't disrupt user if background refresh fails)
      print('Silent refresh failed: $error');

      // Optionally, you could show a snackbar here instead of changing state
    }
  }

  /// Helper methods to check current state
  bool get isLoading => state.isLoading;
  bool get hasError => state.hasError;
  bool get hasValue => state.hasValue;

  /// Get current data (if available)
  WorkerDashboardData? get currentData => state.valueOrNull;

  /// Get error (if in error state)
  Object? get currentError => state.error;
}
