import 'package:flutter/foundation.dart';

import 'package:carenest/app/features/invoice/models/pricing_settings.dart';
import 'package:carenest/app/features/invoice/repositories/pricing_settings_repository.dart';

/// ViewModel for General Pricing Settings.
///
/// Encapsulates business logic, input validation, and save lifecycle
/// for organization-wide pricing settings. Exposes loading and error states.
class PricingSettingsViewModel extends ChangeNotifier {
  final PricingSettingsRepository _repository;

  PricingSettings _settings;
  bool _isLoading = false;
  String? _errorMessage;
  bool _saveSucceeded = false;

  /// Construct the ViewModel with a repository and initial settings state.
  PricingSettingsViewModel(this._repository, {required PricingSettings initial})
      : _settings = initial;

  /// Current settings state bound to the UI.
  PricingSettings get settings => _settings;

  /// Loading flag for save operations.
  bool get isLoading => _isLoading;

  /// Last error message, if any.
  String? get errorMessage => _errorMessage;

  /// True when the last save operation succeeded.
  bool get saveSucceeded => _saveSucceeded;

  /// Update the settings model using copyWith and notify listeners.
  ///
  /// Parameters: partial fields to update on the settings state.
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
    _settings = _settings.copyWith(
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
    );
    notifyListeners();
  }

  /// Validate current settings according to business rules.
  /// Returns `true` if valid and clears any error message; otherwise sets a user-friendly error.
  bool validate() {
    // Currency must be a 3-letter uppercase code
    final cur = _settings.defaultCurrency.trim();
    if (cur.length != 3 || !RegExp(r'^[A-Z]{3}$').hasMatch(cur)) {
      _errorMessage = 'Currency must be a 3-letter code (e.g., AUD).';
      notifyListeners();
      return false;
    }

    // pricingModel and roundingMethod required, <= 100 chars
    if (_settings.pricingModel.isEmpty || _settings.pricingModel.length > 100) {
      _errorMessage = 'Pricing model is required and must be <= 100 characters.';
      notifyListeners();
      return false;
    }
    if (_settings.roundingMethod.isEmpty || _settings.roundingMethod.length > 100) {
      _errorMessage = 'Rounding method is required and must be <= 100 characters.';
      notifyListeners();
      return false;
    }

    // Tax calculation must be one of the allowed values
    const allowedTax = {'GST Inclusive', 'GST Exclusive'};
    if (!allowedTax.contains(_settings.taxCalculation)) {
      _errorMessage = 'Tax calculation must be GST Inclusive or GST Exclusive.';
      notifyListeners();
      return false;
    }

    // Percent ranges
    if (_settings.defaultMarkup < 0 || _settings.defaultMarkup > 100) {
      _errorMessage = 'Default markup must be between 0 and 100.';
      notifyListeners();
      return false;
    }
    if (_settings.maxPriceVariation < 0 || _settings.maxPriceVariation > 100) {
      _errorMessage = 'Max price variation must be between 0 and 100.';
      notifyListeners();
      return false;
    }

    // Integer ranges
    if (_settings.priceHistoryRetention < 1 || _settings.priceHistoryRetention > 3650) {
      _errorMessage = 'Price history retention must be 1–3650 days.';
      notifyListeners();
      return false;
    }
    if (_settings.bulkOperationLimit < 1 || _settings.bulkOperationLimit > 10000) {
      _errorMessage = 'Bulk operation limit must be 1–10000.';
      notifyListeners();
      return false;
    }

    _errorMessage = null;
    return true;
  }

  /// Save the current settings to the backend.
  ///
  /// Parameters:
  /// - [organizationId]: Organization context used for the update.
  ///
  /// Sets loading/error/success states and updates local settings with the sanitized backend response.
  Future<void> save(String organizationId) async {
    if (!validate()) return;
    _isLoading = true;
    _saveSucceeded = false;
    _errorMessage = null;
    notifyListeners();

    try {
      final persisted = await _repository.updateGeneralSettings(
        organizationId: organizationId,
        settings: _settings,
      );
      _settings = persisted;
      _saveSucceeded = true;
    } catch (e) {
      _errorMessage = e.toString();
      _saveSucceeded = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}