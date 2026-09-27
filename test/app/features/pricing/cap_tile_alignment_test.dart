import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

/// Regression guard for the NDIS pricing item card's three regional cap tiles
/// ("NATIONAL", "REMOTE", "VERY REMOTE").
///
/// Two requirements, which pull against each other:
///  1. the label and the amount must each stay on a single line, and
///  2. all three tiles must render at exactly the same height.
///
/// A bare `FittedBox` satisfies (1) but breaks (2): it scales each value by
/// its own width, and a proportional face gives "$82.57" and "$123.86"
/// different natural widths, so the tiles ended up 2-3px apart. Pinning the
/// value's height decouples the scale factor from the laid-out height.
Widget _capTile(String title, String value) => Container(
  padding: const EdgeInsets.fromLTRB(8, 7, 8, 9),
  decoration: BoxDecoration(
    color: BauhausDesign.lightTheme.colorScheme.surfaceContainer,
    border: Border.all(
      color: BauhausDesign.lightTheme.colorScheme.onSurface,
      width: 2,
    ),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        title,
        maxLines: 1,
        softWrap: false,
        overflow: TextOverflow.clip,
        style: BauhausDesign.lightTextTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w800,
          letterSpacing: 0,
        ),
      ),
      const SizedBox(height: 4),
      SizedBox(
        height: 24,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            value,
            maxLines: 1,
            softWrap: false,
            style: BauhausDesign.lightTextTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 20,
            ),
          ),
        ),
      ),
    ],
  ),
);

Widget _capRow(String a, String b, String c) => Row(
  children: [
    Expanded(child: _capTile('NATIONAL', a)),
    const SizedBox(width: 10),
    Expanded(child: _capTile('REMOTE', b)),
    const SizedBox(width: 10),
    Expanded(child: _capTile('VERY REMOTE', c)),
  ],
);

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  Future<List<RenderBox>> pumpCapRow(
    WidgetTester tester, {
    required double width,
    required String a,
    required String b,
    required String c,
  }) async {
    await tester.binding.setSurfaceSize(Size(width, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        theme: BauhausDesign.lightTheme,
        home: Scaffold(
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [IntrinsicHeight(child: _capRow(a, b, c))],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    return tester
        .renderObjectList<RenderBox>(
          find.descendant(
            of: find.byType(Row),
            matching: find.byType(Expanded),
          ),
        )
        .toList();
  }

  // 320 is the narrowest phone width worth supporting; 390 is typical.
  for (final width in [390.0, 320.0]) {
    for (final values in [
      ['N/A', 'N/A', 'N/A'],
      ['\$82.57', '\$115.60', '\$123.86'],
      ['\$1,234.56', '\$1,234.56', '\$1,234.56'],
      ['N/A', '\$115.60', '\$123.86'],
    ]) {
      testWidgets('tiles equal height at $width for ${values.join(' / ')}', (
        tester,
      ) async {
        final boxes = await pumpCapRow(
          tester,
          width: width,
          a: values[0],
          b: values[1],
          c: values[2],
        );
        expect(boxes.length, 3);

        final heights = boxes.map((b) => b.size.height).toSet();
        expect(
          heights.length,
          1,
          reason: 'cap tiles differ in height at ${width}px: $heights',
        );
      });

      testWidgets('labels stay on one line at $width', (tester) async {
        await pumpCapRow(
          tester,
          width: width,
          a: values[0],
          b: values[1],
          c: values[2],
        );

        for (final label in ['NATIONAL', 'REMOTE', 'VERY REMOTE']) {
          final size = tester.getSize(find.text(label));
          expect(
            size.height,
            lessThan(20),
            reason: '"$label" wrapped to more than one line at ${width}px',
          );
        }
        // No RenderFlex overflow from an un-scalable amount.
        expect(tester.takeException(), isNull);
      });
    }
  }
}
