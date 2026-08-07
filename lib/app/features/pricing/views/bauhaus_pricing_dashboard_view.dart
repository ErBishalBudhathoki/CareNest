import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/auth/models/user_model.dart';
import 'package:carenest/app/features/pricing/models/pricing_analytics_models.dart';
import 'package:carenest/app/features/pricing/providers/pricing_live_data_providers.dart';
import 'package:carenest/app/features/pricing/views/bulk_operations_view.dart';
import 'package:carenest/app/features/pricing/views/ndis_pricing_management_view.dart';
import 'package:carenest/app/features/pricing/views/price_history_view.dart';
import 'package:carenest/app/features/pricing/views/pricing_configuration_view.dart';
import 'package:carenest/app/features/pricing/views/service_rate_management_view.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class BauhausPricingDashboardView extends ConsumerStatefulWidget {
  final String? adminEmail;
  final String? organizationId;
  final String? organizationName;

  const BauhausPricingDashboardView({
    super.key,
    this.adminEmail,
    this.organizationId,
    this.organizationName,
  });

  @override
  ConsumerState<BauhausPricingDashboardView> createState() =>
      _BauhausPricingDashboardViewState();
}

class _BauhausPricingDashboardViewState
    extends ConsumerState<BauhausPricingDashboardView> {
  static const Color _screenGray = Color(0xFFE3E3E3);
  static const Color _inkBlack = Color(0xFF171717);
  static const Color _accentRed = Color(0xFFE21F26);
  static const Color _panelWhite = Color(0xFFF8F8F8);
  static const Color _accentBlue = Color(0xFF0D62B3);

  String _formatCurrency(double amount) {
    if (amount >= 1000000) return '\$${(amount / 1000000).toStringAsFixed(1)}M';
    if (amount >= 1000) return '\$${(amount / 1000).toStringAsFixed(1)}K';
    return '\$${amount.toStringAsFixed(0)}';
  }

  String _formatPercent(double value) => '${value.toStringAsFixed(1)}%';

  DateTime? _extractRecordDate(PricingLiveRecord record) =>
      record.updatedAt ?? record.createdAt;

  Future<void> _refresh(String organizationId) async {
    ref.invalidate(pricingLiveRecordsProvider(organizationId));
    ref.invalidate(pricingOrgEmployeesProvider(organizationId));
    ref.invalidate(pricingOrgAnalyticsProvider(organizationId));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final organizationId = widget.organizationId?.trim() ?? '';
    final hasOrgContext = organizationId.isNotEmpty;

    final AsyncValue<List<PricingLiveRecord>> recordsAsync = hasOrgContext
        ? ref.watch(pricingLiveRecordsProvider(organizationId))
        : const AsyncData<List<PricingLiveRecord>>(<PricingLiveRecord>[]);
    final AsyncValue<List<User>> employeesAsync = hasOrgContext
        ? ref.watch(pricingOrgEmployeesProvider(organizationId))
        : const AsyncData<List<User>>(<User>[]);
    final AsyncValue<PricingAnalytics?> analyticsAsync = hasOrgContext
        ? ref.watch(pricingOrgAnalyticsProvider(organizationId))
        : const AsyncData<PricingAnalytics?>(null);

    final records = recordsAsync.value ?? const <PricingLiveRecord>[];
    final employees = employeesAsync.value ?? const <User>[];
    final analytics = analyticsAsync.value;
    final isLoading =
        recordsAsync.isLoading ||
        employeesAsync.isLoading ||
        analyticsAsync.isLoading;

    final totalItems = records.length;
    final customItems = records.where((r) => r.isCustom).length;
    final configuredRates = employees
        .where((e) => e.payRate > 0 || e.detailedRates != null)
        .length;
    final missingRates = (employees.length - configuredRates).clamp(0, 99999);
    final averageRate = configuredRates == 0
        ? 0.0
        : employees
                  .where((e) => e.payRate > 0)
                  .map((e) => e.payRate)
                  .fold<double>(0.0, (sum, v) => sum + v) /
              configuredRates;

    final compliance =
        analytics?.metrics.complianceRate ??
        (totalItems == 0 ? 0.0 : (customItems / totalItems) * 100);
    final revenue = analytics?.metrics.totalRevenue ?? 0.0;
    final violations = analytics?.metrics.nonCompliantItems ?? 0;

    final changedLastWeek = records.where((record) {
      final dt = _extractRecordDate(record);
      if (dt == null) return false;
      return dt.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).length;

    final recentChanges = records
        .where((record) => record.isCustom)
        .take(8)
        .toList(growable: false);

    return Scaffold(
      backgroundColor: _screenGray,
      body: RefreshIndicator(
        onRefresh: () => _refresh(organizationId),
        color: BauhausDesign.primary,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader()),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!hasOrgContext)
                      _buildInlineNotice(
                        l10n.orgContextMissingError,
                        isWarning: true,
                      ),
                    if (recordsAsync.hasError ||
                        employeesAsync.hasError ||
                        analyticsAsync.hasError)
                      _buildInlineNotice(l10n.errorOccurred, isWarning: true),
                    _buildMetricsGrid(
                      l10n: l10n,
                      isLoading: isLoading,
                      totalItems: totalItems,
                      customItems: customItems,
                      configuredRates: configuredRates,
                      missingRates: missingRates,
                      compliance: compliance,
                      revenue: revenue,
                    ),
                    const SizedBox(height: 20),
                    _buildActionGrid(l10n),
                    const SizedBox(height: 20),
                    _buildInsightsPanel(
                      l10n: l10n,
                      isLoading: isLoading,
                      changedLastWeek: changedLastWeek,
                      averageRate: averageRate,
                      compliance: compliance,
                      violations: violations,
                      customItems: customItems,
                      totalItems: totalItems,
                    ),
                    const SizedBox(height: 20),
                    _buildRecentActivity(
                      l10n: l10n,
                      isLoading: isLoading,
                      changes: recentChanges,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      color: _screenGray,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
          child: Container(
            color: _screenGray,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: _panelWhite,
                          border: Border.all(color: _inkBlack, width: 2),
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          size: 18,
                          color: _inkBlack,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        l10n.pricingDashboardTitle,
                        style: BauhausDesign.getTextTheme(context)
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: _inkBlack,
                              letterSpacing: 0.4,
                            ),
                      ),
                    ),
                    InkWell(
                      onTap: _openPricingSettings,
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: _accentBlue,
                          border: Border.all(color: _inkBlack, width: 2),
                        ),
                        child: const Icon(
                          Icons.settings,
                          size: 18,
                          color: BauhausDesign.surfaceWhite,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.pricingUpdateMessage,
                        style: BauhausDesign.getTextTheme(context).labelLarge
                            ?.copyWith(
                              color: _inkBlack,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.2,
                            ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _accentRed,
                        border: Border.all(color: _inkBlack, width: 2),
                      ),
                      child: Text(
                        l10n.systemActive.toUpperCase(),
                        style: BauhausDesign.getTextTheme(context).labelSmall
                            ?.copyWith(
                              color: BauhausDesign.surfaceWhite,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.6,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(color: _inkBlack, height: 1, thickness: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInlineNotice(String text, {bool isWarning = false}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isWarning ? const Color(0xFFFFF4E5) : _panelWhite,
        border: Border.all(
          color: isWarning ? BauhausDesign.warning : _inkBlack,
          width: 2,
        ),
      ),
      child: Text(
        text,
        style: BauhausDesign.getTextTheme(
          context,
        ).bodyMedium?.copyWith(color: _inkBlack, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _buildMetricsGrid({
    required AppLocalizations l10n,
    required bool isLoading,
    required int totalItems,
    required int customItems,
    required int configuredRates,
    required int missingRates,
    required double compliance,
    required double revenue,
  }) {
    final cards = [
      {
        'title': l10n.totalServicesLabel,
        'value': isLoading ? '--' : totalItems.toString(),
        'subtitle': l10n.moduleMetricCatalogItems,
        'color': BauhausDesign.secondary,
        'icon': Icons.medical_services_outlined,
      },
      {
        'title': l10n.moduleMetricCustomPrices,
        'value': isLoading ? '--' : customItems.toString(),
        'subtitle': l10n.moduleKeyInsightCoverage(
          customItems.toString(),
          totalItems.toString(),
        ),
        'color': BauhausDesign.success,
        'icon': Icons.sell_outlined,
      },
      {
        'title': l10n.activeRatesLabel,
        'value': isLoading ? '--' : configuredRates.toString(),
        'subtitle': l10n.moduleKeyInsightMissingRates(missingRates.toString()),
        'color': BauhausDesign.info,
        'icon': Icons.payments_outlined,
      },
      {
        'title': l10n.moduleMetricCompliance,
        'value': isLoading ? '--' : _formatPercent(compliance),
        'subtitle': revenue > 0 ? _formatCurrency(revenue) : l10n.naLabel,
        'color': BauhausDesign.warning,
        'icon': Icons.verified_outlined,
      },
    ];

    return GridView.builder(
      itemCount: cards.length,
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 124,
      ),
      itemBuilder: (context, index) {
        final card = cards[index];
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _panelWhite,
            border: Border.all(color: _inkBlack, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: card['color'] as Color,
                      border: Border.all(color: _inkBlack, width: 2),
                    ),
                    child: Icon(
                      card['icon'] as IconData,
                      size: 14,
                      color: BauhausDesign.surfaceWhite,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      (card['title'] as String).toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: BauhausDesign.getTextTheme(context).labelSmall
                          ?.copyWith(
                            color: _inkBlack,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.4,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                card['value'] as String,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: BauhausDesign.getTextTheme(context).headlineSmall
                    ?.copyWith(color: _inkBlack, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 4),
              Text(
                card['subtitle'] as String,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                  color: BauhausDesign.textMuted,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionGrid(AppLocalizations l10n) {
    final actions = [
      {
        'title': l10n.ndisPricingTitle,
        'subtitle': l10n.ndisPricingSubtitle,
        'icon': Icons.grid_view_outlined,
        'color': BauhausDesign.secondary,
        'onTap': () => _navigateTo('ndis'),
      },
      {
        'title': l10n.serviceRatesTitle,
        'subtitle': l10n.serviceRatesSubtitle,
        'icon': Icons.rate_review_outlined,
        'color': BauhausDesign.success,
        'onTap': () => _navigateTo('rates'),
      },
      {
        'title': l10n.bulkOperationsTitle,
        'subtitle': l10n.bulkOperationsSubtitle,
        'icon': Icons.batch_prediction_outlined,
        'color': BauhausDesign.warning,
        'onTap': () => _navigateTo('bulk'),
      },
      {
        'title': l10n.priceHistoryTitle,
        'subtitle': l10n.priceHistorySubtitle,
        'icon': Icons.history_outlined,
        'color': BauhausDesign.info,
        'onTap': () => _navigateTo('history'),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.quickActions,
          style: BauhausDesign.getTextTheme(
            context,
          ).labelLarge?.copyWith(color: _inkBlack, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          itemCount: actions.length,
          shrinkWrap: true,
          primary: false,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 88,
          ),
          itemBuilder: (context, index) {
            final action = actions[index];
            return InkWell(
              onTap: action['onTap'] as VoidCallback,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _panelWhite,
                  border: Border.all(color: _inkBlack, width: 2),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: action['color'] as Color,
                        border: Border.all(color: _inkBlack, width: 2),
                      ),
                      child: Icon(
                        action['icon'] as IconData,
                        size: 14,
                        color: BauhausDesign.surfaceWhite,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            (action['title'] as String).toUpperCase(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: BauhausDesign.getTextTheme(context)
                                .labelSmall
                                ?.copyWith(
                                  color: _inkBlack,
                                  fontWeight: FontWeight.w900,
                                ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            action['subtitle'] as String,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: BauhausDesign.getTextTheme(context)
                                .labelSmall
                                ?.copyWith(
                                  color: BauhausDesign.textMuted,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildInsightsPanel({
    required AppLocalizations l10n,
    required bool isLoading,
    required int changedLastWeek,
    required double averageRate,
    required double compliance,
    required int violations,
    required int customItems,
    required int totalItems,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _panelWhite,
        border: Border.all(color: _inkBlack, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.pricingAnalyticsTitle.toUpperCase(),
            style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
              color: _inkBlack,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 8),
          _buildInsightLine(
            title: l10n.moduleMetricWeeklyChanges,
            value: isLoading ? '--' : changedLastWeek.toString(),
          ),
          _buildInsightLine(
            title: l10n.moduleMetricAvgBaseRate,
            value: isLoading
                ? '--'
                : (averageRate > 0
                      ? '\$${averageRate.toStringAsFixed(2)}'
                      : l10n.naLabel),
          ),
          _buildInsightLine(
            title: l10n.moduleMetricCompliance,
            value: isLoading ? '--' : _formatPercent(compliance),
          ),
          _buildInsightLine(
            title: l10n.moduleMetricActionableItems,
            value: isLoading ? '--' : violations.toString(),
          ),
          const SizedBox(height: 6),
          Text(
            isLoading
                ? l10n.moduleNoDataYet
                : l10n.moduleKeyInsightCoverage(
                    customItems.toString(),
                    totalItems.toString(),
                  ),
            style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
              color: BauhausDesign.textMuted,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightLine({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                color: _inkBlack,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            value,
            style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
              color: _inkBlack,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity({
    required AppLocalizations l10n,
    required bool isLoading,
    required List<PricingLiveRecord> changes,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _panelWhite,
        border: Border.all(color: _inkBlack, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.recentActivity.toUpperCase(),
            style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
              color: _inkBlack,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 8),
          if (isLoading)
            const LinearProgressIndicator(minHeight: 2)
          else if (changes.isEmpty)
            Text(
              l10n.moduleNoTrackedChanges,
              style: BauhausDesign.getTextTheme(
                context,
              ).bodySmall?.copyWith(color: BauhausDesign.textMuted),
            )
          else
            ...changes.map((record) {
              final stamp = record.effectiveTimestamp;
              final dateText = stamp == null
                  ? l10n.moduleNoDataYet
                  : '${stamp.year}-${stamp.month.toString().padLeft(2, '0')}-${stamp.day.toString().padLeft(2, '0')}';
              return Container(
                margin: const EdgeInsets.only(bottom: 6),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: BauhausDesign.backgroundLight,
                  border: Border.all(color: _inkBlack, width: 1),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${record.supportItemNumber} · ${record.supportItemName}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: BauhausDesign.getTextTheme(context).labelSmall
                            ?.copyWith(
                              color: _inkBlack,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      record.customPrice == null
                          ? l10n.naLabel
                          : '\$${record.customPrice!.toStringAsFixed(2)}',
                      style: BauhausDesign.getTextTheme(context).labelSmall
                          ?.copyWith(
                            color: BauhausDesign.primary,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      dateText,
                      style: BauhausDesign.getTextTheme(context).labelSmall
                          ?.copyWith(
                            color: BauhausDesign.textMuted,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }

  void _navigateTo(String route) {
    final admin = widget.adminEmail ?? '';
    final organizationId = widget.organizationId ?? '';
    final organizationName = widget.organizationName ?? '';

    Widget destination;
    switch (route) {
      case 'ndis':
        destination = NdisPricingManagementView(
          adminEmail: admin,
          organizationId: organizationId,
          organizationName: organizationName,
        );
        break;
      case 'rates':
        destination = ServiceRateManagementView(
          adminEmail: admin,
          organizationId: organizationId,
          organizationName: organizationName,
        );
        break;
      case 'bulk':
        destination = BulkOperationsView(
          adminEmail: admin,
          organizationId: organizationId,
          organizationName: organizationName,
        );
        break;
      case 'history':
        destination = PriceHistoryView(
          adminEmail: admin,
          organizationId: organizationId,
          organizationName: organizationName,
        );
        break;
      default:
        return;
    }

    Navigator.of(context).push(MaterialPageRoute(builder: (_) => destination));
  }

  void _openPricingSettings() {
    final l10n = AppLocalizations.of(context)!;
    final organizationId = widget.organizationId;
    final adminEmail = widget.adminEmail;
    final organizationName = widget.organizationName;

    if (organizationId == null ||
        organizationId.isEmpty ||
        adminEmail == null ||
        adminEmail.isEmpty ||
        organizationName == null ||
        organizationName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.orgContextMissingError),
          backgroundColor: BauhausDesign.error,
        ),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PricingConfigurationView(
          adminEmail: adminEmail,
          organizationId: organizationId,
          organizationName: organizationName,
        ),
      ),
    );
  }
}
