import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
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

class AnalyticsController extends StateNotifier<AsyncValue<AnalyticsData>> {
  final Ref ref;

  AnalyticsController(this.ref) : super(const AsyncValue.loading()) {
    loadData();
  }

  Future<void> loadData() async {
    try {
      state = const AsyncValue.loading();

      // Parallel Fetching using providers
      // Note: Providers are already watching state changes, so they might trigger rebuilds individually.
      // But here we want to aggregate them into a single coherent state for the UI.
      // Alternatively, the UI can watch individual providers, but the requirement asked for an "AnalyticsController".
      // We'll use this controller to aggregate and process logic like "Loss Alert".

      // Force refresh of providers if needed, but since they watch filter state, 
      // changing filter automatically refreshes them. 
      // We just need to read their current future.
      
      final financials = await ref.read(financialMetricsProvider.future);
      final utilization = await ref.read(utilizationMetricsProvider.future);
      final overtime = await ref.read(overtimeMetricsProvider.future);
      final reliability = await ref.read(reliabilityMetricsProvider.future);

      // Business Logic: Check for Financial Loss
      // Flag if TOTAL Revenue < TOTAL Labor Cost (Aggregate check is more meaningful than daily)
      double totalRevenue = 0;
      double totalLaborCost = 0;
      
      for (var f in financials) {
        totalRevenue += f.revenue;
        totalLaborCost += f.laborCost;
      }
      
      // Also flag if any specific day has significant loss (e.g. > 20% margin loss)
      bool hasSignificantDailyLoss = false;
      for (var f in financials) {
        if (f.laborCost > f.revenue && f.laborCost > 0) {
           hasSignificantDailyLoss = true;
           break;
        }
      }

      state = AsyncValue.data(AnalyticsData(
        financials: financials,
        utilization: utilization,
        overtime: overtime,
        reliability: reliability,
        hasFinancialLoss: totalRevenue < totalLaborCost || hasSignificantDailyLoss,
      ));

    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void updateDateFilter(DateTimeRange range) {
    ref.read(analyticsDateRangeProvider.notifier).state = 
      AnalyticsFilter(startDate: range.start, endDate: range.end);
    // The providers watching this state will refresh automatically.
    // We trigger loadData to update OUR local aggregated state.
    loadData();
  }
  
  void setPresetFilter(String preset) {
    final now = DateTime.now();
    DateTime start;
    DateTime end = now;
    
    switch (preset) {
      case 'This Week':
        // Find last Monday
        start = now.subtract(Duration(days: now.weekday - 1));
        break;
      case 'Last Month':
        start = DateTime(now.year, now.month - 1, 1);
        end = DateTime(now.year, now.month, 0);
        break;
      default: // Last 30 Days
        start = now.subtract(const Duration(days: 30));
    }
    
    updateDateFilter(DateTimeRange(start: start, end: end));
  }
}

final analyticsControllerProvider = StateNotifierProvider<AnalyticsController, AsyncValue<AnalyticsData>>((ref) {
  return AnalyticsController(ref);
});
