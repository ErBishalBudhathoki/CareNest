import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/features/training_compliance/repositories/training_compliance_repository.dart';
import 'package:carenest/app/features/training_compliance/viewmodels/certifications_viewmodel.dart';
import 'package:carenest/app/features/training_compliance/viewmodels/training_viewmodel.dart';
import 'package:carenest/app/features/training_compliance/viewmodels/compliance_viewmodel.dart';
import 'package:carenest/app/features/training_compliance/viewmodels/certification_requirements_viewmodel.dart';

final trainingComplianceRepositoryProvider =
    Provider<TrainingComplianceRepository>((ref) {
  return TrainingComplianceRepository(
      ref.read(app_providers.apiMethodProvider));
});

final certificationsViewModelProvider =
    StateNotifierProvider<CertificationsViewModel, CertificationsState>((ref) {
  return CertificationsViewModel(
      ref.watch(trainingComplianceRepositoryProvider));
});

final trainingViewModelProvider =
    StateNotifierProvider<TrainingViewModel, TrainingState>((ref) {
  return TrainingViewModel(ref.watch(trainingComplianceRepositoryProvider));
});

final complianceViewModelProvider =
    StateNotifierProvider<ComplianceViewModel, ComplianceState>((ref) {
  return ComplianceViewModel(ref.watch(trainingComplianceRepositoryProvider));
});

final certificationRequirementsViewModelProvider =
    StateNotifierProvider<CertificationRequirementsViewModel,
        CertificationRequirementsState>((ref) {
  return CertificationRequirementsViewModel(
      ref.watch(trainingComplianceRepositoryProvider));
});
