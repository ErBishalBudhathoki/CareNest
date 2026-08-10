import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/features/payroll/models/advanced_payroll_models.dart';
import 'package:carenest/app/features/payroll/viewmodels/advanced_payroll_viewmodel.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvancedPayrollDashboard extends ConsumerStatefulWidget {
  final String? organizationId;
  final String? userId;

  const AdvancedPayrollDashboard({super.key, this.organizationId, this.userId});

  @override
  ConsumerState<AdvancedPayrollDashboard> createState() =>
      _AdvancedPayrollDashboardState();
}

class _AdvancedPayrollDashboardState
    extends ConsumerState<AdvancedPayrollDashboard> {
  late String _selectedPeriod;
  String? _loadedOrganizationId;
  String? _loadedPeriod;
  String? _activeOrganizationId;
  String? _resolvedUserId;
  bool _isBootstrapping = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedPeriod = '${now.year}-${now.month.toString().padLeft(2, '0')}';

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeDashboard(force: true);
    });
  }

  String? _resolveOrganizationId() {
    final widgetOrg = widget.organizationId?.trim();
    if (widgetOrg != null && widgetOrg.isNotEmpty) {
      return widgetOrg;
    }

    final providerOrg = ref.read(app_providers.organizationIdProvider)?.trim();
    if (providerOrg != null && providerOrg.isNotEmpty) {
      return providerOrg;
    }

    return null;
  }

  Future<String?> _resolveUserId() async {
    final explicitUser = widget.userId?.trim();
    if (explicitUser != null && explicitUser.isNotEmpty) {
      return explicitUser;
    }

    final prefs = ref.read(app_providers.sharedPreferencesProvider);
    await prefs.init();

    final userId = prefs.getUserId()?.trim();
    if (userId != null && userId.isNotEmpty) {
      return userId;
    }

    final email = prefs.getUserEmail()?.trim();
    if (email != null && email.isNotEmpty) {
      return email;
    }

    return null;
  }

  Future<void> _initializeDashboard({bool force = false}) async {
    final orgId = _resolveOrganizationId();

    if (_isBootstrapping && !force) return;

    if (orgId == null || orgId.isEmpty) {
      if (mounted) {
        setState(() {
          _activeOrganizationId = null;
        });
      }
      return;
    }

    if (!force &&
        _loadedOrganizationId == orgId &&
        _loadedPeriod == _selectedPeriod) {
      return;
    }

    if (mounted) {
      setState(() {
        _activeOrganizationId = orgId;
      });
    }

    _isBootstrapping = true;

    try {
      _resolvedUserId = await _resolveUserId();
      await ref
          .read(advancedPayrollViewModelProvider.notifier)
          .getPayrollSummary(orgId, _selectedPeriod);

      _loadedOrganizationId = orgId;
      _loadedPeriod = _selectedPeriod;
    } finally {
      _isBootstrapping = false;
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final providerOrgId = ref.watch(app_providers.organizationIdProvider);
    final desiredOrgId = (widget.organizationId?.trim().isNotEmpty ?? false)
        ? widget.organizationId!.trim()
        : providerOrgId?.trim();

    if (desiredOrgId != null &&
        desiredOrgId.isNotEmpty &&
        (_loadedOrganizationId != desiredOrgId ||
            _activeOrganizationId == null) &&
        !_isBootstrapping) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _initializeDashboard(force: true);
        }
      });
    }

    final state = ref.watch(advancedPayrollViewModelProvider);
    final summary = state.summary;
    final isLoading = (state.isLoading || _isBootstrapping) && summary == null;
    final error = _normalizeError(state.error);

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: _buildAppBar(context),
      body: _activeOrganizationId == null
          ? _buildMissingOrganizationState(context)
          : isLoading
          ? const Center(child: BauhausLoadingState())
          : RefreshIndicator(
              color: BauhausDesign.success,
              onRefresh: () => _initializeDashboard(force: true),
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
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
                          _buildRunControlPanel(context, summary),
                          const SizedBox(height: BauhausDesign.space6),
                          _buildSectionHeader(
                            context,
                            title: 'Payroll Snapshot',
                            subtitle:
                                'Live payroll totals for period $_selectedPeriod.',
                            accent: BauhausDesign.success,
                          ),
                          const SizedBox(height: BauhausDesign.space3),
                          _buildSnapshotGrid(context, summary),
                          const SizedBox(height: BauhausDesign.space6),
                          _buildSectionHeader(
                            context,
                            title: 'Cost Composition',
                            subtitle:
                                'Gross payroll split into net pay, tax, and super.',
                            accent: BauhausDesign.primary,
                          ),
                          const SizedBox(height: BauhausDesign.space3),
                          _buildCompositionTrack(context, summary),
                          const SizedBox(height: BauhausDesign.space6),
                          _buildSectionHeader(
                            context,
                            title: 'Execution Actions',
                            subtitle:
                                'Run calculations, generate payslips, and export accounting payloads.',
                            accent: BauhausDesign.secondary,
                          ),
                          const SizedBox(height: BauhausDesign.space3),
                          _buildActionDeck(context, state),
                          const SizedBox(height: BauhausDesign.space6),
                          if (state.calculation != null) ...[
                            _buildSectionHeader(
                              context,
                              title: 'Latest Simulation',
                              subtitle:
                                  'Most recent payroll calculation response.',
                              accent: BauhausDesign.accent,
                            ),
                            const SizedBox(height: BauhausDesign.space3),
                            _buildLatestSimulation(context, state.calculation!),
                            const SizedBox(height: BauhausDesign.space6),
                          ],
                          _buildSectionHeader(
                            context,
                            title: 'Employee Settlement Ledger',
                            subtitle:
                                'Per-employee gross to net conversion for the selected period.',
                            accent: BauhausDesign.warning,
                          ),
                          const SizedBox(height: BauhausDesign.space3),
                          _buildEmployeeLedger(context, summary),
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
    final textTheme = BauhausDesign.getTextTheme(context);

    return AppBar(
      backgroundColor: BauhausDesign.success,
      elevation: 0,
      titleSpacing: 0,
      title: Text(
        'ADVANCED PAYROLL',
        style: textTheme.headlineMedium?.copyWith(
          color: BauhausDesign.surfaceWhite,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.8,
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
              child: Container(height: 8, color: BauhausDesign.surfaceWhite),
            ),
            Expanded(
              flex: 2,
              child: Container(height: 8, color: BauhausDesign.accent),
            ),
            Expanded(
              flex: 3,
              child: Container(height: 8, color: BauhausDesign.primary),
            ),
            Expanded(
              flex: 2,
              child: Container(height: 8, color: BauhausDesign.secondary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMissingOrganizationState(BuildContext context) {
    return Center(
      child: BauhausEmptyState(
        title: 'Organization Required',
        message:
            'Payroll dashboard requires an organization context before loading payroll records.',
        icon: Icons.domain_disabled_rounded,
        actionLabel: 'RETRY',
        onAction: () => _initializeDashboard(force: true),
      ),
    );
  }

  Widget _buildErrorBanner(BuildContext context, String error) {
    final textTheme = BauhausDesign.getTextTheme(context);

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
              style: textTheme.bodySmall?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRunControlPanel(BuildContext context, PayrollSummary? summary) {
    final textTheme = BauhausDesign.getTextTheme(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHard],
      ),
      child: Padding(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: BauhausDesign.success.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                    border: Border.all(
                      color: BauhausDesign.neutral,
                      width: 1.4,
                    ),
                  ),
                  child: const Icon(
                    Icons.payments_rounded,
                    color: BauhausDesign.textDark,
                    size: 28,
                  ),
                ),
                const SizedBox(width: BauhausDesign.space3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Payroll Operations Deck',
                        style: textTheme.headlineMedium?.copyWith(
                          color: BauhausDesign.textDark,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: BauhausDesign.space1),
                      Text(
                        'Organization: ${_activeOrganizationId ?? 'Unavailable'}',
                        style: textTheme.bodySmall?.copyWith(
                          color: BauhausDesign.textDark,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatusChip(
                  context,
                  summary == null ? 'NO RUN' : 'SYNCED',
                  summary == null
                      ? BauhausDesign.warning
                      : BauhausDesign.success,
                ),
              ],
            ),
            const SizedBox(height: BauhausDesign.space4),
            LayoutBuilder(
              builder: (context, constraints) {
                final compact = constraints.maxWidth < 620;
                final periodCard = Container(
                  padding: const EdgeInsets.all(BauhausDesign.space3),
                  decoration: BoxDecoration(
                    color: BauhausDesign.surfaceOffWhite,
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                    border: Border.all(
                      color: BauhausDesign.neutral,
                      width: 1.2,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_month_rounded,
                        color: BauhausDesign.textDark,
                        size: 18,
                      ),
                      const SizedBox(width: BauhausDesign.space2),
                      Expanded(
                        child: Text(
                          'Pay Period: $_selectedPeriod',
                          style: textTheme.bodySmall?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                );

                final runSummary = Container(
                  padding: const EdgeInsets.all(BauhausDesign.space3),
                  decoration: BoxDecoration(
                    color: BauhausDesign.surfaceOffWhite,
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                    border: Border.all(
                      color: BauhausDesign.neutral,
                      width: 1.2,
                    ),
                  ),
                  child: Text(
                    summary == null
                        ? 'No payroll records yet for this period.'
                        : '${summary.totalEmployees} employee(s) in current run.',
                    style: textTheme.bodySmall?.copyWith(
                      color: BauhausDesign.textDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );

                final actions = Wrap(
                  spacing: BauhausDesign.space2,
                  runSpacing: BauhausDesign.space2,
                  children: [
                    _buildInlineButton(
                      label: 'PERIOD',
                      icon: Icons.edit_calendar_rounded,
                      onPressed: () => _showPeriodPicker(context),
                    ),
                    _buildInlineButton(
                      label: 'REFRESH',
                      icon: Icons.refresh_rounded,
                      onPressed: () => _initializeDashboard(force: true),
                    ),
                  ],
                );

                if (compact) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      periodCard,
                      const SizedBox(height: BauhausDesign.space2),
                      runSummary,
                      const SizedBox(height: BauhausDesign.space2),
                      actions,
                    ],
                  );
                }

                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: periodCard),
                        const SizedBox(width: BauhausDesign.space2),
                        Expanded(child: runSummary),
                      ],
                    ),
                    const SizedBox(height: BauhausDesign.space2),
                    Align(alignment: Alignment.centerLeft, child: actions),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context, String label, Color color) {
    final textTheme = BauhausDesign.getTextTheme(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space3,
        vertical: BauhausDesign.space2,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(BauhausDesign.radiusFull),
        border: Border.all(color: BauhausDesign.neutral, width: 1),
      ),
      child: Text(
        label,
        style: textTheme.labelSmall?.copyWith(
          color: BauhausDesign.textDark,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildInlineButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16, color: BauhausDesign.textDark),
      label: Text(
        label,
        style: const TextStyle(
          color: BauhausDesign.textDark,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: BauhausDesign.neutral, width: 1.2),
        backgroundColor: BauhausDesign.surfaceOffWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: BauhausDesign.space3,
          vertical: BauhausDesign.space2,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    required String subtitle,
    required Color accent,
  }) {
    final textTheme = BauhausDesign.getTextTheme(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8,
          height: 54,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
          ),
        ),
        const SizedBox(width: BauhausDesign.space3),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.headlineLarge?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: BauhausDesign.space1),
              Text(
                subtitle,
                style: textTheme.bodyMedium?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSnapshotGrid(BuildContext context, PayrollSummary? summary) {
    final employees = summary?.totalEmployees ?? 0;
    final gross = summary?.totalGrossPay ?? 0;
    final tax = summary?.totalTax ?? 0;
    final superAmount = summary?.totalSuper ?? 0;
    final net = summary?.totalNetPay ?? 0;

    final averageNet = employees > 0 ? net / employees : 0;
    final statutory = tax + superAmount;
    final netRatio = gross > 0 ? net / gross : 0.0;

    final metrics = [
      _PayrollMetricCard(
        label: 'Employees',
        value: employees.toString(),
        detail: 'Active in this payroll run',
        icon: Icons.groups_rounded,
        accent: BauhausDesign.secondary,
      ),
      _PayrollMetricCard(
        label: 'Gross Payroll',
        value: _formatCurrencyCompact(gross),
        detail: 'Total earnings before deductions',
        icon: Icons.account_balance_wallet_rounded,
        accent: BauhausDesign.primary,
      ),
      _PayrollMetricCard(
        label: 'Net Disbursement',
        value: _formatCurrencyCompact(net),
        detail: 'Total take-home payout',
        icon: Icons.payments_rounded,
        accent: BauhausDesign.success,
      ),
      _PayrollMetricCard(
        label: 'Statutory Costs',
        value: _formatCurrencyCompact(statutory),
        detail: 'Tax + super obligations',
        icon: Icons.account_balance_rounded,
        accent: BauhausDesign.warning,
      ),
      _PayrollMetricCard(
        label: 'Avg Net / Employee',
        value: _formatCurrencyCompact(averageNet),
        detail: 'Mean take-home amount',
        icon: Icons.person_outline_rounded,
        accent: BauhausDesign.accent,
      ),
      _PayrollMetricCard(
        label: 'Net Ratio',
        value: _formatPercent(netRatio),
        detail: 'Net payout as % of gross',
        icon: Icons.pie_chart_rounded,
        accent: BauhausDesign.success,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 1100
            ? 3
            : constraints.maxWidth >= 680
            ? 2
            : 1;
        final spacing = BauhausDesign.space3;
        final cardWidth =
            (constraints.maxWidth - (columns - 1) * spacing) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final metric in metrics)
              SizedBox(
                width: cardWidth,
                child: _buildMetricCard(context, metric),
              ),
          ],
        );
      },
    );
  }

  Widget _buildMetricCard(BuildContext context, _PayrollMetricCard metric) {
    final textTheme = BauhausDesign.getTextTheme(context);

    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 1.4),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: metric.accent,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(BauhausDesign.radiusMd),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(metric.icon, size: 18, color: BauhausDesign.textDark),
                    const SizedBox(width: BauhausDesign.space2),
                    Expanded(
                      child: Text(
                        metric.label,
                        style: textTheme.labelLarge?.copyWith(
                          color: BauhausDesign.textDark,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: BauhausDesign.space2),
                Text(
                  metric.value,
                  style: textTheme.headlineMedium?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: BauhausDesign.space1),
                Text(
                  metric.detail,
                  style: textTheme.bodySmall?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompositionTrack(BuildContext context, PayrollSummary? summary) {
    final textTheme = BauhausDesign.getTextTheme(context);

    final gross = summary?.totalGrossPay ?? 0;
    final net = summary?.totalNetPay ?? 0;
    final tax = summary?.totalTax ?? 0;
    final superAmount = summary?.totalSuper ?? 0;

    if (gross <= 0) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: BauhausDesign.surfaceWhite,
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          border: Border.all(color: BauhausDesign.neutral, width: 1.4),
        ),
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: Text(
          'No gross payroll data available for this period.',
          style: textTheme.bodyMedium?.copyWith(
            color: BauhausDesign.textDark,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    final components = [
      _CostComponent(
        label: 'Net Pay',
        value: net,
        color: BauhausDesign.success,
      ),
      _CostComponent(label: 'Tax', value: tax, color: BauhausDesign.primary),
      _CostComponent(
        label: 'Super',
        value: superAmount,
        color: BauhausDesign.secondary,
      ),
    ];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 1.4),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gross Payroll: ${_formatCurrency(gross)}',
            style: textTheme.titleMedium?.copyWith(
              color: BauhausDesign.textDark,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          LayoutBuilder(
            builder: (context, constraints) {
              final barWidth = constraints.maxWidth;
              final total = components.fold<double>(
                0,
                (sum, item) => sum + item.value,
              );

              final segments = components
                  .where((component) => component.value > 0)
                  .map((component) {
                    final ratio = total > 0 ? component.value / total : 0.0;
                    final width = (barWidth * ratio).clamp(1.0, barWidth);
                    return _SegmentData(
                      label: component.label,
                      value: component.value,
                      color: component.color,
                      width: width,
                    );
                  })
                  .toList();

              return ClipRRect(
                borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                child: Row(
                  children: [
                    for (final segment in segments)
                      Container(
                        width: segment.width,
                        height: 24,
                        color: segment.color,
                      ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: BauhausDesign.space3),
          Wrap(
            spacing: BauhausDesign.space2,
            runSpacing: BauhausDesign.space2,
            children: [
              for (final component in components)
                _buildLegendChip(
                  context,
                  label: component.label,
                  value: component.value,
                  total: gross,
                  color: component.color,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendChip(
    BuildContext context, {
    required String label,
    required double value,
    required double total,
    required Color color,
  }) {
    final textTheme = BauhausDesign.getTextTheme(context);
    final ratio = total > 0 ? value / total : 0.0;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space3,
        vertical: BauhausDesign.space2,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(BauhausDesign.radiusFull),
        border: Border.all(color: BauhausDesign.neutral, width: 1),
      ),
      child: Text(
        '$label ${_formatCurrencyCompact(value)} (${_formatPercent(ratio)})',
        style: textTheme.bodySmall?.copyWith(
          color: BauhausDesign.textDark,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildActionDeck(BuildContext context, AdvancedPayrollState state) {
    final actions = [
      _ActionTileData(
        title: 'Run Payroll Calculation',
        detail:
            'Executes award, penalty, allowance, and tax/super simulation for the selected period.',
        buttonLabel: state.isLoading ? 'RUNNING...' : 'RUN CALCULATION',
        icon: Icons.calculate_rounded,
        accent: BauhausDesign.primary,
        onPressed: state.isLoading ? null : _calculatePayroll,
      ),
      _ActionTileData(
        title: 'Generate Payslips',
        detail:
            'Creates finalized payslips for employees included in this payroll period.',
        buttonLabel: state.isLoading ? 'GENERATING...' : 'GENERATE PAYSLIPS',
        icon: Icons.receipt_long_rounded,
        accent: BauhausDesign.secondary,
        onPressed: state.isLoading ? null : _generatePayslips,
      ),
      _ActionTileData(
        title: 'Export Accounting Payload',
        detail:
            'Exports payroll summary to accounting integration format for external processing.',
        buttonLabel: state.isExporting ? 'EXPORTING...' : 'EXPORT PAYROLL',
        icon: Icons.upload_file_rounded,
        accent: BauhausDesign.warning,
        onPressed: state.isExporting ? null : _exportPayroll,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 1080
            ? 3
            : constraints.maxWidth >= 700
            ? 2
            : 1;
        final spacing = BauhausDesign.space3;
        final cardWidth =
            (constraints.maxWidth - (columns - 1) * spacing) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final action in actions)
              SizedBox(
                width: cardWidth,
                child: _buildActionTile(context, action),
              ),
          ],
        );
      },
    );
  }

  Widget _buildActionTile(BuildContext context, _ActionTileData action) {
    final textTheme = BauhausDesign.getTextTheme(context);

    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 1.4),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: Padding(
        padding: const EdgeInsets.all(BauhausDesign.space3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: action.accent.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                border: Border.all(color: BauhausDesign.neutral, width: 1.1),
              ),
              child: Icon(action.icon, color: BauhausDesign.textDark, size: 22),
            ),
            const SizedBox(height: BauhausDesign.space2),
            Text(
              action.title,
              style: textTheme.labelLarge?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: BauhausDesign.space1),
            Text(
              action.detail,
              style: textTheme.bodySmall?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: BauhausDesign.space3),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: action.onPressed,
                icon: Icon(action.icon, size: 16),
                label: Text(action.buttonLabel),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  foregroundColor: BauhausDesign.surfaceWhite,
                  backgroundColor: action.accent,
                  padding: const EdgeInsets.symmetric(
                    vertical: BauhausDesign.space2,
                    horizontal: BauhausDesign.space3,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLatestSimulation(
    BuildContext context,
    PayrollCalculation calculation,
  ) {
    final textTheme = BauhausDesign.getTextTheme(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 1.4),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'User ${calculation.userId} • ${calculation.period}',
            style: textTheme.titleMedium?.copyWith(
              color: BauhausDesign.textDark,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          Wrap(
            spacing: BauhausDesign.space2,
            runSpacing: BauhausDesign.space2,
            children: [
              _buildLegendChip(
                context,
                label: 'Gross',
                value: calculation.grossPay,
                total: calculation.grossPay,
                color: BauhausDesign.primary,
              ),
              _buildLegendChip(
                context,
                label: 'Net',
                value: calculation.netPay,
                total: calculation.grossPay,
                color: BauhausDesign.success,
              ),
              _buildLegendChip(
                context,
                label: 'Tax',
                value: calculation.taxAndSuper.tax,
                total: calculation.grossPay,
                color: BauhausDesign.warning,
              ),
              _buildLegendChip(
                context,
                label: 'Super',
                value: calculation.taxAndSuper.superAmount,
                total: calculation.grossPay,
                color: BauhausDesign.secondary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeLedger(BuildContext context, PayrollSummary? summary) {
    final textTheme = BauhausDesign.getTextTheme(context);

    if (summary == null || summary.employees.isEmpty) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: BauhausDesign.surfaceWhite,
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          border: Border.all(color: BauhausDesign.neutral, width: 1.4),
        ),
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: Text(
          'No employee payroll records found for $_selectedPeriod.',
          style: textTheme.bodyMedium?.copyWith(
            color: BauhausDesign.textDark,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    final employees = summary.employees.toList()
      ..sort((a, b) => b.netPay.compareTo(a.netPay));

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 1.4),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      padding: const EdgeInsets.all(BauhausDesign.space3),
      child: Column(
        children: [
          for (var i = 0; i < employees.length; i++) ...[
            _buildEmployeeRow(context, i + 1, employees[i]),
            if (i < employees.length - 1)
              const Divider(height: BauhausDesign.space4),
          ],
        ],
      ),
    );
  }

  Widget _buildEmployeeRow(
    BuildContext context,
    int rank,
    EmployeePayrollSummary employee,
  ) {
    final textTheme = BauhausDesign.getTextTheme(context);
    final conversion = employee.grossPay > 0
        ? employee.netPay / employee.grossPay
        : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: BauhausDesign.surfaceOffWhite,
                borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                border: Border.all(color: BauhausDesign.neutral, width: 1),
              ),
              child: Text(
                '$rank',
                style: textTheme.bodySmall?.copyWith(
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
                  Text(
                    employee.userName,
                    style: textTheme.labelLarge?.copyWith(
                      color: BauhausDesign.textDark,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: BauhausDesign.space1),
                  Text(
                    'Gross ${_formatCurrency(employee.grossPay)} • Net ${_formatCurrency(employee.netPay)}',
                    style: textTheme.bodySmall?.copyWith(
                      color: BauhausDesign.textDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: BauhausDesign.space2,
                vertical: BauhausDesign.space1,
              ),
              decoration: BoxDecoration(
                color: BauhausDesign.success.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                border: Border.all(color: BauhausDesign.neutral, width: 1),
              ),
              child: Text(
                _formatPercent(conversion),
                style: textTheme.bodySmall?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: BauhausDesign.space2),
        LayoutBuilder(
          builder: (context, constraints) {
            final totalWidth = constraints.maxWidth;
            final netWidth = (totalWidth * conversion).clamp(2.0, totalWidth);

            return Stack(
              children: [
                Container(
                  height: 8,
                  width: totalWidth,
                  decoration: BoxDecoration(
                    color: BauhausDesign.surfaceOffWhite,
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                    border: Border.all(
                      color: BauhausDesign.neutral,
                      width: 0.8,
                    ),
                  ),
                ),
                Container(
                  height: 8,
                  width: netWidth,
                  decoration: BoxDecoration(
                    color: BauhausDesign.success,
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Future<void> _showPeriodPicker(BuildContext context) async {
    final controller = TextEditingController(text: _selectedPeriod);
    String? validationError;

    await showDialog<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Select Payroll Period'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Use YYYY-MM format (example: 2026-02).'),
                  const SizedBox(height: BauhausDesign.space3),
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: '2026-02',
                      errorText: validationError,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('CANCEL'),
                ),
                FilledButton(
                  onPressed: () {
                    final value = controller.text.trim();
                    if (!_isValidPeriod(value)) {
                      setDialogState(() {
                        validationError = 'Invalid format. Use YYYY-MM.';
                      });
                      return;
                    }

                    Navigator.pop(context);
                    if (mounted) {
                      setState(() {
                        _selectedPeriod = value;
                      });
                      _initializeDashboard(force: true);
                    }
                  },
                  child: const Text('APPLY'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  bool _isValidPeriod(String period) {
    final regex = RegExp(r'^\d{4}-(0[1-9]|1[0-2])$');
    return regex.hasMatch(period);
  }

  Future<void> _calculatePayroll() async {
    final orgId = _activeOrganizationId ?? _resolveOrganizationId();
    if (orgId == null || orgId.isEmpty) {
      _showSnack(
        'Organization is required to calculate payroll.',
        isError: true,
      );
      return;
    }

    final userId = _resolvedUserId ?? await _resolveUserId() ?? 'system';

    final success = await ref
        .read(advancedPayrollViewModelProvider.notifier)
        .calculatePayroll({
          'organizationId': orgId,
          'userId': userId,
          'period': _selectedPeriod,
          'awardLevel': 'SCHADS-2',
          'hours': {
            'regular': 76,
            'overtime': 4,
            'saturday': 4,
            'sunday': 0,
            'publicHoliday': 0,
          },
          'travelKm': 0,
          'mealAllowance': 0,
          'sleepovers': 0,
          'hasFirstAid': false,
        });

    if (success) {
      _showSnack('Payroll calculation completed.');
      await _initializeDashboard(force: true);
      return;
    }

    final error = ref.read(advancedPayrollViewModelProvider).error;
    _showSnack(error ?? 'Failed to calculate payroll.', isError: true);
  }

  Future<void> _generatePayslips() async {
    final orgId = _activeOrganizationId ?? _resolveOrganizationId();
    if (orgId == null || orgId.isEmpty) {
      _showSnack(
        'Organization is required to generate payslips.',
        isError: true,
      );
      return;
    }

    final success = await ref
        .read(advancedPayrollViewModelProvider.notifier)
        .generatePayslips(orgId, _selectedPeriod);

    if (success) {
      _showSnack('Payslips generated successfully.');
      await _initializeDashboard(force: true);
      return;
    }

    final error = ref.read(advancedPayrollViewModelProvider).error;
    _showSnack(error ?? 'Failed to generate payslips.', isError: true);
  }

  Future<void> _exportPayroll() async {
    final orgId = _activeOrganizationId ?? _resolveOrganizationId();
    if (orgId == null || orgId.isEmpty) {
      _showSnack('Organization is required to export payroll.', isError: true);
      return;
    }

    final success = await ref
        .read(advancedPayrollViewModelProvider.notifier)
        .exportPayrollData({
          'organizationId': orgId,
          'period': _selectedPeriod,
          'format': 'xero',
        });

    if (success) {
      _showSnack('Payroll export initiated successfully.');
      return;
    }

    final error = ref.read(advancedPayrollViewModelProvider).error;
    _showSnack(error ?? 'Failed to export payroll.', isError: true);
  }

  void _showSnack(String message, {bool isError = false}) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? BauhausDesign.error : BauhausDesign.success,
      ),
    );
  }

  String? _normalizeError(String? error) {
    if (error == null || error.trim().isEmpty) return null;

    final normalized = error.toLowerCase();
    if (normalized.contains('not found')) return null;

    return error;
  }

  String _formatCurrency(num value) => '\$${value.toStringAsFixed(2)}';

  String _formatCurrencyCompact(num value) {
    final abs = value.abs();

    if (abs >= 1000000) {
      return '\$${(value / 1000000).toStringAsFixed(1)}M';
    }
    if (abs >= 1000) {
      return '\$${(value / 1000).toStringAsFixed(1)}K';
    }
    return '\$${value.toStringAsFixed(2)}';
  }

  String _formatPercent(double ratio) => '${(ratio * 100).toStringAsFixed(1)}%';
}

class _PayrollMetricCard {
  const _PayrollMetricCard({
    required this.label,
    required this.value,
    required this.detail,
    required this.icon,
    required this.accent,
  });

  final String label;
  final String value;
  final String detail;
  final IconData icon;
  final Color accent;
}

class _CostComponent {
  const _CostComponent({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final double value;
  final Color color;
}

class _SegmentData {
  const _SegmentData({
    required this.label,
    required this.value,
    required this.color,
    required this.width,
  });

  final String label;
  final double value;
  final Color color;
  final double width;
}

class _ActionTileData {
  const _ActionTileData({
    required this.title,
    required this.detail,
    required this.buttonLabel,
    required this.icon,
    required this.accent,
    required this.onPressed,
  });

  final String title;
  final String detail;
  final String buttonLabel;
  final IconData icon;
  final Color accent;
  final VoidCallback? onPressed;
}
