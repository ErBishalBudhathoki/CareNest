import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/analytics_models.dart';
import '../repositories/analytics_repository.dart';
import 'package:carenest/app/features/auth/providers/user_provider.dart';

// Filter State
class AnalyticsFilter {
  final DateTime startDate;
  final DateTime endDate;

  AnalyticsFilter({required this.startDate, required this.endDate});
}

class AnalyticsDateRangeNotifier extends Notifier<AnalyticsFilter> {
  @override
  AnalyticsFilter build() {
    final now = DateTime.now();
    return AnalyticsFilter(
      startDate: now.subtract(const Duration(days: 30)),
      endDate: now,
    );
  }
}

final analyticsDateRangeProvider =
    NotifierProvider<AnalyticsDateRangeNotifier, AnalyticsFilter>(
      AnalyticsDateRangeNotifier.new,
    );

// Financials Provider
final financialMetricsProvider = FutureProvider<List<FinancialMetric>>((
  ref,
) async {
  final repo = ref.watch(analyticsRepositoryProvider);
  final filter = ref.watch(analyticsDateRangeProvider);
  final userAsync = ref.watch(currentUserProvider);

  return userAsync.when(
    data: (user) async {
      if (user == null || user.organizationId == null) {
        return [];
      }
      return repo.fetchFinancials(
        organizationId: user.organizationId,
        startDate: filter.startDate,
        endDate: filter.endDate,
      );
    },
    loading: () => [],
    error: (_, _) => [],
  );
});

// Utilization Provider
final utilizationMetricsProvider = FutureProvider<List<UtilizationMetric>>((
  ref,
) async {
  final repo = ref.watch(analyticsRepositoryProvider);
  final filter = ref.watch(analyticsDateRangeProvider);
  final userAsync = ref.watch(currentUserProvider);

  return userAsync.when(
    data: (user) async {
      if (user == null || user.organizationId == null) return [];
      return repo.fetchUtilization(
        organizationId: user.organizationId,
        startDate: filter.startDate,
        endDate: filter.endDate,
      );
    },
    loading: () => [],
    error: (_, _) => [],
  );
});

// Overtime Provider
final overtimeMetricsProvider = FutureProvider<List<OvertimeMetric>>((
  ref,
) async {
  final repo = ref.watch(analyticsRepositoryProvider);
  final filter = ref.watch(analyticsDateRangeProvider);
  final userAsync = ref.watch(currentUserProvider);

  return userAsync.when(
    data: (user) async {
      if (user == null || user.organizationId == null) return [];
      return repo.fetchOvertime(
        organizationId: user.organizationId,
        weekStart: filter.startDate,
      );
    },
    loading: () => [],
    error: (_, _) => [],
  );
});

// Reliability Provider
final reliabilityMetricsProvider = FutureProvider<List<ReliabilityMetric>>((
  ref,
) async {
  final repo = ref.watch(analyticsRepositoryProvider);
  final filter = ref.watch(analyticsDateRangeProvider);
  final userAsync = ref.watch(currentUserProvider);

  return userAsync.when(
    data: (user) async {
      if (user == null || user.organizationId == null) return [];
      return repo.fetchReliability(
        organizationId: user.organizationId,
        startDate: filter.startDate,
        endDate: filter.endDate,
      );
    },
    loading: () => [],
    error: (_, _) => [],
  );
});
