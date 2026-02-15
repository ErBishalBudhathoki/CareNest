import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import '../repositories/onboarding_repository.dart';
import '../viewmodels/onboarding_viewmodel.dart';
import '../viewmodels/admin_onboarding_viewmodel.dart';

// ApiMethod Provider
final apiMethodProvider = Provider<ApiMethod>((ref) {
  return ref.read(app_providers.apiMethodProvider);
});

// Repository Provider
final onboardingRepositoryProvider = Provider<OnboardingRepository>((ref) {
  final apiMethod = ref.watch(apiMethodProvider);
  return OnboardingRepository(apiMethod);
});

// ViewModel Provider (User)
final onboardingViewModelProvider =
    StateNotifierProvider<OnboardingViewModel, OnboardingState>((ref) {
  final repository = ref.watch(onboardingRepositoryProvider);
  return OnboardingViewModel(repository);
});

// ViewModel Provider (Admin)
final adminOnboardingViewModelProvider =
    StateNotifierProvider<AdminOnboardingViewModel, AdminOnboardingState>(
        (ref) {
  final repository = ref.watch(onboardingRepositoryProvider);
  return AdminOnboardingViewModel(repository);
});
