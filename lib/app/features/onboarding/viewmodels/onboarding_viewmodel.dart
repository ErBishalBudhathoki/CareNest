import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/onboarding_record.dart';
import '../models/employee_document.dart';
import '../repositories/onboarding_repository.dart';

class OnboardingState {
  final bool isLoading;
  final String? error;
  final OnboardingRecord? record;
  final List<EmployeeDocument> documents;

  OnboardingState({
    this.isLoading = false,
    this.error,
    this.record,
    this.documents = const [],
  });

  OnboardingState copyWith({
    bool? isLoading,
    String? error,
    OnboardingRecord? record,
    List<EmployeeDocument>? documents,
  }) {
    return OnboardingState(
      isLoading: isLoading ?? this.isLoading,
      error: error, 
      record: record ?? this.record,
      documents: documents ?? this.documents,
    );
  }
}

class OnboardingViewModel extends StateNotifier<OnboardingState> {
  final OnboardingRepository _repository;

  OnboardingViewModel(this._repository) : super(OnboardingState());

  Future<void> loadStatus() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final record = await _repository.getOnboardingStatus();
      final docs = await _repository.getDocuments();
      state = state.copyWith(isLoading: false, record: record, documents: docs);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> updateStep(String stepName, Map<String, dynamic> data) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final record = await _repository.updateStep(stepName, data);
      state = state.copyWith(isLoading: false, record: record);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> uploadDocument(File file, String type, {DateTime? expiryDate, String? documentNumber}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // 1. Upload file
      final fileUrl = await _repository.uploadFile(file);
      
      // 2. Save document metadata
      await _repository.saveDocument({
        'type': type,
        'fileUrl': fileUrl,
        'expiryDate': expiryDate?.toIso8601String(),
        'documentNumber': documentNumber
      });
      
      // 3. Refresh docs
      final docs = await _repository.getDocuments();
      
      // 4. Refresh status to update step progress
      final record = await _repository.getOnboardingStatus();
      
      state = state.copyWith(isLoading: false, documents: docs, record: record);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> deleteDocument(String docId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repository.deleteDocument(docId);
      
      // Refresh docs and status
      final docs = await _repository.getDocuments();
      final record = await _repository.getOnboardingStatus();
      
      state = state.copyWith(isLoading: false, documents: docs, record: record);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> submitOnboarding() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final record = await _repository.submitOnboarding();
      state = state.copyWith(isLoading: false, record: record);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
