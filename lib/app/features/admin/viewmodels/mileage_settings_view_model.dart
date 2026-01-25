import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/admin/repositories/organization_repository.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';

class MileageSettingsState {
  final bool isLoading;
  final double reimbursementRate;
  final String? error;

  MileageSettingsState({
    this.isLoading = false,
    this.reimbursementRate = 0.99, // Default SCHADS
    this.error,
  });

  MileageSettingsState copyWith({
    bool? isLoading,
    double? reimbursementRate,
    String? error,
  }) {
    return MileageSettingsState(
      isLoading: isLoading ?? this.isLoading,
      reimbursementRate: reimbursementRate ?? this.reimbursementRate,
      error: error,
    );
  }
}

class MileageSettingsViewModel extends StateNotifier<MileageSettingsState> {
  final OrganizationRepository _repository;

  MileageSettingsViewModel(this._repository) : super(MileageSettingsState()) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    state = state.copyWith(isLoading: true);
    try {
      final prefs = await SharedPreferencesUtils.getInstance();
      final orgId = prefs.getOrganizationId();
      if (orgId != null) {
        final org = await _repository.getOrganization(orgId);
        // Assuming org model has reimbursementRate
        // If not, we use default or fetch from separate config endpoint
        // For now, assuming it's part of org profile or we use a dedicated settings API
        if (org != null && org['reimbursementRate'] != null) {
           state = state.copyWith(
             reimbursementRate: (org['reimbursementRate'] as num).toDouble(),
             isLoading: false
           );
        } else {
           state = state.copyWith(isLoading: false);
        }
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
        // Call repo to update
        await _repository.updateOrganization(orgId, {'reimbursementRate': newRate});
        state = state.copyWith(reimbursementRate: newRate, isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final mileageSettingsViewModelProvider = 
    StateNotifierProvider<MileageSettingsViewModel, MileageSettingsState>((ref) {
  final repo = ref.watch(organizationRepositoryProvider);
  return MileageSettingsViewModel(repo);
});
