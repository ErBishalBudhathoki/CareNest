import 'package:carenest/app/features/auth/models/user_model.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:carenest/app/features/auth/models/login_model.dart';
import 'package:carenest/app/features/auth/services/auth_error_handler.dart';

import 'package:device_info_plus/device_info_plus.dart';

import 'dart:math' as math;

class LoginViewModel extends ChangeNotifier {
  final LoginModel model = LoginModel();
  final ApiMethod _apiMethod;
  final SharedPreferencesUtils _sharedPrefs;

  // Security enhancements
  bool isLoading = false;
  String? _deviceId;
  String? _deviceInfo;
  Map<String, dynamic>? _securityContext;
  DateTime? _lastLoginAttempt;

  // Rate limiting
  static const int maxAttemptsPerMinute = 3;
  final List<DateTime> _recentAttempts = [];

  // Security logging
  final List<Map<String, dynamic>> _securityLogs = [];

  LoginViewModel(this._apiMethod, this._sharedPrefs) {
    _initializeSecurityContext();
    if (kDebugMode) {
      // Only set debug credentials in debug mode and with user consent
      // setDebugCredentials();
    }
  }

  void togglePasswordVisibility() {
    model.isVisible = !model.isVisible;
    notifyListeners();
  }

  /// Initialize security context with device information
  Future<void> _initializeSecurityContext() async {
    try {
      final deviceInfoPlugin = DeviceInfoPlugin();

      if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        _deviceId = androidInfo.id;
        _deviceInfo =
            '${androidInfo.brand} ${androidInfo.model} (Android ${androidInfo.version.release})';
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        _deviceId = iosInfo.identifierForVendor;
        _deviceInfo =
            '${iosInfo.name} ${iosInfo.model} (iOS ${iosInfo.systemVersion})';
      }

      _securityContext = {
        'deviceId': _deviceId,
        'deviceInfo': _deviceInfo,
        'platform': Platform.operatingSystem,
        'timestamp': DateTime.now().toIso8601String(),
      };

      _logSecurityEvent('security_context_initialized', {
        'deviceInfo': _deviceInfo,
        'platform': Platform.operatingSystem,
      });
    } catch (e) {
      _logSecurityEvent('security_context_init_failed', {
        'error': e.toString(),
      });
    }
  }

  /// Enhanced login with comprehensive security measures and loading indicators
  Future<void> login(BuildContext context) async {
    debugPrint(
        "🔐 LOGIN ATTEMPT: Starting login process for email: ${model.getSanitizedEmail()}");

    // Check rate limiting
    if (!_checkRateLimit()) {
      await AuthErrorHandler.handleAuthError(
        context: context,
        error: 'rate_limit_exceeded',
        userEmail: model.getSanitizedEmail(),
        onRetry: () => login(context),
      );
      return;
    }

    // Validate form with security checks
    if (!model.validateForm()) {
      _logSecurityEvent('login_validation_failed', {
        'email': model.getSanitizedEmail(),
        'errors': {
          'email': model.emailError,
          'password': model.passwordError,
        }
      });
      return;
    }

    // Check account lockout
    if (model.isAccountLocked) {
      await AuthErrorHandler.handleAuthError(
        context: context,
        error: 'account_locked',
        userEmail: model.getSanitizedEmail(),
        onRetry: () => login(context),
      );
      return;
    }

    // Loading state will be handled by the UI layer using AuthLoadingOverlay widget

    isLoading = true;
    notifyListeners();

    // Store context reference before async operations
    final BuildContext contextRef = context;

    try {
      // Ensure SharedPreferences is initialized
      await _sharedPrefs.init();

      // Record login attempt
      _lastLoginAttempt = DateTime.now();
      _recentAttempts.add(_lastLoginAttempt!);

      // Prepare secure login data
      final loginData = {
        'email': model.getSanitizedEmail(),
        'password': model.passwordController.text.trim(),
        'deviceId': _deviceId,
        'deviceInfo': _deviceInfo,
        'timestamp': DateTime.now().toIso8601String(),
        'securityContext': _securityContext,
      };

      _logSecurityEvent('login_attempt_started', {
        'email': model.getSanitizedEmail(),
        'deviceId': _deviceId,
      });

      final response = await _apiMethod.secureLogin(loginData);

      debugPrint("🔐 LOGIN RESPONSE: ${response['message']}");
      debugPrint("🔐 LOGIN RESPONSE FULL: $response");

      if (_isSuccessfulLogin(response)) {
        if (contextRef.mounted) {
          await _handleSuccessfulLogin(contextRef, response);
        }
      } else {
        if (contextRef.mounted) {
          await _handleFailedLogin(contextRef, response);
        }
      }
    } catch (e) {
      if (contextRef.mounted) {
        await AuthErrorHandler.handleAuthError(
          context: contextRef,
          error: e,
          userEmail: model.getSanitizedEmail(),
          onRetry: () => login(contextRef),
          onCreateAccount: () => Navigator.pushNamed(contextRef, Routes.signup),
          onForgotPassword: () =>
              Navigator.pushNamed(contextRef, Routes.forgotPassword),
        );
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Debug function to clear auth token and force fresh login
  Future<void> debugClearTokenAndLogin(BuildContext context) async {
    debugPrint("🔧 DEBUG: Clearing auth token and forcing fresh login");
    await _sharedPrefs.clearAuthToken();
    final currentToken = _sharedPrefs.getAuthToken();
    debugPrint("🔧 DEBUG: Token after clear: $currentToken");

    // Trigger fresh login
    await login(context);
  }

  /// Check if login response indicates success
  bool _isSuccessfulLogin(Map<String, dynamic> response) {
    return response['message'] == 'user found' ||
        response['message'] == 'Login successful' ||
        response['success'] == true;
  }

  /// Handle successful login
  Future<void> _handleSuccessfulLogin(
      BuildContext context, Map<String, dynamic> response) async {
    final userData = response['user'];
    if (userData == null) {
      _showSecurityDialog(
          context, 'Login Error', 'User data not found in response.');
      return;
    }

    try {
      final user = User.fromJson(userData);
      String organizationName = '';
      String organizationCode = '';

      if (response['user']['organization'] != null) {
        final orgData = response['user']['organization'];
        organizationName = orgData['name'] ?? '';
        organizationCode = orgData['code'] ?? '';
      }

      // Extract and save the JWT token
      // Check multiple possible token locations in the response
      final token = response['token'] ??
          response['accessToken'] ??
          (response['data'] is Map ? response['data']['token'] : null);

      debugPrint("🔐 TOKEN EXTRACTION: Token from response: $token");
      debugPrint(
          "🔐 TOKEN EXTRACTION: Response keys: ${response.keys.toList()}");

      if (token != null && token.toString().isNotEmpty) {
        // Format token properly with Bearer prefix if needed
        final String formattedToken = token.toString().startsWith('Bearer ')
            ? token.toString()
            : 'Bearer ${token.toString()}';

        await _sharedPrefs.saveAuthToken(formattedToken);
        debugPrint(
            "✅ Auth token saved successfully: ${formattedToken.substring(0, math.min(formattedToken.length, 30))}...");

        // Verify token was saved
        final savedToken = _sharedPrefs.getAuthToken();
        if (savedToken != null && savedToken.isNotEmpty) {
          debugPrint(
              "🔐 TOKEN VERIFICATION: Saved token retrieved: ${savedToken.substring(0, math.min(savedToken.length, 30))}...");
        } else {
          debugPrint(
              "⚠️ Token verification failed - could not retrieve saved token");
        }
      } else {
        debugPrint("⚠️ No token found in login response");
        debugPrint("🔐 RESPONSE STRUCTURE: $response");
        _logSecurityEvent('login_no_token', {
          'email': user.email,
          'response_keys': response.keys.toList(),
        });
      }

      // Save user data securely
      await _sharedPrefs.saveUserData(
        email: user.email,
        organizationId: user.organizationId,
        name: user.name,
        organizationCode: organizationCode,
      );

      await _sharedPrefs.setRole(user.role);
      await _sharedPrefs.setBool('isLoggedIn', true);

      // Save security context
      await _sharedPrefs.setString('lastLoginDevice', _deviceId ?? 'unknown');
      await _sharedPrefs.setString(
          'lastLoginTime', DateTime.now().toIso8601String());

      // Register FCM token with enhanced error handling
      await _registerFcmToken(user);

      // Reset login attempts on successful login
      model.resetLoginAttempts();
      _recentAttempts.clear();

      _logSecurityEvent('login_successful', {
        'email': user.email,
        'userId': user.id,
        'organizationId': user.organizationId,
        'role': user.role,
        'deviceId': _deviceId,
      });

      if (context.mounted) {
        // Show success feedback before navigation
        await AuthErrorHandler.showSuccessFeedback(
          context,
          title: 'Welcome Back!',
          message: 'Login successful. Redirecting to your dashboard...',
          onContinue: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.bottomNavBar,
              (Route<dynamic> route) => false,
              arguments: {
                'email': user.email,
                'role': user.role,
                'organizationId': user.organizationId,
                'organizationName': organizationName,
                'organizationCode': organizationCode,
                'userEmail': user.email,
              },
            );
          },
        );
      }
    } catch (e) {
      _logSecurityEvent('login_data_processing_failed', {
        'error': e.toString(),
        'email': model.getSanitizedEmail(),
      });

      if (context.mounted) {
        _showSecurityDialog(
            context, 'Login Error', 'Failed to process login data.');
      }
    }
  }

  /// Handle failed login with comprehensive error handling
  Future<void> _handleFailedLogin(
      BuildContext context, Map<String, dynamic>? response) async {
    model.recordFailedAttempt();

    final errorMessage =
        response?['message'] ?? 'Login failed. Please try again.';

    _logSecurityEvent('login_failed', {
      'email': model.getSanitizedEmail(),
      'error': errorMessage,
      'errorCode': response?['errorCode'],
      'attempts': model.loginAttempts,
      'deviceId': _deviceId,
    });

    if (context.mounted) {
      // Use comprehensive error handler
      await AuthErrorHandler.handleAuthError(
        context: context,
        error: response ?? {'message': errorMessage},
        userEmail: model.getSanitizedEmail(),
        onRetry: () => login(context),
        onCreateAccount: () => Navigator.pushNamed(context, Routes.signup),
        onForgotPassword: () =>
            Navigator.pushNamed(context, Routes.forgotPassword),
      );
    }
  }

  /// Handle login errors
  Future<void> _handleLoginError(
      BuildContext context, dynamic error, StackTrace stackTrace) async {
    model.recordFailedAttempt();

    _logSecurityEvent('login_error', {
      'email': model.getSanitizedEmail(),
      'error': error.toString(),
      'stackTrace': stackTrace.toString(),
      'deviceId': _deviceId,
    });

    debugPrint('Login error: $error');
    debugPrint('Stack trace: $stackTrace');

    if (context.mounted) {
      _showSecurityDialog(
          context, 'Login Error', 'An error occurred. Please try again.');
    }
  }

  /// Register FCM token with enhanced security
  Future<void> _registerFcmToken(User user) async {
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken != null) {
        await _apiMethod.registerFcmToken(
          user.email,
          user.organizationId,
          fcmToken,
          deviceId: _deviceId,
          deviceInfo: _deviceInfo,
        );

        _logSecurityEvent('fcm_token_registered', {
          'email': user.email,
          'deviceId': _deviceId,
        });

        debugPrint('FCM token registered successfully');
      } else {
        _logSecurityEvent('fcm_token_null', {
          'email': user.email,
          'deviceId': _deviceId,
        });
        debugPrint('FCM token is null, skipping registration');
      }
    } catch (fcmError) {
      _logSecurityEvent('fcm_token_registration_failed', {
        'email': user.email,
        'error': fcmError.toString(),
        'deviceId': _deviceId,
      });
      debugPrint('FCM token registration failed: $fcmError');
    }
  }

  /// Check rate limiting
  bool _checkRateLimit() {
    final now = DateTime.now();
    final oneMinuteAgo = now.subtract(const Duration(minutes: 1));

    // Remove attempts older than 1 minute
    _recentAttempts.removeWhere((attempt) => attempt.isBefore(oneMinuteAgo));

    return _recentAttempts.length < maxAttemptsPerMinute;
  }

  /// Log security events
  void _logSecurityEvent(String event, Map<String, dynamic> data) {
    final logEntry = {
      'event': event,
      'timestamp': DateTime.now().toIso8601String(),
      'data': data,
    };

    _securityLogs.add(logEntry);

    // Keep only last 100 logs to prevent memory issues
    if (_securityLogs.length > 100) {
      _securityLogs.removeAt(0);
    }

    // In production, send critical security events to backend
    if (!kDebugMode && _isCriticalSecurityEvent(event)) {
      _sendSecurityLogToBackend(logEntry);
    }
  }

  /// Check if event is critical for security monitoring
  bool _isCriticalSecurityEvent(String event) {
    final criticalEvents = [
      'login_failed',
      'login_error',
      'account_locked',
      'suspicious_activity',
      'security_context_init_failed',
    ];

    return criticalEvents.contains(event);
  }

  /// Send security log to backend (placeholder)
  Future<void> _sendSecurityLogToBackend(Map<String, dynamic> logEntry) async {
    try {
      // Implementation would send log to backend security monitoring
      await _apiMethod.sendSecurityLog(logEntry);
    } catch (e) {
      debugPrint('Failed to send security log: $e');
    }
  }

  /// Show security-related dialogs
  void _showSecurityDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.security, color: Colors.red),
              const SizedBox(width: 8),
              Text(title),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  /// Get security logs for debugging
  List<Map<String, dynamic>> getSecurityLogs() {
    return List.unmodifiable(_securityLogs);
  }

  /// Clear security logs
  void clearSecurityLogs() {
    _securityLogs.clear();
  }

  /// Validate email input with security checks
  void validateEmail(String email) {
    model.validateEmail(email);
  }

  /// Validate password input with security checks
  void validatePassword(String password) {
    model.validatePassword(password);
  }

  /// Check if form is valid and secure
  bool isFormValid() {
    return model.validateForm() && !model.isAccountLocked;
  }

  @override
  void dispose() {
    // Securely clear sensitive data
    model.clearForm();
    _securityLogs.clear();
    _recentAttempts.clear();
    model.dispose();
    super.dispose();
  }

  /// Set debug credentials (only in debug mode)
  void setDebugCredentials() {
    if (kDebugMode) {
      const debugEmail = 'test1@tester.com';
      const debugPassword = '111111';

      model.emailController.text = debugEmail;
      model.passwordController.text = debugPassword;
      notifyListeners();

      _logSecurityEvent('debug_credentials_set', {
        'email': debugEmail,
        'environment': 'debug',
      });
    }
  }

  /// Clear credentials securely
  void clearCredentials() {
    model.clearForm();
    _logSecurityEvent('credentials_cleared', {
      'timestamp': DateTime.now().toIso8601String(),
    });
    notifyListeners();
  }

  /// Force logout for security reasons
  Future<void> forceLogout(BuildContext context, String reason) async {
    _logSecurityEvent('force_logout', {
      'reason': reason,
      'deviceId': _deviceId,
    });

    await _sharedPrefs.setBool('isLoggedIn', false);
    await _sharedPrefs.clear();

    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.login,
        (Route<dynamic> route) => false,
      );

      _showSecurityDialog(context, 'Security Logout',
          'You have been logged out for security reasons: $reason');
    }
  }
}
