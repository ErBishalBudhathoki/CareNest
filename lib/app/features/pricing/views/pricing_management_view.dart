import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/shared/constants/values/dimens/app_dimens.dart';
import 'package:carenest/app/shared/widgets/stat_cards.dart';
import 'package:carenest/app/features/pricing/views/pricing_dashboard_view.dart';
import 'package:carenest/app/features/pricing/views/ndis_item_management_view.dart';
import 'package:carenest/app/features/pricing/views/ndis_pricing_management_view.dart';
import 'package:carenest/app/features/pricing/views/service_rate_management_view.dart';
import 'package:carenest/app/features/pricing/views/bulk_operations_view.dart';
import 'package:carenest/app/features/pricing/views/price_history_view.dart';
import 'package:carenest/app/features/pricing/widgets/improved_design_system.dart';
import 'package:carenest/app/features/pricing/widgets/enhanced_navigation.dart';
import 'dart:ui';
import 'package:flutter_animate/flutter_animate.dart';

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
  bool _isLoadingNdisItems = false;
  bool _ndisItemsEmpty = false;
  bool _showOnboarding = true; // For onboarding tooltip

  final List<Map<String, dynamic>> _pricingModules = [
    {
      'title': 'Dashboard Overview',
      'subtitle': 'View pricing analytics and insights',
      'icon': Icons.dashboard_rounded,
      'color': const Color(0xFF6366F1),
      'gradient': [const Color(0xFF6366F1), const Color(0xFF8B5CF6)],
      'route': 'dashboard',
      'stats': '12 active metrics'
    },
    {
      'title': 'NDIS Pricing',
      'subtitle': 'Manage NDIS rates and compliance',
      'icon': Icons.medical_services_rounded,
      'color': const Color(0xFF10B981),
      'gradient': [const Color(0xFF10B981), const Color(0xFF059669)],
      'route': 'ndis',
      'stats': '156 NDIS items'
    },
    {
      'title': 'Service Rates',
      'subtitle': 'Configure service pricing structures',
      'icon': Icons.rate_review_rounded,
      'color': const Color(0xFFF59E0B),
      'gradient': [const Color(0xFFF59E0B), const Color(0xFFD97706)],
      'route': 'service_rates',
      'stats': '42 service types'
    },
    {
      'title': 'Bulk Operations',
      'subtitle': 'Import/export and batch updates',
      'icon': Icons.batch_prediction_rounded,
      'color': const Color(0xFF3B82F6),
      'gradient': [const Color(0xFF3B82F6), const Color(0xFF2563EB)],
      'route': 'bulk_operations',
      'stats': '3 pending operations'
    },
    {
      'title': 'Price History',
      'subtitle': 'Track pricing changes over time',
      'icon': Icons.history_rounded,
      'color': const Color(0xFF8B5CF6),
      'gradient': [const Color(0xFF8B5CF6), const Color(0xFF7C3AED)],
      'route': 'price_history',
      'stats': '248 historical records'
    },
    {
      'title': 'Quick Actions',
      'subtitle': 'Frequently used pricing tools',
      'icon': Icons.flash_on_rounded,
      'color': const Color(0xFFEF4444),
      'gradient': [const Color(0xFFEF4444), const Color(0xFFDC2626)],
      'route': 'quick_actions',
      'stats': '5 shortcuts available'
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
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildModernHeader(),
            _buildHorizontalStats(),
            _buildPricingModulesGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildModernHeader() {
    return Container(
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
                              'Pricing Management',
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
                                'Manage and optimize your service pricing across different regions and categories',
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
                            color:
                                const Color(0xFF10B981).withValues(alpha: 0.1),
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
                            'Manage and optimize your service pricing',
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
                            color:
                                const Color(0xFF10B981).withValues(alpha: 0.1),
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
                                'Active',
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
                  ]
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHorizontalStats() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final cardWidth =
            (screenWidth - 64) / 2; // 2 cards per row on small screens
        final isWideScreen = screenWidth > 600;

        if (isWideScreen) {
          // Horizontal scrollable layout for wide screens
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
                      title: 'Total Services',
                      value: '156',
                      subtitle: '+12 this month',
                      icon: Icons.business_center,
                      color: const Color(0xFF6366F1),
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 160,
                    child: _buildStatCard(
                      title: 'Active Rates',
                      value: '142',
                      subtitle: '3 urgent',
                      icon: Icons.check_circle,
                      color: const Color(0xFF10B981),
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 160,
                    child: _buildStatCard(
                      title: 'Pending Updates',
                      value: '14',
                      subtitle: 'vs last quarter',
                      icon: Icons.pending,
                      color: const Color(0xFFF59E0B),
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 160,
                    child: _buildStatCard(
                      title: 'Avg Rate',
                      value: '\$85.50',
                      subtitle: 'projected monthly',
                      icon: Icons.attach_money,
                      color: const Color(0xFF3B82F6),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          // Grid layout for smaller screens
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        title: 'Total Services',
                        value: '156',
                        subtitle: '+12 this month',
                        icon: Icons.business_center,
                        color: const Color(0xFF6366F1),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        title: 'Active Rates',
                        value: '142',
                        subtitle: '3 urgent',
                        icon: Icons.check_circle,
                        color: const Color(0xFF10B981),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        title: 'Pending Updates',
                        value: '14',
                        subtitle: 'vs last quarter',
                        icon: Icons.pending,
                        color: const Color(0xFFF59E0B),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        title: 'Avg Rate',
                        value: '\$85.50',
                        subtitle: 'projected monthly',
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
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
                color: Colors.grey[400],
                size: 16,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 3),
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[500],
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
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.apps_rounded,
                        color: Color(0xFF6366F1),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pricing Modules',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            'Choose a module to manage your pricing',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF64748B),
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
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                ),
                itemCount: _pricingModules.length,
                itemBuilder: (context, index) {
                  final module = _pricingModules[index];
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
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: module['gradient'],
          ),
          boxShadow: [
            BoxShadow(
              color: module['color'].withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.1),
                Colors.white.withValues(alpha: 0.05),
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
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        module['icon'],
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        module['stats'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Flexible(
                child: Text(
                  module['title'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 4),
              Flexible(
                child: Text(
                  module['subtitle'],
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 11,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 8),
              // Row(
              //   children: [
              //     const Spacer(),
              //     Container(
              //       padding: const EdgeInsets.all(6),
              //       decoration: BoxDecoration(
              //         color: Colors.white.withValues(alpha:0.2),
              //         borderRadius: BorderRadius.circular(8),
              //       ),
              //       child: const Icon(
              //         Icons.arrow_forward_rounded,
              //         color: Colors.white,
              //         size: 14,
              //       ),
              //     ),
              //   ],
              // ),
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
        _showSnackBar('Module not available yet', isError: true);
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
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  _buildQuickActionTile(
                    'Bulk Price Update',
                    'Update multiple prices at once',
                    Icons.update_rounded,
                    const Color(0xFF6366F1),
                    () => _navigateToModule('bulk_operations'),
                  ),
                  _buildQuickActionTile(
                    'Export Pricing Data',
                    'Download current pricing information',
                    Icons.download_rounded,
                    const Color(0xFF10B981),
                    () => _navigateToModule('bulk_operations'),
                  ),
                  _buildQuickActionTile(
                    'Price Analytics',
                    'View pricing trends and insights',
                    Icons.analytics_rounded,
                    const Color(0xFF3B82F6),
                    () => _navigateToModule('dashboard'),
                  ),
                  _buildQuickActionTile(
                    'NDIS Compliance Check',
                    'Verify NDIS pricing compliance',
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
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF0F172A),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.grey[400],
          size: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        tileColor: Colors.grey[50],
      ),
    );
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
