import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/invoice/repositories/fallback_pricing_repository.dart';
import 'package:carenest/app/features/invoice/viewmodels/fallback_pricing_view_model.dart';

/// Provider for FallbackPricingRepository wired to ApiMethod.
final fallbackPricingRepositoryProvider = Provider<FallbackPricingRepository>((ref) {
  final api = ApiMethod();
  return FallbackPricingRepository(api);
});

/// ChangeNotifier provider for FallbackPricingViewModel.
final fallbackPricingViewModelProvider =
    ChangeNotifierProvider<FallbackPricingViewModel>((ref) {
  final repo = ref.watch(fallbackPricingRepositoryProvider);
  return FallbackPricingViewModel(repo);
});