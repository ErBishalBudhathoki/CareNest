import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/compliance_repository.dart';

final complianceDashboardViewModelProvider = NotifierProvider.autoDispose<
    ComplianceDashboardViewModel, ComplianceState>(ComplianceDashboardViewModel.new);

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

class ComplianceDashboardViewModel extends Notifier<ComplianceState> {
  late final ComplianceRepository _repository;

  @override
  ComplianceState build() {
    _repository = ref.watch(complianceRepositoryProvider);
    // Loading data asynchronously in build can be done without awaiting,
    // or typically we might just invoke it right away.
    Future.microtask(() => loadData());
    return const ComplianceState();
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
