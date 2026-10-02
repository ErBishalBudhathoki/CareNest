import 'dart:io';
import 'dart:math' as math;

import 'package:carenest/app/features/pricing/widgets/bauhaus_dashboard_components.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The create-request views painted supporting copy in `BauhausDesign.primary`,
/// hazard yellow #FFC300.
///
/// On the light card surface that is 1.57:1, and on the date chips it is worse:
/// the chip background is the same yellow at 10% over the card, so yellow sat on
/// pale yellow at 1.49:1. Both fail WCAG AA outright.
///
/// Foreground text and icons now use onSurface, which is the paired content
/// colour: 16.1:1 on the chip tint and 15.5:1 on the plain card, and 9.2:1 in
/// dark mode where the old yellow had been sitting at 6.5:1.
void main() {
  double contrast(Color a, Color b) {
    double lum(Color c) {
      double f(double v) => v <= 0.03928
          ? v / 12.92
          : math.pow((v + 0.055) / 1.055, 2.4) as double;
      return 0.2126 * f(c.r) + 0.7152 * f(c.g) + 0.0722 * f(c.b);
    }

    final l1 = lum(a), l2 = lum(b);
    final hi = l1 > l2 ? l1 : l2;
    final lo = l1 > l2 ? l2 : l1;
    return (hi + 0.05) / (lo + 0.05);
  }

  /// Reproduces `BauhausDesign.primary.withValues(alpha: a)` composited over
  /// `under`, which is what the chip backgrounds actually paint.
  Color tint(Color over, Color under, double a) =>
      Color.alphaBlend(over.withValues(alpha: a), under);

  Future<void> dispose(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 1));
  }

  test('yellow on the chip tint was unreadable, onSurface is not', () {
    final light = BauhausDesign.lightTheme.colorScheme;
    final chip = tint(BauhausDesign.primary, light.surfaceContainerLow, 0.1);

    final before = contrast(BauhausDesign.primary, chip);
    expect(
      before,
      lessThan(4.5),
      reason: 'yellow on its own 10% tint was ${before.toStringAsFixed(2)}:1',
    );

    final after = contrast(light.onSurface, chip);
    expect(
      after,
      greaterThanOrEqualTo(4.5),
      reason:
          'onSurface on the same tint is only ${after.toStringAsFixed(2)}:1',
    );
  });

  test('yellow on the plain light card was unreadable too', () {
    final light = BauhausDesign.lightTheme.colorScheme;
    final before = contrast(BauhausDesign.primary, light.surfaceContainerLow);
    expect(before, lessThan(4.5));
    expect(
      contrast(light.onSurface, light.surfaceContainerLow),
      greaterThanOrEqualTo(4.5),
    );
  });

  test('dark mode is not regressed by the change', () {
    final dark = BauhausDesign.darkTheme.colorScheme;
    final chip = tint(BauhausDesign.primary, dark.surfaceContainerLow, 0.1);
    expect(
      contrast(dark.onSurface, chip),
      greaterThanOrEqualTo(4.5),
      reason: 'onSurface must also hold on the chip in dark mode',
    );
  });

  test('the create-request views use no yellow foreground', () {
    const files = <String>[
      'lib/app/features/requests/views/add_shift_request_view.dart',
      'lib/app/features/requests/views/add_time_off_request_view.dart',
      'lib/app/features/requests/views/shift_exchange_view.dart',
    ];
    // A bare `BauhausDesign.primary` as a foreground colour is the bug. The
    // chip backgrounds legitimately use primary.withValues(alpha:), and the
    // spinner keeps the accent as its own colour.
    final offenders = <String>[];
    for (final f in files) {
      final file = File(f);
      if (!file.existsSync()) continue;
      final lines = file.readAsStringSync().split('\n');
      for (var i = 0; i < lines.length; i++) {
        final t = lines[i].trim();
        if (!t.contains('BauhausDesign.primary')) continue;
        if (t.contains('withValues')) continue;
        // Progress indicators are shapes, not text, and the accent is correct
        // for them. CircularProgressIndicator takes its colour on the same
        // line; RefreshIndicator's colour argument sits up to three lines
        // below the constructor. Check both.
        final above = i >= 3
            ? lines.sublist(i - 3, i).join(' ')
            : lines.sublist(0, i).join(' ');
        if (t.contains('CircularProgressIndicator(')) continue;
        if (above.contains('CircularProgressIndicator(')) continue;
        if (above.contains('RefreshIndicator(')) continue;
        offenders.add('$f: ${i + 1}: $t');
      }
    }
    expect(
      offenders,
      isEmpty,
      reason:
          'yellow foreground fails AA on the light card (1.57:1) and on the '
          'yellow chip (1.49:1). Use colorScheme.onSurface instead:\n'
          '${offenders.join('\n')}',
    );
  });

  testWidgets('action card no longer draws a trailing arrow', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 300));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        theme: BauhausDesign.lightTheme,
        home: Scaffold(
          body: Row(
            children: [
              Expanded(
                child: BauhausActionCard(
                  title: 'Shift request',
                  subtitle: 'Swap a shift',
                  icon: Icons.calendar_month,
                  color: BauhausDesign.primary,
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
    expect(
      find.byIcon(Icons.arrow_forward),
      findsNothing,
      reason:
          'the trailing arrow was removed from the shared card, so all '
          'three create-request tiles lose it together',
    );
    // The rest of the card is intact.
    expect(find.byIcon(Icons.calendar_month), findsOneWidget);
    expect(find.text('Shift request'), findsOneWidget);
    await dispose(tester);
  });

  testWidgets('no arrow in dark mode either', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 300));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        theme: BauhausDesign.darkTheme,
        home: Scaffold(
          body: Row(
            children: [
              Expanded(
                child: BauhausActionCard(
                  title: 'Shift request',
                  subtitle: 'Swap a shift',
                  icon: Icons.calendar_month,
                  color: BauhausDesign.primary,
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
    expect(find.byIcon(Icons.arrow_forward), findsNothing);
    await dispose(tester);
  });
}
