import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/features/invoice/repositories/fallback_pricing_repository.dart';
import 'package:carenest/app/features/invoice/viewmodels/fallback_pricing_view_model.dart';

/// Provider for FallbackPricingRepository wired to ApiMethod.
final fallbackPricingRepositoryProvider =
    Provider<FallbackPricingRepository>((ref) {
  final api = ref.read(app_providers.apiMethodProvider);
  return FallbackPricingRepository(api);
});

/// ChangeNotifier provider for FallbackPricingViewModel.
final fallbackPricingViewModelProvider =
    ChangeNotifierProvider<FallbackPricingViewModel>((ref) {
  final repo = ref.watch(fallbackPricingRepositoryProvider);
  return FallbackPricingViewModel(repo);
});
