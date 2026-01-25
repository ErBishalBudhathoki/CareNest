import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/payroll_model.dart';
import '../repositories/payroll_repository.dart';

final payrollViewModelProvider = ChangeNotifierProvider<PayrollViewModel>((ref) {
  final repository = ref.watch(payrollRepositoryProvider);
  return PayrollViewModel(repository);
});

class PayrollViewModel extends ChangeNotifier {
  final PayrollRepository _repository;

  PayrollViewModel(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  PayrollSummary? _summary;
  PayrollSummary? get summary => _summary;

  DateTimeRange? _selectedDateRange;
  DateTimeRange? get selectedDateRange => _selectedDateRange;

  // Initial fetch
  Future<void> initialize() async {
    // Default to current month
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, 1);
    final end = DateTime(now.year, now.month + 1, 0);
    
    _selectedDateRange = DateTimeRange(start: start, end: end);
    await fetchSummary();
  }

  void updateDateRange(DateTimeRange range) {
    _selectedDateRange = range;
    fetchSummary();
  }

  Future<void> fetchSummary() async {
    if (_selectedDateRange == null) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final dateFormat = DateFormat('yyyy-MM-dd');
      final startDate = dateFormat.format(_selectedDateRange!.start);
      final endDate = dateFormat.format(_selectedDateRange!.end);

      _summary = await _repository.getPayrollSummary(
        startDate: startDate,
        endDate: endDate,
      );
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> exportData(String format) async {
    if (_selectedDateRange == null) return;
    
    // Implement export logic (show toast, etc)
    // For now just call repository
    try {
        final dateFormat = DateFormat('yyyy-MM-dd');
        await _repository.exportPayroll(
            format: format,
            startDate: dateFormat.format(_selectedDateRange!.start),
            endDate: dateFormat.format(_selectedDateRange!.end),
        );
    } catch (e) {
        _errorMessage = "Export failed: ${e.toString()}";
        notifyListeners();
    }
  }
}
