// Alias file for backward compatibility
// Maps BauhausColors to BauhausDesign properties
import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';

class BauhausColors {
  // Core colors
  static const Color primaryRed = BauhausDesign.primary;
  static const Color primaryBlue = BauhausDesign.secondary;
  static const Color primaryYellow = BauhausDesign.accent;
  
  // Accent colors
  static const Color accentGreen = BauhausDesign.success;
  static const Color accentOrange = BauhausDesign.warning;
  static const Color accentPurple = BauhausDesign.info;
  
  // Text colors
  static const Color textDark = BauhausDesign.textDark;
  static const Color textMedium = BauhausDesign.textMuted;
  static const Color textLight = BauhausDesign.textLight;
  
  // Background colors
  static const Color background = BauhausDesign.background;
  static const Color backgroundLight = BauhausDesign.backgroundLight;
  static const Color surface = BauhausDesign.surfaceWhite;
}
