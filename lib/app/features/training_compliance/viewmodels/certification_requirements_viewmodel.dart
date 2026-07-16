import 'package:carenest/app/features/training_compliance/providers/training_compliance_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/training_compliance/models/certification_requirement.dart';
import 'package:carenest/app/features/training_compliance/repositories/training_compliance_repository.dart';

class CertificationRequirementsState {
  final bool isLoading;
  final List<CertificationRequirement> requirements;
  final String? errorMessage;

  const CertificationRequirementsState({
    this.isLoading = false,
    this.requirements = const [],
    this.errorMessage,
  });

  CertificationRequirementsState copyWith({
    bool? isLoading,
    List<CertificationRequirement>? requirements,
    String? errorMessage,
  }) {
    return CertificationRequirementsState(
      isLoading: isLoading ?? this.isLoading,
      requirements: requirements ?? this.requirements,
      errorMessage: errorMessage,
    );
  }
}

class CertificationRequirementsViewModel
    extends Notifier<CertificationRequirementsState> {
  late final TrainingComplianceRepository _repository;

  @override
  CertificationRequirementsState build() {
    _repository = ref.watch(trainingComplianceRepositoryProvider);
    return const CertificationRequirementsState();
  }

  Future<void> loadRequirements({bool includeInactive = false}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final raw = await _repository.getCertificationRequirements(
        includeInactive: includeInactive,
      );
      final requirements = raw
          .map((e) => CertificationRequirement.fromJson(e))
          .toList();
      state = state.copyWith(isLoading: false, requirements: requirements);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> createRequirement(Map<String, dynamic> data) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _repository.createCertificationRequirement(data);
      await loadRequirements(includeInactive: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> updateRequirement(String id, Map<String, dynamic> data) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _repository.updateCertificationRequirement(id, data);
      await loadRequirements(includeInactive: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> deleteRequirement(String id) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _repository.deleteCertificationRequirement(id);
      await loadRequirements(includeInactive: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}
