import 'package:flutter/material.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

import 'package:flutter_animate/flutter_animate.dart';

class PricingAnalyticsView extends StatefulWidget {
  final String adminEmail;
  final String organizationId;
  final String organizationName;

  const PricingAnalyticsView({
    super.key,
    required this.adminEmail,
    required this.organizationId,
    required this.organizationName,
  });

  @override
  _PricingAnalyticsViewState createState() => _PricingAnalyticsViewState();
}

class _PricingAnalyticsViewState extends State<PricingAnalyticsView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedMetric = 'Revenue';

  final List<Map<String, dynamic>> _topServices = [
    {
      'name': 'Support Worker Level 2',
      'code': 'SW_L2',
      'revenue': 45000.0,
      'hours': 520,
      'rate': 86.54,
      'change': 8.2,
    },
    {
      'name': 'Community Participation',
      'code': 'CP_001',
      'revenue': 32000.0,
      'hours': 380,
      'rate': 84.21,
      'change': -2.1,
    },
    {
      'name': 'Personal Care',
      'code': 'PC_001',
      'revenue': 28000.0,
      'hours': 340,
      'rate': 82.35,
      'change': 5.5,
    },
    {
      'name': 'Transport Services',
      'code': 'TS_001',
      'revenue': 20000.0,
      'hours': 250,
      'rate': 80.00,
      'change': 12.3,
    },
  ];

  final List<Map<String, dynamic>> _pricingTrends = [
    {
      'category': 'NDIS Core Supports',
      'averageRate': 85.20,
      'change': 3.2,
      'volume': 1250,
      'trend': 'Increasing',
    },
    {
      'category': 'Capacity Building',
      'averageRate': 92.50,
      'change': -1.5,
      'volume': 890,
      'trend': 'Stable',
    },
    {
      'category': 'Capital Supports',
      'averageRate': 78.90,
      'change': 8.7,
      'volume': 450,
      'trend': 'Increasing',
    },
    {
      'category': 'Transport',
      'averageRate': 65.30,
      'change': 2.1,
      'volume': 320,
      'trend': 'Stable',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildModernHeader(),
          _buildHorizontalStats(),
          Expanded(child: _buildTabContent()),
        ],
      ),
    );
  }

  Widget _buildModernHeader() {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.arrow_back_ios_new, size: 20),
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.pricingAnalyticsTitle,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppLocalizations.of(context)!.monitorPricingPerformance,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.secondary.withValues(alpha: 0.1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      AppLocalizations.of(context)!.liveData,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
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

  Widget _buildHorizontalStats() {
    return Container(
      height: 145,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            SizedBox(
              width: 160,
              child: _buildStatCard(
                title: AppLocalizations.of(context)!.totalRevenue,
                value: '0.125K',
                subtitle: AppLocalizations.of(context)!.thisMonthStat('+12.5%'),
                icon: Icons.attach_money,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 160,
              child: _buildStatCard(
                title: AppLocalizations.of(context)!.avgRate,
                value: '\$85.50',
                subtitle: AppLocalizations.of(context)!.vsLastMonthStat('-2.3'),
                icon: Icons.trending_down,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 160,
              child: _buildStatCard(
                title: AppLocalizations.of(context)!.utilization,
                value: '78.5%',
                subtitle: AppLocalizations.of(context)!.improvementStat('+5.2'),
                icon: Icons.trending_up,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 160,
              child: _buildStatCard(
                title: AppLocalizations.of(context)!.profitMargin,
                value: '23.8%',
                subtitle: AppLocalizations.of(context)!.growthStat('+1.8'),
                icon: Icons.pie_chart,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: color.withValues(alpha: 0.1)),
                child: Icon(icon, color: color, size: 20),
              ),
              const Spacer(),
              Icon(
                Icons.more_vert,
                color: Theme.of(context).colorScheme.outline,
                size: 16,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(
              context,
            ).colorScheme.outlineVariant.withValues(alpha: 0.3),
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildRevenueAnalysisTab(),
          _buildServicePerformanceTab(),
          _buildTrendsAndForecastsTab(),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.analyticsOverview,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildChartPlaceholder(
              AppLocalizations.of(context)!.revenueTrendTitle,
              AppLocalizations.of(context)!.revenueTrendChartDesc,
              Icons.show_chart,
              Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 16),
            _buildChartPlaceholder(
              AppLocalizations.of(context)!.serviceDistributionTitle,
              AppLocalizations.of(context)!.serviceDistributionChartDesc,
              Icons.pie_chart,
              Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 16),
            _buildQuickInsights(),
          ],
        ),
      ),
    );
  }

  Widget _buildRevenueAnalysisTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.revenueAnalysis,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                DropdownButton<String>(
                  value: _selectedMetric,
                  items:
                      [
                            AppLocalizations.of(context)!.metricRevenue,
                            AppLocalizations.of(context)!.metricHours,
                            AppLocalizations.of(context)!.metricRate,
                            AppLocalizations.of(context)!.metricMargin,
                          ]
                          .map(
                            (metric) => DropdownMenuItem(
                              value: metric,
                              child: Text(metric),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedMetric = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildChartPlaceholder(
              AppLocalizations.of(context)!.revenueByPeriodTitle,
              AppLocalizations.of(context)!.revenueByPeriodChartDesc,
              Icons.bar_chart,
              Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 16),
            _buildChartPlaceholder(
              AppLocalizations.of(context)!.revenueByCategoryTitle,
              AppLocalizations.of(context)!.revenueCategoryChartDesc,
              Icons.horizontal_split,
              Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 16),
            _buildRevenueBreakdown(),
          ],
        ),
      ),
    );
  }

  Widget _buildServicePerformanceTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.topPerformingServices,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _topServices.length,
              itemBuilder: (context, index) {
                final service = _topServices[index];
                return _buildServicePerformanceCard(service, index);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendsAndForecastsTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.pricingTrendsByCategory,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _pricingTrends.length,
              itemBuilder: (context, index) {
                final trend = _pricingTrends[index];
                return _buildTrendCard(trend, index);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServicePerformanceCard(Map<String, dynamic> service, int index) {
    final isPositive = service['change'] > 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Theme.of(
              context,
            ).colorScheme.outlineVariant.withValues(alpha: 0.3),
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppLocalizations.of(
                        context,
                      )!.codeLabelValue(service['code']),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color:
                      (isPositive
                              ? Theme.of(context).colorScheme.secondary
                              : Theme.of(context).colorScheme.error)
                          .withValues(alpha: 0.1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                      size: 12,
                      color: isPositive
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '${service['change'].abs()}%',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isPositive
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildServiceMetric(
                  AppLocalizations.of(context)!.metricRevenue,
                  '\$${service['revenue'].toStringAsFixed(0)}',
                  Icons.attach_money,
                  Theme.of(context).colorScheme.secondary,
                ),
              ),
              Expanded(
                child: _buildServiceMetric(
                  AppLocalizations.of(context)!.metricHours,
                  '${service['hours']}',
                  Icons.schedule,
                  Theme.of(context).colorScheme.secondary,
                ),
              ),
              Expanded(
                child: _buildServiceMetric(
                  AppLocalizations.of(context)!.metricRate,
                  '\$${service['rate'].toStringAsFixed(2)}',
                  Icons.trending_up,
                  Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate(delay: (index * 100).ms).fadeIn().slideX(begin: 0.3, end: 0);
  }

  Widget _buildServiceMetric(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildTrendCard(Map<String, dynamic> trend, int index) {
    final trendColor =
        trend['trend'] == AppLocalizations.of(context)!.trendIncreasing
        ? Theme.of(context).colorScheme.secondary
        : trend['trend'] == AppLocalizations.of(context)!.trendDecreasing
        ? Theme.of(context).colorScheme.error
        : Theme.of(context).colorScheme.primary;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Theme.of(
              context,
            ).colorScheme.outlineVariant.withValues(alpha: 0.3),
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  trend['category'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: trendColor.withValues(alpha: 0.1),
                ),
                child: Text(
                  trend['trend'],
                  style: TextStyle(
                    color: trendColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.averageRate,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '\$${trend['averageRate'].toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.changeLabel,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '${trend['change'] > 0 ? '+' : ''}${trend['change']}%',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: trend['change'] > 0
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.volume,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '${trend['volume']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate(delay: (index * 100).ms).fadeIn().slideY(begin: 0.3, end: 0);
  }

  Widget _buildChartPlaceholder(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48, color: color),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickInsights() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        border: Border.all(color: Theme.of(context).colorScheme.secondary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.of(context)!.quickInsights,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildInsightItem(
            AppLocalizations.of(context)!.revenueInsightLabel('12.5'),
          ),
          _buildInsightItem(
            AppLocalizations.of(
              context,
            )!.topServiceInsightLabel('Support Worker Level 2'),
          ),
          _buildInsightItem(
            AppLocalizations.of(context)!.avgRateInsightLabel('2.3'),
          ),
          _buildInsightItem(
            AppLocalizations.of(context)!.utilizationInsightLabel('5.2'),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSecondaryContainer,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildRevenueBreakdown() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        border: Border.all(color: Theme.of(context).colorScheme.secondary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.revenueBreakdown,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildBreakdownItem(
                  AppLocalizations.of(context)!.ndisCore,
                  '\$75,000',
                  '60%',
                ),
              ),
              Expanded(
                child: _buildBreakdownItem(
                  AppLocalizations.of(context)!.capacityBuilding,
                  '\$30,000',
                  '24%',
                ),
              ),
              Expanded(
                child: _buildBreakdownItem(
                  AppLocalizations.of(context)!.other,
                  '\$20,000',
                  '16%',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownItem(String label, String amount, String percentage) {
    return Column(
      children: [
        Text(
          amount,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
        ),
        Text(
          percentage,
          style: TextStyle(
            fontSize: 11,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
        ),
      ],
    );
  }
}
