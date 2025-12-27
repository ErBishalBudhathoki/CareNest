import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/shared/constants/values/dimens/app_dimens.dart';

/// Enhanced design system for pricing feature with improved UX
class PricingDesignSystem {
  // Enhanced spacing system
  static const double spacingMicro = 4.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingXLarge = 32.0;
  static const double spacingXXLarge = 48.0;

  // Enhanced border radius system
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 24.0;

  // Enhanced elevation system
  static const double elevationLow = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationHigh = 8.0;
  static const double elevationXHigh = 16.0;
}

/// Enhanced action card with improved accessibility and visual hierarchy
class EnhancedActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final bool isEnabled;
  final String? badge;
  final bool showArrow;

  const EnhancedActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
    this.isEnabled = true,
    this.badge,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: isEnabled,
      label: '$title. $subtitle',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? onTap : null,
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: AppColors.colorWhite,
              borderRadius:
                  BorderRadius.circular(8.0),
              border: Border.all(
                color: isEnabled
                    ? color.withOpacity(0.1)
                    : AppColors.colorGrey300,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: (isEnabled ? color : AppColors.colorGrey400)
                      .withOpacity(0.1),
                  blurRadius: 4.0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(
                          8.0),
                      decoration: BoxDecoration(
                        color: (isEnabled ? color : AppColors.colorGrey400)
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(
                            4.0),
                      ),
                      child: Icon(
                        icon,
                        color: isEnabled ? color : AppColors.colorGrey400,
                        size: AppDimens.iconSizeMedium,
                      ),
                    ),
                    const Spacer(),
                    if (badge != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.colorWarning,
                          borderRadius: BorderRadius.circular(
                              4.0),
                        ),
                        child: Text(
                          badge!,
                          style: const TextStyle(
                            color: AppColors.colorWhite,
                            fontSize: AppDimens.fontSizeXSmall,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    if (showArrow)
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: isEnabled
                            ? AppColors.colorGrey500
                            : AppColors.colorGrey300,
                      ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: AppDimens.fontSizeMedium,
                    fontWeight: FontWeight.w600,
                    color: isEnabled
                        ? AppColors.colorFontPrimary
                        : AppColors.colorGrey400,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: AppDimens.fontSizeSmall,
                    color: isEnabled
                        ? AppColors.colorFontSecondary
                        : AppColors.colorGrey400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: const Duration(milliseconds: 400))
        .slideY(begin: 0.1, end: 0);
  }
}

/// Enhanced stat card with better visual hierarchy and accessibility
class EnhancedStatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData? icon;
  final Color? color;
  final double? changePercentage;
  final VoidCallback? onTap;
  final bool isLoading;

  const EnhancedStatCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.icon,
    this.color,
    this.changePercentage,
    this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = color ?? AppColors.colorPrimary;
    final isPositiveChange = changePercentage != null && changePercentage! > 0;
    final changeColor =
        isPositiveChange ? AppColors.colorSuccess : AppColors.colorWarning;

    return Semantics(
      button: onTap != null,
      label:
          '$title: $value${changePercentage != null ? ". Change: ${changePercentage!.toStringAsFixed(1)}%" : ""}',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: AppColors.colorWhite,
              borderRadius:
                  BorderRadius.circular(8.0),
              border: Border.all(
                color: cardColor.withOpacity(0.1),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: cardColor.withOpacity(0.1),
                  blurRadius: 4.0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: isLoading
                ? _buildLoadingState()
                : _buildContent(cardColor, changeColor),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: const Duration(milliseconds: 600))
        .scale(begin: const Offset(0.95, 0.95));
  }

  Widget _buildLoadingState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 80,
          height: 12,
          decoration: BoxDecoration(
            color: AppColors.colorGrey200,
            borderRadius:
                BorderRadius.circular(4.0),
          ),
        )
            .animate(onPlay: (controller) => controller.repeat())
            .shimmer(duration: const Duration(milliseconds: 1500)),
        const SizedBox(height: 8.0),
        Container(
          width: 60,
          height: 24,
          decoration: BoxDecoration(
            color: AppColors.colorGrey200,
            borderRadius:
                BorderRadius.circular(4.0),
          ),
        )
            .animate(onPlay: (controller) => controller.repeat())
            .shimmer(duration: const Duration(milliseconds: 1500)),
      ],
    );
  }

  Widget _buildContent(Color cardColor, Color changeColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: cardColor,
                size: AppDimens.iconSizeSmall,
              ),
              const SizedBox(width: 8.0),
            ],
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: AppDimens.fontSizeSmall,
                  color: AppColors.colorFontSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (changePercentage != null)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: changeColor.withOpacity(0.1),
                  borderRadius:
                      BorderRadius.circular(4.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      (changePercentage ?? 0) >= 0
                          ? Icons.trending_up
                          : Icons.trending_down,
                      size: 12,
                      color: (changePercentage ?? 0) >= 0
                          ? AppColors.colorSuccess
                          : AppColors.colorWarning,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '${changePercentage!.abs().toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontSize: AppDimens.fontSizeXSmall,
                        color: changeColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          value,
          style: TextStyle(
            fontSize: AppDimens.fontSizeXXMedium,
            fontWeight: FontWeight.bold,
            color: AppColors.colorFontPrimary,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4.0),
          Text(
            subtitle!,
            style: const TextStyle(
              fontSize: AppDimens.fontSizeXSmall,
              color: AppColors.colorFontTertiary,
            ),
          ),
        ],
      ],
    );
  }
}

/// Enhanced section header with consistent styling
class EnhancedSectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? action;
  final EdgeInsets padding;

  const EnhancedSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.action,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 8.0,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: AppDimens.fontSizeXMedium,
                    fontWeight: FontWeight.bold,
                    color: AppColors.colorFontPrimary,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4.0),
                  Text(
                    subtitle!,
                    style: const TextStyle(
                      fontSize: AppDimens.fontSizeSmall,
                      color: AppColors.colorFontSecondary,
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

/// Enhanced empty state with better UX
class EnhancedEmptyState extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;
  final bool showIllustration;

  const EnhancedEmptyState({
    super.key,
    required this.title,
    required this.message,
    required this.icon,
    this.actionLabel,
    this.onAction,
    this.showIllustration = true,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showIllustration)
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.colorGrey100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 48,
                  color: AppColors.colorGrey400,
                ),
              )
                  .animate()
                  .scale(duration: const Duration(milliseconds: 600))
                  .then(delay: const Duration(milliseconds: 200))
                  .fadeIn(),
            const SizedBox(height: 24.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: AppDimens.fontSizeXMedium,
                fontWeight: FontWeight.w600,
                color: AppColors.colorFontPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            Text(
              message,
              style: const TextStyle(
                fontSize: AppDimens.fontSizeNormal,
                color: AppColors.colorFontSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 24.0),
              ElevatedButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.add),
                label: Text(actionLabel!),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,
                  foregroundColor: AppColors.colorWhite,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: const Duration(milliseconds: 800))
        .slideY(begin: 0.1, end: 0);
  }
}

/// Enhanced error state with retry functionality
class EnhancedErrorState extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onRetry;
  final String retryLabel;

  const EnhancedErrorState({
    super.key,
    required this.title,
    required this.message,
    this.onRetry,
    this.retryLabel = 'Try Again',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.colorWarning.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline,
                size: 48,
                color: AppColors.colorWarning,
              ),
            ),
            const SizedBox(height: 24.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: AppDimens.fontSizeXMedium,
                fontWeight: FontWeight.w600,
                color: AppColors.colorFontPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            Text(
              message,
              style: const TextStyle(
                fontSize: AppDimens.fontSizeNormal,
                color: AppColors.colorFontSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24.0),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(retryLabel),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,
                  foregroundColor: AppColors.colorWhite,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: const Duration(milliseconds: 600))
        .scale(begin: const Offset(0.8, 0.8));
  }
}
