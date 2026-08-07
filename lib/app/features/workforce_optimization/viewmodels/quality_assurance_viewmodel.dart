import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/workforce_optimization/models/workforce_models.dart';
import 'package:carenest/app/features/workforce_optimization/repositories/workforce_repository.dart';
import 'package:carenest/app/features/workforce_optimization/viewmodels/workforce_planning_viewmodel.dart';

// State class for Quality Assurance
class QualityAssuranceState {
  late final bool isLoading;
  late final QualityScore? qualityScore;
  late final List<ComplianceCheck> complianceChecks;
  late final List<SentimentAnalysis> sentiments;
  late final List<RiskAssessment> riskAssessments;
  late final IncidentPattern? incidentPattern;
  late final String? error;

  QualityAssuranceState({
    this.isLoading = false,
    this.qualityScore,
    this.complianceChecks = const [],
    this.sentiments = const [],
    this.riskAssessments = const [],
    this.incidentPattern,
    this.error,
  });

  QualityAssuranceState copyWith({
    bool? isLoading,
    QualityScore? qualityScore,
    List<ComplianceCheck>? complianceChecks,
    List<SentimentAnalysis>? sentiments,
    List<RiskAssessment>? riskAssessments,
    IncidentPattern? incidentPattern,
    String? error,
  }) {
    return QualityAssuranceState(
      isLoading: isLoading ?? this.isLoading,
      qualityScore: qualityScore ?? this.qualityScore,
      complianceChecks: complianceChecks ?? this.complianceChecks,
      sentiments: sentiments ?? this.sentiments,
      riskAssessments: riskAssessments ?? this.riskAssessments,
      incidentPattern: incidentPattern ?? this.incidentPattern,
      error: error,
    );
  }
}

// StateNotifier for Quality Assurance
class QualityAssuranceViewModel extends Notifier<QualityAssuranceState> {
  late final WorkforceRepository _repository;

  @override
  QualityAssuranceState build() {
    final repository = ref.watch(workforceRepositoryProvider);

    return QualityAssuranceState();
  }

  // Score service quality
  Future<void> scoreServiceQuality({
    required String appointmentId,
    required String organizationId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.scoreServiceQuality(
        appointmentId: appointmentId,
        organizationId: organizationId,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          qualityScore: result['qualityScore'] as QualityScore?,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result['message'] as String?,
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Perform compliance check
  Future<void> performComplianceCheck({
    required String organizationId,
    String? employeeId,
    String? startDate,
    String? endDate,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.performComplianceCheck(
        organizationId: organizationId,
        employeeId: employeeId,
        startDate: startDate,
        endDate: endDate,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          complianceChecks: result['checks'] as List<ComplianceCheck>,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result['message'] as String?,
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Analyze feedback sentiment
  Future<void> analyzeFeedbackSentiment({
    required String organizationId,
    String? employeeId,
    String? startDate,
    String? endDate,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.analyzeFeedbackSentiment(
        organizationId: organizationId,
        employeeId: employeeId,
        startDate: startDate,
        endDate: endDate,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          sentiments: result['sentiments'] as List<SentimentAnalysis>,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result['message'] as String?,
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Assess risk
  Future<void> assessRisk({
    required String organizationId,
    String? appointmentId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.assessRisk(
        organizationId: organizationId,
        appointmentId: appointmentId,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          riskAssessments: result['assessments'] as List<RiskAssessment>,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result['message'] as String?,
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Detect incident patterns
  Future<void> detectIncidentPatterns({
    required String organizationId,
    required String startDate,
    required String endDate,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.detectIncidentPatterns(
        organizationId: organizationId,
        startDate: startDate,
        endDate: endDate,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          incidentPattern: result['patterns'] as IncidentPattern?,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result['message'] as String?,
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }

  // Reset state
  void reset() {
    state = QualityAssuranceState();
  }
}

// Provider for QualityAssuranceViewModel
final qualityAssuranceViewModelProvider =
    NotifierProvider<QualityAssuranceViewModel, QualityAssuranceState>(
      QualityAssuranceViewModel.new,
    );
