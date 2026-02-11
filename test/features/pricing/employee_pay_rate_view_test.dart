import 'package:carenest/app/features/auth/models/user_model.dart';
import 'package:carenest/app/features/pricing/viewmodels/employee_pay_rate_viewmodel.dart';
import 'package:carenest/app/features/pricing/views/employee_pay_rate_view.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

import 'package:carenest/app/features/auth/models/user_role.dart';

// Mock ViewModel
class MockEmployeePayRateViewModel extends StateNotifier<EmployeePayRateState>
    implements EmployeePayRateViewModel {
  MockEmployeePayRateViewModel(List<User> employees)
      : super(EmployeePayRateState(employees: employees));

  // ignore: unused_field
  final ApiMethod _apiMethod = ApiMethod();
  @override
  final String organizationId = 'test-org';

  @override
  Future<void> fetchEmployees() async {}
}

void main() {
  testWidgets('EmployeePayRateView dropdown interaction test', (WidgetTester tester) async {
    // 1. Setup Test Data
    final testUser = User(
      id: '1',
      organizationId: 'org1',
      name: 'Test User',
      email: 'test@example.com',
      phone: '1234567890',
      role: UserRole.normal,
      // No classification initially
    );

    // 2. Setup Provider Overrides
    final mockViewModel = MockEmployeePayRateViewModel([testUser]);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          employeePayRateViewModelProvider.overrideWith(
            (ref, orgId) => mockViewModel,
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          home: EmployeePayRateView(
            organizationId: 'org1',
            adminEmail: 'admin@example.com',
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // 3. Open the Dialog
    await tester.tap(find.text('TEST USER'));
    await tester.pumpAndSettle();

    expect(find.text('Set Pay Rates: TEST USER'), findsOneWidget);

    // 4. Find Dropdowns
    final streamDropdown = find.widgetWithText(DropdownButtonFormField<String>, 'Stream');
    final levelDropdown = find.widgetWithText(DropdownButtonFormField<String>, 'Level');
    final payPointDropdown = find.widgetWithText(DropdownButtonFormField<String>, 'Pay Point');

    expect(streamDropdown, findsOneWidget);
    expect(levelDropdown, findsOneWidget);
    expect(payPointDropdown, findsOneWidget);

    final streamWidget =
        tester.widget<DropdownButtonFormField<String>>(streamDropdown);
    streamWidget.onChanged?.call('Social & Community Services');
    await tester.pump();

    final levelWidget =
        tester.widget<DropdownButtonFormField<String>>(levelDropdown);
    levelWidget.onChanged?.call('Level 1');
    await tester.pump();

    final payPointWidget =
        tester.widget<DropdownButtonFormField<String>>(payPointDropdown);
    payPointWidget.onChanged?.call('Pay Point 1');
    await tester.pumpAndSettle();

    // 8. Verify Base Rate Updated
    // $26.30 is the rate for SACS Level 1 PP 1
    final baseRateValueFinder = find.byWidgetPredicate(
      (w) => w is EditableText && w.controller.text == '26.30',
    );
    expect(baseRateValueFinder, findsOneWidget);
  });
}
