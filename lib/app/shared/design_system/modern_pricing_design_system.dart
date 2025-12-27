import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';

/// Chip variants for different visual styles
enum ModernChipVariant {
  primary,
  secondary,
  success,
  warning,
  error,
  info,
  outlined,
  outline,
}

/// Action button variants
enum ModernActionButtonVariant {
  primary,
  secondary,
  success,
  warning,
  error,
  info,
  ghost,
  danger,
}

/// Modern design system for pricing features with enhanced UX/UI
class ModernPricingDesign {
  // Enhanced color palette
  static const Color primaryGradientStart = Color(0xFF667eea);
  static const Color primaryGradientEnd = Color(0xFF764ba2);
  static const Color successGradientStart = Color(0xFF11998e);
  static const Color successGradientEnd = Color(0xFF38ef7d);
  static const Color warningGradientStart = Color(0xFFf093fb);
  static const Color warningGradientEnd = Color(0xFFf5576c);
  static const Color infoGradientStart = Color(0xFF4facfe);
  static const Color infoGradientEnd = Color(0xFF00f2fe);

  // Primary colors
  static const Color primaryColor = Color(0xFF667eea);
  static const Color secondaryColor = Color(0xFF764ba2);
  static const Color successColor = Color(0xFF11998e);
  static const Color errorColor = Color(0xFFf5576c);
  static const Color warningColor = Color(0xFFf093fb);
  static const Color infoColor = Color(0xFF4facfe);

  // Accent colors
  static const Color accentBlue = Color(0xFF4facfe);
  static const Color accentGreen = Color(0xFF11998e);
  static const Color accentRed = Color(0xFFf5576c);
  static const Color accentOrange = Color(0xFFf093fb);

  // Text colors
  static const Color textPrimary = Color(0xFF1a1a1a);
  static const Color textSecondary = Color(0xFF6b7280);
  static const Color textTertiary = Color(0xFF9ca3af);

  // Surface colors
  static const Color surfacePrimary = Color(0xFFFAFBFC);
  static const Color surfaceSecondary = Color(0xFFF8F9FA);
  static const Color surfaceCard = Color(0xFFFFFFFF);
  static const Color surfaceElevated = Color(0xFFFFFFFF);
  static const Color surfaceOverlay = Color(0x1A000000);
  static const Color backgroundPrimary = Color(0xFFFAFBFC);

  // Border colors
  static const Color borderColor = Color(0xFFe5e7eb);

  // Gradient collections
  static const List<Color> primaryGradient = [
    primaryGradientStart,
    primaryGradientEnd
  ];
  static const List<Color> successGradient = [
    successGradientStart,
    successGradientEnd
  ];
  static const List<Color> warningGradient = [
    warningGradientStart,
    warningGradientEnd
  ];
  static const List<Color> infoGradient = [infoGradientStart, infoGradientEnd];

  // Card shadows
  static const List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 10,
      offset: Offset(0, 4),
      spreadRadius: 0,
    ),
  ];

  // Enhanced spacing system
  static const double spacing2xs = 2.0;
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;
  static const double spacing2xl = 48.0;
  static const double spacing3xl = 64.0;

  // Enhanced border radius system
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 20.0;
  static const double radius2xl = 24.0;
  static const double radiusRound = 50.0;

  // Enhanced elevation system
  static const double elevationNone = 0.0;
  static const double elevationXs = 1.0;
  static const double elevationSm = 2.0;
  static const double elevationMd = 4.0;
  static const double elevationLg = 8.0;
  static const double elevationXl = 12.0;
  static const double elevation2xl = 16.0;

  // Animation durations
  static const Duration animationFast = Duration(milliseconds: 150);
  static const Duration animationMedium = Duration(milliseconds: 300);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);

  // Typography scale
  static const TextStyle headingXl = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.2,
  );

  static const TextStyle headingLg = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.3,
    height: 1.3,
  );

  static const TextStyle headingMd = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
    height: 1.4,
  );

  static const TextStyle headingSm = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static const TextStyle bodyLg = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static const TextStyle bodyMd = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static const TextStyle bodySm = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 0.5,
  );
}

/// Modern gradient card with enhanced visual appeal
class ModernGradientCard extends StatelessWidget {
  final Widget child;
  final List<Color> gradientColors;
  final double borderRadius;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  final bool showShadow;
  final double elevation;

  const ModernGradientCard({
    super.key,
    required this.child,
    required this.gradientColors,
    this.borderRadius = ModernPricingDesign.radiusMd,
    this.padding = const EdgeInsets.all(ModernPricingDesign.spacingMd),
    this.onTap,
    this.showShadow = true,
    this.elevation = ModernPricingDesign.elevationMd,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: showShadow
                ? [
                    BoxShadow(
                      color: gradientColors.first.withValues(alpha: 0.3),
                      blurRadius: elevation * 2,
                      offset: Offset(0, elevation),
                      spreadRadius: 0,
                    ),
                  ]
                : null,
          ),
          child: child,
        ),
      ),
    )
        .animate()
        .fadeIn(duration: ModernPricingDesign.animationNormal)
        .slideY(begin: 0.1, end: 0);
  }
}

/// Modern empty state widget
class ModernEmptyState extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final Widget? action;

  const ModernEmptyState({
    super.key,
    required this.title,
    required this.message,
    this.icon = Icons.inbox,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(ModernPricingDesign.spacingXl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: ModernPricingDesign.textSecondary,
            ),
            const SizedBox(height: ModernPricingDesign.spacingLg),
            Text(
              title,
              style: ModernPricingDesign.headingLg.copyWith(
                color: ModernPricingDesign.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: ModernPricingDesign.spacingMd),
            Text(
              message,
              style: ModernPricingDesign.bodyMd.copyWith(
                color: ModernPricingDesign.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (action != null) ...[
              const SizedBox(height: ModernPricingDesign.spacingLg),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

/// Modern checkbox widget
class ModernCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final Color? activeColor;
  final Color? checkColor;

  const ModernCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.activeColor,
    this.checkColor,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
            if (states.contains(WidgetState.disabled)) {
              return null;
            }
            if (states.contains(WidgetState.selected)) {
              return activeColor ?? ModernPricingDesign.primaryColor;
            }
            return null;
          }),
          checkColor: WidgetStateProperty.all(checkColor ?? Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ModernPricingDesign.radiusSm),
          ),
        ),
      ),
      child: Checkbox(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}

/// Modern glass morphism card
class ModernGlassCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  final double opacity;
  final Color backgroundColor;

  const ModernGlassCard({
    super.key,
    required this.child,
    this.borderRadius = ModernPricingDesign.radiusMd,
    this.padding = const EdgeInsets.all(ModernPricingDesign.spacingMd),
    this.onTap,
    this.opacity = 0.1,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: backgroundColor.withValues(alpha: opacity),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: backgroundColor.withValues(alpha: 0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: ModernPricingDesign.elevationLg,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: child,
        ),
      ),
    )
        .animate()
        .fadeIn(duration: ModernPricingDesign.animationNormal)
        .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1));
  }
}

/// Modern stat card with enhanced visual hierarchy
class ModernStatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData icon;
  final List<Color> gradientColors;
  final double? changePercentage;
  final VoidCallback? onTap;
  final bool isLoading;

  const ModernStatCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    required this.icon,
    required this.gradientColors,
    this.changePercentage,
    this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final isPositiveChange = changePercentage != null && changePercentage! > 0;
    final changeColor = isPositiveChange
        ? ModernPricingDesign.successGradientStart
        : ModernPricingDesign.warningGradientStart;

    return ModernGlassCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(ModernPricingDesign.spacingSm),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius:
                      BorderRadius.circular(ModernPricingDesign.radiusSm),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const Spacer(),
              if (changePercentage != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: ModernPricingDesign.spacingSm,
                    vertical: ModernPricingDesign.spacingXs,
                  ),
                  decoration: BoxDecoration(
                    color: changeColor.withValues(alpha: 0.1),
                    borderRadius:
                        BorderRadius.circular(ModernPricingDesign.radiusXs),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isPositiveChange
                            ? Icons.trending_up
                            : Icons.trending_down,
                        color: changeColor,
                        size: 12,
                      ),
                      const SizedBox(width: ModernPricingDesign.spacingXs),
                      Text(
                        '${changePercentage!.abs().toStringAsFixed(1)}%',
                        style: ModernPricingDesign.caption.copyWith(
                          color: changeColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: ModernPricingDesign.spacingMd),
          if (isLoading)
            Container(
              height: 24,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius:
                    BorderRadius.circular(ModernPricingDesign.radiusXs),
              ),
            )
          else
            Text(
              value,
              style: ModernPricingDesign.headingLg.copyWith(
                color: AppColors.colorFontPrimary,
              ),
            ),
          const SizedBox(height: ModernPricingDesign.spacingXs),
          Text(
            title,
            style: ModernPricingDesign.bodyMd.copyWith(
              color: AppColors.colorFontSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: ModernPricingDesign.spacingXs),
            Text(
              subtitle!,
              style: ModernPricingDesign.bodySm.copyWith(
                color: AppColors.colorFontSecondary.withValues(alpha: 0.7),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Modern action button with enhanced visual feedback
class ModernActionButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final List<Color>? gradientColors;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final EdgeInsets padding;
  final bool isLoading;
  final bool isOutlined;
  final double elevation;
  final ModernActionButtonVariant? variant;

  const ModernActionButton({
    super.key,
    this.text,
    this.onPressed,
    this.icon,
    this.gradientColors,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = ModernPricingDesign.radiusMd,
    this.padding = const EdgeInsets.symmetric(
      horizontal: ModernPricingDesign.spacingLg,
      vertical: ModernPricingDesign.spacingMd,
    ),
    this.isLoading = false,
    this.isOutlined = false,
    this.elevation = ModernPricingDesign.elevationSm,
    this.variant,
  });

  @override
  Widget build(BuildContext context) {
    // Handle variant-based styling
    Color variantBackgroundColor;
    Color variantTextColor;
    bool variantIsOutlined = isOutlined;

    switch (variant) {
      case ModernActionButtonVariant.primary:
        variantBackgroundColor = ModernPricingDesign.primaryColor;
        variantTextColor = Colors.white;
        break;
      case ModernActionButtonVariant.secondary:
        variantBackgroundColor = ModernPricingDesign.secondaryColor;
        variantTextColor = Colors.white;
        break;
      case ModernActionButtonVariant.success:
        variantBackgroundColor = ModernPricingDesign.successColor;
        variantTextColor = Colors.white;
        break;
      case ModernActionButtonVariant.warning:
        variantBackgroundColor = ModernPricingDesign.warningColor;
        variantTextColor = Colors.white;
        break;
      case ModernActionButtonVariant.error:
      case ModernActionButtonVariant.danger:
        variantBackgroundColor = ModernPricingDesign.errorColor;
        variantTextColor = Colors.white;
        break;
      case ModernActionButtonVariant.info:
        variantBackgroundColor = ModernPricingDesign.infoColor;
        variantTextColor = Colors.white;
        break;
      case ModernActionButtonVariant.ghost:
        variantBackgroundColor = Colors.transparent;
        variantTextColor = ModernPricingDesign.primaryColor;
        variantIsOutlined = true;
        break;
      default:
        variantBackgroundColor = backgroundColor ?? AppColors.colorPrimary;
        variantTextColor = Colors.white;
    }

    final effectiveGradientColors = gradientColors ??
        [
          variantBackgroundColor,
          variantBackgroundColor,
        ];

    final effectiveTextColor =
        textColor ?? (variantIsOutlined ? variantTextColor : variantTextColor);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            gradient: variantIsOutlined
                ? null
                : LinearGradient(
                    colors: effectiveGradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            color: variantIsOutlined
                ? Colors.transparent
                : (backgroundColor ?? variantBackgroundColor),
            borderRadius: BorderRadius.circular(borderRadius),
            border: variantIsOutlined
                ? Border.all(
                    color: variantTextColor,
                    width: 1.5,
                  )
                : null,
            boxShadow: !variantIsOutlined && elevation > 0
                ? [
                    BoxShadow(
                      color:
                          effectiveGradientColors.first.withValues(alpha: 0.3),
                      blurRadius: elevation * 2,
                      offset: Offset(0, elevation),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(effectiveTextColor),
                  ),
                )
              else if (icon != null)
                Icon(
                  icon,
                  color: effectiveTextColor,
                  size: 18,
                ),
              if ((icon != null || isLoading) &&
                  text != null &&
                  text!.isNotEmpty)
                const SizedBox(width: ModernPricingDesign.spacingSm),
              if (text != null && text!.isNotEmpty)
                Text(
                  text!,
                  style: ModernPricingDesign.bodyMd.copyWith(
                    color: effectiveTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ),
      ),
    )
        .animate(target: onPressed != null ? 1 : 0)
        .scale(begin: const Offset(1, 1), end: const Offset(1.02, 1.02));
  }
}

/// Modern search bar with enhanced UX
class ModernSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback? onClear;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const ModernSearchBar({
    super.key,
    required this.controller,
    this.hintText = 'Search...',
    this.onClear,
    this.onChanged,
    this.onSubmitted,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ModernPricingDesign.surfaceElevated,
        borderRadius: BorderRadius.circular(ModernPricingDesign.radiusMd),
        border: Border.all(
          color: AppColors.colorGrey300.withValues(alpha: 0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: ModernPricingDesign.elevationSm,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: ModernPricingDesign.bodyMd.copyWith(
            color: AppColors.colorFontSecondary.withValues(alpha: 0.6),
          ),
          prefixIcon: prefixIcon ??
              const Icon(
                Icons.search,
                color: AppColors.colorFontSecondary,
              ),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: AppColors.colorFontSecondary,
                  ),
                  onPressed: () {
                    controller.clear();
                    onClear?.call();
                  },
                )
              : suffixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: ModernPricingDesign.spacingMd,
            vertical: ModernPricingDesign.spacingMd,
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: ModernPricingDesign.animationNormal)
        .slideX(begin: -0.1, end: 0);
  }
}

/// Modern chip with enhanced visual appeal
class ModernChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  final IconData? icon;
  final Color? selectedColor;
  final Color? unselectedColor;
  final ModernChipVariant? variant;

  const ModernChip({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onTap,
    this.icon,
    this.selectedColor,
    this.unselectedColor,
    this.variant,
  });

  @override
  Widget build(BuildContext context) {
    Color effectiveSelectedColor;
    Color effectiveUnselectedColor;
    bool isOutlined = false;

    switch (variant) {
      case ModernChipVariant.primary:
        effectiveSelectedColor = ModernPricingDesign.primaryColor;
        effectiveUnselectedColor =
            ModernPricingDesign.primaryColor.withValues(alpha: 0.1);
        break;
      case ModernChipVariant.secondary:
        effectiveSelectedColor = ModernPricingDesign.secondaryColor;
        effectiveUnselectedColor =
            ModernPricingDesign.secondaryColor.withValues(alpha: 0.1);
        break;
      case ModernChipVariant.success:
        effectiveSelectedColor = ModernPricingDesign.successColor;
        effectiveUnselectedColor =
            ModernPricingDesign.successColor.withValues(alpha: 0.1);
        break;
      case ModernChipVariant.warning:
        effectiveSelectedColor = ModernPricingDesign.warningColor;
        effectiveUnselectedColor =
            ModernPricingDesign.warningColor.withValues(alpha: 0.1);
        break;
      case ModernChipVariant.error:
        effectiveSelectedColor = ModernPricingDesign.errorColor;
        effectiveUnselectedColor =
            ModernPricingDesign.errorColor.withValues(alpha: 0.1);
        break;
      case ModernChipVariant.info:
        effectiveSelectedColor = ModernPricingDesign.infoColor;
        effectiveUnselectedColor =
            ModernPricingDesign.infoColor.withValues(alpha: 0.1);
        break;
      case ModernChipVariant.outlined:
      case ModernChipVariant.outline:
        effectiveSelectedColor = ModernPricingDesign.primaryColor;
        effectiveUnselectedColor = Colors.transparent;
        isOutlined = true;
        break;
      default:
        effectiveSelectedColor = selectedColor ?? AppColors.colorPrimary;
        effectiveUnselectedColor = unselectedColor ?? AppColors.colorGrey200;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(ModernPricingDesign.radiusRound),
        child: AnimatedContainer(
          duration: ModernPricingDesign.animationFast,
          padding: const EdgeInsets.symmetric(
            horizontal: ModernPricingDesign.spacingMd,
            vertical: ModernPricingDesign.spacingSm,
          ),
          decoration: BoxDecoration(
            color:
                isSelected ? effectiveSelectedColor : effectiveUnselectedColor,
            borderRadius:
                BorderRadius.circular(ModernPricingDesign.radiusRound),
            border: Border.all(
              color: isOutlined || isSelected
                  ? effectiveSelectedColor
                  : effectiveUnselectedColor.withValues(alpha: 0.5),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 16,
                  color: isSelected
                      ? Colors.white
                      : (isOutlined
                          ? effectiveSelectedColor
                          : AppColors.colorFontSecondary),
                ),
                const SizedBox(width: ModernPricingDesign.spacingXs),
              ],
              Text(
                label,
                style: ModernPricingDesign.bodySm.copyWith(
                  color: isSelected
                      ? Colors.white
                      : (isOutlined
                          ? effectiveSelectedColor
                          : AppColors.colorFontSecondary),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate(target: isSelected ? 1 : 0)
        .scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05));
  }
}