import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/onboarding_record.dart';
import '../models/employee_document.dart';
import '../repositories/onboarding_repository.dart';

class AdminOnboardingState {
  final bool isLoading;
  final String? error;
  final List<dynamic> pendingList;
  final OnboardingRecord? selectedRecord;
  final Map<String, dynamic>? selectedUser;
  final List<EmployeeDocument> selectedDocuments;

  AdminOnboardingState({
    this.isLoading = false,
    this.error,
    this.pendingList = const [],
    this.selectedRecord,
    this.selectedUser,
    this.selectedDocuments = const [],
  });

  AdminOnboardingState copyWith({
    bool? isLoading,
    String? error,
    List<dynamic>? pendingList,
    OnboardingRecord? selectedRecord,
    Map<String, dynamic>? selectedUser,
    List<EmployeeDocument>? selectedDocuments,
  }) {
    return AdminOnboardingState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      pendingList: pendingList ?? this.pendingList,
      selectedRecord: selectedRecord ?? this.selectedRecord,
      selectedUser: selectedUser ?? this.selectedUser,
      selectedDocuments: selectedDocuments ?? this.selectedDocuments,
    );
  }
}

class AdminOnboardingViewModel extends StateNotifier<AdminOnboardingState> {
  final OnboardingRepository _repository;

  AdminOnboardingViewModel(this._repository) : super(AdminOnboardingState());

  Future<void> loadPendingList() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final list = await _repository.getPendingOnboardings();
      state = state.copyWith(isLoading: false, pendingList: list);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> selectUser(Map<String, dynamic> rawData) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // Extract user info which is nested from aggregation
      final userInfo = rawData['user'] as Map<String, dynamic>?;
      // The userId might be in rawData directly or inside user object depending on aggregation
      // In aggregation: userId is in root (OnboardingRecord field)
      final userId = rawData['userId']?.toString();
      
      if (userId == null) throw Exception('User ID not found in record');

      final record = OnboardingRecord.fromJson(rawData);
      final docs = await _repository.getAdminDocuments(userId);
      
      state = state.copyWith(
        isLoading: false, 
        selectedRecord: record,
        selectedUser: userInfo,
        selectedDocuments: docs
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> verifyDocument(String docId, String status, {String? reason}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repository.verifyDocument(docId, status, reason: reason);
      
      // Refresh documents
      if (state.selectedRecord != null) {
        final userId = state.selectedRecord!.userId;
        final docs = await _repository.getAdminDocuments(userId);
        state = state.copyWith(isLoading: false, selectedDocuments: docs);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> finalizeOnboarding(String userId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final updatedRecord = await _repository.finalizeOnboarding(userId);
      
      // Update selected record and refresh list
      state = state.copyWith(
        isLoading: false, 
        selectedRecord: updatedRecord,
      );
      
      // Also refresh the list in background
      loadPendingList();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
