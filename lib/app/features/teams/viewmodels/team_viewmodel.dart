
import 'package:flutter/foundation.dart';
import 'package:carenest/app/features/teams/models/team_models.dart';
import 'package:carenest/app/features/teams/repositories/team_repository.dart';

class TeamViewModel extends ChangeNotifier {
  final TeamRepository _repository;

  TeamViewModel(this._repository);

  List<Team> _teams = [];
  List<EmergencyBroadcast> _activeBroadcasts = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Team> get teams => _teams;
  List<EmergencyBroadcast> get activeBroadcasts => _activeBroadcasts;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // --- Teams ---

  Future<void> loadMyTeams() async {
    _setLoading(true);
    try {
      _teams = await _repository.getMyTeams();
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

  void _setLoading(bool value) {
    _isLoading = value;
    _errorMessage = null;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    debugPrint('TeamViewModel Error: $message');
  }
}
