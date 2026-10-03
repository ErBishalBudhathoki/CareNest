import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/test.dart';
import 'package:firebase_messaging_platform_interface/firebase_messaging_platform_interface.dart';

/// Firebase test seams for widget tests.
///
/// Both packages below are declared as `dev_dependencies` in pubspec.yaml (test
/// only, never shipped) rather than reached for as transitive dependencies,
/// which would break silently on an upgrade.
///
/// Both are needed: `FirebaseMessaging.instance` calls `Firebase.app()` before
/// touching the messaging platform, so mocking the platform alone still throws
/// `[core/no-app]`.
class FakeFirebaseMessaging extends FirebaseMessagingPlatform {
  /// What [getNotificationSettings] reports.
  AuthorizationStatus currentStatus = AuthorizationStatus.notDetermined;

  /// What [requestPermission] reports. Defaults to [currentStatus].
  AuthorizationStatus? requestResult;

  int getNotificationSettingsCalls = 0;
  int requestPermissionCalls = 0;

  @override
  Future<NotificationSettings> getNotificationSettings() async {
    getNotificationSettingsCalls++;
    return _settings(currentStatus);
  }

  @override
  Future<NotificationSettings> requestPermission({
    bool alert = true,
    bool announcement = true,
    bool badge = true,
    bool carPlay = true,
    bool criticalAlert = true,
    bool providesAppNotificationSettings = true,
    bool sound = true,
    bool provisional = false,
  }) async {
    requestPermissionCalls++;
    return _settings(requestResult ?? currentStatus);
  }

  NotificationSettings _settings(AuthorizationStatus status) =>
      NotificationSettings(
        authorizationStatus: status,
        alert: AppleNotificationSetting.enabled,
        announcement: AppleNotificationSetting.enabled,
        badge: AppleNotificationSetting.enabled,
        carPlay: AppleNotificationSetting.notSupported,
        criticalAlert: AppleNotificationSetting.notSupported,
        lockScreen: AppleNotificationSetting.enabled,
        notificationCenter: AppleNotificationSetting.enabled,
        providesAppNotificationSettings: AppleNotificationSetting.enabled,
        showPreviews: AppleShowPreviewSetting.always,
        sound: AppleNotificationSetting.enabled,
        timeSensitive: AppleNotificationSetting.notSupported,
      );

  @override
  Future<bool> isSupported() async => true;

  /// FirebaseMessaging's constructor calls `FirebaseMessagingPlatform.instance
  /// .delegateFor(app:)` and uses the result as its delegate, so this has to
  /// return something that answers [getNotificationSettings].
  @override
  FirebaseMessagingPlatform delegateFor({required FirebaseApp app}) => this;

  @override
  FirebaseMessagingPlatform setInitialValues({bool? isAutoInitEnabled}) => this;

  @override
  bool get isAutoInitEnabled => true;

  @override
  Stream<String> get onTokenRefresh => const Stream<String>.empty();

  @override
  Future<String?> getToken({
    String? vapidKey,
    String? serviceWorkerScriptPath,
  }) async => 'fake-fcm-token';
}

/// One shared instance for the whole test run.
///
/// `FirebaseMessaging` memoises its delegate per Firebase app in a private
/// static, so replacing the platform with a fresh object after the first test
/// has no effect: the cached delegate keeps pointing at the original. Mutating
/// one long-lived fake is the only way to change what later tests observe.
final FakeFirebaseMessaging fakeMessaging = FakeFirebaseMessaging();

/// Installs the Firebase test seams and points [fakeMessaging] at [status].
/// Call from `setUp`.
Future<FakeFirebaseMessaging> installFirebaseMessaging({
  AuthorizationStatus currentStatus = AuthorizationStatus.notDetermined,
  AuthorizationStatus? requestResult,
}) async {
  // Both halves are required: the core mocks let Firebase.initializeApp()
  // succeed, and the initialised app is what lets FirebaseMessaging.instance
  // resolve. Without the app, every call throws [core/no-app].
  setupFirebaseCoreMocks();
  await Firebase.initializeApp();

  fakeMessaging
    ..currentStatus = currentStatus
    ..requestResult = requestResult
    ..getNotificationSettingsCalls = 0
    ..requestPermissionCalls = 0;

  FirebaseMessagingPlatform.instance = fakeMessaging;
  return fakeMessaging;
}

/// Detaches the fake. Call from `tearDown` so nothing leaks between tests.
void removeFirebaseMessaging() {
  // MethodChannelFirebaseMessaging lives in the firebase_messaging package, not
  // in this platform interface, so fall back to a minimal subclass whose methods
  // throw. Anything really calling through outside a test should be loud.
  FirebaseMessagingPlatform.instance = _DetachedMessaging();
}

class _DetachedMessaging extends FirebaseMessagingPlatform {
  @override
  Future<bool> isSupported() async => true;
}
