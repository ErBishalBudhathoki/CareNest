import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/core_providers.dart';
import 'package:carenest/app/features/organization/models/organization_model.dart';
import 'package:carenest/app/features/organization/models/organization_branding.dart';
import 'package:flutter/foundation.dart';

final organizationRepositoryProvider = Provider<OrganizationRepository>((ref) {
  final apiMethod = ref.read(apiMethodProvider);
  return OrganizationRepository(apiMethod);
});

class OrganizationRepository {
  final ApiMethod _api;

  OrganizationRepository(this._api);

  /// Fetches organization details by ID
  Future<Organization?> getOrganization(String id) async {
    try {
      final response = await _api.get('organization/$id');

      if (response['success'] == false && response['statusCode'] != 200) {
        throw Exception(response['message'] ?? 'Failed to fetch organization');
      }

      final data = response['organization'] ?? response['data'];
      if (data == null) return null;

      return Organization.fromBackend(data);
    } catch (e) {
      debugPrint('Error fetching organization: $e');
      rethrow;
    }
  }

  /// Fetches raw organization data (useful for dynamic fields not in the model)
  Future<Map<String, dynamic>?> getOrganizationData(String id) async {
    try {
      final response = await _api.get('organization/$id');
      return response['organization'] ?? response['data'];
    } catch (e) {
      debugPrint('Error fetching organization data: $e');
      return null;
    }
  }

  /// Updates organization details
  Future<void> updateOrganization(
      String id, Map<String, dynamic> updates) async {
    try {
      final response = await _api.put('organization/$id', body: updates);

      if (response['success'] == false && response['statusCode'] != 200) {
        throw Exception(response['message'] ?? 'Failed to update organization');
      }
    } catch (e) {
      debugPrint('Error updating organization: $e');
      rethrow;
    }
  }

  /// Get user's organizations
  Future<List<dynamic>> getUserOrganizations() async {
    try {
      final response = await _api.get('organization/user/my-organizations');
      if (response['success'] == false && response['statusCode'] != 200) {
        // Fallback or throw?
        return [];
      }
      return response['data'] ?? [];
    } catch (e) {
      debugPrint('Error getting user organizations: $e');
      return [];
    }
  }

  /// Switch organization context
  Future<Map<String, dynamic>?> switchOrganization(
      String organizationId) async {
    try {
      final response = await _api.post('organization/switch/$organizationId');
      if (response['success'] == false && response['statusCode'] != 200) {
        throw Exception(response['message'] ?? 'Failed to switch organization');
      }
      return response['data'];
    } catch (e) {
      debugPrint('Error switching organization: $e');
      rethrow;
    }
  }

  /// Uploads organization logo
  Future<String> uploadLogo(File file) async {
    try {
      return await _api.uploadLogoFile(file);
    } catch (e) {
      debugPrint('Error uploading logo: $e');
      rethrow;
    }
  }

  /// Get branding
  Future<Map<String, dynamic>?> getBranding(String organizationId) async {
    try {
      final response = await _api.get('organization/$organizationId/branding');
      if (response['success'] == false && response['statusCode'] != 200) {
        return null;
      }
      return response['data'];
    } catch (e) {
      debugPrint('Error getting branding: $e');
      return null;
    }
  }

  /// Update branding
  Future<OrganizationBranding?> updateBranding(
      String organizationId, Map<String, dynamic> brandingData) async {
    try {
      final response = await _api.put('organization/$organizationId/branding',
          body: brandingData);
      if (response['success'] == false && response['statusCode'] != 200) {
        throw Exception(response['message'] ?? 'Failed to update branding');
      }
      return OrganizationBranding.fromBackend(response['data']);
    } catch (e) {
      debugPrint('Error updating branding: $e');
      rethrow;
    }
  }
}
