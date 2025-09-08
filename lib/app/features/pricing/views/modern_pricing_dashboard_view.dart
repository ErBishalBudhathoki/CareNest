import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../shared/design_system/modern_saas_design_system.dart';
import '../widgets/modern_dashboard_components.dart';

class ModernPricingDashboardView extends StatefulWidget {
  const ModernPricingDashboardView({Key? key}) : super(key: key);

  @override
  State<ModernPricingDashboardView> createState() =>
      _ModernPricingDashboardViewState();
}

class _ModernPricingDashboardViewState extends State<ModernPricingDashboardView>
    with TickerProviderStateMixin {
  bool _isLoading = false;
  String _selectedPeriod = 'This Month';
  final ScrollController _scrollController = ScrollController();
  late AnimationController _refreshController;

  // Mock data - replace with actual data from your backend
  final List<MetricData> _metrics = [
    MetricData(
      title: 'Total Revenue',
      value: '\$125,000',
      subtitle: 'This Month',
      icon: Icons.attach_money,
      iconColor: ModernSaasDesign.success,
      trend: 12.5,
      trendLabel: 'vs last month',
    ),
    MetricData(
      title: 'Active Items',
      value: '245',
      subtitle: 'NDIS Items',
      icon: Icons.inventory_2_outlined,
      iconColor: ModernSaasDesign.primary,
      trend: 8.2,
      trendLabel: 'vs last month',
    ),
    MetricData(
      title: 'Average Rate',
      value: '\$85.50',
      subtitle: 'Per Hour',
      icon: Icons.trending_up,
      iconColor: ModernSaasDesign.accent,
      trend: -2.1,
      trendLabel: 'vs last month',
    ),
    MetricData(
      title: 'Validation Issues',
      value: '7',
      subtitle: 'Requires Attention',
      icon: Icons.warning_outlined,
      iconColor: ModernSaasDesign.warning,
      trend: -15.3,
      trendLabel: 'vs last month',
    ),
  ];

  final List<QuickActionData> _quickActions = [
    QuickActionData(
      title: 'Add New Item',
      subtitle: 'Create pricing item',
      icon: Icons.add_circle_outline,
      color: ModernSaasDesign.primary,
    ),
    QuickActionData(
      title: 'Bulk Import',
      subtitle: 'Import from CSV',
      icon: Icons.upload_file,
      color: ModernSaasDesign.secondary,
    ),
    QuickActionData(
      title: 'Generate Report',
      subtitle: 'Export analytics',
      icon: Icons.analytics_outlined,
      color: ModernSaasDesign.accent,
    ),
    QuickActionData(
      title: 'Settings',
      subtitle: 'Configure pricing',
      icon: Icons.settings_outlined,
      color: ModernSaasDesign.neutral600,
    ),
  ];

  final List<ActivityData> _recentActivities = [
    ActivityData(
      title: 'New pricing item added',
      description: 'Support Coordination - Level 2 has been created',
      timestamp: '2 minutes ago',
      icon: Icons.add_circle,
      color: ModernSaasDesign.success,
    ),
    ActivityData(
      title: 'Rate updated',
      description: 'Personal Care rate changed from \$65.50 to \$68.00',
      timestamp: '15 minutes ago',
      icon: Icons.edit,
      color: ModernSaasDesign.primary,
    ),
    ActivityData(
      title: 'Validation completed',
      description: '3 items passed NDIS compliance check',
      timestamp: '1 hour ago',
      icon: Icons.check_circle,
      color: ModernSaasDesign.success,
    ),
    ActivityData(
      title: 'Report generated',
      description: 'Monthly pricing report exported successfully',
      timestamp: '2 hours ago',
      icon: Icons.file_download,
      color: ModernSaasDesign.accent,
    ),
  ];

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
        backgroundColor: ModernSaasDesign.background,
        body: RefreshIndicator(
          onRefresh: _onRefresh,
          color: ModernSaasDesign.primary,
          child: ColoredBox(
            color: ModernSaasDesign.background,
            child: CustomScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                _buildModernHeader(),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                    ModernSaasDesign.space3,
                    ModernSaasDesign.space3,
                    ModernSaasDesign.space3,
                    ModernSaasDesign.space3,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      _buildWelcomeSection(),
                      const SizedBox(height: ModernSaasDesign.space4),
                      _buildMetricsGrid(),
                      //const SizedBox(height: ModernSaasDesign.space4),
                      _buildQuickActionsSection(),
                      const SizedBox(height: ModernSaasDesign.space4),
                      _buildAnalyticsSection(),
                      const SizedBox(height: ModernSaasDesign.space4),
                      _buildRecentActivitySection(),
                      const SizedBox(height: ModernSaasDesign.space20),
                      SizedBox(height: ModernSaasDesign.space20 + 56.0),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildModernHeader() {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
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
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 20,
                            ),
                            color: const Color(0xFF475569),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'NDIS Pricing Management',
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 24 : 28,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF0F172A),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (!isSmallScreen) ...[
                                const SizedBox(height: 8),
                                Text(
                                  'Manage NDIS rate and compliance',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ]
                            ],
                          ),
                        ),
                        if (!isSmallScreen)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF10B981)
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF10B981),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  'System Active',
                                  style: TextStyle(
                                    color: Color(0xFF10B981),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    if (isSmallScreen) ...[
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Manage NDIS rate and compliance',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF10B981)
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF10B981),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  'System Active',
                                  style: TextStyle(
                                    color: Color(0xFF10B981),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
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

  // Widget _buildModernAppBar() {
  //   return SliverToBoxAdapter(
  //     child: Container(
  //       color: Colors.white,
  //       child: SafeArea(
  //         child: Padding(
  //           padding: const EdgeInsets.all(24),
  //           child: Row(
  //             children: [
  //               Container(
  //                 decoration: BoxDecoration(
  //                   color: const Color(0xFFF1F5F9),
  //                   borderRadius: BorderRadius.circular(12),
  //                 ),
  //                 child: IconButton(
  //                   onPressed: () => Navigator.of(context).pop(),
  //                   icon: const Icon(
  //                     Icons.arrow_back_ios_new,
  //                     size: 20,
  //                   ),
  //                   color: const Color(0xFF475569),
  //                 ),
  //               ),
  //               const SizedBox(width: 16),
  //               Expanded(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     const Text(
  //                       'Pricing Dashboard',
  //                       style: TextStyle(
  //                         fontSize: 28,
  //                         fontWeight: FontWeight.bold,
  //                         color: Color(0xFF0F172A),
  //                       ),
  //                     ),
  //                     const SizedBox(height: 8),
  //                     Text(
  //                       'Comprehensive pricing management and analytics',
  //                       style: TextStyle(
  //                         fontSize: 16,
  //                         color: Colors.grey[600],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               Container(
  //                 padding:
  //                     const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  //                 decoration: BoxDecoration(
  //                   color: const Color(0xFF10B981).withValues(alpha:0.1),
  //                   borderRadius: BorderRadius.circular(20),
  //                   border: Border.all(
  //                     color: const Color(0xFF10B981).withValues(alpha:0.3),
  //                   ),
  //                 ),
  //                 child: Row(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     Container(
  //                       width: 8,
  //                       height: 8,
  //                       decoration: const BoxDecoration(
  //                         color: Color(0xFF10B981),
  //                         shape: BoxShape.circle,
  //                       ),
  //                     ),
  //                     const SizedBox(width: 6),
  //                     const Text(
  //                       'System Active',
  //                       style: TextStyle(
  //                         color: Color(0xFF10B981),
  //                         fontSize: 12,
  //                         fontWeight: FontWeight.w500,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildWelcomeSection() {
    return Container(
      color: ModernSaasDesign.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back! 👋',
            style: ModernSaasDesign.headlineLarge.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.3, end: 0),
          const SizedBox(height: ModernSaasDesign.space1),
          Text(
            'Here\'s what\'s happening with your pricing today.',
            style: ModernSaasDesign.bodyLarge.copyWith(
              color: ModernSaasDesign.textSecondary,
            ),
          )
              .animate()
              .fadeIn(duration: 600.ms, delay: 200.ms)
              .slideY(begin: 0.3, end: 0),
          const SizedBox(height: ModernSaasDesign.space1),
          _buildPeriodSelector(),
          const SizedBox(height: ModernSaasDesign.space2),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
    final periods = ['Today', 'This Week', 'This Month', 'This Quarter'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: periods.map((period) {
          final isSelected = period == _selectedPeriod;
          return Padding(
            padding: const EdgeInsets.only(right: ModernSaasDesign.space2),
            child: ModernButton(
              text: period,
              onPressed: () {
                setState(() {
                  _selectedPeriod = period;
                });
              },
              variant:
                  isSelected ? ButtonVariant.primary : ButtonVariant.outline,
              size: ButtonSize.small,
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
          'Key Metrics',
          style: ModernSaasDesign.headlineSmall.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: ModernSaasDesign.space3),
        LayoutBuilder(
          builder: (context, constraints) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _getCrossAxisCount(constraints.maxWidth),
                crossAxisSpacing: ModernSaasDesign.space3,
                mainAxisSpacing: ModernSaasDesign.space3,
                childAspectRatio:
                    constraints.maxWidth < ModernSaasDesign.breakpointMd
                        ? 1.4
                        : 1.6,
              ),
              itemCount: _metrics.length,
              itemBuilder: (context, index) {
                final metric = _metrics[index];
                return ModernMetricCard(
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
          'Quick Actions',
          style: ModernSaasDesign.headlineSmall.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        //const SizedBox(height: ModernSaasDesign.space2),
        LayoutBuilder(
          builder: (context, constraints) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: ModernSaasDesign.space4),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _getCrossAxisCount(constraints.maxWidth),
                crossAxisSpacing: ModernSaasDesign.space3,
                mainAxisSpacing: ModernSaasDesign.space3,
                childAspectRatio:
                    constraints.maxWidth < ModernSaasDesign.breakpointMd
                        ? 1.3
                        : 1.5,
              ),
              itemCount: _quickActions.length,
              itemBuilder: (context, index) {
                final action = _quickActions[index];
                return ModernActionCard(
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
          'Analytics Overview',
          style: ModernSaasDesign.headlineSmall.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: ModernSaasDesign.space4),
        ModernChartWidget(
          title: 'Revenue Trend',
          data: _generateChartData(),
          type: ChartType.line,
          primaryColor: ModernSaasDesign.primary,
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
              'Recent Activity',
              style: ModernSaasDesign.headlineSmall.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to full activity log
              },
              child: Text(
                'View All',
                style: ModernSaasDesign.bodyMedium.copyWith(
                  color: ModernSaasDesign.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: ModernSaasDesign.space4),
        ModernCard(
          child: Column(
            children: _recentActivities.asMap().entries.map((entry) {
              final index = entry.key;
              final activity = entry.value;
              final isLast = index == _recentActivities.length - 1;

              return ModernActivityItem(
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
    if (width >= ModernSaasDesign.breakpointXl) return 4;
    if (width >= ModernSaasDesign.breakpointLg) return 3;
    if (width >= ModernSaasDesign.breakpointMd) return 2;
    return 1;
  }

  List<ChartData> _generateChartData() {
    return [
      ChartData(label: 'Jan', value: 45000),
      ChartData(label: 'Feb', value: 52000),
      ChartData(label: 'Mar', value: 48000),
      ChartData(label: 'Apr', value: 61000),
      ChartData(label: 'May', value: 55000),
      ChartData(label: 'Jun', value: 67000),
    ];
  }

  void _handleQuickAction(String actionTitle) {
    // Handle different quick actions
    switch (actionTitle) {
      case 'Add New Item':
        // Navigate to add item screen
        break;
      case 'Bulk Import':
        // Navigate to import screen
        break;
      case 'Generate Report':
        // Navigate to reports screen
        break;
      case 'Settings':
        // Navigate to settings screen
        break;
    }
  }
}

// Data Models
class MetricData {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final double trend;
  final String trendLabel;

  MetricData({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.trend,
    required this.trendLabel,
  });
}

class QuickActionData {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  QuickActionData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}

class ActivityData {
  final String title;
  final String description;
  final String timestamp;
  final IconData icon;
  final Color color;

  ActivityData({
    required this.title,
    required this.description,
    required this.timestamp,
    required this.icon,
    required this.color,
  });
}
