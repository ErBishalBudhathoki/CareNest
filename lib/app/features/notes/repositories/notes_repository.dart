import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/core_providers.dart';
import '../models/note_model.dart';

final notesRepositoryProvider = Provider<NotesRepository>((ref) {
  final apiMethod = ref.read(apiMethodProvider);
  return NotesRepository(apiMethod);
});

class NotesRepository {
  final ApiMethod _apiMethod;

  NotesRepository(this._apiMethod);

  /// Add a note for a client
  Future<Note> addNote({
    required String userEmail,
    required String clientEmail,
    required String notes,
  }) async {
    final response = await _apiMethod.post(
      'notes',
      body: {
        'userEmail': userEmail,
        'clientEmail': clientEmail,
        'notes': notes,
      },
    );

    if (response['success'] == true) {
      return Note.fromJson(response['data']);
    } else {
      throw Exception(response['message'] ?? 'Failed to add note');
    }
  }

  /// Get notes for a client
  Future<NotesResponse> getNotes({
    required String clientEmail,
    int page = 1,
    int limit = 20,
  }) async {
    final query = '?page=$page&limit=$limit';
    final response = await _apiMethod.get('notes/$clientEmail$query');

    if (response['success'] == true) {
      return NotesResponse.fromJson(response['data']);
    } else {
      throw Exception(response['message'] ?? 'Failed to fetch notes');
    }
  }

  /// Update a note
  Future<Note> updateNote({
    required String id,
    required String notes,
  }) async {
    final response = await _apiMethod.put(
      'notes/$id',
      body: {'notes': notes},
    );

    if (response['success'] == true) {
      return Note.fromJson(response['data']);
    } else {
      throw Exception(response['message'] ?? 'Failed to update note');
    }
  }

  /// Delete a note
  Future<void> deleteNote(String id) async {
    final response = await _apiMethod.delete('notes/$id');

    if (response['success'] != true) {
      throw Exception(response['message'] ?? 'Failed to delete note');
    }
  }
}
