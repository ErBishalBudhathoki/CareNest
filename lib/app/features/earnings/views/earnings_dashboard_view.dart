import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/earnings/viewmodels/earnings_viewmodel.dart';
import 'package:carenest/app/features/earnings/models/earnings_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:carenest/app/shared/design_system/bauhaus_design_system.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:carenest/app/features/earnings/services/employee_invoice_service.dart';
import 'package:carenest/app/core/providers/auth_providers.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/features/auth/providers/user_provider.dart';
import 'package:carenest/app/features/admin/providers/business_stats_provider.dart';
import 'package:carenest/app/features/admin/widgets/business_overview_section.dart';

class EarningsDashboardView extends ConsumerWidget {
  final String? organizationId;
  final String? organizationName;

  const EarningsDashboardView({
    super.key,
    this.organizationId,
    this.organizationName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(earningsViewModelProvider);
    final viewModel = ref.read(earningsViewModelProvider.notifier);
    final role = ref.watch(userRoleProvider);

    final range = _calculateRange(state.period, state.anchorDate);
    final rangeLabel = _formatRangeLabel(state.period, range.start, range.end);

    return Scaffold(
      backgroundColor: BauhausDesign.surfaceLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.surfaceLight,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(color: BauhausDesign.textDark, height: 2),
        ),
        title: Text(
          'EARNINGS DASHBOARD',
          style: GoogleFonts.oswald(
            color: BauhausDesign.textDark,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
            fontSize: 20,
          ),
        ),
        actions: [
            IconButton(
                icon: const Icon(Icons.download_rounded, color: BauhausDesign.textDark),
                tooltip: 'Generate Payslip',
                onPressed: () {
                    final now = DateTime.now();
                    final startOfMonth = DateTime(now.year, now.month, 1);
                    final endOfMonth = DateTime(now.year, now.month + 1, 0);
                    
                    ref.read(employeeInvoiceServiceProvider).generateAndOpenInvoice(
                        context, 
                        ref.read(currentUserProvider).value?.email ?? '',
                        startOfMonth,
                        endOfMonth
                    );
                },
            ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
              ? Center(child: Text('Error: ${state.error}'))
              : LayoutBuilder(
                builder: (context, constraints) {
                    final isWide = constraints.maxWidth >= 800;

                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (role == UserRole.admin &&
                              organizationId != null &&
                              organizationId!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: _buildBusinessOverview(context, ref),
                            ),
                          _buildPeriodControls(
                            context: context,
                            period: state.period,
                            rangeLabel: rangeLabel,
                            onPeriodChanged: viewModel.setPeriod,
                            onPrevious: viewModel.goToPreviousPeriod,
                            onNext: viewModel.goToNextPeriod,
                          ),
                          const SizedBox(height: 16),
                          if (isWide)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: state.summary != null
                                      ? _buildSummaryCard(
                                          state.summary!,
                                          context,
                                          title: state.period ==
                                                  EarningsPeriod.weekly
                                              ? 'Weekly Summary'
                                              : 'Monthly Summary',
                                        )
                                      : const SizedBox.shrink(),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: state.projection != null
                                      ? _buildProjectedPayCard(
                                          state.projection!,
                                          context,
                                        )
                                      : const SizedBox.shrink(),
                                ),
                              ],
                            )
                          else ...[
                            if (state.summary != null)
                              _buildSummaryCard(
                                state.summary!,
                                context,
                                title: state.period == EarningsPeriod.weekly
                                    ? 'Weekly Summary'
                                    : 'Monthly Summary',
                              ),
                            const SizedBox(height: 20),
                            if (state.projection != null)
                              _buildProjectedPayCard(state.projection!, context),
                          ],
                          const SizedBox(height: 20),
                          _buildPayHistory(state.periodHistory),
                          const SizedBox(height: 20),
                          _buildPayHistory(state.periodHistory),
                          const SizedBox(height: 20),
                          _buildChartSection(
                            context,
                            state.summary?.history ?? [],
                            state.period == EarningsPeriod.weekly
                                ? 'EARNINGS HISTORY (THIS WEEK)'
                                : 'EARNINGS HISTORY (THIS MONTH)',
                          ),
                          const SizedBox(height: 12),
                          _buildHistoryList(state.summary?.history ?? const []),
                          const SizedBox(height: 20),
                          _buildTaxFrequencyControls(
                            context: context,
                            value: state.taxFrequency,
                            onChanged: viewModel.setTaxFrequency,
                          ),
                          const SizedBox(height: 12),
                          _buildTaxEstimator(
                            viewModel,
                            state.summary?.totalEarnings ?? 0,
                            state.taxFrequency,
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }

  _Range _calculateRange(EarningsPeriod period, DateTime anchor) {
    final normalized = DateTime(anchor.year, anchor.month, anchor.day);
    if (period == EarningsPeriod.weekly) {
      final start = normalized.subtract(Duration(days: normalized.weekday - 1));
      final end = start.add(const Duration(days: 6));
      return _Range(start: start, end: end);
    }
    final start = DateTime(normalized.year, normalized.month, 1);
    final end = DateTime(normalized.year, normalized.month + 1, 0);
    return _Range(start: start, end: end);
  }

  String _formatRangeLabel(EarningsPeriod period, DateTime start, DateTime end) {
    final df = DateFormat('MMM d');
    if (period == EarningsPeriod.weekly) {
      return '${df.format(start)} – ${df.format(end)}';
    }
    return DateFormat('MMMM yyyy').format(start);
  }

  Widget _buildPeriodControls({
    required BuildContext context,
    required EarningsPeriod period,
    required String rangeLabel,
    required void Function(EarningsPeriod period) onPeriodChanged,
    required VoidCallback onPrevious,
    required VoidCallback onNext,
  }) {
    // Custom Bauhaus inspired toggle
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: BauhausDesign.textDark, width: 2),
                borderRadius: BorderRadius.circular(4),
                boxShadow: const [BoxShadow(color: BauhausDesign.neutral, offset: Offset(2, 2))],
                color: BauhausDesign.surfaceLight,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildToggleItem(
                    label: 'WEEKLY',
                    isSelected: period == EarningsPeriod.weekly,
                    onTap: () => onPeriodChanged(EarningsPeriod.weekly),
                  ),
                  Container(width: 2, height: 40, color: BauhausDesign.textDark),
                  _buildToggleItem(
                    label: 'MONTHLY',
                    isSelected: period == EarningsPeriod.monthly,
                    onTap: () => onPeriodChanged(EarningsPeriod.monthly),
                  ),
                ],
              ),
            ),
            
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildNavButton(Icons.arrow_back, onPrevious),
                const SizedBox(width: 8),
                Text(
                  rangeLabel.toUpperCase(),
                  style: GoogleFonts.oswald(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: BauhausDesign.textDark,
                  ),
                ),
                const SizedBox(width: 8),
                _buildNavButton(Icons.arrow_forward, onNext),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildToggleItem({required String label, required bool isSelected, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: isSelected ? BauhausDesign.textDark : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Text(
          label,
          style: GoogleFonts.oswald(
            fontWeight: FontWeight.bold,
            color: isSelected ? BauhausDesign.surfaceLight : BauhausDesign.textDark,
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: BauhausDesign.textDark, width: 2),
          color: BauhausDesign.surfaceLight,
        ),
        child: Icon(icon, size: 20, color: BauhausDesign.textDark),
      ),
    );
  }

  Widget _buildTaxFrequencyControls({
    required BuildContext context,
    required TaxFrequency value,
    required void Function(TaxFrequency frequency) onChanged,
  }) {
    String label(TaxFrequency f) {
      switch (f) {
        case TaxFrequency.weekly:
          return 'Weekly';
        case TaxFrequency.fortnightly:
          return 'Fortnightly';
        case TaxFrequency.monthly:
          return 'Monthly';
        case TaxFrequency.annually:
          return 'Annually';
      }
    }

    return Row(
      children: [
        Text(
          'TAX FREQUENCY:',
          style: GoogleFonts.oswald(
              fontSize: 16, fontWeight: FontWeight.bold, color: BauhausDesign.textDark),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: BauhausDesign.textDark, width: 2),
            borderRadius: BorderRadius.circular(0),
             boxShadow: const [BoxShadow(color: BauhausDesign.neutral, offset: Offset(2, 2))],
             color: BauhausDesign.surfaceLight,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<TaxFrequency>(
              value: value,
              icon: const Icon(Icons.arrow_drop_down, color: BauhausDesign.textDark),
              dropdownColor: BauhausDesign.surfaceLight,
              onChanged: (v) {
                if (v == null) return;
                onChanged(v);
              },
              items: TaxFrequency.values
                  .map(
                    (f) => DropdownMenuItem(
                      value: f,
                      child: Text(
                        label(f).toUpperCase(),
                         style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: BauhausDesign.textDark),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBusinessOverview(BuildContext context, WidgetRef ref) {
    final orgId = organizationId;
    if (orgId == null || orgId.isEmpty) {
      return const SizedBox.shrink();
    }

    final statsAsync = ref.watch(businessStatsProvider(orgId));
    return statsAsync.when(
      data: (stats) => BusinessOverviewSection(businessStats: stats),
      loading: () => const SizedBox(
        height: 150,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Failed to load business overview: $e'),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
    EarningsSummary summary,
    BuildContext context, {
    required String title,
  }) {
    final currencyFormat = NumberFormat.simpleCurrency();
    
    return Container(
      decoration: BauhausDesign.cardDecoration,
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
             style: GoogleFonts.inter(
                fontSize: 12, fontWeight: FontWeight.bold, color: BauhausDesign.neutral),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        currencyFormat.format(summary.totalEarnings),
                        style: GoogleFonts.outfit(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: BauhausDesign.success,
                        ),
                      ),
                    ),
                    Text(
                      'TOTAL EARNINGS',
                      style: GoogleFonts.oswald(
                        fontSize: 14,
                        color: BauhausDesign.textDark,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${summary.totalHours.toStringAsFixed(1)} hrs',
                        style: GoogleFonts.outfit(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: BauhausDesign.textDark,
                        ),
                      ),
                    ),
                    Text(
                      'TOTAL HOURS',
                      style: GoogleFonts.oswald(
                        fontSize: 14,
                        color: BauhausDesign.textDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 32, color: BauhausDesign.textDark, thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'PAY RATE: ${currencyFormat.format(summary.payRate)}/${summary.payType == 'Hourly' ? 'HR' : 'YR'}',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    color: BauhausDesign.textDark,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: BauhausDesign.success,
                  border: Border.all(color: BauhausDesign.textDark),
                  boxShadow: const [BoxShadow(color: BauhausDesign.textDark, offset: Offset(2, 2))],
                ),
                child: Text(
                  'ACTIVE',
                   style: GoogleFonts.oswald(fontSize: 12, fontWeight: FontWeight.bold, color: BauhausDesign.textDark),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProjectedPayCard(ProjectedEarnings projection, BuildContext context) {
    final currencyFormat = NumberFormat.simpleCurrency();
    
    return Container(
      decoration: BauhausDesign.cardDecoration.copyWith(
        color: BauhausDesign.backgroundLight,
      ),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
             Row(
               children: [
                 const Icon(Icons.trending_up, color: BauhausDesign.secondary),
                 const SizedBox(width: 8),
                 Expanded(
                   child: Text(
                     'PROJECTED PAY (UPCOMING)',
                     style: GoogleFonts.oswald(
                       fontSize: 16,
                       fontWeight: FontWeight.bold,
                       color: BauhausDesign.textDark,
                     ),
                     overflow: TextOverflow.ellipsis,
                   ),
                 ),
               ],
             ),
             const SizedBox(height: 16),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text(
                   currencyFormat.format(projection.projectedEarnings),
                   style: GoogleFonts.outfit(fontSize: 28, fontWeight: FontWeight.bold, color: BauhausDesign.secondary),
                 ),
                 const SizedBox(width: 12),
                 Flexible(
                   child: Text(
                     '${projection.projectedHours.toStringAsFixed(1)} hrs scheduled',
                     style: GoogleFonts.inter(
                       fontWeight: FontWeight.w500,
                       color: BauhausDesign.textDark,
                     ),
                     overflow: TextOverflow.ellipsis,
                     textAlign: TextAlign.end,
                   ),
                 ),
               ],
             ),
             if (projection.breakdown.isNotEmpty) ...[
               const SizedBox(height: 16),
               Text('UPCOMING SHIFTS:', style: GoogleFonts.oswald(fontWeight: FontWeight.bold, color: BauhausDesign.textDark)),
               const SizedBox(height: 8),
               ...projection.breakdown.take(3).map((item) => Padding(
                 padding: const EdgeInsets.only(top: 8),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text(DateFormat('MMM dd').format(DateTime.parse(item.date)),
                        style: GoogleFonts.inter(color: BauhausDesign.textDark)),
                     Text('${item.hours} hrs', style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: BauhausDesign.textDark)),
                   ],
                 ),
               )),
             ]
          ],
        ),
    );
  }

  Widget _buildChartSection(BuildContext context, List<EarningsHistoryItem> history, String title) {
    if (history.isEmpty) return const SizedBox.shrink();

    return Container(
      decoration: BauhausDesign.cardDecoration,
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.oswald(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: BauhausDesign.textDark,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(border: Border.all(color: BauhausDesign.textDark)),
                child: const Icon(Icons.bar_chart, size: 16, color: BauhausDesign.textDark),
              )
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 220,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: history.map((e) => e.earnings).fold<double>(0.0, (p, c) => c > p ? c : p) * 1.2,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 100, // Adjust based on scale if possible, dynamic would be better but fixed is ok
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: BauhausDesign.neutral.withOpacity(0.1),
                    strokeWidth: 1,
                  ),
                ),
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (group) => BauhausDesign.neutral,
                    tooltipPadding: const EdgeInsets.all(8),
                    tooltipMargin: 8,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        '\$${rod.toY.toStringAsFixed(0)}',
                        GoogleFonts.outfit(
                          color: BauhausDesign.surfaceLight,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        if (value.toInt() >= 0 && value.toInt() < history.length) {
                          final date = DateTime.parse(history[value.toInt()].date);
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              DateFormat('dd').format(date),
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: BauhausDesign.textDark,
                              ),
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      interval: 100, // Match grid
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '\$${value.toInt()}',
                          style: GoogleFonts.outfit(
                            fontSize: 10,
                            color: BauhausDesign.neutral.withOpacity(0.6),
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border(
                    bottom: BorderSide(color: BauhausDesign.textDark),
                    left: BorderSide(color: BauhausDesign.textDark),
                  ),
                ),
                barGroups: history.asMap().entries.map((entry) {
                  return BarChartGroupData(
                    x: entry.key,
                    barRods: [
                      BarChartRodData(
                        toY: entry.value.earnings,
                        color: BauhausDesign.secondary,
                        width: 16, // Wider bars
                        borderRadius: BorderRadius.zero,
                        backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY: history.map((e) => e.earnings).fold<double>(0.0, (p, c) => c > p ? c : p) * 1.2,
                          color: BauhausDesign.neutral.withOpacity(0.05),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList(List<EarningsHistoryItem> history) {
    if (history.isEmpty) return const SizedBox.shrink();
    final currencyFormat = NumberFormat.simpleCurrency();

    return Container(
      decoration: BauhausDesign.cardDecoration,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: history
            .map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        DateFormat('EEE, MMM d')
                            .format(DateTime.parse(item.date))
                            .toUpperCase(),
                        style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: BauhausDesign.textDark),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text('${item.hours.toStringAsFixed(1)}H', style: GoogleFonts.inter(color: BauhausDesign.textDark)),
                    const SizedBox(width: 12),
                    Text(currencyFormat.format(item.earnings), style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: BauhausDesign.success)),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildPayHistory(EarningsPeriodHistory? history) {
    if (history == null || history.items.isEmpty) {
      return const SizedBox.shrink();
    }
    final currencyFormat = NumberFormat.simpleCurrency();
    final isWeekly = history.bucket == 'week';

    String labelForItem(EarningsPeriodHistoryItem item) {
      final start = DateTime.tryParse(item.periodStart);
      final end = DateTime.tryParse(item.periodEnd);
      if (start == null) return item.periodStart;
      if (!isWeekly) return DateFormat('MMM yyyy').format(start).toUpperCase();
      if (end == null) return DateFormat('MMM d').format(start).toUpperCase();
      return '${DateFormat('MMM d').format(start)} – ${DateFormat('MMM d').format(end)}'.toUpperCase();
    }

    return Container(
      decoration: BauhausDesign.cardDecoration,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PAY HISTORY',
            style: GoogleFonts.oswald(fontSize: 16, fontWeight: FontWeight.bold, color: BauhausDesign.textDark),
          ),
          const SizedBox(height: 12),
          ...history.items.reversed.take(8).map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(labelForItem(item), style: GoogleFonts.inter(fontWeight: FontWeight.w500, color: BauhausDesign.textDark))),
                      const SizedBox(width: 12),
                      Text('${item.hours.toStringAsFixed(1)}H', style: GoogleFonts.inter(color: BauhausDesign.textDark)),
                      const SizedBox(width: 12),
                      Text(currencyFormat.format(item.earnings), style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: BauhausDesign.textDark)),
                    ],
                  ),
                ),
              ),
        ],
      ),
    );
  }

  Widget _buildTaxEstimator(
    EarningsViewModel viewModel,
    double periodEarnings,
    TaxFrequency frequency,
  ) {
    final currencyFormat = NumberFormat.simpleCurrency();
    String frequencyLabel;
    switch (frequency) {
      case TaxFrequency.weekly:
        frequencyLabel = 'Weekly';
        break;
      case TaxFrequency.fortnightly:
        frequencyLabel = 'Fortnightly';
        break;
      case TaxFrequency.monthly:
        frequencyLabel = 'Monthly';
        break;
      case TaxFrequency.annually:
        frequencyLabel = 'Annually';
        break;
    }
    final estimated = viewModel.calculateTax(periodEarnings, frequencyLabel);

    return Container(
      decoration: BauhausDesign.cardDecoration,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TAX ESTIMATOR (${frequencyLabel.toUpperCase()})',
            style: GoogleFonts.oswald(fontSize: 16, fontWeight: FontWeight.bold, color: BauhausDesign.textDark),
          ),
          const SizedBox(height: 4),
          Text('Based on ATO Resident Rates 2024-2025', style: GoogleFonts.inter(fontSize: 12, color: BauhausDesign.neutral)),
          const SizedBox(height: 16),
          _buildTaxRow('Gross Income', estimated['gross']!, currencyFormat, isBold: true),
          const Divider(color: BauhausDesign.textDark, thickness: 1),
          _buildTaxRow('Estimated Tax', estimated['tax']!, currencyFormat, color: BauhausDesign.error),
          const Divider(color: BauhausDesign.textDark, thickness: 1),
          _buildTaxRow('Net Pay', estimated['net']!, currencyFormat, color: BauhausDesign.success, isBold: true),
        ],
      ),
    );
  }

  Widget _buildTaxRow(String label, double value, NumberFormat format, {Color? color, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label.toUpperCase(), style: GoogleFonts.inter(fontWeight: isBold ? FontWeight.bold : FontWeight.w500, color: BauhausDesign.textDark)),
          Text(format.format(value), 
              style: GoogleFonts.outfit(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                color: color ?? BauhausDesign.textDark,
                fontSize: 16,
              )),
        ],
      ),
    );
  }
}

class _Range {
  final DateTime start;
  final DateTime end;

  const _Range({required this.start, required this.end});
}
