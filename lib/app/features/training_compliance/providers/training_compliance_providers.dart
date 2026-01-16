import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/training_compliance/repositories/training_compliance_repository.dart';
import 'package:carenest/app/features/training_compliance/viewmodels/certifications_viewmodel.dart';
import 'package:carenest/app/features/training_compliance/viewmodels/training_viewmodel.dart';
import 'package:carenest/app/features/training_compliance/viewmodels/compliance_viewmodel.dart';

final trainingComplianceRepositoryProvider = Provider<TrainingComplianceRepository>((ref) {
  return TrainingComplianceRepository(ApiMethod());
});

final certificationsViewModelProvider = StateNotifierProvider<CertificationsViewModel, CertificationsState>((ref) {
  return CertificationsViewModel(ref.watch(trainingComplianceRepositoryProvider));
});

final trainingViewModelProvider = StateNotifierProvider<TrainingViewModel, TrainingState>((ref) {
  return TrainingViewModel(ref.watch(trainingComplianceRepositoryProvider));
});

final complianceViewModelProvider = StateNotifierProvider<ComplianceViewModel, ComplianceState>((ref) {
  return ComplianceViewModel(ref.watch(trainingComplianceRepositoryProvider));
});
