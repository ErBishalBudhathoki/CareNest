import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/analytics/models/analytics_models.dart';
import 'package:carenest/app/features/analytics/repositories/analytics_repository.dart';

final crossOrgViewModelProvider =
    AsyncNotifierProvider<CrossOrgViewModel, List<CrossOrgMetric>>(
      CrossOrgViewModel.new,
    );

class CrossOrgViewModel extends AsyncNotifier<List<CrossOrgMetric>> {
  late final AnalyticsRepository _repository;

  @override
  FutureOr<List<CrossOrgMetric>> build() {
    _repository = ref.watch(analyticsRepositoryProvider);
    Future.microtask(() => fetchMetrics());
    return <CrossOrgMetric>[];
  }

  Future<void> fetchMetrics({DateTime? start, DateTime? end}) async {
    try {
      state = const AsyncLoading();

      final now = DateTime.now();
      final startDate =
          start ?? DateTime(now.year, now.month, 1); // Start of month
      final endDate = end ?? now;

      final result = await _repository.fetchCrossOrgRevenue(
        startDate: startDate,
        endDate: endDate,
      );

      state = AsyncData(result);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
