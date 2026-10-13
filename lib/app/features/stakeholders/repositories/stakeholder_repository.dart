import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/stakeholders/models/stakeholder_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stakeholderRepositoryProvider = Provider<StakeholderRepository>((ref) {
  return StakeholderRepository(ref.watch(apiMethodProvider));
});

/// Repository over the `/api/stakeholders/*` endpoints (Phase 5).
class StakeholderRepository {
  StakeholderRepository(this._apiMethod);

  final ApiMethod _apiMethod;

  Future<List<Stakeholder>> getStakeholders({String? type}) async {
    final response = await _apiMethod.getStakeholders(type: type);
    _ensureSuccess(response, 'Failed to load stakeholders');
    final list = (response['data']?['stakeholders'] as List?) ?? const [];
    return list
        .whereType<Map>()
        .map((e) => Stakeholder.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<Stakeholder> createStakeholder(Map<String, dynamic> body) async {
    final response = await _apiMethod.createStakeholder(body);
    _ensureSuccess(response, 'Failed to create stakeholder');
    return Stakeholder.fromJson(
      Map<String, dynamic>.from(response['data'] as Map),
    );
  }

  Future<Stakeholder> updateStakeholder(
    String id,
    Map<String, dynamic> body,
  ) async {
    final response = await _apiMethod.updateStakeholder(id, body);
    _ensureSuccess(response, 'Failed to update stakeholder');
    return Stakeholder.fromJson(
      Map<String, dynamic>.from(response['data'] as Map),
    );
  }

  Future<void> deleteStakeholder(String id) async {
    final response = await _apiMethod.deleteStakeholder(id);
    _ensureSuccess(response, 'Failed to deactivate stakeholder');
  }

  Future<ClientCareTeam> getCareTeam(String clientId) async {
    final response = await _apiMethod.getClientCareTeam(clientId);
    _ensureSuccess(response, 'Failed to load care team');
    return ClientCareTeam.fromJson(
      Map<String, dynamic>.from(response['data'] as Map),
    );
  }

  Future<void> linkStakeholder(
    String clientId, {
    required String stakeholderId,
    String? role,
    bool? isPrimary,
    String? fundingType,
  }) async {
    final response = await _apiMethod.linkClientStakeholder(clientId, {
      'stakeholderId': stakeholderId,
      'role': ?role,
      'isPrimary': ?isPrimary,
      'fundingType': ?fundingType,
    });
    _ensureSuccess(response, 'Failed to link stakeholder');
  }

  Future<void> unlinkStakeholder(String clientId, String stakeholderId) async {
    final response =
        await _apiMethod.unlinkClientStakeholder(clientId, stakeholderId);
    _ensureSuccess(response, 'Failed to unlink stakeholder');
  }

  void _ensureSuccess(Map<String, dynamic> response, String fallback) {
    if (response['success'] != true) {
      throw Exception(response['message']?.toString() ?? fallback);
    }
  }
}
