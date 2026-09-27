import 'dart:ui' as ui;

import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

/// Proves the slider dialer is a square block and not a disc.
///
/// A shape-type assertion is not enough here: Material's
/// `RoundSliderThumbShape` and a square thumb both report a square
/// `getPreferredSize`, so the original circular implementation passed a
/// type check while still painting a circle. This samples the rendered pixels
/// instead.
///
/// Discriminator: a square has fill in its own top-left corner, a circle has
/// the track/backdrop showing through there.
bool _isYellow(Color c) => c.r > 0.75 && c.g > 0.55 && c.b < 0.35;

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  Future<Color> thumbCornerPixel(WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final key = GlobalKey();
    await tester.pumpWidget(
      MaterialApp(
        theme: BauhausDesign.lightTheme,
        home: Scaffold(
          backgroundColor: const Color(0xFF000000),
          body: RepaintBoundary(
            key: key,
            child: Center(
              child: Slider(value: 0.5, min: 0, max: 1, onChanged: (_) {}),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    final boundary =
        key.currentContext!.findRenderObject()! as RenderRepaintBoundary;

    return (await tester.runAsync(() async {
      final image = await boundary.toImage(pixelRatio: 1.0);
      final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
      final w = image.width, h = image.height;
      Color at(int x, int y) {
        final i = (y * w + x) * 4;
        return Color.fromARGB(
          255,
          data!.getUint8(i),
          data.getUint8(i + 1),
          data.getUint8(i + 2),
        );
      }

      // The track is 10px tall and the thumb 18px, so the column with the
      // tallest yellow extent is the thumb's centre. Finding the *first*
      // tall column instead would land inside a disc, whose extreme columns
      // are only a few pixels tall.
      var bestX = -1, bestExtent = 0, tTop = -1, tBottom = -1;
      for (var x = 0; x < w; x++) {
        var cTop = -1, cBottom = -1;
        for (var y = 0; y < h; y++) {
          if (_isYellow(at(x, y))) {
            if (cTop < 0) cTop = y;
            cBottom = y;
          }
        }
        final extent = cTop < 0 ? 0 : cBottom - cTop + 1;
        if (extent > bestExtent) {
          bestExtent = extent;
          bestX = x;
          tTop = cTop;
          tBottom = cBottom;
        }
      }
      expect(bestX, greaterThanOrEqualTo(0), reason: 'no thumb found');

      // Walk out to the thumb's true horizontal edges.
      final midY = (tTop + tBottom) ~/ 2;
      var tLeft = bestX;
      while (tLeft > 0 && _isYellow(at(tLeft - 1, midY))) {
        tLeft--;
      }
      return at(tLeft + 1, tTop);
    }))!;
  }

  testWidgets('light theme paints a square thumb, not a disc', (tester) async {
    final corner = await thumbCornerPixel(tester);
    expect(
      _isYellow(corner),
      isTrue,
      reason:
          'thumb corner is rgb(${corner.r.toStringAsFixed(2)},'
          '${corner.g.toStringAsFixed(2)},${corner.b.toStringAsFixed(2)}) '
          '— expected the thumb fill, so the dialer is rendering as a circle',
    );
  });
}
