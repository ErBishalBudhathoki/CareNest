import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'dart:io';

import 'package:carenest/app/core/utils/Services/upload_notes.dart';
import 'package:carenest/config/environment.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/shared/utils/encryption/encrypt_decrypt.dart';
import 'package:carenest/app/shared/utils/encryption/encryption_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  Future<Map<String, dynamic>> getQuarterlyOTE(String userEmail, {String? date}) async {
    try {
      final endpoint = 'api/earnings/quarterly-ote/$userEmail${date != null ? '?date=$date' : ''}';
      final response = await get(endpoint);
      return response;
    } catch (e) {
      debugPrint('Error getting quarterly OTE: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getLeaveForecast(String userEmail, DateTime targetDate) async {
    final dateStr = targetDate.toIso8601String().split('T')[0];
    final endpoint = 'api/requests/forecast/$userEmail?targetDate=$dateStr'; // Adjusted to match backend route
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

      // Attach Authorization header if token exists
      final sharedUtils = SharedPreferencesUtils();
      await sharedUtils.init();
      final token = sharedUtils.getAuthToken();
      final hasToken = token != null && token.isNotEmpty;
      final tokenHasBearerPrefix =
          hasToken && token.toLowerCase().startsWith('bearer ');
      debugPrint(
          '=== API METHOD DEBUG: Auth header present: $hasToken, tokenHasBearerPrefix: $tokenHasBearerPrefix ===');
      final String? authValue = hasToken
          ? (token.toLowerCase().startsWith('bearer ')
              ? token
              : 'Bearer $token')
          : null;
      final headers = {
        'Content-Type': 'application/json',
        if (authValue != null) 'Authorization': authValue,
      };

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

      debugPrint(
          '=== API METHOD DEBUG: Request headers set (Authorization present: ${authValue != null}) ===');
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
      
      debugPrint('=== API METHOD DEBUG: POST MULTIPART request to: $fullUrl ===');

      final sharedUtils = SharedPreferencesUtils();
      await sharedUtils.init();
      final token = sharedUtils.getAuthToken();
      final String? authValue = (token != null && token.isNotEmpty)
          ? (token.toLowerCase().startsWith('bearer ') ? token : 'Bearer $token')
          : null;

      final request = http.MultipartRequest('POST', Uri.parse(fullUrl));
      
      if (authValue != null) {
        request.headers['Authorization'] = authValue;
      }
      
      if (fields != null) {
        request.fields.addAll(fields);
      }
      
      if (files != null) {
        request.files.addAll(files);
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      
      debugPrint('=== API METHOD DEBUG: Response status code: ${response.statusCode} ===');
      
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
    final req = http.Request('GET', uri);
    req.headers.addAll(combinedHeaders);
    return client.send(req);
  }

  Future<String> uploadFile(String endpoint, File file, {String fieldName = 'file'}) async {
    final uri = _buildUri(endpoint);
    final request = http.MultipartRequest('POST', uri);
    final authValue = await _getAuthorizationHeaderValue();
    if (authValue != null) {
      request.headers['Authorization'] = authValue;
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
      throw Exception((decoded['message'] ?? 'Upload failed: No URL returned').toString());
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
         if (response['data'] is Map && response['data'].containsKey('members')) {
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

  Future<Map<String, dynamic>> sendOTP(
      String email, String encryptionKey) async {
    final response = await http.post(
      Uri.parse('${_baseUrl}sendOTP'),
      body: jsonEncode({'email': email, 'clientEncryptionKey': encryptionKey}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to send OTP');
    }

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
    // debugPrint('${_baseUrl}login/$email/$password');

    try {
      EncryptionUtils encryptionUtils = EncryptionUtils();
      final getSaltResponse = await getSalt(email);
      debugPrint("inside login: $getSaltResponse");
      debugPrint("getSaltResponse: $getSaltResponse.body");

      // Check if there's an error in getSalt response
      if (getSaltResponse.containsKey('error')) {
        debugPrint("Error getting salt: ${getSaltResponse['error']}");
        return {
          'message': getSaltResponse['error'],
          'errorCode': getSaltResponse['errorCode'] ?? 'UNKNOWN_ERROR',
          'statusCode': getSaltResponse['statusCode'] ?? 500,
        };
      }

      final salt = getSaltResponse['salt'];

      // Check if salt is null or empty
      if (salt == null || salt.toString().isEmpty) {
        debugPrint(
            "Error: Salt is null or empty. User may not exist or there's a backend issue.");
        return {
          'message': 'User not found',
          'errorCode': 'USER_NOT_FOUND',
          'statusCode': 404,
        };
      }

      final Uint8List originalSalt = encryptionUtils.hexStringToUint8List(salt);
      debugPrint("Salty: $salt");

      var hashedPasswordWithSalt = encryptionUtils
          .encryptPasswordWithArgon2andSalt(password, originalSalt);
      debugPrint("Hashed password with salt: $hashedPasswordWithSalt");
      final response = await http.post(
        Uri.parse('${_baseUrl}login'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'email': email, 'password': hashedPasswordWithSalt},
      );

      debugPrint("Resp: ${response.statusCode}");

      Map<String, dynamic> data = {};

      switch (response.statusCode) {
        case 200:
          data = Map<String, dynamic>.from(json.decode(response.body));
          if (kDebugMode) {
            debugPrint("200" + data['message']);
          }
          // Retrieve the user's role from the response and assign it to a variable
          // The role is inside the 'user' object in the response
          String role = data['user']['role'];
          UserRole roleEnum;
          // Convert the string role to the UserRole enum
          if (role == 'admin') {
            roleEnum = UserRole.admin;
          } else {
            roleEnum = UserRole.normal;
          }
          debugPrint("Role enum: $roleEnum $role");
          // Save user email and organization ID to SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('userEmail', email);
          if (data['user']['organizationId'] != null) {
            await prefs.setString(
                'organizationId', data['user']['organizationId']);
          }
          return {
            'message': 'user found',
            'role': role,
            'user': data['user'], // Include full user data
          };

        case 400:
          data = Map<String, dynamic>.from(json.decode(response.body));
          if (kDebugMode) {
            debugPrint("400" + data['message']);
          }
          return {
            'message': data['message'] ?? 'Invalid credentials',
            'errorCode': data['errorCode'],
            'statusCode': 400,
          };

        case 401:
          data = Map<String, dynamic>.from(json.decode(response.body));
          debugPrint("401: Unauthorized - ${data['message']}");
          return {
            'message': data['message'] ?? 'Invalid credentials',
            'errorCode': data['errorCode'],
            'statusCode': 401,
          };

        case 423:
          data = Map<String, dynamic>.from(json.decode(response.body));
          debugPrint("423: Account locked - ${data['message']}");
          return {
            'message': data['message'] ?? 'Account temporarily locked',
            'errorCode': data['errorCode'] ?? 'ACCOUNT_LOCKED',
            'statusCode': 423,
          };

        case 429:
          data = Map<String, dynamic>.from(json.decode(response.body));
          debugPrint("429: Rate limit exceeded - ${data['message']}");
          return {
            'message': data['message'] ?? 'Too many login attempts',
            'errorCode': data['errorCode'] ?? 'RATE_LIMIT_EXCEEDED',
            'statusCode': 429,
          };

        case 500:
          data = Map<String, dynamic>.from(json.decode(response.body));
          debugPrint("500: Server error - ${data['message']}");
          return {
            'message': data['message'] ?? 'Server error occurred',
            'errorCode': data['errorCode'] ?? 'SERVER_ERROR',
            'statusCode': 500,
          };

        default:
          debugPrint("Unexpected status code: ${response.statusCode}");
          return {
            'message': 'Unknown error occurred',
            'errorCode': 'UNKNOWN_ERROR',
            'statusCode': response.statusCode,
          };
      }
    } catch (e) {
      // Handle any exception that occurs during the login process
      debugPrint("Exception api method: $e");
      return {
        'message': 'An error occurred during login',
      };
    }
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
      final String password = loginData['password'];

      // Step 1: Get salt for the user (critical step from original login)
      EncryptionUtils encryptionUtils = EncryptionUtils();
      final getSaltResponse = await getSalt(email);
      debugPrint("secureLogin getSalt response: $getSaltResponse");

      // Check if there's an error in getSalt response
      if (getSaltResponse.containsKey('error')) {
        debugPrint(
            "Error getting salt in secureLogin: ${getSaltResponse['error']}");
        return {
          'success': false,
          'message': getSaltResponse['error'],
          'errorCode': getSaltResponse['errorCode'] ?? 'UNKNOWN_ERROR',
          'statusCode': getSaltResponse['statusCode'] ?? 500,
        };
      }

      final salt = getSaltResponse['salt'];

      // Check if salt is null or empty
      if (salt == null || salt.toString().isEmpty) {
        debugPrint(
            "Error: Salt is null or empty in secureLogin. User may not exist.");
        return {
          'success': false,
          'message': 'User not found',
          'errorCode': 'USER_NOT_FOUND',
          'statusCode': 404,
        };
      }

      // Step 2: Hash password with salt using Argon2 (critical step from original login)
      final Uint8List originalSalt = encryptionUtils.hexStringToUint8List(salt);
      debugPrint("secureLogin salt: $salt");

      var hashedPasswordWithSalt = encryptionUtils
          .encryptPasswordWithArgon2andSalt(password, originalSalt);
      debugPrint(
          "secureLogin hashed password with salt: $hashedPasswordWithSalt");

      // Step 3: Prepare enhanced login data with hashed password
      final enhancedLoginData = Map<String, dynamic>.from(loginData);
      enhancedLoginData['password'] =
          hashedPasswordWithSalt; // Replace plain password with hashed

      // Step 4: Make secure login request
      final response = await http.post(
        Uri.parse('${_baseUrl}login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(enhancedLoginData),
      );

      debugPrint("secureLogin response status: ${response.statusCode}");

      // Step 5: Handle response with proper status code mapping (from original login)
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
        headers: {'Content-Type': 'application/json'},
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
}
