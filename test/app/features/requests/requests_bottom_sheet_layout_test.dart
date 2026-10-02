import 'package:carenest/app/features/pricing/widgets/bauhaus_dashboard_components.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Pressing New Request opens a bottom sheet of BauhausActionCards.
///
/// Each card used to wrap its subtitle in `Expanded` inside a
/// `Column(mainAxisSize: MainAxisSize.min)`. A bottom sheet hands its child an
/// unbounded height, and a flex child cannot take an infinite main-axis extent,
/// so opening the sheet threw:
///
///   RenderFlex children have non-zero flex but incoming height constraints
///   are unbounded
///
/// and then a cascade of "RenderBox was not laid out".
void main() {
  Future<void> dispose(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 1));
  }

  Widget card(String title) => Expanded(
    child: BauhausActionCard(
      title: title,
      subtitle: 'A reasonably long subtitle that wraps to two lines',
      icon: Icons.calendar_month,
      color: BauhausDesign.primary,
      onTap: () {},
    ),
  );

  testWidgets('action cards lay out inside an unbounded bottom sheet', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        theme: BauhausDesign.lightTheme,
        home: Scaffold(
          body: Builder(
            builder: (context) => Center(
              child: ElevatedButton(
                onPressed: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => Container(
                    padding: const EdgeInsets.all(BauhausDesign.space4),
                    decoration: BoxDecoration(
                      color: BauhausDesign.lightTheme.colorScheme.surface,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(children: [card('Shift'), card('Time Off')]),
                        Row(children: [card('Exchange'), card('Other')]),
                      ],
                    ),
                  ),
                ),
                child: const Text('New Request'),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('New Request'));
    await tester.pumpAndSettle();

    expect(
      tester.takeException(),
      isNull,
      reason:
          'the bottom sheet must lay out without a flex-in-unbounded-height '
          'assertion',
    );
    expect(find.byType(BauhausActionCard), findsNWidgets(4));
    await dispose(tester);
  });

  testWidgets('action card renders its title and subtitle', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        theme: BauhausDesign.lightTheme,
        home: Scaffold(
          body: SingleChildScrollView(
            child: Row(children: [card('Shift'), card('Time Off')]),
          ),
        ),
      ),
    );
    expect(find.text('Shift'), findsOneWidget);
    expect(
      find.text('A reasonably long subtitle that wraps to two lines'),
      findsNWidgets(2),
    );
    await dispose(tester);
  });
}
