import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import '../controllers/analytics_controller.dart';
import '../providers/analytics_provider.dart';
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
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        title: Text(
          'WORKFORCE ANALYTICS',
          style: BauhausDesign.getTextTheme(context).displaySmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: BauhausDesign.textDark,
          ),
        ),
        centerTitle: true,
        backgroundColor: BauhausDesign.surfaceWhite,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: const Border(
          bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DashboardStatusStrip(
                    activeLabel:
                        '${DateFormat('MMM d').format(filter.startDate)} - ${DateFormat('MMM d').format(filter.endDate)}',
                  ),
                  const SizedBox(height: BauhausDesign.space3),
                  Container(
                    padding: const EdgeInsets.all(BauhausDesign.space3),
                    decoration: BoxDecoration(
                      color: BauhausDesign.surfaceLight,
                      borderRadius: BorderRadius.circular(
                        BauhausDesign.radiusSm,
                      ),
                      border: Border.all(
                        color: BauhausDesign.neutral,
                        width: 2,
                      ),
                      boxShadow: const [BauhausDesign.shadowHardSm],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'PERIOD:',
                          style: BauhausDesign.getTextTheme(context).labelMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w900,
                                color: BauhausDesign.textDark,
                              ),
                        ),
                        const SizedBox(width: 8),
                        _DateFilterButton(
                          currentRange:
                              '${DateFormat('MMM d').format(filter.startDate)} - ${DateFormat('MMM d').format(filter.endDate)}',
                          onTap: () => _showFilterOptions(context, ref, filter),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (analyticsState.value?.hasFinancialLoss == true)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Container(
                        padding: const EdgeInsets.all(BauhausDesign.space3),
                        decoration: BoxDecoration(
                          color: BauhausDesign.surfaceLight,
                          borderRadius: BorderRadius.circular(
                            BauhausDesign.radiusSm,
                          ),
                          border: Border.all(
                            color: BauhausDesign.error,
                            width: 2,
                          ),
                          boxShadow: const [BauhausDesign.shadowHardSm],
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.warning,
                              color: BauhausDesign.error,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'ALERT: REVENUE BELOW LABOR COST',
                                style: BauhausDesign.getTextTheme(context)
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: BauhausDesign.textDark,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  analyticsState.when(
                    data: (data) {
                      if (data.isEmpty) {
                        return const BauhausEmptyState(
                          message: 'No data for this period',
                        );
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
                                    Expanded(
                                      child: OvertimeHeatmap(
                                        metrics: data.overtime,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: UtilizationGauge(
                                        metrics: data.utilization,
                                      ),
                                    ),
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
                    error: (e, s) =>
                        _ErrorBlock(error: e.toString(), height: 300),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterOptions(
    BuildContext context,
    WidgetRef ref,
    AnalyticsFilter currentFilter,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: BauhausDesign.surfaceWhite,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          border: Border.all(color: BauhausDesign.neutral, width: 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'SELECT PERIOD',
              style: BauhausDesign.getTextTheme(context).headlineSmall
                  ?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: BauhausDesign.textDark,
                  ),
            ),
            const SizedBox(height: 24),
            _FilterOption(
              label: 'This Week',
              onTap: () {
                ref
                    .read(analyticsControllerProvider.notifier)
                    .setPresetFilter('This Week');
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 12),
            _FilterOption(
              label: 'Last Month',
              onTap: () {
                ref
                    .read(analyticsControllerProvider.notifier)
                    .setPresetFilter('Last Month');
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
                  initialDateRange: DateTimeRange(
                    start: currentFilter.startDate,
                    end: currentFilter.endDate,
                  ),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                          primary: BauhausDesign.primary,
                          onPrimary: BauhausDesign.surfaceWhite,
                          surface: BauhausDesign.surfaceWhite,
                          onSurface: BauhausDesign.textDark,
                        ),
                        dialogTheme: DialogThemeData(backgroundColor: BauhausDesign.surfaceWhite),
                      ),
                      child: child!,
                    );
                  },
                );
                if (picked != null) {
                  ref
                      .read(analyticsControllerProvider.notifier)
                      .updateDateFilter(picked);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardStatusStrip extends StatelessWidget {
  final String activeLabel;
  const _DashboardStatusStrip({required this.activeLabel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: Row(
        children: [
          const Icon(Icons.insights, color: BauhausDesign.secondary),
          const SizedBox(width: BauhausDesign.space3),
          Expanded(
            child: Text(
              'Monitoring period',
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space2,
              vertical: BauhausDesign.space1,
            ),
            decoration: BoxDecoration(
              color: BauhausDesign.secondary,
              border: Border.all(color: BauhausDesign.neutral, width: 1),
            ),
            child: Text(
              activeLabel,
              style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                color: BauhausDesign.surfaceLight,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
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
          border: Border.all(color: BauhausDesign.neutral, width: 2),
          color: BauhausDesign.surfaceWhite,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: BauhausDesign.textDark, // Ensure visible text
              ),
            ),
            Icon(
              Icons.arrow_forward,
              color: BauhausDesign.textDark,
            ), // Ensure visible icon
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
          color: BauhausDesign.surfaceWhite,
          border: Border.all(color: BauhausDesign.neutral, width: 2),
        ),
        child: Row(
          children: [
            Text(
              currentRange,
              style: BauhausDesign.getTextTheme(context).labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: BauhausDesign.textDark, // Ensure visible text
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.calendar_today,
              size: 16,
              color: BauhausDesign.textDark,
            ), // Ensure visible icon
          ],
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
      color: BauhausDesign.error.withValues(alpha: 0.1),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: BauhausDesign.error, size: 32),
            const SizedBox(height: 8),
            Text(
              'Error loading data',
              style: BauhausDesign.getTextTheme(
                context,
              ).titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              error,
              style: BauhausDesign.getTextTheme(
                context,
              ).bodySmall?.copyWith(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
