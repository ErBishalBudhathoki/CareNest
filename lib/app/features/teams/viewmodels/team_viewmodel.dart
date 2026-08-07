import 'package:flutter/foundation.dart';
import 'package:carenest/app/features/teams/models/team_models.dart';
import 'package:carenest/app/features/teams/repositories/team_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeamState {
  final List<Team> teams;
  final List<EmergencyBroadcast> activeBroadcasts;
  final List<EmergencyBroadcast> broadcastHistory;
  final List<TeamMember> availableUsers;
  final bool isLoading;
  final String? errorMessage;

  TeamState({
    this.teams = const [],
    this.activeBroadcasts = const [],
    this.broadcastHistory = const [],
    this.availableUsers = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  TeamState copyWith({
    List<Team>? teams,
    List<EmergencyBroadcast>? activeBroadcasts,
    List<EmergencyBroadcast>? broadcastHistory,
    List<TeamMember>? availableUsers,
    bool? isLoading,
    String? errorMessage,
  }) {
    return TeamState(
      teams: teams ?? this.teams,
      activeBroadcasts: activeBroadcasts ?? this.activeBroadcasts,
      broadcastHistory: broadcastHistory ?? this.broadcastHistory,
      availableUsers: availableUsers ?? this.availableUsers,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class TeamViewModel extends Notifier<TeamState> {
  late final TeamRepository _repository;

  @override
  TeamState build() {
    _repository = ref.watch(teamRepositoryProvider);
    return TeamState();
  }

  // --- Teams ---

  Future<void> loadMyTeams() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    debugPrint('TeamViewModel: Starting loadMyTeams');
    try {
      // Decouple team loading from user loading to show the dashboard faster
      final updatedTeams = await _repository.getMyTeams();
      state = state.copyWith(teams: updatedTeams);
      debugPrint('TeamViewModel: Loaded ${updatedTeams.length} teams');

      // Load users in the background (used for invite dialogs)
      debugPrint(
        'TeamViewModel: Starting background load of organization users',
      );
      final updatedUsers = await _repository.getOrganizationUsers();
      state = state.copyWith(availableUsers: updatedUsers);
      debugPrint(
        'TeamViewModel: Loaded ${updatedUsers.length} available users',
      );
    } catch (e) {
      debugPrint('TeamViewModel: Error in loadMyTeams: $e');
      state = state.copyWith(errorMessage: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> createTeam(String name) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final team = await _repository.createTeam(name);
      state = state.copyWith(teams: [...state.teams, team]);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
      rethrow;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> updateTeam(String teamId, String name) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final updated = await _repository.updateTeam(teamId, name);
      final newTeams = List<Team>.from(state.teams);
      final idx = newTeams.indexWhere((t) => t.id == teamId);
      if (idx != -1) {
        newTeams[idx] = updated;
        state = state.copyWith(teams: newTeams);
      }
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
      rethrow;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> deleteTeam(String teamId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _repository.deleteTeam(teamId);
      final newTeams = List<Team>.from(state.teams);
      newTeams.removeWhere((t) => t.id == teamId);
      state = state.copyWith(teams: newTeams);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
      rethrow;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> squashTeam(String teamId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _repository.squashTeam(teamId);
      final newTeams = List<Team>.from(state.teams);
      newTeams.removeWhere((t) => t.id == teamId);
      state = state.copyWith(teams: newTeams);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
      rethrow;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> inviteMember(String teamId, String email, String role) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _repository.inviteMember(teamId, email, role);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
      rethrow;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  // --- Broadcasts ---

  Future<void> sendBroadcast(
    List<String> teamIds,
    String message,
    String type,
  ) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final broadcast = await _repository.sendEmergencyBroadcast(
        teamIds,
        message,
        type,
      );
      state = state.copyWith(
        activeBroadcasts: [broadcast, ...state.activeBroadcasts],
        broadcastHistory: [broadcast, ...state.broadcastHistory],
      );
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
      rethrow;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> loadActiveBroadcasts({bool silent = false}) async {
    if (!silent) state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final broadcasts = await _repository.getActiveBroadcasts();
      state = state.copyWith(activeBroadcasts: broadcasts);
    } catch (e) {
      if (!silent) state = state.copyWith(errorMessage: e.toString());
    } finally {
      if (!silent) state = state.copyWith(isLoading: false);
    }
  }

  Future<void> loadBroadcastHistory({bool silent = false}) async {
    if (!silent) state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final history = await _repository.getBroadcastHistory();
      state = state.copyWith(broadcastHistory: history);
    } catch (e) {
      if (!silent) state = state.copyWith(errorMessage: e.toString());
    } finally {
      if (!silent) state = state.copyWith(isLoading: false);
    }
  }

  Future<void> acknowledgeBroadcast(String broadcastId) async {
    try {
      await _repository.acknowledgeBroadcast(broadcastId);
      // Reload silently to get updated ack status
      await loadActiveBroadcasts(silent: true);
      await loadBroadcastHistory(silent: true);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }
}
