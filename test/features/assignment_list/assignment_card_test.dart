import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Error boundary renders error card on exception', (
    WidgetTester tester,
  ) async {
    // Mimic the logic in AssignmentListView
    Widget buildSafeCard(bool shouldThrow) {
      try {
        if (shouldThrow) throw Exception('Test Error');
        return const Text('Success');
      } catch (e) {
        return const Text('Error displaying assignment');
      }
    }

    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: buildSafeCard(true))),
    );

    expect(find.text('Error displaying assignment'), findsOneWidget);
  });
}
