import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  SharedPreferences? _sharedPreferences;
  SharedPreferences? get sharedPreferences => _sharedPreferences;

  // Private constructor
  SharedPreferencesUtils._internal();

  /// Visible for testing purposes only
  @visibleForTesting
  SharedPreferencesUtils.forTesting();

  static SharedPreferencesUtils? _instance;
  static Completer<void>? _initCompleter;

  static Future<SharedPreferencesUtils> getInstance() async {
    if (_instance == null) {
      _instance = SharedPreferencesUtils._internal();
      await _instance!.init();
    }
    return _instance!;
  }

  // Factory constructor to return the singleton instance
  factory SharedPreferencesUtils() {
    _instance ??= SharedPreferencesUtils._internal();
    return _instance!;
  }

  // Use a private static constant for the key to avoid typos.
  static const String _kUserEmailKey = 'userEmail';
  static const String _kRoleKey = 'userRole';
  static const String _kUserIdKey = 'userId';
  // New: Auth token key
  static const String _kAuthTokenKey = 'authToken';

  /// Public key for storing date format preference (for ambiguous numeric dates)
  /// Allowed values: 'mdy' (US month-first), 'dmy' (day-first)
  static const String kDateFormatPreferenceKey = 'date_format_preference';

  /// Public key for storing user preference of using admin bank details
  /// When true, invoices will use admin bank details; otherwise employee details
  static const String kUseAdminBankDetailsKey = 'useAdminBankDetails';

  /// Public key for storing theme preference
  /// Allowed values: 'light', 'dark', 'system'
  static const String kThemePreferenceKey = 'theme_preference';

  Future<void> init() async {
    if (_sharedPreferences != null) return;

    // Prevent race conditions with multiple concurrent init calls
    if (_initCompleter != null) {
      return _initCompleter!.future;
    }

    _initCompleter = Completer<void>();

    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      _initCompleter!.complete();
    } catch (e) {
      debugPrint('Error initializing SharedPreferences: $e');
      _initCompleter!.completeError(e);
      _initCompleter = null; // Reset to allow retry
    }
  }

  Future<void> setString(String key, String value) async {
    await _sharedPreferences?.setString(key, value);
  }

  Future<void> setBool(String key, bool value) async {
    if (_sharedPreferences == null) {
      await init();
    }
    await _sharedPreferences!.setBool(key, value);
  }

  Future<void> setInt(String key, int value) async {
    await _sharedPreferences?.setInt(key, value);
  }

  Future<void> setDouble(String key, double value) async {
    await _sharedPreferences?.setDouble(key, value);
  }

  Future<void> setStringList(String key, List<String> value) async {
    await _sharedPreferences?.setStringList(key, value);
  }

  String? getString(String key) {
    return _sharedPreferences?.getString(key);
  }

  bool? getBool(String key) {
    return _sharedPreferences?.getBool(key);
  }

  int? getInt(String key) {
    return _sharedPreferences?.getInt(key);
  }

  double? getDouble(String key) {
    return _sharedPreferences?.getDouble(key);
  }

  List<String>? getStringList(String key) {
    return _sharedPreferences?.getStringList(key);
  }

  Future<bool> containsKey(String key) async {
    return _sharedPreferences!.containsKey(key);
  }

  Future<void> remove(String key) async {
    await _sharedPreferences?.remove(key);
  }

  Future<void> clear() async {
    await _sharedPreferences?.clear();
  }

  Future<String?> getUserEmailFromSharedPreferences() async {
    return _sharedPreferences?.getString(_kUserEmailKey);
  }

  Future<void> saveEmailToSharedPreferences(String email) async {
    await _sharedPreferences?.setString(_kUserEmailKey, email);
  }

  Future<void> setPhoto(Uint8List photo, String userEmail) async {
    debugPrint(" Shared pref Photo data: $photo");
    String photoString = base64Encode(photo);
    debugPrint("Photo data in savePhoto: $photoString");
    await _sharedPreferences?.setString('userPhoto$userEmail', photoString);
  }

  Future<Uint8List?> getPhoto(String userEmail) async {
    try {
      String? photoString =
          _sharedPreferences?.getString('userPhoto$userEmail');
      debugPrint("Photo string in getPhoto: $photoString");
      Uint8List? photo = photoString != null ? base64Decode(photoString) : null;
      if (photo != null) {
        debugPrint("Successfully retrieved photo data from SharedPreferences.");
      } else {
        debugPrint("No photo data found in SharedPreferences.");
      }
      debugPrint('Photo in getPhoto return time: $photo');
      return photo;
    } catch (e) {
      return null;
    }
  }

  Future<void> setRole(UserRole role) async {
    if (_sharedPreferences == null) {
      await init();
    }
    await _sharedPreferences!
        .setString('role', role.toString().split('.').last);
  }

  UserRole? getRole() {
    String? roleString = _sharedPreferences?.getString('role');
    if (roleString == null) {
      return null;
    }
    return UserRoleResolver.resolve(role: roleString);
  }

  setUserData({required String email, required UserRole role}) {
    saveEmailToSharedPreferences(email);
    setRole(role);
  }

  /// Saves the user's email to local storage.
  Future<void> saveUserEmailToSharedPreferences(String email) async {
    if (_sharedPreferences == null) await init(); // Ensure it's initialized
    await _sharedPreferences!.setString(_kUserEmailKey, email);
    debugPrint("✅ Email saved to SharedPreferences: $email");
  }

  /// Clears the user's email from storage, typically on logout.
  Future<void> clearUserEmail() async {
    if (_sharedPreferences == null) await init();
    await _sharedPreferences!.remove(_kUserEmailKey);
    debugPrint("🗑️ User email cleared from SharedPreferences.");
  }

  // Define keys as private static constants to prevent typos.

  static const String _kOrganizationIdKey = 'organizationId';
  static const String _kOrganizationCodeKey = 'organizationCode';
  static const String _kNameKey = 'First LastName';

  /// Saves all necessary user data after a successful login.
  Future<void> saveUserData({
    required String email,
    required String organizationId,
    required String name,
    String? userId,
    String? organizationCode,
  }) async {
    if (_sharedPreferences == null) {
      await init();
    }
    await _sharedPreferences!.setString(_kUserEmailKey, email);
    await _sharedPreferences!.setString(_kOrganizationIdKey, organizationId);
    await _sharedPreferences!.setString(_kNameKey, name);
    if (userId != null && userId.isNotEmpty) {
      await _sharedPreferences!.setString(_kUserIdKey, userId);
    }
    if (organizationCode != null) {
      await _sharedPreferences!
          .setString(_kOrganizationCodeKey, organizationCode);
    }
    debugPrint(
        "✅ User data saved to SharedPreferences: Email: $email, OrgID: $organizationId, Name: $name, OrgCode: $organizationCode");
  }

  /// Retrieves the logged-in user's email.
  String? getUserEmail() {
    return _sharedPreferences?.getString(_kUserEmailKey);
  }

  String? getUserId() {
    return _sharedPreferences?.getString(_kUserIdKey);
  }

  /// Retrieves the user's organization ID.
  String? getOrganizationId() {
    return _sharedPreferences?.getString(_kOrganizationIdKey);
  }

  /// Updates the stored Organization ID.
  Future<void> setOrganizationId(String organizationId) async {
    if (_sharedPreferences == null) await init();
    await _sharedPreferences!.setString(_kOrganizationIdKey, organizationId);
    debugPrint("✅ Organization ID updated to: $organizationId");
  }

  /// Retrieves the user's organization code.
  String? getOrganizationCode() {
    return _sharedPreferences?.getString(_kOrganizationCodeKey);
  }

  /// Retrieves the user's name.
  String? getName() {
    return _sharedPreferences?.getString(_kNameKey);
  }

  /// Clears all user data from storage, typically on logout.
  Future<void> clearAllUserData() async {
    await init();
    await _sharedPreferences!.clear(); // .clear() is simpler for logout
    debugPrint("🗑️ All user data cleared from SharedPreferences.");
  }

  // New: Token helpers
  Future<void> saveAuthToken(String token) async {
    if (_sharedPreferences == null) await init();
    // Normalize: strip leading 'Bearer ' if present and trim whitespace before saving
    String normalized = token.trim();
    if (normalized.toLowerCase().startsWith('bearer ')) {
      normalized = normalized.substring(7).trim();
    }
    await _sharedPreferences!.setString(_kAuthTokenKey, normalized);
    debugPrint(
        "🔐 Auth token saved to SharedPreferences (normalized, length: ${normalized.length})");
  }

  String? getAuthToken() {
    // Return trimmed token if stored
    final t = _sharedPreferences?.getString(_kAuthTokenKey);
    return t?.trim();
  }

  Future<void> clearAuthToken() async {
    if (_sharedPreferences == null) await init();
    await _sharedPreferences!.remove(_kAuthTokenKey);
    debugPrint("🔓 Auth token cleared from SharedPreferences");
  }

  /// Saves the user's date format preference used for parsing ambiguous numeric dates.
  ///
  /// Expected values:
  /// - 'mdy': month/day/year (US)
  /// - 'dmy': day/month/year (default)
  Future<void> saveDateFormatPreference(String preference) async {
    if (_sharedPreferences == null) await init();
    final normalized = preference.trim().toLowerCase();
    if (normalized != 'mdy' && normalized != 'dmy') {
      throw ArgumentError('Invalid date format preference: $preference');
    }
    await _sharedPreferences!.setString(kDateFormatPreferenceKey, normalized);
    debugPrint('📅 Date format preference saved: $normalized');
  }

  /// Retrieves the stored date format preference.
  /// Returns 'mdy', 'dmy', or null when not set.
  String? getDateFormatPreference() {
    final v = _sharedPreferences?.getString(kDateFormatPreferenceKey);
    switch (v?.toLowerCase()) {
      case 'mdy':
        return 'mdy';
      case 'dmy':
        return 'dmy';
      default:
        return null;
    }
  }

  /// Saves the user's theme preference.
  ///
  /// Expected values: 'light', 'dark', 'system'
  Future<void> saveThemePreference(String preference) async {
    if (_sharedPreferences == null) await init();
    final normalized = preference.trim().toLowerCase();
    if (normalized != 'light' &&
        normalized != 'dark' &&
        normalized != 'system') {
      debugPrint(
          '⚠️ Invalid theme preference: $preference, defaulting to system');
      await _sharedPreferences!.setString(kThemePreferenceKey, 'system');
      return;
    }
    await _sharedPreferences!.setString(kThemePreferenceKey, normalized);
    debugPrint('🎨 Theme preference saved: $normalized');
  }

  /// Retrieves the stored theme preference.
  /// Returns 'light', 'dark', or 'system' (default).
  String getThemePreference() {
    final v = _sharedPreferences?.getString(kThemePreferenceKey);
    switch (v?.toLowerCase()) {
      case 'light':
        return 'light';
      case 'dark':
        return 'dark';
      case 'system':
      default:
        return 'system';
    }
  }
}
