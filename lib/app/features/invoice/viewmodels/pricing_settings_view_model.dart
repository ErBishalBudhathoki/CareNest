import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:carenest/app/features/invoice/repositories/pricing_settings_repository.dart';
import 'package:carenest/app/features/invoice/models/pricing_settings.dart';
import 'package:carenest/app/features/invoice/providers/pricing_settings_providers.dart';

part 'pricing_settings_view_model.freezed.dart';

@freezed
abstract class PricingSettingsState with _$PricingSettingsState {
  const factory PricingSettingsState({
    required PricingSettings settings,
    @Default(false) bool isLoading,
    String? errorMessage,
    @Default(false) bool saveSucceeded,
  }) = _PricingSettingsState;
}

class PricingSettingsViewModel extends Notifier<PricingSettingsState> {
  late final PricingSettingsRepository _repository;
  PricingSettingsViewModel([PricingSettings? initial]);

  @override
  PricingSettingsState build() {
    _repository = ref.watch(pricingSettingsRepositoryProvider);
    final initial = ref.watch(defaultPricingSettingsProvider);
    return PricingSettingsState(settings: initial);
  }

  void updateSettings({
    String? defaultCurrency,
    String? pricingModel,
    String? roundingMethod,
    String? taxCalculation,
    double? defaultMarkup,
    double? maxPriceVariation,
    int? priceHistoryRetention,
    int? bulkOperationLimit,
    bool? autoUpdatePricing,
    bool? enablePriceValidation,
    bool? requireApprovalForChanges,
    bool? enableBulkOperations,
    bool? enablePriceHistory,
    bool? enableNotifications,
  }) {
    state = state.copyWith(
      settings: state.settings.copyWith(
        defaultCurrency: defaultCurrency,
        pricingModel: pricingModel,
        roundingMethod: roundingMethod,
        taxCalculation: taxCalculation,
        defaultMarkup: defaultMarkup,
        maxPriceVariation: maxPriceVariation,
        priceHistoryRetention: priceHistoryRetention,
        bulkOperationLimit: bulkOperationLimit,
        autoUpdatePricing: autoUpdatePricing,
        enablePriceValidation: enablePriceValidation,
        requireApprovalForChanges: requireApprovalForChanges,
        enableBulkOperations: enableBulkOperations,
        enablePriceHistory: enablePriceHistory,
        enableNotifications: enableNotifications,
      ),
      errorMessage: null,
    );
  }

  bool _validate() {
    final cur = state.settings.defaultCurrency.trim();
    if (cur.length != 3 || !RegExp(r'^[A-Z]{3}$').hasMatch(cur)) {
      state = state.copyWith(
        errorMessage: 'Currency must be a 3-letter code (e.g., AUD).',
      );
      return false;
    }
    if (state.settings.pricingModel.isEmpty ||
        state.settings.pricingModel.length > 100) {
      state = state.copyWith(
        errorMessage:
            'Pricing model is required and must be <= 100 characters.',
      );
      return false;
    }
    if (state.settings.roundingMethod.isEmpty ||
        state.settings.roundingMethod.length > 100) {
      state = state.copyWith(
        errorMessage:
            'Rounding method is required and must be <= 100 characters.',
      );
      return false;
    }
    const allowedTax = {'GST Inclusive', 'GST Exclusive'};
    if (!allowedTax.contains(state.settings.taxCalculation)) {
      state = state.copyWith(
        errorMessage: 'Tax calculation must be GST Inclusive or GST Exclusive.',
      );
      return false;
    }
    if (state.settings.defaultMarkup < 0 ||
        state.settings.defaultMarkup > 100) {
      state = state.copyWith(
        errorMessage: 'Default markup must be between 0 and 100.',
      );
      return false;
    }
    if (state.settings.maxPriceVariation < 0 ||
        state.settings.maxPriceVariation > 100) {
      state = state.copyWith(
        errorMessage: 'Max price variation must be between 0 and 100.',
      );
      return false;
    }
    if (state.settings.priceHistoryRetention < 1 ||
        state.settings.priceHistoryRetention > 3650) {
      state = state.copyWith(
        errorMessage: 'Price history retention must be 1–3650 days.',
      );
      return false;
    }
    if (state.settings.bulkOperationLimit < 1 ||
        state.settings.bulkOperationLimit > 10000) {
      state = state.copyWith(
        errorMessage: 'Bulk operation limit must be 1–10000.',
      );
      return false;
    }
    state = state.copyWith(errorMessage: null);
    return true;
  }

  Future<void> save(String organizationId) async {
    if (!_validate()) return;

    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      saveSucceeded: false,
    );

    try {
      final persisted = await _repository.updateGeneralSettings(
        organizationId: organizationId,
        settings: state.settings,
      );
      state = state.copyWith(settings: persisted, saveSucceeded: true);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), saveSucceeded: false);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
