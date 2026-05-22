import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:share_plus/share_plus.dart';

final payrollExportViewModelProvider =
    StateNotifierProvider<PayrollExportViewModel, AsyncValue<void>>((ref) {
  return PayrollExportViewModel(ref.read(app_providers.apiMethodProvider));
});

class PayrollExportViewModel extends StateNotifier<AsyncValue<void>> {
  final ApiMethod _apiMethod;

  PayrollExportViewModel(this._apiMethod) : super(const AsyncValue.data(null));

  Future<void> exportPayroll({
    required DateTime startDate,
    required DateTime endDate,
    required String organizationId,
  }) async {
    state = const AsyncValue.loading();
    try {
      final response = await _apiMethod.post(
        'api/timesheets/export-payroll',
        body: {
          'startDate': startDate.toIso8601String(),
          'endDate': endDate.toIso8601String(),
          'organizationId': organizationId,
        },
      );

      if (response['success'] == true) {
        final csvContent = response['csv'];
        final filename = response['filename'] ?? 'payroll_export.csv';

        if (csvContent != null) {
          await _saveAndShareFile(csvContent, filename);
          state = const AsyncValue.data(null);
        } else {
          state =
              AsyncValue.error('No CSV content received', StackTrace.current);
        }
      } else {
        state = AsyncValue.error(
            response['message'] ?? 'Export failed', StackTrace.current);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> _saveAndShareFile(String content, String filename) async {
    try {
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/$filename');
      await file.writeAsString(content);

      // Share the file (which opens the share sheet or allows opening in compatible apps)
      // This is better than open_file for CSVs on mobile as it gives more options
      await Share.shareXFiles([XFile(file.path)], text: 'Payroll Export');
    } catch (e) {
      throw Exception('Failed to save file: $e');
    }
  }
}
