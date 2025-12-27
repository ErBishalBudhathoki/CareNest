import 'package:flutter/foundation.dart';

import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/invoice/models/pricing_settings.dart';

/// Typed exception for PricingSettings repository operations.
class PricingSettingsException implements Exception {
  final String message;
  final Map<String, dynamic>? details;

  /// Creates a new PricingSettingsException with an error message and optional details.
  const PricingSettingsException(this.message, {this.details});

  @override
  String toString() => 'PricingSettingsException: $message';
}

/// Repository responsible for persisting and retrieving general pricing settings.
///
/// Handles API calls and maps responses to `PricingSettings` models.
class PricingSettingsRepository {
  final ApiMethod _apiMethod;

  /// Construct the repository with an injected `ApiMethod`.
  PricingSettingsRepository(this._apiMethod);

  /// Update general pricing settings atomically for the given organization.
  ///
  /// Parameters:
  /// - [organizationId]: Organization context for the update.
  /// - [settings]: The pricing settings to be persisted.
  ///
  /// Returns the sanitized, persisted `PricingSettings` from the backend.
  /// Throws `PricingSettingsException` on validation or server errors.
  Future<PricingSettings> updateGeneralSettings({
    required String organizationId,
    required PricingSettings settings,
  }) async {
    try {
      final result = await _apiMethod.updateGeneralPricingSettings(
        organizationId,
        settings.toJson(),
      );

      final success = (result['success'] as bool?) ?? false;
      if (!success) {
        final message = (result['message'] as String?) ?? 'Failed to update settings';
        debugPrint('PricingSettingsRepository: update failed: $message');
        throw PricingSettingsException(message, details: result);
      }

      final data = (result['data'] as Map<String, dynamic>?);
      if (data == null) {
        throw const PricingSettingsException('Missing data in update response');
      }
      return PricingSettings.fromJson(data);
    } catch (e) {
      if (e is PricingSettingsException) rethrow;
      debugPrint('PricingSettingsRepository: exception during update: $e');
      throw PricingSettingsException('Error updating settings: $e');
    }
  }
}