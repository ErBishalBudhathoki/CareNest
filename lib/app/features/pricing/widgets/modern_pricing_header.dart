import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/shared/constants/values/dimens/app_dimens.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Modern pricing dashboard header with improved UX and visibility
class ModernPricingHeader extends StatefulWidget {
  final String title;
  final String subtitle;
  final String userName;
  final String userEmail;
  final int notificationCount;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onSettingsTap;
  final VoidCallback? onMenuTap;
  final VoidCallback? onSearchTap;
  final bool showStats;
  final List<HeaderStatCard>? stats;

  const ModernPricingHeader({
    super.key,
    this.title = 'Pricing Dashboard',
    this.subtitle = 'Manage your subscription plans and billing',
    this.userName = 'Admin User',
    this.userEmail = 'admin@company.com',
    this.notificationCount = 0,
    this.onNotificationTap,
    this.onSettingsTap,
    this.onMenuTap,
    this.onSearchTap,
    this.showStats = true,
    this.stats,
  });

  @override
  State<ModernPricingHeader> createState() => _ModernPricingHeaderState();
}

class _ModernPricingHeaderState extends State<ModernPricingHeader>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  final bool _isSearchFocused = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildMainHeader(),
            if (widget.showStats) _buildStatsSection(),
          ],
        ),
      ),
    );
  }

  /// Build the main header section with navigation and user info
  Widget _buildMainHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.paddingLarge,
        vertical: AppDimens.paddingSmall,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title row
          Row(
            children: [
              // Title section
              Expanded(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width < 768
                        ? AppDimens.fontSizeMedium
                        : AppDimens.fontSizeLarge,
                    fontWeight: FontWeight.bold,
                    color: AppColors.colorBlack87,
                  ),
                ),
              ),

              // Right section - Actions only
              Row(
                children: [
                  // Search button
                  _buildIconButton(
                    icon: Icons.search,
                    onTap: widget.onSearchTap,
                    tooltip: 'Search',
                  ),
                  const SizedBox(width: AppDimens.paddingSmall),

                  // Notifications
                  _buildNotificationButton(),
                  const SizedBox(width: AppDimens.paddingSmall),

                  // Settings
                  _buildIconButton(
                    icon: Icons.settings_outlined,
                    onTap: widget.onSettingsTap,
                    tooltip: 'Settings',
                  ),
                ],
              ),
            ],
          ),

          // Subtitle row
          const SizedBox(height: 4),
          Text(
            widget.subtitle,
            style: TextStyle(
              fontSize: AppDimens.fontSizeXSmall,
              color: AppColors.colorGrey600,
            ),
          ),
          const SizedBox(height: AppDimens.paddingSmall),

          // Search bar for larger screens
          if (MediaQuery.of(context).size.width >= 768)
            Padding(
              padding: const EdgeInsets.only(top: AppDimens.paddingSmall),
              child: _buildSearchBar(),
            ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.1, end: 0);
  }

  /// Build stats section with key metrics
  Widget _buildStatsSection() {
    final defaultStats = widget.stats ??
        [
          HeaderStatCard(
            label: 'Monthly Revenue',
            value: '\$24,500',
            icon: Icons.attach_money,
            trend: '+12%',
            trendPositive: true,
          ),
          HeaderStatCard(
            label: 'Active Plans',
            value: '156',
            icon: Icons.credit_card,
            trend: '+8%',
            trendPositive: true,
          ),
          HeaderStatCard(
            label: 'Customers',
            value: '2,340',
            icon: Icons.people,
            trend: '+15%',
            trendPositive: true,
          ),
          HeaderStatCard(
            label: 'Growth Rate',
            value: '23%',
            icon: Icons.trending_up,
            trend: '+5%',
            trendPositive: true,
          ),
        ];

    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppDimens.paddingLarge,
        AppDimens.paddingSmall,
        AppDimens.paddingLarge,
        AppDimens.paddingMedium,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth >= 768;
          final crossAxisCount = isTablet ? 4 : 2;

          return Wrap(
            spacing: AppDimens.paddingSmall,
            runSpacing: AppDimens.paddingSmall,
            children: defaultStats.asMap().entries.map((entry) {
              final index = entry.key;
              final stat = entry.value;
              return SizedBox(
                width: (constraints.maxWidth - AppDimens.paddingSmall) /
                    crossAxisCount,
                child: _buildStatCard(stat, index),
              );
            }).toList(),
          );
        },
      ),
    )
        .animate(delay: 200.ms)
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.1, end: 0);
  }

  /// Build individual stat card
  Widget _buildStatCard(HeaderStatCard stat, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.colorGrey200,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.colorPrimary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    stat.icon,
                    size: 14,
                    color: AppColors.colorPrimary,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    color: stat.trendPositive
                        ? AppColors.colorSuccess.withOpacity(0.1)
                        : AppColors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    stat.trend,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: stat.trendPositive
                          ? AppColors.colorSuccess
                          : AppColors.error,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Flexible(
              child: Text(
                stat.value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.colorBlack87,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 2),
            Flexible(
              child: Text(
                stat.label,
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.colorGrey600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    )
        .animate(delay: (100 * index).ms)
        .fadeIn(duration: 400.ms)
        .scale(begin: const Offset(0.8, 0.8));
  }

  /// Build search bar
  Widget _buildSearchBar() {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.colorGrey50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isSearchFocused
              ? AppColors.colorPrimary.withOpacity(0.1)
              : AppColors.colorGrey200,
          width: 1,
        ),
      ),
      child: TextField(
        onTap: widget.onSearchTap,
        onChanged: (value) {
          // Handle search
        },
        decoration: InputDecoration(
          hintText: 'Search plans, customers, or transactions...',
          hintStyle: TextStyle(
            color: AppColors.colorGrey500,
            fontSize: AppDimens.fontSizeSmall,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.colorGrey500,
            size: 20,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppDimens.paddingMedium,
            vertical: AppDimens.paddingSmall,
          ),
        ),
        style: TextStyle(
          fontSize: AppDimens.fontSizeSmall,
          color: AppColors.colorBlack87,
        ),
      ),
    );
  }

  /// Build notification button with badge
  Widget _buildNotificationButton() {
    return Stack(
      children: [
        _buildIconButton(
          icon: Icons.notifications_outlined,
          onTap: widget.onNotificationTap,
          tooltip: 'Notifications',
        ),
        if (widget.notificationCount > 0)
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: AppColors.error,
                borderRadius: BorderRadius.circular(8),
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Text(
                widget.notificationCount > 9
                    ? '9+'
                    : widget.notificationCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }

  /// Build icon button with consistent styling
  Widget _buildIconButton({
    required IconData icon,
    VoidCallback? onTap,
    String? tooltip,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.colorGrey50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.colorGrey200,
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            size: 20,
            color: AppColors.colorBlack87,
          ),
        ),
      ),
    );
  }

  /// Build user profile section (removed as per user request)
  Widget _buildUserProfile() {
    return const SizedBox.shrink();
  }
}

/// Data class for header stat cards
class HeaderStatCard {
  final String label;
  final String value;
  final IconData icon;
  final String trend;
  final bool trendPositive;

  const HeaderStatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.trend,
    this.trendPositive = true,
  });
}
