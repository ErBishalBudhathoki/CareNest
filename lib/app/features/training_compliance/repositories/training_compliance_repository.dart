import 'dart:io';
import 'package:carenest/app/features/training_compliance/models/certification.dart';
import 'package:carenest/app/features/training_compliance/models/training_module.dart';
import 'package:carenest/app/features/training_compliance/models/compliance_checklist.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:http/http.dart' as http;

class TrainingComplianceRepository {
  final ApiMethod _apiMethod;
  static const String _basePath = 'training-compliance';

  TrainingComplianceRepository(this._apiMethod);

  Future<String?> _resolveOrganizationId(String? organizationId) async {
    if (organizationId != null && organizationId.trim().isNotEmpty) {
      return organizationId.trim();
    }
    final sp = SharedPreferencesUtils();
    await sp.init();
    final resolved = sp.getOrganizationId();
    return resolved?.trim().isNotEmpty == true ? resolved!.trim() : null;
  }

  String _appendOrgQuery(String endpoint, String organizationId) {
    final uri = Uri.parse(endpoint);
    final query = Map<String, String>.from(uri.queryParameters);
    query['organizationId'] = organizationId;
    return Uri(path: uri.path, queryParameters: query).toString();
  }

  // --- Certification Requirements ---

  Future<List<Map<String, dynamic>>> getCertificationRequirements({
    bool includeInactive = false,
    String? organizationId,
  }) async {
    var endpoint = '$_basePath/certification-requirements';
    final orgId = await _resolveOrganizationId(organizationId);
    if (orgId != null) {
      endpoint = _appendOrgQuery(endpoint, orgId);
    }
    if (includeInactive) {
      final uri = Uri.parse(endpoint);
      final query = Map<String, String>.from(uri.queryParameters);
      query['includeInactive'] = 'true';
      endpoint = Uri(path: uri.path, queryParameters: query).toString();
    }
    final response = await _apiMethod.get(endpoint);
    if (response['success'] == true) {
      final list = response['data'] as List;
      return list.map((e) => Map<String, dynamic>.from(e as Map)).toList();
    }
    throw Exception(response['message'] ?? 'Failed to fetch requirements');
  }

  Future<Map<String, dynamic>> createCertificationRequirement(
    Map<String, dynamic> data, {
    String? organizationId,
  }) async {
    final orgId = await _resolveOrganizationId(organizationId);
    if (orgId != null) {
      data = {...data, 'organizationId': orgId};
    }
    final response = await _apiMethod.post(
      '$_basePath/certification-requirements',
      body: data,
    );
    if (response['success'] == true) {
      return Map<String, dynamic>.from(response['data'] as Map);
    }
    throw Exception(response['message'] ?? 'Failed to create requirement');
  }

  Future<Map<String, dynamic>> updateCertificationRequirement(
    String id,
    Map<String, dynamic> data, {
    String? organizationId,
  }) async {
    final orgId = await _resolveOrganizationId(organizationId);
    if (orgId != null) {
      data = {...data, 'organizationId': orgId};
    }
    final response = await _apiMethod.put(
      '$_basePath/certification-requirements/$id',
      body: data,
    );
    if (response['success'] == true) {
      return Map<String, dynamic>.from(response['data'] as Map);
    }
    throw Exception(response['message'] ?? 'Failed to update requirement');
  }

  Future<void> deleteCertificationRequirement(
    String id, {
    String? organizationId,
  }) async {
    var endpoint = '$_basePath/certification-requirements/$id';
    final orgId = await _resolveOrganizationId(organizationId);
    if (orgId != null) {
      endpoint = _appendOrgQuery(endpoint, orgId);
    }
    final response = await _apiMethod.delete(endpoint);
    if (response['success'] != true) {
      throw Exception(response['message'] ?? 'Failed to delete requirement');
    }
  }

  // --- Certifications ---

  Future<Certification> uploadCertification({
    required File file,
    required String name,
    required String issuer,
    required DateTime expiryDate,
    String? notes,
    String? certificationNumber,
    String? requirementId,
    String? organizationId,
  }) async {
    final orgId = await _resolveOrganizationId(organizationId);
    final fields = {
      'name': name,
      'issuer': issuer,
      'expiryDate': expiryDate.toIso8601String(),
    };

    if (notes != null) fields['notes'] = notes;
    if (certificationNumber != null) {
      fields['certificationNumber'] = certificationNumber;
    }
    if (requirementId != null) {
      fields['requirementId'] = requirementId;
    }
    if (orgId != null) {
      fields['organizationId'] = orgId;
    }

    final filePart = await http.MultipartFile.fromPath(
      'certification',
      file.path,
    );

    final response = await _apiMethod.postMultipart(
      '$_basePath/certifications/upload',
      fields: fields,
      files: [filePart],
    );

    if (response['success'] == true) {
      return _parseCertification(response['data']);
    } else {
      throw Exception(response['message'] ?? 'Failed to upload certification');
    }
  }

  Future<List<Certification>> getCertifications({
    String? status,
    String? userId,
    String? organizationId,
  }) async {
    String endpoint = '$_basePath/certifications';
    final queryParams = <String, String>{};
    if (status != null) {
      queryParams['status'] = _toBackendCertificationStatus(status);
    }
    if (userId != null) queryParams['userId'] = userId;
    final orgId = await _resolveOrganizationId(organizationId);
    if (orgId != null) queryParams['organizationId'] = orgId;

    if (queryParams.isNotEmpty) {
      endpoint += '?${Uri(queryParameters: queryParams).query}';
    }

    final response = await _apiMethod.get(endpoint);

    if (response['success'] == true) {
      final list = response['data'] as List;
      return list.map((e) => _parseCertification(e)).toList();
    } else {
      throw Exception(response['message'] ?? 'Failed to fetch certifications');
    }
  }

  Future<Certification> auditCertification(
    String id,
    String status,
    String? notes, {
    String? certificationNumber,
    DateTime? expiryDate,
    String? organizationId,
  }) async {
    final orgId = await _resolveOrganizationId(organizationId);
    final body = <String, dynamic>{
      'status': _toBackendCertificationStatus(status),
      'notes': notes,
    };
    if (certificationNumber != null) {
      body['certificationNumber'] = certificationNumber;
    }
    if (expiryDate != null) {
      body['expiryDate'] = expiryDate.toIso8601String();
    }
    if (orgId != null) {
      body['organizationId'] = orgId;
    }

    final response = await _apiMethod.put(
      '$_basePath/certifications/$id/audit',
      body: body,
    );

    if (response['success'] == true) {
      return _parseCertification(response['data']);
    } else {
      throw Exception(response['message'] ?? 'Failed to audit certification');
    }
  }

  Future<Certification> updateCertification({
    required String id,
    String? name,
    String? issuer,
    DateTime? expiryDate,
    String? notes,
    String? certificationNumber,
    String? requirementId,
    String? organizationId,
  }) async {
    final orgId = await _resolveOrganizationId(organizationId);
    final body = <String, dynamic>{};
    if (name != null) body['name'] = name;
    if (issuer != null) body['issuer'] = issuer;
    if (expiryDate != null) body['expiryDate'] = expiryDate.toIso8601String();
    if (notes != null) body['notes'] = notes;
    if (certificationNumber != null) {
      body['certificationNumber'] = certificationNumber;
    }
    if (requirementId != null) {
      body['requirementId'] = requirementId;
    }
    if (orgId != null) {
      body['organizationId'] = orgId;
    }

    final response = await _apiMethod.put(
      '$_basePath/certifications/$id',
      body: body,
    );

    if (response['success'] == true) {
      return _parseCertification(response['data']);
    }
    throw Exception(response['message'] ?? 'Failed to update certification');
  }

  Future<void> deleteCertification(String id, {String? organizationId}) async {
    var endpoint = '$_basePath/certifications/$id';
    final orgId = await _resolveOrganizationId(organizationId);
    if (orgId != null) {
      endpoint = _appendOrgQuery(endpoint, orgId);
    }
    final response = await _apiMethod.delete(endpoint);
    if (response['success'] != true) {
      throw Exception(response['message'] ?? 'Failed to delete certification');
    }
  }

  // --- Training ---

  Future<TrainingModule> createTrainingModule(Map<String, dynamic> data) async {
    final orgId = await _resolveOrganizationId(
      data['organizationId']?.toString(),
    );
    if (orgId != null) {
      data = {...data, 'organizationId': orgId};
    }
    final response = await _apiMethod.post('$_basePath/training', body: data);

    if (response['success'] == true) {
      return _parseTrainingModule(response['data'] as Map<String, dynamic>);
    } else {
      throw Exception(
        response['message'] ?? 'Failed to create training module',
      );
    }
  }

  Future<List<TrainingModule>> getTrainingModules() async {
    var endpoint = '$_basePath/training';
    final orgId = await _resolveOrganizationId(null);
    if (orgId != null) {
      endpoint = _appendOrgQuery(endpoint, orgId);
    }
    final response = await _apiMethod.get(endpoint);

    if (response['success'] == true) {
      final list = response['data'] as List;
      return list
          .map((e) => _parseTrainingModule(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(
        response['message'] ?? 'Failed to fetch training modules',
      );
    }
  }

  Future<TrainingProgress> updateTrainingProgress(
    String moduleId,
    String status,
    int percentage,
  ) async {
    final orgId = await _resolveOrganizationId(null);
    final response = await _apiMethod.post(
      '$_basePath/training/$moduleId/progress',
      body: {
        'status': status,
        'progressPercentage': percentage,
        'organizationId': ?orgId,
      },
    );

    if (response['success'] == true) {
      final normalized = _normalizeTrainingProgress(
        response['data'] as Map<String, dynamic>,
      );
      return TrainingProgress.fromJson(normalized);
    } else {
      throw Exception(response['message'] ?? 'Failed to update progress');
    }
  }

  Future<TrainingModule> updateTrainingModule(
    String moduleId,
    Map<String, dynamic> data,
  ) async {
    final orgId = await _resolveOrganizationId(
      data['organizationId']?.toString(),
    );
    if (orgId != null) {
      data = {...data, 'organizationId': orgId};
    }
    final response = await _apiMethod.put(
      '$_basePath/training/$moduleId',
      body: data,
    );
    if (response['success'] == true) {
      return _parseTrainingModule(response['data'] as Map<String, dynamic>);
    }
    throw Exception(response['message'] ?? 'Failed to update training module');
  }

  Future<void> deleteTrainingModule(String moduleId) async {
    var endpoint = '$_basePath/training/$moduleId';
    final orgId = await _resolveOrganizationId(null);
    if (orgId != null) {
      endpoint = _appendOrgQuery(endpoint, orgId);
    }
    final response = await _apiMethod.delete(endpoint);
    if (response['success'] != true) {
      throw Exception(
        response['message'] ?? 'Failed to delete training module',
      );
    }
  }

  Future<Map<String, dynamic>> getTrainingModuleProgress(
    String moduleId,
  ) async {
    var endpoint = '$_basePath/training/$moduleId/progress';
    final orgId = await _resolveOrganizationId(null);
    if (orgId != null) {
      endpoint = _appendOrgQuery(endpoint, orgId);
    }
    final response = await _apiMethod.get(endpoint);
    if (response['success'] == true) {
      return Map<String, dynamic>.from(response);
    }
    throw Exception(response['message'] ?? 'Failed to fetch training progress');
  }

  // --- Compliance ---

  Future<ComplianceChecklist> createChecklist(Map<String, dynamic> data) async {
    final orgId = await _resolveOrganizationId(
      data['organizationId']?.toString(),
    );
    if (orgId != null) {
      data = {...data, 'organizationId': orgId};
    }
    final response = await _apiMethod.post('$_basePath/compliance', body: data);

    if (response['success'] == true) {
      return _parseChecklist(response['data'] as Map<String, dynamic>);
    } else {
      throw Exception(response['message'] ?? 'Failed to create checklist');
    }
  }

  Future<List<ComplianceChecklist>> getChecklists() async {
    var endpoint = '$_basePath/compliance';
    final orgId = await _resolveOrganizationId(null);
    if (orgId != null) {
      endpoint = _appendOrgQuery(endpoint, orgId);
    }
    final response = await _apiMethod.get(endpoint);

    if (response['success'] == true) {
      final list = response['data'] as List;
      return list
          .map((e) => _parseChecklist(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(response['message'] ?? 'Failed to fetch checklists');
    }
  }

  Future<UserChecklistStatus> updateChecklistStatus(
    String checklistId,
    Map<String, bool> itemsStatus,
    bool isCompleted,
  ) async {
    final completedItems = itemsStatus.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    final orgId = await _resolveOrganizationId(null);
    final response = await _apiMethod.post(
      '$_basePath/compliance/status',
      body: {
        'checklistId': checklistId,
        'completedItems': completedItems,
        'itemsStatus': itemsStatus,
        'isCompleted': isCompleted,
        'organizationId': ?orgId,
      },
    );

    if (response['success'] == true) {
      final data = response['data'] as Map<String, dynamic>;
      final normalized = _normalizeUserChecklistStatus(
        rawStatus: data,
        checklist: null,
      );
      return UserChecklistStatus.fromJson(normalized);
    } else {
      throw Exception(
        response['message'] ?? 'Failed to update checklist status',
      );
    }
  }

  Future<ComplianceChecklist> updateChecklist(
    String checklistId,
    Map<String, dynamic> data,
  ) async {
    final orgId = await _resolveOrganizationId(
      data['organizationId']?.toString(),
    );
    if (orgId != null) {
      data = {...data, 'organizationId': orgId};
    }
    final response = await _apiMethod.put(
      '$_basePath/compliance/$checklistId',
      body: data,
    );
    if (response['success'] == true) {
      return _parseChecklist(response['data'] as Map<String, dynamic>);
    }
    throw Exception(response['message'] ?? 'Failed to update checklist');
  }

  Future<void> deleteChecklist(String checklistId) async {
    var endpoint = '$_basePath/compliance/$checklistId';
    final orgId = await _resolveOrganizationId(null);
    if (orgId != null) {
      endpoint = _appendOrgQuery(endpoint, orgId);
    }
    final response = await _apiMethod.delete(endpoint);
    if (response['success'] != true) {
      throw Exception(response['message'] ?? 'Failed to delete checklist');
    }
  }

  Certification _parseCertification(dynamic raw) {
    final map = Map<String, dynamic>.from(raw as Map);
    final normalized = <String, dynamic>{
      ...map,
      '_id': map['_id'] ?? map['id'],
      'userId': _stringId(map['userId']),
      'name': map['name'] ?? '',
      'issuer': map['issuer'] ?? '',
      'certificationNumber': map['certificationNumber'],
      'requirementId': map['requirementId'],
      'fileUrl': map['fileUrl'] ?? '',
      'status': _toFrontendCertificationStatus(map['status']),
      'expiryDate': map['expiryDate'] ?? DateTime.now().toIso8601String(),
      'uploadedAt':
          map['uploadedAt'] ??
          map['createdAt'] ??
          DateTime.now().toIso8601String(),
    };
    return Certification.fromJson(normalized);
  }

  TrainingModule _parseTrainingModule(Map<String, dynamic> raw) {
    final normalizedModule = <String, dynamic>{
      ...raw,
      '_id': raw['_id'] ?? raw['id'],
      'title': raw['title'] ?? '',
      'description': raw['description'] ?? '',
      'contentType':
          raw['contentType'] ??
          ((raw['contentText'] != null &&
                  raw['contentText'].toString().isNotEmpty)
              ? 'Text'
              : ((raw['contentUrl'] != null &&
                        raw['contentUrl'].toString().isNotEmpty)
                    ? 'Video'
                    : 'Text')),
      'contentUrl': raw['contentUrl'],
      'contentText': raw['contentText'],
      'durationMinutes': raw['durationMinutes'] ?? 0,
      'isPublished': raw['isPublished'] ?? true,
      'createdBy': _stringId(raw['createdBy']),
      'createdAt': raw['createdAt'] ?? DateTime.now().toIso8601String(),
      'updatedAt': raw['updatedAt'] ?? DateTime.now().toIso8601String(),
    };

    final parsed = TrainingModule.fromJson(normalizedModule);
    final rawProgress = raw['userProgress'];
    if (rawProgress == null) return parsed;

    final normalizedProgress = _normalizeTrainingProgress(
      Map<String, dynamic>.from(rawProgress as Map),
      moduleIdOverride: parsed.id ?? '',
    );

    return parsed.copyWith(
      userProgress: TrainingProgress.fromJson(normalizedProgress),
    );
  }

  ComplianceChecklist _parseChecklist(Map<String, dynamic> raw) {
    final normalizedItems = (raw['items'] as List<dynamic>? ?? []).map((item) {
      final map = Map<String, dynamic>.from(item as Map);
      return <String, dynamic>{
        ...map,
        '_id': map['_id'] ?? map['id'],
        'text': map['text'] ?? '',
        'isRequired': map['isRequired'] ?? map['isMandatory'] ?? true,
      };
    }).toList();

    final normalizedChecklist = <String, dynamic>{
      ...raw,
      '_id': raw['_id'] ?? raw['id'],
      'title': raw['title'] ?? '',
      'description': raw['description'] ?? '',
      'items': normalizedItems,
      'targetRoles': raw['targetRoles'] ?? <String>[],
    };

    final parsed = ComplianceChecklist.fromJson(normalizedChecklist);
    final rawStatus = raw['userStatus'];
    if (rawStatus == null) return parsed;

    final normalizedStatus = _normalizeUserChecklistStatus(
      rawStatus: Map<String, dynamic>.from(rawStatus as Map),
      checklist: parsed,
    );

    return parsed.copyWith(
      userStatus: UserChecklistStatus.fromJson(normalizedStatus),
    );
  }

  Map<String, dynamic> _normalizeTrainingProgress(
    Map<String, dynamic> rawProgress, {
    String? moduleIdOverride,
  }) {
    return <String, dynamic>{
      ...rawProgress,
      '_id': rawProgress['_id'] ?? rawProgress['id'],
      'userId': _stringId(rawProgress['userId']),
      'moduleId': moduleIdOverride?.isNotEmpty == true
          ? moduleIdOverride
          : _stringId(rawProgress['moduleId']),
      'status': rawProgress['status'] ?? 'not_started',
      'progressPercentage':
          rawProgress['progressPercentage'] ?? rawProgress['progress'] ?? 0,
      'completedAt': rawProgress['completedAt'],
    };
  }

  Map<String, dynamic> _normalizeUserChecklistStatus({
    required Map<String, dynamic> rawStatus,
    required ComplianceChecklist? checklist,
  }) {
    final completedItems = (rawStatus['completedItems'] as List<dynamic>? ?? [])
        .map((e) => e.toString())
        .toSet();

    final itemsStatus = <String, bool>{};
    if (checklist != null) {
      for (final item in checklist.items) {
        final itemId = (item.id ?? item.text);
        itemsStatus[itemId] = completedItems.contains(itemId);
      }
    } else {
      for (final itemId in completedItems) {
        itemsStatus[itemId] = true;
      }
    }

    return <String, dynamic>{
      ...rawStatus,
      '_id': rawStatus['_id'] ?? rawStatus['id'],
      'userId': _stringId(rawStatus['userId']),
      'checklistId': _stringId(rawStatus['checklistId']),
      'itemsStatus': itemsStatus,
      'isCompleted': rawStatus['isCompleted'] ?? false,
      'lastUpdated':
          rawStatus['lastUpdated'] ??
          rawStatus['updatedAt'] ??
          DateTime.now().toIso8601String(),
    };
  }

  String _stringId(dynamic value) {
    if (value == null) return '';
    if (value is Map<String, dynamic>) {
      if (value['_id'] != null) return value['_id'].toString();
      if (value['id'] != null) return value['id'].toString();
      return '';
    }
    return value.toString();
  }

  String _toBackendCertificationStatus(String? status) {
    final normalized = (status ?? '').toLowerCase().trim();
    switch (normalized) {
      case 'pending':
        return 'pending_approval';
      case 'approved':
        return 'active';
      case 'rejected':
        return 'rejected';
      case 'expired':
        return 'expired';
      default:
        return normalized.isEmpty ? '' : normalized;
    }
  }

  String _toFrontendCertificationStatus(dynamic status) {
    final normalized = (status ?? '').toString().toLowerCase().trim();
    switch (normalized) {
      case 'pending_approval':
        return 'Pending';
      case 'active':
        return 'Approved';
      case 'rejected':
        return 'Rejected';
      case 'expired':
        return 'Expired';
      default:
        return normalized.isEmpty ? 'Pending' : status.toString();
    }
  }
}
