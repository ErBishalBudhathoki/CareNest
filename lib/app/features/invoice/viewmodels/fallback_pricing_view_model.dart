import 'package:flutter/foundation.dart';

import 'package:carenest/app/features/invoice/repositories/fallback_pricing_repository.dart';

/// ViewModel managing fallback pricing state, validation, and save lifecycle.
///
/// Encapsulates business rules to determine when fallback pricing is required
/// and provides methods to load and update the organization fallback base rate.
class FallbackPricingViewModel extends ChangeNotifier {
  final FallbackPricingRepository _repository;

  double? _fallbackRate;
  bool _isLoading = false;
  String? _errorMessage;
  bool _saveSucceeded = false;

  FallbackPricingViewModel(this._repository);

  /// Currently configured fallback rate (null when not set).
  double? get fallbackRate => _fallbackRate;

  /// Loading flag for async operations.
  bool get isLoading => _isLoading;

  /// Last error message, if any.
  String? get errorMessage => _errorMessage;

  /// True when the last save operation succeeded.
  bool get saveSucceeded => _saveSucceeded;

  /// Load fallback base rate from backend and update state.
  Future<void> load(String organizationId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _fallbackRate = await _repository.getFallbackBaseRate(
        organizationId: organizationId,
      );
      _saveSucceeded = false;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Validate a candidate fallback rate according to business requirements.
  ///
  /// Returns true if valid; otherwise sets a user-friendly error message.
  bool validateRate(double? rate) {
    if (rate == null || rate <= 0) {
      _errorMessage = 'Please enter a valid positive amount.';
      notifyListeners();
      return false;
    }
    // Extend with additional rules (e.g., max cap constraints) if required.
    _errorMessage = null;
    return true;
  }

  /// Save the fallback rate via the repository.
  Future<void> save({
    required String organizationId,
    required double fallbackRate,
    required String userEmail,
  }) async {
    if (!validateRate(fallbackRate)) return;
    _isLoading = true;
    _saveSucceeded = false;
    notifyListeners();
    try {
      final persisted = await _repository.setFallbackBaseRate(
        organizationId: organizationId,
        fallbackBaseRate: fallbackRate,
        userEmail: userEmail,
      );
      _fallbackRate = persisted;
      _saveSucceeded = true;
    } catch (e) {
      _errorMessage = e.toString();
      _saveSucceeded = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Determine if fallback pricing is required based on supplied context.
  ///
  /// Parameters:
  /// - [hasPrimaryRate]: true if a client/organization-specific rate exists.
  /// - [hasServiceRate]: true if a defined service rate is available.
  /// - [integrationConnected]: external pricing integration is connected.
  /// - [validationPassed]: pricing validation rules passed.
  ///
  /// Returns true when the system should use fallback pricing. This is a
  /// central hook for business rules that can be extended without touching
  /// UI components.
  bool evaluateFallbackNeed({
    required bool hasPrimaryRate,
    required bool hasServiceRate,
    required bool integrationConnected,
    required bool validationPassed,
  }) {
    // Basic rule: fallback when there is no primary nor service rate.
    if (!hasPrimaryRate && !hasServiceRate) return true;

    // If the external integration is disconnected, consider fallback.
    if (!integrationConnected) return true;

    // If validation fails, avoid fallback unless explicitly allowed.
    if (!validationPassed) return false;

    return false;
  }
}