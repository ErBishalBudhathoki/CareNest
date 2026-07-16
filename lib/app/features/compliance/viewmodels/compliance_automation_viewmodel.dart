import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/compliance/repositories/compliance_automation_repository.dart';
import 'package:carenest/app/features/compliance/models/compliance_automation_models.dart';

/// State for compliance automation
class ComplianceAutomationState {
  late final bool isLoading;
  late final String? error;
  late final ComplianceScan? scanResult;
  late final List<ExpiringDocument>? expiringDocuments;
  late final ComplianceReport? report;
  late final ComplianceTrends? trends;

  ComplianceAutomationState({
    this.isLoading = false,
    this.error,
    this.scanResult,
    this.expiringDocuments,
    this.report,
    this.trends,
  });

  ComplianceAutomationState copyWith({
    bool? isLoading,
    String? error,
    ComplianceScan? scanResult,
    List<ExpiringDocument>? expiringDocuments,
    ComplianceReport? report,
    ComplianceTrends? trends,
  }) {
    return ComplianceAutomationState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      scanResult: scanResult ?? this.scanResult,
      expiringDocuments: expiringDocuments ?? this.expiringDocuments,
      report: report ?? this.report,
      trends: trends ?? this.trends,
    );
  }
}

/// ViewModel for compliance automation
class ComplianceAutomationViewModel extends Notifier<ComplianceAutomationState> {
  late final ComplianceAutomationRepository repository;

  
  @override
  ComplianceAutomationState build() {
    final repository = ref.watch(complianceAutomationRepositoryProvider);
    
    return ComplianceAutomationState();
  }

  /// Run compliance scan
  Future<void> runComplianceScan(String organizationId) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final response = await repository.runComplianceScan(
        organizationId: organizationId,
      );
      
      if (response['success'] == true && response['data'] != null) {
        final scanResult = ComplianceScan.fromJson(response['data']);
        state = state.copyWith(
          isLoading: false,
          scanResult: scanResult,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response['message'] ?? 'Failed to run compliance scan',
        );
      }
    } catch (e) {
      debugPrint('Error in runComplianceScan: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Get expiring documents
  Future<void> getExpiringDocuments(String organizationId, {int? daysAhead}) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final response = await repository.getExpiringDocuments(
        organizationId: organizationId,
        daysAhead: daysAhead,
      );
      
      if (response['success'] == true && response['data'] != null) {
        final documents = (response['data']['documents'] as List)
            .map((doc) => ExpiringDocument.fromJson(doc))
            .toList();
        state = state.copyWith(
          isLoading: false,
          expiringDocuments: documents,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response['message'] ?? 'Failed to get expiring documents',
        );
      }
    } catch (e) {
      debugPrint('Error in getExpiringDocuments: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Generate compliance report
  Future<void> generateReport(String organizationId, String reportType) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final response = await repository.generateComplianceReport(
        organizationId: organizationId,
        reportType: reportType,
      );
      
      if (response['success'] == true && response['data'] != null) {
        final report = ComplianceReport.fromJson(response['data']);
        state = state.copyWith(
          isLoading: false,
          report: report,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response['message'] ?? 'Failed to generate report',
        );
      }
    } catch (e) {
      debugPrint('Error in generateReport: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Get compliance trends
  Future<void> getComplianceTrends(String organizationId, {int? months}) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final response = await repository.getComplianceTrends(
        organizationId: organizationId,
        months: months,
      );
      
      if (response['success'] == true && response['data'] != null) {
        final trends = ComplianceTrends.fromJson(response['data']);
        state = state.copyWith(
          isLoading: false,
          trends: trends,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response['message'] ?? 'Failed to get trends',
        );
      }
    } catch (e) {
      debugPrint('Error in getComplianceTrends: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

/// Provider for compliance automation viewmodel
final complianceAutomationViewModelProvider = NotifierProvider<ComplianceAutomationViewModel, ComplianceAutomationState>(ComplianceAutomationViewModel.new);
