import 'dart:ui';
import 'dart:typed_data';

import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/features/client/views/add_client_details_view.dart';
import 'package:carenest/app/features/client/views/client_list_view.dart';
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
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:carenest/app/features/settings/views/settings_view.dart';
import 'package:carenest/app/features/security/views/api_usage_dashboard_view.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:carenest/app/features/admin/widgets/bauhaus_command_center.dart';
import 'package:carenest/app/features/admin/widgets/business_overview_sliver.dart';
import 'package:carenest/app/features/training_compliance/views/admin_certification_audit_view.dart';
import 'package:carenest/app/features/training_compliance/views/admin_certification_requirements_view.dart';
import 'package:carenest/app/features/training_compliance/views/admin_training_management_view.dart';
import 'package:carenest/app/features/training_compliance/views/admin_compliance_management_view.dart';
import 'package:carenest/app/features/analytics/views/analytics_dashboard_view.dart';
import 'package:carenest/app/features/admin/views/mileage/admin_mileage_dashboard.dart';
import 'package:carenest/app/features/schedule/views/schedule_dashboard_screen.dart';
import 'package:carenest/app/features/onboarding/views/admin/admin_onboarding_list_view.dart';
import 'package:carenest/app/features/admin/views/admin_feedback_feed_view.dart';

import 'package:carenest/app/features/timesheet/views/admin_payroll_export_view.dart';

// Phase 1-10 Advanced Features
import 'package:carenest/app/features/analytics/views/enhanced_predictive_insights_view.dart';
import 'package:carenest/app/features/bulk_actions/views/bulk_actions_view.dart';
import 'package:carenest/app/features/scheduling/views/auto_schedule_dashboard.dart';
import 'package:carenest/app/features/invoice/views/invoice_ai_dashboard.dart';
import 'package:carenest/app/features/compliance/views/compliance_automation_dashboard.dart';
import 'package:carenest/app/features/expenses/views/smart_expense_dashboard.dart';
import 'package:carenest/app/features/expenses/views/quick_expense_capture_view.dart';
import 'package:carenest/app/features/payroll/views/advanced_payroll_dashboard.dart';
import 'package:carenest/app/features/communication/views/communication_hub_dashboard.dart';
import 'package:carenest/app/features/realtime_portal/views/realtime_portal_dashboard.dart';
import 'package:carenest/app/features/workforce_optimization/views/workforce_optimization_dashboard.dart';
import 'package:carenest/app/features/care_intelligence/views/care_intelligence_dashboard.dart';
import 'package:carenest/app/features/financial_intelligence/views/financial_intelligence_dashboard.dart';
import 'package:carenest/config/environment.dart';

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
      await _sharedPrefs.init();
      final data = await _apiMethod.getInitData(widget.email);
      final emailKey = await _checkEmailKey(widget.email);
      final organizationId = _resolveOrganizationId(data);

      Map<String, dynamic> stats = _defaultBusinessStats();
      String? statsError;

      if (organizationId != null && organizationId.isNotEmpty) {
        try {
          final response = await _apiMethod.getInvoiceStats(organizationId);
          stats = _normalizeBusinessStats(response);
        } catch (e) {
          statsError = AppLocalizations.of(context)!.failedToLoadStats;
        }

        try {
          final businesses = await _apiMethod.getBusinesses(organizationId);
          if (businesses.isNotEmpty || _toInt(stats['activeBusinesses']) == 0) {
            stats['activeBusinesses'] = businesses.length;
          }
        } catch (_) {}

        try {
          final clients =
              await _apiMethod.getClientsByOrganizationId(organizationId);
          if (clients.isNotEmpty || _toInt(stats['totalClients']) == 0) {
            stats['totalClients'] = clients.length;
          }
        } catch (_) {}

        stats['activeBusinesses'] = _toInt(stats['activeBusinesses']);
        stats['totalClients'] = _toInt(stats['totalClients']);
        stats['totalInvoices'] = _toInt(stats['totalInvoices']);
        stats['totalRevenue'] = _formatRevenueDisplay(stats);
      } else {
        statsError = AppLocalizations.of(context)!.orgIdNotAvailable;
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

  String? _resolveOrganizationId(dynamic initData) {
    final widgetOrgId = widget.organizationId?.trim();
    if (widgetOrgId != null && widgetOrgId.isNotEmpty) return widgetOrgId;

    final prefsOrgId = _sharedPrefs.getOrganizationId()?.trim();
    if (prefsOrgId != null && prefsOrgId.isNotEmpty) return prefsOrgId;

    if (initData is Map<String, dynamic>) {
      final dynamic orgId = initData['organizationId'] ??
          initData['orgId'] ??
          (initData['data'] is Map<String, dynamic>
              ? (initData['data'] as Map<String, dynamic>)['organizationId']
              : null);
      final parsed = orgId?.toString().trim();
      if (parsed != null && parsed.isNotEmpty) return parsed;
    }
    return null;
  }

  Map<String, dynamic> _defaultBusinessStats() {
    return {
      'activeBusinesses': 0,
      'totalClients': 0,
      'totalInvoices': 0,
      'totalRevenue': '\$0.00',
      'rawRevenue': 0
    };
  }

  Map<String, dynamic> _normalizeBusinessStats(Map<String, dynamic> response) {
    final defaults = _defaultBusinessStats();
    if (response.isEmpty) return defaults;

    dynamic stats = response['data'];
    if (stats is Map<String, dynamic> &&
        stats['data'] is Map<String, dynamic>) {
      stats = stats['data'];
    }
    if (stats is! Map<String, dynamic>) return defaults;

    final normalized = <String, dynamic>{...defaults, ...stats};

    if (!normalized.containsKey('totalRevenue') &&
        normalized['totalAmount'] != null) {
      normalized['totalRevenue'] = normalized['totalAmount'];
    }
    if (!normalized.containsKey('rawRevenue') &&
        normalized['totalAmount'] != null) {
      normalized['rawRevenue'] = normalized['totalAmount'];
    }

    return normalized;
  }

  int _toInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  String _formatRevenueDisplay(Map<String, dynamic> stats) {
    final revenue = stats['totalRevenue'];
    if (revenue is String && revenue.trim().isNotEmpty) return revenue;
    final raw = stats['rawRevenue'];
    final numValue = raw is num
        ? raw.toDouble()
        : (revenue is num ? revenue.toDouble() : 0.0);
    return '\$${numValue.toStringAsFixed(2)}';
  }

  bool get _hasConfiguredInvoicingEmail {
    return key != null && key != 'add' && key != 'error';
  }

  Future<void> _showEmailSettingsRequiredSheet({
    required String workflowName,
  }) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Container(
              decoration: BoxDecoration(
                color: BauhausDesign.surfaceWhite,
                border: Border.all(
                  color: BauhausDesign.neutral,
                  width: 2,
                ),
                boxShadow: const [BauhausDesign.shadowHard],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: BauhausDesign.warning,
                              border: Border.all(
                                color: BauhausDesign.neutral,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              'SETUP REQUIRED',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    color: BauhausDesign.textDark,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1.1,
                                  ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: BauhausDesign.primary,
                            border: Border.all(
                              color: BauhausDesign.neutral,
                              width: 2,
                            ),
                            boxShadow: const [BauhausDesign.shadowHardSm],
                          ),
                          child: const Icon(
                            Icons.email_outlined,
                            color: BauhausDesign.surfaceWhite,
                            size: 26,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Complete email setup first',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w900,
                                color: BauhausDesign.textDark,
                                height: 1.05,
                              ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: BauhausDesign.backgroundLight,
                        border: Border.all(
                          color: BauhausDesign.neutral,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$workflowName needs your organization invoicing mailbox before the workflow can send invoices and delivery updates.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: BauhausDesign.textDark,
                                  fontWeight: FontWeight.w700,
                                  height: 1.35,
                                ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                margin: const EdgeInsets.only(top: 4),
                                decoration: BoxDecoration(
                                  color: BauhausDesign.accent,
                                  border: Border.all(
                                    color: BauhausDesign.neutral,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Next step: Configuration & Finance -> Email Settings',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w800,
                                        color: BauhausDesign.textMuted,
                                        height: 1.3,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 52,
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                Navigator.of(sheetContext).pop();
                                await _navigateToEmailSettings();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: BauhausDesign.primary,
                                foregroundColor: BauhausDesign.surfaceWhite,
                                elevation: 0,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                  side: BorderSide(
                                    color: BauhausDesign.neutral,
                                    width: 2,
                                  ),
                                ),
                              ),
                              icon: const Icon(Icons.settings_outlined),
                              label: const Text(
                                'SET UP NOW',
                                style: TextStyle(fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SizedBox(
                            height: 52,
                            child: OutlinedButton(
                              onPressed: () => Navigator.of(sheetContext).pop(),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: BauhausDesign.textDark,
                                side: const BorderSide(
                                  color: BauhausDesign.neutral,
                                  width: 2,
                                ),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                              child: const Text(
                                'LATER',
                                style: TextStyle(fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: BauhausDesign.success.withOpacity(0.08),
                        border: Border.all(
                          color: BauhausDesign.neutral,
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        'Once configured, this workflow unlocks immediately when you return.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: BauhausDesign.textDark,
                              fontWeight: FontWeight.w700,
                              height: 1.3,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
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

  void _openScanInvoice() {
    final orgId = widget.organizationId;
    if (orgId == null || orgId.isEmpty) {
      _showSnackBar('Organization ID is required', isError: true);
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuickExpenseCaptureView(
          adminEmail: widget.email,
          organizationId: orgId,
        ),
      ),
    );
  }

  void _openVoiceAssistant() {
    Navigator.pushNamed(context, Routes.voiceAssistant);
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
      floatingActionButton: FloatingActionButton(
        onPressed: _openVoiceAssistant,
        backgroundColor: BauhausDesign.primary,
        foregroundColor: BauhausDesign.surfaceWhite,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        tooltip: 'Voice Assistant',
        child: const Icon(Icons.keyboard_voice_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
    final apiFirstName = getInitialData['firstName']?.toString().trim() ?? '';
    final apiLastName = getInitialData['lastName']?.toString().trim() ?? '';
    final storedName = _sharedPrefs.getName()?.trim() ?? '';
    final displayName = '$apiFirstName $apiLastName'.trim().isNotEmpty
        ? '$apiFirstName $apiLastName'.trim()
        : (storedName.isNotEmpty ? storedName : 'Test User');
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
          child: SafeArea(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Greeting row with icons
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: TweenAnimationBuilder<double>(
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
                                                    style: BauhausDesign
                                                            .getTextTheme(
                                                                context)
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
                                        ),
                                        // Notification & Settings icons
                                        Transform.scale(
                                          scale:
                                              _headerAnimationController.value,
                                          child: Opacity(
                                            opacity: _headerAnimationController
                                                .value,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                GestureDetector(
                                                  onTap: _openScanInvoice,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      color: BauhausDesign
                                                          .surfaceWhite,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              BauhausDesign
                                                                  .radiusMd),
                                                      border: Border.all(
                                                        color: BauhausDesign
                                                            .neutral,
                                                        width: 2,
                                                      ),
                                                      boxShadow: const [
                                                        BauhausDesign
                                                            .shadowHardSm,
                                                      ],
                                                    ),
                                                    child: const Icon(
                                                      Icons
                                                          .document_scanner_outlined,
                                                      color:
                                                          BauhausDesign.neutral,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                    width:
                                                        BauhausDesign.space4),
                                                Consumer(
                                                  builder:
                                                      (context, ref, child) {
                                                    final unreadCount = ref.watch(
                                                        unreadNotificationCountProvider);
                                                    final hasUnread =
                                                        unreadCount > 0;

                                                    return GestureDetector(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                const NotificationListView(),
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: BauhausDesign
                                                              .surfaceWhite,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  BauhausDesign
                                                                      .radiusMd),
                                                          border: Border.all(
                                                            color: BauhausDesign
                                                                .neutral,
                                                            width: 2,
                                                          ),
                                                          boxShadow: const [
                                                            BauhausDesign
                                                                .shadowHardSm,
                                                          ],
                                                        ),
                                                        child: Stack(
                                                          children: [
                                                            Icon(
                                                              hasUnread
                                                                  ? Icons
                                                                      .notifications_active
                                                                  : Icons
                                                                      .notifications_outlined,
                                                              color:
                                                                  BauhausDesign
                                                                      .neutral,
                                                              size: 20,
                                                            ),
                                                            if (hasUnread)
                                                              Positioned(
                                                                top: 0,
                                                                right: 0,
                                                                child:
                                                                    Container(
                                                                  width: 10,
                                                                  height: 10,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: BauhausDesign
                                                                        .error,
                                                                    shape: BoxShape
                                                                        .rectangle,
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: BauhausDesign
                                                                          .neutral,
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
                                                const SizedBox(
                                                    width:
                                                        BauhausDesign.space4),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            SettingsView(
                                                          userEmail:
                                                              widget.email,
                                                          userName: displayName,
                                                          photoData:
                                                              photoDataState
                                                                  .photoData,
                                                          organizationId: widget
                                                              .organizationId,
                                                          organizationName: widget
                                                              .organizationName,
                                                          organizationCode: widget
                                                              .organizationCode,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      color: BauhausDesign
                                                          .surfaceWhite,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              BauhausDesign
                                                                  .radiusMd),
                                                      border: Border.all(
                                                        color: BauhausDesign
                                                            .neutral,
                                                        width: 2,
                                                      ),
                                                      boxShadow: const [
                                                        BauhausDesign
                                                            .shadowHardSm,
                                                      ],
                                                    ),
                                                    child: const Icon(
                                                      Icons.settings_outlined,
                                                      color:
                                                          BauhausDesign.neutral,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                        height: BauhausDesign.space1),
                                    TweenAnimationBuilder<double>(
                                      duration:
                                          const Duration(milliseconds: 800),
                                      tween: Tween(begin: 0.0, end: 1.0),
                                      builder: (context, value, child) {
                                        return Transform.translate(
                                          offset: Offset(0, 12 * (1 - value)),
                                          child: Opacity(
                                            opacity: value,
                                            child: Text(
                                              displayName,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: BauhausDesign.getTextTheme(
                                                      context)
                                                  .headlineMedium
                                                  ?.copyWith(
                                                    color: BauhausDesign
                                                        .surfaceWhite,
                                                    fontWeight: FontWeight.w700,
                                                    letterSpacing: -0.5,
                                                    height: 1.1,
                                                    fontSize:
                                                        isSmallScreen ? 24 : 32,
                                                  ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                        height: BauhausDesign.space2),
                                    TweenAnimationBuilder<double>(
                                      duration:
                                          const Duration(milliseconds: 1000),
                                      tween: Tween(begin: 0.0, end: 1.0),
                                      builder: (context, value, child) {
                                        return Transform.translate(
                                          offset: Offset(0, 15 * (1 - value)),
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
                                                    width:
                                                        BauhausDesign.space4),
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
                          (isSmallScreen ? 10 : 20) *
                              (1 - _headerAnimationController.value),
                        ),
                        child: Opacity(
                          opacity: _headerAnimationController.value,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        shape: BoxShape.rectangle,
                                        border: Border.all(
                                            color: BauhausDesign.neutral,
                                            width: 1),
                                      ),
                                    ),
                                    const SizedBox(width: BauhausDesign.space2),
                                    Text(
                                      AppLocalizations.of(context)!.adminActive,
                                      style: BauhausDesign.getTextTheme(context)
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
                    padding: const EdgeInsets.fromLTRB(
                        24, 20, 24, 10), // Reduced top padding
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
                            gradientStartColor: BauhausDesign.secondary,
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
    final l10n = AppLocalizations.of(context)!;
    final needsEmailSetup = !_hasConfiguredInvoicingEmail;

    final categories = <CommandCategory>[
      // Invoice Management
      CommandCategory(
        title: 'Invoice Operations',
        headerIcon: Icons.receipt_long_rounded,
        accentColor: BauhausDesign.primary,
        setupBannerTitle: needsEmailSetup
            ? 'Complete invoicing email setup to unlock this tab'
            : null,
        setupBannerSubtitle: needsEmailSetup
            ? 'Connect your organization mailbox once, then invoice creation, employee invoicing, and automatic delivery workflows will be ready to use.'
            : null,
        setupBannerActionLabel: needsEmailSetup ? 'SET UP NOW' : null,
        onSetupBannerTap: needsEmailSetup ? _navigateToEmailSettings : null,
        actions: [
          CommandAction(
            icon: const Icon(Icons.add_circle_outline_rounded),
            title: l10n.addClientButton,
            subtitle: needsEmailSetup
                ? 'Setup required: configure invoicing email first'
                : 'Generate invoice for selected employees',
            color: BauhausDesign.primary,
            onTap: _navigateToEmployeeSelection,
            statusLabel: needsEmailSetup ? 'SETUP' : null,
            statusColor: needsEmailSetup ? BauhausDesign.warning : null,
          ),
          CommandAction(
            icon: const Icon(Icons.person_outline_rounded),
            title: 'Employee Invoice',
            subtitle: needsEmailSetup
                ? 'Setup required: configure invoicing email first'
                : 'Individual employee invoicing',
            color: BauhausDesign.secondary,
            onTap: _navigateToEmployeeInvoice,
            statusLabel: needsEmailSetup ? 'SETUP' : null,
            statusColor: needsEmailSetup ? BauhausDesign.warning : null,
          ),
          CommandAction(
            icon: const Icon(Icons.auto_awesome_rounded),
            title: 'Auto Invoices',
            subtitle: needsEmailSetup
                ? 'Setup required: configure invoicing email first'
                : 'Automatic invoice generation',
            color: BauhausDesign.accent,
            onTap: _navigateToAutomaticInvoiceGeneration,
            statusLabel: needsEmailSetup ? 'SETUP' : null,
            statusColor: needsEmailSetup ? BauhausDesign.warning : null,
          ),
          CommandAction(
            icon: const Icon(Icons.dashboard_customize_rounded),
            title: 'Enhanced Invoice',
            subtitle: needsEmailSetup
                ? 'Setup required: configure invoicing email first'
                : 'Advanced invoicing features',
            color: BauhausDesign.success,
            onTap: _navigateToEnhancedInvoice,
            statusLabel: needsEmailSetup ? 'SETUP' : null,
            statusColor: needsEmailSetup ? BauhausDesign.warning : null,
          ),
          CommandAction(
            icon: const Icon(Icons.list_alt_rounded),
            title: 'Invoice List',
            subtitle: 'View all generated invoices',
            color: BauhausDesign.info,
            onTap: _navigateToInvoiceList,
          ),
        ],
      ),

      // Training & Compliance
      CommandCategory(
        title: l10n.trainingCompliance,
        headerIcon: Icons.school_rounded,
        accentColor: BauhausDesign.accent,
        actions: [
          CommandAction(
            icon: const Icon(Icons.verified_user),
            title: l10n.auditCertifications,
            subtitle: l10n.auditCertificationsDesc,
            color: BauhausDesign.warning,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const AdminCertificationAuditView()),
            ),
          ),
          CommandAction(
            icon: const Icon(Icons.rule_folder_rounded),
            title: 'Certification Requirements',
            subtitle: 'Manage required employee certifications',
            color: BauhausDesign.info,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const AdminCertificationRequirementsView()),
            ),
          ),
          CommandAction(
            icon: const Icon(Icons.model_training_rounded),
            title: l10n.manageTraining,
            subtitle: l10n.manageTrainingDesc,
            color: BauhausDesign.secondary,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const AdminTrainingManagementView()),
            ),
          ),
          CommandAction(
            icon: const Icon(Icons.checklist_rounded),
            title: l10n.complianceChecklists,
            subtitle: l10n.complianceChecklistsDesc,
            color: BauhausDesign.primary,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const AdminComplianceManagementView()),
            ),
          ),
        ],
      ),

      // Organization Management
      CommandCategory(
        title: l10n.organizationManagement,
        headerIcon: Icons.business_rounded,
        accentColor: BauhausDesign.secondary,
        actions: [
          CommandAction(
            icon: const Icon(Icons.calendar_month_rounded),
            title: l10n.scheduleTitle,
            subtitle: 'Manage shifts and assignments',
            color: BauhausDesign.secondary,
            onTap: _navigateToScheduleDashboard,
          ),
          CommandAction(
            icon: const Icon(Icons.assignment_ind_rounded),
            title: l10n.requestsDashboard,
            subtitle: l10n.requestsDashboardDesc,
            color: BauhausDesign.warning,
            onTap: () => Navigator.of(context, rootNavigator: true)
                .pushNamed(Routes.adminRequests),
          ),
          CommandAction(
            icon: const Icon(Icons.groups_rounded),
            title: 'Client List',
            subtitle: 'Manage clients, activation status, and setup emails',
            color: BauhausDesign.primary,
            onTap: _navigateToClientList,
          ),
          CommandAction(
            icon: const Icon(Icons.celebration_rounded),
            title: l10n.holidayList,
            subtitle: l10n.holidayListDesc,
            color: BauhausDesign.accent,
            onTap: () => _navigateToHolidayList(),
          ),
          CommandAction(
            icon: const Icon(Icons.work_outline_rounded),
            title: l10n.viewAssignments,
            subtitle: l10n.viewAssignmentsDesc,
            color: BauhausDesign.primary,
            onTap: () => _navigateToAssignments(),
          ),
          CommandAction(
            icon: const Icon(Icons.location_on_outlined),
            title: l10n.employeeTracking,
            subtitle: l10n.employeeTrackingDesc,
            color: BauhausDesign.info,
            onTap: () => _navigateToEmployeeTracking(),
          ),
          CommandAction(
            icon: const Icon(Icons.directions_car_filled_rounded),
            title: l10n.mileageAdmin,
            subtitle: l10n.mileageAdminDesc,
            color: BauhausDesign.secondary,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AdminMileageDashboard(),
              ),
            ),
          ),
          CommandAction(
            icon: const Icon(Icons.rate_review_outlined),
            title: 'Client Feedback',
            subtitle: 'View service ratings and comments',
            color: BauhausDesign.accent,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AdminFeedbackFeedView(),
              ),
            ),
          ),
          CommandAction(
            icon: const Icon(Icons.person_add_alt_1_rounded),
            title: 'Staff Onboarding',
            subtitle: 'Review pending employee onboardings',
            color: BauhausDesign.success,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AdminOnboardingListView(),
              ),
            ),
          ),
        ],
      ),

      // Advanced Intelligence & Optimization
      CommandCategory(
        title: 'Intelligence & Automation',
        headerIcon: Icons.psychology_rounded,
        accentColor: BauhausDesign.success,
        actions: [
          CommandAction(
            icon: const Icon(Icons.analytics_outlined),
            title: 'Predictive Analytics',
            subtitle: 'Churn, demand forecasts, compliance risk',
            color: BauhausDesign.primary,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const EnhancedPredictiveInsightsView()),
            ),
          ),
          CommandAction(
            icon: const Icon(Icons.playlist_add_check),
            title: 'Bulk Actions',
            subtitle: 'Mass approve, invoice, and assign',
            color: BauhausDesign.secondary,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BulkActionsView()),
            ),
          ),
          CommandAction(
            icon: const Icon(Icons.calendar_today_outlined),
            title: 'Smart Scheduling',
            subtitle: 'AI shift matching & route optimization',
            color: BauhausDesign.accent,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => AutoScheduleDashboard(
                        organizationId: widget.organizationId,
                      )),
            ),
          ),
          CommandAction(
            icon: const Icon(Icons.receipt_long_outlined),
            title: 'Smart Invoicing',
            subtitle: 'AI error detection & payment predictions',
            color: BauhausDesign.primary,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => InvoiceAIDashboard(
                        organizationId: widget.organizationId,
                      )),
            ),
          ),
          CommandAction(
            icon: const Icon(Icons.verified_user_outlined),
            title: 'Compliance Automation',
            subtitle: 'Automated scanning and alerts',
            color: BauhausDesign.success,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ComplianceAutomationDashboard(
                        organizationId: widget.organizationId,
                      )),
            ),
          ),
          CommandAction(
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
          CommandAction(
            icon: const Icon(Icons.document_scanner_outlined),
            title: 'Scan Invoice',
            subtitle: 'Quick receipt capture',
            color: BauhausDesign.warning,
            onTap: _openScanInvoice,
          ),
          CommandAction(
            icon: const Icon(Icons.payments_outlined),
            title: 'Advanced Payroll',
            subtitle: 'Award rates & penalty calculations',
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
          CommandAction(
            icon: const Icon(Icons.forum_outlined),
            title: 'Communication Hub',
            subtitle: 'Multi-channel messaging & broadcasts',
            color: BauhausDesign.secondary,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => CommunicationHubDashboard(
                        userId: widget.email,
                      )),
            ),
          ),
          CommandAction(
            icon: const Icon(Icons.keyboard_voice_outlined),
            title: 'Voice Assistant',
            subtitle: 'Hands-free commands for admin workflows',
            color: BauhausDesign.info,
            onTap: () => Navigator.pushNamed(context, Routes.voiceAssistant),
          ),
          CommandAction(
            icon: const Icon(Icons.real_estate_agent_outlined),
            title: 'Real-Time Portal',
            subtitle: 'Live tracking & service confirmations',
            color: BauhausDesign.accent,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const RealtimePortalDashboard()),
            ),
          ),
          CommandAction(
            icon: const Icon(Icons.insights_rounded),
            title: 'Workforce Optimization',
            subtitle: 'AI planning & business intelligence',
            color: BauhausDesign.secondary,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const WorkforceOptimizationDashboard()),
            ),
          ),
          CommandAction(
            icon: const Icon(Icons.psychology_outlined),
            title: 'Care Intelligence',
            subtitle: 'AI risk prediction & care planning',
            color: BauhausDesign.primary,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const CareIntelligenceDashboard()),
            ),
          ),
          CommandAction(
            icon: const Icon(Icons.trending_up_rounded),
            title: 'Financial Intelligence',
            subtitle: 'Revenue forecasting & pricing optimization',
            color: BauhausDesign.accent,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const FinancialIntelligenceDashboard()),
            ),
          ),
        ],
      ),

      // Configuration & Finance
      CommandCategory(
        title: l10n.configFinance,
        headerIcon: Icons.settings_rounded,
        accentColor: BauhausDesign.neutral,
        actions: [
          CommandAction(
            icon: const Icon(Icons.bar_chart_rounded),
            title: l10n.workforceAnalytics,
            subtitle: l10n.workforceAnalyticsDesc,
            color: BauhausDesign.accent,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AnalyticsDashboardView()),
            ),
          ),
          CommandAction(
            icon: const Icon(Icons.email_outlined),
            title: l10n.emailSettings,
            subtitle: l10n.emailSettingsDesc,
            color: BauhausDesign.error,
            onTap: () => _navigateToEmailSettings(),
          ),
          CommandAction(
            icon: const Icon(Icons.price_change_outlined),
            title: l10n.pricingManagement,
            subtitle: l10n.pricingManagementDesc,
            color: BauhausDesign.primary,
            onTap: () => _navigateToPricingManagement(),
          ),
          CommandAction(
            icon: const Icon(Icons.attach_money_rounded),
            title: l10n.employeePayRates,
            subtitle: l10n.employeePayRatesDesc,
            color: BauhausDesign.secondary,
            onTap: () => _navigateToEmployeePayRates(),
          ),
          CommandAction(
            icon: const Icon(Icons.account_balance_wallet_outlined),
            title: l10n.earningsDashboard,
            subtitle: l10n.earningsDashboardDesc,
            color: BauhausDesign.success,
            onTap: () => _navigateToEarningsDashboard(),
          ),
          CommandAction(
            icon: const Icon(Icons.credit_card_rounded),
            title: l10n.expenseManagement,
            subtitle: l10n.expenseManagementDesc,
            color: BauhausDesign.warning,
            onTap: () => _navigateToExpenseManagement(),
          ),
          CommandAction(
            icon: const Icon(Icons.account_balance_rounded),
            title: l10n.bankDetails,
            subtitle: l10n.bankDetailsDesc,
            color: BauhausDesign.neutral,
            onTap: () => _navigateToBankDetails(),
          ),
          CommandAction(
            icon: const Icon(Icons.rate_review_outlined),
            title: l10n.clientPricingReview,
            subtitle: l10n.clientPricingReviewDesc,
            color: BauhausDesign.success,
            onTap: () => _navigateToClientPricingReview(),
          ),
          if (!kReleaseMode && !AppConfig.isProduction)
            CommandAction(
              icon: const Icon(Icons.security_rounded),
              title: l10n.apiUsageDashboard,
              subtitle: l10n.apiUsageDashboardDesc,
              color: BauhausDesign.primary,
              onTap: _navigateToApiUsageDashboard,
            ),
          CommandAction(
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
    ];

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
                      title: 'Command Center',
                      subtitle: 'Use tabs to jump between admin workflows',
                    ),
                    const SizedBox(height: BauhausDesign.space6),
                    BauhausCommandCenter(categories: categories),
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
    if (_hasConfiguredInvoicingEmail) {
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
      _showEmailSettingsRequiredSheet(
        workflowName: AppLocalizations.of(context)!.addClientButton,
      );
    }
  }

  void _navigateToEmployeeInvoice() {
    if (_hasConfiguredInvoicingEmail) {
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
      _showEmailSettingsRequiredSheet(
        workflowName: 'Employee Invoice',
      );
    }
  }

  void _navigateToAutomaticInvoiceGeneration() {
    if (_hasConfiguredInvoicingEmail) {
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
      _showEmailSettingsRequiredSheet(
        workflowName: 'Auto Invoices',
      );
    }
  }

  void _navigateToEnhancedInvoice() {
    if (_hasConfiguredInvoicingEmail) {
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
      _showEmailSettingsRequiredSheet(
        workflowName: 'Enhanced Invoice',
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
      await Navigator.push(
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
      await Navigator.push(
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

    if (!mounted) return;
    final refreshedKey = await _checkEmailKey(widget.email);
    if (!mounted) return;
    setState(() {
      key = refreshedKey;
    });
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

  void _navigateToClientList() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ClientListView(),
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
