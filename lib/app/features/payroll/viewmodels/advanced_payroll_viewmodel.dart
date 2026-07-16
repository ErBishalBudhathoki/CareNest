import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/payroll/repositories/advanced_payroll_repository.dart';
import 'package:carenest/app/features/payroll/models/advanced_payroll_models.dart';

final advancedPayrollViewModelProvider = NotifierProvider<AdvancedPayrollViewModel, AdvancedPayrollState>(AdvancedPayrollViewModel.new);

class AdvancedPayrollState {
  late final bool isLoading;
  late final String? error;
  late final PayrollCalculation? calculation;
  late final Payslip? payslip;
  late final PayrollSummary? summary;
  late final bool isExporting;

  AdvancedPayrollState({
    this.isLoading = false,
    this.error,
    this.calculation,
    this.payslip,
    this.summary,
    this.isExporting = false,
  });

  AdvancedPayrollState copyWith({
    bool? isLoading,
    String? error,
    PayrollCalculation? calculation,
    Payslip? payslip,
    PayrollSummary? summary,
    bool? isExporting,
  }) {
    return AdvancedPayrollState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      calculation: calculation ?? this.calculation,
      payslip: payslip ?? this.payslip,
      summary: summary ?? this.summary,
      isExporting: isExporting ?? this.isExporting,
    );
  }
}

class AdvancedPayrollViewModel extends Notifier<AdvancedPayrollState> {
  late final AdvancedPayrollRepository _repository;

  
  @override
  AdvancedPayrollState build() {
    final repository = ref.watch(advancedPayrollRepositoryProvider);
    
    return AdvancedPayrollState();
  }

  /// Calculate payroll with award rates and penalties
  Future<bool> calculatePayroll(Map<String, dynamic> payrollData) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response =
          await _repository.calculatePayroll(payrollData: payrollData);
      if (response['success'] == true && response['data'] != null) {
        final calculation = PayrollCalculation.fromJson(response['data']);
        state = state.copyWith(isLoading: false, calculation: calculation);
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response['message'] ?? 'Failed to calculate payroll',
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  /// Get payslip for a user and period
  Future<void> getPayslip(String userId, String period) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response =
          await _repository.getPayslip(userId: userId, period: period);
      if (response['success'] == true && response['data'] != null) {
        final payslip = Payslip.fromJson(response['data']);
        state = state.copyWith(isLoading: false, payslip: payslip);
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response['message'] ?? 'Failed to load payslip',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Generate payslips for all employees
  Future<bool> generatePayslips(String organizationId, String period) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _repository.generatePayslips(
        organizationId: organizationId,
        period: period,
      );
      final success = response['success'] == true;
      state = state.copyWith(
        isLoading: false,
        error: success
            ? null
            : (response['message'] ??
                response['error'] ??
                'Failed to generate payslips'),
      );
      return success;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  /// Get payroll summary for organization
  Future<void> getPayrollSummary(String organizationId, String period) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _repository.getPayrollSummary(
        organizationId: organizationId,
        period: period,
      );
      if (response['success'] == true && response['data'] != null) {
        final summary = PayrollSummary.fromJson(response['data']);
        state = state.copyWith(isLoading: false, summary: summary);
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response['message'] ?? 'Failed to load summary',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Export payroll data to Xero/MYOB
  Future<bool> exportPayrollData(Map<String, dynamic> exportData) async {
    state = state.copyWith(isExporting: true, error: null);
    try {
      final response =
          await _repository.exportPayrollData(exportData: exportData);
      final success = response['success'] == true;
      state = state.copyWith(
        isExporting: false,
        error: success
            ? null
            : (response['message'] ??
                response['error'] ??
                'Failed to export payroll data'),
      );
      return success;
    } catch (e) {
      state = state.copyWith(isExporting: false, error: e.toString());
      return false;
    }
  }
}
