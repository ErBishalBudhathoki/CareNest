import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/pricing/views/pricing_dashboard_view.dart';
import 'package:carenest/app/features/pricing/views/ndis_pricing_management_view.dart';
import 'package:carenest/app/features/pricing/views/service_rate_management_view.dart';
import 'package:carenest/app/features/pricing/views/bulk_operations_view.dart';
import 'package:carenest/app/features/pricing/views/price_history_view.dart';
import 'package:carenest/app/features/pricing/views/pricing_configuration_view.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

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
  final bool _isLoadingNdisItems = false;
  final bool _ndisItemsEmpty = false;
  final bool _showOnboarding = true;

  List<Map<String, dynamic>> _getPricingModules(BuildContext context) => [
        {
          'title': AppLocalizations.of(context)!.dashboardOverviewTitle,
          'subtitle': AppLocalizations.of(context)!.dashboardOverviewSubtitle,
          'icon': Icons.dashboard_rounded,
          'color': const Color(0xFF6366F1),
          'gradient': [const Color(0xFF6366F1), const Color(0xFF8B5CF6)],
          'route': 'dashboard',
          'stats': AppLocalizations.of(context)!.activeMetricsTitle('12')
        },
        {
          'title': AppLocalizations.of(context)!.ndisPricingTitle,
          'subtitle': AppLocalizations.of(context)!.ndisPricingSubtitle,
          'icon': Icons.medical_services_rounded,
          'color': const Color(0xFF10B981),
          'gradient': [const Color(0xFF10B981), const Color(0xFF059669)],
          'route': 'ndis',
          'stats': AppLocalizations.of(context)!.ndisItemsStat('156')
        },
        {
          'title': AppLocalizations.of(context)!.serviceRatesTitle,
          'subtitle': AppLocalizations.of(context)!.serviceRatesSubtitle,
          'icon': Icons.rate_review_rounded,
          'color': const Color(0xFFF59E0B),
          'gradient': [const Color(0xFFF59E0B), const Color(0xFFD97706)],
          'route': 'service_rates',
          'stats': AppLocalizations.of(context)!.serviceTypesStat('42')
        },
        {
          'title': AppLocalizations.of(context)!.bulkOperationsTitle,
          'subtitle': AppLocalizations.of(context)!.bulkOperationsSubtitle,
          'icon': Icons.batch_prediction_rounded,
          'color': const Color(0xFF3B82F6),
          'gradient': [const Color(0xFF3B82F6), const Color(0xFF2563EB)],
          'route': 'bulk_operations',
          'stats': AppLocalizations.of(context)!.pendingOpsStat('3')
        },
        {
          'title': AppLocalizations.of(context)!.priceHistoryTitle,
          'subtitle': AppLocalizations.of(context)!.priceHistorySubtitle,
          'icon': Icons.history_rounded,
          'color': const Color(0xFF8B5CF6),
          'gradient': [const Color(0xFF8B5CF6), const Color(0xFF7C3AED)],
          'route': 'price_history',
          'stats': AppLocalizations.of(context)!.historicalRecordsStat('248')
        },
        {
          'title': AppLocalizations.of(context)!.quickActionsTitle,
          'subtitle': AppLocalizations.of(context)!.quickActionsSubtitle,
          'icon': Icons.flash_on_rounded,
          'color': const Color(0xFFEF4444),
          'gradient': [const Color(0xFFEF4444), const Color(0xFFDC2626)],
          'route': 'quick_actions',
          'stats': AppLocalizations.of(context)!.shortcutsAvailableStat('5')
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildBauhausHeader(),
            _buildHorizontalStats(),
            _buildPricingModulesGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildBauhausHeader() {
    return Container(
      color: BauhausDesign.surfaceWhite,
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
                      Container(
                        decoration: BoxDecoration(
                          color: BauhausDesign.backgroundLight,
                          borderRadius:
                              BorderRadius.circular(BauhausDesign.radiusMd),
                          border: Border.all(color: BauhausDesign.neutral),
                        ),
                        child: IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 20,
                          ),
                          color: BauhausDesign.textDark,
                        ),
                      ),
                      const SizedBox(width: BauhausDesign.space4),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .pricingManagementTitle,
                              style: BauhausDesign.getTextTheme(context)
                                  .displaySmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: isSmallScreen ? 24 : 28,
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
                                    .bodyMedium
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
                          text: AppLocalizations.of(context)!.systemActive,
                          color: BauhausDesign.success,
                          icon: Icons.circle,
                        ),
                      const SizedBox(width: BauhausDesign.space3),
                      // Settings shortcut button
                      Container(
                        decoration: BoxDecoration(
                          color: BauhausDesign.backgroundLight,
                          borderRadius:
                              BorderRadius.circular(BauhausDesign.radiusMd),
                          border: Border.all(color: BauhausDesign.neutral),
                        ),
                        child: IconButton(
                          onPressed: _openPricingSettings,
                          icon: const Icon(
                            Icons.settings,
                            size: 20,
                          ),
                          tooltip: AppLocalizations.of(context)!
                              .pricingSettingsTooltip,
                          color: BauhausDesign.textDark,
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
                        BauhausChip(
                          text: AppLocalizations.of(context)!.activeLabel,
                          color: BauhausDesign.success,
                          icon: Icons.circle,
                        ),
                      ],
                    ),
                  ]
                ],
              ),
            );
          },
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

  Widget _buildHorizontalStats() {
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
                children: [
                  SizedBox(
                    width: 180,
                    child: _buildStatCard(
                      title: AppLocalizations.of(context)!.totalServicesLabel,
                      value: '156',
                      subtitle:
                          AppLocalizations.of(context)!.thisMonthStat('12'),
                      icon: Icons.business_center,
                      color: const Color(0xFF6366F1),
                    ),
                  ),
                  const SizedBox(width: BauhausDesign.space3),
                  SizedBox(
                    width: 180,
                    child: _buildStatCard(
                      title: AppLocalizations.of(context)!.activeRatesLabel,
                      value: '142',
                      subtitle: AppLocalizations.of(context)!.urgentStat('3'),
                      icon: Icons.check_circle,
                      color: const Color(0xFF10B981),
                    ),
                  ),
                  const SizedBox(width: BauhausDesign.space3),
                  SizedBox(
                    width: 180,
                    child: _buildStatCard(
                      title: AppLocalizations.of(context)!.pendingUpdatesLabel,
                      value: '14',
                      subtitle: AppLocalizations.of(context)!.vsLastQuarterStat,
                      icon: Icons.pending,
                      color: const Color(0xFFF59E0B),
                    ),
                  ),
                  const SizedBox(width: BauhausDesign.space3),
                  SizedBox(
                    width: 180,
                    child: _buildStatCard(
                      title: AppLocalizations.of(context)!.avgRateLabel,
                      value: '\$85.50',
                      subtitle:
                          AppLocalizations.of(context)!.projectedMonthlyStat,
                      icon: Icons.attach_money,
                      color: const Color(0xFF3B82F6),
                    ),
                  ),
                ],
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
                        title: AppLocalizations.of(context)!.totalServicesLabel,
                        value: '156',
                        subtitle:
                            AppLocalizations.of(context)!.thisMonthStat('12'),
                        icon: Icons.business_center,
                        color: const Color(0xFF6366F1),
                      ),
                    ),
                    const SizedBox(width: BauhausDesign.space3),
                    Expanded(
                      child: _buildStatCard(
                        title: AppLocalizations.of(context)!.activeRatesLabel,
                        value: '142',
                        subtitle: AppLocalizations.of(context)!.urgentStat('3'),
                        icon: Icons.check_circle,
                        color: const Color(0xFF10B981),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: BauhausDesign.space3),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        title:
                            AppLocalizations.of(context)!.pendingUpdatesLabel,
                        value: '14',
                        subtitle:
                            AppLocalizations.of(context)!.vsLastQuarterStat,
                        icon: Icons.pending,
                        color: const Color(0xFFF59E0B),
                      ),
                    ),
                    const SizedBox(width: BauhausDesign.space3),
                    Expanded(
                      child: _buildStatCard(
                        title: AppLocalizations.of(context)!.avgRateLabel,
                        value: '\$85.50',
                        subtitle:
                            AppLocalizations.of(context)!.projectedMonthlyStat,
                        icon: Icons.attach_money,
                        color: const Color(0xFF3B82F6),
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
    return BauhausCard(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space2),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 18,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.more_vert,
                color: BauhausDesign.textMuted,
                size: 16,
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space3),
          Text(
            value,
            style: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: BauhausDesign.textDark,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: BauhausDesign.space1),
          Text(
            title,
            style: BauhausDesign.getTextTheme(context).labelMedium?.copyWith(
                  color: BauhausDesign.textMuted,
                  fontWeight: FontWeight.w600,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: BauhausDesign.space1),
          Text(
            subtitle,
            style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                  color: BauhausDesign.textMuted,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildPricingModulesGrid() {
    return Container(
      decoration: const BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(BauhausDesign.radiusLg),
          topRight: Radius.circular(BauhausDesign.radiusLg),
        ),
        boxShadow: [BauhausDesign.shadowHard],
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
                      padding: const EdgeInsets.all(BauhausDesign.space3),
                      decoration: BoxDecoration(
                        color: BauhausDesign.primary.withOpacity(0.1),
                        borderRadius:
                            BorderRadius.circular(BauhausDesign.radiusMd),
                      ),
                      child: const Icon(
                        Icons.apps_rounded,
                        color: BauhausDesign.primary,
                        size: 24,
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
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: BauhausDesign.textDark,
                                ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.chooseModuleDesc,
                            style: BauhausDesign.getTextTheme(context)
                                .bodyMedium
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
              final crossAxisCount = constraints.maxWidth > 800 ? 3 : 2;
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
                  crossAxisSpacing: BauhausDesign.space4,
                  mainAxisSpacing: BauhausDesign.space4,
                  childAspectRatio: 1.1,
                ),
                itemCount: _getPricingModules(context).length,
                itemBuilder: (context, index) {
                  final module = _getPricingModules(context)[index];
                  return _buildPricingModuleCard(module, index);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPricingModuleCard(Map<String, dynamic> module, int index) {
    return GestureDetector(
      onTap: () => _navigateToModule(module['route']),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 600 + (index * 100)),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: module['gradient'],
          ),
          boxShadow: [
            BoxShadow(
              color: module['color'].withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(BauhausDesign.space4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.1),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(BauhausDesign.space3),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius:
                            BorderRadius.circular(BauhausDesign.radiusMd),
                      ),
                      child: Icon(
                        module['icon'],
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: BauhausDesign.space2),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: BauhausDesign.space2,
                        vertical: BauhausDesign.space1,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius:
                            BorderRadius.circular(BauhausDesign.radiusMd),
                      ),
                      child: Text(
                        module['stats'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: BauhausDesign.space3),
              Flexible(
                child: Text(
                  module['title'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: BauhausDesign.space1),
              Flexible(
                child: Text(
                  module['subtitle'],
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
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
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: const BoxDecoration(
          color: BauhausDesign.surfaceWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(BauhausDesign.radiusLg),
            topRight: Radius.circular(BauhausDesign.radiusLg),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: BauhausDesign.space3),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: BauhausDesign.neutral,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(BauhausDesign.space6),
              child: Text(
                AppLocalizations.of(context)!.quickActionsTitle,
                style:
                    BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: BauhausDesign.textDark,
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
                    Icons.update_rounded,
                    const Color(0xFF6366F1),
                    () => _navigateToModule('bulk_operations'),
                  ),
                  _buildQuickActionTile(
                    AppLocalizations.of(context)!.exportPricingDataTitle,
                    AppLocalizations.of(context)!.exportPricingDataSubtitle,
                    Icons.download_rounded,
                    const Color(0xFF10B981),
                    () => _navigateToModule('bulk_operations'),
                  ),
                  _buildQuickActionTile(
                    AppLocalizations.of(context)!.priceAnalyticsTitle,
                    AppLocalizations.of(context)!.priceAnalyticsSubtitle,
                    Icons.analytics_rounded,
                    const Color(0xFF3B82F6),
                    () => _navigateToModule('dashboard'),
                  ),
                  _buildQuickActionTile(
                    AppLocalizations.of(context)!.ndisComplianceCheckTitle,
                    AppLocalizations.of(context)!.ndisComplianceCheckSubtitle,
                    Icons.verified_rounded,
                    const Color(0xFFF59E0B),
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
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(BauhausDesign.space3),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: BauhausDesign.textDark,
              ),
        ),
        subtitle: Text(
          subtitle,
          style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                color: BauhausDesign.textMuted,
              ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: BauhausDesign.neutral,
          size: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          side: const BorderSide(color: BauhausDesign.neutral),
        ),
        tileColor: BauhausDesign.backgroundLight,
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
