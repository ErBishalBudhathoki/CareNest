import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/auth/viewmodels/signup_viewmodel.dart';
import 'package:carenest/app/features/auth/views/signup_view.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_switch.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

/// The real view model constructs a FirebaseAuthService, which needs a
/// Firebase app. Nothing on this screen is under test beyond its layout, so the
/// service is left out.
class _TestSignupViewModel extends SignupViewModel {
  @override
  int build() {
    apiMethod = ApiMethod();
    return 0;
  }
}

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  Future<void> pumpSignUpView(WidgetTester tester) async {
    // Tall enough that the whole form is laid out in one pass.
    tester.view.physicalSize = const Size(1200, 3000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          signupViewModelProvider.overrideWith(_TestSignupViewModel.new),
        ],
        child: MaterialApp(
          theme: BauhausDesign.lightTheme,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SignUpView(),
        ),
      ),
    );
    await tester.pump(const Duration(seconds: 2));
  }

  testWidgets('renders its labels and fields', (tester) async {
    await pumpSignUpView(tester);

    for (final label in const [
      'Create Account',
      'Personal Information',
      'First Name',
      'Last Name',
      'Email',
      'ABN (11 digits)',
      'Account Type',
      'Normal User',
      'Administrator',
      'Join Organization',
      'Security',
      'Password',
      'Confirm Password',
      'Already have an account?',
    ]) {
      expect(
        find.text(label),
        findsWidgets,
        reason: 'expected the signup screen to render "$label"',
      );
    }

    expect(find.byType(TextFormField), findsNWidgets(6));
    // Only "join organization" is shown until the administrator role is
    // selected, which adds the organization-creation switch.
    expect(find.byType(BauhausSwitch), findsOneWidget);
  });

  testWidgets('builds without throwing', (tester) async {
    await pumpSignUpView(tester);

    expect(tester.takeException(), isNull);
  });

  testWidgets('selecting the administrator role reveals organization setup', (
    tester,
  ) async {
    await pumpSignUpView(tester);

    expect(find.text('Organization Setup'), findsNothing);

    await tester.tap(find.text('Administrator'));
    // The header runs a looping liquid animation, so pumpAndSettle never
    // settles here.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Organization Setup'), findsOneWidget);
    expect(find.text('Create New Organization'), findsOneWidget);
    expect(find.byType(BauhausSwitch), findsNWidgets(2));
  });
}
