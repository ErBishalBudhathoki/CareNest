import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/features/onboarding/repositories/onboarding_repository.dart';
import 'package:carenest/backend/api_method.dart';

enum OnboardingGateTarget {
  dashboard,
  welcome,
}

class OnboardingGateService {
  OnboardingGateService({
    OnboardingRepository? repository,
  }) : _repository = repository ?? OnboardingRepository(ApiMethod());

  final OnboardingRepository _repository;

  Future<OnboardingGateTarget> resolveTarget({
    required UserRole role,
    String? userId,
    String? email,
  }) async {
    if (role != UserRole.employee) {
      return OnboardingGateTarget.dashboard;
    }

    try {
      final record = await _repository.getOnboardingStatus();
      if (const {'submitted', 'review_pending', 'completed'}
          .contains(record.status)) {
        return OnboardingGateTarget.dashboard;
      }

      return OnboardingGateTarget.welcome;
    } catch (_) {
      return OnboardingGateTarget.dashboard;
    }
  }
}
