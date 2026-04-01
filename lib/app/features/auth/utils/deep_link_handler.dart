import 'package:carenest/app/core/utils/navigation.dart';
import 'package:carenest/app/features/auth/views/change_password_view.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Deep Link Handler
/// Handles deep links for the application, particularly for organization signup links
class DeepLinkHandler {
  static const String _customScheme = 'com.bishal.invoice';
  static const String _signupPath = '/signup';
  static const String _firebaseResetPasswordMode = 'resetPassword';
  static const String _firebaseVerifyEmailMode = 'verifyEmail';
  static const String _fallbackUniversalHost = 'bishalbudhathoki.com';

  static String? get _configuredUniversalHost {
    if (!dotenv.isInitialized) return null;

    final rawValue = dotenv.env['UNIVERSAL_LINK_HOST']?.trim();
    if (rawValue == null || rawValue.isEmpty) return null;

    try {
      final normalizedValue =
          rawValue.contains('://') ? rawValue : 'https://$rawValue';
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
      if (configuredHost != null) configuredHost,
    }.toList();
  }

  static String get _universalHost {
    return _configuredUniversalHost ?? _fallbackUniversalHost;
  }

  /// Handles incoming deep links
  static void handleDeepLink(String link) {
    final rawLink = link.trim();
    if (rawLink.isEmpty) return;

    Uri uri;
    try {
      uri = Uri.parse(rawLink);
    } catch (e) {
      debugPrint('DeepLinkHandler: invalid deep link "$rawLink": $e');
      return;
    }

    // Handle custom scheme links (com.bishal.invoice://signup?orgCode=...)
    if (uri.scheme == _customScheme) {
      _handleCustomSchemeLink(uri);
      return;
    }

    final firebaseAction = _extractFirebaseAction(uri);
    if (firebaseAction != null) {
      if (firebaseAction.key == _firebaseResetPasswordMode) {
        _navigateToFirebaseResetPassword(firebaseAction.value);
      } else if (firebaseAction.key == _firebaseVerifyEmailMode) {
        _handleFirebaseEmailVerification(firebaseAction.value);
      }
      return;
    }

    // Handle universal/app links (https://bishalbudhathoki.com/signup?orgCode=...)
    if ((uri.scheme == 'https' || uri.scheme == 'http') &&
        _supportedDomains.contains(uri.host) &&
        _isSignupPath(uri)) {
      final orgCode = uri.queryParameters['orgCode'];

      if (orgCode != null && orgCode.isNotEmpty) {
        // Navigate to signup page with pre-filled organization code
        _navigateToSignupWithOrgCode(orgCode);
      } else {
        // Navigate to regular signup page
        _navigateToSignup();
      }
    }
  }

  /// Handles custom scheme deep links (com.bishal.invoice://)
  static void _handleCustomSchemeLink(Uri uri) {
    final firebaseAction = _extractFirebaseAction(uri);
    if (firebaseAction != null) {
      if (firebaseAction.key == _firebaseResetPasswordMode) {
        _navigateToFirebaseResetPassword(firebaseAction.value);
      } else if (firebaseAction.key == _firebaseVerifyEmailMode) {
        _handleFirebaseEmailVerification(firebaseAction.value);
      }
      return;
    }

    // Check if it's a signup link
    if (_isSignupPath(uri)) {
      final orgCode = uri.queryParameters['orgCode'];

      if (orgCode != null && orgCode.isNotEmpty) {
        // Navigate to signup page with pre-filled organization code
        _navigateToSignupWithOrgCode(orgCode);
      } else {
        // Navigate to regular signup page
        _navigateToSignup();
      }
    }
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
  static void _navigateToSignupWithOrgCode(String orgCode) {
    final navState = navigatorKey.currentState;
    if (navState == null) {
      debugPrint(
          'DeepLinkHandler: navigator not ready, cannot route to signup yet');
      return;
    }
    navState.pushNamed(
      Routes.signup,
      arguments: {'prefilledOrgCode': orgCode},
    );
  }

  /// Navigate to regular signup page
  static void _navigateToSignup() {
    final navState = navigatorKey.currentState;
    if (navState == null) {
      debugPrint(
          'DeepLinkHandler: navigator not ready, cannot route to signup yet');
      return;
    }
    navState.pushNamed(Routes.signup);
  }

  /// Navigate to reset-password page for Firebase email action links.
  static void _navigateToFirebaseResetPassword(String oobCode) {
    final navState = navigatorKey.currentState;
    if (navState == null) {
      debugPrint(
          'DeepLinkHandler: navigator not ready, cannot route to reset password yet');
      return;
    }
    navState.push(
      MaterialPageRoute(
        builder: (_) => ChangePasswordView(firebaseOobCode: oobCode),
      ),
    );
  }

  static Future<void> _handleFirebaseEmailVerification(String oobCode) async {
    final navState = navigatorKey.currentState;
    if (navState == null) {
      debugPrint(
          'DeepLinkHandler: navigator not ready, cannot route to email verification yet');
      return;
    }

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
          'DeepLinkHandler: email verification failed: ${e.code} - ${e.message}');
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
        SnackBar(
          content: Text(message),
          backgroundColor: backgroundColor,
        ),
      );
    });
  }

  /// Public method to navigate to signup (can be used by other parts of the app)
  static void navigateToSignup(BuildContext context,
      {String? organizationCode}) {
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
  static String generateSignupLink(String organizationCode,
      {bool useCustomScheme = false}) {
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
      queryParameters:
          normalizedCode.isEmpty ? null : {'orgCode': normalizedCode},
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
