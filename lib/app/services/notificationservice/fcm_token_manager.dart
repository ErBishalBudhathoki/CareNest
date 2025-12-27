import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:carenest/backend/api_method.dart';

/// FCM Token Manager with robust error handling for Firebase Installations Service issues
///
/// This class handles common Firebase Messaging errors including:
/// - FIS_AUTH_ERROR: Firebase Installations Service authentication errors
/// - Service unavailable: Temporary Firebase service outages
/// - Network connectivity issues
///
/// Features:
/// - Retry mechanism with exponential backoff
/// - Firebase service health diagnostics
/// - Graceful degradation when FCM is unavailable
/// - Comprehensive logging for debugging
///
/// The app will continue to function normally even if FCM tokens cannot be retrieved,
/// with push notifications being the only affected feature.
class FcmTokenManager {
  static const String _fcmTokenKey = 'fcm_token';
  static const String _tokenLastSentKey = 'fcm_token_last_sent';

  final ApiMethod _apiMethod = ApiMethod();

  // Singleton pattern
  static final FcmTokenManager _instance = FcmTokenManager._internal();

  factory FcmTokenManager() {
    return _instance;
  }

  FcmTokenManager._internal();

  /// Check Firebase service availability and provide diagnostics
  Future<void> _checkFirebaseServiceHealth() async {
    try {
      debugPrint('\n--- FIREBASE SERVICE HEALTH CHECK ---');

      // Check if Firebase is initialized
      final isInitialized = FirebaseMessaging.instance != null;
      debugPrint('Firebase Messaging initialized: $isInitialized');

      // Check notification permissions
      final settings =
          await FirebaseMessaging.instance.getNotificationSettings();
      debugPrint('Notification permission: ${settings.authorizationStatus}');
      debugPrint('Alert setting: ${settings.alert}');
      debugPrint('Badge setting: ${settings.badge}');
      debugPrint('Sound setting: ${settings.sound}');

      // Check if we can get APNS token (iOS specific)
      try {
        final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        debugPrint('APNS Token available: ${apnsToken != null}');
      } catch (e) {
        debugPrint('APNS Token check failed (normal on Android): $e');
      }
    } catch (e) {
      debugPrint('❌ Firebase service health check failed: $e');
    }
  }

  /// Get FCM token with retry mechanism for Firebase Installations Service errors
  Future<String?> _getTokenWithRetry({int maxRetries = 3}) async {
    for (int attempt = 1; attempt <= maxRetries; attempt++) {
      try {
        debugPrint('FCM Token retrieval attempt $attempt/$maxRetries');
        final token = await FirebaseMessaging.instance.getToken();
        if (token != null) {
          debugPrint('✅ FCM Token retrieved successfully on attempt $attempt');
          return token;
        }
        debugPrint('⚠️ FCM Token was null on attempt $attempt');
      } catch (e) {
        debugPrint('❌ FCM Token retrieval failed on attempt $attempt: $e');

        // Check if it's a Firebase Installations Service error
        if (e.toString().contains('FIS_AUTH_ERROR') ||
            e
                .toString()
                .contains('Firebase Installations Service is unavailable')) {
          debugPrint(
              '🔄 Firebase Installations Service error detected, will retry...');
        }

        // If this is the last attempt, don't wait
        if (attempt < maxRetries) {
          // Exponential backoff: 2^attempt seconds
          final delaySeconds = (2 << (attempt - 1)).clamp(1, 8);
          debugPrint('⏳ Waiting ${delaySeconds}s before retry...');
          await Future.delayed(Duration(seconds: delaySeconds));
        }
      }
    }

    debugPrint('❌ All FCM token retrieval attempts failed');
    return null;
  }

  /// Set up token refresh listener
  void _setupTokenRefreshListener(String userEmail, String organizationId) {
    debugPrint('\n--- SETTING UP TOKEN REFRESH LISTENER ---');
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      debugPrint('\n=== FCM TOKEN REFRESH DETECTED ===');
      debugPrint('Timestamp: ${DateTime.now().toIso8601String()}');
      debugPrint('New Token Preview: ${newToken.substring(0, 20)}...');
      _handleTokenRefresh(newToken, userEmail, organizationId);
    });
  }

  /// Initialize the FCM token manager and register the token if needed
  Future<void> initialize(String userEmail, String organizationId) async {
    try {
      debugPrint('\n=== FCM TOKEN MANAGER INITIALIZATION ===');
      debugPrint('Timestamp: ${DateTime.now().toIso8601String()}');
      debugPrint('User Email: $userEmail');
      debugPrint('Organization ID: $organizationId');

      // Check Firebase service health first
      await _checkFirebaseServiceHealth();

      // Get the current FCM token with retry mechanism
      debugPrint('\n--- RETRIEVING FCM TOKEN ---');
      final currentToken = await _getTokenWithRetry();

      if (currentToken == null) {
        debugPrint('❌ Failed to get FCM token from Firebase after retries');
        debugPrint(
            '⚠️ This is likely due to Firebase Installations Service being temporarily unavailable');
        debugPrint(
            '📱 App will continue to function normally, but push notifications may not work');
        debugPrint(
            '🔄 FCM token will be retried on next app launch or token refresh');
        debugPrint('=== END FCM TOKEN MANAGER (NO TOKEN) ===\n');

        // Set up token refresh listener anyway, in case service becomes available
        _setupTokenRefreshListener(userEmail, organizationId);
        return;
      }

      debugPrint('✅ FCM Token retrieved successfully');
      debugPrint('Token Preview: ${currentToken.substring(0, 20)}...');
      debugPrint('Full Token: $currentToken');
      debugPrint('Token Length: ${currentToken.length} characters');

      // Check if we need to send the token to the backend
      debugPrint('\n--- CHECKING TOKEN REGISTRATION STATUS ---');
      final shouldSendToken = await _shouldSendTokenToBackend(currentToken);
      debugPrint('Should send token to backend: $shouldSendToken');

      if (shouldSendToken) {
        debugPrint('\n--- SENDING TOKEN TO BACKEND ---');
        debugPrint('Backend endpoint: /auth/register-fcm-token');
        debugPrint(
            'Payload: {email: $userEmail, organizationId: $organizationId, fcmToken: ${currentToken.substring(0, 20)}...}');

        try {
          await _apiMethod.registerFcmToken(
            userEmail,
            organizationId,
            currentToken,
          );
          debugPrint('✅ Token sent to backend successfully');

          // Save the token and timestamp
          await _saveTokenInfo(currentToken);
          debugPrint('✅ Token info saved locally');
        } catch (e) {
          debugPrint('❌ Failed to send token to backend: $e');
          debugPrint('This may affect notification delivery');
          rethrow;
        }
      } else {
        debugPrint('\n--- TOKEN ALREADY REGISTERED ---');
        debugPrint('Token was sent recently, skipping backend registration');
        debugPrint('This helps avoid unnecessary API calls');
      }

      // Set up token refresh listener
      _setupTokenRefreshListener(userEmail, organizationId);

      debugPrint('✅ FCM Token Manager initialization completed');
      debugPrint('=== END FCM TOKEN MANAGER INITIALIZATION ===\n');
    } catch (e) {
      debugPrint('❌ FCM Token Manager initialization failed: $e');
      debugPrint('=== END FCM TOKEN MANAGER (WITH ERROR) ===\n');
      rethrow;
    }
  }

  /// Handle FCM token refresh
  Future<void> _handleTokenRefresh(
    String newToken,
    String userEmail,
    String organizationId,
  ) async {
    try {
      debugPrint('\n--- PROCESSING TOKEN REFRESH ---');
      debugPrint('User Email: $userEmail');
      debugPrint('Organization ID: $organizationId');
      debugPrint('New Token: $newToken');

      // Send the new token to the backend
      debugPrint('Sending refreshed token to backend...');
      await _apiMethod.registerFcmToken(
        userEmail,
        organizationId,
        newToken,
      );
      debugPrint('✅ Refreshed token sent to backend successfully');

      // Save the new token and timestamp
      await _saveTokenInfo(newToken);
      debugPrint('FCM Token Manager: Refreshed token sent and saved');
    } catch (e) {
      debugPrint('FCM Token Manager: Error handling token refresh - $e');
    }
  }

  /// Check if we should send the token to the backend
  /// Returns true if the token has changed or hasn't been sent in the last 24 hours
  Future<bool> _shouldSendTokenToBackend(String currentToken) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Get the saved token
      final savedToken = prefs.getString(_fcmTokenKey);

      // If the token has changed, we should send it
      if (savedToken != currentToken) {
        debugPrint('FCM Token Manager: Token has changed, should send');
        return true;
      }

      // Check when the token was last sent
      final lastSentTimestamp = prefs.getInt(_tokenLastSentKey) ?? 0;
      final lastSentDate =
          DateTime.fromMillisecondsSinceEpoch(lastSentTimestamp);
      final now = DateTime.now();

      // If the token hasn't been sent in the last 24 hours, we should send it
      final difference = now.difference(lastSentDate).inHours;
      debugPrint(
          'FCM Token Manager: Hours since last token update: $difference');

      return difference >= 24;
    } catch (e) {
      debugPrint(
          'FCM Token Manager: Error checking if token should be sent - $e');
      return true; // If there's an error, send the token to be safe
    }
  }

  /// Save the token and the current timestamp
  Future<void> _saveTokenInfo(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString(_fcmTokenKey, token);
      await prefs.setInt(
          _tokenLastSentKey, DateTime.now().millisecondsSinceEpoch);

      debugPrint('FCM Token Manager: Token info saved');
    } catch (e) {
      debugPrint('FCM Token Manager: Error saving token info - $e');
    }
  }

  /// Get the current FCM token
  Future<String?> getCurrentToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_fcmTokenKey);
    } catch (e) {
      debugPrint('FCM Token Manager: Error getting current token - $e');
      return null;
    }
  }

  /// Force update the FCM token on the backend
  Future<bool> forceUpdateToken(String userEmail, String organizationId) async {
    try {
      debugPrint('FCM Token Manager: Force updating token');

      // Get the current FCM token
      final currentToken = await FirebaseMessaging.instance.getToken();

      if (currentToken == null) {
        debugPrint(
            'FCM Token Manager: Failed to get FCM token for force update');
        return false;
      }

      // Send the token to the backend
      await _apiMethod.registerFcmToken(
        userEmail,
        organizationId,
        currentToken,
      );

      // Save the token and timestamp
      await _saveTokenInfo(currentToken);

      debugPrint('FCM Token Manager: Token force updated successfully');
      return true;
    } catch (e) {
      debugPrint('FCM Token Manager: Error force updating token - $e');
      return false;
    }
  }
}
