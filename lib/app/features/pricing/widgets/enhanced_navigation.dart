import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/shared/constants/values/dimens/app_dimens.dart';
import 'improved_design_system.dart';

/// Enhanced navigation system for pricing feature with improved UX
class PricingNavigationController {
  static const String dashboard = 'dashboard';
  static const String management = 'management';
  static const String analytics = 'analytics';
  static const String configuration = 'configuration';
  static const String history = 'history';
  static const String ndisItems = 'ndis_items';
}

/// Enhanced bottom navigation with better visual hierarchy
class EnhancedPricingBottomNav extends StatelessWidget {
  final String currentRoute;
  final Function(String) onRouteChanged;
  final bool showLabels;

  const EnhancedPricingBottomNav({
    Key? key,
    required this.currentRoute,
    required this.onRouteChanged,
    this.showLabels = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = _getNavigationItems();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorWhite,
        boxShadow: [
          BoxShadow(
            color: AppColors.colorGrey400.withValues(alpha: 0.1),
            blurRadius: PricingDesignSystem.elevationMedium,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: PricingDesignSystem.spacingMedium,
            vertical: PricingDesignSystem.spacingSmall,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.map((item) => _buildNavItem(item)).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(NavigationItem item) {
    final isSelected = currentRoute == item.route;

    return Semantics(
      button: true,
      selected: isSelected,
      label: item.label,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onRouteChanged(item.route),
          borderRadius: BorderRadius.circular(PricingDesignSystem.radiusMedium),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: PricingDesignSystem.spacingMedium,
              vertical: PricingDesignSystem.spacingSmall,
            ),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.colorPrimary.withValues(alpha: 0.1)
                  : Colors.transparent,
              borderRadius:
                  BorderRadius.circular(PricingDesignSystem.radiusMedium),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  item.icon,
                  color: isSelected
                      ? AppColors.colorPrimary
                      : AppColors.colorGrey500,
                  size: AppDimens.iconSizeSmall,
                ),
                if (showLabels) ...[
                  const SizedBox(height: PricingDesignSystem.spacingMicro),
                  Text(
                    item.label,
                    style: TextStyle(
                      fontSize: AppDimens.fontSizeXSmall,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected
                          ? AppColors.colorPrimary
                          : AppColors.colorGrey500,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    )
        .animate(target: isSelected ? 1 : 0)
        .scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05));
  }

  List<NavigationItem> _getNavigationItems() {
    return [
      NavigationItem(
        route: PricingNavigationController.dashboard,
        icon: Icons.dashboard_outlined,
        label: 'Dashboard',
      ),
      NavigationItem(
        route: PricingNavigationController.management,
        icon: Icons.inventory_2_outlined,
        label: 'Items',
      ),
      NavigationItem(
        route: PricingNavigationController.analytics,
        icon: Icons.analytics_outlined,
        label: 'Analytics',
      ),
      NavigationItem(
        route: PricingNavigationController.configuration,
        icon: Icons.settings_outlined,
        label: 'Settings',
      ),
    ];
  }
}

/// Enhanced tab navigation for sub-sections
class EnhancedPricingTabBar extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final Function(int) onTabChanged;
  final bool isScrollable;

  const EnhancedPricingTabBar({
    Key? key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabChanged,
    this.isScrollable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: PricingDesignSystem.spacingMedium,
      ),
      decoration: BoxDecoration(
        color: AppColors.colorGrey100,
        borderRadius: BorderRadius.circular(PricingDesignSystem.radiusMedium),
      ),
      child: Row(
        children: tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          final isSelected = selectedIndex == index;

          return Expanded(
            child: Semantics(
              button: true,
              selected: isSelected,
              label: tab,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => onTabChanged(index),
                  borderRadius:
                      BorderRadius.circular(PricingDesignSystem.radiusMedium),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin:
                        const EdgeInsets.all(PricingDesignSystem.spacingMicro),
                    padding: const EdgeInsets.symmetric(
                      vertical: PricingDesignSystem.spacingMedium,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.colorWhite
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(
                          PricingDesignSystem.radiusSmall),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: AppColors.colorGrey400
                                    .withValues(alpha: 0.1),
                                blurRadius: PricingDesignSystem.elevationLow,
                                offset: const Offset(0, 1),
                              ),
                            ]
                          : null,
                    ),
                    child: Text(
                      tab,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: AppDimens.fontSizeSmall,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w500,
                        color: isSelected
                            ? AppColors.colorPrimary
                            : AppColors.colorGrey600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// Enhanced breadcrumb navigation for complex hierarchies
class EnhancedBreadcrumb extends StatelessWidget {
  final List<BreadcrumbItem> items;
  final Function(String)? onItemTap;

  const EnhancedBreadcrumb({
    Key? key,
    required this.items,
    this.onItemTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: PricingDesignSystem.spacingMedium,
        vertical: PricingDesignSystem.spacingSmall,
      ),
      child: Row(
        children: _buildBreadcrumbItems(),
      ),
    );
  }

  List<Widget> _buildBreadcrumbItems() {
    final widgets = <Widget>[];

    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      final isLast = i == items.length - 1;

      // Add breadcrumb item
      widgets.add(
        Semantics(
          button: !isLast && onItemTap != null,
          label: item.label,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: !isLast && onItemTap != null
                  ? () => onItemTap!(item.route)
                  : null,
              borderRadius:
                  BorderRadius.circular(PricingDesignSystem.radiusSmall),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: PricingDesignSystem.spacingSmall,
                  vertical: PricingDesignSystem.spacingMicro,
                ),
                child: Text(
                  item.label,
                  style: TextStyle(
                    fontSize: AppDimens.fontSizeSmall,
                    fontWeight: isLast ? FontWeight.w600 : FontWeight.w500,
                    color: isLast
                        ? AppColors.colorFontPrimary
                        : AppColors.colorPrimary,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      // Add separator
      if (!isLast) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: PricingDesignSystem.spacingMicro,
            ),
            child: Icon(
              Icons.chevron_right,
              size: 16,
              color: AppColors.colorGrey400,
            ),
          ),
        );
      }
    }

    return widgets;
  }
}

/// Enhanced floating action menu for quick actions
class EnhancedFloatingActionMenu extends StatefulWidget {
  final List<FloatingActionItem> items;
  final IconData mainIcon;
  final Color? backgroundColor;
  final String? tooltip;

  const EnhancedFloatingActionMenu({
    Key? key,
    required this.items,
    this.mainIcon = Icons.add,
    this.backgroundColor,
    this.tooltip,
  }) : super(key: key);

  @override
  State<EnhancedFloatingActionMenu> createState() =>
      _EnhancedFloatingActionMenuState();
}

class _EnhancedFloatingActionMenuState extends State<EnhancedFloatingActionMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ..._buildMenuItems(),
        const SizedBox(height: PricingDesignSystem.spacingSmall),
        _buildMainButton(),
      ],
    );
  }

  List<Widget> _buildMenuItems() {
    return widget.items.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      final delay = index * 50;

      return AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value,
            child: Opacity(
              opacity: _animation.value,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: PricingDesignSystem.spacingSmall,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (item.label != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: PricingDesignSystem.spacingMedium,
                          vertical: PricingDesignSystem.spacingSmall,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.colorWhite,
                          borderRadius: BorderRadius.circular(
                              PricingDesignSystem.radiusSmall),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  AppColors.colorGrey400.withValues(alpha: 0.2),
                              blurRadius: PricingDesignSystem.elevationMedium,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          item.label!,
                          style: const TextStyle(
                            fontSize: AppDimens.fontSizeSmall,
                            fontWeight: FontWeight.w500,
                            color: AppColors.colorFontPrimary,
                          ),
                        ),
                      ),
                    const SizedBox(width: PricingDesignSystem.spacingSmall),
                    FloatingActionButton.small(
                      heroTag: "fab_menu_item_$index",
                      onPressed: () {
                        _toggle();
                        item.onTap();
                      },
                      backgroundColor:
                          item.backgroundColor ?? AppColors.colorPrimary,
                      child: Icon(
                        item.icon,
                        color: AppColors.colorWhite,
                        size: AppDimens.iconSizeSmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      )
          .animate(delay: Duration(milliseconds: delay))
          .slideY(begin: 0.5, end: 0)
          .fadeIn();
    }).toList();
  }

  Widget _buildMainButton() {
    return Semantics(
      button: true,
      label: widget.tooltip ?? 'Quick actions menu',
      child: FloatingActionButton(
        heroTag: "fab_main_menu",
        onPressed: _toggle,
        backgroundColor: widget.backgroundColor ?? AppColors.colorPrimary,
        child: AnimatedRotation(
          turns: _isOpen ? 0.125 : 0,
          duration: const Duration(milliseconds: 300),
          child: Icon(
            _isOpen ? Icons.close : widget.mainIcon,
            color: AppColors.colorWhite,
          ),
        ),
      ),
    );
  }
}

/// Data models for navigation components
class NavigationItem {
  final String route;
  final IconData icon;
  final String label;
  final String? badge;

  const NavigationItem({
    required this.route,
    required this.icon,
    required this.label,
    this.badge,
  });
}

class BreadcrumbItem {
  final String route;
  final String label;

  const BreadcrumbItem({
    required this.route,
    required this.label,
  });
}

class FloatingActionItem {
  final IconData icon;
  final String? label;
  final VoidCallback onTap;
  final Color? backgroundColor;

  const FloatingActionItem({
    required this.icon,
    required this.onTap,
    this.label,
    this.backgroundColor,
  });
}
