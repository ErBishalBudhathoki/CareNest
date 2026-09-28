import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Enforces the shape rules in DESIGN.md.
///
/// DESIGN.md, "Shapes":
///
/// > Geometry is strictly sharp (`roundedness: 0`).
/// > Corners are unrounded (`0px`) across all cards, badges, buttons, progress
/// > tracks, and layout segments. The only permissible circular geometry
/// > (`rounded-full`) is reserved for minute functional terminal indicators.
///
/// Two things make this easy to break by accident:
///
/// 1. `BauhausDesign.radiusXs/sm/md/lg/xl/full/pill` are all `0.0`, so
///    `BorderRadius.circular(BauhausDesign.radiusMd)` looks like a rounded
///    corner at the call site but renders sharp. That is fine. What breaks the
///    rule is a non-zero **literal** radius, or a Material widget that defaults
///    to a pill/stadium shape and is not overridden by the theme.
/// 2. The theme already forces `BorderRadius.zero` on `cardTheme`, `chipTheme`
///    and `dialogTheme`, so bare `Card(` and `Chip(` are sharp by inheritance.
///    They do not need checking; `Switch` and `Switch.adaptive` are not themed
///    that way and are always pills.
///
/// The file list below is the migration scope that has already been reviewed.
/// Extend it as further screens are converted; see the counts in the
/// non-scoped test at the end for the remaining app-wide debt.
const _scopedFiles = <String>[
  'lib/app/features/invoice/views/price_override_view.dart',
  'lib/app/features/pricing/views/pricing_configuration_view.dart',
  'lib/app/features/pricing/views/ndis_pricing_management_view.dart',
  'lib/app/shared/widgets/bauhaus_switch.dart',
  'lib/app/shared/widgets/bauhaus_widgets.dart',
  'lib/app/shared/constants/bauhaus_design.dart',
];

/// Material widgets that render a pill or stadium shape unless the theme
/// overrides them. `cardTheme` and `chipTheme` are already sharp in
/// BauhausDesign, so `Card(` and `Chip(` are deliberately absent.
///
/// The negative lookbehind matters: `BauhausSwitch(` is the compliant widget
/// and would otherwise match a plain `Switch(` substring search.
final _unthemedPillWidget = RegExp(r'(?<!Bauhaus)\bSwitch(\.adaptive)?\(');

/// A non-zero literal radius. Catches `BorderRadius.circular(8)` but not
/// `BorderRadius.circular(BauhausDesign.radiusMd)`, which is 0.0.
final _literalRadius = RegExp(r'BorderRadius\.circular\(\s*[1-9][0-9]*');

/// Strips whole-line `//` comments so a comment mentioning a widget does not
/// trip the guard.
String _codeOf(String source) =>
    source.split('\n').where((l) => !l.trimLeft().startsWith('//')).join('\n');

String _read(String path) {
  final f = File('${Directory.current.path}/$path');
  expect(f.existsSync(), isTrue, reason: '$path must exist');
  return f.readAsStringSync();
}

void main() {
  group('DESIGN.md shape rules in migrated screens', () {
    for (final path in _scopedFiles) {
      test('$path has no non-zero corner radius', () {
        final matches = _literalRadius.allMatches(_read(path)).toList();
        expect(
          matches,
          isEmpty,
          reason:
              'DESIGN.md requires roundedness 0. Non-zero literal radii at '
              'offsets ${matches.map((m) => m.start).toList()}. Use '
              'BauhausDesign.radius* (all 0.0) or BorderRadius.zero.',
        );
      });

      test('$path uses no unthemed pill widget', () {
        expect(
          _unthemedPillWidget.hasMatch(_codeOf(_read(path))),
          isFalse,
          reason:
              'Material Switch renders a pill shape with a circular thumb '
              'and is not overridden by the theme. Use BauhausSwitch.',
        );
      });
    }
  });

  test('the whole app has no unthemed pill switch left', () {
    final offenders = <String>[];
    for (final f
        in Directory('${Directory.current.path}/lib')
            .listSync(recursive: true)
            .whereType<File>()
            .where((f) => f.path.endsWith('.dart'))
            .where((f) => !f.path.contains('.g.dart'))) {
      if (_unthemedPillWidget.hasMatch(_codeOf(f.readAsStringSync()))) {
        offenders.add(f.path.replaceFirst('${Directory.current.path}/', ''));
      }
    }
    expect(
      offenders,
      isEmpty,
      reason:
          'Material Switch renders a pill with a circular thumb, which '
          'DESIGN.md forbids. Replace with BauhausSwitch:\n'
          '${offenders.join('\n')}',
    );
  });
}
