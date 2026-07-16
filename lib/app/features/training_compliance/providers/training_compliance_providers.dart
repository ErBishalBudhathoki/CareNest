import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    NotifierProvider<CertificationsViewModel, CertificationsState>(CertificationsViewModel.new);

final trainingViewModelProvider =
    NotifierProvider<TrainingViewModel, TrainingState>(TrainingViewModel.new);

final complianceViewModelProvider =
    NotifierProvider<ComplianceViewModel, ComplianceState>(ComplianceViewModel.new);

final certificationRequirementsViewModelProvider =
    NotifierProvider<CertificationRequirementsViewModel,
        CertificationRequirementsState>(CertificationRequirementsViewModel.new);
