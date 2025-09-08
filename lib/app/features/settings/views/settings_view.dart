import 'package:carenest/app/features/auth/viewmodels/change_password_viewmodel.dart';
import 'package:carenest/app/features/auth/views/change_password_view.dart';
import 'package:carenest/app/features/organization/views/organization_details_view.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/shared/widgets/profile_image_widget.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'dart:typed_data';

import 'package:carenest/config/environment.dart';
import 'package:carenest/app/features/admin/views/admin_dashboard_view.dart';
import 'package:carenest/app/features/security/views/api_usage_dashboard_view.dart';
import 'package:carenest/app/features/pricing/views/pricing_analytics_view.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Modernized Settings View
/// A visually refreshed settings page with fluid animations and a clean, grouped layout.
class SettingsView extends StatefulWidget {
  final String? organizationId;
  final String? organizationName;
  final String? organizationCode;
  final String userEmail;
  final String userName;
  final Uint8List? photoData;

  const SettingsView({
    super.key,
    this.organizationId,
    this.organizationName,
    this.organizationCode,
    required this.userEmail,
    required this.userName,
    this.photoData,
  });

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  // App version info
  String _version = '';
  String _buildNumber = '';

  // Helper to show a consistently styled dialog for confirmations.
  void _showStyledDialog({
    required BuildContext context,
    required String title,
    required String content,
    required String confirmText,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title:
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey.shade700),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
              child: Text(
                confirmText,
                style: const TextStyle(
                    color: AppColors.colorRed, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  // --- Owner-only secret gesture state ---
  int _secretTapCount = 0;
  DateTime? _lastTapTime;

  bool get _isOwner {
    final owner = AppConfig.ownerEmail.trim().toLowerCase();
    return owner.isNotEmpty && widget.userEmail.trim().toLowerCase() == owner;
  }

  void _handleSecretTap() {
    final now = DateTime.now();
    if (_lastTapTime == null ||
        now.difference(_lastTapTime!) > const Duration(seconds: 1)) {
      // Reset sequence if too much time passed
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
          const SnackBar(content: Text('Restricted: Owner access only')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadAppVersion();
  }

  Future<void> _loadAppVersion() async {
    try {
      final info = await PackageInfo.fromPlatform();
      if (!mounted) return;
      setState(() {
        _version = info.version; // e.g., 2025.08.30
        _buildNumber = info.buildNumber; // e.g., 23
      });
    } catch (e) {
      // Fallback: keep empty, UI will handle gracefully
    }
  }

  @override
  Widget build(BuildContext context) {
    // We use a CustomScrollView with Slivers for a more flexible and performant layout.
    return Scaffold(
      backgroundColor:
          const Color(0xFFF4F6FA), // A soft, modern background color
      body: CustomScrollView(
        slivers: [
          _buildUserProfileHeader(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  // Each section is built using a helper, making the code clean.
                  _buildSettingsSection(
                    title: 'Account',
                    items: [
                      _buildSettingsItem(
                        icon: Icons.person_outline,
                        color: AppColors.colorBlue,
                        title: 'Profile Settings',
                        subtitle: 'Update your personal information',
                        onTap: () {
                          // TODO: Navigate to profile settings
                        },
                      ),
                      _buildSettingsItem(
                        icon: Icons.lock_outline,
                        color: AppColors.colorGreen,
                        title: 'Change Password',
                        subtitle: 'Update your account password',
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
                  // if (widget.organizationName != null)
                  _buildSettingsSection(
                    title: 'Organization',
                    items: [
                      _buildSettingsItem(
                        icon: Icons.business_center_outlined,
                        color: AppColors.colorPurple,
                        title: 'Organization Details',
                        subtitle: widget.organizationName ?? 'N/A',
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
                    title: 'App Settings',
                    items: [
                      _buildSettingsItem(
                        icon: Icons.notifications_outlined,
                        color: AppColors.colorOrange,
                        title: 'Notifications',
                        subtitle: 'Manage notification preferences',
                        onTap: () {
                          // TODO: Implement notification settings
                        },
                      ),
                      _buildSettingsItem(
                        icon: Icons.palette_outlined,
                        color: AppColors.colorPink,
                        title: 'Theme',
                        subtitle: 'Choose app appearance',
                        onTap: () {
                          // TODO: Implement theme settings
                        },
                      ),
                    ],
                  ),
                  // --- Owner-only tools section ---
                  if (_isOwner)
                    _buildSettingsSection(
                      title: 'Owner Tools',
                      items: [
                        _buildSettingsItem(
                          icon: Icons.admin_panel_settings_outlined,
                          color: AppColors.colorBlue,
                          title: 'Admin Dashboard',
                          subtitle: 'Manage organization and app',
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
                          color: AppColors.colorGreen,
                          title: 'Security Dashboard',
                          subtitle: 'API usage and security metrics',
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
                            color: AppColors.colorPurple,
                            title: 'Pricing Analytics',
                            subtitle: 'Analyze pricing performance',
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
                    isDangerZone: true,
                    title: 'Danger Zone',
                    items: [
                      _buildSettingsItem(
                        icon: Icons.logout,
                        color: AppColors.colorRed400,
                        title: 'Logout',
                        subtitle: 'Sign out of your account',
                        onTap: () => _showStyledDialog(
                          context: context,
                          title: 'Logout',
                          content: 'Are you sure you want to logout?',
                          confirmText: 'Logout',
                          onConfirm: () async {
                            await _performLogout(context);
                          },
                        ),
                      ),
                      _buildSettingsItem(
                        icon: Icons.delete_forever_outlined,
                        color: AppColors.colorRed800,
                        title: 'Delete Account',
                        subtitle: 'Permanently delete your account',
                        onTap: () => _showStyledDialog(
                          context: context,
                          title: 'Delete Account',
                          content:
                              'This action is permanent and cannot be undone. Are you sure?',
                          confirmText: 'Delete',
                          onConfirm: () {
                            // TODO: Add delete account logic
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Secret multi-tap gesture on version footer
                  GestureDetector(
                    onTap: _handleSecretTap,
                    onLongPress: _handleSecretTap,
                    child: Text(
                      _version.isNotEmpty
                          ? 'Version $_version${_buildNumber.isNotEmpty ? ' ($_buildNumber)' : ''}'
                          : 'Version',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 20),
                ]
                    // This single block animates all list items with a beautiful stagger effect.
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

  // A custom SliverAppBar for the fluid, curved header.
  Widget _buildUserProfileHeader() {
    return SliverAppBar(
      expandedHeight: 220.0,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: ClipPath(
          clipper: _HeaderClipper(),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.colorPrimary,
                  AppColors.colorPrimary.withValues(alpha: 0.8),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                ProfileImageWidget(
                  photoData: widget.photoData,
                  size: 90,
                ),
                const SizedBox(height: 12),
                Text(
                  widget.userName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.userEmail,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 15,
                  ),
                ),
              ],
            ).animate().fadeIn(duration: 500.ms),
          ),
        ),
      ),
    );
  }

  // A reusable widget for creating a section with a title and grouped items.
  Widget _buildSettingsSection({
    required String title,
    required List<Widget> items,
    bool isDangerZone = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 24.0, bottom: 8.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDangerZone
                  ? AppColors.colorRed700
                  : AppColors.colorPrimary.withValues(alpha: 0.8),
              letterSpacing: 0.5,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 20,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Column(
            // Add dividers between items, but not after the last one.
            children: List.generate(items.length, (index) {
              return Column(
                children: [
                  items[index],
                  if (index < items.length - 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Divider(
                        height: 1,
                        color: Colors.grey.shade200,
                      ),
                    ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  // A beautifully styled list item for the settings.
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
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color.withValues(alpha: 0.15),
                      color.withValues(alpha: 0.1)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
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
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Logout method to clear user data and navigate to login
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

// A custom clipper to create the curved header shape.
class _HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40); // Start from bottom-left, up a bit
    path.quadraticBezierTo(
      size.width / 2, // Control point in the middle
      size.height, // Control point at the bottom
      size.width, // End point at bottom-right
      size.height - 40,
    );
    path.lineTo(size.width, 0); // Line to top-right
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
