import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Fails when `lib/` grows a file that nothing references.
///
/// Dead code accumulated to 131 files and ~30.5k lines before this check
/// existed. Import, export and part directives are all followed, and
/// conditional imports (`if (dart.library.html)`) count as usage, because
/// platform-specific siblings such as `encryption_utils_io.dart` and
/// `pdf_viewer_io.dart` are reached only that way. An earlier version of this
/// scan looked at plain imports alone and reported those as dead, which would
/// have deleted live platform code.
///
/// Baseline of the dead files that already exist. Every entry is a file in
/// lib/ that no import, export or part directive reaches. It is a ratchet: each
/// cleanup batch removes its own entries and the list only shrinks. Do not add
/// an entry to silence a new file, delete the file or wire it up instead.
///
/// Much of this is redesign work that was never wired up: the `*_bauhaus.dart`
/// screens, the financial_intelligence and workforce_optimization models and
/// viewmodels, and several legacy views. Whether to delete that or finish
/// wiring it is a product decision, so it is recorded here rather than removed.
/// Baseline of the dead files that already exist. Every entry is a file in
/// lib/ that no import, export or part directive reaches.
///
/// The 12 entries marked UNTRACKED below are not in git at all: they exist on
/// disk and compile into the app, but no commit has them, so deleting them
/// would be unrecoverable. They are called out here and must not be removed
/// without an explicit decision.
/// Baseline of dead files that already exist: a file in lib/ that no
/// import, export or part directive reaches.
///
/// Paths are compared case-insensitively, because the checkout can be on a
/// case-insensitive filesystem where features/Appointment/ and
/// features/appointment/ are the same directory. Comparing raw case reported
/// 12 live appointment files as dead.
const _knownDead = <String>{};

/// Entry points and configuration that are legitimately unimported.
bool _isEntryPoint(String path, String source) {
  if (source.contains('void main(')) return true;
  if (source.contains("@pragma('vm:entry-point')")) return true;
  // Loaded by flutter_dotenv / --dart-define rather than imported.
  if (path == 'lib/env.dart') return true;
  if (source.contains('flutter_dotenv')) return true;
  return false;
}

void main() {
  test('lib/ has no unreferenced files', () {
    final root = Directory.current;

    // import | export | part, plus any "if (...)" continuation.
    final directive = RegExp(
      r'''(?:^|\n)\s*(?:import|export|part)\s+['"]([^'"]+)['"]([^;\n]*)''',
    );
    final conditional = RegExp(r'''if\s*\([^)]*\)\s*['"]([^'"]+)['"]''');

    // Everything is normalised to an absolute path. A package: specifier
    // resolves through the repo root, a relative one through the importing
    // file's directory. Returning a relative path for one and an absolute path
    // for the other made every package:-imported file look unreferenced.
    final rootUri = root.uri;
    String? resolve(String importer, String spec) {
      try {
        if (spec.startsWith('package:carenest/')) {
          return rootUri
              .resolve('lib/${spec.substring('package:carenest/'.length)}')
              .toFilePath();
        }
        return File(importer).parent.uri.resolve(spec).toFilePath();
      } catch (_) {
        return null;
      }
    }

    final roots = [
      'lib',
      'test',
      'integration_test',
      'integration_test_driver',
    ].where((d) => Directory('${root.path}/$d').existsSync()).toList();

    final referenced = <String>{};
    for (final dir in roots) {
      for (final entity in Directory(
        '${root.path}/$dir',
      ).listSync(recursive: true)) {
        if (entity is! File || !entity.path.endsWith('.dart')) continue;
        if (entity.path.contains('.g.dart')) continue;
        if (entity.path.contains('.freezed.dart')) continue;
        final source = entity.readAsStringSync();
        for (final m in directive.allMatches(source)) {
          for (final spec in [
            m.group(1)!,
            ...conditional.allMatches(m.group(2) ?? '').map((x) => x.group(1)!),
          ]) {
            final target = resolve(entity.path, spec);
            if (target != null && target.endsWith('.dart')) {
              referenced.add(target);
            }
          }
        }
      }
    }

    final dead = <String>[];
    for (final entity in Directory(
      '${root.path}/lib',
    ).listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;
      if (entity.path.contains('.g.dart')) continue;
      if (entity.path.contains('.freezed.dart')) continue;
      final rel = entity.path.substring(root.path.length + 1);
      if (referenced.contains(entity.path)) continue;
      if (_isEntryPoint(rel, entity.readAsStringSync())) continue;
      dead.add(rel);
    }

    final fresh = dead.where((f) => !_knownDead.contains(f)).toList()..sort();
    expect(
      fresh,
      isEmpty,
      reason:
          'these files under lib/ are not referenced by any import, export or '
          'part directive, so they are dead. Wire them up or delete them:\n'
          '${fresh.join('\n')}',
    );
    expect(
      dead.length,
      lessThanOrEqualTo(_knownDead.length),
      reason: '_knownDead is a ratchet and must shrink, never grow',
    );
  });
}
