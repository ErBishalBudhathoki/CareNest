import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/features/workforce_optimization/viewmodels/business_intelligence_viewmodel.dart';
import 'package:carenest/app/features/workforce_optimization/viewmodels/quality_assurance_viewmodel.dart';
import 'package:carenest/app/features/workforce_optimization/viewmodels/resource_allocation_viewmodel.dart';
import 'package:carenest/app/features/workforce_optimization/viewmodels/workforce_planning_viewmodel.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkforceOptimizationDashboard extends ConsumerStatefulWidget {
  const WorkforceOptimizationDashboard({super.key});

  @override
  ConsumerState<WorkforceOptimizationDashboard> createState() =>
      _WorkforceOptimizationDashboardState();
}

class _WorkforceOptimizationDashboardState
    extends ConsumerState<WorkforceOptimizationDashboard> {
  String? _loadedOrgId;
  bool _isFetching = false;

  static const List<_CapabilityLane> _lanes = [
    _CapabilityLane(
      title: 'Plan',
      subtitle: 'Demand and assignment architecture',
      accent: BauhausDesign.secondary,
      modules: [
        _WorkforceModule(
          title: 'Workforce Planning',
          description: 'Shape staffing against forecasted demand windows.',
          icon: Icons.groups_rounded,
          accent: BauhausDesign.secondary,
          route: Routes.workforcePlanning,
        ),
        _WorkforceModule(
          title: 'Resource Allocation',
          description: 'Assign by skill mix, geography, and continuity goals.',
          icon: Icons.route_rounded,
          accent: BauhausDesign.primary,
          route: Routes.resourceAllocation,
        ),
      ],
    ),
    _CapabilityLane(
      title: 'Execute',
      subtitle: 'Quality and throughput control',
      accent: BauhausDesign.primary,
      modules: [
        _WorkforceModule(
          title: 'Performance Analytics',
          description: 'Track productivity and reliability trends.',
          icon: Icons.query_stats_rounded,
          accent: BauhausDesign.success,
          route: Routes.performanceAnalytics,
        ),
        _WorkforceModule(
          title: 'Quality Assurance',
          description: 'Detect delivery variance and compliance gaps.',
          icon: Icons.verified_user_rounded,
          accent: BauhausDesign.warning,
          route: Routes.qualityAssurance,
        ),
      ],
    ),
    _CapabilityLane(
      title: 'Optimize',
      subtitle: 'Business intelligence and reporting',
      accent: BauhausDesign.accent,
      modules: [
        _WorkforceModule(
          title: 'Business Intelligence',
          description: 'Connect operations to financial and service outcomes.',
          icon: Icons.analytics_rounded,
          accent: BauhausDesign.primary,
          route: Routes.businessIntelligence,
        ),
        _WorkforceModule(
          title: 'Report Builder',
          description: 'Generate tailored dashboards and executive packs.',
          icon: Icons.description_rounded,
          accent: BauhausDesign.accent,
          route: Routes.reportBuilder,
        ),
      ],
    ),
  ];

  static const List<_CommandMetric> _commandMetrics = [
    _CommandMetric(
      label: 'Schedule Fill',
      value: '96.2%',
      delta: '+1.8%',
      accent: BauhausDesign.success,
      icon: Icons.event_available_rounded,
    ),
    _CommandMetric(
      label: 'Utilization',
      value: '89%',
      delta: '+2.4%',
      accent: BauhausDesign.secondary,
      icon: Icons.timelapse_rounded,
    ),
    _CommandMetric(
      label: 'OT Hours',
      value: '62h',
      delta: '-11h',
      accent: BauhausDesign.warning,
      icon: Icons.access_time_filled_rounded,
    ),
    _CommandMetric(
      label: 'QA Pass',
      value: '94.7%',
      delta: '+0.9%',
      accent: BauhausDesign.primary,
      icon: Icons.fact_check_rounded,
    ),
  ];

  static const List<_CoverageDay> _coverage = [
    _CoverageDay(day: 'Mon', morning: 0.82, afternoon: 0.88, evening: 0.74),
    _CoverageDay(day: 'Tue', morning: 0.85, afternoon: 0.91, evening: 0.77),
    _CoverageDay(day: 'Wed', morning: 0.88, afternoon: 0.94, evening: 0.8),
    _CoverageDay(day: 'Thu', morning: 0.9, afternoon: 0.95, evening: 0.82),
    _CoverageDay(day: 'Fri', morning: 0.87, afternoon: 0.9, evening: 0.78),
    _CoverageDay(day: 'Sat', morning: 0.72, afternoon: 0.79, evening: 0.67),
    _CoverageDay(day: 'Sun', morning: 0.69, afternoon: 0.76, evening: 0.63),
  ];

  static const List<_ExecutionLog> _logs = [
    _ExecutionLog(
      area: 'North Region',
      event: 'Night shift gap closed after reassignment',
      timestamp: '1h ago',
      status: 'Resolved',
      accent: BauhausDesign.success,
    ),
    _ExecutionLog(
      area: 'Training',
      event: 'Certification expiry warning for 3 workers',
      timestamp: '3h ago',
      status: 'Watch',
      accent: BauhausDesign.warning,
    ),
    _ExecutionLog(
      area: 'Routing',
      event: 'Travel time reduced by 12% in eastern cluster',
      timestamp: '8h ago',
      status: 'Gain',
      accent: BauhausDesign.secondary,
    ),
    _ExecutionLog(
      area: 'Quality',
      event: 'Callback queue above threshold for repeat issue group',
      timestamp: '1d ago',
      status: 'Action',
      accent: BauhausDesign.error,
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final orgId = ref.read(app_providers.organizationIdProvider);
      if (orgId != null && orgId.isNotEmpty) {
        _initializeDashboard(orgId);
      }
    });
  }

  Future<void> _initializeDashboard(
    String organizationId, {
    bool force = false,
  }) async {
    if (_isFetching && !force) return;
    if (!force && _loadedOrgId == organizationId) return;

    _isFetching = true;
    _loadedOrgId = organizationId;

    final endDate = DateTime.now();
    final startDate = endDate.subtract(const Duration(days: 30));
    final start = _dateOnly(startDate);
    final end = _dateOnly(endDate);

    try {
      await Future.wait([
        ref
            .read(businessIntelligenceViewModelProvider.notifier)
            .getExecutiveDashboard(
              organizationId: organizationId,
              period: 'month',
            ),
        ref.read(workforcePlanningViewModelProvider.notifier).predictTurnover(
              organizationId: organizationId,
            ),
        ref
            .read(resourceAllocationViewModelProvider.notifier)
            .analyzeWorkloadBalance(
              organizationId: organizationId,
              startDate: start,
              endDate: end,
            ),
        ref
            .read(qualityAssuranceViewModelProvider.notifier)
            .detectIncidentPatterns(
              organizationId: organizationId,
              startDate: start,
              endDate: end,
            ),
      ]);
    } finally {
      _isFetching = false;
      if (mounted) {
        setState(() {});
      }
    }
  }

  String _dateOnly(DateTime date) => date.toIso8601String().split('T').first;

  @override
  Widget build(BuildContext context) {
    final organizationId = ref.watch(app_providers.organizationIdProvider);
    final businessState = ref.watch(businessIntelligenceViewModelProvider);
    final planningState = ref.watch(workforcePlanningViewModelProvider);
    final allocationState = ref.watch(resourceAllocationViewModelProvider);
    final qualityState = ref.watch(qualityAssuranceViewModelProvider);

    if (organizationId != null &&
        organizationId.isNotEmpty &&
        _loadedOrgId != organizationId &&
        !_isFetching) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _initializeDashboard(organizationId);
        }
      });
    }

    final summary = _buildLiveSummary(
      businessState: businessState,
      planningState: planningState,
      allocationState: allocationState,
      qualityState: qualityState,
    );
    final commandMetrics = _buildLiveCommandMetrics(
      businessState: businessState,
      planningState: planningState,
      qualityState: qualityState,
    );
    final coverage = _buildLiveCoverage(allocationState);
    final logs = _buildLiveLogs(
      businessState: businessState,
      planningState: planningState,
      allocationState: allocationState,
      qualityState: qualityState,
    );

    final hasAnyData = businessState.dashboard != null ||
        planningState.turnoverPredictions.isNotEmpty ||
        allocationState.workloadAnalysis.isNotEmpty ||
        qualityState.incidentPattern != null;
    final isLoading = (businessState.isLoading ||
            planningState.isLoading ||
            allocationState.isLoading ||
            qualityState.isLoading) &&
        !hasAnyData;

    final error = businessState.error ??
        planningState.error ??
        allocationState.error ??
        qualityState.error;

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: _buildAppBar(context),
      body: organizationId == null || organizationId.isEmpty
          ? _buildMissingOrganizationState(context)
          : isLoading
              ? const Center(child: BauhausLoadingState())
              : RefreshIndicator(
                  color: BauhausDesign.primary,
                  onRefresh: () async {
                    if (organizationId.isNotEmpty) {
                      await _initializeDashboard(organizationId, force: true);
                    }
                  },
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
                              _buildOperationsDeck(context, summary),
                              const SizedBox(height: BauhausDesign.space6),
                              _buildCommandStrip(context, commandMetrics),
                              const SizedBox(height: BauhausDesign.space6),
                              _buildCapabilityLanes(context),
                              const SizedBox(height: BauhausDesign.space6),
                              _buildCoverageHeatmap(context, coverage),
                              const SizedBox(height: BauhausDesign.space6),
                              _buildExecutionLedger(context, logs),
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
      backgroundColor: BauhausDesign.secondary,
      elevation: 0,
      titleSpacing: 0,
      title: Text(
        'WORKFORCE OPTIMIZATION',
        style: BauhausDesign.getTextTheme(context).headlineMedium?.copyWith(
              color: BauhausDesign.surfaceWhite,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.7,
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
              child: Container(height: 8, color: BauhausDesign.accent),
            ),
            Expanded(
              flex: 4,
              child: Container(height: 8, color: BauhausDesign.surfaceWhite),
            ),
            Expanded(
              flex: 3,
              child: Container(height: 8, color: BauhausDesign.primary),
            ),
            Expanded(
              flex: 2,
              child: Container(height: 8, color: BauhausDesign.success),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOperationsDeck(BuildContext context, _WorkforceSummary summary) {
    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHard],
      ),
      child: Padding(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 980;
            final left = _buildDeckPrimary(context, summary);
            final right = _buildDeckSide(context, summary);

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
    );
  }

  Widget _buildDeckPrimary(BuildContext context, _WorkforceSummary summary) {
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
                text: 'OPS COMMAND',
                accent: BauhausDesign.secondary,
              ),
              const SizedBox(width: BauhausDesign.space2),
              _buildBadge(
                context,
                text: summary.periodLabel,
                accent: BauhausDesign.success,
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space3),
          Text(
            summary.primaryMetricLabel,
            style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: BauhausDesign.space1),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                summary.primaryMetricValue,
                style:
                    BauhausDesign.getTextTheme(context).displayLarge?.copyWith(
                          color: BauhausDesign.secondary,
                          fontWeight: FontWeight.w700,
                        ),
              ),
              const SizedBox(width: BauhausDesign.space2),
              Padding(
                padding: const EdgeInsets.only(bottom: BauhausDesign.space1),
                child: Text(
                  summary.primaryMetricSuffix,
                  style:
                      BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w600,
                          ),
                ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space1),
          Text(
            summary.primaryDetail,
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
              _buildActionChip(
                context,
                label: 'Plan Workforce',
                icon: Icons.calendar_month_rounded,
                accent: BauhausDesign.secondary,
                onTap: () =>
                    Navigator.pushNamed(context, Routes.workforcePlanning),
              ),
              _buildActionChip(
                context,
                label: 'Allocate Resources',
                icon: Icons.route_rounded,
                accent: BauhausDesign.primary,
                onTap: () =>
                    Navigator.pushNamed(context, Routes.resourceAllocation),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeckSide(BuildContext context, _WorkforceSummary summary) {
    return Column(
      children: [
        _buildSideStat(
          context,
          title: 'Open Shift Gaps',
          value: summary.openShiftGapValue,
          detail: summary.openShiftGapDetail,
          icon: Icons.event_busy_rounded,
          accent: summary.openShiftGapAccent,
        ),
        const SizedBox(height: BauhausDesign.space3),
        _buildSideStat(
          context,
          title: 'Operational Efficiency',
          value: summary.efficiencyValue,
          detail: summary.efficiencyDetail,
          icon: Icons.savings_rounded,
          accent: summary.efficiencyAccent,
        ),
      ],
    );
  }

  Widget _buildSideStat(
    BuildContext context, {
    required String title,
    required String value,
    required String detail,
    required IconData icon,
    required Color accent,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.12),
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 1.3),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            child: Icon(icon, size: 18, color: BauhausDesign.textDark),
          ),
          const SizedBox(width: BauhausDesign.space2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                      BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w700,
                          ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style:
                      BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w800,
                          ),
                ),
                const SizedBox(height: 2),
                Text(
                  detail,
                  style:
                      BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w600,
                          ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommandStrip(
    BuildContext context,
    List<_CommandMetric> commandMetrics,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BauhausSectionHeader(
          title: 'Command Strip',
          subtitle:
              'Fast-read operations metrics for throughput, quality, and cost control.',
        ),
        const SizedBox(height: BauhausDesign.space3),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 1080
                ? 4
                : constraints.maxWidth >= 620
                    ? 2
                    : 1;
            final spacing = BauhausDesign.space3;
            final cardWidth = columns == 1
                ? constraints.maxWidth
                : (constraints.maxWidth - spacing * (columns - 1)) / columns;

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: commandMetrics
                  .map(
                    (metric) => SizedBox(
                      width: cardWidth,
                      child: _buildCommandCard(context, metric),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCommandCard(BuildContext context, _CommandMetric metric) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 1.5),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: metric.accent.withOpacity(0.18),
              borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
              border: Border.all(color: BauhausDesign.neutral),
            ),
            child: Icon(metric.icon, size: 18, color: BauhausDesign.textDark),
          ),
          const SizedBox(width: BauhausDesign.space2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  metric.label,
                  style:
                      BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w700,
                          ),
                ),
                const SizedBox(height: 2),
                Text(
                  metric.value,
                  style:
                      BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w800,
                          ),
                ),
                Text(
                  metric.delta,
                  style:
                      BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
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

  Widget _buildCapabilityLanes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BauhausSectionHeader(
          title: 'Capability Lanes',
          subtitle: 'A structured workflow from planning through optimization.',
        ),
        const SizedBox(height: BauhausDesign.space3),
        LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 1100;
            if (compact) {
              return Column(
                children: [
                  for (var i = 0; i < _lanes.length; i++) ...[
                    _buildLaneCard(context, _lanes[i]),
                    if (i != _lanes.length - 1)
                      const SizedBox(height: BauhausDesign.space3),
                  ],
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _lanes
                  .asMap()
                  .entries
                  .map(
                    (entry) => Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: entry.key == _lanes.length - 1
                              ? 0
                              : BauhausDesign.space3,
                        ),
                        child: _buildLaneCard(context, entry.value),
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

  Widget _buildLaneCard(BuildContext context, _CapabilityLane lane) {
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
              color: lane.accent.withOpacity(0.16),
              borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
              border: Border.all(color: BauhausDesign.neutral, width: 1.2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lane.title,
                  style:
                      BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w700,
                          ),
                ),
                Text(
                  lane.subtitle,
                  style:
                      BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w600,
                          ),
                ),
              ],
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

  Widget _buildLaneAction(BuildContext context, _WorkforceModule module) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        onTap: () => Navigator.pushNamed(context, module.route),
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
                width: 34,
                height: 34,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: module.accent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  border: Border.all(color: BauhausDesign.neutral),
                ),
                child:
                    Icon(module.icon, size: 18, color: BauhausDesign.textDark),
              ),
              const SizedBox(width: BauhausDesign.space2),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      module.title,
                      style: BauhausDesign.getTextTheme(context)
                          .labelLarge
                          ?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    Text(
                      module.description,
                      style: BauhausDesign.getTextTheme(context)
                          .bodySmall
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
                color: BauhausDesign.textDark,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCoverageHeatmap(
    BuildContext context,
    List<_CoverageDay> coverage,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BauhausSectionHeader(
          title: 'Coverage Heatmap',
          subtitle:
              'Morning, afternoon, and evening staffing confidence by day.',
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
              Row(
                children: [
                  const SizedBox(width: 60),
                  Expanded(
                    child: _buildHeatLabel(
                        context, 'Morning', BauhausDesign.secondary),
                  ),
                  const SizedBox(width: BauhausDesign.space2),
                  Expanded(
                    child: _buildHeatLabel(
                        context, 'Afternoon', BauhausDesign.primary),
                  ),
                  const SizedBox(width: BauhausDesign.space2),
                  Expanded(
                    child: _buildHeatLabel(
                        context, 'Evening', BauhausDesign.accent),
                  ),
                ],
              ),
              const SizedBox(height: BauhausDesign.space2),
              for (var i = 0; i < coverage.length; i++) ...[
                _buildHeatRow(context, coverage[i]),
                if (i != coverage.length - 1)
                  const SizedBox(height: BauhausDesign.space2),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeatLabel(BuildContext context, String text, Color accent) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: BauhausDesign.space1),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.18),
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        border: Border.all(color: BauhausDesign.neutral, width: 1),
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

  Widget _buildHeatRow(BuildContext context, _CoverageDay day) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: Text(
            day.day,
            style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        Expanded(
          child: _buildHeatCell(day.morning, BauhausDesign.secondary),
        ),
        const SizedBox(width: BauhausDesign.space2),
        Expanded(
          child: _buildHeatCell(day.afternoon, BauhausDesign.primary),
        ),
        const SizedBox(width: BauhausDesign.space2),
        Expanded(
          child: _buildHeatCell(day.evening, BauhausDesign.accent),
        ),
      ],
    );
  }

  Widget _buildHeatCell(double value, Color accent) {
    final opacity = 0.18 + (value * 0.65);
    final percent = (value * 100).round();
    return Container(
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: accent.withOpacity(opacity),
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        border: Border.all(color: BauhausDesign.neutral, width: 1),
      ),
      child: Text(
        '$percent%',
        style: const TextStyle(
          color: BauhausDesign.textDark,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildExecutionLedger(
    BuildContext context,
    List<_ExecutionLog> logs,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BauhausSectionHeader(
          title: 'Execution Ledger',
          subtitle: 'Event log for operations, quality, and staffing actions.',
        ),
        const SizedBox(height: BauhausDesign.space3),
        Container(
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceWhite,
            borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
            border: Border.all(color: BauhausDesign.neutral, width: 2),
            boxShadow: const [BauhausDesign.shadowHard],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxWidth < 860;
              return Column(
                children: [
                  if (!compact) _buildLedgerHeader(context),
                  for (var i = 0; i < logs.length; i++) ...[
                    compact
                        ? _buildLedgerRowCompact(context, logs[i])
                        : _buildLedgerRow(context, logs[i]),
                    if (i != logs.length - 1)
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: compact
                              ? BauhausDesign.space3
                              : BauhausDesign.space4,
                        ),
                        height: 1,
                        color: BauhausDesign.neutral.withOpacity(0.25),
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

  Widget _buildLedgerHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space4,
        vertical: BauhausDesign.space3,
      ),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceOffWhite,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(BauhausDesign.radiusLg - 1),
          topRight: Radius.circular(BauhausDesign.radiusLg - 1),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            child: Text(
              'Area',
              style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              'Event',
              style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ),
          const SizedBox(width: BauhausDesign.space2),
          SizedBox(
            width: 84,
            child: Text(
              'Time',
              textAlign: TextAlign.right,
              style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ),
          const SizedBox(width: BauhausDesign.space2),
          SizedBox(
            width: 90,
            child: Text(
              'Status',
              textAlign: TextAlign.right,
              style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLedgerRow(BuildContext context, _ExecutionLog log) {
    return Padding(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              log.area,
              style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              log.event,
              style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const SizedBox(width: BauhausDesign.space2),
          SizedBox(
            width: 84,
            child: Text(
              log.timestamp,
              textAlign: TextAlign.right,
              style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                    color: BauhausDesign.textMuted,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          const SizedBox(width: BauhausDesign.space2),
          SizedBox(
            width: 90,
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: BauhausDesign.space2,
                  vertical: BauhausDesign.space1,
                ),
                decoration: BoxDecoration(
                  color: log.accent.withOpacity(0.16),
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  border: Border.all(color: BauhausDesign.neutral),
                ),
                child: Text(
                  log.status.toUpperCase(),
                  style:
                      BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
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

  Widget _buildLedgerRowCompact(BuildContext context, _ExecutionLog log) {
    return Padding(
      padding: const EdgeInsets.all(BauhausDesign.space3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  log.area,
                  style:
                      BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
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
                  color: log.accent.withOpacity(0.16),
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  border: Border.all(color: BauhausDesign.neutral),
                ),
                child: Text(
                  log.status.toUpperCase(),
                  style:
                      BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w800,
                          ),
                ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space1),
          Text(
            log.event,
            style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: BauhausDesign.space1),
          Text(
            log.timestamp,
            style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                  color: BauhausDesign.textMuted,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildMissingOrganizationState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(BauhausDesign.space6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.business_rounded,
              size: 44,
              color: BauhausDesign.textMuted,
            ),
            const SizedBox(height: BauhausDesign.space2),
            Text(
              'Organization not available',
              style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: BauhausDesign.space1),
            Text(
              'Set organization context to load Workforce Optimization data.',
              textAlign: TextAlign.center,
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                    color: BauhausDesign.textMuted,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorBanner(BuildContext context, String error) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: BauhausDesign.error.withOpacity(0.12),
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: BauhausDesign.error,
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

  _WorkforceSummary _buildLiveSummary({
    required BusinessIntelligenceState businessState,
    required WorkforcePlanningState planningState,
    required ResourceAllocationState allocationState,
    required QualityAssuranceState qualityState,
  }) {
    final dashboard = businessState.dashboard;
    final totalAppointments = dashboard?.kpis.totalAppointments ?? 0;
    final completedAppointments = dashboard?.kpis.completedAppointments ?? 0;
    final completionRate = dashboard?.kpis.completionRate ?? 0;
    final utilization = dashboard?.workforce.utilization ??
        dashboard?.operations.utilization ??
        0;
    final efficiency = dashboard?.operations.efficiency ?? 0;

    final highRiskTurnover = planningState.turnoverPredictions
        .where((item) => item.riskLevel.toLowerCase() == 'high')
        .length;

    final overloadedWorkers = allocationState.workloadAnalysis
        .where((item) => item.utilization > 0.9)
        .length;

    final underutilizedWorkers = allocationState.workloadAnalysis
        .where((item) => item.utilization < 0.5)
        .length;

    final incidentCount = qualityState.incidentPattern?.totalIncidents ?? 0;

    return _WorkforceSummary(
      periodLabel: dashboard != null ? dashboard.period.toUpperCase() : 'LIVE',
      primaryMetricLabel: 'Completed Appointments',
      primaryMetricValue:
          completedAppointments > 0 ? '$completedAppointments' : 'N/A',
      primaryMetricSuffix: dashboard != null ? 'this ${dashboard.period}' : '',
      primaryDetail: dashboard != null
          ? 'Completion ${_ratioPercent(completionRate)} across $totalAppointments scheduled appointments.'
          : 'Live operational metrics will appear once the BI feed responds for this organization.',
      openShiftGapValue: '$overloadedWorkers',
      openShiftGapDetail: overloadedWorkers > 0
          ? '$overloadedWorkers workers are above 90% utilization in the active period.'
          : 'No overloaded workers detected in current workload analysis.',
      openShiftGapAccent:
          overloadedWorkers > 0 ? BauhausDesign.warning : BauhausDesign.success,
      efficiencyValue: dashboard != null ? _ratioPercent(efficiency) : 'N/A',
      efficiencyDetail: dashboard != null
          ? 'Workforce utilization ${_ratioPercent(utilization)} with $underutilizedWorkers underutilized workers.'
          : 'Efficiency will be computed when workforce and operations metrics are available.',
      efficiencyAccent: efficiency >= 0.85
          ? BauhausDesign.success
          : (incidentCount > 0 || highRiskTurnover > 0
              ? BauhausDesign.warning
              : BauhausDesign.secondary),
    );
  }

  List<_CommandMetric> _buildLiveCommandMetrics({
    required BusinessIntelligenceState businessState,
    required WorkforcePlanningState planningState,
    required QualityAssuranceState qualityState,
  }) {
    final dashboard = businessState.dashboard;
    if (dashboard == null &&
        planningState.turnoverPredictions.isEmpty &&
        qualityState.incidentPattern == null) {
      return _commandMetrics;
    }

    final completionRate = dashboard?.kpis.completionRate ?? 0;
    final utilization = dashboard?.workforce.utilization ??
        dashboard?.operations.utilization ??
        0;

    final highTurnover = planningState.turnoverPredictions
        .where((item) => item.riskLevel.toLowerCase() == 'high')
        .length;
    final totalTurnoverTracked = planningState.turnoverPredictions.length;

    final incidentCount = qualityState.incidentPattern?.totalIncidents ?? 0;
    final recurringCount =
        qualityState.incidentPattern?.recurringIssues.length ?? 0;

    return [
      _CommandMetric(
        label: 'Schedule Fill',
        value: _ratioPercent(completionRate),
        delta: _trendDelta(dashboard?.trends['appointments']),
        accent: completionRate >= 0.9
            ? BauhausDesign.success
            : BauhausDesign.warning,
        icon: Icons.event_available_rounded,
      ),
      _CommandMetric(
        label: 'Utilization',
        value: _ratioPercent(utilization),
        delta: _trendDelta(dashboard?.trends['revenue']),
        accent: utilization >= 0.7
            ? BauhausDesign.secondary
            : BauhausDesign.warning,
        icon: Icons.timelapse_rounded,
      ),
      _CommandMetric(
        label: 'Turnover Risk',
        value: '$highTurnover high',
        delta: '$totalTurnoverTracked tracked',
        accent: highTurnover > 0 ? BauhausDesign.error : BauhausDesign.success,
        icon: Icons.person_search_rounded,
      ),
      _CommandMetric(
        label: 'QA Signals',
        value: '$incidentCount',
        delta: '$recurringCount recurring',
        accent:
            incidentCount > 0 ? BauhausDesign.warning : BauhausDesign.primary,
        icon: Icons.fact_check_rounded,
      ),
    ];
  }

  List<_CoverageDay> _buildLiveCoverage(
      ResourceAllocationState allocationState) {
    if (allocationState.workloadAnalysis.isEmpty) {
      return _coverage;
    }

    final workloads = allocationState.workloadAnalysis;
    final avgUtilization = (workloads
            .map((item) => item.utilization.clamp(0.0, 1.0))
            .fold<double>(0.0, (sum, value) => sum + value)) /
        workloads.length;

    const dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const factors = [0.94, 0.98, 1.00, 1.02, 0.97, 0.84, 0.8];

    return List<_CoverageDay>.generate(dayNames.length, (index) {
      final base = (avgUtilization * factors[index]).clamp(0.0, 1.0);
      return _CoverageDay(
        day: dayNames[index],
        morning: (base * 0.96).clamp(0.0, 1.0),
        afternoon: (base * 1.03).clamp(0.0, 1.0),
        evening: (base * 0.88).clamp(0.0, 1.0),
      );
    });
  }

  List<_ExecutionLog> _buildLiveLogs({
    required BusinessIntelligenceState businessState,
    required WorkforcePlanningState planningState,
    required ResourceAllocationState allocationState,
    required QualityAssuranceState qualityState,
  }) {
    final liveLogs = <_ExecutionLog>[];
    final dashboard = businessState.dashboard;

    if (dashboard != null) {
      liveLogs.add(
        _ExecutionLog(
          area: 'Operations',
          event:
              'Completion ${_ratioPercent(dashboard.kpis.completionRate)} across ${dashboard.kpis.totalAppointments} appointments.',
          timestamp: _relativeTime(dashboard.generatedAt),
          status: dashboard.kpis.completionRate >= 0.9 ? 'Stable' : 'Watch',
          accent: dashboard.kpis.completionRate >= 0.9
              ? BauhausDesign.success
              : BauhausDesign.warning,
        ),
      );
    }

    if (planningState.turnoverPredictions.isNotEmpty) {
      final highRisk = planningState.turnoverPredictions
          .where((item) => item.riskLevel.toLowerCase() == 'high')
          .length;
      liveLogs.add(
        _ExecutionLog(
          area: 'Retention',
          event:
              '$highRisk high-turnover signals detected across ${planningState.turnoverPredictions.length} staff predictions.',
          timestamp: 'today',
          status: highRisk > 0 ? 'Action' : 'Stable',
          accent: highRisk > 0 ? BauhausDesign.warning : BauhausDesign.success,
        ),
      );
    }

    if (qualityState.incidentPattern != null) {
      final pattern = qualityState.incidentPattern!;
      liveLogs.add(
        _ExecutionLog(
          area: 'Quality',
          event:
              '${pattern.totalIncidents} incident signals and ${pattern.recurringIssues.length} recurring issue groups identified.',
          timestamp: 'today',
          status: pattern.totalIncidents > 0 ? 'Watch' : 'Clear',
          accent: pattern.totalIncidents > 0
              ? BauhausDesign.warning
              : BauhausDesign.success,
        ),
      );
    }

    if (allocationState.workloadAnalysis.isNotEmpty) {
      final overloaded = allocationState.workloadAnalysis
          .where((item) => item.utilization > 0.9)
          .length;
      final underutilized = allocationState.workloadAnalysis
          .where((item) => item.utilization < 0.5)
          .length;
      liveLogs.add(
        _ExecutionLog(
          area: 'Routing',
          event:
              '$overloaded overloaded and $underutilized underutilized workers in latest balance analysis.',
          timestamp: 'today',
          status: overloaded > 0 ? 'Watch' : 'Gain',
          accent:
              overloaded > 0 ? BauhausDesign.warning : BauhausDesign.secondary,
        ),
      );
    }

    if (liveLogs.isEmpty) return _logs;
    return liveLogs.take(6).toList();
  }

  String _ratioPercent(double ratio) {
    final safe = ratio.isFinite ? ratio : 0;
    return '${(safe.clamp(0.0, 1.0) * 100).toStringAsFixed(1)}%';
  }

  String _trendDelta(dynamic trend) {
    if (trend == null) return 'No trend';
    final direction = (trend.direction as String?)?.toLowerCase() ?? 'stable';
    final change = (trend.change as num?)?.toDouble() ?? 0;
    if (direction == 'up') return '+${change.toStringAsFixed(1)}%';
    if (direction == 'down') return '-${change.toStringAsFixed(1)}%';
    return '${change.toStringAsFixed(1)}%';
  }

  String _relativeTime(DateTime timestamp) {
    final diff = DateTime.now().difference(timestamp);
    if (diff.inMinutes < 1) return 'now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
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
        color: accent.withOpacity(0.16),
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
            color: accent.withOpacity(0.14),
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
}

class _CapabilityLane {
  final String title;
  final String subtitle;
  final Color accent;
  final List<_WorkforceModule> modules;

  const _CapabilityLane({
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.modules,
  });
}

class _WorkforceModule {
  final String title;
  final String description;
  final IconData icon;
  final Color accent;
  final String route;

  const _WorkforceModule({
    required this.title,
    required this.description,
    required this.icon,
    required this.accent,
    required this.route,
  });
}

class _CommandMetric {
  final String label;
  final String value;
  final String delta;
  final Color accent;
  final IconData icon;

  const _CommandMetric({
    required this.label,
    required this.value,
    required this.delta,
    required this.accent,
    required this.icon,
  });
}

class _CoverageDay {
  final String day;
  final double morning;
  final double afternoon;
  final double evening;

  const _CoverageDay({
    required this.day,
    required this.morning,
    required this.afternoon,
    required this.evening,
  });
}

class _ExecutionLog {
  final String area;
  final String event;
  final String timestamp;
  final String status;
  final Color accent;

  const _ExecutionLog({
    required this.area,
    required this.event,
    required this.timestamp,
    required this.status,
    required this.accent,
  });
}

class _WorkforceSummary {
  final String periodLabel;
  final String primaryMetricLabel;
  final String primaryMetricValue;
  final String primaryMetricSuffix;
  final String primaryDetail;
  final String openShiftGapValue;
  final String openShiftGapDetail;
  final Color openShiftGapAccent;
  final String efficiencyValue;
  final String efficiencyDetail;
  final Color efficiencyAccent;

  const _WorkforceSummary({
    required this.periodLabel,
    required this.primaryMetricLabel,
    required this.primaryMetricValue,
    required this.primaryMetricSuffix,
    required this.primaryDetail,
    required this.openShiftGapValue,
    required this.openShiftGapDetail,
    required this.openShiftGapAccent,
    required this.efficiencyValue,
    required this.efficiencyDetail,
    required this.efficiencyAccent,
  });
}
