import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/shared/widgets/bottom_nav_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// Regression coverage for the splash-screen loop.
///
/// The shell is a single route whose tabs are siblings in an IndexedStack, not
/// routes. With no back handling, the system back gesture while a non-first tab
/// was selected found nothing to pop, so Android fell through to the default
/// popRoute and finished the activity. Settings has no app bar of its own, so
/// back from the SETTINGS tab closed the app instead of returning to the
/// dashboard — and the next launch is a cold start through SplashScreen, which
/// read as a splash loop.
///
/// The real tab screens boot Firebase and fire network calls from initState, so
/// the shell is given placeholder tabs via `screensBuilder`. What is under test
/// is the shell's own back contract.
class _StubPhotoDataNotifier extends PhotoDataNotifier {
  @override
  Future<void> fetchPhotoData(
    String email, {
    bool forceRefresh = false,
  }) async {}
}

class _StubRoleNotifier extends UserRoleNotifier {
  @override
  Future<void> refreshRole() async {}
}

void main() {
  setUp(() {
    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    // The shell requests notification permission in a post-frame callback.
    // There is no Firebase app in a widget test, so the request throws; the
    // shell's guard is what keeps that from failing the test, and a stubbed
    // channel keeps it from reaching for a real platform.
    messenger.setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/firebase_messaging'),
      (call) async => 1,
    );
    messenger.setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/core'),
      (call) async => null,
    );
  });

  tearDown(() {
    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    messenger.setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/firebase_messaging'),
      null,
    );
    messenger.setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/core'),
      null,
    );
  });

  Future<void> pumpShell(WidgetTester tester, {int? initialIndex}) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          photoDataProvider.overrideWith(_StubPhotoDataNotifier.new),
          userRoleProvider.overrideWith(_StubRoleNotifier.new),
        ],
        child: MaterialApp(
          home: BottomNavBarWidget(
            email: 'admin@carenest.test',
            role: UserRole.admin,
            organizationId: 'org-1',
            organizationName: 'Acme Care',
            organizationCode: 'ACME',
            initialIndex: initialIndex,
            // Admin tabs: 0 HOME, 1 ASSIGN, 2 SETTINGS.
            screensBuilder: (_) => const [
              Scaffold(body: Center(child: Text('HOME_SCREEN'))),
              Scaffold(body: Center(child: Text('ASSIGN_SCREEN'))),
              Scaffold(body: Center(child: Text('SETTINGS_SCREEN'))),
            ],
          ),
        ),
      ),
    );
    await tester.pump();
  }

  Finder backScope() => find.byKey(const ValueKey('bottom_nav_back_scope'));

  bool canPopNow(WidgetTester tester) =>
      tester.widget<PopScope<Object?>>(backScope()).canPop;

  bool isTabSelected(WidgetTester tester, String label) {
    // The selected nav item carries a non-null `selected` property. Other
    // semantics nodes reuse the same label (the visible Text), so filter on
    // `selected` being present rather than matching by label alone.
    final matches = tester
        .widgetList<Semantics>(find.byType(Semantics))
        .where(
          (s) => s.properties.label == label && s.properties.selected != null,
        )
        .toList();
    expect(
      matches,
      hasLength(1),
      reason: 'expected exactly one nav item semantics node for $label',
    );
    return matches.single.properties.selected == true;
  }

  testWidgets('back is allowed to leave the app from the first tab', (
    tester,
  ) async {
    await pumpShell(tester);
    expect(canPopNow(tester), isTrue);
    expect(isTabSelected(tester, 'HOME'), isTrue);
  });

  testWidgets('a non-first tab blocks the platform pop', (tester) async {
    await pumpShell(tester);
    expect(canPopNow(tester), isTrue);

    await tester.tap(find.text('SETTINGS'));
    await tester.pump();

    expect(canPopNow(tester), isFalse);
    expect(find.text('SETTINGS_SCREEN'), findsOneWidget);
  });

  testWidgets('back from the Settings tab returns to the dashboard', (
    tester,
  ) async {
    await pumpShell(tester);

    await tester.tap(find.text('SETTINGS'));
    await tester.pump();
    expect(find.text('SETTINGS_SCREEN'), findsOneWidget);

    // Simulate the system back gesture / predictive back.
    await tester.binding.handlePopRoute();
    await tester.pump();

    // The shell consumed the gesture instead of letting Android finish the task.
    expect(find.text('HOME_SCREEN'), findsOneWidget);
    expect(isTabSelected(tester, 'HOME'), isTrue);
    expect(canPopNow(tester), isTrue);
  });

  testWidgets('back from the Assign tab returns to the dashboard', (
    tester,
  ) async {
    await pumpShell(tester);

    await tester.tap(find.text('ASSIGN'));
    await tester.pump();
    expect(find.text('ASSIGN_SCREEN'), findsOneWidget);

    await tester.binding.handlePopRoute();
    await tester.pump();

    expect(find.text('HOME_SCREEN'), findsOneWidget);
    expect(isTabSelected(tester, 'HOME'), isTrue);
  });

  testWidgets('reopening the shell after back lands on the dashboard', (
    tester,
  ) async {
    // The reported symptom was a splash loop, i.e. the app being torn down and
    // cold-started. Starting on the Settings tab mirrors returning to a session
    // that was left there, and back must go to the dashboard, not exit.
    await pumpShell(tester, initialIndex: 2);
    expect(find.text('SETTINGS_SCREEN'), findsOneWidget);

    await tester.binding.handlePopRoute();
    await tester.pump();

    expect(find.text('HOME_SCREEN'), findsOneWidget);
  });
}
