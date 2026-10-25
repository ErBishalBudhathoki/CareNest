import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/auth/views/forgot_password_view.dart';
import 'package:carenest/app/features/auth/views/verify_otp_view.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

const _confirmation =
    'If an account with this email exists, a password reset code has been sent.';

/// Stands in for the network call so the loading and confirmation states can be
/// observed without hitting the backend.
class _FakeApiMethod extends ApiMethod {
  _FakeApiMethod();

  /// Long enough that the loading state is observable before the request ends.
  static const delay = Duration(milliseconds: 100);
  int sendOtpCalls = 0;

  @override
  Future<Map<String, dynamic>> sendOTP(String email) async {
    sendOtpCalls += 1;
    await Future<void>.delayed(delay);
    return <String, dynamic>{
      'success': true,
      'statusCode': 200,
      'message': _confirmation,
    };
  }
}

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  Future<_FakeApiMethod> pumpView(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 2600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    final api = _FakeApiMethod();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [apiMethodProvider.overrideWithValue(api)],
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
    return api;
  }

  testWidgets('shows a spinner while the code is being sent', (tester) async {
    final api = await pumpView(tester);

    await tester.enterText(find.byType(TextFormField), 'ada@example.com');
    await tester.pump();
    await tester.tap(find.text('Send Verification Code'));

    // Request in flight: the button shows its spinner and cannot be tapped again.
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.tap(find.text('Send Verification Code'), warnIfMissed: false);
    await tester.pump();
    expect(api.sendOtpCalls, 1);

    // Let the fake request finish, then leave the screen in a settled state so
    // no timer is left behind when the test ends.
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(find.text('Enter code'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
  });

  testWidgets('confirms the send and continues to the code screen', (
    tester,
  ) async {
    await pumpView(tester);

    await tester.enterText(find.byType(TextFormField), 'ada@example.com');
    await tester.pump();
    await tester.tap(find.text('Send Verification Code'));

    // Let the fake request finish and the dialog animate in.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Check your email'), findsOneWidget);
    expect(find.text(_confirmation), findsOneWidget);

    await tester.tap(find.text('Enter code'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.byType(VerifyOTPView), findsOneWidget);
  });

  testWidgets('keeps the email after the send completes', (tester) async {
    await pumpView(tester);

    await tester.enterText(find.byType(TextFormField), 'ada@example.com');
    await tester.pump();
    await tester.tap(find.text('Send Verification Code'));

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    await tester.tap(find.text('Enter code'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    final otpView = tester.widget<VerifyOTPView>(find.byType(VerifyOTPView));
    expect(otpView.email, 'ada@example.com');
  });
}
