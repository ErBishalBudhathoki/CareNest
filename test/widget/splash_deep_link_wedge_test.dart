import 'package:carenest/app/features/auth/utils/deep_link_state.dart';
import 'package:carenest/app/shared/widgets/splash_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Regression coverage for the sticky deep-link flag wedging the splash screen.
///
/// `DeepLinkState.handled` is process-global and is never cleared on its own. A
/// deep link handled at any point in the process used to leave it true, and
/// every later splash screen stood down — routing nowhere, retrying nothing.
/// Splash now clears the flag when it starts.
void main() {
  setUp(() => SharedPreferences.setMockInitialValues(<String, Object>{}));

  tearDown(DeepLinkState.reset);

  Future<void> pumpSplash(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: const SplashScreen(),
        routes: {'/login': (_) => const Scaffold(body: Text('LOGIN_ROUTE'))},
      ),
    );
  }

  /// Splash waits 2s + 500ms before deciding.
  Future<void> elapseStartupDelay(WidgetTester tester) async {
    await tester.pump(const Duration(seconds: 2));
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pumpAndSettle();
  }

  testWidgets('routes to login when there is no stored session', (
    tester,
  ) async {
    await pumpSplash(tester);
    await elapseStartupDelay(tester);

    expect(find.text('LOGIN_ROUTE'), findsOneWidget);
  });

  testWidgets('a stale handled flag from earlier in the process does not wedge '
      'routing', (tester) async {
    // Reproduces the reported symptom: a deep link was handled earlier, so the
    // process-global flag is still true when a fresh splash mounts.
    DeepLinkState.handled = true;

    await pumpSplash(tester);
    await elapseStartupDelay(tester);

    expect(
      DeepLinkState.handled,
      isFalse,
      reason: 'splash must clear the stale flag before deciding',
    );
    expect(
      find.text('LOGIN_ROUTE'),
      findsOneWidget,
      reason: 'a stale flag must not leave the user stuck on the splash screen',
    );
  });

  testWidgets('stands down for a deep link handled during this splash', (
    tester,
  ) async {
    await pumpSplash(tester);

    // A link routes while the splash delay is still running.
    await tester.pump(const Duration(milliseconds: 100));
    DeepLinkState.handled = true;

    await elapseStartupDelay(tester);

    expect(
      find.text('LOGIN_ROUTE'),
      findsNothing,
      reason: 'splash must not clobber a deep link that took over navigation',
    );
  });
}
