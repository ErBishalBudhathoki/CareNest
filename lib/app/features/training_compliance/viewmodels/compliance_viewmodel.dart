import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:carenest/app/features/training_compliance/models/compliance_checklist.dart';
import 'package:carenest/app/features/training_compliance/repositories/training_compliance_repository.dart';

part 'compliance_viewmodel.freezed.dart';

@freezed
abstract class ComplianceState with _$ComplianceState {
  const factory ComplianceState({
    @Default(false) bool isLoading,
    @Default([]) List<ComplianceChecklist> checklists,
    String? errorMessage,
  }) = _ComplianceState;
}

class ComplianceViewModel extends StateNotifier<ComplianceState> {
  final TrainingComplianceRepository _repository;

  ComplianceViewModel(this._repository) : super(const ComplianceState());

  Future<void> loadChecklists() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final lists = await _repository.getChecklists();
      state = state.copyWith(isLoading: false, checklists: lists);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> createChecklist(Map<String, dynamic> data) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _repository.createChecklist(data);
      await loadChecklists();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> updateChecklistStatus(String checklistId, Map<String, bool> itemsStatus, bool isCompleted) async {
    try {
      await _repository.updateChecklistStatus(checklistId, itemsStatus, isCompleted);
      await loadChecklists();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  Future<void> updateChecklist(String checklistId, Map<String, dynamic> data) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _repository.updateChecklist(checklistId, data);
      await loadChecklists();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> deleteChecklist(String checklistId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _repository.deleteChecklist(checklistId);
      await loadChecklists();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}
