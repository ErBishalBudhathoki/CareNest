import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/realtime_portal/models/realtime_portal_models.dart';
import 'package:carenest/app/features/realtime_portal/repositories/realtime_portal_repository.dart';
import 'package:carenest/app/core/providers/app_providers.dart';

/// State for service confirmation
class ServiceConfirmationState {
  final bool isLoading;
  final String? error;
  final DigitalSignature? signature;
  final ServiceConfirmation? confirmation;
  final List<ChecklistItem> checklist;
  final ClientRating? rating;
  final List<IncidentReport> incidents;
  final bool isSubmitting;
  final ServiceReport? report;

  ServiceConfirmationState({
    this.isLoading = false,
    this.error,
    this.signature,
    this.confirmation,
    this.checklist = const [],
    this.rating,
    this.incidents = const [],
    this.isSubmitting = false,
    this.report,
  });

  ServiceConfirmationState copyWith({
    bool? isLoading,
    String? error,
    DigitalSignature? signature,
    ServiceConfirmation? confirmation,
    List<ChecklistItem>? checklist,
    ClientRating? rating,
    List<IncidentReport>? incidents,
    bool? isSubmitting,
    ServiceReport? report,
  }) {
    return ServiceConfirmationState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      signature: signature ?? this.signature,
      confirmation: confirmation ?? this.confirmation,
      checklist: checklist ?? this.checklist,
      rating: rating ?? this.rating,
      incidents: incidents ?? this.incidents,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      report: report ?? this.report,
    );
  }
}

class ServiceConfirmationViewModel extends Notifier<ServiceConfirmationState> {
  late final RealtimePortalRepository _repository;

  @override
  ServiceConfirmationState build() {
    final apiMethod = ref.watch(apiMethodProvider);
    _repository = RealtimePortalRepository(apiMethod);
    return ServiceConfirmationState();
  }

  /// Save digital signature
  Future<void> saveSignature({
    required String appointmentId,
    required String clientId,
    required String signatureData,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final signature = await _repository.saveSignature(
        appointmentId: appointmentId,
        clientId: clientId,
        signatureData: signatureData,
      );

      state = state.copyWith(isLoading: false, signature: signature);
    } catch (e) {
      debugPrint('Error saving signature: $e');
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Submit service confirmation
  Future<void> submitConfirmation({
    required String appointmentId,
    required String clientId,
    required String workerId,
    required DigitalSignature signature,
    required List<ChecklistItem> checklist,
    required ClientRating rating,
    List<String>? photoUrls,
    String? notes,
    List<IncidentReport>? incidents,
  }) async {
    state = state.copyWith(isSubmitting: true, error: null);

    try {
      final confirmation = await _repository.submitServiceConfirmation(
        appointmentId: appointmentId,
        clientId: clientId,
        workerId: workerId,
        signatureId: signature.id,
        rating: rating.stars,
        feedback: rating.feedback,
        checklist: checklist,
        photos: photoUrls,
        incidents: incidents,
      );

      state = state.copyWith(
        isSubmitting: false,
        confirmation: confirmation,
        signature: signature,
        checklist: checklist,
        rating: rating,
        incidents: incidents ?? [],
      );
    } catch (e) {
      debugPrint('Error submitting confirmation: $e');
      state = state.copyWith(isSubmitting: false, error: e.toString());
    }
  }

  /// Get service confirmation
  Future<void> getConfirmation({required String appointmentId}) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final confirmation = await _repository.getServiceConfirmation(
        appointmentId: appointmentId,
      );

      if (confirmation != null) {
        state = state.copyWith(
          isLoading: false,
          confirmation: confirmation,
          checklist: confirmation.checklist ?? [],
          incidents: confirmation.incidents ?? [],
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Service confirmation not found',
        );
      }
    } catch (e) {
      debugPrint('Error getting confirmation: $e');
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Get checklist template
  Future<void> getChecklistTemplate({required String serviceType}) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final checklist = await _repository.getChecklistTemplate(
        serviceType: serviceType,
      );

      state = state.copyWith(isLoading: false, checklist: checklist);
    } catch (e) {
      debugPrint('Error getting checklist template: $e');
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Update checklist item
  void updateChecklistItem(int itemId, bool completed) {
    final updatedChecklist = state.checklist.map((item) {
      if (item.id == itemId) {
        return item.copyWith(
          completed: completed,
          completedAt: completed ? DateTime.now() : null,
        );
      }
      return item;
    }).toList();

    state = state.copyWith(checklist: updatedChecklist);
  }

  /// Set rating
  void setRating({required int stars, String? feedback, List<String>? tags}) {
    final rating = ClientRating(
      stars: stars,
      feedback: feedback,
      tags: tags ?? [],
      timestamp: DateTime.now(),
    );

    state = state.copyWith(rating: rating);
  }

  /// Add incident report
  void addIncident({
    required String appointmentId,
    required String reportedBy,
    required String reporterType,
    required String severity,
    required String category,
    required String description,
    List<String>? photos,
  }) {
    final incident = IncidentReport(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      appointmentId: appointmentId,
      reportedBy: reportedBy,
      reporterType: reporterType,
      severity: severity,
      category: category,
      description: description,
      photos: photos ?? [],
      timestamp: DateTime.now(),
      status: 'reported',
    );

    final updatedIncidents = [...state.incidents, incident];
    state = state.copyWith(incidents: updatedIncidents);
  }

  /// Remove incident report
  void removeIncident(String incidentId) {
    final updatedIncidents = state.incidents
        .where((incident) => incident.id != incidentId)
        .toList();
    state = state.copyWith(incidents: updatedIncidents);
  }

  /// Clear signature
  void clearSignature() {
    state = state.copyWith(signature: null);
  }

  /// Reset state
  void reset() {
    state = ServiceConfirmationState();
  }
}

/// Provider for service confirmation viewmodel
final serviceConfirmationViewModelProvider =
    NotifierProvider<ServiceConfirmationViewModel, ServiceConfirmationState>(
      ServiceConfirmationViewModel.new,
    );
