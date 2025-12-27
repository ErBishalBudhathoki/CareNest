import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/invoice/models/pricing_settings.dart';
import 'package:carenest/app/features/invoice/repositories/pricing_settings_repository.dart';
import 'package:carenest/app/features/invoice/viewmodels/pricing_settings_view_model.dart';
import 'package:carenest/app/core/providers/app_providers.dart' show apiMethodProvider;

/// Provider for PricingSettingsRepository using the shared ApiMethod.
final pricingSettingsRepositoryProvider = Provider<PricingSettingsRepository>((ref) {
  final api = ref.watch(apiMethodProvider);
  return PricingSettingsRepository(api);
});

/// Default initial settings used to bootstrap the ViewModel state.
/// Adjust in the UI before saving to match user selections.
final _defaultPricingSettingsProvider = Provider<PricingSettings>((ref) {
  return const PricingSettings(
    defaultCurrency: 'AUD',
    pricingModel: 'NDIS Standard',
    roundingMethod: 'Round to nearest cent',
    taxCalculation: 'GST Inclusive',
    defaultMarkup: 10.0,
    maxPriceVariation: 5.0,
    priceHistoryRetention: 365,
    bulkOperationLimit: 500,
    autoUpdatePricing: true,
    enablePriceValidation: true,
    requireApprovalForChanges: false,
    enableBulkOperations: true,
    enablePriceHistory: true,
    enableNotifications: false,
  );
});

/// ViewModel provider for pricing settings, wired to the repository.
final pricingSettingsViewModelProvider = ChangeNotifierProvider<PricingSettingsViewModel>((ref) {
  final repo = ref.watch(pricingSettingsRepositoryProvider);
  final initial = ref.watch(_defaultPricingSettingsProvider);
  return PricingSettingsViewModel(repo, initial: initial);
});