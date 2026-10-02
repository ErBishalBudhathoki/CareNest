import 'dart:io';

import 'package:carenest/app/features/earnings/views/earnings_dashboard_view.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/contrast.dart';

/// Guards two typography and colour defects that were both invisible until
/// measured.
///
/// `headlineLarge` is 40px in this scale. Fourteen AppBar titles used it, plus
/// `fontWeight.bold` and 1.0 of letter spacing, which is why "Earnings
/// Dashboard" and "Training & Compliance" read as poster headlines. An AppBar
/// title is a label, not a display figure, so nothing above `titleLarge`
/// belongs there.
///
/// The earnings period toggle had a near-black track and near-black text on its
/// inactive half, so only the selected option was ever visible.
void main() {
  /// Tokens above titleLarge, which renders at 20px. `display*` and
  /// `headlineLarge` are for figures and page-scale moments, not chrome.
  const tooLargeForAnAppBar = <String>{
    'displayLarge',
    'displayMedium',
    'displaySmall',
    'headlineLarge',
    'headlineMedium',
  };

  List<File> dartSources() => Directory('lib/app')
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .where((f) => !f.path.endsWith('.g.dart'))
      .where((f) => !f.path.endsWith('.freezed.dart'))
      .toList();

  /// Index of the paren matching the one at [openIdx], skipping string bodies.
  int closingParen(String s, int openIdx) {
    var depth = 0;
    var i = openIdx;
    while (i < s.length) {
      final c = s[i];
      if (c == "'" || c == '"') {
        final q = c;
        i++;
        while (i < s.length && s[i] != q) {
          i += s[i] == r'\' ? 2 : 1;
        }
        i++;
        continue;
      }
      if (c == '(') depth++;
      if (c == ')') {
        depth--;
        if (depth == 0) return i;
      }
      i++;
    }
    throw StateError('unbalanced parentheses');
  }

  test('no AppBar title is set above titleLarge', () {
    final offenders = <String>[];
    for (final f in dartSources()) {
      final src = f.readAsStringSync();
      for (final m in RegExp(
        r'\bappBar:\s*(?:AppBar|BauhausAppBar)\(',
      ).allMatches(src)) {
        final open = m.end - 1;
        final close = closingParen(src, open);
        final block = src.substring(open, close);
        final title = RegExp(r'title:\s*Text\(').firstMatch(block);
        if (title == null) continue;
        // Only the Text() that is the title, not a later one in the same block.
        final tOpen = open + title.end - 1;
        final seg = src.substring(tOpen, closingParen(src, tOpen) + 1);
        for (final bad in tooLargeForAnAppBar) {
          if (seg.contains('.$bad')) {
            final line = src.substring(0, open).split('\n').length;
            offenders.add('${f.path}:$line uses $bad');
          }
        }
      }
    }
    expect(
      offenders,
      isEmpty,
      reason:
          'an AppBar title is a label and should use titleLarge or smaller:\n'
          '${offenders.join('\n')}',
    );
  });

  test('headlineLarge is not used as a list item or section title', () {
    // The four screens named as having oversized headings used it for list item
    // titles and section headers, which sit at titleMedium/titleLarge.
    final offenders = <String>[];
    // The whole training_compliance feature plus earnings. The admin screens
    // were not named but had the identical defect, including dialog titles at
    // 40px, and they are the same feature area.
    final screens = <String>[
      'features/earnings/views/earnings_dashboard_view.dart',
      ...Directory('lib/app/features/training_compliance/views')
          .listSync()
          .whereType<File>()
          .map((f) => f.path.replaceFirst('lib/app/', '')),
    ];
    for (final rel in screens) {
      final f = File('lib/app/$rel');
      if (!f.existsSync()) continue;
      final src = f.readAsStringSync();
      for (final m in RegExp(r'\.headlineLarge').allMatches(src)) {
        final line = src.substring(0, m.start).split('\n').length;
        offenders.add('$rel:$line');
      }
    }
    expect(
      offenders,
      isEmpty,
      reason:
          'these screens should size headings with titleMedium/titleLarge or '
          'headlineSmall:\n${offenders.join('\n')}',
    );
  });

  group('earnings period toggle', () {
    for (final entry in {
      'light': BauhausDesign.lightTheme.colorScheme,
      'dark': BauhausDesign.darkTheme.colorScheme,
    }.entries) {
      test('the inactive half is readable on the track in ${entry.key}', () {
        final off = resolveEarningsToggleColors(entry.value, false);
        // Transparent fill, so the track is what shows through behind it.
        expect(
          contrastRatio(off.label, off.track),
          greaterThanOrEqualTo(4.5),
          reason:
              'inactive label ${off.label} on track ${off.track} is '
              '${contrast(off.label, off.track)}:1 in ${entry.key}',
        );
      });

      test('the active half is readable on its own fill in ${entry.key}', () {
        final on = resolveEarningsToggleColors(entry.value, true);
        expect(
          contrastRatio(on.label, on.fill),
          greaterThanOrEqualTo(4.5),
          reason:
              'active label ${on.label} on fill ${on.fill} is '
              '${contrast(on.label, on.fill)}:1 in ${entry.key}',
        );
      });

      test('the two halves are distinguishable in ${entry.key}', () {
        final on = resolveEarningsToggleColors(entry.value, true);
        final off = resolveEarningsToggleColors(entry.value, false);
        // A selected half that looks identical to the unselected one is the
        // other half of "only the selected one is visible".
        expect(
          contrastRatio(on.fill, off.track),
          greaterThanOrEqualTo(3.0),
          reason:
              'active fill ${on.fill} against the track ${off.track} is only '
              '${contrast(on.fill, off.track)}:1 in ${entry.key}',
        );
      });
    }
  });

  test('onPrimary and onSurface are the same ink in light mode', () {
    // Recorded because it is the trap. The toggle track used to be onPrimary
    // while its inactive label used onSurface, and those two are identical here,
    // so the inactive option was invisible. A future theme change that separates
    // them would hide the cause of this bug rather than fix it, so the fact is
    // pinned and the assertion that matters is the contrast one above.
    final light = BauhausDesign.lightTheme.colorScheme;
    expect(light.onPrimary, light.onSurface);

    // The track must not be that ink, and the resolver is what guarantees it.
    for (final entry in {
      'light': BauhausDesign.lightTheme.colorScheme,
      'dark': BauhausDesign.darkTheme.colorScheme,
    }.entries) {
      final off = resolveEarningsToggleColors(entry.value, false);
      expect(
        off.track,
        isNot(off.label),
        reason:
            'in ${entry.key} the track and the inactive label must differ, '
            'otherwise the inactive option has no visible label',
      );
    }
  });
}
