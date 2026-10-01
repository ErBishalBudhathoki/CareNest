import 'package:carenest/app/features/client_portal/views/client_dashboard_view.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The portal header used to be one Row holding a profile-picture placeholder,
/// the title, the subtitle, a Family button and Logout. That left the title
/// about 137 logical px, so "CLIENT DASHBOARD" wrapped onto two lines and the
/// subtitle took three.
///
/// The placeholder and the Family button are both gone: the placeholder stood in
/// for nothing the portal knows, and Family duplicated the FAMILY ACCESS section
/// the body already renders at the top of its scroll view.
///
/// This pumps [ClientPortalHeader] directly. Going through ClientDashboardView
/// would drag in its initState, which asks for Firebase messaging.
void main() {
  Future<void> pumpHeader(
    WidgetTester tester, {
    double width = 390,
    String title = 'CLIENT DASHBOARD',
    String subtitle = 'Manage services, invoices, and appointments',
  }) async {
    await tester.binding.setSurfaceSize(Size(width, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        theme: BauhausDesign.lightTheme,
        home: Scaffold(
          body: ClientPortalHeader(
            title: title,
            subtitle: subtitle,
            onLogout: () async {},
          ),
        ),
      ),
    );
  }

  /// The binding asserts no timers are pending right after the test body and
  /// before any teardown, and BauhausIconButton wraps a Tooltip that schedules
  /// one on mount. Call this last in every test.
  Future<void> disposeHeader(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 1));
  }

  // 320 is the narrowest phone the app supports, 430 a common large size.
  for (final width in <double>[320, 360, 390, 412, 430]) {
    testWidgets('title stays on one line at $width logical px', (tester) async {
      await pumpHeader(tester, width: width);

      final finder = find.text('CLIENT DASHBOARD');
      expect(finder, findsOneWidget);

      final text = tester.widget<Text>(finder);
      expect(
        text.maxLines,
        1,
        reason:
            'the title must be capped at one line so it ellipsises rather '
            'than wrapping',
      );
      expect(text.overflow, TextOverflow.ellipsis);

      final rect = tester.getRect(finder);
      expect(
        rect.left + rect.width,
        lessThanOrEqualTo(width),
        reason: 'the title runs past the viewport edge at $width',
      );

      await disposeHeader(tester);
    });

    testWidgets('subtitle is capped at two lines at $width logical px', (
      tester,
    ) async {
      await pumpHeader(tester, width: width);
      final finder = find.text('Manage services, invoices, and appointments');
      expect(tester.widget<Text>(finder).maxLines, 2);
      await disposeHeader(tester);
    });

    testWidgets('header lays out without overflow at $width logical px', (
      tester,
    ) async {
      await pumpHeader(tester, width: width);
      expect(tester.takeException(), isNull);
      await disposeHeader(tester);
    });
  }

  testWidgets('title uses the design-system face', (tester) async {
    await pumpHeader(tester);
    final style = tester.widget<Text>(find.text('CLIENT DASHBOARD')).style;
    expect(
      style?.fontFamily,
      contains('BricolageGrotesque'),
      reason:
          'DESIGN.md sets Bricolage Grotesque for headings. The header was '
          'calling GoogleFonts.oswald directly, bypassing the text theme.',
    );
    await disposeHeader(tester);
  });

  testWidgets('logout is present and the title shares its row', (tester) async {
    await pumpHeader(tester);
    expect(find.byTooltip('Logout'), findsOneWidget);

    final title = tester.getRect(find.text('CLIENT DASHBOARD'));
    final logout = tester.getRect(find.byTooltip('Logout'));
    expect(
      title.top,
      inInclusiveRange(logout.top - 24, logout.bottom),
      reason: 'the title and the logout control should sit on the same row',
    );
    expect(
      logout.left,
      greaterThan(title.right),
      reason: 'logout must sit after the copy, not overlap it',
    );
    await disposeHeader(tester);
  });

  testWidgets('no profile-picture placeholder is rendered', (tester) async {
    await pumpHeader(tester);
    expect(find.byIcon(Icons.person_outline), findsNothing);
    expect(find.byIcon(Icons.family_restroom_outlined), findsNothing);
    await disposeHeader(tester);
  });

  testWidgets('no Family control in the header', (tester) async {
    await pumpHeader(tester);
    expect(
      find.text('Family'),
      findsNothing,
      reason:
          'family access is reached from the FAMILY ACCESS section at the '
          'top of the body, so the appbar button was a duplicate',
    );
    await disposeHeader(tester);
  });

  testWidgets('family viewer sees the same reduced header', (tester) async {
    await pumpHeader(
      tester,
      title: 'FAMILY DASHBOARD',
      subtitle: 'View your loved one\'s care updates',
    );
    expect(find.text('FAMILY DASHBOARD'), findsOneWidget);
    expect(find.text('Family'), findsNothing);
    await disposeHeader(tester);
  });
}
