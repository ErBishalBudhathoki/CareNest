import 'package:flutter/material.dart';
import 'modern_saas_design_system.dart';

/// Responsive Layout Helper
class ModernResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  final double mobileBreakpoint;
  final double tabletBreakpoint;

  const ModernResponsiveLayout({
    Key? key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.mobileBreakpoint = ModernSaasDesign.breakpointMd,
    this.tabletBreakpoint = ModernSaasDesign.breakpointLg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= tabletBreakpoint && desktop != null) {
          return desktop!;
        } else if (constraints.maxWidth >= mobileBreakpoint && tablet != null) {
          return tablet!;
        } else {
          return mobile;
        }
      },
    );
  }
}

/// Responsive Grid
class ModernResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final double runSpacing;
  final int mobileColumns;
  final int tabletColumns;
  final int desktopColumns;
  final double childAspectRatio;

  const ModernResponsiveGrid({
    Key? key,
    required this.children,
    this.spacing = ModernSaasDesign.space4,
    this.runSpacing = ModernSaasDesign.space4,
    this.mobileColumns = 1,
    this.tabletColumns = 2,
    this.desktopColumns = 3,
    this.childAspectRatio = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int columns;
        if (constraints.maxWidth >= ModernSaasDesign.breakpointLg) {
          columns = desktopColumns;
        } else if (constraints.maxWidth >= ModernSaasDesign.breakpointMd) {
          columns = tabletColumns;
        } else {
          columns = mobileColumns;
        }

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: columns,
          crossAxisSpacing: spacing,
          mainAxisSpacing: runSpacing,
          childAspectRatio: childAspectRatio,
          children: children,
        );
      },
    );
  }
}

/// Modern Section Header
class ModernSectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? action;
  final EdgeInsetsGeometry? padding;

  const ModernSectionHeader({
    Key? key,
    required this.title,
    this.subtitle,
    this.action,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: ModernSaasDesign.headlineSmall.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: ModernSaasDesign.space1),
                  Text(
                    subtitle!,
                    style: ModernSaasDesign.bodyMedium.copyWith(
                      color: ModernSaasDesign.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (action != null) action!,
        ],
      ),
    );
  }
}

/// Modern Empty State
class ModernEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Widget? action;
  final Color? iconColor;

  const ModernEmptyState({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
    this.action,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(ModernSaasDesign.space6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: (iconColor ?? ModernSaasDesign.primary)
                    .withValues(alpha: 0.1),
                borderRadius:
                    BorderRadius.circular(ModernSaasDesign.radiusFull),
              ),
              child: Icon(
                icon,
                size: 40,
                color: iconColor ?? ModernSaasDesign.primary,
              ),
            ),
            const SizedBox(height: ModernSaasDesign.space4),
            Text(
              title,
              style: ModernSaasDesign.headlineSmall.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: ModernSaasDesign.space2),
            Text(
              description,
              style: ModernSaasDesign.bodyMedium.copyWith(
                color: ModernSaasDesign.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (action != null) ...[
              const SizedBox(height: ModernSaasDesign.space4),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

/// Modern Error State
class ModernErrorState extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback? onRetry;
  final String retryText;

  const ModernErrorState({
    Key? key,
    this.title = 'Something went wrong',
    this.description = 'We encountered an error while loading your data.',
    this.onRetry,
    this.retryText = 'Try Again',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ModernEmptyState(
      icon: Icons.error_outline,
      title: title,
      description: description,
      iconColor: ModernSaasDesign.error,
      action: onRetry != null
          ? ModernButton(
              text: retryText,
              onPressed: onRetry!,
              variant: ButtonVariant.outline,
            )
          : null,
    );
  }
}

/// Modern Loading State
class ModernLoadingState extends StatelessWidget {
  final String? message;
  final bool showMessage;

  const ModernLoadingState({
    Key? key,
    this.message,
    this.showMessage = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(ModernSaasDesign.primary),
            strokeWidth: 3,
          ),
          if (showMessage) ...[
            const SizedBox(height: ModernSaasDesign.space4),
            Text(
              message ?? 'Loading...',
              style: ModernSaasDesign.bodyMedium.copyWith(
                color: ModernSaasDesign.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Modern Stats Card
class ModernStatsCard extends StatelessWidget {
  final String label;
  final String value;
  final String? change;
  final bool isPositiveChange;
  final IconData? icon;
  final Color? color;

  const ModernStatsCard({
    Key? key,
    required this.label,
    required this.value,
    this.change,
    this.isPositiveChange = true,
    this.icon,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardColor = color ?? ModernSaasDesign.primary;

    return ModernCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: ModernSaasDesign.bodyMedium.copyWith(
                  color: ModernSaasDesign.textSecondary,
                ),
              ),
              if (icon != null)
                Icon(
                  icon,
                  size: 20,
                  color: cardColor,
                ),
            ],
          ),
          const SizedBox(height: ModernSaasDesign.space2),
          Text(
            value,
            style: ModernSaasDesign.headlineMedium.copyWith(
              fontWeight: FontWeight.w700,
              color: ModernSaasDesign.textPrimary,
            ),
          ),
          if (change != null) ...[
            const SizedBox(height: ModernSaasDesign.space1),
            Row(
              children: [
                Icon(
                  isPositiveChange ? Icons.trending_up : Icons.trending_down,
                  size: 16,
                  color: isPositiveChange
                      ? ModernSaasDesign.success
                      : ModernSaasDesign.error,
                ),
                const SizedBox(width: ModernSaasDesign.space1),
                Text(
                  change!,
                  style: ModernSaasDesign.bodySmall.copyWith(
                    color: isPositiveChange
                        ? ModernSaasDesign.success
                        : ModernSaasDesign.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// Modern Filter Chip
class ModernFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData? icon;

  const ModernFilterChip({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.icon,
  }) : super(key: key);

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
          color:
              isSelected ? ModernSaasDesign.primary : ModernSaasDesign.surface,
          borderRadius: BorderRadius.circular(ModernSaasDesign.radiusFull),
          border: Border.all(
            color:
                isSelected ? ModernSaasDesign.primary : ModernSaasDesign.border,
            width: 1,
          ),
          boxShadow: isSelected ? ModernSaasDesign.shadowSm : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16,
                color:
                    isSelected ? Colors.white : ModernSaasDesign.textSecondary,
              ),
              const SizedBox(width: ModernSaasDesign.space1),
            ],
            Text(
              label,
              style: ModernSaasDesign.bodySmall.copyWith(
                color:
                    isSelected ? Colors.white : ModernSaasDesign.textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Modern Progress Indicator
class ModernProgressIndicator extends StatelessWidget {
  final double value;
  final String? label;
  final Color? color;
  final double height;

  const ModernProgressIndicator({
    Key? key,
    required this.value,
    this.label,
    this.color,
    this.height = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progressColor = color ?? ModernSaasDesign.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label!,
                style: ModernSaasDesign.bodySmall,
              ),
              Text(
                '${(value * 100).toInt()}%',
                style: ModernSaasDesign.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: ModernSaasDesign.space1),
        ],
        Container(
          height: height,
          decoration: BoxDecoration(
            color: ModernSaasDesign.neutral200,
            borderRadius: BorderRadius.circular(ModernSaasDesign.radiusFull),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: value.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: progressColor,
                borderRadius:
                    BorderRadius.circular(ModernSaasDesign.radiusFull),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
