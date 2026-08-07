import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/features/invoice/repositories/fallback_pricing_repository.dart';
import 'package:carenest/app/features/invoice/viewmodels/fallback_pricing_view_model.dart';

final fallbackPricingRepositoryProvider = Provider<FallbackPricingRepository>((
  ref,
) {
  final api = ref.read(app_providers.apiMethodProvider);
  return FallbackPricingRepository(api);
});

final fallbackPricingViewModelProvider =
    NotifierProvider<FallbackPricingViewModel, FallbackPricingState>(
      FallbackPricingViewModel.new,
    );
