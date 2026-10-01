import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:carenest/app/shared/widgets/bauhaus_error_widget.dart';

void main() {
  group('BauhausErrorWidget', () {
    testWidgets('displays title and message correctly', (tester) async {
      const testTitle = 'TEST ERROR';
      const testMessage = 'This is a test error message';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BauhausErrorWidget(title: testTitle, message: testMessage),
          ),
        ),
      );

      expect(find.text(testTitle), findsOneWidget);
      expect(find.text(testMessage), findsOneWidget);
    });

    testWidgets('displays retry button when onRetry is provided', (
      tester,
    ) async {
      bool retryPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BauhausErrorWidget(
              title: 'ERROR',
              message: 'Test message',
              onRetry: () {
                retryPressed = true;
              },
            ),
          ),
        ),
      );

      expect(find.text('TRY AGAIN'), findsOneWidget);

      await tester.tap(find.text('TRY AGAIN'));
      await tester.pump();

      expect(retryPressed, isTrue);
    });

    testWidgets('does not display retry button when onRetry is null', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BauhausErrorWidget(title: 'ERROR', message: 'Test message'),
          ),
        ),
      );

      expect(find.text('TRY AGAIN'), findsNothing);
    });

    testWidgets('displays custom icon when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BauhausErrorWidget(
              title: 'NETWORK ERROR',
              message: 'No connection',
              icon: Icons.wifi_off,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.wifi_off), findsOneWidget);
    });

    testWidgets('displays default error icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BauhausErrorWidget(title: 'ERROR', message: 'Test message'),
          ),
        ),
      );

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    group('compact layout', () {
      testWidgets('renders in compact mode', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: BauhausErrorWidget(
                title: 'COMPACT ERROR',
                message: 'Compact message',
                compact: true,
              ),
            ),
          ),
        );

        expect(find.text('COMPACT ERROR'), findsOneWidget);
        expect(find.text('Compact message'), findsOneWidget);
      });

      testWidgets('shows retry icon in compact mode', (tester) async {
        bool retryPressed = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BauhausErrorWidget(
                title: 'ERROR',
                message: 'Test',
                compact: true,
                onRetry: () {
                  retryPressed = true;
                },
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.refresh), findsOneWidget);

        await tester.tap(find.byIcon(Icons.refresh));
        await tester.pump();

        expect(retryPressed, isTrue);
      });
    });

    group('factory constructors', () {
      testWidgets('BauhausErrorWidget.network creates network error widget', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(home: Scaffold(body: BauhausErrorWidget.network())),
        );

        expect(find.text('CONNECTION ERROR'), findsOneWidget);
        expect(find.byIcon(Icons.wifi_off), findsOneWidget);
      });

      testWidgets('BauhausErrorWidget.empty creates empty state widget', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(home: Scaffold(body: BauhausErrorWidget.empty())),
        );

        expect(find.text('NO RESULTS'), findsOneWidget);
        expect(find.byIcon(Icons.inbox_outlined), findsOneWidget);
      });

      testWidgets('BauhausErrorWidget.permission creates permission widget', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BauhausErrorWidget.permission(permissionType: 'Camera'),
            ),
          ),
        );

        expect(find.text('PERMISSION REQUIRED'), findsOneWidget);
        expect(find.textContaining('Camera'), findsWidgets);
        expect(find.byIcon(Icons.lock_outline), findsOneWidget);
      });
    });

    group('diagnostics', () {
      testWidgets('shows diagnostics button when enabled', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: BauhausErrorWidget(
                title: 'ERROR',
                message: 'Test',
                showDiagnostics: true,
                diagnosticInfo: 'Debug info here',
              ),
            ),
          ),
        );

        expect(find.text('VIEW DIAGNOSTICS'), findsOneWidget);
      });

      testWidgets('hides diagnostics button when disabled', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: BauhausErrorWidget(
                title: 'ERROR',
                message: 'Test',
                showDiagnostics: false,
              ),
            ),
          ),
        );

        expect(find.text('VIEW DIAGNOSTICS'), findsNothing);
      });

      testWidgets('opens diagnostics dialog on tap', (tester) async {
        const diagnosticInfo = 'Stack trace: line 42';

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: BauhausErrorWidget(
                title: 'ERROR',
                message: 'Test',
                showDiagnostics: true,
                diagnosticInfo: diagnosticInfo,
              ),
            ),
          ),
        );

        await tester.tap(find.text('VIEW DIAGNOSTICS'));
        await tester.pumpAndSettle();

        expect(find.text('DIAGNOSTICS'), findsOneWidget);
        expect(find.text(diagnosticInfo), findsOneWidget);
        expect(find.text('COPY'), findsOneWidget);
        expect(find.text('CLOSE'), findsOneWidget);
      });
    });

    group('accessibility', () {
      testWidgets('error icon has proper semantics', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: BauhausErrorWidget(
                title: 'ERROR',
                message: 'Accessible error message',
              ),
            ),
          ),
        );

        // Verify text is present for screen readers
        expect(find.text('ERROR'), findsOneWidget);
        expect(find.text('Accessible error message'), findsOneWidget);
      });

      testWidgets('retry button is tappable', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BauhausErrorWidget(
                title: 'ERROR',
                message: 'Test',
                onRetry: () {},
              ),
            ),
          ),
        );

        final retryButton = find.text('TRY AGAIN');
        expect(tester.getSemantics(retryButton), isNotNull);
      });
    });
  });
}
