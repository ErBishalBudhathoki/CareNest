import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:carenest/app/features/training_compliance/models/training_module.dart';
import 'package:carenest/app/features/training_compliance/repositories/training_compliance_repository.dart';

part 'training_viewmodel.freezed.dart';

@freezed
abstract class TrainingState with _$TrainingState {
  const factory TrainingState({
    @Default(false) bool isLoading,
    @Default([]) List<TrainingModule> modules,
    String? errorMessage,
  }) = _TrainingState;
}

class TrainingViewModel extends StateNotifier<TrainingState> {
  final TrainingComplianceRepository _repository;

  TrainingViewModel(this._repository) : super(const TrainingState());

  Future<void> loadModules() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final modules = await _repository.getTrainingModules();
      state = state.copyWith(isLoading: false, modules: modules);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> createModule(Map<String, dynamic> data) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _repository.createTrainingModule(data);
      await loadModules();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> updateProgress(String moduleId, String status, int percentage) async {
    // Optimistic update or reload? Let's reload for simplicity for now
    try {
      await _repository.updateTrainingProgress(moduleId, status, percentage);
      await loadModules();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  Future<void> updateModule(String moduleId, Map<String, dynamic> data) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _repository.updateTrainingModule(moduleId, data);
      await loadModules();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> deleteModule(String moduleId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _repository.deleteTrainingModule(moduleId);
      await loadModules();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}
