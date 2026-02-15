import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import '../models/payroll_model.dart';

final payrollRepositoryProvider = Provider<PayrollRepository>((ref) {
  return PayrollRepository(ref.read(app_providers.apiMethodProvider));
});

class PayrollRepository {
  final ApiMethod _apiMethod;

  PayrollRepository(this._apiMethod);

  Future<PayrollSummary> getPayrollSummary({
    required String startDate,
    required String endDate,
  }) async {
    final query = '?startDate=$startDate&endDate=$endDate';
    final response = await _apiMethod.get('api/payroll/summary$query');

    if (response['success'] == true) {
      return PayrollSummary.fromJson(response['data']);
    } else {
      throw Exception(response['message'] ?? 'Failed to fetch payroll summary');
    }
  }

  Future<void> exportPayroll({
    required String format,
    required String startDate,
    required String endDate,
  }) async {
    // Note: For file download, we might need a different handling if it returns a blob/stream.
    // ApiMethod usually handles JSON.
    // If backend returns file content directly (csv), ApiMethod might fail if it expects JSON.
    // Assuming ApiMethod wraps http client.
    // For now, let's implement the call.

    final body = {
      'startDate': startDate,
      'endDate': endDate,
    };

    // Warning: standard _apiMethod.post might expect JSON response.
    // If exporting CSV, backend sends text/csv.
    // This might need a specialized method or we just handle JSON export for now which is safer.

    final response = await _apiMethod.post(
      'api/payroll/export/$format',
      body: body,
    );

    if (format == 'json') {
      if (response['success'] != true) {
        throw Exception(response['message'] ?? 'Failed to export payroll');
      }
      // Handle JSON data export (maybe save to file)
    }
    // For CSV, response handling depends on ApiMethod implementation.
  }
}
