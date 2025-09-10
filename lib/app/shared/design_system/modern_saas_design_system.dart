import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Modern SAAS Design System for Pricing Dashboard
/// Implements contemporary design patterns with mobile-first responsive approach
class ModernSaasDesign {
  // Modern Color Palette - Professional SAAS Colors
  static const Color primary = Color(0xFF3B82F6); // Modern Blue
  static const Color primaryDark = Color(0xFF1E40AF); // Darker Blue
  static const Color primaryLight = Color(0xFF93C5FD); // Light Blue

  static const Color secondary = Color(0xFF10B981); // Emerald Green
  static const Color secondaryDark = Color(0xFF047857); // Dark Green
  static const Color secondaryLight = Color(0xFF6EE7B7); // Light Green

  static const Color accent = Color(0xFFF59E0B); // Amber
  static const Color accentDark = Color(0xFFD97706); // Dark Amber
  static const Color accentLight = Color(0xFFFDE68A); // Light Amber

  static const Color error = Color(0xFFEF4444); // Red
  static const Color errorDark = Color(0xFFDC2626); // Dark Red
  static const Color errorLight = Color(0xFFFECACA); // Light Red

  static const Color warning = Color(0xFFF97316); // Orange
  static const Color success = Color(0xFF10B981); // Green
  static const Color info = Color(0xFF3B82F6); // Blue

  // Neutral Colors - Modern Gray Scale
  static const Color neutral50 = Color(0xFFF8FAFC);
  static const Color neutral100 = Color(0xFFF1F5F9);
  static const Color neutral200 = Color(0xFFE2E8F0);
  static const Color neutral300 = Color(0xFFCBD5E1);
  static const Color neutral400 = Color(0xFF94A3B8);
  static const Color neutral500 = Color(0xFF64748B);
  static const Color neutral600 = Color(0xFF475569);
  static const Color neutral700 = Color(0xFF334155);
  static const Color neutral800 = Color(0xFF1E293B);
  static const Color neutral900 = Color(0xFF0F172A);

  // Surface Colors
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF8FAFC);
  static const Color surfaceTintColor = Color(0x00000000);
  static const Color background = Color(0xFFF8FAFC);
  static const Color backgroundSecondary = Color(0xFFF1F5F9);

  // Additional background colors from UnifiedDesignSystem
  static const Color backgroundPrimary = Color(0xFFFFFFFF);
  static const Color backgroundTertiary = Color(0xFFF1F5F9);
  static const Color onSurface = Color(0xFF1E293B);
  static const Color onSurfaceVariant = Color(0xFF64748B);

  // Text Colors
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textTertiary = Color(0xFF94A3B8);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Border Colors
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderLight = Color(0xFFF1F5F9);
  static const Color borderFocus = Color(0xFF3B82F6);

  // Admin Dashboard Colors - From admin_dashboard_view.dart
  static const Color adminErrorRed = Color(0xFFDC2626); // Error state
  static const Color adminSuccessGreen = Color(0xFF059669); // Success state
  static const Color adminPurpleBlue = Color(0xFF667EEA); // Purple-blue accent
  static const Color adminSlate800 = Color(0xFF1E293B); // Dark slate
  static const Color adminSlate700 = Color(0xFF334155); // Medium slate
  static const Color adminSlate600 = Color(0xFF475569); // Light slate
  static const Color adminBrightBlue = Color(0xFF3B82F6); // Bright blue
  static const Color adminCyan = Color(0xFF06B6D4); // Cyan accent
  static const Color adminDangerRed = Color(0xFFEF4444); // Danger/alert red
  static const Color adminEmergencyGreen = Color(0xFF10B981); // Emergency green
  static const Color adminPurpleGradient = Color(0xFF764BA2); // Purple gradient
  static const Color adminViolet = Color(0xFF8B5CF6); // Violet
  static const Color adminAmber = Color(0xFFF59E0B); // Amber/yellow
  static const Color adminLightBlue = Color(0xFF4FACFE); // Light blue gradient
  static const Color adminAqua = Color(0xFF00F2FE); // Aqua gradient
  static const Color adminIndigo = Color(0xFF3F51B5); // Indigo
  static const Color adminDeepBlue = Color(0xFF2563EB); // Deep blue
  static const Color adminPink = Color(0xFFEC4899); // Pink
  static const Color adminPurple = Color(0xFF8B5CF6); // Purple
  static const Color adminTeal = Color(0xFF06B6D4); // Teal
  static const Color adminCrimson = Color(0xFFEF4444); // Crimson
  static const Color adminMagenta = Color(0xFF9C27B0); // Magenta
  static const Color adminLimeGreen = Color(0xFF4CAF50); // Lime green
  static const Color adminDarkGray = Color(0xFF111827); // Dark gray
  static const Color adminMediumGray = Color(0xFF6B7280); // Medium gray
  static const Color adminLavender = Color(0xFF6C5CE7); // Lavender

  // Additional Colors from UnifiedDesignSystem
  static const Color softErrorBackground =
      Color(0xFFEF4444); // From invoice_email_view.dart
  static const Color darkText =
      Color(0xFF111827); // From admin_dashboard_view.dart
  static const Color adminWarningOrange = Color(0xFFF59E0B);
  static const Color adminInfoBlue = Color(0xFF2563EB);
  static const Color adminTealGreen = Color(0xFF0D9488);
  static const Color adminEmerald = Color(0xFF10B981);
  static const Color adminLime = Color(0xFF84CC16);
  static const Color adminRose = Color(0xFFF43F5E);
  static const Color adminSky = Color(0xFF0EA5E9);
  static const Color adminOrange = Color(0xFFF97316);
  static const Color adminSlate = Color(0xFF64748B);
  static const Color adminGray = Color(0xFF6B7280);
  static const Color adminZinc = Color(0xFF71717A);
  static const Color adminStone = Color(0xFF78716C);
  static const Color adminNeutral = Color(0xFF737373);

  // Light variants
  static const Color adminErrorLight = Color(0xFFFEE2E2);
  static const Color adminSuccessLight = Color(0xFFD1FAE5);
  static const Color adminWarningLight = Color(0xFFFEF3C7);
  static const Color adminInfoLight = Color(0xFFDBEAFE);
  static const Color adminPurpleLight = Color(0xFFF3E8FF);
  static const Color adminTealLight = Color(0xFFCCFBF1);
  static const Color adminPinkLight = Color(0xFFF8BBD9);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF3B82F6), Color(0xFF1E40AF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF047857)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient warningGradient = LinearGradient(
    colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF8FAFC)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, secondary],
  );

  // Admin Dashboard Gradients - From admin_dashboard_view.dart
  static const LinearGradient adminPurpleBlueGradient = LinearGradient(
    colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient adminAquaGradient = LinearGradient(
    colors: [Color(0xFF4FACFE), Color(0xFF00F2FE)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient adminSlateGradient = LinearGradient(
    colors: [Color(0xFF1E293B), Color(0xFF334155), Color(0xFF475569)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient adminBlueAccentGradient = LinearGradient(
    colors: [Color(0xFF3B82F6), Color(0xFF06B6D4)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Typography Scale - Modern Font Sizes
  static const TextStyle displayLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.2,
    color: textPrimary,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.3,
    height: 1.3,
    color: textPrimary,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
    height: 1.3,
    color: textPrimary,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.1,
    height: 1.4,
    color: textPrimary,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: textPrimary,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: textPrimary,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: textSecondary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: textTertiary,
  );

  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: textPrimary,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.3,
    color: textSecondary,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 1.2,
    color: textTertiary,
  );

  // Spacing System - 8pt Grid
  static const double space1 = 4.0;
  static const double space2 = 8.0;
  static const double space3 = 12.0;
  static const double space4 = 16.0;
  static const double space5 = 20.0;
  static const double space6 = 24.0;
  static const double space8 = 32.0;
  static const double space10 = 40.0;
  static const double space12 = 48.0;
  static const double space16 = 64.0;
  static const double space20 = 80.0;

  // Spacing aliases from UnifiedDesignSystem
  static const double spacing1 = 4.0;
  static const double spacing2 = 8.0;
  static const double spacing3 = 12.0;
  static const double spacing4 = 16.0;
  static const double spacing5 = 20.0;
  static const double spacing6 = 24.0;
  static const double spacing8 = 32.0;
  static const double spacing10 = 40.0;
  static const double spacing12 = 48.0;
  static const double spacing16 = 64.0;
  static const double spacing20 = 80.0;
  static const double spacing24 = 24.0;
  static const double spacing56 = 56.0;

  // Border Radius
  static const double radiusXs = 4.0;
  static const double radiusSm = 6.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 12.0;
  static const double radiusXl = 16.0;
  static const double radius2xl = 20.0;
  static const double radius3xl = 24.0;
  static const double radiusFull = 9999.0;

  // Legacy radius constants from UnifiedDesignSystem
  static const double radiusSmall = 4.0;
  static const double radiusMedium = 8.0;
  static const double radiusLarge = 12.0;
  static const double radiusXLarge = 16.0;
  static const double radiusXXLarge = 24.0;

  // Border Radius objects
  static const BorderRadius borderRadiusSmall =
      BorderRadius.all(Radius.circular(radiusSmall));
  static const BorderRadius borderRadiusMedium =
      BorderRadius.all(Radius.circular(radiusMedium));
  static const BorderRadius borderRadiusLarge =
      BorderRadius.all(Radius.circular(radiusLarge));
  static const BorderRadius borderRadiusXLarge =
      BorderRadius.all(Radius.circular(radiusXLarge));
  static const BorderRadius borderRadiusXXLarge =
      BorderRadius.all(Radius.circular(radiusXXLarge));

  // Elevation & Shadows
  static const List<BoxShadow> shadowSm = [
    BoxShadow(
      color: Color(0x0D000000),
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
  ];

  static const List<BoxShadow> shadowMd = [
    BoxShadow(
      color: Color(0x0F000000),
      blurRadius: 6,
      offset: Offset(0, 4),
      spreadRadius: -1,
    ),
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 4,
      offset: Offset(0, 2),
      spreadRadius: -2,
    ),
  ];

  static const List<BoxShadow> shadowLg = [
    BoxShadow(
      color: Color(0x0F000000),
      blurRadius: 15,
      offset: Offset(0, 10),
      spreadRadius: -3,
    ),
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 6,
      offset: Offset(0, 4),
      spreadRadius: -2,
    ),
  ];

  static const List<BoxShadow> shadowXl = [
    BoxShadow(
      color: Color(0x19000000),
      blurRadius: 25,
      offset: Offset(0, 20),
      spreadRadius: -5,
    ),
    BoxShadow(
      color: Color(0x0F000000),
      blurRadius: 10,
      offset: Offset(0, 8),
      spreadRadius: -6,
    ),
  ];

  // Additional shadow variants from UnifiedDesignSystem
  static const List<BoxShadow> shadowSmall = [
    BoxShadow(
      color: Color(0x0F000000),
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> shadowMedium = [
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -1,
    ),
    BoxShadow(
      color: Color(0x0F000000),
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: -1,
    ),
  ];

  static const List<BoxShadow> shadowLarge = [
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 10),
      blurRadius: 15,
      spreadRadius: -3,
    ),
    BoxShadow(
      color: Color(0x0F000000),
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -2,
    ),
  ];

  // Animation Durations
  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationNormal = Duration(milliseconds: 300);
  static const Duration durationSlow = Duration(milliseconds: 500);

  // Breakpoints for Responsive Design
  static const double breakpointSm = 640;
  static const double breakpointMd = 768;
  static const double breakpointLg = 1024;
  static const double breakpointXl = 1280;

  // Helper Methods
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < breakpointMd;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= breakpointMd && width < breakpointLg;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= breakpointLg;
  }

  static int getGridColumns(BuildContext context) {
    if (isMobile(context)) return 2;
    if (isTablet(context)) return 3;
    return 4;
  }

  static double getCardWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final columns = getGridColumns(context);
    final spacing = space4 * (columns + 1);
    return (screenWidth - spacing) / columns;
  }

  // ==================== COMPONENT STYLES FROM UNIFIED DESIGN SYSTEM ====================

  static BoxDecoration cardDecoration = BoxDecoration(
    color: surface,
    borderRadius: borderRadiusLarge,
    boxShadow: shadowMedium,
  );

  static BoxDecoration elevatedCardDecoration = BoxDecoration(
    color: surface,
    borderRadius: borderRadiusLarge,
    boxShadow: shadowLarge,
  );

  static InputDecoration inputDecoration({
    String? labelText,
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: borderRadiusMedium,
        borderSide: const BorderSide(color: neutral300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadiusMedium,
        borderSide: const BorderSide(color: neutral300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadiusMedium,
        borderSide: const BorderSide(color: primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: borderRadiusMedium,
        borderSide: const BorderSide(color: error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: borderRadiusMedium,
        borderSide: const BorderSide(color: error, width: 2),
      ),
      filled: true,
      fillColor: backgroundSecondary,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: spacing16,
        vertical: spacing12,
      ),
    );
  }

  // ==================== BUTTON STYLES ====================
  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primary,
    foregroundColor: textOnPrimary,
    elevation: 0,
    padding: const EdgeInsets.symmetric(
      horizontal: spacing24,
      vertical: spacing12,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: borderRadiusMedium,
    ),
    textStyle: labelLarge,
  );

  static ButtonStyle secondaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: backgroundSecondary,
    foregroundColor: neutral700,
    elevation: 0,
    padding: const EdgeInsets.symmetric(
      horizontal: spacing24,
      vertical: spacing12,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: borderRadiusMedium,
      side: const BorderSide(color: neutral300),
    ),
    textStyle: labelLarge,
  );
}

/// Modern Card Widget with Glass Morphism Effect
class ModernCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Color? backgroundColor;
  final Border? border;
  final VoidCallback? onTap;
  final bool isGlass;

  const ModernCard({
    Key? key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.boxShadow,
    this.backgroundColor,
    this.border,
    this.onTap,
    this.isGlass = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget card = Container(
      padding: padding ?? const EdgeInsets.all(ModernSaasDesign.space4),
      margin: margin,
      decoration: BoxDecoration(
        color: isGlass
            ? ModernSaasDesign.surface.withValues(alpha: 0.8)
            : backgroundColor ?? ModernSaasDesign.surface,
        borderRadius: BorderRadius.circular(
          borderRadius ?? ModernSaasDesign.radiusLg,
        ),
        boxShadow: boxShadow ?? ModernSaasDesign.shadowMd,
        border: border ??
            Border.all(
              color: ModernSaasDesign.border,
              width: 1,
            ),
      ),
      child: child,
    );

    if (onTap != null) {
      card = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(
            borderRadius ?? ModernSaasDesign.radiusLg,
          ),
          child: card,
        ),
      );
    }

    return card;
  }
}

/// Modern Button with Multiple Variants
class ModernButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final ButtonVariant variant;
  final ButtonSize size;
  final double? width;

  const ModernButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = _getColors();
    final dimensions = _getDimensions();

    return SizedBox(
      width: width,
      height: dimensions.height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.background,
          foregroundColor: colors.foreground,
          elevation: variant == ButtonVariant.ghost ? 0 : 2,
          shadowColor: colors.background.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ModernSaasDesign.radiusMd),
            side: variant == ButtonVariant.outline
                ? BorderSide(color: colors.background)
                : BorderSide.none,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: dimensions.paddingHorizontal,
            vertical: dimensions.paddingVertical,
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: dimensions.iconSize,
                height: dimensions.iconSize,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(colors.foreground),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: dimensions.iconSize),
                    SizedBox(width: ModernSaasDesign.space2),
                  ],
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: dimensions.fontSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  _ButtonColors _getColors() {
    switch (variant) {
      case ButtonVariant.primary:
        return _ButtonColors(
          background: ModernSaasDesign.primary,
          foreground: ModernSaasDesign.textOnPrimary,
        );
      case ButtonVariant.secondary:
        return _ButtonColors(
          background: ModernSaasDesign.secondary,
          foreground: ModernSaasDesign.textOnPrimary,
        );
      case ButtonVariant.outline:
        return _ButtonColors(
          background: Colors.transparent,
          foreground: ModernSaasDesign.primary,
        );
      case ButtonVariant.ghost:
        return _ButtonColors(
          background: Colors.transparent,
          foreground: ModernSaasDesign.textSecondary,
        );
      case ButtonVariant.danger:
        return _ButtonColors(
          background: ModernSaasDesign.error,
          foreground: ModernSaasDesign.textOnPrimary,
        );
    }
  }

  _ButtonDimensions _getDimensions() {
    switch (size) {
      case ButtonSize.small:
        return _ButtonDimensions(
          height: 32,
          paddingHorizontal: ModernSaasDesign.space3,
          paddingVertical: ModernSaasDesign.space1,
          fontSize: 12,
          iconSize: 16,
        );
      case ButtonSize.medium:
        return _ButtonDimensions(
          height: 40,
          paddingHorizontal: ModernSaasDesign.space4,
          paddingVertical: ModernSaasDesign.space2,
          fontSize: 14,
          iconSize: 18,
        );
      case ButtonSize.large:
        return _ButtonDimensions(
          height: 48,
          paddingHorizontal: ModernSaasDesign.space6,
          paddingVertical: ModernSaasDesign.space3,
          fontSize: 16,
          iconSize: 20,
        );
    }
  }
}

class _ButtonColors {
  final Color background;
  final Color foreground;

  _ButtonColors({required this.background, required this.foreground});
}

class _ButtonDimensions {
  final double height;
  final double paddingHorizontal;
  final double paddingVertical;
  final double fontSize;
  final double iconSize;

  _ButtonDimensions({
    required this.height,
    required this.paddingHorizontal,
    required this.paddingVertical,
    required this.fontSize,
    required this.iconSize,
  });
}

enum ButtonVariant { primary, secondary, outline, ghost, danger }

enum ButtonSize { small, medium, large }
