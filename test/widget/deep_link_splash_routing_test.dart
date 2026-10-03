import 'package:carenest/app/core/utils/navigation.dart';
import 'package:carenest/app/features/auth/utils/deep_link_handler.dart';
import 'package:carenest/app/features/auth/utils/deep_link_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Regression coverage for the "stuck on splash" bug.
///
/// The app installs its deep-link listener in `main()`, before `runApp()`, and
/// `SplashScreen` asks `DeepLinkState.handled` whether a link already took over
/// navigation. If that flag is set for a link that never actually routed —
/// which is what happens on a cold start, because the navigator is not attached
/// yet — the splash screen stands down and never routes. There is no retry and
/// no timeout, so the user sits on the splash screen for the rest of the
/// process lifetime.
///
/// These tests pin the contract that makes that impossible: the handler
/// reports whether it navigated, and callers only set the flag on a true.
void main() {
  tearDown(() {
    DeepLinkState.reset();
  });

  group('DeepLinkHandler reports whether it routed', () {
    testWidgets('returns false when the navigator is not attached yet', (
      tester,
    ) async {
      // The cold-start condition. navigatorKey.currentState is null because no
      // MaterialApp is mounted.
      expect(navigatorKey.currentState, isNull);

      final handled = DeepLinkHandler.handleDeepLink(
        'com.bishal.invoice://signup?orgCode=ABC123',
      );

      expect(
        handled,
        isFalse,
        reason: 'nothing was routed, so the splash screen must keep routing',
      );
    });

    testWidgets('returns false for an unrecognised link', (tester) async {
      await tester.pumpWidget(
        MaterialApp(navigatorKey: navigatorKey, home: const SizedBox()),
      );

      expect(navigatorKey.currentState, isNotNull);

      expect(
        DeepLinkHandler.handleDeepLink('com.bishal.invoice://not-a-real-route'),
        isFalse,
      );
      expect(
        DeepLinkHandler.handleDeepLink('https://example.com/whatever'),
        isFalse,
      );
    });

    testWidgets('returns false for empty and unparseable links', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(navigatorKey: navigatorKey, home: const SizedBox()),
      );

      expect(DeepLinkHandler.handleDeepLink(''), isFalse);
      expect(DeepLinkHandler.handleDeepLink('   '), isFalse);
      expect(DeepLinkHandler.handleDeepLink('ht!tp://%%%broken'), isFalse);
    });

    testWidgets('returns true and pushes signup once a navigator exists', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: navigatorKey,
          home: const Scaffold(body: Text('host')),
          routes: {
            '/signup': (_) => const Scaffold(body: Text('SIGNUP_ROUTE')),
          },
        ),
      );
      await tester.pumpAndSettle();

      final handled = DeepLinkHandler.handleDeepLink(
        'com.bishal.invoice://signup?orgCode=ABC123',
      );
      await tester.pumpAndSettle();

      expect(handled, isTrue);
      expect(find.text('SIGNUP_ROUTE'), findsOneWidget);
    });

    testWidgets('returns true for a universal signup link with no orgCode', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: navigatorKey,
          home: const Scaffold(body: Text('host')),
          routes: {
            '/signup': (_) => const Scaffold(body: Text('SIGNUP_ROUTE')),
          },
        ),
      );
      await tester.pumpAndSettle();

      final handled = DeepLinkHandler.handleDeepLink(
        'https://bishalbudhathoki.com/signup',
      );
      await tester.pumpAndSettle();

      expect(handled, isTrue);
      expect(find.text('SIGNUP_ROUTE'), findsOneWidget);
    });
  });

  group('DeepLinkState', () {
    test('reset clears the sticky process-global flag', () {
      DeepLinkState.handled = true;
      expect(DeepLinkState.handled, isTrue);

      DeepLinkState.reset();

      expect(
        DeepLinkState.handled,
        isFalse,
        reason: 'a stale flag would suppress routing in every later splash',
      );
    });
  });
}
