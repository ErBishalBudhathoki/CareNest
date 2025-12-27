import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:carenest/app/features/invoice/presentation/widgets/price_prompt_dialog.dart';

/// Widget tests for PricePromptDialog to verify quantity formatting
/// and tooltip content, and simulate a successful price entry flow.
void main() {
  /// Pumps a MaterialApp with the PricePromptDialog for testing.
  ///
  /// Parameters:
  /// - `promptData`: Map used to populate the dialog fields.
  /// - `onProvided`: Callback invoked when Apply Price is pressed.
  Future<void> pumpDialog(
    WidgetTester tester, {
    required Map<String, dynamic> promptData,
    required void Function(Map<String, dynamic>) onProvided,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              // Present as a real dialog so Navigator.pop() closes it.
              // Use microtask to ensure showDialog runs after first build.
              Future.microtask(() {
                showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (dialogCtx) => PricePromptDialog(
                    promptData: promptData,
                    onPriceProvided: (r) {
                      onProvided(r);
                      Navigator.of(dialogCtx).pop();
                    },
                    onCancel: () {
                      Navigator.of(dialogCtx).pop();
                    },
                  ),
                );
              });
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('Displays formatted quantity (seconds included) and tooltip',
      (tester) async {
    Map<String, dynamic> promptData = {
      'ndisItemNumber': '01_011_0107_1_1',
      'itemDescription': 'Assistance with self-care activities',
      'quantity': 1.003611, // ~1 hour and 13 seconds
      'unit': 'hours',
      'suggestedPrice': 55.0,
    };

    Map<String, dynamic>? resolution;

    await pumpDialog(
      tester,
      promptData: promptData,
      onProvided: (r) => resolution = r,
    );

    // Verify resolution is captured when price provided
    expect(resolution, isNull); // Since we don't tap apply in this test

    // Verify quantity text shows 4 decimals and unit label.
    expect(find.text('1.0036 hours'), findsOneWidget);

    // Verify tooltip exists with expected message content.
    final tooltipFinder = find.byType(Tooltip);
    expect(tooltipFinder, findsOneWidget);
    final tooltip = tester.widget<Tooltip>(tooltipFinder);
    expect(
      tooltip.message,
      'Exact hours shown up to 4 decimals (seconds included). Total = Hours × Rate.',
    );
  });

  testWidgets('Falls back to 1.00 hours when quantity is invalid/missing',
      (tester) async {
    Map<String, dynamic> promptData = {
      'ndisItemNumber': '01_011_0107_1_1',
      'itemDescription': 'Assistance with self-care activities',
      'quantity': 'abc', // invalid
      'unit': 'hours',
      'suggestedPrice': 55.0,
    };

    await pumpDialog(
      tester,
      promptData: promptData,
      onProvided: (_) {},
    );

    // Expect fallback formatting to 1.00 hours
    expect(find.text('1.00 hours'), findsOneWidget);
  });

  testWidgets('Applies price and closes dialog successfully', (tester) async {
    Map<String, dynamic> promptData = {
      'ndisItemNumber': '01_011_0107_1_1',
      'itemDescription': 'Assistance with self-care activities',
      'quantity': 2.25,
      'unit': 'hours',
      'suggestedPrice': 40.0,
    };

    Map<String, dynamic>? resolution;

    await pumpDialog(
      tester,
      promptData: promptData,
      onProvided: (r) => resolution = r,
    );

    // Enter a valid price value
    final priceField = find.byType(TextFormField).first;
    await tester.enterText(priceField, '50.00');

    // Tap Apply Price
    await tester.tap(find.text('Apply Price'));
    await tester.pumpAndSettle();

    // Verify resolution captured
    expect(resolution, isNotNull);
    expect(resolution!['providedPrice'], 50.00);

    // Dialog should be closed
    expect(find.byType(PricePromptDialog), findsNothing);

    addTearDown(() async {
      // Ensure no pending animations or overlays remain
      await tester.pumpAndSettle();
    });
  });
}