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
const _avatarFiles = <String>{
  'lib/app/shared/widgets/profile_image_widget.dart',
  'lib/app/shared/widgets/circular_profile_image_widget.dart',
};

/// Material widgets that render a pill or stadium shape unless the theme
/// overrides them. `Card(` and `Chip(` are deliberately absent because the
/// theme already forces a zero radius on them.
///
/// The negative lookbehind matters: `BauhausSwitch(` is the compliant widget
/// and would otherwise match a plain `Switch(` substring search.
final _unthemedPillWidget = RegExp(r'(?<!Bauhaus)\bSwitch(\.adaptive)?\(');

/// A non-zero literal radius. Catches `BorderRadius.circular(8)` but not
/// `BorderRadius.circular(BauhausDesign.radiusMd)`, which is 0.0.
final _literalRadius = RegExp(r'BorderRadius\.circular\(\s*[1-9][0-9]*');

/// Files still containing non-zero literal corner radii. DESIGN.md requires
/// roundedness 0 outside avatars, so every entry here is a migration target.
/// Each screen batch removes its own entry; the list must only shrink.
/// Do not add to this list to silence a new violation.
const _knownRadiusDebt = <String>{
  'lib/app/core/services/file_conversion_service.dart',
  'lib/app/features/analytics/widgets/overtime_heatmap.dart',
  'lib/app/features/analytics/widgets/utilization_gauge.dart',
  'lib/app/features/appointment/views/select_client_for_assignmnet.dart',
  'lib/app/features/bulk_actions/views/bulk_actions_view.dart',
  'lib/app/features/care_intelligence/views/health_monitoring_view.dart',
  'lib/app/features/care_intelligence/views/medication_management_view.dart',
  'lib/app/features/care_intelligence/views/outcome_tracking_view.dart',
  'lib/app/features/client/views/client_list_view.dart',
  'lib/app/features/earnings/views/earnings_dashboard_view.dart',
  'lib/app/features/employee_tracking/views/employee_tracking_view.dart',
  'lib/app/features/expenses/presentation/widgets/enhanced_file_viewer_widget.dart',
  'lib/app/features/home/widgets/compliance_alerts_widget.dart',
  'lib/app/features/home/widgets/live_worker_map_widget.dart',
  'lib/app/features/home/widgets/live_worker_map_widget_full.dart',
  'lib/app/features/home/widgets/quick_actions_widget.dart',
  'lib/app/features/home/widgets/revenue_chart_widget.dart',
  'lib/app/features/home/widgets/today_summary_widget.dart',
  'lib/app/features/invoice/services/invoice_pdf_generator_service.dart',
  'lib/app/features/invoice/views/enhanced_invoice_generation_view.dart',
  'lib/app/features/invoice/views/invoice_ai_dashboard.dart',
  'lib/app/features/invoice/widgets/invoice_photo_attachment_widget.dart',
  'lib/app/features/onboarding/views/onboarding_stepper_view.dart',
  'lib/app/features/onboarding/views/onboarding_welcome_view.dart',
  'lib/app/features/organization/views/organization_details_view.dart',
  'lib/app/features/pricing/views/enhanced_pricing_dashboard_view.dart',
  'lib/app/features/pricing/views/pricing_analytics_view.dart',
  'lib/app/features/pricing/views/pricing_validation_view.dart',
  'lib/app/features/realtime_portal/views/admin_family_management_view.dart',
  'lib/app/features/realtime_portal/views/admin_service_confirmations_view.dart',
  'lib/app/features/realtime_portal/views/appointment_timeline_view.dart',
  'lib/app/features/realtime_portal/views/live_tracking_view.dart',
  'lib/app/features/realtime_portal/views/realtime_portal_dashboard.dart',
  'lib/app/features/requests/views/add_shift_request_view.dart',
  'lib/app/features/requests/views/add_time_off_request_view.dart',
  'lib/app/features/requests/views/requests_view.dart',
  'lib/app/features/requests/views/shift_exchange_view.dart',
  'lib/app/features/schedule/views/schedule_dashboard_screen.dart',
  'lib/app/features/schedule/widgets/smart_assign_dialog.dart',
  'lib/app/features/workforce_optimization/views/business_intelligence_view.dart',
  'lib/app/features/workforce_optimization/views/performance_analytics_view.dart',
  'lib/app/features/workforce_optimization/views/quality_assurance_view.dart',
  'lib/app/features/workforce_optimization/views/report_builder_view.dart',
  'lib/app/features/workforce_optimization/views/resource_allocation_view.dart',
  'lib/app/features/workforce_optimization/views/workforce_planning_view.dart',
  'lib/app/shared/utils/pdf/pdf_viewer_io.dart',
  'lib/app/shared/widgets/appointment_card_widget.dart',
  'lib/app/shared/widgets/bauhaus_date_range_picker.dart',
  'lib/app/shared/widgets/button_with_variable_width_height_widget.dart',
  'lib/app/shared/widgets/card_label_text_widget.dart',
  'lib/app/shared/widgets/enhanced_3d_assignment_card.dart',
  'lib/app/shared/widgets/enhanced_3d_holiday_card.dart',
  'lib/app/shared/widgets/enhanced_quick_action_cards.dart',
  'lib/app/shared/widgets/enhanced_stat_cards.dart',
  'lib/app/shared/widgets/glass_card.dart',
};

/// Known debt, tracked so the guard can ratchet. Every entry is a file with
/// decorative circular geometry that DESIGN.md does not sanction. Each screen
/// batch removes its own entry; the list must only ever shrink. Do not add to
/// this list to silence a new violation.
const _knownCircularGeometryDebt = <String>{
  'lib/app/features/admin/views/admin_dashboard_view.dart',
  'lib/app/features/admin/views/employee_invoice_generation_view.dart',
  'lib/app/features/analytics/views/enhanced_predictive_insights_view.dart',
  'lib/app/features/care_intelligence/views/care_intelligence_dashboard.dart',
  'lib/app/features/care_intelligence/views/risk_assessment_view.dart',
  'lib/app/features/client_portal/views/client_appointment_detail_view.dart',
  'lib/app/features/client_portal/views/client_portal_dashboard.dart',
  'lib/app/features/employee_tracking/widgets/employee_status_card.dart',
  'lib/app/features/expenses/presentation/widgets/enhanced_file_attachment_widget.dart',
  'lib/app/features/expenses/widgets/expense_photo_attachment_widget.dart',
  'lib/app/features/feedback/views/feedback_form_view.dart',
  'lib/app/features/holiday/views/holiday_list_view.dart',
  'lib/app/features/home/widgets/bauhaus_appointment_card.dart',
  'lib/app/features/home/widgets/live_worker_map_widget.dart',
  'lib/app/features/home/widgets/live_worker_map_widget_full.dart',
  'lib/app/features/invoice/views/automatic_invoice_generation_view.dart',
  'lib/app/features/invoice/views/employee_selection_view.dart',
  'lib/app/features/invoice/views/enhanced_invoice_generation_view.dart',
  'lib/app/features/invoice/widgets/bauhaus_date_range_picker.dart',
  'lib/app/features/invoice/widgets/invoice_photo_attachment_widget.dart',
  'lib/app/features/notifications/widgets/bauhaus_notification_card.dart',
  'lib/app/features/ocr/views/ocr_view.dart',
  'lib/app/features/offline/views/offline_sync_dashboard_view.dart',
  'lib/app/features/onboarding/views/onboarding_welcome_view.dart',
  'lib/app/features/organization/views/organization_details_view.dart',
  'lib/app/features/organization/views/organization_edit_view.dart',
  'lib/app/features/photo/views/photo_upload_view.dart',
  'lib/app/features/pricing/views/enhanced_pricing_dashboard_view.dart',
  'lib/app/features/pricing/views/ndis_pricing_management_view.dart',
  'lib/app/features/pricing/views/pricing_analytics_view.dart',
  'lib/app/features/realtime_portal/views/realtime_portal_dashboard.dart',
  'lib/app/features/requests/views/add_shift_request_view.dart',
  'lib/app/features/requests/views/add_time_off_request_view.dart',
  'lib/app/features/requests/views/requests_view.dart',
  'lib/app/features/settings/views/date_format_settings_view.dart',
  'lib/app/features/settings/views/theme_settings_view.dart',
  'lib/app/features/settings/widgets/bauhaus_settings_widgets.dart',
  'lib/app/features/teams/views/team_dashboard_view.dart',
  'lib/app/features/worker/views/widgets/worker_status_card.dart',
  'lib/app/features/workforce_optimization/views/quality_assurance_view.dart',
  'lib/app/shared/utils/image_utils.dart',
  'lib/app/shared/widgets/dynamic_appointment_card_widget.dart',
  'lib/app/shared/widgets/enhanced_3d_assignment_card.dart',
  'lib/app/shared/widgets/enhanced_3d_holiday_card.dart',
  'lib/app/shared/widgets/photo_display_widget.dart',
};

/// Known debt: soft, blurred shadows. DESIGN.md, "Elevation & Depth":
/// > Depth is created strictly through physical neo-brutalist hard offsets
/// > rather than soft ambient blur shadows.
/// Every entry is a migration target. Each screen batch removes its own
/// entries; the list must only shrink. Do not add to silence a violation.
const _knownSoftShadowDebt = <String>{
  'lib/app/features/auth/views/forgot_password_view.dart',
  'lib/app/features/auth/views/verify_otp_view.dart',
  'lib/app/features/client_portal/views/client_appointment_detail_view.dart',
  'lib/app/features/client_portal/views/client_invoice_detail_view.dart',
  'lib/app/features/earnings/views/earnings_dashboard_view.dart',
  'lib/app/features/expenses/presentation/widgets/enhanced_file_viewer_widget.dart',
  'lib/app/features/home/widgets/live_worker_map_widget.dart',
  'lib/app/features/invoice/views/enhanced_invoice_generation_view.dart',
  'lib/app/features/invoice/widgets/bauhaus_date_range_picker.dart',
  'lib/app/features/pricing/views/enhanced_pricing_dashboard_view.dart',
  'lib/app/features/pricing/views/pricing_analytics_view.dart',
  'lib/app/features/pricing/views/pricing_validation_view.dart',
  'lib/app/features/realtime_portal/views/live_tracking_view.dart',
  'lib/app/features/workforce_optimization/views/business_intelligence_view.dart',
  'lib/app/features/workforce_optimization/views/performance_analytics_view.dart',
  'lib/app/features/workforce_optimization/views/quality_assurance_view.dart',
  'lib/app/features/workforce_optimization/views/report_builder_view.dart',
  'lib/app/features/workforce_optimization/views/resource_allocation_view.dart',
  'lib/app/features/workforce_optimization/views/workforce_planning_view.dart',
  'lib/app/shared/widgets/appointment_card_widget.dart',
  'lib/app/shared/widgets/bauhaus_time_picker.dart',
  'lib/app/shared/widgets/dynamic_appointment_card_widget.dart',
  'lib/app/shared/widgets/enhanced_3d_assignment_card.dart',
  'lib/app/shared/widgets/enhanced_3d_holiday_card.dart',
  'lib/app/shared/widgets/enhanced_quick_action_cards.dart',
  'lib/app/shared/widgets/enhanced_stat_cards.dart',
  'lib/app/shared/widgets/home_detail_card_widget.dart',
  'lib/app/shared/widgets/photo_display_widget.dart',
};

/// A non-zero blurRadius. DESIGN.md requires zero-blur hard offset shadows;
/// see BauhausDesign.shadowHard* for the compliant tokens.
final _softBlur = RegExp(r'blurRadius:\s*(?!0(\.0*)?\s*,)\d');

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
  'lib/app/features/invoice/views/price_override_view.dart',
  'lib/app/features/pricing/views/pricing_configuration_view.dart',
  'lib/app/features/pricing/views/ndis_pricing_management_view.dart',
  'lib/app/shared/widgets/bauhaus_switch.dart',
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
      if (_avatarFiles.contains(rel)) continue;
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
      if (_softBlur.hasMatch(_codeOf(f.readAsStringSync()))) {
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
      if (_avatarFiles.contains(rel)) continue;
      if (_codeOf(f.readAsStringSync()).contains('BoxShape.circle')) {
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
