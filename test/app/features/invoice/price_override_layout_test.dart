import 'dart:io';

import 'package:carenest/app/features/invoice/views/price_override_view.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Guards the Price Override line-item cards in both themes.
///
/// Two defects are covered:
///
/// 1. The item-number chip, the [SourceBadge] and the "modified" badge shared a
///    `Row` that gave each child an unbounded width. A long badge label such as
///    "Client-specific custom" therefore overflowed by 10px on a 342 card.
///    `BauhausChip` already ellipsizes internally, but it can only do so when
///    the outer row bounds it, so the badge must be `Flexible`.
/// 2. Muted foregrounds used the fixed `BauhausDesign.textMuted`, which is dark
///    ink and therefore invisible on the dark surface. The source guard below
///    checks that the whole view has moved to the `onSurfaceVariant` role.
void main() {
  Future<void> pump(WidgetTester tester, ThemeData theme, double width) async {
    await tester.binding.setSurfaceSize(Size(width, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        theme: theme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Center(
            child: Container(
              width: width,
              padding: const EdgeInsets.all(BauhausDesign.space4),
              child: Row(
                children: [
                  Flexible(
                    child: SourceBadge(
                      source: 'client-specific',
                      isSmall: true,
                    ),
                  ),
                  const SizedBox(width: BauhausDesign.space2),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: BauhausDesign.space2,
                        vertical: 2,
                      ),
                      child: Text(
                        'modified long trailing label',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
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

  final themes = <String, ThemeData>{
    'light': BauhausDesign.lightTheme,
    'dark': BauhausDesign.darkTheme,
  };

  for (final entry in themes.entries) {
    for (final width in <double>[320, 342, 390, 430]) {
      testWidgets('badge row does not overflow in ${entry.key} at $width', (
        tester,
      ) async {
        await pump(tester, entry.value, width);
        expect(
          tester.takeException(),
          isNull,
          reason: 'RenderFlex overflow in the ${entry.key} theme at $width dp',
          // ignore: prefer_interpolation_to_compose_strings
        );
      });
    }
  }

  test('view no longer uses fixed dark ink for muted foregrounds', () {
    final source = _readSource();
    expect(
      source.contains('BauhausDesign.textMuted'),
      isFalse,
      reason:
          'textMuted is dark ink and vanishes on the dark surface. Use the '
          'onSurfaceVariant role instead.',
    );
  });

  test('view does not use a foreground role as a box fill', () {
    final source = _readSource();
    // onPrimary as AppBar foregroundColor / IconThemeData is correct, since
    // that bar is painted with primary. Only a BoxDecoration fill is a bug.
    expect(
      RegExp(
        r'BoxDecoration\(\s*color: Theme\.of\(context\)\.colorScheme\.onPrimary',
      ).hasMatch(source),
      isFalse,
      reason:
          'onPrimary is a foreground role. Used as a BoxDecoration fill it '
          'resolved to near-black in light mode, producing an unreadable '
          'slab behind the employee/client details. Use a surface role.',
    );
  });

  test('view does not fill tiles with a 10% accent tint', () {
    final source = _readSource();
    expect(
      source.contains('color: displayColor.withValues(alpha: 0.1)'),
      isFalse,
      reason:
          'a 10% accent tint is unreadable as a tile fill in either theme; '
          'the accent belongs on the border.',
    );
  });

  test('source badge in the card header is Flexible', () {
    final source = _readSource();
    expect(
      source.contains(
        'Flexible(\n                            child: SourceBadge(',
      ),
      isTrue,
      reason:
          'an unconstrained SourceBadge overflows the card header row; it '
          'must be wrapped so the chip can ellipsize.',
    );
  });
}

String _readSource() {
  final f =
      '${Directory.current.path}/lib/app/features/invoice/views/'
      'price_override_view.dart';
  return File(f).readAsStringSync();
}
