import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/busineess/views/add_business_details_view.dart';
import 'package:carenest/app/features/client/views/add_client_details_view.dart';
import 'package:carenest/app/features/holiday/views/holiday_list_view.dart';
import 'package:carenest/app/shared/constants/values/strings/asset_strings.dart';
import 'package:carenest/app/features/invoice/models/invoicing_email_model.dart';
import 'package:carenest/app/features/invoice/views/add_update_invoice_email_view.dart';
import 'package:carenest/app/features/invoice/views/invoice_email_view.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/shared/design_system/modern_saas_design_system.dart';
import 'package:carenest/app/shared/widgets/profile_image_widget.dart';
import 'package:carenest/app/shared/widgets/home-detail-card-widget.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/features/employee_tracking/views/employee_tracking_view.dart';
import 'package:carenest/app/features/notifications/providers/notification_provider.dart';
import 'package:carenest/app/features/notifications/views/notification_list_view.dart';
import 'package:carenest/app/features/pricing/views/pricing_management_view.dart';
import 'package:carenest/app/features/expenses/views/expense_management_view.dart';
import 'package:carenest/app/features/invoice/views/enhanced_invoice_generation_view.dart';
import 'package:carenest/app/features/invoice/views/employee_selection_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:carenest/app/features/security/views/api_usage_dashboard_view.dart';

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
  final ApiMethod _apiMethod = ApiMethod();
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

    // Debug prints to track organizationId in AdminDashboardView
    debugPrint('=== ADMIN DASHBOARD DEBUG: email = ${widget.email} ===');
    debugPrint(
        '=== ADMIN DASHBOARD DEBUG: organizationId = ${widget.organizationId} ===');
    debugPrint(
        '=== ADMIN DASHBOARD DEBUG: organizationName = ${widget.organizationName} ===');
    debugPrint(
        '=== ADMIN DASHBOARD DEBUG: organizationCode = ${widget.organizationCode} ===');

    _initializeAnimations();
    _fetchInitialData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize notifications after the widget is built
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

      // Fetch business statistics if organizationId is available
      Map<String, dynamic> stats = {};
      String? statsError;

      if (widget.organizationId != null && widget.organizationId!.isNotEmpty) {
        try {
          final response =
              await _apiMethod.getInvoiceStats(widget.organizationId!);
          debugPrint(
              '=== ADMIN DASHBOARD DEBUG: Business stats response: $response ===');

          // Extract data from the nested response structure
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
          debugPrint('=== ADMIN DASHBOARD DEBUG: Extracted stats: $stats ===');
        } catch (e) {
          debugPrint(
              '=== ADMIN DASHBOARD DEBUG: Error fetching business stats: $e ===');
          statsError = 'Failed to load business statistics';
          // Use default values if API call fails
          stats = {
            'activeBusinesses': 0,
            'totalClients': 0,
            'totalInvoices': 0,
            'totalRevenue': '\$0.00'
          };
        }
      } else {
        // No organization ID available
        statsError = 'Organization ID not available';
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

// Start animations after data is loaded
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
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        backgroundColor:
            isError ? const Color(0xFFDC2626) : const Color(0xFF059669),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(20),
        elevation: 8,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: AppColors.colorWhite,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF667EEA),
                      Color(0xFF764BA2),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF667EEA).withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 3,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Loading Dashboard...',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              _buildEnhancedHeaderSliver(),
              _buildStatsOverviewSliver(),
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
    return SliverAppBar(
      expandedHeight: 240.0, // Reduced from 320 to 240
      pinned: false,
      floating: false,
      backgroundColor: AppColors.colorTransparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: AnimatedBuilder(
          animation: _headerAnimationController,
          builder: (context, child) {
            return Stack(
              children: [
                // Modern gradient background with better colors
                Transform.translate(
                  offset: Offset(
                    0,
                    20 * (1 - _headerAnimationController.value),
                  ),
                  child: Opacity(
                    opacity: _headerAnimationController.value,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF1E293B), // Slate 800
                            const Color(0xFF334155), // Slate 700
                            const Color(0xFF475569), // Slate 600
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF3B82F6)
                                  .withValues(alpha: 0.1), // Blue accent
                              Colors.transparent,
                              const Color(0xFF06B6D4)
                                  .withValues(alpha: 0.05), // Cyan accent
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Functional animated elements - notification indicators
                AnimatedBuilder(
                  animation: _headerAnimationController,
                  builder: (context, child) {
                    return Positioned(
                      top: 60,
                      right: 24,
                      child: Transform.scale(
                        scale: _headerAnimationController.value,
                        child: Opacity(
                          opacity: _headerAnimationController.value,
                          child: Row(
                            children: [
                              // Notification bell with dynamic indicator
                              Consumer(
                                builder: (context, ref, child) {
                                  final unreadCount = ref
                                      .watch(unreadNotificationCountProvider);
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
                                        color: hasUnread
                                            ? const Color(0xFFEF4444)
                                                .withValues(alpha: 0.2)
                                            : AppColors.colorWhite
                                                .withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: hasUnread
                                              ? const Color(0xFFEF4444)
                                                  .withValues(alpha: 0.3)
                                              : AppColors.colorWhite
                                                  .withValues(alpha: 0.2),
                                          width: hasUnread ? 1.5 : 1,
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Icon(
                                            hasUnread
                                                ? Icons.notifications_active
                                                : Icons.notifications_outlined,
                                            color: hasUnread
                                                ? const Color(0xFFEF4444)
                                                : const Color(0xFF10B981),
                                            size: 20,
                                          ),
                                          if (hasUnread)
                                            Positioned(
                                              top: 0,
                                              right: 0,
                                              child: Container(
                                                width: 8,
                                                height: 8,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFFEF4444),
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: AppColors.colorWhite,
                                                    width: 1,
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: const Color(
                                                              0xFFEF4444)
                                                          .withValues(
                                                              alpha: 0.5),
                                                      blurRadius: 4,
                                                      spreadRadius: 1,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          else
                                            Positioned(
                                              top: 0,
                                              right: 0,
                                              child: Container(
                                                width: 6,
                                                height: 6,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF10B981),
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: AppColors.colorWhite,
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
                              const SizedBox(width: 12),
                              // Settings gear
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.colorWhite
                                      .withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColors.colorWhite
                                        .withValues(alpha: 0.2),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.settings_outlined,
                                  color: AppColors.colorWhite,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

                // Main content with improved layout
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                        24, 20, 24, 40), // Reduced padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top section with profile and welcome
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
                                    // Enhanced profile photo with modern styling
                                    Hero(
                                      tag: 'profile_photo',
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFF3B82F6)
                                                  .withValues(alpha: 0.3),
                                              blurRadius: 20,
                                              spreadRadius: 2,
                                            ),
                                          ],
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: LinearGradient(
                                              colors: [
                                                const Color(0xFF3B82F6)
                                                    .withValues(alpha: 0.3),
                                                const Color(0xFF06B6D4)
                                                    .withValues(alpha: 0.2),
                                              ],
                                            ),
                                          ),
                                          child: AdminProfileImage(
                                            email: widget.email,
                                            photoData: photoDataState.photoData,
                                            size: 70,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Current time/date
                                          TweenAnimationBuilder<double>(
                                            duration: const Duration(
                                                milliseconds: 600),
                                            tween: Tween(begin: 0.0, end: 1.0),
                                            builder: (context, value, child) {
                                              return Transform.translate(
                                                offset:
                                                    Offset(0, 8 * (1 - value)),
                                                child: Opacity(
                                                  opacity: value,
                                                  child: Text(
                                                    _getCurrentGreeting(),
                                                    style: TextStyle(
                                                      color: AppColors
                                                          .colorWhite
                                                          .withValues(
                                                              alpha: 0.8),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          const SizedBox(height: 4),
                                          // User name with clean styling
                                          TweenAnimationBuilder<double>(
                                            duration: const Duration(
                                                milliseconds: 800),
                                            tween: Tween(begin: 0.0, end: 1.0),
                                            builder: (context, value, child) {
                                              return Transform.translate(
                                                offset:
                                                    Offset(0, 12 * (1 - value)),
                                                child: Opacity(
                                                  opacity: value,
                                                  child: Text(
                                                    '$firstName $lastName',
                                                    style: const TextStyle(
                                                      color:
                                                          AppColors.colorWhite,
                                                      fontSize: 28,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      letterSpacing: -0.5,
                                                      height: 1.1,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          const SizedBox(height: 8),
                                          // Quick stats row
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
                                                          'Active',
                                                          '12',
                                                          Icons.trending_up),
                                                      const SizedBox(width: 16),
                                                      _buildQuickStat('Pending',
                                                          '3', Icons.schedule),
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

                        // Modern admin badge with better functionality
                        AnimatedBuilder(
                          animation: _headerAnimationController,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(
                                0,
                                20 * (1 - _headerAnimationController.value),
                              ),
                              child: Opacity(
                                opacity: _headerAnimationController.value,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Admin status badge
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF10B981)
                                            .withValues(alpha: 0.2),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: const Color(0xFF10B981)
                                              .withValues(alpha: 0.3),
                                        ),
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
                                          const SizedBox(width: 8),
                                          const Text(
                                            'Admin Active',
                                            style: TextStyle(
                                              color: Color(0xFF10B981),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Quick action button
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF3B82F6),
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF3B82F6)
                                                .withValues(alpha: 0.3),
                                            blurRadius: 12,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.add_rounded,
                                        color: AppColors.colorWhite,
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
            );
          },
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
                offset: const Offset(0, -40), // Move up to connect with header
                child: ClipPath(
                  clipper: _StatsOverviewClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF667EEA).withValues(alpha: 0.05),
                          const Color(0xFF764BA2).withValues(alpha: 0.02),
                          Colors.white,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.0, 0.3, 1.0],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                          32, 60, 32, 10), // Increased top padding for curve
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Business Overview',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Track your business performance at a glance',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            height: 120,
                            child: ListView(
                              clipBehavior: Clip.none,
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              children: [
                                _buildEnhancedStatsCard(
                                  Icons.business_center_rounded,
                                  businessStats['activeBusinesses']
                                          ?.toString() ??
                                      '0',
                                  'Active Businesses',
                                  const Color(0xFF3B82F6),
                                  0,
                                ),
                                _buildEnhancedStatsCard(
                                  Icons.people_rounded,
                                  businessStats['totalClients']?.toString() ??
                                      '0',
                                  'Total Clients',
                                  const Color(0xFF10B981),
                                  1,
                                ),
                                _buildEnhancedStatsCard(
                                  Icons.receipt_long_rounded,
                                  businessStats['totalInvoices']?.toString() ??
                                      '0',
                                  'Invoices Generated',
                                  const Color(0xFF8B5CF6),
                                  2,
                                ),
                                _buildEnhancedStatsCard(
                                  Icons.trending_up_rounded,
                                  businessStats['totalRevenue']?.toString() ??
                                      '\$0.00',
                                  'Total Revenue',
                                  const Color(0xFFF59E0B),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: color.withValues(alpha: 0.1), width: 1),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    height: 1.1,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
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
// const SizedBox(height: 24),
                    const Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Set up your business and client information',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          child: HomeDetailCard(
                            buttonLabel: 'Add Client',
                            cardLabel: 'Know Your\nClient!',
                            image: Image.asset(
                              AssetsStrings.cardImageGirl,
                              fit: BoxFit.contain,
                            ),
                            gradientStartColor: const Color(0xFF667EEA),
                            gradientEndColor: const Color(0xFF764BA2),
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
                        const SizedBox(width: 24),
                        Expanded(
                          child: HomeDetailCard(
                            buttonLabel: 'Add Business',
                            cardLabel: 'Know Your\nBusiness!',
                            image: Image.asset(
                              AssetsStrings.cardImageBoy,
                              fit: BoxFit.contain,
                            ),
                            gradientStartColor: const Color(0xFF4FACFE),
                            gradientEndColor: const Color(0xFF00F2FE),
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
                    const Text(
                      'Quick Actions',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Manage your invoices and settings efficiently',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Invoice Management Section
                    _buildActionCategorySection(
                      'Invoice Management',
                      [
                        _buildImageActionTile(
                          asset:
                              'assets/icons/3D Icons/3dicons-file-text-dynamic-color.png',
                          title: 'Generate Invoice',
                          subtitle: 'Create new invoice for clients',
                          color: const Color(0xFFF59E0B),
                          onTap: () => _navigateToEmployeeSelection(),
                        ),
                        _buildImageActionTile(
                          asset: 'assets/icons/fav-folder-dynamic-premium.png',
                          title: 'All Invoices',
                          subtitle:
                              'Generate invoices for all users automatically',
                          color: const Color(0xFF10B981),
                          onTap: () => _navigateToAutomaticInvoiceGeneration(),
                        ),
                        _buildImageActionTile(
                          asset:
                              'assets/icons/3D Icons/3dicons-fire-dynamic-color.png',
                          title: 'Enhanced Invoice',
                          subtitle:
                              'Generate invoices with pricing integration',
                          color: const Color(0xFF3F51B5),
                          onTap: () => _navigateToEnhancedInvoice(),
                        ),
                        _buildImageActionTile(
                          asset:
                              'assets/icons/3D Icons/3dicons-locker-dynamic-premium.png',
                          title: 'Invoice List',
                          subtitle: 'View and manage generated invoices',
                          color: const Color(0xFF2563EB),
                          onTap: () => _navigateToInvoiceList(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Organization Management Section
                    _buildActionCategorySection(
                      'Organization Management',
                      [
                        _buildImageActionTile(
                          asset:
                              'assets/icons/3D Icons/3dicons-calendar-dynamic-color.png',
                          title: 'Holiday List',
                          subtitle: 'Manage company holidays',
                          color: ModernSaasDesign.adminPink,
                          onTap: () => _navigateToHolidayList(),
                        ),
                        _buildImageActionTile(
                          asset:
                              'assets/icons/3D Icons/3dicons-tools-dynamic-color.png',
                          title: 'View Assignments',
                          subtitle: 'View all employee assignments',
                          color: const Color(0xFF8B5CF6),
                          onTap: () => _navigateToAssignments(),
                        ),
                        _buildImageActionTile(
                          asset:
                              'assets/icons/3D Icons/3dicons-clock-dynamic-color.png',
                          title: 'Employee Tracking',
                          subtitle: 'Track employee work status & shifts',
                          color: const Color(0xFF06B6D4),
                          onTap: () => _navigateToEmployeeTracking(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Configuration & Finance Section
                    _buildActionCategorySection(
                      'Configuration & Finance',
                      [
                        _buildImageActionTile(
                          asset:
                              'assets/icons/3D Icons/3dicons-mail-dynamic-color.png',
                          title: 'Email Settings',
                          subtitle: 'Configure invoice email settings',
                          color: const Color(0xFFEF4444),
                          onTap: () => _navigateToEmailSettings(),
                        ),
                        _buildImageActionTile(
                          asset:
                              'assets/icons/3D Icons/3dicons-money-dynamic-color.png',
                          title: 'Pricing Management',
                          subtitle: 'Manage NDIS pricing & service rates',
                          color: const Color(0xFF9C27B0),
                          onTap: () => _navigateToPricingManagement(),
                        ),
                        _buildImageActionTile(
                          asset:
                              'assets/icons/3D Icons/3dicons-credit-card-dynamic-premium.png',
                          title: 'Expense Management',
                          subtitle: 'Track and manage organization expenses',
                          color: const Color(0xFF4CAF50),
                          onTap: () => _navigateToExpenseManagement(),
                        ),
                        _buildActionCard(
                          icon: Icons.security_rounded,
                          title: 'API Usage Dashboard',
                          subtitle:
                              'Monitor API traffic and errors in real-time',
                          color: ModernSaasDesign.primary,
                          onTap: _navigateToApiUsageDashboard,
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

  Widget _buildActionCategorySection(String title, List<Widget> actions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 16),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
              border: Border.all(
                color: color.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
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
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ModernSaasDesign.darkText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: color,
                  size: 20,
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
    // Responsive sizing based on device width
    final double screenWidth = MediaQuery.of(context).size.width;
    final double scale = (screenWidth / 375.0).clamp(0.95, 1.25);
    final double tileRadius = (16.0 * scale).clamp(14.0, 20.0);
    final double iconContainerSize = (64.0 * scale).clamp(56.0, 84.0);
    final double iconSize = (44.0 * scale).clamp(36.0, 56.0);
    final double chevronContainerSize = (32.0 * scale).clamp(28.0, 40.0);
    final double chevronIconSize = (20.0 * scale).clamp(18.0, 24.0);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(tileRadius),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(tileRadius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
              border: Border.all(
                color: color.withValues(alpha: 0.18),
                width: 1,
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
                    color: color.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(tileRadius),
                  ),
                  alignment: Alignment.center,
                  child: Image.asset(
                    asset,
                    width: iconSize,
                    height: iconSize,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF111827),
                          letterSpacing: -0.1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13.5,
                          color: Colors.grey[600],
                          height: 1.25,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: chevronContainerSize,
                  height: chevronContainerSize,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.chevron_right_rounded,
                    color: color,
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

  void _navigateToEmployeeSelection() {
    if (key != null && key != 'add' && key != 'error') {
      Navigator.of(context).pushNamed(
        Routes.employeeSelection,
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
      Navigator.of(context).pushNamed(
        Routes.automaticInvoiceGeneration,
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

  void _navigateToEnhancedInvoice() {
    if (key != null && key != 'add' && key != 'error') {
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
    Navigator.of(context).pushNamed(
      Routes.invoiceList,
      arguments: {
        'organizationId': widget.organizationId,
        'userEmail': widget.email,
      },
    );
  }

  Future<void> _navigateToHolidayList() async {
    try {
      List<dynamic>? holidays = await _apiMethod.getHolidays();
      if (holidays != null && holidays.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => HolidayListView(holidays: holidays),
          ),
        );
      } else {
        _showSnackBar(
          'No holiday data available.',
          isError: true,
        );
      }
    } catch (e) {
      _showSnackBar(
        'Failed to get holidays: $e',
        isError: true,
      );
    }
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

  Widget _build3DActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color primaryColor,
    required Color secondaryColor,
    required int index,
    required VoidCallback onTap,
  }) {
    return AnimatedBuilder(
      animation: _contentAnimationController,
      builder: (context, child) {
        final animationValue = _contentAnimationController.value;
        final staggeredDelay = (index * 0.1).clamp(0.0, 1.0);
        final cardAnimation =
            ((animationValue - staggeredDelay) / (1.0 - staggeredDelay))
                .clamp(0.0, 1.0);

        return Transform.translate(
          offset: Offset(0, 20 * (1 - cardAnimation)),
          child: Opacity(
            opacity: cardAnimation,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                height: MediaQuery.of(context).size.height *
                    0.20, // Increased height for better proportion
                constraints: BoxConstraints(
                  minHeight: 140, // Increased minimum height
                  maxHeight: MediaQuery.of(context).size.height *
                      0.22, // Reasonable maximum height
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: primaryColor.withValues(alpha: 0.08),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withValues(alpha: 0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width *
                      0.035), // Reduced padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Top section with icon and indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width *
                                0.11, // Slightly smaller icon container
                            height: MediaQuery.of(context).size.width * 0.11,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  primaryColor.withValues(alpha: 0.15),
                                  primaryColor.withValues(alpha: 0.08),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: primaryColor.withValues(alpha: 0.1),
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                icon,
                                color: primaryColor,
                                size: MediaQuery.of(context).size.width *
                                    0.055, // Proportional icon size
                              ),
                            ),
                          ),
                          Container(
                            width: 7,
                            height: 7,
                            decoration: BoxDecoration(
                              color: primaryColor.withValues(alpha: 0.6),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),

                      // Flexible spacer
                      Expanded(
                        child: SizedBox(),
                      ),

                      // Text section at bottom
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width *
                                  0.037, // Optimized font size
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF111827),
                              height: 1.1,
                              letterSpacing: -0.2,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  0.004), // Reduced spacing
                          Text(
                            subtitle,
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width *
                                  0.028, // Optimized subtitle size
                              color: const Color(0xFF6B7280),
                              height: 1.2,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.1,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
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
// Show sticky label when scrolled past the header
            opacity = (_scrollController.offset > 200) ? 1.0 : 0.0;
          }
          return AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: opacity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
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
                    color: const Color(0xFF6C5CE7).withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.dashboard_rounded,
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'Admin Dashboard',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
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

// You would add this class to the bottom of your AdminDashboardView.dart file
class _HeaderBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
// A 'Path' is like drawing with a pen on a canvas.
    final path = Path();
// 1. Start at the top-left corner (0, 0) - this is the default start point.

// 2. Draw a line down the left side, but stop a bit above the bottom edge.
// This creates the "shoulder" of the curve.
    path.lineTo(0, size.height - 60);

// 3. THIS IS THE KEY LINE FOR THE "SQUIRCLE" EFFECT.
// Instead of a sharp corner, we draw a quadratic Bézier curve.
    path.quadraticBezierTo(
      // The "control point" pulls the curve.
      // We place it at the horizontal center and vertical bottom of the widget.
      // This pulls the middle of the line downwards, creating a smooth arc.
      size.width / 2, // x-coordinate of control point (center)
      size.height, // y-coordinate of control point (very bottom)

      // The "end point" of the curve.
      // We end on the right side at the same height we started the curve.
      size.width, // x-coordinate of end point (far right)
      size.height - 40, // y-coordinate of end point (same as start of curve)
    );

// 4. Draw a line from the end of the curve up to the top-right corner.
    path.lineTo(size.width, 0);

// 5. Close the path, which automatically draws a line from the
// current point (top-right) back to the starting point (top-left).
    path.close();

    return path;
  }

// This should be false to prevent unnecessary re-clipping, which improves performance.
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _ModernFluidClipper extends CustomClipper<Path> {
  final double animationValue;
  _ModernFluidClipper({required this.animationValue});
  @override
  Path getClip(Size size) {
    final path = Path();
    final width = size.width;
    final height = size.height;
// Create a more dynamic, fluid shape that changes with animation
    final waveHeight = 40 + (20 * animationValue);
    final waveFrequency = 1.5 + (0.5 * animationValue);

    path.lineTo(0, height - waveHeight);

// Create multiple fluid waves
    for (double i = 0; i <= width; i += width / 4) {
      final progress = i / width;
      final waveOffset =
          sin(progress * pi * waveFrequency + animationValue * pi) *
              waveHeight *
              0.3;

      if (i == 0) {
        path.quadraticBezierTo(
          width * 0.25,
          height - waveHeight + waveOffset,
          width * 0.5,
          height - waveHeight * 0.7,
        );
      } else if (i == width / 2) {
        path.quadraticBezierTo(
          width * 0.75,
          height - waveHeight * 0.3 + waveOffset,
          width,
          height - waveHeight * 0.8,
        );
      }
    }

    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return oldClipper is _ModernFluidClipper &&
        oldClipper.animationValue != animationValue;
  }
}

// Enhanced Custom Clipper with more sophisticated curve
class _ModernHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
// Start from top-left
    path.lineTo(0, size.height - 60);

// Create a smooth wavy curve at the bottom
    path.quadraticBezierTo(
      size.width * 0.2,
      size.height - 10,
      size.width * 0.4,
      size.height - 30,
    );

    path.quadraticBezierTo(
      size.width * 0.6,
      size.height - 50,
      size.width * 0.8,
      size.height - 30,
    );

    path.quadraticBezierTo(
      size.width * 0.9,
      size.height - 20,
      size.width,
      size.height - 40,
    );

// Complete the path
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Custom Clipper for the stats overview section to match header curve
class _StatsOverviewClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
// Start from top with matching curve
    path.moveTo(0, 40);

    path.quadraticBezierTo(
      size.width * 0.1,
      20,
      size.width * 0.2,
      30,
    );

    path.quadraticBezierTo(
      size.width * 0.4,
      50,
      size.width * 0.6,
      30,
    );

    path.quadraticBezierTo(
      size.width * 0.8,
      10,
      size.width,
      40,
    );

// Complete the rectangle
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Helper method for greeting based on time
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

// Helper widget for quick stats
Widget _buildQuickStat(String label, String value, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.2),
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 14,
        ),
        const SizedBox(width: 6),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
