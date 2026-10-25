import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/auth/views/forgot_password_view.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

/// Regression test for the email field clearing itself when the keyboard
/// closes.
///
/// The screen passes `MediaQuery`-derived values into `build`, so showing or
/// dismissing the keyboard rebuilds it. The view model is autoDispose, and the
/// view used to reach it with a bare `ref.read(...)`, which creates no
/// listener: the notifier (and its text controller) was disposed and rebuilt
/// empty, so the typed address disappeared the moment the keyboard went away.
void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  Future<void> pumpView(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 2600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: BauhausDesign.lightTheme,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const ForgotPasswordView(),
        ),
      ),
    );
    // The header runs a looping pulse animation, so pumpAndSettle never settles.
    await tester.pump(const Duration(seconds: 2));
  }

  testWidgets('keeps the typed email when the keyboard opens and closes', (
    tester,
  ) async {
    await pumpView(tester);

    await tester.enterText(find.byType(TextFormField), 'ada@example.com');
    await tester.pump();
    expect(find.text('ada@example.com'), findsOneWidget);

    // Keyboard up.
    tester.view.viewInsets = const FakeViewPadding(bottom: 640);
    await tester.pump();
    expect(
      find.text('ada@example.com'),
      findsOneWidget,
      reason: 'opening the keyboard must not clear the email field',
    );

    // Keyboard down (tick mark, tap outside, or the hardware down arrow all
    // end up here).
    tester.view.viewInsets = FakeViewPadding.zero;
    await tester.pump();

    expect(
      find.text('ada@example.com'),
      findsOneWidget,
      reason: 'dismissing the keyboard must not clear the email field',
    );

    final container = ProviderScope.containerOf(
      tester.element(find.byType(ForgotPasswordView)),
    );
    expect(
      container
          .read(forgotPasswordViewModelProvider.notifier)
          .model
          .emailController
          .text,
      'ada@example.com',
      reason: 'the view model that sends the OTP must still hold the address',
    );
  });

  testWidgets('reuses one view model across rebuilds', (tester) async {
    await pumpView(tester);

    final element = tester.element(find.byType(ForgotPasswordView));
    final container = ProviderScope.containerOf(element);
    final before = container.read(forgotPasswordViewModelProvider.notifier);

    tester.view.viewInsets = const FakeViewPadding(bottom: 300);
    await tester.pump();
    tester.view.viewInsets = FakeViewPadding.zero;
    await tester.pump();

    final after = container.read(forgotPasswordViewModelProvider.notifier);

    expect(identical(before, after), isTrue);
    expect(
      identical(before.model.emailController, after.model.emailController),
      isTrue,
    );
  });
}
