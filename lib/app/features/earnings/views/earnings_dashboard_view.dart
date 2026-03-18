import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/earnings/viewmodels/earnings_viewmodel.dart';
import 'package:carenest/app/features/earnings/models/earnings_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';

import 'package:carenest/app/features/earnings/services/employee_invoice_service.dart';
import 'package:carenest/app/core/providers/auth_providers.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/features/auth/providers/user_provider.dart';
import 'package:carenest/app/features/admin/providers/business_stats_provider.dart';
import 'package:carenest/app/features/admin/widgets/business_overview_section.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

final earningsChartHighlightProvider = StateProvider<double?>((ref) => null);

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
    final l10n = AppLocalizations.of(context);
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
          l10n?.earningsDashboardTitle ?? 'Earnings Dashboard',
          style: BauhausDesign.getTextTheme(context).headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download_rounded,
                color: BauhausDesign.textDark),
            tooltip: l10n?.generatePayslip ?? 'Generate payslip',
            onPressed: () {
              final now = DateTime.now();
              final startOfMonth = DateTime(now.year, now.month, 1);
              final endOfMonth = DateTime(now.year, now.month + 1, 0);

              ref.read(employeeInvoiceServiceProvider).generateAndOpenInvoice(
                  context,
                  ref.read(currentUserProvider).value?.email ?? '',
                  startOfMonth,
                  endOfMonth);
            },
          ),
        ],
      ),
      body: state.isLoading
          ? BauhausLoadingState(
              message: l10n?.loadingEarnings ?? 'Loading earnings')
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
                                              ? (l10n?.weeklySummary ?? 'Weekly summary')
                                              : (l10n?.monthlySummary ?? 'Monthly summary'),
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
                                    ? (l10n?.weeklySummary ?? 'Weekly summary')
                                    : (l10n?.monthlySummary ?? 'Monthly summary'),
                              ),
                            const SizedBox(height: 20),
                            if (state.projection != null)
                              _buildProjectedPayCard(
                                  state.projection!, context),
                          ],
                          const SizedBox(height: 20),
                          _buildPayHistory(state.periodHistory, context),
                          const SizedBox(height: 20),
                          _buildPayHistory(state.periodHistory, context),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: const BoxDecoration(
                              border: Border(
                                  left: BorderSide(
                                      color: BauhausDesign.textDark, width: 4)),
                            ),
                            child: Text(
                              state.period == EarningsPeriod.weekly
                                  ? (l10n?.earningsHistoryThisWeek ?? 'This week')
                                  : (l10n?.earningsHistoryThisMonth ?? 'This month'),
                              style: BauhausDesign.getTextTheme(context)
                                  .headlineMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 220,
                            child: _buildChart(
                                state.summary?.history ?? [], context, ref),
                          ),
                          const SizedBox(height: 12),
                          _buildHistoryList(
                              state.summary?.history ?? const [], context),
                          const SizedBox(height: 20),
                          _buildTaxFrequencyControls(
                            context: context,
                            value: state.taxFrequency,
                            onChanged: viewModel.setTaxFrequency,
                          ),
                          const SizedBox(height: 12),
                          _buildTaxEstimator(
                            context,
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

  String _formatRangeLabel(
      EarningsPeriod period, DateTime start, DateTime end) {
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
                boxShadow: const [
                  BoxShadow(color: BauhausDesign.neutral, offset: Offset(2, 2))
                ],
                color: BauhausDesign.surfaceLight,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildToggleItem(
                    context: context,
                    label: AppLocalizations.of(context)!.weeklyToggle,
                    isSelected: period == EarningsPeriod.weekly,
                    onTap: () => onPeriodChanged(EarningsPeriod.weekly),
                  ),
                  Container(
                      width: 2, height: 40, color: BauhausDesign.textDark),
                  _buildToggleItem(
                    context: context,
                    label: AppLocalizations.of(context)!.monthlyToggle,
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
                  style: BauhausDesign.getTextTheme(context)
                      .headlineMedium
                      ?.copyWith(
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

  Widget _buildToggleItem(
      {required BuildContext context,
      required String label,
      required bool isSelected,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: isSelected ? BauhausDesign.textDark : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Text(
          label,
          style: BauhausDesign.getTextTheme(context).headlineMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? BauhausDesign.surfaceLight
                    : BauhausDesign.textDark,
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
          return AppLocalizations.of(context)!.taxFreqWeekly;
        case TaxFrequency.fortnightly:
          return AppLocalizations.of(context)!.taxFreqFortnightly;
        case TaxFrequency.monthly:
          return AppLocalizations.of(context)!.taxFreqMonthly;
        case TaxFrequency.annually:
          return AppLocalizations.of(context)!.taxFreqAnnually;
      }
    }

    return Row(
      children: [
        Text(
          AppLocalizations.of(context)!.taxFrequencyLabel,
          style: BauhausDesign.getTextTheme(context).headlineMedium?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: BauhausDesign.textDark),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: BauhausDesign.textDark, width: 2),
            borderRadius: BorderRadius.circular(0),
            boxShadow: const [
              BoxShadow(color: BauhausDesign.neutral, offset: Offset(2, 2))
            ],
            color: BauhausDesign.surfaceLight,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<TaxFrequency>(
              value: value,
              icon: const Icon(Icons.arrow_drop_down,
                  color: BauhausDesign.textDark),
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
                        style: BauhausDesign.getTextTheme(context)
                            .bodyMedium
                            ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: BauhausDesign.textDark),
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
      loading: () => SizedBox(
        height: 150,
        child: BauhausLoadingState(
            message: AppLocalizations.of(context)!.loadingOverview),
      ),
      error: (e, _) => Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(AppLocalizations.of(context)!
              .failedToLoadBusinessOverview(e.toString())),
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
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: BauhausDesign.neutral),
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
                        style: BauhausDesign.getTextTheme(context)
                            .displayLarge
                            ?.copyWith(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: BauhausDesign.success,
                            ),
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.totalEarningsTitle,
                      style: BauhausDesign.getTextTheme(context)
                          .labelLarge
                          ?.copyWith(
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
                        '${summary.totalHours.toStringAsFixed(1)} ${AppLocalizations.of(context)!.hoursAbbrev}',
                        style: BauhausDesign.getTextTheme(context)
                            .displaySmall
                            ?.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: BauhausDesign.textDark,
                            ),
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.totalHoursTitle,
                      style: BauhausDesign.getTextTheme(context)
                          .labelLarge
                          ?.copyWith(
                            color: BauhausDesign.textDark,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(
              height: 32, color: BauhausDesign.textDark, thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  AppLocalizations.of(context)!.payRateTitle(
                      currencyFormat.format(summary.payRate),
                      summary.payType == 'Hourly' ? 'HR' : 'YR'),
                  style:
                      BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
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
                  boxShadow: const [
                    BoxShadow(
                        color: BauhausDesign.textDark, offset: Offset(2, 2))
                  ],
                ),
                child: Text(
                  AppLocalizations.of(context)!.activeCaps,
                  style: BauhausDesign.getTextTheme(context)
                      .labelSmall
                      ?.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: BauhausDesign.textDark),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProjectedPayCard(
      ProjectedEarnings projection, BuildContext context) {
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
                  AppLocalizations.of(context)!.projectedPayUpcoming,
                  style: BauhausDesign.getTextTheme(context)
                      .headlineMedium
                      ?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
                style: BauhausDesign.getTextTheme(context)
                    .displayMedium
                    ?.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: BauhausDesign.secondary),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  '${projection.projectedHours.toStringAsFixed(1)} ${AppLocalizations.of(context)!.hoursAbbrev} ${AppLocalizations.of(context)!.scheduledSuffix}',
                  style:
                      BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
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
            Text(
              AppLocalizations.of(context)!.upcomingShifts,
              style: BauhausDesign.getTextTheme(context)
                  .headlineMedium
                  ?.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...projection.breakdown.take(3).map((item) => Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          DateFormat('MMM dd')
                              .format(DateTime.parse(item.date)),
                          style: BauhausDesign.getTextTheme(context)
                              .bodyMedium
                              ?.copyWith(color: BauhausDesign.textDark)),
                      Text(
                          '${item.hours} ${AppLocalizations.of(context)!.hoursAbbrev}',
                          style: BauhausDesign.getTextTheme(context)
                              .labelLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: BauhausDesign.textDark)),
                    ],
                  ),
                )),
          ]
        ],
      ),
    );
  }

  Widget _buildChart(
      List<EarningsHistoryItem> history, BuildContext context, WidgetRef ref) {
    if (history.isEmpty) {
      return Center(
        child: Text(AppLocalizations.of(context)!.noDataForChart,
            style: BauhausDesign.getTextTheme(context)
                .bodyMedium
                ?.copyWith(color: BauhausDesign.neutral)),
      );
    }

    final spots = history
        .asMap()
        .entries
        .map((entry) => FlSpot(entry.key.toDouble(), entry.value.earnings))
        .toList();
    final maxEarnings = spots
        .map((spot) => spot.y)
        .fold<double>(0.0, (prev, next) => next > prev ? next : prev);
    final maxY = math.max(1, maxEarnings * 1.2).toDouble();
    final highlighted = ref.watch(earningsChartHighlightProvider);
    final displayValue = highlighted ?? maxEarnings;
    final notifier = ref.read(earningsChartHighlightProvider.notifier);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF05050B),
            Color(0xFF0D0D14),
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 16),
              child: LineChart(
                LineChartData(
                  minY: 0,
                  maxY: maxY,
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 22,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 0 && value.toInt() < history.length) {
                            final date = DateTime.parse(history[value.toInt()].date);
                            return Text(DateFormat('dd').format(date),
                                style: BauhausDesign.getTextTheme(context)
                                    .labelSmall
                                    ?.copyWith(color: Colors.white70, fontSize: 10));
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    leftTitles:
                        const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles:
                        const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles:
                        const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  lineTouchData: LineTouchData(
                    getTouchedSpotIndicator: (barData, spotIndexes) => [],
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipColor: (_) => Colors.white70,
                      getTooltipItems: (spots) => spots
                          .map(
                            (spot) => LineTooltipItem(
                              '\$${spot.y.toStringAsFixed(0)}',
                              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          )
                          .toList(),
                    ),
                    touchCallback: (event, response) {
                      final spot = response?.lineBarSpots?.first;
                      if (spot != null) {
                        notifier.state = spot.y;
                        return;
                      }
                      if (event is FlPanEndEvent ||
                          event is FlTapUpEvent ||
                          event is FlLongPressEnd) {
                        notifier.state = null;
                      }
                    },
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      preventCurveOverShooting: true,
                      color: Colors.redAccent,
                      barWidth: 3,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            Colors.redAccent.withOpacity(0.2),
                            Colors.red.shade900.withOpacity(0.8),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      shadow: const Shadow(
                          blurRadius: 20, color: Color(0x99FF2E2E), offset: Offset(0, 10)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 16,
            top: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('EXPENSES',
                    style: BauhausDesign.getTextTheme(context)
                        .labelSmall
                        ?.copyWith(color: Colors.white70, letterSpacing: 1.5)),
                const SizedBox(height: 4),
                Text(
                  '\$${displayValue.toStringAsFixed(0)}',
                  style: BauhausDesign.getTextTheme(context)
                      .headlineMedium
                      ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList(
      List<EarningsHistoryItem> history, BuildContext context) {
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
                        style: BauhausDesign.getTextTheme(context)
                            .labelLarge
                            ?.copyWith(
                              color: BauhausDesign.textDark,
                            ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                        '${item.hours.toStringAsFixed(1)}${AppLocalizations.of(context)!.hoursAbbrev.toUpperCase()}',
                        style: BauhausDesign.getTextTheme(context).bodyMedium),
                    const SizedBox(width: 12),
                    Text(currencyFormat.format(item.earnings),
                        style: BauhausDesign.getTextTheme(context)
                            .bodyMedium
                            ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: BauhausDesign.success)),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildPayHistory(
      EarningsPeriodHistory? history, BuildContext context) {
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
      return '${DateFormat('MMM d').format(start)} – ${DateFormat('MMM d').format(end)}'
          .toUpperCase();
    }

    return Container(
      decoration: BauhausDesign.cardDecoration,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.payHistoryTitle,
            style: BauhausDesign.getTextTheme(context).headlineMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: BauhausDesign.textDark),
          ),
          const SizedBox(height: 12),
          ...history.items.reversed.take(8).map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(labelForItem(item),
                              style: BauhausDesign.getTextTheme(context)
                                  .bodyMedium
                                  ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: BauhausDesign.textDark))),
                      const SizedBox(width: 12),
                      Text('${item.hours.toStringAsFixed(1)}H',
                          style: BauhausDesign.getTextTheme(context)
                              .bodyMedium
                              ?.copyWith(color: BauhausDesign.textDark)),
                      const SizedBox(width: 12),
                      Text(currencyFormat.format(item.earnings),
                          style: BauhausDesign.getTextTheme(context)
                              .bodyMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: BauhausDesign.textDark)),
                    ],
                  ),
                ),
              ),
        ],
      ),
    );
  }

  Widget _buildTaxEstimator(
    BuildContext context,
    EarningsViewModel viewModel,
    double periodEarnings,
    TaxFrequency frequency,
  ) {
    final currencyFormat = NumberFormat.simpleCurrency();
    String frequencyLabel;
    switch (frequency) {
      case TaxFrequency.weekly:
        frequencyLabel = AppLocalizations.of(context)!.taxFreqWeekly;
        break;
      case TaxFrequency.fortnightly:
        frequencyLabel = AppLocalizations.of(context)!.taxFreqFortnightly;
        break;
      case TaxFrequency.monthly:
        frequencyLabel = AppLocalizations.of(context)!.taxFreqMonthly;
        break;
      case TaxFrequency.annually:
        frequencyLabel = AppLocalizations.of(context)!.taxFreqAnnually;
        break;
    }
    final estimated = viewModel.calculateTax(periodEarnings, frequency);

    return Container(
      decoration: BauhausDesign.cardDecoration,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!
                .taxEstimatorTitle(frequencyLabel.toUpperCase()),
            style: BauhausDesign.getTextTheme(context).headlineMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Text(AppLocalizations.of(context)!.taxEstimatorSubtitle,
              style: BauhausDesign.getTextTheme(context)
                  .bodyMedium
                  ?.copyWith(fontSize: 12, color: BauhausDesign.neutral)),
          const SizedBox(height: 16),
          _buildTaxRow(context, AppLocalizations.of(context)!.grossIncome,
              estimated['gross']!, currencyFormat,
              isBold: true),
          const Divider(color: BauhausDesign.textDark, thickness: 1),
          _buildTaxRow(context, AppLocalizations.of(context)!.estimatedTax,
              estimated['tax']!, currencyFormat,
              color: BauhausDesign.error),
          const Divider(color: BauhausDesign.textDark, thickness: 1),
          _buildTaxRow(context, AppLocalizations.of(context)!.netPay,
              estimated['net']!, currencyFormat,
              color: BauhausDesign.success, isBold: true),
        ],
      ),
    );
  }

  Widget _buildTaxRow(
      BuildContext context, String label, double value, NumberFormat format,
      {Color? color, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label.toUpperCase(),
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.w500)),
          Text(format.format(value),
              style: BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
                    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                    color: color ?? BauhausDesign.textDark,
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
