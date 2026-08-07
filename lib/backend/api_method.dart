import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'dart:io';

import 'package:carenest/app/core/utils/Services/upload_notes.dart';
import 'package:carenest/config/environment.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/shared/utils/encryption/encrypt_decrypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carenest/app/core/services/timer_service.dart';

import 'package:carenest/app/features/auth/models/user_model.dart' as app;
import 'package:carenest/app/features/client/models/client_model.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/shared/utils/debug_log.dart';

class ApiMethod extends ChangeNotifier {
  static bool _hasLoggedUnsupportedAppCheck = false;
  static bool _hasLoggedFirebaseTokenUsage = false;
  static bool _hasLoggedCustomTokenUsage = false;
  static const Duration _fallbackBaseRateCacheTtl = Duration(minutes: 10);
  static final Map<String, double?> _fallbackBaseRateCache =
      <String, double?>{};
  static final Map<String, DateTime> _fallbackBaseRateCacheTimestamps =
      <String, DateTime>{};
  static final Map<String, Future<double?>> _fallbackBaseRateInFlight =
      <String, Future<double?>>{};

  static bool _isFallbackBaseRateCacheFresh(String organizationId) {
    final fetchedAt = _fallbackBaseRateCacheTimestamps[organizationId];
    if (fetchedAt == null) return false;
    return DateTime.now().difference(fetchedAt) <= _fallbackBaseRateCacheTtl;
  }

  static void _cacheFallbackBaseRate(String organizationId, double? value) {
    _fallbackBaseRateCache[organizationId] = value;
    _fallbackBaseRateCacheTimestamps[organizationId] = DateTime.now();
  }

  /// Get Quarterly OTE for a user (for Superannuation Cap calculation)
  Future<Map<String, dynamic>> getQuarterlyOTE(
    String userEmail, {
    String? date,
  }) async {
    try {
      final endpoint =
          'earnings/quarterly-ote/$userEmail${date != null ? '?date=$date' : ''}';
      final response = await get(endpoint);
      return response;
    } catch (e) {
      debugPrint('Error getting quarterly OTE: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getLeaveForecast(
    String userEmail,
    DateTime targetDate,
  ) async {
    final dateStr = targetDate.toIso8601String().split('T')[0];
    final endpoint = 'requests/forecast/$userEmail?targetDate=$dateStr';
    return await get(endpoint);
  }

  Future<Map<String, dynamic>> getLeaveBalances(String userEmail) async {
    final endpoint = 'leave/balances/$userEmail';
    return await get(endpoint);
  }

  Future<Map<String, dynamic>> getUserLeaveRequests(String userEmail) async {
    final endpoint = 'leave/requests/$userEmail';
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
    final endpoint = 'requests';
    final body = {
      'userEmail': userEmail,
      'type': 'TimeOff',
      'details': {
        'leaveType': leaveType,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'reason': reason,
        'totalHours': totalHours,
      },
    };
    return await post(endpoint, body: body);
  }

  Future<Map<String, dynamic>> updateLeaveRequestStatus({
    required String requestId,
    required String status,
    String? adminNotes,
  }) async {
    final endpoint = 'requests/$requestId/status';
    final body = {'status': status, 'adminNotes': ?adminNotes};
    return await put(endpoint, body: body);
  }

  Future<Map<String, dynamic>> calculateLeaveHours({
    required String startDate,
    required String endDate,
    String? organizationId,
    double dailyHours = 7.6,
  }) async {
    final endpoint = 'requests/calculate-hours';
    final body = {
      'startDate': startDate,
      'endDate': endDate,
      'organizationId': ?organizationId,
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
        'requests/organization/$organizationId?userId=$userEmail&type=TimeOff';
    return await get(endpoint);
  }

  // HTTP Methods for RESTful API calls
  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    try {
      final uri = _buildUri(endpoint);
      final fullUrl = uri.toString();

      // Debug: request construction
      debugPrint('=== API METHOD DEBUG: GET request to: $fullUrl ===');
      debugPrint('=== API METHOD DEBUG: Base URL is: $_baseUrl ===');
      debugPrint('=== API METHOD DEBUG: Endpoint is: $endpoint ===');

      final authValue = await _getAuthorizationHeaderValue();
      final hasToken = authValue != null;
      final tokenHasBearerPrefix =
          hasToken && authValue.toLowerCase().startsWith('bearer ');
      debugPrint(
        '=== API METHOD DEBUG: Auth header present: $hasToken, tokenHasBearerPrefix: $tokenHasBearerPrefix ===',
      );
      final requestHeaders = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
        extra: headers,
      );

      final response = await http.get(uri, headers: requestHeaders);
      debugPrint(
        '=== API METHOD DEBUG: GET status: ${response.statusCode} ===',
      );

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
    if (_isFallbackBaseRateCacheFresh(organizationId)) {
      return _fallbackBaseRateCache[organizationId];
    }

    final inFlightRequest = _fallbackBaseRateInFlight[organizationId];
    if (inFlightRequest != null) {
      return await inFlightRequest;
    }

    final request = _fetchFallbackBaseRate(organizationId);
    _fallbackBaseRateInFlight[organizationId] = request;

    try {
      return await request;
    } finally {
      _fallbackBaseRateInFlight.remove(organizationId);
    }
  }

  Future<double?> _fetchFallbackBaseRate(String organizationId) async {
    final staleCachedRate = _fallbackBaseRateCache[organizationId];
    try {
      final url = '${_baseUrl}pricing/fallback-base-rate/$organizationId';
      final sw = Stopwatch()..start();
      DebugLog.networkRequest(
        'GET',
        url,
        payload: {'organizationId': organizationId},
      );
      final headers = await _buildProtectedJsonHeaders();
      if (headers == null) {
        debugPrint(
          'Skipping fallback base rate request: authorization header missing',
        );
        return staleCachedRate;
      }
      final response = await http.get(Uri.parse(url), headers: headers);
      sw.stop();
      dynamic body;
      try {
        body = response.body.isNotEmpty ? json.decode(response.body) : null;
      } catch (_) {
        body = {'raw': response.body};
      }
      DebugLog.networkResponse(
        url,
        response.statusCode,
        body: body,
        durationMs: sw.elapsedMilliseconds,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['statusCode'] == 200 && data['data'] != null) {
          final rate = data['data']['fallbackBaseRate'];
          if (rate is num) {
            final normalized = rate.toDouble();
            _cacheFallbackBaseRate(organizationId, normalized);
            return normalized;
          }
        }
        _cacheFallbackBaseRate(organizationId, null);
        return null;
      }

      if (response.statusCode == 429) {
        // Preserve last known value under read-limit pressure.
        if (staleCachedRate != null) {
          return staleCachedRate;
        }
      }

      final settingsRate = await _getFallbackBaseRateFromSettings(
        organizationId,
        headers,
      );
      if (settingsRate != null) {
        _cacheFallbackBaseRate(organizationId, settingsRate);
        return settingsRate;
      }

      return staleCachedRate;
    } catch (e) {
      debugPrint('Exception getting fallback base rate: $e');
      DebugLog.error(
        'Exception getting fallback base rate',
        details: {'organizationId': organizationId, 'error': e.toString()},
      );
      return staleCachedRate;
    }
  }

  Future<double?> _getFallbackBaseRateFromSettings(
    String organizationId,
    Map<String, String> headers,
  ) async {
    try {
      final url = '${_baseUrl}settings/general?organizationId=$organizationId';
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode != 200) return null;

      final decoded = json.decode(response.body);
      if (decoded is! Map<String, dynamic>) return null;
      final data = decoded['data'];
      if (data is! Map<String, dynamic>) return null;

      final value = data['fallbackBaseRate'];
      return value is num ? value.toDouble() : null;
    } catch (_) {
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
    String organizationId,
    double fallbackBaseRate,
    String userEmail,
  ) async {
    try {
      final url = '${_baseUrl}pricing/fallback-base-rate/$organizationId';
      final payload = {
        'fallbackBaseRate': fallbackBaseRate,
        'userEmail': userEmail,
      };
      final headers = await _buildProtectedJsonHeaders();
      if (headers == null) {
        return {
          'success': false,
          'message': 'Authentication required. Please log in again.',
        };
      }
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
        responseBody = response.body.isNotEmpty
            ? json.decode(response.body)
            : {};
      } catch (_) {
        responseBody = {'raw': response.body};
      }
      DebugLog.networkResponse(
        url,
        response.statusCode,
        body: responseBody,
        durationMs: sw.elapsedMilliseconds,
      );

      if (response.statusCode == 200) {
        final responseData = responseBody['data'];
        final fallbackRateFromResponse =
            responseData is Map && responseData['fallbackBaseRate'] is num
            ? (responseData['fallbackBaseRate'] as num).toDouble()
            : fallbackBaseRate;
        _cacheFallbackBaseRate(organizationId, fallbackRateFromResponse);
        return {
          'success': true,
          'message': responseBody['message'] ?? 'Fallback base rate updated',
          'data': responseData,
          'fallbackBaseRate': fallbackRateFromResponse,
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
      DebugLog.error(
        'Exception setting fallback base rate',
        details: {
          'organizationId': organizationId,
          'fallbackBaseRate': fallbackBaseRate,
          'userEmail': userEmail,
          'error': e.toString(),
        },
      );
      return {
        'success': false,
        'message': 'Error updating fallback base rate: $e',
      };
    }
  }

  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = _buildUri(endpoint);
      final fullUrl = uri.toString();
      debugPrint('🚀🚀🚀 CRITICAL DEBUG: POST request to: $fullUrl 🚀🚀🚀');
      debugPrint('🚀🚀🚀 CRITICAL DEBUG: Base URL is: $_baseUrl 🚀🚀🚀');
      debugPrint('🚀🚀🚀 CRITICAL DEBUG: Endpoint is: $endpoint 🚀🚀🚀');

      final requestHeaders = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
        extra: headers,
      );

      debugPrint(
        '=== API METHOD DEBUG: Request headers set (Authorization present: ${requestHeaders.containsKey('Authorization')}) ===',
      );
      if (body != null) {
        debugPrint(
          '=== API METHOD DEBUG: Request body: ${json.encode(body)} ===',
        );
      }

      final response = await http.post(
        uri,
        headers: requestHeaders,
        body: body != null ? json.encode(body) : null,
      );

      debugPrint(
        '=== API METHOD DEBUG: Response status code: ${response.statusCode} ===',
      );
      debugPrint(
        '=== API METHOD DEBUG: Response headers: ${response.headers} ===',
      );
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
      final uri = _buildUri(endpoint);
      final fullUrl = uri.toString();

      debugPrint(
        '=== API METHOD DEBUG: POST MULTIPART request to: $fullUrl ===',
      );

      final sharedUtils = SharedPreferencesUtils();
      await sharedUtils.init();
      final authValue = await _getAuthorizationHeaderValue();
      final appCheckToken = await _getAppCheckToken();

      final request = http.MultipartRequest('POST', uri);

      if (authValue != null) {
        request.headers['Authorization'] = authValue;
      }
      if (appCheckToken != null && appCheckToken.isNotEmpty) {
        request.headers['X-Firebase-AppCheck'] = appCheckToken;
      }
      if (!kIsWeb && Platform.isIOS) {
        request.headers['X-Platform'] = 'ios';
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
        '=== API METHOD DEBUG: Response status code: ${response.statusCode} ===',
      );

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
      final url = '${_baseUrl}settings/general';
      final headers = await _buildProtectedJsonHeaders();
      if (headers == null) {
        return {
          'success': false,
          'message': 'Authentication required. Please log in again.',
        };
      }

      final payload = {'organizationId': organizationId, ...settings};

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
        responseBody = response.body.isNotEmpty
            ? json.decode(response.body)
            : {};
      } catch (_) {
        responseBody = {'raw': response.body};
      }
      DebugLog.networkResponse(
        url,
        response.statusCode,
        body: responseBody,
        durationMs: sw.elapsedMilliseconds,
      );

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
      DebugLog.error(
        'Exception updating general settings',
        details: {'organizationId': organizationId, 'error': e.toString()},
      );
      return {'success': false, 'message': 'Error updating settings: $e'};
    }
  }

  Future<Map<String, dynamic>> put(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final uri = _buildUri(endpoint);
      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );

      final response = await http.put(
        uri,
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
      final uri = _buildUri(endpoint);
      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );

      final response = await http.delete(uri, headers: headers);

      return _handleResponse(response);
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        return {'success': true, 'statusCode': response.statusCode};
      }

      final dynamic decoded = json.decode(response.body);
      if (decoded is Map<String, dynamic>) {
        decoded['success'] = true;
        decoded['statusCode'] ??= response.statusCode;
        return decoded;
      } else {
        return {
          'success': true,
          'statusCode': response.statusCode,
          'data': decoded,
        };
      }
    } else {
      try {
        final Map<String, dynamic> errorData = json.decode(response.body);
        errorData['success'] = false;
        errorData['statusCode'] ??= response.statusCode;
        return errorData;
      } catch (e) {
        return {
          'success': false,
          'statusCode': response.statusCode,
          'message': 'Request failed with status: ${response.statusCode}',
        };
      }
    }
  }

  //API to authenticate user login
  String get _baseUrl => AppConfig.baseUrl;

  // Public getter for baseUrl for debugging purposes
  String get baseUrl => _baseUrl;

  String _normalizeEndpointForBase(String endpointOrPath) {
    final trimmed = endpointOrPath.trim();
    final cleanEndpoint = trimmed.startsWith('/')
        ? trimmed.substring(1)
        : trimmed;

    if (cleanEndpoint.isEmpty) return cleanEndpoint;

    final basePath = Uri.parse(_baseUrl).path;
    final baseEndsWithApi =
        basePath.endsWith('/api') || basePath.endsWith('/api/');

    // Prevent duplicated /api/api/... when callers pass "api/..." while
    // baseUrl already ends with "/api/".
    if (baseEndsWithApi &&
        (cleanEndpoint == 'api' || cleanEndpoint.startsWith('api/'))) {
      var normalized = cleanEndpoint;
      while (normalized.startsWith('api/')) {
        normalized = normalized.substring(4);
      }
      if (normalized == 'api') {
        return '';
      }
      return normalized;
    }

    return cleanEndpoint;
  }

  Uri _buildUri(String endpointOrPath) {
    final cleanEndpoint = _normalizeEndpointForBase(endpointOrPath);
    final baseNoTrailing = _baseUrl.replaceAll(RegExp(r'/+$'), '');
    if (cleanEndpoint.isEmpty) {
      return Uri.parse(baseNoTrailing);
    }
    return Uri.parse('$baseNoTrailing/$cleanEndpoint');
  }

  bool _isSameOrigin(Uri a, Uri b) {
    return a.scheme == b.scheme && a.host == b.host && a.port == b.port;
  }

  Future<String?> _getAuthorizationHeaderValue({
    bool forceRefresh = false,
  }) async {
    // Try to get Firebase ID token first (new auth system)
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final idToken = await user.getIdToken(forceRefresh);
        if (idToken != null && idToken.isNotEmpty) {
          if (!_hasLoggedFirebaseTokenUsage) {
            debugPrint('✅ Using Firebase ID token for authorization');
            _hasLoggedFirebaseTokenUsage = true;
          }
          return 'Bearer $idToken';
        }
      }
    } catch (e) {
      debugPrint('⚠️ Failed to get Firebase ID token: $e');
    }

    // Fallback to custom JWT token (for backward compatibility during migration)
    final sharedUtils = SharedPreferencesUtils();
    await sharedUtils.init();
    final token = sharedUtils.getAuthToken();
    if (token == null || token.isEmpty) {
      debugPrint('⚠️ No auth token available');
      return null;
    }
    if (token.toLowerCase().startsWith('bearer ')) return token;
    if (!_hasLoggedCustomTokenUsage) {
      debugPrint('✅ Using custom JWT token for authorization');
      _hasLoggedCustomTokenUsage = true;
    }
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
      final errorText = e.toString();
      if (errorText.contains('code-unsupported')) {
        if (!_hasLoggedUnsupportedAppCheck) {
          debugPrint(
            'App Check not supported on this platform/OS; continuing without App Check token.',
          );
          _hasLoggedUnsupportedAppCheck = true;
        }
      } else {
        debugPrint('App Check token fetch failed: $e');
      }
      return null;
    }
  }

  Future<Map<String, String>> _buildJsonHeaders({
    bool includeAuth = false,
    bool includeAppCheck = false,
    Map<String, String>? extra,
    bool forceAuthRefresh = false,
  }) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      if (!kIsWeb && Platform.isIOS) 'X-Platform': 'ios',
      ...?extra,
    };

    if (includeAuth && !headers.containsKey('Authorization')) {
      final authValue = await _getAuthorizationHeaderValue(
        forceRefresh: forceAuthRefresh,
      );
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

  Future<Map<String, String>?> _buildProtectedJsonHeaders({
    bool forceAuthRefresh = false,
  }) async {
    var headers = await _buildJsonHeaders(
      includeAuth: true,
      includeAppCheck: true,
      forceAuthRefresh: forceAuthRefresh,
    );

    if (!headers.containsKey('Authorization')) {
      await Future.delayed(const Duration(milliseconds: 200));
      headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
        forceAuthRefresh: forceAuthRefresh,
      );
    }

    return headers.containsKey('Authorization') ? headers : null;
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
      ...?headers,
      if (!kIsWeb && Platform.isIOS) 'X-Platform': 'ios',
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
      ...?headers,
      if (!kIsWeb && Platform.isIOS) 'X-Platform': 'ios',
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
      ...?headers,
      if (!kIsWeb && Platform.isIOS) 'X-Platform': 'ios',
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

  Future<String> uploadFile(
    String endpoint,
    File file, {
    String fieldName = 'file',
  }) async {
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
    if (!kIsWeb && Platform.isIOS) {
      request.headers['X-Platform'] = 'ios';
    }
    request.files.add(await http.MultipartFile.fromPath(fieldName, file.path));
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
    final dynamic fileUrlValue =
        decoded['data']?['url'] ??
        decoded['url'] ??
        decoded['fileUrl'] ??
        decoded['data']?['fileUrl'];

    if (fileUrlValue == null || fileUrlValue.toString().isEmpty) {
      throw Exception(
        (decoded['message'] ?? 'Upload failed: No URL returned').toString(),
      );
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
    try {
      // Current backend supports generic onboarding upload route.
      return await uploadFile(
        'onboarding/upload?uploadType=receipt',
        file,
        fieldName: 'file',
      );
    } catch (e) {
      final errorText = e.toString().toLowerCase();
      final isRouteMissing =
          errorText.contains('route not found') || errorText.contains('404');
      if (!isRouteMissing) {
        rethrow;
      }

      // Compatibility fallback for older backends.
      debugPrint(
        'uploadReceiptFile: primary endpoint unavailable, trying legacy /upload/receipt',
      );
      return await uploadFile('upload/receipt', file, fieldName: 'receipt');
    }
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
    if (!kIsWeb && Platform.isIOS) {
      request.headers['X-Platform'] = 'ios';
    }
    request.files.add(await http.MultipartFile.fromPath('logo', file.path));
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

  Future<Map<String, dynamic>> startTimer({
    String? userEmail,
    String? clientEmail,
    String? organizationId,
  }) async {
    final Map<String, dynamic> requestBody = {};

    // Add parameters if provided
    if (userEmail != null) requestBody['userEmail'] = userEmail;
    if (clientEmail != null) requestBody['clientEmail'] = clientEmail;
    if (organizationId != null) requestBody['organizationId'] = organizationId;

    final response = await post('active-timers/start', body: requestBody);
    debugPrint('Start timer response: ${json.encode(response)}');

    if (response['success'] == true) {
      debugPrint("Timer Started");
    } else {
      debugPrint("Timer failed");
    }

    return response;
  }

  /// Fetches employees for an organization
  /// Used by EmployeeSelectionViewModel
  Future<Map<String, dynamic>> getOrganizationEmployees(
    String organizationId,
  ) async {
    try {
      Map<String, dynamic> response = await get(
        'organization/$organizationId/employees',
      );

      if (response['success'] != true && response['employees'] == null) {
        // Fallback for backends that expose members but not employees.
        response = await getOrganizationMembers(organizationId);
      }

      if (response.containsKey('error')) {
        return {
          'success': false,
          'message': response['error'],
          if (response['statusCode'] != null)
            'statusCode': response['statusCode'],
        };
      }

      List<dynamic> people = [];
      if (response['employees'] is List) {
        people = response['employees'] as List<dynamic>;
      } else if (response['members'] is List) {
        people = response['members'] as List<dynamic>;
      } else if (response['data'] is Map) {
        final data = Map<String, dynamic>.from(response['data'] as Map);
        if (data['employees'] is List) {
          people = data['employees'] as List<dynamic>;
        } else if (data['members'] is List) {
          people = data['members'] as List<dynamic>;
        }
      } else if (response['data'] is List) {
        people = response['data'] as List<dynamic>;
      } else if (response['users'] is List) {
        people = response['users'] as List<dynamic>;
      }

      final employees = people.where((item) {
        if (item is! Map) return false;
        final map = Map<String, dynamic>.from(item);
        final roleTags = <String>{};

        final role = map['role']?.toString().toLowerCase().trim();
        if (role != null && role.isNotEmpty) roleTags.add(role);
        final orgRole = map['organizationRole']
            ?.toString()
            .toLowerCase()
            .trim();
        if (orgRole != null && orgRole.isNotEmpty) roleTags.add(orgRole);

        final roles = map['roles'];
        if (roles is List) {
          for (final entry in roles) {
            final tag = entry.toString().toLowerCase().trim();
            if (tag.isNotEmpty) roleTags.add(tag);
          }
        }

        final clientId = map['clientId']?.toString().trim();
        if (clientId != null && clientId.isNotEmpty) return false;
        if (roleTags.contains('client') || roleTags.contains('family')) {
          return false;
        }
        return true;
      }).toList();

      return {'success': true, 'employees': employees};
    } catch (e) {
      debugPrint("Error fetching organization employees: $e");
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  /// Stops the timer for a specific user or organization.

  Future<void> stopTimer({String? userEmail, String? organizationId}) async {
    final Map<String, dynamic> requestBody = {};

    // Add parameters if provided
    if (userEmail != null) requestBody['userEmail'] = userEmail;
    if (organizationId != null) requestBody['organizationId'] = organizationId;

    final response = await post('active-timers/stop', body: requestBody);
    debugPrint('Stop timer response: ${json.encode(response)}');

    if (response['success'] == true) {
      debugPrint("Timer stopped");
      final totalTime =
          response['totalSeconds'] ??
          response['totalTime']?.toInt() ??
          response['data']?['totalSeconds'] ??
          0;
      timerModel.setTotalTime(totalTime);
      debugPrint("Total time from timer: ${timerModel.totalTime}");
      notifyListeners();
      return;
    }

    debugPrint("Timer failed");
    throw Exception(response['message'] ?? 'Failed to stop timer');
  }

  Future<List<app.User>> fetchUserData() async {
    final response = await get('user/getUsers/');
    if (response['success'] == true) {
      final dynamic data = response['data'] ?? response['users'];
      if (data is List) {
        return data.map((item) => app.User.fromJson(item)).toList();
      }
      return [];
    } else {
      throw Exception(response['message'] ?? 'Unexpected error occured!');
    }
  }

  Future<Map<String, dynamic>> sendOTP(String email) async {
    final uri = Uri.parse('${_baseUrl}auth/forgot-password');
    debugPrint('sendOTP request URL: $uri');

    final headers = await _buildJsonHeaders(includeAppCheck: true);
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
      return {'success': true, 'statusCode': 200, ...payload};
    }

    return {
      'success': false,
      'statusCode': response.statusCode,
      'message': payload['message'] ?? 'Failed to send password reset code',
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

  /// Request backend to send Firebase email verification link.
  Future<Map<String, dynamic>> resendEmailVerificationOtp(String email) async {
    final uri = Uri.parse('${_baseUrl}auth/resend-verification');
    final headers = await _buildJsonHeaders(includeAppCheck: true);

    final response = await http.post(
      uri,
      body: jsonEncode({'email': email}),
      headers: headers,
    );

    return _handleResponse(response);
  }

  /// Verifies account email with OTP.
  Future<Map<String, dynamic>> verifyEmailOtp({
    required String email,
    required String otp,
  }) async {
    final uri = Uri.parse('${_baseUrl}auth/verify-email');
    final headers = await _buildJsonHeaders(includeAppCheck: true);

    final response = await http.post(
      uri,
      body: jsonEncode({'email': email, 'otp': otp}),
      headers: headers,
    );

    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> resetForgotPassword({
    required String email,
    required String otp,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final uri = Uri.parse('${_baseUrl}auth/reset-password');
    final headers = await _buildJsonHeaders(includeAppCheck: true);

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

  /// Change password for an authenticated user.
  ///
  /// Uses `/auth/v2/change-password` endpoint only.
  Future<Map<String, dynamic>> changeAuthenticatedPassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final payload = <String, dynamic>{
      'currentPassword': currentPassword,
      'newPassword': newPassword,
      'confirmPassword': newPassword,
    };

    return await post('auth/v2/change-password', body: payload);
  }

  Future<List<Patient>> fetchClientData() async {
    final response = await get('getClients');
    if (response['success'] == true) {
      final dynamic data = response['clients'] ?? response['data'];
      if (data is List) {
        return data.map((item) => Patient.fromJson(item)).toList();
      }
      return [];
    } else {
      throw Exception(response['message'] ?? 'Unexpected error occured!');
    }
  }

  Future<dynamic> getInitData(String email) async {
    var data;
    try {
      debugPrint('${_baseUrl}initData/$email');

      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );
      debugPrint(
        '=== API METHOD DEBUG: initData headers (Authorization: ${headers.containsKey('Authorization')}, AppCheck: ${headers.containsKey('X-Firebase-AppCheck')}) ===',
      );

      final response = await http.get(
        Uri.parse('${_baseUrl}initData/$email'),
        headers: headers,
      );
      data = (json.decode(response.body));

      // Ensure a value is returned even on error status codes
      if (response.statusCode != 200) {
        debugPrint(
          "Get init data failed with status ${response.statusCode}: ${response.body}",
        );
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
    String userEmail,
    String clientEmail,
    String organizationId,
  ) async {
    try {
      final encodedUser = Uri.encodeComponent(userEmail);
      final encodedClient = Uri.encodeComponent(clientEmail);
      final primaryUri = Uri.parse(
        '${_baseUrl}worked-time/getWorkedTime/$encodedUser/$encodedClient?organizationId=$organizationId',
      );
      final fallbackUri = Uri.parse(
        '${_baseUrl}getWorkedTime/$encodedUser/$encodedClient?organizationId=$organizationId',
      );

      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );

      http.Response response = await http.get(primaryUri, headers: headers);

      // Backward-compatibility fallback for environments still exposing legacy route.
      if (response.statusCode == 404) {
        response = await http.get(fallbackUri, headers: headers);
      }

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded is Map<String, dynamic>) {
          return decoded;
        }
        return {
          'success': false,
          'message': 'Invalid worked time response format',
          'workedTimes': [],
        };
      } else {
        // The backend now sends a meaningful error message on 404.
        final errorBody = jsonDecode(response.body);
        return {
          'success': false,
          'message':
              errorBody['message'] ??
              'Failed to load worked time: Status ${response.statusCode}',
          'workedTimes': [],
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error loading worked time: $e',
        'workedTimes': [],
      };
    }
  }

  Future<List<Patient>> fetchMultiplePatientData(String emails) async {
    debugPrint(Uri.parse('${_baseUrl}getMultipleClients/$emails').toString());
    debugPrint(emails.toString());
    final headers = await _buildJsonHeaders(
      includeAuth: true,
      includeAppCheck: true,
    );
    final response = await http.get(
      Uri.parse('${_baseUrl}getMultipleClients/$emails'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      debugPrint("I am a response client: \n${response.body}");
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Patient.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<dynamic> deleteHolidayItem(String id) async {
    final response = await delete('holidays/$id');
    if (response['success'] == true) {
      return response;
    }
    throw Exception(response['message'] ?? 'Failed to delete holiday');
  }

  Future<dynamic> addHolidayItem(Map<String, String> newHoliday) async {
    final prefs = SharedPreferencesUtils();
    await prefs.init();
    final organizationId = prefs.getOrganizationId();

    final date = _normalizeHolidayDateForApi(newHoliday['Date']);
    final payload = <String, dynamic>{
      'name': newHoliday['Holiday']?.trim(),
      'date': date,
      'day': newHoliday['Day']?.trim(),
      if (organizationId != null && organizationId.isNotEmpty)
        'organizationId': organizationId,
    };

    // Use the internal post method which handles auth headers and logging.
    final result = await post('holidays', body: payload);

    if (result['success'] == true) {
      return result;
    } else {
      debugPrint("Add Holiday failed: ${result['message']}");
      // The calling UI expects an exception on failure
      throw Exception(result['message'] ?? 'Failed to add holiday');
    }
  }

  String _normalizeHolidayDateForApi(String? rawDate) {
    final value = rawDate?.trim() ?? '';
    if (value.isEmpty) {
      return DateTime.now().toIso8601String();
    }

    final match = RegExp(r'^(\d{2})-(\d{2})-(\d{4})$').firstMatch(value);
    if (match != null) {
      final day = int.tryParse(match.group(1) ?? '');
      final month = int.tryParse(match.group(2) ?? '');
      final year = int.tryParse(match.group(3) ?? '');
      if (day != null && month != null && year != null) {
        return DateTime(year, month, day).toIso8601String();
      }
    }

    try {
      return DateTime.parse(value).toIso8601String();
    } catch (_) {
      return DateTime.now().toIso8601String();
    }
  }

  /// Fetches appointment data for a given email
  /// Returns empty data structure for new users or when no appointments exist
  Future<dynamic> getAppointmentData(String email) async {
    debugPrint('${_baseUrl}loadAppointments/$email');
    try {
      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );
      final response = await http.get(
        Uri.parse('${_baseUrl}loadAppointments/$email'),
        headers: headers,
      );

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

  String? _normalizeShiftTimeForValidation(String? rawTime) {
    final value = rawTime?.trim() ?? '';
    if (value.isEmpty) return null;

    final hhmm24 = RegExp(r'^([0-1]?[0-9]|2[0-3]):([0-5][0-9])$');
    final hhmm24Match = hhmm24.firstMatch(value);
    if (hhmm24Match != null) {
      return '${hhmm24Match.group(1)!.padLeft(2, '0')}:${hhmm24Match.group(2)!}';
    }

    final hhmmss24 = RegExp(r'^([0-1]?[0-9]|2[0-3]):([0-5][0-9]):[0-5][0-9]$');
    final hhmmssMatch = hhmmss24.firstMatch(value);
    if (hhmmssMatch != null) {
      return '${hhmmssMatch.group(1)!.padLeft(2, '0')}:${hhmmssMatch.group(2)!}';
    }

    final amPm = RegExp(r'^(0?[1-9]|1[0-2]):([0-5][0-9])\s*([AaPp][Mm])$');
    final amPmMatch = amPm.firstMatch(value);
    if (amPmMatch != null) {
      var hour = int.parse(amPmMatch.group(1)!);
      final minute = amPmMatch.group(2)!;
      final period = amPmMatch.group(3)!.toUpperCase();
      if (period == 'PM' && hour != 12) hour += 12;
      if (period == 'AM' && hour == 12) hour = 0;
      return '${hour.toString().padLeft(2, '0')}:$minute';
    }

    return null;
  }

  String? _normalizeShiftDateForValidation(String? rawDate) {
    final value = rawDate?.trim() ?? '';
    if (value.isEmpty) return null;

    final parsed = DateTime.tryParse(value);
    if (parsed != null) {
      return parsed.toIso8601String().split('T').first;
    }

    final mmDdYyyy = RegExp(r'^(\d{1,2})\/(\d{1,2})\/(\d{4})$');
    final mmDdMatch = mmDdYyyy.firstMatch(value);
    if (mmDdMatch != null) {
      final month = int.tryParse(mmDdMatch.group(1)!);
      final day = int.tryParse(mmDdMatch.group(2)!);
      final year = int.tryParse(mmDdMatch.group(3)!);
      if (month != null && day != null && year != null) {
        return DateTime(year, month, day).toIso8601String().split('T').first;
      }
    }

    return null;
  }

  int? _parseBreakDurationToMinutes(dynamic breakValue) {
    if (breakValue == null) return null;
    final value = breakValue.toString().trim();
    if (value.isEmpty) return null;
    if (value.toLowerCase() == 'no') return 0;

    final direct = int.tryParse(value);
    if (direct != null && direct >= 0) return direct;

    final match = RegExp(r'(\d+)').firstMatch(value);
    if (match != null) {
      final parsed = int.tryParse(match.group(1)!);
      if (parsed != null && parsed >= 0) return parsed;
    }

    return null;
  }

  Future<dynamic> setWorkedTime(
    String userEmail,
    String clientEmail,
    String workedTime,
    int shiftIndex, {
    String? shiftDate,
    String? shiftStartTime,
    String? shiftEndTime,
    dynamic shiftBreak,
  }) async {
    try {
      final url = '${_baseUrl}setWorkedTime';
      debugPrint('Calling API: $url');

      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );

      final normalizedDate = _normalizeShiftDateForValidation(shiftDate);
      final normalizedStartTime = _normalizeShiftTimeForValidation(
        shiftStartTime,
      );
      final normalizedEndTime = _normalizeShiftTimeForValidation(shiftEndTime);
      final breakDuration = _parseBreakDurationToMinutes(shiftBreak);

      if (normalizedDate == null ||
          normalizedStartTime == null ||
          normalizedEndTime == null) {
        throw Exception(
          'Selected shift details are invalid. Please select the exact shift and try again.',
        );
      }

      final body = {
        'userEmail': userEmail,
        'clientEmail': clientEmail,
        'timeList': workedTime,
        'shiftIndex': shiftIndex,
        'date': normalizedDate,
        'startTime': normalizedStartTime,
        'endTime': normalizedEndTime,
        'breakDuration': ?breakDuration,
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
          'Unexpected error occurred! Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint('API Error: $e');
      rethrow;
    }
  }

  Future<dynamic> setWorkedTimer(
    String userEmail,
    String clientEmail,
    String time,
  ) async {
    debugPrint('${_baseUrl}setWorkedTimer/');
    final url = '${_baseUrl}setWorkedTimer/';
    final headers = await _buildJsonHeaders(
      includeAuth: true,
      includeAppCheck: true,
    );
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
    String userEmail,
    String clientEmail,
  ) async {
    final url = '${_baseUrl}loadAppointmentDetails/$userEmail/$clientEmail';
    debugPrint(url);

    try {
      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );
      final response = await http.get(Uri.parse(url), headers: headers);

      debugPrint(
        '=== API METHOD DEBUG: loadAppointmentDetails status: ${response.statusCode} ===',
      );
      debugPrint(
        '=== API METHOD DEBUG: loadAppointmentDetails body: ${response.body} ===',
      );

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded is Map<String, dynamic>) {
          return decoded;
        }
        return {
          'success': false,
          'message': 'Invalid response payload',
          'statusCode': 200,
          'data': {'clientDetails': [], 'assignedClient': null},
        };
      }

      if (response.statusCode == 404) {
        return {
          'success': false,
          'message': 'No appointment details found for this client.',
          'statusCode': 404,
          'data': {'clientDetails': [], 'assignedClient': null},
        };
      }

      String message = 'Unexpected error occurred.';
      try {
        final parsed = json.decode(response.body);
        if (parsed is Map && parsed['message'] is String) {
          message = parsed['message'] as String;
        }
      } catch (_) {
        // Keep fallback message when response body is not JSON.
      }

      return {
        'success': false,
        'message': message,
        'statusCode': response.statusCode,
        'data': {'clientDetails': [], 'assignedClient': null},
      };
    } catch (e) {
      debugPrint('Error in getClientAndAppointmentData: $e');
      return {
        'success': false,
        'message': e.toString(),
        'statusCode': 500,
        'data': {'clientDetails': [], 'assignedClient': null},
      };
    }
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
        'deviceId': ?deviceId,
        'deviceInfo': ?deviceInfo,
        'timestamp': DateTime.now().toIso8601String(),
      };

      return post('auth/register-fcm-token', body: body);
    } catch (e) {
      debugPrint('FCM token registration error: $e');
      return {'success': false, 'message': 'FCM token registration failed: $e'};
    }
  }

  late Map<String, dynamic> data = {};

  Future<Map<String, dynamic>?> checkEmail(String email) async {
    try {
      final encoded = Uri.encodeComponent(email);
      debugPrint('${_baseUrl}checkEmail/$encoded');

      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );

      // Legacy endpoint (if present in older deployments).
      final response = await http.get(
        Uri.parse('${_baseUrl}checkEmail/$encoded'),
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        data = Map<String, dynamic>.from(json.decode(response.body));
        return data;
      }

      // Compatibility path: resolve user details from organization employee directory.
      final orgId = await _resolveOrganizationIdFromPrefs();
      if (orgId != null && orgId.isNotEmpty) {
        final orgResp = await getOrganizationEmployees(orgId);
        if (orgResp['success'] == true && orgResp['employees'] is List) {
          final employees = orgResp['employees'] as List<dynamic>;
          for (final employee in employees) {
            if (employee is! Map) continue;
            final map = Map<String, dynamic>.from(employee);
            final candidateEmail =
                map['email']?.toString().toLowerCase().trim() ?? '';
            if (candidateEmail == email.toLowerCase().trim()) {
              return {'success': true, 'statusCode': 200, ...map};
            }
          }
        }
      }
    } on SocketException {
      // _apiResponse.ApiError = ApiError(error: "Server error. Please retry") as String;
    } catch (e) {
      debugPrint('checkEmail fallback error: $e');
    }
    return {
      'success': false,
      'statusCode': 404,
      'message': 'User not found',
      'email': email,
    };
  }

  Future<Map<String, dynamic>> getUserPayDetails(
    String email, {
    String? organizationId,
  }) async {
    try {
      final encoded = Uri.encodeComponent(email);
      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );
      final response = await http.get(
        Uri.parse('${_baseUrl}userPayDetails/$encoded'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body is Map<String, dynamic>) return body;
        return {'success': false, 'message': 'Invalid response body'};
      }

      Map<String, dynamic>? parsedBody;
      if (response.body.isNotEmpty) {
        try {
          final body = jsonDecode(response.body);
          if (body is Map<String, dynamic>) parsedBody = body;
        } catch (_) {}
      }

      // Primary compatibility path: use organization employee listing when legacy
      // pay-details route is unavailable in backend.
      if (response.statusCode == 404 ||
          (parsedBody?['message']?.toString().toLowerCase().contains(
                'route not found',
              ) ??
              false)) {
        final resolvedOrgId =
            organizationId ?? await _resolveOrganizationIdFromPrefs();
        if (resolvedOrgId != null && resolvedOrgId.isNotEmpty) {
          final orgResp = await getOrganizationEmployees(resolvedOrgId);
          if (orgResp['success'] == true && orgResp['employees'] is List) {
            final employees = orgResp['employees'] as List<dynamic>;
            for (final employee in employees) {
              if (employee is! Map) continue;
              final map = Map<String, dynamic>.from(employee);
              final candidateEmail =
                  map['email']?.toString().toLowerCase().trim() ?? '';
              if (candidateEmail == email.toLowerCase().trim()) {
                return {
                  'success': true,
                  'message':
                      'Employee pay details loaded from organization directory',
                  'data': map,
                  'source': 'organization_employees',
                };
              }
            }
          }
        }
      }

      return {
        'success': false,
        'message':
            parsedBody?['message'] ??
            'Failed to fetch user pay details: ${response.statusCode}',
      };
    } catch (e) {
      final resolvedOrgId =
          organizationId ?? await _resolveOrganizationIdFromPrefs();
      if (resolvedOrgId != null && resolvedOrgId.isNotEmpty) {
        try {
          final orgResp = await getOrganizationEmployees(resolvedOrgId);
          if (orgResp['success'] == true && orgResp['employees'] is List) {
            final employees = orgResp['employees'] as List<dynamic>;
            for (final employee in employees) {
              if (employee is! Map) continue;
              final map = Map<String, dynamic>.from(employee);
              final candidateEmail =
                  map['email']?.toString().toLowerCase().trim() ?? '';
              if (candidateEmail == email.toLowerCase().trim()) {
                return {
                  'success': true,
                  'message':
                      'Employee pay details loaded from organization directory',
                  'data': map,
                  'source': 'organization_employees',
                };
              }
            }
          }
        } catch (_) {}
      }
      return {
        'success': false,
        'message': 'Error fetching user pay details: $e',
      };
    }
  }

  Future<String?> _resolveOrganizationIdFromPrefs() async {
    try {
      final shared = SharedPreferencesUtils();
      await shared.init();
      final orgId = shared.getOrganizationId();
      if (orgId != null && orgId.isNotEmpty) return orgId;
    } catch (_) {}

    try {
      final prefs = await SharedPreferences.getInstance();
      final orgId = prefs.getString('organizationId');
      if (orgId != null && orgId.isNotEmpty) return orgId;
    } catch (_) {}

    return null;
  }

  /// Get detailed client information including businessName from clients collection
  /// This method fetches comprehensive client data needed for invoice generation
  Future<Map<String, dynamic>?> getClientDetails(
    String clientEmail, {
    String? clientId,
    String? organizationId,
  }) async {
    try {
      debugPrint('Fetching client details for: $clientEmail');
      final normalizedEmail = clientEmail.toLowerCase().trim();
      final normalizedClientId = clientId?.trim() ?? '';

      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );

      final query = <String, String>{};
      if (organizationId != null && organizationId.isNotEmpty) {
        query['organizationId'] = organizationId;
      }

      String extractId(dynamic value) {
        if (value is Map && value[r'$oid'] != null) {
          return value[r'$oid'].toString();
        }
        return value?.toString().trim() ?? '';
      }

      Map<String, dynamic>? extractClientPayload(dynamic raw) {
        if (raw is! Map) return null;
        final map = Map<String, dynamic>.from(raw);
        if (map['client'] is Map) {
          return Map<String, dynamic>.from(map['client']);
        }
        if (map['clientDetails'] is Map) {
          return Map<String, dynamic>.from(map['clientDetails']);
        }
        if (map['data'] is Map) {
          return Map<String, dynamic>.from(map['data']);
        }
        final hasClientLikeFields =
            map.containsKey('clientEmail') ||
            map.containsKey('clientFirstName');
        return hasClientLikeFields ? map : null;
      }

      final candidateUris = <Uri>[];
      if (normalizedClientId.isNotEmpty) {
        candidateUris.add(
          _buildUri(
            'clients/$normalizedClientId',
          ).replace(queryParameters: query.isEmpty ? null : query),
        );
        candidateUris.add(
          _buildUri(
            'client/details/$normalizedClientId',
          ).replace(queryParameters: query.isEmpty ? null : query),
        );
      }

      http.Response? lastResponse;

      for (final uri in candidateUris) {
        final response = await http.get(uri, headers: headers);
        lastResponse = response;
        debugPrint(
          'Client details request: GET $uri -> ${response.statusCode}',
        );
        if (response.statusCode != 200) continue;

        final decoded = response.body.isNotEmpty
            ? json.decode(response.body)
            : const {};
        final clientData = extractClientPayload(decoded);
        if (clientData != null) {
          clientData['success'] = true;
          clientData['message'] = (decoded is Map && decoded['message'] != null)
              ? decoded['message']
              : 'Client details retrieved successfully';
          debugPrint('Successfully fetched client details: $clientData');
          return clientData;
        }
      }

      final resolvedOrgId =
          organizationId ?? await _resolveOrganizationIdFromPrefs();
      if (resolvedOrgId != null && resolvedOrgId.isNotEmpty) {
        try {
          final listUri = _buildUri(
            'clients/$resolvedOrgId',
          ).replace(queryParameters: {'organizationId': resolvedOrgId});
          final listResp = await http.get(listUri, headers: headers);
          lastResponse = listResp;
          if (listResp.statusCode == 200) {
            final decoded = listResp.body.isNotEmpty
                ? json.decode(listResp.body)
                : null;
            dynamic clientsRaw;
            if (decoded is Map<String, dynamic>) {
              clientsRaw =
                  decoded['clients'] ??
                  (decoded['data'] is List ? decoded['data'] : null);
            } else if (decoded is List) {
              clientsRaw = decoded;
            }

            if (clientsRaw is List) {
              for (final entry in clientsRaw) {
                if (entry is! Map) continue;
                final clientMap = Map<String, dynamic>.from(entry);
                final emailValue =
                    clientMap['clientEmail']?.toString().toLowerCase().trim() ??
                    '';
                final entryClientId = extractId(
                  clientMap['_id'] ?? clientMap['id'] ?? clientMap['clientId'],
                );
                final idMatches =
                    normalizedClientId.isNotEmpty &&
                    entryClientId == normalizedClientId;
                final emailMatches = emailValue == normalizedEmail;
                if (!idMatches && !emailMatches) continue;
                clientMap['success'] = true;
                clientMap['message'] = 'Client details retrieved successfully';
                return clientMap;
              }
            }
          }
        } catch (e) {
          debugPrint('Client details list fallback failed: $e');
        }
      }

      if (lastResponse != null) {
        debugPrint(
          'Client details response status: ${lastResponse.statusCode}',
        );
        debugPrint('Client details response body: ${lastResponse.body}');
      }

      debugPrint('Client not found: $clientEmail');
      return {
        'success': false,
        'message': 'Client not found',
        'clientEmail': clientEmail,
        'clientFirstName': '',
        'clientLastName': '',
        'businessName': '',
      };
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
      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );
      final response = await http.delete(
        Uri.parse('${_baseUrl}deleteUser/'),
        headers: headers,
        body: jsonEncode({'email': email}),
      );
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
      final response = await http.post(
        Uri.parse('${_baseUrl}getSalt/'),
        body: jsonEncode({'email': email}),
        headers: {'Content-Type': 'application/json'},
      );
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
              "Warning: Backend returned empty or missing salt for user: $email",
            );
            data['error'] = 'Empty salt returned from server';
          } else {
            data['salt'] = extractedSalt;
          }
          break;
        case 400:
          data = Map<String, dynamic>.from(json.decode(response.body));
          debugPrint(
            "400 error getting salt: ${data['message'] ?? 'Unknown error'}",
          );
          break;
        case 404:
          debugPrint("404: User not found - $email");
          data = {
            'error': 'User not found',
            'errorCode': 'USER_NOT_FOUND',
            'statusCode': 404,
          };
          break;
        case 500:
          debugPrint("500: Server error getting salt");
          data = {
            'error': 'Server error occurred',
            'errorCode': 'SERVER_ERROR',
            'statusCode': 500,
          };
          break;
        default:
          debugPrint(
            "Unexpected status code getting salt: ${response.statusCode}",
          );
          data = {
            'error': 'Unexpected status code: ${response.statusCode}',
            'errorCode': 'UNKNOWN_ERROR',
            'statusCode': response.statusCode,
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
    final response = await secureLogin({'email': email, 'password': password});

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
    final response = await post('holidays/upload-csv');
    return response;
  }

  Future<List<dynamic>> getBusinessNameList({String? organizationId}) async {
    try {
      var orgId = organizationId;
      if (orgId == null || orgId.trim().isEmpty) {
        final prefs = SharedPreferencesUtils();
        await prefs.init();
        orgId = prefs.getOrganizationId();
      }

      if (orgId == null || orgId.trim().isEmpty) {
        debugPrint('getBusinessNameList: organizationId is missing');
        return [];
      }

      final businesses = await getBusinesses(orgId);
      final List<Map<String, String>> names = [];
      final seen = <String>{};

      for (final item in businesses) {
        if (item is! Map) continue;
        final businessName = (item['businessName'] ?? '').toString().trim();
        if (businessName.isEmpty) continue;
        final normalized = businessName.toLowerCase();
        if (seen.contains(normalized)) continue;
        seen.add(normalized);
        names.add({'businessName': businessName});
      }

      names.sort(
        (a, b) => (a['businessName'] ?? '').toLowerCase().compareTo(
          (b['businessName'] ?? '').toLowerCase(),
        ),
      );
      return names;
    } catch (e) {
      debugPrint('Error getting business names: $e');
      return [];
    }
  }

  late List<dynamic> holidaysList = [];

  Future<Map<String, dynamic>> getHolidays({
    String? organizationId,
    String? state,
  }) async {
    final params = <String>[];
    if (organizationId != null && organizationId.isNotEmpty) {
      params.add('organizationId=${Uri.encodeQueryComponent(organizationId)}');
    }
    if (state != null && state.isNotEmpty) {
      params.add('state=${Uri.encodeQueryComponent(state)}');
    }

    final query = params.isEmpty ? '' : '?${params.join('&')}';
    final response = await get('holidays$query');

    final payload = response['data'];
    if (payload is List) {
      holidaysList = List<dynamic>.from(payload);
    } else {
      holidaysList = [];
    }

    return response;
  }

  late List<dynamic> list = [];

  Future<dynamic> getUserDocs() async {
    try {
      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );
      final response = await http.get(
        Uri.parse('${_baseUrl}user-docs'),
        headers: headers,
      );
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
    String ndisItemNumber,
    double price,
    String notes, {
    Map<String, dynamic>? metadata,
    String? userEmail,
    String? organizationId,
  }) async {
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

      final headers = await _buildProtectedJsonHeaders();
      if (headers == null) {
        return {
          'success': false,
          'message': 'Authentication required. Please log in again.',
        };
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
    String ndisItemNumber,
    String clientId,
    double price,
    String notes, {
    Map<String, dynamic>? metadata,
    String? userEmail,
    String? organizationId,
  }) async {
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

      final headers = await _buildProtectedJsonHeaders();
      if (headers == null) {
        return {
          'success': false,
          'message': 'Authentication required. Please log in again.',
        };
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
          'message': 'Failed to save client custom price',
        };
      }
    } catch (e) {
      debugPrint('Exception saving client custom price: $e');
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  Future<double> getCustomPriceForOrganization(String ndisItemNumber) async {
    try {
      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );

      final response = await http.get(
        Uri.parse('${_baseUrl}custom-price-organization/$ndisItemNumber'),
        headers: headers,
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
    String ndisItemNumber,
    String clientId,
  ) async {
    try {
      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );

      final response = await http.get(
        Uri.parse('${_baseUrl}custom-price-client/$ndisItemNumber/$clientId'),
        headers: headers,
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
    String ndisItemNumber,
    String clientId,
  ) async {
    try {
      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );

      final response = await http.get(
        Uri.parse('${_baseUrl}price-history/$ndisItemNumber/$clientId'),
        headers: headers,
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
      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );

      final response = await http.get(
        Uri.parse('${_baseUrl}ndis-price-cap/$ndisItemNumber'),
        headers: headers,
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
      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );

      final response = await http.get(
        Uri.parse('${_baseUrl}pricing/standard-price/$ndisItemNumber'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is Map<String, dynamic>) {
          // Current API shape
          if (data['success'] == true && data['price'] != null) {
            return double.parse(data['price'].toString());
          }

          // Fallback to nested response shape
          if (data['data'] is Map<String, dynamic>) {
            final nested = data['data'] as Map<String, dynamic>;
            if (nested['price'] != null) {
              return double.parse(nested['price'].toString());
            }
          }
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
      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );
      final response = await http.get(
        Uri.parse('${_baseUrl}assigned-client-data'),
        headers: headers,
      );
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

  Future<Map<String, dynamic>> signupUser(
    String firstName,
    String lastName,
    String email,
    String password,
    String abn,
    String role, {
    String? organizationId,
    String? organizationCode,
    String? organizationName,
    bool? isOwner,
  }) async {
    try {
      // Prepare request body for the unified register endpoint
      // Backend handles email check + Firebase user creation via Admin SDK
      final Map<String, dynamic> requestBody = {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "confirmPassword": password,
        "abn": abn,
      };

      // Handle organization creation/joining
      if (isOwner == true || role == 'admin') {
        requestBody["isOwner"] = true;
        if (organizationName != null && organizationName.isNotEmpty) {
          requestBody["organizationName"] = organizationName;
        }
      }

      if (organizationId != null && organizationId.isNotEmpty) {
        requestBody["organizationId"] = organizationId;
      }
      if (organizationCode != null && organizationCode.isNotEmpty) {
        requestBody["organizationCode"] = organizationCode;
      }

      // Get Firebase App Check token
      String? appCheckToken;
      try {
        appCheckToken = await FirebaseAppCheck.instance.getToken();
      } catch (e) {
        debugPrint('App Check token error: $e');
      }

      final signupResponse = await http.post(
        Uri.parse('${_baseUrl}auth/register'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          if (!kIsWeb && Platform.isIOS) 'X-Platform': 'ios',
          "X-Firebase-AppCheck": ?appCheckToken,
        },
        body: jsonEncode(requestBody),
      );
      debugPrint('${_baseUrl}auth/register');
      debugPrint('Request body: ${jsonEncode(requestBody)}');
      debugPrint('Response status: ${signupResponse.statusCode}');
      debugPrint('Response body: ${signupResponse.body}');

      switch (signupResponse.statusCode) {
        case 200:
        case 201:
          final signupData = json.decode(signupResponse.body);
          debugPrint("Signup successful: ${signupResponse.body}");
          return {...signupData, "success": true};
        case 400:
          final errorData = json.decode(signupResponse.body);
          debugPrint("Signup failed: ${signupResponse.body}");
          return {
            "error":
                errorData['message'] ?? errorData['error'] ?? "Signup failed",
          };
        case 409:
          debugPrint("Email already exists");
          return {"error": "Email already exists"};
        case 500:
          debugPrint("Server error: ${signupResponse.body}");
          return {"error": "Server error occurred"};
        default:
          debugPrint(
            "Signup failed with status code ${signupResponse.statusCode}",
          );
          return {
            "error":
                "Signup failed with status code ${signupResponse.statusCode}",
          };
      }
    } on SocketException {
      debugPrint("Server error. Please retry");
      return {"error": "Server error. Please retry"};
    } catch (e) {
      debugPrint("Signup exception: $e");
      return {"error": "An error occurred: $e"};
    }
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
        "businessName": businessName,
      };

      // Add optional parameters if provided
      if (userEmail != null) {
        requestBody["userEmail"] = userEmail;
      }
      if (organizationId != null) {
        requestBody["organizationId"] = organizationId;
      }
      final response = await post('addClient', body: requestBody);
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return {'success': false, 'message': 'Failed to add client: $e'};
    }
  }

  Future<Map<String, dynamic>> updateClient({
    required String clientId,
    required String clientFirstName,
    required String clientLastName,
    required String clientPhone,
    required String clientAddress,
    required String clientCity,
    required String clientState,
    required String clientZip,
    String? businessName,
    required String userEmail,
    required String organizationId,
  }) async {
    try {
      return await put(
        'client/$clientId',
        body: {
          'clientFirstName': clientFirstName,
          'clientLastName': clientLastName,
          'clientPhone': clientPhone,
          'clientAddress': clientAddress,
          'clientCity': clientCity,
          'clientState': clientState,
          'clientZip': clientZip,
          'businessName': ?businessName,
          'userEmail': userEmail,
          'organizationId': organizationId,
        },
      );
    } catch (e) {
      return {'success': false, 'message': 'Failed to update client: $e'};
    }
  }

  Future<Map<String, dynamic>> deleteClient({
    required String clientId,
    required String userEmail,
    required String organizationId,
    bool forceDelete = false,
  }) async {
    try {
      return await post(
        'client/$clientId/delete',
        body: {
          'userEmail': userEmail,
          'organizationId': organizationId,
          if (forceDelete) 'forceDelete': true,
        },
      );
    } catch (e) {
      return {'success': false, 'message': 'Failed to delete client: $e'};
    }
  }

  Future<Map<String, dynamic>> restoreClient({
    required String clientId,
    required String userEmail,
    required String organizationId,
    String? clientFirstName,
    String? clientLastName,
    String? clientPhone,
    String? clientAddress,
    String? clientCity,
    String? clientState,
    String? clientZip,
    String? businessName,
  }) async {
    try {
      return await post(
        'client/$clientId/restore',
        body: {
          'userEmail': userEmail,
          'organizationId': organizationId,
          'clientFirstName': ?clientFirstName,
          'clientLastName': ?clientLastName,
          'clientPhone': ?clientPhone,
          'clientAddress': ?clientAddress,
          'clientCity': ?clientCity,
          'clientState': ?clientState,
          'clientZip': ?clientZip,
          'businessName': ?businessName,
        },
      );
    } catch (e) {
      return {'success': false, 'message': 'Failed to restore client: $e'};
    }
  }

  Future<Map<String, dynamic>> markClientActivatedByAdmin({
    required String clientId,
    required String userEmail,
    required String organizationId,
  }) async {
    try {
      return await post(
        'client/$clientId/mark-activated',
        body: {'userEmail': userEmail, 'organizationId': organizationId},
      );
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to mark client as activated: $e',
      };
    }
  }

  Future<dynamic> addBusiness(
    String businessName,
    String businessEmail,
    String businessPhone,
    String businessAddress,
    String businessCity,
    String businessState,
    String businessZip, {
    String? organizationId,
    String? userEmail,
  }) async {
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
      final response = await post('addBusiness', body: requestBody);
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return {'success': false, 'message': 'Failed to add business: $e'};
    }
  }

  Future<Map<String, dynamic>> updateBusiness({
    required String businessId,
    required String businessName,
    required String businessEmail,
    required String businessPhone,
    required String businessAddress,
    required String businessCity,
    required String businessState,
    required String businessZip,
    required String userEmail,
    required String organizationId,
  }) async {
    try {
      return await put(
        'business/$businessId',
        body: {
          'businessName': businessName,
          'businessEmail': businessEmail,
          'businessPhone': businessPhone,
          'businessAddress': businessAddress,
          'businessCity': businessCity,
          'businessState': businessState,
          'businessZip': businessZip,
          'userEmail': userEmail,
          'organizationId': organizationId,
        },
      );
    } catch (e) {
      return {'success': false, 'message': 'Failed to update business: $e'};
    }
  }

  Future<Map<String, dynamic>> deleteBusiness({
    required String businessId,
    required String userEmail,
    required String organizationId,
  }) async {
    try {
      return await post(
        'business/$businessId/delete',
        body: {'userEmail': userEmail, 'organizationId': organizationId},
      );
    } catch (e) {
      return {'success': false, 'message': 'Failed to delete business: $e'};
    }
  }

  /// Get businesses for organization
  Future<List<dynamic>> getBusinesses(String organizationId) async {
    try {
      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );

      final response = await http.get(
        Uri.parse('${_baseUrl}businesses/$organizationId'),
        headers: headers,
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
      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );

      final response = await http.post(
        Uri.parse('${_baseUrl}organization/create'),
        headers: headers,
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
            "error": errorData['message'] ?? "Organization creation failed",
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
      // Use public endpoint for signup flow (no auth required)
      final response = await http.get(
        Uri.parse('${_baseUrl}auth/verify-organization/$organizationCode'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );

      switch (response.statusCode) {
        case 200:
          final responseData = json.decode(response.body);
          debugPrint("Organization code verified: ${response.body}");
          return {
            "success": true,
            "organizationId": responseData['organizationId'],
            "organizationName": responseData['organizationName'],
            "organizationCode": responseData['organizationCode'],
          };
        case 404:
          debugPrint("Invalid organization code");
          return {"success": false, "message": "Invalid organization code"};
        default:
          debugPrint("Verification failed: ${response.statusCode}");
          return {"success": false, "message": "Verification failed"};
      }
    } catch (e) {
      debugPrint("Error verifying organization code: $e");
      return {"success": false, "message": "Network error occurred"};
    }
  }

  Future<Map<String, dynamic>> getOrganization(String organizationId) async {
    try {
      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );

      final response = await http.get(
        Uri.parse('${_baseUrl}organization/$organizationId'),
        headers: headers,
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
    String organizationId,
  ) async {
    try {
      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );

      final response = await http.get(
        Uri.parse('${_baseUrl}organization/$organizationId/members'),
        headers: headers,
      );

      switch (response.statusCode) {
        case 200:
          final responseData = json.decode(response.body);
          return responseData;
        case 401:
          return {"error": "Authentication required", "statusCode": 401};
        case 403:
          return {
            "error": "Permission denied for organization members",
            "statusCode": 403,
          };
        case 404:
          return {"error": "Organization not found", "statusCode": 404};
        default:
          String? message;
          try {
            final decoded = json.decode(response.body);
            if (decoded is Map<String, dynamic>) {
              message = decoded['message']?.toString();
            }
          } catch (_) {}

          return {
            "error": message ?? "Failed to fetch members",
            "statusCode": response.statusCode,
          };
      }
    } catch (e) {
      debugPrint("Error fetching organization members: $e");
      return {"error": "Network error occurred"};
    }
  }

  Future<Map<String, dynamic>> getOrganizationBusinesses(
    String organizationId,
  ) async {
    try {
      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );

      final response = await http.get(
        Uri.parse('${_baseUrl}organization/$organizationId/businesses'),
        headers: headers,
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

  Future<Map<String, dynamic>> addClientWithOrganization(
    String clientName,
    String clientEmail,
    String clientPhone,
    String clientAddress, {
    String? organizationId,
  }) async {
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

      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );

      final response = await http.post(
        Uri.parse('${_baseUrl}addClient/'),
        headers: headers,
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
    List<bool> highIntensityList,
  ) async {
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
      final sharedUtils = SharedPreferencesUtils();
      await sharedUtils.init();
      final organizationId = sharedUtils.getOrganizationId();

      final requestBody = {
        "userEmail": userEmail,
        "clientEmail": clientEmail,
        "dateList": dateList,
        "startTimeList": startTimeList,
        "endTimeList": endTimeList,
        "breakList": breakList,
        "ndisItem": cleanNdisItem,
        "highIntensityList": highIntensityList,
        if (organizationId != null && organizationId.isNotEmpty)
          "organizationId": organizationId,
      };

      // Add customPricing as a separate field if it exists
      if (customPricing != null) {
        requestBody["customPricing"] = customPricing;
      }

      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );

      if (organizationId != null && organizationId.isNotEmpty) {
        headers['x-organization-id'] = organizationId;
      }

      debugPrint(
        '=== API METHOD DEBUG: assignClientToUser payload: ${jsonEncode(requestBody)} ===',
      );
      final response = await http.post(
        _buildUri('assignClientToUser'),
        headers: headers,
        body: jsonEncode(requestBody),
      );
      debugPrint(
        '=== API METHOD DEBUG: assignClientToUser status: ${response.statusCode} ===',
      );
      debugPrint(
        '=== API METHOD DEBUG: assignClientToUser body: ${response.body} ===',
      );
      final handledResponse = _handleResponse(response);
      return _normalizeAssignmentApiResponse(handledResponse);
    } catch (e) {
      debugPrint('=== API METHOD DEBUG: assignClientToUser exception: $e ===');
      return {
        'success': false,
        'statusCode': 0,
        'message': 'Failed to assign client to user: $e',
      };
    }
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
    List<Map<String, dynamic>> scheduleWithNdisItems,
  ) async {
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
      final sharedUtils = SharedPreferencesUtils();
      await sharedUtils.init();
      final organizationId = sharedUtils.getOrganizationId();

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
        if (organizationId != null && organizationId.isNotEmpty)
          "organizationId": organizationId,
      };

      // Add customPricing as a separate field if it exists
      if (customPricing != null) {
        requestBody["customPricing"] = customPricing;
      }

      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );
      if (organizationId != null && organizationId.isNotEmpty) {
        headers['x-organization-id'] = organizationId;
      }

      debugPrint(
        '=== API METHOD DEBUG: assignClientToUserWithScheduleItems payload: ${jsonEncode(requestBody)} ===',
      );
      final response = await http.post(
        _buildUri('assignClientToUser'),
        headers: headers,
        body: jsonEncode(requestBody),
      );
      debugPrint(
        '=== API METHOD DEBUG: assignClientToUserWithScheduleItems status: ${response.statusCode} ===',
      );
      debugPrint(
        '=== API METHOD DEBUG: assignClientToUserWithScheduleItems body: ${response.body} ===',
      );
      final handledResponse = _handleResponse(response);
      return _normalizeAssignmentApiResponse(handledResponse);
    } catch (e) {
      debugPrint(
        '=== API METHOD DEBUG: assignClientToUserWithScheduleItems exception: $e ===',
      );
      return {
        'success': false,
        'statusCode': 0,
        'message': 'Failed to assign client with schedules: $e',
      };
    }
  }

  Map<String, dynamic> _normalizeAssignmentApiResponse(
    Map<String, dynamic> response,
  ) {
    final normalized = Map<String, dynamic>.from(response);
    final success = normalized['success'] == true;
    final statusCode = normalized['statusCode'] as int? ?? 0;
    final message = normalized['message']?.toString().trim() ?? '';

    if (success) {
      if (message.isEmpty) {
        normalized['message'] = 'Assignment created successfully';
      }
      return normalized;
    }

    if (message.isNotEmpty) {
      return normalized;
    }

    switch (statusCode) {
      case 400:
        normalized['message'] = 'Invalid assignment request';
        break;
      case 401:
        normalized['message'] = 'Authentication required. Please sign in again';
        break;
      case 403:
        normalized['message'] =
            'You do not have permission to create assignments';
        break;
      case 404:
        normalized['message'] = 'Assignment endpoint not found';
        break;
      case 409:
        normalized['message'] = 'Conflicting shift schedule detected';
        break;
      case 422:
        normalized['message'] = 'Assignment validation failed';
        break;
      case 429:
        normalized['message'] = 'Too many requests. Please try again shortly';
        break;
      case 500:
      case 502:
      case 503:
      case 504:
        normalized['message'] = 'Server error while creating assignment';
        break;
      default:
        normalized['message'] =
            'Failed to create assignment (status: $statusCode)';
    }

    return normalized;
  }

  Future<Map<String, dynamic>> getInvoiceData({
    bool includeExpenses = false,
    String? userEmail,
    String? clientEmail,
    String? startDate,
    String? endDate,
    String? invoiceType,
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

      final requestBody = <String, dynamic>{"includeExpenses": includeExpenses};

      // Add required parameters if available
      if (userEmail != null) requestBody["userEmail"] = userEmail;
      if (clientEmail != null) requestBody["clientEmail"] = clientEmail;
      if (startDate != null) requestBody["startDate"] = startDate;
      if (endDate != null) requestBody["endDate"] = endDate;
      if (invoiceType != null) requestBody["invoiceType"] = invoiceType;

      final headers = await _buildProtectedJsonHeaders();
      if (headers == null) {
        throw Exception('Failed to get invoice data: 401');
      }

      headers["Accept"] = "application/json";

      final response = await http.post(
        Uri.parse('${_baseUrl}invoice/generate-line-items'),
        headers: headers,
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
  Future<List<Map<String, dynamic>>> getLineItems({
    bool includeExpenses = false,
  }) async {
    final invoiceData = await getInvoiceData(includeExpenses: includeExpenses);
    return List<Map<String, dynamic>>.from(invoiceData['lineItems'] ?? []);
  }

  /// Fetches business statistics for the admin dashboard
  Future<Map<String, dynamic>> getInvoiceStats(String organizationId) async {
    try {
      final response = await getRawUrl(
        'invoices/stats/$organizationId',
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
            'Failed to get invoice stats: organization not found',
          );
        default:
          throw Exception(
            'Failed to get invoice stats: ${response.statusCode}',
          );
      }
    } on SocketException {
      throw Exception('Failed to get invoice stats: network error');
    } catch (e) {
      throw Exception('Failed to get invoice stats: $e');
    }
  }

  /// Fetch active admin invoice profile for an organization
  Future<Map<String, dynamic>> getAdminInvoiceProfile(
    String organizationId,
  ) async {
    try {
      return await get('admin-invoice-profile/$organizationId');
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Create or update admin invoice profile
  Future<Map<String, dynamic>> upsertAdminInvoiceProfile(
    Map<String, dynamic> payload,
  ) async {
    try {
      final profileId = payload['profileId'];
      if (profileId != null) {
        return await put('admin-invoice-profile/$profileId', body: payload);
      } else {
        return await post('admin-invoice-profile', body: payload);
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Get organization details
  Future<Map<String, dynamic>> getOrganizationDetails(
    String organizationId, {
    bool forceRefresh = false,
  }) async {
    try {
      final refreshQuery = forceRefresh
          ? '?_ts=${DateTime.now().millisecondsSinceEpoch}'
          : '';
      return await get('organization/$organizationId$refreshQuery');
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Update organization business details
  Future<Map<String, dynamic>> updateOrganizationDetails(
    String organizationId,
    Map<String, dynamic> updates,
  ) async {
    try {
      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
        extra: const {'Accept': 'application/json'},
      );
      final uri = Uri.parse('${_baseUrl}organization/$organizationId');
      debugPrint('=== updateOrganizationDetails DEBUG ===');
      debugPrint('URL: $uri');
      debugPrint(
        'Auth header present: ${headers.containsKey('Authorization')}',
      );
      final response = await http.put(
        uri,
        headers: headers,
        body: json.encode(updates),
      );
      debugPrint(
        'updateOrganizationDetails statusCode: ${response.statusCode}',
      );

      if (response.body.isEmpty) {
        return {
          'success': response.statusCode >= 200 && response.statusCode < 300,
          'statusCode': response.statusCode,
          'message': response.statusCode >= 200 && response.statusCode < 300
              ? 'Organization updated'
              : 'Empty response from server',
        };
      }

      dynamic decoded;
      try {
        decoded = json.decode(response.body);
      } catch (e) {
        debugPrint(
          'updateOrganizationDetails: Non-JSON response body: ${response.body}',
        );
        return {
          'success': false,
          'statusCode': response.statusCode,
          'message': 'Invalid response from server',
        };
      }

      if (decoded is Map<String, dynamic>) {
        final result = Map<String, dynamic>.from(decoded);
        result['statusCode'] ??= response.statusCode;
        result['success'] ??=
            response.statusCode >= 200 && response.statusCode < 300;
        if ((response.statusCode == 401 || response.statusCode == 403) &&
            (result['message'] == null ||
                result['message'].toString().trim().isEmpty)) {
          result['message'] = 'Authentication failed';
        }
        return result;
      }

      return {
        'success': false,
        'statusCode': response.statusCode,
        'message': 'Invalid response',
      };
    } catch (e) {
      debugPrint('updateOrganizationDetails exception: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> sendOrganizationContactVerification(
    String organizationId,
  ) async {
    try {
      return await post(
        'organization/$organizationId/contact-email/send-verification',
      );
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
        body: jsonEncode({"dateList": workedDateList.join(',')}),
      );
      if (response.statusCode == 200) {
        final List<dynamic> holidayStatusListJson = json.decode(response.body);
        final List<String> holidayStatusList = holidayStatusListJson
            .cast<String>();
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
    List<List<String>> workedDateList,
  ) async {
    // Flatten the List<List<String>> to List<String>
    List<String> flattenedWorkedDateList = workedDateList
        .expand((i) => i)
        .toList();
    return checkHolidaysSingle(flattenedWorkedDateList);
  }

  Future<dynamic> uploadPhoto(String userEmail, File imageFile) async {
    try {
      final request = http.MultipartRequest('POST', _buildUri('user/photo'));
      final authValue = await _getAuthorizationHeaderValue();
      final appCheckToken = await _getAppCheckToken();

      if (authValue != null) {
        request.headers['Authorization'] = authValue;
      }
      if (appCheckToken != null && appCheckToken.isNotEmpty) {
        request.headers['X-Firebase-AppCheck'] = appCheckToken;
      }
      if (!kIsWeb && Platform.isIOS) {
        request.headers['X-Platform'] = 'ios';
      }

      request.fields['email'] = userEmail.trim().toLowerCase();
      request.files.add(
        await http.MultipartFile.fromPath(
          'photo',
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
      );

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);

      Map<String, dynamic> payload = {};
      if (response.body.isNotEmpty) {
        try {
          payload = Map<String, dynamic>.from(jsonDecode(response.body));
        } catch (_) {
          payload = {};
        }
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {'success': true, 'statusCode': response.statusCode, ...payload};
      }

      return {
        'success': false,
        'statusCode': response.statusCode,
        'message':
            payload['message'] ??
            payload['error'] ??
            'Failed to upload profile photo',
        ...payload,
      };
    } catch (e) {
      throw Exception('Failed to upload photo: $e');
    }
  }

  Future<Uint8List?> getUserPhoto(String userEmail) async {
    final normalizedEmail = userEmail.trim().toLowerCase();
    final response = await getRawUrl(
      'user/photo/${Uri.encodeComponent(normalizedEmail)}',
    );

    if (response.statusCode == 404) {
      return null;
    }

    if (response.statusCode != 200) {
      debugPrint('Failed to load profile photo: ${response.statusCode}');
      return null;
    }

    // Backend now streams image bytes directly (proxied from R2)
    if (response.bodyBytes.isEmpty) {
      return null;
    }
    return response.bodyBytes;
  }

  Future<UploadNotes> uploadNotes(
    String userEmail,
    String clientEmail,
    String notes,
  ) async {
    try {
      debugPrint("Email with notes: $userEmail + $notes");
      final response = await post(
        'notes',
        body: {
          "userEmail": userEmail,
          "clientEmail": clientEmail,
          "notes": notes,
        },
      );
      debugPrint('${_baseUrl}notes');
      if (response['success'] == true) {
        return UploadNotes(
          success: true,
          title: "Success",
          message:
              response['message']?.toString() ?? "Notes uploaded successfully",
          surfaceColor: Colors.green,
        );
      }

      return UploadNotes(
        success: false,
        title: "Error",
        message: response['message']?.toString() ?? "Notes upload failed",
        surfaceColor: Colors.red,
      );
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

  Future<Map<String, dynamic>> addUpdateInvoicingEmailDetail(
    String userEmail,
    String invoicingBusinessName,
    String invoicingEmail,
    String invoicingEmailAppPassword,
  ) async {
    try {
      await EncryptDecrypt.generateEncryptionKey();
      final generatedKey = await EncryptDecrypt.getSecureEncryptionKey();

      if (generatedKey == null || generatedKey.isEmpty) {
        return {
          'success': false,
          'message': 'Failed to generate encryption key for invoicing email.',
        };
      }

      final encryptedPassword = EncryptDecrypt.encryptPassword(
        invoicingEmailAppPassword,
        generatedKey,
      );
      debugPrint('Posting invoicing email details to backend');

      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
        extra: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Accept': 'application/json',
        },
      );

      final response = await http.post(
        Uri.parse('${_baseUrl}addUpdateInvoicingEmailDetail'),
        headers: headers,
        body: {
          'userEmail': userEmail,
          'invoicingBusinessName': invoicingBusinessName,
          'email': invoicingEmail,
          'encryptedPassword': encryptedPassword,
        },
      );

      debugPrint("Resp: ${response.statusCode}");
      debugPrint("Resp body: ${response.body}");

      final backendMessage = _extractBackendMessage(response.body);
      final lowerMessage = backendMessage.toLowerCase();
      final alreadyExists = lowerMessage.contains('already');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final keyResponse = await http.post(
          Uri.parse('${_baseUrl}invoicingEmailDetailKey'),
          headers: headers,
          body: {'userEmail': userEmail, 'invoicingBusinessKey': generatedKey},
        );
        debugPrint("Key save resp: ${keyResponse.statusCode}");
        debugPrint("Key save body: ${keyResponse.body}");

        return {
          'success': true,
          'message': backendMessage.isNotEmpty
              ? backendMessage
              : 'Invoicing email details added successfully',
        };
      }

      if (response.statusCode == 400 ||
          response.statusCode == 409 ||
          alreadyExists) {
        return {
          'success': false,
          'reason': 'already_exists',
          'message': backendMessage.isNotEmpty
              ? backendMessage
              : 'Invoicing email details already added',
        };
      }

      if (response.statusCode == 401 || response.statusCode == 403) {
        return {
          'success': false,
          'reason': 'unauthorized',
          'message': backendMessage.isNotEmpty
              ? backendMessage
              : 'Unauthorized. Please sign in again.',
        };
      }

      return {
        'success': false,
        'message': backendMessage.isNotEmpty
            ? backendMessage
            : 'Failed to add invoicing email details (HTTP ${response.statusCode})',
      };
    } catch (e) {
      debugPrint("Exception addUpdateInvoicingEmailDetail: $e");
      return {
        'success': false,
        'message': 'An error occurred while adding invoicing email details.',
      };
    }
  }

  String _extractBackendMessage(String responseBody) {
    if (responseBody.trim().isEmpty) return '';
    try {
      final decoded = json.decode(responseBody);
      if (decoded is Map<String, dynamic>) {
        final message = decoded['message'] ?? decoded['error'];
        if (message is String) return message.trim();
      }
    } catch (_) {
      // Ignore parse errors and return empty to use fallback.
    }
    return '';
  }

  Future<Map<String, dynamic>> getInvoicingEmailDetails(
    String email,
    String genKey,
  ) async {
    // try {
    final headers = await _buildJsonHeaders(
      includeAuth: true,
      includeAppCheck: true,
      extra: {'Content-Type': 'application/x-www-form-urlencoded'},
    );
    final response = await http.get(
      Uri.parse('${_baseUrl}getInvoicingEmailDetails?email=$email'),
      headers: headers,
    );

    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> data = Map<String, dynamic>.from(
          json.decode(response.body),
        );
        if (kDebugMode) {
          debugPrint("200" + data['message']);
        }
        debugPrint("Checking message: ${data['message']}");
        // Check if details exist in the response and return them
        if (data['message'] == 'Invoicing email details found') {
          final generatedKey = await EncryptDecrypt.getSecureEncryptionKey();
          if (generatedKey == null) {
            EncryptDecrypt.setSecureEncryptionKey(genKey);
          }
          // Decrypt the password before returning the data
          final keyToUse = generatedKey ?? genKey;
          final decryptedPassword = EncryptDecrypt.decryptPassword(
            data['data']['encryptedPassword'] ?? '',
            keyToUse,
          );
          // Update the data map with the decrypted password
          data['data']['password'] = decryptedPassword.isNotEmpty
              ? decryptedPassword
              : 'Password decryption failed';
          return data;
        } else {
          return {'message': 'No invoicing email details found'};
        }

      case 400:
        Map<String, dynamic> errorData = Map<String, dynamic>.from(
          json.decode(response.body),
        );
        if (kDebugMode) {
          debugPrint("400" + errorData['message']);
        }

        return {'message': 'Error retrieving invoicing email details'};

      default:
        return {'message': 'Unknown error occurred'};
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
    final headers = await _buildJsonHeaders(
      includeAuth: true,
      includeAppCheck: true,
      extra: {'Content-Type': 'application/x-www-form-urlencoded'},
    );
    final response = await http.get(
      Uri.parse('${_baseUrl}checkInvoicingEmailKey?email=$email'),
      headers: headers,
    );

    debugPrint("checkInvoicingEmailKey: ${response.body}");

    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> data = Map<String, dynamic>.from(
          json.decode(response.body),
        );
        if (kDebugMode) {
          debugPrint("200" + data['message']);
        }
        debugPrint("checkInvoicingEmailKey message: ${data['message']}");
        // Check if details exist in the response and return them
        if (data['message'] == 'Invoicing email key found') {
          if (data['key'] == null) {
            return {'message': 'Encryption key empty'};
          }
          return data;
        } else {
          return {'message': 'No invoicing email key found'};
        }

      case 400:
        Map<String, dynamic> errorData = Map<String, dynamic>.from(
          json.decode(response.body),
        );
        if (kDebugMode) {
          debugPrint("400" + errorData['message']);
        }

        return {'message': 'Error retrieving invoicing email key details'};

      default:
        return {'message': 'Unknown error occurred'};
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
    String userEmail,
  ) async {
    try {
      debugPrint(
        "getEmailDetailToSendEmail: $userEmail Uri.parse('${_baseUrl}getEmailDetailToSendEmail')",
      );
      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );
      final response = await http.post(
        Uri.parse('${_baseUrl}getEmailDetailToSendEmail'),
        headers: headers,
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
      final headers = await _buildProtectedJsonHeaders();
      if (headers == null) {
        return {
          'success': false,
          'message': 'Authentication required. Please log in again.',
        };
      }
      final response = await http.get(
        Uri.parse('$_baseUrl/requests'),
        headers: headers,
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> createRequest(
    Map<String, dynamic> requestData,
  ) async {
    try {
      final headers = await _buildProtectedJsonHeaders();
      if (headers == null) {
        return {
          'success': false,
          'message': 'Authentication required. Please log in again.',
        };
      }
      final response = await http.post(
        Uri.parse('$_baseUrl/requests'),
        headers: headers,
        body: jsonEncode(requestData),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> updateRequest(
    Map<String, dynamic> requestData,
  ) async {
    try {
      final headers = await _buildProtectedJsonHeaders();
      if (headers == null) {
        return {
          'success': false,
          'message': 'Authentication required. Please log in again.',
        };
      }
      final response = await http.put(
        Uri.parse('$_baseUrl/requests/${requestData['id']}'),
        headers: headers,
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
      // Compatibility: try legacy endpoint first for environments that still expose it.
      final legacyResponse = await get('getTimerStatus/$userEmail');
      if (legacyResponse['success'] == true &&
          (legacyResponse.containsKey('isRunning') ||
              legacyResponse.containsKey('timer'))) {
        return legacyResponse;
      }
    } catch (e) {
      debugPrint('Legacy getTimerStatus endpoint unavailable: $e');
    }

    try {
      final sharedPrefs = SharedPreferencesUtils();
      await sharedPrefs.init();
      final organizationId = sharedPrefs.getString('organizationId');

      if (organizationId == null || organizationId.trim().isEmpty) {
        return {
          'success': true,
          'isRunning': false,
          'timer': null,
          'message': 'Organization context unavailable for timer status',
        };
      }

      final timersResponse = await get('active-timers/$organizationId');
      if (timersResponse['success'] != true) {
        return {
          'success': false,
          'message':
              timersResponse['message'] ??
              'Failed to fetch active timers for timer status',
        };
      }

      final activeTimers = timersResponse['activeTimers'];
      if (activeTimers is! List) {
        return {'success': true, 'isRunning': false, 'timer': null};
      }

      final userTimers = <Map<String, dynamic>>[];
      for (final timer in activeTimers) {
        if (timer is! Map) continue;
        final timerMap = Map<String, dynamic>.from(timer);
        if (timerMap['userEmail']?.toString() == userEmail) {
          userTimers.add(timerMap);
        }
      }

      if (userTimers.isEmpty) {
        return {'success': true, 'isRunning': false, 'timer': null};
      }

      userTimers.sort((a, b) {
        final aStart = DateTime.tryParse(a['startTime']?.toString() ?? '');
        final bStart = DateTime.tryParse(b['startTime']?.toString() ?? '');
        if (aStart == null && bStart == null) return 0;
        if (aStart == null) return 1;
        if (bStart == null) return -1;
        return bStart.compareTo(aStart);
      });

      return {'success': true, 'isRunning': true, 'timer': userTimers.first};
    } catch (e) {
      return {'success': false, 'message': 'Error getting timer status: $e'};
    }
  }

  Future<Map<String, dynamic>> getActiveTimers(String organizationId) async {
    try {
      return await get('active-timers/$organizationId');
    } catch (e) {
      return {'success': false, 'message': 'Error getting active timers: $e'};
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
      final headers = await _buildProtectedJsonHeaders();
      if (headers == null) {
        return {
          'success': false,
          'message': 'Authentication required. Please log in again.',
        };
      }
      final Map<String, dynamic> requestBody = {'title': title, 'body': body};
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
        headers: headers,
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Notification sent successfully.'};
      } else {
        final errorBody = jsonDecode(response.body);
        return {
          'success': false,
          'message': errorBody['message'] ?? 'Failed to send notification.',
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
        'error_code': 'INVALID_EMAIL',
      };
    }

    try {
      debugPrint('Fetching assignments for user: $userEmail');
      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );
      final response = await http.get(
        Uri.parse(
          '${_baseUrl}getUserAssignments/${Uri.encodeComponent(userEmail)}',
        ),
        headers: headers,
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
                  : response.body,
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
            'Returning decoded response: ${(decodedResponse['assignments']).toString()} ',
          );
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
                : response.body,
          };
        }
      } else {
        debugPrint(
          'Failed to load assignments: ${response.statusCode} - ${response.body}',
        );
        String backendMessage = 'Failed to load user assignments';
        try {
          final decoded = jsonDecode(response.body);
          if (decoded is Map<String, dynamic> &&
              decoded['message'] is String &&
              (decoded['message'] as String).trim().isNotEmpty) {
            backendMessage = decoded['message'] as String;
          }
        } catch (_) {}
        return {
          'success': false,
          'message': backendMessage,
          'assignments': [],
          'error_code': 'HTTP_ERROR_${response.statusCode}',
          'status_code': response.statusCode,
        };
      }
    } catch (e) {
      debugPrint('Exception in getUserAssignments: $e');
      return {
        'success': false,
        'message': 'Error loading user assignments: $e',
        'assignments': [],
        'error_code': 'NETWORK_ERROR',
      };
    }
  }

  /// Fix organizationId for existing client and assignment records
  Future<Map<String, dynamic>> fixClientOrganizationId(
    String userEmail,
    String organizationId,
  ) async {
    try {
      final headers = await _buildProtectedJsonHeaders();
      if (headers == null) {
        return {
          'success': false,
          'message': 'Authentication required. Please log in again.',
        };
      }
      final requestData = {
        'userEmail': userEmail,
        'organizationId': organizationId,
      };

      final response = await http.post(
        Uri.parse('${_baseUrl}fixClientOrganizationId'),
        headers: headers,
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
    String organizationId,
  ) async {
    try {
      final headers = await _buildProtectedJsonHeaders();
      if (headers == null) {
        return {
          'success': false,
          'message': 'Authentication required. Please log in again.',
          'data': null,
        };
      }
      final endpoints = <String>[
        '${_baseUrl}employee-tracking/api/employee-tracking/$organizationId',
        '${_baseUrl}employee-tracking/$organizationId',
        '${_baseUrl}getEmployeeTrackingData/$organizationId',
      ];

      http.Response? response;
      for (final endpoint in endpoints) {
        response = await http.get(Uri.parse(endpoint), headers: headers);
        if (response.statusCode == 200) {
          return jsonDecode(response.body);
        }
        if (response.statusCode != 404) {
          break;
        }
      }

      final statusCode = response?.statusCode ?? 'unknown';
      throw Exception('Failed to load employee tracking data: $statusCode');
    } catch (e) {
      return {
        'success': false,
        'message': 'Error fetching employee tracking data: $e',
        'data': null,
      };
    }
  }

  // ... inside your ApiMethod class

  /// Search NDIS support items by text query and ensure correct typing.
  Future<List<Map<String, dynamic>>> searchSupportItems(String query) async {
    try {
      // URL-encode the query to handle spaces and special characters
      final encodedQuery = Uri.encodeComponent(query);
      final uri = Uri.parse('${_baseUrl}support-items/search?q=$encodedQuery');

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['items'] != null) {
          final List<dynamic> rawItems = data['items'];
          // This is the key part: ensure the list is correctly typed
          final List<Map<String, dynamic>> correctlyTypedItems = rawItems.map((
            item,
          ) {
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
      final response = await http.get(
        Uri.parse('${_baseUrl}support-items/all'),
      );
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
      final headers = await _buildProtectedJsonHeaders();
      if (headers == null) {
        return {
          'success': false,
          'message': 'Authentication required. Please log in again.',
          'validationResults': null,
        };
      }
      final response = await http.post(
        Uri.parse('${_baseUrl}invoice/validate-pricing-realtime'),
        headers: headers,
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
          'Error validating pricing: ${response.statusCode} ${response.body}',
        );
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
    Map<String, dynamic> promptData,
  ) async {
    try {
      final headers = await _buildProtectedJsonHeaders();
      if (headers == null) {
        return {
          'success': false,
          'message': 'Authentication required. Please log in again.',
        };
      }
      final response = await http.post(
        Uri.parse('${_baseUrl}price-prompts/create'),
        headers: headers,
        body: jsonEncode(promptData),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        debugPrint(
          'Error creating price prompt: ${response.statusCode} ${response.body}',
        );
        return {
          'success': false,
          'message': 'Failed to create price prompt: ${response.statusCode}',
        };
      }
    } catch (e) {
      debugPrint('Exception creating price prompt: $e');
      return {'success': false, 'message': 'Error creating price prompt: $e'};
    }
  }

  /// Resolves a price prompt with user-provided price
  Future<Map<String, dynamic>> resolvePricePrompt(
    String promptId,
    Map<String, dynamic> resolution,
  ) async {
    try {
      final headers = await _buildProtectedJsonHeaders();
      if (headers == null) {
        return {
          'success': false,
          'message': 'Authentication required. Please log in again.',
        };
      }
      final response = await http.post(
        Uri.parse('${_baseUrl}price-prompts/resolve'),
        headers: headers,
        body: jsonEncode({'promptId': promptId, 'resolution': resolution}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        debugPrint(
          'Error resolving price prompt: ${response.statusCode} ${response.body}',
        );
        return {
          'success': false,
          'message': 'Failed to resolve price prompt: ${response.statusCode}',
        };
      }
    } catch (e) {
      debugPrint('Exception resolving price prompt: $e');
      return {'success': false, 'message': 'Error resolving price prompt: $e'};
    }
  }

  /// Gets pending price prompts for a session
  Future<Map<String, dynamic>> getPendingPrompts(String sessionId) async {
    try {
      final headers = await _buildProtectedJsonHeaders();
      if (headers == null) {
        return {
          'success': false,
          'message': 'Authentication required. Please log in again.',
          'prompts': [],
        };
      }
      final response = await http.get(
        Uri.parse('${_baseUrl}price-prompts/pending/$sessionId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        debugPrint(
          'Error getting pending prompts: ${response.statusCode} ${response.body}',
        );
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
    String organizationId,
  ) async {
    try {
      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );
      final response = await http.get(
        Uri.parse('${_baseUrl}organization/$organizationId/clients'),
        headers: headers,
      );

      Map<String, dynamic>? data;
      try {
        final decoded = json.decode(response.body);
        if (decoded is Map<String, dynamic>) data = decoded;
      } catch (_) {}

      if (response.statusCode == 200) {
        final dynamic clientsRaw =
            data?['clients'] ??
            (data?['data'] is Map<String, dynamic>
                ? (data?['data'] as Map<String, dynamic>)['clients']
                : null) ??
            data?['data'] ??
            const <dynamic>[];
        if (clientsRaw is List) {
          return clientsRaw
              .whereType<Map>()
              .map((e) => Map<String, dynamic>.from(e))
              .toList();
        }
        return const <Map<String, dynamic>>[];
      }

      if (response.statusCode == 401) {
        throw Exception('AUTH_REQUIRED_401');
      }
      if (response.statusCode == 403) {
        throw Exception('AUTH_FORBIDDEN_403');
      }
      if (response.statusCode == 404) {
        final message = (data?['message'] ?? '').toString().toLowerCase();
        if (message.contains('route not found')) {
          throw Exception('ROUTE_NOT_FOUND_CLIENTS');
        }
        // Treat non-route 404 as no data for this organization in invoice flow.
        return const <Map<String, dynamic>>[];
      }
      if (response.statusCode >= 500) {
        throw Exception('SERVER_ERROR_${response.statusCode}');
      }

      final message = data?['message']?.toString();
      throw Exception(
        message?.isNotEmpty == true ? message : 'CLIENTS_FETCH_FAILED',
      );
    } catch (e) {
      debugPrint('Error getting clients by organization ID: $e');
      if (e is Exception) rethrow;
      throw Exception('CLIENTS_FETCH_FAILED');
    }
  }

  Future<List<Map<String, dynamic>>> getDeletedClientsByOrganizationId(
    String organizationId,
  ) async {
    try {
      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );
      final response = await http.get(
        Uri.parse('${_baseUrl}organization/$organizationId/clients/history'),
        headers: headers,
      );

      Map<String, dynamic>? data;
      try {
        final decoded = json.decode(response.body);
        if (decoded is Map<String, dynamic>) data = decoded;
      } catch (_) {}

      if (response.statusCode == 200) {
        final dynamic clientsRaw =
            data?['clients'] ??
            (data?['data'] is Map<String, dynamic>
                ? (data?['data'] as Map<String, dynamic>)['clients']
                : null) ??
            data?['data'] ??
            const <dynamic>[];
        if (clientsRaw is List) {
          return clientsRaw
              .whereType<Map>()
              .map((e) => Map<String, dynamic>.from(e))
              .toList();
        }
        return const <Map<String, dynamic>>[];
      }

      if (response.statusCode == 401) {
        throw Exception('AUTH_REQUIRED_401');
      }
      if (response.statusCode == 403) {
        throw Exception('AUTH_FORBIDDEN_403');
      }
      if (response.statusCode == 404) {
        final message = (data?['message'] ?? '').toString().toLowerCase();
        if (message.contains('route not found')) {
          throw Exception('ROUTE_NOT_FOUND_CLIENT_HISTORY');
        }
        return const <Map<String, dynamic>>[];
      }
      if (response.statusCode >= 500) {
        throw Exception('SERVER_ERROR_${response.statusCode}');
      }

      final message = data?['message']?.toString();
      throw Exception(
        message?.isNotEmpty == true ? message : 'CLIENT_HISTORY_FETCH_FAILED',
      );
    } catch (e) {
      debugPrint('Error getting deleted clients by organization ID: $e');
      if (e is Exception) rethrow;
      throw Exception('CLIENT_HISTORY_FETCH_FAILED');
    }
  }

  /// Get support item details including description and price caps
  Future<Map<String, dynamic>?> getSupportItemDetails(
    String supportItemNumber,
  ) async {
    try {
      final headers = await _buildProtectedJsonHeaders();
      if (headers == null) {
        debugPrint(
          'Skipping support item details request: authorization header missing',
        );
        return null;
      }
      final response = await http.get(
        Uri.parse('${_baseUrl}pricing/standard-price/$supportItemNumber'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if ((data['success'] == true || data['statusCode'] == 200) &&
            data['data'] != null) {
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
    String organizationId,
    String supportItemNumber, {
    String? clientId,
  }) async {
    try {
      String url =
          '${_baseUrl}pricing/lookup/$organizationId/$supportItemNumber';
      if (clientId != null) {
        url += '?clientId=$clientId';
      }

      final headers = await _buildProtectedJsonHeaders();
      if (headers == null) {
        debugPrint(
          'Skipping pricing lookup request: authorization header missing',
        );
        return null;
      }

      final sw = Stopwatch()..start();
      DebugLog.networkRequest(
        'GET',
        url,
        payload: {
          'organizationId': organizationId,
          'supportItemNumber': supportItemNumber,
          'clientId': ?clientId,
        },
      );
      final response = await http.get(Uri.parse(url), headers: headers);
      sw.stop();
      dynamic body;
      try {
        body = response.body.isNotEmpty ? json.decode(response.body) : null;
      } catch (_) {
        body = {'raw': response.body};
      }
      DebugLog.networkResponse(
        url,
        response.statusCode,
        body: body,
        durationMs: sw.elapsedMilliseconds,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['statusCode'] == 200 && data['data'] != null) {
          return Map<String, dynamic>.from(data['data']);
        }
      }
      return null;
    } catch (e) {
      debugPrint('Exception getting pricing lookup: $e');
      DebugLog.error(
        'Exception getting pricing lookup',
        details: {
          'organizationId': organizationId,
          'supportItemNumber': supportItemNumber,
          'clientId': ?clientId,
          'error': e.toString(),
        },
      );
      return null;
    }
  }

  /// Get bulk pricing lookup for multiple NDIS items including metadata.
  ///
  /// Returns `{data, metadata}` where:
  /// - `data`: map keyed by support item number
  /// - `metadata`: summary data from backend (includes fallback base rate)
  Future<Map<String, dynamic>?> getBulkPricingLookupResponse(
    String organizationId,
    List<String> supportItemNumbers, {
    String? clientId,
  }) async {
    try {
      if (supportItemNumbers.isEmpty) {
        return {'data': <String, dynamic>{}, 'metadata': <String, dynamic>{}};
      }

      final url = '${_baseUrl}pricing/bulk-lookup';
      final body = {
        'organizationId': organizationId,
        'supportItemNumbers': supportItemNumbers,
      };

      if (clientId != null) {
        body['clientId'] = clientId;
      }

      final headers = await _buildProtectedJsonHeaders();
      if (headers == null) {
        debugPrint(
          'Skipping bulk pricing lookup request: authorization missing',
        );
        return null;
      }

      final sw = Stopwatch()..start();
      DebugLog.networkRequest('POST', url, payload: body);
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body),
      );
      sw.stop();
      dynamic respBody;
      try {
        respBody = response.body.isNotEmpty ? json.decode(response.body) : null;
      } catch (_) {
        respBody = {'raw': response.body};
      }
      DebugLog.networkResponse(
        url,
        response.statusCode,
        body: respBody,
        durationMs: sw.elapsedMilliseconds,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['statusCode'] == 200 && data['data'] != null) {
          return {
            'data': Map<String, dynamic>.from(data['data'] as Map),
            'metadata': data['metadata'] is Map
                ? Map<String, dynamic>.from(data['metadata'] as Map)
                : <String, dynamic>{},
          };
        }
      }
      return null;
    } catch (e) {
      debugPrint('Exception getting bulk pricing lookup: $e');
      DebugLog.error(
        'Bulk pricing lookup failed',
        details: {
          'organizationId': organizationId,
          'supportItemNumbers': supportItemNumbers,
          'clientId': ?clientId,
          'error': e.toString(),
        },
      );
      return null;
    }
  }

  /// Get bulk pricing lookup for multiple NDIS items.
  ///
  /// Backward-compatible helper that returns only the `data` map keyed by
  /// support item numbers.
  Future<Map<String, dynamic>?> getBulkPricingLookup(
    String organizationId,
    List<String> supportItemNumbers, {
    String? clientId,
  }) async {
    final response = await getBulkPricingLookupResponse(
      organizationId,
      supportItemNumbers,
      clientId: clientId,
    );
    if (response == null) return null;
    final data = response['data'];
    if (data is Map<String, dynamic>) {
      return data;
    }
    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }
    return <String, dynamic>{};
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
    String userEmail, {
    String? supportItemName,
  }) async {
    try {
      final resolvedName =
          (supportItemName != null && supportItemName.trim().isNotEmpty)
          ? supportItemName
          : 'Item $supportItemNumber';
      final url = '${_baseUrl}pricing/create';
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
      final headers = await _buildProtectedJsonHeaders();
      if (headers == null) {
        return {
          'success': false,
          'message': 'Authentication required to save custom pricing',
        };
      }
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(payload),
      );
      sw.stop();

      final responseBody = response.body.isNotEmpty
          ? json.decode(response.body)
          : {};
      DebugLog.networkResponse(
        url,
        response.statusCode,
        body: responseBody,
        durationMs: sw.elapsedMilliseconds,
      );

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
      DebugLog.error(
        'Exception saving custom pricing',
        details: {
          'organizationId': organizationId,
          'supportItemNumber': supportItemNumber,
          'price': price,
          'pricingType': pricingType,
          'userEmail': userEmail,
          'supportItemName': ?supportItemName,
          'error': e.toString(),
        },
      );
      return {'success': false, 'message': 'Error saving custom pricing: $e'};
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
    String userEmail, {
    String? supportItemName,
  }) async {
    try {
      final resolvedName =
          (supportItemName != null && supportItemName.trim().isNotEmpty)
          ? supportItemName
          : 'Item $supportItemNumber';
      final url = '${_baseUrl}pricing/create';
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
      final headers = await _buildProtectedJsonHeaders();
      if (headers == null) {
        return {
          'success': false,
          'message': 'Authentication required to save client custom pricing',
        };
      }
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(payload),
      );
      sw.stop();

      final responseBody = response.body.isNotEmpty
          ? json.decode(response.body)
          : {};
      DebugLog.networkResponse(
        url,
        response.statusCode,
        body: responseBody,
        durationMs: sw.elapsedMilliseconds,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'message':
              responseBody['message'] ??
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
      DebugLog.error(
        'Exception saving client custom pricing',
        details: {
          'organizationId': organizationId,
          'clientId': clientId,
          'supportItemNumber': supportItemNumber,
          'price': price,
          'pricingType': pricingType,
          'userEmail': userEmail,
          'supportItemName': ?supportItemName,
          'error': e.toString(),
        },
      );
      return {
        'success': false,
        'message': 'Error saving client custom pricing: $e',
      };
    }
  }

  /// Remove custom pricing for an NDIS item
  Future<Map<String, dynamic>> removeCustomPricing(
    String organizationId,
    String supportItemNumber,
  ) async {
    try {
      // Get user email from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userEmail = prefs.getString('userEmail');

      if (userEmail == null) {
        return {'success': false, 'message': 'User email not found'};
      }

      // First, get the custom pricing record to find its ID
      final lookupResponse = await getPricingLookup(
        organizationId,
        supportItemNumber,
      );

      if (lookupResponse == null || lookupResponse['customPricing'] == null) {
        return {
          'success': false,
          'message': 'No custom pricing found for this item',
        };
      }

      final customPricing = lookupResponse['customPricing'];
      final pricingId = customPricing['_id'];

      if (pricingId == null) {
        return {'success': false, 'message': 'Custom pricing ID not found'};
      }

      // Delete the custom pricing record
      final url = '${_baseUrl}pricing/$pricingId';
      final sw = Stopwatch()..start();
      DebugLog.networkRequest('DELETE', url);
      final headers = await _buildProtectedJsonHeaders();
      if (headers == null) {
        return {
          'success': false,
          'message': 'Authentication required to remove custom pricing',
        };
      }
      final response = await http.delete(Uri.parse(url), headers: headers);
      sw.stop();

      final responseBody = response.body.isNotEmpty
          ? json.decode(response.body)
          : {};
      DebugLog.networkResponse(
        url,
        response.statusCode,
        body: responseBody,
        durationMs: sw.elapsedMilliseconds,
      );

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
      DebugLog.error(
        'Exception removing custom pricing',
        details: {
          'organizationId': organizationId,
          'supportItemNumber': supportItemNumber,
          'error': e.toString(),
        },
      );
      return {'success': false, 'message': 'Error removing custom pricing: $e'};
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
  Future<Map<String, dynamic>> updateCustomPricing({
    required String pricingId,
    double? price,
    String pricingType = 'fixed',
    required String userEmail,
    String? supportItemName,
    double? multiplier,
    String? clientId,
    bool? clientSpecific,
  }) async {
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

      final url = '${_baseUrl}pricing/$pricingId';
      final sw = Stopwatch()..start();
      DebugLog.networkRequest('PUT', url, payload: payload);
      final headers = await _buildProtectedJsonHeaders();
      if (headers == null) {
        return {
          'success': false,
          'message': 'Authentication required to update custom pricing',
        };
      }
      final response = await http.put(
        Uri.parse(url),
        headers: headers,
        body: json.encode(payload),
      );
      sw.stop();

      final responseBody = response.body.isNotEmpty
          ? json.decode(response.body)
          : {};
      DebugLog.networkResponse(
        url,
        response.statusCode,
        body: responseBody,
        durationMs: sw.elapsedMilliseconds,
      );

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
      DebugLog.error(
        'Exception updating custom pricing',
        details: {
          'pricingId': pricingId,
          'price': price,
          'pricingType': pricingType,
          'userEmail': userEmail,
          'supportItemName': ?supportItemName,
          'multiplier': ?multiplier,
          'clientId': ?clientId,
          'clientSpecific': ?clientSpecific,
          'error': e.toString(),
        },
      );
      return {'success': false, 'message': 'Error updating custom pricing: $e'};
    }
  }

  /// Enhanced secure login method with device information and security context
  Future<Map<String, dynamic>> secureLogin(
    Map<String, dynamic> loginData,
  ) async {
    try {
      final String email = loginData['email'];
      final requestBody = Map<String, dynamic>.from(loginData);

      // Modern auth flow: backend expects plain password at /api/auth/login.
      final headers = await _buildJsonHeaders(includeAppCheck: true);
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
          final String? tokenCandidate =
              (payload['token'] ??
                      payload['accessToken'] ??
                      data['token'] ??
                      data['accessToken'])
                  as String?;
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
              'secureLogin: No token present in response. Keys present in payload: ${payload.keys.toList()}',
            );
          }

          if (userMap.isNotEmpty) {
            final resolvedRole = UserRoleResolver.resolve(
              role: userMap['role'],
              roles: userMap['roles'],
              organizationRole: userMap['organizationRole'],
              clientId: userMap['clientId']?.toString(),
            );
            final roleTags = UserRoleResolver.collectRoleTags(
              role: userMap['role'],
              roles: userMap['roles'],
              organizationRole: userMap['organizationRole'],
            );
            debugPrint(
              "secureLogin role: $resolvedRole tags=$roleTags organizationRole=${userMap['organizationRole']}",
            );

            // Save user email and organization ID to SharedPreferences
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('userEmail', email);
            await prefs.setString(
              'role',
              resolvedRole.toString().split('.').last,
            );
            if (userMap['organizationId'] != null) {
              await prefs.setString(
                'organizationId',
                userMap['organizationId'],
              );
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
              'role': resolvedRole.toString().split('.').last,
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
            "secureLogin 429: Rate limit exceeded - ${data['message']}",
          );
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
            "secureLogin unexpected status code: ${response.statusCode}",
          );
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
    Map<String, dynamic> logEntry,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('${_baseUrl}auth/security-log'),
        headers: await _buildJsonHeaders(includeAppCheck: true),
        body: json.encode(logEntry),
      );

      return _handleResponse(response);
    } catch (e) {
      debugPrint('Security log send error: $e');
      return {'success': false, 'message': 'Failed to send security log: $e'};
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
        'bsb': bsb.replaceAll('-', ''),
        'accountNumber': accountNumber,
      };

      // Use generic POST to ensure proper headers and base URL handling
      return await post(
        'bank-details/saveBankDetails',
        body: body,
        headers: {'x-organization-id': organizationId},
      );
    } catch (e) {
      debugPrint('saveBankDetails error: $e');
      return {'success': false, 'message': 'Failed to save bank details: $e'};
    }
  }

  bool _isMissingBankDetailsResponse(Map<String, dynamic> response) {
    final statusCode = response['statusCode'] is int
        ? response['statusCode'] as int
        : int.tryParse(response['statusCode']?.toString() ?? '');
    final message = (response['message'] ?? '').toString().toLowerCase();
    final details = (response['details'] ?? '').toString().toLowerCase();
    final code = (response['code'] ?? '').toString().toLowerCase();

    final routeNotFoundForBankDetails =
        message.contains('route not found') &&
        (message.contains('getbankdetails') ||
            message.contains('bank-details'));

    return statusCode == 404 ||
        code == 'bank_details_not_set' ||
        message.contains('bank details not found') ||
        message.contains('bank details are not set') ||
        routeNotFoundForBankDetails ||
        details.contains('getbankdetails') ||
        details.contains('bank-details/getbankdetails');
  }

  Map<String, dynamic> _normalizeBankDetailsGetResponse(
    Map<String, dynamic> response,
  ) {
    if (response['success'] == true) return response;
    if (!_isMissingBankDetailsResponse(response)) return response;

    final normalized = Map<String, dynamic>.from(response);
    normalized['success'] = false;
    normalized['code'] = 'BANK_DETAILS_NOT_SET';
    normalized['message'] =
        'Bank details are not set yet. Add bank details to continue.';
    return normalized;
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
          'bank-details/getBankDetails?userEmail=${Uri.encodeQueryComponent(userEmail)}&organizationId=${Uri.encodeQueryComponent(organizationId)}';
      final response = await get(
        endpoint,
        headers: {'x-organization-id': organizationId},
      );
      return _normalizeBankDetailsGetResponse(response);
    } catch (e) {
      debugPrint('getBankDetails error: $e');
      return {'success': false, 'message': 'Failed to load bank details: $e'};
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
    String targetUserEmail,
    String organizationId,
  ) async {
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
          'bank-details/getBankDetails?userEmail=${Uri.encodeQueryComponent(targetUserEmail)}&organizationId=${Uri.encodeQueryComponent(organizationId)}';
      final response = await get(
        endpoint,
        headers: {'x-organization-id': organizationId},
      );
      return _normalizeBankDetailsGetResponse(response);
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
    String organizationId,
  ) async {
    try {
      if (organizationId.isEmpty) {
        return {
          'success': false,
          'message': 'Missing organizationId parameter',
        };
      }

      final url = '${_baseUrl}getOrganizationAssignments/$organizationId';
      debugPrint('Fetching organization assignments from: $url');

      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );

      final response = await http.get(Uri.parse(url), headers: headers);

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

  Future<Map<String, dynamic>> patch(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final uri = _buildUri(endpoint);
      final fullUrl = uri.toString();

      debugPrint('=== API METHOD DEBUG: PATCH request to: $fullUrl ===');
      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );

      debugPrint(
        '=== API METHOD DEBUG: PATCH auth header present: ${headers.containsKey('Authorization')} ===',
      );
      if (body != null) {
        debugPrint(
          '=== API METHOD DEBUG: PATCH body: ${json.encode(body)} ===',
        );
      }

      final response = await http.patch(
        uri,
        headers: headers,
        body: body != null ? json.encode(body) : null,
      );

      debugPrint(
        '=== API METHOD DEBUG: PATCH status: ${response.statusCode} ===',
      );
      debugPrint('=== API METHOD DEBUG: PATCH response: ${response.body} ===');

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
    String organizationId,
    String userEmail,
  ) async {
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
      final headers = await _buildProtectedJsonHeaders();
      if (headers == null) {
        return {
          'success': false,
          'message': 'Authentication required. Please log in again.',
        };
      }
      final response = await http.get(
        Uri.parse('${_baseUrl}leave/public-holidays'),
        headers: headers,
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
      final uri = Uri.parse('${_baseUrl}config/tax-brackets');
      var headers = await _buildProtectedJsonHeaders();
      if (headers == null) {
        throw Exception('Failed to load tax settings: missing authorization');
      }

      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 401) {
        debugPrint(
          'Tax settings request returned 401, retrying with a refreshed Firebase token.',
        );
        headers = await _buildProtectedJsonHeaders(forceAuthRefresh: true);
        if (headers != null) {
          response = await http.get(uri, headers: headers);
        }
      }

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
    Map<String, dynamic> shiftData,
  ) async {
    try {
      final url = '${_baseUrl}schedule/shift';
      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );

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

      DebugLog.networkResponse(
        url,
        response.statusCode,
        body: responseBody,
        durationMs: sw.elapsedMilliseconds,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return {'success': true, ...responseBody};
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
      DebugLog.error(
        'Exception creating shift',
        details: {'error': e.toString()},
      );
      return {'success': false, 'error': 'Error creating shift: $e'};
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
      final url = '${_baseUrl}schedule/bulk';
      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );

      final payload = {'organizationId': organizationId, 'shifts': shifts};

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

      DebugLog.networkResponse(
        url,
        response.statusCode,
        body: responseBody,
        durationMs: sw.elapsedMilliseconds,
      );

      return {
        'success': response.statusCode == 201 || response.statusCode == 207,
        ...responseBody,
      };
    } catch (e) {
      debugPrint('Exception in bulk create shifts: $e');
      return {'success': false, 'error': 'Error creating shifts: $e'};
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
        'clientEmail': ?clientEmail,
        if (startTime != null) 'startTime': startTime.toIso8601String(),
        if (endTime != null) 'endTime': endTime.toIso8601String(),
        if (requiredSkills != null && requiredSkills.isNotEmpty)
          'requiredSkills': requiredSkills.join(','),
        if (latitude != null) 'latitude': latitude.toString(),
        if (longitude != null) 'longitude': longitude.toString(),
      };

      final uri = Uri.parse(
        '${_baseUrl}schedule/recommendations',
      ).replace(queryParameters: queryParams);

      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );

      final sw = Stopwatch()..start();
      DebugLog.networkRequest('GET', uri.toString(), payload: queryParams);

      final response = await http.get(uri, headers: headers);

      sw.stop();
      final responseBody = response.body.isNotEmpty
          ? json.decode(response.body)
          : <String, dynamic>{};

      DebugLog.networkResponse(
        uri.toString(),
        response.statusCode,
        body: responseBody,
        durationMs: sw.elapsedMilliseconds,
      );

      if (response.statusCode == 200) {
        return {'success': true, ...responseBody};
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
        'status': ?status,
        'employeeEmail': ?employeeEmail,
        'clientEmail': ?clientEmail,
      };

      final uri = Uri.parse(
        '${_baseUrl}schedule/shifts/$organizationId',
      ).replace(queryParameters: queryParams.isNotEmpty ? queryParams : null);

      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );

      final sw = Stopwatch()..start();
      DebugLog.networkRequest('GET', uri.toString(), payload: queryParams);

      final response = await http.get(uri, headers: headers);

      sw.stop();
      final responseBody = response.body.isNotEmpty
          ? json.decode(response.body)
          : <String, dynamic>{};

      DebugLog.networkResponse(
        uri.toString(),
        response.statusCode,
        body: responseBody,
        durationMs: sw.elapsedMilliseconds,
      );

      if (response.statusCode == 200) {
        return {'success': true, ...responseBody};
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
      final url = '${_baseUrl}schedule/shift/$shiftId';
      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );

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
      final url = '${_baseUrl}schedule/shift/$shiftId';
      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );

      final response = await http.delete(Uri.parse(url), headers: headers);

      final responseBody = response.body.isNotEmpty
          ? json.decode(response.body)
          : <String, dynamic>{};

      return {'success': response.statusCode == 200, ...responseBody};
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
      final url = '${_baseUrl}schedule/check-conflicts';
      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );

      final payload = {
        'employeeId': ?employeeId,
        'employeeEmail': employeeEmail,
        'startTime': startTime.toIso8601String(),
        'endTime': endTime.toIso8601String(),
        'excludeShiftId': ?excludeShiftId,
      };

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(payload),
      );

      final responseBody = response.body.isNotEmpty
          ? json.decode(response.body)
          : <String, dynamic>{};

      return {'success': response.statusCode == 200, ...responseBody};
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

      final url = '${_baseUrl}invoices?$queryString';
      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );

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
      final url = '${_baseUrl}invoices/$invoiceId/payment-status';
      final headers = await _buildJsonHeaders(
        includeAuth: true,
        includeAppCheck: true,
      );

      final body = {
        'organizationId': organizationId,
        'status': status,
        'notes': ?notes,
        'paidAmount': ?paidAmount,
        'updatedBy': ?updatedBy,
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

  Future<Map<String, dynamic>> parseReceiptText(
    String rawText, {
    String source = 'google_mlkit',
  }) async {
    try {
      final body = {'rawText': rawText, 'source': source};
      final primary = await post('expenses/parse-receipt', body: body);
      if (primary['success'] == true) {
        return primary;
      }
      final statusCode = primary['statusCode'];
      final message = '${primary['message'] ?? ''} ${primary['details'] ?? ''}';
      final looksMissing =
          statusCode == 404 || message.contains('Route not found');
      if (looksMissing) {
        return await post('ocr/parse', body: body);
      }
      return primary;
    } catch (e) {
      debugPrint('Error parsing receipt text: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  // ==================== INTEGRATION METHODS ====================

  /// Get all integrations for an organization
  Future<Map<String, dynamic>> getOrganizationIntegrations(
    String organizationId,
  ) async {
    try {
      final endpoint = 'integrations/$organizationId';
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
      final endpoint = 'integrations/$organizationId/connect';
      final body = {
        'integrationType': integrationType,
        'apiKey': ?apiKey,
        'accessToken': ?accessToken,
        'refreshToken': ?refreshToken,
        'metadata': ?metadata,
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
      final endpoint = 'integrations/$organizationId/disconnect';
      final body = {'integrationType': integrationType};
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
      final endpoint = 'integrations/$organizationId/auth-url';
      final body = {
        'integrationType': integrationType,
        'redirectUri': ?redirectUri,
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
      final endpoint = 'integrations/$organizationId/callback';
      final body = {
        'integrationType': integrationType,
        'code': code,
        'state': ?state,
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
      final endpoint = 'integrations/$organizationId/sync';
      final body = {'integrationType': integrationType, 'options': ?options};
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
      final endpoint = 'integrations/$organizationId/test';
      final body = {'integrationType': integrationType};
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
          'integrations/$organizationId/sync-history/$integrationType${limit != null ? '?limit=$limit' : ''}';
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
      final endpoint = 'integrations/$organizationId/settings';
      final body = {'integrationType': integrationType, 'settings': settings};
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
      final endpoint = 'bulk/approve-timesheets';
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
      final endpoint = 'bulk/reject-timesheets';
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
      final endpoint = 'bulk/preview-invoices';
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
      final endpoint = 'bulk/generate-invoices';
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
      final endpoint = 'bulk/suggest-assignments';
      final body = {'shiftIds': shiftIds, 'organizationId': organizationId};
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
      final endpoint = 'bulk/assign-shifts';
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
      final endpoint = 'bulk/send-messages';
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
      final endpoint = 'bulk/schedule-messages';
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
      final endpoint = 'scheduling/match-workers';
      final body = {
        'shiftId': shiftId,
        'organizationId': organizationId,
        'criteria': ?criteria,
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
      final endpoint = 'scheduling/auto-fill';
      final body = {
        'shiftIds': shiftIds,
        'organizationId': organizationId,
        'criteria': ?criteria,
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
      final endpoint = 'scheduling/optimize-route';
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
          'scheduling/recommendations/$shiftId?organizationId=$organizationId';
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
      final endpoint = 'invoice-ai/validate';
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
      final endpoint = 'invoice-ai/detect-anomalies';
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
      final endpoint = 'invoice-ai/payment-prediction/$invoiceId';
      return await get(endpoint);
    } catch (e) {
      debugPrint('Error predicting payment date: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Auto-generate invoices for a period
  Future<Map<String, dynamic>> autoGenerateInvoices({
    required String organizationId,
    DateTime? startDate,
    DateTime? endDate,
    bool validateBeforeGeneration = true,
    bool groupByClient = false,
    bool forceManual = false,
  }) async {
    try {
      final endpoint = 'invoice-ai/auto-generate';
      final body = {
        'organizationId': organizationId,
        if (startDate != null) 'startDate': startDate.toIso8601String(),
        if (endDate != null) 'endDate': endDate.toIso8601String(),
        'validateBeforeGeneration': validateBeforeGeneration,
        'groupByClient': groupByClient,
        'forceManual': forceManual,
      };
      return await post(endpoint, body: body);
    } catch (e) {
      debugPrint('Error auto-generating invoices: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Generate invoice from free text prompt
  Future<Map<String, dynamic>> generateFromText({
    required String organizationId,
    required String textNote,
  }) async {
    try {
      final endpoint = 'invoice-ai/generate-from-text';
      final body = {'organizationId': organizationId, 'textNote': textNote};
      return await post(endpoint, body: body);
    } catch (e) {
      debugPrint('Error generating invoice from text: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Get smart reminders for an invoice
  Future<Map<String, dynamic>> getSmartReminders({
    required String invoiceId,
  }) async {
    try {
      final endpoint = 'invoice-ai/smart-reminders/$invoiceId';
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
      final endpoint = 'compliance/scan/$organizationId';
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
      final endpoint = 'compliance/score/$workerId';
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
          'compliance/expiring/$organizationId${daysAhead != null ? '?daysAhead=$daysAhead' : ''}';
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
      final endpoint = 'compliance/report';
      final body = {'organizationId': organizationId, 'reportType': reportType};
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
          'compliance/trends/$organizationId${months != null ? '?months=$months' : ''}';
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
      final endpoint = 'expenses/scan-receipt';
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
      final endpoint = 'expenses/categorize';
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
      final endpoint = 'expenses/validate-policy';
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
      final endpoint = 'expenses/detect-duplicate';
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
      final endpoint = 'expenses/calculate-mileage';
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
      final endpoint = 'offline/queue';
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
      final endpoint = 'offline/sync';
      final body = {'userId': userId, 'queueItems': queueItems};
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
      final endpoint = 'offline/data/$userId';
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
      final endpoint = 'offline/resolve-conflict';
      final body = {
        'conflictId': conflictId,
        'resolution': resolution,
        'mergedData': ?mergedData,
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
      final endpoint = 'client-portal/dashboard/$clientId';
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
      final endpoint = 'client-portal/worker-location/$appointmentId';
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
      final endpoint = 'client-portal/appointment-status/$appointmentId';
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
      final endpoint = 'client-portal/message';
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
      final endpoint = 'client-portal/feedback';
      return await post(endpoint, body: feedbackData);
    } catch (e) {
      debugPrint('Error submitting feedback: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Get feedback feed for current authenticated admin/employee
  Future<Map<String, dynamic>> getFeedbackFeed({int limit = 20}) async {
    try {
      final primaryEndpoint = 'client-portal/feedback-feed?limit=$limit';
      final primaryResponse = await get(primaryEndpoint);

      if (primaryResponse['success'] == true) {
        return primaryResponse;
      }

      final statusCode = primaryResponse['statusCode'];
      final message =
          primaryResponse['message']?.toString().toLowerCase() ?? '';
      final shouldFallback =
          statusCode == 404 ||
          message.contains('route not found') ||
          message.contains('cannot get');

      if (!shouldFallback) {
        return primaryResponse;
      }

      final fallbackEndpoint =
          'client-portal-enhanced/feedback-feed?limit=$limit';
      final fallbackResponse = await get(fallbackEndpoint);

      if (fallbackResponse['success'] == true) {
        return fallbackResponse;
      }

      return fallbackResponse['message'] == null
          ? {
              ...fallbackResponse,
              'message':
                  primaryResponse['message'] ?? 'Failed to load feedback feed',
            }
          : fallbackResponse;
    } catch (e) {
      debugPrint('Error getting feedback feed: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Get service history for client
  Future<Map<String, dynamic>> getServiceHistory({
    required String clientId,
    int? limit,
  }) async {
    try {
      final query = limit != null ? '?limit=$limit' : '';
      final endpoint = 'client-portal/service-history/$clientId$query';
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
      final endpoint = 'payroll-advanced/calculate';
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
      final endpoint = 'payroll-advanced/payslip/$userId/$period';
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
      final endpoint = 'payroll-advanced/generate-payslips';
      final body = {'organizationId': organizationId, 'period': period};
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
      final endpoint = 'payroll-advanced/summary/$organizationId/$period';
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
      final endpoint = 'payroll-advanced/export';
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
      final endpoint = 'communication/send';
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
      final endpoint = 'communication/conversations/$userId';
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
      final endpoint = 'communication/messages/$conversationId';
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
      final endpoint = 'communication/broadcast';
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
      final endpoint = 'communication/schedule';
      return await post(endpoint, body: scheduleData);
    } catch (e) {
      debugPrint('Error scheduling message: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Get available message templates
  Future<Map<String, dynamic>> getMessageTemplates() async {
    try {
      final endpoint = 'communication/templates';
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
      final endpoint = 'communication/status/$messageId';
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
      'realtime-portal/tracking/start',
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
      'realtime-portal/tracking/update',
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
      'realtime-portal/tracking/stop',
      body: {'appointmentId': appointmentId},
    );
  }

  /// Get live tracking data
  Future<Map<String, dynamic>> getLiveTracking({
    required String appointmentId,
  }) async {
    return await get('realtime-portal/tracking/live/$appointmentId');
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
      'realtime-portal/messages/send',
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

    return await get('realtime-portal/messages/$conversationId$query');
  }

  /// Create real-time conversation
  Future<Map<String, dynamic>> createRealtimeConversation({
    required String appointmentId,
    required String clientId,
    required String workerId,
    required String organizationId,
  }) async {
    return await post(
      'realtime-portal/conversations/create',
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
    return await get('realtime-portal/conversations/user/$userId');
  }

  /// Save digital signature
  Future<Map<String, dynamic>> saveDigitalSignature({
    required String appointmentId,
    required String clientId,
    required String signatureData,
  }) async {
    return await post(
      'realtime-portal/signature/save',
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
      'realtime-portal/service-confirmation/submit',
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
    return await get('realtime-portal/service-confirmation/$appointmentId');
  }

  /// Get checklist template
  Future<Map<String, dynamic>> getChecklistTemplate({
    required String serviceType,
  }) async {
    return await get('realtime-portal/checklist/$serviceType');
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
      'realtime-portal/family/invite',
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
    return await get('realtime-portal/family/members/$clientId');
  }

  /// Get own family permissions (self-lookup for family members)
  Future<Map<String, dynamic>> getMyFamilyPermissions({
    required String clientId,
  }) async {
    return await get('realtime-portal/family/my-permissions/$clientId');
  }

  /// Update family permissions
  Future<Map<String, dynamic>> updateFamilyPermissions({
    required String clientId,
    required String memberId,
    required Map<String, dynamic> permissions,
    required String updatedBy,
  }) async {
    return await put(
      'realtime-portal/family/permissions',
      body: {
        'clientId': clientId,
        'memberId': memberId,
        'permissions': permissions,
        'updatedBy': updatedBy,
      },
    );
  }

  /// Update family member status
  Future<Map<String, dynamic>> updateFamilyMemberStatus({
    required String clientId,
    required String memberId,
    required String status,
    String? updatedBy,
  }) async {
    return await put(
      'realtime-portal/family/status',
      body: {
        'clientId': clientId,
        'memberId': memberId,
        'status': status,
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

    return await get('realtime-portal/family/access-log/$clientId$query');
  }

  // ============================================================================
  // Workforce Optimization API Methods
  // ============================================================================

  // Workforce Planning
  Future<Map<String, dynamic>> forecastDemand(
    Map<String, dynamic> params,
  ) async {
    return await post('workforce/planning/forecast', body: params);
  }

  Future<Map<String, dynamic>> optimizeStaffing(
    Map<String, dynamic> params,
  ) async {
    return await post('workforce/planning/optimize', body: params);
  }

  Future<Map<String, dynamic>> predictTurnover(
    Map<String, dynamic> params,
  ) async {
    return await post('workforce/planning/turnover', body: params);
  }

  Future<Map<String, dynamic>> analyzeScenarios(
    Map<String, dynamic> params,
  ) async {
    return await post('workforce/planning/scenarios', body: params);
  }

  // Resource Allocation
  Future<Map<String, dynamic>> optimizeAllocation(
    Map<String, dynamic> params,
  ) async {
    return await post('workforce/allocation/optimize', body: params);
  }

  Future<Map<String, dynamic>> reallocateResources(
    Map<String, dynamic> params,
  ) async {
    return await post('workforce/allocation/reallocate', body: params);
  }

  Future<Map<String, dynamic>> getAllocationRecommendations({
    required String appointmentId,
    required String organizationId,
  }) async {
    return await get(
      'workforce/allocation/recommendations/$appointmentId?organizationId=$organizationId',
    );
  }

  Future<Map<String, dynamic>> analyzeWorkloadBalance({
    required String organizationId,
    required String startDate,
    required String endDate,
  }) async {
    return await get(
      'workforce/allocation/workload-balance?organizationId=$organizationId&startDate=$startDate&endDate=$endDate',
    );
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
    return await get('workforce/performance/analytics?$query');
  }

  Future<Map<String, dynamic>> analyzePerformanceTrends({
    required String employeeId,
    required String organizationId,
    String? period,
  }) async {
    String query = 'organizationId=$organizationId';
    if (period != null) query += '&period=$period';
    return await get('workforce/performance/trends/$employeeId?$query');
  }

  Future<Map<String, dynamic>> predictPerformance(
    Map<String, dynamic> params,
  ) async {
    return await post('workforce/performance/predict', body: params);
  }

  Future<Map<String, dynamic>> trackSkillProficiency({
    required String employeeId,
    required String organizationId,
  }) async {
    return await get(
      'workforce/performance/skills/$employeeId?organizationId=$organizationId',
    );
  }

  // Quality Assurance
  Future<Map<String, dynamic>> scoreServiceQuality(
    Map<String, dynamic> params,
  ) async {
    return await post('workforce/quality/score', body: params);
  }

  Future<Map<String, dynamic>> performComplianceCheck(
    Map<String, dynamic> params,
  ) async {
    return await post('workforce/quality/compliance-check', body: params);
  }

  Future<Map<String, dynamic>> analyzeFeedbackSentiment(
    Map<String, dynamic> params,
  ) async {
    return await post('workforce/quality/sentiment', body: params);
  }

  Future<Map<String, dynamic>> assessRisk(Map<String, dynamic> params) async {
    return await post('workforce/quality/risk-assessment', body: params);
  }

  Future<Map<String, dynamic>> detectIncidentPatterns({
    required String organizationId,
    required String startDate,
    required String endDate,
  }) async {
    return await get(
      'workforce/quality/incident-patterns?organizationId=$organizationId&startDate=$startDate&endDate=$endDate',
    );
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
    return await get('workforce/quality/audit-trail?$query');
  }

  // Business Intelligence
  Future<Map<String, dynamic>> getExecutiveDashboard({
    required String organizationId,
    String? period,
  }) async {
    String query = 'organizationId=$organizationId';
    if (period != null) query += '&period=$period';
    return await get('workforce/bi/dashboard?$query');
  }

  Future<Map<String, dynamic>> forecastRevenue(
    Map<String, dynamic> params,
  ) async {
    return await post('workforce/bi/forecast-revenue', body: params);
  }

  Future<Map<String, dynamic>> predictChurn(Map<String, dynamic> params) async {
    return await post('workforce/bi/predict-churn', body: params);
  }

  Future<Map<String, dynamic>> analyzeProfitability({
    required String organizationId,
    required String dimension,
    required String startDate,
    required String endDate,
  }) async {
    return await get(
      'workforce/bi/profitability?organizationId=$organizationId&dimension=$dimension&startDate=$startDate&endDate=$endDate',
    );
  }

  Future<Map<String, dynamic>> analyzeWhatIfScenario(
    Map<String, dynamic> params,
  ) async {
    return await post('workforce/bi/what-if', body: params);
  }

  Future<Map<String, dynamic>> calculateCustomerLifetimeValue({
    required String organizationId,
    String? clientId,
  }) async {
    String query = 'organizationId=$organizationId';
    if (clientId != null) query += '&clientId=$clientId';
    return await get('workforce/bi/customer-lifetime-value?$query');
  }

  // ML Models
  Future<Map<String, dynamic>> trainModel(Map<String, dynamic> params) async {
    return await post('workforce/ml/train', body: params);
  }

  Future<Map<String, dynamic>> evaluateModel(
    Map<String, dynamic> params,
  ) async {
    return await post('workforce/ml/evaluate', body: params);
  }

  Future<Map<String, dynamic>> mlPredict(Map<String, dynamic> params) async {
    return await post('workforce/ml/predict', body: params);
  }

  Future<Map<String, dynamic>> batchPredict(Map<String, dynamic> params) async {
    return await post('workforce/ml/batch-predict', body: params);
  }

  Future<Map<String, dynamic>> listMLModels({
    required String organizationId,
  }) async {
    return await get('workforce/ml/models?organizationId=$organizationId');
  }

  Future<Map<String, dynamic>> getMLModelInfo({required String modelId}) async {
    return await get('workforce/ml/models/$modelId');
  }

  Future<Map<String, dynamic>> updateMLModel({
    required String modelId,
    required Map<String, dynamic> updates,
  }) async {
    return await put('workforce/ml/models/$modelId', body: updates);
  }

  Future<Map<String, dynamic>> deleteMLModel({required String modelId}) async {
    return await delete('workforce/ml/models/$modelId');
  }

  Future<Map<String, dynamic>> engineerFeatures(
    Map<String, dynamic> params,
  ) async {
    return await post('workforce/ml/feature-engineering', body: params);
  }

  Future<Map<String, dynamic>> abTestModels(Map<String, dynamic> params) async {
    return await post('workforce/ml/ab-test', body: params);
  }

  Future<Map<String, dynamic>> monitorMLPerformance({
    required String modelId,
    String? timeRange,
  }) async {
    String query = '';
    if (timeRange != null) query = '?timeRange=$timeRange';
    return await get('workforce/ml/monitor/$modelId$query');
  }

  Future<Map<String, dynamic>> exportMLModel({
    required String modelId,
    required String format,
  }) async {
    return await post('workforce/ml/export/$modelId', body: {'format': format});
  }

  // ============================================================================
  // Care Intelligence API Methods
  // ============================================================================

  // Care Intelligence
  Future<Map<String, dynamic>> generateIntelligenceReport({
    required String clientId,
    required String organizationId,
  }) async {
    return await post(
      'care-intelligence/intelligence/report/$clientId',
      body: {'organizationId': organizationId},
    );
  }

  Future<Map<String, dynamic>> analyzeCarePatterns({
    required String clientId,
    required String organizationId,
    String? startDate,
    String? endDate,
  }) async {
    return await post(
      'care-intelligence/intelligence/patterns/$clientId',
      body: {
        'organizationId': organizationId,
        'startDate': ?startDate,
        'endDate': ?endDate,
      },
    );
  }

  Future<Map<String, dynamic>> predictCareNeeds({
    required String clientId,
    required String organizationId,
    int horizon = 30,
  }) async {
    return await post(
      'care-intelligence/intelligence/predict-needs/$clientId',
      body: {'organizationId': organizationId, 'horizon': horizon},
    );
  }

  Future<Map<String, dynamic>> optimizeCareDelivery({
    required String clientId,
    required String organizationId,
  }) async {
    return await post(
      'care-intelligence/intelligence/optimize/$clientId',
      body: {'organizationId': organizationId},
    );
  }

  Future<Map<String, dynamic>> generatePersonalizedInsights({
    required String clientId,
    required String organizationId,
  }) async {
    return await get(
      'care-intelligence/intelligence/insights/$clientId?organizationId=$organizationId',
    );
  }

  // Risk Prediction
  Future<Map<String, dynamic>> predictAllRisks({
    required String clientId,
    required String organizationId,
  }) async {
    return await post(
      'care-intelligence/risk/predict-all/$clientId',
      body: {'organizationId': organizationId},
    );
  }

  Future<Map<String, dynamic>> predictFallsRisk({
    required String clientId,
    required String organizationId,
  }) async {
    return await post(
      'care-intelligence/risk/falls/$clientId',
      body: {'organizationId': organizationId},
    );
  }

  Future<Map<String, dynamic>> predictBehaviorEscalation({
    required String clientId,
    required String organizationId,
  }) async {
    return await post(
      'care-intelligence/risk/behavior/$clientId',
      body: {'organizationId': organizationId},
    );
  }

  Future<Map<String, dynamic>> predictHealthDeterioration({
    required String clientId,
    required String organizationId,
  }) async {
    return await post(
      'care-intelligence/risk/health/$clientId',
      body: {'organizationId': organizationId},
    );
  }

  Future<Map<String, dynamic>> predictMedicationRisk({
    required String clientId,
    required String organizationId,
  }) async {
    return await post(
      'care-intelligence/risk/medication/$clientId',
      body: {'organizationId': organizationId},
    );
  }

  Future<Map<String, dynamic>> analyzeRiskTrends({
    required String clientId,
    required String organizationId,
    String? startDate,
    String? endDate,
  }) async {
    return await post(
      'care-intelligence/risk/trends/$clientId',
      body: {
        'organizationId': organizationId,
        'startDate': ?startDate,
        'endDate': ?endDate,
      },
    );
  }

  // Care Planning
  Future<Map<String, dynamic>> generateCarePlan({
    required String clientId,
    required String organizationId,
    Map<String, dynamic>? preferences,
  }) async {
    return await post(
      'care-intelligence/care-plan/generate',
      body: {
        'clientId': clientId,
        'organizationId': organizationId,
        'preferences': ?preferences,
      },
    );
  }

  Future<Map<String, dynamic>> generateSmartGoals({
    required String clientId,
    required String organizationId,
    List<String>? outcomeAreas,
  }) async {
    return await post(
      'care-intelligence/care-plan/goals/$clientId',
      body: {'organizationId': organizationId, 'outcomeAreas': ?outcomeAreas},
    );
  }

  Future<Map<String, dynamic>> recommendServices({
    required String clientId,
    required String organizationId,
  }) async {
    return await post(
      'care-intelligence/care-plan/services/$clientId',
      body: {'organizationId': organizationId},
    );
  }

  Future<Map<String, dynamic>> adaptCarePlan({
    required String planId,
    required String organizationId,
    required Map<String, dynamic> progressData,
  }) async {
    return await put(
      'care-intelligence/care-plan/adapt/$planId',
      body: {'organizationId': organizationId, 'progressData': progressData},
    );
  }

  Future<Map<String, dynamic>> trackGoalProgress({
    required String goalId,
    required String organizationId,
    required Map<String, dynamic> progressUpdate,
  }) async {
    return await post(
      'care-intelligence/care-plan/progress/$goalId',
      body: {
        'organizationId': organizationId,
        'progressUpdate': progressUpdate,
      },
    );
  }

  Future<Map<String, dynamic>> generateEvidenceBasedRecommendations({
    required String clientId,
    required String organizationId,
    String? condition,
  }) async {
    return await post(
      'care-intelligence/care-plan/evidence-based',
      body: {
        'clientId': clientId,
        'organizationId': organizationId,
        'condition': ?condition,
      },
    );
  }

  // Incident Management
  Future<Map<String, dynamic>> reportIncident({
    required String clientId,
    required String organizationId,
    required Map<String, dynamic> incidentData,
  }) async {
    return await post(
      'care-intelligence/incident/report',
      body: {
        'clientId': clientId,
        'organizationId': organizationId,
        ...incidentData,
      },
    );
  }

  Future<Map<String, dynamic>> analyzeRootCause({
    required String incidentId,
    required String organizationId,
  }) async {
    return await post(
      'care-intelligence/incident/root-cause/$incidentId',
      body: {'organizationId': organizationId},
    );
  }

  Future<Map<String, dynamic>> detectCareIncidentPatterns({
    required String organizationId,
    String? startDate,
    String? endDate,
  }) async {
    return await post(
      'care-intelligence/incident/patterns/$organizationId',
      body: {'startDate': ?startDate, 'endDate': ?endDate},
    );
  }

  Future<Map<String, dynamic>> predictIncidentRecurrence({
    required String incidentId,
    required String organizationId,
  }) async {
    return await post(
      'care-intelligence/incident/predict-recurrence/$incidentId',
      body: {'organizationId': organizationId},
    );
  }

  Future<Map<String, dynamic>> generateCorrectiveActions({
    required String incidentId,
    required String organizationId,
  }) async {
    return await post(
      'care-intelligence/incident/corrective-actions/$incidentId',
      body: {'organizationId': organizationId},
    );
  }

  // Medication Management
  Future<Map<String, dynamic>> checkMedicationInteractions({
    required String clientId,
    required String organizationId,
    required List<String> medications,
  }) async {
    return await post(
      'care-intelligence/medication/check-interactions',
      body: {
        'clientId': clientId,
        'organizationId': organizationId,
        'medications': medications,
      },
    );
  }

  Future<Map<String, dynamic>> trackMedicationCompliance({
    required String clientId,
    required String organizationId,
    String? startDate,
    String? endDate,
  }) async {
    return await post(
      'care-intelligence/medication/compliance/$clientId',
      body: {
        'organizationId': organizationId,
        'startDate': ?startDate,
        'endDate': ?endDate,
      },
    );
  }

  Future<Map<String, dynamic>> getMedicationAlerts({
    required String clientId,
    required String organizationId,
  }) async {
    return await get(
      'care-intelligence/medication/alerts/$clientId?organizationId=$organizationId',
    );
  }

  Future<Map<String, dynamic>> optimizeMedicationSchedule({
    required String clientId,
    required String organizationId,
  }) async {
    return await post(
      'care-intelligence/medication/optimize-schedule/$clientId',
      body: {'organizationId': organizationId},
    );
  }

  Future<Map<String, dynamic>> monitorMedicationSideEffects({
    required String clientId,
    required String organizationId,
    required Map<String, dynamic> sideEffectData,
  }) async {
    return await post(
      'care-intelligence/medication/side-effects/$clientId',
      body: {'organizationId': organizationId, ...sideEffectData},
    );
  }

  // ============================================================================
  // Phase 10 - Advanced Financial Intelligence & Predictive Revenue System
  // API Methods (50+ endpoints)
  // ============================================================================

  // Revenue Forecasting (7 methods)
  Future<Map<String, dynamic>> generateRevenueForecast(
    Map<String, dynamic> data,
  ) async {
    return await post('financial-intelligence/revenue/forecast', body: data);
  }

  Future<Map<String, dynamic>> analyzeRevenueDrivers(
    Map<String, dynamic> data,
  ) async {
    return await post('financial-intelligence/revenue/drivers', body: data);
  }

  Future<Map<String, dynamic>> generateRevenueScenarios(
    Map<String, dynamic> data,
  ) async {
    return await post('financial-intelligence/revenue/scenarios', body: data);
  }

  Future<Map<String, dynamic>> performWhatIfAnalysis(
    Map<String, dynamic> data,
  ) async {
    return await post('financial-intelligence/revenue/what-if', body: data);
  }

  Future<Map<String, dynamic>> getRevenueTrends(
    String organizationId, {
    int? period,
  }) async {
    final query = period != null ? '?period=$period' : '';
    return await get(
      'financial-intelligence/revenue/trends/$organizationId$query',
    );
  }

  Future<Map<String, dynamic>> getForecastAccuracy(String forecastId) async {
    return await get('financial-intelligence/revenue/confidence/$forecastId');
  }

  Future<Map<String, dynamic>> updateRevenueModels(
    Map<String, dynamic> data,
  ) async {
    return await post(
      'financial-intelligence/revenue/update-model',
      body: data,
    );
  }

  // Pricing Optimization (7 methods)
  Future<Map<String, dynamic>> optimizePrices(Map<String, dynamic> data) async {
    return await post('financial-intelligence/pricing/optimize', body: data);
  }

  Future<Map<String, dynamic>> setupPricingABTest(
    Map<String, dynamic> data,
  ) async {
    return await post('financial-intelligence/pricing/test', body: data);
  }

  Future<Map<String, dynamic>> getPricingRecommendations(
    String serviceId,
    Map<String, dynamic> data,
  ) async {
    return await post(
      'financial-intelligence/pricing/recommendations/$serviceId',
      body: data,
    );
  }

  Future<Map<String, dynamic>> analyzeMargins(Map<String, dynamic> data) async {
    return await post(
      'financial-intelligence/pricing/margin-analysis',
      body: data,
    );
  }

  Future<Map<String, dynamic>> analyzeCompetitorPricing(
    Map<String, dynamic> data,
  ) async {
    return await post(
      'financial-intelligence/pricing/competitor-analysis',
      body: data,
    );
  }

  Future<Map<String, dynamic>> calculatePriceElasticity(
    String serviceId,
    Map<String, dynamic> data,
  ) async {
    return await post(
      'financial-intelligence/pricing/elasticity/$serviceId',
      body: data,
    );
  }

  Future<Map<String, dynamic>> optimizeBundlePricing(
    Map<String, dynamic> data,
  ) async {
    return await post(
      'financial-intelligence/pricing/bundle-optimization',
      body: data,
    );
  }

  // Billing Automation (8 methods)
  Future<Map<String, dynamic>> generateInvoices(
    Map<String, dynamic> data,
  ) async {
    return await post('financial-intelligence/billing/generate', body: data);
  }

  Future<Map<String, dynamic>> validateBilling(
    Map<String, dynamic> data,
  ) async {
    return await post('financial-intelligence/billing/validate', body: data);
  }

  Future<Map<String, dynamic>> detectBillingAnomalies(
    Map<String, dynamic> data,
  ) async {
    return await post(
      'financial-intelligence/billing/anomaly-detection',
      body: data,
    );
  }

  Future<Map<String, dynamic>> approveInvoices(
    Map<String, dynamic> data,
  ) async {
    return await post('financial-intelligence/billing/approve', body: data);
  }

  Future<Map<String, dynamic>> generateCreditNote(
    Map<String, dynamic> data,
  ) async {
    return await post('financial-intelligence/billing/credit-note', body: data);
  }

  Future<Map<String, dynamic>> getPendingInvoices(
    String organizationId, {
    Map<String, dynamic>? filters,
  }) async {
    String query = '';
    if (filters != null && filters.isNotEmpty) {
      query = '?' + filters.entries.map((e) => '${e.key}=${e.value}').join('&');
    }
    return await get(
      'financial-intelligence/billing/pending/$organizationId$query',
    );
  }

  Future<Map<String, dynamic>> batchProcessInvoices(
    Map<String, dynamic> data,
  ) async {
    return await post(
      'financial-intelligence/billing/batch-process',
      body: data,
    );
  }

  Future<Map<String, dynamic>> reconcileInvoices(
    Map<String, dynamic> data,
  ) async {
    return await post('financial-intelligence/billing/reconcile', body: data);
  }

  // Cash Flow Management (7 methods)
  Future<Map<String, dynamic>> forecastCashFlow(
    Map<String, dynamic> data,
  ) async {
    return await post('financial-intelligence/cashflow/forecast', body: data);
  }

  Future<Map<String, dynamic>> predictPayments(
    Map<String, dynamic> data,
  ) async {
    return await post(
      'financial-intelligence/cashflow/payment-prediction',
      body: data,
    );
  }

  Future<Map<String, dynamic>> optimizeCash(Map<String, dynamic> data) async {
    return await post('financial-intelligence/cashflow/optimize', body: data);
  }

  Future<Map<String, dynamic>> getCurrentCashPosition(
    String organizationId,
  ) async {
    return await get(
      'financial-intelligence/cashflow/position/$organizationId',
    );
  }

  Future<Map<String, dynamic>> generateCashFlowScenario(
    Map<String, dynamic> data,
  ) async {
    return await post('financial-intelligence/cashflow/scenario', body: data);
  }

  Future<Map<String, dynamic>> getCashFlowAlerts(String organizationId) async {
    return await get('financial-intelligence/cashflow/alerts/$organizationId');
  }

  Future<Map<String, dynamic>> getCashFlowRecommendations(
    Map<String, dynamic> data,
  ) async {
    return await post(
      'financial-intelligence/cashflow/recommendations',
      body: data,
    );
  }

  // Financial Analytics (6 methods)
  Future<Map<String, dynamic>> getFinancialDashboard(
    String organizationId, {
    String? period,
  }) async {
    final query = period != null ? '?period=$period' : '';
    return await get(
      'financial-intelligence/analytics/dashboard/$organizationId$query',
    );
  }

  Future<Map<String, dynamic>> analyzeFinancialProfitability(
    Map<String, dynamic> data,
  ) async {
    return await post(
      'financial-intelligence/analytics/profitability',
      body: data,
    );
  }

  Future<Map<String, dynamic>> analyzeFinancialVariance(
    Map<String, dynamic> data,
  ) async {
    return await post('financial-intelligence/analytics/variance', body: data);
  }

  Future<Map<String, dynamic>> getFinancialKPIs(String organizationId) async {
    return await get('financial-intelligence/analytics/kpis/$organizationId');
  }

  Future<Map<String, dynamic>> analyzeFinancialTrends(
    Map<String, dynamic> data,
  ) async {
    return await post('financial-intelligence/analytics/trends', body: data);
  }

  Future<Map<String, dynamic>> drillDownAnalysis(
    Map<String, dynamic> data,
  ) async {
    return await post(
      'financial-intelligence/analytics/drill-down',
      body: data,
    );
  }

  // Budget Management (6 methods)
  Future<Map<String, dynamic>> createBudget(Map<String, dynamic> data) async {
    return await post('financial-intelligence/budget/create', body: data);
  }

  Future<Map<String, dynamic>> monitorBudget(Map<String, dynamic> data) async {
    return await post('financial-intelligence/budget/monitor', body: data);
  }

  Future<Map<String, dynamic>> analyzeBudgetVariance(
    Map<String, dynamic> data,
  ) async {
    return await post('financial-intelligence/budget/variance', body: data);
  }

  Future<Map<String, dynamic>> generateRollingForecast(
    Map<String, dynamic> data,
  ) async {
    return await post('financial-intelligence/budget/forecast', body: data);
  }

  Future<Map<String, dynamic>> optimizeBudgetAllocation(
    Map<String, dynamic> data,
  ) async {
    return await post('financial-intelligence/budget/optimize', body: data);
  }

  Future<Map<String, dynamic>> getBudgetStatus(String organizationId) async {
    return await get('financial-intelligence/budget/status/$organizationId');
  }

  // Payment Processing (5 methods)
  Future<Map<String, dynamic>> processPayment(Map<String, dynamic> data) async {
    return await post('financial-intelligence/payment/process', body: data);
  }

  Future<Map<String, dynamic>> reconcilePayments(
    Map<String, dynamic> data,
  ) async {
    return await post('financial-intelligence/payment/reconcile', body: data);
  }

  Future<Map<String, dynamic>> optimizePaymentRouting(
    Map<String, dynamic> data,
  ) async {
    return await post(
      'financial-intelligence/payment/optimize-routing',
      body: data,
    );
  }

  Future<Map<String, dynamic>> getPaymentAnalytics(
    String organizationId, {
    String? period,
  }) async {
    final query = period != null ? '?period=$period' : '';
    return await get(
      'financial-intelligence/payment/analytics/$organizationId$query',
    );
  }

  Future<Map<String, dynamic>> checkPaymentFraud(
    Map<String, dynamic> data,
  ) async {
    return await post('financial-intelligence/payment/fraud-check', body: data);
  }

  // Compliance & Audit (3 methods)
  Future<Map<String, dynamic>> checkFinancialCompliance(
    Map<String, dynamic> data,
  ) async {
    return await post('financial-intelligence/compliance/check', body: data);
  }

  Future<Map<String, dynamic>> generateFinancialAuditTrail(
    Map<String, dynamic> data,
  ) async {
    return await post(
      'financial-intelligence/compliance/audit-trail',
      body: data,
    );
  }

  Future<Map<String, dynamic>> getComplianceStatus(
    String organizationId,
  ) async {
    return await get(
      'financial-intelligence/compliance/status/$organizationId',
    );
  }

  // Client Financial Management (3 methods)
  Future<Map<String, dynamic>> manageCreditLimit(
    Map<String, dynamic> data,
  ) async {
    return await post('financial-intelligence/client/credit-limit', body: data);
  }

  Future<Map<String, dynamic>> calculateLifetimeValue(
    Map<String, dynamic> data,
  ) async {
    return await post(
      'financial-intelligence/client/lifetime-value',
      body: data,
    );
  }

  Future<Map<String, dynamic>> assessFinancialHealth(
    Map<String, dynamic> data,
  ) async {
    return await post(
      'financial-intelligence/client/financial-health',
      body: data,
    );
  }

  // Financial Reporting (3 methods)
  Future<Map<String, dynamic>> generateExecutiveReport(
    Map<String, dynamic> data,
  ) async {
    return await post('financial-intelligence/reporting/executive', body: data);
  }

  Future<Map<String, dynamic>> buildCustomReport(
    Map<String, dynamic> data,
  ) async {
    return await post('financial-intelligence/reporting/custom', body: data);
  }

  Future<Map<String, dynamic>> generateRegulatoryReport(
    Map<String, dynamic> data,
  ) async {
    return await post(
      'financial-intelligence/reporting/regulatory',
      body: data,
    );
  }

  /// Sync Firebase Auth user with MongoDB backend.
  ///
  /// This method is called after successful Firebase authentication to ensure
  /// the user exists in MongoDB with proper organization and role data.
  ///
  /// Parameters:
  /// - [firebaseUid]: The Firebase Auth UID
  /// - [email]: User's email address
  /// - [idToken]: Firebase ID token for backend verification
  /// - [firstName]: Optional first name
  /// - [lastName]: Optional last name
  /// - [photoURL]: Optional profile photo URL
  ///
  /// Returns user data including role and organization info for navigation.
  Future<Map<String, dynamic>> syncFirebaseUser({
    required String firebaseUid,
    required String email,
    required String idToken,
    String? firstName,
    String? lastName,
    String? photoURL,
  }) async {
    try {
      final cleanEndpoint = 'firebase-auth/sync';
      final baseNoTrailing = _baseUrl.replaceAll(RegExp(r'/+$'), '');
      final fullUrl = '$baseNoTrailing/$cleanEndpoint';

      final body = {
        'firebaseUid': firebaseUid,
        'email': email,
        'firstName': ?firstName,
        'lastName': ?lastName,
        'photoURL': ?photoURL,
      };

      final appCheckToken = await _getAppCheckToken();
      final headers = <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $idToken',
        if (!kIsWeb && Platform.isIOS) 'X-Platform': 'ios',
        if (appCheckToken != null && appCheckToken.isNotEmpty)
          'X-Firebase-AppCheck': appCheckToken,
      };

      debugPrint('🔐 syncFirebaseUser: POST to $fullUrl');
      debugPrint('🔐 syncFirebaseUser: body = $body');

      final response = await http.post(
        Uri.parse(fullUrl),
        headers: headers,
        body: json.encode(body),
      );

      debugPrint('🔐 syncFirebaseUser: status = ${response.statusCode}');
      debugPrint('🔐 syncFirebaseUser: response = ${response.body}');

      return _handleResponse(response);
    } catch (e) {
      debugPrint('🔐 syncFirebaseUser exception: $e');
      return {'success': false, 'message': 'Failed to sync user: $e'};
    }
  }

  /// Sync verified email status from Firebase to MongoDB.
  ///
  /// Requires a valid Firebase ID token in Authorization header.
  Future<Map<String, dynamic>> syncEmailVerificationStatus({
    required String firebaseUid,
  }) async {
    try {
      return await post(
        'firebase-auth/verify-email',
        body: {'firebaseUid': firebaseUid},
      );
    } catch (e) {
      debugPrint('syncEmailVerificationStatus exception: $e');
      return {
        'success': false,
        'message': 'Failed to sync email verification status: $e',
      };
    }
  }
}
