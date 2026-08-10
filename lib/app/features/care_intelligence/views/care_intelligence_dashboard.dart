import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/features/care_intelligence/viewmodels/intelligence_viewmodel.dart';
import 'package:carenest/app/features/care_intelligence/viewmodels/medication_viewmodel.dart';
import 'package:carenest/app/features/care_intelligence/viewmodels/risk_prediction_viewmodel.dart';
import 'package:carenest/app/features/client/providers/client_provider.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CareIntelligenceDashboard extends ConsumerStatefulWidget {
  const CareIntelligenceDashboard({super.key});

  @override
  ConsumerState<CareIntelligenceDashboard> createState() =>
      _CareIntelligenceDashboardState();
}

class _CareIntelligenceDashboardState
    extends ConsumerState<CareIntelligenceDashboard> {
  String? _loadedOrgId;
  String? _activeClientId;
  String? _activeClientName;
  bool _isFetching = false;

  static const List<_CareModule> _modules = [
    _CareModule(
      title: 'Risk Assessment',
      description: 'Prioritize clients by dynamic safety and decline signals.',
      icon: Icons.warning_amber_rounded,
      accent: BauhausDesign.error,
      route: Routes.riskAssessment,
    ),
    _CareModule(
      title: 'Care Plan Builder',
      description:
          'Generate measurable plans aligned with daily interventions.',
      icon: Icons.assignment_turned_in_rounded,
      accent: BauhausDesign.secondary,
      route: Routes.carePlanBuilder,
    ),
    _CareModule(
      title: 'Incident Management',
      description:
          'Capture, classify, and resolve incidents with audit clarity.',
      icon: Icons.report_problem_rounded,
      accent: BauhausDesign.warning,
      route: Routes.incidentManagement,
    ),
    _CareModule(
      title: 'Medication Management',
      description: 'Track adherence and identify interaction conflicts.',
      icon: Icons.medication_rounded,
      accent: BauhausDesign.primary,
      route: Routes.medicationManagement,
    ),
    _CareModule(
      title: 'Behavior Support',
      description: 'Surface behavior patterns and recommend interventions.',
      icon: Icons.psychology_alt_rounded,
      accent: BauhausDesign.primary,
      route: Routes.behaviorSupport,
    ),
    _CareModule(
      title: 'Health Monitoring',
      description: 'Monitor vitals and trend changes across the caseload.',
      icon: Icons.monitor_heart_rounded,
      accent: BauhausDesign.success,
      route: Routes.healthMonitoring,
    ),
    _CareModule(
      title: 'Outcome Insights',
      description: 'Measure progress against goals and recovery milestones.',
      icon: Icons.track_changes_rounded,
      accent: BauhausDesign.accent,
      route: Routes.outcomeTracking,
    ),
  ];

  static const List<_JourneyStep> _journeySteps = [
    _JourneyStep(
      title: 'Detect',
      detail: 'Risk and behavior patterns',
      icon: Icons.visibility_rounded,
      accent: BauhausDesign.error,
    ),
    _JourneyStep(
      title: 'Plan',
      detail: 'Adaptive support protocol',
      icon: Icons.edit_note_rounded,
      accent: BauhausDesign.secondary,
    ),
    _JourneyStep(
      title: 'Deliver',
      detail: 'Coordinated care execution',
      icon: Icons.local_hospital_rounded,
      accent: BauhausDesign.primary,
    ),
    _JourneyStep(
      title: 'Validate',
      detail: 'Outcome and adherence checks',
      icon: Icons.task_alt_rounded,
      accent: BauhausDesign.success,
    ),
  ];

  static const List<_RiskSignal> _riskSignals = [
    _RiskSignal(
      title: 'Falls Exposure',
      score: 0,
      trend: 'Awaiting risk feed',
      accent: BauhausDesign.success,
    ),
    _RiskSignal(
      title: 'Medication Conflict',
      score: 0,
      trend: 'Awaiting risk feed',
      accent: BauhausDesign.warning,
    ),
    _RiskSignal(
      title: 'Plan Drift',
      score: 0,
      trend: 'Awaiting risk feed',
      accent: BauhausDesign.secondary,
    ),
    _RiskSignal(
      title: 'Incident Recurrence',
      score: 0,
      trend: 'Awaiting risk feed',
      accent: BauhausDesign.success,
    ),
  ];

  static const List<_CareAlert> _alerts = [
    _CareAlert(
      title: 'No active care alerts',
      subtitle: 'Backend returned no current alert records.',
      timestamp: 'now',
      severity: 'Info',
      accent: BauhausDesign.secondary,
      icon: Icons.insights_rounded,
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
    if (!force && _loadedOrgId == organizationId && _activeClientId != null) {
      return;
    }

    _isFetching = true;
    _loadedOrgId = organizationId;

    try {
      await ref
          .read(clientProvider.notifier)
          .fetchClientsByOrganization(organizationId);

      final clients = ref
          .read(clientProvider)
          .clients
          .where((client) => client.id != null && client.id!.isNotEmpty)
          .toList();

      if (clients.isEmpty) {
        _activeClientId = null;
        _activeClientName = null;
        return;
      }

      final selectedClient = clients.firstWhere(
        (client) => client.id == _activeClientId,
        orElse: () => clients.first,
      );

      final clientId = selectedClient.id!;
      _activeClientId = clientId;
      _activeClientName = selectedClient.displayName;

      await Future.wait([
        ref
            .read(intelligenceViewModelProvider.notifier)
            .generateIntelligenceReport(
              clientId: clientId,
              organizationId: organizationId,
            ),
        ref
            .read(riskPredictionViewModelProvider.notifier)
            .predictAllRisks(
              clientId: clientId,
              organizationId: organizationId,
            ),
        ref
            .read(medicationViewModelProvider.notifier)
            .getMedicationAlerts(
              clientId: clientId,
              organizationId: organizationId,
            ),
      ]);
    } finally {
      _isFetching = false;
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final organizationId = ref.watch(app_providers.organizationIdProvider);
    final clientState = ref.watch(clientProvider);
    final intelligenceState = ref.watch(intelligenceViewModelProvider);
    final riskState = ref.watch(riskPredictionViewModelProvider);
    final medicationState = ref.watch(medicationViewModelProvider);

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

    final liveRiskSignals = _buildLiveRiskSignals(riskState);
    final liveAlerts = _buildLiveAlerts(intelligenceState, medicationState);
    final summary = _buildLiveSummary(
      clientState: clientState,
      intelligenceState: intelligenceState,
      riskState: riskState,
      medicationState: medicationState,
      alerts: liveAlerts,
    );

    final hasAnyData =
        intelligenceState.report != null ||
        riskState.assessment != null ||
        medicationState.alerts.isNotEmpty;

    final isLoading =
        (clientState.isLoading ||
            intelligenceState.isLoading ||
            riskState.isLoading ||
            medicationState.isLoading) &&
        !hasAnyData;

    final error =
        intelligenceState.error ??
        riskState.error ??
        medicationState.error ??
        clientState.error;

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: _buildAppBar(context),
      body: organizationId == null || organizationId.isEmpty
          ? _buildMissingOrganizationState(context)
          : _activeClientId == null && !clientState.isLoading
          ? _buildMissingClientState(context)
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
                          _buildClinicalCanvas(context, summary),
                          const SizedBox(height: BauhausDesign.space6),
                          _buildJourneyBand(context),
                          const SizedBox(height: BauhausDesign.space6),
                          _buildModuleAtlas(context),
                          const SizedBox(height: BauhausDesign.space6),
                          _buildRiskMatrix(context, liveRiskSignals),
                          const SizedBox(height: BauhausDesign.space6),
                          _buildAlertTimeline(context, liveAlerts),
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
        'CARE INTELLIGENCE',
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
              flex: 3,
              child: Container(height: 8, color: BauhausDesign.secondary),
            ),
            Expanded(
              flex: 4,
              child: Container(height: 8, color: BauhausDesign.surfaceWhite),
            ),
            Expanded(
              flex: 2,
              child: Container(height: 8, color: BauhausDesign.accent),
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

  Widget _buildClinicalCanvas(BuildContext context, _CareSummary summary) {
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
            final compact = constraints.maxWidth < 1000;
            final headline = _buildCanvasHeadline(context, summary);
            final triage = _buildTriagePanel(context, summary);

            if (compact) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headline,
                  const SizedBox(height: BauhausDesign.space3),
                  triage,
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 6, child: headline),
                const SizedBox(width: BauhausDesign.space4),
                Expanded(flex: 4, child: triage),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCanvasHeadline(BuildContext context, _CareSummary summary) {
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
                text: 'CLINICAL COMMAND',
                accent: BauhausDesign.primary,
              ),
              const SizedBox(width: BauhausDesign.space2),
              _buildBadge(
                context,
                text: summary.activeClientLabel ?? 'LIVE SHIFT',
                accent: BauhausDesign.success,
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space3),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Clients Under Active Monitoring',
                      style: BauhausDesign.getTextTheme(context).labelLarge
                          ?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: BauhausDesign.space1),
                    Text(
                      summary.monitoredClients,
                      style: BauhausDesign.getTextTheme(context).displayLarge
                          ?.copyWith(
                            color: BauhausDesign.primary,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: BauhausDesign.space1),
                    Text(
                      summary.coverageDetail,
                      style: BauhausDesign.getTextTheme(context).bodyMedium
                          ?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
              SizedBox(
                width: 120,
                height: 120,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        width: 68,
                        height: 68,
                        decoration: BoxDecoration(
                          color: BauhausDesign.secondary.withValues(alpha: 0.22),
                          borderRadius: BorderRadius.circular(
                            BauhausDesign.radiusSm,
                          ),
                          border: Border.all(
                            color: BauhausDesign.neutral,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          color: BauhausDesign.accent.withValues(alpha: 0.24),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: BauhausDesign.neutral,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: BauhausDesign.primary.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(
                            BauhausDesign.radiusSm,
                          ),
                          border: Border.all(
                            color: BauhausDesign.neutral,
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.favorite_rounded,
                          color: BauhausDesign.textDark,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space3),
          Wrap(
            spacing: BauhausDesign.space2,
            runSpacing: BauhausDesign.space2,
            children: [
              _CanvasTag(
                label: 'Plans Due',
                value: summary.plansDue,
                accent: BauhausDesign.warning,
              ),
              _CanvasTag(
                label: 'Stable Cases',
                value: summary.stableCases,
                accent: BauhausDesign.success,
              ),
              _CanvasTag(
                label: 'Escalations',
                value: summary.escalations,
                accent: BauhausDesign.error,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTriagePanel(BuildContext context, _CareSummary summary) {
    return Column(
      children: [
        _buildTriageCard(
          context,
          title: 'Immediate Review',
          value: summary.immediateReviewValue,
          detail: summary.immediateReviewDetail,
          icon: Icons.priority_high_rounded,
          accent: BauhausDesign.error,
        ),
        const SizedBox(height: BauhausDesign.space3),
        _buildTriageCard(
          context,
          title: 'Medication Watch',
          value: summary.medicationWatchValue,
          detail: summary.medicationWatchDetail,
          icon: Icons.medication_rounded,
          accent: BauhausDesign.warning,
        ),
        const SizedBox(height: BauhausDesign.space3),
        _buildTriageCard(
          context,
          title: 'Outcome Momentum',
          value: summary.outcomeMomentumValue,
          detail: summary.outcomeMomentumDetail,
          icon: Icons.trending_up_rounded,
          accent: BauhausDesign.success,
        ),
      ],
    );
  }

  Widget _buildTriageCard(
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
        color: accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 1.4),
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
              border: Border.all(color: BauhausDesign.neutral, width: 1),
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
                  style: BauhausDesign.getTextTheme(context).labelSmall
                      ?.copyWith(
                        color: BauhausDesign.textDark,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: BauhausDesign.getTextTheme(context).titleMedium
                      ?.copyWith(
                        color: BauhausDesign.textDark,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  detail,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: BauhausDesign.getTextTheme(context).bodySmall
                      ?.copyWith(
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

  Widget _buildJourneyBand(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BauhausSectionHeader(
          title: 'Care Journey Band',
          subtitle:
              'Operational path from early signal detection to verified outcomes.',
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
              final compact = constraints.maxWidth < 900;
              if (compact) {
                return Wrap(
                  spacing: BauhausDesign.space3,
                  runSpacing: BauhausDesign.space3,
                  children: _journeySteps
                      .asMap()
                      .entries
                      .map(
                        (entry) => SizedBox(
                          width: constraints.maxWidth >= 520
                              ? (constraints.maxWidth - BauhausDesign.space3) /
                                    2
                              : constraints.maxWidth,
                          child: _buildJourneyCard(
                            context,
                            entry.key,
                            entry.value,
                          ),
                        ),
                      )
                      .toList(),
                );
              }

              return Row(
                children: _journeySteps
                    .asMap()
                    .entries
                    .map(
                      (entry) => Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: entry.key == _journeySteps.length - 1
                                ? 0
                                : BauhausDesign.space3,
                          ),
                          child: _buildJourneyCard(
                            context,
                            entry.key,
                            entry.value,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildJourneyCard(BuildContext context, int index, _JourneyStep step) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: step.accent.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceWhite,
              borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
              border: Border.all(color: BauhausDesign.neutral),
            ),
            child: Text(
              '${index + 1}',
              style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: BauhausDesign.space2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(step.icon, size: 15, color: BauhausDesign.textDark),
                    const SizedBox(width: BauhausDesign.space1),
                    Text(
                      step.title,
                      style: BauhausDesign.getTextTheme(context).labelLarge
                          ?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  step.detail,
                  style: BauhausDesign.getTextTheme(context).bodySmall
                      ?.copyWith(
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

  Widget _buildModuleAtlas(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BauhausSectionHeader(
          title: 'Module Atlas',
          subtitle:
              'Dedicated workflows for assessment, care planning, incidents, and progress.',
          action: _buildBadge(
            context,
            text: '${_modules.length} MODULES',
            accent: BauhausDesign.secondary,
          ),
        ),
        const SizedBox(height: BauhausDesign.space3),
        Container(
          padding: const EdgeInsets.all(BauhausDesign.space3),
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceWhite,
            borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
            border: Border.all(color: BauhausDesign.neutral, width: 2),
            boxShadow: const [BauhausDesign.shadowHard],
          ),
          child: Column(
            children: [
              for (var i = 0; i < _modules.length; i++) ...[
                _buildModuleRow(context, _modules[i], i),
                if (i != _modules.length - 1)
                  const SizedBox(height: BauhausDesign.space3),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildModuleRow(BuildContext context, _CareModule module, int index) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        onTap: () => Navigator.pushNamed(context, module.route),
        child: Container(
          padding: const EdgeInsets.all(BauhausDesign.space3),
          decoration: BoxDecoration(
            color: index.isEven
                ? BauhausDesign.surfaceOffWhite
                : BauhausDesign.surfaceWhite,
            borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
            border: Border.all(color: BauhausDesign.neutral, width: 1.4),
          ),
          child: Row(
            children: [
              Container(
                width: 6,
                height: 64,
                decoration: BoxDecoration(
                  color: module.accent,
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusXs),
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: module.accent.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  border: Border.all(color: BauhausDesign.neutral),
                ),
                child: Icon(
                  module.icon,
                  size: 20,
                  color: BauhausDesign.textDark,
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
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
                    const SizedBox(height: 2),
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
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: BauhausDesign.space2,
                  vertical: BauhausDesign.space1,
                ),
                decoration: BoxDecoration(
                  color: module.accent.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  border: Border.all(color: BauhausDesign.neutral),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Open',
                      style: BauhausDesign.getTextTheme(context).labelSmall
                          ?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(width: BauhausDesign.space1),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      size: 14,
                      color: BauhausDesign.textDark,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRiskMatrix(BuildContext context, List<_RiskSignal> riskSignals) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BauhausSectionHeader(
          title: 'Risk Matrix',
          subtitle:
              'Current exposure by category with short-term movement signals.',
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
          child: Column(
            children: [
              for (var i = 0; i < riskSignals.length; i++) ...[
                _buildRiskRow(context, riskSignals[i]),
                if (i != riskSignals.length - 1)
                  const SizedBox(height: BauhausDesign.space2),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRiskRow(BuildContext context, _RiskSignal signal) {
    final fill = signal.score.clamp(0, 100) / 100;
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceOffWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 1.2),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 780;

          if (compact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        signal.title,
                        style: BauhausDesign.getTextTheme(context).labelLarge
                            ?.copyWith(
                              color: BauhausDesign.textDark,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                    const SizedBox(width: BauhausDesign.space2),
                    Text(
                      '${signal.score.toInt()} / 100',
                      textAlign: TextAlign.right,
                      style: BauhausDesign.getTextTheme(context).labelSmall
                          ?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: BauhausDesign.space2),
                Container(
                  height: 14,
                  decoration: BoxDecoration(
                    color: BauhausDesign.surfaceWhite,
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                    border: Border.all(color: BauhausDesign.neutral),
                  ),
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: fill,
                    child: Container(
                      decoration: BoxDecoration(
                        color: signal.accent.withValues(alpha: 0.75),
                        borderRadius: BorderRadius.circular(
                          BauhausDesign.radiusSm,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: BauhausDesign.space1),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    signal.trend,
                    textAlign: TextAlign.right,
                    style: BauhausDesign.getTextTheme(context).bodySmall
                        ?.copyWith(
                          color: signal.accent,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
              ],
            );
          }

          return Row(
            children: [
              SizedBox(
                width: 146,
                child: Text(
                  signal.title,
                  style: BauhausDesign.getTextTheme(context).labelLarge
                      ?.copyWith(
                        color: BauhausDesign.textDark,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
              Expanded(
                child: Container(
                  height: 14,
                  decoration: BoxDecoration(
                    color: BauhausDesign.surfaceWhite,
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                    border: Border.all(color: BauhausDesign.neutral),
                  ),
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: fill,
                    child: Container(
                      decoration: BoxDecoration(
                        color: signal.accent.withValues(alpha: 0.75),
                        borderRadius: BorderRadius.circular(
                          BauhausDesign.radiusSm,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
              SizedBox(
                width: 92,
                child: Text(
                  '${signal.score.toInt()} / 100',
                  textAlign: TextAlign.right,
                  style: BauhausDesign.getTextTheme(context).labelSmall
                      ?.copyWith(
                        color: BauhausDesign.textDark,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
              const SizedBox(width: BauhausDesign.space2),
              SizedBox(
                width: 90,
                child: Text(
                  signal.trend,
                  textAlign: TextAlign.right,
                  style: BauhausDesign.getTextTheme(context).bodySmall
                      ?.copyWith(
                        color: signal.accent,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAlertTimeline(BuildContext context, List<_CareAlert> alerts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BauhausSectionHeader(
          title: 'Alert Timeline',
          subtitle:
              'Sequenced escalation and progress events from live operations.',
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
              for (var i = 0; i < alerts.length; i++)
                _buildTimelineRow(
                  context,
                  alerts[i],
                  showConnector: i != alerts.length - 1,
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineRow(
    BuildContext context,
    _CareAlert alert, {
    required bool showConnector,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: showConnector ? BauhausDesign.space3 : 0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 26,
            child: Column(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: alert.accent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: BauhausDesign.neutral,
                      width: 1.2,
                    ),
                  ),
                ),
                if (showConnector)
                  Container(
                    width: 2,
                    height: 62,
                    margin: const EdgeInsets.only(top: 2),
                    color: BauhausDesign.neutral.withValues(alpha: 0.35),
                  ),
              ],
            ),
          ),
          const SizedBox(width: BauhausDesign.space2),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(BauhausDesign.space3),
              decoration: BoxDecoration(
                color: alert.accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                border: Border.all(color: BauhausDesign.neutral, width: 1.2),
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
                      borderRadius: BorderRadius.circular(
                        BauhausDesign.radiusSm,
                      ),
                      border: Border.all(color: BauhausDesign.neutral),
                    ),
                    child: Icon(
                      alert.icon,
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
                          alert.title,
                          style: BauhausDesign.getTextTheme(context).labelLarge
                              ?.copyWith(
                                color: BauhausDesign.textDark,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          alert.subtitle,
                          style: BauhausDesign.getTextTheme(context).bodySmall
                              ?.copyWith(
                                color: BauhausDesign.textDark,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: BauhausDesign.space1),
                        Text(
                          alert.timestamp,
                          style: BauhausDesign.getTextTheme(context).labelSmall
                              ?.copyWith(
                                color: BauhausDesign.textMuted,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: BauhausDesign.space2),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: BauhausDesign.space2,
                      vertical: BauhausDesign.space1,
                    ),
                    decoration: BoxDecoration(
                      color: alert.accent.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(
                        BauhausDesign.radiusSm,
                      ),
                      border: Border.all(color: BauhausDesign.neutral),
                    ),
                    child: Text(
                      alert.severity.toUpperCase(),
                      style: BauhausDesign.getTextTheme(context).labelSmall
                          ?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                ],
              ),
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
              'Set organization context to load Care Intelligence data.',
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

  Widget _buildMissingClientState(BuildContext context) {
    final organizationId = ref.read(app_providers.organizationIdProvider);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(BauhausDesign.space6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.people_alt_outlined,
              size: 44,
              color: BauhausDesign.textMuted,
            ),
            const SizedBox(height: BauhausDesign.space2),
            Text(
              'No clients available',
              style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: BauhausDesign.space1),
            Text(
              'Care Intelligence requires at least one client profile in this organization.',
              textAlign: TextAlign.center,
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                color: BauhausDesign.textMuted,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: BauhausDesign.space4),
            BauhausActionButton(
              text: 'Refresh',
              icon: Icons.refresh_rounded,
              onPressed: () {
                if (organizationId != null && organizationId.isNotEmpty) {
                  _initializeDashboard(organizationId, force: true);
                }
              },
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
        color: BauhausDesign.error.withValues(alpha: 0.12),
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

  _CareSummary _buildLiveSummary({
    required ClientState clientState,
    required IntelligenceState intelligenceState,
    required RiskPredictionState riskState,
    required MedicationState medicationState,
    required List<_CareAlert> alerts,
  }) {
    final report = intelligenceState.report;
    final assessment = riskState.assessment;

    final highAlertCount = alerts
        .where((alert) => _isHighSeverity(alert.severity))
        .length;

    final plansDue =
        report?.nextActions
            .where((action) => _isDueSoon(action.deadline, days: 14))
            .length ??
        0;

    final stableCases = assessment != null
        ? (100 - assessment.overallRisk).clamp(0, 100).toInt()
        : null;

    final goalProbability =
        report?.outcomePredictions.goalAchievement.probability;
    final healthConfidence =
        report?.outcomePredictions.healthStability.confidence;

    return _CareSummary(
      activeClientLabel: _activeClientName != null
          ? 'CLIENT · ${_activeClientName!.toUpperCase()}'
          : null,
      monitoredClients: clientState.clients.isNotEmpty
          ? '${clientState.clients.length}'
          : 'N/A',
      coverageDetail: report != null
          ? 'Intelligence score ${report.intelligenceScore} with ${report.riskSummary.trendDirection} risk trajectory.'
          : 'Coverage syncs once intelligence and risk feeds are available for the selected client.',
      plansDue: '$plansDue',
      stableCases: stableCases != null ? '$stableCases%' : 'N/A',
      escalations: '$highAlertCount',
      immediateReviewValue: '$highAlertCount clients',
      immediateReviewDetail: highAlertCount > 0
          ? 'Escalation queue requires supervisor decision.'
          : 'No high-severity care escalations are currently active.',
      medicationWatchValue: '${medicationState.alerts.length} alerts',
      medicationWatchDetail: medicationState.alerts.isNotEmpty
          ? 'Potential timing or interaction conflicts identified.'
          : 'No medication alerts returned for this client.',
      outcomeMomentumValue: goalProbability != null
          ? '${(goalProbability * 100).toStringAsFixed(0)}%'
          : 'N/A',
      outcomeMomentumDetail: healthConfidence != null
          ? 'Prediction confidence ${(healthConfidence * 100).toStringAsFixed(0)}% for this cycle.'
          : 'Outcome momentum appears once intelligence prediction data loads.',
    );
  }

  List<_RiskSignal> _buildLiveRiskSignals(RiskPredictionState riskState) {
    final assessment = riskState.assessment;
    if (assessment == null) return _riskSignals;

    final trendLabel = _buildTrendLabel(
      direction: assessment.trends.direction,
      changePercentage: assessment.trends.changePercentage,
    );

    return [
      _RiskSignal(
        title: 'Falls Exposure',
        score: assessment.fallsRisk.score.toDouble(),
        trend: '${assessment.fallsRisk.level} · $trendLabel',
        accent: _riskColor(assessment.fallsRisk.score.toDouble()),
      ),
      _RiskSignal(
        title: 'Medication Conflict',
        score: assessment.medicationRisk.score.toDouble(),
        trend: '${assessment.medicationRisk.level} · $trendLabel',
        accent: _riskColor(assessment.medicationRisk.score.toDouble()),
      ),
      _RiskSignal(
        title: 'Plan Drift',
        score: assessment.healthRisk.score.toDouble(),
        trend: '${assessment.healthRisk.level} · $trendLabel',
        accent: _riskColor(assessment.healthRisk.score.toDouble()),
      ),
      _RiskSignal(
        title: 'Incident Recurrence',
        score: assessment.behaviorRisk.score.toDouble(),
        trend: '${assessment.behaviorRisk.level} · $trendLabel',
        accent: _riskColor(assessment.behaviorRisk.score.toDouble()),
      ),
    ];
  }

  List<_CareAlert> _buildLiveAlerts(
    IntelligenceState intelligenceState,
    MedicationState medicationState,
  ) {
    final liveAlerts = <_CareAlert>[];

    final report = intelligenceState.report;
    if (report != null) {
      for (final alert in report.alerts) {
        liveAlerts.add(
          _CareAlert(
            title: '${alert.type}: ${alert.message}',
            subtitle: alert.action,
            timestamp: _formatTimestamp(report.generatedAt),
            severity: alert.severity,
            accent: _severityColor(alert.severity),
            icon: _alertIcon(type: alert.type, severity: alert.severity),
          ),
        );
      }
    }

    for (final alert in medicationState.alerts) {
      liveAlerts.add(
        _CareAlert(
          title: 'Medication: ${alert.message}',
          subtitle: alert.action,
          timestamp: _formatTimestamp(alert.dueDate ?? alert.timestamp),
          severity: alert.severity,
          accent: _severityColor(alert.severity),
          icon: _alertIcon(type: alert.type, severity: alert.severity),
        ),
      );
    }

    if (liveAlerts.isEmpty) return _alerts;
    return liveAlerts.take(6).toList();
  }

  bool _isDueSoon(String value, {int days = 14}) {
    final dueDate = DateTime.tryParse(value);
    if (dueDate == null) return false;
    final now = DateTime.now();
    return dueDate.isAfter(now) &&
        dueDate.isBefore(now.add(Duration(days: days)));
  }

  bool _isHighSeverity(String severity) {
    final normalized = severity.toLowerCase();
    return normalized.contains('critical') ||
        normalized.contains('high') ||
        normalized.contains('serious');
  }

  String _buildTrendLabel({
    required String direction,
    required int changePercentage,
  }) {
    final sign = changePercentage >= 0 ? '+' : '';
    return '$direction $sign$changePercentage%';
  }

  Color _riskColor(double score) {
    if (score >= 70) return BauhausDesign.error;
    if (score >= 40) return BauhausDesign.warning;
    return BauhausDesign.success;
  }

  Color _severityColor(String severity) {
    final normalized = severity.toLowerCase();
    if (normalized.contains('critical') || normalized.contains('high')) {
      return BauhausDesign.error;
    }
    if (normalized.contains('watch') || normalized.contains('medium')) {
      return BauhausDesign.warning;
    }
    if (normalized.contains('progress') || normalized.contains('stable')) {
      return BauhausDesign.success;
    }
    return BauhausDesign.secondary;
  }

  IconData _alertIcon({required String type, required String severity}) {
    final typeText = type.toLowerCase();
    final severityText = severity.toLowerCase();

    if (typeText.contains('fall')) return Icons.report_gmailerrorred_rounded;
    if (typeText.contains('medication') || typeText.contains('dose')) {
      return Icons.medication_outlined;
    }
    if (typeText.contains('behavior')) return Icons.psychology_alt_rounded;
    if (severityText.contains('critical') || severityText.contains('high')) {
      return Icons.priority_high_rounded;
    }
    return Icons.insights_rounded;
  }

  String _formatTimestamp(String? value) {
    if (value == null || value.isEmpty) return 'recent';
    final timestamp = DateTime.tryParse(value);
    if (timestamp == null) return 'recent';

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
}

class _CareModule {
  final String title;
  final String description;
  final IconData icon;
  final Color accent;
  final String route;

  const _CareModule({
    required this.title,
    required this.description,
    required this.icon,
    required this.accent,
    required this.route,
  });
}

class _JourneyStep {
  final String title;
  final String detail;
  final IconData icon;
  final Color accent;

  const _JourneyStep({
    required this.title,
    required this.detail,
    required this.icon,
    required this.accent,
  });
}

class _RiskSignal {
  final String title;
  final double score;
  final String trend;
  final Color accent;

  const _RiskSignal({
    required this.title,
    required this.score,
    required this.trend,
    required this.accent,
  });
}

class _CareAlert {
  final String title;
  final String subtitle;
  final String timestamp;
  final String severity;
  final Color accent;
  final IconData icon;

  const _CareAlert({
    required this.title,
    required this.subtitle,
    required this.timestamp,
    required this.severity,
    required this.accent,
    required this.icon,
  });
}

class _CareSummary {
  final String? activeClientLabel;
  final String monitoredClients;
  final String coverageDetail;
  final String plansDue;
  final String stableCases;
  final String escalations;
  final String immediateReviewValue;
  final String immediateReviewDetail;
  final String medicationWatchValue;
  final String medicationWatchDetail;
  final String outcomeMomentumValue;
  final String outcomeMomentumDetail;

  const _CareSummary({
    this.activeClientLabel,
    required this.monitoredClients,
    required this.coverageDetail,
    required this.plansDue,
    required this.stableCases,
    required this.escalations,
    required this.immediateReviewValue,
    required this.immediateReviewDetail,
    required this.medicationWatchValue,
    required this.medicationWatchDetail,
    required this.outcomeMomentumValue,
    required this.outcomeMomentumDetail,
  });
}

class _CanvasTag extends StatelessWidget {
  final String label;
  final String value;
  final Color accent;

  const _CanvasTag({
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
