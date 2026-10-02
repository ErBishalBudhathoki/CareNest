import 'dart:math' as math;

import 'package:carenest/app/features/requests/views/requests_view.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

/// Drives the real [RequestsAppBar], not a copy of its configuration.
///
/// This appbar was `expandedHeight: 120` behind a FlexibleSpaceBar, which
/// reserved about 64px of empty black above a one-word title. It also coloured
/// the title with `colorScheme.surface`, the page background token: near-white
/// on the near-black bar in light mode, but in dark mode surface and
/// inverseSurface are both dark and the title came out at 1.31:1 against its own
/// background.
void main() {
  Future<void> pumpBar(
    WidgetTester tester, {
    required ThemeData theme,
    double width = 390,
  }) async {
    await tester.binding.setSurfaceSize(Size(width, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        theme: theme,
        home: Scaffold(
          body: CustomScrollView(
            slivers: [
              RequestsAppBar(
                title: 'REQUESTS',
                actionLabel: 'NEW REQUEST',
                onActionPressed: () {},
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 600)),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> dispose(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 1));
  }

  testWidgets('reserves no height above the title', (tester) async {
    await pumpBar(tester, theme: BauhausDesign.lightTheme);

    // Where the title sits catches a FlexibleSpaceBar pushing it down. It does
    // not catch a bare expandedHeight, which adds empty space above without
    // moving the title, so the sliver's own extent is asserted too.
    final title = tester.getRect(find.text('REQUESTS'));
    expect(
      title.top,
      lessThan(BauhausDesign.appBarCompactHeight),
      reason:
          'the title must sit inside one toolbar, not at the bottom of a '
          'tall expanded bar',
    );
    expect(
      title.center.dy,
      closeTo(BauhausDesign.appBarCompactHeight / 2, 6),
      reason: 'the title should be vertically centred in the toolbar',
    );

    // The sliver reports its own extents; getRect cannot be used on a sliver.
    final sliver = tester.renderObject<RenderSliverPersistentHeader>(
      find.byType(SliverAppBar),
    );
    expect(
      sliver.maxExtent,
      lessThanOrEqualTo(BauhausDesign.appBarCompactHeight + 1),
      reason:
          'the bar is ${sliver.maxExtent} tall; anything above the toolbar '
          'height is empty space',
    );
    await dispose(tester);
  });

  testWidgets('renders the title on exactly one line', (tester) async {
    await pumpBar(tester, theme: BauhausDesign.lightTheme);
    final text = tester.widget<Text>(find.text('REQUESTS'));
    expect(text.maxLines, 1);
    expect(text.overflow, TextOverflow.ellipsis);
    await dispose(tester);
  });

  testWidgets('title is readable against the bar in light and dark', (
    tester,
  ) async {
    for (final (label, theme) in <(String, ThemeData)>[
      ('light', BauhausDesign.lightTheme),
      ('dark', BauhausDesign.darkTheme),
    ]) {
      await pumpBar(tester, theme: theme);

      final context = tester.element(find.text('REQUESTS'));
      final ink =
          tester.widget<Text>(find.text('REQUESTS')).style?.color ??
          Theme.of(context).colorScheme.onSurface;
      final bg = theme.colorScheme.inverseSurface;
      final ratio = _contrast(ink, bg);

      expect(
        ratio,
        greaterThanOrEqualTo(4.5),
        reason:
            '$label: title is only ${ratio.toStringAsFixed(2)}:1 against '
            'its own bar background',
      );
      await dispose(tester);
    }
  });

  testWidgets('the previous colour would have failed in dark mode', (
    tester,
  ) async {
    // Pins the regression numerically so the reason for onInverseSurface is not
    // lost when someone tidies this file.
    final bad = _contrast(
      BauhausDesign.darkTheme.colorScheme.surface,
      BauhausDesign.darkTheme.colorScheme.inverseSurface,
    );
    expect(
      bad,
      lessThan(4.5),
      reason:
          'colorScheme.surface on inverseSurface was ${bad.toStringAsFixed(2)}:1 '
          'in dark mode, which is why the title was unreadable',
    );
    await dispose(tester);
  });

  testWidgets('New Request keeps a label so the action is obvious', (
    tester,
  ) async {
    await pumpBar(tester, theme: BauhausDesign.lightTheme);
    expect(
      find.text('NEW REQUEST'),
      findsOneWidget,
      reason: 'a bare + icon does not explain the action',
    );
    expect(find.byIcon(Icons.add), findsOneWidget);
    await dispose(tester);
  });

  testWidgets('New Request is compact and does not overlap the title', (
    tester,
  ) async {
    for (final width in <double>[320, 390, 430]) {
      await pumpBar(tester, theme: BauhausDesign.lightTheme, width: width);

      expect(tester.takeException(), isNull);
      final title = tester.getRect(find.text('REQUESTS'));
      final button = tester.getRect(find.byType(BauhausActionButton));
      expect(
        button.left,
        greaterThan(title.right),
        reason: 'overlap at $width',
      );
      expect(button.right, lessThanOrEqualTo(width));
      expect(
        button.height,
        lessThanOrEqualTo(40),
        reason: 'should stay compact enough for a one-line toolbar',
      );
      await dispose(tester);
    }
  });
}

/// WCAG 2.1 relative luminance contrast ratio.
double _contrast(Color a, Color b) {
  double lum(Color c) {
    double f(double v) =>
        v <= 0.03928 ? v / 12.92 : math.pow((v + 0.055) / 1.055, 2.4) as double;
    return 0.2126 * f(c.r) + 0.7152 * f(c.g) + 0.0722 * f(c.b);
  }

  final l1 = lum(a), l2 = lum(b);
  final hi = l1 > l2 ? l1 : l2;
  final lo = l1 > l2 ? l2 : l1;
  return (hi + 0.05) / (lo + 0.05);
}
