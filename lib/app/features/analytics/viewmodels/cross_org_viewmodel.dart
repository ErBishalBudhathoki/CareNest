import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/analytics/models/analytics_models.dart';
import 'package:carenest/app/features/analytics/repositories/analytics_repository.dart';

final crossOrgViewModelProvider =
    StateNotifierProvider<CrossOrgViewModel, AsyncValue<List<CrossOrgMetric>>>((ref) {
  final repository = ref.watch(analyticsRepositoryProvider);
  return CrossOrgViewModel(repository);
});

class CrossOrgViewModel extends StateNotifier<AsyncValue<List<CrossOrgMetric>>> {
  final AnalyticsRepository _repository;

  CrossOrgViewModel(this._repository) : super(const AsyncValue.loading()) {
    fetchMetrics();
  }

  Future<void> fetchMetrics({DateTime? start, DateTime? end}) async {
    try {
      state = const AsyncValue.loading();
      
      final now = DateTime.now();
      final startDate = start ?? DateTime(now.year, now.month, 1); // Start of month
      final endDate = end ?? now;

      final result = await _repository.fetchCrossOrgRevenue(
        startDate: startDate,
        endDate: endDate,
      );

      state = AsyncValue.data(result);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
