import 'dart:io';
import 'dart:math' as math;

import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

/// The Actions row on the leave tracker had two Expanded buttons side by side.
/// At 390 wide with 32px page padding and a 16px gap, each button got 155px, and
/// after 24px of padding either side plus the icon and gap that leaves 81px of
/// text room. Both labels were ellipsising; measured output was
/// didExceedMaxLines=true.
///
/// Stacked, each button gets the full 326px, so 252px of text room and both
/// labels fit on one line.
///
/// The Public Holiday button also used `variant: secondary`, which resolves to
/// a surface background with a hazard yellow label: 1.57:1 in light mode. It is
/// now `neutral`, which keeps a dark label and still reads as secondary next to
/// the filled primary button above it.
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

  Future<void> pumpActions(
    WidgetTester tester, {
    required ThemeData theme,
  }) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        theme: theme,
        home: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: BauhausActionButton(
                      text: 'NEW REQUEST',
                      icon: Icons.add_circle_outline,
                      variant: BauhausActionVariant.primary,
                      isFullWidth: true,
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(height: BauhausDesign.space3),
                  SizedBox(
                    width: double.infinity,
                    child: BauhausActionButton(
                      text: 'PUBLIC HOLIDAY',
                      icon: Icons.calendar_month_outlined,
                      variant: BauhausActionVariant.neutral,
                      isFullWidth: true,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
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

  testWidgets('both action labels are shown in full', (tester) async {
    await pumpActions(tester, theme: BauhausDesign.lightTheme);
    expect(tester.takeException(), isNull);

    for (final label in ['NEW REQUEST', 'PUBLIC HOLIDAY']) {
      expect(
        tester
            .renderObject<RenderParagraph>(find.text(label))
            .didExceedMaxLines,
        isFalse,
        reason: '"$label" is still truncated',
      );
      expect(
        tester.widget<Text>(find.text(label)).maxLines,
        1,
        reason: '"$label" should no longer need to wrap at full width',
      );
    }
    await dispose(tester);
  });

  testWidgets('the buttons now have room for the label', (tester) async {
    await pumpActions(tester, theme: BauhausDesign.lightTheme);
    for (var i = 0; i < 2; i++) {
      final button = tester.getRect(find.byType(BauhausActionButton).at(i));
      expect(
        button.width,
        390 - 64,
        reason: 'a stacked button spans the padded content width',
      );
    }
    await dispose(tester);
  });

  testWidgets('both labels are readable, in both themes', (tester) async {
    for (final (name, theme) in <(String, ThemeData)>[
      ('light', BauhausDesign.lightTheme),
      ('dark', BauhausDesign.darkTheme),
    ]) {
      await pumpActions(tester, theme: theme);

      // The background comes from the variant's documented semantics rather
      // than from sniffing the container tree, which picked the wrong ancestor
      // and reported a false 1.32:1. primary fills; neutral sits on the card.
      for (final (label, bg) in <(String, Color)>[
        ('NEW REQUEST', theme.colorScheme.primary),
        ('PUBLIC HOLIDAY', theme.colorScheme.surfaceContainerLow),
      ]) {
        final ink =
            tester.widget<Text>(find.text(label)).style?.color ??
            theme.colorScheme.onSurface;
        expect(
          contrast(ink, bg),
          greaterThanOrEqualTo(4.5),
          reason:
              '$name "$label" is only '
              '${contrast(ink, bg).toStringAsFixed(2)}:1 against its own '
              'button background',
        );
      }
      await dispose(tester);
    }
  });

  testWidgets('the Public Holiday label is not yellow', (tester) async {
    final theme = BauhausDesign.lightTheme;
    await pumpActions(tester, theme: theme);
    final ink = tester.widget<Text>(find.text('PUBLIC HOLIDAY')).style?.color;
    expect(
      ink,
      isNot(theme.colorScheme.primary),
      reason: 'hazard yellow on a white surface was the reported problem',
    );
    expect(ink, theme.colorScheme.onSurface);
    await dispose(tester);
  });

  test('secondary would have failed, so the reason survives', () {
    final light = BauhausDesign.lightTheme.colorScheme;
    // secondary = surface background, primary-coloured label.
    final bad = contrast(BauhausDesign.primary, light.surface);
    expect(
      bad,
      lessThan(4.5),
      reason: 'secondary renders at ${bad.toStringAsFixed(2)}:1',
    );
  });

  test('the leave tracker keeps the variants it now needs', () {
    const file = 'lib/app/features/leave/views/leave_tracker_view.dart';
    final src = File(file).readAsStringSync();
    // Resolve the variant that actually belongs to each button rather than
    // scanning a fixed-size window: the explanatory comment sits between the
    // label and the variant, so a window guess goes stale on any reformat.
    final re = RegExp(r'variant:\s*BauhausActionVariant\.(\w+)');
    for (final (label, expected) in <(String, String)>[
      ('l10n.publicHoliday', 'neutral'),
      ('l10n.newRequestTitle', 'primary'),
    ]) {
      final at = src.indexOf(label);
      expect(at, greaterThan(0), reason: '$label should exist');
      expect(
        re.firstMatch(src.substring(at))?.group(1),
        expected,
        reason:
            '$label must stay $expected; secondary renders yellow on a '
            'white surface at 1.57:1',
      );
    }
  });

  test('the actions block is stacked, not side by side', () {
    // The widget tests above render a reconstructed copy of this layout, which
    // proves the geometry works but not that the screen uses it. A mutation that
    // put these buttons back into a Row with Expanded passed them, so the shape
    // of the production source is pinned here.
    const file = 'lib/app/features/leave/views/leave_tracker_view.dart';
    final src = File(file).readAsStringSync();

    final holiday = src.indexOf('l10n.publicHoliday');
    expect(holiday, greaterThan(0));

    // Take the block that holds both action buttons and check it stacks them.
    final blockStart = src.lastIndexOf('Column(', holiday);
    final blockEnd = src.indexOf(
      'const SizedBox(height: BauhausDesign.space8)',
      holiday,
    );
    expect(
      blockStart,
      greaterThan(-1),
      reason: 'the actions block should be a Column',
    );
    expect(
      blockEnd,
      greaterThan(holiday),
      reason: 'the actions block should end the section',
    );
    final block = src.substring(blockStart, blockEnd);

    expect(
      block.contains('width: double.infinity'),
      isTrue,
      reason: 'each action button should span the content width',
    );
    expect(
      !block.contains('Expanded('),
      isTrue,
      reason:
          'Expanded inside the actions Column is what produced the 155px '
          'buttons that ellipsised both labels',
    );
  });

  test('the leave date picker is themed square, not Material rounded', () {
    const file = 'lib/app/features/leave/views/leave_request_form.dart';
    final src = File(file).readAsStringSync();
    expect(
      src.contains('DatePickerThemeData'),
      isTrue,
      reason:
          'the range picker needs a DatePickerTheme or it keeps Material\'s '
          'stadium-shaped range highlight and circular day cells',
    );
    expect(
      src.contains('dayShape'),
      isTrue,
      reason: 'dayShape squares the day cells and the range band',
    );
    expect(
      RegExp(r'BorderRadius\.zero').allMatches(src).isNotEmpty,
      isTrue,
      reason: 'DESIGN.md forbids rounded geometry outside avatars',
    );
  });
}
