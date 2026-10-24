/// On-device end-to-end check of the worker clock-in / clock-out flow.
///
/// The SIL tier-1 work made worked time land for roster shifts that have no
/// `ClientAssignment` row. Unit and widget tests prove the service and the
/// screen in isolation; this test proves the whole hop on a real device against
/// the development backend: worker login -> home shift card -> details ->
/// Start Shift -> End Shift -> shift picker -> confirm -> "Time updated
/// successfully", i.e. the day's hours are now in worked time.
///
/// Credentials are injected, never committed:
///
///   export WORKER_EMAIL=...
///   export WORKER_PASSWORD=...
///   flutter test integration_test/sil_worker_clock_in_out_test.dart \
///     -d emulator-5554 --flavor development \
///     --dart-define=DEVELOPMENT_URL="$DEVELOPMENT_URL" \
///     --dart-define=WORKER_EMAIL="$WORKER_EMAIL" \
///     --dart-define=WORKER_PASSWORD="$WORKER_PASSWORD"
///
/// Preconditions (development database):
///   * the worker has at least one shift this week that has not been logged
///     yet — run `node backend/scripts/plan_sil_current_week.js` (and
///     `reset_sil_test_week.js` for a repeatable week);
///   * no timer is already running for this worker from a previous run.
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:carenest/app/features/home/widgets/bauhaus_appointment_card.dart';
import 'package:carenest/main_development.dart' as app;

const workerEmail = String.fromEnvironment('WORKER_EMAIL');
const workerPassword = String.fromEnvironment('WORKER_PASSWORD');

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  Future<void> settle(WidgetTester tester, int seconds) async {
    for (var i = 0; i < seconds * 5; i++) {
      await tester.pump(const Duration(milliseconds: 200));
    }
  }

  String screenText() {
    final texts = <String>[];
    for (final element in find.byType(Text).evaluate()) {
      final data = (element.widget as Text).data;
      if (data != null && data.trim().isNotEmpty) texts.add(data.trim());
    }
    return texts.take(40).join(' · ');
  }

  Future<bool> waitFor(
    WidgetTester tester,
    Finder finder, {
    Duration timeout = const Duration(seconds: 30),
    String label = '',
  }) async {
    final stopwatch = Stopwatch()..start();
    while (finder.evaluate().isEmpty && stopwatch.elapsed < timeout) {
      await tester.pump(const Duration(milliseconds: 500));
    }
    final found = finder.evaluate().isNotEmpty;
    if (!found && label.isNotEmpty) {
      debugPrint('⏱️ timed out waiting for $label; on-screen now: ${screenText()}');
    }
    return found;
  }

  Future<void> signIn(WidgetTester tester) async {
    final fields = find.byType(TextField);
    if (find.byType(AutofillGroup).evaluate().isEmpty) {
      debugPrint('ℹ️ no login screen — reusing the persisted session');
      return;
    }

    expect(
      await waitFor(
        tester,
        fields,
        timeout: const Duration(seconds: 20),
        label: 'login fields',
      ),
      isTrue,
      reason: 'the login form should render',
    );

    var signedIn = false;
    for (var attempt = 1; attempt <= 3 && !signedIn; attempt++) {
      if (find.byType(AutofillGroup).evaluate().isEmpty) break;

      await tester.tap(fields.at(0));
      await tester.enterText(fields.at(0), workerEmail);
      await tester.pump(const Duration(milliseconds: 300));
      await tester.tap(fields.at(1));
      await tester.enterText(fields.at(1), workerPassword);
      tester.testTextInput.closeConnection();
      await settle(tester, 2);

      final signInButton = find.text('Sign in');
      if (signInButton.evaluate().isEmpty) break;
      await tester.ensureVisible(signInButton.first);
      await settle(tester, 1);
      await tester.tap(signInButton.first);
      debugPrint('🔐 submitted worker credentials (attempt $attempt)');

      // The worker home renders the upcoming-shift section once the dashboard
      // request succeeds.
      signedIn = await waitFor(
        tester,
        find.text('UPCOMING SHIFTS'),
        timeout: const Duration(seconds: 45),
        label: 'worker home',
      );
    }
    expect(signedIn, isTrue, reason: 'worker login should reach the home dashboard');
  }

  testWidgets('worker clocks in and out on a roster shift', (tester) async {
    if (workerEmail.isEmpty || workerPassword.isEmpty) {
      markTestSkipped(
        'Set WORKER_EMAIL and WORKER_PASSWORD (dart-define) to run this flow.',
      );
      return;
    }

    app.main();
    await settle(tester, 6);

    await signIn(tester);
    await settle(tester, 3);

    // ---- Open the participant's details from the home shift card ----------
    final cards = find.byType(BauhausAppointmentCard);
    final hasCard = await waitFor(
      tester,
      cards,
      timeout: const Duration(seconds: 40),
      label: 'home shift cards',
    );
    expect(
      hasCard,
      isTrue,
      reason: 'the worker needs at least one unlogged shift this week '
          '(run: node backend/scripts/plan_sil_current_week.js)',
    );

    await tester.tap(cards.first);
    await settle(tester, 4);

    final startShift = find.text('START SHIFT');
    final endShift = find.text('END SHIFT');
    final onDetails = await waitFor(
      tester,
      find.text('CLIENT INFORMATION'),
      timeout: const Duration(seconds: 30),
      label: 'client details screen',
    );
    expect(onDetails, isTrue, reason: 'the shift card should open the details screen');

    // ---- Clock in ---------------------------------------------------------
    // A timer left running from a previous attempt shows END SHIFT straight
    // away, so treat both states as "the shift is open".
    if (startShift.evaluate().isNotEmpty) {
      await tester.tap(startShift.first);
      await settle(tester, 4);
      expect(
        await waitFor(
          tester,
          endShift,
          timeout: const Duration(seconds: 20),
          label: 'END SHIFT after clocking in',
        ),
        isTrue,
        reason: 'clocking in should flip the button to END SHIFT',
      );
    } else {
      debugPrint('ℹ️ timer already running for this participant');
    }
    expect(endShift.evaluate().isNotEmpty, isTrue);

    // ---- Clock out and link the worked time to the roster shift ----------
    await tester.tap(endShift.first);
    await settle(tester, 4);

    final shiftPicker = await waitFor(
      tester,
      find.text('Select Shift'),
      timeout: const Duration(seconds: 20),
      label: 'shift picker',
    );
    expect(
      shiftPicker,
      isTrue,
      reason: 'the details screen offers the roster shift to link time to',
    );

    // Already-logged shifts render as disabled rows, so only the enabled ones
    // can be picked.
    final shiftOptions = find.byWidgetPredicate(
      (widget) => widget is ListTile && widget.enabled,
    );
    expect(
      shiftOptions.evaluate().isNotEmpty,
      isTrue,
      reason: 'at least one unlogged shift should be selectable',
    );
    await tester.tap(shiftOptions.first);
    await settle(tester, 3);

    expect(
      await waitFor(
        tester,
        find.text('CONFIRM SHIFT ASSOCIATION'),
        timeout: const Duration(seconds: 20),
        label: 'confirm shift dialog',
      ),
      isTrue,
      reason: 'the confirm dialog should appear before the save',
    );
    await tester.tap(find.text('CONFIRM').first);
    await settle(tester, 6);

    // ---- The save landed --------------------------------------------------
    expect(
      await waitFor(
        tester,
        find.text('Time updated successfully'),
        timeout: const Duration(seconds: 30),
        label: 'worked-time success',
      ),
      isTrue,
      reason: 'the worked time should be saved for the roster shift',
    );
  });
}
