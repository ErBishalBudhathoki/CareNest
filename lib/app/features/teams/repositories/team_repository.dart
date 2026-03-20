import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import '../models/team_models.dart';

final teamRepositoryProvider = Provider<TeamRepository>((ref) {
  return TeamRepository(ref.read(app_providers.apiMethodProvider));
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

  Future<List<TeamMember>> getOrganizationUsers() async {
    final response = await _apiMethod.get('api/user/getUsers/');

    if (response['success'] == true) {
      final List<dynamic> list = response['users'] ?? [];
      // we map raw user objects to TeamMember so we can reuse the display name logic
      return list.map((e) {
        return TeamMember.fromJson({
          'userId': e,
          'role': e['role'] ?? 'member', 
          'status': 'active',
          'joinedAt': e['createdAt'] ?? DateTime.now().toIso8601String(),
        });
      }).toList();
    } else {
      throw Exception(response['message'] ?? 'Failed to fetch organization users');
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

  Future<EmergencyBroadcast> sendEmergencyBroadcast(
      String teamId, String message, String type) async {
    final response = await _apiMethod.post(
      'api/emergency/broadcast',
      body: {'teamId': teamId, 'message': message, 'type': type},
    );

    if (response['success'] == true) {
      return EmergencyBroadcast.fromJson(response['data']);
    } else {
      throw Exception(
          response['message'] ?? 'Failed to send emergency broadcast');
    }
  }

  Future<List<EmergencyBroadcast>> getActiveBroadcasts() async {
    final response = await _apiMethod.get('api/emergency/active');

    if (response['success'] == true) {
      final List<dynamic> list = response['data'];
      return list.map((e) => EmergencyBroadcast.fromJson(e)).toList();
    } else {
      throw Exception(
          response['message'] ?? 'Failed to fetch active broadcasts');
    }
  }

  Future<void> acknowledgeBroadcast(String broadcastId) async {
    final response =
        await _apiMethod.post('api/emergency/acknowledge/$broadcastId');

    if (response['success'] != true) {
      throw Exception(response['message'] ?? 'Failed to acknowledge broadcast');
    }
  }
}
