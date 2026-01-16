import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Bauhaus Design System
/// Implements functionalist design patterns with strong geometric forms and high contrast
class BauhausDesign {
  // ==================== COLORS ====================
  // Core Palette
  static const Color primary = Color(0xFFD12D21); // Fiery Red
  static const Color secondary = Color(0xFF1A3BA0); // Royal Indigo
  static const Color accent = Color(0xFFF4B513); // Tangerine/Yellow tone
  static const Color neutral = Color(0xFF1A1A1A); // Charcoal Black
  static const Color success = Color(0xFF0DA85E); // Emerald Bliss
  static const Color warning = Color(0xFFF4B513); // Using Accent/Yellow for warning
  static const Color error = Color(0xFFD32F2F); // Standard Error Red

  
  // Surface & Background
  static const Color backgroundLight = Color(0xFFF7F5F0); // Cream Vest
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  
  // Text
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textLight = Color(0xFFF7F5F0);

  // ==================== SPACING ====================
  // 4pt Grid System
  static const double space1 = 4.0;  // xs
  static const double space2 = 8.0;  // sm
  static const double space3 = 12.0;
  static const double space4 = 16.0; // md
  static const double space5 = 20.0;
  static const double space6 = 24.0; // lg
  static const double space8 = 32.0;
  static const double space10 = 40.0;
  static const double space12 = 48.0;
  static const double space16 = 64.0;

  // ==================== BORDER RADIUS ====================
  static const double radiusXs = 2.0;
  static const double radiusSm = 4.0;
  static const double radiusMd = 12.0; // Default
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  static const double radiusFull = 999.0;

  // ==================== SHADOWS ====================
  static const Color shadowColor = Color(0xFF000000);
  static const BoxShadow shadowHard = BoxShadow(
    color: shadowColor,
    offset: Offset(4, 4),
    blurRadius: 0,
    spreadRadius: 0,
  );

  static const BoxShadow shadowHardSm = BoxShadow(
    color: Color(0xFF000000),
    offset: Offset(2, 2),
    blurRadius: 0,
    spreadRadius: 0,
  );

  static const BoxShadow shadowHardXs = BoxShadow(
    color: Color(0xFF000000),
    offset: Offset(1, 1),
    blurRadius: 0,
    spreadRadius: 0,
  );

  static const List<BoxShadow> shadowSm = [
    BoxShadow(
      color: Color(0x0D000000),
      blurRadius: 2,
      offset: Offset(0, 1),
    )
  ];

  // ==================== TYPOGRAPHY ====================
  static TextTheme getTextTheme(BuildContext context) {
    return GoogleFonts.interTextTheme(
      Theme.of(context).textTheme,
    ).copyWith(
      displayLarge: GoogleFonts.oswald(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.2,
      ),
      displayMedium: GoogleFonts.oswald(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
      displaySmall: GoogleFonts.oswald(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
      headlineLarge: GoogleFonts.oswald(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.4,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.4,
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

  static BoxDecoration cardDecoration = BoxDecoration(
    color: surfaceLight,
    borderRadius: BorderRadius.circular(radiusMd),
    border: Border.all(color: neutral, width: 2), // Bold border
    boxShadow: [shadowHard],
  );

  static InputDecoration inputDecoration = InputDecoration(
    filled: true,
    fillColor: backgroundLight,
    contentPadding: const EdgeInsets.symmetric(horizontal: space4, vertical: space3),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radiusMd),
      borderSide: const BorderSide(color: neutral, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radiusMd),
      borderSide: const BorderSide(color: neutral, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radiusMd),
      borderSide: const BorderSide(color: primary, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radiusMd),
      borderSide: const BorderSide(color: primary, width: 2), // Red border for error
    ),
  );
  static TextTheme getTextThemeBuilder(TextTheme base) {
    return base.copyWith(
      displayLarge: GoogleFonts.oswald(fontSize: 32, fontWeight: FontWeight.w700, height: 1.2, color: textLight),
      displayMedium: GoogleFonts.oswald(fontSize: 28, fontWeight: FontWeight.w600, height: 1.3, color: textLight),
      displaySmall: GoogleFonts.oswald(fontSize: 24, fontWeight: FontWeight.w600, height: 1.3, color: textLight),
      headlineLarge: GoogleFonts.oswald(fontSize: 20, fontWeight: FontWeight.w600, height: 1.4, color: textLight),
      bodyLarge: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400, height: 1.5, color: textLight),
      bodyMedium: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, height: 1.5, color: textLight),
      labelLarge: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, height: 1.4, color: textLight),
    );
  }
}

// Wrapper for Hard Shadow Buttons
class BauhausButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;

  const BauhausButton({
    super.key, 
    required this.text, 
    this.onPressed,
    this.backgroundColor = BauhausDesign.primary,
    this.textColor = Colors.white,
    this.icon,
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
              vertical: BauhausDesign.space3
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
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
