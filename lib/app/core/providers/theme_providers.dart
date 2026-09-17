// Theme Providers - App theming and visual customization.
// The app follows a single neo-brutalist Bauhaus light theme and does not
// currently support light/dark switching. All providers below are pinned to
// the light theme so the OS dark mode can never leak into the UI.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/values/themes/app_theme_config.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';

// ==================== THEME MODE NOTIFIER ====================

class ThemeModeNotifier extends Notifier<ThemeMode> {
  final SharedPreferencesUtils _prefs = SharedPreferencesUtils();

  @override
  ThemeMode build() {
    _migrateLegacyPreference();
    return ThemeMode.light;
  }

  /// One-way migration: any stored 'dark'/'system' preference from before the
  /// light-only lock is normalized to 'light' so it can never restore dark.
  Future<void> _migrateLegacyPreference() async {
    await _prefs.init();
    final pref = _prefs.getThemePreference();
    if (pref != 'light') {
      await _prefs.saveThemePreference('light');
    }
    // Keep state pinned even if the stored value was dark/system.
    state = ThemeMode.light;
  }

  /// Kept for API compatibility (e.g. ThemeSettingsView). Any requested mode
  /// resolves to light; the stored preference is normalized to 'light'.
  Future<void> setMode(ThemeMode mode) async {
    state = ThemeMode.light;
    await _prefs.saveThemePreference('light');
  }
}

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);

// ==================== THEME DATA PROVIDER ====================

// Always returns the single Bauhaus light theme, regardless of OS brightness.
final themeProvider = Provider<ThemeData>((ref) {
  ref.watch(themeModeProvider);
  return AppThemeConfig.lightTheme;
});

// Derived provider for dark mode status — always false (light-only app).
final isDarkModeProvider = Provider<bool>((ref) {
  ref.watch(themeModeProvider);
  return false;
});
