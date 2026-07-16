import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/organization/models/organization_model.dart';
import 'package:carenest/app/features/organization/models/organization_branding.dart';
import 'package:carenest/app/features/organization/repositories/organization_repository.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/core/providers/core_providers.dart';

// State class for Organization
class OrganizationState {
  final Organization? currentOrganization;
  final OrganizationBranding? branding;
  final List<dynamic> userOrganizations;
  final bool isLoading;
  final String? error;

  const OrganizationState({
    this.currentOrganization,
    this.branding,
    this.userOrganizations = const [],
    this.isLoading = false,
    this.error,
  });

  OrganizationState copyWith({
    Organization? currentOrganization,
    OrganizationBranding? branding,
    List<dynamic>? userOrganizations,
    bool? isLoading,
    String? error,
  }) {
    return OrganizationState(
      currentOrganization: currentOrganization ?? this.currentOrganization,
      branding: branding ?? this.branding,
      userOrganizations: userOrganizations ?? this.userOrganizations,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

// Notifier
class OrganizationNotifier extends Notifier<OrganizationState> {
  late final OrganizationRepository _repository;
  late final SharedPreferencesUtils _prefs;

  @override
  OrganizationState build() {
    _repository = ref.watch(organizationRepositoryProvider);
    _prefs = ref.watch(sharedPreferencesProvider);
    loadUserOrganizations();
    return const OrganizationState();
  }

  Future<void> loadUserOrganizations() async {
    state = state.copyWith(isLoading: true);
    try {
      final orgs = await _repository.getUserOrganizations();
      state = state.copyWith(
        userOrganizations: orgs,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  Future<void> loadOrganization(String orgId) async {
    state = state.copyWith(isLoading: true);
    try {
      final org = await _repository.getOrganization(orgId);
      state = state.copyWith(
        currentOrganization: org,
        isLoading: false,
      );
      // Also load branding if organization is loaded successfully
      if (org != null) {
        loadBranding(orgId);
      }
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  Future<void> switchOrganization(String orgId) async {
    state = state.copyWith(isLoading: true);
    try {
      final result = await _repository.switchOrganization(orgId);
      if (result != null) {
        await _prefs.setOrganizationId(orgId);
        await loadUserOrganizations();
        // Optionally load branding
        loadBranding(orgId);
      }
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  Future<void> loadBranding(String orgId) async {
    try {
      final brandingData = await _repository.getBranding(orgId);
      if (brandingData != null) {
        state = state.copyWith(
          branding: OrganizationBranding.fromBackend(brandingData),
        );
      }
    } catch (e) {
      print('Failed to load branding: $e');
    }
  }

  Future<bool> updateBranding(String orgId, Map<String, dynamic> brandingData) async {
    try {
      await _repository.updateBranding(orgId, brandingData);
      // Reload branding to update state
      await loadBranding(orgId);
      return true;
    } catch (e) {
      print('Failed to update branding: $e');
      return false;
    }
  }
}

// Provider
final organizationProvider =
    NotifierProvider<OrganizationNotifier, OrganizationState>(OrganizationNotifier.new);
