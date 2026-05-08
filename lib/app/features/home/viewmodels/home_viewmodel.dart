import 'package:carenest/app/features/home/models/home_dashboard_data.dart';
import 'package:carenest/app/features/home/repositories/home_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for HomeViewModel
final homeViewModelProvider =
    StateNotifierProvider<HomeViewModel, AsyncValue<HomeDashboardData>>((ref) {
  final repository = ref.read(homeRepositoryProvider);
  return HomeViewModel(repository);
});

/// Home View Model
///
/// Manages the state of the Employee Home View dashboard.
class HomeViewModel extends StateNotifier<AsyncValue<HomeDashboardData>> {
  final HomeRepository _repository;

  HomeViewModel(this._repository) : super(const AsyncValue.loading());

  /// Load home dashboard data
  Future<void> loadDashboard(String email) async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getHomeDashboardData(email);
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Refresh dashboard data silently (full reload)
  Future<void> refreshSilently(String email) async {
    try {
      final data = await _repository.getHomeDashboardData(email);
      state = AsyncValue.data(data);
    } catch (e) {
      // Keep previous state on silent error
      debugPrint('Silent refresh error: $e');
    }
  }

  /// Poll only the active broadcasts and merge into the current state.
  ///
  /// Called every 15 seconds by a timer in [EmployeeHomeView] so employees
  /// see emergency alerts immediately without a manual pull-to-refresh.
  /// Preserves existing appointment data so the UI does not flicker.
  Future<void> pollBroadcasts() async {
    try {
      final freshBroadcasts = await _repository.getActiveBroadcasts();

      if (!mounted) return;
      final current = state.valueOrNull;
      if (current == null) return;

      // Skip rebuild when the broadcast list has not changed.
      final currentIds = current.activeBroadcasts.map((b) => b.id).toSet();
      final freshIds = freshBroadcasts.map((b) => b.id).toSet();
      if (currentIds.length == freshIds.length &&
          currentIds.containsAll(freshIds)) {
        return;
      }

      state = AsyncValue.data(
        current.copyWith(activeBroadcasts: freshBroadcasts),
      );
    } catch (e) {
      // Swallow polling errors silently – they should never disrupt the UI.
      debugPrint('pollBroadcasts error: $e');
    }
  }

  /// Acknowledge a broadcast then silently refresh so the banner disappears.
  Future<void> acknowledgeBroadcast(String email, String broadcastId) async {
    try {
      await _repository.acknowledgeBroadcast(broadcastId);
      await refreshSilently(email);
    } catch (e) {
      rethrow;
    }
  }
}
