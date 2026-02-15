import 'dart:convert';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/features/requests/models/request_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

final requestRepositoryProvider = Provider<RequestRepository>((ref) {
  return RequestRepository(ref.read(app_providers.apiMethodProvider));
});

class RequestRepository {
  final ApiMethod _apiMethod;
  static String _getStorageKey(String userEmail) =>
      'local_requests_cache_$userEmail';

  RequestRepository(this._apiMethod);

  Future<RequestModel> createRequest(
      RequestModel request, String userEmail) async {
    try {
      final response = await _apiMethod.post('api/requests/create', body: {
        ...request.toJson(),
        'userEmail': userEmail,
      });

      if (response['success'] == true) {
        final data = response['data'];
        final newRequest = RequestModel.fromJson(data);
        await _cacheRequest(newRequest, userEmail);
        return newRequest;
      } else {
        // If 404 (endpoint not found) or 500 (server error), fallback to local storage
        final message = response['message']?.toString() ?? '';
        if (message.contains('404') ||
            message.contains('500') ||
            message.contains('502')) {
          debugPrint(
              'RequestRepository: Backend unavailable ($message), saving locally.');
          return await _createLocalRequest(request, userEmail);
        }
        throw Exception(
            message.isNotEmpty ? message : 'Failed to create request');
      }
    } catch (e) {
      // If network error, fallback to local storage
      debugPrint('RequestRepository: Network error ($e), saving locally.');
      return await _createLocalRequest(request, userEmail);
    }
  }

  Future<RequestModel> _createLocalRequest(
      RequestModel request, String userEmail) async {
    final newRequest = request.copyWith(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      status: RequestStatus.pendingLocal,
      createdBy: userEmail,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await _cacheRequest(newRequest, userEmail);
    return newRequest;
  }

  Future<void> _cacheRequest(RequestModel request, String userEmail) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _getStorageKey(userEmail);
    final List<String> cached = prefs.getStringList(key) ?? [];
    cached.add(jsonEncode(request.toJson()));
    await prefs.setStringList(key, cached);
  }

  Future<List<RequestModel>> getRequests(
    String organizationId, {
    String? userId,
    String? userEmail,
  }) async {
    try {
      final requestUserId = (userId != null && userId.isNotEmpty)
          ? userId
          : (userEmail != null && userEmail.isNotEmpty ? userEmail : null);

      final endpoint = requestUserId != null
          ? 'api/requests/organization/$organizationId?userId=$requestUserId'
          : 'api/requests/organization/$organizationId';

      debugPrint('RequestRepository: Fetching from $endpoint');
      final response = await _apiMethod.get(endpoint);
      debugPrint('RequestRepository: Response success: ${response['success']}');

      if (response['success'] == true) {
        final List data = response['data'];
        debugPrint('RequestRepository: Parsed ${data.length} records');
        final requests = data.map((e) => RequestModel.fromJson(e)).toList();
        return requests;
      } else {
        final message = response['message']?.toString() ?? '';
        if (message.contains('404')) {
          // Endpoint not found, treat as empty list or local list
          debugPrint(
              'RequestRepository: Endpoint 404, returning local requests.');
          return await _getLocalRequests(organizationId, userEmail);
        }
        throw Exception(
            message.isNotEmpty ? message : 'Failed to fetch requests');
      }
    } catch (e) {
      // Fallback to local
      debugPrint(
          'RequestRepository: Error fetching requests ($e), returning local.');

      // If admin (userEmail is null), rethrow because we don't have local cache for admins yet
      if (userEmail == null) rethrow;

      return await _getLocalRequests(organizationId, userEmail);
    }
  }

  Future<bool> updateRequestStatus(
      String requestId, String status, String userEmail,
      {String? reason}) async {
    try {
      final response =
          await _apiMethod.patch('api/requests/$requestId/status', body: {
        'status': status,
        'userEmail': userEmail,
        if (reason != null) 'reason': reason,
      });

      return response['success'] == true;
    } catch (e) {
      debugPrint('RequestRepository: Error updating status: $e');
      return false;
    }
  }

  Future<List<RequestModel>> _getLocalRequests(
      String organizationId, String? userEmail) async {
    if (userEmail == null) return []; // No local storage for admin view yet
    final prefs = await SharedPreferences.getInstance();
    final key = _getStorageKey(userEmail);
    final List<String> cached = prefs.getStringList(key) ?? [];
    return cached
        .map((e) => RequestModel.fromJson(jsonDecode(e)))
        .where((r) => r.organizationId == organizationId)
        .toList();
  }
}
