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
