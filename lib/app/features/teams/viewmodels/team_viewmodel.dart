
import 'package:flutter/foundation.dart';
import 'package:carenest/app/features/teams/models/team_models.dart';
import 'package:carenest/app/features/teams/repositories/team_repository.dart';

class TeamViewModel extends ChangeNotifier {
  final TeamRepository _repository;

  TeamViewModel(this._repository);

  List<Team> _teams = [];
  List<EmergencyBroadcast> _activeBroadcasts = [];
  List<TeamMember> _availableUsers = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Team> get teams => _teams;
  List<EmergencyBroadcast> get activeBroadcasts => _activeBroadcasts;
  List<TeamMember> get availableUsers => _availableUsers;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // --- Teams ---

  Future<void> loadMyTeams() async {
    _setLoading(true);
    try {
      final teamsFuture = _repository.getMyTeams();
      final usersFuture = _repository.getOrganizationUsers();
      
      final results = await Future.wait([teamsFuture, usersFuture]);
      _teams = results[0] as List<Team>;
      _availableUsers = results[1] as List<TeamMember>;
    } catch (e) {
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
    } finally {
      _setLoading(false);
    }
  }

  // --- Emergency ---

  Future<void> sendBroadcast(String teamId, String message, String type) async {
    _setLoading(true);
    try {
      final broadcast = await _repository.sendEmergencyBroadcast(teamId, message, type);
      _activeBroadcasts.insert(0, broadcast);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> loadActiveBroadcasts() async {
    _setLoading(true);
    try {
      _activeBroadcasts = await _repository.getActiveBroadcasts();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> acknowledgeBroadcast(String broadcastId) async {
    // Optimistic update
    final index = _activeBroadcasts.indexWhere((b) => b.id == broadcastId);
    if (index != -1) {
      // Logic to update local state if we knew the user ID, skipping for now
    }

    try {
      await _repository.acknowledgeBroadcast(broadcastId);
      await loadActiveBroadcasts(); // Reload to get fresh state
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
    _errorMessage = null;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    debugPrint('TeamViewModel Error: $message');
  }
}
