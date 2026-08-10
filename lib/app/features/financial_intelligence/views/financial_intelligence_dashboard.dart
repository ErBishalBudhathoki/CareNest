import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/features/financial_intelligence/viewmodels/cashflow_viewmodel.dart';
import 'package:carenest/app/features/financial_intelligence/viewmodels/financial_analytics_viewmodel.dart';
import 'package:carenest/app/features/financial_intelligence/viewmodels/revenue_forecasting_viewmodel.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FinancialIntelligenceDashboard extends ConsumerStatefulWidget {
  const FinancialIntelligenceDashboard({super.key});

  @override
  ConsumerState<FinancialIntelligenceDashboard> createState() =>
      _FinancialIntelligenceDashboardState();
}

class _FinancialIntelligenceDashboardState
    extends ConsumerState<FinancialIntelligenceDashboard> {
  String? _loadedOrgId;
  bool _isFetching = false;

  static const List<_PulseMetric> _fallbackPulseMetrics = [
    _PulseMetric(
      title: 'Cash Position',
      value: 'N/A',
      trend: 'Awaiting sync',
      accent: BauhausDesign.success,
      icon: Icons.account_balance_wallet_rounded,
    ),
    _PulseMetric(
      title: 'Receivables',
      value: 'N/A',
      trend: 'Awaiting sync',
      accent: BauhausDesign.primary,
      icon: Icons.receipt_long_rounded,
    ),
    _PulseMetric(
      title: 'Payables',
      value: 'N/A',
      trend: 'Awaiting sync',
      accent: BauhausDesign.warning,
      icon: Icons.request_quote_rounded,
    ),
    _PulseMetric(
      title: 'Gross Margin',
      value: 'N/A',
      trend: 'Awaiting sync',
      accent: BauhausDesign.secondary,
      icon: Icons.pie_chart_rounded,
    ),
  ];

  static const List<_FinancialModule> _modules = [
    _FinancialModule(
      title: 'Revenue Forecasting',
      description: 'Model recurring income and risk-adjusted upside.',
      icon: Icons.trending_up_rounded,
      accent: BauhausDesign.secondary,
    ),
    _FinancialModule(
      title: 'Pricing Lab',
      description: 'Stress-test service rates by demand and region.',
      icon: Icons.tune_rounded,
      accent: BauhausDesign.primary,
    ),
    _FinancialModule(
      title: 'Cashflow Radar',
      description: 'Detect short-term runway pressure and bottlenecks.',
      icon: Icons.radar_rounded,
      accent: BauhausDesign.accent,
    ),
    _FinancialModule(
      title: 'Cost Attribution',
      description: 'Map payroll and ops cost by service line.',
      icon: Icons.account_balance_wallet_rounded,
      accent: BauhausDesign.success,
    ),
    _FinancialModule(
      title: 'Ledger Hygiene',
      description: 'Flag duplicate charges and missing evidence trails.',
      icon: Icons.fact_check_rounded,
      accent: BauhausDesign.secondary,
    ),
    _FinancialModule(
      title: 'Debt Exposure',
      description: 'Monitor overdue risk by client and funding source.',
      icon: Icons.warning_amber_rounded,
      accent: BauhausDesign.warning,
    ),
  ];

  static const List<_RunwayPoint> _fallbackRunwayPoints = [
    _RunwayPoint(label: 'W1', value: 0, accent: BauhausDesign.secondary),
    _RunwayPoint(label: 'W2', value: 0, accent: BauhausDesign.primary),
    _RunwayPoint(label: 'W3', value: 0, accent: BauhausDesign.secondary),
    _RunwayPoint(label: 'W4', value: 0, accent: BauhausDesign.success),
    _RunwayPoint(label: 'W5', value: 0, accent: BauhausDesign.primary),
    _RunwayPoint(label: 'W6', value: 0, accent: BauhausDesign.success),
  ];

  static const List<_SignalItem> _fallbackSignals = [
    _SignalItem(
      title: 'No active cashflow alerts',
      subtitle: 'Backend did not return alert items for this organization.',
      timeLabel: 'now',
      severity: 'Info',
      accent: BauhausDesign.secondary,
      icon: Icons.insights_rounded,
    ),
  ];

  static const List<_ScenarioRow> _fallbackScenarios = [
    _ScenarioRow(
      name: 'Base Plan',
      revenue: 'N/A',
      margin: 'N/A',
      runway: 'N/A',
      confidence: 'N/A',
      accent: BauhausDesign.secondary,
    ),
    _ScenarioRow(
      name: 'Upside',
      revenue: 'N/A',
      margin: 'N/A',
      runway: 'N/A',
      confidence: 'N/A',
      accent: BauhausDesign.success,
    ),
    _ScenarioRow(
      name: 'Defensive',
      revenue: 'N/A',
      margin: 'N/A',
      runway: 'N/A',
      confidence: 'N/A',
      accent: BauhausDesign.warning,
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final orgId = ref.read(app_providers.organizationIdProvider);
      if (orgId != null && orgId.isNotEmpty) {
        _loadDashboardData(orgId);
      }
    });
  }

  Future<void> _loadDashboardData(
    String organizationId, {
    bool force = false,
  }) async {
    if (_isFetching && !force) return;
    if (!force && _loadedOrgId == organizationId) return;

    _loadedOrgId = organizationId;
    _isFetching = true;

    try {
      await Future.wait([
        ref
            .read(financialAnalyticsViewModelProvider.notifier)
            .getDashboard(organizationId: organizationId, period: '30d'),
        ref
            .read(financialAnalyticsViewModelProvider.notifier)
            .getKPIs(organizationId),
        ref
            .read(cashFlowViewModelProvider.notifier)
            .getCurrentPosition(organizationId),
        ref
            .read(cashFlowViewModelProvider.notifier)
            .forecastCashFlow(organizationId: organizationId, horizon: 60),
        ref.read(cashFlowViewModelProvider.notifier).getAlerts(organizationId),
        ref
            .read(revenueForecastingViewModelProvider.notifier)
            .generateScenarios(organizationId: organizationId, horizon: 90),
      ]);
    } finally {
      _isFetching = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final organizationId = ref.watch(app_providers.organizationIdProvider);
    final analyticsState = ref.watch(financialAnalyticsViewModelProvider);
    final cashState = ref.watch(cashFlowViewModelProvider);
    final revenueState = ref.watch(revenueForecastingViewModelProvider);

    if (organizationId != null &&
        organizationId.isNotEmpty &&
        _loadedOrgId != organizationId &&
        !_isFetching) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _loadDashboardData(organizationId);
        }
      });
    }

    final hasAnyData =
        analyticsState.dashboard != null ||
        analyticsState.kpis != null ||
        cashState.position != null ||
        cashState.forecast != null ||
        revenueState.scenarios != null;

    final isLoading =
        (analyticsState.isLoading ||
            cashState.isLoading ||
            revenueState.isLoading) &&
        !hasAnyData;

    final pulseMetrics = _buildLivePulseMetrics(analyticsState, cashState);
    final scenarios = _buildLiveScenarios(
      analyticsState,
      cashState,
      revenueState,
    );
    final runwayPoints = _buildLiveRunway(cashState);
    final signals = _buildLiveSignals(cashState);

    final totalCash =
        _readDouble(_dig(cashState.position, ['cash', 'total'])) ??
        _readDouble(
          _dig(analyticsState.dashboard, ['kpis', 'cashFlow', 'value']),
        ) ??
        0;
    final cashChange = _readDouble(
      _dig(analyticsState.dashboard, ['kpis', 'cashFlow', 'change']),
    );

    final runwayDays = _estimateRunwayDays(cashState);
    final projectedOutflows = _readDouble(
      _dig(cashState.forecast, ['summary', 'projectedOutflows']),
    );
    final horizon = _readDouble(_dig(cashState.forecast, ['horizon'])) ?? 60;
    final weeklyBurn = projectedOutflows != null && horizon > 0
        ? (projectedOutflows / horizon) * 7
        : null;

    final receivablesCurrent = _readDouble(
      _dig(cashState.position, ['receivables', 'current']),
    );
    final receivablesTotal = _readDouble(
      _dig(cashState.position, ['receivables', 'total']),
    );
    final collectionRate =
        (receivablesCurrent != null &&
            receivablesTotal != null &&
            receivablesTotal > 0)
        ? (receivablesCurrent / receivablesTotal)
        : null;

    final error = analyticsState.error ?? cashState.error ?? revenueState.error;

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: _buildAppBar(context),
      body: organizationId == null || organizationId.isEmpty
          ? _buildMissingOrganizationState(context)
          : isLoading
          ? const Center(child: BauhausLoadingState())
          : RefreshIndicator(
              color: BauhausDesign.primary,
              onRefresh: () => _loadDashboardData(organizationId, force: true),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        BauhausDesign.space4,
                        BauhausDesign.space4,
                        BauhausDesign.space4,
                        BauhausDesign.space8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (error != null) ...[
                            _buildErrorBanner(context, error),
                            const SizedBox(height: BauhausDesign.space4),
                          ],
                          _buildTreasuryBoard(
                            context,
                            netCashLabel: _formatCurrencyCompact(totalCash),
                            varianceLabel: cashChange != null
                                ? _formatSignedPercent(cashChange)
                                : 'N/A',
                            runwayLabel: runwayDays != null
                                ? '${runwayDays.toStringAsFixed(0)} days'
                                : 'N/A',
                            burnLabel: weeklyBurn != null
                                ? '${_formatCurrencyCompact(weeklyBurn)}/wk'
                                : 'N/A',
                            collectionLabel: collectionRate != null
                                ? _formatPercent(collectionRate)
                                : 'N/A',
                            pulseMetrics: pulseMetrics,
                          ),
                          const SizedBox(height: BauhausDesign.space6),
                          _buildScenarioTable(context, scenarios),
                          const SizedBox(height: BauhausDesign.space6),
                          _buildAllocationDesk(context),
                          const SizedBox(height: BauhausDesign.space6),
                          _buildLiquidityLadder(context, runwayPoints),
                          const SizedBox(height: BauhausDesign.space6),
                          _buildSignalTape(context, signals),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: BauhausDesign.primary,
      elevation: 0,
      titleSpacing: 0,
      title: Text(
        'FINANCIAL INTELLIGENCE',
        style: BauhausDesign.getTextTheme(context).headlineMedium?.copyWith(
          color: BauhausDesign.surfaceWhite,
          letterSpacing: 0.6,
          fontWeight: FontWeight.w700,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: BauhausDesign.surfaceWhite),
        onPressed: () => Navigator.pop(context),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(8),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(height: 8, color: BauhausDesign.secondary),
            ),
            Expanded(
              flex: 5,
              child: Container(height: 8, color: BauhausDesign.surfaceWhite),
            ),
            Expanded(
              flex: 2,
              child: Container(height: 8, color: BauhausDesign.accent),
            ),
            Expanded(
              flex: 3,
              child: Container(height: 8, color: BauhausDesign.success),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMissingOrganizationState(BuildContext context) {
    return Center(
      child: BauhausEmptyState(
        title: 'Organization Not Available',
        message:
            'Financial intelligence requires an organization context. Please re-login or select an organization.',
        icon: Icons.domain_disabled_rounded,
        actionLabel: 'RELOAD',
        onAction: () {
          final orgId = ref.read(app_providers.organizationIdProvider);
          if (orgId != null && orgId.isNotEmpty) {
            _loadDashboardData(orgId, force: true);
          }
        },
      ),
    );
  }

  Widget _buildErrorBanner(BuildContext context, String error) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: BauhausDesign.error.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: BauhausDesign.textDark,
            size: 18,
          ),
          const SizedBox(width: BauhausDesign.space2),
          Expanded(
            child: Text(
              error,
              style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTreasuryBoard(
    BuildContext context, {
    required String netCashLabel,
    required String varianceLabel,
    required String runwayLabel,
    required String burnLabel,
    required String collectionLabel,
    required List<_PulseMetric> pulseMetrics,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHard],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: BauhausDesign.accent.withValues(alpha: 0.2),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(BauhausDesign.radiusLg),
                  bottomLeft: Radius.circular(BauhausDesign.radiusMd),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: BauhausDesign.secondary.withValues(alpha: 0.18),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(BauhausDesign.radiusMd),
                  bottomLeft: Radius.circular(BauhausDesign.radiusLg),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final compact = constraints.maxWidth < 980;
                final left = _buildTreasuryMain(
                  context,
                  netCashLabel: netCashLabel,
                  varianceLabel: varianceLabel,
                  runwayLabel: runwayLabel,
                  burnLabel: burnLabel,
                  collectionLabel: collectionLabel,
                );
                final right = _buildTreasurySidebar(context, pulseMetrics);

                if (compact) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      left,
                      const SizedBox(height: BauhausDesign.space3),
                      right,
                    ],
                  );
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 6, child: left),
                    const SizedBox(width: BauhausDesign.space4),
                    Expanded(flex: 4, child: right),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTreasuryMain(
    BuildContext context, {
    required String netCashLabel,
    required String varianceLabel,
    required String runwayLabel,
    required String burnLabel,
    required String collectionLabel,
  }) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceOffWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildBadge(
                context,
                text: 'TREASURY BOARD',
                accent: BauhausDesign.primary,
              ),
              const SizedBox(width: BauhausDesign.space2),
              _buildBadge(
                context,
                text: 'LIVE API',
                accent: BauhausDesign.success,
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space3),
          Text(
            'Net Cash Position',
            style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
              color: BauhausDesign.textDark,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: BauhausDesign.space1),
          Text(
            netCashLabel,
            style: BauhausDesign.getTextTheme(context).displayLarge?.copyWith(
              color: BauhausDesign.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: BauhausDesign.space1),
          Text(
            'Cashflow change: $varianceLabel',
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
              color: BauhausDesign.textDark,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          Wrap(
            spacing: BauhausDesign.space2,
            runSpacing: BauhausDesign.space2,
            children: [
              _KpiChip(
                label: 'Runway',
                value: runwayLabel,
                accent: BauhausDesign.secondary,
              ),
              _KpiChip(
                label: 'Burn',
                value: burnLabel,
                accent: BauhausDesign.warning,
              ),
              _KpiChip(
                label: 'Net Collection',
                value: collectionLabel,
                accent: BauhausDesign.success,
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space3),
          Wrap(
            spacing: BauhausDesign.space2,
            runSpacing: BauhausDesign.space2,
            children: [
              _buildActionChip(
                context,
                label: 'Refresh Snapshot',
                icon: Icons.refresh_rounded,
                accent: BauhausDesign.secondary,
                onTap: () {
                  final orgId = ref.read(app_providers.organizationIdProvider);
                  if (orgId != null && orgId.isNotEmpty) {
                    _loadDashboardData(orgId, force: true);
                  }
                },
              ),
              _buildActionChip(
                context,
                label: 'Load Scenarios',
                icon: Icons.account_tree_rounded,
                accent: BauhausDesign.primary,
                onTap: () {
                  final orgId = ref.read(app_providers.organizationIdProvider);
                  if (orgId != null && orgId.isNotEmpty) {
                    ref
                        .read(revenueForecastingViewModelProvider.notifier)
                        .generateScenarios(organizationId: orgId, horizon: 90);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTreasurySidebar(
    BuildContext context,
    List<_PulseMetric> pulseMetrics,
  ) {
    final safe = pulseMetrics.isEmpty ? _fallbackPulseMetrics : pulseMetrics;
    final firstThree = safe.take(3).toList();

    return Column(
      children: [
        for (var i = 0; i < firstThree.length; i++) ...[
          _buildSidebarTile(context, metric: firstThree[i]),
          if (i != firstThree.length - 1)
            const SizedBox(height: BauhausDesign.space3),
        ],
      ],
    );
  }

  Widget _buildSidebarTile(
    BuildContext context, {
    required _PulseMetric metric,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: metric.accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceWhite,
              borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
              border: Border.all(color: BauhausDesign.neutral),
            ),
            child: Icon(metric.icon, color: BauhausDesign.textDark, size: 18),
          ),
          const SizedBox(width: BauhausDesign.space2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  metric.title,
                  style: BauhausDesign.getTextTheme(context).labelSmall
                      ?.copyWith(
                        color: BauhausDesign.textDark,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  metric.value,
                  style: BauhausDesign.getTextTheme(context).titleMedium
                      ?.copyWith(
                        color: BauhausDesign.textDark,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                Text(
                  metric.trend,
                  style: BauhausDesign.getTextTheme(context).bodySmall
                      ?.copyWith(
                        color: metric.accent,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScenarioTable(
    BuildContext context,
    List<_ScenarioRow> scenarios,
  ) {
    final rows = scenarios.isEmpty ? _fallbackScenarios : scenarios;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BauhausSectionHeader(
          title: 'Scenario Table',
          subtitle: 'Base, upside, and defensive envelopes from live forecast.',
        ),
        const SizedBox(height: BauhausDesign.space3),
        Container(
          padding: const EdgeInsets.all(BauhausDesign.space3),
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceWhite,
            borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
            border: Border.all(color: BauhausDesign.neutral, width: 2),
            boxShadow: const [BauhausDesign.shadowHardSm],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxWidth < 860;

              if (compact) {
                return Column(
                  children: [
                    for (var i = 0; i < rows.length; i++) ...[
                      _buildScenarioCard(context, rows[i]),
                      if (i != rows.length - 1)
                        const SizedBox(height: BauhausDesign.space2),
                    ],
                  ],
                );
              }

              return Column(
                children: [
                  _buildScenarioHeader(context),
                  for (var i = 0; i < rows.length; i++) ...[
                    _buildScenarioRow(context, rows[i]),
                    if (i != rows.length - 1)
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: BauhausDesign.space2,
                        ),
                        height: 1,
                        color: BauhausDesign.neutral.withValues(alpha: 0.22),
                      ),
                  ],
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildScenarioHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space2,
        vertical: BauhausDesign.space2,
      ),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceOffWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        border: Border.all(color: BauhausDesign.neutral, width: 1),
      ),
      child: Row(
        children: [
          _buildHeaderCell(context, 'Scenario', flex: 3, alignRight: false),
          _buildHeaderCell(context, 'Revenue', flex: 2),
          _buildHeaderCell(context, 'Margin', flex: 2),
          _buildHeaderCell(context, 'Runway', flex: 2),
          _buildHeaderCell(context, 'Confidence', flex: 2),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(
    BuildContext context,
    String text, {
    int flex = 1,
    bool alignRight = true,
  }) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        textAlign: alignRight ? TextAlign.right : TextAlign.left,
        style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
          color: BauhausDesign.textDark,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildScenarioRow(BuildContext context, _ScenarioRow row) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space2,
        vertical: BauhausDesign.space2,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 32,
                  decoration: BoxDecoration(
                    color: row.accent,
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusXs),
                  ),
                ),
                const SizedBox(width: BauhausDesign.space2),
                Expanded(
                  child: Text(
                    row.name,
                    style: BauhausDesign.getTextTheme(context).labelLarge
                        ?.copyWith(
                          color: BauhausDesign.textDark,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              row.revenue,
              textAlign: TextAlign.right,
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              row.margin,
              textAlign: TextAlign.right,
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              row.runway,
              textAlign: TextAlign.right,
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: BauhausDesign.space2,
                  vertical: BauhausDesign.space1,
                ),
                decoration: BoxDecoration(
                  color: row.accent.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  border: Border.all(color: BauhausDesign.neutral),
                ),
                child: Text(
                  row.confidence,
                  style: BauhausDesign.getTextTheme(context).labelSmall
                      ?.copyWith(
                        color: BauhausDesign.textDark,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScenarioCard(BuildContext context, _ScenarioRow row) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceOffWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 9,
                height: 30,
                decoration: BoxDecoration(
                  color: row.accent,
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusXs),
                ),
              ),
              const SizedBox(width: BauhausDesign.space2),
              Expanded(
                child: Text(
                  row.name,
                  style: BauhausDesign.getTextTheme(context).labelLarge
                      ?.copyWith(
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
                  color: row.accent.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  border: Border.all(color: BauhausDesign.neutral),
                ),
                child: Text(
                  row.confidence,
                  style: BauhausDesign.getTextTheme(context).labelSmall
                      ?.copyWith(
                        color: BauhausDesign.textDark,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space2),
          Row(
            children: [
              Expanded(child: _buildMiniCell(context, 'Revenue', row.revenue)),
              const SizedBox(width: BauhausDesign.space2),
              Expanded(child: _buildMiniCell(context, 'Margin', row.margin)),
              const SizedBox(width: BauhausDesign.space2),
              Expanded(child: _buildMiniCell(context, 'Runway', row.runway)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniCell(BuildContext context, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space2),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        border: Border.all(color: BauhausDesign.neutral, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
              color: BauhausDesign.textMuted,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
              color: BauhausDesign.textDark,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllocationDesk(BuildContext context) {
    final lanes = [
      _DeskLane(
        title: 'Growth Levers',
        accent: BauhausDesign.secondary,
        modules: _modules.sublist(0, 2),
      ),
      _DeskLane(
        title: 'Liquidity Control',
        accent: BauhausDesign.primary,
        modules: _modules.sublist(2, 4),
      ),
      _DeskLane(
        title: 'Risk Governance',
        accent: BauhausDesign.warning,
        modules: _modules.sublist(4, 6),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BauhausSectionHeader(
          title: 'Allocation Desk',
          subtitle:
              'Capital and control programs grouped by finance objective.',
          action: _buildBadge(
            context,
            text: '${_modules.length} MODULES',
            accent: BauhausDesign.secondary,
          ),
        ),
        const SizedBox(height: BauhausDesign.space3),
        LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 1100;

            if (compact) {
              return Column(
                children: [
                  for (var i = 0; i < lanes.length; i++) ...[
                    _buildDeskLane(context, lanes[i]),
                    if (i != lanes.length - 1)
                      const SizedBox(height: BauhausDesign.space3),
                  ],
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: lanes
                  .asMap()
                  .entries
                  .map(
                    (entry) => Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: entry.key == lanes.length - 1
                              ? 0
                              : BauhausDesign.space3,
                        ),
                        child: _buildDeskLane(context, entry.value),
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildDeskLane(BuildContext context, _DeskLane lane) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space3,
              vertical: BauhausDesign.space2,
            ),
            decoration: BoxDecoration(
              color: lane.accent.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
              border: Border.all(color: BauhausDesign.neutral, width: 1.2),
            ),
            child: Text(
              lane.title,
              style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          for (var i = 0; i < lane.modules.length; i++) ...[
            _buildLaneAction(context, lane.modules[i]),
            if (i != lane.modules.length - 1)
              const SizedBox(height: BauhausDesign.space2),
          ],
        ],
      ),
    );
  }

  Widget _buildLaneAction(BuildContext context, _FinancialModule module) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _showComingSoon(context, module.title),
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        child: Container(
          padding: const EdgeInsets.all(BauhausDesign.space3),
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceOffWhite,
            borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
            border: Border.all(color: BauhausDesign.neutral, width: 1.2),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: module.accent.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  border: Border.all(color: BauhausDesign.neutral),
                ),
                child: Icon(
                  module.icon,
                  size: 18,
                  color: BauhausDesign.textDark,
                ),
              ),
              const SizedBox(width: BauhausDesign.space2),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      module.title,
                      style: BauhausDesign.getTextTheme(context).labelLarge
                          ?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    Text(
                      module.description,
                      style: BauhausDesign.getTextTheme(context).bodySmall
                          ?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: BauhausDesign.space2),
              const Icon(
                Icons.arrow_forward_rounded,
                size: 16,
                color: BauhausDesign.textDark,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLiquidityLadder(
    BuildContext context,
    List<_RunwayPoint> runwayPoints,
  ) {
    final points = runwayPoints.isEmpty ? _fallbackRunwayPoints : runwayPoints;
    final maxValue = points.fold<double>(
      0,
      (max, point) => point.value > max ? point.value : max,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BauhausSectionHeader(
          title: 'Liquidity Ladder',
          subtitle: 'Week-by-week runway level from live cash flow forecasts.',
        ),
        const SizedBox(height: BauhausDesign.space3),
        Container(
          padding: const EdgeInsets.all(BauhausDesign.space4),
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceWhite,
            borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
            border: Border.all(color: BauhausDesign.neutral, width: 2),
            boxShadow: const [BauhausDesign.shadowHard],
          ),
          child: Column(
            children: [
              for (var i = 0; i < points.length; i++) ...[
                _buildLadderRow(context, points[i], maxValue),
                if (i != points.length - 1)
                  const SizedBox(height: BauhausDesign.space2),
              ],
              const SizedBox(height: BauhausDesign.space3),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(BauhausDesign.space3),
                decoration: BoxDecoration(
                  color: BauhausDesign.surfaceOffWhite,
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                  border: Border.all(color: BauhausDesign.neutral, width: 1.2),
                ),
                child: Text(
                  'Signal: ladder is generated from backend position and forecast data for your organization.',
                  style: BauhausDesign.getTextTheme(context).bodySmall
                      ?.copyWith(
                        color: BauhausDesign.textDark,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLadderRow(
    BuildContext context,
    _RunwayPoint point,
    double maxValue,
  ) {
    final ratio = maxValue == 0 ? 0.0 : point.value / maxValue;

    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 560;

        if (compact) {
          return Container(
            padding: const EdgeInsets.all(BauhausDesign.space2),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceOffWhite,
              borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
              border: Border.all(color: BauhausDesign.neutral, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      point.label,
                      style: BauhausDesign.getTextTheme(context).labelLarge
                          ?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const Spacer(),
                    Text(
                      '${point.value.toStringAsFixed(0)}d',
                      style: BauhausDesign.getTextTheme(context).labelSmall
                          ?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: BauhausDesign.space1),
                Container(
                  height: 14,
                  decoration: BoxDecoration(
                    color: BauhausDesign.surfaceWhite,
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                    border: Border.all(color: BauhausDesign.neutral),
                  ),
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: ratio,
                    child: Container(
                      decoration: BoxDecoration(
                        color: point.accent.withValues(alpha: 0.76),
                        borderRadius: BorderRadius.circular(
                          BauhausDesign.radiusSm,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return Row(
          children: [
            SizedBox(
              width: 42,
              child: Text(
                point.label,
                style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 14,
                decoration: BoxDecoration(
                  color: BauhausDesign.surfaceOffWhite,
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  border: Border.all(color: BauhausDesign.neutral),
                ),
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: ratio,
                  child: Container(
                    decoration: BoxDecoration(
                      color: point.accent.withValues(alpha: 0.76),
                      borderRadius: BorderRadius.circular(
                        BauhausDesign.radiusSm,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: BauhausDesign.space2),
            SizedBox(
              width: 52,
              child: Text(
                '${point.value.toStringAsFixed(0)}d',
                textAlign: TextAlign.right,
                style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSignalTape(BuildContext context, List<_SignalItem> signals) {
    final entries = signals.isEmpty ? _fallbackSignals : signals;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BauhausSectionHeader(
          title: 'Signal Tape',
          subtitle: 'Rolling events from live cashflow and analytics APIs.',
        ),
        const SizedBox(height: BauhausDesign.space3),
        Container(
          padding: const EdgeInsets.symmetric(vertical: BauhausDesign.space3),
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceWhite,
            borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
            border: Border.all(color: BauhausDesign.neutral, width: 2),
            boxShadow: const [BauhausDesign.shadowHard],
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space3,
            ),
            child: Row(
              children: [
                for (var i = 0; i < entries.length; i++) ...[
                  _buildTapeCard(context, entries[i]),
                  if (i != entries.length - 1)
                    const SizedBox(width: BauhausDesign.space3),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTapeCard(BuildContext context, _SignalItem item) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: item.accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: BauhausDesign.surfaceWhite,
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  border: Border.all(color: BauhausDesign.neutral),
                ),
                child: Icon(item.icon, size: 18, color: BauhausDesign.textDark),
              ),
              const SizedBox(width: BauhausDesign.space2),
              Expanded(
                child: Text(
                  item.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: BauhausDesign.getTextTheme(context).labelLarge
                      ?.copyWith(
                        color: BauhausDesign.textDark,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space2),
          Text(
            item.subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
              color: BauhausDesign.textDark,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: BauhausDesign.space2),
          Row(
            children: [
              Text(
                item.timeLabel,
                style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                  color: BauhausDesign.textMuted,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: BauhausDesign.space2,
                  vertical: BauhausDesign.space1,
                ),
                decoration: BoxDecoration(
                  color: item.accent.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  border: Border.all(color: BauhausDesign.neutral),
                ),
                child: Text(
                  item.severity.toUpperCase(),
                  style: BauhausDesign.getTextTheme(context).labelSmall
                      ?.copyWith(
                        color: BauhausDesign.textDark,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionChip(
    BuildContext context, {
    required String label,
    required IconData icon,
    required Color accent,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: BauhausDesign.space3,
            vertical: BauhausDesign.space2,
          ),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
            border: Border.all(color: BauhausDesign.neutral, width: 1.2),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: BauhausDesign.textDark),
              const SizedBox(width: BauhausDesign.space1),
              Text(
                label,
                style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(
    BuildContext context, {
    required String text,
    required Color accent,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space2,
        vertical: BauhausDesign.space1,
      ),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        border: Border.all(color: BauhausDesign.neutral, width: 1.1),
      ),
      child: Text(
        text,
        style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
          color: BauhausDesign.textDark,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context, String moduleTitle) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$moduleTitle module is ready for integration.'),
        backgroundColor: BauhausDesign.secondary,
      ),
    );
  }

  List<_PulseMetric> _buildLivePulseMetrics(
    FinancialAnalyticsState analyticsState,
    CashFlowState cashState,
  ) {
    final cashTotal = _readDouble(_dig(cashState.position, ['cash', 'total']));
    final receivables = _readDouble(
      _dig(cashState.position, ['receivables', 'total']),
    );
    final payables = _readDouble(
      _dig(cashState.position, ['payables', 'total']),
    );
    final payablesOverdue = _readDouble(
      _dig(cashState.position, ['payables', 'overdue']),
    );

    final revenueChange = _readDouble(
      _dig(analyticsState.dashboard, ['kpis', 'revenue', 'change']),
    );
    final profitChange = _readDouble(
      _dig(analyticsState.dashboard, ['kpis', 'profit', 'change']),
    );
    final margin =
        _readDouble(_dig(analyticsState.kpis, ['financial', 'grossMargin'])) ??
        _readDouble(
          _dig(analyticsState.dashboard, ['kpis', 'margin', 'value']),
        );
    final marginChange = _readDouble(
      _dig(analyticsState.dashboard, ['kpis', 'margin', 'change']),
    );
    final hasData =
        cashTotal != null ||
        receivables != null ||
        payables != null ||
        margin != null;

    if (!hasData) {
      return _fallbackPulseMetrics;
    }

    final payablesTrend =
        (payables != null && payables > 0 && payablesOverdue != null)
        ? '${_formatPercent(payablesOverdue / payables)} overdue'
        : 'N/A';

    final live = [
      _PulseMetric(
        title: 'Cash Position',
        value: cashTotal != null ? _formatCurrencyCompact(cashTotal) : 'N/A',
        trend: revenueChange != null
            ? _formatSignedPercent(revenueChange)
            : 'N/A',
        accent: BauhausDesign.success,
        icon: Icons.account_balance_wallet_rounded,
      ),
      _PulseMetric(
        title: 'Receivables',
        value: receivables != null
            ? _formatCurrencyCompact(receivables)
            : 'N/A',
        trend: profitChange != null
            ? _formatSignedPercent(profitChange)
            : 'N/A',
        accent: BauhausDesign.primary,
        icon: Icons.receipt_long_rounded,
      ),
      _PulseMetric(
        title: 'Payables',
        value: payables != null ? _formatCurrencyCompact(payables) : 'N/A',
        trend: payablesTrend,
        accent: BauhausDesign.warning,
        icon: Icons.request_quote_rounded,
      ),
      _PulseMetric(
        title: 'Gross Margin',
        value: margin != null ? _formatPercent(margin) : 'N/A',
        trend: marginChange != null
            ? _formatSignedPercent(marginChange)
            : 'N/A',
        accent: BauhausDesign.secondary,
        icon: Icons.pie_chart_rounded,
      ),
    ];

    return live;
  }

  List<_ScenarioRow> _buildLiveScenarios(
    FinancialAnalyticsState analyticsState,
    CashFlowState cashState,
    RevenueForecastingState revenueState,
  ) {
    final baseRevenue =
        _readDouble(
          _dig(analyticsState.dashboard, ['kpis', 'revenue', 'value']),
        ) ??
        _readDouble(_dig(analyticsState.kpis, ['financial', 'revenue']));
    final baseMargin =
        _readDouble(_dig(analyticsState.kpis, ['financial', 'grossMargin'])) ??
        _readDouble(
          _dig(analyticsState.dashboard, ['kpis', 'margin', 'value']),
        );
    final baseRunway = _estimateRunwayDays(cashState);

    final scenarios = _asMap(revenueState.scenarios);
    if (scenarios == null || scenarios.isEmpty) {
      if (baseRevenue != null) {
        return [
          _ScenarioRow(
            name: 'Base Plan',
            revenue: _formatCurrencyCompact(baseRevenue),
            margin: baseMargin != null ? _formatPercent(baseMargin) : 'N/A',
            runway: baseRunway != null
                ? '${baseRunway.toStringAsFixed(0)}d'
                : 'N/A',
            confidence: 'N/A',
            accent: BauhausDesign.secondary,
          ),
          _ScenarioRow(
            name: 'Upside',
            revenue: _formatCurrencyCompact(baseRevenue * 1.1),
            margin: baseMargin != null
                ? _formatPercent((baseMargin * 1.05).toDouble())
                : 'N/A',
            runway: baseRunway != null
                ? '${(baseRunway * 1.08).clamp(1, 999).toStringAsFixed(0)}d'
                : 'N/A',
            confidence: 'N/A',
            accent: BauhausDesign.success,
          ),
          _ScenarioRow(
            name: 'Defensive',
            revenue: _formatCurrencyCompact(baseRevenue * 0.9),
            margin: baseMargin != null
                ? _formatPercent((baseMargin * 0.93).toDouble())
                : 'N/A',
            runway: baseRunway != null
                ? '${(baseRunway * 0.88).clamp(1, 999).toStringAsFixed(0)}d'
                : 'N/A',
            confidence: 'N/A',
            accent: BauhausDesign.warning,
          ),
        ];
      }
      return _fallbackScenarios;
    }

    _ScenarioRow mapScenario(String key, String label, Color accent) {
      final data = _asMap(scenarios[key]);
      final revenue = _readDouble(_dig(data, ['totalRevenue']));
      final growth = _readDouble(_dig(data, ['growth'])) ?? 0;
      final probability = _readDouble(_dig(data, ['probability']));

      final scenarioMargin = baseMargin != null
          ? _formatPercent(baseMargin * (1 + (growth * 0.3)))
          : 'N/A';
      final scenarioRunway = baseRunway != null
          ? '${(baseRunway * (1 + (growth * 0.6))).clamp(1, 999).toStringAsFixed(0)}d'
          : 'N/A';

      return _ScenarioRow(
        name: label,
        revenue: revenue != null ? _formatCurrencyCompact(revenue) : 'N/A',
        margin: scenarioMargin,
        runway: scenarioRunway,
        confidence: probability != null ? _formatPercent(probability) : 'N/A',
        accent: accent,
      );
    }

    return [
      mapScenario('mostLikely', 'Base Plan', BauhausDesign.secondary),
      mapScenario('bestCase', 'Upside', BauhausDesign.success),
      mapScenario('worstCase', 'Defensive', BauhausDesign.warning),
    ];
  }

  List<_RunwayPoint> _buildLiveRunway(CashFlowState cashState) {
    final forecast = _asMap(cashState.forecast);
    if (forecast == null) {
      final estimated = _estimateRunwayDays(cashState);
      return estimated != null
          ? _buildDerivedRunwayPoints(estimated)
          : _fallbackRunwayPoints;
    }

    final horizon = (_readDouble(_dig(forecast, ['horizon'])) ?? 60).toInt();
    final projectedOutflows = _readDouble(
      _dig(forecast, ['summary', 'projectedOutflows']),
    );
    final dailyOutflow = (projectedOutflows != null && horizon > 0)
        ? projectedOutflows / horizon
        : null;

    final daily = _asList(_dig(forecast, ['dailyForecast']));
    if (daily.isEmpty || dailyOutflow == null || dailyOutflow <= 0) {
      final estimated = _estimateRunwayDays(cashState);
      return estimated != null
          ? _buildDerivedRunwayPoints(estimated)
          : _fallbackRunwayPoints;
    }

    final points = <_RunwayPoint>[];
    for (var i = 0; i < 6; i++) {
      final idx = (((daily.length - 1) * (i + 1)) / 6).round().clamp(
        0,
        daily.length - 1,
      );
      final item = _asMap(daily[idx]);
      final closingBalance = _readDouble(_dig(item, ['closingBalance'])) ?? 0;
      final runwayDays = (closingBalance / dailyOutflow)
          .clamp(0, 999)
          .toDouble();

      points.add(
        _RunwayPoint(
          label: 'W${i + 1}',
          value: runwayDays,
          accent: [
            BauhausDesign.secondary,
            BauhausDesign.primary,
            BauhausDesign.secondary,
            BauhausDesign.success,
            BauhausDesign.primary,
            BauhausDesign.success,
          ][i],
        ),
      );
    }

    return points;
  }

  List<_RunwayPoint> _buildDerivedRunwayPoints(double baseDays) {
    final safeBase = baseDays.clamp(1, 999).toDouble();
    const adjustments = [1.0, 0.96, 0.92, 0.88, 0.84, 0.8];
    const accents = [
      BauhausDesign.secondary,
      BauhausDesign.primary,
      BauhausDesign.secondary,
      BauhausDesign.success,
      BauhausDesign.primary,
      BauhausDesign.success,
    ];

    return List.generate(6, (index) {
      final days = (safeBase * adjustments[index]).clamp(1, 999).toDouble();
      return _RunwayPoint(
        label: 'W${index + 1}',
        value: days,
        accent: accents[index],
      );
    });
  }

  List<_SignalItem> _buildLiveSignals(CashFlowState cashState) {
    final alerts = _asList(cashState.alerts);
    if (alerts.isEmpty) return _fallbackSignals;

    final mapped = alerts.take(4).map((entry) {
      final alert = _asMap(entry) ?? const <String, dynamic>{};
      final type = (alert['type'] ?? 'alert').toString();
      final severity = (alert['severity'] ?? 'info').toString();
      final message = (alert['message'] ?? type).toString();
      final action = (alert['action'] ?? 'Review in operations console.')
          .toString();
      final timeLabel = _formatDateLabel(alert['dueDate']) ?? 'recent';

      return _SignalItem(
        title: message,
        subtitle: action,
        timeLabel: timeLabel,
        severity: severity,
        accent: _severityColor(severity),
        icon: _signalIcon(type),
      );
    }).toList();

    return mapped.isEmpty ? _fallbackSignals : mapped;
  }

  double? _estimateRunwayDays(CashFlowState cashState) {
    final cashTotal = _readDouble(_dig(cashState.position, ['cash', 'total']));
    final projectedOutflows = _readDouble(
      _dig(cashState.forecast, ['summary', 'projectedOutflows']),
    );
    final horizon = _readDouble(_dig(cashState.forecast, ['horizon'])) ?? 60;

    if (cashTotal == null ||
        projectedOutflows == null ||
        projectedOutflows <= 0) {
      return null;
    }

    final dailyOutflow = projectedOutflows / horizon;
    if (dailyOutflow <= 0) return null;
    return cashTotal / dailyOutflow;
  }

  dynamic _dig(dynamic data, List<Object> path) {
    dynamic current = data;
    for (final key in path) {
      if (current is Map && current.containsKey(key)) {
        current = current[key];
      } else if (current is List &&
          key is int &&
          key >= 0 &&
          key < current.length) {
        current = current[key];
      } else {
        return null;
      }
    }
    return current;
  }

  Map<String, dynamic>? _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return null;
  }

  List<dynamic> _asList(dynamic value) {
    if (value is List) return value;
    return const [];
  }

  double? _readDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is String) {
      final cleaned = value.replaceAll(RegExp(r'[^0-9.-]'), '');
      return double.tryParse(cleaned);
    }
    return null;
  }

  String _formatCurrencyCompact(double value) {
    final abs = value.abs();
    final sign = value < 0 ? '-' : '';
    if (abs >= 1000000) {
      return '${sign}AUD ${(abs / 1000000).toStringAsFixed(2)}M';
    }
    if (abs >= 1000) {
      return '${sign}AUD ${(abs / 1000).toStringAsFixed(1)}K';
    }
    return '${sign}AUD ${abs.toStringAsFixed(0)}';
  }

  String _formatPercent(double value) {
    final normalized = value.abs() <= 1 ? value * 100 : value;
    return '${normalized.toStringAsFixed(1)}%';
  }

  String _formatSignedPercent(double value) {
    final normalized = value.abs() <= 1 ? value * 100 : value;
    final sign = normalized >= 0 ? '+' : '';
    return '$sign${normalized.toStringAsFixed(1)}%';
  }

  String? _formatDateLabel(dynamic value) {
    if (value == null) return null;
    DateTime? dt;
    if (value is String) {
      dt = DateTime.tryParse(value);
    }
    if (dt == null) return null;

    final now = DateTime.now();
    final diff = dt.difference(now).inHours;
    if (diff.abs() < 24) {
      final hours = diff.abs();
      return diff >= 0 ? 'in ${hours}h' : '${hours}h ago';
    }

    final days = dt.difference(now).inDays;
    if (days >= 0) return 'in ${days}d';
    return '${days.abs()}d ago';
  }

  Color _severityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'high':
      case 'critical':
        return BauhausDesign.error;
      case 'medium':
      case 'watch':
        return BauhausDesign.warning;
      case 'low':
      case 'stable':
      case 'resolved':
        return BauhausDesign.success;
      default:
        return BauhausDesign.secondary;
    }
  }

  IconData _signalIcon(String type) {
    switch (type.toLowerCase()) {
      case 'low_cash':
        return Icons.account_balance_wallet_rounded;
      case 'overdue_receivables':
        return Icons.warning_amber_rounded;
      case 'concentration_risk':
        return Icons.pie_chart_rounded;
      default:
        return Icons.insights_rounded;
    }
  }
}

class _ScenarioRow {
  final String name;
  final String revenue;
  final String margin;
  final String runway;
  final String confidence;
  final Color accent;

  const _ScenarioRow({
    required this.name,
    required this.revenue,
    required this.margin,
    required this.runway,
    required this.confidence,
    required this.accent,
  });
}

class _DeskLane {
  final String title;
  final Color accent;
  final List<_FinancialModule> modules;

  _DeskLane({required this.title, required this.accent, required this.modules});
}

class _PulseMetric {
  final String title;
  final String value;
  final String trend;
  final Color accent;
  final IconData icon;

  const _PulseMetric({
    required this.title,
    required this.value,
    required this.trend,
    required this.accent,
    required this.icon,
  });
}

class _FinancialModule {
  final String title;
  final String description;
  final IconData icon;
  final Color accent;

  const _FinancialModule({
    required this.title,
    required this.description,
    required this.icon,
    required this.accent,
  });
}

class _RunwayPoint {
  final String label;
  final double value;
  final Color accent;

  const _RunwayPoint({
    required this.label,
    required this.value,
    required this.accent,
  });
}

class _SignalItem {
  final String title;
  final String subtitle;
  final String timeLabel;
  final String severity;
  final Color accent;
  final IconData icon;

  const _SignalItem({
    required this.title,
    required this.subtitle,
    required this.timeLabel,
    required this.severity,
    required this.accent,
    required this.icon,
  });
}

class _KpiChip extends StatelessWidget {
  final String label;
  final String value;
  final Color accent;

  const _KpiChip({
    required this.label,
    required this.value,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space2,
        vertical: BauhausDesign.space2,
      ),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        border: Border.all(color: BauhausDesign.neutral, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
              color: BauhausDesign.textDark,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
              color: BauhausDesign.textDark,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
