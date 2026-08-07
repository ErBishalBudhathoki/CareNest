import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/features/invoice/repositories/pricing_settings_repository.dart';
import 'package:carenest/app/features/invoice/viewmodels/pricing_settings_view_model.dart';
import 'package:carenest/app/features/invoice/models/pricing_settings.dart';

final pricingSettingsRepositoryProvider = Provider<PricingSettingsRepository>((
  ref,
) {
  final api = ref.read(app_providers.apiMethodProvider);
  return PricingSettingsRepository(api);
});

final defaultPricingSettingsProvider = Provider<PricingSettings>((ref) {
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

final pricingSettingsViewModelProvider =
    NotifierProvider<PricingSettingsViewModel, PricingSettingsState>(
      () => PricingSettingsViewModel(null),
    );
