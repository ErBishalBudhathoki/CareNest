import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

/// Guards a real regression: `BauhausActionButton(isOutlined: true)` silently
/// overrides `backgroundColor` with `colorScheme.surface`, so passing a
/// `textColor` equal to `surface` produced an invisible (surface-on-surface)
/// button in light mode.
void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  Future<Color?> labelColorOf(WidgetTester tester, ThemeData theme) async {
    late Color? color;
    await tester.pumpWidget(
      MaterialApp(
        theme: theme,
        home: Scaffold(
          body: Builder(
            builder: (context) => Center(
              child: BauhausActionButton(
                text: 'CANCEL',
                isOutlined: true,
                onPressed: () {},
                textColor: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final texts = tester.widgetList<Text>(find.text('CANCEL'));
    color = texts.first.style?.color;
    return color;
  }

  testWidgets('outlined action button label is readable in both themes', (
    tester,
  ) async {
    final light = await labelColorOf(tester, BauhausDesign.lightTheme);
    final dark = await labelColorOf(tester, BauhausDesign.darkTheme);

    // Light: dark ink on the light surface fill.
    expect(light, BauhausDesign.lightTheme.colorScheme.onSurface);
    expect(
      light!.computeLuminance(),
      lessThan(0.2),
      reason: 'light-theme outlined label must be dark ink',
    );

    // Dark: cream ink on the dark surface fill.
    expect(dark, BauhausDesign.darkTheme.colorScheme.onSurface);
    expect(
      dark!.computeLuminance(),
      greaterThan(0.5),
      reason: 'dark-theme outlined label must be light ink',
    );
  });

  testWidgets('outlined action button fill is the themed surface', (
    tester,
  ) async {
    for (final theme in [BauhausDesign.lightTheme, BauhausDesign.darkTheme]) {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: Builder(
              builder: (context) => Center(
                child: BauhausActionButton(
                  text: 'CANCEL',
                  isOutlined: true,
                  onPressed: () {},
                  textColor: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final container = tester
          .widgetList<Container>(find.byType(Container))
          .firstWhere((c) => c.decoration is BoxDecoration);
      final decoration = container.decoration! as BoxDecoration;

      expect(
        decoration.color,
        theme.colorScheme.surface,
        reason: 'isOutlined forces the fill to colorScheme.surface',
      );
      // The label must never match the fill it sits on.
      expect(
        decoration.color,
        isNot(
          Theme.of(tester.element(find.byType(Scaffold))).colorScheme.onSurface,
        ),
      );
    }
  });
}
