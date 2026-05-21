import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/services/notificationservice/fcm_token_manager.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/services/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:carenest/app/features/auth/models/login_model.dart';
import 'package:carenest/app/features/auth/services/auth_error_handler.dart';
import 'package:carenest/app/features/auth/services/session_timeout_service.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/features/onboarding/services/onboarding_gate_service.dart';

import 'package:device_info_plus/device_info_plus.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginModel model = LoginModel();
  final ApiMethod _apiMethod;
  final SharedPreferencesUtils _sharedPrefs;
  final FcmTokenManager _fcmTokenManager;
  final FirebaseAuthService _firebaseAuth;
  final OnboardingGateService _onboardingGateService = OnboardingGateService();

  bool isLoading = false;
  String? _deviceId;
  String? _deviceInfo;
  Map<String, dynamic>? _securityContext;
  DateTime? _lastLoginAttempt;

  static const int maxAttemptsPerMinute = 3;
  final List<DateTime> _recentAttempts = [];

  final List<Map<String, dynamic>> _securityLogs = [];

  LoginViewModel(
    this._apiMethod,
    this._sharedPrefs,
    this._fcmTokenManager, {
    FirebaseAuthService? firebaseAuthService,
  }) : _firebaseAuth = firebaseAuthService ?? FirebaseAuthService() {
    _initializeSecurityContext();
  }

  void togglePasswordVisibility() {
    model.isVisible = !model.isVisible;
    notifyListeners();
  }

  Future<void> _initializeSecurityContext() async {
    try {
      final deviceInfoPlugin = DeviceInfoPlugin();

      if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        _deviceId = androidInfo.id;
        _deviceInfo =
            'Android ${androidInfo.version.release} (${androidInfo.manufacturer} ${androidInfo.model})';
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        _deviceId = iosInfo.identifierForVendor;
        _deviceInfo = 'iOS ${iosInfo.systemVersion} (${iosInfo.model})';
      }

      _securityContext = {
        'platform': Platform.operatingSystem,
        'deviceId': _deviceId,
        'deviceInfo': _deviceInfo,
        'timestamp': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      debugPrint('Error initializing security context: $e');
    }
  }

  void _logSecurityEvent(String event, Map<String, dynamic> data) {
    final logEntry = {
      'timestamp': DateTime.now().toIso8601String(),
      'event': event,
      ...data,
    };
    _securityLogs.add(logEntry);
    debugPrint('🔒 SECURITY LOG: $logEntry');
  }

  Future<void> login(BuildContext context) async {
    if (_recentAttempts.length >= maxAttemptsPerMinute) {
      final oldestAttempt = _recentAttempts.first;
      if (DateTime.now().difference(oldestAttempt).inMinutes < 1) {
        await AuthErrorHandler.handleAuthError(
          context: context,
          error: 'too_many_attempts',
          userEmail: model.getSanitizedEmail(),
          onRetry: () => login(context),
        );
        return;
      } else {
        _recentAttempts.removeRange(
            0, _recentAttempts.length - maxAttemptsPerMinute + 1);
      }
    }

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

    if (model.isAccountLocked) {
      await AuthErrorHandler.handleAuthError(
        context: context,
        error: 'account_locked',
        userEmail: model.getSanitizedEmail(),
        onRetry: () => login(context),
      );
      return;
    }

    isLoading = true;
    notifyListeners();

    final BuildContext contextRef = context;

    try {
      await _sharedPrefs.init();

      _lastLoginAttempt = DateTime.now();
      _recentAttempts.add(_lastLoginAttempt!);

      _logSecurityEvent('login_attempt_started', {
        'email': model.getSanitizedEmail(),
        'deviceId': _deviceId,
      });

      // Step 1: Authenticate with Firebase
      debugPrint("🔐 Step 1: Authenticating with Firebase...");
      UserCredential credential;
      try {
        credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: model.getSanitizedEmail(),
          password: model.passwordController.text.trim(),
        );
      } on FirebaseAuthException catch (e) {
        debugPrint("🔐 Firebase auth failed: ${e.code}");
        if (contextRef.mounted) {
          await _handleFirebaseError(contextRef, e);
        }
        return;
      }

      if (credential.user == null) {
        throw Exception('Login failed: No user returned from Firebase');
      }

      debugPrint("🔐 Firebase auth successful for: ${credential.user!.email}");

      if (!credential.user!.emailVerified) {
        if (contextRef.mounted) {
          await AuthErrorHandler.handleAuthError(
            context: contextRef,
            error: 'email-not-verified',
            userEmail: credential.user!.email ?? model.getSanitizedEmail(),
          );
        }
        await _firebaseAuth.signOut();
        return;
      }

      // Step 2: Get Firebase ID token
      final idToken = await credential.user!.getIdToken();
      if (idToken == null || idToken.isEmpty) {
        throw Exception('Failed to get Firebase ID token');
      }
      debugPrint("🔐 Got Firebase ID token");

      // Step 3: Sync with MongoDB backend
      debugPrint("🔐 Step 2: Syncing with MongoDB...");
      final response = await _apiMethod.syncFirebaseUser(
        firebaseUid: credential.user!.uid,
        email: credential.user!.email ?? '',
        idToken: idToken,
        firstName: credential.user!.displayName?.split(' ').first,
        lastName: credential.user!.displayName?.split(' ').skip(1).join(' '),
        photoURL: credential.user!.photoURL,
      );

      debugPrint("🔐 SYNC RESPONSE: $response");

      if (response['success'] == true) {
        final userData = response['data'] ?? response;
        final resolvedRole = UserRoleResolver.resolve(
          role: userData['role'],
          roles: userData['roles'],
          organizationRole: userData['organizationRole'],
          clientId: userData['clientId']?.toString(),
        );
        final clientId = userData['clientId']?.toString() ?? '';

        // Save user data locally
        await _sharedPrefs.saveAuthToken('Bearer $idToken');
        await _sharedPrefs.setString(
            'userEmail', userData['email'] ?? credential.user!.email ?? '');
        await _sharedPrefs.setString('userId', userData['_id'] ?? '');
        await _sharedPrefs.setString('firebaseUid', credential.user!.uid);
        await _sharedPrefs.setString('clientId', clientId);
        await _sharedPrefs.setString(
            'organizationId', userData['organizationId'] ?? '');
        await _sharedPrefs.setRole(resolvedRole);
        await _sharedPrefs.setString(
            'organizationName', userData['organizationName'] ?? '');
        await _sharedPrefs.setString(
            'organizationCode', userData['organizationCode'] ?? '');

        // Save user name
        final firstName = userData['firstName'] ?? '';
        final lastName = userData['lastName'] ?? '';
        final fullName = '$firstName $lastName'.trim();
        if (fullName.isNotEmpty) {
          await _sharedPrefs.setString('First LastName', fullName);
        }

        if (resolvedRole == UserRole.client && clientId.isEmpty) {
          throw Exception(
              'Client account is not linked yet. Please contact support.');
        }

        await SessionTimeoutService(sharedPrefs: _sharedPrefs)
            .markSessionStarted();

        // Register FCM token NOW that we have valid email + organizationId.
        // NotificationHandler.initState runs at app startup before login, so
        // it always skips because email/orgId aren't in prefs yet.  This is
        // the earliest place where we can reliably register the push token.
        _registerFcmTokenAfterLogin(
          email: userData['email'] ?? credential.user!.email ?? '',
          organizationId: userData['organizationId'] ?? '',
        );

        _logSecurityEvent('login_successful', {
          'email': model.getSanitizedEmail(),
          'userId': userData['_id'],
        });

        if (contextRef.mounted) {
          _navigateBasedOnRole(contextRef, userData);
        }
      } else {
        throw Exception(response['message'] ?? 'Backend sync failed');
      }
    } catch (e) {
      debugPrint("🔐 LOGIN ERROR: $e");
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

  Future<void> _handleFirebaseError(
      BuildContext context, FirebaseAuthException e) async {
    String errorMessage;
    switch (e.code) {
      case 'user-not-found':
        errorMessage = 'No account found with this email';
        break;
      case 'wrong-password':
        errorMessage = 'Incorrect password';
        break;
      case 'invalid-credential':
        errorMessage = 'Invalid email or password';
        break;
      case 'invalid-email':
        errorMessage = 'Invalid email address';
        break;
      case 'user-disabled':
        errorMessage = 'This account has been disabled';
        break;
      case 'too-many-requests':
        errorMessage = 'Too many attempts. Please try again later';
        break;
      default:
        errorMessage = 'Login failed: ${e.message ?? e.code}';
    }

    _logSecurityEvent('firebase_auth_failed', {
      'email': model.getSanitizedEmail(),
      'errorCode': e.code,
    });

    await AuthErrorHandler.handleAuthError(
      context: context,
      error: errorMessage,
      userEmail: model.getSanitizedEmail(),
      onRetry: () => login(context),
      onCreateAccount: () => Navigator.pushNamed(context, Routes.signup),
      onForgotPassword: () =>
          Navigator.pushNamed(context, Routes.forgotPassword),
    );
  }

  void _navigateBasedOnRole(
      BuildContext context, Map<String, dynamic> userData) {
    final resolvedRole = UserRoleResolver.resolve(
      role: userData['role'],
      roles: userData['roles'],
      organizationRole: userData['organizationRole'],
      clientId: userData['clientId']?.toString(),
    );
    _navigateWithOnboardingGate(context, userData, resolvedRole);
  }

  void _navigateWithOnboardingGate(
    BuildContext context,
    Map<String, dynamic> userData,
    UserRole resolvedRole,
  ) async {
    final onboardingTarget = await _onboardingGateService.resolveTarget(
      role: resolvedRole,
      userId: userData['_id']?.toString(),
      email: userData['email']?.toString(),
    );

    if (!context.mounted) {
      return;
    }

    if (resolvedRole == UserRole.admin) {
      Navigator.pushReplacementNamed(
        context,
        Routes.bottomNavBar,
        arguments: {
          'email': userData['email'],
          'role': UserRole.admin,
          'organizationId': userData['organizationId'],
          'organizationName': userData['organizationName'],
          'organizationCode': userData['organizationCode'],
        },
      );
      return;
    }

    if (resolvedRole == UserRole.client) {
      final clientId = userData['clientId']?.toString() ?? '';
      Navigator.pushReplacementNamed(
        context,
        Routes.clientDashboard,
        arguments: {
          'email': userData['email'],
          'clientId': clientId,
        },
      );
      return;
    }

    if (onboardingTarget == OnboardingGateTarget.welcome) {
      Navigator.pushReplacementNamed(context, Routes.onboarding);
      return;
    }

    Navigator.pushReplacementNamed(
      context,
      Routes.bottomNavBar,
      arguments: {
        'email': userData['email'],
        'role': UserRole.employee,
        'organizationId': userData['organizationId'],
        'organizationName': userData['organizationName'],
        'organizationCode': userData['organizationCode'],
      },
    );
  }

  /// Fire-and-forget FCM token registration after successful login.
  /// This is critical: without it, the backend has no FCM token to push
  /// emergency broadcast notifications to this device.
  void _registerFcmTokenAfterLogin({
    required String email,
    required String organizationId,
  }) {
    if (email.isEmpty || organizationId.isEmpty) {
      debugPrint('🔔 FCM_REG: Skipping post-login registration — missing email/orgId');
      return;
    }
    // Run async registration without awaiting — don't block navigation.
    Future(() async {
      try {
        debugPrint('🔔 FCM_REG: Post-login registration for $email (org: $organizationId)');
        await _fcmTokenManager.initialize(
          email,
          organizationId,
          deviceId: _deviceId,
          deviceInfo: _deviceInfo,
        );
        debugPrint('🔔 FCM_REG: ✅ Post-login FCM token registration successful');
      } catch (e) {
        debugPrint('🔔 FCM_REG: ❌ Post-login FCM token registration failed: $e');
      }
    });
  }

  @override
  void dispose() {
    model.dispose();
    super.dispose();
  }
}
