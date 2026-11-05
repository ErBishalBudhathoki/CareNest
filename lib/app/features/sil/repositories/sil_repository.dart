import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/sil/models/sil_models.dart';
import 'package:carenest/app/features/sil/utils/roc_invoice_idempotency.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final silRepositoryProvider = Provider<SILRepository>((ref) {
  return SILRepository(ref.watch(apiMethodProvider));
});

/// Thrown when an operation (like activating an RoC) is blocked by the Consent Gate
/// because no active signed NDIS Service Agreement covers the participant.
class SILConsentRequiredException implements Exception {
  final String message;
  final String? code;
  final Map<String, dynamic>? data;

  const SILConsentRequiredException({
    required this.message,
    this.code = 'SERVICE_AGREEMENT_REQUIRED',
    this.data,
  });

  @override
  String toString() => message;
}

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

  Future<List<SILOccupancy>> getOccupancy({
    String? propertyId,
    String? clientId,
  }) async {
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

  /// Milestone 2.1: Record an absence (hospital, family leave, …).
  Future<Map<String, dynamic>> recordSilAbsence(
    String occupancyId, {
    required DateTime startDate,
    DateTime? endDate,
    String? reason,
    String? notes,
    int? maxClaimableDays,
  }) async {
    final response = await _apiMethod.recordSilAbsence(
      occupancyId,
      startDate: silIsoDate(startDate),
      endDate: endDate == null ? null : silIsoDate(endDate),
      reason: reason,
      notes: notes,
      maxClaimableDays: maxClaimableDays,
    );
    _ensureSuccess(response, 'Failed to record absence');
    final data = response['data'];
    return data is Map ? Map<String, dynamic>.from(data) : const {};
  }

  /// Milestone 2.1: End an ongoing absence (or set its return date).
  Future<Map<String, dynamic>> endSilAbsence(
    String occupancyId,
    String absenceId, {
    DateTime? endDate,
  }) async {
    final response = await _apiMethod.endSilAbsence(
      occupancyId,
      absenceId,
      endDate: endDate == null ? null : silIsoDate(endDate),
    );
    _ensureSuccess(response, 'Failed to end absence');
    final data = response['data'];
    return data is Map ? Map<String, dynamic>.from(data) : const {};
  }

  /// Milestone 2.1: List absences, optionally filtered. Returns flattened
  /// absence rows (newest first) exactly as the API serializes them.
  Future<List<Map<String, dynamic>>> listSilAbsences({
    String? occupancyId,
    String? clientId,
    String? propertyId,
  }) async {
    final response = await _apiMethod.listSilAbsences(
      occupancyId: occupancyId,
      clientId: clientId,
      propertyId: propertyId,
    );
    _ensureSuccess(response, 'Failed to load absences');
    final list = (response['data']?['absences'] as List?) ?? const [];
    return list.whereType<Map>().map(Map<String, dynamic>.from).toList();
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

  // Milestone 6.2: Supports ratio enforcement parameter (block on ratio breach)
  Future<SILRoster> publishRoster(String id, {bool? blockOnRatioBreach}) async {
    final response = await _apiMethod.publishSilRoster(
      id,
      blockOnRatioBreach: blockOnRatioBreach,
    );
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

  // Milestone 6.1: Passes digital e-signature payload on accept
  Future<SILQuote> acceptQuote(
    String id, {
    Map<String, dynamic>? signatureData,
  }) async {
    final response = await _apiMethod.acceptSilQuote(id, body: signatureData);
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
    final response = await _apiMethod.convertSilQuote(
      id,
      body: {'effectiveFrom': ?effectiveFrom, 'cadence': ?cadence},
    );
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

  /// Bill one period of an active roster of care. The returned invoice summary
  /// carries the stamped funding route so the UI can tell the user whether it
  /// became a claim CSV or a PDF.
  Future<SILRosterOfCareInvoice> invoiceRosterOfCare(
    String id, {
    required String from,
    required String to,
    String? dueDate,
    String? idempotencyKey,
  }) async {
    final response = await _apiMethod.generateSilRosterOfCareInvoice(
      id,
      from: from,
      to: to,
      dueDate: dueDate,
      idempotencyKey: idempotencyKey,
    );
    _ensureSuccess(response, 'Failed to generate invoice');
    final data = response['data'];
    return SILRosterOfCareInvoice.fromJson(
      data is Map ? Map<String, dynamic>.from(data) : const {},
    );
  }

  /// Milestone 7.3: Dispatch a SIL invoice PDF to the plan manager or participant.
  Future<Map<String, dynamic>> dispatchInvoice(
    String id, {
    String? dispatchMethod,
    String? recipientEmail,
  }) async {
    final response = await _apiMethod.dispatchSilInvoice(
      id,
      dispatchMethod: dispatchMethod,
      recipientEmail: recipientEmail,
    );
    _ensureSuccess(response, 'Failed to dispatch invoice');
    final data = response['data'];
    return data is Map ? Map<String, dynamic>.from(data) : const {};
  }

  /// Materialise a roster of care's agreed weekly pattern into that week's
  /// shifts (unassigned). Returns the number created/skipped.
  Future<({int created, int skipped})> materializeRosterOfCareShifts(
    String id, {
    required String weekStarting,
  }) async {
    final response = await _apiMethod.materializeSilRosterOfCareShifts(
      id,
      weekStarting: weekStarting,
    );
    _ensureSuccess(response, 'Failed to plan shifts');
    final data = response['data'];
    final map = data is Map ? Map<String, dynamic>.from(data) : const {};
    return (
      created: (map['created'] as num?)?.toInt() ?? 0,
      skipped: (map['skipped'] as num?)?.toInt() ?? 0,
    );
  }

  /// Update a roster of care (e.g. activating from draft to active, or applying emergency consent bypass).
  Future<SILRosterOfCare> updateRosterOfCare(
    String id,
    Map<String, dynamic> body,
  ) async {
    final response = await _apiMethod.updateSilRosterOfCare(id, body);
    _ensureSuccess(response, 'Failed to update roster of care');
    final data = response['data'];
    return SILRosterOfCare.fromJson(Map<String, dynamic>.from(data as Map));
  }

  // ---- Service agreements (Milestone 4.2 Consent Gate) ----

  Future<List<SILServiceAgreement>> getServiceAgreements({
    String? clientId,
    String? status,
  }) async {
    final response = await _apiMethod.getSilServiceAgreements(
      clientId: clientId,
      status: status,
    );
    _ensureSuccess(response, 'Failed to load service agreements');
    final list = (response['data']?['agreements'] as List?) ?? const [];
    return list
        .whereType<Map>()
        .map((e) => SILServiceAgreement.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<SILServiceAgreement> createServiceAgreement(
    Map<String, dynamic> body,
  ) async {
    final response = await _apiMethod.createSilServiceAgreement(body);
    _ensureSuccess(response, 'Failed to create service agreement');
    return SILServiceAgreement.fromJson(
      Map<String, dynamic>.from(response['data'] as Map),
    );
  }

  Future<SILServiceAgreement> signServiceAgreement(
    String id,
    Map<String, dynamic> body,
  ) async {
    final response = await _apiMethod.signSilServiceAgreement(id, body);
    _ensureSuccess(response, 'Failed to sign service agreement');
    return SILServiceAgreement.fromJson(
      Map<String, dynamic>.from(response['data'] as Map),
    );
  }

  Future<Map<String, dynamic>> checkServiceAgreement(String clientId) async {
    final response = await _apiMethod.checkSilServiceAgreement(clientId);
    _ensureSuccess(response, 'Failed to check service agreement');
    return response['data'] is Map
        ? Map<String, dynamic>.from(response['data'] as Map)
        : <String, dynamic>{};
  }

  void _ensureSuccess(Map<String, dynamic> response, String fallback) {
    if (response['success'] != true) {
      if (response['code'] == 'SERVICE_AGREEMENT_REQUIRED') {
        throw SILConsentRequiredException(
          message: response['message']?.toString() ?? fallback,
          code: 'SERVICE_AGREEMENT_REQUIRED',
          data: response['data'] is Map
              ? Map<String, dynamic>.from(response['data'] as Map)
              : null,
        );
      }
      throw Exception(response['message']?.toString() ?? fallback);
    }
  }
}
