import 'dart:io';
import 'package:carenest/backend/api_method.dart';
import '../models/onboarding_record.dart';
import '../models/employee_document.dart';

class OnboardingRepository {
  final ApiMethod _apiMethod;

  OnboardingRepository(this._apiMethod);

  Future<OnboardingRecord> getOnboardingStatus() async {
    final response = await _apiMethod.get('api/onboarding/status');
    if (response['success'] == true) {
      return OnboardingRecord.fromJson(response['data']);
    }
    throw Exception(response['message'] ?? 'Failed to get status');
  }

  Future<OnboardingRecord> updateStep(String stepName, Map<String, dynamic> data) async {
    final response = await _apiMethod.put('api/onboarding/step/$stepName', body: data);
    if (response['success'] == true) {
      return OnboardingRecord.fromJson(response['data']);
    }
    throw Exception(response['message'] ?? 'Failed to update step');
  }

  Future<String> uploadFile(File file) async {
    return await _apiMethod.uploadFile('api/onboarding/upload', file);
  }

  Future<EmployeeDocument> saveDocument(Map<String, dynamic> data) async {
    final response = await _apiMethod.post('api/onboarding/documents', body: data);
    if (response['success'] == true) {
      return EmployeeDocument.fromJson(response['data']);
    }
    throw Exception(response['message'] ?? 'Failed to save document');
  }

  Future<void> deleteDocument(String docId) async {
    final response = await _apiMethod.delete('api/onboarding/documents/$docId');
    if (response['success'] != true) {
      throw Exception(response['message'] ?? 'Failed to delete document');
    }
  }

  Future<List<EmployeeDocument>> getDocuments() async {
    final response = await _apiMethod.get('api/onboarding/documents');
    if (response['success'] == true) {
      final List data = response['data'];
      return data.map((e) => EmployeeDocument.fromJson(e)).toList();
    }
    throw Exception(response['message'] ?? 'Failed to get documents');
  }

  Future<OnboardingRecord> submitOnboarding() async {
    final response = await _apiMethod.put('api/onboarding/submit', body: {});
    if (response['success'] == true) {
      return OnboardingRecord.fromJson(response['data']);
    }
    throw Exception(response['message'] ?? 'Failed to submit');
  }

  // --- Admin Methods ---

  Future<List<dynamic>> getPendingOnboardings() async {
    final response = await _apiMethod.get('api/onboarding/admin/pending');
    if (response['success'] == true) {
      return response['data'] as List<dynamic>;
    }
    throw Exception(response['message'] ?? 'Failed to get pending onboardings');
  }

  Future<List<EmployeeDocument>> getAdminDocuments(String userId) async {
    final response = await _apiMethod.get('api/onboarding/admin/documents/$userId');
    if (response['success'] == true) {
      final List data = response['data'];
      return data.map((e) => EmployeeDocument.fromJson(e)).toList();
    }
    throw Exception(response['message'] ?? 'Failed to get user documents');
  }

  Future<void> verifyDocument(String docId, String status, {String? reason}) async {
    final response = await _apiMethod.put(
      'api/onboarding/admin/verify-document/$docId',
      body: {'status': status, 'reason': reason},
    );
    if (response['success'] != true) {
      throw Exception(response['message'] ?? 'Failed to verify document');
    }
  }

  Future<OnboardingRecord> finalizeOnboarding(String userId) async {
    final response = await _apiMethod.put(
      'api/onboarding/admin/finalize/$userId',
      body: {},
    );
    if (response['success'] == true) {
      return OnboardingRecord.fromJson(response['data']);
    }
    throw Exception(response['message'] ?? 'Failed to finalize onboarding');
  }
}
