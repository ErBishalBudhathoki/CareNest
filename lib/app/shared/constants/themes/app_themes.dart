import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:flutter/material.dart';

/// The single source of truth for app theming.
///
/// Both modes are the Bauhaus system ([BauhausDesign]); the retired
/// `AppThemeConfig` / `AppColors` legacy themes have been removed.
class AppTheme {
  static ThemeData get lightTheme => BauhausDesign.lightTheme;
  static ThemeData get darkTheme => BauhausDesign.darkTheme;

  static ThemeData themeData = BauhausDesign.lightTheme;
}
