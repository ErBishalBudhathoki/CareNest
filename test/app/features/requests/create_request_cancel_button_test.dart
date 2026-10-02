import 'dart:io';
import 'dart:math' as math;

import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The cancel button on all three create-request views is
/// `BauhausActionVariant.neutral` with `isOutlined: true`.
///
/// BauhausActionButton ended its outlined handling with
/// `effectiveText = textColor ?? colorScheme.primary`, which discarded the
/// variant's own accent. Neutral therefore painted hazard yellow #FFC300 on a
/// near-white surface: 1.57:1, failing AA outright. Rendered output before this
/// fix, in light mode:
///
///   CANCEL text colour = ffffc300   border = ffffc300   on surface fffffcf5
///
/// Neutral is now exempt from that override, so it keeps its neutral accent.
/// Every other outlined variant is deliberately untouched.
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

  Future<(Color ink, Color? border)> render(
    WidgetTester tester,
    BauhausActionVariant variant, {
    required bool isOutlined,
    required ThemeData theme,
    String label = 'CANCEL',
  }) async {
    await tester.binding.setSurfaceSize(const Size(390, 300));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        theme: theme,
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 200,
              child: BauhausActionButton(
                text: label,
                variant: variant,
                isOutlined: isOutlined,
                onPressed: () {},
              ),
            ),
          ),
        ),
      ),
    );

    var ink = theme.colorScheme.onSurface;
    Color? border;
    for (final e in find.byType(Text).evaluate()) {
      if ((e.widget as Text).data == label) {
        ink = (e.widget as Text).style?.color ?? ink;
      }
    }
    for (final e in find.byType(Container).evaluate()) {
      final d = (e.widget as Container).decoration;
      if (d is BoxDecoration &&
          d.border != null &&
          d.border!.isUniform &&
          d.border!.top.width > 0) {
        border = d.border!.top.color;
      }
    }
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 1));
    return (ink, border);
  }

  testWidgets('the neutral outlined cancel label is readable in light mode', (
    tester,
  ) async {
    final theme = BauhausDesign.lightTheme;
    final (ink, border) = await render(
      tester,
      BauhausActionVariant.neutral,
      isOutlined: true,
      theme: theme,
    );

    expect(
      ink,
      isNot(theme.colorScheme.primary),
      reason: 'the label must not be hazard yellow',
    );
    final ratio = contrast(ink, theme.colorScheme.surface);
    expect(
      ratio,
      greaterThanOrEqualTo(4.5),
      reason:
          'cancel label is only ${ratio.toStringAsFixed(2)}:1 on the light '
          'surface',
    );
    expect(border, ink, reason: 'border and label should share the accent');
  });

  testWidgets('the same cancel label is readable in dark mode', (tester) async {
    final theme = BauhausDesign.darkTheme;
    final (ink, _) = await render(
      tester,
      BauhausActionVariant.neutral,
      isOutlined: true,
      theme: theme,
    );
    expect(contrast(ink, theme.colorScheme.surface), greaterThanOrEqualTo(4.5));
  });

  testWidgets('primary and secondary keep the yellow accent', (tester) async {
    // Guards against the cancel fix going further than it should. Primary and
    // secondary outlined buttons render yellow on purpose.
    //
    // Danger is deliberately absent: it now carries red on the border, which is
    // covered by bauhaus_danger_button_test.dart.
    for (final variant in <BauhausActionVariant>[
      BauhausActionVariant.primary,
      BauhausActionVariant.secondary,
    ]) {
      final theme = BauhausDesign.lightTheme;
      final (ink, _) = await render(
        tester,
        variant,
        isOutlined: true,
        theme: theme,
      );
      expect(
        ink,
        theme.colorScheme.primary,
        reason: '$variant outlined should still use the primary accent',
      );
    }
  });

  testWidgets('danger outlined is red-bordered, not yellow', (tester) async {
    // Recorded here too, because this is the file that first pinned danger as
    // yellow. If danger ever goes back to yellow that is a regression.
    final theme = BauhausDesign.lightTheme;
    final (ink, border) = await render(
      tester,
      BauhausActionVariant.danger,
      isOutlined: true,
      theme: theme,
      label: 'DECLINE',
    );
    expect(border, theme.colorScheme.tertiary, reason: 'border must be red');
    expect(
      ink,
      theme.colorScheme.onSurface,
      reason: 'the label stays readable rather than red',
    );
  });

  testWidgets('a filled neutral button is unchanged', (tester) async {
    final theme = BauhausDesign.lightTheme;
    final (ink, _) = await render(
      tester,
      BauhausActionVariant.neutral,
      isOutlined: false,
      theme: theme,
    );
    expect(ink, theme.colorScheme.onSurface);
  });

  test('the old pairing was below AA, so the reason survives', () {
    final light = BauhausDesign.lightTheme.colorScheme;
    final before = contrast(BauhausDesign.primary, light.surface);
    expect(
      before,
      lessThan(4.5),
      reason: 'yellow on the light surface was ${before.toStringAsFixed(2)}:1',
    );
    expect(contrast(light.onSurface, light.surface), greaterThanOrEqualTo(4.5));
  });

  test('all three create-request cancel buttons use the fixed combination', () {
    // The views cannot be pumped without their providers, so this asserts the
    // shape of the call instead. All three were neutral + isOutlined.
    const files = <String>[
      'lib/app/features/requests/views/add_shift_request_view.dart',
      'lib/app/features/requests/views/add_time_off_request_view.dart',
      'lib/app/features/requests/views/shift_exchange_view.dart',
    ];
    for (final f in files) {
      final file = File(f);
      expect(file.existsSync(), isTrue, reason: '$f should exist');
      final src = file.readAsStringSync();
      // Find each cancel button and confirm it is neutral + outlined, the
      // combination this fix addresses.
      final re = RegExp(
        r'BauhausActionButton\((?:[^()]|\([^()]*\))*?variant:\s*BauhausActionVariant\.neutral(?:[^()]|\([^()]*\))*?isOutlined:\s*true',
        dotAll: true,
      );
      expect(
        re.hasMatch(src),
        isTrue,
        reason:
            '$f should still use neutral + isOutlined for its cancel '
            'button, which is what makes this fix apply to it',
      );
    }
  });
}
