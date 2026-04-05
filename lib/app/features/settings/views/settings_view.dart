import 'dart:typed_data';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/auth/views/change_password_view.dart';
import 'package:carenest/app/features/auth/services/session_timeout_service.dart';
import 'package:carenest/app/features/organization/views/organization_details_view.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/services/firebase_auth_service.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

import 'package:carenest/app/features/security/views/api_usage_dashboard_view.dart';
import 'package:carenest/app/features/pricing/views/pricing_analytics_view.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:carenest/app/features/settings/views/date_format_settings_view.dart';
import 'package:carenest/app/features/photo/views/photo_upload_view.dart';
import 'package:carenest/app/features/feedback/views/feedback_form_view.dart';
import 'package:carenest/app/features/requests/models/request_model.dart';
import 'package:carenest/app/features/requests/repositories/request_repository.dart';
import 'package:carenest/app/shared/widgets/confirmation_alert_dialog_widget.dart';
import 'package:carenest/app/features/settings/widgets/bauhaus_settings_widgets.dart';
import 'package:carenest/config/environment.dart';

/// Modernized Settings View using Bauhaus Design System
class SettingsView extends ConsumerStatefulWidget {
  final String? organizationId;
  final String? organizationName;
  final String? organizationCode;
  final String userEmail;
  final String userName;
  final Uint8List? photoData;
  final String? imageUrl;
  final VoidCallback? onPhotoUpdated;

  const SettingsView({
    super.key,
    this.organizationId,
    this.organizationName,
    this.organizationCode,
    required this.userEmail,
    required this.userName,
    this.photoData,
    this.imageUrl,
    this.onPhotoUpdated,
  });

  @override
  ConsumerState<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView> {
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  // App version info
  String _version = '';
  String _buildNumber = '';
  // Local photo data to show immediate updates
  Uint8List? _currentPhotoData;
  bool _isEmailVerified = false;
  bool _isEmailVerificationLoading = false;
  bool _isDeletingAccount = false;

  @override
  void initState() {
    super.initState();
    _currentPhotoData = widget.photoData;
    _initPackageInfo();
    _isEmailVerified = _firebaseAuthService.currentUser?.emailVerified ?? false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshEmailVerificationStatus(showFeedback: false);
    });
  }

  // --- Owner-only secret gesture state ---
  int _secretTapCount = 0;
  DateTime? _lastTapTime;

  bool get _isOwner {
    final role = SharedPreferencesUtils().getRole();
    return role == UserRole.admin;
  }

  void _handleSecretTap() {
    final canOpenSecurityDashboard = !kReleaseMode && !AppConfig.isProduction;

    final now = DateTime.now();
    if (_lastTapTime == null ||
        now.difference(_lastTapTime!) > const Duration(seconds: 1)) {
      _secretTapCount = 0;
    }
    _lastTapTime = now;
    _secretTapCount++;

    if (_secretTapCount >= 7) {
      _secretTapCount = 0;
      if (_isOwner && canOpenSecurityDashboard) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ApiUsageDashboardView(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.restrictedOwnerOnly),
            behavior: SnackBarBehavior.floating,
            backgroundColor: BauhausDesign.error,
          ),
        );
      }
    }
  }

  Future<void> _initPackageInfo() async {
    try {
      final info = await PackageInfo.fromPlatform();
      if (!mounted) return;
      setState(() {
        _version = info.version;
        _buildNumber = info.buildNumber;
      });
    } catch (e) {
      // Fallback
    }
  }

  Future<void> _openEmployeeDashboardMode() async {
    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => PopScope(
        canPop: false,
        child: AlertDialog(
          backgroundColor: BauhausDesign.surfaceLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: const BorderSide(color: BauhausDesign.neutral, width: 2),
          ),
          content: Row(
            children: [
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: BauhausDesign.primary,
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
              Expanded(
                child: Text(
                  AppLocalizations.of(context)!.loadingDashboard,
                  style: BauhausDesign.getTextTheme(context)
                      .bodyMedium
                      ?.copyWith(color: BauhausDesign.textDark),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    try {
      final apiMethod = ref.read(apiMethodProvider);
      await apiMethod
          .getInitData(widget.userEmail)
          .timeout(const Duration(seconds: 8));
    } catch (e) {
      debugPrint('Employee dashboard warmup failed: $e');
    } finally {
      if (mounted && Navigator.of(context, rootNavigator: true).canPop()) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    }

    if (!mounted) return;
    Navigator.pushReplacementNamed(
      context,
      Routes.bottomNavBar,
      arguments: {
        'email': widget.userEmail,
        'role': UserRole.normal,
        'organizationId': widget.organizationId,
        'organizationName': widget.organizationName,
        'organizationCode': widget.organizationCode,
      },
    );
  }

  void _openAdminDashboardMode() {
    if (!mounted) return;
    Navigator.pushReplacementNamed(
      context,
      Routes.bottomNavBar,
      arguments: {
        'email': widget.userEmail,
        'role': UserRole.admin,
        'organizationId': widget.organizationId,
        'organizationName': widget.organizationName,
        'organizationCode': widget.organizationCode,
      },
    );
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (context) => ConfirmationAlertDialog(
        title: AppLocalizations.of(context)!.logoutConfirmTitle,
        content: AppLocalizations.of(context)!.logoutConfirmMessage,
        confirmText: AppLocalizations.of(context)!.logoutButton,
        confirmColor: BauhausDesign.error,
        confirmAction: () async {
          Navigator.pop(context);
          await _performLogout(context);
        },
      ),
    );
  }

  void _showDeleteAccountConfirmation() {
    showDialog(
      context: context,
      builder: (context) => ConfirmationAlertDialog(
        title: AppLocalizations.of(context)!.deleteAccountConfirmTitle,
        content: AppLocalizations.of(context)!.deleteAccountConfirmMessage,
        confirmText: AppLocalizations.of(context)!.deleteButton,
        confirmColor: BauhausDesign.error,
        confirmAction: () async {
          Navigator.pop(context);
          await _deleteAccount();
        },
      ),
    );
  }

  Future<void> _deleteAccount() async {
    if (_isDeletingAccount) return;

    setState(() {
      _isDeletingAccount = true;
    });

    try {
      final submitted = await _submitAccountDeletionRequest();
      if (!submitted || !mounted) return;
      _showSettingsSnackBar(
        'Deletion requested. You have been signed out. After approval, the account is deactivated and records required for payroll, tax, audit, and care obligations are retained for up to 90 days before permanent deletion.',
      );
      await Future.delayed(const Duration(milliseconds: 900));
      if (!mounted) return;
      await _performLogout(context);
    } catch (e) {
      _showSettingsSnackBar(
        'Failed to start account deletion: $e',
        isError: true,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isDeletingAccount = false;
        });
      }
    }
  }

  Future<bool> _submitAccountDeletionRequest() async {
    final currentUser = _firebaseAuthService.currentUser;
    final organizationId =
        widget.organizationId ?? ref.read(organizationIdProvider);

    if (currentUser == null ||
        organizationId == null ||
        organizationId.isEmpty) {
      if (!mounted) return false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.somethingWentWrong),
          behavior: SnackBarBehavior.floating,
          backgroundColor: BauhausDesign.error,
        ),
      );
      return false;
    }

    try {
      final request = RequestModel(
        organizationId: organizationId,
        userId: currentUser.uid,
        type: 'ACCOUNT_DELETION',
        status: RequestStatus.pending,
        details: {
          'reason':
              'User initiated account deletion from settings with 90-day retention',
          'email': widget.userEmail,
          'retentionDays': 90,
          'retentionReason':
              'Payroll, tax, audit, and care-service record obligations',
          'deactivateOnApproval': true,
          'requestedAt': DateTime.now().toIso8601String(),
        },
      );

      await ref
          .read(requestRepositoryProvider)
          .createRequest(request, widget.userEmail);
      return true;
    } catch (e) {
      _showSettingsSnackBar(
        'Failed to start account deletion: $e',
        isError: true,
      );
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userRole = ref.watch(userRoleProvider);
    final isClient = userRole == UserRole.client;
    final isProductionFlavor = AppConfig.isProduction;
    final showSecurityDashboard = !kReleaseMode && !isProductionFlavor;

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: BauhausSettingsHeader(
              title: AppLocalizations.of(context)!.settingsTitle,
            ),
          ),
          SliverToBoxAdapter(
            child: _buildUserProfileCard(),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: BauhausDesign.space4,
                vertical: BauhausDesign.space2,
              ),
              child: _buildQuickActionsStrip(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space4,
              vertical: BauhausDesign.space4,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  _buildSettingsSection(
                    title: AppLocalizations.of(context)!.accountSection,
                    items: [
                      _buildSettingsItem(
                        icon: Icons.person_outline,
                        color: BauhausDesign.primary,
                        title: AppLocalizations.of(context)!.profileSettings,
                        subtitle: AppLocalizations.of(context)!
                            .profileSettingsSubtitle,
                        onTap: () {
                          // TODO: Navigate to profile settings
                        },
                      ),
                      _buildSettingsItem(
                        icon: Icons.lock_outline,
                        color: BauhausDesign.success,
                        title: AppLocalizations.of(context)!.changePassword,
                        subtitle: AppLocalizations.of(context)!
                            .changePasswordSubtitle,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChangePasswordView(),
                            ),
                          );
                        },
                      ),
                      _buildSettingsItem(
                        icon: _isEmailVerified
                            ? Icons.verified_user_outlined
                            : Icons.mark_email_unread_outlined,
                        color: _isEmailVerified
                            ? BauhausDesign.success
                            : BauhausDesign.warning,
                        title: _isEmailVerified
                            ? 'Email verified'
                            : 'Verify email',
                        subtitle: _isEmailVerificationLoading
                            ? 'Checking verification status...'
                            : _isEmailVerified
                                ? 'Your email is verified'
                                : 'Send a verification link to your email',
                        onTap: _handleEmailVerificationAction,
                      ),
                    ],
                  ),
                  if (!isClient)
                    _buildSettingsSection(
                      title: AppLocalizations.of(context)!.teamSection,
                      items: [
                        _buildSettingsItem(
                          icon: Icons.groups_outlined,
                          color: BauhausDesign.info,
                          title:
                              AppLocalizations.of(context)!.teamDashboardTitle,
                          subtitle: AppLocalizations.of(context)!
                              .teamDashboardSubtitle,
                          onTap: () {
                            Navigator.pushNamed(context, Routes.teamDashboard);
                          },
                        ),
                      ],
                    ),
                  _buildSettingsSection(
                    title: AppLocalizations.of(context)!.organizationSection,
                    items: [
                      _buildSettingsItem(
                        icon: Icons.business_center_outlined,
                        color: BauhausDesign.secondary,
                        title:
                            AppLocalizations.of(context)!.organizationDetails,
                        subtitle: widget.organizationName ??
                            AppLocalizations.of(context)!.naLabel,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrganizationDetailsView(
                                organizationId: widget.organizationId,
                                organizationName: widget.organizationName,
                                organizationCode: widget.organizationCode,
                                userEmail: widget.userEmail,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  if (!isClient)
                    _buildSettingsSection(
                      title: AppLocalizations.of(context)!.workerSection,
                      items: [
                        if (!isProductionFlavor)
                          _buildSettingsItem(
                            icon: Icons.dashboard_outlined,
                            color: BauhausDesign.secondary,
                            title: AppLocalizations.of(context)!
                                .workerDashboardTitle,
                            subtitle: AppLocalizations.of(context)!
                                .workerDashboardSubtitle,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.workerDashboard);
                            },
                          ),
                        _buildSettingsItem(
                          icon: Icons.history_outlined,
                          color: BauhausDesign.primary,
                          title: AppLocalizations.of(context)!
                              .workerShiftHistoryTitle,
                          subtitle: AppLocalizations.of(context)!
                              .workerShiftHistorySubtitle,
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.workerShiftHistory);
                          },
                        ),
                      ],
                    ),
                  _buildSettingsSection(
                    title: AppLocalizations.of(context)!.appSettingsSection,
                    items: [
                      _buildSettingsItem(
                        icon: Icons.notifications_outlined,
                        color: BauhausDesign.warning,
                        title: AppLocalizations.of(context)!.notificationsTitle,
                        subtitle:
                            AppLocalizations.of(context)!.notificationsSubtitle,
                        onTap: () {
                          // TODO: Implement notification settings
                        },
                      ),
                      _buildSettingsItem(
                        icon: Icons.event_outlined,
                        color: BauhausDesign.primary,
                        title: AppLocalizations.of(context)!.dateFormatTitle,
                        subtitle:
                            AppLocalizations.of(context)!.dateFormatSubtitle,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const DateFormatSettingsView(),
                            ),
                          );
                        },
                      ),
                      _buildSettingsItem(
                        icon: Icons.palette_outlined,
                        color: BauhausDesign.info,
                        title: AppLocalizations.of(context)!.themeTitle,
                        subtitle: AppLocalizations.of(context)!.themeSubtitle,
                        onTap: () {
                          // TODO: Implement theme settings
                        },
                      ),
                      _buildSettingsItem(
                        icon: Icons.feedback_outlined,
                        color: BauhausDesign.accent,
                        title: AppLocalizations.of(context)?.feedbackTitle ??
                            'Submit Feedback',
                        subtitle:
                            AppLocalizations.of(context)?.feedbackSubtitle ??
                                'Report issues or suggestions',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FeedbackFormView(
                                userEmail: widget.userEmail,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  if (_isOwner)
                    _buildSettingsSection(
                      title: AppLocalizations.of(context)!.ownerToolsSection,
                      items: [
                        _buildSettingsItem(
                          icon: Icons.badge_outlined,
                          color: BauhausDesign.secondary,
                          title:
                              AppLocalizations.of(context)!.employeeOptionTitle,
                          subtitle: AppLocalizations.of(context)!
                              .employeeTrackingDesc,
                          onTap: _openEmployeeDashboardMode,
                        ),
                        _buildSettingsItem(
                          icon: Icons.admin_panel_settings_outlined,
                          color: BauhausDesign.primary,
                          title: AppLocalizations.of(context)!.adminDashboard,
                          subtitle: AppLocalizations.of(context)!
                              .adminDashboardSubtitle,
                          onTap: _openAdminDashboardMode,
                        ),
                        if (showSecurityDashboard)
                          _buildSettingsItem(
                            icon: Icons.shield_outlined,
                            color: BauhausDesign.success,
                            title:
                                AppLocalizations.of(context)!.securityDashboard,
                            subtitle: AppLocalizations.of(context)!
                                .securityDashboardSubtitle,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ApiUsageDashboardView(),
                                ),
                              );
                            },
                          ),
                        if ((widget.organizationId ?? '').isNotEmpty &&
                            (widget.organizationName ?? '').isNotEmpty)
                          _buildSettingsItem(
                            icon: Icons.trending_up_outlined,
                            color: BauhausDesign.secondary,
                            title:
                                AppLocalizations.of(context)!.pricingAnalytics,
                            subtitle: AppLocalizations.of(context)!
                                .pricingAnalyticsSubtitle,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PricingAnalyticsView(
                                    adminEmail: widget.userEmail,
                                    organizationId: widget.organizationId!,
                                    organizationName: widget.organizationName!,
                                  ),
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  _buildSettingsSection(
                    title: AppLocalizations.of(context)!.dangerZoneSection,
                    isDangerZone: true,
                    items: [
                      _buildSettingsItem(
                        icon: Icons.logout,
                        color: BauhausDesign.error,
                        title: AppLocalizations.of(context)!.logoutButton,
                        subtitle: AppLocalizations.of(context)!.logoutSubtitle,
                        onTap: _showLogoutConfirmation,
                      ),
                      _buildSettingsItem(
                        icon: Icons.delete_forever_outlined,
                        color: BauhausDesign.error,
                        title: AppLocalizations.of(context)!.deleteAccount,
                        subtitle:
                            AppLocalizations.of(context)!.deleteAccountSubtitle,
                        onTap: _showDeleteAccountConfirmation,
                      ),
                    ],
                  ),
                  const SizedBox(height: BauhausDesign.space4),
                  GestureDetector(
                    onTap: _handleSecretTap,
                    onLongPress: _handleSecretTap,
                    child: Text(
                      _version.isNotEmpty
                          ? (_buildNumber.isNotEmpty
                              ? AppLocalizations.of(context)!
                                  .versionWithBuild(_version, _buildNumber)
                              : '${AppLocalizations.of(context)!.versionLabel} $_version')
                          : AppLocalizations.of(context)!.versionLabel,
                      textAlign: TextAlign.center,
                      style: BauhausDesign.getTextTheme(context)
                          .bodySmall
                          ?.copyWith(
                            color: BauhausDesign.textMuted,
                          ),
                    ),
                  ),
                  const SizedBox(height: BauhausDesign.space8),
                ]
                    .animate(interval: 80.ms)
                    .fadeIn(duration: 400.ms, delay: 200.ms)
                    .slideY(
                        begin: 0.2, duration: 400.ms, curve: Curves.easeOut),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserProfileCard() {
    final photoState = ref.watch(photoDataProvider);
    final displayPhoto = photoState.photoData ?? _currentPhotoData;

    return BauhausProfileCard(
      userName: _resolveDisplayName(),
      userEmail: widget.userEmail,
      photoData: displayPhoto,
      imageUrl: widget.imageUrl,
      isEmailVerified: _isEmailVerified,
      onPhotoTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PhotoUploadScreen(
              email: widget.userEmail,
            ),
          ),
        );

        if (mounted) {
          ref
              .read(photoDataProvider.notifier)
              .fetchPhotoData(widget.userEmail, forceRefresh: true);
          if (widget.onPhotoUpdated != null) {
            widget.onPhotoUpdated!();
          }
        }
      },
    );
  }

  String _resolveDisplayName() {
    final explicitName = widget.userName.trim();
    if (explicitName.isNotEmpty) return explicitName;

    final firebaseName = _firebaseAuthService.currentUser?.displayName?.trim();
    if (firebaseName != null && firebaseName.isNotEmpty) return firebaseName;

    final emailPrefix = widget.userEmail.trim().split('@').first;
    return emailPrefix.isNotEmpty ? emailPrefix : 'User';
  }

  Widget _buildQuickActionsStrip() {
    return Row(
      children: [
        Expanded(
          child: _buildQuickActionButton(
            icon: Icons.business_center_outlined,
            label: 'ORG',
            color: BauhausDesign.secondary,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrganizationDetailsView(
                    organizationId: widget.organizationId,
                    organizationName: widget.organizationName,
                    organizationCode: widget.organizationCode,
                    userEmail: widget.userEmail,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: BauhausDesign.space3),
        Expanded(
          child: _buildQuickActionButton(
            icon: Icons.lock_outline,
            label: 'PASSWORD',
            color: BauhausDesign.success,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChangePasswordView(),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: BauhausDesign.space3),
        Expanded(
          child: _buildQuickActionButton(
            icon: Icons.logout,
            label: 'LOGOUT',
            color: BauhausDesign.error,
            onTap: _showLogoutConfirmation,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    final foregroundColor =
        ThemeData.estimateBrightnessForColor(color) == Brightness.dark
            ? BauhausDesign.textLight
            : BauhausDesign.textDark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: BauhausDesign.space3,
          horizontal: BauhausDesign.space2,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          border: Border.all(color: BauhausDesign.neutral, width: 2),
          boxShadow: const [BauhausDesign.shadowHardSm],
        ),
        child: Column(
          children: [
            Icon(icon, color: foregroundColor, size: 18),
            const SizedBox(height: 6),
            Text(
              label,
              style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                    color: foregroundColor,
                    letterSpacing: 0.6,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection({
    required String title,
    required List<Widget> items,
    bool isDangerZone = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BauhausSectionTitle(
          title: title,
          isDangerZone: isDangerZone,
        ),
        ...items,
      ],
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return BauhausSettingsTile(
      icon: icon,
      title: title,
      subtitle: subtitle,
      onTap: onTap,
      iconColor: color,
    );
  }

  Future<void> _performLogout(BuildContext context) async {
    final sharedPrefs = SharedPreferencesUtils();
    await SessionTimeoutService(sharedPrefs: sharedPrefs).logoutAndClearSession(
      reason: 'manual_logout_from_settings',
    );
    if (!mounted) return;

    Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
      Routes.login,
      (route) => false,
    );
  }

  Future<void> _handleEmailVerificationAction() async {
    if (_isEmailVerificationLoading) return;

    setState(() {
      _isEmailVerificationLoading = true;
    });

    try {
      await _firebaseAuthService.reloadUser();
      final user = _firebaseAuthService.currentUser;

      if (user == null) {
        _showSettingsSnackBar(
          'Please sign in again to manage email verification.',
          isError: true,
        );
        return;
      }

      final signedInEmail = user.email?.trim().toLowerCase();
      final targetEmail = widget.userEmail.trim().toLowerCase();
      if (signedInEmail == null || signedInEmail != targetEmail) {
        _showSettingsSnackBar(
          'Signed-in account does not match this profile. Please sign in again.',
          isError: true,
        );
        return;
      }

      if (user.emailVerified) {
        if (mounted) {
          setState(() {
            _isEmailVerified = true;
          });
        }
        await _syncEmailVerificationToBackend(user.uid);
        _showSettingsSnackBar('Email is already verified.');
        return;
      }

      try {
        await _firebaseAuthService.sendEmailVerification();
        _showSettingsSnackBar(
          'Verification link sent. Open the link from your email.',
        );
      } catch (_) {
        final apiMethod = ref.read(apiMethodProvider);
        final response =
            await apiMethod.resendEmailVerificationOtp(targetEmail);
        final isSuccess =
            response['success'] == true || response['statusCode'] == 200;

        if (!isSuccess) {
          final message = response['message']?.toString() ??
              'Failed to send verification link.';
          _showSettingsSnackBar(message, isError: true);
          return;
        }

        _showSettingsSnackBar(
          response['message']?.toString() ??
              'Verification link sent. Open the link from your email.',
        );
      }
    } catch (e) {
      _showSettingsSnackBar('Failed to send verification link: $e',
          isError: true);
    } finally {
      if (mounted) {
        setState(() {
          _isEmailVerificationLoading = false;
        });
      }
    }
  }

  Future<void> _refreshEmailVerificationStatus(
      {bool showFeedback = true}) async {
    if (_isEmailVerificationLoading) return;

    setState(() {
      _isEmailVerificationLoading = true;
    });

    try {
      await _firebaseAuthService.reloadUser();
      final user = _firebaseAuthService.currentUser;

      if (user == null) {
        if (showFeedback) {
          _showSettingsSnackBar('Please sign in again to verify your email.',
              isError: true);
        }
        return;
      }

      if (mounted) {
        setState(() {
          _isEmailVerified = user.emailVerified;
        });
      }

      if (user.emailVerified) {
        await _syncEmailVerificationToBackend(user.uid);
        if (showFeedback) {
          _showSettingsSnackBar('Email verified successfully.');
        }
      } else if (showFeedback) {
        _showSettingsSnackBar(
          'Email is not verified yet. Request a verification link and open it from your inbox.',
        );
      }
    } catch (e) {
      if (showFeedback) {
        _showSettingsSnackBar('Failed to check email verification: $e',
            isError: true);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isEmailVerificationLoading = false;
        });
      }
    }
  }

  Future<void> _syncEmailVerificationToBackend(String firebaseUid) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      final response =
          await apiMethod.syncEmailVerificationStatus(firebaseUid: firebaseUid);
      if (response['success'] != true) {
        debugPrint(
            'Email verification sync skipped/failed: ${response['message']}');
      }
    } catch (e) {
      debugPrint('Email verification sync exception: $e');
    }
  }

  void _showSettingsSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: isError ? BauhausDesign.error : BauhausDesign.success,
      ),
    );
  }
}
