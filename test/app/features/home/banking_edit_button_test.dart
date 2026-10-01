import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The Edit control on the employee dashboard's Banking & Payouts card was
/// `BauhausActionVariant.ghost` with `isOutlined: true`.
///
/// That combination cannot work. BauhausActionButton handles ghost with an
/// early return that builds a bare `TextButton`, and that return happens before
/// `isOutlined` is ever consulted. So the flag was silently dropped and the
/// control rendered as a full-width centred label with no border, no fill and
/// Material's default padding. It did not read as a button at all.
///
/// The card also double-padded itself: BauhausCard pads by space4, and the
/// body added another 20 on top, putting content 36px in while the header strip
/// sat at 32px.
void main() {
  Future<void> pump(
    WidgetTester tester,
    BauhausActionVariant variant, {
    required bool isOutlined,
  }) async {
    await tester.binding.setSurfaceSize(const Size(390, 300));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        theme: BauhausDesign.lightTheme,
        home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: BauhausActionButton(
                variant: variant,
                isOutlined: isOutlined,
                isFullWidth: true,
                icon: Icons.edit,
                text: 'EDIT',
                onPressed: () {},
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> dispose(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 1));
  }

  /// Counts the uniform borders, opaque fills and shadows in the rendered tree.
  (int borders, int fills, int shadows, double borderWidth, Color? borderColor)
  chromeOf(WidgetTester tester) {
    var borders = 0, fills = 0, shadows = 0;
    double width = 0;
    Color? colour;
    for (final e in find.byType(DecoratedBox).evaluate()) {
      final d = (e.widget as DecoratedBox).decoration;
      if (d is! BoxDecoration) continue;
      final b = d.border;
      if (b != null && b.isUniform && b.top.width > 0) {
        borders++;
        width = b.top.width;
        colour = b.top.color;
      }
      if (d.boxShadow != null && d.boxShadow!.isNotEmpty) shadows++;
      if (d.color != null && d.color != Colors.transparent) fills++;
    }
    return (borders, fills, shadows, width, colour);
  }

  testWidgets('an outlined ghost renders no button chrome at all', (
    tester,
  ) async {
    // Kept as documentation of the trap: ghost ignores isOutlined.
    await pump(tester, BauhausActionVariant.ghost, isOutlined: true);
    final chrome = chromeOf(tester);
    expect(chrome.$1, 0, reason: 'ghost does not draw a border');
    expect(chrome.$2, 0, reason: 'ghost does not fill');
    expect(find.byType(TextButton), findsOneWidget);
    await dispose(tester);
  });

  testWidgets('the Edit control variant draws a visible bordered box', (
    tester,
  ) async {
    // This is what the banking card uses.
    await pump(tester, BauhausActionVariant.secondary, isOutlined: true);
    final chrome = chromeOf(tester);

    expect(
      chrome.$1,
      greaterThan(0),
      reason: 'the control must draw a border or it does not read as a button',
    );
    expect(
      chrome.$2,
      greaterThan(0),
      reason: 'an outlined button needs a surface fill behind the label',
    );
    expect(find.byType(TextButton), findsNothing);

    // 2.5px is the Bauhaus border weight used across the design system.
    expect(chrome.$4, 2.5);
    expect(chrome.$5, isNotNull);
    await dispose(tester);
  });

  testWidgets('the button fills the width it is given', (tester) async {
    await pump(tester, BauhausActionVariant.secondary, isOutlined: true);
    final button = tester.getRect(find.byType(BauhausActionButton));
    expect(button.width, 390 - 32, reason: 'should fill the padded width');
    await dispose(tester);
  });

  testWidgets('the label is centred in the button', (tester) async {
    await pump(tester, BauhausActionVariant.secondary, isOutlined: true);
    final button = tester.getRect(find.byType(BauhausActionButton));
    final label = tester.getRect(find.text('EDIT'));
    final leftGap = label.left - button.left;
    final rightGap = button.right - label.right;
    // The icon sits to the left of the label, so the label is offset right of
    // true centre; what matters is that the pair is balanced, not centred alone.
    expect(leftGap - rightGap, lessThan(label.width));
    await dispose(tester);
  });

  testWidgets('the control meets a comfortable tap target', (tester) async {
    await pump(tester, BauhausActionVariant.secondary, isOutlined: true);
    final button = tester.getRect(find.byType(BauhausActionButton));
    expect(button.height, greaterThanOrEqualTo(44));
    expect(button.width, greaterThanOrEqualTo(44));
    await dispose(tester);
  });
}
