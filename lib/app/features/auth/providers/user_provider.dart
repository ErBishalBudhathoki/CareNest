import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/auth/models/user_model.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:flutter/foundation.dart';

final currentUserProvider = FutureProvider<User?>((ref) async {
  final apiMethod = ApiMethod();

  // Try fetching from API first
  try {
    final response = await apiMethod.get('api/auth/me');

    if (response['success'] == true &&
        response['data'] != null &&
        response['data']['user'] != null) {
      return User.fromJson(response['data']['user']);
    }

    debugPrint(
        '⚠️ currentUserProvider: API failed or invalid response: $response');
  } catch (e) {
    debugPrint('⚠️ currentUserProvider: API exception: $e');
  }

  // Fallback to SharedPreferences
  debugPrint(
      'ℹ️ currentUserProvider: Attempting fallback to SharedPreferences');
  final sharedPrefs = SharedPreferencesUtils();
  await sharedPrefs.init();

  final email = sharedPrefs.getUserEmail();
  final userId = sharedPrefs.getUserId();
  final organizationId = sharedPrefs.getOrganizationId();

  if (email != null && organizationId != null) {
    debugPrint('✅ currentUserProvider: Restored user from SharedPreferences');
    return User(
      id: userId ?? '',
      organizationId: organizationId,
      name: sharedPrefs.getName() ?? '',
      email: email,
      phone: '', // Dummy phone
      role: sharedPrefs.getRole() ?? UserRole.normal,
    );
  }

  debugPrint(
      '❌ currentUserProvider: Failed to restore user from SharedPreferences');
  return null;
});
