import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';

/// Centralized theme configuration for the entire application
/// Contains all design tokens including colors, typography, spacing, shadows, etc.
class AppThemeConfig {
  // Private constructor to prevent instantiation
  AppThemeConfig._();

  // ==================== TYPOGRAPHY ====================

  /// Font families
  static const String primaryFontFamily = 'Roboto';
  static const String secondaryFontFamily = 'Inter';

  /// Font sizes
  static const double fontSizeExtraSmall = 10.0;
  static const double fontSizeSmall = 12.0;
  static const double fontSizeMedium = 14.0;
  static const double fontSizeRegular = 16.0;
  static const double fontSizeLarge = 18.0;
  static const double fontSizeExtraLarge = 20.0;
  static const double fontSizeXXL = 24.0;
  static const double fontSizeXXXL = 28.0;
  static const double fontSizeHeading = 32.0;
  static const double fontSizeTitle = 36.0;

  /// Font weights
  static const FontWeight fontWeightLight = FontWeight.w300;
  static const FontWeight fontWeightRegular = FontWeight.w400;
  static const FontWeight fontWeightMedium = FontWeight.w500;
  static const FontWeight fontWeightSemiBold = FontWeight.w600;
  static const FontWeight fontWeightBold = FontWeight.w700;
  static const FontWeight fontWeightExtraBold = FontWeight.w800;

  /// Text styles
  static const TextStyle headingStyle = TextStyle(
    fontSize: fontSizeHeading,
    fontWeight: fontWeightBold,
    color: AppColors.colorBlack,
    fontFamily: primaryFontFamily,
  );

  static const TextStyle titleStyle = TextStyle(
    fontSize: fontSizeXXXL,
    fontWeight: fontWeightSemiBold,
    color: AppColors.colorBlack,
    fontFamily: primaryFontFamily,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontSize: fontSizeLarge,
    fontWeight: fontWeightMedium,
    color: AppColors.colorGrey600,
    fontFamily: primaryFontFamily,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: fontSizeRegular,
    fontWeight: fontWeightRegular,
    color: AppColors.colorBlack,
    fontFamily: primaryFontFamily,
  );

  static const TextStyle captionStyle = TextStyle(
    fontSize: fontSizeSmall,
    fontWeight: fontWeightRegular,
    color: AppColors.colorGrey500,
    fontFamily: primaryFontFamily,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: fontSizeRegular,
    fontWeight: fontWeightSemiBold,
    color: AppColors.colorWhite,
    fontFamily: primaryFontFamily,
  );

  // ==================== SPACING ====================

  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;
  static const double spacingXXXL = 64.0;

  // ==================== BORDER RADIUS ====================

  static const double radiusXS = 4.0;
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 20.0;
  static const double radiusXXL = 24.0;
  static const double radiusCircular = 50.0;

  static const BorderRadius borderRadiusXS =
      BorderRadius.all(Radius.circular(radiusXS));
  static const BorderRadius borderRadiusS =
      BorderRadius.all(Radius.circular(radiusS));
  static const BorderRadius borderRadiusM =
      BorderRadius.all(Radius.circular(radiusM));
  static const BorderRadius borderRadiusL =
      BorderRadius.all(Radius.circular(radiusL));
  static const BorderRadius borderRadiusXL =
      BorderRadius.all(Radius.circular(radiusXL));
  static const BorderRadius borderRadiusXXL =
      BorderRadius.all(Radius.circular(radiusXXL));

  // ==================== SHADOWS ====================

  static const List<BoxShadow> shadowLight = [
    BoxShadow(
      color: AppColors.colorShadow,
      blurRadius: 4.0,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> shadowMedium = [
    BoxShadow(
      color: AppColors.colorShadow,
      blurRadius: 8.0,
      offset: Offset(0, 4),
    ),
  ];

  static const List<BoxShadow> shadowHeavy = [
    BoxShadow(
      color: AppColors.colorShadow,
      blurRadius: 16.0,
      offset: Offset(0, 8),
    ),
  ];

  // ==================== BUTTON STYLES ====================

  static final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.colorBlue,
    foregroundColor: AppColors.colorWhite,
    textStyle: buttonTextStyle,
    padding: const EdgeInsets.symmetric(
      horizontal: spacingL,
      vertical: spacingM,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: borderRadiusM,
    ),
    elevation: 2.0,
  );

  static final ButtonStyle secondaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.colorGrey100,
    foregroundColor: AppColors.colorBlack,
    textStyle: buttonTextStyle.copyWith(color: AppColors.colorBlack),
    padding: const EdgeInsets.symmetric(
      horizontal: spacingL,
      vertical: spacingM,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: borderRadiusM,
    ),
    elevation: 0.0,
  );

  static final ButtonStyle outlineButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: AppColors.colorBlue,
    textStyle: buttonTextStyle.copyWith(color: AppColors.colorBlue),
    padding: const EdgeInsets.symmetric(
      horizontal: spacingL,
      vertical: spacingM,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: borderRadiusM,
    ),
    side: const BorderSide(
      color: AppColors.colorBlue,
      width: 1.0,
    ),
  );

  static final ButtonStyle dangerButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.colorRed,
    foregroundColor: AppColors.colorWhite,
    textStyle: buttonTextStyle,
    padding: const EdgeInsets.symmetric(
      horizontal: spacingL,
      vertical: spacingM,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: borderRadiusM,
    ),
    elevation: 2.0,
  );

  static final ButtonStyle successButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.colorGreen,
    foregroundColor: AppColors.colorWhite,
    textStyle: buttonTextStyle,
    padding: const EdgeInsets.symmetric(
      horizontal: spacingL,
      vertical: spacingM,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: borderRadiusM,
    ),
    elevation: 2.0,
  );

  // ==================== INPUT DECORATION ====================

  static final InputDecoration inputDecoration = InputDecoration(
    filled: true,
    fillColor: AppColors.colorGrey50,
    border: OutlineInputBorder(
      borderRadius: borderRadiusM,
      borderSide: const BorderSide(
        color: AppColors.colorBorder,
        width: 1.0,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: borderRadiusM,
      borderSide: const BorderSide(
        color: AppColors.colorBorder,
        width: 1.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: borderRadiusM,
      borderSide: const BorderSide(
        color: AppColors.colorBlue,
        width: 2.0,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: borderRadiusM,
      borderSide: const BorderSide(
        color: AppColors.colorRed,
        width: 1.0,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: borderRadiusM,
      borderSide: const BorderSide(
        color: AppColors.colorRed,
        width: 2.0,
      ),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: spacingM,
      vertical: spacingM,
    ),
    hintStyle: captionStyle,
    errorStyle: captionStyle.copyWith(color: AppColors.colorRed),
  );

  // ==================== CARD DECORATION ====================

  static final BoxDecoration cardDecoration = BoxDecoration(
    color: AppColors.colorWhite,
    borderRadius: borderRadiusM,
    boxShadow: shadowLight,
    border: Border.all(
      color: AppColors.colorBorder,
      width: 1.0,
    ),
  );

  static final BoxDecoration elevatedCardDecoration = BoxDecoration(
    color: AppColors.colorWhite,
    borderRadius: borderRadiusL,
    boxShadow: shadowMedium,
  );

  // ==================== THEME DATA ====================

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: primaryFontFamily,

      // Color scheme
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.colorBlue,
        brightness: Brightness.light,
        primary: AppColors.colorBlue,
        secondary: AppColors.colorGreen,
        error: AppColors.colorRed,
        surface: AppColors.colorWhite,
        background: AppColors.colorGrey50,
      ),

      // App bar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.colorWhite,
        foregroundColor: AppColors.colorBlack,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: titleStyle,
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: primaryButtonStyle,
      ),

      // Outlined button theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: outlineButtonStyle,
      ),

      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.colorBlue,
          textStyle: buttonTextStyle.copyWith(color: AppColors.colorBlue),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.colorGrey50,
        border: inputDecoration.border,
        enabledBorder: inputDecoration.enabledBorder,
        focusedBorder: inputDecoration.focusedBorder,
        errorBorder: inputDecoration.errorBorder,
        focusedErrorBorder: inputDecoration.focusedErrorBorder,
        contentPadding: inputDecoration.contentPadding,
        hintStyle: inputDecoration.hintStyle,
        errorStyle: inputDecoration.errorStyle,
      ),

      // Card theme
      cardTheme: CardThemeData(
        color: AppColors.colorWhite,
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadiusM,
        ),
      ),

      // Divider theme
      dividerTheme: const DividerThemeData(
        color: AppColors.colorDivider,
        thickness: 1.0,
      ),

      // Text theme
      textTheme: const TextTheme(
        headlineLarge: headingStyle,
        headlineMedium: titleStyle,
        headlineSmall: subtitleStyle,
        bodyLarge: bodyStyle,
        bodyMedium: bodyStyle,
        bodySmall: captionStyle,
        labelLarge: buttonTextStyle,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: primaryFontFamily,

      // Color scheme
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.colorBlue,
        brightness: Brightness.dark,
        primary: AppColors.colorBlue,
        secondary: AppColors.colorGreen,
        error: AppColors.colorRed,
        surface: AppColors.colorGrey800,
        background: AppColors.colorBlack,
      ),

      // App bar theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.colorGrey800,
        foregroundColor: AppColors.colorWhite,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: titleStyle.copyWith(color: AppColors.colorWhite),
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: primaryButtonStyle,
      ),

      // Outlined button theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: outlineButtonStyle,
      ),

      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.colorBlue,
          textStyle: buttonTextStyle.copyWith(color: AppColors.colorBlue),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.colorGrey700,
        border: inputDecoration.border?.copyWith(
          borderSide: const BorderSide(color: AppColors.colorGrey600),
        ),
        enabledBorder: inputDecoration.enabledBorder?.copyWith(
          borderSide: const BorderSide(color: AppColors.colorGrey600),
        ),
        focusedBorder: inputDecoration.focusedBorder,
        errorBorder: inputDecoration.errorBorder,
        focusedErrorBorder: inputDecoration.focusedErrorBorder,
        contentPadding: inputDecoration.contentPadding,
        hintStyle: captionStyle.copyWith(color: AppColors.colorGrey400),
        errorStyle: captionStyle.copyWith(color: AppColors.colorRed),
      ),

      // Card theme
      cardTheme: CardThemeData(
        color: AppColors.colorGrey800,
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadiusM,
        ),
      ),

      // Divider theme
      dividerTheme: const DividerThemeData(
        color: AppColors.colorGrey600,
        thickness: 1.0,
      ),

      // Text theme
      textTheme: TextTheme(
        headlineLarge: headingStyle.copyWith(color: AppColors.colorWhite),
        headlineMedium: titleStyle.copyWith(color: AppColors.colorWhite),
        headlineSmall: subtitleStyle.copyWith(color: AppColors.colorGrey300),
        bodyLarge: bodyStyle.copyWith(color: AppColors.colorWhite),
        bodyMedium: bodyStyle.copyWith(color: AppColors.colorWhite),
        bodySmall: captionStyle.copyWith(color: AppColors.colorGrey400),
        labelLarge: buttonTextStyle,
      ),
    );
  }
}
