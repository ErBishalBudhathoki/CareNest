import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/bauhaus_dashboard_components.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class BauhausPricingDashboardView extends StatefulWidget {
  const BauhausPricingDashboardView({super.key});

  @override
  State<BauhausPricingDashboardView> createState() =>
      _BauhausPricingDashboardViewState();
}

class _BauhausPricingDashboardViewState
    extends State<BauhausPricingDashboardView> with TickerProviderStateMixin {
  bool _isLoading = false;
  String _selectedPeriod = '';
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_selectedPeriod.isEmpty) {
      _selectedPeriod = AppLocalizations.of(context)!.thisMonth;
    }
  }

  final ScrollController _scrollController = ScrollController();
  late AnimationController _refreshController;

  // Mock data - replace with actual data from your backend
  List<MetricData> _getMetrics(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      MetricData(
        title: l10n.totalRevenue,
        value: '\$125,000',
        subtitle: l10n.thisMonth,
        icon: Icons.attach_money,
        iconColor: BauhausDesign.success,
        trend: 12.5,
        trendLabel: l10n.vsLastMonth,
      ),
      MetricData(
        title: l10n.activeItems,
        value: '245',
        subtitle: l10n.ndisItems,
        icon: Icons.inventory_2_outlined,
        iconColor: BauhausDesign.primary,
        trend: 8.2,
        trendLabel: l10n.vsLastMonth,
      ),
      MetricData(
        title: l10n.averageRate,
        value: '\$85.50',
        subtitle: l10n.perHour,
        icon: Icons.trending_up,
        iconColor: BauhausDesign.info,
        trend: -2.1,
        trendLabel: l10n.vsLastMonth,
      ),
      MetricData(
        title: l10n.validationIssues,
        value: '7',
        subtitle: l10n.requiresAttention,
        icon: Icons.warning_outlined,
        iconColor: BauhausDesign.warning,
        trend: -15.3,
        trendLabel: l10n.vsLastMonth,
      ),
    ];
  }

  List<QuickActionData> _getQuickActions(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      QuickActionData(
        title: l10n.addNewItem,
        subtitle: l10n.createPricingItem,
        icon: Icons.add_circle_outline,
        color: BauhausDesign.primary,
      ),
      QuickActionData(
        title: l10n.bulkImport,
        subtitle: l10n.importFromCsv,
        icon: Icons.upload_file,
        color: BauhausDesign.secondary,
      ),
      QuickActionData(
        title: l10n.generateReport,
        subtitle: l10n.exportAnalytics,
        icon: Icons.analytics_outlined,
        color: BauhausDesign.info,
      ),
      QuickActionData(
        title: l10n
            .configurePricing, // Changed from Settings to match key if needed or use Settings key
        subtitle: l10n.configurePricing,
        icon: Icons.settings_outlined,
        color: BauhausDesign.textDark,
      ),
    ];
  }

  List<ActivityData> _getRecentActivities(BuildContext context) {
    // These are mock data but headers localize
    return [
      ActivityData(
        title: AppLocalizations.of(context)!.newPricingItemAdded,
        description: 'Support Coordination - Level 2 has been created',
        timestamp: '2 minutes ago',
        icon: Icons.add_circle,
        color: BauhausDesign.success,
      ),
      ActivityData(
        title: AppLocalizations.of(context)!.rateUpdatedActivity,
        description: 'Personal Care rate changed from \$65.50 to \$68.00',
        timestamp: '15 minutes ago',
        icon: Icons.edit,
        color: BauhausDesign.primary,
      ),
      ActivityData(
        title: AppLocalizations.of(context)!.validationCompletedActivity,
        description: '3 items passed NDIS compliance check',
        timestamp: '1 hour ago',
        icon: Icons.check_circle,
        color: BauhausDesign.success,
      ),
      ActivityData(
        title: AppLocalizations.of(context)!.reportGeneratedActivity,
        description: 'Monthly pricing report exported successfully',
        timestamp: '2 hours ago',
        icon: Icons.file_download,
        color: BauhausDesign.info,
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _refreshController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _loadData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 1500));

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _onRefresh() async {
    _refreshController.forward();
    await _loadData();
    _refreshController.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: BauhausDesign.backgroundLight,
        body: RefreshIndicator(
          onRefresh: _onRefresh,
          color: BauhausDesign.primary,
          child: CustomScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              _buildModernHeader(),
              SliverPadding(
                padding: EdgeInsets.all(BauhausDesign.space4),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildWelcomeSection(),
                    const SizedBox(height: 16.0),
                    _buildMetricsGrid(),
                    const SizedBox(height: 16.0),
                    _buildQuickActionsSection(),
                    const SizedBox(height: 16.0),
                    _buildAnalyticsSection(),
                    const SizedBox(height: 16.0),
                    _buildRecentActivitySection(),
                    const SizedBox(height: 8.00 + 56.0),
                  ]),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildModernHeader() {
    return SliverToBoxAdapter(
      child: Container(
        color: BauhausDesign.surfaceWhite,
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isSmallScreen = constraints.maxWidth < 600;
              return Padding(
                padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
                child: Column(
                  children: [
                    Row(
                      children: [
                        BauhausActionButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Icons.arrow_back_ios_new,
                          variant: BauhausActionVariant.ghost,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!
                                    .pricingDashboardTitle,
                                style: BauhausDesign.getTextTheme(context)
                                    .headlineMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: isSmallScreen ? 24 : 28,
                                    ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (!isSmallScreen) ...[
                                const SizedBox(height: 8),
                                Text(
                                  AppLocalizations.of(context)!
                                      .ndisPricingManagementSubtitle,
                                  style: BauhausDesign.getTextTheme(context)
                                      .bodyLarge
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
                        if (!isSmallScreen)
                          BauhausChip(
                            label: AppLocalizations.of(context)!.systemActive,
                            icon: Icons.circle,
                            color: BauhausDesign.success,
                            variant: BauhausChipVariant.success,
                          ),
                      ],
                    ),
                    if (isSmallScreen) ...[
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              AppLocalizations.of(context)!
                                  .ndisPricingManagementSubtitle,
                              style: BauhausDesign.getTextTheme(context)
                                  .bodyMedium
                                  ?.copyWith(
                                    color: BauhausDesign.textMuted,
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 12),
                          BauhausChip(
                            label: AppLocalizations.of(context)!.systemActive,
                            icon: Icons.circle,
                            color: BauhausDesign.success,
                            variant: BauhausChipVariant.success,
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    final headers = AppLocalizations.of(context)!;
    return BauhausCard(
      padding: EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headers.welcomeBack,
            style: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.3, end: 0),
          const SizedBox(height: 4.0),
          Text(
            headers.pricingUpdateMessage,
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: BauhausDesign.textMuted,
                ),
          )
              .animate()
              .fadeIn(duration: 600.ms, delay: 200.ms)
              .slideY(begin: 0.3, end: 0),
          const SizedBox(height: 12.0),
          _buildPeriodSelector(),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
    final l10n = AppLocalizations.of(context)!;
    final periods = [
      l10n.todayLabel,
      l10n.thisWeekLabel,
      l10n.thisMonth,
      l10n.thisQuarterLabel
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: periods.map((period) {
          final isSelected = period == _selectedPeriod;
          return Padding(
            padding: const EdgeInsets.only(right: BauhausDesign.space2),
            child: BauhausChip(
              label: period,
              isSelected: isSelected,
              onTap: () {
                setState(() {
                  _selectedPeriod = period;
                });
              },
              variant: isSelected
                  ? BauhausChipVariant.primary
                  : BauhausChipVariant.outlined,
            ),
          );
        }).toList(),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 400.ms);
  }

  Widget _buildMetricsGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.keyMetrics,
          style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 12.0),
        LayoutBuilder(
          builder: (context, constraints) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _getCrossAxisCount(constraints.maxWidth),
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: constraints.maxWidth < 768.0 ? 1.4 : 1.6,
              ),
              itemCount: _getMetrics(context).length,
              itemBuilder: (context, index) {
                final metric = _getMetrics(context)[index];
                return BauhausMetricCard(
                  title: metric.title,
                  value: metric.value,
                  subtitle: metric.subtitle,
                  icon: metric.icon,
                  iconColor: metric.iconColor,
                  trend: metric.trend,
                  trendLabel: metric.trendLabel,
                  isLoading: _isLoading,
                  onTap: () {
                    // Handle metric tap
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildQuickActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.quickActions,
          style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _getCrossAxisCount(constraints.maxWidth),
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: constraints.maxWidth < 768.0 ? 1.3 : 1.5,
              ),
              itemCount: _getQuickActions(context).length,
              itemBuilder: (context, index) {
                final actions = _getQuickActions(context);
                final action = actions[index];
                return BauhausActionCard(
                  title: action.title,
                  subtitle: action.subtitle,
                  icon: action.icon,
                  color: action.color,
                  onTap: () {
                    // Handle action tap
                    _handleQuickAction(action.title);
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildAnalyticsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.analyticsOverview,
          style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 16.0),
        BauhausChartWidget(
          title: AppLocalizations.of(context)!.revenueTrend,
          data: _generateChartData(),
          type: ChartType.line,
          primaryColor: BauhausDesign.primary,
          height: 250,
        ),
      ],
    );
  }

  Widget _buildRecentActivitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.recentActivity,
              style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to full activity log
              },
              child: Text(
                AppLocalizations.of(context)!.viewAll,
                style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                      color: BauhausDesign.primary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        BauhausCard(
          child: Column(
            children:
                _getRecentActivities(context).asMap().entries.map((entry) {
              final index = entry.key;
              final activity = entry.value;
              final isLast = index == _getRecentActivities(context).length - 1;

              return BauhausActivityItem(
                title: activity.title,
                description: activity.description,
                timestamp: activity.timestamp,
                icon: activity.icon,
                color: activity.color,
                isLast: isLast,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  int _getCrossAxisCount(double width) {
    if (width >= 1280.0) return 4;
    if (width >= 1024.0) return 3;
    if (width >= 768.0) return 2;
    return 1;
  }

  List<ChartData> _generateChartData() {
    final l10n = AppLocalizations.of(context)!;
    return [
      ChartData(label: l10n.janInitial, value: 45000),
      ChartData(label: l10n.febInitial, value: 52000),
      ChartData(label: l10n.marInitial, value: 48000),
      ChartData(label: l10n.aprInitial, value: 61000),
      ChartData(label: l10n.mayInitial, value: 55000),
      ChartData(label: l10n.junInitial, value: 67000),
    ];
  }

  void _handleQuickAction(String actionTitle) {
    final l10n = AppLocalizations.of(context)!;
    if (actionTitle == l10n.addNewItem) {
      // Handle Add New Item
    } else if (actionTitle == l10n.generateReport) {
      // Navigate to reports screen
    } else if (actionTitle == l10n.configurePricing) {
      // Navigate to settings screen
    }
  }
}
