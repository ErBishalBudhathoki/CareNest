import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:carenest/app/features/earnings/models/earnings_data.dart';
import 'package:carenest/app/features/earnings/repositories/earnings_repository.dart';
import 'package:carenest/app/features/auth/providers/user_provider.dart';

enum EarningsPeriod { weekly, monthly }

enum TaxFrequency { weekly, fortnightly, monthly, annually }

// State class
class EarningsState {
  final bool isLoading;
  final String? error;
  final EarningsSummary? summary;
  final ProjectedEarnings? projection;
  final EarningsPeriodHistory? periodHistory;
  final EarningsPeriod period;
  final DateTime anchorDate;
  final TaxFrequency taxFrequency;

  EarningsState({
    this.isLoading = false,
    this.error,
    this.summary,
    this.projection,
    this.periodHistory,
    this.period = EarningsPeriod.monthly,
    DateTime? anchorDate,
    this.taxFrequency = TaxFrequency.monthly,
  }) : anchorDate = anchorDate ?? DateTime.now();

  EarningsState copyWith({
    bool? isLoading,
    String? error,
    EarningsSummary? summary,
    ProjectedEarnings? projection,
    EarningsPeriodHistory? periodHistory,
    EarningsPeriod? period,
    DateTime? anchorDate,
    TaxFrequency? taxFrequency,
  }) {
    return EarningsState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      summary: summary ?? this.summary,
      projection: projection ?? this.projection,
      periodHistory: periodHistory ?? this.periodHistory,
      period: period ?? this.period,
      anchorDate: anchorDate ?? this.anchorDate,
      taxFrequency: taxFrequency ?? this.taxFrequency,
    );
  }
}

final earningsViewModelProvider =
    StateNotifierProvider<EarningsViewModel, EarningsState>((ref) {
  final repository = ref.watch(earningsRepositoryProvider);
  final userAsync = ref.watch(currentUserProvider);
  final userEmail = userAsync.value?.email ?? '';
  return EarningsViewModel(repository, userEmail);
});

class EarningsViewModel extends StateNotifier<EarningsState> {
  final EarningsRepository _repository;
  final String _userEmail;
  Map<String, dynamic>? _taxConfig;

  EarningsViewModel(
    this._repository,
    this._userEmail, {
    bool autoLoad = true,
  }) : super(EarningsState()) {
    if (autoLoad && _userEmail.isNotEmpty) {
      loadDashboardData();
    }
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // Fetch tax config if not loaded
      if (_taxConfig == null) {
        try {
          _taxConfig = await _repository.getTaxSettings();
        } catch (e) {
          debugPrint('Error loading tax settings: $e');
        }
      }

      final now = DateTime.now();
      final range = _calculateRange(state.period, state.anchorDate);
      final historyRange = _calculateHistoryRange(state.period, range);

      final summary = await _repository.getEarningsSummary(
        _userEmail,
        startDate: _formatDate(range.start),
        endDate: _formatDate(range.end),
      );

      final projection = await _repository.getProjectedEarnings(
        _userEmail,
        startDate: _formatDate(now),
      );

      final periodHistory = await _repository.getEarningsHistory(
        _userEmail,
        startDate: _formatDate(historyRange.start),
        endDate: _formatDate(historyRange.end),
        bucket: state.period == EarningsPeriod.weekly ? 'week' : 'month',
      );

      state = state.copyWith(
        isLoading: false,
        summary: summary,
        projection: projection,
        periodHistory: periodHistory,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void setPeriod(EarningsPeriod period) {
    if (state.period == period) return;
    state = state.copyWith(period: period);
    loadDashboardData();
  }

  void setAnchorDate(DateTime anchorDate) {
    state = state.copyWith(anchorDate: anchorDate);
    loadDashboardData();
  }

  void goToPreviousPeriod() {
    final d = state.anchorDate;
    final DateTime prev;
    if (state.period == EarningsPeriod.weekly) {
      prev = d.subtract(const Duration(days: 7));
    } else {
      prev = DateTime(d.year, d.month - 1, 1);
    }
    state = state.copyWith(anchorDate: prev);
    loadDashboardData();
  }

  void goToNextPeriod() {
    final d = state.anchorDate;
    final DateTime next;
    if (state.period == EarningsPeriod.weekly) {
      next = d.add(const Duration(days: 7));
    } else {
      next = DateTime(d.year, d.month + 1, 1);
    }
    state = state.copyWith(anchorDate: next);
    loadDashboardData();
  }

  void setTaxFrequency(TaxFrequency frequency) {
    state = state.copyWith(taxFrequency: frequency);
  }

  _Range _calculateRange(EarningsPeriod period, DateTime anchor) {
    final normalized = DateTime(anchor.year, anchor.month, anchor.day);
    switch (period) {
      case EarningsPeriod.weekly:
        final start =
            normalized.subtract(Duration(days: normalized.weekday - 1));
        final end = start.add(const Duration(days: 6));
        return _Range(start: start, end: end);
      case EarningsPeriod.monthly:
        final start = DateTime(normalized.year, normalized.month, 1);
        final end = DateTime(normalized.year, normalized.month + 1, 0);
        return _Range(start: start, end: end);
    }
  }

  _Range _calculateHistoryRange(EarningsPeriod period, _Range currentRange) {
    if (period == EarningsPeriod.weekly) {
      return _Range(
        start: currentRange.start.subtract(const Duration(days: 49)),
        end: currentRange.end,
      );
    }

    final s = currentRange.start;
    return _Range(
      start: DateTime(s.year, s.month - 5, 1),
      end: currentRange.end,
    );
  }

  String _formatDate(DateTime d) =>
      "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";

  // Tax Estimator Logic
  Map<String, double> calculateTax(double grossIncome, TaxFrequency frequency) {
    double annualized = 0;
    if (frequency == TaxFrequency.weekly) annualized = grossIncome * 52;
    if (frequency == TaxFrequency.fortnightly) annualized = grossIncome * 26;
    if (frequency == TaxFrequency.monthly) annualized = grossIncome * 12;
    if (frequency == TaxFrequency.annually) annualized = grossIncome;

    double tax = 0;

    // Use dynamic config if available
    if (_taxConfig != null && _taxConfig!['brackets'] != null) {
      final brackets =
          (_taxConfig!['brackets'] as List).cast<Map<String, dynamic>>();
      for (final bracket in brackets) {
        final double? max =
            bracket['max'] != null ? (bracket['max'] as num).toDouble() : null;
        final double rate = (bracket['rate'] as num).toDouble();
        final double base = (bracket['base'] as num).toDouble();
        final double min = (bracket['min'] as num).toDouble();

        if (max == null || annualized <= max) {
          double threshold = min > 0 ? min - 1 : 0;
          tax = base + (annualized - threshold) * rate;
          break;
        }
      }
    } else {
      // Fallback to hardcoded (ATO 2024-2025)
      if (annualized <= 18200) {
        tax = 0;
      } else if (annualized <= 45000) {
        tax = (annualized - 18200) * 0.19;
      } else if (annualized <= 120000) {
        tax = 5092 + (annualized - 45000) * 0.325;
      } else if (annualized <= 180000) {
        tax = 29467 + (annualized - 120000) * 0.37;
      } else {
        tax = 51667 + (annualized - 180000) * 0.45;
      }
    }

    double periodTax = 0;
    if (frequency == TaxFrequency.weekly) periodTax = tax / 52;
    if (frequency == TaxFrequency.fortnightly) periodTax = tax / 26;
    if (frequency == TaxFrequency.monthly) periodTax = tax / 12;
    if (frequency == TaxFrequency.annually) periodTax = tax;

    return {
      'gross': grossIncome,
      'tax': periodTax,
      'net': grossIncome - periodTax,
    };
  }
}

class _Range {
  final DateTime start;
  final DateTime end;

  const _Range({required this.start, required this.end});
}
