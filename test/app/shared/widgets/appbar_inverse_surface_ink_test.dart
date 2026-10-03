import 'dart:io';

import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/contrast.dart';

/// An AppBar painted with `inverseSurface` must be inked with `onInverseSurface`.
///
/// The Client Feedback admin screen titled its bar with `colorScheme.surface`,
/// which is #313030 in dark mode against an #1c1b1b bar: 1.31:1, dark grey on
/// near-black. The same mistake was in eight other AppBars, and six of those
/// also inked the leading icon with a token that fails in one mode or the other,
/// leaving an invisible back arrow.
///
/// The reason this is worth a scan: the two plausible alternative inks each
/// break in exactly one brightness mode, and in opposite ones.
void main() {
  List<File> dartSources() => Directory('lib/app')
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .where((f) => !f.path.endsWith('.g.dart'))
      .where((f) => !f.path.endsWith('.freezed.dart'))
      .toList();

  /// The body of the call whose '(' is at [open], or null if it cannot be
  /// bounded. Read-only: an imprecise walk here costs a false positive, which
  /// is recoverable, rather than corrupting a source file, which is not.
  String? callBody(String s, int open) {
    var depth = 0;
    var i = open;
    while (i < s.length) {
      final c = s[i];
      // Skip comments so an apostrophe in prose is not read as a string.
      if (c == '/' && i + 1 < s.length && s[i + 1] == '/') {
        final nl = s.indexOf('\n', i);
        i = nl == -1 ? s.length : nl;
        continue;
      }
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
        if (depth == 0) return s.substring(open + 1, i);
      }
      i++;
    }
    return null;
  }

  test('only onInverseSurface is safe on an inverseSurface bar', () {
    // Neither alternative is merely worse, each is broken in one mode:
    //
    //   token            light     dark
    //   surface          12.84:1    1.31:1   <- Client Feedback's title
    //   onSurface         1.32:1   15.16:1
    //   onInverseSurface 11.60:1   15.16:1
    //
    // Stated as numbers because "use onInverseSurface" is easy to rationalise
    // away when a spot check in one brightness mode happens to look fine.
    final light = BauhausDesign.lightTheme.colorScheme;
    final dark = BauhausDesign.darkTheme.colorScheme;

    for (final c in [light, dark]) {
      expect(
        contrastRatio(c.onInverseSurface, c.inverseSurface),
        greaterThanOrEqualTo(4.5),
        reason: 'onInverseSurface is correct in both modes',
      );
    }

    // `surface` is the one that produced the report: fine in light, invisible
    // in dark.
    expect(
      contrastRatio(light.surface, light.inverseSurface),
      greaterThanOrEqualTo(4.5),
      reason: 'surface passes in light',
    );
    expect(
      contrastRatio(dark.surface, dark.inverseSurface),
      lessThan(4.5),
      reason: 'surface is the reported dark-mode failure',
    );

    // `onSurface` is the mirror image, and would break light mode instead.
    expect(
      contrastRatio(light.onSurface, light.inverseSurface),
      lessThan(4.5),
      reason: 'onSurface fails in light',
    );
    expect(
      contrastRatio(dark.onSurface, dark.inverseSurface),
      greaterThanOrEqualTo(4.5),
      reason: 'onSurface passes in dark',
    );
  });

  test('no AppBar on inverseSurface inks its title or leading icon wrongly', () {
    final offenders = <String>[];
    var scanned = 0;

    for (final f in dartSources()) {
      final src = f.readAsStringSync();
      for (final m in RegExp(
        r'\bappBar:\s*(?:AppBar|BauhausAppBar)\(',
      ).allMatches(src)) {
        final open = src.lastIndexOf('(', m.end - 1);
        final body = callBody(src, open);
        if (body == null) continue;

        // Judge the ink against this AppBar's own background. A windowed scan
        // previously flagged a yellow-bar screen because an unrelated widget
        // further down happened to mention inverseSurface.
        final bg = RegExp(
          r'backgroundColor:\s*[^,]*?colorScheme\.(\w+)',
        ).firstMatch(body);
        if (bg == null || bg.group(1) != 'inverseSurface') continue;
        scanned++;

        final line = src.substring(0, m.start).split('\n').length;
        final where = f.path.split('/').last;

        // Only ink positions matter. backgroundColor, borders and dividers are
        // allowed to be other tokens, and an earlier version flagged both.
        final inks = <String, String?>{};

        final fg = RegExp(
          r'foregroundColor:\s*(?:Theme\.of\(context\)\.)?colorScheme\.(\w+)',
        ).firstMatch(body);
        inks['foregroundColor'] = fg?.group(1);

        // Balanced walk, not a [^)]* capture: IconThemeData(color:
        // Theme.of(context)...) closes at the first ')', which is inside
        // Theme.of, so a naive capture never reached the colour at all and the
        // slot looked unset.
        final iconTheme = RegExp(
          r'iconTheme:\s*IconThemeData\(',
        ).firstMatch(body);
        inks['iconTheme'] = iconTheme == null
            ? null
            : RegExp(
                r'colorScheme\.(\w+)',
              ).firstMatch(callBody(body, iconTheme.end - 1) ?? '')?.group(1);

        // A leading IconButton paints its own icon colour when set.
        final leading = RegExp(
          r'leading:\s*IconButton\(([\s\S]{0,400}?)\),\s',
        ).firstMatch(body);
        inks['leading icon'] = leading == null
            ? null
            : RegExp(
                r'color:\s*(?:Theme\.of\(context\)\.)?colorScheme\.(\w+)',
              ).firstMatch(leading.group(1)!)?.group(1);

        // The title's own style colour, if it sets one. Absent means it
        // inherits foregroundColor, which is already checked.
        final t = RegExp(r'title:\s*Text\(').firstMatch(body);
        if (t != null) {
          // Scoped to the title itself. Reading the whole rest of the bar would
          // pick up the iconTheme's colour and blame it on the title.
          final titleBody = callBody(body, t.end - 1) ?? '';
          inks['title'] = RegExp(
            r'color:\s*(?:Theme\.of\(context\)\.)?colorScheme\.(\w+)',
          ).firstMatch(titleBody)?.group(1);
        }

        inks.forEach((slot, token) {
          if (token == null || token == 'onInverseSurface') return;
          offenders.add('$line: $slot uses $token ($where)');
        });
      }
    }

    expect(
      scanned,
      greaterThan(0),
      reason: 'the scan found no inverseSurface AppBars, so it is not looking',
    );
    expect(
      offenders,
      isEmpty,
      reason:
          'use colorScheme.onInverseSurface for the title, foregroundColor and '
          'leading icon on an inverseSurface bar:\n${offenders.join('\n')}',
    );
  });

  testWidgets('the Client Feedback title is legible in dark mode', (
    tester,
  ) async {
    // Tied to the actual pixels rather than to the token, using the same bar
    // colours the app resolves in dark mode.
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        theme: BauhausDesign.darkTheme,
        home: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: AppBar(
              backgroundColor: const Color(0xFF1C1B1B),
              title: const Text(
                'Client Feedback',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF3F0EF),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final ink = tester.widget<Text>(find.text('Client Feedback')).style!.color!;
    expect(
      contrastRatio(ink, const Color(0xFF1C1B1B)),
      greaterThanOrEqualTo(4.5),
      reason:
          'the fixed pairing is ${contrast(ink, const Color(0xFF1C1B1B))}:1, '
          'against the 1.31:1 it had with surface',
    );
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 1));
  });
}
