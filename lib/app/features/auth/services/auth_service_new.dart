import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:carenest/app/core/services/networking/dio_client.dart';
import 'package:carenest/app/features/auth/models/user_model.dart';
import 'package:carenest/app/features/auth/services/session_timeout_service.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';

class AuthService {
  final Dio _dio = DioClient().dio;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<Response<dynamic>> _postAuthV2(String action, {Object? data}) async {
    try {
      return await _dio.post('/auth/v2/$action', data: data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return await _dio.post('/v2/auth/$action', data: data);
      }
      rethrow;
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _postAuthV2(
        'login',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        final accessToken = data['accessToken'];
        final refreshToken = data['refreshToken'];
        final userData = data['user'];
        final requiresChange = data['requiresPasswordChange'] == true;

        // Store tokens in FlutterSecureStorage (for DioClient)
        await _storage.write(key: 'accessToken', value: accessToken);
        await _storage.write(key: 'refreshToken', value: refreshToken);

        // CRITICAL: Also sync token to SharedPreferencesUtils for ApiMethod compatibility
        final sharedPrefs = await SharedPreferencesUtils.getInstance();
        await sharedPrefs.saveAuthToken(accessToken);

        // Save user data to SharedPreferencesUtils for ApiMethod and other components
        if (userData != null) {
          await sharedPrefs.saveUserData(
            email: userData['email'] ?? '',
            organizationId:
                userData['organizationId'] ??
                userData['organization']?['_id'] ??
                '',
            name: '${userData['firstName'] ?? ''} ${userData['lastName'] ?? ''}'
                .trim(),
            userId: userData['_id'] ?? userData['id'] ?? '',
            organizationCode:
                userData['organization']?['code'] ??
                userData['organizationCode'] ??
                '',
          );
        }
        await SessionTimeoutService(
          sharedPrefs: sharedPrefs,
        ).markSessionStarted();

        // Parse User
        return {
          'user': User.fromJson(userData),
          'requiresPasswordChange': requiresChange,
        };
      }
      throw Exception('Login failed');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> register(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    await _postAuthV2(
      'register',
      data: {
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'confirmPassword':
            password, // Backend v2 (zod) doesn't check confirmPassword inside controller usually?
        // Wait, my v2 controller schema didn't check confirmPassword.
        // It just checked email/pass/names.
        // The secureAuthOriginal DID check confirmPassword.
        // I should pass it anyway if UI sends it, but my controller doesn't enforce it.
      },
    );
  }

  Future<void> logout() async {
    try {
      final refreshToken = await _storage.read(key: 'refreshToken');
      if (refreshToken != null) {
        await _postAuthV2('logout', data: {'refreshToken': refreshToken});
      }
    } catch (_) {
      // Ignore network error on logout
    } finally {
      // Clear FlutterSecureStorage
      await _storage.deleteAll();

      // Also clear local session state and Firebase session.
      final sharedPrefs = await SharedPreferencesUtils.getInstance();
      await SessionTimeoutService(
        sharedPrefs: sharedPrefs,
      ).logoutAndClearSession(reason: 'auth_service_logout');
    }
  }

  Future<void> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    await _postAuthV2(
      'change-password',
      data: {'currentPassword': currentPassword, 'newPassword': newPassword},
    );
  }
}
