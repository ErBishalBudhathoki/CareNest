import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/sil/models/sil_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final silRepositoryProvider = Provider<SILRepository>((ref) {
  return SILRepository(ref.watch(apiMethodProvider));
});

/// Thin repository over the `/api/sil/*` endpoints (Phase 4).
class SILRepository {
  SILRepository(this._apiMethod);

  final ApiMethod _apiMethod;

  // ---- Properties ----

  Future<List<SILProperty>> getProperties() async {
    final response = await _apiMethod.getSilProperties();
    _ensureSuccess(response, 'Failed to load properties');
    final list = (response['data']?['properties'] as List?) ?? const [];
    return list
        .whereType<Map>()
        .map((e) => SILProperty.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<SILProperty> createProperty(Map<String, dynamic> body) async {
    final response = await _apiMethod.createSilProperty(body);
    _ensureSuccess(response, 'Failed to create property');
    return SILProperty.fromJson(
      Map<String, dynamic>.from(response['data'] as Map),
    );
  }

  Future<SILVacancyBoard> getVacancies(String propertyId) async {
    final response = await _apiMethod.getSilVacancies(propertyId);
    _ensureSuccess(response, 'Failed to load vacancies');
    return SILVacancyBoard.fromJson(
      Map<String, dynamic>.from(response['data'] as Map),
    );
  }

  // ---- Occupancy ----

  Future<List<SILOccupancy>> getOccupancy({String? propertyId, String? clientId}) async {
    final response = await _apiMethod.getSilOccupancy(
      propertyId: propertyId,
      clientId: clientId,
    );
    _ensureSuccess(response, 'Failed to load occupancy');
    final list = (response['data']?['occupancy'] as List?) ?? const [];
    return list
        .whereType<Map>()
        .map((e) => SILOccupancy.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<SILOccupancy> createOccupancy(Map<String, dynamic> body) async {
    final response = await _apiMethod.createSilOccupancy(body);
    _ensureSuccess(response, 'Failed to create occupancy');
    return SILOccupancy.fromJson(
      Map<String, dynamic>.from(response['data'] as Map),
    );
  }

  Future<SILOccupancy> endOccupancy(
    String id, {
    String? endDate,
    String? vacatedReason,
    String? newRoomId,
  }) async {
    final response = await _apiMethod.endSilOccupancy(id, {
      'endDate': ?endDate,
      'vacatedReason': ?vacatedReason,
      'newRoomId': ?newRoomId,
    });
    _ensureSuccess(response, 'Failed to end occupancy');
    return SILOccupancy.fromJson(
      Map<String, dynamic>.from(response['data'] as Map),
    );
  }

  // ---- Ratio rules ----

  Future<List<SILRatioRule>> getRatioRules() async {
    final response = await _apiMethod.getSilRatioRules();
    _ensureSuccess(response, 'Failed to load ratio rules');
    final list = (response['data']?['rules'] as List?) ?? const [];
    return list
        .whereType<Map>()
        .map((e) => SILRatioRule.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<SILRatioRule> createRatioRule(Map<String, dynamic> body) async {
    final response = await _apiMethod.createSilRatioRule(body);
    _ensureSuccess(response, 'Failed to create ratio rule');
    return SILRatioRule.fromJson(
      Map<String, dynamic>.from(response['data'] as Map),
    );
  }

  // ---- Rosters ----

  Future<SILRoster?> getRoster({
    required String propertyId,
    required String weekStarting,
  }) async {
    final response = await _apiMethod.getSilRoster(
      propertyId: propertyId,
      weekStarting: weekStarting,
    );
    _ensureSuccess(response, 'Failed to load roster');
    final data = response['data'];
    if (data is! Map) return null;
    return SILRoster.fromJson(Map<String, dynamic>.from(data));
  }

  Future<SILRoster> buildRoster({
    required String propertyId,
    required String weekStarting,
  }) async {
    final response = await _apiMethod.buildSilRoster({
      'propertyId': propertyId,
      'weekStarting': weekStarting,
    });
    _ensureSuccess(response, 'Failed to build roster');
    return SILRoster.fromJson(
      Map<String, dynamic>.from(response['data'] as Map),
    );
  }

  Future<SILRoster> publishRoster(String id) async {
    final response = await _apiMethod.publishSilRoster(id);
    _ensureSuccess(response, 'Failed to publish roster');
    return SILRoster.fromJson(
      Map<String, dynamic>.from(response['data'] as Map),
    );
  }

  // ---- Quotes ----

  Future<List<SILQuote>> getQuotes({String? clientId}) async {
    final response = await _apiMethod.getSilQuotes(clientId: clientId);
    _ensureSuccess(response, 'Failed to load quotes');
    final list = (response['data']?['quotes'] as List?) ?? const [];
    return list
        .whereType<Map>()
        .map((e) => SILQuote.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<SILQuote> createQuote(Map<String, dynamic> body) async {
    final response = await _apiMethod.createSilQuote(body);
    _ensureSuccess(response, 'Failed to create quote');
    return SILQuote.fromJson(
      Map<String, dynamic>.from(response['data'] as Map),
    );
  }

  Future<SILQuote> acceptQuote(String id) async {
    final response = await _apiMethod.acceptSilQuote(id);
    _ensureSuccess(response, 'Failed to accept quote');
    return SILQuote.fromJson(
      Map<String, dynamic>.from(response['data'] as Map),
    );
  }

  Future<SILRosterOfCare> convertQuote(
    String id, {
    String? effectiveFrom,
    String? cadence,
  }) async {
    final response = await _apiMethod.convertSilQuote(id, body: {
      'effectiveFrom': ?effectiveFrom,
      'cadence': ?cadence,
    });
    _ensureSuccess(response, 'Failed to convert quote');
    final roc = response['data']?['rosterOfCare'];
    return SILRosterOfCare.fromJson(Map<String, dynamic>.from(roc as Map));
  }

  // ---- Rosters of care ----

  Future<List<SILRosterOfCare>> getRostersOfCare({String? clientId}) async {
    final response = await _apiMethod.getSilRostersOfCare(clientId: clientId);
    _ensureSuccess(response, 'Failed to load rosters of care');
    final list = (response['data']?['rostersOfCare'] as List?) ?? const [];
    return list
        .whereType<Map>()
        .map((e) => SILRosterOfCare.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  void _ensureSuccess(Map<String, dynamic> response, String fallback) {
    if (response['success'] != true) {
      throw Exception(response['message']?.toString() ?? fallback);
    }
  }
}
