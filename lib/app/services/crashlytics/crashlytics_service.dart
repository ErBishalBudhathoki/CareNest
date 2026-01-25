import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

/// Service wrapper for Firebase Crashlytics providing crash reporting,
/// custom logging, and error tracking capabilities.
class CrashlyticsService {
  CrashlyticsService._();
  static final CrashlyticsService _instance = CrashlyticsService._();
  static CrashlyticsService get instance => _instance;

  FirebaseCrashlytics get _crashlytics => FirebaseCrashlytics.instance;

  bool _initialized = false;

  /// Initialize Crashlytics with global error handlers.
  ///
  /// Call this once in main() after Firebase.initializeApp().
  Future<void> initialize() async {
    if (_initialized) return;

    try {
      // Enable crash collection in all modes for now (can disable in debug later)
      // Set to true to ensure data is sent during testing
      await _crashlytics.setCrashlyticsCollectionEnabled(true);

      final isEnabled = _crashlytics.isCrashlyticsCollectionEnabled;
      debugPrint('✅ Crashlytics collection enabled: $isEnabled');

      // Set up Flutter framework error handler
      FlutterError.onError = (errorDetails) {
        debugPrint('----------------FIREBASE CRASHLYTICS----------------');
        debugPrint(
            'The following exception was thrown ${errorDetails.exception}:');
        debugPrint('${errorDetails.exception}');
        debugPrint('');
        debugPrint('${errorDetails.stack}');
        debugPrint('----------------------------------------------------');
        _crashlytics.recordFlutterFatalError(errorDetails);
      };

      // Handle errors outside of Flutter framework
      PlatformDispatcher.instance.onError = (error, stack) {
        debugPrint(
            '----------------FIREBASE CRASHLYTICS (Platform)----------------');
        debugPrint('Error: $error');
        debugPrint('Stack: $stack');
        debugPrint(
            '---------------------------------------------------------------');
        _crashlytics.recordError(error, stack, fatal: true);
        return true;
      };

      _initialized = true;
      debugPrint('✅ CrashlyticsService initialized successfully');
    } catch (e, stack) {
      debugPrint('❌ CrashlyticsService initialization failed: $e');
      debugPrint('Stack: $stack');
    }
  }

  /// Log a custom message that will appear in crash reports.
  ///
  /// Use this to add breadcrumbs for debugging.
  void log(String message) {
    _crashlytics.log(message);
    if (kDebugMode) {
      debugPrint('[Crashlytics] $message');
    }
  }

  /// Record a non-fatal error.
  ///
  /// Use this for handled exceptions that should still be tracked.
  Future<void> recordError(
    dynamic error,
    StackTrace? stackTrace, {
    String? reason,
    bool fatal = false,
  }) async {
    await _crashlytics.recordError(
      error,
      stackTrace,
      reason: reason,
      fatal: fatal,
    );
    if (kDebugMode) {
      final isFeedback = error.toString().contains('User Feedback');
      debugPrint('[Crashlytics] ${isFeedback ? 'Feedback' : 'Error'} recorded: $error');
      if (stackTrace != null && !isFeedback) debugPrint('Stack: $stackTrace');
    }
  }

  /// Set the user identifier for crash reports.
  ///
  /// Call this after user login to associate crashes with users.
  Future<void> setUserIdentifier(String userId) async {
    await _crashlytics.setUserIdentifier(userId);
    log('User identified: ${userId.length > 10 ? '${userId.substring(0, 10)}...' : userId}');
  }

  /// Clear user identifier on logout.
  Future<void> clearUserIdentifier() async {
    await _crashlytics.setUserIdentifier('');
  }

  /// Set a custom key-value pair for crash context.
  Future<void> setCustomKey(String key, dynamic value) async {
    await _crashlytics.setCustomKey(key, value);
  }

  /// Force a crash for testing purposes.
  ///
  /// ⚠️ WARNING: Only use in development for testing!
  void forceCrashForTesting() {
    if (kDebugMode) {
      debugPrint('⚠️ Forcing test crash...');
    }
    _crashlytics.crash();
  }

  /// Check if Crashlytics collection is enabled.
  Future<bool> isCollectionEnabled() async {
    return _crashlytics.isCrashlyticsCollectionEnabled;
  }

  /// Enable or disable Crashlytics collection.
  Future<void> setCollectionEnabled(bool enabled) async {
    await _crashlytics.setCrashlyticsCollectionEnabled(enabled);
  }
}
