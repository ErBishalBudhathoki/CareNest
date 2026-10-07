import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Static guard against two Bauhaus dark-mode defects that are invisible to the
/// analyzer and easy to reintroduce:
///
/// 1. A **translucent** `BoxDecoration.color` paired with one of the
///    zero-blur, fully opaque black `shadowHard*` shadows. The black shadow
///    shows through the mostly-transparent fill and the widget renders black.
///    (This is what made the confirmation-dialog icon tile render black.)
/// 2. A **hardcoded light-plane** fill (`BauhausDesign.neoPaper`,
///    `BauhausDesign.surfaceWhite`) on a decoration that also carries a hard
///    shadow, which cannot respond to the dark theme.
///
/// This scans the source rather than rendering widgets, so it covers screens
/// that are impractical to pump in a widget test.
void main() {
  final repoRoot = Directory.current;

  List<File> dartFilesUnder(String relative) {
    final dir = Directory('${repoRoot.path}/$relative');
    if (!dir.existsSync()) return const [];
    return dir
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'))
        .where((f) => !f.path.contains('.g.dart'))
        .where((f) => !f.path.contains('.freezed.dart'))
        .toList();
  }

  /// Returns the offending `boxShadow` line numbers in [source].
  List<int> translucentFillOverHardShadow(String source) {
    final lines = source.split('\n');
    final hits = <int>[];

    // A `border:`/`side:` line also contains a `color:`, so those lines must be
    // *skipped* while walking backwards, not treated as the fill.
    final borderLine = RegExp(
      r'^\s*(border|borderSide|side|shape|gradient|foregroundColor)\s*:',
    );
    final fillLine = RegExp(
      r'^\s*color:\s*[\w\.\(\)\s]*?(withValues\(\s*alpha|withOpacity\()',
    );

    for (var i = 0; i < lines.length; i++) {
      final line = lines[i];
      if (!RegExp(r'boxShadow:').hasMatch(line)) continue;
      if (!RegExp(r'shadowHard|shadowNeo|shadowSoft').hasMatch(line)) continue;

      // Walk back to the enclosing `BoxDecoration(` looking for the fill.
      for (var j = i - 1; j >= 0 && j >= i - 16; j--) {
        final back = lines[j];
        if (RegExp(r'decoration:\s*BoxDecoration').hasMatch(back)) break;
        if (borderLine.hasMatch(back)) continue; // nested border colour
        if (fillLine.hasMatch(back)) {
          hits.add(i + 1);
          break;
        }
      }
    }
    return hits;
  }

  /// Yields 1-based line numbers of [pattern] in [file] with their text.
  Iterable<({int line, String text})> linesMatching(
    File file,
    RegExp pattern,
  ) sync* {
    final lines = file.readAsStringSync().split('\n');
    for (var i = 0; i < lines.length; i++) {
      if (pattern.hasMatch(lines[i])) {
        yield (line: i + 1, text: lines[i].trim());
      }
    }
  }

  test('no translucent fill sits on an opaque zero-blur hard shadow', () {
    final offenders = <String>[];

    for (final file in dartFilesUnder('lib')) {
      final rel = file.path.replaceFirst('${repoRoot.path}/', '');
      for (final lineNo in translucentFillOverHardShadow(
        file.readAsStringSync(),
      )) {
        offenders.add('$rel:$lineNo');
      }
    }

    expect(
      offenders,
      isEmpty,
      reason:
          'A translucent BoxDecoration.color combined with an opaque black '
          'shadowHard* shadow lets the shadow bleed through and renders the '
          'widget black. Use an opaque themed fill (colorScheme.surface):\n'
          '${offenders.join('\n')}',
    );
  });

  test('Generate Invoice paints no surface with a literal light-plane fill', () {
    // Regression: this screen filled its cards and every text field with
    // `neoPaper` (#FFFCF5, a light-plane literal), so under the dark theme the
    // cards stayed parchment-white on a dark scaffold and the Tax rate field
    // rendered light body text on a white fill.
    //
    // Only *surface* fills are checked. A light foreground next to a fixed
    // accent (teal headers, crimson error blocks) is correct and must stay.
    const target =
        'lib/app/features/invoice/views/enhanced_invoice_generation_view.dart';
    final file = File('${repoRoot.path}/$target');
    expect(file.existsSync(), isTrue, reason: 'target screen moved?');

    final lines = file.readAsStringSync().split('\n');
    final offenders = <String>[];

    // The plane helpers must be handed a BuildContext so they can resolve the
    // brightness. Without one they fall back to the light plane.
    for (var i = 0; i < lines.length; i++) {
      if (RegExp(r'neo(Card|Panel)Decoration\(').hasMatch(lines[i])) {
        if (!RegExp(r'context:\s*context').hasMatch(lines[i])) {
          offenders.add('$target:${i + 1}  decoration without context');
        }
      }

      final isFillAssign = RegExp(
        r'^\s*(color|fillColor|backgroundColor)\s*:',
      ).hasMatch(lines[i]);
      if (!isFillAssign) continue;
      if (!RegExp(
        r'BauhausDesign\.(neoPaper|surfaceWhite|surfaceLight|surfaceOffWhite)\b',
      ).hasMatch(lines[i])) {
        continue;
      }

      // Walk back to confirm this colour paints a surface rather than a
      // foreground. Icon glyphs, text styles and spinners sit on accents.
      var isSurfaceFill = true;
      for (var j = i - 1; j >= 0 && j >= i - 8; j--) {
        final back = lines[j];
        if (RegExp(r'decoration:\s*BoxDecoration').hasMatch(back)) break;
        if (RegExp(r'style:|border:|RoundedRectangleAvatar').hasMatch(back)) {
          isSurfaceFill = false;
          break;
        }
        // A glyph or label drawn on a fixed accent keeps its light ink.
        if (RegExp(
          r'child:\s*(Icon|Text\(|CircularProgressIndicator)|\b(Icon|Text|CircularProgressIndicator)\(',
        ).hasMatch(back)) {
          isSurfaceFill = false;
          break;
        }
      }

      if (isSurfaceFill) offenders.add('$target:${i + 1}  ${lines[i].trim()}');
    }

    expect(
      offenders,
      isEmpty,
      reason:
          'Surfaces must follow the theme: use BauhausDesign.neoSurface(context) '
          'for fills and neoInkOnSurface(context) for text on them. A literal '
          'light-plane fill stays white in dark mode.\n'
          '${offenders.join('\n')}',
    );
  });

  test('Generate Invoice never paints text with a light-plane literal', () {
    // Regression: `textMuted` (#3D3728) is a light-plane literal. Used as a
    // foreground it is near-black on the dark card plane, which is why the
    // PDF/DOC/IMAGE/TXT chips and the Price override explanation were invisible
    // in dark mode. `colorScheme.onSurfaceVariant` is the same value in light
    // mode and the readable one in dark.
    const target =
        'lib/app/features/invoice/views/enhanced_invoice_generation_view.dart';
    final file = File('${repoRoot.path}/$target');
    expect(file.existsSync(), isTrue, reason: 'target screen moved?');

    final offenders = <String>[];
    for (final token in const ['textMuted', 'textDark']) {
      final pattern = RegExp('BauhausDesign\\.$token\\b');
      for (final hit in linesMatching(file, pattern)) {
        offenders.add('$target:${hit.line}  ${hit.text}');
      }
    }

    expect(
      offenders,
      isEmpty,
      reason:
          'Use colorScheme.onSurfaceVariant (or neoInkOnSurface(context)) for '
          'text so it follows the active theme. Light-plane literals stay dark '
          'in dark mode.\n${offenders.join('\n')}',
    );
  });

  test('design tokens keep the documented palette', () {
    // Guards the invariant the whole migration relies on: `outline` is a
    // theme-invariant near-black used for structural borders only.
    final designFile = File(
      '${repoRoot.path}/lib/app/shared/constants/bauhaus_design.dart',
    );
    expect(designFile.existsSync(), isTrue);

    final source = designFile.readAsStringSync();
    expect(source, contains('static const Color neoInk = Color(0xFF000000);'));
    expect(
      source,
      contains('outline: neoInk,'),
      reason: 'BauhausDesign mandates black structural borders in both themes',
    );
  });
}
