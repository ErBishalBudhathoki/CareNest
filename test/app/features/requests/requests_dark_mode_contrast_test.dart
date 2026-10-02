import 'dart:io';
import 'dart:math' as math;

import 'package:carenest/app/features/pricing/widgets/bauhaus_dashboard_components.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// `BauhausDesign.textMuted` is a fixed `const Color`, #3D3728, chosen for the
/// light theme where it sits on a near-white card. In dark mode the cards are
/// #313030 and #1C1B1B, so it measured 1.11:1 and 1.45:1: present on screen,
/// completely unreadable.
///
/// These pinned values are exactly `onSurfaceVariant`, which resolves to
/// #3D3728 in the light scheme and #D3C5AB in the dark one. Swapping one for the
/// other is therefore a no-op in light mode and a 7.7:1 fix in dark.
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

  Future<void> dispose(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 1));
  }

  testWidgets('action card subtitle is readable on the dark card surface', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
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
                  subtitle: 'Swap a shift with a colleague',
                  icon: Icons.calendar_month,
                  color: BauhausDesign.primary,
                  onTap: () {},
                ),
              ),
              Expanded(
                child: BauhausActionCard(
                  title: 'Time off',
                  subtitle: 'Request annual or sick leave',
                  icon: Icons.beach_access,
                  color: BauhausDesign.primary,
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );

    final subtitle = tester.widget<Text>(
      find.text('Swap a shift with a colleague'),
    );
    final ink = subtitle.style?.color;
    expect(
      ink,
      isNotNull,
      reason: 'the subtitle must carry an explicit colour',
    );

    final cardBg = BauhausDesign.darkTheme.colorScheme.surfaceContainerLow;
    final ratio = contrast(ink!, cardBg);
    expect(
      ratio,
      greaterThanOrEqualTo(4.5),
      reason:
          'subtitle is only ${ratio.toStringAsFixed(2)}:1 against the dark '
          'card; it was unreadable before this fix',
    );
    await dispose(tester);
  });

  testWidgets('the same card is unchanged in light mode', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
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
                  subtitle: 'Swap a shift with a colleague',
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
    final ink = tester
        .widget<Text>(find.text('Swap a shift with a colleague'))
        .style
        ?.color;
    expect(
      ink,
      BauhausDesign.textMuted,
      reason:
          'in light mode onSurfaceVariant resolves to textMuted, so the '
          'swap must not change what light mode renders',
    );
    await dispose(tester);
  });

  test('the fixed token was unreadable, so the reason survives', () {
    final dark = BauhausDesign.darkTheme.colorScheme;
    final bad = contrast(BauhausDesign.textMuted, dark.surfaceContainerLow);
    expect(
      bad,
      lessThan(4.5),
      reason:
          'BauhausDesign.textMuted on the dark card was '
          '${bad.toStringAsFixed(2)}:1',
    );
    final good = contrast(dark.onSurfaceVariant, dark.surfaceContainerLow);
    expect(good, greaterThanOrEqualTo(4.5));
  });

  test('the requests feature no longer hardcodes the light-mode token', () {
    // A guard rather than a one-off. Every one of these call sites rendered at
    // about 1.1:1 in dark mode.
    const files = <String>[
      'lib/app/features/requests/views/requests_view.dart',
      'lib/app/features/requests/views/add_shift_request_view.dart',
      'lib/app/features/requests/views/add_time_off_request_view.dart',
      'lib/app/features/requests/views/shift_exchange_view.dart',
      'lib/app/features/requests/views/admin_requests_dashboard_view.dart',
      'lib/app/features/pricing/widgets/bauhaus_dashboard_components.dart',
    ];
    final offenders = <String>[];
    for (final f in files) {
      final file = File(f);
      if (!file.existsSync()) continue;
      if (file.readAsStringSync().contains('BauhausDesign.textMuted')) {
        offenders.add(f);
      }
    }
    expect(
      offenders,
      isEmpty,
      reason:
          'these still use BauhausDesign.textMuted, a light-mode-only colour. '
          'Use Theme.of(context).colorScheme.onSurfaceVariant instead:\n'
          '${offenders.join('\n')}',
    );
  });
}
