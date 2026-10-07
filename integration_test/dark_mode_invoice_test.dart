import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/admin/views/admin_dashboard_view.dart';
import 'package:carenest/app/features/auth/views/login_view.dart';
import 'package:carenest/app/features/invoice/viewmodels/employee_selection_viewmodel.dart';
import 'package:carenest/app/features/invoice/views/employee_selection_view.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/main_development.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  Future<void> pumpFor(
    WidgetTester tester,
    int seconds, {
    int stepMs = 200,
  }) async {
    final iterations = (seconds * 1000) ~/ stepMs;
    for (var i = 0; i < iterations; i++) {
      await tester.pump(Duration(milliseconds: stepMs));
    }
  }

  Future<bool> waitFor(
    WidgetTester tester,
    Finder finder, {
    int seconds = 45,
  }) async {
    for (var i = 0; i < (seconds * 5); i++) {
      if (finder.evaluate().isNotEmpty) return true;
      await tester.pump(const Duration(milliseconds: 200));
    }
    return finder.evaluate().isNotEmpty;
  }

  Future<void> capture(WidgetTester tester, String name) async {
    try {
      await pumpFor(tester, 3);
      print('SHOT|$name');
      try {
        await binding.convertFlutterSurfaceToImage();
      } catch (e) {
        print('CONVERROR|$e');
      }
      await binding.takeScreenshot(name);
    } catch (e) {
      print('SHOTERROR|$name|$e');
    }
  }

  testWidgets('dark mode invoice generation', (WidgetTester tester) async {
    app.main();
    await pumpFor(tester, 5);

    final fields = find.byType(TextField);
    final gotFields = await waitFor(tester, fields, seconds: 60);
    print('STATE|fields=$gotFields count=${fields.evaluate().length}');
    if (!gotFields || fields.evaluate().length < 2) {
      debugDumpApp();
      fail('Login text fields not found');
    }

    await tester.enterText(fields.at(0), 'deverbishal331@gmail.com');
    await tester.enterText(fields.at(1), 'Bishal@xiomi123');
    await pumpFor(tester, 3);
    tester.testTextInput.closeConnection();
    await Future.delayed(const Duration(seconds: 3));
    await pumpFor(tester, 3);

    final signInBtn = find.ancestor(
      of: find.text('Sign in'),
      matching: find.byType(BauhausActionButton),
    );
    if (signInBtn.evaluate().isNotEmpty) {
      print('STATE|signInBtn=${signInBtn.evaluate().length}');
      await tester.tap(signInBtn.first, warnIfMissed: false);
    } else {
      print('STATE|btn=${find.byType(BauhausActionButton).evaluate().length}');
      await tester.tap(find.byType(BauhausActionButton).first, warnIfMissed: false);
    }
    await pumpFor(tester, 3);

    var adminFound = await waitFor(
      tester,
      find.byType(AdminDashboardView),
      seconds: 60,
    );
    if (!adminFound) {
      // fallback: call the same provider handler the button triggers
      print('STATE|tap did not navigate; running vm.login programmatically');
      final loginConsumerState =
          tester.state(find.byType(LoginView)) as ConsumerState<LoginView>;
      final ref = loginConsumerState.ref;
      final loginVm = ref.read(loginViewModelProvider.notifier);
      final loginCtx = tester.element(find.byType(LoginView));
      await loginVm.login(loginCtx);
      await pumpFor(tester, 20);
      adminFound = await waitFor(
        tester,
        find.byType(AdminDashboardView),
        seconds: 60,
      );
    }
    print('STATE|adminFound=$adminFound');
    if (!adminFound) {
      print('TEXTS on screen:');
      final texts = tester
          .widgetList<Text>(find.byType(Text))
          .map((t) => t.data)
          .take(20);
      for (final t in texts) {
        print('  TEXT|${t ?? ''}');
      }
      debugDumpApp();
      fail('AdminDashboardView not found after sign in');
    }

    final adminWidget = tester.widget<AdminDashboardView>(
      find.byType(AdminDashboardView),
    );
    print(
      'STATE|adminEmail=${adminWidget.email} orgId=${adminWidget.organizationId} orgName=${adminWidget.organizationName}',
    );

    final orgId = adminWidget.organizationId ?? '';
    final orgName = adminWidget.organizationName ?? '';

    final ctx = tester.element(find.byType(Scaffold).last);
    Navigator.of(ctx).pushNamed(
      '/employeeSelection',
      arguments: {
        'email': adminWidget.email,
        'organizationId': orgId,
        'organizationName': orgName,
      },
    );
    await pumpFor(tester, 20);

    final empFound = await waitFor(
      tester,
      find.byType(EmployeeSelectionView),
      seconds: 30,
    );
    print('STATE|empFound=$empFound');

    final empConsumerState =
        tester.state(find.byType(EmployeeSelectionView))
            as ConsumerState<EmployeeSelectionView>;
    final empNotifier = empConsumerState.ref.read(
      employeeSelectionViewModelProvider(orgId).notifier,
    );
    final state1 = empNotifier.state;
    print('STATE|employees=${state1.employees.length}');

    if (state1.employees.isNotEmpty) {
      final first = state1.employees.first;
      empNotifier.toggleEmployeeSelection(first.id);
      await pumpFor(tester, 2);
      await empNotifier.fetchClientsForEmployee(first.email);
      await pumpFor(tester, 8);
    }

    final state2 = empNotifier.state;
    if (state2.employees.isEmpty ||
        state2.employees.first.clients.isEmpty) {
      print('STATE|no clients after fetch');
      debugDumpApp();
      fail('No clients');
    }

    final emp = state2.employees
        .firstWhere((e) => e.clients.isNotEmpty, orElse: () => state2.employees.first);
    final client = emp.clients.first;
    empNotifier.toggleClientSelection(emp.email, client.id);
    await pumpFor(tester, 2);
    print('STATE|selected client=${client.name}');

    final selectedData = empNotifier.getSelectedEmployeesAndClients();
    print('STATE|selectedDataCount=${selectedData.length}');

    final ctx2 = tester.element(find.byType(Scaffold).last);
    Navigator.of(ctx2).pushNamed(
      '/enhancedInvoiceGeneration',
      arguments: {
        'userEmail': adminWidget.email,
        'organizationId': orgId,
        'organizationName': orgName,
        'selectedEmployeesAndClients': selectedData,
      },
    );
    await pumpFor(tester, 25);

    final taxField = find.textContaining(
      RegExp(r'tax', caseSensitive: false),
    );
    print('STATE|taxMatches=${taxField.evaluate().length}');

    final ctx3 = tester.element(find.byType(Scaffold).last);
    print('STATE|brightness=${Theme.of(ctx3).brightness}');

    await capture(tester, 'dark_invoice_enhanced_top');

    final scrolls = find.byType(Scrollable);
    print('STATE|scrollables=${scrolls.evaluate().length}');
    if (scrolls.evaluate().isNotEmpty) {
      await tester.drag(scrolls.first, const Offset(0, -900));
      await pumpFor(tester, 3);
    }
    await capture(tester, 'dark_invoice_enhanced_mid');

    if (scrolls.evaluate().isNotEmpty) {
      await tester.drag(scrolls.first, const Offset(0, -900));
      await pumpFor(tester, 3);
    }
    await capture(tester, 'dark_invoice_enhanced_lower');
  });
}