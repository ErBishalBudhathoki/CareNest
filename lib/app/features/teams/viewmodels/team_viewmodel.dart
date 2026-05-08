import 'package:flutter/foundation.dart';
import 'package:carenest/app/features/teams/models/team_models.dart';
import 'package:carenest/app/features/teams/repositories/team_repository.dart';

class TeamViewModel extends ChangeNotifier {
  final TeamRepository _repository;

  TeamViewModel(this._repository);

  List<Team> _teams = [];
  List<EmergencyBroadcast> _activeBroadcasts = [];
  List<EmergencyBroadcast> _broadcastHistory = [];
  List<TeamMember> _availableUsers = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Team> get teams => _teams;
  List<EmergencyBroadcast> get activeBroadcasts => _activeBroadcasts;
  List<EmergencyBroadcast> get broadcastHistory => _broadcastHistory;
  List<TeamMember> get availableUsers => _availableUsers;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // --- Teams ---

  Future<void> loadMyTeams() async {
    _setLoading(true);
    debugPrint('TeamViewModel: Starting loadMyTeams');
    try {
      // Decouple team loading from user loading to show the dashboard faster
      _teams = await _repository.getMyTeams();
      debugPrint('TeamViewModel: Loaded ${_teams.length} teams');
      notifyListeners();

      // Load users in the background (used for invite dialogs)
      debugPrint(
          'TeamViewModel: Starting background load of organization users');
      _availableUsers = await _repository.getOrganizationUsers();
      debugPrint(
          'TeamViewModel: Loaded ${_availableUsers.length} available users');
      notifyListeners();
    } catch (e) {
      debugPrint('TeamViewModel: Error in loadMyTeams: $e');
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> createTeam(String name) async {
    _setLoading(true);
    try {
      final team = await _repository.createTeam(name);
      _teams.add(team);
    } catch (e) {
      _setError(e.toString());
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateTeam(String teamId, String name) async {
    _setLoading(true);
    try {
      final updated = await _repository.updateTeam(teamId, name);
      final idx = _teams.indexWhere((t) => t.id == teamId);
      if (idx != -1) {
        _teams[idx] = updated;
        notifyListeners();
      }
    } catch (e) {
      _setError(e.toString());
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteTeam(String teamId) async {
    _setLoading(true);
    try {
      await _repository.deleteTeam(teamId);
      _teams.removeWhere((t) => t.id == teamId);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> squashTeam(String teamId) async {
    _setLoading(true);
    try {
      await _repository.squashTeam(teamId);
      _teams.removeWhere((t) => t.id == teamId);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> inviteMember(String teamId, String email, String role) async {
    _setLoading(true);
    try {
      await _repository.inviteMember(teamId, email, role);
    } catch (e) {
      _setError(e.toString());
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // --- Emergency ---

  Future<void> sendBroadcast(
      List<String> teamIds, String message, String type) async {
    _setLoading(true);
    try {
      final broadcast =
          await _repository.sendEmergencyBroadcast(teamIds, message, type);
      _activeBroadcasts.insert(0, broadcast);
      _broadcastHistory.insert(0, broadcast);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> loadActiveBroadcasts({bool silent = false}) async {
    if (!silent) _setLoading(true);
    try {
      _activeBroadcasts = await _repository.getActiveBroadcasts();
      if (silent)
        notifyListeners(); // Only notify if silent, otherwise _setLoading handles it
    } catch (e) {
      if (!silent) _setError(e.toString());
    } finally {
      if (!silent) _setLoading(false);
    }
  }

  Future<void> loadBroadcastHistory({bool silent = false}) async {
    if (!silent) _setLoading(true);
    try {
      _broadcastHistory = await _repository.getBroadcastHistory();
      if (silent) notifyListeners();
    } catch (e) {
      if (!silent) _setError(e.toString());
    } finally {
      if (!silent) _setLoading(false);
    }
  }

  Future<void> acknowledgeBroadcast(String broadcastId) async {
    try {
      await _repository.acknowledgeBroadcast(broadcastId);
      // Reload both to get fresh state (ack counts)
      await loadActiveBroadcasts(silent: true);
      await loadBroadcastHistory(silent: true);
    } catch (e) {
      _setError(e.toString());
    }
  }

  // --- Helpers ---

  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  void _setLoading(bool value) {
    if (_isDisposed) return;
    _isLoading = value;
    if (value) {
      _errorMessage = null;
    }
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    debugPrint('TeamViewModel Error: $message');
    notifyListeners();
  }
}
