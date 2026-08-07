import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BauhausTheme {
  // Primary Bauhaus Palette
  static const Color red = Color(0xFFD02020);
  static const Color blue = Color(0xFF1D55C0);
  static const Color yellow = Color(0xFFF0C520);
  static const Color black = Color(0xFF1A1A1A);
  static const Color white = Colors.white;
  static const Color textDark = Color(0xFF1A1A1A);

  // Text Styles
  static TextStyle get headerStyle => GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w900,
    color: textDark,
    height: 1.2,
  );

  static TextStyle get subHeaderStyle => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: textDark,
  );

  static TextStyle get bodyStyle => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: textDark,
  );

  static TextStyle get labelStyle => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: textDark,
    letterSpacing: 0.5,
  );

  // Layout Constants
  static const double borderWidth = 2.0;
  static const EdgeInsets blockPadding = EdgeInsets.all(16.0);
  static const BorderRadius zeroRadius = BorderRadius.zero;

  // Shadows (None, as per rules, but just in case we need elevation simulation via border)
  static BoxDecoration blockDecoration = BoxDecoration(
    color: white,
    border: Border.all(color: black, width: borderWidth),
    borderRadius: zeroRadius,
  );
}
