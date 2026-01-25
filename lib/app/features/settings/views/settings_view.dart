import 'dart:typed_data';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/auth/views/change_password_view.dart';
import 'package:carenest/app/features/organization/views/organization_details_view.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/shared/widgets/profile_image_widget.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

import 'package:carenest/app/features/admin/views/admin_dashboard_view.dart';
import 'package:carenest/app/features/security/views/api_usage_dashboard_view.dart';
import 'package:carenest/app/features/pricing/views/pricing_analytics_view.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:carenest/app/features/settings/views/date_format_settings_view.dart';
import 'package:carenest/app/features/photo/views/photo_upload_view.dart';
import 'package:carenest/app/features/feedback/views/feedback_form_view.dart';
import 'package:carenest/app/shared/widgets/confirmation_alert_dialog_widget.dart';

/// Modernized Settings View using Bauhaus Design System
class SettingsView extends ConsumerStatefulWidget {
  final String? organizationId;
  final String? organizationName;
  final String? organizationCode;
  final String userEmail;
  final String userName;
  final Uint8List? photoData;
  final VoidCallback? onPhotoUpdated;

  const SettingsView({
    super.key,
    this.organizationId,
    this.organizationName,
    this.organizationCode,
    required this.userEmail,
    required this.userName,
    this.photoData,
    this.onPhotoUpdated,
  });

  @override
  ConsumerState<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView> {
  // App version info
  String _version = '';
  String _buildNumber = '';
  // Local photo data to show immediate updates
  Uint8List? _currentPhotoData;

  @override
  void initState() {
    super.initState();
    _currentPhotoData = widget.photoData;
    _initPackageInfo();
  }

  // --- Owner-only secret gesture state ---
  int _secretTapCount = 0;
  DateTime? _lastTapTime;

  bool get _isOwner {
    final role = SharedPreferencesUtils().getRole();
    return role == UserRole.admin;
  }

  void _handleSecretTap() {
    final now = DateTime.now();
    if (_lastTapTime == null ||
        now.difference(_lastTapTime!) > const Duration(seconds: 1)) {
      _secretTapCount = 0;
    }
    _lastTapTime = now;
    _secretTapCount++;

    if (_secretTapCount >= 7) {
      _secretTapCount = 0;
      if (_isOwner) {
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
        confirmAction: () {
          Navigator.pop(context);
          // TODO: Add delete account logic
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      body: CustomScrollView(
        slivers: [
          _buildUserProfileHeader(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space4,
              vertical: BauhausDesign.space6,
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
                    ],
                  ),
                  _buildSettingsSection(
                    title: AppLocalizations.of(context)!.organizationSection,
                    items: [
                      _buildSettingsItem(
                        icon: Icons.business_center_outlined,
                        color: const Color(0xFF8B5CF6), // Purple
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
                        color: const Color(0xFFEC4899), // Pink
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
                          icon: Icons.admin_panel_settings_outlined,
                          color: BauhausDesign.primary,
                          title: AppLocalizations.of(context)!.adminDashboard,
                          subtitle: AppLocalizations.of(context)!
                              .adminDashboardSubtitle,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminDashboardView(
                                  email: widget.userEmail,
                                  photoData: widget.photoData,
                                  organizationId: widget.organizationId,
                                  organizationName: widget.organizationName,
                                  organizationCode: widget.organizationCode,
                                ),
                              ),
                            );
                          },
                        ),
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
                            color: const Color(0xFF8B5CF6),
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

  Widget _buildUserProfileHeader() {
    final photoState = ref.watch(photoDataProvider);
    final displayPhoto = photoState.photoData ?? _currentPhotoData;

    return SliverAppBar(
      expandedHeight: 240,
      pinned: true,
      backgroundColor: BauhausDesign.surfaceWhite,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          alignment: Alignment.center,
          children: [
            // Background gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    BauhausDesign.primary.withOpacity(0.1),
                    BauhausDesign.backgroundLight,
                  ],
                ),
              ),
            ),
            // Profile content
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: BauhausDesign.space8),
                Hero(
                  tag: 'profile-image',
                  child: GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhotoUploadScreen(
                            email: widget.userEmail,
                          ),
                        ),
                      );

                      if (mounted) {
                        ref.read(photoDataProvider.notifier).fetchPhotoData(
                            widget.userEmail,
                            forceRefresh: true);
                        if (widget.onPhotoUpdated != null) {
                          widget.onPhotoUpdated!();
                        }
                      }
                    },
                    child: Stack(
                      children: [
                        ProfileImageWidget(
                          photoData: displayPhoto,
                          size: 100,
                          borderWidth: 4,
                          borderColor: BauhausDesign.surfaceWhite,
                          elevation: 8,
                          shadowColor: Colors.black12,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(BauhausDesign.space2),
                            decoration: BoxDecoration(
                              color: BauhausDesign.primary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: BauhausDesign.surfaceWhite, width: 2),
                              boxShadow: const [BauhausDesign.shadowSoft],
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 16,
                              color: BauhausDesign.surfaceWhite,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: BauhausDesign.space4),
                Text(
                  widget.userName,
                  style: BauhausDesign.getTextTheme(context)
                      .headlineMedium
                      ?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: BauhausDesign.textDark,
                      ),
                ),
                const SizedBox(height: BauhausDesign.space1),
                Text(
                  widget.userEmail,
                  style:
                      BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                            color: BauhausDesign.textMuted,
                          ),
                ),
              ],
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
        Padding(
          padding: const EdgeInsets.only(
            left: BauhausDesign.space2,
            top: BauhausDesign.space6,
            bottom: BauhausDesign.space3,
          ),
          child: Text(
            title,
            style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDangerZone
                      ? BauhausDesign.error
                      : BauhausDesign.textMuted,
                  letterSpacing: 0.5,
                ),
          ),
        ),
        BauhausCard(
          padding: EdgeInsets.zero,
          borderColor:
              isDangerZone ? BauhausDesign.error.withOpacity(0.3) : null,
          child: Column(
            children: List.generate(items.length, (index) {
              return Column(
                children: [
                  items[index],
                  if (index < items.length - 1)
                    Divider(
                      height: 1,
                      color: BauhausDesign.neutral.withOpacity(0.5),
                    ),
                ],
              );
            }),
          ),
        ),
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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: BauhausDesign.space4,
            vertical: BauhausDesign.space4,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space2),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: BauhausDesign.space4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: BauhausDesign.getTextTheme(context)
                          .bodyLarge
                          ?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: BauhausDesign.textDark,
                          ),
                    ),
                    const SizedBox(height: 2),
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
              const SizedBox(width: BauhausDesign.space2),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: BauhausDesign.neutral,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _performLogout(BuildContext context) async {
    final sharedPrefs = SharedPreferencesUtils();
    await sharedPrefs.init();
    await sharedPrefs.clearAuthToken();
    await sharedPrefs.clear();
    if (!mounted) return;

    Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
      Routes.login,
      (route) => false,
    );
  }
}
