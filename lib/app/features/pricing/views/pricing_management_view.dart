import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/pricing/views/pricing_dashboard_view.dart';
import 'package:carenest/app/features/pricing/views/ndis_pricing_management_view.dart';
import 'package:carenest/app/features/pricing/views/service_rate_management_view.dart';
import 'package:carenest/app/features/pricing/views/bulk_operations_view.dart';
import 'package:carenest/app/features/pricing/views/price_history_view.dart';
import 'package:carenest/app/features/pricing/views/pricing_configuration_view.dart';
import 'package:carenest/app/features/pricing/repositories/pricing_repository.dart';
import 'package:carenest/app/features/pricing/models/pricing_analytics_models.dart';
import 'package:carenest/app/features/invoice/domain/models/ndis_item.dart';
import 'package:carenest/app/features/invoice/providers/ndis_providers.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

final organizationEmployeeRateSnapshotProvider =
    FutureProvider.autoDispose.family<List<Map<String, dynamic>>, String>(
  (ref, organizationId) async {
    if (organizationId.trim().isEmpty) return const [];
    final api = ref.read(app_providers.apiMethodProvider);
    final response = await api.getOrganizationEmployees(organizationId);
    final people = (response['employees'] as List<dynamic>? ?? const [])
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
    return people;
  },
);

final pricingAnalyticsSnapshotProvider =
    FutureProvider.autoDispose.family<PricingAnalytics?, String>(
  (ref, organizationId) async {
    if (organizationId.trim().isEmpty) return null;
    try {
      final repo = ref.read(pricingRepositoryProvider);
      return await repo.fetchPricingAnalytics(organizationId: organizationId);
    } catch (_) {
      return null;
    }
  },
);

class _PricingModuleInsight {
  final String badge;
  final String statusLabel;
  final Color statusColor;
  final String primaryMetricValue;
  final String primaryMetricLabel;
  final String secondaryMetricValue;
  final String secondaryMetricLabel;
  final double progress;
  final String progressLabel;
  final String keyInsight;

  const _PricingModuleInsight({
    required this.badge,
    required this.statusLabel,
    required this.statusColor,
    required this.primaryMetricValue,
    required this.primaryMetricLabel,
    required this.secondaryMetricValue,
    required this.secondaryMetricLabel,
    required this.progress,
    required this.progressLabel,
    required this.keyInsight,
  });
}

class PricingManagementView extends ConsumerStatefulWidget {
  final String adminEmail;
  final String? organizationId;
  final String? organizationName;

  const PricingManagementView({
    super.key,
    required this.adminEmail,
    this.organizationId,
    this.organizationName,
  });

  @override
  ConsumerState<PricingManagementView> createState() =>
      _PricingManagementViewState();
}

class _PricingManagementViewState extends ConsumerState<PricingManagementView>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  List<Map<String, dynamic>> _getPricingModules(BuildContext context) => [
        {
          'title': AppLocalizations.of(context)!.dashboardOverviewTitle,
          'subtitle': AppLocalizations.of(context)!.dashboardOverviewSubtitle,
          'icon': Icons.dashboard_outlined,
          'color': BauhausDesign.secondary,
          'route': 'dashboard',
        },
        {
          'title': AppLocalizations.of(context)!.ndisPricingTitle,
          'subtitle': AppLocalizations.of(context)!.ndisPricingSubtitle,
          'icon': Icons.medical_services_outlined,
          'color': BauhausDesign.success,
          'route': 'ndis',
        },
        {
          'title': AppLocalizations.of(context)!.serviceRatesTitle,
          'subtitle': AppLocalizations.of(context)!.serviceRatesSubtitle,
          'icon': Icons.rate_review_outlined,
          'color': BauhausDesign.warning,
          'route': 'service_rates',
        },
        {
          'title': AppLocalizations.of(context)!.bulkOperationsTitle,
          'subtitle': AppLocalizations.of(context)!.bulkOperationsSubtitle,
          'icon': Icons.batch_prediction_outlined,
          'color': BauhausDesign.info,
          'route': 'bulk_operations',
        },
        {
          'title': AppLocalizations.of(context)!.priceHistoryTitle,
          'subtitle': AppLocalizations.of(context)!.priceHistorySubtitle,
          'icon': Icons.history_outlined,
          'color': BauhausDesign.primary,
          'route': 'price_history',
        },
        {
          'title': AppLocalizations.of(context)!.quickActionsTitle,
          'subtitle': AppLocalizations.of(context)!.quickActionsSubtitle,
          'icon': Icons.flash_on_outlined,
          'color': BauhausDesign.primary,
          'route': 'quick_actions',
        },
      ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool _isFallbackPricingSource(String? source) {
    if (source == null) return false;
    final normalized = source.trim().toLowerCase();
    return normalized == 'base-rate' ||
        normalized == 'fallback-base-rate' ||
        normalized == 'fallback' ||
        normalized == 'ndis_default';
  }

  double _toDouble(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0;
    return 0;
  }

  DateTime? _extractDate(dynamic raw) {
    if (raw == null) return null;
    if (raw is DateTime) return raw;
    if (raw is String) return DateTime.tryParse(raw);
    if (raw is Map && raw['\$date'] != null) {
      return DateTime.tryParse(raw['\$date'].toString());
    }
    return null;
  }

  String _formatCurrencyCompact(double amount) {
    if (amount >= 1000000) return '\$${(amount / 1000000).toStringAsFixed(1)}M';
    if (amount >= 1000) return '\$${(amount / 1000).toStringAsFixed(1)}K';
    return '\$${amount.toStringAsFixed(0)}';
  }

  String _formatRate(double value) => '\$${value.toStringAsFixed(2)}';

  String _formatPercent(double value) => '${value.toStringAsFixed(0)}%';

  Map<String, _PricingModuleInsight> _buildModuleInsights({
    required AppLocalizations l10n,
    required List<dynamic> ndisItems,
    required Map<String, dynamic> pricingLookup,
    required List<Map<String, dynamic>> employees,
    required PricingAnalytics? analytics,
  }) {
    final totalItems = ndisItems.length;
    final customEntries = pricingLookup.entries.where((entry) {
      final payload = entry.value;
      if (payload is! Map) return false;
      final map = Map<String, dynamic>.from(payload);
      final price = _toDouble(map['price']);
      final source = map['source']?.toString();
      return price > 0 && !_isFallbackPricingSource(source);
    }).length;

    final quotableItems =
        ndisItems.whereType<NDISItem>().where((item) => item.isQuotable).length;

    final coverage = totalItems > 0 ? (customEntries / totalItems) : 0.0;

    final configuredRateValues = employees
        .map((employee) => _toDouble(employee['payRate']))
        .where((rate) => rate > 0)
        .toList();
    final configuredRates = configuredRateValues.length;
    final avgRate = configuredRateValues.isEmpty
        ? 0.0
        : configuredRateValues.reduce((a, b) => a + b) /
            configuredRateValues.length;
    final missingRates = (employees.length - configuredRates).clamp(0, 99999);

    final now = DateTime.now();
    int updatesLast7d = 0;
    DateTime? latestChange;
    for (final value in pricingLookup.values) {
      if (value is! Map) continue;
      final map = Map<String, dynamic>.from(value);
      final dt = _extractDate(map['updatedAt'] ?? map['createdAt']);
      if (dt == null) continue;
      final local = dt.toLocal();
      if (local.isAfter(now.subtract(const Duration(days: 7)))) {
        updatesLast7d++;
      }
      if (latestChange == null || local.isAfter(latestChange)) {
        latestChange = local;
      }
    }

    final analyticsMetrics = analytics?.metrics;
    final revenue = analyticsMetrics?.totalRevenue ?? 0;
    final compliance = analyticsMetrics?.complianceRate ?? (coverage * 100);
    final violations = analyticsMetrics?.nonCompliantItems ?? 0;

    final dashboardStatus = violations > 0
        ? l10n.moduleStatusNeedsAction
        : l10n.moduleStatusHealthy;
    final dashboardStatusColor =
        violations > 0 ? BauhausDesign.warning : BauhausDesign.success;

    final ndisStatus = coverage < 0.2
        ? l10n.moduleStatusNeedsAction
        : l10n.moduleStatusHealthy;
    final ndisStatusColor =
        coverage < 0.2 ? BauhausDesign.warning : BauhausDesign.success;

    final ratesStatus = missingRates > 0
        ? l10n.moduleStatusNeedsAction
        : l10n.moduleStatusHealthy;
    final ratesStatusColor =
        missingRates > 0 ? BauhausDesign.warning : BauhausDesign.success;

    final bulkCandidates = (totalItems - customEntries).clamp(0, 999999);
    final recommendedBatchSize =
        bulkCandidates == 0 ? 0 : ((bulkCandidates / 20).ceil()).clamp(25, 500);

    final historyFreshness = latestChange == null
        ? l10n.moduleNoTrackedChanges
        : l10n.moduleLastUpdatedDays(
            now.difference(latestChange).inDays.toString(),
          );

    final actionableCount = missingRates + (violations > 0 ? violations : 0);

    return {
      'dashboard': _PricingModuleInsight(
        badge: l10n.moduleBadgeOverview,
        statusLabel: dashboardStatus,
        statusColor: dashboardStatusColor,
        primaryMetricValue: revenue > 0
            ? _formatCurrencyCompact(revenue)
            : _formatPercent(coverage * 100),
        primaryMetricLabel:
            revenue > 0 ? l10n.moduleMetricRevenue : l10n.moduleMetricCoverage,
        secondaryMetricValue: _formatPercent(compliance),
        secondaryMetricLabel: l10n.moduleMetricCompliance,
        progress: (compliance / 100).clamp(0, 1),
        progressLabel: l10n.moduleKeyInsightCoverage(
          customEntries.toString(),
          totalItems.toString(),
        ),
        keyInsight: violations > 0
            ? l10n.moduleKeyInsightViolations(violations.toString())
            : l10n.moduleKeyInsightHealthy,
      ),
      'ndis': _PricingModuleInsight(
        badge: l10n.moduleBadgeNdis,
        statusLabel: ndisStatus,
        statusColor: ndisStatusColor,
        primaryMetricValue: totalItems.toString(),
        primaryMetricLabel: l10n.moduleMetricCatalogItems,
        secondaryMetricValue: customEntries.toString(),
        secondaryMetricLabel: l10n.moduleMetricCustomPrices,
        progress: coverage.clamp(0, 1),
        progressLabel: l10n.moduleKeyInsightCoverage(
          customEntries.toString(),
          totalItems.toString(),
        ),
        keyInsight: l10n.moduleKeyInsightQuotable(quotableItems.toString()),
      ),
      'service_rates': _PricingModuleInsight(
        badge: l10n.moduleBadgeRates,
        statusLabel: ratesStatus,
        statusColor: ratesStatusColor,
        primaryMetricValue: configuredRates.toString(),
        primaryMetricLabel: l10n.moduleMetricConfiguredRates,
        secondaryMetricValue: avgRate > 0 ? _formatRate(avgRate) : l10n.naLabel,
        secondaryMetricLabel: l10n.moduleMetricAvgBaseRate,
        progress: employees.isEmpty ? 0 : (configuredRates / employees.length),
        progressLabel: l10n.moduleRatesCoverage(
          configuredRates.toString(),
          employees.length.toString(),
        ),
        keyInsight: missingRates > 0
            ? l10n.moduleKeyInsightMissingRates(missingRates.toString())
            : l10n.moduleKeyInsightAllRatesConfigured,
      ),
      'bulk_operations': _PricingModuleInsight(
        badge: l10n.moduleBadgeBulk,
        statusLabel:
            bulkCandidates > 0 ? l10n.moduleStatusReady : l10n.moduleStatusIdle,
        statusColor:
            bulkCandidates > 0 ? BauhausDesign.info : BauhausDesign.textMuted,
        primaryMetricValue: bulkCandidates.toString(),
        primaryMetricLabel: l10n.moduleMetricBulkCandidates,
        secondaryMetricValue: recommendedBatchSize.toString(),
        secondaryMetricLabel: l10n.moduleMetricRecommendedBatch,
        progress: totalItems == 0 ? 0 : (bulkCandidates / totalItems),
        progressLabel: l10n.moduleKeyInsightBacklog(
          bulkCandidates.toString(),
          totalItems.toString(),
        ),
        keyInsight: l10n.moduleKeyInsightBatchSuggestion(
          recommendedBatchSize.toString(),
        ),
      ),
      'price_history': _PricingModuleInsight(
        badge: l10n.moduleBadgeHistory,
        statusLabel: updatesLast7d > 0
            ? l10n.moduleStatusRecentlyUpdated
            : l10n.moduleStatusIdle,
        statusColor:
            updatesLast7d > 0 ? BauhausDesign.success : BauhausDesign.textMuted,
        primaryMetricValue: updatesLast7d.toString(),
        primaryMetricLabel: l10n.moduleMetricWeeklyChanges,
        secondaryMetricValue: customEntries.toString(),
        secondaryMetricLabel: l10n.moduleMetricTrackedEntries,
        progress: customEntries == 0
            ? 0
            : (updatesLast7d / customEntries).clamp(0, 1),
        progressLabel: historyFreshness,
        keyInsight: l10n.moduleKeyInsightHistory(customEntries.toString()),
      ),
      'quick_actions': _PricingModuleInsight(
        badge: l10n.moduleBadgeActions,
        statusLabel: actionableCount > 0
            ? l10n.moduleStatusNeedsAction
            : l10n.moduleStatusReady,
        statusColor:
            actionableCount > 0 ? BauhausDesign.warning : BauhausDesign.success,
        primaryMetricValue: actionableCount.toString(),
        primaryMetricLabel: l10n.moduleMetricActionableItems,
        secondaryMetricValue: _getPricingModules(context).length.toString(),
        secondaryMetricLabel: l10n.moduleMetricAvailableActions,
        progress: actionableCount == 0 ? 1 : 0.45,
        progressLabel: l10n.moduleKeyInsightActionCenter,
        keyInsight: actionableCount > 0
            ? l10n.moduleKeyInsightPendingActions(actionableCount.toString())
            : l10n.moduleKeyInsightClearQueue,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final organizationId = widget.organizationId ?? '';
    final hasOrgContext = organizationId.isNotEmpty;
    final ndisItemsAsync = ref.watch(ndisItemsProvider);
    final pricingLookupAsync = hasOrgContext
        ? ref.watch(ndisPricingProvider(organizationId))
        : const AsyncData<Map<String, dynamic>>({});
    final employeesAsync = hasOrgContext
        ? ref.watch(organizationEmployeeRateSnapshotProvider(organizationId))
        : const AsyncData<List<Map<String, dynamic>>>([]);
    final analyticsAsync = hasOrgContext
        ? ref.watch(pricingAnalyticsSnapshotProvider(organizationId))
        : const AsyncData<PricingAnalytics?>(null);

    final ndisItems = ndisItemsAsync.value ?? const <NDISItem>[];
    final pricingLookup =
        pricingLookupAsync.value ?? const <String, dynamic>{};
    final employees =
        employeesAsync.value ?? const <Map<String, dynamic>>[];
    final analytics = analyticsAsync.value;
    final moduleInsights = _buildModuleInsights(
      l10n: AppLocalizations.of(context)!,
      ndisItems: ndisItems,
      pricingLookup: pricingLookup,
      employees: employees,
      analytics: analytics,
    );

    final isInsightsLoading = ndisItemsAsync.isLoading ||
        pricingLookupAsync.isLoading ||
        employeesAsync.isLoading ||
        analyticsAsync.isLoading;

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildBauhausHeader(),
            _buildHorizontalStats(
              moduleInsights: moduleInsights,
              isLoading: isInsightsLoading,
            ),
            _buildPricingModulesGrid(
              moduleInsights: moduleInsights,
              isLoading: isInsightsLoading,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBauhausHeader() {
    return Container(
      color: BauhausDesign.backgroundLight,
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isSmallScreen = constraints.maxWidth < 600;
            return Padding(
              padding: EdgeInsets.all(
                  isSmallScreen ? BauhausDesign.space4 : BauhausDesign.space6),
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          width: BauhausDesign.space10,
                          height: BauhausDesign.space10,
                          decoration: BoxDecoration(
                            color: BauhausDesign.surfaceWhite,
                            border: Border.all(
                              color: BauhausDesign.neutral,
                              width: BauhausDesign.borderThick,
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            size: BauhausDesign.iconMd,
                            color: BauhausDesign.neutral,
                          ),
                        ),
                      ),
                      const SizedBox(width: BauhausDesign.space4),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .pricingManagementTitle
                                  .toUpperCase(),
                              style: BauhausDesign.getTextTheme(context)
                                  .headlineMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 0.5,
                                    fontSize: isSmallScreen
                                        ? BauhausDesign.fontXxl + 2
                                        : BauhausDesign.fontXxl + 6,
                                    color: BauhausDesign.textDark,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (!isSmallScreen) ...[
                              const SizedBox(height: BauhausDesign.space2),
                              Text(
                                AppLocalizations.of(context)!
                                    .pricingManagementDesc,
                                style: BauhausDesign.getTextTheme(context)
                                    .labelLarge
                                    ?.copyWith(
                                      color: BauhausDesign.textMuted,
                                    ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ]
                          ],
                        ),
                      ),
                      if (!isSmallScreen) _buildStatusBadge(isCompact: true),
                      const SizedBox(width: BauhausDesign.space3),
                      InkWell(
                        onTap: _openPricingSettings,
                        child: Container(
                          width: BauhausDesign.space10,
                          height: BauhausDesign.space10,
                          decoration: BoxDecoration(
                            color: BauhausDesign.secondary,
                            border: Border.all(
                              color: BauhausDesign.neutral,
                              width: BauhausDesign.borderThick,
                            ),
                          ),
                          child: const Icon(
                            Icons.settings,
                            size: BauhausDesign.iconMd,
                            color: BauhausDesign.surfaceWhite,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (isSmallScreen) ...[
                    const SizedBox(height: BauhausDesign.space3),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context)!.manageAndOptimizeDesc,
                            style: BauhausDesign.getTextTheme(context)
                                .bodyMedium
                                ?.copyWith(
                                  color: BauhausDesign.textMuted,
                                ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: BauhausDesign.space3),
                        _buildStatusBadge(),
                      ],
                    ),
                  ],
                  const SizedBox(height: BauhausDesign.space3),
                  Container(
                    width: double.infinity,
                    height: BauhausDesign.borderThin,
                    color: BauhausDesign.neutral,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatusBadge({bool isCompact = false}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? BauhausDesign.space2 : BauhausDesign.space3,
        vertical: BauhausDesign.space1,
      ),
      decoration: BoxDecoration(
        color: BauhausDesign.primary,
        border: Border.all(
          color: BauhausDesign.neutral,
          width: BauhausDesign.borderThick,
        ),
      ),
      child: Text(
        AppLocalizations.of(context)!.systemActive.toUpperCase(),
        style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
              color: BauhausDesign.surfaceWhite,
              letterSpacing: 0.6,
              fontWeight: FontWeight.w800,
            ),
      ),
    );
  }

  void _openPricingSettings() {
    final orgId = widget.organizationId;
    final admin = widget.adminEmail;
    final orgName = widget.organizationName;

    if (orgId == null || orgId.isEmpty || orgName == null || orgName.isEmpty) {
      _showSnackBar(AppLocalizations.of(context)!.orgContextMissingError,
          isError: true);
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PricingConfigurationView(
          adminEmail: admin,
          organizationId: orgId,
          organizationName: orgName,
        ),
      ),
    );
  }

  Widget _buildHorizontalStats({
    required Map<String, _PricingModuleInsight> moduleInsights,
    required bool isLoading,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final ndis = moduleInsights['ndis'];
    final rates = moduleInsights['service_rates'];
    final bulk = moduleInsights['bulk_operations'];
    final history = moduleInsights['price_history'];

    final statData = [
      {
        'title': l10n.totalServicesLabel,
        'value': ndis?.primaryMetricValue ?? '--',
        'subtitle': ndis?.primaryMetricLabel ?? l10n.moduleMetricCatalogItems,
        'icon': Icons.medical_services_outlined,
        'color': BauhausDesign.secondary,
      },
      {
        'title': l10n.activeRatesLabel,
        'value': rates?.primaryMetricValue ?? '--',
        'subtitle':
            rates?.primaryMetricLabel ?? l10n.moduleMetricConfiguredRates,
        'icon': Icons.rate_review_outlined,
        'color': BauhausDesign.success,
      },
      {
        'title': l10n.pendingUpdatesLabel,
        'value': bulk?.primaryMetricValue ?? '--',
        'subtitle': bulk?.primaryMetricLabel ?? l10n.moduleMetricBulkCandidates,
        'icon': Icons.batch_prediction_outlined,
        'color': BauhausDesign.warning,
      },
      {
        'title': l10n.priceHistoryTitle,
        'value': history?.primaryMetricValue ?? '--',
        'subtitle':
            history?.primaryMetricLabel ?? l10n.moduleMetricWeeklyChanges,
        'icon': Icons.history_outlined,
        'color': BauhausDesign.info,
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isWideScreen = screenWidth > 600;

        if (isWideScreen) {
          return Container(
            height: 155,
            margin: const EdgeInsets.symmetric(vertical: BauhausDesign.space4),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding:
                  const EdgeInsets.symmetric(horizontal: BauhausDesign.space4),
              child: Row(
                children: statData.map((stat) {
                  return Padding(
                    padding: const EdgeInsets.only(right: BauhausDesign.space3),
                    child: SizedBox(
                      width: 180,
                      child: _buildStatCard(
                        title: stat['title']! as String,
                        value: isLoading ? '--' : stat['value']! as String,
                        subtitle: stat['subtitle']! as String,
                        icon: stat['icon']! as IconData,
                        color: stat['color']! as Color,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        } else {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: BauhausDesign.space4),
            padding:
                const EdgeInsets.symmetric(horizontal: BauhausDesign.space4),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        title: statData[0]['title']! as String,
                        value:
                            isLoading ? '--' : statData[0]['value']! as String,
                        subtitle: statData[0]['subtitle']! as String,
                        icon: statData[0]['icon']! as IconData,
                        color: statData[0]['color']! as Color,
                      ),
                    ),
                    const SizedBox(width: BauhausDesign.space3),
                    Expanded(
                      child: _buildStatCard(
                        title: statData[1]['title']! as String,
                        value:
                            isLoading ? '--' : statData[1]['value']! as String,
                        subtitle: statData[1]['subtitle']! as String,
                        icon: statData[1]['icon']! as IconData,
                        color: statData[1]['color']! as Color,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: BauhausDesign.space3),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        title: statData[2]['title']! as String,
                        value:
                            isLoading ? '--' : statData[2]['value']! as String,
                        subtitle: statData[2]['subtitle']! as String,
                        icon: statData[2]['icon']! as IconData,
                        color: statData[2]['color']! as Color,
                      ),
                    ),
                    const SizedBox(width: BauhausDesign.space3),
                    Expanded(
                      child: _buildStatCard(
                        title: statData[3]['title']! as String,
                        value:
                            isLoading ? '--' : statData[3]['value']! as String,
                        subtitle: statData[3]['subtitle']! as String,
                        icon: statData[3]['icon']! as IconData,
                        color: statData[3]['color']! as Color,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(
          color: BauhausDesign.neutral,
          width: BauhausDesign.borderThick,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            color: BauhausDesign.neutral,
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space2,
              vertical: BauhausDesign.space1,
            ),
            child: Text(
              title.toUpperCase(),
              style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                    color: BauhausDesign.surfaceWhite,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w800,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: BauhausDesign.space8,
                height: BauhausDesign.space8,
                decoration: BoxDecoration(
                  color: color,
                  border: Border.all(
                    color: BauhausDesign.neutral,
                    width: BauhausDesign.borderThick,
                  ),
                ),
                child: Icon(icon,
                    color: BauhausDesign.surfaceWhite,
                    size: BauhausDesign.iconMd),
              ),
              const SizedBox(width: BauhausDesign.space3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: BauhausDesign.getTextTheme(context)
                          .headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: BauhausDesign.textDark,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: BauhausDesign.space1),
                    Text(
                      subtitle,
                      style: BauhausDesign.getTextTheme(context)
                          .labelSmall
                          ?.copyWith(
                            color: BauhausDesign.textMuted,
                            fontWeight: FontWeight.w700,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPricingModulesGrid({
    required Map<String, _PricingModuleInsight> moduleInsights,
    required bool isLoading,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final modules = _getPricingModules(context);

    return Container(
      decoration: const BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border(
          top: BorderSide(
            color: BauhausDesign.neutral,
            width: BauhausDesign.borderThin,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: BauhausDesign.space10,
                      height: BauhausDesign.space10,
                      decoration: BoxDecoration(
                        color: BauhausDesign.primary,
                        border: Border.all(
                          color: BauhausDesign.neutral,
                          width: BauhausDesign.borderThick,
                        ),
                      ),
                      child: const Icon(
                        Icons.apps,
                        color: BauhausDesign.surfaceWhite,
                        size: BauhausDesign.fontXl,
                      ),
                    ),
                    const SizedBox(width: BauhausDesign.space4),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.pricingModulesTitle,
                            style: BauhausDesign.getTextTheme(context)
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.4,
                                  color: BauhausDesign.textDark,
                                ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.chooseModuleDesc,
                            style: BauhausDesign.getTextTheme(context)
                                .labelLarge
                                ?.copyWith(
                                  color: BauhausDesign.textMuted,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              final isCompact = constraints.maxWidth < 700;
              final isVeryWideDesktop = constraints.maxWidth >= 1500;
              final crossAxisCount = isVeryWideDesktop ? 2 : 1;
              final cardHeight = crossAxisCount == 2
                  ? BauhausDesign.space16 * 4.8
                  : isCompact
                      ? BauhausDesign.space16 * 5.4
                      : BauhausDesign.space16 * 4.9;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  BauhausDesign.space6,
                  0,
                  BauhausDesign.space6,
                  BauhausDesign.space6,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing:
                      crossAxisCount == 1 ? 0 : BauhausDesign.space4,
                  mainAxisSpacing: BauhausDesign.space4,
                  mainAxisExtent: cardHeight,
                ),
                itemCount: modules.length,
                itemBuilder: (context, index) {
                  final module = modules[index];
                  return _buildPricingModuleCard(
                    module,
                    moduleInsights[module['route']] ??
                        _PricingModuleInsight(
                          badge: l10n.moduleBadgeOverview,
                          statusLabel: l10n.moduleStatusIdle,
                          statusColor: BauhausDesign.textMuted,
                          primaryMetricValue: '--',
                          primaryMetricLabel: l10n.moduleMetricCoverage,
                          secondaryMetricValue: '--',
                          secondaryMetricLabel:
                              l10n.moduleMetricConfiguredRates,
                          progress: 0,
                          progressLabel: l10n.moduleNoDataYet,
                          keyInsight: l10n.moduleNoDataYet,
                        ),
                    index,
                    isLoading: isLoading,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPricingModuleCard(
    Map<String, dynamic> module,
    _PricingModuleInsight insight,
    int index, {
    required bool isLoading,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final accentColor = (module['color'] as Color?) ?? BauhausDesign.secondary;
    final primaryMetricValue = isLoading ? '--' : insight.primaryMetricValue;
    final secondaryMetricValue =
        isLoading ? '--' : insight.secondaryMetricValue;
    final progress = isLoading ? 0.0 : insight.progress.clamp(0.0, 1.0);
    final progressLabel =
        isLoading ? l10n.moduleNoDataYet : insight.progressLabel;
    final keyInsight = isLoading ? l10n.moduleNoDataYet : insight.keyInsight;

    return GestureDetector(
      onTap: () => _navigateToModule(module['route']),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 600 + (index * 100)),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: BauhausDesign.surfaceWhite,
          border: Border.all(
            color: BauhausDesign.neutral,
            width: BauhausDesign.borderThick,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(BauhausDesign.space3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      color: BauhausDesign.neutral,
                      padding: const EdgeInsets.symmetric(
                        horizontal: BauhausDesign.space2,
                        vertical: BauhausDesign.space1,
                      ),
                      child: Text(
                        insight.badge.toUpperCase(),
                        style: BauhausDesign.getTextTheme(context)
                            .labelSmall
                            ?.copyWith(
                              color: BauhausDesign.surfaceWhite,
                              letterSpacing: 0.4,
                              fontWeight: FontWeight.w800,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const SizedBox(width: BauhausDesign.space2),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: BauhausDesign.space2,
                      vertical: BauhausDesign.space1,
                    ),
                    decoration: BoxDecoration(
                      color: insight.statusColor,
                      border: Border.all(
                        color: BauhausDesign.neutral,
                        width: BauhausDesign.borderThin,
                      ),
                    ),
                    child: Text(
                      insight.statusLabel.toUpperCase(),
                      style: BauhausDesign.getTextTheme(context)
                          .labelSmall
                          ?.copyWith(
                            color: BauhausDesign.surfaceWhite,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: BauhausDesign.space3),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: BauhausDesign.space8 + BauhausDesign.space1,
                    height: BauhausDesign.space8 + BauhausDesign.space1,
                    decoration: BoxDecoration(
                      color: accentColor,
                      border: Border.all(
                        color: BauhausDesign.neutral,
                        width: BauhausDesign.borderThick,
                      ),
                    ),
                    child: Icon(
                      module['icon'] as IconData,
                      color: BauhausDesign.surfaceWhite,
                      size: BauhausDesign.iconMd,
                    ),
                  ),
                  const SizedBox(width: BauhausDesign.space3),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          module['title'].toString().toUpperCase(),
                          style: BauhausDesign.getTextTheme(context)
                              .labelLarge
                              ?.copyWith(
                                color: BauhausDesign.textDark,
                                fontWeight: FontWeight.w800,
                                height: 1.15,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: BauhausDesign.space1),
                        Text(
                          module['subtitle'].toString(),
                          style: BauhausDesign.getTextTheme(context)
                              .bodySmall
                              ?.copyWith(
                                color: BauhausDesign.textMuted,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: BauhausDesign.space3),
              Row(
                children: [
                  Expanded(
                    child: _buildInfographicMetricTile(
                      value: primaryMetricValue,
                      label: insight.primaryMetricLabel,
                    ),
                  ),
                  const SizedBox(width: BauhausDesign.space2),
                  Expanded(
                    child: _buildInfographicMetricTile(
                      value: secondaryMetricValue,
                      label: insight.secondaryMetricLabel,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: BauhausDesign.space2),
              Text(
                progressLabel,
                style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                      color: BauhausDesign.textMuted,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: BauhausDesign.space1),
              Container(
                width: double.infinity,
                height: BauhausDesign.space2,
                decoration: BoxDecoration(
                  color: BauhausDesign.surfaceOffWhite,
                  border: Border.all(
                    color: BauhausDesign.neutral,
                    width: BauhausDesign.borderThin,
                  ),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress,
                  child: Container(color: accentColor),
                ),
              ),
              const SizedBox(height: BauhausDesign.space2),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(BauhausDesign.space2),
                  decoration: BoxDecoration(
                    color: BauhausDesign.backgroundLight,
                    border: Border.all(
                      color: BauhausDesign.neutral,
                      width: BauhausDesign.borderThin,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.insights,
                        size: BauhausDesign.fontMd,
                        color: BauhausDesign.neutral,
                      ),
                      const SizedBox(width: BauhausDesign.space2),
                      Expanded(
                        child: Text(
                          keyInsight,
                          style: BauhausDesign.getTextTheme(context)
                              .labelSmall
                              ?.copyWith(
                                color: BauhausDesign.textDark,
                                height: 1.25,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: BauhausDesign.space2),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: BauhausDesign.space2,
                        vertical: BauhausDesign.space1,
                      ),
                      decoration: BoxDecoration(
                        color: BauhausDesign.neutral,
                        border: Border.all(
                          color: BauhausDesign.neutral,
                          width: BauhausDesign.borderThin,
                        ),
                      ),
                      child: Text(
                        l10n.open.toUpperCase(),
                        style: BauhausDesign.getTextTheme(context)
                            .labelSmall
                            ?.copyWith(
                              color: BauhausDesign.surfaceWhite,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(width: BauhausDesign.space2),
                  Container(
                    width: BauhausDesign.space8,
                    height: BauhausDesign.space8,
                    decoration: BoxDecoration(
                      color: BauhausDesign.primary,
                      border: Border.all(
                        color: BauhausDesign.neutral,
                        width: BauhausDesign.borderThick,
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      size: BauhausDesign.fontMd,
                      color: BauhausDesign.surfaceWhite,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfographicMetricTile({
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space2),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(
          color: BauhausDesign.neutral,
          width: BauhausDesign.borderThin,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: BauhausDesign.getTextTheme(context).headlineMedium?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w900,
                  height: 1.0,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: BauhausDesign.space1),
          Text(
            label,
            style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                  color: BauhausDesign.textMuted,
                  fontWeight: FontWeight.w700,
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  void _navigateToModule(String route) {
    Widget destination;

    switch (route) {
      case 'dashboard':
        destination = PricingDashboardView(
          adminEmail: widget.adminEmail,
          organizationId: widget.organizationId ?? '',
          organizationName: widget.organizationName ?? '',
        );
        break;
      case 'ndis':
        destination = NdisPricingManagementView(
          adminEmail: widget.adminEmail,
          organizationId: widget.organizationId ?? '',
          organizationName: widget.organizationName ?? '',
        );
        break;
      case 'service_rates':
        destination = ServiceRateManagementView(
          adminEmail: widget.adminEmail,
          organizationId: widget.organizationId ?? '',
          organizationName: widget.organizationName ?? '',
        );
        break;
      case 'bulk_operations':
        destination = BulkOperationsView(
          adminEmail: widget.adminEmail,
          organizationId: widget.organizationId ?? '',
          organizationName: widget.organizationName ?? '',
        );
        break;
      case 'price_history':
        destination = PriceHistoryView(
          adminEmail: widget.adminEmail,
          organizationId: widget.organizationId ?? '',
          organizationName: widget.organizationName ?? '',
        );
        break;
      case 'quick_actions':
        _showQuickActionsBottomSheet();
        return;
      default:
        _showSnackBar(AppLocalizations.of(context)!.errorOccurred,
            isError: true);
        return;
    }

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => destination,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;

          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  void _showQuickActionsBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: BauhausDesign.surfaceWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(
          color: BauhausDesign.neutral,
          width: BauhausDesign.borderThick,
        ),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: const BoxDecoration(
          color: BauhausDesign.surfaceWhite,
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: BauhausDesign.space3),
              width: BauhausDesign.space10,
              height: BauhausDesign.space1,
              color: BauhausDesign.neutral,
            ),
            Container(
              width: double.infinity,
              color: BauhausDesign.neutral,
              padding: const EdgeInsets.all(BauhausDesign.space3),
              margin: const EdgeInsets.fromLTRB(
                BauhausDesign.space4,
                BauhausDesign.space4,
                BauhausDesign.space4,
                BauhausDesign.space3,
              ),
              child: Text(
                AppLocalizations.of(context)!.quickActionsTitle.toUpperCase(),
                style:
                    BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: BauhausDesign.surfaceWhite,
                          letterSpacing: 0.5,
                        ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                    horizontal: BauhausDesign.space6),
                children: [
                  _buildQuickActionTile(
                    AppLocalizations.of(context)!.bulkPriceUpdateTitle,
                    AppLocalizations.of(context)!.bulkPriceUpdateSubtitle,
                    Icons.update,
                    BauhausDesign.secondary,
                    () => _navigateToModule('bulk_operations'),
                  ),
                  _buildQuickActionTile(
                    AppLocalizations.of(context)!.exportPricingDataTitle,
                    AppLocalizations.of(context)!.exportPricingDataSubtitle,
                    Icons.download,
                    BauhausDesign.success,
                    () => _navigateToModule('bulk_operations'),
                  ),
                  _buildQuickActionTile(
                    AppLocalizations.of(context)!.priceAnalyticsTitle,
                    AppLocalizations.of(context)!.priceAnalyticsSubtitle,
                    Icons.analytics_outlined,
                    BauhausDesign.info,
                    () => _navigateToModule('dashboard'),
                  ),
                  _buildQuickActionTile(
                    AppLocalizations.of(context)!.ndisComplianceCheckTitle,
                    AppLocalizations.of(context)!.ndisComplianceCheckSubtitle,
                    Icons.verified_outlined,
                    BauhausDesign.warning,
                    () => _navigateToModule('ndis'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionTile(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: BauhausDesign.space3),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(BauhausDesign.space3),
          decoration: BoxDecoration(
            color: BauhausDesign.backgroundLight,
            border: Border.all(
              color: BauhausDesign.neutral,
              width: BauhausDesign.borderThick,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: BauhausDesign.space8 + BauhausDesign.space1,
                height: BauhausDesign.space8 + BauhausDesign.space1,
                decoration: BoxDecoration(
                  color: color,
                  border: Border.all(
                    color: BauhausDesign.neutral,
                    width: BauhausDesign.borderThick,
                  ),
                ),
                child: Icon(
                  icon,
                  color: BauhausDesign.surfaceWhite,
                  size: BauhausDesign.iconMd,
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title.toUpperCase(),
                      style: BauhausDesign.getTextTheme(context)
                          .labelLarge
                          ?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(height: BauhausDesign.space1),
                    Text(
                      subtitle,
                      style: BauhausDesign.getTextTheme(context)
                          .bodySmall
                          ?.copyWith(
                            color: BauhausDesign.textMuted,
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                width: BauhausDesign.space6 + BauhausDesign.space1,
                height: BauhausDesign.space6 + BauhausDesign.space1,
                decoration: BoxDecoration(
                  color: BauhausDesign.primary,
                  border: Border.all(
                    color: BauhausDesign.neutral,
                    width: BauhausDesign.borderThick,
                  ),
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: BauhausDesign.surfaceWhite,
                  size: BauhausDesign.fontMd,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: BauhausDesign.surfaceWhite),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: isError ? BauhausDesign.error : BauhausDesign.textDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        ),
        margin: const EdgeInsets.all(BauhausDesign.space4),
      ),
    );
  }
}
