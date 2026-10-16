import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/claiming/models/claim_import_result.dart';
import 'package:carenest/app/features/claiming/models/claim_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final claimRepositoryProvider = Provider<ClaimRepository>((ref) {
  return ClaimRepository(ref.watch(apiMethodProvider));
});

/// Repository over the `/api/ndis-claims/*` endpoints (Phase 6).
class ClaimRepository {
  ClaimRepository(this._apiMethod);

  final ApiMethod _apiMethod;

  Future<List<ClaimBatch>> getBatches() async {
    final response = await _apiMethod.getClaimBatches();
    _ensureSuccess(response, 'Failed to load claim batches');
    final list = (response['data']?['batches'] as List?) ?? const [];
    return list
        .whereType<Map>()
        .map((e) => ClaimBatch.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<({ClaimBatch batch, List<ClaimLine> lines})> getBatch(String id) async {
    final response = await _apiMethod.getClaimBatch(id);
    _ensureSuccess(response, 'Failed to load claim batch');
    final data = response['data'] as Map;
    final batch = ClaimBatch.fromJson(Map<String, dynamic>.from(data['batch'] as Map));
    final lines = ((data['lines'] as List?) ?? const [])
        .whereType<Map>()
        .map((e) => ClaimLine.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    return (batch: batch, lines: lines);
  }

  Future<({ClaimBatch batch, String csv, ClaimValidation validation})> generate({
    required String from,
    required String to,
    bool allowInvalid = false,
  }) async {
    final response = await _apiMethod.generateClaimBatch(
      from: from,
      to: to,
      allowInvalid: allowInvalid,
    );
    if (response['success'] != true) {
      final data = response['data'];
      final validation = data is Map && data['validation'] is Map
          ? ClaimValidation.fromJson(
              Map<String, dynamic>.from(data['validation'] as Map))
          : null;
      throw ClaimGenerationException(
        response['message']?.toString() ?? 'Failed to generate claim batch',
        validation: validation,
      );
    }
    final data = response['data'] as Map;
    return (
      batch: ClaimBatch.fromJson(Map<String, dynamic>.from(data['batch'] as Map)),
      csv: data['csv']?.toString() ?? '',
      validation: data['validation'] is Map
          ? ClaimValidation.fromJson(
              Map<String, dynamic>.from(data['validation'] as Map))
          : const ClaimValidation(),
    );
  }

  /// Imports a Bulk Payment Results File and returns the reconciliation
  /// summary. The status of the batch afterwards (`reconciled`, `partial`,
  /// `failed`) is carried in [ClaimImportResult.batchStatus] so the caller can
  /// distinguish a clean import from a rejected or partially-rejected one.
  Future<ClaimImportResult> importResults(
    String batchId,
    String fileContent,
  ) async {
    final response = await _apiMethod.importClaimResults(batchId, fileContent);
    _ensureSuccess(response, 'Failed to import claim results');

    final data = response['data'];
    if (data is! Map) return const ClaimImportResult();

    final batch = data['batch'] is Map
        ? Map<String, dynamic>.from(data['batch'] as Map)
        : const <String, dynamic>{};
    final summary = data['summary'] is Map
        ? Map<String, dynamic>.from(data['summary'] as Map)
        : const <String, dynamic>{};

    return ClaimImportResult.fromJson({
      ...summary,
      'batchStatus': batch['status'],
    });
  }

  void _ensureSuccess(Map<String, dynamic> response, String fallback) {
    if (response['success'] != true) {
      throw Exception(response['message']?.toString() ?? fallback);
    }
  }
}

class ClaimGenerationException implements Exception {
  ClaimGenerationException(this.message, {this.validation});
  final String message;
  final ClaimValidation? validation;

  @override
  String toString() => message;
}
