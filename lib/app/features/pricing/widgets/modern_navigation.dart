import 'package:flutter/material.dart';
import '../../../shared/design_system/modern_saas_design_system.dart';

/// Modern Bottom Navigation Bar
class ModernBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<ModernNavItem> items;

  const ModernBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ModernSaasDesign.surface,
        boxShadow: [
          BoxShadow(
            color: ModernSaasDesign.neutral900.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: ModernSaasDesign.space4,
            vertical: ModernSaasDesign.space2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isSelected = index == currentIndex;

              return _ModernNavButton(
                item: item,
                isSelected: isSelected,
                onTap: () => onTap(index),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _ModernNavButton extends StatelessWidget {
  final ModernNavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const _ModernNavButton({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: ModernSaasDesign.durationFast,
        padding: const EdgeInsets.symmetric(
          horizontal: ModernSaasDesign.space3,
          vertical: ModernSaasDesign.space2,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? ModernSaasDesign.primary.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(ModernSaasDesign.radiusLg),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: ModernSaasDesign.durationFast,
              padding: const EdgeInsets.all(ModernSaasDesign.space1),
              child: Icon(
                isSelected ? item.activeIcon : item.icon,
                color: isSelected
                    ? ModernSaasDesign.primary
                    : ModernSaasDesign.textTertiary,
                size: 24,
              ),
            ),
            const SizedBox(height: ModernSaasDesign.space1),
            AnimatedDefaultTextStyle(
              duration: ModernSaasDesign.durationFast,
              style: ModernSaasDesign.labelSmall.copyWith(
                color: isSelected
                    ? ModernSaasDesign.primary
                    : ModernSaasDesign.textTertiary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
              child: Text(item.label),
            ),
          ],
        ),
      ),
    );
  }
}

/// Modern Floating Action Button
class ModernFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String? tooltip;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool isExtended;
  final String? label;

  const ModernFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.tooltip,
    this.backgroundColor,
    this.foregroundColor,
    this.isExtended = false,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? ModernSaasDesign.primary;
    final fgColor = foregroundColor ?? Colors.white;

    if (isExtended && label != null) {
      return FloatingActionButton.extended(
        onPressed: onPressed,
        icon: Icon(icon, color: fgColor),
        label: Text(
          label!,
          style: ModernSaasDesign.bodyMedium.copyWith(
            color: fgColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: bgColor,
        elevation: 8,
        tooltip: tooltip,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ModernSaasDesign.radiusXl),
        ),
      );
    }

    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: bgColor,
      foregroundColor: fgColor,
      elevation: 8,
      tooltip: tooltip,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ModernSaasDesign.radiusXl),
      ),
      child: Icon(icon),
    );
  }
}

/// Modern App Bar
class ModernAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final Color? backgroundColor;
  final double elevation;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  const ModernAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.centerTitle = true,
    this.backgroundColor,
    this.elevation = 0,
    this.showBackButton = false,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: ModernSaasDesign.headlineSmall.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? ModernSaasDesign.surface,
      elevation: elevation,
      surfaceTintColor: Colors.transparent,
      leading: leading ??
          (showBackButton
              ? IconButton(
                  onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: ModernSaasDesign.textPrimary,
                  ),
                )
              : null),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Modern Tab Bar
class ModernTabBar extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final bool isScrollable;

  const ModernTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTap,
    this.isScrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ModernSaasDesign.surface,
        border: Border(
          bottom: BorderSide(
            color: ModernSaasDesign.border,
            width: 1,
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: tabs.asMap().entries.map((entry) {
            final index = entry.key;
            final tab = entry.value;
            final isSelected = index == selectedIndex;

            return _ModernTab(
              text: tab,
              isSelected: isSelected,
              onTap: () => onTap(index),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _ModernTab extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _ModernTab({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: ModernSaasDesign.space4,
          vertical: ModernSaasDesign.space3,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? ModernSaasDesign.primary : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          text,
          style: ModernSaasDesign.bodyMedium.copyWith(
            color: isSelected
                ? ModernSaasDesign.primary
                : ModernSaasDesign.textSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

/// Modern Drawer
class ModernDrawer extends StatelessWidget {
  final String? userEmail;
  final String? userName;
  final String? userAvatar;
  final List<ModernDrawerItem> items;
  final ValueChanged<int>? onItemTap;

  const ModernDrawer({
    super.key,
    this.userEmail,
    this.userName,
    this.userAvatar,
    required this.items,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ModernSaasDesign.surface,
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: ModernSaasDesign.space4,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return _ModernDrawerItem(
                  item: item,
                  onTap: () => onItemTap?.call(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(ModernSaasDesign.space6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ModernSaasDesign.primary,
            ModernSaasDesign.primary.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white.withValues(alpha: 0.2),
              backgroundImage:
                  userAvatar != null ? NetworkImage(userAvatar!) : null,
              child: userAvatar == null
                  ? Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.white,
                    )
                  : null,
            ),
            const SizedBox(height: ModernSaasDesign.space3),
            if (userName != null)
              Text(
                userName!,
                style: ModernSaasDesign.headlineSmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            if (userEmail != null)
              Text(
                userEmail!,
                style: ModernSaasDesign.bodyMedium.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ModernDrawerItem extends StatelessWidget {
  final ModernDrawerItem item;
  final VoidCallback? onTap;

  const _ModernDrawerItem({
    required this.item,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        item.icon,
        color: ModernSaasDesign.textSecondary,
      ),
      title: Text(
        item.title,
        style: ModernSaasDesign.bodyMedium,
      ),
      subtitle: item.subtitle != null
          ? Text(
              item.subtitle!,
              style: ModernSaasDesign.bodySmall,
            )
          : null,
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ModernSaasDesign.radiusMd),
      ),
    );
  }
}

// Data Models
class ModernNavItem {
  final String label;
  final IconData icon;
  final IconData activeIcon;

  ModernNavItem({
    required this.label,
    required this.icon,
    IconData? activeIcon,
  }) : activeIcon = activeIcon ?? icon;
}

class ModernDrawerItem {
  final String title;
  final String? subtitle;
  final IconData icon;

  ModernDrawerItem({
    required this.title,
    this.subtitle,
    required this.icon,
  });
}
