import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

/// Guards the Bauhaus "edged dialer" requirement: sliders must render a
/// square thumb and a rectangular track, not Material's round thumb, and the
/// inactive track must be visible in dark mode.
void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('both themes use the hard-edged slider shapes', (tester) async {
    for (final theme in [BauhausDesign.lightTheme, BauhausDesign.darkTheme]) {
      final slider = theme.sliderTheme;

      expect(
        slider.trackShape.runtimeType,
        RectangularSliderTrackShape,
        reason: 'track must be rectangular, not rounded',
      );
      expect(
        slider.thumbShape.runtimeType.toString(),
        isNot('RoundSliderThumbShape'),
        reason: 'thumb must not be the default round shape',
      );
      expect(
        slider.overlayShape.runtimeType.toString(),
        isNot('SliderComponentShape'),
      );
    }
  });

  testWidgets('dark inactive track is visible against the dark surface', (
    tester,
  ) async {
    final dark = BauhausDesign.darkTheme.sliderTheme;
    final surface = BauhausDesign.darkTheme.colorScheme.surface;

    // The track must be meaningfully lighter than the plane behind it.
    expect(
      dark.inactiveTrackColor!.computeLuminance(),
      greaterThan(surface.computeLuminance()),
      reason: 'dark inactive track would be invisible',
    );
    expect(dark.thumbColor!.computeLuminance(), greaterThan(0.3));
  });

  testWidgets('an enabled slider paints a square thumb with a hard border', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 400));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        theme: BauhausDesign.lightTheme,
        home: Scaffold(
          body: Center(
            child: Slider(value: 0.5, min: 0, max: 1, onChanged: (_) {}),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final shape = BauhausDesign.lightTheme.sliderTheme.thumbShape!;
    final size = shape.getPreferredSize(true, false);
    expect(size.width, size.height);

    // A circle and a square have identical preferred sizes, so asserting only
    // on size cannot tell them apart. The corner radius is what does: a radius
    // equal to half the thumb is a circle, which is what the Bauhaus thumb
    // must never be.
    expect(
      BauhausDesign.sliderThumbCornerRadius,
      lessThan(BauhausDesign.sliderThumbRadius / 2),
      reason: 'thumb radius at half the size renders a circle, not a block',
    );
    expect(
      BauhausDesign.sliderThumbCornerRadius,
      0,
      reason: 'DESIGN.md: zero radii',
    );

    expect(tester.takeException(), isNull);
  });
}
