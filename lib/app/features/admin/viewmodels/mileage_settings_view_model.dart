import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/admin/repositories/organization_repository.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import '../models/mileage_settings_state.dart';

class MileageSettingsViewModel extends Notifier<MileageSettingsState> {
  late final OrganizationRepository _repository;

  @override
  MileageSettingsState build() {
    _repository = ref.watch(organizationRepositoryProvider);
    _loadSettings();
    return const MileageSettingsState();
  }

  Future<void> _loadSettings() async {
    state = state.copyWith(isLoading: true);
    try {
      final prefs = await SharedPreferencesUtils.getInstance();
      final orgId = prefs.getOrganizationId();
      if (orgId != null) {
        final org = await _repository.getOrganization(orgId);
        if (org != null && org['reimbursementRate'] != null) {
          state = state.copyWith(
            reimbursementRate: (org['reimbursementRate'] as num).toDouble(),
            isLoading: false,
          );
        } else {
          state = state.copyWith(isLoading: false);
        }
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> updateRate(double newRate) async {
    state = state.copyWith(isLoading: true);
    try {
      final prefs = await SharedPreferencesUtils.getInstance();
      final orgId = prefs.getOrganizationId();
      if (orgId != null) {
        await _repository.updateOrganization(orgId, {'reimbursementRate': newRate});
        state = state.copyWith(reimbursementRate: newRate, isLoading: false);
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final mileageSettingsViewModelProvider =
    NotifierProvider<MileageSettingsViewModel, MileageSettingsState>(
  MileageSettingsViewModel.new,
);
