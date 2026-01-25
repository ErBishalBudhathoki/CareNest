
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';
import '../models/team_models.dart';

final teamRepositoryProvider = Provider<TeamRepository>((ref) {
  return TeamRepository(ApiMethod());
});

class TeamRepository {
  final ApiMethod _apiMethod;

  TeamRepository(this._apiMethod);

  // --- Teams ---

  Future<List<Team>> getMyTeams() async {
    final response = await _apiMethod.get('api/teams/my-teams');

    if (response['success'] == true) {
      final List<dynamic> list = response['data'];
      return list.map((e) => Team.fromJson(e)).toList();
    } else {
      throw Exception(response['message'] ?? 'Failed to fetch teams');
    }
  }

  Future<Team> createTeam(String name) async {
    final response = await _apiMethod.post(
      'api/teams',
      body: {'name': name},
    );

    if (response['success'] == true) {
      return Team.fromJson(response['data']);
    } else {
      throw Exception(response['message'] ?? 'Failed to create team');
    }
  }

  Future<void> inviteMember(String teamId, String email, String role) async {
    final response = await _apiMethod.post(
      'api/teams/$teamId/invite',
      body: {'email': email, 'role': role},
    );

    if (response['success'] != true) {
      throw Exception(response['message'] ?? 'Failed to invite member');
    }
  }

  // --- Emergency Broadcasts ---

  Future<EmergencyBroadcast> sendEmergencyBroadcast(String teamId, String message, String type) async {
    final response = await _apiMethod.post(
      'api/emergency/broadcast',
      body: {'teamId': teamId, 'message': message, 'type': type},
    );

    if (response['success'] == true) {
      return EmergencyBroadcast.fromJson(response['data']);
    } else {
      throw Exception(response['message'] ?? 'Failed to send emergency broadcast');
    }
  }

  Future<List<EmergencyBroadcast>> getActiveBroadcasts() async {
    final response = await _apiMethod.get('api/emergency/active');

    if (response['success'] == true) {
      final List<dynamic> list = response['data'];
      return list.map((e) => EmergencyBroadcast.fromJson(e)).toList();
    } else {
      throw Exception(response['message'] ?? 'Failed to fetch active broadcasts');
    }
  }

  Future<void> acknowledgeBroadcast(String broadcastId) async {
    final response = await _apiMethod.post('api/emergency/acknowledge/$broadcastId');

    if (response['success'] != true) {
      throw Exception(response['message'] ?? 'Failed to acknowledge broadcast');
    }
  }
}
