import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/stakeholders/models/stakeholder_models.dart';
import 'package:carenest/app/features/stakeholders/repositories/stakeholder_repository.dart';

class CareTeamState {
  final bool isLoading;
  final String? error;
  final ClientCareTeam? careTeam;
  final List<Stakeholder> allStakeholders;

  CareTeamState({
    this.isLoading = false,
    this.error,
    this.careTeam,
    this.allStakeholders = const [],
  });

  CareTeamState copyWith({
    bool? isLoading,
    String? error,
    ClientCareTeam? careTeam,
    List<Stakeholder>? allStakeholders,
  }) {
    return CareTeamState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      careTeam: careTeam ?? this.careTeam,
      allStakeholders: allStakeholders ?? this.allStakeholders,
    );
  }
}

/// Care-team state for a single client (Phase 5), keyed by clientId.
class CareTeamViewModel extends Notifier<CareTeamState> {
  CareTeamViewModel(this.clientId);
  final String clientId;

  StakeholderRepository get _repository =>
      ref.read(stakeholderRepositoryProvider);

  @override
  CareTeamState build() {
    ref.watch(stakeholderRepositoryProvider);
    return CareTeamState();
  }

  Future<void> load() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final careTeam = await _repository.getCareTeam(clientId);
      final all = await _repository.getStakeholders();
      state = state.copyWith(
        isLoading: false,
        careTeam: careTeam,
        allStakeholders: all,
      );
    } catch (e) {
      debugPrint('Error loading care team: $e');
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<bool> createStakeholder(Map<String, dynamic> body) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repository.createStakeholder(body);
      final all = await _repository.getStakeholders();
      state = state.copyWith(isLoading: false, allStakeholders: all);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> link({
    required String stakeholderId,
    String? role,
    bool? isPrimary,
    String? fundingType,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repository.linkStakeholder(
        clientId,
        stakeholderId: stakeholderId,
        role: role,
        isPrimary: isPrimary,
        fundingType: fundingType,
      );
      await load();
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> unlink(String stakeholderId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repository.unlinkStakeholder(clientId, stakeholderId);
      await load();
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }
}

final careTeamViewModelProvider =
    NotifierProvider.family<CareTeamViewModel, CareTeamState, String>(
      CareTeamViewModel.new,
    );
