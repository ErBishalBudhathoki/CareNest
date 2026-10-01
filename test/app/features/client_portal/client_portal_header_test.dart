import 'package:carenest/app/features/client_portal/views/client_dashboard_view.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The portal header used to be a single Row holding the avatar, the title, the
/// subtitle and both controls. The title had about 137 logical px to work with,
/// so "CLIENT DASHBOARD" wrapped onto two lines and the subtitle took three,
/// while Family and Logout sat shoulder to shoulder with the copy.
///
/// This pumps [ClientPortalHeader] directly. Going through ClientDashboardView
/// would drag in its initState, which asks for Firebase messaging.
void main() {
  Future<void> pumpHeader(
    WidgetTester tester, {
    double width = 390,
    bool familyViewer = false,
  }) async {
    await tester.binding.setSurfaceSize(Size(width, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        theme: BauhausDesign.lightTheme,
        home: Scaffold(
          body: ClientPortalHeader(
            isFamilyViewer: familyViewer,
            title: familyViewer ? 'FAMILY DASHBOARD' : 'CLIENT DASHBOARD',
            subtitle: familyViewer
                ? 'View your loved one\'s care updates'
                : 'Manage services, invoices, and appointments',
            onFamilyPressed: familyViewer ? null : () {},
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

  testWidgets('title shares the first row with the logout control', (
    tester,
  ) async {
    await pumpHeader(tester);
    final title = tester.getRect(find.text('CLIENT DASHBOARD'));
    final logout = tester.getRect(find.byTooltip('Logout'));
    expect(
      title.top,
      inInclusiveRange(logout.top - 24, logout.bottom),
      reason: 'the title and the logout control should sit on the same row',
    );
    await disposeHeader(tester);
  });

  testWidgets('title is vertically centred against the avatar', (tester) async {
    await pumpHeader(tester);
    final title = tester.getRect(find.text('CLIENT DASHBOARD'));
    final avatar = tester.getRect(find.byIcon(Icons.person_outline));
    expect(
      avatar.top + avatar.height / 2,
      inInclusiveRange(title.top, title.bottom),
      reason: 'the avatar and the title should read as one aligned row',
    );
    await disposeHeader(tester);
  });

  testWidgets('Family control is shown for the client portal', (tester) async {
    await pumpHeader(tester);
    expect(find.text('Family'), findsOneWidget);
    await disposeHeader(tester);
  });

  testWidgets('family viewer drops the Family control', (tester) async {
    await pumpHeader(tester, familyViewer: true);
    expect(find.text('Family'), findsNothing);
    // The family viewer's avatar is itself a family_restroom icon, so exactly
    // one is expected: the avatar. A second would be the dropped button.
    expect(find.byIcon(Icons.family_restroom_outlined), findsOneWidget);
    expect(find.text('FAMILY DASHBOARD'), findsOneWidget);
    await disposeHeader(tester);
  });
}
