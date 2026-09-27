import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:carenest/app/shared/constants/values/themes/app_theme_config.dart';

class AppTheme {
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: AppThemeConfig.fontSizeExtraLarge,
      color: BauhausDesign.textDark,
      fontWeight: AppThemeConfig.fontWeightSemiBold,
      fontFamily: 'Space Mono',
    ),
    decoration: BoxDecoration(
      border: Border.all(color: BauhausDesign.neutral, width: 2.5),
      borderRadius: BorderRadius.zero,
    ),
  );

  static ThemeData get lightTheme => BauhausDesign.lightTheme;
  static ThemeData get darkTheme => BauhausDesign.darkTheme;

  static ThemeData themeData = BauhausDesign.lightTheme;
}
