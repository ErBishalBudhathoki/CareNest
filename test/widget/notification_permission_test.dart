import 'package:carenest/app/core/utils/permission_manager.dart';
import 'package:firebase_messaging_platform_interface/firebase_messaging_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/firebase_test_harness.dart';

/// Regression coverage for the "Enable Notifications" nag.
///
/// The old flow called `requestPermission` unconditionally and then showed a
/// pointer-to-Settings dialog whenever the user had denied before. Since the
/// OS only ever shows its prompt once, that dialog reappeared on every single
/// launch: dismiss it, relaunch, get it again. It also offered Settings to users
/// who had not been prompted yet.
///
/// The contract now:
///   * status is read before anything can prompt;
///   * the OS prompt is only ever requested while `notDetermined`;
///   * the Settings nudge is shown at most once per install.
void main() {
  Future<void> pumpHost(WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: SizedBox())),
    );
  }

  Finder dialog() => find.byType(AlertDialog);

  setUp(() => SharedPreferences.setMockInitialValues(<String, Object>{}));

  tearDown(() async {
    removeFirebaseMessaging();
    SharedPreferences.setMockInitialValues(<String, Object>{});
  });

  group('notification permission', () {
    testWidgets('prompts once when never asked, then records the answer', (
      tester,
    ) async {
      final fake = await installFirebaseMessaging(
        currentStatus: AuthorizationStatus.notDetermined,
        requestResult: AuthorizationStatus.denied,
      );
      await pumpHost(tester);

      await PermissionManager.requestNotificationPermission(
        tester.element(find.byType(Scaffold)),
      );
      await tester.pumpAndSettle();

      expect(fake.getNotificationSettingsCalls, 1);
      expect(fake.requestPermissionCalls, 1);
      expect(
        dialog(),
        findsNothing,
        reason:
            'a user who just answered the prompt must not be sent to Settings',
      );
    });

    testWidgets('does not prompt again once already allowed', (tester) async {
      final fake = await installFirebaseMessaging(
        currentStatus: AuthorizationStatus.authorized,
      );
      await pumpHost(tester);

      await PermissionManager.requestNotificationPermission(
        tester.element(find.byType(Scaffold)),
      );
      await tester.pumpAndSettle();

      expect(fake.requestPermissionCalls, 0);
      expect(dialog(), findsNothing);
      expect(
        fake.getNotificationSettingsCalls,
        1,
        reason: 'status must be read first, and the flow must not have thrown',
      );
    });

    testWidgets('does not prompt an already-denied user again', (tester) async {
      final fake = await installFirebaseMessaging(
        currentStatus: AuthorizationStatus.denied,
      );
      await pumpHost(tester);

      await PermissionManager.requestNotificationPermission(
        tester.element(find.byType(Scaffold)),
      );
      await tester.pumpAndSettle();

      expect(
        fake.requestPermissionCalls,
        0,
        reason: 'the OS will not show it again, so asking is pointless',
      );
      expect(
        fake.getNotificationSettingsCalls,
        1,
        reason: 'the flow must actually run, not bail out early',
      );
    });

    testWidgets('shows the Settings nudge at most once per install', (
      tester,
    ) async {
      await installFirebaseMessaging(currentStatus: AuthorizationStatus.denied);
      await pumpHost(tester);
      final context = tester.element(find.byType(Scaffold));

      // First visit after denial: one helpful nudge.
      await PermissionManager.requestNotificationPermission(context);
      await tester.pumpAndSettle();
      expect(dialog(), findsOneWidget);

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(dialog(), findsNothing);

      // Every later launch must be silent. This was the nag loop.
      for (var launch = 0; launch < 3; launch++) {
        await PermissionManager.requestNotificationPermission(context);
        await tester.pumpAndSettle();
        expect(
          dialog(),
          findsNothing,
          reason: 'launch $launch must not re-show the nudge',
        );
      }
    });

    testWidgets(
      'a denied user is nudged only once even without the OS prompt',
      (tester) async {
        await installFirebaseMessaging(
          currentStatus: AuthorizationStatus.denied,
        );
        await pumpHost(tester);
        final context = tester.element(find.byType(Scaffold));

        await PermissionManager.requestNotificationPermission(context);
        await tester.pumpAndSettle();
        expect(dialog(), findsOneWidget);

        // Never dismissed by the user (e.g. they backgrounded the app).
        await PermissionManager.requestNotificationPermission(context);
        await tester.pumpAndSettle();
        expect(
          dialog(),
          findsOneWidget,
          reason:
              'the nudge is recorded before it is shown, so a repeat call '
              'must not stack a second dialog on the open one',
        );
      },
    );

    testWidgets('granting later in Settings makes the nudge available again', (
      tester,
    ) async {
      await installFirebaseMessaging(currentStatus: AuthorizationStatus.denied);
      await pumpHost(tester);
      final context = tester.element(find.byType(Scaffold));

      await PermissionManager.requestNotificationPermission(context);
      await tester.pumpAndSettle();
      expect(dialog(), findsOneWidget);
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      // User fixes it in Settings, then denies again much later.
      removeFirebaseMessaging();
      await installFirebaseMessaging(
        currentStatus: AuthorizationStatus.authorized,
      );
      await PermissionManager.requestNotificationPermission(context);
      await tester.pumpAndSettle();

      removeFirebaseMessaging();
      await installFirebaseMessaging(currentStatus: AuthorizationStatus.denied);
      await PermissionManager.requestNotificationPermission(context);
      await tester.pumpAndSettle();

      expect(
        dialog(),
        findsOneWidget,
        reason: 'a fresh cycle should be allowed one nudge again',
      );
    });
  });
}
