import 'dart:ui';
import 'dart:typed_data';

import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/features/client/views/add_client_details_view.dart';
import 'package:carenest/app/features/holiday/views/holiday_list_view.dart';
import 'package:carenest/app/shared/constants/values/strings/asset_strings.dart';
import 'package:carenest/app/features/invoice/views/add_update_invoice_email_view.dart';
import 'package:carenest/app/features/invoice/views/invoice_email_view.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/shared/widgets/profile_image_widget.dart';
import 'package:carenest/app/shared/widgets/home_detail_card_widget.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/features/employee_tracking/views/employee_tracking_view.dart';
import 'package:carenest/app/features/notifications/providers/notification_provider.dart';
import 'package:carenest/app/features/notifications/views/notification_list_view.dart';
import 'package:carenest/app/features/pricing/views/pricing_management_view.dart';
import 'package:carenest/app/features/pricing/views/client_pricing_review_view.dart';
import 'package:carenest/app/features/pricing/views/employee_pay_rate_view.dart';
import 'package:carenest/app/features/expenses/views/expense_management_view.dart';
import 'package:carenest/app/features/invoice/views/employee_selection_view.dart';
import 'package:carenest/app/features/earnings/views/earnings_dashboard_view.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:carenest/app/features/settings/views/settings_view.dart';
import 'package:carenest/app/features/security/views/api_usage_dashboard_view.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:carenest/app/features/admin/widgets/bauhaus_invoice_grid.dart';
import 'package:carenest/app/features/admin/widgets/business_overview_sliver.dart';
import 'package:carenest/app/features/training_compliance/views/admin_certification_audit_view.dart';
import 'package:carenest/app/features/training_compliance/views/admin_training_management_view.dart';
import 'package:carenest/app/features/training_compliance/views/admin_compliance_management_view.dart';
import 'package:carenest/app/features/analytics/views/analytics_dashboard_view.dart';
import 'package:carenest/app/features/admin/views/mileage/admin_mileage_dashboard.dart';
import 'package:carenest/app/features/schedule/views/schedule_dashboard_screen.dart';
import 'package:carenest/app/features/onboarding/views/admin/admin_onboarding_list_view.dart';

import 'package:carenest/app/features/timesheet/views/admin_payroll_export_view.dart';

// Phase 1-10 Advanced Features
import 'package:carenest/app/features/analytics/views/enhanced_predictive_insights_view.dart';
import 'package:carenest/app/features/bulk_actions/views/bulk_actions_view.dart';
import 'package:carenest/app/features/scheduling/views/auto_schedule_dashboard.dart';
import 'package:carenest/app/features/invoice/views/invoice_ai_dashboard.dart';
import 'package:carenest/app/features/compliance/views/compliance_automation_dashboard.dart';
import 'package:carenest/app/features/expenses/views/smart_expense_dashboard.dart';
import 'package:carenest/app/features/payroll/views/advanced_payroll_dashboard.dart';
import 'package:carenest/app/features/communication/views/communication_hub_dashboard.dart';
import 'package:carenest/app/features/realtime_portal/views/realtime_portal_dashboard.dart';
import 'package:carenest/app/features/workforce_optimization/views/workforce_optimization_dashboard.dart';
import 'package:carenest/app/features/care_intelligence/views/care_intelligence_dashboard.dart';
import 'package:carenest/app/features/financial_intelligence/views/financial_intelligence_dashboard.dart';

class AdminDashboardView extends ConsumerStatefulWidget {
  final String email;
  final Uint8List? photoData;
  final String? organizationId;
  final String? organizationName;
  final String? organizationCode;
  final PersistentTabController? controller;
  const AdminDashboardView({
    super.key,
    required this.email,
    this.photoData,
    this.organizationId,
    this.organizationName,
    this.organizationCode,
    this.controller,
  });
  @override
  _AdminDashboardViewControllerState createState() =>
      _AdminDashboardViewControllerState();
}

class _AdminDashboardViewControllerState
    extends ConsumerState<AdminDashboardView> with TickerProviderStateMixin {
  Map<String, dynamic> getInitialData = {};
  Map<String, dynamic> businessStats = {};
  late final ApiMethod _apiMethod;
  final SharedPreferencesUtils _sharedPrefs = SharedPreferencesUtils();
  String? key;
  bool _isLoading = true;
  bool _isStatsLoading = true;
  String? _statsError;
  late AnimationController _headerAnimationController;
  late AnimationController _contentAnimationController;
  late AnimationController _statsAnimationController;
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _apiMethod = ref.read(apiMethodProvider);

    _initializeAnimations();
    _fetchInitialData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notificationProvider.notifier).refresh();
    });
  }

  void _initializeAnimations() {
    _headerAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _contentAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _statsAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _headerAnimationController.dispose();
    _contentAnimationController.dispose();
    _statsAnimationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchInitialData() async {
    try {
      final data = await _apiMethod.getInitData(widget.email);
      final emailKey = await _checkEmailKey(widget.email);

      Map<String, dynamic> stats = {};
      String? statsError;

      if (widget.organizationId != null && widget.organizationId!.isNotEmpty) {
        try {
          final response =
              await _apiMethod.getInvoiceStats(widget.organizationId!);

          if (response['success'] == true && response['data'] != null) {
            stats = response['data'];
          } else {
            stats = {
              'activeBusinesses': 0,
              'totalClients': 0,
              'totalInvoices': 0,
              'totalRevenue': '\$0.00'
            };
          }
        } catch (e) {
          statsError = AppLocalizations.of(context)!.failedToLoadStats;
          stats = {
            'activeBusinesses': 0,
            'totalClients': 0,
            'totalInvoices': 0,
            'totalRevenue': '\$0.00'
          };
        }
      } else {
        statsError = AppLocalizations.of(context)!.orgIdNotAvailable;
        stats = {
          'activeBusinesses': 0,
          'totalClients': 0,
          'totalInvoices': 0,
          'totalRevenue': '\$0.00'
        };
      }

      if (mounted) {
        setState(() {
          getInitialData = data;
          businessStats = stats;
          key = emailKey;
          _isLoading = false;
          _isStatsLoading = false;
          _statsError = statsError;
        });
        ref.read(photoDataProvider.notifier).fetchPhotoData(widget.email);

        _headerAnimationController.forward();
        Future.delayed(const Duration(milliseconds: 300), () {
          _statsAnimationController.forward();
        });
        Future.delayed(const Duration(milliseconds: 600), () {
          _contentAnimationController.forward();
        });
      }
    } catch (e) {
      debugPrint("Error fetching initial data: $e");
      setState(() => _isLoading = false);
    }
  }

  Future<String> _checkEmailKey(String email) async {
    try {
      final response = await _apiMethod.checkInvoicingEmailKey(email);
      if (response['message'] == 'Invoicing email key found') {
        return response['key'] ?? 'add';
      } else if (response['message'] == 'No invoicing email key found') {
        return 'add';
      }
      return 'error';
    } catch (e) {
      debugPrint("Error checking key: $e");
      return 'error';
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: BauhausDesign.surfaceWhite,
              ),
        ),
        backgroundColor: isError ? BauhausDesign.error : BauhausDesign.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BauhausDesign.radiusLg)),
        margin: const EdgeInsets.all(BauhausDesign.space6),
        elevation: 8,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: BauhausDesign.backgroundLight,
        body: Center(
          child: BauhausLoadingState(
            message: AppLocalizations.of(context)!.loadingDashboard,
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              _buildEnhancedHeaderSliver(),
              BusinessOverviewSliver(
                animation: _statsAnimationController,
                businessStats: businessStats,
              ),
              _buildFeaturedActionsSliver(),
              _buildQuickActionsSliver(),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
          _buildStickyAdminLabel(),
        ],
      ),
    );
  }

  Widget _buildEnhancedHeaderSliver() {
    final firstName = getInitialData['firstName'] ?? 'Test';
    final lastName = getInitialData['lastName'] ?? 'User';
    final photoDataState = ref.watch(photoDataProvider);
    final displayPhoto = photoDataState.photoData ?? widget.photoData;

    // Detect small screen to adjust layout
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenHeight < 700;

    return SliverAppBar(
      expandedHeight: isSmallScreen ? 260.0 : 240.0,
      pinned: false,
      floating: false,
      elevation: 0,
      backgroundColor: BauhausDesign.primary,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            color: BauhausDesign.primary,
            border: Border(
              bottom: BorderSide(
                color: BauhausDesign.neutral,
                width: 2,
              ),
            ),
          ),
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: _headerAnimationController,
                builder: (context, child) {
                  return Positioned(
                    top: isSmallScreen ? 50 : 60, // Pushed up slightly for small screens
                    right: 24,
                    child: Transform.scale(
                      scale: _headerAnimationController.value,
                      child: Opacity(
                        opacity: _headerAnimationController.value,
                        child: Row(
                          children: [
                            Consumer(
                              builder: (context, ref, child) {
                                final unreadCount =
                                    ref.watch(unreadNotificationCountProvider);
                                final hasUnread = unreadCount > 0;

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const NotificationListView(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: BauhausDesign.surfaceWhite,
                                      borderRadius: BorderRadius.circular(
                                          BauhausDesign.radiusMd),
                                      border: Border.all(
                                        color: BauhausDesign.neutral,
                                        width: 2,
                                      ),
                                      boxShadow: const [
                                        BauhausDesign.shadowHardSm,
                                      ],
                                    ),
                                    child: Stack(
                                      children: [
                                        Icon(
                                          hasUnread
                                              ? Icons.notifications_active
                                              : Icons.notifications_outlined,
                                          color: BauhausDesign.neutral,
                                          size: 20,
                                        ),
                                        if (hasUnread)
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: Container(
                                              width: 10,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                color: BauhausDesign.error,
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                  color: BauhausDesign.neutral,
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: BauhausDesign.space4),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SettingsView(
                                      userEmail: widget.email,
                                      userName: '$firstName $lastName',
                                      photoData: photoDataState.photoData,
                                      organizationId: widget.organizationId,
                                      organizationName: widget.organizationName,
                                      organizationCode: widget.organizationCode,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: BauhausDesign.surfaceWhite,
                                  borderRadius: BorderRadius.circular(
                                      BauhausDesign.radiusMd),
                                  border: Border.all(
                                    color: BauhausDesign.neutral,
                                    width: 2,
                                  ),
                                  boxShadow: const [
                                    BauhausDesign.shadowHardSm,
                                  ],
                                ),
                                child: const Icon(
                                  Icons.settings_outlined,
                                  color: BauhausDesign.neutral,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(24, isSmallScreen ? 10 : 20, 24, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedBuilder(
                        animation: _headerAnimationController,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(
                              0,
                              15 * (1 - _headerAnimationController.value),
                            ),
                            child: Opacity(
                              opacity: _headerAnimationController.value,
                              child: Row(
                                children: [
                                  Hero(
                                    tag: 'profile_photo',
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: BauhausDesign.neutral,
                                          width: 2,
                                        ),
                                        boxShadow: const [
                                          BauhausDesign.shadowHard,
                                        ],
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(0),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: BauhausDesign.surfaceWhite,
                                        ),
                                        child: AdminProfileImage(
                                          email: widget.email,
                                          photoData: displayPhoto,
                                          size: 70,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: BauhausDesign.space6),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TweenAnimationBuilder<double>(
                                          duration:
                                              const Duration(milliseconds: 600),
                                          tween: Tween(begin: 0.0, end: 1.0),
                                          builder: (context, value, child) {
                                            return Transform.translate(
                                              offset:
                                                  Offset(0, 8 * (1 - value)),
                                              child: Opacity(
                                                opacity: value,
                                                child: Text(
                                                  _getCurrentGreeting(),
                                                  style: BauhausDesign
                                                          .getTextTheme(context)
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        color: BauhausDesign
                                                            .surfaceWhite,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(
                                          height: BauhausDesign.space1),
                                      TweenAnimationBuilder<double>(
                                        duration:
                                            const Duration(milliseconds: 800),
                                        tween: Tween(begin: 0.0, end: 1.0),
                                        builder: (context, value, child) {
                                          return Transform.translate(
                                            offset:
                                                Offset(0, 12 * (1 - value)),
                                            child: Opacity(
                                              opacity: value,
                                              child: Text(
                                                '$firstName $lastName',
                                                style: BauhausDesign
                                                        .getTextTheme(context)
                                                    .headlineMedium
                                                    ?.copyWith(
                                                      color: BauhausDesign
                                                          .surfaceWhite,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      letterSpacing: -0.5,
                                                      height: 1.1,
                                                      fontSize: isSmallScreen ? 24 : 32, // Smaller font for small screens
                                                    ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(
                                          height: BauhausDesign.space2),
                                        TweenAnimationBuilder<double>(
                                          duration: const Duration(
                                              milliseconds: 1000),
                                          tween: Tween(begin: 0.0, end: 1.0),
                                          builder: (context, value, child) {
                                            return Transform.translate(
                                              offset:
                                                  Offset(0, 15 * (1 - value)),
                                              child: Opacity(
                                                opacity: value,
                                                child: Row(
                                                  children: [
                                                    _buildQuickStat(
                                                        context,
                                                        'Active',
                                                        (businessStats[
                                                                    'activeInvoices'] ??
                                                                0)
                                                            .toString(),
                                                        Icons.trending_up),
                                                    const SizedBox(
                                                        width: BauhausDesign
                                                            .space4),
                                                    _buildQuickStat(
                                                        context,
                                                        'Pending',
                                                        (businessStats[
                                                                    'pendingInvoices'] ??
                                                                0)
                                                            .toString(),
                                                        Icons.schedule),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
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
                      const Spacer(),
                      AnimatedBuilder(
                        animation: _headerAnimationController,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(
                              0,
                              (isSmallScreen ? 10 : 20) * (1 - _headerAnimationController.value),
                            ),
                            child: Opacity(
                              opacity: _headerAnimationController.value,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: BauhausDesign.surfaceWhite,
                                      borderRadius: BorderRadius.circular(
                                          BauhausDesign.radiusLg),
                                      border: Border.all(
                                        color: BauhausDesign.neutral,
                                        width: 1.5,
                                      ),
                                      boxShadow: const [
                                        BauhausDesign.shadowHardSm,
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: BauhausDesign.success,
                                            shape:
                                                BoxShape.rectangle, // Geometric
                                            border: Border.all(
                                                color: BauhausDesign.neutral,
                                                width: 1),
                                          ),
                                        ),
                                        const SizedBox(
                                            width: BauhausDesign.space2),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .adminActive,
                                          style: BauhausDesign.getTextTheme(
                                                  context)
                                              .labelSmall
                                              ?.copyWith(
                                                color: BauhausDesign.neutral,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: BauhausDesign.accent,
                                      borderRadius: BorderRadius.circular(
                                          BauhausDesign.radiusMd),
                                      border: Border.all(
                                        color: BauhausDesign.neutral,
                                        width: 2,
                                      ),
                                      boxShadow: const [
                                        BauhausDesign.shadowHard,
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.add_rounded,
                                      color: BauhausDesign.neutral,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsOverviewSliver() {
    return SliverToBoxAdapter(
      child: AnimatedBuilder(
        animation: _statsAnimationController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(
              0,
              30 * (1 - _statsAnimationController.value),
            ),
            child: Opacity(
              opacity: _statsAnimationController.value,
              child: Transform.translate(
                offset: const Offset(0, -20), // Reduced negative offset
                child: Container(
                  decoration: const BoxDecoration(
                    color: BauhausDesign.backgroundLight,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 10), // Reduced top padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.businessOverview,
                          style: BauhausDesign.getTextTheme(context)
                              .titleMedium
                              ?.copyWith(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: BauhausDesign.neutral,
                                letterSpacing: -0.5,
                              ),
                        ),
                        const SizedBox(height: BauhausDesign.space1),
                        Text(
                          AppLocalizations.of(context)!.businessOverviewDesc,
                          style: BauhausDesign.getTextTheme(context)
                              .bodyMedium
                              ?.copyWith(
                                color: BauhausDesign.neutral,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        const SizedBox(height: BauhausDesign.space6),
                        SizedBox(
                          height: 150,
                          child: ListView(
                            clipBehavior: Clip.none,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            children: [
                              _buildEnhancedStatsCard(
                                Icons.business_center_rounded,
                                businessStats['activeBusinesses']?.toString() ??
                                    '0',
                                AppLocalizations.of(context)!.activeBusinesses,
                                BauhausDesign.primary,
                                0,
                              ),
                              _buildEnhancedStatsCard(
                                Icons.people_rounded,
                                businessStats['totalClients']?.toString() ??
                                    '0',
                                AppLocalizations.of(context)!.totalClients,
                                BauhausDesign.success,
                                1,
                              ),
                              _buildEnhancedStatsCard(
                                Icons.receipt_long_rounded,
                                businessStats['totalInvoices']?.toString() ??
                                    '0',
                                AppLocalizations.of(context)!.invoicesGenerated,
                                BauhausDesign.secondary,
                                2,
                              ),
                              _buildEnhancedStatsCard(
                                Icons.trending_up_rounded,
                                businessStats['totalRevenue']?.toString() ??
                                    '\$0.00',
                                AppLocalizations.of(context)!.totalRevenue,
                                BauhausDesign.warning,
                                3,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEnhancedStatsCard(
    IconData icon,
    String value,
    String title,
    Color color,
    int index,
  ) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        borderRadius: BorderRadius.circular(
            BauhausDesign.radiusMd), // Less rounded for Bauhaus
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [
          BauhausDesign.shadowHard,
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color, // Solid color
                borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                border: Border.all(color: BauhausDesign.neutral, width: 1.5),
                boxShadow: const [
                  BauhausDesign.shadowHardSm,
                ],
              ),
              child: Icon(icon,
                  color: BauhausDesign.surfaceLight, size: 18), // White icon
            ),
            const SizedBox(height: BauhausDesign.space2),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      value,
                      style: BauhausDesign.getTextTheme(context)
                          .titleMedium
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: BauhausDesign.neutral, // High contrast
                            letterSpacing: -0.5,
                          ),
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: BauhausDesign.getTextTheme(context)
                        .labelSmall
                        ?.copyWith(
                          color: BauhausDesign.neutral,
                          height: 1.1,
                          fontWeight: FontWeight.w600,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    )
        .animate(delay: (index * 150).ms)
        .scale(begin: const Offset(0.8, 0.8), curve: Curves.easeOutQuart)
        .fadeIn(duration: 600.ms, curve: Curves.easeOutQuart);
  }

  Widget _buildFeaturedActionsSliver() {
    return SliverToBoxAdapter(
      child: AnimatedBuilder(
        animation: _contentAnimationController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(
              0,
              20 * (1 - _contentAnimationController.value) - 16,
            ),
            child: Opacity(
              opacity: _contentAnimationController.value,
              child: Container(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.getStarted,
                      style: BauhausDesign.getTextTheme(context)
                          .titleMedium
                          ?.copyWith(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: BauhausDesign.textDark,
                            letterSpacing: -0.5,
                          ),
                    ),
                    const SizedBox(height: BauhausDesign.space1),
                    Text(
                      AppLocalizations.of(context)!.getStartedDesc,
                      style: BauhausDesign.getTextTheme(context)
                          .bodyMedium
                          ?.copyWith(
                            color: BauhausDesign.neutral,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(height: BauhausDesign.space8),
                    Row(
                      children: [
                        Expanded(
                          child: HomeDetailCard(
                            buttonLabel:
                                AppLocalizations.of(context)!.addClientButton,
                            cardLabel:
                                AppLocalizations.of(context)!.knowYourClient,
                            image: Image.asset(
                              AssetsStrings.cardImageGirl,
                              fit: BoxFit.contain,
                            ),
                            gradientStartColor: BauhausDesign
                                .secondary, // Solid color by matching start/end
                            gradientEndColor: BauhausDesign.secondary,
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddClientDetails(),
                              ),
                            ),
                          )
                              .animate()
                              .scale(
                                begin: const Offset(0.9, 0.9),
                                curve: Curves.easeOutBack,
                                duration: 800.ms,
                              )
                              .fadeIn(duration: 600.ms),
                        ),
                        const SizedBox(width: BauhausDesign.space6),
                        Expanded(
                          child: HomeDetailCard(
                            buttonLabel:
                                AppLocalizations.of(context)!.addBusinessButton,
                            cardLabel:
                                AppLocalizations.of(context)!.knowYourBusiness,
                            image: Image.asset(
                              AssetsStrings.cardImageBoy,
                              fit: BoxFit.contain,
                            ),
                            gradientStartColor: BauhausDesign.primary,
                            gradientEndColor: BauhausDesign.primary,
                            onPressed: () => Navigator.pushNamed(
                              context,
                              Routes.addBusinessDetails,
                            ),
                          )
                              .animate(delay: 200.ms)
                              .scale(
                                begin: const Offset(0.9, 0.9),
                                curve: Curves.easeOutBack,
                                duration: 800.ms,
                              )
                              .fadeIn(duration: 600.ms),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildQuickActionsSliver() {
    return SliverToBoxAdapter(
      child: AnimatedBuilder(
        animation: _contentAnimationController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(
              0,
              30 * (1 - _contentAnimationController.value),
            ),
            child: Opacity(
              opacity: _contentAnimationController.value,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BauhausSectionHeader(
                      title: AppLocalizations.of(context)!.quickActions,
                      subtitle: AppLocalizations.of(context)!.quickActionsDesc,
                    ),
                    const SizedBox(height: BauhausDesign.space6),

                    // Invoice Management Section - Bauhaus Grid
                    BauhausInvoiceGrid(
                      onGenerateInvoice: _navigateToEmployeeSelection,
                      onEmployeeInvoice: _navigateToEmployeeInvoice,
                      onAllInvoices: _navigateToAutomaticInvoiceGeneration,
                      onEnhancedInvoice: _navigateToEnhancedInvoice,
                      onInvoiceList: _navigateToInvoiceList,
                    ),

                    const SizedBox(height: BauhausDesign.space6),

                    // Training & Compliance Section
                    _buildActionCategorySection(
                      AppLocalizations.of(context)!.trainingCompliance,
                      [
                        BauhausActionTile(
                          icon: const Icon(Icons.verified_user),
                          title:
                              AppLocalizations.of(context)!.auditCertifications,
                          subtitle: AppLocalizations.of(context)!
                              .auditCertificationsDesc,
                          color: BauhausDesign.warning,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    const AdminCertificationAuditView()),
                          ),
                        ),
                        BauhausActionTile(
                          icon: Image.asset(
                              'assets/icons/3D Icons/3dicons-mail-dynamic-color.png'),
                          title: AppLocalizations.of(context)!.manageTraining,
                          subtitle:
                              AppLocalizations.of(context)!.manageTrainingDesc,
                          color: BauhausDesign.secondary,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    const AdminTrainingManagementView()),
                          ),
                        ),
                        BauhausActionTile(
                          icon: Image.asset(
                              'assets/icons/3D Icons/3dicons-calendar-dynamic-color.png'),
                          title: AppLocalizations.of(context)!
                              .complianceChecklists,
                          subtitle: AppLocalizations.of(context)!
                              .complianceChecklistsDesc,
                          color: BauhausDesign.primary,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    const AdminComplianceManagementView()),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: BauhausDesign.space6),

                    // Organization Management Section
                    _buildActionCategorySection(
                      AppLocalizations.of(context)!.organizationManagement,
                      [
                        BauhausActionTile(
                          icon: const Icon(Icons.calendar_month_rounded),
                          title: AppLocalizations.of(context)!.scheduleTitle,
                          subtitle: 'Manage shifts and assignments',
                          color: BauhausDesign.secondary,
                          onTap: _navigateToScheduleDashboard,
                        ),
                        BauhausActionTile(
                          icon: const Icon(Icons.assignment_ind_rounded),
                          title:
                              AppLocalizations.of(context)!.requestsDashboard,
                          subtitle: AppLocalizations.of(context)!
                              .requestsDashboardDesc,
                          color: BauhausDesign.warning,
                          onTap: () =>
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamed(Routes.adminRequests),
                        ),
                        BauhausActionTile(
                          icon: Image.asset(
                              'assets/icons/3D Icons/3dicons-calendar-dynamic-color.png'),
                          title: AppLocalizations.of(context)!.holidayList,
                          subtitle:
                              AppLocalizations.of(context)!.holidayListDesc,
                          color: BauhausDesign.secondary,
                          onTap: () => _navigateToHolidayList(),
                        ),
                        BauhausActionTile(
                          icon: Image.asset(
                              'assets/icons/3D Icons/3dicons-tools-dynamic-color.png'),
                          title: AppLocalizations.of(context)!.viewAssignments,
                          subtitle:
                              AppLocalizations.of(context)!.viewAssignmentsDesc,
                          color: BauhausDesign.primary,
                          onTap: () => _navigateToAssignments(),
                        ),
                        BauhausActionTile(
                          icon: Image.asset(
                              'assets/icons/3D Icons/3dicons-clock-dynamic-color.png'),
                          title: AppLocalizations.of(context)!.employeeTracking,
                          subtitle: AppLocalizations.of(context)!
                              .employeeTrackingDesc,
                          color: BauhausDesign.primary,
                          onTap: () => _navigateToEmployeeTracking(),
                        ),
                        BauhausActionTile(
                          icon: const Icon(Icons.directions_car_filled_rounded),
                          title: AppLocalizations.of(context)!.mileageAdmin,
                          subtitle:
                              AppLocalizations.of(context)!.mileageAdminDesc,
                          color: BauhausDesign.secondary,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AdminMileageDashboard(),
                            ),
                          ),
                        ),
                        BauhausActionTile(
                          icon: const Icon(Icons.person_add_alt_1_rounded),
                          title: 'Onboarding', 
                          subtitle: 'Review pending onboardings',
                          color: BauhausDesign.primary,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AdminOnboardingListView(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: BauhausDesign.space6),

                    // Advanced Intelligence & Optimization Section
                    _buildActionCategorySection(
                      'ADVANCED INTELLIGENCE & OPTIMIZATION',
                      [
                        BauhausActionTile(
                          icon: const Icon(Icons.analytics_outlined),
                          title: 'Predictive Analytics',
                          subtitle: 'Worker churn, demand forecasts, and compliance risk predictions',
                          color: BauhausDesign.primary,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    const EnhancedPredictiveInsightsView()),
                          ),
                        ),
                        BauhausActionTile(
                          icon: const Icon(Icons.playlist_add_check),
                          title: 'Bulk Actions',
                          subtitle: 'Approve timesheets, generate invoices, assign shifts in bulk',
                          color: BauhausDesign.secondary,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const BulkActionsView()),
                          ),
                        ),
                        BauhausActionTile(
                          icon: const Icon(Icons.calendar_today_outlined),
                          title: 'Smart Scheduling',
                          subtitle: 'AI-powered shift matching and auto-scheduling with route optimization',
                          color: BauhausDesign.secondary,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => AutoScheduleDashboard(
                                      organizationId: widget.organizationId,
                                    )),
                          ),
                        ),
                        BauhausActionTile(
                          icon: const Icon(Icons.receipt_long_outlined),
                          title: 'Smart Invoicing',
                          subtitle: 'Auto-generate invoices with AI error detection and payment predictions',
                          color: BauhausDesign.primary,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => InvoiceAIDashboard(
                                      organizationId: widget.organizationId,
                                    )),
                          ),
                        ),
                        BauhausActionTile(
                          icon: const Icon(Icons.verified_user_outlined),
                          title: 'Compliance Automation',
                          subtitle: 'Automated compliance scanning and alerts',
                          color: BauhausDesign.success,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ComplianceAutomationDashboard(
                                      organizationId: widget.organizationId,
                                    )),
                          ),
                        ),
                        BauhausActionTile(
                          icon: const Icon(Icons.receipt_outlined),
                          title: 'Smart Expenses',
                          subtitle: 'Receipt scanning with AI categorization',
                          color: BauhausDesign.warning,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => SmartExpenseDashboard(
                                      organizationId: widget.organizationId,
                                    )),
                          ),
                        ),
                        BauhausActionTile(
                          icon: const Icon(Icons.payments_outlined),
                          title: 'Advanced Payroll',
                          subtitle: 'Smart payroll calculations with award rates and penalties',
                          color: BauhausDesign.success,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => AdvancedPayrollDashboard(
                                      organizationId: widget.organizationId,
                                      userId: widget.email,
                                    )),
                          ),
                        ),
                        BauhausActionTile(
                          icon: const Icon(Icons.forum_outlined),
                          title: 'Communication Hub',
                          subtitle: 'Multi-channel messaging with templates and broadcasts',
                          color: BauhausDesign.secondary,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => CommunicationHubDashboard(
                                      userId: widget.email,
                                    )),
                          ),
                        ),
                        BauhausActionTile(
                          icon: const Icon(Icons.real_estate_agent_outlined),
                          title: 'Real-Time Portal',
                          subtitle: 'Live tracking, secure messaging, and digital service confirmations',
                          color: BauhausDesign.accent,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    const RealtimePortalDashboard()),
                          ),
                        ),
                        BauhausActionTile(
                          icon: const Icon(Icons.analytics_outlined),
                          title: 'Workforce Optimization',
                          subtitle: 'AI-powered planning, analytics, and business intelligence',
                          color: BauhausDesign.secondary,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    const WorkforceOptimizationDashboard()),
                          ),
                        ),
                        BauhausActionTile(
                          icon: const Icon(Icons.psychology_outlined),
                          title: 'Care Intelligence',
                          subtitle: 'AI-powered risk prediction, care planning, and incident management',
                          color: BauhausDesign.primary,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    const CareIntelligenceDashboard()),
                          ),
                        ),
                        BauhausActionTile(
                          icon: const Icon(Icons.trending_up_rounded),
                          title: 'Financial Intelligence',
                          subtitle: 'AI-powered revenue forecasting, pricing optimization, and predictive analytics',
                          color: BauhausDesign.accent,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    const FinancialIntelligenceDashboard()),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: BauhausDesign.space6),

                    // Configuration & Finance Section
                    _buildActionCategorySection(
                      AppLocalizations.of(context)!.configFinance,
                      [
                        BauhausActionTile(
                          icon: const Icon(Icons.bar_chart_rounded),
                          title:
                              AppLocalizations.of(context)!.workforceAnalytics,
                          subtitle: AppLocalizations.of(context)!
                              .workforceAnalyticsDesc,
                          color: BauhausDesign.accent,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const AnalyticsDashboardView()),
                          ),
                        ),
                        BauhausActionTile(
                          icon: Image.asset(
                              'assets/icons/3D Icons/3dicons-mail-dynamic-color.png'),
                          title: AppLocalizations.of(context)!.emailSettings,
                          subtitle:
                              AppLocalizations.of(context)!.emailSettingsDesc,
                          color: BauhausDesign.error,
                          onTap: () => _navigateToEmailSettings(),
                        ),
                        BauhausActionTile(
                          icon: Image.asset(
                              'assets/icons/3D Icons/3dicons-money-dynamic-color.png'),
                          title:
                              AppLocalizations.of(context)!.pricingManagement,
                          subtitle: AppLocalizations.of(context)!
                              .pricingManagementDesc,
                          color: BauhausDesign.primary,
                          onTap: () => _navigateToPricingManagement(),
                        ),
                        BauhausActionTile(
                          icon: Image.asset(
                              'assets/icons/3D Icons/3dicons-money-dynamic-color.png'),
                          title: AppLocalizations.of(context)!.employeePayRates,
                          subtitle: AppLocalizations.of(context)!
                              .employeePayRatesDesc,
                          color: BauhausDesign.secondary,
                          onTap: () => _navigateToEmployeePayRates(),
                        ),
                        BauhausActionTile(
                          icon: Image.asset(
                              'assets/icons/3D Icons/3dicons-money-dynamic-color.png'),
                          title:
                              AppLocalizations.of(context)!.earningsDashboard,
                          subtitle: AppLocalizations.of(context)!
                              .earningsDashboardDesc,
                          color: BauhausDesign.success,
                          onTap: () => _navigateToEarningsDashboard(),
                        ),
                        BauhausActionTile(
                          icon: Image.asset(
                              'assets/icons/3D Icons/3dicons-credit-card-dynamic-premium.png'),
                          title:
                              AppLocalizations.of(context)!.expenseManagement,
                          subtitle: AppLocalizations.of(context)!
                              .expenseManagementDesc,
                          color: BauhausDesign.success,
                          onTap: () => _navigateToExpenseManagement(),
                        ),
                        BauhausActionTile(
                          icon: Image.asset(
                              'assets/icons/3D Icons/3dicons-money-dynamic-color.png'),
                          title: AppLocalizations.of(context)!.bankDetails,
                          subtitle:
                              AppLocalizations.of(context)!.bankDetailsDesc,
                          color: BauhausDesign.neutral,
                          onTap: () => _navigateToBankDetails(),
                        ),
                        BauhausActionTile(
                          icon: Image.asset(
                              'assets/icons/profile_placeholder.png'),
                          title:
                              AppLocalizations.of(context)!.clientPricingReview,
                          subtitle: AppLocalizations.of(context)!
                              .clientPricingReviewDesc,
                          color: BauhausDesign.success,
                          onTap: () => _navigateToClientPricingReview(),
                        ),
                        BauhausActionTile(
                          icon: const Icon(Icons.security_rounded),
                          title:
                              AppLocalizations.of(context)!.apiUsageDashboard,
                          subtitle: AppLocalizations.of(context)!
                              .apiUsageDashboardDesc,
                          color: BauhausDesign.primary,
                          onTap: _navigateToApiUsageDashboard,
                        ),
                        BauhausActionTile(
                          icon: const Icon(Icons.download_rounded),
                          title: 'Payroll Export',
                          subtitle: 'Export timesheets for payroll',
                          color: BauhausDesign.accent,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AdminPayrollExportView(
                                organizationId: widget.organizationId ?? '',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _navigateToBankDetails() async {
    await _sharedPrefs.init();
    final userRole = _sharedPrefs.getRole();
    if (userRole == UserRole.admin) {
      Navigator.of(context, rootNavigator: true).pushNamed(Routes.bankDetails);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.adminAccessRequiredTitle),
          content:
              Text(AppLocalizations.of(context)!.adminAccessRequiredMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)!.ok),
            ),
          ],
        ),
      );
    }
  }

  void _navigateToEarningsDashboard() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EarningsDashboardView(
          organizationId: widget.organizationId,
          organizationName: widget.organizationName,
        ),
      ),
    );
  }

  Widget _buildActionCategorySection(String title, List<Widget> actions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: BauhausDesign.textDark,
              ),
        ),
        const SizedBox(height: BauhausDesign.space4),
        ...actions,
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double scale = (screenWidth / 375.0).clamp(0.95, 1.25);
    final double tileRadius = (16.0 * scale).clamp(14.0, 20.0);
    // Use slightly larger container size for Material Icons vs Image Assets to maintain visual balance
    final double iconContainerSize = (64.0 * scale).clamp(56.0, 84.0);
    final double iconSize = (32.0 * scale).clamp(24.0, 40.0);
    final double chevronContainerSize = (32.0 * scale).clamp(28.0, 40.0);
    final double chevronIconSize = (20.0 * scale).clamp(18.0, 24.0);

    return Padding(
      padding: const EdgeInsets.only(bottom: BauhausDesign.space2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(tileRadius),
          child: Container(
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceLight,
              borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
              boxShadow: const [
                BauhausDesign.shadowHard,
              ],
              border: Border.all(
                color: BauhausDesign.neutral,
                width: 2,
              ),
            ),
            padding: EdgeInsets.symmetric(
                horizontal: 16 * scale, vertical: 14 * scale),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: iconContainerSize,
                  height: iconContainerSize,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                    border: Border.all(
                      color: BauhausDesign.neutral,
                      width: 1.5,
                    ),
                    boxShadow: const [
                      BauhausDesign.shadowHardSm,
                    ],
                  ),
                  child: Icon(
                    icon,
                    color: BauhausDesign.surfaceLight,
                    size: iconSize,
                  ),
                ),
                const SizedBox(width: BauhausDesign.space4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: BauhausDesign.getTextTheme(context)
                            .labelLarge
                            ?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: BauhausDesign.textDark,
                              letterSpacing: -0.5,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: BauhausDesign.getTextTheme(context)
                            .bodySmall
                            ?.copyWith(
                              color: BauhausDesign.neutral,
                              fontWeight: FontWeight.w500,
                              height: 1.25,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: BauhausDesign.space2),
                Container(
                  width: chevronContainerSize,
                  height: chevronContainerSize,
                  decoration: BoxDecoration(
                    color: BauhausDesign.backgroundLight,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                    border: Border.all(
                      color: BauhausDesign.neutral,
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    Icons.chevron_right_rounded,
                    color: BauhausDesign.neutral,
                    size: chevronIconSize,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageActionTile({
    required String asset,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double scale = (screenWidth / 375.0).clamp(0.95, 1.25);
    final double tileRadius = (16.0 * scale).clamp(14.0, 20.0);
    final double iconContainerSize = (64.0 * scale).clamp(56.0, 84.0);
    final double iconSize = (44.0 * scale).clamp(36.0, 56.0);
    final double chevronContainerSize = (32.0 * scale).clamp(28.0, 40.0);
    final double chevronIconSize = (20.0 * scale).clamp(18.0, 24.0);

    return Padding(
      padding: const EdgeInsets.only(bottom: BauhausDesign.space2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(tileRadius),
          child: Container(
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceLight,
              borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
              boxShadow: const [
                BauhausDesign.shadowHard,
              ],
              border: Border.all(
                color: BauhausDesign.neutral,
                width: 2,
              ),
            ),
            padding: EdgeInsets.symmetric(
                horizontal: 16 * scale, vertical: 14 * scale),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: iconContainerSize,
                  height: iconContainerSize,
                  decoration: BoxDecoration(
                    color: BauhausDesign.surfaceLight,
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                    border: Border.all(
                      color: BauhausDesign.neutral,
                      width: 1.5,
                    ),
                    boxShadow: const [
                      BauhausDesign.shadowHardSm,
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Image.asset(
                    asset,
                    width: iconSize,
                    height: iconSize,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.image_not_supported_outlined,
                        size: iconSize,
                        color: BauhausDesign.neutral,
                      );
                    },
                  ),
                ),
                const SizedBox(width: BauhausDesign.space4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: BauhausDesign.getTextTheme(context)
                            .labelLarge
                            ?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: BauhausDesign.textDark,
                              letterSpacing: -0.5,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: BauhausDesign.getTextTheme(context)
                            .bodySmall
                            ?.copyWith(
                              color: BauhausDesign.neutral,
                              fontWeight: FontWeight.w500,
                              height: 1.25,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: BauhausDesign.space2),
                Container(
                  width: chevronContainerSize,
                  height: chevronContainerSize,
                  decoration: BoxDecoration(
                    color: BauhausDesign.backgroundLight,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                    border: Border.all(
                      color: BauhausDesign.neutral,
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    Icons.chevron_right_rounded,
                    color: BauhausDesign.neutral,
                    size: chevronIconSize,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToScheduleDashboard() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScheduleDashboardScreen(
          organizationId: widget.organizationId ?? '',
          userEmail: widget.email,
          isAdmin: true,
        ),
      ),
    );
  }

  void _navigateToEmployeeSelection() {
    if (key != null && key != 'add' && key != 'error') {
      debugPrint("in employee selection");
      Navigator.of(context, rootNavigator: true).pushNamed(
        Routes.employeeSelection,
        arguments: {
          'email': widget.email,
          'organizationId': widget.organizationId!,
          'organizationName': widget.organizationName ?? '',
        },
      );
    } else {
      _showSnackBar(
        AppLocalizations.of(context)!.configureEmailSettingsFirst,
        isError: true,
      );
    }
  }

  void _navigateToEmployeeInvoice() {
    if (key != null && key != 'add' && key != 'error') {
      debugPrint("in employee invoice");
      Navigator.of(context, rootNavigator: true).pushNamed(
        Routes.employeeInvoice,
        arguments: {
          'email': widget.email,
          'organizationId': widget.organizationId!,
          'organizationName': widget.organizationName ?? '',
        },
      );
    } else {
      _showSnackBar(
        'Please configure Email Settings first.',
        isError: true,
      );
    }
  }

  void _navigateToAutomaticInvoiceGeneration() {
    if (key != null && key != 'add' && key != 'error') {
      debugPrint("in automatic invoice generation");
      Navigator.of(context, rootNavigator: true).pushNamed(
        Routes.automaticInvoiceGeneration,
        arguments: {
          'email': widget.email,
          'organizationId': widget.organizationId!,
          'organizationName': widget.organizationName ?? '',
          'autoMode': true,
          'invoiceType': 'both',
        },
      );
    } else {
      _showSnackBar(
        'Please configure Email Settings first.',
        isError: true,
      );
    }
  }

  void _navigateToEnhancedInvoice() {
    if (key != null && key != 'add' && key != 'error') {
      debugPrint("in enhanced invoice");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmployeeSelectionView(
            email: widget.email,
            organizationId: widget.organizationId,
            organizationName: widget.organizationName,
          ),
        ),
      );
    } else {
      _showSnackBar(
        'Please configure Email Settings first.',
        isError: true,
      );
    }
  }

  void _navigateToInvoiceList() {
    debugPrint("in invoice list");
    Navigator.of(context).pushNamed(
      Routes.invoiceList,
      arguments: {
        'organizationId': widget.organizationId,
        'userEmail': widget.email,
      },
    );
  }

  Future<void> _navigateToHolidayList() async {
    debugPrint("in holiday list");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (c) => const HolidayListView(
          holidays: [],
        ),
      ),
    );
  }

  void _navigateToAssignments() {
    final sharedPrefs = SharedPreferencesUtils();
    final userEmail = sharedPrefs.getString('userEmail');
    debugPrint(
        "Assigned client trigreed :\n\n$userEmail ${widget.email}\n\n${widget.organizationId}");
    Navigator.of(context).pushNamed(
      Routes.assignmentList,
      arguments: {
        'userEmail': widget.email,
        'organizationId': widget.organizationId,
        'organizationName': widget.organizationName,
        'organizationCode': widget.organizationCode,
      },
    );
  }

  void _navigateToEmployeeTracking() {
    debugPrint('🔍 DEBUG: Employee Tracking selected from Admin Dashboard');
    debugPrint('🔍 DEBUG: User Email: ${widget.email}');
    debugPrint('🔍 DEBUG: Organization ID: ${widget.organizationId}');
    debugPrint('🔍 DEBUG: Organization Name: ${widget.organizationName}');
    debugPrint('🔍 DEBUG: Navigating to EmployeeTrackingView...');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          debugPrint('🔍 DEBUG: EmployeeTrackingView builder called');
          return const EmployeeTrackingView();
        },
      ),
    ).then((result) {
      debugPrint(
          '🔍 DEBUG: Returned from EmployeeTrackingView with result: $result');
    });
  }

  Future<void> _navigateToEmailSettings() async {
    final currentKey = await _checkEmailKey(widget.email);
    if (currentKey == 'add' || currentKey == 'error') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddUpdateInvoicingEmailView(
            widget.email,
            currentKey,
            getInitialData['organizationName'] ?? 'Organization',
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (c) => InvoicingEmailView(
            widget.email,
            currentKey,
            getInitialData['organizationName'],
          ),
        ),
      );
    }
  }

  void _navigateToPricingManagement() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PricingManagementView(
          adminEmail: widget.email,
          organizationId: widget.organizationId,
          organizationName: widget.organizationName,
        ),
      ),
    );
  }

  void _navigateToEmployeePayRates() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmployeePayRateView(
          adminEmail: widget.email,
          organizationId: widget.organizationId ?? '',
        ),
      ),
    );
  }

  void _navigateToExpenseManagement() {
    debugPrint(
        '=== EXPENSE NAVIGATION DEBUG: adminEmail = ${widget.email} ===');
    debugPrint(
        '=== EXPENSE NAVIGATION DEBUG: organizationId = ${widget.organizationId} ===');
    debugPrint(
        '=== EXPENSE NAVIGATION DEBUG: organizationName = ${widget.organizationName} ===');
    debugPrint(
        '=== EXPENSE NAVIGATION DEBUG: organizationId is null? ${widget.organizationId == null} ===');
    debugPrint(
        '=== EXPENSE NAVIGATION DEBUG: organizationId is empty? ${widget.organizationId?.isEmpty ?? true} ===');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExpenseManagementView(
          adminEmail: widget.email,
          organizationId: widget.organizationId,
          organizationName: widget.organizationName,
        ),
      ),
    );
  }

  void _navigateToApiUsageDashboard() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ApiUsageDashboardView(),
      ),
    );
  }

  void _navigateToClientPricingReview() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClientPricingReviewView(
          organizationId: widget.organizationId ?? '',
          userEmail: widget.email,
        ),
      ),
    );
  }

  Widget _buildStickyAdminLabel() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 16,
      child: AnimatedBuilder(
        animation: _scrollController,
        builder: (context, child) {
          double opacity = 0.0;
          if (_scrollController.hasClients) {
            opacity = (_scrollController.offset > 200) ? 1.0 : 0.0;
          }
          return AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: opacity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 10,
                  sigmaY: 10,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: BauhausDesign.secondary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
                    border: Border.all(
                      color: BauhausDesign.surfaceWhite.withOpacity(0.1),
                      width: 1,
                    ),
                    boxShadow: const [...BauhausDesign.shadowSm],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: BauhausDesign.surfaceWhite.withOpacity(0.1),
                          borderRadius:
                              BorderRadius.circular(BauhausDesign.radiusMd),
                        ),
                        child: const Icon(
                          Icons.dashboard_rounded,
                          color: BauhausDesign.surfaceWhite,
                          size: 12,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Admin Dashboard',
                        style: BauhausDesign.getTextTheme(context)
                            .labelSmall
                            ?.copyWith(
                              color: BauhausDesign.surfaceWhite,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.1,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

String _getCurrentGreeting() {
  final hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Good Morning';
  } else if (hour < 17) {
    return 'Good Afternoon';
  } else {
    return 'Good Evening';
  }
}

Widget _buildQuickStat(
    BuildContext context, String label, String value, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: BauhausDesign.surfaceWhite.withOpacity(0.1),
      borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
      border: Border.all(
        color: BauhausDesign.surfaceWhite.withOpacity(0.1),
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: BauhausDesign.surfaceWhite,
          size: 14,
        ),
        const SizedBox(width: 6),
        Text(
          value,
          style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                color: BauhausDesign.surfaceWhite,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                color: BauhausDesign.surfaceWhite.withOpacity(0.8),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    ),
  );
}
