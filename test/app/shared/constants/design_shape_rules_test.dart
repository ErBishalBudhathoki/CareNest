import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Enforces the shape rules in DESIGN.md.
///
/// DESIGN.md, "Shapes":
///
/// > Geometry is strictly sharp (`roundedness: 0`). Corners are unrounded
/// > (`0px`) across all cards, badges, buttons, progress tracks, and layout
/// > segments. The only rounded element in the component set is the avatar:
/// > profile photos and user avatars are circular because they depict a
/// > person rather than a machined surface. Pill and stadium shapes are never
/// > acceptable, including on switches.
///
/// Three things make this easy to break by accident:
///
/// 1. `BauhausDesign.radiusXs/sm/md/lg/xl/full/pill` are all `0.0`, so
///    `BorderRadius.circular(BauhausDesign.radiusMd)` looks rounded at the
///    call site but renders sharp. Only a non-zero **literal** is a violation.
///    The argument is often on the next line, so the pattern is multiline.
/// 2. The theme forces `BorderRadius.zero` on `cardTheme`, `chipTheme` and
///    `dialogTheme`, so bare `Card(` and `Chip(` are sharp by inheritance.
///    `Switch` and `Switch.adaptive` are not themed that way and are always
///    pills.
/// 3. Circular geometry is legitimate for identity imagery. The rule is
///    semantic, not a file allowlist, so a new screen showing a person passes
///    without editing this test.

/// The sanctioned exception. Circular identity imagery.
///
/// DO NOT MODIFY THESE FILES. They are exempt from the shape rules by design
/// and they are owned by the user, not by the design sweep. An earlier pass
/// restyled profile_image_widget.dart to be theme-aware without being asked;
/// that was reverted. Any future change here needs the user's explicit say-so.
const _avatarFiles = <String>{
  'lib/app/shared/widgets/profile_image_widget.dart',
  'lib/app/shared/widgets/circular_profile_image_widget.dart',
};

/// Widgets that display a person, a photo or a logo, wherever they live. These
/// are circular by design and the sweep must not square them.
///
/// This list exists because an earlier sweep did exactly that: it squared
/// ImageErrorHandler's loading and error placeholders, the admin profile Hero,
/// the employee status card avatars, the organization logo and logo picker, the
/// photo upload preview, and the settings profile photo. All of them render
/// imagery, and the grey square that appeared behind a loaded profile photo was
/// the squared placeholder showing through.
const _imageDisplayWidgets = <String>{
  'lib/app/shared/utils/image_utils.dart',
  'lib/app/features/admin/views/admin_dashboard_view.dart',
  'lib/app/features/employee_tracking/widgets/employee_status_card.dart',
  'lib/app/features/organization/views/organization_edit_view.dart',
  'lib/app/features/organization/views/organization_details_view.dart',
  'lib/app/features/photo/views/photo_upload_view.dart',
  'lib/app/features/settings/widgets/bauhaus_settings_widgets.dart',
  'lib/app/features/client_portal/views/client_appointment_detail_view.dart',
};

/// Expected number of circular image containers in each of those files.
///
/// A count, rather than a source pattern, is the honest guard: the sweep's
/// mistake was removing `shape: BoxShape.circle` lines, so a drop in the count
/// is exactly the regression to catch. Icon badges and remove buttons in these
/// same files are deliberately square and are not counted.
const _expectedImageCircles = <String, int>{
  'lib/app/shared/utils/image_utils.dart': 2,
  'lib/app/features/admin/views/admin_dashboard_view.dart': 2,
  'lib/app/features/employee_tracking/widgets/employee_status_card.dart': 2,
  'lib/app/features/organization/views/organization_edit_view.dart': 1,
  'lib/app/features/organization/views/organization_details_view.dart': 3,
  'lib/app/features/photo/views/photo_upload_view.dart': 2,
  'lib/app/features/settings/widgets/bauhaus_settings_widgets.dart': 1,
  'lib/app/features/client_portal/views/client_appointment_detail_view.dart': 0,
};

/// Material widgets that render a pill or stadium shape unless the theme
/// overrides them. `Card(` and `Chip(` are deliberately absent because the
/// theme already forces a zero radius on them.
///
/// The negative lookbehind matters: `BauhausSwitch(` is the compliant widget
/// and would otherwise match a plain `Switch(` substring search.
final _unthemedPillWidget = RegExp(r'(?<!Bauhaus)\bSwitch(\.adaptive)?\(');

/// A non-zero literal Flutter corner radius. Catches `BorderRadius.circular(8)`
/// but not `BorderRadius.circular(BauhausDesign.radiusMd)`, which is 0.0.
///
/// The `pw.` alternative excludes the `pdf` package: a generated invoice PDF is
/// a print artefact, not an on-screen widget, so DESIGN.md's shape rules do not
/// govern it.
final _literalRadius = RegExp(
  r'(?<!pw\.)\bBorderRadius\.circular\(\s*[1-9][0-9]*',
);

/// Files still containing non-zero literal corner radii. DESIGN.md requires
/// roundedness 0 outside avatars, so every entry here is a migration target.
/// Each screen batch removes its own entry; the list must only shrink.
/// Do not add to this list to silence a new violation.
const _knownRadiusDebt = <String>{};

/// Known debt, tracked so the guard can ratchet. Every entry is a file with
/// decorative circular geometry that DESIGN.md does not sanction. Each screen
/// batch removes its own entry; the list must only ever shrink. Do not add to
/// this list to silence a new violation.
const _knownCircularGeometryDebt = <String>{};

/// Known debt: soft, blurred shadows. DESIGN.md, "Elevation & Depth":
/// > Depth is created strictly through physical neo-brutalist hard offsets
/// > rather than soft ambient blur shadows.
/// Scoped to BoxShadow, not text Shadow: DESIGN.md's rule is about depth, and a
/// blurred text shadow is a legibility technique rather than a cast shadow.
///
/// Every entry is a migration target. Each screen batch removes its own
/// entries; the list must only shrink. Do not add to silence a violation.
const _knownSoftShadowDebt = <String>{};

/// Captures the numeric blurRadius so the value can be compared as a number.
/// A textual negative lookahead is wrong here: `blurRadius: 0` and
/// `blurRadius: 0.0` are both compliant, and the character after the value
/// varies (`0,` vs `0)`), so a lookahead that assumes a trailing comma
/// reports compliant zero-blur shadows as violations.
final _blurRadiusValue = RegExp(r'blurRadius:\s*([0-9]+(?:\.[0-9]+)?)');

/// A text `Shadow(` that is not the tail of a `BoxShadow(`.
final _textShadowToken = RegExp(r'(?<!Box)Shadow\(');

bool _hasSoftBlur(String code) {
  for (final m in _blurRadiusValue.allMatches(code)) {
    // DESIGN.md's depth rule is about elevation, so only BoxShadow counts. A
    // text `Shadow` with a blur is a legibility technique, not a cast shadow,
    // and is not a violation.
    final before = code.substring(0, m.start);
    // 'BoxShadow(' ends with 'Shadow(', so a plain substring search for
    // 'Shadow(' also matches inside 'BoxShadow(' and misclassifies every
    // cast shadow as a text shadow. Exclude it with a lookbehind.
    final lastTextShadow = _textShadowToken
        .allMatches(before)
        .fold<int>(-1, (a, b) => b.end > a ? b.end : a);
    final lastBoxShadow = before.lastIndexOf('BoxShadow(');
    if (lastBoxShadow < lastTextShadow) continue;
    if (double.parse(m.group(1)!) != 0) return true;
  }
  return false;
}

final _extent = RegExp(r'\b(width|height):\s*([0-9]+(?:\.[0-9]+)?)');

/// How far back from a circle to look for the extents that size it.
///
/// Two earlier approaches were wrong. A regex spanning a whole `Container(...)`
/// body attributed a nested child's size to its parent, and a paren-depth scan
/// mis-nested spans in deeply indented code, so both reported a 4px "today" dot
/// as a violation. Reading the nearest preceding extents within a fixed window
/// is coarse but predictable, and the window is wide enough for the indentation
/// actually present in this codebase.
const _extentLookback = 600;

/// DESIGN.md permits circular geometry for "minute functional terminal
/// indicators (e.g., live-feed pulse LEDs and active segment indicators)". A
/// small status dot is one; a large decorative shape is not. The threshold
/// covers the functional indicators actually in use (a 4px "today" dot, an 8px
/// success LED, a 10px bullet marker, an 18px radio dot) while excluding the
/// 100-200px background shapes migrated in the earlier batches.
const _minuteIndicatorMax = 24.0;

bool _hasOversizedCircle(String code) {
  for (final circle in 'BoxShape.circle'.allMatches(code)) {
    final from = circle.start - _extentLookback < 0
        ? 0
        : circle.start - _extentLookback;
    final extents = <String, double>{};
    for (final e in _extent.allMatches(code.substring(from, circle.start))) {
      extents[e.group(1)!] = double.parse(e.group(2)!);
    }
    final w = extents['width'];
    final h = extents['height'];
    // Unmeasurable is treated as a violation, so a new decorative circle has to
    // be given an explicit, reviewed decision.
    if (w == null || h == null) return true;
    if (w > _minuteIndicatorMax || h > _minuteIndicatorMax) return true;
  }
  return false;
}

/// Strips whole-line `//` comments so a comment mentioning a widget does not
/// trip the guard.
String _codeOf(String source) =>
    source.split('\n').where((l) => !l.trimLeft().startsWith('//')).join('\n');

String _read(String path) {
  final f = File('${Directory.current.path}/$path');
  expect(f.existsSync(), isTrue, reason: '$path must exist');
  return f.readAsStringSync();
}

/// Every real Dart file under lib/, with generated code excluded.
List<File> _libFiles() => Directory('${Directory.current.path}/lib')
    .listSync(recursive: true)
    .whereType<File>()
    .where((f) => f.path.endsWith('.dart'))
    .where((f) => !f.path.contains('.g.dart'))
    .where((f) => !f.path.contains('.freezed.dart'))
    .toList();

String _rel(File f) => f.path.replaceFirst('${Directory.current.path}/', '');

/// Screens already reviewed and migrated. These must stay perfectly sharp.
const _scopedFiles = <String>[
  'lib/app/features/auth/views/login_view_bauhaus.dart',
  'lib/app/features/auth/views/forgot_password_view.dart',
  'lib/app/features/auth/views/verify_otp_view.dart',
  'lib/app/features/home/widgets/bauhaus_appointment_card.dart',
  'lib/app/features/invoice/views/enhanced_invoice_generation_view.dart',
  'lib/app/features/invoice/views/invoice_ai_dashboard.dart',
  'lib/app/features/invoice/widgets/invoice_photo_attachment_widget.dart',
  'lib/app/features/invoice/views/automatic_invoice_generation_view.dart',
  'lib/app/features/invoice/views/employee_selection_view.dart',
  'lib/app/features/invoice/widgets/bauhaus_date_range_picker.dart',
  'lib/app/features/workforce_optimization/views/business_intelligence_view.dart',
  'lib/app/features/workforce_optimization/views/performance_analytics_view.dart',
  'lib/app/features/workforce_optimization/views/quality_assurance_view.dart',
  'lib/app/features/workforce_optimization/views/report_builder_view.dart',
  'lib/app/features/workforce_optimization/views/resource_allocation_view.dart',
  'lib/app/features/workforce_optimization/views/workforce_planning_view.dart',
  'lib/app/features/invoice/views/price_override_view.dart',
  'lib/app/features/pricing/views/pricing_configuration_view.dart',
  'lib/app/features/pricing/views/ndis_pricing_management_view.dart',
  'lib/app/shared/widgets/bauhaus_switch.dart',
  'lib/app/shared/widgets/bauhaus_date_range_picker.dart',
  'lib/app/shared/widgets/bauhaus_time_picker.dart',
  'lib/app/shared/widgets/home_detail_card_widget.dart',
  'lib/app/shared/widgets/bauhaus_widgets.dart',
  'lib/app/shared/constants/bauhaus_design.dart',
];

void main() {
  group('DESIGN.md shape rules in migrated screens', () {
    for (final path in _scopedFiles) {
      if (_avatarFiles.contains(path)) continue;

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

      test('$path has no oversized decorative circle', () {
        expect(
          _hasOversizedCircle(_codeOf(_read(path))),
          isFalse,
          reason:
              'Only avatars and minute functional indicators may be circular. '
              'A decorative Container circle must be at most '
              '${_minuteIndicatorMax}px, or be removed.',
        );
      });

      test('$path uses no unthemed pill widget', () {
        expect(
          _unthemedPillWidget.hasMatch(_codeOf(_read(path))),
          isFalse,
          reason:
              'Material Switch renders a pill shape with a circular thumb and '
              'is not overridden by the theme. Use BauhausSwitch.',
        );
      });
    }
  });

  test('image and avatar containers are still circular', () {
    for (final entry in _expectedImageCircles.entries) {
      final f = File('${Directory.current.path}/${entry.key}');
      expect(f.existsSync(), isTrue, reason: '${entry.key} must exist');
      final count = 'shape: BoxShape.circle'
          .allMatches(_codeOf(f.readAsStringSync()))
          .length;
      expect(
        count,
        entry.value,
        reason:
            '${entry.key} displays imagery and its circular containers must be '
            'preserved. Squaring them makes a grey or square panel appear behind '
            'the image. If a circle was removed on purpose, update this count '
            'and say why.',
      );
    }
  });

  test('lib/ contains no editor backup or patch files', () {
    // A .dart.bak is not compiled, so it silently accumulates stale Material
    // widgets that neither the analyzer nor the app ever exercises, while
    // still polluting grep-based audits. One such file held four pill Switches
    // whose live equivalents had long since been migrated to BauhausSwitch.
    final stray = Directory('${Directory.current.path}/lib')
        .listSync(recursive: true)
        .whereType<File>()
        .map(_rel)
        .where(
          (p) =>
              p.endsWith('.bak') || p.endsWith('.orig') || p.endsWith('.rej'),
        )
        .toList();
    expect(
      stray,
      isEmpty,
      reason: 'remove these from lib/:\n${stray.join('\n')}',
    );
  });

  test('the whole app has no unthemed pill switch left', () {
    final offenders = <String>[];
    for (final f in _libFiles()) {
      if (_unthemedPillWidget.hasMatch(_codeOf(f.readAsStringSync()))) {
        offenders.add(_rel(f));
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

  test('no duplicate Bauhaus component shadows the shared one', () {
    // A feature-local BauhausSwitch once existed in the pricing feature with
    // the same class name as the shared widget. Nothing imported it, so it sat
    // in the tree as a rounded dead copy. Catch that class of drift.
    final shared = <String, String>{};
    for (final f in _libFiles()) {
      final m = RegExp(
        r'class\s+(Bauhaus\w+)\b',
      ).firstMatch(f.readAsStringSync());
      final name = m?.group(1);
      if (name != null && !shared.containsKey(name)) {
        shared[name] = _rel(f);
      }
    }
    final dupes = <String>[];
    for (final f in _libFiles()) {
      final m = RegExp(
        r'class\s+(Bauhaus\w+)\b',
      ).firstMatch(f.readAsStringSync());
      final name = m?.group(1);
      if (name != null && shared[name] != _rel(f)) {
        dupes.add(
          '${_rel(f)} declares $name, already defined in ${shared[name]}',
        );
      }
    }
    expect(
      dupes,
      isEmpty,
      reason:
          'duplicate Bauhaus component names cause a shadowed, unimported copy '
          'to drift out of sync:\n${dupes.join('\n')}',
    );
  });

  test('non-zero literal corner radii are ratcheting down', () {
    final offenders = <String>[];
    for (final f in _libFiles()) {
      final rel = _rel(f);
      if (_avatarFiles.contains(rel) || _scopedFiles.contains(rel)) continue;
      if (_literalRadius.hasMatch(_codeOf(f.readAsStringSync()))) {
        offenders.add(rel);
      }
    }
    final known = _knownRadiusDebt.toSet();
    final newOnes = offenders.where((f) => !known.contains(f)).toList();
    expect(
      newOnes,
      isEmpty,
      reason:
          'these files have non-zero literal corner radii but are not in the '
          'known-debt ratchet, so this is a new violation:\n'
          '${newOnes.join('\n')}',
    );
    expect(
      offenders.length,
      lessThanOrEqualTo(_knownRadiusDebt.length),
      reason: 'the known-debt list must shrink, never grow',
    );
  });

  test('soft blurred shadows are ratcheting down', () {
    final offenders = <String>[];
    for (final f in _libFiles()) {
      final rel = _rel(f);
      if (_hasSoftBlur(_codeOf(f.readAsStringSync()))) {
        offenders.add(rel);
      }
    }
    final known = _knownSoftShadowDebt.toSet();
    final newOnes = offenders.where((f) => !known.contains(f)).toList();
    expect(
      newOnes,
      isEmpty,
      reason:
          'DESIGN.md requires hard offset shadows with zero blur. These files '
          'use a non-zero blurRadius but are not in the known-debt ratchet:\n'
          '${newOnes.join('\n')}',
    );
    expect(
      offenders.length,
      lessThanOrEqualTo(_knownSoftShadowDebt.length),
      reason: 'the known-debt list must shrink, never grow',
    );
  });

  test('decorative circular geometry is ratcheting down', () {
    final offenders = <String>[];
    for (final f in _libFiles()) {
      final rel = _rel(f);
      // Image and avatar containers are legitimately large (a 220px photo
      // preview, a 76px logo picker). Their circles are governed by the
      // _expectedImageCircles count guard, not by the size threshold.
      if (_avatarFiles.contains(rel) ||
          _scopedFiles.contains(rel) ||
          _expectedImageCircles.containsKey(rel)) {
        continue;
      }
      if (_hasOversizedCircle(_codeOf(f.readAsStringSync()))) {
        offenders.add(rel);
      }
    }
    final known = _knownCircularGeometryDebt.toSet();
    final newOnes = offenders.where((f) => !known.contains(f)).toList();
    expect(
      newOnes,
      isEmpty,
      reason:
          'DESIGN.md permits circles for avatars and profile images only. A '
          'BoxShape.circle on a decorative container must become '
          'BorderRadius.zero, or be routed through ProfileImageWidget:\n'
          '${newOnes.join('\n')}',
    );
    expect(
      offenders.length,
      lessThanOrEqualTo(_knownCircularGeometryDebt.length),
      reason: 'the known-debt list must shrink, never grow',
    );
  });
}
