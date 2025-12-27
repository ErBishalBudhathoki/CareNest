import 'package:flutter/foundation.dart';
import 'package:carenest/backend/api_method.dart';

/// Exception type for fallback pricing operations.
class FallbackPricingException implements Exception {
  final String message;
  FallbackPricingException(this.message);
  @override
  String toString() => message;
}

/// Repository responsible for fetching and updating the organization fallback base rate.
///
/// This is the only layer that performs API calls for fallback pricing, using
/// the underlying `ApiMethod` client. It provides typed responses and throws
/// `FallbackPricingException` on failures.
class FallbackPricingRepository {
  final ApiMethod _api;
  FallbackPricingRepository(this._api);

  /// Load the configured fallback base rate for the given organization.
  ///
  /// Returns the rate as a double when configured, or null if not set.
  /// Throws `FallbackPricingException` on network or server errors.
  Future<double?> getFallbackBaseRate({required String organizationId}) async {
    try {
      return await _api.getFallbackBaseRate(organizationId);
    } catch (e) {
      debugPrint('getFallbackBaseRate error: $e');
      throw FallbackPricingException('Failed to load fallback base rate');
    }
  }

  /// Update the fallback base rate for the organization.
  ///
  /// Returns the persisted numeric rate on success.
  /// Throws `FallbackPricingException` with a user-friendly message on failure.
  Future<double> setFallbackBaseRate({
    required String organizationId,
    required double fallbackBaseRate,
    required String userEmail,
  }) async {
    try {
      final result = await _api.setFallbackBaseRate(
        organizationId,
        fallbackBaseRate,
        userEmail,
      );
      if (result['success'] == true) {
        return (result['fallbackBaseRate'] as num).toDouble();
      }
      throw FallbackPricingException(
          result['message'] ?? 'Failed to update fallback base rate');
    } catch (e) {
      debugPrint('setFallbackBaseRate error: $e');
      throw FallbackPricingException('Error updating fallback base rate');
    }
  }
}