import 'package:flutter/foundation.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvancedPayrollRepository {
  final Ref ref;

  AdvancedPayrollRepository(this.ref);

  Future<Map<String, dynamic>> calculatePayroll({required Map<String, dynamic> payrollData}) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      return await apiMethod.calculatePayroll(payrollData: payrollData);
    } catch (e) {
      debugPrint('Error calculating payroll: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getPayslip({required String userId, required String period}) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      return await apiMethod.getPayslip(userId: userId, period: period);
    } catch (e) {
      debugPrint('Error getting payslip: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> generatePayslips({required String organizationId, required String period}) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      return await apiMethod.generatePayslips(organizationId: organizationId, period: period);
    } catch (e) {
      debugPrint('Error generating payslips: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getPayrollSummary({required String organizationId, required String period}) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      return await apiMethod.getPayrollSummary(organizationId: organizationId, period: period);
    } catch (e) {
      debugPrint('Error getting payroll summary: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> exportPayrollData({required Map<String, dynamic> exportData}) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      return await apiMethod.exportPayrollData(exportData: exportData);
    } catch (e) {
      debugPrint('Error exporting payroll data: $e');
      return {'success': false, 'message': e.toString()};
    }
  }
}

final advancedPayrollRepositoryProvider = Provider<AdvancedPayrollRepository>((ref) {
  return AdvancedPayrollRepository(ref);
});
