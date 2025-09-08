import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:flutter/material.dart';

/// Enhanced color system with additional design tokens
class EnhancedAppColors {
  EnhancedAppColors._();

  // Enhanced Primary Colors
  static const colorPrimary50 = Color(0xFFF8F6FC);
  static const colorPrimary100 = Color(0xFFEDE8F5);
  static const colorPrimary200 = Color(0xFFD6C7E3);
  static const colorPrimary300 = Color(0xFFB89FD1);
  static const colorPrimary400 = Color(0xFF9A77BF);
  static const colorPrimary500 = AppColors.colorPrimary; // #1C0D32
  static const colorPrimary600 = Color(0xFF160A28);
  static const colorPrimary700 = Color(0xFF11081E);
  static const colorPrimary800 = Color(0xFF0B0514);
  static const colorPrimary900 = Color(0xFF06030A);

  // Enhanced Secondary Colors
  static const colorSecondary50 = Color(0xFFF6F3FF);
  static const colorSecondary100 = Color(0xFFE8DEFF);
  static const colorSecondary200 = Color(0xFFD1BDFF);
  static const colorSecondary300 = Color(0xFFBA9CFF);
  static const colorSecondary400 = Color(0xFFA37BFF);
  static const colorSecondary500 = AppColors.colorSecondary; // #4C07AB
  static const colorSecondary600 = Color(0xFF3D0689);
  static const colorSecondary700 = Color(0xFF2E0467);
  static const colorSecondary800 = Color(0xFF1F0345);
  static const colorSecondary900 = Color(0xFF100123);

  // Enhanced Accent Colors
  static const colorAccent50 = Color(0xFFFFFBE6);
  static const colorAccent100 = Color(0xFFFFF4B3);
  static const colorAccent200 = Color(0xFFFFED80);
  static const colorAccent300 = Color(0xFFFFE64D);
  static const colorAccent400 = Color(0xFFFFDF1A);
  static const colorAccent500 = AppColors.colorAccent; // #FCBD13
  static const colorAccent600 = Color(0xFFE6AA11);
  static const colorAccent700 = Color(0xFFB3830D);
  static const colorAccent800 = Color(0xFF805C09);
  static const colorAccent900 = Color(0xFF4D3605);

  // Enhanced Status Colors
  static const colorSuccess50 = Color(0xFFF0FDF4);
  static const colorSuccess100 = Color(0xFFDCFCE7);
  static const colorSuccess500 = AppColors.colorGreen;
  static const colorSuccess600 = Color(0xFF16A34A);
  static const colorSuccess700 = Color(0xFF15803D);

  static const colorWarning50 = Color(0xFFFFFBEB);
  static const colorWarning100 = Color(0xFFFEF3C7);
  static const colorWarning500 = AppColors.colorOrange;
  static const colorWarning600 = Color(0xFFEA580C);
  static const colorWarning700 = Color(0xFFC2410C);

  static const colorError50 = Color(0xFFFEF2F2);
  static const colorError100 = Color(0xFFFECDD3);
  static const colorError500 = AppColors.colorRed;
  static const colorError600 = Color(0xFFDC2626);
  static const colorError700 = Color(0xFFB91C1C);

  static const colorInfo50 = Color(0xFFEFF6FF);
  static const colorInfo100 = Color(0xFFDBEAFE);
  static const colorInfo500 = AppColors.colorBlue;
  static const colorInfo600 = Color(0xFF2563EB);
  static const colorInfo700 = Color(0xFF1D4ED8);

  // Enhanced Surface Colors
  static const colorSurface50 = Color(0xFFFAFAFA);
  static const colorSurface100 = Color(0xFFF5F5F5);
  static const colorSurface200 = Color(0xFFEEEEEE);
  static const colorSurface300 = Color(0xFFE0E0E0);
  static const colorSurface400 = Color(0xFFBDBDBD);
  static const colorSurface500 = Color(0xFF9E9E9E);
  static const colorSurface600 = Color(0xFF757575);
  static const colorSurface700 = Color(0xFF616161);
  static const colorSurface800 = Color(0xFF424242);
  static const colorSurface900 = Color(0xFF212121);

  // Enhanced Shadow Colors
  static const colorShadowLight = Color(0x08000000);
  static const colorShadowMedium = Color(0x12000000);
  static const colorShadowHeavy = Color(0x1A000000);

  // Enhanced Border Colors
  static const colorBorderLight = Color(0xFFF0F0F0);
  static const colorBorderMedium = Color(0xFFE0E0E0);
  static const colorBorderHeavy = Color(0xFFD0D0D0);

  // Gradient Definitions
  static const primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [colorPrimary400, colorPrimary600],
  );

  static const secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [colorSecondary400, colorSecondary600],
  );

  static const accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [colorAccent400, colorAccent600],
  );

  static const successGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [colorSuccess500, colorSuccess600],
  );

  static const warningGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [colorWarning500, colorWarning600],
  );

  static const errorGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [colorError500, colorError600],
  );

  static const infoGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [colorInfo500, colorInfo600],
  );
}
