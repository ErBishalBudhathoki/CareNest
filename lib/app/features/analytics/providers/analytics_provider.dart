import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/analytics_models.dart';
import '../repositories/analytics_repository.dart';
import 'package:carenest/app/features/auth/providers/user_provider.dart';

// Filter State
class AnalyticsFilter {
  final DateTime startDate;
  final DateTime endDate;
  
  AnalyticsFilter({required this.startDate, required this.endDate});
}

final analyticsDateRangeProvider = StateProvider<AnalyticsFilter>((ref) {
  final now = DateTime.now();
  // Default to last 30 days
  return AnalyticsFilter(
    startDate: now.subtract(const Duration(days: 30)), 
    endDate: now
  );
});

// Financials Provider
final financialMetricsProvider = FutureProvider<List<FinancialMetric>>((ref) async {
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
    error: (_, __) => [],
  );
});

// Utilization Provider
final utilizationMetricsProvider = FutureProvider<List<UtilizationMetric>>((ref) async {
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
    error: (_, __) => [],
  );
});

// Overtime Provider
final overtimeMetricsProvider = FutureProvider<List<OvertimeMetric>>((ref) async {
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
    error: (_, __) => [],
  );
});

// Reliability Provider
final reliabilityMetricsProvider = FutureProvider<List<ReliabilityMetric>>((ref) async {
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
    error: (_, __) => [],
  );
});
