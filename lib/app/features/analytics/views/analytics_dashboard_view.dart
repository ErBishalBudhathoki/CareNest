import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../controllers/analytics_controller.dart';
import '../providers/analytics_provider.dart';
import '../theme/bauhaus_theme.dart';
import '../widgets/bauhaus_container.dart';
import '../widgets/financial_trend_chart.dart';
import '../widgets/overtime_heatmap.dart';
import '../widgets/utilization_gauge.dart';
import '../widgets/reliability_table.dart';
import '../widgets/bauhaus_loader.dart';
import '../widgets/bauhaus_empty_state.dart';

class AnalyticsDashboardView extends ConsumerWidget {
  const AnalyticsDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(analyticsDateRangeProvider);
    final analyticsState = ref.watch(analyticsControllerProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light grey bg for contrast
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HEADER
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text('WORKFORCE ANALYTICS', style: BauhausTheme.headerStyle)),
                      _DateFilterButton(
                        currentRange: '${DateFormat('MMM d').format(filter.startDate)} - ${DateFormat('MMM d').format(filter.endDate)}',
                        onTap: () => _showFilterOptions(context, ref, filter),
                      ),
                    ],
                  ),
                  
                  if (analyticsState.valueOrNull?.hasFinancialLoss == true)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: BauhausContainer(
                        color: BauhausTheme.red,
                        child: Row(
                          children: [
                            const Icon(Icons.warning, color: BauhausTheme.white),
                            const SizedBox(width: 12),
                            Text(
                              'ALERT: REVENUE BELOW LABOR COST',
                              style: BauhausTheme.subHeaderStyle.copyWith(color: BauhausTheme.white),
                            ),
                          ],
                        ),
                      ),
                    ),

                  const SizedBox(height: 24),

                  analyticsState.when(
                    data: (data) {
                      if (data.isEmpty) {
                        return const BauhausEmptyState(message: 'No data for this period');
                      }
                      return Column(
                        children: [
                          // BLOCK 1: FINANCIAL TREND (Full Width)
                          FinancialTrendChart(metrics: data.financials),
                          const SizedBox(height: 16),

                          // BLOCK 2 & 3: OVERTIME & UTILIZATION (Grid)
                          LayoutBuilder(
                            builder: (context, constraints) {
                              if (constraints.maxWidth < 800) {
                                return Column(
                                  children: [
                                    OvertimeHeatmap(metrics: data.overtime),
                                    const SizedBox(height: 16),
                                    UtilizationGauge(metrics: data.utilization),
                                  ],
                                );
                              } else {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(child: OvertimeHeatmap(metrics: data.overtime)),
                                    const SizedBox(width: 16),
                                    Expanded(child: UtilizationGauge(metrics: data.utilization)),
                                  ],
                                );
                              }
                            },
                          ),
                          const SizedBox(height: 16),

                          // BLOCK 4: RELIABILITY TABLE (Full Width)
                          ReliabilityTable(metrics: data.reliability),
                          const SizedBox(height: 32),
                        ],
                      );
                    },
                    loading: () => const SizedBox(
                      height: 400,
                      child: BauhausLoader(size: 60),
                    ),
                    error: (e, s) => _ErrorBlock(error: e.toString(), height: 300),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterOptions(BuildContext context, WidgetRef ref, AnalyticsFilter currentFilter) {
    showModalBottomSheet(
      context: context,
      backgroundColor: BauhausTheme.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          border: Border.all(color: BauhausTheme.black, width: 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('SELECT PERIOD', style: BauhausTheme.headerStyle),
            const SizedBox(height: 24),
            _FilterOption(
              label: 'This Week',
              onTap: () {
                ref.read(analyticsControllerProvider.notifier).setPresetFilter('This Week');
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 12),
            _FilterOption(
              label: 'Last Month',
              onTap: () {
                ref.read(analyticsControllerProvider.notifier).setPresetFilter('Last Month');
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 12),
            _FilterOption(
              label: 'Custom Range',
              onTap: () async {
                Navigator.pop(context);
                final picked = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  initialDateRange: DateTimeRange(start: currentFilter.startDate, end: currentFilter.endDate),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: BauhausTheme.blue,
                          onPrimary: BauhausTheme.white,
                          surface: BauhausTheme.white,
                          onSurface: BauhausTheme.black,
                        ),
                        dialogBackgroundColor: BauhausTheme.white,
                      ),
                      child: child!,
                    );
                  },
                );
                if (picked != null) {
                  ref.read(analyticsControllerProvider.notifier).updateDateFilter(picked);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterOption extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _FilterOption({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          border: Border.all(color: BauhausTheme.black, width: 2),
          color: BauhausTheme.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: BauhausTheme.subHeaderStyle),
            const Icon(Icons.arrow_forward, color: BauhausTheme.black),
          ],
        ),
      ),
    );
  }
}

class _DateFilterButton extends StatelessWidget {
  final String currentRange;
  final VoidCallback onTap;

  const _DateFilterButton({required this.currentRange, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: BauhausTheme.white,
          border: Border.all(color: BauhausTheme.black, width: 2),
        ),
        child: Row(
          children: [
            Text(currentRange, style: BauhausTheme.labelStyle),
            const SizedBox(width: 8),
            const Icon(Icons.calendar_today,
                size: 16, color: BauhausTheme.black),
          ],
        ),
      ),
    );
  }
}

class _LoadingBlock extends StatelessWidget {
  final double height;
  const _LoadingBlock({required this.height});

  @override
  Widget build(BuildContext context) {
    return BauhausContainer(
      height: height,
      child: const Center(
        child: CircularProgressIndicator(
          color: BauhausTheme.blue,
          strokeWidth: 4,
        ),
      ),
    );
  }
}

class _ErrorBlock extends StatelessWidget {
  final String error;
  final double height;
  const _ErrorBlock({required this.error, required this.height});

  @override
  Widget build(BuildContext context) {
    return BauhausContainer(
      height: height,
      color: const Color(0xFFFFEBEE),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: BauhausTheme.red, size: 32),
            const SizedBox(height: 8),
            Text('Error loading data', style: BauhausTheme.subHeaderStyle),
            Text(error, style: BauhausTheme.bodyStyle.copyWith(fontSize: 10)),
          ],
        ),
      ),
    );
  }
}
