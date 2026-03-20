import 'package:carenest/app/core/utils/navigation.dart';
import 'package:carenest/app/features/auth/views/change_password_view.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import '../../../../env.dart';

/// Deep Link Handler
/// Handles deep links for the application, particularly for organization signup links
class DeepLinkHandler {
  static const String _customScheme = 'com.bishal.invoice';
  static String get _baseUrl {
    final baseUrlValue = env['baseUrl']!;
    // If baseUrl is a custom scheme, use default universal host for share links.
    if (baseUrlValue.contains(_customScheme)) {
      return _defaultUniversalHost;
    }

    // Otherwise, try to parse as URL and extract host
    try {
      final parsed = Uri.parse(baseUrlValue);
      if (parsed.host.isNotEmpty) return parsed.host;
      return baseUrlValue;
    } catch (e) {
      // Fallback to the original value if parsing fails
      return baseUrlValue;
    }
  }

  static const String _signupPath = '/signup';
  static const String _firebaseResetPasswordMode = 'resetPassword';
  static const String _defaultUniversalHost = 'bishalbudhathoki.tech';

  // Additional supported domains for backward compatibility
  static const List<String> _supportedDomains = [
    'bishalbudhathoki.tech',
    'bishalbudhathoki.com',
  ];

  static String get _universalHost {
    final host = _baseUrl.toLowerCase();
    if (_supportedDomains.contains(host)) {
      return host;
    }
    return _defaultUniversalHost;
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

    // Handle Firebase reset-password action links.
    final resetCode = _extractFirebaseResetCode(uri);
    if (resetCode != null && resetCode.isNotEmpty) {
      _navigateToFirebaseResetPassword(resetCode);
      return;
    }

    // Handle universal/app links (https://bishalbudhathoki.tech/signup?orgCode=...)
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
    final resetCode = _extractFirebaseResetCode(uri);
    if (resetCode != null && resetCode.isNotEmpty) {
      _navigateToFirebaseResetPassword(resetCode);
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

  static String? _extractFirebaseResetCode(Uri uri) {
    final mode = uri.queryParameters['mode']?.trim();
    final oobCode = uri.queryParameters['oobCode']?.trim();
    if (mode == _firebaseResetPasswordMode &&
        oobCode != null &&
        oobCode.isNotEmpty) {
      return oobCode;
    }

    // Some dynamic links embed the real action URL in a "link" query param.
    final nestedLink = uri.queryParameters['link'];
    if (nestedLink != null && nestedLink.isNotEmpty) {
      try {
        final nestedUri = Uri.parse(nestedLink);
        final nestedMode = nestedUri.queryParameters['mode']?.trim();
        final nestedCode = nestedUri.queryParameters['oobCode']?.trim();
        if (nestedMode == _firebaseResetPasswordMode &&
            nestedCode != null &&
            nestedCode.isNotEmpty) {
          return nestedCode;
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
