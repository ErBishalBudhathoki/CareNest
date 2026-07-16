import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/payroll_model.dart';
import '../repositories/payroll_repository.dart';

class PayrollState {
  final bool isLoading;
  final String? errorMessage;
  final PayrollSummary? summary;
  final DateTimeRange? selectedDateRange;

  const PayrollState({
    this.isLoading = false,
    this.errorMessage,
    this.summary,
    this.selectedDateRange,
  });

  PayrollState copyWith({
    bool? isLoading,
    String? errorMessage,
    PayrollSummary? summary,
    DateTimeRange? selectedDateRange,
  }) {
    return PayrollState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      summary: summary ?? this.summary,
      selectedDateRange: selectedDateRange ?? this.selectedDateRange,
    );
  }
}

final payrollViewModelProvider =
    NotifierProvider<PayrollViewModel, PayrollState>(PayrollViewModel.new);

class PayrollViewModel extends Notifier<PayrollState> {
  late final PayrollRepository _repository;

  @override
  PayrollState build() {
    _repository = ref.watch(payrollRepositoryProvider);
    final now = DateTime.now();
    final defaultRange = DateTimeRange(
      start: DateTime(now.year, now.month, 1),
      end: DateTime(now.year, now.month + 1, 0),
    );
    Future.microtask(() => fetchSummary(dateRange: defaultRange));
    return PayrollState(selectedDateRange: defaultRange);
  }

  Future<void> initialize() async {
    final now = DateTime.now();
    final range = DateTimeRange(
      start: DateTime(now.year, now.month, 1),
      end: DateTime(now.year, now.month + 1, 0),
    );
    state = state.copyWith(selectedDateRange: range);
    await fetchSummary(dateRange: range);
  }

  void updateDateRange(DateTimeRange range) {
    state = state.copyWith(selectedDateRange: range);
    fetchSummary(dateRange: range);
  }

  Future<void> fetchSummary({DateTimeRange? dateRange}) async {
    final range = dateRange ?? state.selectedDateRange;
    if (range == null) return;

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final dateFormat = DateFormat('yyyy-MM-dd');
      final startDate = dateFormat.format(range.start);
      final endDate = dateFormat.format(range.end);

      final summary = await _repository.getPayrollSummary(
        startDate: startDate,
        endDate: endDate,
      );
      state = state.copyWith(isLoading: false, summary: summary);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> exportData(String format) async {
    final range = state.selectedDateRange;
    if (range == null) return;

    try {
      final dateFormat = DateFormat('yyyy-MM-dd');
      await _repository.exportPayroll(
        format: format,
        startDate: dateFormat.format(range.start),
        endDate: dateFormat.format(range.end),
      );
    } catch (e) {
      state = state.copyWith(errorMessage: 'Export failed: ${e.toString()}');
    }
  }
}
