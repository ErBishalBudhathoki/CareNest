import 'dart:async';

import 'package:carenest/app/core/utils/navigation.dart';
import 'package:carenest/app/features/auth/views/change_password_view.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carenest/config/build_config.dart';

/// Deep Link Handler
/// Handles deep links for the application, particularly for organization signup links
class DeepLinkHandler {
  static const String _customScheme = 'com.bishal.invoice';
  static const String _signupPath = '/signup';
  static const String _firebaseResetPasswordMode = 'resetPassword';
  static const String _firebaseVerifyEmailMode = 'verifyEmail';
  static const String _fallbackUniversalHost = 'bishalbudhathoki.com';

  static String? get _configuredUniversalHost {
    final rawValue = BuildConfig.universalLinkHost.trim();
    if (rawValue.isEmpty) return null;

    try {
      final normalizedValue = rawValue.contains('://')
          ? rawValue
          : 'https://$rawValue';
      final parsed = Uri.parse(normalizedValue);
      final host = parsed.host.trim().toLowerCase();
      return host.isEmpty ? null : host;
    } catch (_) {
      return null;
    }
  }

  // Additional supported domains for backward compatibility
  static List<String> get _supportedDomains {
    final configuredHost = _configuredUniversalHost;
    return {
      'bishalbudhathoki.tech',
      'bishalbudhathoki.com',
      'careservices.page.link',
      ?configuredHost,
    }.toList();
  }

  static String get _universalHost {
    return _configuredUniversalHost ?? _fallbackUniversalHost;
  }

  /// Handles an incoming deep link.
  ///
  /// Returns true only when this actually navigated somewhere, or was
  /// guaranteed to navigate once its async work completes.
  ///
  /// Callers use the result to decide whether the deep link has taken over
  /// navigation. The splash screen stands down when it sees
  /// `DeepLinkState.handled`, so returning true for a link we ignored or could
  /// not route would strand the user on the splash screen for good.
  static bool handleDeepLink(String link) {
    final rawLink = link.trim();
    if (rawLink.isEmpty) return false;

    Uri uri;
    try {
      uri = Uri.parse(rawLink);
    } catch (e) {
      debugPrint('DeepLinkHandler: invalid deep link "$rawLink": $e');
      return false;
    }

    // Handle custom scheme links (com.bishal.invoice://signup?orgCode=...)
    if (uri.scheme == _customScheme) {
      return _handleCustomSchemeLink(uri);
    }

    final firebaseAction = _extractFirebaseAction(uri);
    if (firebaseAction != null) {
      if (firebaseAction.key == _firebaseResetPasswordMode) {
        return _navigateToFirebaseResetPassword(firebaseAction.value);
      } else if (firebaseAction.key == _firebaseVerifyEmailMode) {
        return _handleFirebaseEmailVerification(firebaseAction.value);
      }
      return false;
    }

    // Handle universal/app links (https://bishalbudhathoki.com/signup?orgCode=...)
    if ((uri.scheme == 'https' || uri.scheme == 'http') &&
        _supportedDomains.contains(uri.host) &&
        _isSignupPath(uri)) {
      final orgCode = uri.queryParameters['orgCode'];

      if (orgCode != null && orgCode.isNotEmpty) {
        // Navigate to signup page with pre-filled organization code
        return _navigateToSignupWithOrgCode(orgCode);
      }
      // Navigate to regular signup page
      return _navigateToSignup();
    }

    debugPrint('DeepLinkHandler: ignoring unrecognised link "$rawLink"');
    return false;
  }

  /// Handles custom scheme deep links (com.bishal.invoice://)
  ///
  /// Returns true only if navigation happened or is guaranteed to.
  static bool _handleCustomSchemeLink(Uri uri) {
    final firebaseAction = _extractFirebaseAction(uri);
    if (firebaseAction != null) {
      if (firebaseAction.key == _firebaseResetPasswordMode) {
        return _navigateToFirebaseResetPassword(firebaseAction.value);
      } else if (firebaseAction.key == _firebaseVerifyEmailMode) {
        return _handleFirebaseEmailVerification(firebaseAction.value);
      }
      return false;
    }

    // Check if it's a signup link
    if (_isSignupPath(uri)) {
      final orgCode = uri.queryParameters['orgCode'];

      if (orgCode != null && orgCode.isNotEmpty) {
        // Navigate to signup page with pre-filled organization code
        return _navigateToSignupWithOrgCode(orgCode);
      }
      // Navigate to regular signup page
      return _navigateToSignup();
    }

    debugPrint('DeepLinkHandler: no custom-scheme action for "$uri"');
    return false;
  }

  static bool _isSignupPath(Uri uri) {
    if (uri.host == 'signup') return true;
    final normalizedPath = uri.path.toLowerCase();
    if (normalizedPath == _signupPath || normalizedPath == '$_signupPath/') {
      return true;
    }
    return uri.pathSegments.any((segment) => segment.toLowerCase() == 'signup');
  }

  static MapEntry<String, String>? _extractFirebaseAction(Uri uri) {
    final mode = uri.queryParameters['mode']?.trim();
    final oobCode = uri.queryParameters['oobCode']?.trim();
    if ((mode == _firebaseResetPasswordMode ||
            mode == _firebaseVerifyEmailMode) &&
        oobCode != null &&
        oobCode.isNotEmpty) {
      return MapEntry(mode!, oobCode);
    }

    // Some dynamic links embed the real action URL in a "link" query param.
    final nestedLink = uri.queryParameters['link'];
    if (nestedLink != null && nestedLink.isNotEmpty) {
      try {
        final nestedUri = Uri.parse(nestedLink);
        final nestedMode = nestedUri.queryParameters['mode']?.trim();
        final nestedCode = nestedUri.queryParameters['oobCode']?.trim();
        if ((nestedMode == _firebaseResetPasswordMode ||
                nestedMode == _firebaseVerifyEmailMode) &&
            nestedCode != null &&
            nestedCode.isNotEmpty) {
          return MapEntry(nestedMode!, nestedCode);
        }
      } catch (_) {
        // Ignore malformed nested links and continue.
      }
    }
    return null;
  }

  /// Navigate to signup page with organization code
  static bool _navigateToSignupWithOrgCode(String orgCode) {
    final navState = navigatorKey.currentState;
    if (navState == null) {
      debugPrint(
        'DeepLinkHandler: navigator not ready, cannot route to signup yet',
      );
      return false;
    }
    navState.pushNamed(Routes.signup, arguments: {'prefilledOrgCode': orgCode});
    return true;
  }

  /// Navigate to regular signup page
  static bool _navigateToSignup() {
    final navState = navigatorKey.currentState;
    if (navState == null) {
      debugPrint(
        'DeepLinkHandler: navigator not ready, cannot route to signup yet',
      );
      return false;
    }
    navState.pushNamed(Routes.signup);
    return true;
  }

  /// Navigate to reset-password page for Firebase email action links.
  static bool _navigateToFirebaseResetPassword(String oobCode) {
    final navState = navigatorKey.currentState;
    if (navState == null) {
      debugPrint(
        'DeepLinkHandler: navigator not ready, cannot route to reset password yet',
      );
      return false;
    }
    navState.push(
      MaterialPageRoute(
        builder: (_) => ChangePasswordView(firebaseOobCode: oobCode),
      ),
    );
    return true;
  }

  /// Handles a Firebase email-verification action link.
  ///
  /// Synchronous by design: it reports whether navigation is guaranteed, then
  /// does the async Firebase work in the background. Every branch below routes
  /// to the login screen, so once the navigator exists the outcome is decided.
  static bool _handleFirebaseEmailVerification(String oobCode) {
    final navState = navigatorKey.currentState;
    if (navState == null) {
      debugPrint(
        'DeepLinkHandler: navigator not ready, cannot route to email verification yet',
      );
      return false;
    }

    unawaited(_applyEmailVerification(oobCode));
    return true;
  }

  static Future<void> _applyEmailVerification(String oobCode) async {
    final navState = navigatorKey.currentState;
    if (navState == null) return;

    try {
      await FirebaseAuth.instance.applyActionCode(oobCode);
      await FirebaseAuth.instance.currentUser?.reload();

      navState.pushNamedAndRemoveUntil(Routes.login, (route) => false);
      _showSnackBar(
        'Email verified successfully. You can now sign in.',
        backgroundColor: Colors.green,
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(
        'DeepLinkHandler: email verification failed: ${e.code} - ${e.message}',
      );
      navState.pushNamedAndRemoveUntil(Routes.login, (route) => false);
      _showSnackBar(
        e.message ?? 'This verification link is invalid or has expired.',
        backgroundColor: Colors.red,
      );
    } catch (e) {
      debugPrint('DeepLinkHandler: email verification failed: $e');
      navState.pushNamedAndRemoveUntil(Routes.login, (route) => false);
      _showSnackBar(
        'Failed to verify email. Please request a new verification email.',
        backgroundColor: Colors.red,
      );
    }
  }

  static void _showSnackBar(String message, {required Color backgroundColor}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = navigatorKey.currentContext;
      if (context == null) return;
      final messenger = ScaffoldMessenger.maybeOf(context);
      messenger?.showSnackBar(
        SnackBar(content: Text(message), backgroundColor: backgroundColor),
      );
    });
  }

  /// Public method to navigate to signup (can be used by other parts of the app)
  static void navigateToSignup(
    BuildContext context, {
    String? organizationCode,
  }) {
    if (organizationCode != null && organizationCode.isNotEmpty) {
      Navigator.pushNamed(
        context,
        '/signup',
        arguments: {'prefilledOrgCode': organizationCode},
      );
    } else {
      Navigator.pushNamed(context, '/signup');
    }
  }

  /// Generates a shareable signup link with organization code
  /// Uses universal link by default so users without the app can fall back to web/App Store.
  static String generateSignupLink(
    String organizationCode, {
    bool useCustomScheme = false,
  }) {
    final normalizedCode = organizationCode.trim();
    if (normalizedCode.isEmpty) {
      return Uri(
        scheme: 'https',
        host: _universalHost,
        path: 'signup',
      ).toString();
    }

    if (useCustomScheme) {
      return generateCustomSchemeSignupLink(normalizedCode);
    }

    return Uri(
      scheme: 'https',
      host: _universalHost,
      path: 'signup',
      queryParameters: {'orgCode': normalizedCode},
    ).toString();
  }

  /// Generates a custom scheme signup link
  static String generateCustomSchemeSignupLink(String organizationCode) {
    final normalizedCode = organizationCode.trim();
    return Uri(
      scheme: _customScheme,
      host: 'signup',
      queryParameters: normalizedCode.isEmpty
          ? null
          : {'orgCode': normalizedCode},
    ).toString();
  }

  /// Validates if a link is a valid signup link (supports both schemes)
  static bool isValidSignupLink(String link) {
    try {
      final uri = Uri.parse(link);

      // Check custom scheme links
      if (uri.scheme == _customScheme) {
        return _isSignupPath(uri);
      }

      // Check domain-based links
      return (uri.scheme == 'https' || uri.scheme == 'http') &&
          _supportedDomains.contains(uri.host) &&
          _isSignupPath(uri);
    } catch (e) {
      return false;
    }
  }

  /// Extracts organization code from a signup link (supports both schemes)
  static String? extractOrgCodeFromLink(String link) {
    try {
      final uri = Uri.parse(link);
      if (isValidSignupLink(link)) {
        return uri.queryParameters['orgCode'];
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
