import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'modern_invoice_design_system.dart';

/// Modern Metric Card for Invoice Dashboard
class ModernInvoiceMetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData icon;
  final Color? iconColor;
  final String? trend;
  final bool isPositiveTrend;
  final VoidCallback? onTap;
  final bool isLoading;

  const ModernInvoiceMetricCard({
    Key? key,
    required this.title,
    required this.value,
    this.subtitle,
    required this.icon,
    this.iconColor,
    this.trend,
    this.isPositiveTrend = true,
    this.onTap,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ModernInvoiceCard(
      onTap: onTap,
      padding: const EdgeInsets.all(ModernInvoiceDesign.space5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(ModernInvoiceDesign.space3),
                decoration: BoxDecoration(
                  color: (iconColor ?? ModernInvoiceDesign.primary)
                      .withValues(alpha: 0.1),
                  borderRadius:
                      BorderRadius.circular(ModernInvoiceDesign.radiusLg),
                ),
                child: Icon(
                  icon,
                  color: iconColor ?? ModernInvoiceDesign.primary,
                  size: 24,
                ),
              ),
              const Spacer(),
              if (trend != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: ModernInvoiceDesign.space2,
                    vertical: ModernInvoiceDesign.space1,
                  ),
                  decoration: BoxDecoration(
                    color: isPositiveTrend
                        ? ModernInvoiceDesign.success.withValues(alpha: 0.1)
                        : ModernInvoiceDesign.error.withValues(alpha: 0.1),
                    borderRadius:
                        BorderRadius.circular(ModernInvoiceDesign.radiusFull),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isPositiveTrend
                            ? Icons.trending_up
                            : Icons.trending_down,
                        size: 12,
                        color: isPositiveTrend
                            ? ModernInvoiceDesign.success
                            : ModernInvoiceDesign.error,
                      ),
                      const SizedBox(width: ModernInvoiceDesign.space1),
                      Text(
                        trend!,
                        style: ModernInvoiceDesign.labelSmall.copyWith(
                          color: isPositiveTrend
                              ? ModernInvoiceDesign.success
                              : ModernInvoiceDesign.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: ModernInvoiceDesign.space4),
          if (isLoading)
            Container(
              height: 32,
              width: double.infinity,
              decoration: BoxDecoration(
                color: ModernInvoiceDesign.neutral200,
                borderRadius:
                    BorderRadius.circular(ModernInvoiceDesign.radiusSm),
              ),
            )
                .animate(onPlay: (controller) => controller.repeat())
                .shimmer(duration: 1500.ms)
          else
            Text(
              value,
              style: ModernInvoiceDesign.displaySmall.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          const SizedBox(height: ModernInvoiceDesign.space2),
          Text(
            title,
            style: ModernInvoiceDesign.bodyMedium,
          ),
          if (subtitle != null) ...[
            const SizedBox(height: ModernInvoiceDesign.space1),
            Text(
              subtitle!,
              style: ModernInvoiceDesign.bodySmall,
            ),
          ],
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 100.ms)
        .slideY(begin: 0.2, end: 0, duration: 600.ms, delay: 100.ms);
  }
}

/// Modern Status Badge for Invoice Items
class ModernInvoiceStatusBadge extends StatelessWidget {
  final String status;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;
  final bool isSmall;

  const ModernInvoiceStatusBadge({
    Key? key,
    required this.status,
    this.backgroundColor,
    this.textColor,
    this.icon,
    this.isSmall = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color fgColor;
    IconData? statusIcon;

    switch (status.toLowerCase()) {
      case 'paid':
      case 'completed':
      case 'success':
      case 'approved':
        bgColor = ModernInvoiceDesign.success.withValues(alpha: 0.1);
        fgColor = ModernInvoiceDesign.success;
        statusIcon = Icons.check_circle;
        break;
      case 'pending':
      case 'processing':
      case 'pending approval':
        bgColor = ModernInvoiceDesign.warning.withValues(alpha: 0.1);
        fgColor = ModernInvoiceDesign.warning;
        statusIcon = Icons.schedule;
        break;
      case 'overdue':
      case 'failed':
      case 'error':
      case 'rejected':
        bgColor = ModernInvoiceDesign.error.withValues(alpha: 0.1);
        fgColor = ModernInvoiceDesign.error;
        statusIcon = Icons.error;
        break;
      case 'draft':
      case 'inactive':
        bgColor = ModernInvoiceDesign.neutral200;
        fgColor = ModernInvoiceDesign.neutral600;
        statusIcon = Icons.edit;
        break;
      default:
        bgColor = ModernInvoiceDesign.primary.withValues(alpha: 0.1);
        fgColor = ModernInvoiceDesign.primary;
        statusIcon = Icons.info;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal:
            isSmall ? ModernInvoiceDesign.space2 : ModernInvoiceDesign.space3,
        vertical:
            isSmall ? ModernInvoiceDesign.space1 : ModernInvoiceDesign.space2,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? bgColor,
        borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null || statusIcon != null)
            Icon(
              icon ?? statusIcon,
              size: isSmall ? 12 : 14,
              color: textColor ?? fgColor,
            ),
          if (icon != null || statusIcon != null)
            SizedBox(
                width: isSmall
                    ? ModernInvoiceDesign.space1
                    : ModernInvoiceDesign.space2),
          Text(
            status,
            style: (isSmall
                    ? ModernInvoiceDesign.labelSmall
                    : ModernInvoiceDesign.labelMedium)
                .copyWith(
              color: textColor ?? fgColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// Modern Section Header for Invoice Views
class ModernInvoiceSectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Widget? action;
  final VoidCallback? onTap;
  final bool showDivider;

  const ModernInvoiceSectionHeader({
    Key? key,
    required this.title,
    this.subtitle,
    this.icon,
    this.action,
    this.onTap,
    this.showDivider = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusLg),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: ModernInvoiceDesign.space3,
            ),
            child: Row(
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    color: ModernInvoiceDesign.primary,
                    size: 20,
                  ),
                  const SizedBox(width: ModernInvoiceDesign.space3),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: ModernInvoiceDesign.headlineSmall,
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: ModernInvoiceDesign.space1),
                        Text(
                          subtitle!,
                          style: ModernInvoiceDesign.bodySmall,
                        ),
                      ],
                    ],
                  ),
                ),
                if (action != null) action!,
                if (onTap != null)
                  Icon(
                    Icons.chevron_right,
                    color: ModernInvoiceDesign.textTertiary,
                    size: 20,
                  ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Container(
            height: 1,
            color: ModernInvoiceDesign.border,
            margin: const EdgeInsets.only(top: ModernInvoiceDesign.space2),
          ),
      ],
    );
  }
}

/// Modern Loading Shimmer for Invoice Lists
class ModernInvoiceLoadingShimmer extends StatelessWidget {
  final int itemCount;
  final double height;
  final EdgeInsetsGeometry? margin;

  const ModernInvoiceLoadingShimmer({
    Key? key,
    this.itemCount = 3,
    this.height = 80,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        itemCount,
        (index) => Container(
          height: height,
          margin: margin ??
              const EdgeInsets.only(bottom: ModernInvoiceDesign.space4),
          decoration: BoxDecoration(
            color: ModernInvoiceDesign.neutral100,
            borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusLg),
          ),
          child: Padding(
            padding: const EdgeInsets.all(ModernInvoiceDesign.space4),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: ModernInvoiceDesign.neutral200,
                    borderRadius:
                        BorderRadius.circular(ModernInvoiceDesign.radiusLg),
                  ),
                ),
                const SizedBox(width: ModernInvoiceDesign.space4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 16,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ModernInvoiceDesign.neutral200,
                          borderRadius: BorderRadius.circular(
                              ModernInvoiceDesign.radiusSm),
                        ),
                      ),
                      const SizedBox(height: ModernInvoiceDesign.space2),
                      Container(
                        height: 12,
                        width: MediaQuery.of(context).size.width * 0.6,
                        decoration: BoxDecoration(
                          color: ModernInvoiceDesign.neutral200,
                          borderRadius: BorderRadius.circular(
                              ModernInvoiceDesign.radiusSm),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 60,
                  height: 24,
                  decoration: BoxDecoration(
                    color: ModernInvoiceDesign.neutral200,
                    borderRadius:
                        BorderRadius.circular(ModernInvoiceDesign.radiusFull),
                  ),
                ),
              ],
            ),
          ),
        )
            .animate(onPlay: (controller) => controller.repeat())
            .shimmer(duration: 1500.ms, delay: (index * 100).ms),
      ),
    );
  }
}

/// Modern Empty State for Invoice Lists
class ModernInvoiceEmptyState extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String? actionText;
  final VoidCallback? onAction;
  final Widget? customAction;

  const ModernInvoiceEmptyState({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.actionText,
    this.onAction,
    this.customAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(ModernInvoiceDesign.space8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: ModernInvoiceDesign.primary.withValues(alpha: 0.1),
                borderRadius:
                    BorderRadius.circular(ModernInvoiceDesign.radius2xl),
              ),
              child: Icon(
                icon,
                size: 40,
                color: ModernInvoiceDesign.primary,
              ),
            ),
            const SizedBox(height: ModernInvoiceDesign.space6),
            Text(
              title,
              style: ModernInvoiceDesign.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: ModernInvoiceDesign.space3),
            Text(
              subtitle,
              style: ModernInvoiceDesign.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: ModernInvoiceDesign.space6),
            if (customAction != null)
              customAction!
            else if (actionText != null && onAction != null)
              ModernInvoiceButton(
                text: actionText!,
                onPressed: onAction,
                icon: Icons.add,
              ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.3, end: 0, duration: 600.ms);
  }
}

/// Modern Search Bar for Invoice Views
class ModernInvoiceSearchBar extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final VoidCallback? onClear;
  final bool showFilter;
  final VoidCallback? onFilter;
  final int? filterCount;

  const ModernInvoiceSearchBar({
    Key? key,
    this.hint = 'Search invoices...',
    this.controller,
    this.onChanged,
    this.onClear,
    this.showFilter = false,
    this.onFilter,
    this.filterCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: ModernInvoiceDesign.surface,
              borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusLg),
              border: Border.all(color: ModernInvoiceDesign.border),
              boxShadow: ModernInvoiceDesign.shadowSm,
            ),
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: ModernInvoiceDesign.bodyLarge,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: ModernInvoiceDesign.bodyLarge.copyWith(
                  color: ModernInvoiceDesign.textTertiary,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: ModernInvoiceDesign.textSecondary,
                ),
                suffixIcon: controller?.text.isNotEmpty == true
                    ? IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: ModernInvoiceDesign.textSecondary,
                        ),
                        onPressed: onClear,
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: ModernInvoiceDesign.space4,
                  vertical: ModernInvoiceDesign.space3,
                ),
              ),
            ),
          ),
        ),
        if (showFilter) ...[
          const SizedBox(width: ModernInvoiceDesign.space3),
          Container(
            decoration: BoxDecoration(
              color: filterCount != null && filterCount! > 0
                  ? ModernInvoiceDesign.primary
                  : ModernInvoiceDesign.surface,
              borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusLg),
              border: Border.all(
                color: filterCount != null && filterCount! > 0
                    ? ModernInvoiceDesign.primary
                    : ModernInvoiceDesign.border,
              ),
              boxShadow: ModernInvoiceDesign.shadowSm,
            ),
            child: IconButton(
              icon: Stack(
                children: [
                  Icon(
                    Icons.filter_list,
                    color: filterCount != null && filterCount! > 0
                        ? ModernInvoiceDesign.textOnPrimary
                        : ModernInvoiceDesign.textSecondary,
                  ),
                  if (filterCount != null && filterCount! > 0)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: ModernInvoiceDesign.error,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
              onPressed: onFilter,
            ),
          ),
        ],
      ],
    );
  }
}

/// Modern Progress Indicator for Invoice Operations
class ModernInvoiceProgressIndicator extends StatelessWidget {
  final double progress;
  final String? label;
  final Color? color;
  final bool showPercentage;

  const ModernInvoiceProgressIndicator({
    Key? key,
    required this.progress,
    this.label,
    this.color,
    this.showPercentage = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progressColor = color ?? ModernInvoiceDesign.primary;
    final percentage = (progress * 100).round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null || showPercentage)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (label != null)
                Text(
                  label!,
                  style: ModernInvoiceDesign.labelMedium,
                ),
              if (showPercentage)
                Text(
                  '$percentage%',
                  style: ModernInvoiceDesign.labelMedium.copyWith(
                    color: progressColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        if (label != null || showPercentage)
          const SizedBox(height: ModernInvoiceDesign.space2),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: ModernInvoiceDesign.neutral200,
            borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusFull),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: progressColor,
                borderRadius:
                    BorderRadius.circular(ModernInvoiceDesign.radiusFull),
              ),
            ),
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(duration: 300.ms)
        .scaleX(begin: 0, end: 1, duration: 600.ms, curve: Curves.easeOutCubic);
  }
}
