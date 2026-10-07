import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

/// Locks the brightness-aware plane tokens that the Generate Invoice (enhanced)
/// screen now paints from.
///
/// Regression: those surfaces were painted with the literal `neoPaper`
/// (#FFFCF5, a light-plane colour) and text with the literal `neoInk`. In dark
/// mode that left white cards on a dark scaffold, and the Tax rate field
/// rendered light body text on a white fill — white on white.
void main() {
  late bool originalAllowRuntimeFetching;

  setUpAll(() {
    originalAllowRuntimeFetching = GoogleFonts.config.allowRuntimeFetching;
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  tearDownAll(() {
    GoogleFonts.config.allowRuntimeFetching = originalAllowRuntimeFetching;
  });

  /// Pumps a bare child inside each theme and returns the tokens resolved there.
  Future<({Color surface, Color ink})> resolveIn(
    WidgetTester tester,
    Brightness brightness,
  ) async {
    late Color surface;
    late Color ink;
    await tester.pumpWidget(
      MaterialApp(
        theme: brightness == Brightness.dark
            ? BauhausDesign.darkTheme
            : BauhausDesign.lightTheme,
        home: Builder(
          builder: (context) {
            surface = BauhausDesign.neoSurface(context);
            ink = BauhausDesign.neoInkOnSurface(context);
            return const SizedBox.shrink();
          },
        ),
      ),
    );
    return (surface: surface, ink: ink);
  }

  group('neoSurface follows the active brightness', () {
    testWidgets('is the parchment plane in light mode', (tester) async {
      // `debugPrint` must stay live here: the enhanced-invoice theme builds a
      // TextTheme eagerly and Flutter asserts the foundation debug vars are
      // untouched at the end of a widget test.
      final t = await resolveIn(tester, Brightness.light);
      expect(t.surface, BauhausDesign.neoPaper);
    });

    testWidgets('is the dark plane in dark mode', (tester) async {
      final t = await resolveIn(tester, Brightness.dark);
      expect(t.surface, BauhausDesign.surfaceDark);
      expect(t.surface, isNot(BauhausDesign.neoPaper));
    });
  });

  group('neoInkOnSurface is always readable on neoSurface', () {
    testWidgets('black ink on the light plane', (tester) async {
      final t = await resolveIn(tester, Brightness.light);
      expect(t.ink, BauhausDesign.neoInk);
    });

    testWidgets('light ink on the dark plane', (tester) async {
      final t = await resolveIn(tester, Brightness.dark);
      expect(t.ink, BauhausDesign.textLight);
      expect(t.ink, isNot(BauhausDesign.neoInk));
    });

    testWidgets('never returns the same colour as its own plane', (
      tester,
    ) async {
      for (final brightness in Brightness.values) {
        final t = await resolveIn(tester, brightness);
        expect(
          t.ink,
          isNot(t.surface),
          reason: 'ink and surface must differ in $brightness mode',
        );
      }
    });
  });

  group('the exact defect: field fill must not be light under dark text', () {
    testWidgets('dark mode field fill is dark, so light text can be read', (
      tester,
    ) async {
      final t = await resolveIn(tester, Brightness.dark);
      // The Tax rate field renders theme body text, which is light in dark
      // mode. A white fill here was the white-on-white bug.
      final bodyText = BauhausDesign.darkTheme.textTheme.bodyMedium?.color;
      expect(bodyText, BauhausDesign.textLight);
      expect(
        t.surface.computeLuminance(),
        lessThan(bodyText!.computeLuminance()),
        reason: 'field fill must be darker than its light body text',
      );
    });
  });

  group('decorations resolve the themed plane', () {
    testWidgets('card fill is dark in dark mode', (tester) async {
      late BoxDecoration decoration;
      await tester.pumpWidget(
        MaterialApp(
          theme: BauhausDesign.darkTheme,
          home: Builder(
            builder: (context) {
              decoration = BauhausDesign.neoCardDecoration(context: context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(decoration.color, BauhausDesign.surfaceDark);
      expect(
        decoration.color,
        isNot(BauhausDesign.neoPaper),
        reason: 'the light-plane fill is what kept cards white on dark',
      );
      // The structural border stays black in both themes per DESIGN.md.
      expect((decoration.border! as Border).top.color, BauhausDesign.neoInk);
    });

    testWidgets('panel fill is dark in dark mode', (tester) async {
      late BoxDecoration decoration;
      await tester.pumpWidget(
        MaterialApp(
          theme: BauhausDesign.darkTheme,
          home: Builder(
            builder: (context) {
              decoration = BauhausDesign.neoPanelDecoration(context: context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(decoration.color, BauhausDesign.surfaceDark);
    });

    testWidgets('an explicit backgroundColor still wins', (tester) async {
      late BoxDecoration decoration;
      await tester.pumpWidget(
        MaterialApp(
          theme: BauhausDesign.darkTheme,
          home: Builder(
            builder: (context) {
              decoration = BauhausDesign.neoCardDecoration(
                context: context,
                backgroundColor: BauhausDesign.neoSignal,
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(decoration.color, BauhausDesign.neoSignal);
    });

    testWidgets('without a context it falls back to the light plane', (
      tester,
    ) async {
      // Kept for call sites that genuinely have no BuildContext; the enhanced
      // invoice view now always passes one.
      expect(BauhausDesign.neoCardDecoration().color, BauhausDesign.neoPaper);
    });
  });
}

BuildContext _ctxFor(Brightness b) => throw UnimplementedError();
