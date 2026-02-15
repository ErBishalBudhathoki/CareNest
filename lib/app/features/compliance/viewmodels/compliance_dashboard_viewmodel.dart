import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/compliance_repository.dart';

final complianceDashboardViewModelProvider = StateNotifierProvider.autoDispose<
    ComplianceDashboardViewModel, ComplianceState>((ref) {
  final repository = ref.watch(complianceRepositoryProvider);
  return ComplianceDashboardViewModel(repository);
});

class ComplianceState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic>? data;

  const ComplianceState({
    this.isLoading = false,
    this.error,
    this.data,
  });

  ComplianceState copyWith({
    bool? isLoading,
    String? error,
    Map<String, dynamic>? data,
  }) {
    return ComplianceState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      data: data ?? this.data,
    );
  }
}

class ComplianceDashboardViewModel extends StateNotifier<ComplianceState> {
  final ComplianceRepository _repository;

  ComplianceDashboardViewModel(this._repository)
      : super(const ComplianceState()) {
    loadData();
  }

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final data = await _repository.getComplianceSummary();
      state = state.copyWith(isLoading: false, data: data);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
