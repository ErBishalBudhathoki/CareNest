import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class BauhausDesign {
  static const Color primary = Color(0xFFFFC300);
  static const Color primaryDeep = Color(0xFF785A00);
  static const Color primaryRed = Color(0xFFE63946);
  static const Color secondary = Color(0xFF028090);
  static const Color secondaryDeep = Color(0xFF006876);
  static const Color primaryBlue = Color(0xFF1D4ED8);
  static const Color accent = Color(0xFFE63946);
  static const Color tertiary = Color(0xFFE63946);
  static const Color primaryYellow = Color(0xFFFFC300);
  static const Color neutral = Color(0xFF1A1A1A);
  static const Color success = Color(0xFF028090);
  static const Color warning = Color(0xFFFFC300);
  static const Color error = Color(0xFFE63946);
  static const Color info = Color(0xFF1D4ED8);

  static const Color background = Color(0xFFFFF9E6);
  static const Color backgroundLight = Color(0xFFFFF9E6);
  static const Color backgroundDark = Color(0xFF1C1B1B);
  static const Color surfaceWhite = Color(0xFFFFFCF5);
  static const Color surfaceLight = Color(0xFFFFFCF5);
  static const Color surfaceDim = Color(0xFFE5D4AF);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFFBF4DE);
  static const Color surfaceContainer = Color(0xFFF5E9CE);
  static const Color surfaceContainerHigh = Color(0xFFEFE0C2);
  static const Color surfaceContainerHighest = Color(0xFFE8D8B5);
  static const Color surfaceVariant = Color(0xFFF8EED6);
  static const Color surfaceOffWhite = Color(0xFFF5E9CE);
  static const Color surfaceDark = Color(0xFF313030);
  static const Color surfaceDarkest = Color(0xFF1C1B1B);

  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textLight = Color(0xFFF3F0EF);
  static const Color textMuted = Color(0xFF3D3728);
  static const Color textMutedDark = Color(0xFFD3C5AB);
  static const Color textMedium = Color(0xFF3D3728);

  static const double space0_5 = 2.0;
  static const double space1 = 4.0;
  static const double space2 = 8.0;
  static const double space2_5 = 10.0;
  static const double space3 = 12.0;
  static const double space4 = 16.0;
  static const double space5 = 20.0;
  static const double space6 = 24.0;
  static const double space8 = 32.0;
  static const double space10 = 40.0;
  static const double space12 = 48.0;
  static const double space16 = 64.0;

  static const double appBarCompactHeight = 54.0;
  static const double appBarExpandedHeight = 120.0;
  static const double panelPlaceholderHeight = 400.0;

  static const double radiusXs = 0.0;
  static const double radiusSm = 0.0;
  static const double radiusMd = 0.0;
  static const double radiusLg = 0.0;
  static const double radiusXl = 0.0;
  static const double radiusFull = 0.0;
  static const double radiusPill = 0.0;

  static const double borderThin = 2.0;
  static const double borderThick = 2.5;

  static const double fontXxs = 10.0;
  static const double fontXs = 11.0;
  static const double fontSm = 12.0;
  static const double fontMd = 14.0;
  static const double fontLg = 16.0;
  static const double fontXl = 18.0;
  static const double fontXxl = 20.0;
  static const double iconMd = 18.0;

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
  static const List<BoxShadow> shadowSm = [shadowHardSm];
  static const BoxShadow shadowSoft = BoxShadow(
    color: shadowColor,
    offset: Offset(0, 2),
    blurRadius: 0,
    spreadRadius: 0,
  );

  static const Color neoInk = Color(0xFF000000);
  static const Color neoPaper = surfaceWhite;
  static const Color neoSignal = secondary;
  static const Color neoDanger = tertiary;
  static const Color neoHighlight = primary;
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
      border: Border.all(color: neoInk, width: neoBorderWidth),
      boxShadow: const [shadowNeoCard],
    );
  }

  static BoxDecoration neoPanelDecoration({Color? backgroundColor}) {
    return BoxDecoration(
      color: backgroundColor ?? neoPaper,
      border: Border.all(color: neoInk, width: neoInnerBorderWidth),
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

  /// Returns ink or paper for a glyph or label sitting on [background] so the
  /// colour plane keeps a readable contrast ratio in both brightness modes.
  ///
  /// Use this whenever a foreground is chosen from a *literal* palette colour
  /// (accent blocks, status chips, category headers) rather than from a themed
  /// surface. `colorScheme.onSurface`/`onSurfaceVariant` are correct only for
  /// themed surfaces; they are meaningless next to a fixed accent.
  static Color readableOnColor(Color background) {
    return background.computeLuminance() > 0.45 ? textDark : textLight;
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
    return GoogleFonts.spaceMono(
      color:
          color ??
          (Theme.of(context).brightness == Brightness.dark
              ? textLight
              : textDark),
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
    );
  }

  static TextTheme _buildTextTheme(
    TextTheme base,
    Color textColor,
    Color mutedTextColor,
  ) {
    return GoogleFonts.spaceMonoTextTheme(base).copyWith(
      displayLarge: GoogleFonts.bricolageGrotesque(
        fontSize: 56,
        fontWeight: FontWeight.w800,
        height: 60 / 56,
        letterSpacing: -0.04 * 14,
        color: textColor,
      ),
      displayMedium: GoogleFonts.bricolageGrotesque(
        fontSize: 36,
        fontWeight: FontWeight.w800,
        height: 40 / 36,
        letterSpacing: -0.03 * 36,
        color: textColor,
      ),
      displaySmall: GoogleFonts.bricolageGrotesque(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 32 / 28,
        letterSpacing: -0.02 * 28,
        color: textColor,
      ),
      headlineLarge: GoogleFonts.bricolageGrotesque(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        height: 44 / 40,
        letterSpacing: -0.03 * 40,
        color: textColor,
      ),
      headlineMedium: GoogleFonts.bricolageGrotesque(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 32 / 28,
        letterSpacing: -0.02 * 28,
        color: textColor,
      ),
      headlineSmall: GoogleFonts.bricolageGrotesque(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        height: 24 / 20,
        letterSpacing: -0.01 * 20,
        color: textColor,
      ),
      titleLarge: GoogleFonts.bricolageGrotesque(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        height: 24 / 20,
        color: textColor,
      ),
      titleMedium: GoogleFonts.bricolageGrotesque(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 20 / 16,
        color: textColor,
      ),
      titleSmall: GoogleFonts.bricolageGrotesque(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        height: 18 / 14,
        color: textColor,
      ),
      bodyLarge: GoogleFonts.spaceMono(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 24 / 16,
        letterSpacing: -0.01 * 16,
        color: textColor,
      ),
      bodyMedium: GoogleFonts.spaceMono(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 20 / 14,
        color: textColor,
      ),
      bodySmall: GoogleFonts.spaceMono(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 16 / 12,
        color: mutedTextColor,
      ),
      labelLarge: GoogleFonts.spaceMono(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        height: 16 / 13,
        letterSpacing: 0.06 * 13,
        color: textColor,
      ),
      labelMedium: GoogleFonts.spaceMono(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        height: 16 / 12,
        color: textColor,
      ),
      labelSmall: GoogleFonts.spaceMono(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        height: 14 / 11,
        letterSpacing: 0.08 * 11,
        color: mutedTextColor,
      ),
    );
  }

  static TextTheme getTextTheme(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return _buildTextTheme(
      theme.textTheme,
      isDark ? theme.colorScheme.onSurface : theme.colorScheme.onSurface,
      isDark
          ? theme.colorScheme.onSurfaceVariant
          : theme.colorScheme.onSurfaceVariant,
    );
  }

  static TextTheme getTextThemeBuilder(TextTheme base) {
    return _buildTextTheme(base, textLight, textMutedDark);
  }

  static TextTheme get lightTextTheme {
    return _buildTextTheme(
      GoogleFonts.spaceMonoTextTheme(ThemeData.light().textTheme),
      textDark,
      textMuted,
    );
  }

  static TextTheme get darkTextTheme {
    return _buildTextTheme(
      GoogleFonts.spaceMonoTextTheme(ThemeData.dark().textTheme),
      textLight,
      textMutedDark,
    );
  }

  static ThemeData get lightTheme {
    const border = BorderSide(color: neoInk, width: borderThick);
    const shape = RoundedRectangleBorder(borderRadius: BorderRadius.zero);
    const colorScheme = ColorScheme.light(
      primary: primary,
      onPrimary: textDark,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: colorWhite,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: secondaryDeep,
      tertiary: tertiary,
      onTertiary: colorWhite,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: tertiaryDeep,
      error: error,
      onError: colorWhite,
      errorContainer: errorContainer,
      onErrorContainer: errorDeep,
      surface: surfaceWhite,
      onSurface: textDark,
      onSurfaceVariant: textMuted,
      outline: neoInk,
      outlineVariant: outlineVariant,
      inverseSurface: inverseSurface,
      onInverseSurface: textLight,
      inversePrimary: inversePrimary,
      surfaceTint: primaryDeep,
      surfaceContainerLowest: surfaceContainerLowest,
      surfaceContainerLow: surfaceContainerLow,
      surfaceContainer: surfaceContainer,
      surfaceContainerHigh: surfaceContainerHigh,
      surfaceContainerHighest: surfaceContainerHighest,
    );
    final textTheme = lightTextTheme;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: backgroundLight,
      canvasColor: backgroundLight,
      fontFamily: 'Space Mono',
      textTheme: textTheme,
      splashFactory: InkRipple.splashFactory,
      appBarTheme: AppBarTheme(
        backgroundColor: inverseSurface,
        foregroundColor: textLight,
        elevation: 0,
        centerTitle: true,
        shadowColor: neoInk,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: textTheme.titleLarge?.copyWith(color: textLight),
        iconTheme: const IconThemeData(color: textLight),
        actionsIconTheme: const IconThemeData(color: textLight),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: textDark,
          elevation: 0,
          minimumSize: const Size(48, 44),
          padding: const EdgeInsets.symmetric(
            horizontal: space6,
            vertical: space3,
          ),
          side: border,
          shape: shape,
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryBlue,
          minimumSize: const Size(48, 44),
          padding: const EdgeInsets.symmetric(
            horizontal: space6,
            vertical: space3,
          ),
          side: const BorderSide(color: primaryBlue, width: borderThick),
          shape: shape,
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryBlue,
          minimumSize: const Size(48, 44),
          padding: const EdgeInsets.symmetric(
            horizontal: space4,
            vertical: space2,
          ),
          shape: shape,
          textStyle: textTheme.labelLarge,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: textDark,
          minimumSize: const Size(40, 40),
          shape: shape,
          side: const BorderSide(color: primaryBlue, width: borderThick),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceWhite,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: space4,
          vertical: space3,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: border,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: border,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: primaryBlue, width: borderThick),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: error, width: borderThick),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: error, width: borderThick),
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(color: textMuted),
        errorStyle: textTheme.bodySmall?.copyWith(color: error),
      ),
      cardTheme: CardThemeData(
        color: surfaceWhite,
        elevation: 0,
        margin: EdgeInsets.zero,
        shadowColor: neoInk,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: border,
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surfaceWhite,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: border,
        ),
        titleTextStyle: textTheme.headlineSmall?.copyWith(color: textDark),
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: textDark),
      ),
      menuTheme: MenuThemeData(
        style: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(surfaceWhite),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
              side: border,
            ),
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surfaceWhite,
        elevation: 0,
        indicatorColor: primary,
        indicatorShape: shape,
        labelTextStyle: WidgetStatePropertyAll(textTheme.labelMedium),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          return IconThemeData(
            color: states.contains(WidgetState.selected) ? textDark : textDark,
          );
        }),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: surfaceWhite,
        elevation: 0,
        indicatorColor: primary,
        indicatorShape: shape,
        labelType: NavigationRailLabelType.all,
        selectedIconTheme: const IconThemeData(color: textDark),
        unselectedIconTheme: const IconThemeData(color: textDark),
        selectedLabelTextStyle: textTheme.labelMedium?.copyWith(
          color: textDark,
        ),
        unselectedLabelTextStyle: textTheme.labelMedium?.copyWith(
          color: textDark,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: neoInk,
        thickness: borderThick,
        space: borderThick,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: surfaceWhite,
        selectedColor: primary,
        disabledColor: surfaceOffWhite,
        labelStyle: textTheme.labelLarge,
        secondaryLabelStyle: textTheme.labelLarge?.copyWith(color: textDark),
        side: border,
        shape: shape,
        padding: const EdgeInsets.symmetric(
          horizontal: space3,
          vertical: space2,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: textDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: border,
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: primary,
        linearTrackColor: surfaceOffWhite,
        circularTrackColor: surfaceOffWhite,
        borderRadius: BorderRadius.zero,
      ),
      snackBarTheme: SnackBarThemeData(
        elevation: 0,
        backgroundColor: inverseSurface,
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: textLight),
        actionTextColor: primary,
        behavior: SnackBarBehavior.floating,
        shape: shape,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: const BoxDecoration(
          color: inverseSurface,
          borderRadius: BorderRadius.zero,
        ),
        textStyle: textTheme.bodySmall?.copyWith(color: textLight),
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: border,
        ),
        textColor: textDark,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: primary,
        selectionColor: surfaceDim,
        selectionHandleColor: primary,
      ),
    );
  }

  static ThemeData get darkTheme {
    const border = BorderSide(color: neoInk, width: borderThick);
    const shape = RoundedRectangleBorder(borderRadius: BorderRadius.zero);
    const colorScheme = ColorScheme.dark(
      primary: primary,
      onPrimary: textDark,
      primaryContainer: primaryFixed,
      onPrimaryContainer: onPrimaryFixed,
      secondary: secondary,
      onSecondary: textLight,
      secondaryContainer: secondaryFixed,
      onSecondaryContainer: textLight,
      tertiary: tertiary,
      onTertiary: textLight,
      tertiaryContainer: tertiaryFixed,
      onTertiaryContainer: tertiaryFixedDeep,
      error: error,
      onError: textLight,
      errorContainer: errorContainer,
      onErrorContainer: errorDeep,
      surface: surfaceDark,
      onSurface: textLight,
      onSurfaceVariant: textMutedDark,
      outline: neoInk,
      outlineVariant: outlineVariant,
      inverseSurface: surfaceDarkest,
      onInverseSurface: textLight,
      inversePrimary: primary,
      surfaceTint: primary,
      surfaceContainerLowest: surfaceDarkest,
      surfaceContainerLow: surfaceDark,
      surfaceContainer: surfaceDark,
      surfaceContainerHigh: surfaceDark,
      surfaceContainerHighest: surfaceDark,
    );
    final textTheme = darkTextTheme;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: backgroundDark,
      canvasColor: backgroundDark,
      fontFamily: 'Space Mono',
      textTheme: textTheme,
      splashFactory: InkRipple.splashFactory,
      appBarTheme: AppBarTheme(
        backgroundColor: surfaceDarkest,
        foregroundColor: textLight,
        elevation: 0,
        centerTitle: true,
        shadowColor: neoInk,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: textTheme.titleLarge?.copyWith(color: textLight),
        iconTheme: const IconThemeData(color: textLight),
        actionsIconTheme: const IconThemeData(color: textLight),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: textDark,
          elevation: 0,
          minimumSize: const Size(48, 44),
          padding: const EdgeInsets.symmetric(
            horizontal: space6,
            vertical: space3,
          ),
          side: border,
          shape: shape,
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textLight,
          minimumSize: const Size(48, 44),
          padding: const EdgeInsets.symmetric(
            horizontal: space6,
            vertical: space3,
          ),
          side: const BorderSide(color: textLight, width: borderThick),
          shape: shape,
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          minimumSize: const Size(48, 44),
          padding: const EdgeInsets.symmetric(
            horizontal: space4,
            vertical: space2,
          ),
          shape: shape,
          textStyle: textTheme.labelLarge,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: textLight,
          minimumSize: const Size(40, 40),
          shape: shape,
          side: const BorderSide(color: primaryBlue, width: borderThick),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceDark,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: space4,
          vertical: space3,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: border,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: border,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: primaryBlue, width: borderThick),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: error, width: borderThick),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: error, width: borderThick),
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(color: textMutedDark),
        errorStyle: textTheme.bodySmall?.copyWith(color: errorContainer),
      ),
      cardTheme: CardThemeData(
        color: surfaceDark,
        elevation: 0,
        margin: EdgeInsets.zero,
        shadowColor: neoInk,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: border,
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surfaceDark,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: border,
        ),
        titleTextStyle: textTheme.headlineSmall?.copyWith(color: textLight),
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: textLight),
      ),
      menuTheme: MenuThemeData(
        style: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(surfaceDark),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
              side: border,
            ),
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surfaceDark,
        elevation: 0,
        indicatorColor: primary,
        indicatorShape: shape,
        labelTextStyle: WidgetStatePropertyAll(textTheme.labelMedium),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          return IconThemeData(color: textLight);
        }),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: surfaceDark,
        elevation: 0,
        indicatorColor: primary,
        indicatorShape: shape,
        labelType: NavigationRailLabelType.all,
        selectedIconTheme: const IconThemeData(color: textLight),
        unselectedIconTheme: const IconThemeData(color: textLight),
        selectedLabelTextStyle: textTheme.labelMedium?.copyWith(
          color: textLight,
        ),
        unselectedLabelTextStyle: textTheme.labelMedium?.copyWith(
          color: textLight,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: textLight,
        thickness: borderThick,
        space: borderThick,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: surfaceDark,
        selectedColor: primary,
        disabledColor: surfaceDarkest,
        labelStyle: textTheme.labelLarge?.copyWith(color: textLight),
        secondaryLabelStyle: textTheme.labelLarge?.copyWith(color: textDark),
        side: const BorderSide(color: textLight, width: borderThick),
        shape: shape,
        padding: const EdgeInsets.symmetric(
          horizontal: space3,
          vertical: space2,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: textDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: border,
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: primary,
        linearTrackColor: surfaceDarkest,
        circularTrackColor: surfaceDarkest,
        borderRadius: BorderRadius.zero,
      ),
      snackBarTheme: SnackBarThemeData(
        elevation: 0,
        backgroundColor: surfaceDarkest,
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: textLight),
        actionTextColor: primary,
        behavior: SnackBarBehavior.floating,
        shape: shape,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: const BoxDecoration(
          color: surfaceDarkest,
          borderRadius: BorderRadius.zero,
        ),
        textStyle: textTheme.bodySmall?.copyWith(color: textLight),
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: border,
        ),
        textColor: textLight,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: primary,
        selectionColor: secondaryContainer,
        selectionHandleColor: primary,
      ),
    );
  }

  static ButtonStyle get primaryButtonStyle => ElevatedButton.styleFrom(
    backgroundColor: primary,
    foregroundColor: textDark,
    padding: const EdgeInsets.symmetric(horizontal: space6, vertical: space3),
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    side: const BorderSide(color: neoInk, width: borderThick),
    elevation: 0,
  );

  static ButtonStyle get secondaryButtonStyle => OutlinedButton.styleFrom(
    foregroundColor: primaryBlue,
    side: const BorderSide(color: primaryBlue, width: borderThick),
    padding: const EdgeInsets.symmetric(horizontal: space6, vertical: space3),
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    elevation: 0,
  );

  /// Hard-edged card plane: zero radius, 2.5px border, opaque hard shadow.
  ///
  /// Takes [context] so the fill and border follow the active theme. The
  /// previous constant `cardDecoration` was hardcoded to `surfaceWhite`, which
  /// rendered a white card in dark mode.
  static BoxDecoration cardDecorationFor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BoxDecoration(
      color: colorScheme.surface,
      borderRadius: BorderRadius.zero,
      border: Border.all(color: colorScheme.onSurface, width: borderThick),
      boxShadow: const [shadowHard],
    );
  }

  /// Hard-edged chip plane. Unselected follows the theme; selected uses
  /// [color] with a luminance-safe glyph from [readableOnColor].
  static BoxDecoration chipDecorationFor(
    BuildContext context, {
    bool selected = false,
    Color color = primary,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return BoxDecoration(
      color: selected ? color : colorScheme.surface,
      borderRadius: BorderRadius.zero,
      border: Border.all(color: colorScheme.onSurface, width: 1.5),
      boxShadow: selected ? const [shadowHardSm] : const [],
    );
  }

  /// [inputDecorationFor] with a hint applied.
  static InputDecoration inputDecoration(BuildContext context, String hint) {
    return inputDecorationFor(context).copyWith(hintText: hint);
  }

  /// Hard-edged, zero-radius input decoration.
  ///
  /// Takes [context] so the fill, borders and label/hint colours follow the
  /// active theme. A hardcoded `surfaceWhite` fill rendered a white field with
  /// golden hint text in dark mode, which was unreadable.
  static InputDecoration inputDecorationFor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    OutlineInputBorder border(Color color) => OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: color, width: borderThick),
    );

    return InputDecoration(
      filled: true,
      fillColor: colorScheme.surface,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: space4,
        vertical: space3,
      ),
      labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
      floatingLabelStyle: TextStyle(color: colorScheme.onSurface),
      hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
      prefixIconColor: colorScheme.onSurfaceVariant,
      suffixIconColor: colorScheme.onSurfaceVariant,
      iconColor: colorScheme.onSurfaceVariant,
      border: border(colorScheme.onSurface),
      enabledBorder: border(colorScheme.onSurface),
      focusedBorder: border(colorScheme.primary),
      errorBorder: border(colorScheme.error),
      focusedErrorBorder: border(colorScheme.error),
      disabledBorder: border(colorScheme.onSurface.withValues(alpha: 0.3)),
    );
  }
}

class BauhausButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color? textColor;
  final IconData? icon;
  final bool isFullWidth;

  const BauhausButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor = BauhausDesign.primary,
    this.textColor,
    this.icon,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final resolvedTextColor =
        textColor ??
        switch (backgroundColor) {
          BauhausDesign.secondary ||
          BauhausDesign.success => colorScheme.onSecondary,
          BauhausDesign.error => colorScheme.onError,
          BauhausDesign.tertiary ||
          BauhausDesign.accent => colorScheme.onTertiary,
          _ => colorScheme.onPrimary,
        };
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.zero,
        boxShadow: const [BauhausDesign.shadowHard],
        border: Border.all(color: BauhausDesign.neutral, width: 2.5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.zero,
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
                  Icon(icon, color: resolvedTextColor, size: 20),
                  const SizedBox(width: 8),
                ],
                Text(
                  text,
                  style: GoogleFonts.spaceMono(
                    color: resolvedTextColor,
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

const colorWhite = Color(0xFFFFFFFF);
const primaryContainer = BauhausDesign.primary;
const onPrimaryContainer = Color(0xFF6D5200);
const secondaryContainer = Color(0xFF92EDFF);
const tertiaryContainer = Color(0xFFFFBBB9);
const tertiaryDeep = Color(0xFFAF0425);
const errorContainer = Color(0xFFFFDAD6);
const errorDeep = Color(0xFF93000A);
const primaryFixed = Color(0xFFFFDF9A);
const onPrimaryFixed = Color(0xFF251A00);
const secondaryFixed = Color(0xFF9EEFFF);
const tertiaryFixed = Color(0xFFFFDAD8);
const tertiaryFixedDeep = Color(0xFF410007);
const outlineVariant = Color(0xFFD3C5AB);
const inverseSurface = Color(0xFF313030);
const inversePrimary = Color(0xFFF8BE00);
