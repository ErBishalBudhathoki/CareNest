import 'dart:math' as math;

import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Destructive actions have to read as destructive, but the obvious fix of
/// colouring the label red does not survive contact with the contrast maths.
///
/// BauhausDesign's danger red is #E63946. As a label it measures 4.07:1 on the
/// light surface and 3.16:1 on the dark one, so it fails AA for text in both
/// themes. On a red fill it is 1.0:1. The default `variant: danger` button fills
/// with red and labels it with onTertiary, which is white and fine.
///
/// So an outlined danger button carries red on the *border* and keeps the label
/// on onSurface. A 2.5px border is a UI component, so the 3:1 non-text
/// threshold applies rather than 4.5:1, and the red clears that against both
/// surfaces.
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

  Future<(Color label, Color? border, Color fill)> render(
    WidgetTester tester,
    BauhausActionVariant variant, {
    required bool isOutlined,
    required ThemeData theme,
    String label = 'DECLINE',
  }) async {
    await tester.binding.setSurfaceSize(const Size(390, 300));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        theme: theme,
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 220,
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
    var fill = theme.colorScheme.surface;
    for (final e in find.byType(Text).evaluate()) {
      if ((e.widget as Text).data == label) {
        ink = (e.widget as Text).style?.color ?? ink;
      }
    }
    for (final e in find.byType(Container).evaluate()) {
      final d = (e.widget as Container).decoration;
      if (d is! BoxDecoration) continue;
      // The filled button is the one carrying the hard shadow.
      if (d.boxShadow != null && d.boxShadow!.isNotEmpty && d.color != null) {
        fill = d.color!;
      }
      if (d.border != null && d.border!.isUniform && d.border!.top.width > 0) {
        border = d.border!.top.color;
      }
    }
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 1));
    return (ink, border, fill);
  }

  testWidgets('outlined danger keeps a red border and a readable label', (
    tester,
  ) async {
    for (final (name, theme) in <(String, ThemeData)>[
      ('light', BauhausDesign.lightTheme),
      ('dark', BauhausDesign.darkTheme),
    ]) {
      final (label, border, _) = await render(
        tester,
        BauhausActionVariant.danger,
        isOutlined: true,
        theme: theme,
      );

      expect(
        border,
        theme.colorScheme.tertiary,
        reason: '$name: the border must carry the destructive red',
      );
      expect(
        label,
        theme.colorScheme.onSurface,
        reason: '$name: the label must not be red; red fails AA as text',
      );
      expect(
        contrast(label, theme.colorScheme.surface),
        greaterThanOrEqualTo(4.5),
        reason: '$name: label must stay readable on the surface',
      );
      // The border is a UI component, so 3:1 is the applicable threshold.
      expect(
        contrast(border!, theme.colorScheme.surface),
        greaterThanOrEqualTo(3.0),
        reason: '$name: the red border needs to be visible against the surface',
      );
    }
  });

  testWidgets('the label is never red on a red background', (tester) async {
    // The failure mode the user called out: red text over a red fill.
    for (final theme in <ThemeData>[
      BauhausDesign.lightTheme,
      BauhausDesign.darkTheme,
    ]) {
      for (final outlined in <bool>[true, false]) {
        final (label, border, fill) = await render(
          tester,
          BauhausActionVariant.danger,
          isOutlined: outlined,
          theme: theme,
        );
        // The label must not simply be the fill colour. 1:1 is the red-on-red
        // case; comfortably above it means a legible label.
        expect(
          contrast(label, fill),
          greaterThan(2.0),
          reason:
              'outlined=$outlined: label against its own background is '
              '${contrast(label, fill).toStringAsFixed(2)}:1, which is close '
              'to red-on-red',
        );
        if (outlined) {
          expect(
            label,
            isNot(border),
            reason:
                'an outlined danger button must not print the border '
                'colour as its label',
          );
          expect(
            contrast(label, fill),
            greaterThanOrEqualTo(4.5),
            reason: 'the outlined variant has no excuse: its label clears AA',
          );
        }
      }
    }
  });

  testWidgets('filled danger: red fill, light label, measured not assumed', (
    tester,
  ) async {
    final theme = BauhausDesign.lightTheme;
    final (label, _, fill) = await render(
      tester,
      BauhausActionVariant.danger,
      isOutlined: false,
      theme: theme,
    );
    expect(fill, theme.colorScheme.tertiary, reason: 'the fill must stay red');
    expect(label, theme.colorScheme.onTertiary, reason: 'label stays light');

    final ratio = contrast(label, fill);
    // 4.17:1 as measured. AA wants 4.5:1, so this sits 0.33 short. Closing it
    // needs a darker red, which means moving BauhausDesign.tertiary and
    // recolouring every button, border and accent that uses it. Deliberately
    // not done here; recorded so the gap stays visible.
    expect(
      ratio,
      greaterThan(4.0),
      reason:
          'white on the current danger red is ${ratio.toStringAsFixed(2)}:1',
    );
    expect(
      ratio,
      lessThan(4.5),
      reason:
          'if this now passes 4.5 the tertiary red changed; update the note in '
          'this test',
    );
  });

  testWidgets('the cancel button did not regress', (tester) async {
    final theme = BauhausDesign.lightTheme;
    final (label, border, _) = await render(
      tester,
      BauhausActionVariant.neutral,
      isOutlined: true,
      theme: theme,
      label: 'CANCEL',
    );
    expect(label, theme.colorScheme.onSurface);
    expect(border, theme.colorScheme.onSurface);
  });

  testWidgets('the accent variants are untouched', (tester) async {
    final theme = BauhausDesign.lightTheme;
    for (final variant in <BauhausActionVariant>[
      BauhausActionVariant.primary,
      BauhausActionVariant.secondary,
    ]) {
      final (label, border, _) = await render(
        tester,
        variant,
        isOutlined: true,
        theme: theme,
      );
      expect(label, theme.colorScheme.primary, reason: '$variant label');
      expect(border, theme.colorScheme.primary, reason: '$variant border');
    }
  });

  test('red as a label never reached AA, so the reason survives', () {
    for (final theme in <ThemeData>[
      BauhausDesign.lightTheme,
      BauhausDesign.darkTheme,
    ]) {
      expect(
        contrast(theme.colorScheme.tertiary, theme.colorScheme.surface),
        lessThan(4.5),
        reason:
            'danger red as text was below AA on this surface, which is why '
            'the red moved to the border',
      );
    }
    expect(
      contrast(
        BauhausDesign.lightTheme.colorScheme.tertiary,
        BauhausDesign.lightTheme.colorScheme.tertiary,
      ),
      1.0,
      reason: 'red on red is 1:1',
    );
  });
}
