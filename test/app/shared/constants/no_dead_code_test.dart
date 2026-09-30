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
const _knownDead = <String>{
  'lib/app/core/base/base_viewmodel.dart',
  'lib/app/core/base/helper.dart',
  'lib/app/core/interfaces/visibility_toggle.dart',
  'lib/app/core/providers/appointment_providers.dart',
  'lib/app/core/providers/business_providers.dart',
  'lib/app/core/providers/notification_provider.dart',
  'lib/app/core/providers/timer_providers.dart',
  'lib/app/core/services/dialog_service.dart',
  'lib/app/core/utils/Services/invoicing_email_details.dart',
  'lib/app/core/utils/Services/storage_permission_handler.dart',
  'lib/app/core/utils/permissions_utils.dart',
  'lib/app/features/admin/repositories/bank_details_repository.dart',
  'lib/app/features/admin/views/admin_requests_view.dart',
  'lib/app/features/admin/views/rbac_management_view.dart',
  'lib/app/features/admin/widgets/bauhaus_invoice_grid.dart',
  'lib/app/features/analytics/views/cross_org_dashboard_view.dart',
  'lib/app/features/analytics/views/predictive_insights_view.dart',
  'lib/app/features/appointment/utils/shift_utils.dart',
  'lib/app/features/appointment/viewmodels/appointment_viewmodel.dart',
  'lib/app/features/appointment/views/client_appointment_details_view.dart',
  'lib/app/features/appointment/views/schedule_assignment.dart',
  'lib/app/features/appointment/views/select_client_for_assignmnet.dart',
  'lib/app/features/appointment/views/select_employee_view.dart',
  'lib/app/features/appointment/widgets/bauhaus_client_header.dart',
  'lib/app/features/appointment/widgets/bauhaus_info_block.dart',
  'lib/app/features/appointment/widgets/bauhaus_schedule_list.dart',
  'lib/app/features/appointment/widgets/bauhaus_timer_control.dart',
  'lib/app/features/appointment/widgets/shift_details_widget.dart',
  'lib/app/features/appointment/widgets/shift_selection_dialog.dart',
  'lib/app/features/assignment/views/ndis_item_selection_view.dart',
  'lib/app/features/assignment_list/repositories/assignment_repository.dart',
  'lib/app/features/auth/models/changePassword_model.dart',
  'lib/app/features/auth/models/visibility_toggle_model_impl.dart',
  'lib/app/features/auth/viewmodels/user_viewmodel.dart',
  'lib/app/features/auth/views/change_password_view_bauhaus.dart',
  'lib/app/features/auth/views/login_view_bauhaus.dart',
  'lib/app/features/auth/views/signup_view_bauhaus.dart',
  'lib/app/features/auth/widgets/auth_validation_widget.dart',
  'lib/app/features/business/repositories/business_repository.dart',
  'lib/app/features/care_intelligence/viewmodels/health_monitoring_viewmodel.dart',
  'lib/app/features/client/repositories/client_repository.dart',
  'lib/app/features/client_appointment_details/views/client_appointment_details_view.dart',
  'lib/app/features/clockInandOut/viewmodels/clock_in_out_viewmodel.dart',
  'lib/app/features/compliance/viewmodels/compliance_automation_viewmodel.dart',
  'lib/app/features/compliance/views/compliance_dashboard_view.dart',
  'lib/app/features/expenses/viewmodels/smart_expense_viewmodel.dart',
  'lib/app/features/expenses/views/bauhaus_layout_widgets.dart',
  'lib/app/features/expenses/widgets/expense_photo_attachment_widget.dart',
  'lib/app/features/financial_intelligence/models/financial_intelligence_models.dart',
  'lib/app/features/financial_intelligence/viewmodels/billing_automation_viewmodel.dart',
  'lib/app/features/financial_intelligence/viewmodels/budget_management_viewmodel.dart',
  'lib/app/features/financial_intelligence/viewmodels/compliance_viewmodel.dart',
  'lib/app/features/financial_intelligence/viewmodels/payment_processing_viewmodel.dart',
  'lib/app/features/financial_intelligence/viewmodels/pricing_optimization_viewmodel.dart',
  'lib/app/features/holiday/viewmodels/holiday_viewmodel.dart',
  'lib/app/features/home/models/dashboard_models.dart',
  'lib/app/features/invoice/domain/models/invoice.dart',
  'lib/app/features/invoice/models/invoicing_email_model.dart',
  'lib/app/features/invoice/presentation/widgets/dynamic_line_item_entry.dart',
  'lib/app/features/invoice/viewmodels/invoice_viewmodel.dart',
  'lib/app/features/invoice/views/credit_note_creation_view.dart',
  'lib/app/features/invoice/views/generateInvoice.dart',
  'lib/app/features/invoice/widgets/fallback_price_dialog.dart',
  'lib/app/features/multi_org/views/multi_org_rollup_view.dart',
  'lib/app/features/notes/repositories/notes_repository.dart',
  'lib/app/features/notifications/services/geofence_notification_service.dart',
  'lib/app/features/notifications/services/smart_timing_service.dart',
  'lib/app/features/notifications/views/geofence_view.dart',
  'lib/app/features/notifications/views/notification_history_view.dart',
  'lib/app/features/notifications/views/smart_notification_dashboard.dart',
  'lib/app/features/ocr/views/ocr_view.dart',
  'lib/app/features/offline/viewmodels/offline_viewmodel.dart',
  'lib/app/features/offline/views/offline_sync_dashboard_view.dart',
  'lib/app/features/onboarding/views/widgets/tax_super_form.dart',
  'lib/app/features/organization/models/shared_employee.dart',
  'lib/app/features/organization/models/user_organization.dart',
  'lib/app/features/organization/viewmodels/accounting_viewmodel.dart',
  'lib/app/features/organization/views/bauhaus_banking_section.dart',
  'lib/app/features/organization/views/bauhaus_contact_section.dart',
  'lib/app/features/organization/views/bauhaus_details_section.dart',
  'lib/app/features/organization/views/integration_oauth_callback_view.dart',
  'lib/app/features/organization/views/organization_dashboard_view.dart',
  'lib/app/features/organization/views/organization_settings_view.dart',
  'lib/app/features/organization/views/shared_employee_pool_view.dart',
  'lib/app/features/organization/widgets/organization_switcher.dart',
  'lib/app/features/payroll/views/payroll_dashboard_view.dart',
  'lib/app/features/photo/repositories/photo_repository.dart',
  'lib/app/features/pricing/views/bauhaus_slider_shapes.dart',
  'lib/app/features/pricing/views/ndis_item_management_view.dart',
  'lib/app/features/realtime_portal/services/encryption_service.dart',
  'lib/app/features/realtime_portal/services/geofence_service.dart',
  'lib/app/features/schedule/viewmodels/schedule_viewmodel.dart',
  'lib/app/features/settings/widgets/bauhaus_logout_dialog.dart',
  'lib/app/features/shift_assignment/views/shift_success_view.dart',
  'lib/app/features/workforce_optimization/services/ml_inference_service.dart',
  'lib/app/features/workforce_optimization/services/optimization_service.dart',
  'lib/app/shared/constants/base/base_component.dart',
  'lib/app/shared/constants/base/base_controller.dart',
  'lib/app/shared/constants/base/base_page.dart',
  'lib/app/shared/constants/values/colors/enhanced_app_colors.dart',
  'lib/app/shared/constants/values/strings/appbar_title.dart',
  'lib/app/shared/services/offline_service.dart',
  'lib/app/shared/theme/bauhaus_colors.dart',
  'lib/app/shared/utils/encryption/encryption_utils.dart',
  'lib/app/shared/utils/encryption/encryption_utils_web.dart',
  'lib/app/shared/utils/secure_error_handler.dart',
  'lib/app/shared/widgets/add_client_business_details_widget.dart',
  'lib/app/shared/widgets/animated_background.dart',
  'lib/app/shared/widgets/circular_profile_image_widget.dart',
  'lib/app/shared/widgets/enhanced_data_table.dart',
  'lib/app/shared/widgets/enhanced_search_filter.dart',
  'lib/app/shared/widgets/invoice_email_view_widget.dart',
  'lib/app/shared/widgets/job_status_widget.dart',
  'lib/app/shared/widgets/notification_refresh_button.dart',
  'lib/app/shared/widgets/option_menu_widget.dart',
  'lib/app/shared/widgets/permission_guard.dart',
  'lib/app/shared/widgets/request_photo_permission.dart',
  'lib/app/shared/widgets/show_warning_dialog_widget.dart',
  'lib/app/shared/widgets/stat_cards.dart',
  'lib/app/shared/widgets/text_field_widget.dart',
  'lib/app/shared/widgets/wave_animation_widget.dart',
  'lib/backend/api_error.dart',
  'lib/backend/api_response.dart',
  'lib/config/env/environment.dart',
  'lib/generated/assets.dart',
  'lib/models/leave.dart',
  'lib/utils.dart',
};

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
