// Theme Providers - App theming and visual customization
// Contains providers for theme management including dark mode support.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/values/themes/app_theme_config.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';

// ==================== THEME MODE NOTIFIER ====================

class ThemeModeNotifier extends Notifier<ThemeMode> {
  final SharedPreferencesUtils _prefs = SharedPreferencesUtils();

  @override
  ThemeMode build() {
    _loadTheme();
    return ThemeMode.system;
  }

  Future<void> _loadTheme() async {
    await _prefs.init();
    final pref = _prefs.getThemePreference();
    if (pref == 'dark') {
      state = ThemeMode.dark;
    } else if (pref == 'light') {
      state = ThemeMode.light;
    } else {
      state = ThemeMode.system;
    }
  }

  Future<void> setMode(ThemeMode mode) async {
    state = mode;
    String prefString = 'system';
    switch (mode) {
      case ThemeMode.light:
        prefString = 'light';
        break;
      case ThemeMode.dark:
        prefString = 'dark';
        break;
      case ThemeMode.system:
        prefString = 'system';
        break;
    }
    await _prefs.saveThemePreference(prefString);
  }
}

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);

// ==================== THEME DATA PROVIDER ====================

// Returns the actual ThemeData based on current mode and system brightness
final themeProvider = Provider<ThemeData>((ref) {
  final mode = ref.watch(themeModeProvider);

  switch (mode) {
    case ThemeMode.light:
      return AppThemeConfig.lightTheme;
    case ThemeMode.dark:
      return AppThemeConfig.darkTheme;
    case ThemeMode.system:
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.dark
          ? AppThemeConfig.darkTheme
          : AppThemeConfig.lightTheme;
  }
});

// Derived provider for dark mode status
final isDarkModeProvider = Provider<bool>((ref) {
  final theme = ref.watch(themeProvider);
  return theme.brightness == Brightness.dark;
});
