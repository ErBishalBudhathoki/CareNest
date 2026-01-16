// Core Providers - Foundational providers used across the app
//
// Contains essential providers like SharedPreferences, API, and navigation.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/backend/api_method.dart';

// ==================== SHARED PREFERENCES ====================

// SharedPreferences utility provider - initialized on app start
final sharedPreferencesProvider = Provider<SharedPreferencesUtils>((ref) {
  final prefs = SharedPreferencesUtils();
  prefs.init();
  return prefs;
});

// Alias for sharedPreferencesProvider (for backwards compatibility)
final sharedPreferencesUtilsProvider = Provider<SharedPreferencesUtils>((ref) {
  return SharedPreferencesUtils();
});

// ==================== API SERVICE ====================

// API method provider - single instance for all API calls
final apiMethodProvider = Provider<ApiMethod>((ref) => ApiMethod());

// ==================== NAVIGATION ====================

// Global navigation key for programmatic navigation
final navigationKeyProvider = Provider(
  (ref) => GlobalKey<NavigatorState>(debugLabel: 'navigation_key_provider'),
);

// ==================== USER INFO ====================

// Current user email from SharedPreferences
final userEmailProvider = Provider<String?>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getUserEmail();
});

// Current organization ID from SharedPreferences
final organizationIdProvider = Provider<String?>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getOrganizationId();
});
