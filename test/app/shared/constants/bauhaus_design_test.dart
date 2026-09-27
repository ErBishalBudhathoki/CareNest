import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/constants/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

const _black = Color(0xFF000000);
const _parchment = Color(0xFFFFF9E6);
const _paper = Color(0xFFFFFCF5);
const _yellow = Color(0xFFFFC300);
const _teal = Color(0xFF028090);
const _red = Color(0xFFE63946);
const _blue = Color(0xFF1D4ED8);

void main() {
  late void Function(String?, {int? wrapWidth}) originalDebugPrint;
  late bool originalAllowRuntimeFetching;

  setUpAll(() {
    originalDebugPrint = debugPrint;
    originalAllowRuntimeFetching = GoogleFonts.config.allowRuntimeFetching;
    debugPrint = (message, {wrapWidth}) {};
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  tearDownAll(() {
    debugPrint = originalDebugPrint;
    GoogleFonts.config.allowRuntimeFetching = originalAllowRuntimeFetching;
  });

  group('canonical palette', () {
    test('uses the exact core and semantic colors', () {
      expect(BauhausDesign.primary, _yellow);
      expect(BauhausDesign.secondary, _teal);
      expect(BauhausDesign.tertiary, _red);
      expect(BauhausDesign.accent, _red);
      expect(BauhausDesign.error, _red);
      expect(BauhausDesign.success, _teal);
      expect(BauhausDesign.warning, _yellow);
      expect(BauhausDesign.info, _blue);
      expect(BauhausDesign.primaryBlue, _blue);
      expect(BauhausDesign.neutral, const Color(0xFF1A1A1A));
      expect(BauhausDesign.neoInk, _black);
      expect(BauhausDesign.background, _parchment);
      expect(BauhausDesign.backgroundLight, _parchment);
      expect(BauhausDesign.surfaceWhite, _paper);
      expect(BauhausDesign.surfaceLight, _paper);
      expect(BauhausDesign.surfaceVariant, const Color(0xFFF8EED6));
    });

    test('uses the exact spacing scale', () {
      expect(BauhausDesign.space1, 4);
      expect(BauhausDesign.space2, 8);
      expect(BauhausDesign.space4, 16);
      expect(BauhausDesign.space6, 24);
      expect(BauhausDesign.space10, 40);
    });
  });

  group('canonical typography', () {
    test('uses Bricolage Grotesque for display, headline, and title', () {
      final textTheme = BauhausDesign.lightTextTheme;

      _expectStyle(
        textTheme.displayLarge,
        'BricolageGrotesque',
        56,
        FontWeight.w800,
      );
      _expectStyle(
        textTheme.displayMedium,
        'BricolageGrotesque',
        36,
        FontWeight.w800,
      );
      _expectStyle(
        textTheme.displaySmall,
        'BricolageGrotesque',
        28,
        FontWeight.w700,
      );
      _expectStyle(
        textTheme.headlineLarge,
        'BricolageGrotesque',
        40,
        FontWeight.w700,
      );
      _expectStyle(
        textTheme.headlineMedium,
        'BricolageGrotesque',
        28,
        FontWeight.w700,
      );
      _expectStyle(
        textTheme.headlineSmall,
        'BricolageGrotesque',
        20,
        FontWeight.w700,
      );
      _expectStyle(
        textTheme.titleLarge,
        'BricolageGrotesque',
        20,
        FontWeight.w700,
      );
      _expectStyle(
        textTheme.titleMedium,
        'BricolageGrotesque',
        16,
        FontWeight.w700,
      );
      _expectStyle(
        textTheme.titleSmall,
        'BricolageGrotesque',
        14,
        FontWeight.w700,
      );
    });

    test('uses Space Mono for body and labels', () {
      final textTheme = BauhausDesign.lightTextTheme;

      _expectStyle(textTheme.bodyLarge, 'SpaceMono', 16, FontWeight.w400);
      _expectStyle(textTheme.bodyMedium, 'SpaceMono', 14, FontWeight.w400);
      _expectStyle(textTheme.bodySmall, 'SpaceMono', 12, FontWeight.w400);
      _expectStyle(textTheme.labelLarge, 'SpaceMono', 13, FontWeight.w700);
      _expectStyle(textTheme.labelMedium, 'SpaceMono', 12, FontWeight.w700);
      _expectStyle(textTheme.labelSmall, 'SpaceMono', 11, FontWeight.w700);
    });
  });

  testWidgets('uses cream body text on dark surfaces', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: BauhausDesign.darkTheme,
        home: Builder(
          builder: (context) => Text(
            'Dark surface',
            style: BauhausDesign.getTextTheme(context).bodyMedium,
          ),
        ),
      ),
    );

    final text = tester.widget<Text>(find.text('Dark surface'));
    expect(text.style?.color, BauhausDesign.textLight);
    debugPrint = originalDebugPrint;
  });

  group('canonical geometry', () {
    test('keeps every radius at zero', () {
      expect(BauhausDesign.radiusXs, 0);
      expect(BauhausDesign.radiusSm, 0);
      expect(BauhausDesign.radiusMd, 0);
      expect(BauhausDesign.radiusLg, 0);
      expect(BauhausDesign.radiusXl, 0);
      expect(BauhausDesign.radiusFull, 0);
      expect(BauhausDesign.radiusPill, 0);
      // cardDecorationFor / chipDecorationFor / inputDecoration are now
      // context-aware, so their zero-radius geometry is asserted in the
      // "card and chip decorations follow the active theme" widget test.
    });

    test('uses opaque zero-blur hard shadows', () {
      final shadows = <BoxShadow>[
        BauhausDesign.shadowHard,
        BauhausDesign.shadowHardSm,
        BauhausDesign.shadowHardXs,
        BauhausDesign.shadowHardLg,
        BauhausDesign.shadowSoft,
        BauhausDesign.shadowNeoCard,
        BauhausDesign.shadowNeoButton,
        ...BauhausDesign.shadowSm,
      ];

      for (final shadow in shadows) {
        expect(shadow.color, _black);
        expect(shadow.blurRadius, 0);
        expect(shadow.spreadRadius, 0);
      }
    });

    test('uses structural 2px and 2.5px borders', () {
      expect(BauhausDesign.borderThin, 2);
      expect(BauhausDesign.borderThick, 2.5);
      expect(BauhausDesign.neoBorderWidth, 2.5);
      expect(BauhausDesign.neoCardDecoration().border?.top.width, 2.5);
    });
  });

  group('complete ThemeData', () {
    test('defines light semantic roles and hard-edged components', () {
      final theme = BauhausDesign.lightTheme;

      _expectTheme(
        theme,
        Brightness.light,
        _parchment,
        _paper,
        BauhausDesign.textDark,
      );
      _expectComponentThemes(theme);
      expect(theme.appBarTheme.shadowColor, _black);
      expect(theme.cardTheme.elevation, 0);
      expect(theme.floatingActionButtonTheme.elevation, 0);
      expect(theme.navigationBarTheme.elevation, 0);
      expect(theme.navigationRailTheme.elevation, 0);
      expect(theme.snackBarTheme.elevation, 0);
      expect(theme.progressIndicatorTheme.borderRadius, BorderRadius.zero);
    });

    test('defines dark semantic roles and hard-edged components', () {
      final theme = BauhausDesign.darkTheme;

      _expectTheme(
        theme,
        Brightness.dark,
        BauhausDesign.backgroundDark,
        BauhausDesign.surfaceDark,
        BauhausDesign.textLight,
      );
      _expectComponentThemes(theme);
      expect(theme.appBarTheme.shadowColor, _black);
      expect(theme.cardTheme.elevation, 0);
      expect(theme.floatingActionButtonTheme.elevation, 0);
      expect(theme.navigationBarTheme.elevation, 0);
      expect(theme.navigationRailTheme.elevation, 0);
      expect(theme.snackBarTheme.elevation, 0);
      expect(theme.progressIndicatorTheme.borderRadius, BorderRadius.zero);
    });

    test('dark surface roles never resolve to black', () {
      final dark = BauhausDesign.darkTheme.colorScheme;

      // Every "on*" role paired with a dark plane must be light ink, otherwise
      // text disappears into the surface in dark mode.
      final onRoles = <String, Color>{
        'onSurface': dark.onSurface,
        'onSurfaceVariant': dark.onSurfaceVariant,
        'onInverseSurface': dark.onInverseSurface,
        'onSecondary': dark.onSecondary,
        'onSecondaryContainer': dark.onSecondaryContainer,
      };
      onRoles.forEach((role, color) {
        expect(
          color.computeLuminance(),
          greaterThan(0.5),
          reason: '$role must be light ink in dark mode',
        );
      });

      // inverseSurface is used as a header plane by app bars and snack bars, so
      // it must stay dark in dark mode and pair with light text.
      expect(dark.inverseSurface, BauhausDesign.surfaceDarkest);
      expect(dark.onInverseSurface, BauhausDesign.textLight);
    });

    test('dark snack bar keeps light text on a dark plane', () {
      final snack = BauhausDesign.darkTheme.snackBarTheme;

      expect(snack.backgroundColor, BauhausDesign.surfaceDarkest);
      expect(
        snack.contentTextStyle?.color?.computeLuminance(),
        greaterThan(0.5),
      );
      expect(snack.actionTextColor, BauhausDesign.primary);
    });

    test('readableOnColor picks ink or paper by luminance', () {
      // Light planes take ink, dark planes take paper, independent of theme.
      expect(BauhausDesign.readableOnColor(_yellow), BauhausDesign.textDark);
      expect(BauhausDesign.readableOnColor(_teal), BauhausDesign.textLight);
      expect(BauhausDesign.readableOnColor(_red), BauhausDesign.textLight);
      expect(
        BauhausDesign.readableOnColor(BauhausDesign.surfaceDark),
        BauhausDesign.textLight,
      );
      expect(
        BauhausDesign.readableOnColor(BauhausDesign.surfaceWhite),
        BauhausDesign.textDark,
      );
    });

    testWidgets('input decoration follows the active theme', (tester) async {
      Future<InputDecoration> resolve(ThemeData theme) async {
        late InputDecoration result;
        await tester.pumpWidget(
          MaterialApp(
            theme: theme,
            home: Builder(
              builder: (context) {
                result = BauhausDesign.inputDecorationFor(context);
                return const SizedBox.shrink();
              },
            ),
          ),
        );
        // MaterialApp animates theme changes, so let it settle before reading.
        await tester.pumpAndSettle();
        return result;
      }

      final light = await resolve(BauhausDesign.lightTheme);
      final dark = await resolve(BauhausDesign.darkTheme);

      // The fill must be the themed surface, never a hardcoded light plane.
      expect(light.fillColor, BauhausDesign.lightTheme.colorScheme.surface);
      expect(dark.fillColor, BauhausDesign.darkTheme.colorScheme.surface);
      expect(dark.fillColor, isNot(_paper));

      // Label/hint/icon text must be legible against that fill.
      expect(dark.labelStyle?.color?.computeLuminance(), greaterThan(0.5));
      expect(dark.hintStyle?.color?.computeLuminance(), greaterThan(0.5));
      expect(dark.prefixIconColor?.computeLuminance(), greaterThan(0.5));

      // Zero radius preserved in both themes.
      for (final decoration in [light, dark]) {
        final enabled = decoration.enabledBorder! as OutlineInputBorder;
        expect(enabled.borderRadius, BorderRadius.zero);
        expect(enabled.borderSide.width, BauhausDesign.borderThick);
      }
    });

    testWidgets('card and chip decorations follow the active theme', (
      tester,
    ) async {
      Future<({BoxDecoration card, BoxDecoration chip})> resolve(
        ThemeData theme,
      ) async {
        late BoxDecoration card;
        late BoxDecoration chip;
        await tester.pumpWidget(
          MaterialApp(
            theme: theme,
            home: Builder(
              builder: (context) {
                card = BauhausDesign.cardDecorationFor(context);
                chip = BauhausDesign.chipDecorationFor(context);
                return const SizedBox.shrink();
              },
            ),
          ),
        );
        await tester.pumpAndSettle();
        return (card: card, chip: chip);
      }

      final light = await resolve(BauhausDesign.lightTheme);
      final dark = await resolve(BauhausDesign.darkTheme);

      // Neither helper may fall back to a hardcoded light plane.
      expect(light.card.color, BauhausDesign.lightTheme.colorScheme.surface);
      expect(dark.card.color, BauhausDesign.darkTheme.colorScheme.surface);
      expect(dark.card.color, isNot(_paper));
      expect(dark.chip.color, BauhausDesign.darkTheme.colorScheme.surface);
      expect(dark.chip.color, isNot(_paper));

      // Dark card border must be visible against the dark fill.
      final darkBorder = dark.card.border! as Border;
      expect(
        darkBorder.top.color.computeLuminance(),
        greaterThan(0.5),
        reason: 'dark card border must not be black-on-black',
      );

      // Zero radius + hard shadow preserved in both themes.
      for (final decoration in [light.card, dark.card, light.chip, dark.chip]) {
        expect(decoration.borderRadius, BorderRadius.zero);
      }
      expect(light.card.boxShadow, isNotEmpty);
      expect(dark.card.boxShadow, isNotEmpty);
    });

    testWidgets('inputDecoration applies the hint on the themed base', (
      tester,
    ) async {
      late InputDecoration lightDec;
      late InputDecoration darkDec;

      Future<void> pump(
        ThemeData theme,
        void Function(InputDecoration) sink,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: theme,
            home: Builder(
              builder: (context) {
                sink(BauhausDesign.inputDecoration(context, 'Search…'));
                return const SizedBox.shrink();
              },
            ),
          ),
        );
        await tester.pumpAndSettle();
      }

      await pump(BauhausDesign.lightTheme, (d) => lightDec = d);
      await pump(BauhausDesign.darkTheme, (d) => darkDec = d);

      expect(lightDec.hintText, 'Search…');
      expect(darkDec.hintText, 'Search…');
      expect(darkDec.fillColor, BauhausDesign.darkTheme.colorScheme.surface);
      expect(darkDec.fillColor, isNot(_paper));
    });

    test('keeps AppTheme aliases on the canonical theme', () {
      expect(
        AppTheme.lightTheme.colorScheme,
        BauhausDesign.lightTheme.colorScheme,
      );
      expect(
        AppTheme.darkTheme.colorScheme,
        BauhausDesign.darkTheme.colorScheme,
      );
      expect(
        AppTheme.themeData.colorScheme,
        BauhausDesign.lightTheme.colorScheme,
      );
      expect(
        AppTheme().defaultPinTheme.decoration?.borderRadius,
        BorderRadius.zero,
      );
    });
  });
}

void _expectStyle(
  TextStyle? style,
  String family,
  double size,
  FontWeight weight,
) {
  expect(style, isNotNull);
  expect(style!.fontFamily, startsWith(family));
  expect(style.fontSize, size);
  expect(style.fontWeight, weight);
}

void _expectTheme(
  ThemeData theme,
  Brightness brightness,
  Color background,
  Color surface,
  Color onSurface,
) {
  expect(theme.brightness, brightness);
  expect(theme.colorScheme.brightness, brightness);
  expect(theme.colorScheme.primary, _yellow);
  expect(theme.colorScheme.secondary, _teal);
  expect(theme.colorScheme.tertiary, _red);
  expect(theme.colorScheme.error, _red);
  expect(theme.colorScheme.surface, surface);
  expect(theme.colorScheme.onSurface, onSurface);
  expect(theme.colorScheme.outline, _black);
  expect(theme.scaffoldBackgroundColor, background);
  expect(theme.canvasColor, background);
}

void _expectComponentThemes(ThemeData theme) {
  final buttonShape =
      theme.elevatedButtonTheme.style?.shape?.resolve({})!
          as RoundedRectangleBorder;
  final iconFocusSide = theme.iconButtonTheme.style?.side?.resolve({
    WidgetState.focused,
  });

  expect(buttonShape.borderRadius, BorderRadius.zero);
  expect(iconFocusSide?.color, _blue);
  expect(iconFocusSide?.width, 2.5);
  expect(
    (theme.inputDecorationTheme.enabledBorder! as OutlineInputBorder)
        .borderRadius,
    BorderRadius.zero,
  );
  expect(
    (theme.cardTheme.shape! as RoundedRectangleBorder).borderRadius,
    BorderRadius.zero,
  );
  expect(
    (theme.chipTheme.shape! as RoundedRectangleBorder).borderRadius,
    BorderRadius.zero,
  );
  expect(
    (theme.floatingActionButtonTheme.shape! as RoundedRectangleBorder)
        .borderRadius,
    BorderRadius.zero,
  );
  expect(
    (theme.dialogTheme.shape! as RoundedRectangleBorder).borderRadius,
    BorderRadius.zero,
  );
  expect(
    (theme.menuTheme.style!.shape!.resolve({}) as RoundedRectangleBorder)
        .borderRadius,
    BorderRadius.zero,
  );
  expect(
    (theme.navigationBarTheme.indicatorShape! as RoundedRectangleBorder)
        .borderRadius,
    BorderRadius.zero,
  );
  expect(
    (theme.navigationRailTheme.indicatorShape! as RoundedRectangleBorder)
        .borderRadius,
    BorderRadius.zero,
  );
  expect(
    (theme.tooltipTheme.decoration! as BoxDecoration).borderRadius,
    BorderRadius.zero,
  );
  expect(
    (theme.listTileTheme.shape! as RoundedRectangleBorder).borderRadius,
    BorderRadius.zero,
  );
  expect(theme.textSelectionTheme.cursorColor, _yellow);
  expect(theme.textSelectionTheme.selectionHandleColor, _yellow);
}
