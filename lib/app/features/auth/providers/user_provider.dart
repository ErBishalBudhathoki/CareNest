import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/features/auth/models/user_model.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:flutter/foundation.dart';

void _debugLogResolvedUserRole(
  String source,
  Map<String, dynamic> payload,
  User user,
) {
  debugPrint(
    '🔎 currentUserProvider[$source]: '
    'role=${payload['role']}, '
    'roles=${payload['roles']}, '
    'organizationRole=${payload['organizationRole']}, '
    'clientId=${payload['clientId']}, '
    'resolvedRole=${user.role}, '
    'normalizedRoles=${user.roles}',
  );
}

final currentUserProvider = FutureProvider<User?>((ref) async {
  final apiMethod = ref.read(app_providers.apiMethodProvider);

  // Try fetching from API first
  try {
    final response = await apiMethod.get('auth/profile');

    if (response['success'] == true) {
      final dynamic data = response['data'];

      // /auth/profile returns user object in `data`
      if (data is Map<String, dynamic>) {
        final user = User.fromJson(data);
        _debugLogResolvedUserRole('auth/profile', data, user);
        return user;
      }

      // Backward compatible guard for nested user payload
      if (data is Map &&
          data['user'] != null &&
          data['user'] is Map<String, dynamic>) {
        final userData = data['user'] as Map<String, dynamic>;
        final user = User.fromJson(userData);
        _debugLogResolvedUserRole('auth/profile.user', userData, user);
        return user;
      }
    }

    // Secondary fallback for environments exposing only v2 me endpoint
    final v2Response = await apiMethod.get('auth/v2/me');
    if (v2Response['success'] == true) {
      final dynamic v2User = v2Response['user'] ?? v2Response['data'];
      if (v2User is Map<String, dynamic>) {
        final user = User.fromJson(v2User);
        _debugLogResolvedUserRole('auth/v2/me', v2User, user);
        return user;
      }
    }

    debugPrint(
      '⚠️ currentUserProvider: API failed or invalid response: $response',
    );
  } catch (e) {
    debugPrint('⚠️ currentUserProvider: API exception: $e');
  }

  // Fallback to SharedPreferences
  debugPrint(
    'ℹ️ currentUserProvider: Attempting fallback to SharedPreferences',
  );
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
      phone: '',
      role: sharedPrefs.getRole() ?? UserRole.employee,
    );
  }

  debugPrint(
    '❌ currentUserProvider: Failed to restore user from SharedPreferences',
  );
  return null;
});
