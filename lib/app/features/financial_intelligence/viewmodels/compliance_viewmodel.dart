import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/financial_intelligence_repository.dart';

class ComplianceState {
  late final bool isLoading;
  final Map<String, dynamic>? complianceCheck;
  final Map<String, dynamic>? auditTrail;
  final Map<String, dynamic>? status;
  late final String? error;

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

class ComplianceViewModel extends Notifier<ComplianceState> {
  late final FinancialIntelligenceRepository _repository;

  @override
  ComplianceState build() {

    return ComplianceState();
  }

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
          isLoading: false,
          complianceCheck: result['compliance'],
        );
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
      final result = await _repository.getComplianceStatus(
        organizationId: organizationId,
      );
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
    NotifierProvider<ComplianceViewModel, ComplianceState>(
      ComplianceViewModel.new,
    );
