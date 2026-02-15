import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'dart:io';

import 'package:carenest/app/core/utils/Services/upload_notes.dart';
import 'package:carenest/config/environment.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/shared/utils/encryption/encrypt_decrypt.dart';
import 'package:carenest/app/shared/utils/encryption/encryption_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carenest/app/core/services/timer_service.dart';

import 'package:carenest/app/features/auth/models/user_model.dart' as app;
import 'package:carenest/app/features/client/models/client_model.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/shared/utils/debug_log.dart';

class ApiMethod extends ChangeNotifier {
  /// Get Quarterly OTE for a user (for Superannuation Cap calculation)
  Future<Map<String, dynamic>> getQuarterlyOTE(String userEmail,
      {String? date}) async {
    try {
      final endpoint =
          'api/earnings/quarterly-ote/$userEmail${date != null ? '?date=$date' : ''}';
      final response = await get(endpoint);
      return response;
    } catch (e) {
      debugPrint('Error getting quarterly OTE: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getLeaveForecast(
      String userEmail, DateTime targetDate) async {
    final dateStr = targetDate.toIso8601String().split('T')[0];
    final endpoint =
        'api/requests/forecast/$userEmail?targetDate=$dateStr'; // Adjusted to match backend route
    return await get(endpoint);
  }

  Future<Map<String, dynamic>> getLeaveBalances(String userEmail) async {
    final endpoint = 'api/leave/balances/$userEmail';
    return await get(endpoint);
  }

  Future<Map<String, dynamic>> getUserLeaveRequests(String userEmail) async {
    final endpoint = 'api/requests/user/$userEmail?type=TimeOff';
    return await get(endpoint);
  }

  Future<Map<String, dynamic>> submitLeaveRequest({
    required String userEmail,
    required String leaveType,
    required DateTime startDate,
    required DateTime endDate,
    required String reason,
    required double totalHours,
  }) async {
    final endpoint = 'api/requests';
    final body = {
      'userEmail': userEmail,
      'type': 'TimeOff',
      'details': {
        'leaveType': leaveType,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'reason': reason,
        'totalHours': totalHours,
      }
    };
    return await post(endpoint, body: body);
  }

  Future<Map<String, dynamic>> updateLeaveRequestStatus({
    required String requestId,
    required String status,
    String? adminNotes,
  }) async {
    final endpoint = 'api/requests/$requestId/status';
    final body = {
      'status': status,
      if (adminNotes != null) 'adminNotes': adminNotes,
    };
    return await put(endpoint, body: body);
  }

  Future<Map<String, dynamic>> calculateLeaveHours({
    required String startDate,
    required String endDate,
    String? organizationId,
    double dailyHours = 7.6,
  }) async {
    final endpoint = 'api/requests/calculate-hours';
    final body = {
      'startDate': startDate,
      'endDate': endDate,
      if (organizationId != null) 'organizationId': organizationId,
      'dailyHours': dailyHours,
    };
    return await post(endpoint, body: body);
  }

  Future<Map<String, dynamic>> getLeaveRequestsForOrg(String userEmail) async {
    final sharedUtils = SharedPreferencesUtils();
    await sharedUtils.init();
    final organizationId = sharedUtils.getOrganizationId();
    if (organizationId == null || organizationId.isEmpty) {
      return {'success': false, 'message': 'Organization ID not found'};
    }
    final endpoint =
        'api/requests/organization/$organizationId?userId=$userEmail&type=TimeOff';
    return await get(endpoint);
  }

  // HTTP Methods for RESTful API calls
  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      // Fix double slash issue by properly joining base URL and endpoint
      final cleanEndpoint =
          endpoint.startsWith('/') ? endpoint.substring(1) : endpoint;
      final baseNoTrailing = _baseUrl.replaceAll(RegExp(r'/+$'), '');
      final fullUrl = '$baseNoTrailing/$cleanEndpoint';

      // Debug: request construction
      debugPrint('=== API METHOD DEBUG: GET request to: $fullUrl ===');
      debugPrint('=== API METHOD DEBUG: Base URL is: $_baseUrl ===');
      debugPrint('=== API METHOD DEBUG: Endpoint is: $endpoint ===');

      final authValue = await _getAuthorizationHeaderValue();
      final hasToken = authValue != null;
      final tokenHasBearerPrefix =
          hasToken && authValue.toLowerCase().startsWith('bearer ');
      debugPrint(
          '=== API METHOD DEBUG: Auth header present: $hasToken, tokenHasBearerPrefix: $tokenHasBearerPrefix ===');
      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );

      final response = await http.get(
        Uri.parse(fullUrl),
        headers: headers,
      );
      debugPrint(
          '=== API METHOD DEBUG: GET status: ${response.statusCode} ===');

      return _handleResponse(response);
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  /// Get organization fallback base rate setting.
  ///
  /// Parameters:
  /// - [organizationId]: The organization identifier.
  ///
  /// Returns the fallback base rate as a double when configured, or null if
  /// none is set or the request fails.
  Future<double?> getFallbackBaseRate(String organizationId) async {
    try {
      final url = '${_baseUrl}api/pricing/fallback-base-rate/$organizationId';
      final sw = Stopwatch()..start();
      DebugLog.networkRequest('GET', url, payload: {
        'organizationId': organizationId,
      });
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );
      sw.stop();
      dynamic body;
      try {
        body = response.body.isNotEmpty ? json.decode(response.body) : null;
      } catch (_) {
        body = {'raw': response.body};
      }
      DebugLog.networkResponse(url, response.statusCode,
          body: body, durationMs: sw.elapsedMilliseconds);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['statusCode'] == 200 && data['data'] != null) {
          final rate = data['data']['fallbackBaseRate'];
          if (rate is num) return rate.toDouble();
        }
      }
      return null;
    } catch (e) {
      debugPrint('Exception getting fallback base rate: $e');
      DebugLog.error('Exception getting fallback base rate', details: {
        'organizationId': organizationId,
        'error': e.toString(),
      });
      return null;
    }
  }

  /// Set organization fallback base rate setting.
  ///
  /// Parameters:
  /// - [organizationId]: The organization identifier.
  /// - [fallbackBaseRate]: Positive decimal rate to set.
  /// - [userEmail]: Email of the admin performing the update.
  ///
  /// Returns `{success, message, data?}` with the updated settings on success.
  Future<Map<String, dynamic>> setFallbackBaseRate(
      String organizationId, double fallbackBaseRate, String userEmail) async {
    try {
      final url = '${_baseUrl}api/pricing/fallback-base-rate/$organizationId';
      final payload = {
        'fallbackBaseRate': fallbackBaseRate,
        'userEmail': userEmail,
      };
      final sw = Stopwatch()..start();
      DebugLog.networkRequest('PUT', url, payload: payload);
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );
      sw.stop();
      dynamic responseBody;
      try {
        responseBody =
            response.body.isNotEmpty ? json.decode(response.body) : {};
      } catch (_) {
        responseBody = {'raw': response.body};
      }
      DebugLog.networkResponse(url, response.statusCode,
          body: responseBody, durationMs: sw.elapsedMilliseconds);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': responseBody['message'] ?? 'Fallback base rate updated',
          'data': responseBody['data'],
        };
      } else {
        return {
          'success': false,
          'message':
              responseBody['message'] ?? 'Failed to update fallback base rate',
        };
      }
    } catch (e) {
      debugPrint('Exception setting fallback base rate: $e');
      DebugLog.error('Exception setting fallback base rate', details: {
        'organizationId': organizationId,
        'fallbackBaseRate': fallbackBaseRate,
        'userEmail': userEmail,
        'error': e.toString(),
      });
      return {
        'success': false,
        'message': 'Error updating fallback base rate: $e',
      };
    }
  }

  Future<Map<String, dynamic>> post(String endpoint,
      {Map<String, dynamic>? body}) async {
    try {
      // Fix double slash issue by properly joining base URL and endpoint
      final cleanEndpoint =
          endpoint.startsWith('/') ? endpoint.substring(1) : endpoint;
      final baseNoTrailing = _baseUrl.replaceAll(RegExp(r'/+$'), '');
      final fullUrl = '$baseNoTrailing/$cleanEndpoint';
      debugPrint('🚀🚀🚀 CRITICAL DEBUG: POST request to: $fullUrl 🚀🚀🚀');
      debugPrint('🚀🚀🚀 CRITICAL DEBUG: Base URL is: $_baseUrl 🚀🚀🚀');
      debugPrint('🚀🚀🚀 CRITICAL DEBUG: Endpoint is: $endpoint 🚀🚀🚀');

      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );

      debugPrint(
          '=== API METHOD DEBUG: Request headers set (Authorization present: ${headers.containsKey('Authorization')}) ===');
      if (body != null) {
        debugPrint(
            '=== API METHOD DEBUG: Request body: ${json.encode(body)} ===');
      }

      final response = await http.post(
        Uri.parse(fullUrl),
        headers: headers,
        body: body != null ? json.encode(body) : null,
      );

      debugPrint(
          '=== API METHOD DEBUG: Response status code: ${response.statusCode} ===');
      debugPrint(
          '=== API METHOD DEBUG: Response headers: ${response.headers} ===');
      debugPrint('=== API METHOD DEBUG: Response body: ${response.body} ===');

      return _handleResponse(response);
    } catch (e) {
      debugPrint('=== API METHOD DEBUG: Exception occurred: $e ===');
      debugPrint('=== API METHOD DEBUG: Exception type: ${e.runtimeType} ===');
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  Future<Map<String, dynamic>> postMultipart(
    String endpoint, {
    Map<String, String>? fields,
    List<http.MultipartFile>? files,
  }) async {
    try {
      final cleanEndpoint =
          endpoint.startsWith('/') ? endpoint.substring(1) : endpoint;
      final baseNoTrailing = _baseUrl.replaceAll(RegExp(r'/+$'), '');
      final fullUrl = '$baseNoTrailing/$cleanEndpoint';

      debugPrint(
          '=== API METHOD DEBUG: POST MULTIPART request to: $fullUrl ===');

      final sharedUtils = SharedPreferencesUtils();
      await sharedUtils.init();
      final authValue = await _getAuthorizationHeaderValue();
      final appCheckToken = await _getAppCheckToken();

      final request = http.MultipartRequest('POST', Uri.parse(fullUrl));

      if (authValue != null) {
        request.headers['Authorization'] = authValue;
      }
      if (appCheckToken != null && appCheckToken.isNotEmpty) {
        request.headers['X-Firebase-AppCheck'] = appCheckToken;
      }

      if (fields != null) {
        request.fields.addAll(fields);
      }

      if (files != null) {
        request.files.addAll(files);
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      debugPrint(
          '=== API METHOD DEBUG: Response status code: ${response.statusCode} ===');

      return _handleResponse(response);
    } catch (e) {
      debugPrint('=== API METHOD DEBUG: Exception occurred: $e ===');
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  /// Update general pricing settings for an organization.
  ///
  /// Sends a `PUT` request to `/api/settings/general` with the provided
  /// configuration payload. The request includes the `Authorization` header
  /// when a token is available in `SharedPreferencesUtils`.
  ///
  /// Parameters:
  /// - [organizationId]: The organization identifier used for context.
  /// - [settings]: A map containing general pricing settings fields:
  ///   - `autoUpdatePricing` (bool)
  ///   - `enablePriceValidation` (bool)
  ///   - `requireApprovalForChanges` (bool)
  ///   - `enableBulkOperations` (bool)
  ///   - `enablePriceHistory` (bool)
  ///   - `enableNotifications` (bool)
  ///   - `defaultCurrency` (String, 3-letter code)
  ///   - `pricingModel` (String)
  ///   - `roundingMethod` (String)
  ///   - `taxCalculation` (String, `GST Inclusive` or `GST Exclusive`)
  ///   - `defaultMarkup` (num)
  ///   - `maxPriceVariation` (num)
  ///   - `priceHistoryRetention` (int)
  ///   - `bulkOperationLimit` (int)
  ///
  /// Returns `{success, message, data?}`.
  Future<Map<String, dynamic>> updateGeneralPricingSettings(
    String organizationId,
    Map<String, dynamic> settings,
  ) async {
    try {
      final url = '${_baseUrl}api/settings/general';
      // Attach Authorization header if token exists
      final sharedUtils = SharedPreferencesUtils();
      await sharedUtils.init();
      final token = sharedUtils.getAuthToken();
      final String? authValue = (token != null && token.isNotEmpty)
          ? (token.toLowerCase().startsWith('bearer ')
              ? token
              : 'Bearer $token')
          : null;
      final headers = {
        'Content-Type': 'application/json',
        if (authValue != null) 'Authorization': authValue,
      };

      final payload = {
        'organizationId': organizationId,
        ...settings,
      };

      final sw = Stopwatch()..start();
      DebugLog.networkRequest('PUT', url, payload: payload);
      final response = await http.put(
        Uri.parse(url),
        headers: headers,
        body: json.encode(payload),
      );
      sw.stop();
      dynamic responseBody;
      try {
        responseBody =
            response.body.isNotEmpty ? json.decode(response.body) : {};
      } catch (_) {
        responseBody = {'raw': response.body};
      }
      DebugLog.networkResponse(url, response.statusCode,
          body: responseBody, durationMs: sw.elapsedMilliseconds);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': responseBody['message'] ?? 'General settings updated',
          'data': responseBody['data'],
        };
      } else {
        return {
          'success': false,
          'message': responseBody['message'] ?? 'Failed to update settings',
          'errors': responseBody['errors'],
        };
      }
    } catch (e) {
      debugPrint('Exception updating general settings: $e');
      DebugLog.error('Exception updating general settings', details: {
        'organizationId': organizationId,
        'error': e.toString(),
      });
      return {
        'success': false,
        'message': 'Error updating settings: $e',
      };
    }
  }

  Future<Map<String, dynamic>> put(String endpoint,
      {Map<String, dynamic>? body}) async {
    try {
      // Fix double slash issue by properly joining base URL and endpoint
      final cleanEndpoint =
          endpoint.startsWith('/') ? endpoint.substring(1) : endpoint;
      final baseNoTrailing = _baseUrl.replaceAll(RegExp(r'/+$'), '');
      final fullUrl = '$baseNoTrailing/$cleanEndpoint';
      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );

      final response = await http.put(
        Uri.parse(fullUrl),
        headers: headers,
        body: body != null ? json.encode(body) : null,
      );

      return _handleResponse(response);
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  Future<Map<String, dynamic>> delete(String endpoint) async {
    try {
      // Fix double slash issue by properly joining base URL and endpoint
      final cleanEndpoint =
          endpoint.startsWith('/') ? endpoint.substring(1) : endpoint;
      final baseNoTrailing = _baseUrl.replaceAll(RegExp(r'/+$'), '');
      final fullUrl = '$baseNoTrailing/$cleanEndpoint';
      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );

      final response = await http.delete(
        Uri.parse(fullUrl),
        headers: headers,
      );

      return _handleResponse(response);
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        return {'success': true};
      }

      final Map<String, dynamic> responseData = json.decode(response.body);
      responseData['success'] = true;
      return responseData;
    } else {
      try {
        final Map<String, dynamic> errorData = json.decode(response.body);
        errorData['success'] = false;
        return errorData;
      } catch (e) {
        return {
          'success': false,
          'message': 'Request failed with status: ${response.statusCode}',
        };
      }
    }
  }

//API to authenticate user login
  String get _baseUrl => AppConfig.baseUrl;

  // Public getter for baseUrl for debugging purposes
  String get baseUrl => _baseUrl;

  Uri _buildUri(String endpointOrPath) {
    final cleanEndpoint = endpointOrPath.startsWith('/')
        ? endpointOrPath.substring(1)
        : endpointOrPath;
    final baseNoTrailing = _baseUrl.replaceAll(RegExp(r'/+$'), '');
    return Uri.parse('$baseNoTrailing/$cleanEndpoint');
  }

  bool _isSameOrigin(Uri a, Uri b) {
    return a.scheme == b.scheme && a.host == b.host && a.port == b.port;
  }

  Future<String?> _getAuthorizationHeaderValue() async {
    final sharedUtils = SharedPreferencesUtils();
    await sharedUtils.init();
    final token = sharedUtils.getAuthToken();
    if (token == null || token.isEmpty) return null;
    if (token.toLowerCase().startsWith('bearer ')) return token;
    return 'Bearer $token';
  }

  Future<String?> _getAppCheckToken() async {
    try {
      final token = await FirebaseAppCheck.instance.getToken();
      if (token == null || token.isEmpty) {
        return null;
      }
      return token;
    } catch (e) {
      debugPrint('App Check token fetch failed: $e');
      return null;
    }
  }

  Future<Map<String, String>> _buildJsonHeaders({
    bool includeAuth = false,
    bool includeAppCheck = false,
    Map<String, String>? extra,
  }) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      if (extra != null) ...extra,
    };

    if (includeAuth && !headers.containsKey('Authorization')) {
      final authValue = await _getAuthorizationHeaderValue();
      if (authValue != null) {
        headers['Authorization'] = authValue;
      }
    }

    if (includeAppCheck && !headers.containsKey('X-Firebase-AppCheck')) {
      final appCheckToken = await _getAppCheckToken();
      if (appCheckToken != null && appCheckToken.isNotEmpty) {
        headers['X-Firebase-AppCheck'] = appCheckToken;
      }
    }

    return headers;
  }

  Future<http.Response> getRawUrl(
    String url, {
    Map<String, String>? headers,
    Duration? timeout,
  }) async {
    final targetUri = url.startsWith('http://') || url.startsWith('https://')
        ? Uri.parse(url)
        : _buildUri(url);
    final baseUri = Uri.parse(_baseUrl);
    final Map<String, String> combinedHeaders = {
      if (headers != null) ...headers,
    };

    if (_isSameOrigin(targetUri, baseUri)) {
      final authValue = await _getAuthorizationHeaderValue();
      if (authValue != null && !combinedHeaders.containsKey('Authorization')) {
        combinedHeaders['Authorization'] = authValue;
      }
      final appCheckToken = await _getAppCheckToken();
      if (appCheckToken != null &&
          appCheckToken.isNotEmpty &&
          !combinedHeaders.containsKey('X-Firebase-AppCheck')) {
        combinedHeaders['X-Firebase-AppCheck'] = appCheckToken;
      }
    }

    Future<http.Response> f = http.get(targetUri, headers: combinedHeaders);
    if (timeout != null) {
      f = f.timeout(timeout);
    }
    return f;
  }

  Future<http.Response> head(
    String url, {
    Map<String, String>? headers,
    Duration? timeout,
  }) async {
    final targetUri = url.startsWith('http://') || url.startsWith('https://')
        ? Uri.parse(url)
        : _buildUri(url);
    final baseUri = Uri.parse(_baseUrl);
    final Map<String, String> combinedHeaders = {
      if (headers != null) ...headers,
    };

    if (_isSameOrigin(targetUri, baseUri)) {
      final authValue = await _getAuthorizationHeaderValue();
      if (authValue != null && !combinedHeaders.containsKey('Authorization')) {
        combinedHeaders['Authorization'] = authValue;
      }
      final appCheckToken = await _getAppCheckToken();
      if (appCheckToken != null &&
          appCheckToken.isNotEmpty &&
          !combinedHeaders.containsKey('X-Firebase-AppCheck')) {
        combinedHeaders['X-Firebase-AppCheck'] = appCheckToken;
      }
    }

    Future<http.Response> f = http.head(targetUri, headers: combinedHeaders);
    if (timeout != null) {
      f = f.timeout(timeout);
    }
    return f;
  }

  Future<http.StreamedResponse> openSseStream(
    String endpoint, {
    required http.Client client,
    Map<String, String>? headers,
  }) async {
    final uri = _buildUri(endpoint);
    final Map<String, String> combinedHeaders = {
      if (headers != null) ...headers,
    };
    final authValue = await _getAuthorizationHeaderValue();
    if (authValue != null && !combinedHeaders.containsKey('Authorization')) {
      combinedHeaders['Authorization'] = authValue;
    }
    final appCheckToken = await _getAppCheckToken();
    if (appCheckToken != null &&
        appCheckToken.isNotEmpty &&
        !combinedHeaders.containsKey('X-Firebase-AppCheck')) {
      combinedHeaders['X-Firebase-AppCheck'] = appCheckToken;
    }
    final req = http.Request('GET', uri);
    req.headers.addAll(combinedHeaders);
    return client.send(req);
  }

  Future<String> uploadFile(String endpoint, File file,
      {String fieldName = 'file'}) async {
    final uri = _buildUri(endpoint);
    final request = http.MultipartRequest('POST', uri);
    final authValue = await _getAuthorizationHeaderValue();
    if (authValue != null) {
      request.headers['Authorization'] = authValue;
    }
    final appCheckToken = await _getAppCheckToken();
    if (appCheckToken != null && appCheckToken.isNotEmpty) {
      request.headers['X-Firebase-AppCheck'] = appCheckToken;
    }
    request.files.add(
      await http.MultipartFile.fromPath(
        fieldName,
        file.path,
      ),
    );
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    final decoded = response.body.isNotEmpty ? json.decode(response.body) : {};

    if (response.statusCode != 200) {
      final msg = decoded is Map
          ? (decoded['message'] ?? 'Upload failed').toString()
          : 'Upload failed';
      throw Exception(msg);
    }

    if (decoded is! Map) {
      throw Exception('Upload failed');
    }

    // Try to find the URL in various common locations
    final dynamic fileUrlValue = decoded['data']?['url'] ??
        decoded['url'] ??
        decoded['fileUrl'] ??
        decoded['data']?['fileUrl'];

    if (fileUrlValue == null || fileUrlValue.toString().isEmpty) {
      throw Exception(
          (decoded['message'] ?? 'Upload failed: No URL returned').toString());
    }

    final String fileUrl = fileUrlValue.toString();
    if (fileUrl.startsWith('http://') || fileUrl.startsWith('https://')) {
      return fileUrl;
    }

    final baseNoTrailing = _baseUrl.replaceAll(RegExp(r'/+$'), '');
    final cleanPath = fileUrl.startsWith('/') ? fileUrl.substring(1) : fileUrl;
    return '$baseNoTrailing/$cleanPath';
  }

  Future<String> uploadReceiptFile(File file) async {
    final uri = _buildUri('api/upload/receipt');
    final request = http.MultipartRequest('POST', uri);
    final authValue = await _getAuthorizationHeaderValue();
    if (authValue != null) {
      request.headers['Authorization'] = authValue;
    }
    final appCheckToken = await _getAppCheckToken();
    if (appCheckToken != null && appCheckToken.isNotEmpty) {
      request.headers['X-Firebase-AppCheck'] = appCheckToken;
    }
    request.files.add(
      await http.MultipartFile.fromPath(
        'receipt',
        file.path,
      ),
    );
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    final decoded = response.body.isNotEmpty ? json.decode(response.body) : {};
    if (response.statusCode != 200) {
      final msg = decoded is Map
          ? (decoded['message'] ?? 'Upload failed').toString()
          : 'Upload failed';
      throw Exception(msg);
    }
    if (decoded is! Map) {
      throw Exception('Upload failed');
    }
    final dynamic fileUrlValue =
        decoded['fileUrl'] ?? decoded['data']?['fileUrl'];
    if (fileUrlValue == null || fileUrlValue.toString().isEmpty) {
      throw Exception((decoded['message'] ?? 'Upload failed').toString());
    }
    final String fileUrl = fileUrlValue.toString();
    if (fileUrl.startsWith('http://') || fileUrl.startsWith('https://')) {
      return fileUrl;
    }
    final baseNoTrailing = _baseUrl.replaceAll(RegExp(r'/+$'), '');
    final cleanPath = fileUrl.startsWith('/') ? fileUrl.substring(1) : fileUrl;
    return '$baseNoTrailing/$cleanPath';
  }

  Future<String> uploadLogoFile(File file) async {
    final uri = _buildUri('api/upload/logo');
    final request = http.MultipartRequest('POST', uri);
    final authValue = await _getAuthorizationHeaderValue();
    if (authValue != null) {
      request.headers['Authorization'] = authValue;
    }
    final appCheckToken = await _getAppCheckToken();
    if (appCheckToken != null && appCheckToken.isNotEmpty) {
      request.headers['X-Firebase-AppCheck'] = appCheckToken;
    }
    request.files.add(
      await http.MultipartFile.fromPath(
        'logo',
        file.path,
      ),
    );
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    final decoded = response.body.isNotEmpty ? json.decode(response.body) : {};
    if (response.statusCode != 200) {
      final msg = decoded is Map
          ? (decoded['message'] ?? 'Upload failed').toString()
          : 'Upload failed';
      throw Exception(msg);
    }
    if (decoded is! Map) {
      throw Exception('Upload failed');
    }
    final dynamic fileUrlValue =
        decoded['fileUrl'] ?? decoded['data']?['fileUrl'];
    if (fileUrlValue == null || fileUrlValue.toString().isEmpty) {
      throw Exception((decoded['message'] ?? 'Upload failed').toString());
    }
    final String fileUrl = fileUrlValue.toString();
    if (fileUrl.startsWith('http://') || fileUrl.startsWith('https://')) {
      return fileUrl;
    }
    final baseNoTrailing = _baseUrl.replaceAll(RegExp(r'/+$'), '');
    final cleanPath = fileUrl.startsWith('/') ? fileUrl.substring(1) : fileUrl;
    return '$baseNoTrailing/$cleanPath';
  }

  TimerService timerModel = TimerService();

  Future<dynamic> authenticateUser(String email, String password) async {
    // ApiResponse _apiResponse = new ApiResponse();
    var data;
    try {
      debugPrint('${_baseUrl}hello/$email');
      final response = await http.get(Uri.parse('${_baseUrl}hello/$email'));
      //debugPrint(response.body);
      switch (response.statusCode) {
        case 200:
          data = (json.decode(response.body));
          debugPrint("200");
          break;
      }
    } on SocketException {
      // _apiResponse.ApiError = ApiError(error: "Server error. Please retry") as String;
    }
    return data;
  }

  Future<dynamic> startTimer(
      {String? userEmail, String? clientEmail, String? organizationId}) async {
    final Map<String, dynamic> requestBody = {};

    // Add parameters if provided
    if (userEmail != null) requestBody['userEmail'] = userEmail;
    if (clientEmail != null) requestBody['clientEmail'] = clientEmail;
    if (organizationId != null) requestBody['organizationId'] = organizationId;

    final response = await http.post(
      Uri.parse('${_baseUrl}startTimerWithTracking'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(requestBody),
    );
    debugPrint('Start timer response: ${response.body}');

    switch (response.statusCode) {
      case 200:
        debugPrint("Timer Started");
        break;

      case 400:
        debugPrint("Timer failed");
        break;
    }
  }

  /// Fetches employees for an organization
  /// Used by EmployeeSelectionViewModel
  Future<Map<String, dynamic>> getOrganizationEmployees(
      String organizationId) async {
    try {
      // Use the members endpoint which is known to work
      final response = await getOrganizationMembers(organizationId);

      if (response.containsKey('error')) {
        return {
          'success': false,
          'message': response['error'],
        };
      }

      // Handle backend response format variations
      List<dynamic> members = [];

      if (response.containsKey('members')) {
        members = response['members'];
      } else if (response.containsKey('data')) {
        if (response['data'] is Map &&
            response['data'].containsKey('members')) {
          members = response['data']['members'];
        } else if (response['data'] is List) {
          members = response['data'];
        }
      } else if (response.containsKey('users')) {
        members = response['users'];
      }

      return {
        'success': true,
        'employees': members,
      };
    } catch (e) {
      debugPrint("Error fetching organization employees: $e");
      return {
        'success': false,
        'message': 'Network error: $e',
      };
    }
  }

  /// Stops the timer for a specific user or organization.

  Future<void> stopTimer({String? userEmail, String? organizationId}) async {
    final Map<String, dynamic> requestBody = {};

    // Add parameters if provided
    if (userEmail != null) requestBody['userEmail'] = userEmail;
    if (organizationId != null) requestBody['organizationId'] = organizationId;

    final response = await http.post(
      Uri.parse('${_baseUrl}stopTimerWithTracking'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(requestBody),
    );
    debugPrint('Stop timer response: ${response.body}');
    var totalTimeFromTimer;
    switch (response.statusCode) {
      case 200:
        debugPrint("Timer stopped");
        totalTimeFromTimer = json.decode(response.body);
        // Use totalSeconds if available, otherwise fallback to totalTime
        final totalTime = totalTimeFromTimer['totalSeconds'] ??
            totalTimeFromTimer['totalTime']?.toInt() ??
            0;
        timerModel.setTotalTime(totalTime);
        debugPrint("Total time from timer: ${timerModel.totalTime}");
        notifyListeners(); // Notify listeners after updating totalTime
        break;

      case 400:
        debugPrint("Timer failed");
        break;
    }
  }

  Future<List<app.User>> fetchUserData() async {
    debugPrint(Uri.parse('${_baseUrl}getUsers').toString());
    final response = await http.get(Uri.parse('${_baseUrl}getUsers'));
    if (response.statusCode == 200) {
      debugPrint("I am a assignC2E user: ${response.body}");
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => app.User.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<Map<String, dynamic>> sendOTP(String email) async {
    final uri = Uri.parse('${_baseUrl}auth/forgot-password');
    debugPrint('sendOTP request URL: $uri');

    final headers = await _buildJsonHeaders(
      includeAppCheck: true,
    );
    final response = await http.post(
      uri,
      body: jsonEncode({'email': email}),
      headers: headers,
    );

    Map<String, dynamic> payload = {};
    if (response.body.isNotEmpty) {
      try {
        payload = Map<String, dynamic>.from(jsonDecode(response.body));
      } catch (_) {
        payload = {};
      }
    }

    if (response.statusCode == 200) {
      return {
        'success': true,
        'statusCode': 200,
        ...payload,
      };
    }

    return {
      'success': false,
      'statusCode': response.statusCode,
      'message': payload['message'] ?? 'Failed to send verification code',
      ...payload,
    };

    // switch (response.statusCode) {
    //   case 200:
    //     final Map<String, dynamic> responseData = json.decode(response.body);
    //     debugPrint("200: $responseData ${responseData['statuesCode']}");
    //     return {
    //       'statusCode': responseData['statusCode'],
    //       'message': responseData['message']
    //     }; // Return the message
    //   case 400:
    //     final Map<String, dynamic> responseData = json.decode(response.body);
    //     debugPrint("400: $responseData ${responseData['statuesCode']}");
    //     return {
    //       'statusCode': responseData['statusCode'],
    //       'message': responseData['message']
    //     }; // Return the message
    //   case 500:
    //     final Map<String, dynamic> responseData = json.decode(response.body);
    //     debugPrint("500: $responseData");
    //     return {
    //       'statusCode': responseData['statusCode'],
    //       'message': responseData['message']
    //     }; // Return the message
    //   default:
    //     final Map<String, dynamic> responseData = json.decode(response.body);
    //     return {
    //       'statusCode': responseData['statusCode'],
    //       'message': responseData['message']
    //     }; // Handle other status codes as needed
    // }
  }

  Future<Map<String, dynamic>> resetForgotPassword({
    required String email,
    required String otp,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final uri = Uri.parse('${_baseUrl}auth/reset-password');
    final headers = await _buildJsonHeaders(
      includeAppCheck: true,
    );

    final response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode({
        'email': email,
        'otp': otp,
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
      }),
    );

    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> verifyOTP(
    String userOtp,
    String userVerificationKey,
    String generatedOtp,
    String encryptVerificationKey,
  ) async {
    final response = await http.post(
      Uri.parse('${_baseUrl}verifyOTP'),
      body: jsonEncode({
        'userOTP': userOtp,
        'userVerificationKey': userVerificationKey,
        'generatedOTP': generatedOtp,
        'encryptVerificationKey': encryptVerificationKey,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result['statusCode'] == 200) {
        // OTP verification successful
        return result;
      } else {
        // OTP verification failed, handle accordingly
        throw Exception(result['message']);
      }
    } else {
      throw Exception('Failed to verify OTP');
    }
  }

  Future<Map<String, dynamic>> changePassword(
      String hashedPasswordWithSalt, String email) async {
    Map<String, dynamic> data = {};

    try {
      final response = await http.post(
        Uri.parse('${_baseUrl}updatePassword'),
        body:
            jsonEncode({'newPassword': hashedPasswordWithSalt, 'email': email}),
        headers: {'Content-Type': 'application/json'},
      );

      switch (response.statusCode) {
        case 200:
          data = Map<String, dynamic>.from(json.decode(response.body));
          debugPrint("200: $data");
          break;
        case 400:
          data = Map<String, dynamic>.from(json.decode(response.body));
          debugPrint("400: ${data['message']}");
          break;
        default:
          debugPrint("Unhandled status code: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error: $e");
      // Handle the error if needed
    }

    return data;
  }

  Future<String> firebaseUpdatePassword(
      String newPassword, String email) async {
    try {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: newPassword);
      await FirebaseAuth.instance.currentUser!
          .reauthenticateWithCredential(credential);
      await FirebaseAuth.instance.currentUser!.updatePassword(newPassword);

      debugPrint('Password updated!');
      return "Password updated!";
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }

  // Future<Map<String, dynamic>> sendOTP(String emailRecipient) async {
  //   debugPrint("Send OTP called");
  //   debugPrint(Uri.parse('${_baseUrl}sendOTP'));
  //
  //   final Map<String, dynamic> requestBody = {
  //     'email': emailRecipient,
  //     // Add any other parameters you need for the email service
  //   };
  //
  //   final response = await http.post(
  //     Uri.parse('${_baseUrl}sendOTP'),
  //     body: json.encode(requestBody),
  //     headers: {'Content-Type': 'application/json'},
  //   );
  //
  //   switch (response.statusCode) {
  //     case 200:
  //       final Map<String, dynamic> responseData = json.decode(response.body);
  //       debugPrint("200: $responseData ${responseData['statuesCode']}");
  //       return {
  //         'statusCode': responseData['statusCode'],
  //         'message': responseData['message']
  //       }; // Return the message
  //     case 400:
  //       final Map<String, dynamic> responseData = json.decode(response.body);
  //       debugPrint("400: $responseData ${responseData['statuesCode']}");
  //       return {
  //         'statusCode': responseData['statusCode'],
  //         'message': responseData['message']
  //       }; // Return the message
  //     case 500:
  //       final Map<String, dynamic> responseData = json.decode(response.body);
  //       debugPrint("500: $responseData");
  //       return {
  //         'statusCode': responseData['statusCode'],
  //         'message': responseData['message']
  //       }; // Return the message
  //     default:
  //       final Map<String, dynamic> responseData = json.decode(response.body);
  //       return {
  //         'statusCode': responseData['statusCode'],
  //         'message': responseData['message']
  //       }; // Handle other status codes as needed
  //   }
  // }

  Future<List<Patient>> fetchClientData() async {
    debugPrint(Uri.parse('${_baseUrl}getClients').toString());
    final response = await http.get(Uri.parse('${_baseUrl}getClients'));
    if (response.statusCode == 200) {
      debugPrint("I am a response client: \n${response.body}");
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      // Handle the response format from the backend
      if (jsonResponse['clients'] != null) {
        List clientsList = jsonResponse['clients'];
        return clientsList.map((data) => Patient.fromJson(data)).toList();
      } else {
        // Fallback for direct array response
        List jsonArray = json.decode(response.body);
        return jsonArray.map((data) => Patient.fromJson(data)).toList();
      }
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<dynamic> getInitData(String email) async {
    var data;
    try {
      debugPrint('${_baseUrl}initData/$email');
      final response = await http.get(Uri.parse('${_baseUrl}initData/$email'));
      data = (json.decode(response.body));

      // Ensure a value is returned even on error status codes
      if (response.statusCode != 200) {
        debugPrint(
            "Get init data failed with status ${response.statusCode}: ${response.body}");
      }
    } on SocketException {
      debugPrint("Get init data failed: SocketException");
      data = {'statusCode': 500, 'message': 'Network error'};
    } catch (e) {
      debugPrint("Get init data failed: $e");
      data = {'statusCode': 500, 'message': 'An error occurred'};
    }
    return data;
  }

  /// Fetches the actual logged work time for a user and client within a specific organization.
  Future<Map<String, dynamic>> getWorkedTime(
      String userEmail, String clientEmail, String organizationId) async {
    try {
      // THE FIX: Add the organizationId as a query parameter to the URL.
      final uri = Uri.parse(
          '${_baseUrl}getWorkedTime/$userEmail/$clientEmail?organizationId=$organizationId');

      final response = await http.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        // The backend now sends a meaningful error message on 404.
        final errorBody = jsonDecode(response.body);
        return {
          'success': false,
          'message': errorBody['message'] ??
              'Failed to load worked time: Status ${response.statusCode}',
          'workedTimes': []
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error loading worked time: $e',
        'workedTimes': []
      };
    }
  }

  Future<List<Patient>> fetchMultiplePatientData(String emails) async {
    debugPrint(Uri.parse('${_baseUrl}getMultipleClients/$emails').toString());
    debugPrint(emails.toString());
    final response =
        await http.get(Uri.parse('${_baseUrl}getMultipleClients/$emails'));
    if (response.statusCode == 200) {
      debugPrint("I am a response client: \n${response.body}");
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Patient.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<dynamic> deleteHolidayItem(String id) async {
    debugPrint('${_baseUrl}deleteHoliday/$id');
    final response =
        await http.delete(Uri.parse('${_baseUrl}deleteHoliday/$id'));
    if (response.statusCode == 200) {
      //debugPrint("I am a response client: \n${response.body}");
      try {
        var jsonResponse = json.decode(response.body);
        return jsonResponse;
      } catch (e) {
        debugPrint("Error: $e");
      }
    } else if (response.statusCode == 400) {
      debugPrint("Holiday not found");
    } else if (response.statusCode == 404) {
      throw Exception('Not Found!');
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<dynamic> addHolidayItem(Map<String, String> newHoliday) async {
    // Use the internal post method which handles Auth headers and logging
    final result = await post('addHolidayItem', body: newHoliday);

    if (result['success'] == true) {
      return result;
    } else {
      debugPrint("Add Holiday failed: ${result['message']}");
      // The calling UI expects an exception on failure
      throw Exception(result['message'] ?? 'Failed to add holiday');
    }
  }

  /// Fetches appointment data for a given email
  /// Returns empty data structure for new users or when no appointments exist
  Future<dynamic> getAppointmentData(String email) async {
    debugPrint('${_baseUrl}loadAppointments/$email');
    try {
      final response =
          await http.get(Uri.parse('${_baseUrl}loadAppointments/$email'));

      if (response.statusCode == 200) {
        //debugPrint("I am a response client: \n${response.body}");
        try {
          var jsonResponse = json.decode(response.body);
          return jsonResponse;
        } catch (e) {
          debugPrint("JSON decode error: $e");
          // Return empty data structure if JSON parsing fails
          return {'data': []};
        }
      } else if (response.statusCode == 404) {
        // User has no appointments yet - return empty data structure
        debugPrint('No appointments found for user: $email');
        return {'data': []};
      } else {
        // For other status codes, log the error and return empty data
        debugPrint('API error ${response.statusCode}: ${response.body}');
        return {'data': []};
      }
    } catch (e) {
      // Handle network errors or other exceptions
      debugPrint('Network error loading appointments: $e');
      return {'data': []};
    }
  }

  Future<dynamic> setWorkedTime(
    String userEmail,
    String clientEmail,
    String workedTime,
    int shiftIndex,
  ) async {
    try {
      final url = '${_baseUrl}setWorkedTime';
      debugPrint('Calling API: $url');

      final headers = {
        'Content-Type': 'application/json',
      };

      final body = {
        'User-Email': userEmail,
        'Client-Email': clientEmail,
        'TimeList': workedTime,
        'shiftIndex': shiftIndex,
      };

      debugPrint('Request body: ${json.encode(body)}');

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body),
      );

      debugPrint('Response status code: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        try {
          var jsonResponse = json.decode(response.body);
          debugPrint("API Response: $jsonResponse");
          return jsonResponse;
        } catch (e) {
          debugPrint("JSON Parse Error: $e");
          return {'message': response.body};
        }
      } else if (response.statusCode == 400) {
        throw Exception('Bad request, please check your input data');
      } else if (response.statusCode == 404) {
        throw Exception('Endpoint not found');
      } else {
        throw Exception(
            'Unexpected error occurred! Status: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('API Error: $e');
      rethrow;
    }
  }

  Future<dynamic> setWorkedTimer(
      String userEmail, String clientEmail, String time) async {
    debugPrint('${_baseUrl}setWorkedTimer/');
    final url = '${_baseUrl}setWorkedTimer/';
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = {
      'User-Email': userEmail,
      'Client-Email': clientEmail,
      'TimeList': time,
    };
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: json.encode(body),
    );
    if (response.statusCode == 200) {
      try {
        var jsonResponse = json.decode(response.body);
        debugPrint("I am a response client: \n${response.body}");
        return jsonResponse;
      } catch (e) {
        debugPrint("Error: $e");
      }
    } else if (response.statusCode == 400) {
      throw Exception('Bad request, please check your input data');
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized, please check your API key');
    } else if (response.statusCode == 404) {
      throw Exception('Endpoint not found');
    } else {
      throw Exception('Unexpected error occurred!');
    }
  }

  Future<dynamic> getClientAndAppointmentData(
      String userEmail, String clientEmail) async {
    debugPrint('${_baseUrl}loadAppointmentDetails/$userEmail/$clientEmail');
    final response = await http.get(
        Uri.parse('${_baseUrl}loadAppointmentDetails/$userEmail/$clientEmail'));
    if (response.statusCode == 200) {
      debugPrint("I am a response client: \n${response.body}");
      try {
        var jsonResponse = json.decode(response.body);
        return jsonResponse;
      } catch (e) {
        debugPrint("Error: $e");
      }
    } else {
      throw Exception('Unexpected error occured!');
    }

    // Return a default value after the try-catch block
  }

  /// Enhanced FCM token registration with device information
  Future<Map<String, dynamic>> registerFcmToken(
    String email,
    String organizationId,
    String fcmToken, {
    String? deviceId,
    String? deviceInfo,
  }) async {
    try {
      final body = {
        'email': email,
        'organizationId': organizationId,
        'fcmToken': fcmToken,
        if (deviceId != null) 'deviceId': deviceId,
        if (deviceInfo != null) 'deviceInfo': deviceInfo,
        'timestamp': DateTime.now().toIso8601String(),
      };

      return post('auth/register-fcm-token', body: body);
    } catch (e) {
      debugPrint('FCM token registration error: $e');
      return {
        'success': false,
        'message': 'FCM token registration failed: $e',
      };
    }
  }

  late Map<String, dynamic> data = {};

  Future<Map<String, dynamic>?> checkEmail(String email) async {
    try {
      debugPrint('${_baseUrl}checkEmail/$email');
      //post method with body
      final response =
          await http.get(Uri.parse('${_baseUrl}checkEmail/$email'));
      //debugPrint(response.body);
      switch (response.statusCode) {
        case 200:
          data = Map<String, dynamic>.from(json.decode(response.body));
          //debugPrint("200"+ data['email']);
          break;
        case 400:
          data = Map<String, dynamic>.from(json.decode(response.body));
          //debugPrint("400"+ data['email']);
          break;
      }
      //debugPrint("checkEmail: "+response.body);
    } on SocketException {
      // _apiResponse.ApiError = ApiError(error: "Server error. Please retry") as String;
    }
    return data;
  }

  Future<Map<String, dynamic>> getUserPayDetails(String email) async {
    try {
      final encoded = Uri.encodeComponent(email);
      final response = await http.get(
        Uri.parse('${_baseUrl}userPayDetails/$encoded'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body is Map<String, dynamic>) return body;
        return {'success': false, 'message': 'Invalid response body'};
      }

      if (response.body.isNotEmpty) {
        final body = jsonDecode(response.body);
        if (body is Map<String, dynamic>) return body;
      }

      return {
        'success': false,
        'message': 'Failed to fetch user pay details: ${response.statusCode}',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error fetching user pay details: $e',
      };
    }
  }

  /// Get detailed client information including businessName from clients collection
  /// This method fetches comprehensive client data needed for invoice generation
  Future<Map<String, dynamic>?> getClientDetails(String clientEmail) async {
    try {
      debugPrint('Fetching client details for: $clientEmail');
      debugPrint('API URL: ${_baseUrl}getClientDetails/$clientEmail');

      final response = await http.get(
        Uri.parse(
            '${_baseUrl}getClientDetails/${Uri.encodeComponent(clientEmail)}'),
        headers: {'Content-Type': 'application/json'},
      );

      debugPrint('Client details response status: ${response.statusCode}');
      debugPrint('Client details response body: ${response.body}');

      switch (response.statusCode) {
        case 200:
          final responseData =
              Map<String, dynamic>.from(json.decode(response.body));
          debugPrint('Successfully fetched client details: $responseData');
          // Extract the actual client details from the nested structure
          if (responseData.containsKey('clientDetails')) {
            final clientDetails =
                responseData['clientDetails'] as Map<String, dynamic>;
            // Add success flag and message for consistency
            clientDetails['success'] = true;
            clientDetails['message'] = responseData['message'] ??
                'Client details retrieved successfully';
            return clientDetails;
          }
          return responseData;
        case 404:
          debugPrint('Client not found: $clientEmail');
          return {
            'success': false,
            'message': 'Client not found',
            'clientEmail': clientEmail,
            'clientFirstName': '',
            'clientLastName': '',
            'businessName': '',
          };
        case 400:
          final errorData =
              Map<String, dynamic>.from(json.decode(response.body));
          debugPrint('Bad request for client details: ${errorData['message']}');
          return errorData;
        default:
          debugPrint('Unexpected status code: ${response.statusCode}');
          return {
            'success': false,
            'message': 'Unexpected error: ${response.statusCode}',
            'clientEmail': clientEmail,
            'clientFirstName': '',
            'clientLastName': '',
            'businessName': '',
          };
      }
    } on SocketException catch (e) {
      debugPrint('Network error fetching client details: $e');
      return {
        'success': false,
        'message': 'Network error. Please check your connection.',
        'clientEmail': clientEmail,
        'clientFirstName': '',
        'clientLastName': '',
        'businessName': '',
      };
    } catch (e) {
      debugPrint('Exception in getClientDetails: $e');
      return {
        'success': false,
        'message': 'Error fetching client details: $e',
        'clientEmail': clientEmail,
        'clientFirstName': '',
        'clientLastName': '',
        'businessName': '',
      };
    }
  }

  Future<Map<String, dynamic>> deleteUser(String email) async {
    try {
      debugPrint('${_baseUrl}deleteUser/$email');
      //post method with body
      final response = await http.delete(Uri.parse('${_baseUrl}deleteUser/'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email}));
      //debugPrint(response.body);
      switch (response.statusCode) {
        case 200:
          data = Map<String, dynamic>.from(json.decode(response.body));
          //debugPrint("200"+ data['email']);
          break;
        case 400:
          data = Map<String, dynamic>.from(json.decode(response.body));
          //debugPrint("400"+ data['email']);
          break;
      }
      //debugPrint("checkEmail: "+response.body);
    } on SocketException {
      // _apiResponse.ApiError = ApiError(error: "Server error. Please retry") as String;
    }
    return data;
  }

  Future<Map<String, dynamic>> getSalt(String email) async {
    try {
      debugPrint('${_baseUrl}getSalt/$email');
      //post method with body
      final response = await http.post(Uri.parse('${_baseUrl}getSalt/'),
          body: jsonEncode({'email': email}),
          headers: {'Content-Type': 'application/json'});
      debugPrint("Salt me: ${response.body} ${response.statusCode}");
      switch (response.statusCode) {
        case 200:
          // Decode and try to extract salt from multiple possible locations
          final decoded = Map<String, dynamic>.from(json.decode(response.body));
          String? extractedSalt;

          // 1) Top-level salt
          if (decoded['salt'] != null &&
              decoded['salt'].toString().isNotEmpty) {
            extractedSalt = decoded['salt'].toString();
          } else {
            // 2) Nested: data.salt
            final dataNode = decoded['data'];
            if (dataNode is Map &&
                dataNode['salt'] != null &&
                dataNode['salt'].toString().isNotEmpty) {
              extractedSalt = dataNode['salt'].toString();
            }
            // 3) Nested: payload.salt
            if (extractedSalt == null) {
              final payloadNode = decoded['payload'];
              if (payloadNode is Map &&
                  payloadNode['salt'] != null &&
                  payloadNode['salt'].toString().isNotEmpty) {
                extractedSalt = payloadNode['salt'].toString();
              }
            }
            // 4) Nested: user.salt
            if (extractedSalt == null) {
              final userNode = decoded['user'];
              if (userNode is Map &&
                  userNode['salt'] != null &&
                  userNode['salt'].toString().isNotEmpty) {
                extractedSalt = userNode['salt'].toString();
              }
            }
          }

          // Preserve original map and normalize salt
          data = decoded;
          if (extractedSalt == null) {
            debugPrint(
                "Warning: Backend returned empty or missing salt for user: $email");
            data['error'] = 'Empty salt returned from server';
          } else {
            data['salt'] = extractedSalt;
          }
          break;
        case 400:
          data = Map<String, dynamic>.from(json.decode(response.body));
          debugPrint(
              "400 error getting salt: ${data['message'] ?? 'Unknown error'}");
          break;
        case 404:
          debugPrint("404: User not found - $email");
          data = {
            'error': 'User not found',
            'errorCode': 'USER_NOT_FOUND',
            'statusCode': 404
          };
          break;
        case 500:
          debugPrint("500: Server error getting salt");
          data = {
            'error': 'Server error occurred',
            'errorCode': 'SERVER_ERROR',
            'statusCode': 500
          };
          break;
        default:
          debugPrint(
              "Unexpected status code getting salt: ${response.statusCode}");
          data = {
            'error': 'Unexpected status code: ${response.statusCode}',
            'errorCode': 'UNKNOWN_ERROR',
            'statusCode': response.statusCode
          };
          break;
      }
    } on SocketException {
      data = {'error': 'Network error. Please check your connection.'};
    } catch (e) {
      data = {'error': 'Failed to get salt: $e'};
    }
    debugPrint("Salt getSalt: $data");
    return data;
  }

  Future<dynamic> login(String email, String password) async {
    final response = await secureLogin({
      'email': email,
      'password': password,
    });

    if (response['success'] == true) {
      return response;
    }

    return {
      'success': false,
      'message': response['message'] ?? 'Login failed',
      'errorCode': response['errorCode'] ?? 'UNKNOWN_ERROR',
      'statusCode': response['statusCode'] ?? 500,
    };
  }

  Future<dynamic> uploadCSV() async {
    try {
      debugPrint('${_baseUrl}uploadCSV');
      final response = await http.post(Uri.parse('${_baseUrl}uploadCSV'));
      switch (response.statusCode) {
        case 200:
          data = Map<String, dynamic>.from(json.decode(response.body));
          debugPrint("200 ${data['message']}");
          return data;
        case 400:
          data = Map<String, dynamic>.from(json.decode(response.body));
          debugPrint("400 ${data['message']}");
          return data;
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  late List<dynamic> businessNameList = [];

  Future<dynamic> getBusinessNameList() async {
    try {
      debugPrint('${_baseUrl}business-names');
      final response = await http.get(Uri.parse('${_baseUrl}business-names'));
      switch (response.statusCode) {
        case 200:
          final data = json.decode(response.body);
          if (data != null) {
            businessNameList = List<dynamic>.from(data);
            debugPrint(data);
          }
          debugPrint("200 ");
          return businessNameList;
        case 400:
          final data = json.decode(response.body);
          if (data != null) {
            businessNameList = List<dynamic>.from(data);
            debugPrint(data);
          }
          debugPrint("400 ");
          return businessNameList;
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  late List<dynamic> holidaysList = [];

  Future<dynamic> getHolidays({String? organizationId}) async {
    try {
      String url = '${_baseUrl}getHolidays';
      if (organizationId != null) {
        url += '?organizationId=$organizationId';
      }

      final response = await http.get(Uri.parse(url));
      switch (response.statusCode) {
        case 200:
          final data = json.decode(response.body);
          if (data != null) {
            holidaysList = List<dynamic>.from(data);
            debugPrint("Holiday list: $holidaysList");
          }
          debugPrint("200 ");
          return data;
        case 400:
          final data = json.decode(response.body);
          if (data != null) {
            holidaysList = List<dynamic>.from(data);
          }
          debugPrint("400 ");
          return data;
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  late List<dynamic> list = [];

  Future<dynamic> getUserDocs() async {
    try {
      final response = await http.get(Uri.parse('${_baseUrl}user-docs'));
      switch (response.statusCode) {
        case 200:
          final data = json.decode(response.body);
          debugPrint(data);
          if (data != null && data['userDocs'] is List<dynamic>) {
            list = data['userDocs'];
            debugPrint("\nlist of all assigned clients:\n $list");
          }
          debugPrint("200 ");
          return data;
        case 400:
          final data = json.decode(response.body);
          if (data != null && data['userDocs'] is List<dynamic>) {
            list = data['userDocs'];
          }
          debugPrint("400 ");
          return data;
      }
    } on SocketException catch (e) {
      if (e.message.contains("Connection refused")) {
        debugPrint("Connection refused");
      } else {
        debugPrint("Other error: $e");
      }
    } catch (e) {
      debugPrint("Error get user docs: $e");
    }
  }

  Future<Map<String, dynamic>?> saveCustomPriceForOrganization(
      String ndisItemNumber, double price, String notes,
      {Map<String, dynamic>? metadata,
      String? userEmail,
      String? organizationId}) async {
    try {
      final requestBody = {
        'ndisItemNumber': ndisItemNumber,
        'price': price,
        'notes': notes,
      };

      // Add metadata if provided
      if (metadata != null) {
        requestBody['metadata'] = metadata;
      }

      final headers = {
        'Content-Type': 'application/json',
      };

      // Add authentication headers if provided
      if (userEmail != null) {
        headers['user-email'] = userEmail;
      }
      if (organizationId != null) {
        headers['organization-id'] = organizationId;
      }

      final response = await http.post(
        Uri.parse('${_baseUrl}save-custom-price-organization'),
        headers: headers,
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        debugPrint('Error saving custom price: ${response.body}');
        return {'success': false, 'message': 'Failed to save custom price'};
      }
    } catch (e) {
      debugPrint('Exception saving custom price: $e');
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  Future<Map<String, dynamic>?> saveCustomPriceForClient(
      String ndisItemNumber, String clientId, double price, String notes,
      {Map<String, dynamic>? metadata,
      String? userEmail,
      String? organizationId}) async {
    try {
      final requestBody = {
        'ndisItemNumber': ndisItemNumber,
        'clientId': clientId,
        'price': price,
        'notes': notes,
      };

      // Add metadata if provided
      if (metadata != null) {
        requestBody['metadata'] = metadata;
      }

      final headers = {
        'Content-Type': 'application/json',
      };

      // Add authentication headers if provided
      if (userEmail != null) {
        headers['user-email'] = userEmail;
      }
      if (organizationId != null) {
        headers['organization-id'] = organizationId;
      }

      final response = await http.post(
        Uri.parse('${_baseUrl}save-custom-price-client'),
        headers: headers,
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        debugPrint('Error saving client custom price: ${response.body}');
        return {
          'success': false,
          'message': 'Failed to save client custom price'
        };
      }
    } catch (e) {
      debugPrint('Exception saving client custom price: $e');
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  Future<double> getCustomPriceForOrganization(String ndisItemNumber) async {
    try {
      // Get user credentials from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userEmail = prefs.getString('userEmail');
      String? organizationId = prefs.getString('organizationId');

      if (userEmail == null || organizationId == null) {
        debugPrint('Missing user credentials for organization custom price');
        return 0.0;
      }

      final response = await http.get(
        Uri.parse('${_baseUrl}custom-price-organization/$ndisItemNumber'),
        headers: {
          'Content-Type': 'application/json',
          'user-email': userEmail,
          'organization-id': organizationId,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['price'] != null) {
          return double.parse(data['price'].toString());
        }
      }
      return 0.0; // No custom price found
    } catch (e) {
      debugPrint('Exception getting organization custom price: $e');
      return 0.0;
    }
  }

  Future<double> getCustomPriceForClient(
      String ndisItemNumber, String clientId) async {
    try {
      // Get user credentials from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userEmail = prefs.getString('userEmail');
      String? organizationId = prefs.getString('organizationId');

      if (userEmail == null || organizationId == null) {
        debugPrint('Missing user credentials for client custom price');
        return 0.0;
      }

      final response = await http.get(
        Uri.parse('${_baseUrl}custom-price-client/$ndisItemNumber/$clientId'),
        headers: {
          'Content-Type': 'application/json',
          'user-email': userEmail,
          'organization-id': organizationId,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['price'] != null) {
          return double.parse(data['price'].toString());
        }
      }
      return 0.0; // No custom price found
    } catch (e) {
      debugPrint('Exception getting client custom price: $e');
      return 0.0;
    }
  }

  /// Get price history for an NDIS item and client
  /// Returns a list of previous pricing decisions
  Future<List<Map<String, dynamic>>?> getPriceHistory(
      String ndisItemNumber, String clientId) async {
    try {
      final response = await http.get(
        Uri.parse('${_baseUrl}price-history/$ndisItemNumber/$clientId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['history'] != null) {
          return List<Map<String, dynamic>>.from(data['history']);
        }
      }
      return []; // No history found
    } catch (e) {
      debugPrint('Exception getting price history: $e');
      return [];
    }
  }

  Future<double?> getNdisItemPriceCap(String ndisItemNumber) async {
    try {
      final response = await http.get(
        Uri.parse('${_baseUrl}ndis-price-cap/$ndisItemNumber'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['priceCap'] != null) {
          return double.parse(data['priceCap'].toString());
        }
      }
      return null; // No price cap found
    } catch (e) {
      debugPrint('Exception getting NDIS item price cap: $e');
      return null;
    }
  }

  Future<double> getStandardPrice(String ndisItemNumber) async {
    try {
      final response = await http.get(
        Uri.parse('${_baseUrl}standard-price/$ndisItemNumber'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['price'] != null) {
          return double.parse(data['price'].toString());
        }
      }
      return 0.0; // No standard price found
    } catch (e) {
      debugPrint('Exception getting standard price: $e');
      return 0.0;
    }
  }

  Future<Map<String, dynamic>?> getAssignedClients() async {
    try {
      debugPrint("getAssignedClients called");
      final response =
          await http.get(Uri.parse('${_baseUrl}assigned-client-data'));
      switch (response.statusCode) {
        case 200:
          Map<String, dynamic> data = json.decode(response.body);
          debugPrint(data.toString());
          if (data['assignedClientData'] is List<dynamic>) {
            list = data['assignedClientData'];
            //debugPrint("\nlist of all assigned clients:\n $list");
          }
          debugPrint("200 ");
          return data;
        case 400:
          final data = json.decode(response.body);
          if (data != null && data['assignedClientData'] is List<dynamic>) {
            list = data['assignedClientData'];
          }
          debugPrint("400 ");
          return data;
      }
    } on SocketException catch (e) {
      if (e.message.contains("Connection refused")) {
        debugPrint("Connection refused");
      } else {
        debugPrint("Other error: $e");
      }
    } catch (e) {
      debugPrint("Error get assigned clients: $e");
    }
    return null;
  }

  Future<Map<String, dynamic>> signupUser(String firstName, String lastName,
      String email, String password, String abn, String role,
      {String? organizationId, String? organizationCode}) async {
    try {
      final checkEmailResponse =
          await http.get(Uri.parse('${_baseUrl}checkEmail/$email'));
      debugPrint('${_baseUrl}checkEmail/$email');

      switch (checkEmailResponse.statusCode) {
        case 200:
          debugPrint(
              "Email already exists: ${json.decode(checkEmailResponse.body)['email']}");
          return {"error": "Email already exists"};
        case 404: // Email not found, proceed with signup
        case 400: // Proceed with signup (some backends might use 400 for 'bad request' but here we treat as check passed or proceed)
          // Generate salt and hash password before sending to backend
          final encryptionUtils = EncryptionUtils();
          final salt = encryptionUtils.generateSalt();
          final hashedPassword =
              encryptionUtils.encryptPasswordWithArgon2andSalt(password, salt);

          // Convert salt to hex string for backend storage
          final saltHex =
              salt.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();

          // Prepare request body
          final requestBody = {
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "password": hashedPassword,
            "salt": saltHex,
            "abn": abn,
            "role": role
          };

          // Add organization parameters if provided
          if (organizationId != null) {
            requestBody["organizationId"] = organizationId;
          }
          if (organizationCode != null) {
            requestBody["organizationCode"] = organizationCode;
          }

          final signupResponse = await http.post(
            Uri.parse('${_baseUrl}signup/$email'),
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json"
            },
            body: jsonEncode(requestBody),
          );
          debugPrint('${_baseUrl}signup/$email');

          switch (signupResponse.statusCode) {
            case 200:
              final signupData = json.decode(signupResponse.body);
              debugPrint("Signup successful: ${signupResponse.body}");
              return signupData;
            case 400:
              final errorData = json.decode(signupResponse.body);
              debugPrint("Signup failed: ${signupResponse.body}");
              return {"error": errorData['message'] ?? "Signup failed"};
            case 409:
              debugPrint("Email already exists");
              return {"error": "Email already exists"};
            case 500:
              debugPrint("Server error: ${signupResponse.body}");
              return {"error": "Server error: ${signupResponse.body}"};
            default:
              debugPrint(
                  "Signup failed with status code ${signupResponse.statusCode}");
              return {
                "error":
                    "Signup failed with status code ${signupResponse.statusCode}"
              };
          }
      }
    } on SocketException {
      debugPrint("Server error. Please retry");
      return {"error": "Server error. Please retry"};
    }
    return {"error": "Unknown error occurred"};
  }

  Future<dynamic> addClient(
    String FirstName,
    String LastName,
    String Email,
    String Phone,
    String Address,
    String City,
    String State,
    String Zip,
    String businessName, {
    String? userEmail,
    String? organizationId,
  }) async {
    try {
      debugPrint('${_baseUrl}addClient $Email');

      // Prepare request body
      final requestBody = {
        "clientFirstName": FirstName,
        "clientLastName": LastName,
        "clientEmail": Email,
        "clientPhone": Phone,
        "clientAddress": Address,
        "clientCity": City,
        "clientState": State,
        "clientZip": Zip,
        "businessName": businessName
      };

      // Add optional parameters if provided
      if (userEmail != null) {
        requestBody["userEmail"] = userEmail;
      }
      if (organizationId != null) {
        requestBody["organizationId"] = organizationId;
      }

      final response = await http.post(
        Uri.parse('${_baseUrl}addClient'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: jsonEncode(requestBody),
      );
      debugPrint("Hello: $response $Zip");
      switch (response.statusCode) {
        case 200:
          data = Map<String, dynamic>.from(json.decode(response.body));
          debugPrint("200 " + data['message']!);
          break;
        case 400:
          data = Map<String, dynamic>.from(json.decode(response.body));
          break;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return data;
  }

  Future<dynamic> addBusiness(
      String businessName,
      String businessEmail,
      String businessPhone,
      String businessAddress,
      String businessCity,
      String businessState,
      String businessZip,
      {String? organizationId,
      String? userEmail}) async {
    try {
      debugPrint('${_baseUrl}addBusiness/ $businessName');

      // Prepare request body
      final requestBody = {
        "businessName": businessName,
        "businessEmail": businessEmail,
        "businessPhone": businessPhone,
        "businessAddress": businessAddress,
        "businessCity": businessCity,
        "businessState": businessState,
        "businessZip": businessZip,
      };

      // Add organization parameters if provided
      if (organizationId != null) {
        requestBody["organizationId"] = organizationId;
      }
      if (userEmail != null) {
        requestBody["userEmail"] = userEmail;
      }

      final response = await http.post(
        Uri.parse('${_baseUrl}addBusiness'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: jsonEncode(requestBody),
      );
      debugPrint("Hello: $response $businessZip");
      switch (response.statusCode) {
        case 200:
          data = Map<String, dynamic>.from(json.decode(response.body));
          debugPrint("200 " + data['message']!);
          break;
        case 400:
          data = Map<String, dynamic>.from(json.decode(response.body));
          break;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return data;
  }

  /// Get businesses for organization
  Future<List<dynamic>> getBusinesses(String organizationId) async {
    try {
      final response = await http.get(
        Uri.parse('${_baseUrl}businesses/$organizationId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        if (body['statusCode'] == 200 && body['businesses'] != null) {
          return body['businesses'];
        }
      }
      return [];
    } catch (e) {
      debugPrint('Error getting businesses: $e');
      return [];
    }
  }

  // Organization Management Methods
  Future<Map<String, dynamic>> createOrganization(
    String organizationName,
    String ownerEmail,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('${_baseUrl}organization/create'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: jsonEncode({
          "organizationName": organizationName,
          "ownerEmail": ownerEmail,
        }),
      );

      switch (response.statusCode) {
        case 200:
          final responseData = json.decode(response.body);
          debugPrint("Organization created successfully: ${response.body}");
          return responseData;
        case 400:
          final errorData = json.decode(response.body);
          debugPrint("Organization creation failed: ${response.body}");
          return {
            "error": errorData['message'] ?? "Organization creation failed"
          };
        default:
          debugPrint("Unexpected error: ${response.statusCode}");
          return {"error": "Unexpected error occurred"};
      }
    } catch (e) {
      debugPrint("Error creating organization: $e");
      return {"error": "Network error occurred"};
    }
  }

  Future<Map<String, dynamic>> verifyOrganizationCode(
    String organizationCode,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('${_baseUrl}organization/verify/$organizationCode'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
      );

      switch (response.statusCode) {
        case 200:
          final responseData = json.decode(response.body);
          debugPrint("Organization code verified: ${response.body}");
          return responseData;
        case 404:
          debugPrint("Invalid organization code");
          return {"error": "Invalid organization code"};
        default:
          debugPrint("Verification failed: ${response.statusCode}");
          return {"error": "Verification failed"};
      }
    } catch (e) {
      debugPrint("Error verifying organization code: $e");
      return {"error": "Network error occurred"};
    }
  }

  Future<Map<String, dynamic>> getOrganization(String organizationId) async {
    try {
      final response = await http.get(
        Uri.parse('${_baseUrl}organization/$organizationId'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
      );

      switch (response.statusCode) {
        case 200:
          final responseData = json.decode(response.body);
          return responseData;
        case 404:
          return {"error": "Organization not found"};
        default:
          return {"error": "Failed to fetch organization"};
      }
    } catch (e) {
      debugPrint("Error fetching organization: $e");
      return {"error": "Network error occurred"};
    }
  }

  Future<Map<String, dynamic>> getOrganizationMembers(
      String organizationId) async {
    try {
      final response = await http.get(
        Uri.parse('${_baseUrl}organization/$organizationId/members'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
      );

      switch (response.statusCode) {
        case 200:
          final responseData = json.decode(response.body);
          return responseData;
        case 404:
          return {"error": "Organization not found"};
        default:
          return {"error": "Failed to fetch members"};
      }
    } catch (e) {
      debugPrint("Error fetching organization members: $e");
      return {"error": "Network error occurred"};
    }
  }

  Future<Map<String, dynamic>> getOrganizationBusinesses(
      String organizationId) async {
    try {
      final response = await http.get(
        Uri.parse('${_baseUrl}organization/$organizationId/businesses'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
      );

      switch (response.statusCode) {
        case 200:
          final responseData = json.decode(response.body);
          return responseData;
        case 404:
          return {"error": "Organization not found"};
        default:
          return {"error": "Failed to fetch businesses"};
      }
    } catch (e) {
      debugPrint("Error fetching organization businesses: $e");
      return {"error": "Network error occurred"};
    }
  }

  Future<Map<String, dynamic>> addClientWithOrganization(String clientName,
      String clientEmail, String clientPhone, String clientAddress,
      {String? organizationId}) async {
    try {
      final requestBody = {
        "clientName": clientName,
        "clientEmail": clientEmail,
        "clientPhone": clientPhone,
        "clientAddress": clientAddress,
      };

      if (organizationId != null) {
        requestBody["organizationId"] = organizationId;
      }

      final response = await http.post(
        Uri.parse('${_baseUrl}addClient/'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: jsonEncode(requestBody),
      );

      switch (response.statusCode) {
        case 200:
          final responseData = json.decode(response.body);
          debugPrint("Client added successfully: ${response.body}");
          return responseData;
        case 400:
          final errorData = json.decode(response.body);
          debugPrint("Client addition failed: ${response.body}");
          return {"error": errorData['message'] ?? "Client addition failed"};
        default:
          debugPrint("Unexpected error: ${response.statusCode}");
          return {"error": "Unexpected error occurred"};
      }
    } catch (e) {
      debugPrint("Error adding client: $e");
      return {"error": "Network error occurred"};
    }
  }

  Future<dynamic> assignClientToUser(
      String userEmail,
      String clientEmail,
      List dateList,
      List startTimeList,
      List endTimeList,
      List breakList,
      Map<String, dynamic>? ndisItem,
      List<bool> highIntensityList) async {
    debugPrint('${_baseUrl}assignClientToUser');
    //post method with body
    try {
      // Extract custom pricing from ndisItem if present
      Map<String, dynamic>? customPricing;
      Map<String, dynamic>? cleanNdisItem = ndisItem;

      if (ndisItem != null && ndisItem.containsKey('customPricing')) {
        customPricing = ndisItem['customPricing'] as Map<String, dynamic>?;
        // Create a clean copy of ndisItem without customPricing
        cleanNdisItem = Map<String, dynamic>.from(ndisItem);
        cleanNdisItem.remove('customPricing');
      }

      // Prepare request body
      final requestBody = {
        "userEmail": userEmail,
        "clientEmail": clientEmail,
        "dateList": dateList,
        "startTimeList": startTimeList,
        "endTimeList": endTimeList,
        "breakList": breakList,
        "ndisItem": cleanNdisItem,
        "highIntensityList": highIntensityList,
      };

      // Add customPricing as a separate field if it exists
      if (customPricing != null) {
        requestBody["customPricing"] = customPricing;
      }

      final response = await http.post(
        Uri.parse('${_baseUrl}assignClientToUser'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: jsonEncode(requestBody),
      );
      switch (response.statusCode) {
        case 200:
          data = Map<String, dynamic>.from(json.decode(response.body));
          debugPrint("200" + data['message']);
          return data; // Explicitly return data on success

        case 400:
          data = Map<String, dynamic>.from(json.decode(response.body));
          debugPrint("400" + data['message']);
          return data; // Explicitly return data on 400

        default:
          data = {'message': 'Unknown error occurred', 'success': false};
          return data; // Explicitly return data for other status codes
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return data;
  }

  Future<dynamic> assignClientToUserWithScheduleItems(
      String userEmail,
      String clientEmail,
      List dateList,
      List startTimeList,
      List endTimeList,
      List breakList,
      Map<String, dynamic>? ndisItem,
      List<bool> highIntensityList,
      List<Map<String, dynamic>> scheduleWithNdisItems) async {
    debugPrint('${_baseUrl}assignClientToUser');
    //post method with body
    try {
      // Extract custom pricing from ndisItem if present
      Map<String, dynamic>? customPricing;
      Map<String, dynamic>? cleanNdisItem = ndisItem;

      if (ndisItem != null && ndisItem.containsKey('customPricing')) {
        customPricing = ndisItem['customPricing'] as Map<String, dynamic>?;
        // Create a clean copy of ndisItem without customPricing
        cleanNdisItem = Map<String, dynamic>.from(ndisItem);
        cleanNdisItem.remove('customPricing');
      }

      // Prepare request body
      final requestBody = {
        "userEmail": userEmail,
        "clientEmail": clientEmail,
        "dateList": dateList,
        "startTimeList": startTimeList,
        "endTimeList": endTimeList,
        "breakList": breakList,
        "ndisItem": cleanNdisItem,
        "highIntensityList": highIntensityList,
        "scheduleWithNdisItems": scheduleWithNdisItems, // New parameter
      };

      // Add customPricing as a separate field if it exists
      if (customPricing != null) {
        requestBody["customPricing"] = customPricing;
      }

      final response = await http.post(
        Uri.parse('${_baseUrl}assignClientToUser'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: jsonEncode(requestBody),
      );
      switch (response.statusCode) {
        case 200:
          data = Map<String, dynamic>.from(json.decode(response.body));
          debugPrint("200" + data['message']);
          return data; // Explicitly return data on success

        case 400:
          data = Map<String, dynamic>.from(json.decode(response.body));
          debugPrint("400" + data['message']);
          return data; // Explicitly return data on 400

        default:
          data = {'message': 'Unknown error occurred', 'success': false};
          return data; // Explicitly return data for other status codes
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return data;
  }

  Future<Map<String, dynamic>> getInvoiceData({
    bool includeExpenses = false,
    String? userEmail,
    String? clientEmail,
    String? startDate,
    String? endDate,
  }) async {
    try {
      // Get current user email if not provided
      if (userEmail == null) {
        final user = FirebaseAuth.instance.currentUser;
        userEmail = user?.email;
      }

      // Do not force defaults here. If both dates are omitted, the server
      // should return the full history for the employee-client.
      // Only include dates when explicitly provided.

      final requestBody = <String, dynamic>{
        "includeExpenses": includeExpenses,
      };

      // Add required parameters if available
      if (userEmail != null) requestBody["userEmail"] = userEmail;
      if (clientEmail != null) requestBody["clientEmail"] = clientEmail;
      if (startDate != null) requestBody["startDate"] = startDate;
      if (endDate != null) requestBody["endDate"] = endDate;

      final response = await http.post(
        Uri.parse('${_baseUrl}api/invoice/generate-line-items'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(requestBody),
      );
      switch (response.statusCode) {
        case 200:
          final Map<String, dynamic> responseData = json.decode(response.body);
          final Map<String, dynamic> data = responseData['data'] ?? {};
          final List<dynamic> lineItemsJson = data['lineItems'] ?? [];
          final List<dynamic> expensesJson = data['expenses'] ?? [];

          final List<Map<String, dynamic>> lineItems = lineItemsJson
              .map((json) => Map<String, dynamic>.from(json))
              .toList();
          final List<Map<String, dynamic>> expenses = expensesJson
              .map((json) => Map<String, dynamic>.from(json))
              .toList();

          return {
            'lineItems': lineItems,
            'expenses': expenses,
            'summary': data['summary'] ?? {},
            'validation': data['validation'] ?? {},
          };
        case 400:
          throw Exception('Failed to get invoice data: bad request');
        default:
          throw Exception('Failed to get invoice data: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('Failed to get invoice data: network error');
    } catch (e) {
      throw Exception('Failed to get invoice data: $e');
    }
  }

  // Keep backward compatibility
  Future<List<Map<String, dynamic>>> getLineItems(
      {bool includeExpenses = false}) async {
    final invoiceData = await getInvoiceData(includeExpenses: includeExpenses);
    return List<Map<String, dynamic>>.from(invoiceData['lineItems'] ?? []);
  }

  /// Fetches business statistics for the admin dashboard
  Future<Map<String, dynamic>> getInvoiceStats(String organizationId) async {
    try {
      final response = await getRawUrl(
        'api/invoices/stats/$organizationId',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      switch (response.statusCode) {
        case 200:
          final Map<String, dynamic> responseData = json.decode(response.body);
          return responseData;
        case 400:
          throw Exception('Failed to get invoice stats: bad request');
        case 404:
          throw Exception(
              'Failed to get invoice stats: organization not found');
        default:
          throw Exception(
              'Failed to get invoice stats: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('Failed to get invoice stats: network error');
    } catch (e) {
      throw Exception('Failed to get invoice stats: $e');
    }
  }

  /// Fetch active admin invoice profile for an organization
  Future<Map<String, dynamic>> getAdminInvoiceProfile(
      String organizationId) async {
    try {
      final response = await http.get(
        Uri.parse('${_baseUrl}api/admin-invoice-profile/$organizationId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      final body = response.body.isNotEmpty ? json.decode(response.body) : {};
      return body is Map<String, dynamic>
          ? body
          : {'success': false, 'message': 'Invalid response'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Create or update admin invoice profile
  Future<Map<String, dynamic>> upsertAdminInvoiceProfile(
      Map<String, dynamic> payload) async {
    try {
      final uri = Uri.parse(
          '${_baseUrl}api/admin-invoice-profile${payload['profileId'] != null ? '/${payload['profileId']}' : ''}');
      final response = payload['profileId'] != null
          ? await http.put(uri,
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
              },
              body: json.encode(payload))
          : await http.post(uri,
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
              },
              body: json.encode(payload));
      final body = response.body.isNotEmpty ? json.decode(response.body) : {};
      return body is Map<String, dynamic>
          ? body
          : {'success': false, 'message': 'Invalid response'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Get organization details
  Future<Map<String, dynamic>> getOrganizationDetails(
      String organizationId) async {
    try {
      final response = await http.get(
        Uri.parse('${_baseUrl}organization/$organizationId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      );
      final body = response.body.isNotEmpty ? json.decode(response.body) : {};
      return body is Map<String, dynamic>
          ? body
          : {'success': false, 'message': 'Invalid response'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Update organization business details
  Future<Map<String, dynamic>> updateOrganizationDetails(
      String organizationId, Map<String, dynamic> updates) async {
    try {
      final response = await http.put(
        Uri.parse('${_baseUrl}organization/$organizationId/details'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: json.encode(updates),
      );
      final body = response.body.isNotEmpty ? json.decode(response.body) : {};
      return body is Map<String, dynamic>
          ? body
          : {'success': false, 'message': 'Invalid response'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<List<String>> checkHolidaysSingle(List<String> workedDateList) async {
    try {
      final response = await http.post(
        Uri.parse('${_baseUrl}check-holidays'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "dateList": workedDateList.join(','),
        }),
      );
      if (response.statusCode == 200) {
        final List<dynamic> holidayStatusListJson = json.decode(response.body);
        final List<String> holidayStatusList =
            holidayStatusListJson.cast<String>();
        return holidayStatusList;
      } else {
        throw Exception('Failed to get holidays: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('Failed to get holidays: network error');
    } catch (e) {
      throw Exception('Failed to get holidays: $e');
    }
  }

  Future<List<String>> checkHolidaysMultiple(
      List<List<String>> workedDateList) async {
    // Flatten the List<List<String>> to List<String>
    List<String> flattenedWorkedDateList =
        workedDateList.expand((i) => i).toList();
    return checkHolidaysSingle(flattenedWorkedDateList);
  }

  Future<dynamic> uploadPhoto(
      BuildContext context, String userEmail, File imageFile) async {
    final url = '${_baseUrl}uploadPhoto/';
    final Uint8List photoData = await imageFile.readAsBytes();
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['email'] = userEmail;
    debugPrint(
        "Email sending: ${request.fields['email']}\n photdata is $photoData");
    final imageStream = http.ByteStream(Stream.castFrom(imageFile.openRead()));
    final imageSize = await imageFile.length();

    final multipartFile = http.MultipartFile('photo', imageStream, imageSize,
        filename: imageFile.path.split('/').last);
    request.files.add(multipartFile);

    final response = await request.send();
    if (response.statusCode == 200) {
      try {
        var jsonResponse = json.decode(await response.stream.bytesToString());
        // After successful upload, update the Riverpod PhotoData provider
        // Note: This will be handled by the calling widget using ref.read(photoDataProvider.notifier)

        debugPrint("Response: $jsonResponse");
        return jsonResponse;
      } catch (e) {
        debugPrint("Error: $e");
        throw Exception('Failed to parse response: $e');
      }
    } else if (response.statusCode == 400) {
      throw Exception('Bad request, please check your input data');
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized, please check your API key');
    } else if (response.statusCode == 404) {
      throw Exception('Endpoint not found');
    } else {
      throw Exception('Unexpected error occurred!');
    }
  }

  Future<Uint8List?> getUserPhoto(String userEmail) async {
    final url = '${_baseUrl}getUserPhoto/$userEmail';
    // debugPrint("\n inside get user photo: $url\n");
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      try {
        // Parse the JSON response
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        // Check for R2 photoUrl first
        if (jsonResponse['photoUrl'] != null &&
            jsonResponse['photoUrl'].toString().isNotEmpty) {
          final String photoUrl = jsonResponse['photoUrl'];

          // Download the image from R2
          try {
            final imageResponse = await http.get(Uri.parse(photoUrl));
            if (imageResponse.statusCode == 200) {
              return imageResponse.bodyBytes;
            } else {
              debugPrint(
                  "Failed to download image from R2: ${imageResponse.statusCode}");
            }
          } catch (e) {
            debugPrint("Error downloading image from R2: $e");
          }
        }

        if (jsonResponse['success'] == true && jsonResponse['data'] != null) {
          final String base64PhotoData = jsonResponse['data'];
          final photoData = base64Decode(base64PhotoData);
          return photoData;
        } else {
          return null;
        }
      } catch (e) {
        debugPrint("Error parsing JSON response: $e");
        throw Exception('Failed to parse photo response: $e');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Photo not found');
    } else {
      throw Exception('Unexpected error occurred!');
    }
  }

  Future<Uint8List?> getUserPhotoFromFBS() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        debugPrint("User not authenticated.");
        return null;
      } else {
        debugPrint("User authenticated.");
        Reference storageRef = FirebaseStorage.instance
            .ref()
            .child('profile_pics/${user.uid}.jpg');

        // Get the download URL of the stored file
        String downloadURL = await storageRef.getDownloadURL();

        // Use a network call or any method to fetch the image data
        // Here, I'm using http package to fetch the image data
        http.Response response = await http.get(Uri.parse(downloadURL));

        // Check if the request was successful
        if (response.statusCode == 200) {
          // Decode the response body to Uint8List
          Uint8List imageData = response.bodyBytes;

          // Note: PhotoData update will be handled by the calling widget using Riverpod

          return imageData;
        } else {
          debugPrint("Failed to fetch image: ${response.statusCode}");
          return null;
        }
      }
    } catch (error) {
      debugPrint('Error fetching profile picture: $error');
      return null;
    }
  }

  Future<UploadNotes> uploadNotes(
      String userEmail, String clientEmail, String notes) async {
    try {
      debugPrint("Email with notes: $userEmail + $notes");
      final response = await http.post(
        Uri.parse('${_baseUrl}addNotes'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "userEmail": userEmail,
          "clientEmail": clientEmail,
          "notes": notes,
        }),
      );
      debugPrint('${_baseUrl}addNotes');
      if (response.statusCode == 201) {
        return UploadNotes(
          success: true,
          title: "Success",
          message: "Notes uploaded successfully",
          surfaceColor: Colors.green,
        );
      } else {
        final responseBody = json.decode(response.body);
        return UploadNotes(
          success: false,
          title: "Error",
          message: responseBody['message'] ?? "Notes upload failed",
          surfaceColor: Colors.red,
        );
      }
    } on SocketException {
      throw Exception('Failed to upload notes: network error');
    } catch (e) {
      throw Exception('Failed to upload notes: $e');
    }
  }

  Future<Map<String, dynamic>> addShiftNote({
    required String userEmail,
    required String clientEmail,
    required String shiftDate,
    required String shiftStartTime,
    required String note,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${_baseUrl}addShiftNote'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "userEmail": userEmail,
          "clientEmail": clientEmail,
          "shiftDate": shiftDate,
          "shiftStartTime": shiftStartTime,
          "note": note,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {'success': true, 'message': data['message']};
      } else {
        final error = json.decode(response.body);
        return {'success': false, 'message': error['message']};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error adding shift note: $e'};
    }
  }

  Future<Map<String, dynamic>> updateClientExtendedDetails({
    required String clientEmail,
    String? careNotes,
    Map<String, dynamic>? preferences,
  }) async {
    try {
      final Map<String, dynamic> body = {'clientEmail': clientEmail};
      if (careNotes != null) body['careNotes'] = careNotes;
      if (preferences != null) body['preferences'] = preferences;

      final response = await http.put(
        Uri.parse('${_baseUrl}updateClientExtendedDetails'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {'success': true, 'message': data['message']};
      } else {
        final error = json.decode(response.body);
        return {'success': false, 'message': error['message']};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error updating client details: $e'};
    }
  }

  Future<Map<String, String>> addUpdateInvoicingEmailDetail(
    String userEmail,
    String invoicingBusinessName,
    String invoicingEmail,
    String invoicingEmailAppPassword,
  ) async {
    // try {
    await EncryptDecrypt.generateEncryptionKey();
    final generatedKey = await EncryptDecrypt.getSecureEncryptionKey();
    debugPrint(
        "Generated key when calling addUpdateInvoicingEmailDetail is: $generatedKey");
    final encryptedPassword = EncryptDecrypt.encryptPassword(
        invoicingEmailAppPassword, generatedKey!);
    debugPrint("Encrypted password: $encryptedPassword");
    debugPrint("Hashed password with salt: $generatedKey");
    debugPrint('${_baseUrl}addUpdateInvoicingEmailDetail');
    final response = await http.post(
      Uri.parse('${_baseUrl}addUpdateInvoicingEmailDetail'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'userEmail': userEmail,
        'invoicingBusinessName': invoicingBusinessName,
        'email': invoicingEmail,
        'encryptedPassword': encryptedPassword
      },
    );

    debugPrint("gen code: $generatedKey");
    await http.post(
      Uri.parse('${_baseUrl}invoicingEmailDetailKey'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'userEmail': userEmail,
        'invoicingBusinessKey': generatedKey,
      },
    );

    debugPrint("Resp: ${response.statusCode}");

    Map<String, dynamic> data = {};

    switch (response.statusCode) {
      case 200:
        data = Map<String, dynamic>.from(json.decode(response.body));
        if (kDebugMode) {
          debugPrint("200" + data['message']);
        }

        return {
          'message': 'Invoicing email details added successfully',
        };

      case 400:
        data = Map<String, dynamic>.from(json.decode(response.body));
        if (kDebugMode) {
          debugPrint("400" + data['message']);
        }

        return {
          'message': 'Invoicing Email Details failed',
        };

      default:
        return {
          'message': 'Unknown error occurred',
        };
    }
    // } catch (e) {
    //   // Handle any exception that occurs during the adding email details process
    //   debugPrint("Exception api method: $e");
    //   return {
    //     'message': 'An error occurred during adding invoicing email details',
    //   };
    // }
  }

  Future<Map<String, dynamic>> getInvoicingEmailDetails(
      String email, String genKey) async {
    // try {
    final response = await http.get(
      Uri.parse('${_baseUrl}getInvoicingEmailDetails?email=$email'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    );

    debugPrint("Respsss: ${response.body}");

    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> data =
            Map<String, dynamic>.from(json.decode(response.body));
        if (kDebugMode) {
          debugPrint("200" + data['message']);
        }
        debugPrint("Checking message: ${data['message']}");
        // Check if details exist in the response and return them
        if (data['message'] == 'Invoicing email details found') {
          final generatedKey = await EncryptDecrypt.getSecureEncryptionKey();
          debugPrint("Generated key is: $generatedKey");
          if (generatedKey == null) {
            EncryptDecrypt.setSecureEncryptionKey(genKey);
          }
          debugPrint("Before $generatedKey $genKey");
          // Decrypt the password before returning the data
          final keyToUse = generatedKey ?? genKey;
          final decryptedPassword = EncryptDecrypt.decryptPassword(
              data['data']['encryptedPassword'] ?? '', keyToUse);
          debugPrint("After $decryptedPassword");
          // Update the data map with the decrypted password
          data['data']['password'] = decryptedPassword.isNotEmpty
              ? decryptedPassword
              : 'Password decryption failed';
          debugPrint("DS: ${data.toString()}");
          return data;
        } else {
          return {
            'message': 'No invoicing email details found',
          };
        }

      case 400:
        Map<String, dynamic> errorData =
            Map<String, dynamic>.from(json.decode(response.body));
        if (kDebugMode) {
          debugPrint("400" + errorData['message']);
        }

        return {
          'message': 'Error retrieving invoicing email details',
        };

      default:
        return {
          'message': 'Unknown error occurred',
        };
    }
    // } catch (e) {
    //   // Handle any exception that occurs during the retrieval process
    //   debugPrint("Exception in getInvoicingEmailDetails: $e");
    //   return {
    //     'message':
    //         'An error occurred during retrieving invoicing email details',
    //   };
    // }
  }

  Future<Map<String, dynamic>> checkInvoicingEmailKey(String email) async {
    // try {
    final response = await http.get(
      Uri.parse('${_baseUrl}checkInvoicingEmailKey?email=$email'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    );

    debugPrint("checkInvoicingEmailKey: ${response.body}");

    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> data =
            Map<String, dynamic>.from(json.decode(response.body));
        if (kDebugMode) {
          debugPrint("200" + data['message']);
        }
        debugPrint("checkInvoicingEmailKey message: ${data['message']}");
        // Check if details exist in the response and return them
        if (data['message'] == 'Invoicing email key found') {
          debugPrint("Data key ${data['key']}");
          if (data['key'] == null) {
            return {
              'message': 'Encryption key empty',
            };
          }
          return data;
        } else {
          return {
            'message': 'No invoicing email key found',
          };
        }

      case 400:
        Map<String, dynamic> errorData =
            Map<String, dynamic>.from(json.decode(response.body));
        if (kDebugMode) {
          debugPrint("400" + errorData['message']);
        }

        return {
          'message': 'Error retrieving invoicing email key details',
        };

      default:
        return {
          'message': 'Unknown error occurred',
        };
    }
    // } catch (e) {
    //   // Handle any exception that occurs during the retrieval process
    //   debugPrint("Exception in getInvoicingEmailDetails: $e");
    //   return {
    //     'message':
    //         'An error occurred during retrieving invoicing email details',
    //   };
    // }
  }

  Future<Map<String, dynamic>> getEmailDetailToSendEmail(
      String userEmail) async {
    try {
      debugPrint(
          "getEmailDetailToSendEmail: $userEmail Uri.parse('${_baseUrl}getEmailDetailToSendEmail')");
      final response = await http.post(
        Uri.parse('${_baseUrl}getEmailDetailToSendEmail'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'userEmail': userEmail}),
      );
      debugPrint("getEmailDetails: ${response.body}");
      if (response.statusCode == 200) {
        final emailDetails = json.decode(response.body);
        if (emailDetails['message'] == 'No user found') {
          return {'Error': 'No user found'};
        } else if (emailDetails['message'] == 'No user found') {
          return {'Error': 'Internal server error'};
        } else {
          return {
            'accessToken': emailDetails['accessToken'],
            'emailAddress': emailDetails['emailAddress'],
            'recipientEmail': emailDetails['recipientEmail'],
          };
        }
      } else if (response.statusCode == 500) {
        debugPrint("Internal server error");
        return {'Error': 'Internal server error'};
      } else {
        debugPrint("Failed to load email details");
        throw Exception('Failed to load email details');
      }
    } catch (e) {
      debugPrint('Failed to get email details: $e');
      return {'Error': 'Failed to get email details'};
    }
  }

  // Request Methods
  Future<Map<String, dynamic>> getRequests() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/requests'),
        headers: {'Content-Type': 'application/json'},
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> createRequest(
      Map<String, dynamic> requestData) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/requests'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestData),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> updateRequest(
      Map<String, dynamic> requestData) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/requests/${requestData['id']}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestData),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // Future<Map<String, dynamic>> sendNotification(
  //     {String? recipientEmail, String? organizationId, String? title, String? body}) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('${_baseUrl}sendNotification'),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({
  //         'recipientEmail': recipientEmail,
  //         'organizationId': organizationId,
  //         'title': title,
  //         'body': body,
  //       }),
  //     );
  //     return jsonDecode(response.body);
  //   } catch (e) {
  //     return {'success': false, 'message': e.toString()};
  //   }
  // }

  Future<Map<String, dynamic>> getTimerStatus(String userEmail) async {
    try {
      // Delegate to unified GET helper which normalizes base URL and endpoint to prevent double slashes
      return await get('getTimerStatus/$userEmail');
    } catch (e) {
      return {
        'success': false,
        'message': 'Error getting timer status: $e',
      };
    }
  }

  Future<Map<String, dynamic>> sendNotification({
    String? recipientEmail,
    String? organizationId,
    required String title,
    required String body,
    String? channelId, // Add channelId parameter
  }) async {
    try {
      final Map<String, dynamic> requestBody = {
        'title': title,
        'body': body,
      };
      if (recipientEmail != null) {
        requestBody['recipientEmail'] = recipientEmail;
      }
      if (organizationId != null) {
        requestBody['organizationId'] = organizationId;
      }
      if (channelId != null) {
        requestBody['channelId'] = channelId; // Add channelId to request body
      }

      final response = await http.post(
        Uri.parse('${_baseUrl}sendNotification'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Notification sent successfully.'};
      } else {
        final errorBody = jsonDecode(response.body);
        return {
          'success': false,
          'message': errorBody['message'] ?? 'Failed to send notification.'
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error sending notification: $e'};
    }
  }

  // Assignment Methods
  Future<Map<String, dynamic>> getUserAssignments(String userEmail) async {
    if (userEmail.isEmpty) {
      debugPrint('getUserAssignments called with empty email');
      return {
        'success': false,
        'message': 'Invalid email: Email cannot be empty',
        'assignments': [],
        'error_code': 'INVALID_EMAIL'
      };
    }

    try {
      debugPrint('Fetching assignments for user: $userEmail');
      final response = await http.get(
        Uri.parse(
            '${_baseUrl}getUserAssignments/${Uri.encodeComponent(userEmail)}'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedResponse;
        try {
          decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;

          // Validate response structure
          if (!decodedResponse.containsKey('assignments')) {
            debugPrint('Invalid response structure: missing assignments key');
            return {
              'success': false,
              'message': 'Invalid server response: missing assignments data',
              'assignments': [],
              'error_code': 'INVALID_RESPONSE_STRUCTURE',
              'raw_response': response.body.length > 100
                  ? '${response.body.substring(0, 100)}...'
                  : response.body
            };
          }

          // Ensure assignments is a list
          if (decodedResponse['assignments'] is! List) {
            debugPrint('Invalid assignments type: not a list');
            decodedResponse['assignments'] = [];
            decodedResponse['success'] = false;
            decodedResponse['message'] = 'Invalid assignments data type';
          }

          // Add success flag if not present
          if (!decodedResponse.containsKey('success')) {
            decodedResponse['success'] = true;
          }
          debugPrint(
              'Returning decoded response: ${(decodedResponse['assignments']).toString()} ');
          return decodedResponse;
        } catch (e) {
          debugPrint('Error decoding response: $e');
          return {
            'success': false,
            'message': 'Error parsing server response: $e',
            'assignments': [],
            'error_code': 'PARSE_ERROR',
            'raw_response': response.body.length > 100
                ? '${response.body.substring(0, 100)}...'
                : response.body
          };
        }
      } else {
        debugPrint(
            'Failed to load assignments: ${response.statusCode} - ${response.body}');
        return {
          'success': false,
          'message':
              'Failed to load user assignments: Server returned ${response.statusCode}',
          'assignments': [],
          'error_code': 'HTTP_ERROR_${response.statusCode}',
          'status_code': response.statusCode
        };
      }
    } catch (e) {
      debugPrint('Exception in getUserAssignments: $e');
      return {
        'success': false,
        'message': 'Error loading user assignments: $e',
        'assignments': [],
        'error_code': 'NETWORK_ERROR'
      };
    }
  }

  /// Fix organizationId for existing client and assignment records
  Future<Map<String, dynamic>> fixClientOrganizationId(
      String userEmail, String organizationId) async {
    try {
      final requestData = {
        'userEmail': userEmail,
        'organizationId': organizationId,
      };

      final response = await http.post(
        Uri.parse('${_baseUrl}fixClientOrganizationId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestData),
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'error': 'Error fixing organization ID: $e'};
    }
  }

  /// Get comprehensive employee tracking data for an organization
  /// Returns data about currently working employees, worked time records, and assignments
  Future<Map<String, dynamic>> getEmployeeTrackingData(
      String organizationId) async {
    try {
      final response = await http.get(
        Uri.parse('${_baseUrl}getEmployeeTrackingData/$organizationId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Failed to load employee tracking data: ${response.statusCode}');
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error fetching employee tracking data: $e',
        'data': null
      };
    }
  }

  // ... inside your ApiMethod class

  /// Search NDIS support items by text query and ensure correct typing.
  Future<List<Map<String, dynamic>>> searchSupportItems(String query) async {
    try {
      // URL-encode the query to handle spaces and special characters
      final encodedQuery = Uri.encodeComponent(query);
      final uri =
          Uri.parse('${_baseUrl}api/support-items/search?q=$encodedQuery');

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['items'] != null) {
          final List<dynamic> rawItems = data['items'];
          // This is the key part: ensure the list is correctly typed
          final List<Map<String, dynamic>> correctlyTypedItems =
              rawItems.map((item) {
            return Map<String, dynamic>.from(item);
          }).toList();
          return correctlyTypedItems;
        } else {
          return [];
        }
      } else {
        throw Exception('Failed to search support items');
      }
    } catch (e) {
      debugPrint('Error in searchSupportItems: $e');
      throw Exception('Failed to search support items: $e');
    }
  }

  // Your getAllSupportItems method should also have the safe casting
  Future<List<Map<String, dynamic>>> getAllSupportItems() async {
    // ... (This method should also have the same safe casting logic as searchSupportItems)
    try {
      final response =
          await http.get(Uri.parse('${_baseUrl}api/support-items/all'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['items'] != null) {
          final List<dynamic> rawItems = data['items'];
          return rawItems
              .map((item) => Map<String, dynamic>.from(item))
              .toList();
        }
      }
      return [];
    } catch (e) {
      debugPrint('Error in getAllSupportItems: $e');
      return [];
    }
  }

  /// Validates invoice line items pricing against NDIS caps and custom pricing rules.
  ///
  /// This method sends line items to the backend for price validation and returns
  /// detailed validation results including compliance status for each item.
  ///
  /// Parameters:
  /// - lineItems: List of invoice line items to validate
  /// - state: The state code for pricing rules (default: 'NSW')
  /// - providerType: The provider type for pricing rules (default: 'standard')
  ///
  /// Returns a Map with validation results including:
  /// - success: Whether the API call was successful
  /// - validationResults: Detailed validation information
  ///   - isValid: Overall validation status
  ///   - compliantItems: Count of compliant items
  ///   - nonCompliantItems: Count of non-compliant items
  ///   - totalAmount: Total invoice amount
  ///   - compliantAmount: Amount that is compliant with pricing rules
  ///   - excessAmount: Amount exceeding pricing caps
  ///   - compliancePercentage: Percentage of compliant pricing
  ///   - itemResults: Detailed results for each line item
  Future<Map<String, dynamic>> validateInvoicePricing({
    required List<Map<String, dynamic>> lineItems,
    String state = 'NSW',
    String providerType = 'standard',
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${_baseUrl}api/invoice/validate-pricing-realtime'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'lineItems': lineItems,
          'state': state,
          'providerType': providerType,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        debugPrint(
            'Error validating pricing: ${response.statusCode} ${response.body}');
        return {
          'success': false,
          'message': 'Failed to validate pricing: ${response.statusCode}',
          'validationResults': null,
        };
      }
    } catch (e) {
      debugPrint('Exception validating pricing: $e');
      return {
        'success': false,
        'message': 'Error validating pricing: $e',
        'validationResults': null,
      };
    }
  }

  /// Creates a price prompt for a missing price
  Future<Map<String, dynamic>> createPricePrompt(
      Map<String, dynamic> promptData) async {
    try {
      final response = await http.post(
        Uri.parse('${_baseUrl}api/price-prompts/create'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(promptData),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        debugPrint(
            'Error creating price prompt: ${response.statusCode} ${response.body}');
        return {
          'success': false,
          'message': 'Failed to create price prompt: ${response.statusCode}',
        };
      }
    } catch (e) {
      debugPrint('Exception creating price prompt: $e');
      return {
        'success': false,
        'message': 'Error creating price prompt: $e',
      };
    }
  }

  /// Resolves a price prompt with user-provided price
  Future<Map<String, dynamic>> resolvePricePrompt(
      String promptId, Map<String, dynamic> resolution) async {
    try {
      final response = await http.post(
        Uri.parse('${_baseUrl}api/price-prompts/resolve'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'promptId': promptId,
          'resolution': resolution,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        debugPrint(
            'Error resolving price prompt: ${response.statusCode} ${response.body}');
        return {
          'success': false,
          'message': 'Failed to resolve price prompt: ${response.statusCode}',
        };
      }
    } catch (e) {
      debugPrint('Exception resolving price prompt: $e');
      return {
        'success': false,
        'message': 'Error resolving price prompt: $e',
      };
    }
  }

  /// Gets pending price prompts for a session
  Future<Map<String, dynamic>> getPendingPrompts(String sessionId) async {
    try {
      final response = await http.get(
        Uri.parse('${_baseUrl}api/price-prompts/pending/$sessionId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        debugPrint(
            'Error getting pending prompts: ${response.statusCode} ${response.body}');
        return {
          'success': false,
          'message': 'Failed to get pending prompts: ${response.statusCode}',
          'prompts': [],
        };
      }
    } catch (e) {
      debugPrint('Exception getting pending prompts: $e');
      return {
        'success': false,
        'message': 'Error getting pending prompts: $e',
        'prompts': [],
      };
    }
  }

  /// Fetch clients by organization ID
  /// Returns a list of clients for the specified organization
  Future<List<Map<String, dynamic>>> getClientsByOrganizationId(
      String organizationId) async {
    try {
      final response = await http
          .get(Uri.parse('${_baseUrl}organization/$organizationId/clients'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['clients'] ?? []);
      } else {
        throw Exception('Failed to get clients: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error getting clients by organization ID: $e');
      throw Exception('Failed to get clients: $e');
    }
  }

  /// Get support item details including description and price caps
  Future<Map<String, dynamic>?> getSupportItemDetails(
      String supportItemNumber) async {
    try {
      final response = await http.get(
        Uri.parse('${_baseUrl}api/price-validation/caps/$supportItemNumber'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['data'] != null) {
          return Map<String, dynamic>.from(data['data']);
        }
      }
      return null;
    } catch (e) {
      debugPrint('Exception getting support item details: $e');
      return null;
    }
  }

  /// Get pricing lookup for organization and client
  Future<Map<String, dynamic>?> getPricingLookup(
      String organizationId, String supportItemNumber,
      {String? clientId}) async {
    try {
      String url =
          '${_baseUrl}api/pricing/lookup/$organizationId/$supportItemNumber';
      if (clientId != null) {
        url += '?clientId=$clientId';
      }

      final sw = Stopwatch()..start();
      DebugLog.networkRequest('GET', url, payload: {
        'organizationId': organizationId,
        'supportItemNumber': supportItemNumber,
        if (clientId != null) 'clientId': clientId,
      });
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );
      sw.stop();
      dynamic body;
      try {
        body = response.body.isNotEmpty ? json.decode(response.body) : null;
      } catch (_) {
        body = {'raw': response.body};
      }
      DebugLog.networkResponse(url, response.statusCode,
          body: body, durationMs: sw.elapsedMilliseconds);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['statusCode'] == 200 && data['data'] != null) {
          return Map<String, dynamic>.from(data['data']);
        }
      }
      return null;
    } catch (e) {
      debugPrint('Exception getting pricing lookup: $e');
      DebugLog.error('Exception getting pricing lookup', details: {
        'organizationId': organizationId,
        'supportItemNumber': supportItemNumber,
        if (clientId != null) 'clientId': clientId,
        'error': e.toString(),
      });
      return null;
    }
  }

  /// Get bulk pricing lookup for multiple NDIS items
  /// Returns a map where keys are support item numbers and values are pricing data
  Future<Map<String, dynamic>?> getBulkPricingLookup(
      String organizationId, List<String> supportItemNumbers,
      {String? clientId}) async {
    try {
      if (supportItemNumbers.isEmpty) {
        return {};
      }

      final url = '${_baseUrl}api/pricing/bulk-lookup';
      final body = {
        'organizationId': organizationId,
        'supportItemNumbers': supportItemNumbers,
      };

      if (clientId != null) {
        body['clientId'] = clientId;
      }

      final sw = Stopwatch()..start();
      DebugLog.networkRequest('POST', url, payload: body);
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );
      sw.stop();
      dynamic respBody;
      try {
        respBody = response.body.isNotEmpty ? json.decode(response.body) : null;
      } catch (_) {
        respBody = {'raw': response.body};
      }
      DebugLog.networkResponse(url, response.statusCode,
          body: respBody, durationMs: sw.elapsedMilliseconds);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['statusCode'] == 200 && data['data'] != null) {
          return Map<String, dynamic>.from(data['data']);
        }
      }
      return null;
    } catch (e) {
      debugPrint('Exception getting bulk pricing lookup: $e');
      DebugLog.error('Bulk pricing lookup failed', details: {
        'organizationId': organizationId,
        'supportItemNumbers': supportItemNumbers,
        if (clientId != null) 'clientId': clientId,
        'error': e.toString(),
      });
      return null;
    }
  }

  /// Save custom pricing for an NDIS item.
  ///
  /// Parameters:
  /// - [organizationId]: The organization identifier for which pricing applies.
  /// - [supportItemNumber]: The NDIS support item number.
  /// - [price]: The custom price to save when [pricingType] is 'fixed'.
  /// - [pricingType]: Pricing type, must be 'fixed' or 'multiplier'.
  /// - [userEmail]: Email of the user performing the action.
  /// - [supportItemName]: Optional human-readable name of the support item.
  ///   If not provided, it falls back to `Item <supportItemNumber>`.
  Future<Map<String, dynamic>> saveAsCustomPricing(
      String organizationId,
      String supportItemNumber,
      double price,
      String pricingType,
      String userEmail,
      {String? supportItemName}) async {
    try {
      final resolvedName =
          (supportItemName != null && supportItemName.trim().isNotEmpty)
              ? supportItemName
              : 'Item $supportItemNumber';
      final url = '${_baseUrl}api/pricing/create';
      final payload = {
        'organizationId': organizationId,
        'clientSpecific': false,
        'supportItemNumber': supportItemNumber,
        'supportItemName': resolvedName,
        'customPrice': price,
        'pricingType': pricingType,
        'userEmail': userEmail,
      };
      final sw = Stopwatch()..start();
      DebugLog.networkRequest('POST', url, payload: payload);
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );
      sw.stop();

      final responseBody =
          response.body.isNotEmpty ? json.decode(response.body) : {};
      DebugLog.networkResponse(url, response.statusCode,
          body: responseBody, durationMs: sw.elapsedMilliseconds);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'message':
              responseBody['message'] ?? 'Custom pricing saved successfully',
          'data': responseBody['data'],
        };
      } else {
        return {
          'success': false,
          'message': responseBody['message'] ?? 'Failed to save custom pricing',
        };
      }
    } catch (e) {
      debugPrint('Exception saving custom pricing: $e');
      DebugLog.error('Exception saving custom pricing', details: {
        'organizationId': organizationId,
        'supportItemNumber': supportItemNumber,
        'price': price,
        'pricingType': pricingType,
        'userEmail': userEmail,
        if (supportItemName != null) 'supportItemName': supportItemName,
        'error': e.toString(),
      });
      return {
        'success': false,
        'message': 'Error saving custom pricing: $e',
      };
    }
  }

  /// Save client-specific custom pricing for an NDIS item.
  ///
  /// Parameters:
  /// - [organizationId]: The organization identifier for which pricing applies.
  /// - [clientId]: The client identifier to link this pricing to.
  /// - [supportItemNumber]: The NDIS support item number.
  /// - [price]: The custom price to save when [pricingType] is 'fixed'.
  /// - [pricingType]: Pricing type, must be 'fixed' or 'multiplier'.
  /// - [userEmail]: Email of the admin performing the action.
  /// - [supportItemName]: Optional item name for readability.
  Future<Map<String, dynamic>> saveClientCustomPricing(
      String organizationId,
      String clientId,
      String supportItemNumber,
      double price,
      String pricingType,
      String userEmail,
      {String? supportItemName}) async {
    try {
      final resolvedName =
          (supportItemName != null && supportItemName.trim().isNotEmpty)
              ? supportItemName
              : 'Item $supportItemNumber';
      final url = '${_baseUrl}api/pricing/create';
      final payload = {
        'organizationId': organizationId,
        'clientId': clientId,
        'clientSpecific': true,
        'supportItemNumber': supportItemNumber,
        'supportItemName': resolvedName,
        'customPrice': price,
        'pricingType': pricingType,
        'userEmail': userEmail,
      };
      final sw = Stopwatch()..start();
      DebugLog.networkRequest('POST', url, payload: payload);
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );
      sw.stop();

      final responseBody =
          response.body.isNotEmpty ? json.decode(response.body) : {};
      DebugLog.networkResponse(url, response.statusCode,
          body: responseBody, durationMs: sw.elapsedMilliseconds);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'message': responseBody['message'] ??
              'Client custom pricing saved successfully',
          'data': responseBody['data'],
        };
      } else {
        return {
          'success': false,
          'message':
              responseBody['message'] ?? 'Failed to save client custom pricing',
        };
      }
    } catch (e) {
      debugPrint('Exception saving client custom pricing: $e');
      DebugLog.error('Exception saving client custom pricing', details: {
        'organizationId': organizationId,
        'clientId': clientId,
        'supportItemNumber': supportItemNumber,
        'price': price,
        'pricingType': pricingType,
        'userEmail': userEmail,
        if (supportItemName != null) 'supportItemName': supportItemName,
        'error': e.toString(),
      });
      return {
        'success': false,
        'message': 'Error saving client custom pricing: $e',
      };
    }
  }

  /// Remove custom pricing for an NDIS item
  Future<Map<String, dynamic>> removeCustomPricing(
      String organizationId, String supportItemNumber) async {
    try {
      // Get user email from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userEmail = prefs.getString('userEmail');

      if (userEmail == null) {
        return {
          'success': false,
          'message': 'User email not found',
        };
      }

      // First, get the custom pricing record to find its ID
      final lookupResponse =
          await getPricingLookup(organizationId, supportItemNumber);

      if (lookupResponse == null || lookupResponse['customPricing'] == null) {
        return {
          'success': false,
          'message': 'No custom pricing found for this item',
        };
      }

      final customPricing = lookupResponse['customPricing'];
      final pricingId = customPricing['_id'];

      if (pricingId == null) {
        return {
          'success': false,
          'message': 'Custom pricing ID not found',
        };
      }

      // Delete the custom pricing record
      final url = '${_baseUrl}api/pricing/$pricingId';
      final sw = Stopwatch()..start();
      DebugLog.networkRequest('DELETE', url);
      final response = await http.delete(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );
      sw.stop();

      final responseBody =
          response.body.isNotEmpty ? json.decode(response.body) : {};
      DebugLog.networkResponse(url, response.statusCode,
          body: responseBody, durationMs: sw.elapsedMilliseconds);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message':
              responseBody['message'] ?? 'Custom pricing removed successfully',
        };
      } else {
        return {
          'success': false,
          'message':
              responseBody['message'] ?? 'Failed to remove custom pricing',
        };
      }
    } catch (e) {
      debugPrint('Exception removing custom pricing: $e');
      DebugLog.error('Exception removing custom pricing', details: {
        'organizationId': organizationId,
        'supportItemNumber': supportItemNumber,
        'error': e.toString(),
      });
      return {
        'success': false,
        'message': 'Error removing custom pricing: $e',
      };
    }
  }

  /// Update existing custom pricing record by ID.
  ///
  /// Parameters:
  /// - [pricingId]: The `_id` of the existing customPricing record.
  /// - [price]: New price when `pricingType` is 'fixed'.
  /// - [pricingType]: 'fixed' or 'multiplier'. Defaults to 'fixed'.
  /// - [userEmail]: Email of the user performing the update.
  /// - [supportItemName]: Optional name update.
  /// - [multiplier]: Optional multiplier value when `pricingType` is 'multiplier'.
  ///
  /// Returns a map with `success`, `message`, and optional `data`.
  Future<Map<String, dynamic>> updateCustomPricing(
      {required String pricingId,
      double? price,
      String pricingType = 'fixed',
      required String userEmail,
      String? supportItemName,
      double? multiplier,
      String? clientId,
      bool? clientSpecific}) async {
    try {
      final payload = <String, dynamic>{
        'userEmail': userEmail,
        'pricingType': pricingType,
      };

      if (supportItemName != null) payload['supportItemName'] = supportItemName;
      if (clientId != null) payload['clientId'] = clientId;
      if (clientSpecific != null) payload['clientSpecific'] = clientSpecific;
      if (pricingType == 'fixed') {
        payload['customPrice'] = price;
      } else if (pricingType == 'multiplier') {
        payload['multiplier'] = multiplier;
      }

      final url = '${_baseUrl}api/pricing/$pricingId';
      final sw = Stopwatch()..start();
      DebugLog.networkRequest('PUT', url, payload: payload);
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );
      sw.stop();

      final responseBody =
          response.body.isNotEmpty ? json.decode(response.body) : {};
      DebugLog.networkResponse(url, response.statusCode,
          body: responseBody, durationMs: sw.elapsedMilliseconds);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message':
              responseBody['message'] ?? 'Custom pricing updated successfully',
          'data': responseBody['data'],
        };
      } else {
        return {
          'success': false,
          'message':
              responseBody['message'] ?? 'Failed to update custom pricing',
        };
      }
    } catch (e) {
      debugPrint('Exception updating custom pricing: $e');
      DebugLog.error('Exception updating custom pricing', details: {
        'pricingId': pricingId,
        'price': price,
        'pricingType': pricingType,
        'userEmail': userEmail,
        if (supportItemName != null) 'supportItemName': supportItemName,
        if (multiplier != null) 'multiplier': multiplier,
        if (clientId != null) 'clientId': clientId,
        if (clientSpecific != null) 'clientSpecific': clientSpecific,
        'error': e.toString(),
      });
      return {
        'success': false,
        'message': 'Error updating custom pricing: $e',
      };
    }
  }

  /// Enhanced secure login method with device information and security context
  Future<Map<String, dynamic>> secureLogin(
      Map<String, dynamic> loginData) async {
    try {
      final String email = loginData['email'];
      final requestBody = Map<String, dynamic>.from(loginData);

      // Modern auth flow: backend expects plain password at /api/auth/login.
      final headers = await _buildJsonHeaders(
        includeAppCheck: true,
      );
      final response = await http.post(
        Uri.parse('${_baseUrl}auth/login'),
        headers: headers,
        body: json.encode(requestBody),
      );

      debugPrint("secureLogin response status: ${response.statusCode}");

      // Handle response with proper status code mapping.
      Map<String, dynamic> data = {};

      switch (response.statusCode) {
        case 200:
          data = Map<String, dynamic>.from(json.decode(response.body));
          debugPrint("secureLogin 200: ${data['message']}");

          // According to backend, success response shape is { success, message, data: { token, user: {...} }, timestamp }
          final payload = data['data'] is Map<String, dynamic>
              ? Map<String, dynamic>.from(data['data'])
              : <String, dynamic>{};
          // Support multiple possible token key names from backend responses
          final String? tokenCandidate = (payload['token'] ??
              payload['accessToken'] ??
              data['token'] ??
              data['accessToken']) as String?;
          final userMap = payload['user'] is Map<String, dynamic>
              ? Map<String, dynamic>.from(payload['user'])
              : <String, dynamic>{};

          if (tokenCandidate != null && tokenCandidate.isNotEmpty) {
            final utils = SharedPreferencesUtils();
            await utils.init();
            await utils.saveAuthToken(tokenCandidate);
            debugPrint('secureLogin: JWT token saved');
          } else {
            debugPrint(
                'secureLogin: No token present in response. Keys present in payload: ${payload.keys.toList()}');
          }

          if (userMap.isNotEmpty) {
            final role = userMap['role'] ??
                (userMap['roles'] is List &&
                        (userMap['roles'] as List).isNotEmpty
                    ? (userMap['roles'] as List).first
                    : null);
            UserRole roleEnum =
                role == 'admin' ? UserRole.admin : UserRole.normal;
            debugPrint("secureLogin role: $roleEnum $role");

            // Save user email and organization ID to SharedPreferences
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('userEmail', email);
            if (userMap['organizationId'] != null) {
              await prefs.setString(
                  'organizationId', userMap['organizationId']);
            }
            final userIdValue =
                (userMap['id'] ?? userMap['_id'] ?? userMap['userId'])
                    ?.toString();
            if (userIdValue != null && userIdValue.isNotEmpty) {
              await prefs.setString('userId', userIdValue);
            }

            return {
              'success': true,
              'message': data['message'] ?? 'Login successful',
              'role': role,
              'user': userMap,
              'token': tokenCandidate,
            };
          }

          data['success'] = true;
          return data;

        case 400:
          data = Map<String, dynamic>.from(json.decode(response.body));
          debugPrint("secureLogin 400: ${data['message']}");
          return {
            'success': false,
            'message': data['message'] ?? 'Invalid credentials',
            'errorCode': data['errorCode'],
            'statusCode': 400,
          };

        case 401:
          data = Map<String, dynamic>.from(json.decode(response.body));
          debugPrint("secureLogin 401: Unauthorized - ${data['message']}");
          return {
            'success': false,
            'message': data['message'] ?? 'Invalid credentials',
            'errorCode': data['errorCode'],
            'statusCode': 401,
          };

        case 403:
          try {
            data = Map<String, dynamic>.from(json.decode(response.body));
            debugPrint("secureLogin 403: Forbidden - ${data['message']}");
            return {
              'success': false,
              'message': data['message'] ?? 'Access denied',
              'errorCode': data['errorCode'] ?? 'FORBIDDEN',
              'statusCode': 403,
            };
          } catch (_) {
            return {
              'success': false,
              'message':
                  'Backend access forbidden (403). Check Cloud Run unauthenticated access and IAM.',
              'errorCode': 'FORBIDDEN',
              'statusCode': 403,
            };
          }

        case 423:
          data = Map<String, dynamic>.from(json.decode(response.body));
          debugPrint("secureLogin 423: Account locked - ${data['message']}");
          return {
            'success': false,
            'message': data['message'] ?? 'Account temporarily locked',
            'errorCode': data['errorCode'] ?? 'ACCOUNT_LOCKED',
            'statusCode': 423,
          };

        case 429:
          data = Map<String, dynamic>.from(json.decode(response.body));
          debugPrint(
              "secureLogin 429: Rate limit exceeded - ${data['message']}");
          return {
            'success': false,
            'message': data['message'] ?? 'Too many login attempts',
            'errorCode': data['errorCode'] ?? 'RATE_LIMIT_EXCEEDED',
            'statusCode': 429,
          };

        case 404:
          return {
            'success': false,
            'message':
                'Authentication endpoint not found: /api/auth/login on backend.',
            'errorCode': 'ENDPOINT_NOT_FOUND',
            'statusCode': 404,
          };

        case 500:
          data = Map<String, dynamic>.from(json.decode(response.body));
          debugPrint("secureLogin 500: Server error - ${data['message']}");
          return {
            'success': false,
            'message': data['message'] ?? 'Server error occurred',
            'errorCode': data['errorCode'] ?? 'SERVER_ERROR',
            'statusCode': 500,
          };

        default:
          debugPrint(
              "secureLogin unexpected status code: ${response.statusCode}");
          return {
            'success': false,
            'message': 'Unknown error occurred',
            'errorCode': 'UNKNOWN_ERROR',
            'statusCode': response.statusCode,
          };
      }
    } catch (e) {
      debugPrint('Secure login error: $e');
      return {
        'success': false,
        'message': 'An error occurred during secure login',
        'errorCode': 'NETWORK_ERROR',
      };
    }
  }

  /// Send security log to backend for monitoring
  Future<Map<String, dynamic>> sendSecurityLog(
      Map<String, dynamic> logEntry) async {
    try {
      final response = await http.post(
        Uri.parse('${_baseUrl}auth/security-log'),
        headers: await _buildJsonHeaders(includeAppCheck: true),
        body: json.encode(logEntry),
      );

      return _handleResponse(response);
    } catch (e) {
      debugPrint('Security log send error: $e');
      return {
        'success': false,
        'message': 'Failed to send security log: $e',
      };
    }
  }

  /// Save bank details for the current user within the selected organization.
  /// Parameters:
  /// - bankName: String bank name
  /// - accountName: String account holder name
  /// - bsb: String in format XXX-XXX
  /// - accountNumber: String numeric, 6-10 digits
  /// Returns a Map with keys: success, message, and optionally data.
  Future<Map<String, dynamic>> saveBankDetails({
    required String bankName,
    required String accountName,
    required String bsb,
    required String accountNumber,
  }) async {
    try {
      final sharedUtils = SharedPreferencesUtils();
      await sharedUtils.init();
      final String? userEmail = sharedUtils.getString('userEmail');
      final String? organizationId = sharedUtils.getString('organizationId');

      if (userEmail == null || userEmail.isEmpty) {
        return {
          'success': false,
          'message': 'Missing userEmail in app context',
        };
      }
      if (organizationId == null || organizationId.isEmpty) {
        return {
          'success': false,
          'message': 'Missing organizationId in app context',
        };
      }

      final body = {
        'userEmail': userEmail,
        'organizationId': organizationId,
        'bankName': bankName,
        'accountName': accountName,
        'bsb': bsb,
        'accountNumber': accountNumber,
      };

      // Use generic POST to ensure proper headers and base URL handling
      return await post('saveBankDetails', body: body);
    } catch (e) {
      debugPrint('saveBankDetails error: $e');
      return {
        'success': false,
        'message': 'Failed to save bank details: $e',
      };
    }
  }

  /// Load bank details for the current user from the backend.
  /// Reads userEmail and organizationId from SharedPreferences.
  /// Returns a Map with keys: success, data?, message.
  Future<Map<String, dynamic>> getBankDetails() async {
    try {
      final sharedUtils = SharedPreferencesUtils();
      await sharedUtils.init();
      final String? userEmail = sharedUtils.getString('userEmail');
      final String? organizationId = sharedUtils.getString('organizationId');

      if (userEmail == null || userEmail.isEmpty) {
        return {
          'success': false,
          'message': 'Missing userEmail in app context',
        };
      }
      if (organizationId == null || organizationId.isEmpty) {
        return {
          'success': false,
          'message': 'Missing organizationId in app context',
        };
      }

      final endpoint =
          'getBankDetails?userEmail=$userEmail&organizationId=$organizationId';
      return await get(endpoint);
    } catch (e) {
      debugPrint('getBankDetails error: $e');
      return {
        'success': false,
        'message': 'Failed to load bank details: $e',
      };
    }
  }

  /// Load bank details for an arbitrary user within the current organization.
  ///
  /// Parameters:
  /// - targetUserEmail: Email of the user whose bank details should be fetched
  /// - organizationId: Organization identifier
  ///
  /// Returns:
  /// - Map with keys: `success`, `data?`, `message`
  Future<Map<String, dynamic>> getBankDetailsForUserEmail(
      String targetUserEmail, String organizationId) async {
    try {
      if (targetUserEmail.isEmpty) {
        return {
          'success': false,
          'message': 'Missing targetUserEmail parameter',
        };
      }
      if (organizationId.isEmpty) {
        return {
          'success': false,
          'message': 'Missing organizationId parameter',
        };
      }

      final endpoint =
          'getBankDetails?userEmail=$targetUserEmail&organizationId=$organizationId';
      return await get(endpoint);
    } catch (e) {
      debugPrint('getBankDetailsForUserEmail error: $e');
      return {
        'success': false,
        'message': 'Failed to load bank details for user: $e',
      };
    }
  }

  /// Get all assignments for an organization
  /// Returns clients with their assigned employees and schedules
  Future<Map<String, dynamic>?> getOrganizationAssignments(
      String organizationId) async {
    try {
      if (organizationId.isEmpty) {
        return {
          'success': false,
          'message': 'Missing organizationId parameter',
        };
      }

      final url = '${_baseUrl}getOrganizationAssignments/$organizationId';
      debugPrint('Fetching organization assignments from: $url');

      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'success': true,
          'assignments': data['assignments'] ?? data['data'] ?? [],
          'message': data['message'] ?? 'Assignments loaded successfully',
        };
      } else {
        debugPrint('Failed to load organization assignments: ${response.body}');
        return {
          'success': false,
          'message': 'Failed to load assignments: ${response.statusCode}',
          'assignments': [],
        };
      }
    } catch (e) {
      debugPrint('getOrganizationAssignments error: $e');
      return {
        'success': false,
        'message': 'Error loading assignments: $e',
        'assignments': [],
      };
    }
  }

  Future<Map<String, dynamic>> patch(String endpoint,
      {Map<String, dynamic>? body}) async {
    try {
      // Fix double slash issue by properly joining base URL and endpoint
      final cleanEndpoint =
          endpoint.startsWith('/') ? endpoint.substring(1) : endpoint;
      final baseNoTrailing = _baseUrl.replaceAll(RegExp(r'/+$'), '');
      final fullUrl = '$baseNoTrailing/$cleanEndpoint';

      debugPrint('=== API METHOD DEBUG: PATCH request to: $fullUrl ===');

      // Attach Authorization header if token exists
      final sharedUtils = SharedPreferencesUtils();
      await sharedUtils.init();
      final token = sharedUtils.getAuthToken();
      final String? authValue = (token != null && token.isNotEmpty)
          ? (token.toLowerCase().startsWith('bearer ')
              ? token
              : 'Bearer $token')
          : null;
      final headers = {
        'Content-Type': 'application/json',
        if (authValue != null) 'Authorization': authValue,
      };

      final response = await http.patch(
        Uri.parse(fullUrl),
        headers: headers,
        body: body != null ? json.encode(body) : null,
      );

      debugPrint(
          '=== API METHOD DEBUG: PATCH status: ${response.statusCode} ===');

      return _handleResponse(response);
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  /// Create a shift swap offer
  Future<Map<String, dynamic>> createSwapOffer({
    required String organizationId,
    required String userId,
    required String userEmail,
    required Map<String, dynamic> details,
  }) async {
    try {
      final url =
          'api/requests/create'; // Endpoint handling in post method handles base url
      final payload = {
        'organizationId': organizationId,
        'userId': userId,
        'userEmail': userEmail,
        'type': 'SHIFT_SWAP_OFFER',
        'details': details,
      };

      final response = await post(url, body: payload);
      return response;
    } catch (e) {
      debugPrint('Error creating swap offer: $e');
      return {'success': false, 'message': 'Error creating swap offer: $e'};
    }
  }

  /// Claim a shift swap offer
  Future<Map<String, dynamic>> claimSwapOffer({
    required String requestId,
    required String claimantId,
    required String claimantName,
    required String userEmail,
  }) async {
    try {
      final url = 'api/requests/$requestId/claim';
      final payload = {
        'claimantId': claimantId,
        'claimantName': claimantName,
        'userEmail': userEmail,
      };

      final response = await post(url, body: payload);
      return response;
    } catch (e) {
      debugPrint('Error claiming swap offer: $e');
      return {'success': false, 'message': 'Error claiming swap offer: $e'};
    }
  }

  /// Get open shift offers for an organization
  Future<Map<String, dynamic>> getOpenShifts(String organizationId) async {
    try {
      final url =
          'api/requests/organization/$organizationId?type=SHIFT_SWAP_OFFER&status=Pending';
      final response = await get(url);
      return response;
    } catch (e) {
      debugPrint('Error fetching open shifts: $e');
      return {'success': false, 'message': 'Error fetching open shifts: $e'};
    }
  }

  Future<Map<String, dynamic>> getMyShiftSwapRequests(
      String organizationId, String userEmail) async {
    try {
      // Fetch all swap offers related to this user (created by or claiming)
      // Backend RequestService.getRequests handles userId filter matching userId OR createdBy
      final url =
          'api/requests/organization/$organizationId?type=SHIFT_SWAP_OFFER&userId=$userEmail';
      final response = await get(url);
      return response;
    } catch (e) {
      debugPrint('Error fetching my shifts: $e');
      return {'success': false, 'message': 'Error fetching my shifts: $e'};
    }
  }

  Future<Map<String, dynamic>> getPublicHolidays() async {
    try {
      final response = await http.get(
        Uri.parse('${_baseUrl}leave/public-holidays'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {'success': false, 'message': 'Failed to fetch holidays'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  /// Fetch system tax configuration (ATO brackets)
  Future<Map<String, dynamic>> getTaxSettings() async {
    try {
      final uri = Uri.parse('${_baseUrl}api/config/tax-brackets');
      final authValue = await _getAuthorizationHeaderValue();
      final headers = {
        'Content-Type': 'application/json',
        if (authValue != null) 'Authorization': authValue,
      };

      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load tax settings: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching tax settings: $e');
      rethrow;
    }
  }

  // ============================================================================
  // SCHEDULING API METHODS - Automated Scheduling Engine
  // ============================================================================

  /// Create a new shift
  ///
  /// Parameters:
  /// - [shiftData]: Map containing shift details (organizationId, clientEmail,
  ///   employeeEmail, startTime, endTime, supportItems, notes)
  ///
  /// Returns success response with created shift data or error with conflicts
  Future<Map<String, dynamic>> createShift(
      Map<String, dynamic> shiftData) async {
    try {
      final url = '${_baseUrl}api/schedule/shift';
      final authValue = await _getAuthorizationHeaderValue();
      final headers = {
        'Content-Type': 'application/json',
        if (authValue != null) 'Authorization': authValue,
      };

      final sw = Stopwatch()..start();
      DebugLog.networkRequest('POST', url, payload: shiftData);

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(shiftData),
      );

      sw.stop();
      final responseBody = response.body.isNotEmpty
          ? json.decode(response.body)
          : <String, dynamic>{};

      DebugLog.networkResponse(url, response.statusCode,
          body: responseBody, durationMs: sw.elapsedMilliseconds);

      if (response.statusCode == 201 || response.statusCode == 200) {
        return {
          'success': true,
          ...responseBody,
        };
      } else if (response.statusCode == 409) {
        // Conflict - schedule conflict detected
        return {
          'success': false,
          'error': responseBody['error'] ?? 'Schedule conflict detected',
          'conflicts': responseBody['conflicts'] ?? [],
          'code': 409,
        };
      } else {
        return {
          'success': false,
          'error': responseBody['error'] ?? 'Failed to create shift',
          'code': response.statusCode,
        };
      }
    } catch (e) {
      debugPrint('Exception creating shift: $e');
      DebugLog.error('Exception creating shift',
          details: {'error': e.toString()});
      return {
        'success': false,
        'error': 'Error creating shift: $e',
      };
    }
  }

  /// Bulk create multiple shifts
  ///
  /// Parameters:
  /// - [shifts]: List of shift data maps
  /// - [organizationId]: Applied to all shifts if not specified individually
  ///
  /// Returns result with created and failed shifts
  Future<Map<String, dynamic>> bulkCreateShifts(
    List<Map<String, dynamic>> shifts,
    String organizationId,
  ) async {
    try {
      final url = '${_baseUrl}api/schedule/bulk';
      final authValue = await _getAuthorizationHeaderValue();
      final headers = {
        'Content-Type': 'application/json',
        if (authValue != null) 'Authorization': authValue,
      };

      final payload = {
        'organizationId': organizationId,
        'shifts': shifts,
      };

      final sw = Stopwatch()..start();
      DebugLog.networkRequest('POST', url, payload: payload);

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(payload),
      );

      sw.stop();
      final responseBody = response.body.isNotEmpty
          ? json.decode(response.body)
          : <String, dynamic>{};

      DebugLog.networkResponse(url, response.statusCode,
          body: responseBody, durationMs: sw.elapsedMilliseconds);

      return {
        'success': response.statusCode == 201 || response.statusCode == 207,
        ...responseBody,
      };
    } catch (e) {
      debugPrint('Exception in bulk create shifts: $e');
      return {
        'success': false,
        'error': 'Error creating shifts: $e',
      };
    }
  }

  /// Get AI-powered employee recommendations for a shift
  ///
  /// Parameters:
  /// - [organizationId]: Required organization ID
  /// - [clientEmail]: Client email (optional, for location-based matching)
  /// - [startTime]: Shift start time
  /// - [endTime]: Shift end time
  /// - [requiredSkills]: List of required skills
  /// - [latitude]: Client latitude for distance calculation
  /// - [longitude]: Client longitude for distance calculation
  ///
  /// Returns ranked list of employee recommendations with match scores
  Future<Map<String, dynamic>> getScheduleRecommendations({
    required String organizationId,
    String? clientEmail,
    DateTime? startTime,
    DateTime? endTime,
    List<String>? requiredSkills,
    double? latitude,
    double? longitude,
  }) async {
    try {
      final queryParams = <String, String>{
        'organizationId': organizationId,
        if (clientEmail != null) 'clientEmail': clientEmail,
        if (startTime != null) 'startTime': startTime.toIso8601String(),
        if (endTime != null) 'endTime': endTime.toIso8601String(),
        if (requiredSkills != null && requiredSkills.isNotEmpty)
          'requiredSkills': requiredSkills.join(','),
        if (latitude != null) 'latitude': latitude.toString(),
        if (longitude != null) 'longitude': longitude.toString(),
      };

      final uri = Uri.parse('${_baseUrl}api/schedule/recommendations')
          .replace(queryParameters: queryParams);

      final authValue = await _getAuthorizationHeaderValue();
      final headers = {
        'Content-Type': 'application/json',
        if (authValue != null) 'Authorization': authValue,
      };

      final sw = Stopwatch()..start();
      DebugLog.networkRequest('GET', uri.toString(), payload: queryParams);

      final response = await http.get(uri, headers: headers);

      sw.stop();
      final responseBody = response.body.isNotEmpty
          ? json.decode(response.body)
          : <String, dynamic>{};

      DebugLog.networkResponse(uri.toString(), response.statusCode,
          body: responseBody, durationMs: sw.elapsedMilliseconds);

      if (response.statusCode == 200) {
        return {
          'success': true,
          ...responseBody,
        };
      } else {
        return {
          'success': false,
          'error': responseBody['error'] ?? 'Failed to get recommendations',
          'recommendations': [],
        };
      }
    } catch (e) {
      debugPrint('Exception getting recommendations: $e');
      return {
        'success': false,
        'error': 'Error getting recommendations: $e',
        'recommendations': [],
      };
    }
  }

  /// Get shifts for an organization with optional filters
  ///
  /// Parameters:
  /// - [organizationId]: Required organization ID
  /// - [startDate]: Filter by start date
  /// - [endDate]: Filter by end date
  /// - [status]: Filter by shift status
  /// - [employeeEmail]: Filter by employee
  /// - [clientEmail]: Filter by client
  Future<Map<String, dynamic>> getScheduleShifts({
    required String organizationId,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    String? employeeEmail,
    String? clientEmail,
  }) async {
    try {
      final queryParams = <String, String>{
        if (startDate != null) 'startDate': startDate.toIso8601String(),
        if (endDate != null) 'endDate': endDate.toIso8601String(),
        if (status != null) 'status': status,
        if (employeeEmail != null) 'employeeEmail': employeeEmail,
        if (clientEmail != null) 'clientEmail': clientEmail,
      };

      final uri = Uri.parse('${_baseUrl}api/schedule/shifts/$organizationId')
          .replace(
              queryParameters: queryParams.isNotEmpty ? queryParams : null);

      final authValue = await _getAuthorizationHeaderValue();
      final headers = {
        'Content-Type': 'application/json',
        if (authValue != null) 'Authorization': authValue,
      };

      final sw = Stopwatch()..start();
      DebugLog.networkRequest('GET', uri.toString(), payload: queryParams);

      final response = await http.get(uri, headers: headers);

      sw.stop();
      final responseBody = response.body.isNotEmpty
          ? json.decode(response.body)
          : <String, dynamic>{};

      DebugLog.networkResponse(uri.toString(), response.statusCode,
          body: responseBody, durationMs: sw.elapsedMilliseconds);

      if (response.statusCode == 200) {
        return {
          'success': true,
          ...responseBody,
        };
      } else {
        return {
          'success': false,
          'error': responseBody['error'] ?? 'Failed to get shifts',
          'data': [],
        };
      }
    } catch (e) {
      debugPrint('Exception getting shifts: $e');
      return {
        'success': false,
        'error': 'Error getting shifts: $e',
        'data': [],
      };
    }
  }

  /// Update an existing shift
  ///
  /// Parameters:
  /// - [shiftId]: ID of the shift to update
  /// - [updateData]: Fields to update
  Future<Map<String, dynamic>> updateShift(
    String shiftId,
    Map<String, dynamic> updateData,
  ) async {
    try {
      final url = '${_baseUrl}api/schedule/shift/$shiftId';
      final authValue = await _getAuthorizationHeaderValue();
      final headers = {
        'Content-Type': 'application/json',
        if (authValue != null) 'Authorization': authValue,
      };

      final response = await http.put(
        Uri.parse(url),
        headers: headers,
        body: json.encode(updateData),
      );

      final responseBody = response.body.isNotEmpty
          ? json.decode(response.body)
          : <String, dynamic>{};

      if (response.statusCode == 200) {
        return {'success': true, ...responseBody};
      } else if (response.statusCode == 409) {
        return {
          'success': false,
          'error': responseBody['error'] ?? 'Schedule conflict detected',
          'conflicts': responseBody['conflicts'] ?? [],
          'code': 409,
        };
      } else {
        return {
          'success': false,
          'error': responseBody['error'] ?? 'Failed to update shift',
        };
      }
    } catch (e) {
      return {'success': false, 'error': 'Error updating shift: $e'};
    }
  }

  /// Delete/cancel a shift
  ///
  /// Parameters:
  /// - [shiftId]: ID of the shift to cancel
  Future<Map<String, dynamic>> deleteShift(String shiftId) async {
    try {
      final url = '${_baseUrl}api/schedule/shift/$shiftId';
      final authValue = await _getAuthorizationHeaderValue();
      final headers = {
        'Content-Type': 'application/json',
        if (authValue != null) 'Authorization': authValue,
      };

      final response = await http.delete(Uri.parse(url), headers: headers);

      final responseBody = response.body.isNotEmpty
          ? json.decode(response.body)
          : <String, dynamic>{};

      return {
        'success': response.statusCode == 200,
        ...responseBody,
      };
    } catch (e) {
      return {'success': false, 'error': 'Error deleting shift: $e'};
    }
  }

  /// Check for scheduling conflicts
  ///
  /// Parameters:
  /// - [employeeEmail]: Employee to check
  /// - [startTime]: Proposed start time
  /// - [endTime]: Proposed end time
  /// - [excludeShiftId]: Shift ID to exclude (for updates)
  Future<Map<String, dynamic>> checkScheduleConflicts({
    String? employeeId,
    required String employeeEmail,
    required DateTime startTime,
    required DateTime endTime,
    String? excludeShiftId,
  }) async {
    try {
      final url = '${_baseUrl}api/schedule/check-conflicts';
      final authValue = await _getAuthorizationHeaderValue();
      final headers = {
        'Content-Type': 'application/json',
        if (authValue != null) 'Authorization': authValue,
      };

      final payload = {
        if (employeeId != null) 'employeeId': employeeId,
        'employeeEmail': employeeEmail,
        'startTime': startTime.toIso8601String(),
        'endTime': endTime.toIso8601String(),
        if (excludeShiftId != null) 'excludeShiftId': excludeShiftId,
      };

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(payload),
      );

      final responseBody = response.body.isNotEmpty
          ? json.decode(response.body)
          : <String, dynamic>{};

      return {
        'success': response.statusCode == 200,
        ...responseBody,
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'Error checking conflicts: $e',
        'hasConflict': false,
        'conflicts': [],
      };
    }
  }

  /// Get list of invoices for an organization
  Future<Map<String, dynamic>> getInvoicesList(
    String organizationId, {
    int page = 1,
    int limit = 20,
    String? status,
    String? paymentStatus,
    String? invoiceType,
    String? searchTerm,
  }) async {
    try {
      String queryString =
          'organizationId=$organizationId&page=$page&limit=$limit';
      if (status != null) queryString += '&status=$status';
      if (paymentStatus != null) queryString += '&paymentStatus=$paymentStatus';
      if (invoiceType != null) queryString += '&invoiceType=$invoiceType';
      if (searchTerm != null) queryString += '&searchTerm=$searchTerm';

      final url = '${_baseUrl}api/invoices?$queryString';
      final authValue = await _getAuthorizationHeaderValue();
      final headers = {
        'Content-Type': 'application/json',
        if (authValue != null) 'Authorization': authValue,
      };

      final response = await http.get(Uri.parse(url), headers: headers);
      return json.decode(response.body);
    } catch (e) {
      debugPrint('Error getting invoices list: $e');
      return {'success': false, 'error': e.toString()};
    }
  }

  /// Update invoice payment status
  Future<Map<String, dynamic>> updateInvoicePaymentStatus(
    String invoiceId,
    String organizationId,
    String status, {
    String? notes,
    double? paidAmount,
    String? updatedBy,
  }) async {
    try {
      final url = '${_baseUrl}api/invoices/$invoiceId/payment-status';
      final authValue = await _getAuthorizationHeaderValue();
      final headers = {
        'Content-Type': 'application/json',
        if (authValue != null) 'Authorization': authValue,
      };

      final body = {
        'organizationId': organizationId,
        'status': status,
        if (notes != null) 'notes': notes,
        if (paidAmount != null) 'paidAmount': paidAmount,
        if (updatedBy != null) 'updatedBy': updatedBy,
      };

      final response = await http.patch(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body),
      );
      return json.decode(response.body);
    } catch (e) {
      debugPrint('Error updating invoice payment status: $e');
      return {'success': false, 'error': e.toString()};
    }
  }

  Future<Map<String, dynamic>> parseReceiptText(String rawText,
      {String source = 'google_mlkit'}) async {
    try {
      final endpoint = 'api/expenses/parse-receipt';
      final body = {
        'rawText': rawText,
        'source': source,
      };
      return await post(endpoint, body: body);
    } catch (e) {
      debugPrint('Error parsing receipt text: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  // ==================== INTEGRATION METHODS ====================

  /// Get all integrations for an organization
  Future<Map<String, dynamic>> getOrganizationIntegrations(
      String organizationId) async {
    try {
      final endpoint = 'api/integrations/$organizationId';
      return await get(endpoint);
    } catch (e) {
      debugPrint('Error getting organization integrations: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Connect an integration (OAuth or API key based)
  Future<Map<String, dynamic>> connectIntegration({
    required String organizationId,
    required String integrationType, // 'xero', 'slack', etc.
    String? apiKey,
    String? accessToken,
    String? refreshToken,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final endpoint = 'api/integrations/$organizationId/connect';
      final body = {
        'integrationType': integrationType,
        if (apiKey != null) 'apiKey': apiKey,
        if (accessToken != null) 'accessToken': accessToken,
        if (refreshToken != null) 'refreshToken': refreshToken,
        if (metadata != null) 'metadata': metadata,
      };
      return await post(endpoint, body: body);
    } catch (e) {
      debugPrint('Error connecting integration: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Disconnect an integration
  Future<Map<String, dynamic>> disconnectIntegration({
    required String organizationId,
    required String integrationType,
  }) async {
    try {
      final endpoint = 'api/integrations/$organizationId/disconnect';
      final body = {
        'integrationType': integrationType,
      };
      return await post(endpoint, body: body);
    } catch (e) {
      debugPrint('Error disconnecting integration: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Get OAuth authorization URL for an integration
  Future<Map<String, dynamic>> getIntegrationAuthUrl({
    required String organizationId,
    required String integrationType,
    String? redirectUri,
  }) async {
    try {
      final endpoint = 'api/integrations/$organizationId/auth-url';
      final body = {
        'integrationType': integrationType,
        if (redirectUri != null) 'redirectUri': redirectUri,
      };
      return await post(endpoint, body: body);
    } catch (e) {
      debugPrint('Error getting integration auth URL: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Handle OAuth callback
  Future<Map<String, dynamic>> handleIntegrationCallback({
    required String organizationId,
    required String integrationType,
    required String code,
    String? state,
  }) async {
    try {
      final endpoint = 'api/integrations/$organizationId/callback';
      final body = {
        'integrationType': integrationType,
        'code': code,
        if (state != null) 'state': state,
      };
      return await post(endpoint, body: body);
    } catch (e) {
      debugPrint('Error handling integration callback: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Sync data with an integration
  Future<Map<String, dynamic>> syncIntegration({
    required String organizationId,
    required String integrationType,
    Map<String, dynamic>? options,
  }) async {
    try {
      final endpoint = 'api/integrations/$organizationId/sync';
      final body = {
        'integrationType': integrationType,
        if (options != null) 'options': options,
      };
      return await post(endpoint, body: body);
    } catch (e) {
      debugPrint('Error syncing integration: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Test integration connection
  Future<Map<String, dynamic>> testIntegration({
    required String organizationId,
    required String integrationType,
  }) async {
    try {
      final endpoint = 'api/integrations/$organizationId/test';
      final body = {
        'integrationType': integrationType,
      };
      return await post(endpoint, body: body);
    } catch (e) {
      debugPrint('Error testing integration: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Get integration sync history
  Future<Map<String, dynamic>> getIntegrationSyncHistory({
    required String organizationId,
    required String integrationType,
    int? limit,
  }) async {
    try {
      final endpoint =
          'api/integrations/$organizationId/sync-history/$integrationType${limit != null ? '?limit=$limit' : ''}';
      return await get(endpoint);
    } catch (e) {
      debugPrint('Error getting integration sync history: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Update integration settings
  Future<Map<String, dynamic>> updateIntegrationSettings({
    required String organizationId,
    required String integrationType,
    required Map<String, dynamic> settings,
  }) async {
    try {
      final endpoint = 'api/integrations/$organizationId/settings';
      final body = {
        'integrationType': integrationType,
        'settings': settings,
      };
      return await put(endpoint, body: body);
    } catch (e) {
      debugPrint('Error updating integration settings: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  // ============================================================================
  // Bulk Actions API Methods
  // ============================================================================

  /// Bulk approve timesheets
  Future<Map<String, dynamic>> bulkApproveTimesheets({
    required List<String> timesheetIds,
    required String organizationId,
    required String approvedBy,
  }) async {
    try {
      final endpoint = 'api/bulk/approve-timesheets';
      final body = {
        'timesheetIds': timesheetIds,
        'organizationId': organizationId,
        'approvedBy': approvedBy,
      };
      return await post(endpoint, body: body);
    } catch (e) {
      debugPrint('Error bulk approving timesheets: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Bulk reject timesheets
  Future<Map<String, dynamic>> bulkRejectTimesheets({
    required List<String> timesheetIds,
    required String organizationId,
    required String rejectedBy,
    required String reason,
  }) async {
    try {
      final endpoint = 'api/bulk/reject-timesheets';
      final body = {
        'timesheetIds': timesheetIds,
        'organizationId': organizationId,
        'rejectedBy': rejectedBy,
        'reason': reason,
      };
      return await post(endpoint, body: body);
    } catch (e) {
      debugPrint('Error bulk rejecting timesheets: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Preview invoices before generation
  Future<Map<String, dynamic>> previewInvoices({
    required List<String> appointmentIds,
    required String organizationId,
    required bool groupByClient,
  }) async {
    try {
      final endpoint = 'api/bulk/preview-invoices';
      final body = {
        'appointmentIds': appointmentIds,
        'organizationId': organizationId,
        'groupByClient': groupByClient,
      };
      return await post(endpoint, body: body);
    } catch (e) {
      debugPrint('Error previewing invoices: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Generate invoices in bulk
  Future<Map<String, dynamic>> bulkGenerateInvoices({
    required List<String> appointmentIds,
    required String organizationId,
    required bool groupByClient,
    DateTime? dueDate,
  }) async {
    try {
      final endpoint = 'api/bulk/generate-invoices';
      final body = {
        'appointmentIds': appointmentIds,
        'organizationId': organizationId,
        'groupByClient': groupByClient,
        if (dueDate != null) 'dueDate': dueDate.toIso8601String(),
      };
      return await post(endpoint, body: body);
    } catch (e) {
      debugPrint('Error bulk generating invoices: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Get worker assignment suggestions for shifts
  Future<Map<String, dynamic>> suggestWorkerAssignments({
    required List<String> shiftIds,
    required String organizationId,
  }) async {
    try {
      final endpoint = 'api/bulk/suggest-assignments';
      final body = {
        'shiftIds': shiftIds,
        'organizationId': organizationId,
      };
      return await post(endpoint, body: body);
    } catch (e) {
      debugPrint('Error getting assignment suggestions: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Assign workers to shifts in bulk
  Future<Map<String, dynamic>> bulkAssignShifts({
    required List<Map<String, String>> assignments,
    required String organizationId,
  }) async {
    try {
      final endpoint = 'api/bulk/assign-shifts';
      final body = {
        'assignments': assignments,
        'organizationId': organizationId,
      };
      return await post(endpoint, body: body);
    } catch (e) {
      debugPrint('Error bulk assigning shifts: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Send messages to multiple recipients
  Future<Map<String, dynamic>> bulkSendMessages({
    required List<String> recipientIds,
    required String organizationId,
    required String subject,
    required String message,
    required List<String> channels,
  }) async {
    try {
      final endpoint = 'api/bulk/send-messages';
      final body = {
        'recipientIds': recipientIds,
        'organizationId': organizationId,
        'subject': subject,
        'message': message,
        'channels': channels,
      };
      return await post(endpoint, body: body);
    } catch (e) {
      debugPrint('Error bulk sending messages: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Schedule messages for later delivery
  Future<Map<String, dynamic>> bulkScheduleMessages({
    required List<String> recipientIds,
    required String organizationId,
    required String subject,
    required String message,
    required List<String> channels,
    required DateTime scheduledFor,
  }) async {
    try {
      final endpoint = 'api/bulk/schedule-messages';
      final body = {
        'recipientIds': recipientIds,
        'organizationId': organizationId,
        'subject': subject,
        'message': message,
        'channels': channels,
        'scheduledFor': scheduledFor.toIso8601String(),
      };
      return await post(endpoint, body: body);
    } catch (e) {
      debugPrint('Error bulk scheduling messages: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  // ============================================================================
  // Phase 2: Shift Matching & Auto-Scheduling API Methods
  // ============================================================================

  /// Match workers to a shift
  Future<Map<String, dynamic>> matchWorkers({
    required String shiftId,
    required String organizationId,
    Map<String, dynamic>? criteria,
  }) async {
    try {
      final endpoint = 'api/scheduling/match-workers';
      final body = {
        'shiftId': shiftId,
        'organizationId': organizationId,
        if (criteria != null) 'criteria': criteria,
      };
      return await post(endpoint, body: body);
    } catch (e) {
      debugPrint('Error matching workers: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Auto-fill multiple shifts with optimal workers
  Future<Map<String, dynamic>> autoFillShifts({
    required List<String> shiftIds,
    required String organizationId,
    Map<String, dynamic>? criteria,
  }) async {
    try {
      final endpoint = 'api/scheduling/auto-fill';
      final body = {
        'shiftIds': shiftIds,
        'organizationId': organizationId,
        if (criteria != null) 'criteria': criteria,
      };
      return await post(endpoint, body: body);
    } catch (e) {
      debugPrint('Error auto-filling shifts: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Optimize route for a worker's shifts
  Future<Map<String, dynamic>> optimizeRoute({
    required String workerId,
    required String date,
    required String organizationId,
  }) async {
    try {
      final endpoint = 'api/scheduling/optimize-route';
      final body = {
        'workerId': workerId,
        'date': date,
        'organizationId': organizationId,
      };
      return await post(endpoint, body: body);
    } catch (e) {
      debugPrint('Error optimizing route: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Get shift recommendations for a specific shift
  Future<Map<String, dynamic>> getShiftRecommendations({
    required String shiftId,
    required String organizationId,
  }) async {
    try {
      final endpoint =
          'api/scheduling/recommendations/$shiftId?organizationId=$organizationId';
      return await get(endpoint);
    } catch (e) {
      debugPrint('Error getting shift recommendations: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  // ============================================================================
  // Phase 2: Invoice AI API Methods
  // ============================================================================

  /// Validate an invoice
  Future<Map<String, dynamic>> validateInvoice({
    required Map<String, dynamic> invoice,
  }) async {
    try {
      final endpoint = 'api/invoice-ai/validate';
      final body = {'invoice': invoice};
      return await post(endpoint, body: body);
    } catch (e) {
      debugPrint('Error validating invoice: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Detect anomalies in an invoice
  Future<Map<String, dynamic>> detectInvoiceAnomalies({
    required Map<String, dynamic> invoice,
  }) async {
    try {
      final endpoint = 'api/invoice-ai/detect-anomalies';
      final body = {'invoice': invoice};
      return await post(endpoint, body: body);
    } catch (e) {
      debugPrint('Error detecting invoice anomalies: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Predict payment date for an invoice
  Future<Map<String, dynamic>> predictPaymentDate({
    required String invoiceId,
  }) async {
    try {
      final endpoint = 'api/invoice-ai/payment-prediction/$invoiceId';
      return await get(endpoint);
    } catch (e) {
      debugPrint('Error predicting payment date: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Auto-generate invoices for a period
  Future<Map<String, dynamic>> autoGenerateInvoices({
    required String organizationId,
    required DateTime startDate,
    required DateTime endDate,
    bool validateBeforeGeneration = true,
    bool groupByClient = false,
  }) async {
    try {
      final endpoint = 'api/invoice-ai/auto-generate';
      final body = {
        'organizationId': organizationId,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'validateBeforeGeneration': validateBeforeGeneration,
        'groupByClient': groupByClient,
      };
      return await post(endpoint, body: body);
    } catch (e) {
      debugPrint('Error auto-generating invoices: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Get smart reminders for an invoice
  Future<Map<String, dynamic>> getSmartReminders({
    required String invoiceId,
  }) async {
    try {
      final endpoint = 'api/invoice-ai/smart-reminders/$invoiceId';
      return await get(endpoint);
    } catch (e) {
      debugPrint('Error getting smart reminders: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  // ==================== PHASE 3 API METHODS ====================

  // --- Compliance Automation ---

  /// Run compliance scan for organization
  Future<Map<String, dynamic>> runComplianceScan({
    required String organizationId,
  }) async {
    try {
      final endpoint = 'api/compliance/scan/$organizationId';
      return await get(endpoint);
    } catch (e) {
      debugPrint('Error running compliance scan: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Get compliance score for worker
  Future<Map<String, dynamic>> getComplianceScore({
    required String workerId,
  }) async {
    try {
      final endpoint = 'api/compliance/score/$workerId';
      return await get(endpoint);
    } catch (e) {
      debugPrint('Error getting compliance score: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Get expiring documents
  Future<Map<String, dynamic>> getExpiringDocuments({
    required String organizationId,
    int? daysAhead,
  }) async {
    try {
      final endpoint =
          'api/compliance/expiring/$organizationId${daysAhead != null ? '?daysAhead=$daysAhead' : ''}';
      return await get(endpoint);
    } catch (e) {
      debugPrint('Error getting expiring documents: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Generate compliance report
  Future<Map<String, dynamic>> generateComplianceReport({
    required String organizationId,
    required String reportType,
  }) async {
    try {
      final endpoint = 'api/compliance/report';
      final body = {
        'organizationId': organizationId,
        'reportType': reportType,
      };
      return await post(endpoint, body: body);
    } catch (e) {
      debugPrint('Error generating compliance report: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Get compliance trends
  Future<Map<String, dynamic>> getComplianceTrends({
    required String organizationId,
    int? months,
  }) async {
    try {
      final endpoint =
          'api/compliance/trends/$organizationId${months != null ? '?months=$months' : ''}';
      return await get(endpoint);
    } catch (e) {
      debugPrint('Error getting compliance trends: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  // --- Smart Expenses ---

  /// Scan receipt using OCR
  Future<Map<String, dynamic>> scanReceipt({
    required String imageBase64,
  }) async {
    try {
      final endpoint = 'api/expenses/scan-receipt';
      final body = {'imageBase64': imageBase64};
      return await post(endpoint, body: body);
    } catch (e) {
      debugPrint('Error scanning receipt: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Categorize expense using AI
  Future<Map<String, dynamic>> categorizeExpense({
    required Map<String, dynamic> expenseData,
  }) async {
    try {
      final endpoint = 'api/expenses/categorize';
      return await post(endpoint, body: expenseData);
    } catch (e) {
      debugPrint('Error categorizing expense: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Validate expense against policy
  Future<Map<String, dynamic>> validateExpensePolicy({
    required Map<String, dynamic> expenseData,
  }) async {
    try {
      final endpoint = 'api/expenses/validate-policy';
      return await post(endpoint, body: expenseData);
    } catch (e) {
      debugPrint('Error validating expense policy: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Check for duplicate receipt
  Future<Map<String, dynamic>> checkDuplicateReceipt({
    required String receiptHash,
  }) async {
    try {
      final endpoint = 'api/expenses/detect-duplicate';
      final body = {'receiptHash': receiptHash};
      return await post(endpoint, body: body);
    } catch (e) {
      debugPrint('Error checking duplicate receipt: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Calculate mileage from GPS locations
  Future<Map<String, dynamic>> calculateMileage({
    required List<Map<String, dynamic>> locations,
  }) async {
    try {
      final endpoint = 'api/expenses/calculate-mileage';
      final body = {'locations': locations};
      return await post(endpoint, body: body);
    } catch (e) {
      debugPrint('Error calculating mileage: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  // --- Offline Sync ---

  /// Queue offline data for later sync
  Future<Map<String, dynamic>> queueOfflineData({
    required Map<String, dynamic> data,
  }) async {
    try {
      final endpoint = 'api/offline/queue';
      return await post(endpoint, body: data);
    } catch (e) {
      debugPrint('Error queueing offline data: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Sync offline data to server
  Future<Map<String, dynamic>> syncOfflineData({
    required String userId,
    required List<Map<String, dynamic>> queueItems,
  }) async {
    try {
      final endpoint = 'api/offline/sync';
      final body = {
        'userId': userId,
        'queueItems': queueItems,
      };
      return await post(endpoint, body: body);
    } catch (e) {
      debugPrint('Error syncing offline data: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Get offline-capable data for user
  Future<Map<String, dynamic>> getOfflineCapableData({
    required String userId,
  }) async {
    try {
      final endpoint = 'api/offline/data/$userId';
      return await get(endpoint);
    } catch (e) {
      debugPrint('Error getting offline data: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Resolve sync conflict
  Future<Map<String, dynamic>> resolveConflict({
    required String conflictId,
    required String resolution,
    Map<String, dynamic>? mergedData,
  }) async {
    try {
      final endpoint = 'api/offline/resolve-conflict';
      final body = {
        'conflictId': conflictId,
        'resolution': resolution,
        if (mergedData != null) 'mergedData': mergedData,
      };
      return await post(endpoint, body: body);
    } catch (e) {
      debugPrint('Error resolving conflict: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  // ============================================================================
  // PHASE 4: CLIENT PORTAL, PAYROLL & COMMUNICATION
  // ============================================================================

  // --- Client Portal (6 methods) ---

  /// Get client dashboard data
  Future<Map<String, dynamic>> getClientDashboard({
    required String clientId,
  }) async {
    try {
      final endpoint = 'api/client-portal/dashboard/$clientId';
      return await get(endpoint);
    } catch (e) {
      debugPrint('Error getting client dashboard: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Get real-time worker location
  Future<Map<String, dynamic>> getWorkerLocation({
    required String appointmentId,
  }) async {
    try {
      final endpoint = 'api/client-portal/worker-location/$appointmentId';
      return await get(endpoint);
    } catch (e) {
      debugPrint('Error getting worker location: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Get appointment status with ETA
  Future<Map<String, dynamic>> getAppointmentStatus({
    required String appointmentId,
  }) async {
    try {
      final endpoint = 'api/client-portal/appointment-status/$appointmentId';
      return await get(endpoint);
    } catch (e) {
      debugPrint('Error getting appointment status: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Send message to worker
  Future<Map<String, dynamic>> sendClientMessage({
    required Map<String, dynamic> messageData,
  }) async {
    try {
      final endpoint = 'api/client-portal/message';
      return await post(endpoint, body: messageData);
    } catch (e) {
      debugPrint('Error sending client message: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Submit service feedback
  Future<Map<String, dynamic>> submitServiceFeedback({
    required Map<String, dynamic> feedbackData,
  }) async {
    try {
      final endpoint = 'api/client-portal/feedback';
      return await post(endpoint, body: feedbackData);
    } catch (e) {
      debugPrint('Error submitting feedback: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Get service history for client
  Future<Map<String, dynamic>> getServiceHistory({
    required String clientId,
  }) async {
    try {
      final endpoint = 'api/client-portal/service-history/$clientId';
      return await get(endpoint);
    } catch (e) {
      debugPrint('Error getting service history: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  // --- Advanced Payroll (5 methods) ---

  /// Calculate payroll with award rates and penalties
  Future<Map<String, dynamic>> calculatePayroll({
    required Map<String, dynamic> payrollData,
  }) async {
    try {
      final endpoint = 'api/payroll/calculate';
      return await post(endpoint, body: payrollData);
    } catch (e) {
      debugPrint('Error calculating payroll: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Get payslip for user and period
  Future<Map<String, dynamic>> getPayslip({
    required String userId,
    required String period,
  }) async {
    try {
      final endpoint = 'api/payroll/payslip/$userId/$period';
      return await get(endpoint);
    } catch (e) {
      debugPrint('Error getting payslip: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Generate payslips for all employees
  Future<Map<String, dynamic>> generatePayslips({
    required String organizationId,
    required String period,
  }) async {
    try {
      final endpoint = 'api/payroll/generate-payslips';
      final body = {
        'organizationId': organizationId,
        'period': period,
      };
      return await post(endpoint, body: body);
    } catch (e) {
      debugPrint('Error generating payslips: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Get payroll summary for organization
  Future<Map<String, dynamic>> getPayrollSummary({
    required String organizationId,
    required String period,
  }) async {
    try {
      final endpoint = 'api/payroll/summary/$organizationId/$period';
      return await get(endpoint);
    } catch (e) {
      debugPrint('Error getting payroll summary: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Export payroll data to Xero/MYOB
  Future<Map<String, dynamic>> exportPayrollData({
    required Map<String, dynamic> exportData,
  }) async {
    try {
      final endpoint = 'api/payroll/export';
      return await post(endpoint, body: exportData);
    } catch (e) {
      debugPrint('Error exporting payroll data: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  // --- Communication Hub (7 methods) ---

  /// Send message via specified channel
  Future<Map<String, dynamic>> sendMessage({
    required Map<String, dynamic> messageData,
  }) async {
    try {
      final endpoint = 'api/communication/send';
      return await post(endpoint, body: messageData);
    } catch (e) {
      debugPrint('Error sending message: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Get all conversations for user
  Future<Map<String, dynamic>> getConversations({
    required String userId,
  }) async {
    try {
      final endpoint = 'api/communication/conversations/$userId';
      return await get(endpoint);
    } catch (e) {
      debugPrint('Error getting conversations: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Get messages for a conversation
  Future<Map<String, dynamic>> getMessages({
    required String conversationId,
  }) async {
    try {
      final endpoint = 'api/communication/messages/$conversationId';
      return await get(endpoint);
    } catch (e) {
      debugPrint('Error getting messages: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Broadcast message to group
  Future<Map<String, dynamic>> broadcastMessage({
    required Map<String, dynamic> broadcastData,
  }) async {
    try {
      final endpoint = 'api/communication/broadcast';
      return await post(endpoint, body: broadcastData);
    } catch (e) {
      debugPrint('Error broadcasting message: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Schedule message for later delivery
  Future<Map<String, dynamic>> scheduleMessage({
    required Map<String, dynamic> scheduleData,
  }) async {
    try {
      final endpoint = 'api/communication/schedule';
      return await post(endpoint, body: scheduleData);
    } catch (e) {
      debugPrint('Error scheduling message: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Get available message templates
  Future<Map<String, dynamic>> getMessageTemplates() async {
    try {
      final endpoint = 'api/communication/templates';
      return await get(endpoint);
    } catch (e) {
      debugPrint('Error getting message templates: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Get message delivery status
  Future<Map<String, dynamic>> getMessageStatus({
    required String messageId,
  }) async {
    try {
      final endpoint = 'api/communication/status/$messageId';
      return await get(endpoint);
    } catch (e) {
      debugPrint('Error getting message status: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  // ============================================================================
  // Real-Time Portal API Methods (Phase 7)
  // ============================================================================

  /// Start real-time tracking
  Future<Map<String, dynamic>> startRealtimeTracking({
    required String appointmentId,
    required String workerId,
    required Map<String, dynamic> clientLocation,
  }) async {
    return await post(
      '/api/realtime-portal/tracking/start',
      body: {
        'appointmentId': appointmentId,
        'workerId': workerId,
        'clientLocation': clientLocation,
      },
    );
  }

  /// Update real-time location
  Future<Map<String, dynamic>> updateRealtimeLocation({
    required String appointmentId,
    required String workerId,
    required double latitude,
    required double longitude,
    double? accuracy,
  }) async {
    return await post(
      '/api/realtime-portal/tracking/update',
      body: {
        'appointmentId': appointmentId,
        'workerId': workerId,
        'latitude': latitude,
        'longitude': longitude,
        'accuracy': accuracy ?? 10.0,
      },
    );
  }

  /// Stop real-time tracking
  Future<Map<String, dynamic>> stopRealtimeTracking({
    required String appointmentId,
  }) async {
    return await post(
      '/api/realtime-portal/tracking/stop',
      body: {
        'appointmentId': appointmentId,
      },
    );
  }

  /// Get live tracking data
  Future<Map<String, dynamic>> getLiveTracking({
    required String appointmentId,
  }) async {
    return await get(
      '/api/realtime-portal/tracking/live/$appointmentId',
    );
  }

  /// Send real-time message
  Future<Map<String, dynamic>> sendRealtimeMessage({
    required String conversationId,
    required String senderId,
    required String senderType,
    required String recipientId,
    required String message,
    List<Map<String, dynamic>>? attachments,
  }) async {
    return await post(
      '/api/realtime-portal/messages/send',
      body: {
        'conversationId': conversationId,
        'senderId': senderId,
        'senderType': senderType,
        'recipientId': recipientId,
        'message': message,
        'attachments': attachments,
      },
    );
  }

  /// Get real-time messages
  Future<Map<String, dynamic>> getRealtimeMessages({
    required String conversationId,
    int? limit,
    String? before,
  }) async {
    final queryParams = <String, String>{};
    if (limit != null) queryParams['limit'] = limit.toString();
    if (before != null) queryParams['before'] = before;

    final query = queryParams.isEmpty
        ? ''
        : '?${queryParams.entries.map((e) => '${e.key}=${e.value}').join('&')}';

    return await get(
      '/api/realtime-portal/messages/$conversationId$query',
    );
  }

  /// Create real-time conversation
  Future<Map<String, dynamic>> createRealtimeConversation({
    required String appointmentId,
    required String clientId,
    required String workerId,
    required String organizationId,
  }) async {
    return await post(
      '/api/realtime-portal/conversations/create',
      body: {
        'appointmentId': appointmentId,
        'clientId': clientId,
        'workerId': workerId,
        'organizationId': organizationId,
      },
    );
  }

  /// Get user conversations
  Future<Map<String, dynamic>> getUserConversations({
    required String userId,
  }) async {
    return await get(
      '/api/realtime-portal/conversations/user/$userId',
    );
  }

  /// Save digital signature
  Future<Map<String, dynamic>> saveDigitalSignature({
    required String appointmentId,
    required String clientId,
    required String signatureData,
  }) async {
    return await post(
      '/api/realtime-portal/signature/save',
      body: {
        'appointmentId': appointmentId,
        'clientId': clientId,
        'signatureData': signatureData,
      },
    );
  }

  /// Submit service confirmation
  Future<Map<String, dynamic>> submitServiceConfirmation({
    required String appointmentId,
    required String clientId,
    required String workerId,
    required String signatureId,
    int? rating,
    String? feedback,
    List<Map<String, dynamic>>? checklist,
    List<String>? photos,
    List<Map<String, dynamic>>? incidents,
  }) async {
    return await post(
      '/api/realtime-portal/service-confirmation/submit',
      body: {
        'appointmentId': appointmentId,
        'clientId': clientId,
        'workerId': workerId,
        'signatureId': signatureId,
        'rating': rating,
        'feedback': feedback,
        'checklist': checklist,
        'photos': photos,
        'incidents': incidents,
      },
    );
  }

  /// Get service confirmation
  Future<Map<String, dynamic>> getServiceConfirmation({
    required String appointmentId,
  }) async {
    return await get(
      '/api/realtime-portal/service-confirmation/$appointmentId',
    );
  }

  /// Get checklist template
  Future<Map<String, dynamic>> getChecklistTemplate({
    required String serviceType,
  }) async {
    return await get(
      '/api/realtime-portal/checklist/$serviceType',
    );
  }

  /// Invite family member
  Future<Map<String, dynamic>> inviteFamilyMember({
    required String clientId,
    required String invitedBy,
    required String email,
    required String name,
    required String relationship,
    String? role,
    Map<String, dynamic>? permissions,
  }) async {
    return await post(
      '/api/realtime-portal/family/invite',
      body: {
        'clientId': clientId,
        'invitedBy': invitedBy,
        'email': email,
        'name': name,
        'relationship': relationship,
        'role': role,
        'permissions': permissions,
      },
    );
  }

  /// Get family members
  Future<Map<String, dynamic>> getFamilyMembers({
    required String clientId,
  }) async {
    return await get(
      '/api/realtime-portal/family/members/$clientId',
    );
  }

  /// Update family permissions
  Future<Map<String, dynamic>> updateFamilyPermissions({
    required String clientId,
    required String memberId,
    required Map<String, dynamic> permissions,
    required String updatedBy,
  }) async {
    return await put(
      '/api/realtime-portal/family/permissions',
      body: {
        'clientId': clientId,
        'memberId': memberId,
        'permissions': permissions,
        'updatedBy': updatedBy,
      },
    );
  }

  /// Get access log
  Future<Map<String, dynamic>> getAccessLog({
    required String clientId,
    int? limit,
    String? startDate,
    String? endDate,
  }) async {
    final queryParams = <String, String>{};
    if (limit != null) queryParams['limit'] = limit.toString();
    if (startDate != null) queryParams['startDate'] = startDate;
    if (endDate != null) queryParams['endDate'] = endDate;

    final query = queryParams.isEmpty
        ? ''
        : '?${queryParams.entries.map((e) => '${e.key}=${e.value}').join('&')}';

    return await get(
      '/api/realtime-portal/family/access-log/$clientId$query',
    );
  }

  // ============================================================================
  // Workforce Optimization API Methods
  // ============================================================================

  // Workforce Planning
  Future<Map<String, dynamic>> forecastDemand(
      Map<String, dynamic> params) async {
    return await post('/api/workforce/planning/forecast', body: params);
  }

  Future<Map<String, dynamic>> optimizeStaffing(
      Map<String, dynamic> params) async {
    return await post('/api/workforce/planning/optimize', body: params);
  }

  Future<Map<String, dynamic>> predictTurnover(
      Map<String, dynamic> params) async {
    return await post('/api/workforce/planning/turnover', body: params);
  }

  Future<Map<String, dynamic>> analyzeScenarios(
      Map<String, dynamic> params) async {
    return await post('/api/workforce/planning/scenarios', body: params);
  }

  // Resource Allocation
  Future<Map<String, dynamic>> optimizeAllocation(
      Map<String, dynamic> params) async {
    return await post('/api/workforce/allocation/optimize', body: params);
  }

  Future<Map<String, dynamic>> reallocateResources(
      Map<String, dynamic> params) async {
    return await post('/api/workforce/allocation/reallocate', body: params);
  }

  Future<Map<String, dynamic>> getAllocationRecommendations({
    required String appointmentId,
    required String organizationId,
  }) async {
    return await get(
        '/api/workforce/allocation/recommendations/$appointmentId?organizationId=$organizationId');
  }

  Future<Map<String, dynamic>> analyzeWorkloadBalance({
    required String organizationId,
    required String startDate,
    required String endDate,
  }) async {
    return await get(
        '/api/workforce/allocation/workload-balance?organizationId=$organizationId&startDate=$startDate&endDate=$endDate');
  }

  // Performance Analytics
  Future<Map<String, dynamic>> getPerformanceAnalytics({
    required String organizationId,
    String? employeeId,
    required String startDate,
    required String endDate,
  }) async {
    String query =
        'organizationId=$organizationId&startDate=$startDate&endDate=$endDate';
    if (employeeId != null) query += '&employeeId=$employeeId';
    return await get('/api/workforce/performance/analytics?$query');
  }

  Future<Map<String, dynamic>> analyzePerformanceTrends({
    required String employeeId,
    required String organizationId,
    String? period,
  }) async {
    String query = 'organizationId=$organizationId';
    if (period != null) query += '&period=$period';
    return await get('/api/workforce/performance/trends/$employeeId?$query');
  }

  Future<Map<String, dynamic>> predictPerformance(
      Map<String, dynamic> params) async {
    return await post('/api/workforce/performance/predict', body: params);
  }

  Future<Map<String, dynamic>> trackSkillProficiency({
    required String employeeId,
    required String organizationId,
  }) async {
    return await get(
        '/api/workforce/performance/skills/$employeeId?organizationId=$organizationId');
  }

  // Quality Assurance
  Future<Map<String, dynamic>> scoreServiceQuality(
      Map<String, dynamic> params) async {
    return await post('/api/workforce/quality/score', body: params);
  }

  Future<Map<String, dynamic>> performComplianceCheck(
      Map<String, dynamic> params) async {
    return await post('/api/workforce/quality/compliance-check', body: params);
  }

  Future<Map<String, dynamic>> analyzeFeedbackSentiment(
      Map<String, dynamic> params) async {
    return await post('/api/workforce/quality/sentiment', body: params);
  }

  Future<Map<String, dynamic>> assessRisk(Map<String, dynamic> params) async {
    return await post('/api/workforce/quality/risk-assessment', body: params);
  }

  Future<Map<String, dynamic>> detectIncidentPatterns({
    required String organizationId,
    required String startDate,
    required String endDate,
  }) async {
    return await get(
        '/api/workforce/quality/incident-patterns?organizationId=$organizationId&startDate=$startDate&endDate=$endDate');
  }

  Future<Map<String, dynamic>> generateAuditTrail({
    required String organizationId,
    required String entityType,
    required String entityId,
    String? startDate,
    String? endDate,
  }) async {
    String query =
        'organizationId=$organizationId&entityType=$entityType&entityId=$entityId';
    if (startDate != null) query += '&startDate=$startDate';
    if (endDate != null) query += '&endDate=$endDate';
    return await get('/api/workforce/quality/audit-trail?$query');
  }

  // Business Intelligence
  Future<Map<String, dynamic>> getExecutiveDashboard({
    required String organizationId,
    String? period,
  }) async {
    String query = 'organizationId=$organizationId';
    if (period != null) query += '&period=$period';
    return await get('/api/workforce/bi/dashboard?$query');
  }

  Future<Map<String, dynamic>> forecastRevenue(
      Map<String, dynamic> params) async {
    return await post('/api/workforce/bi/forecast-revenue', body: params);
  }

  Future<Map<String, dynamic>> predictChurn(Map<String, dynamic> params) async {
    return await post('/api/workforce/bi/predict-churn', body: params);
  }

  Future<Map<String, dynamic>> analyzeProfitability({
    required String organizationId,
    required String dimension,
    required String startDate,
    required String endDate,
  }) async {
    return await get(
        '/api/workforce/bi/profitability?organizationId=$organizationId&dimension=$dimension&startDate=$startDate&endDate=$endDate');
  }

  Future<Map<String, dynamic>> analyzeWhatIfScenario(
      Map<String, dynamic> params) async {
    return await post('/api/workforce/bi/what-if', body: params);
  }

  Future<Map<String, dynamic>> calculateCustomerLifetimeValue({
    required String organizationId,
    String? clientId,
  }) async {
    String query = 'organizationId=$organizationId';
    if (clientId != null) query += '&clientId=$clientId';
    return await get('/api/workforce/bi/customer-lifetime-value?$query');
  }

  // ML Models
  Future<Map<String, dynamic>> trainModel(Map<String, dynamic> params) async {
    return await post('/api/workforce/ml/train', body: params);
  }

  Future<Map<String, dynamic>> evaluateModel(
      Map<String, dynamic> params) async {
    return await post('/api/workforce/ml/evaluate', body: params);
  }

  Future<Map<String, dynamic>> mlPredict(Map<String, dynamic> params) async {
    return await post('/api/workforce/ml/predict', body: params);
  }

  Future<Map<String, dynamic>> batchPredict(Map<String, dynamic> params) async {
    return await post('/api/workforce/ml/batch-predict', body: params);
  }

  Future<Map<String, dynamic>> listMLModels({
    required String organizationId,
  }) async {
    return await get('/api/workforce/ml/models?organizationId=$organizationId');
  }

  Future<Map<String, dynamic>> getMLModelInfo({
    required String modelId,
  }) async {
    return await get('/api/workforce/ml/models/$modelId');
  }

  Future<Map<String, dynamic>> updateMLModel({
    required String modelId,
    required Map<String, dynamic> updates,
  }) async {
    return await put('/api/workforce/ml/models/$modelId', body: updates);
  }

  Future<Map<String, dynamic>> deleteMLModel({
    required String modelId,
  }) async {
    return await delete('/api/workforce/ml/models/$modelId');
  }

  Future<Map<String, dynamic>> engineerFeatures(
      Map<String, dynamic> params) async {
    return await post('/api/workforce/ml/feature-engineering', body: params);
  }

  Future<Map<String, dynamic>> abTestModels(Map<String, dynamic> params) async {
    return await post('/api/workforce/ml/ab-test', body: params);
  }

  Future<Map<String, dynamic>> monitorMLPerformance({
    required String modelId,
    String? timeRange,
  }) async {
    String query = '';
    if (timeRange != null) query = '?timeRange=$timeRange';
    return await get('/api/workforce/ml/monitor/$modelId$query');
  }

  Future<Map<String, dynamic>> exportMLModel({
    required String modelId,
    required String format,
  }) async {
    return await post('/api/workforce/ml/export/$modelId',
        body: {'format': format});
  }

  // ============================================================================
  // Care Intelligence API Methods
  // ============================================================================

  // Care Intelligence
  Future<Map<String, dynamic>> generateIntelligenceReport({
    required String clientId,
    required String organizationId,
  }) async {
    return await post('/api/care-intelligence/intelligence/report/$clientId',
        body: {
          'organizationId': organizationId,
        });
  }

  Future<Map<String, dynamic>> analyzeCarePatterns({
    required String clientId,
    required String organizationId,
    String? startDate,
    String? endDate,
  }) async {
    return await post('/api/care-intelligence/intelligence/patterns/$clientId',
        body: {
          'organizationId': organizationId,
          if (startDate != null) 'startDate': startDate,
          if (endDate != null) 'endDate': endDate,
        });
  }

  Future<Map<String, dynamic>> predictCareNeeds({
    required String clientId,
    required String organizationId,
    int horizon = 30,
  }) async {
    return await post(
        '/api/care-intelligence/intelligence/predict-needs/$clientId',
        body: {
          'organizationId': organizationId,
          'horizon': horizon,
        });
  }

  Future<Map<String, dynamic>> optimizeCareDelivery({
    required String clientId,
    required String organizationId,
  }) async {
    return await post('/api/care-intelligence/intelligence/optimize/$clientId',
        body: {
          'organizationId': organizationId,
        });
  }

  Future<Map<String, dynamic>> generatePersonalizedInsights({
    required String clientId,
    required String organizationId,
  }) async {
    return await get(
        '/api/care-intelligence/intelligence/insights/$clientId?organizationId=$organizationId');
  }

  // Risk Prediction
  Future<Map<String, dynamic>> predictAllRisks({
    required String clientId,
    required String organizationId,
  }) async {
    return await post('/api/care-intelligence/risk/predict-all/$clientId',
        body: {
          'organizationId': organizationId,
        });
  }

  Future<Map<String, dynamic>> predictFallsRisk({
    required String clientId,
    required String organizationId,
  }) async {
    return await post('/api/care-intelligence/risk/falls/$clientId', body: {
      'organizationId': organizationId,
    });
  }

  Future<Map<String, dynamic>> predictBehaviorEscalation({
    required String clientId,
    required String organizationId,
  }) async {
    return await post('/api/care-intelligence/risk/behavior/$clientId', body: {
      'organizationId': organizationId,
    });
  }

  Future<Map<String, dynamic>> predictHealthDeterioration({
    required String clientId,
    required String organizationId,
  }) async {
    return await post('/api/care-intelligence/risk/health/$clientId', body: {
      'organizationId': organizationId,
    });
  }

  Future<Map<String, dynamic>> predictMedicationRisk({
    required String clientId,
    required String organizationId,
  }) async {
    return await post('/api/care-intelligence/risk/medication/$clientId',
        body: {
          'organizationId': organizationId,
        });
  }

  Future<Map<String, dynamic>> analyzeRiskTrends({
    required String clientId,
    required String organizationId,
    String? startDate,
    String? endDate,
  }) async {
    return await post('/api/care-intelligence/risk/trends/$clientId', body: {
      'organizationId': organizationId,
      if (startDate != null) 'startDate': startDate,
      if (endDate != null) 'endDate': endDate,
    });
  }

  // Care Planning
  Future<Map<String, dynamic>> generateCarePlan({
    required String clientId,
    required String organizationId,
    Map<String, dynamic>? preferences,
  }) async {
    return await post('/api/care-intelligence/care-plan/generate', body: {
      'clientId': clientId,
      'organizationId': organizationId,
      if (preferences != null) 'preferences': preferences,
    });
  }

  Future<Map<String, dynamic>> generateSmartGoals({
    required String clientId,
    required String organizationId,
    List<String>? outcomeAreas,
  }) async {
    return await post('/api/care-intelligence/care-plan/goals/$clientId',
        body: {
          'organizationId': organizationId,
          if (outcomeAreas != null) 'outcomeAreas': outcomeAreas,
        });
  }

  Future<Map<String, dynamic>> recommendServices({
    required String clientId,
    required String organizationId,
  }) async {
    return await post('/api/care-intelligence/care-plan/services/$clientId',
        body: {
          'organizationId': organizationId,
        });
  }

  Future<Map<String, dynamic>> adaptCarePlan({
    required String planId,
    required String organizationId,
    required Map<String, dynamic> progressData,
  }) async {
    return await put('/api/care-intelligence/care-plan/adapt/$planId', body: {
      'organizationId': organizationId,
      'progressData': progressData,
    });
  }

  Future<Map<String, dynamic>> trackGoalProgress({
    required String goalId,
    required String organizationId,
    required Map<String, dynamic> progressUpdate,
  }) async {
    return await post('/api/care-intelligence/care-plan/progress/$goalId',
        body: {
          'organizationId': organizationId,
          'progressUpdate': progressUpdate,
        });
  }

  Future<Map<String, dynamic>> generateEvidenceBasedRecommendations({
    required String clientId,
    required String organizationId,
    String? condition,
  }) async {
    return await post('/api/care-intelligence/care-plan/evidence-based', body: {
      'clientId': clientId,
      'organizationId': organizationId,
      if (condition != null) 'condition': condition,
    });
  }

  // Incident Management
  Future<Map<String, dynamic>> reportIncident({
    required String clientId,
    required String organizationId,
    required Map<String, dynamic> incidentData,
  }) async {
    return await post('/api/care-intelligence/incident/report', body: {
      'clientId': clientId,
      'organizationId': organizationId,
      ...incidentData,
    });
  }

  Future<Map<String, dynamic>> analyzeRootCause({
    required String incidentId,
    required String organizationId,
  }) async {
    return await post('/api/care-intelligence/incident/root-cause/$incidentId',
        body: {
          'organizationId': organizationId,
        });
  }

  Future<Map<String, dynamic>> detectCareIncidentPatterns({
    required String organizationId,
    String? startDate,
    String? endDate,
  }) async {
    return await post(
        '/api/care-intelligence/incident/patterns/$organizationId',
        body: {
          if (startDate != null) 'startDate': startDate,
          if (endDate != null) 'endDate': endDate,
        });
  }

  Future<Map<String, dynamic>> predictIncidentRecurrence({
    required String incidentId,
    required String organizationId,
  }) async {
    return await post(
        '/api/care-intelligence/incident/predict-recurrence/$incidentId',
        body: {
          'organizationId': organizationId,
        });
  }

  Future<Map<String, dynamic>> generateCorrectiveActions({
    required String incidentId,
    required String organizationId,
  }) async {
    return await post(
        '/api/care-intelligence/incident/corrective-actions/$incidentId',
        body: {
          'organizationId': organizationId,
        });
  }

  // Medication Management
  Future<Map<String, dynamic>> checkMedicationInteractions({
    required String clientId,
    required String organizationId,
    required List<String> medications,
  }) async {
    return await post('/api/care-intelligence/medication/check-interactions',
        body: {
          'clientId': clientId,
          'organizationId': organizationId,
          'medications': medications,
        });
  }

  Future<Map<String, dynamic>> trackMedicationCompliance({
    required String clientId,
    required String organizationId,
    String? startDate,
    String? endDate,
  }) async {
    return await post('/api/care-intelligence/medication/compliance/$clientId',
        body: {
          'organizationId': organizationId,
          if (startDate != null) 'startDate': startDate,
          if (endDate != null) 'endDate': endDate,
        });
  }

  Future<Map<String, dynamic>> getMedicationAlerts({
    required String clientId,
    required String organizationId,
  }) async {
    return await get(
        '/api/care-intelligence/medication/alerts/$clientId?organizationId=$organizationId');
  }

  Future<Map<String, dynamic>> optimizeMedicationSchedule({
    required String clientId,
    required String organizationId,
  }) async {
    return await post(
        '/api/care-intelligence/medication/optimize-schedule/$clientId',
        body: {
          'organizationId': organizationId,
        });
  }

  Future<Map<String, dynamic>> monitorMedicationSideEffects({
    required String clientId,
    required String organizationId,
    required Map<String, dynamic> sideEffectData,
  }) async {
    return await post(
        '/api/care-intelligence/medication/side-effects/$clientId',
        body: {
          'organizationId': organizationId,
          ...sideEffectData,
        });
  }

  // ============================================================================
  // Phase 10 - Advanced Financial Intelligence & Predictive Revenue System
  // API Methods (50+ endpoints)
  // ============================================================================

  // Revenue Forecasting (7 methods)
  Future<Map<String, dynamic>> generateRevenueForecast(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/revenue/forecast',
        body: data);
  }

  Future<Map<String, dynamic>> analyzeRevenueDrivers(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/revenue/drivers',
        body: data);
  }

  Future<Map<String, dynamic>> generateRevenueScenarios(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/revenue/scenarios',
        body: data);
  }

  Future<Map<String, dynamic>> performWhatIfAnalysis(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/revenue/what-if',
        body: data);
  }

  Future<Map<String, dynamic>> getRevenueTrends(String organizationId,
      {int? period}) async {
    final query = period != null ? '?period=$period' : '';
    return await get(
        '/api/financial-intelligence/revenue/trends/$organizationId$query');
  }

  Future<Map<String, dynamic>> getForecastAccuracy(String forecastId) async {
    return await get(
        '/api/financial-intelligence/revenue/confidence/$forecastId');
  }

  Future<Map<String, dynamic>> updateRevenueModels(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/revenue/update-model',
        body: data);
  }

  // Pricing Optimization (7 methods)
  Future<Map<String, dynamic>> optimizePrices(Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/pricing/optimize',
        body: data);
  }

  Future<Map<String, dynamic>> setupPricingABTest(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/pricing/test', body: data);
  }

  Future<Map<String, dynamic>> getPricingRecommendations(
      String serviceId, Map<String, dynamic> data) async {
    return await post(
        '/api/financial-intelligence/pricing/recommendations/$serviceId',
        body: data);
  }

  Future<Map<String, dynamic>> analyzeMargins(Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/pricing/margin-analysis',
        body: data);
  }

  Future<Map<String, dynamic>> analyzeCompetitorPricing(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/pricing/competitor-analysis',
        body: data);
  }

  Future<Map<String, dynamic>> calculatePriceElasticity(
      String serviceId, Map<String, dynamic> data) async {
    return await post(
        '/api/financial-intelligence/pricing/elasticity/$serviceId',
        body: data);
  }

  Future<Map<String, dynamic>> optimizeBundlePricing(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/pricing/bundle-optimization',
        body: data);
  }

  // Billing Automation (8 methods)
  Future<Map<String, dynamic>> generateInvoices(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/billing/generate',
        body: data);
  }

  Future<Map<String, dynamic>> validateBilling(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/billing/validate',
        body: data);
  }

  Future<Map<String, dynamic>> detectBillingAnomalies(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/billing/anomaly-detection',
        body: data);
  }

  Future<Map<String, dynamic>> approveInvoices(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/billing/approve',
        body: data);
  }

  Future<Map<String, dynamic>> generateCreditNote(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/billing/credit-note',
        body: data);
  }

  Future<Map<String, dynamic>> getPendingInvoices(String organizationId,
      {Map<String, dynamic>? filters}) async {
    String query = '';
    if (filters != null && filters.isNotEmpty) {
      query = '?' + filters.entries.map((e) => '${e.key}=${e.value}').join('&');
    }
    return await get(
        '/api/financial-intelligence/billing/pending/$organizationId$query');
  }

  Future<Map<String, dynamic>> batchProcessInvoices(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/billing/batch-process',
        body: data);
  }

  Future<Map<String, dynamic>> reconcileInvoices(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/billing/reconcile',
        body: data);
  }

  // Cash Flow Management (7 methods)
  Future<Map<String, dynamic>> forecastCashFlow(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/cashflow/forecast',
        body: data);
  }

  Future<Map<String, dynamic>> predictPayments(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/cashflow/payment-prediction',
        body: data);
  }

  Future<Map<String, dynamic>> optimizeCash(Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/cashflow/optimize',
        body: data);
  }

  Future<Map<String, dynamic>> getCurrentCashPosition(
      String organizationId) async {
    return await get(
        '/api/financial-intelligence/cashflow/position/$organizationId');
  }

  Future<Map<String, dynamic>> generateCashFlowScenario(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/cashflow/scenario',
        body: data);
  }

  Future<Map<String, dynamic>> getCashFlowAlerts(String organizationId) async {
    return await get(
        '/api/financial-intelligence/cashflow/alerts/$organizationId');
  }

  Future<Map<String, dynamic>> getCashFlowRecommendations(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/cashflow/recommendations',
        body: data);
  }

  // Financial Analytics (6 methods)
  Future<Map<String, dynamic>> getFinancialDashboard(String organizationId,
      {String? period}) async {
    final query = period != null ? '?period=$period' : '';
    return await get(
        '/api/financial-intelligence/analytics/dashboard/$organizationId$query');
  }

  Future<Map<String, dynamic>> analyzeFinancialProfitability(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/analytics/profitability',
        body: data);
  }

  Future<Map<String, dynamic>> analyzeFinancialVariance(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/analytics/variance',
        body: data);
  }

  Future<Map<String, dynamic>> getFinancialKPIs(String organizationId) async {
    return await get(
        '/api/financial-intelligence/analytics/kpis/$organizationId');
  }

  Future<Map<String, dynamic>> analyzeFinancialTrends(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/analytics/trends',
        body: data);
  }

  Future<Map<String, dynamic>> drillDownAnalysis(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/analytics/drill-down',
        body: data);
  }

  // Budget Management (6 methods)
  Future<Map<String, dynamic>> createBudget(Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/budget/create', body: data);
  }

  Future<Map<String, dynamic>> monitorBudget(Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/budget/monitor', body: data);
  }

  Future<Map<String, dynamic>> analyzeBudgetVariance(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/budget/variance',
        body: data);
  }

  Future<Map<String, dynamic>> generateRollingForecast(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/budget/forecast',
        body: data);
  }

  Future<Map<String, dynamic>> optimizeBudgetAllocation(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/budget/optimize',
        body: data);
  }

  Future<Map<String, dynamic>> getBudgetStatus(String organizationId) async {
    return await get(
        '/api/financial-intelligence/budget/status/$organizationId');
  }

  // Payment Processing (5 methods)
  Future<Map<String, dynamic>> processPayment(Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/payment/process',
        body: data);
  }

  Future<Map<String, dynamic>> reconcilePayments(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/payment/reconcile',
        body: data);
  }

  Future<Map<String, dynamic>> optimizePaymentRouting(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/payment/optimize-routing',
        body: data);
  }

  Future<Map<String, dynamic>> getPaymentAnalytics(String organizationId,
      {String? period}) async {
    final query = period != null ? '?period=$period' : '';
    return await get(
        '/api/financial-intelligence/payment/analytics/$organizationId$query');
  }

  Future<Map<String, dynamic>> checkPaymentFraud(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/payment/fraud-check',
        body: data);
  }

  // Compliance & Audit (3 methods)
  Future<Map<String, dynamic>> checkFinancialCompliance(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/compliance/check',
        body: data);
  }

  Future<Map<String, dynamic>> generateFinancialAuditTrail(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/compliance/audit-trail',
        body: data);
  }

  Future<Map<String, dynamic>> getComplianceStatus(
      String organizationId) async {
    return await get(
        '/api/financial-intelligence/compliance/status/$organizationId');
  }

  // Client Financial Management (3 methods)
  Future<Map<String, dynamic>> manageCreditLimit(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/client/credit-limit',
        body: data);
  }

  Future<Map<String, dynamic>> calculateLifetimeValue(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/client/lifetime-value',
        body: data);
  }

  Future<Map<String, dynamic>> assessFinancialHealth(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/client/financial-health',
        body: data);
  }

  // Financial Reporting (3 methods)
  Future<Map<String, dynamic>> generateExecutiveReport(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/reporting/executive',
        body: data);
  }

  Future<Map<String, dynamic>> buildCustomReport(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/reporting/custom',
        body: data);
  }

  Future<Map<String, dynamic>> generateRegulatoryReport(
      Map<String, dynamic> data) async {
    return await post('/api/financial-intelligence/reporting/regulatory',
        body: data);
  }
}
