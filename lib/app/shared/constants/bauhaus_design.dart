import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Bauhaus Design System
/// Implements functionalist design patterns with strong geometric forms and high contrast
class BauhausDesign {
  // ==================== COLORS ====================
  // Core Palette
  static const Color primary = Color(0xFFD12D21); // Fiery Red
  static const Color primaryRed = Color(0xFFD12D21); // Alias for primary
  static const Color secondary = Color(0xFF1A3BA0); // Royal Indigo
  static const Color primaryBlue = Color(0xFF1A3BA0); // Alias for secondary
  static const Color accent = Color(0xFFF4B513); // Tangerine/Yellow
  static const Color primaryYellow = Color(0xFFF4B513); // Alias for accent
  static const Color neutral = Color(0xFF1A1A1A); // Charcoal Black
  static const Color success = Color(0xFF0DA85E); // Emerald Bliss
  static const Color warning = Color(0xFFF4B513); // Warning Yellow
  static const Color error = Color(0xFFD32F2F); // Standard Error Red
  static const Color info = Color(0xFF2D6CDF); // Info Blue

  // Surface & Background
  static const Color background = Color(
    0xFFF7F5F0,
  ); // Alias for backgroundLight
  static const Color backgroundLight = Color(0xFFF7F5F0); // Cream Vest
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFFFFFFF); // Alias for surfaceWhite
  static const Color surfaceOffWhite = Color(0xFFEBE9E4);
  static const Color surfaceDark = Color(0xFF1E1E1E);

  // Text
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textLight = Color(0xFFF7F5F0);
  static const Color textMuted = Color(0xFF666666);
  static const Color textMedium = Color(0xFF666666); // Alias for textMuted

  // ==================== SPACING ====================
  // 4pt Grid System
  static const double space0_5 = 2.0;
  static const double space1 = 4.0; // xs
  static const double space2 = 8.0; // sm
  static const double space2_5 = 10.0; // between sm and md
  static const double space3 = 12.0;
  static const double space4 = 16.0; // md
  static const double space5 = 20.0;
  static const double space6 = 24.0; // lg
  static const double space8 = 32.0;
  static const double space10 = 40.0;
  static const double space12 = 48.0;
  static const double space16 = 64.0;

  // Layout heights
  static const double appBarCompactHeight = 54.0;
  static const double appBarExpandedHeight = 120.0;
  static const double panelPlaceholderHeight = 400.0;

  // ==================== BORDER RADIUS ====================
  static const double radiusXs = 0.0;
  static const double radiusSm = 0.0;
  static const double radiusMd = 0.0;
  static const double radiusLg = 0.0;
  static const double radiusXl = 0.0;
  static const double radiusFull = 0.0;
  static const double radiusPill = 0.0;

  // Border widths
  static const double borderThin = 1.0;
  static const double borderThick = 2.0;

  // ==================== FONT SIZES ====================
  static const double fontXxs =
      10.0; // Extra extra small (captions, fine print)
  static const double fontXs = 11.0; // Extra small (labels)
  static const double fontSm = 12.0; // Small
  static const double fontMd = 14.0; // Medium (body)
  static const double fontLg = 16.0; // Large
  static const double fontXl = 18.0; // Extra large
  static const double fontXxl = 20.0; // Display
  static const double iconMd = 18.0;

  // ==================== SHADOWS ====================
  static const Color shadowColor = Color(0xFF000000);

  static const BoxShadow shadowHard = BoxShadow(
    color: shadowColor,
    offset: Offset(4, 4),
    blurRadius: 0,
    spreadRadius: 0,
  );

  static const BoxShadow shadowHardSm = BoxShadow(
    color: shadowColor,
    offset: Offset(2, 2),
    blurRadius: 0,
    spreadRadius: 0,
  );

  static const BoxShadow shadowHardXs = BoxShadow(
    color: shadowColor,
    offset: Offset(1, 1),
    blurRadius: 0,
    spreadRadius: 0,
  );

  static const BoxShadow shadowHardLg = BoxShadow(
    color: shadowColor,
    offset: Offset(6, 6),
    blurRadius: 0,
    spreadRadius: 0,
  );

  static const List<BoxShadow> shadowSm = [
    BoxShadow(color: Color(0x0D000000), blurRadius: 2, offset: Offset(0, 1)),
  ];

  static const BoxShadow shadowSoft = BoxShadow(
    color: Color(0x1A000000),
    blurRadius: 8,
    offset: Offset(0, 2),
    spreadRadius: 0,
  );

  // ==================== NEO-BAUHAUS TOKENS ====================
  static const Color neoInk = Color(0xFF3B342A);
  static const Color neoPaper = surfaceWhite;
  static const Color neoSignal = info;
  static const Color neoDanger = primary;
  static const Color neoHighlight = accent;

  static const double neoBorderWidth = 2.5;
  static const double neoInnerBorderWidth = 1.5;

  static const BoxShadow shadowNeoCard = BoxShadow(
    color: neoInk,
    offset: Offset(8, 8),
    blurRadius: 0,
    spreadRadius: 0,
  );

  static const BoxShadow shadowNeoButton = BoxShadow(
    color: neoInk,
    offset: Offset(4, 4),
    blurRadius: 0,
    spreadRadius: 0,
  );

  static BoxDecoration neoCardDecoration({Color? backgroundColor}) {
    return BoxDecoration(
      color: backgroundColor ?? neoPaper,
      border: Border.all(
        color: neoInk.withValues(alpha: 0.78),
        width: neoBorderWidth,
      ),
      boxShadow: [
        BoxShadow(
          color: neoInk.withValues(alpha: 0.48),
          offset: const Offset(8, 8),
          blurRadius: 0,
          spreadRadius: 0,
        ),
      ],
    );
  }

  static BoxDecoration neoPanelDecoration({Color? backgroundColor}) {
    return BoxDecoration(
      color: backgroundColor ?? neoPaper,
      border: Border.all(
        color: neoInk.withValues(alpha: 0.58),
        width: neoInnerBorderWidth,
      ),
    );
  }

  static BoxDecoration neoSectionHeaderDecoration({
    Color? backgroundColor,
    bool lightShadow = false,
  }) {
    return BoxDecoration(
      color: backgroundColor ?? neoSignal,
      boxShadow: [
        BoxShadow(
          color: lightShadow ? neoPaper : neoInk,
          offset: const Offset(4, 4),
          blurRadius: 0,
        ),
      ],
    );
  }

  static TextStyle neoHeadingStyle(
    BuildContext context, {
    Color? color,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w700,
    double letterSpacing = 1.0,
  }) {
    return (getTextTheme(context).headlineMedium ?? const TextStyle()).copyWith(
      color: color ?? neoPaper,
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle neoMonoStyle(
    BuildContext context, {
    Color? color,
    double fontSize = 12,
    FontWeight fontWeight = FontWeight.w600,
    double letterSpacing = 0.0,
  }) {
    return GoogleFonts.robotoMono(
      color: color ?? textDark,
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
    );
  }

  // ==================== TYPOGRAPHY ====================
  static TextTheme getTextTheme(BuildContext context) {
    return GoogleFonts.interTextTheme(Theme.of(context).textTheme).copyWith(
      displayLarge: GoogleFonts.oswald(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: textDark,
      ),
      displayMedium: GoogleFonts.oswald(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: textDark,
      ),
      displaySmall: GoogleFonts.oswald(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: textDark,
      ),
      headlineLarge: GoogleFonts.oswald(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.4,
        color: textDark,
      ),
      headlineMedium: GoogleFonts.oswald(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.4,
        color: textDark,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: textDark,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: textDark,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        height: 1.4,
        color: textDark,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
        color: textMuted,
      ),
    );
  }

  static TextTheme getTextThemeBuilder(TextTheme base) {
    return base.copyWith(
      displayLarge: GoogleFonts.oswald(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: textLight,
      ),
      displayMedium: GoogleFonts.oswald(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: textLight,
      ),
      displaySmall: GoogleFonts.oswald(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: textLight,
      ),
      headlineLarge: GoogleFonts.oswald(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.4,
        color: textLight,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: textLight,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: textLight,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.4,
        color: textLight,
      ),
    );
  }

  // ==================== COMPONENT STYLES ====================
  static ButtonStyle get primaryButtonStyle => ElevatedButton.styleFrom(
    backgroundColor: primary,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: space6, vertical: space3),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radiusMd),
    ),
    elevation: 0,
    shadowColor: Colors.transparent,
  );

  static ButtonStyle get secondaryButtonStyle => OutlinedButton.styleFrom(
    foregroundColor: secondary,
    side: const BorderSide(color: secondary, width: 1.5),
    padding: const EdgeInsets.symmetric(horizontal: space6, vertical: space3),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radiusMd),
    ),
    elevation: 0,
  );

  // ==================== DECORATIONS ====================
  static BoxDecoration cardDecoration = BoxDecoration(
    color: surfaceWhite,
    borderRadius: BorderRadius.circular(radiusMd),
    border: Border.all(color: neutral, width: borderThick),
    boxShadow: const [shadowHard],
  );

  static BoxDecoration chipDecoration({
    bool selected = false,
    Color color = primary,
  }) {
    return BoxDecoration(
      color: selected ? color : surfaceWhite,
      borderRadius: BorderRadius.circular(radiusPill),
      border: Border.all(color: neutral, width: 1.5),
      boxShadow: selected ? [shadowHardSm] : [],
    );
  }

  // ==================== INPUT STYLES ====================
  static InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      filled: true,
      fillColor: surfaceWhite,
      hintText: hint,
      hintStyle: GoogleFonts.inter(color: textMuted),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: space4,
        vertical: space3,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSm),
        borderSide: const BorderSide(color: neutral, width: borderThick),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSm),
        borderSide: const BorderSide(color: neutral, width: borderThick),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSm),
        borderSide: const BorderSide(color: primary, width: borderThick),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSm),
        borderSide: const BorderSide(color: error, width: borderThick),
      ),
    );
  }

  static InputDecoration get defaultInputDecoration => InputDecoration(
    filled: true,
    fillColor: surfaceWhite,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: space4,
      vertical: space3,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radiusSm),
      borderSide: const BorderSide(color: neutral, width: borderThick),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radiusSm),
      borderSide: const BorderSide(color: neutral, width: borderThick),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radiusSm),
      borderSide: const BorderSide(color: primary, width: borderThick),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radiusSm),
      borderSide: const BorderSide(color: error, width: borderThick),
    ),
  );
}

// ==================== BAUHAUS BUTTON WIDGET ====================
/// Wrapper for Hard Shadow Buttons following Bauhaus design principles
class BauhausButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;
  final bool isFullWidth;

  const BauhausButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor = BauhausDesign.primary,
    this.textColor = Colors.white,
    this.icon,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        boxShadow: [BauhausDesign.shadowHard],
        border: Border.all(color: BauhausDesign.neutral, width: 1.5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space6,
              vertical: BauhausDesign.space3,
            ),
            child: Row(
              mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon, color: textColor, size: 20),
                  const SizedBox(width: 8),
                ],
                Text(
                  text,
                  style: GoogleFonts.inter(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
