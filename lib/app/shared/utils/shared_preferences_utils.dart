import 'dart:convert';
import 'dart:typed_data';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class SharedPreferencesUtils {
  SharedPreferences? _sharedPreferences;
  SharedPreferences? get sharedPreferences => _sharedPreferences;

  SharedPreferencesUtils(); // Constructor
  // Use a private static constant for the key to avoid typos.
  static const String _kUserEmailKey = 'userEmail';
  static const String _kRoleKey = 'userRole';
  // New: Auth token key
  static const String _kAuthTokenKey = 'authToken';

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
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
    return _sharedPreferences?.getString('user_email');
  }

  Future<void> saveEmailToSharedPreferences(String email) async {
    await _sharedPreferences?.setString('user_email', email);
  }

  // Future<void> setPhoto(Uint8List photo) async {
  //   debugPrint("Photo data: $photo");
  //
  //   // Convert Uint8List to base64-encoded string
  //   String photoString = base64Encode(photo);
  //   debugPrint("Photo data in savePhoto: $photoString");
  //   // Store the base64-encoded string in SharedPreferences
  //   await _sharedPreferences?.setString('photoKey', photoString);
  // }
  //
  // Uint8List? getPhoto() {
  //   // Retrieve the base64-encoded string from SharedPreferences
  //   String? photoString = _sharedPreferences?.getString('photoKey');
  //   debugPrint("Photo string in getPhoto: $photoString");
  //   // Convert the base64-encoded string back to Uint8List
  //   Uint8List? photo = photoString != null ? base64Decode(photoString) : null;
  //
  //   if (photo != null) {
  //     debugPrint("Successfully retrieved photo data from SharedPreferences.");
  //   } else {
  //     debugPrint("No photo data found in SharedPreferences.");
  //   }
  //
  //   return photo;
  // }

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
    return UserRole.values.firstWhere(
        (e) => e.toString().split('.').last == roleString,
        orElse: () => UserRole.normal);
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
    String? organizationCode,
  }) async {
    if (_sharedPreferences == null) {
      await init();
    }
    await _sharedPreferences!.setString(_kUserEmailKey, email);
    await _sharedPreferences!.setString(_kOrganizationIdKey, organizationId);
    await _sharedPreferences!.setString(_kNameKey, name);
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

  /// Retrieves the user's organization ID.
  String? getOrganizationId() {
    return _sharedPreferences?.getString(_kOrganizationIdKey);
  }

  /// Retrieves the user's organization code.
  String? getOrganizationCode() {
    return _sharedPreferences?.getString(_kOrganizationCodeKey);
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
}
