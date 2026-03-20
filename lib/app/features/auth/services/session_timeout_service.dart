import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

/// Enforces max session age and provides a single logout+cleanup path.
class SessionTimeoutService {
  SessionTimeoutService({
    SharedPreferencesUtils? sharedPrefs,
    FirebaseAuth? firebaseAuth,
  })  : _sharedPrefs = sharedPrefs ?? SharedPreferencesUtils(),
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  // Security requirement: users must re-authenticate after this duration.
  static const Duration maxSessionAge = Duration(hours: 10);
  static const String _kSessionStartedAtMsKey = 'sessionStartedAtMs';

  final SharedPreferencesUtils _sharedPrefs;
  final FirebaseAuth _firebaseAuth;

  Future<void> markSessionStarted({DateTime? startedAt}) async {
    await _sharedPrefs.init();
    final startMs = (startedAt ?? DateTime.now()).millisecondsSinceEpoch;
    await _sharedPrefs.setInt(_kSessionStartedAtMsKey, startMs);
  }

  Future<void> clearSessionMetadata() async {
    await _sharedPrefs.init();
    await _sharedPrefs.remove(_kSessionStartedAtMsKey);
  }

  Future<DateTime?> getSessionStartedAt() async {
    await _sharedPrefs.init();

    final storedMs = _sharedPrefs.getInt(_kSessionStartedAtMsKey);
    if (storedMs != null && storedMs > 0) {
      return DateTime.fromMillisecondsSinceEpoch(storedMs);
    }

    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) return null;

    try {
      final tokenResult = await firebaseUser.getIdTokenResult(false);
      final authTime = tokenResult.authTime;
      if (authTime != null) {
        await markSessionStarted(startedAt: authTime);
        return authTime;
      }
    } catch (e) {
      debugPrint(
          'SessionTimeoutService: failed to resolve authTime from token: $e');
    }

    final lastSignInTime = firebaseUser.metadata.lastSignInTime;
    if (lastSignInTime != null) {
      await markSessionStarted(startedAt: lastSignInTime);
    }
    return lastSignInTime;
  }

  Future<bool> isSessionExpired({Duration? timeout}) async {
    final startedAt = await getSessionStartedAt();
    if (startedAt == null) return true;

    final effectiveTimeout = timeout ?? maxSessionAge;
    final elapsed = DateTime.now().difference(startedAt);
    return elapsed >= effectiveTimeout;
  }

  Future<bool> isSessionValid({Duration? timeout}) async {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) {
      debugPrint('SessionTimeoutService: no Firebase user, session invalid');
      return false;
    }

    final expired = await isSessionExpired(timeout: timeout);
    if (expired) {
      debugPrint(
          'SessionTimeoutService: session expired for user ${firebaseUser.email}');
      return false;
    }

    try {
      final idToken = await firebaseUser.getIdToken(true);
      if (idToken == null || idToken.isEmpty) {
        debugPrint('SessionTimeoutService: Firebase ID token missing');
        return false;
      }
      return true;
    } catch (e) {
      debugPrint('SessionTimeoutService: token validation failed: $e');
      return false;
    }
  }

  Future<void> logoutAndClearSession({String? reason}) async {
    await _sharedPrefs.init();
    await clearSessionMetadata();
    await _sharedPrefs.clearAllUserData();

    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      debugPrint('SessionTimeoutService: Firebase sign out failed: $e');
    }

    if (reason != null && reason.isNotEmpty) {
      debugPrint('SessionTimeoutService: session cleared ($reason)');
    }
  }
}
