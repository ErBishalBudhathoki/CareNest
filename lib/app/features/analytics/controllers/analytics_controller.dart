import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../models/analytics_models.dart';
import '../providers/analytics_provider.dart';

// Consolidated Analytics Data State
class AnalyticsData {
  final List<FinancialMetric> financials;
  final List<UtilizationMetric> utilization;
  final List<OvertimeMetric> overtime;
  final List<ReliabilityMetric> reliability;
  final bool hasFinancialLoss;

  AnalyticsData({
    this.financials = const [],
    this.utilization = const [],
    this.overtime = const [],
    this.reliability = const [],
    this.hasFinancialLoss = false,
  });

  bool get isEmpty => 
    financials.isEmpty && 
    utilization.isEmpty && 
    overtime.isEmpty && 
    reliability.isEmpty;
}

class AnalyticsController extends AsyncNotifier<AnalyticsData> {
  @override
  Future<AnalyticsData> build() async {
    return loadData();
  }

  Future<AnalyticsData> loadData() async {
    // Parallel Fetching using providers
    final financials = await ref.read(financialMetricsProvider.future);
    final utilization = await ref.read(utilizationMetricsProvider.future);
    final overtime = await ref.read(overtimeMetricsProvider.future);
    final reliability = await ref.read(reliabilityMetricsProvider.future);

    // Business Logic: Check for Financial Loss
    double totalRevenue = 0;
    double totalLaborCost = 0;

    for (var f in financials) {
      totalRevenue += f.revenue;
      totalLaborCost += f.laborCost;
    }

    bool hasSignificantDailyLoss = false;
    for (var f in financials) {
      if (f.laborCost > f.revenue && f.laborCost > 0) {
        hasSignificantDailyLoss = true;
        break;
      }
    }

    return AnalyticsData(
      financials: financials,
      utilization: utilization,
      overtime: overtime,
      reliability: reliability,
      hasFinancialLoss: totalRevenue < totalLaborCost || hasSignificantDailyLoss,
    );
  }

  Future<void> refreshData() async {
    state = const AsyncValue.loading();
    try {
      state = AsyncValue.data(await loadData());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void updateDateFilter(DateTimeRange range) {
    ref.read(analyticsDateRangeProvider.notifier).state =
        AnalyticsFilter(startDate: range.start, endDate: range.end);
    refreshData();
  }

  void setPresetFilter(String preset) {
    final now = DateTime.now();
    DateTime start;
    DateTime end = now;

    switch (preset) {
      case 'This Week':
        start = now.subtract(Duration(days: now.weekday - 1));
        break;
      case 'Last Month':
        start = DateTime(now.year, now.month - 1, 1);
        end = DateTime(now.year, now.month, 0);
        break;
      default:
        start = now.subtract(const Duration(days: 30));
    }

    updateDateFilter(DateTimeRange(start: start, end: end));
  }
}

final analyticsControllerProvider = AsyncNotifierProvider<AnalyticsController, AnalyticsData>(AnalyticsController.new);
