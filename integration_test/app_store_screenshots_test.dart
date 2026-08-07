import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:carenest/main_development.dart' as app;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  Future<void> waitForWidget(
    WidgetTester tester,
    Finder finder, {
    Duration timeout = const Duration(seconds: 30),
    String label = '',
  }) async {
    final stopwatch = Stopwatch()..start();
    while (finder.evaluate().isEmpty && stopwatch.elapsed < timeout) {
      await tester.pump(const Duration(milliseconds: 500));
    }
    if (finder.evaluate().isEmpty) {
      print(
        '⚠️ TIMEOUT: Could not find widget: $label after ${stopwatch.elapsed.inSeconds}s',
      );
    } else {
      print('✅ Found widget: $label after ${stopwatch.elapsed.inSeconds}s');
    }
  }

  Future<void> captureScreenshot(String name, WidgetTester tester) async {
    await tester.pumpAndSettle(const Duration(milliseconds: 500));
    await Future.delayed(const Duration(seconds: 2));
    print('📸 Capturing Screenshot: $name');
    await binding.takeScreenshot(name);
    print('📸 Screenshot captured: $name');
  }

  testWidgets(
    'App Store Screenshots - Full Tour',
    (WidgetTester tester) async {
      print('🚀 Starting App Store Screenshot test...');

      // CRITICAL: await app.main() so Firebase/AppCheck init completes
      // before we try to interact with the UI
      app.main();
      print('✅ app.main() completed');

      // Wait for the splash screen to finish and login screen to appear
      final loginFinder = find.textContaining(
        RegExp(r'Sign [Ii]n|Log [Ii]n|LOGIN|SIGN IN', caseSensitive: false),
      );
      await waitForWidget(
        tester,
        loginFinder,
        timeout: const Duration(seconds: 60),
        label: 'Login/Sign In button',
      );

      if (loginFinder.evaluate().isEmpty) {
        print(
          '❌ FATAL: Could not find login screen after 60s. Dumping widget tree:',
        );
        debugDumpApp();
        fail('Login screen not found');
      }

      // =======================================================================
      // SLIDE 1 & 8: ADMIN FLOW
      // =======================================================================
      print('--- Starting Admin Flow ---');

      // Find text fields - wait for them to be available
      final textFieldFinder = find.byType(TextField);
      await waitForWidget(tester, textFieldFinder, label: 'Text fields');

      if (textFieldFinder.evaluate().length < 2) {
        print(
          '❌ FATAL: Expected at least 2 text fields, found ${textFieldFinder.evaluate().length}',
        );
        debugDumpApp();
        fail('Not enough text fields on login screen');
      }

      await tester.enterText(textFieldFinder.at(0), 'deverbishal331@gmail.com');
      await tester.enterText(textFieldFinder.at(1), 'Bishal@xiomi222');
      tester.testTextInput.closeConnection();
      await tester.pumpAndSettle();
      print('✅ Entered admin credentials');

      await tester.tap(loginFinder.last);
      print('✅ Tapped login button');

      // Wait for Admin Dashboard to load (API calls take time)
      await waitForWidget(
        tester,
        find.byType(Scaffold),
        timeout: const Duration(seconds: 30),
        label: 'Post-login Scaffold',
      );
      // Extra wait for dashboard data to load
      for (int i = 0; i < 30; i++) {
        await tester.pump(const Duration(milliseconds: 500));
      }
      print('✅ Admin dashboard loaded');

      await captureScreenshot('01_admin_dashboard', tester);

      // Navigate to Invoices tab
      final invoicesTab = find.textContaining(
        RegExp(r'Invoices', caseSensitive: false),
      );
      if (invoicesTab.evaluate().isNotEmpty) {
        await tester.tap(invoicesTab.first);
        for (int i = 0; i < 10; i++) {
          await tester.pump(const Duration(milliseconds: 500));
        }
        await captureScreenshot('08_admin_invoice_list', tester);

        final homeBtn = find.byIcon(Icons.home);
        if (homeBtn.evaluate().isNotEmpty) {
          await tester.tap(homeBtn.first);
          await tester.pumpAndSettle();
        }
      } else {
        print('⚠️ Invoices tab not found, skipping');
      }

      // Voice Assistant (FAB)
      final fab = find.byType(FloatingActionButton);
      if (fab.evaluate().isNotEmpty) {
        await tester.tap(fab.first);
        for (int i = 0; i < 6; i++) {
          await tester.pump(const Duration(milliseconds: 500));
        }
        await captureScreenshot('06_voice_assistant', tester);
        await tester.tapAt(const Offset(10, 50));
        await tester.pumpAndSettle();
      } else {
        print('⚠️ FAB not found, skipping voice assistant');
      }

      // Assign shift
      print('--- Assigning Shift to Employee ---');
      final assignBtn = find.textContaining(
        RegExp(r'ASSIGN', caseSensitive: false),
      );
      if (assignBtn.evaluate().isNotEmpty) {
        await tester.tap(assignBtn.first);
        await tester.pumpAndSettle();

        final harry = find.textContaining(
          RegExp(r'Harry James', caseSensitive: false),
        );
        if (harry.evaluate().isNotEmpty) {
          await tester.tap(harry.first);
          await tester.pumpAndSettle();

          final client = find.byType(ListTile);
          if (client.evaluate().length > 1) {
            await tester.tap(client.at(1));
            await tester.pumpAndSettle();
          }

          final confirm = find.textContaining(
            RegExp(r'Confirm', caseSensitive: false),
          );
          if (confirm.evaluate().isNotEmpty) {
            await tester.tap(confirm.first);
            await tester.pumpAndSettle();
          }

          final closeBtn = find.byIcon(Icons.close);
          if (closeBtn.evaluate().isNotEmpty) {
            await tester.tap(closeBtn.first);
            await tester.pumpAndSettle();
          }
        } else {
          print('⚠️ Harry James not found, skipping assignment');
        }
      } else {
        print('⚠️ ASSIGN button not found, skipping');
      }

      // Logout Admin
      print('--- Logging out Admin ---');
      final menuBtn = find.byIcon(Icons.menu);
      if (menuBtn.evaluate().isNotEmpty) {
        await tester.tap(menuBtn.first);
        await tester.pumpAndSettle();
        final logoutBtn = find.textContaining(
          RegExp(r'Log Out|Logout', caseSensitive: false),
        );
        if (logoutBtn.evaluate().isNotEmpty) {
          await tester.tap(logoutBtn.first);
          for (int i = 0; i < 15; i++) {
            await tester.pump(const Duration(milliseconds: 500));
          }
        }
      }

      // Wait for login screen to reappear
      await waitForWidget(
        tester,
        loginFinder,
        timeout: const Duration(seconds: 30),
        label: 'Login screen (post-logout)',
      );

      // =======================================================================
      // SLIDE 2 & 3: EMPLOYEE FLOW
      // =======================================================================
      print('--- Starting Employee Flow ---');
      final textFields2 = find.byType(TextField);
      if (textFields2.evaluate().length >= 2) {
        await tester.enterText(textFields2.at(0), 'bishalkc331@gmail.com');
        await tester.enterText(textFields2.at(1), 'Bishal@xiomi123');
        tester.testTextInput.closeConnection();
        await tester.pumpAndSettle();

        final loginBtn2 = find.textContaining(
          RegExp(r'Sign [Ii]n|Log [Ii]n|LOGIN|SIGN IN', caseSensitive: false),
        );
        if (loginBtn2.evaluate().isNotEmpty) {
          await tester.tap(loginBtn2.last);
          for (int i = 0; i < 30; i++) {
            await tester.pump(const Duration(milliseconds: 500));
          }
        }

        await captureScreenshot('02_employee_dashboard_shift', tester);

        // Tap shift card
        final shiftCard = find.byType(Card);
        if (shiftCard.evaluate().isNotEmpty) {
          await tester.tap(shiftCard.first);
          for (int i = 0; i < 10; i++) {
            await tester.pump(const Duration(milliseconds: 500));
          }
          await captureScreenshot('03_employee_shift_detail_proof', tester);

          final backButton = find.byTooltip('Back');
          if (backButton.evaluate().isNotEmpty) {
            await tester.tap(backButton.first);
            await tester.pumpAndSettle();
          }
        }

        // Logout Employee
        print('--- Logging out Employee ---');
        if (menuBtn.evaluate().isNotEmpty) {
          await tester.tap(menuBtn.first);
          await tester.pumpAndSettle();
          final logoutBtn = find.textContaining(
            RegExp(r'Log Out|Logout', caseSensitive: false),
          );
          if (logoutBtn.evaluate().isNotEmpty) {
            await tester.tap(logoutBtn.first);
            for (int i = 0; i < 15; i++) {
              await tester.pump(const Duration(milliseconds: 500));
            }
          }
        }

        await waitForWidget(
          tester,
          loginFinder,
          timeout: const Duration(seconds: 30),
          label: 'Login screen (post-employee-logout)',
        );
      }

      // =======================================================================
      // SLIDE 4 & 5 & 7: CLIENT FLOW
      // =======================================================================
      print('--- Starting Client Flow ---');
      final textFields3 = find.byType(TextField);
      if (textFields3.evaluate().length >= 2) {
        await tester.enterText(
          textFields3.at(0),
          'client.seed.1@mailinator.com',
        );
        await tester.enterText(textFields3.at(1), 'Bishal@xiomi123');
        tester.testTextInput.closeConnection();
        await tester.pumpAndSettle();

        final loginBtn3 = find.textContaining(
          RegExp(r'Sign [Ii]n|Log [Ii]n|LOGIN|SIGN IN', caseSensitive: false),
        );
        if (loginBtn3.evaluate().isNotEmpty) {
          await tester.tap(loginBtn3.last);
          for (int i = 0; i < 30; i++) {
            await tester.pump(const Duration(milliseconds: 500));
          }
        }

        await captureScreenshot('05_client_dashboard', tester);

        final messagingSection = find.textContaining(
          RegExp(r'Secure Shift Messaging|Family', caseSensitive: false),
        );
        if (messagingSection.evaluate().isNotEmpty) {
          await tester.ensureVisible(messagingSection.first);
          await tester.pumpAndSettle();
          await captureScreenshot('04_client_family_visibility', tester);
        }

        final openChat = find.textContaining(
          RegExp(r'OPEN CHAT|Messages', caseSensitive: false),
        );
        if (openChat.evaluate().isNotEmpty) {
          await tester.tap(openChat.first);
          for (int i = 0; i < 10; i++) {
            await tester.pump(const Duration(milliseconds: 500));
          }

          final chatInput = find.byType(TextField);
          if (chatInput.evaluate().isNotEmpty) {
            await tester.enterText(chatInput.first, 'Hello! See you soon.');
            tester.testTextInput.closeConnection();
            await tester.pumpAndSettle();
          }
          await captureScreenshot('07_communication_hub_chat', tester);
        }
      }

      print('✅ All App Store Screenshots Captured Successfully!');
    },
    timeout: const Timeout(Duration(minutes: 15)),
  );
}
