import 'dart:io';
import 'dart:convert';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/training_compliance/models/certification.dart';
import 'package:carenest/app/features/training_compliance/models/training_module.dart';
import 'package:carenest/app/features/training_compliance/models/compliance_checklist.dart';
import 'package:carenest/config/environment.dart';
import 'package:http/http.dart' as http;
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';

class TrainingComplianceRepository {
  final ApiMethod _apiMethod;

  TrainingComplianceRepository(this._apiMethod);

  // --- Certifications ---

  Future<Certification> uploadCertification({
    required File file,
    required String name,
    required String issuer,
    required DateTime expiryDate,
    String? notes,
  }) async {
    final sharedUtils = SharedPreferencesUtils();
    await sharedUtils.init();
    final token = sharedUtils.getAuthToken();
    
    // Construct URL manually as AppConfig.baseUrl might end with / or not
    String baseUrl = AppConfig.baseUrl;
    if (!baseUrl.endsWith('/')) baseUrl += '/';
    
    final uri = Uri.parse('${baseUrl}api/certifications/upload');
    final request = http.MultipartRequest('POST', uri);
    
    if (token != null) {
      request.headers['Authorization'] = token.startsWith('Bearer ') ? token : 'Bearer $token';
    }
    
    request.files.add(await http.MultipartFile.fromPath('certification', file.path));
    request.fields['name'] = name;
    request.fields['issuer'] = issuer;
    request.fields['expiryDate'] = expiryDate.toIso8601String();
    if (notes != null) request.fields['notes'] = notes;

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    
    if (response.statusCode == 201) {
      final body = json.decode(response.body);
      return Certification.fromJson(body['data']);
    } else {
      throw Exception('Failed to upload certification: ${response.body}');
    }
  }
  
  Future<List<Certification>> getCertifications({String? status, String? userId}) async {
    String endpoint = 'api/certifications';
    final queryParams = <String, String>{};
    if (status != null) queryParams['status'] = status;
    if (userId != null) queryParams['userId'] = userId;
    
    if (queryParams.isNotEmpty) {
      endpoint += '?${Uri(queryParameters: queryParams).query}';
    }
    
    final response = await _apiMethod.get(endpoint);
    
    if (response['success'] == true) {
      final list = response['data'] as List;
      return list.map((e) => Certification.fromJson(e)).toList();
    } else {
      throw Exception(response['message'] ?? 'Failed to fetch certifications');
    }
  }

  Future<Certification> auditCertification(String id, String status, String? notes) async {
    final response = await _apiMethod.put('api/certifications/$id/audit', body: {
      'status': status,
      'notes': notes,
    });
    
    if (response['success'] == true) {
      return Certification.fromJson(response['data']);
    } else {
      throw Exception(response['message'] ?? 'Failed to audit certification');
    }
  }

  // --- Training ---
  
  Future<TrainingModule> createTrainingModule(Map<String, dynamic> data) async {
    final response = await _apiMethod.post('api/training', body: data);
    
    if (response['success'] == true) {
      return TrainingModule.fromJson(response['data']);
    } else {
      throw Exception(response['message'] ?? 'Failed to create training module');
    }
  }

  Future<List<TrainingModule>> getTrainingModules() async {
    final response = await _apiMethod.get('api/training');
    
    if (response['success'] == true) {
      final list = response['data'] as List;
      return list.map((e) => TrainingModule.fromJson(e)).toList();
    } else {
      throw Exception(response['message'] ?? 'Failed to fetch training modules');
    }
  }

  Future<TrainingProgress> updateTrainingProgress(String moduleId, String status, int percentage) async {
    final response = await _apiMethod.post('api/training/$moduleId/progress', body: {
      'status': status,
      'progressPercentage': percentage,
    });
    
    if (response['success'] == true) {
      return TrainingProgress.fromJson(response['data']);
    } else {
      throw Exception(response['message'] ?? 'Failed to update progress');
    }
  }

  // --- Compliance ---
  
  Future<ComplianceChecklist> createChecklist(Map<String, dynamic> data) async {
    final response = await _apiMethod.post('api/compliance', body: data);
    
    if (response['success'] == true) {
      return ComplianceChecklist.fromJson(response['data']);
    } else {
      throw Exception(response['message'] ?? 'Failed to create checklist');
    }
  }

  Future<List<ComplianceChecklist>> getChecklists() async {
    final response = await _apiMethod.get('api/compliance');
    
    if (response['success'] == true) {
      final list = response['data'] as List;
      return list.map((e) => ComplianceChecklist.fromJson(e)).toList();
    } else {
      throw Exception(response['message'] ?? 'Failed to fetch checklists');
    }
  }

  Future<UserChecklistStatus> updateChecklistStatus(String checklistId, Map<String, bool> itemsStatus, bool isCompleted) async {
    final response = await _apiMethod.post('api/compliance/status', body: {
      'checklistId': checklistId,
      'itemsStatus': itemsStatus,
      'isCompleted': isCompleted,
    });
    
    if (response['success'] == true) {
      return UserChecklistStatus.fromJson(response['data']);
    } else {
      throw Exception(response['message'] ?? 'Failed to update checklist status');
    }
  }
}
