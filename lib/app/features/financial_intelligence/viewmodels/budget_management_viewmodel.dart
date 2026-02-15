import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import '../repositories/financial_intelligence_repository.dart';

class BudgetManagementState {
  final bool isLoading;
  final Map<String, dynamic>? budget;
  final Map<String, dynamic>? monitoring;
  final Map<String, dynamic>? status;
  final String? error;

  BudgetManagementState({
    this.isLoading = false,
    this.budget,
    this.monitoring,
    this.status,
    this.error,
  });

  BudgetManagementState copyWith({
    bool? isLoading,
    Map<String, dynamic>? budget,
    Map<String, dynamic>? monitoring,
    Map<String, dynamic>? status,
    String? error,
  }) {
    return BudgetManagementState(
      isLoading: isLoading ?? this.isLoading,
      budget: budget ?? this.budget,
      monitoring: monitoring ?? this.monitoring,
      status: status ?? this.status,
      error: error,
    );
  }
}

class BudgetManagementViewModel extends StateNotifier<BudgetManagementState> {
  final FinancialIntelligenceRepository _repository;

  BudgetManagementViewModel(this._repository) : super(BudgetManagementState());

  Future<void> createBudget({
    required String organizationId,
    required Map<String, dynamic> budgetData,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.createBudget(
        organizationId: organizationId,
        budgetData: budgetData,
      );

      if (result['success'] == true) {
        state = state.copyWith(isLoading: false, budget: result['budget']);
      } else {
        state = state.copyWith(isLoading: false, error: result['message']);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> monitorBudget({
    required String organizationId,
    required String budgetId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.monitorBudget(
        organizationId: organizationId,
        budgetId: budgetId,
      );

      if (result['success'] == true) {
        state =
            state.copyWith(isLoading: false, monitoring: result['monitoring']);
      } else {
        state = state.copyWith(isLoading: false, error: result['message']);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> getStatus(String organizationId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result =
          await _repository.getBudgetStatus(organizationId: organizationId);
      if (result['success'] == true) {
        state = state.copyWith(isLoading: false, status: result['status']);
      } else {
        state = state.copyWith(isLoading: false, error: result['message']);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

final budgetManagementViewModelProvider =
    StateNotifierProvider<BudgetManagementViewModel, BudgetManagementState>(
        (ref) {
  final apiMethod = ref.read(app_providers.apiMethodProvider);
  final repository = FinancialIntelligenceRepository(apiMethod);
  return BudgetManagementViewModel(repository);
});
