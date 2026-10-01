import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Regression guard for the LateInitializationError outage class:
/// Riverpod may re-run `build()` on the same notifier instance, so caching
/// providers in `late final` fields assigned inside `build()` crashes on
/// rebuild. Repositories must be resolved via getters (`ref.read`) instead.
///
/// `late final` assigned in constructors/initState is safe and ignored —
/// only assignments inside `build()` bodies are flagged. Runs with the
/// package root as CWD (guaranteed by `flutter test`).
void main() {
  test('no viewmodel assigns late final fields inside build()', () {
    final root = Directory('lib/app/features');
    expect(root.existsSync(), isTrue, reason: 'run from package root');

    final offenders = <String>[];
    final fieldPattern = RegExp(r'late\s+final\s+[\w<>,\s\?]+\s+(_\w+)\s*;');
    final buildPattern = RegExp(r'\bbuild\s*\(\s*\)\s*(async\s*)?\{');

    for (final entity in root.listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('_viewmodel.dart')) {
        continue;
      }
      final content = entity.readAsStringSync();
      final lateFields = fieldPattern
          .allMatches(content)
          .map((m) => m.group(1)!)
          .toSet();
      if (lateFields.isEmpty) continue;

      for (final buildMatch in buildPattern.allMatches(content)) {
        final body = _extractBraceBody(content, buildMatch.end - 1);
        for (final field in lateFields) {
          final assign = RegExp(
            r'(?<![\w.])' + RegExp.escape(field) + r'\s*=(?!=|>)',
          );
          if (assign.hasMatch(body)) {
            offenders.add('${entity.path}: $field assigned in build()');
          }
        }
      }
    }

    expect(
      offenders,
      isEmpty,
      reason:
          'ViewModels must not assign `late final` fields inside build() '
          '(rebuilt notifiers throw LateInitializationError). Use a getter '
          'with ref.read instead:\n${offenders.join('\n')}',
    );
  });
}

/// Returns the `{...}` body starting at the opening brace index (exclusive).
String _extractBraceBody(String src, int openIndex) {
  var depth = 0;
  for (var i = openIndex; i < src.length; i++) {
    if (src[i] == '{') depth++;
    if (src[i] == '}') {
      depth--;
      if (depth == 0) return src.substring(openIndex + 1, i);
    }
  }
  return '';
}
