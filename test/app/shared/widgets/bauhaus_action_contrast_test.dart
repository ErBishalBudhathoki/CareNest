import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/contrast.dart';

/// Every [BauhausActionVariant] must label itself readably against the fill it
/// is painted on, in both brightness modes, filled and outlined.
///
/// The rule lives in [resolveActionButtonColors] so it can be checked directly.
/// `secondary` shipped hazard-yellow text on a near-white fill at 1.57:1 across
/// 33 call sites, mostly dialog Cancel buttons, and no test looked at the
/// rendered pair. Two earlier batches fixed requests and then leave while the
/// variant itself stayed broken, because each fix went into a screen instead of
/// into the shared switch.
void main() {
  /// danger and error share the brand red fill, where white measures 4.17:1.
  /// Recorded rather than silently skipped, so a change to the red cannot move
  /// it without this test noticing.
  const knownSubAa = <BauhausActionVariant, double>{
    BauhausActionVariant.danger: 4.17,
    BauhausActionVariant.error: 4.17,
  };

  final schemes = <String, ColorScheme>{
    'light': BauhausDesign.lightTheme.colorScheme,
    'dark': BauhausDesign.darkTheme.colorScheme,
  };

  for (final entry in schemes.entries) {
    for (final isOutlined in [false, true]) {
      final mode = isOutlined ? 'outlined' : 'filled';
      group('${entry.key} $mode', () {
        for (final variant in BauhausActionVariant.values) {
          test('${variant.name} label is readable on its own fill', () {
            final r = resolveActionButtonColors(
              colorScheme: entry.value,
              variant: variant,
              isOutlined: isOutlined,
            );

            // Outlined buttons always sit on the surface; a transparent fill
            // means the button is transparent and the surface shows through.
            final fill = r.background.a < 0.01
                ? entry.value.surface
                : r.background;

            final ratio = contrastRatio(r.label, fill);
            // Only the filled red fill is the exception. Outlined danger labels
            // with onSurface, which clears AA comfortably.
            final bar = isOutlined ? null : knownSubAa[variant];

            if (bar != null) {
              expect(
                ratio,
                closeTo(bar, 0.15),
                reason:
                    '${variant.name} is a recorded sub-AA exception on '
                    '${entry.key} $mode at ${ratio.toStringAsFixed(2)}:1. '
                    'If this moved, either fix the red or update this record '
                    'deliberately.',
              );
            } else {
              expect(
                ratio,
                greaterThanOrEqualTo(4.5),
                reason:
                    '${variant.name} on ${entry.key} $mode labels in '
                    '${r.label} on $fill = '
                    '${ratio.toStringAsFixed(2)}:1, needs 4.5:1.',
              );
            }
          });
        }
      });
    }
  }

  test('every outlined border clears the 3:1 non-text threshold', () {
    // A border is a shape, not text, so it is judged against 3:1 rather than
    // 4.5:1. This is the threshold the red danger border was chosen to pass.
    for (final entry in schemes.entries) {
      for (final variant in BauhausActionVariant.values) {
        if (variant == BauhausActionVariant.ghost) continue;
        final r = resolveActionButtonColors(
          colorScheme: entry.value,
          variant: variant,
          isOutlined: true,
        );
        final border = r.border;
        if (border == null || border.a < 0.01) continue;
        expect(
          contrastRatio(border, entry.value.surface),
          greaterThanOrEqualTo(3.0),
          reason:
              '${variant.name} outlined border on ${entry.key} is '
              '${contrast(border, entry.value.surface)}:1 against the surface, '
              'needs 3:1.',
        );
      }
    }
  });

  test('secondary no longer labels with hazard yellow', () {
    // The specific regression, in plain numbers. Yellow on the surface is only
    // a problem in light mode, where the surface is near-white; in dark mode the
    // same pair is 8.18:1 and perfectly readable, so the assertion is scoped.
    final light = BauhausDesign.lightTheme.colorScheme;
    final dark = BauhausDesign.darkTheme.colorScheme;

    for (final entry in schemes.entries) {
      final r = resolveActionButtonColors(
        colorScheme: entry.value,
        variant: BauhausActionVariant.secondary,
      );
      expect(
        r.label,
        entry.value.onSurface,
        reason: 'secondary labels with onSurface, not primary',
      );
    }

    expect(
      contrastRatio(light.primary, light.surface),
      lessThan(2.0),
      reason:
          'in light mode this is ${contrast(light.primary, light.surface)}:1, '
          'the pair secondary used to paint. It must never be a label pair again.',
    );
    expect(
      contrastRatio(dark.primary, dark.surface),
      greaterThan(4.5),
      reason:
          'yellow on the dark surface is ${contrast(dark.primary, dark.surface)}:1 '
          'and legitimately readable, so the rule above is light-mode only',
    );
  });

  test('an explicit backgroundColor still wins', () {
    // The escape hatch has to keep working, or call sites that pass a custom
    // fill silently start rendering the variant's default.
    final r = resolveActionButtonColors(
      colorScheme: BauhausDesign.lightTheme.colorScheme,
      variant: BauhausActionVariant.primary,
      backgroundColor: const Color(0xFF000000),
    );
    expect(r.background, const Color(0xFF000000));
    expect(r.border, isNull);
  });
}
