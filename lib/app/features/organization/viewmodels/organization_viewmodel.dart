import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:carenest/app/features/organization/models/organization_model.dart';
import 'package:carenest/app/features/organization/repositories/organization_repository.dart';

final organizationViewModelProvider =
    StateNotifierProvider<OrganizationViewModel, AsyncValue<Organization?>>(
        (ref) {
  final repository = ref.watch(organizationRepositoryProvider);
  return OrganizationViewModel(repository);
});

class OrganizationViewModel extends StateNotifier<AsyncValue<Organization?>> {
  final OrganizationRepository _repository;

  OrganizationViewModel(this._repository) : super(const AsyncValue.loading());

  Future<void> loadOrganization(String id) async {
    state = const AsyncValue.loading();
    try {
      final organization = await _repository.getOrganization(id);
      state = AsyncValue.data(organization);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<bool> saveOrganization(String id, Map<String, dynamic> updates) async {
    // Keep current state while saving, or maybe switch to a specific "saving" state if UI requires it
    // For now, we won't set state to loading to avoid flicker, as we might want to just show a spinner on the button
    try {
      await _repository.updateOrganization(id, updates);
      // Refresh data
      await loadOrganization(id);
      return true;
    } catch (e) {
      // We don't change the main state to error because we want to keep the form visible
      // The UI should handle the error toast/snackbar based on the return value or a side-effect provider
      return false;
    }
  }

  Future<bool> updateBranding(String id, Map<String, dynamic> brandingData) async {
    try {
      await _repository.updateBranding(id, brandingData);
      await loadOrganization(id);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String?> uploadLogo(File file) async {
    try {
      return await _repository.uploadLogo(file);
    } catch (e) {
      // Allow UI to handle specific error if needed
      rethrow;
    }
  }
}
