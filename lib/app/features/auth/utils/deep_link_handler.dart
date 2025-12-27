import 'package:carenest/app/core/utils/navigation.dart';
import 'package:flutter/material.dart';
import '../../../../env.dart';

/// Deep Link Handler
/// Handles deep links for the application, particularly for organization signup links
class DeepLinkHandler {
  static String get _baseUrl {
    final baseUrlValue = env['baseUrl']!;
    // If baseUrl is already a custom scheme (like com.bishal.invoice), use it directly
    if (baseUrlValue.contains('com.bishal.invoice')) {
      return 'com.bishal.invoice';
    }
    // Otherwise, try to parse as URL and extract host
    try {
      return Uri.parse(baseUrlValue).host;
    } catch (e) {
      // Fallback to the original value if parsing fails
      return baseUrlValue;
    }
  }

  static const String _signupPath = '/signup';

  // Additional supported domains for backward compatibility
  static const List<String> _supportedDomains = [
    'com.bishal.invoice',
    'bishalbudhathoki.tech',
    'bishalbudhathoki.com'
  ];

  /// Handles incoming deep links
  static void handleDeepLink(String link) {
    final uri = Uri.parse(link);

    if (uri.scheme == 'com.bishal.invoice') {
      return;
    }

    // Handle domain-based links (https://bishalbudhathoki.tech/ or https://com.bishal.invoice/)
    if ((uri.scheme == 'https' || uri.scheme == 'http') &&
        _supportedDomains.contains(uri.host) &&
        uri.path == _signupPath) {
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
    // Check if it's a signup link
    if (uri.host == 'signup' ||
        uri.path == '/signup' ||
        uri.pathSegments.contains('signup')) {
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

  /// Navigate to signup page with organization code
  static void _navigateToSignupWithOrgCode(String orgCode) {
    // Use standard Flutter navigation instead of GetX to avoid GlobalKey conflicts
    final context = navigatorKey.currentContext;
    if (context != null) {
      Navigator.pushNamed(
        context,
        '/signup',
        arguments: {'prefilledOrgCode': orgCode},
      );
    }
  }

  /// Navigate to regular signup page
  static void _navigateToSignup() {
    // Use standard Flutter navigation instead of GetX to avoid GlobalKey conflicts
    final context = navigatorKey.currentContext;
    if (context != null) {
      Navigator.pushNamed(context, '/signup');
    }
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
  /// Returns custom scheme link when baseUrl is a custom scheme, otherwise returns HTTPS link
  static String generateSignupLink(String organizationCode,
      {bool useCustomScheme = false}) {
    // If baseUrl is a custom scheme or useCustomScheme is true, use custom scheme
    if (useCustomScheme || _baseUrl == 'com.bishal.invoice') {
      return 'com.bishal.invoice://signup?orgCode=$organizationCode';
    }
    return 'https://$_baseUrl$_signupPath?orgCode=$organizationCode';
  }

  /// Generates a custom scheme signup link
  static String generateCustomSchemeSignupLink(String organizationCode) {
    return 'com.bishal.invoice://signup?orgCode=$organizationCode';
  }

  /// Validates if a link is a valid signup link (supports both schemes)
  static bool isValidSignupLink(String link) {
    try {
      final uri = Uri.parse(link);

      // Check custom scheme links
      if (uri.scheme == 'com.bishal.invoice') {
        return uri.host == 'signup' ||
            uri.path == '/signup' ||
            uri.pathSegments.contains('signup');
      }

      // Check domain-based links
      return (uri.scheme == 'https' || uri.scheme == 'http') &&
          _supportedDomains.contains(uri.host) &&
          uri.path == _signupPath;
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
