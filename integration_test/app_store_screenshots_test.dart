import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:integration_test/integration_test.dart';
import 'package:carenest/main_development.dart' as app;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Helper function to capture screenshots gracefully
  Future<void> captureScreenshot(String name, PatrolIntegrationTester $) async {
    // Wait for any animations to finish
    await $.pumpAndSettle();
    await Future.delayed(const Duration(milliseconds: 500));
    print('📸 Capturing Screenshot: $name');
    await binding.takeScreenshot(name);
  }

  patrolTest(
    'App Store Screenshots - Full Tour',
    config: const PatrolTesterConfig(
      settleTimeout: Duration(seconds: 20),
    ),
    ($) async {
      await app.main();
      await Future.delayed(const Duration(seconds: 4)); // Let Firebase init

      // =======================================================================
      // SLIDE 1 & 8: ADMIN FLOW
      // =======================================================================
      print('--- Starting Admin Flow ---');
      final emailFields = $(TextField);
      await emailFields.at(0).enterText('deverbishal331@gmail.com');
      await emailFields.at(1).enterText('Bishal@xiomi222');
      
      if ($.tester.testTextInput.hasAnyClients) {
        $.tester.testTextInput.closeConnection();
      }
      
      await $(RegExp(r'Sign in|Login', caseSensitive: false)).tap();

      // Wait for Admin Dashboard
      await $(RegExp(r'ASSIGN|Dashboard', caseSensitive: false)).waitUntilVisible();
      await Future.delayed(const Duration(seconds: 3)); 
      
      // Slide 1: One app for the whole care circle (Admin Dashboard)
      await captureScreenshot('01_admin_dashboard', $);

      // Slide 8: Invoices
      if (await $(RegExp(r'Invoices', caseSensitive: false)).exists) {
        await $(RegExp(r'Invoices', caseSensitive: false)).tap();
        await Future.delayed(const Duration(seconds: 3));
        await captureScreenshot('08_admin_invoice_list', $);
        
        // Go back to home for next steps
        await $(Icons.home).tap(); // Assuming bottom nav or drawer back
        await Future.delayed(const Duration(seconds: 2));
      }

      // Slide 6: Voice Assistant
      // "admin dashboard bottom right floating button when clicked it loads the voice assistant"
      if (await $(FloatingActionButton).exists) {
        await $(FloatingActionButton).tap();
        await Future.delayed(const Duration(seconds: 2)); // wait for bottom sheet or modal
        await captureScreenshot('06_voice_assistant', $);
        
        // Close the voice assistant (swipe down or tap outside)
        // Usually pressing escape or tapping at the top of the screen closes bottom sheets
        await $.tester.tapAt(const Offset(10, 50)); 
        await Future.delayed(const Duration(seconds: 1));
      }

      // ASSIGN A SHIFT TO EMPLOYEE (So Employee flow works)
      print('--- Assigning Shift to Employee ---');
      if (await $(RegExp(r'ASSIGN', caseSensitive: false)).exists) {
        await $(RegExp(r'ASSIGN', caseSensitive: false)).tap();
        await Future.delayed(const Duration(seconds: 2));
        
        // Select Employee (Harry James)
        await $(RegExp(r'Harry James', caseSensitive: false)).tap();
        
        // Select Client (Maya)
        if (await $(RegExp(r'Maya Client', caseSensitive: false)).exists) {
            await $(RegExp(r'Maya Client', caseSensitive: false)).tap();
        } else {
            // Tap the first available client if Maya isn't found
            await $(ListTile).at(1).tap(); 
        }

        await $(RegExp(r'Confirm', caseSensitive: false)).tap();
        
        // Select Date (Just tap OK for today)
        if (await $(RegExp(r'Select Date', caseSensitive: false)).exists) {
            await $(RegExp(r'Select Date', caseSensitive: false)).tap();
            await $(RegExp(r'OK', caseSensitive: false)).tap();
        }
        
        // Select NDIS Item
        if (await $(RegExp(r'Select NDIS Item', caseSensitive: false)).exists) {
            await $(RegExp(r'Select NDIS Item', caseSensitive: false)).tap();
            // Tap the first standard rate item
            await $(RegExp(r'Assistance With Self-Care|Standard NDIS', caseSensitive: false)).at(0).tap();
            await $(RegExp(r'Select', caseSensitive: false)).tap();
        }

        // Tap Add Assignment / Create
        await $(RegExp(r'Add Assignment|Create Shift', caseSensitive: false)).tap();
        await Future.delayed(const Duration(seconds: 3)); // Wait for API
      }

      // Log out Admin
      print('--- Logging out Admin ---');
      await $(Icons.menu).tap(); // Open drawer or profile
      await $(RegExp(r'Log Out|Logout|Sign Out', caseSensitive: false)).tap();
      await Future.delayed(const Duration(seconds: 2));


      // =======================================================================
      // SLIDE 2 & 3: EMPLOYEE FLOW (Shift Admin & Proof of Service)
      // =======================================================================
      print('--- Starting Employee Flow ---');
      await emailFields.at(0).enterText('bishalkc331@gmail.com');
      await emailFields.at(1).enterText('Bishal@xiomi123'); // Assuming same password format
      
      if ($.tester.testTextInput.hasAnyClients) {
        $.tester.testTextInput.closeConnection();
      }
      
      await $(RegExp(r'Sign in|Login', caseSensitive: false)).tap();
      
      // Wait for Employee Dashboard
      await Future.delayed(const Duration(seconds: 5)); 
      
      // Slide 2: Spend less time on shift admin (Employee Dashboard showing assigned shift)
      await captureScreenshot('02_employee_dashboard_shift', $);

      // Slide 3: Capture proof of service
      // "user can see the shift assigned to them in detail if that widget is tapped in"
      // We will tap the first card that looks like a shift assignment
      if (await $(Card).exists) {
        await $(Card).at(0).tap(); // Tap the shift card
        await Future.delayed(const Duration(seconds: 2));
        await captureScreenshot('03_employee_shift_detail_proof', $);
        
        // Go back
        await $.native.pressBack();
      }

      // Log out Employee
      print('--- Logging out Employee ---');
      await $(Icons.menu).tap();
      await $(RegExp(r'Log Out|Logout|Sign Out', caseSensitive: false)).tap();
      await Future.delayed(const Duration(seconds: 2));


      // =======================================================================
      // SLIDE 4 & 5 & 7: CLIENT FLOW (Family Visibility, Client Portal, Hub)
      // =======================================================================
      print('--- Starting Client Flow ---');
      // I am assuming the client email based on your maestro files. Adjust if needed.
      await emailFields.at(0).enterText('client.seed.1@mailinator.com'); 
      await emailFields.at(1).enterText('Bishal@xiomi123'); 
      
      if ($.tester.testTextInput.hasAnyClients) {
        $.tester.testTextInput.closeConnection();
      }
      
      await $(RegExp(r'Sign in|Login', caseSensitive: false)).tap();
      await Future.delayed(const Duration(seconds: 4)); 

      // Slide 5: Let clients see what matters
      await captureScreenshot('05_client_dashboard', $);

      // Slide 4: Give families visibility
      // Scroll down to family/messaging area
      await $(Scrollable).scrollTo(
        $(RegExp(r'Secure Shift Messaging|Family', caseSensitive: false)),
      );
      await Future.delayed(const Duration(seconds: 1));
      await captureScreenshot('04_client_family_visibility', $);

      // Slide 7: Communication Hub
      if (await $(RegExp(r'OPEN CHAT|Messages', caseSensitive: false)).exists) {
        await $(RegExp(r'OPEN CHAT|Messages', caseSensitive: false)).tap();
        await Future.delayed(const Duration(seconds: 2));
        
        // Type a dummy message so the UI looks active
        if (await $(TextField).exists) {
          await $(TextField).enterText('Hello! See you soon.');
          if ($.tester.testTextInput.hasAnyClients) {
            $.tester.testTextInput.closeConnection();
          }
        }
        await captureScreenshot('07_communication_hub_chat', $);
      }

      print('✅ All App Store Screenshots Captured Successfully!');
    },
  );
}
