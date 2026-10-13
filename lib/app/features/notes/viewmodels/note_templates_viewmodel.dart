import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/notes/repositories/note_template_repository.dart';

class NoteTemplatesState {
  final bool isLoading;
  final String? error;
  final List<Map<String, dynamic>> templates;

  NoteTemplatesState({
    this.isLoading = false,
    this.error,
    this.templates = const [],
  });

  NoteTemplatesState copyWith({
    bool? isLoading,
    String? error,
    List<Map<String, dynamic>>? templates,
  }) {
    return NoteTemplatesState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      templates: templates ?? this.templates,
    );
  }
}

/// Admin CRUD for progress-note templates (Phase 2).
class NoteTemplatesViewModel extends Notifier<NoteTemplatesState> {
  NoteTemplateRepository get _repository =>
      ref.read(noteTemplateRepositoryProvider);

  @override
  NoteTemplatesState build() {
    ref.watch(noteTemplateRepositoryProvider);
    return NoteTemplatesState();
  }

  Future<void> load() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final templates = await _repository.list();
      state = state.copyWith(isLoading: false, templates: templates);
    } catch (e) {
      debugPrint('Error loading note templates: $e');
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<bool> create(Map<String, dynamic> body) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repository.create(body);
      await load();
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> update(String id, Map<String, dynamic> body) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repository.update(id, body);
      await load();
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> deactivate(String id) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repository.deactivate(id);
      await load();
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }
}

final noteTemplatesViewModelProvider =
    NotifierProvider<NoteTemplatesViewModel, NoteTemplatesState>(
      NoteTemplatesViewModel.new,
    );
