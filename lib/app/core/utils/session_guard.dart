import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carenest/app/core/utils/navigation.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';

/// Backend error codes meaning "the credential you sent is no good".
/// Matched deliberately narrow: login failures use different codes
/// (e.g. INVALID_CREDENTIALS), so a wrong password never triggers this.
const _expiredCredentialCodes = <String>{'TOKEN_EXPIRED', 'INVALID_TOKEN'};

/// True when a decoded backend response means the presented credential is
/// expired/invalid. Pure logic — unit-tested.
bool isSessionExpired(Map<String, dynamic> response) {
  if (response['statusCode']?.toString() != '401') return false;
  final code =
      response['code']?.toString() ?? response['errorCode']?.toString() ?? '';
  return _expiredCredentialCodes.contains(code);
}

/// True when a raw HTTP response carries an expired/invalid credential
/// rejection. Pure logic — unit-tested.
bool isSessionExpiredResponse(int statusCode, Map<String, dynamic>? body) {
  if (statusCode != 401 || body == null) return false;
  final code = body['code']?.toString() ?? body['errorCode']?.toString() ?? '';
  return _expiredCredentialCodes.contains(code);
}

DateTime? _lastPromptAt;

/// Routes to re-login when the session is hard-expired (a forced token
/// refresh was already attempted upstream and still failed, or no refresh
/// was possible). Throttled so concurrent 401s prompt once. Fire-and-forget.
void maybePromptReLogin(Map<String, dynamic> response) {
  if (!isSessionExpired(response)) return;

  final now = DateTime.now();
  if (_lastPromptAt != null &&
      now.difference(_lastPromptAt!) < const Duration(seconds: 5)) {
    return;
  }
  _lastPromptAt = now;

  () async {
    try {
      // Best effort: drop cached credentials so stale role gates and
      // cached tokens cannot keep the app in a half-authed limbo.
      try {
        await FirebaseAuth.instance.signOut();
      } catch (_) {}
      try {
        final prefs = SharedPreferencesUtils();
        await prefs.init();
        await prefs.clearAllUserData();
      } catch (_) {}
    } catch (_) {}
    final navigator = navigatorKey.currentState;
    final context = navigatorKey.currentContext;
    if (navigator == null || context == null) return;
    navigator.pushNamedAndRemoveUntil(Routes.login, (_) => false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Session expired. Please sign in again.'),
        duration: Duration(seconds: 4),
      ),
    );
  }();
}
