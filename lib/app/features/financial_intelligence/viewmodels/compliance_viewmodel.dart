import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import '../repositories/financial_intelligence_repository.dart';

class ComplianceState {
  final bool isLoading;
  final Map<String, dynamic>? complianceCheck;
  final Map<String, dynamic>? auditTrail;
  final Map<String, dynamic>? status;
  final String? error;

  ComplianceState({
    this.isLoading = false,
    this.complianceCheck,
    this.auditTrail,
    this.status,
    this.error,
  });

  ComplianceState copyWith({
    bool? isLoading,
    Map<String, dynamic>? complianceCheck,
    Map<String, dynamic>? auditTrail,
    Map<String, dynamic>? status,
    String? error,
  }) {
    return ComplianceState(
      isLoading: isLoading ?? this.isLoading,
      complianceCheck: complianceCheck ?? this.complianceCheck,
      auditTrail: auditTrail ?? this.auditTrail,
      status: status ?? this.status,
      error: error,
    );
  }
}

class ComplianceViewModel extends StateNotifier<ComplianceState> {
  final FinancialIntelligenceRepository _repository;

  ComplianceViewModel(this._repository) : super(ComplianceState());

  Future<void> checkCompliance({
    required String organizationId,
    Map<String, dynamic>? data,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.checkCompliance(
        organizationId: organizationId,
        data: data,
      );

      if (result['success'] == true) {
        state = state.copyWith(
            isLoading: false, complianceCheck: result['compliance']);
      } else {
        state = state.copyWith(isLoading: false, error: result['message']);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> generateAuditTrail({
    required String organizationId,
    required String period,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.generateAuditTrail(
        organizationId: organizationId,
        period: period,
      );

      if (result['success'] == true) {
        state = state.copyWith(isLoading: false, auditTrail: result['trail']);
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
          await _repository.getComplianceStatus(organizationId: organizationId);
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

final complianceViewModelProvider =
    StateNotifierProvider<ComplianceViewModel, ComplianceState>((ref) {
  final apiMethod = ref.read(app_providers.apiMethodProvider);
  final repository = FinancialIntelligenceRepository(apiMethod);
  return ComplianceViewModel(repository);
});
