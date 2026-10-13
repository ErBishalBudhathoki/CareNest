import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final noteTemplateRepositoryProvider = Provider<NoteTemplateRepository>((ref) {
  return NoteTemplateRepository(ref.watch(apiMethodProvider));
});

/// CRUD over `/api/notes/templates` (Phase 2 admin UI).
///
/// Templates are returned as raw maps because the composer renders them
/// dynamically from their `sections` array.
class NoteTemplateRepository {
  NoteTemplateRepository(this._apiMethod);

  final ApiMethod _apiMethod;

  Future<List<Map<String, dynamic>>> list() async {
    return _apiMethod.getNoteTemplates();
  }

  Future<Map<String, dynamic>> create(Map<String, dynamic> body) async {
    final response = await _apiMethod.createNoteTemplate(body);
    _ensureSuccess(response, 'Failed to create template');
    return Map<String, dynamic>.from(response['data'] as Map);
  }

  Future<Map<String, dynamic>> update(
    String id,
    Map<String, dynamic> body,
  ) async {
    final response = await _apiMethod.updateNoteTemplate(id, body);
    _ensureSuccess(response, 'Failed to update template');
    return Map<String, dynamic>.from(response['data'] as Map);
  }

  Future<void> deactivate(String id) async {
    final response = await _apiMethod.deleteNoteTemplate(id);
    _ensureSuccess(response, 'Failed to deactivate template');
  }

  void _ensureSuccess(Map<String, dynamic> response, String fallback) {
    if (response['success'] != true) {
      throw Exception(response['message']?.toString() ?? fallback);
    }
  }
}
