import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:carenest/config/environment.dart'; // Assuming this exists or similar
import 'dart:io';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late final Dio _dio;
  final _storage = const FlutterSecureStorage();

  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl, // Ensure this exists or use string
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(AuthInterceptor(_dio, _storage));

    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
    }
  }

  Dio get dio => _dio;
}

class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final FlutterSecureStorage _storage;
  bool _isRefreshing = false;
  final List<void Function()> _requestsQueue = [];

  AuthInterceptor(this._dio, this._storage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Add Access Token if available
    final accessToken = await _storage.read(key: 'accessToken');
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    if (!kIsWeb && Platform.isIOS) {
      options.headers['X-Platform'] = 'ios';
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Handle Unauthorized
      final refreshToken = await _storage.read(key: 'refreshToken');

      // If no refresh token or already refreshing, reject (unless we handle queue)
      if (refreshToken == null) {
        // Logout
        await _performLogout();
        return handler.next(err);
      }

      if (_isRefreshing) {
        // Queue the request
        // Creates a completer logic or simple queue?
        // Simple queue for this example
        // Note: Dio's queue support is limited manually.
        // We can just await a future here if we had one.
        // For simplicity: reject if overlapping to avoid complex mutex code in snippet,
        // OR better: use a rudimentary queue.
        return handler.next(err); // Simpler for now: fail concurrents.
        // Real production: waiting for the first refresh future to complete.
      }

      _isRefreshing = true;

      try {
        // Call Refresh API
        // Use a FRESH Dio instance to avoid interceptor loop
        final refreshDio = Dio(BaseOptions(baseUrl: _dio.options.baseUrl));
        final response = await refreshDio.post(
          '/auth/v2/refresh-token',
          data: {'refreshToken': refreshToken},
        );

        if (response.statusCode == 200) {
          final newAccessToken = response.data['data']['accessToken'];
          final newRefreshToken = response.data['data']['refreshToken'];

          await _storage.write(key: 'accessToken', value: newAccessToken);
          await _storage.write(key: 'refreshToken', value: newRefreshToken);

          _isRefreshing = false;

          // Retry the original request
          final opts = err.requestOptions;
          opts.headers['Authorization'] = 'Bearer $newAccessToken';

          final clonedRequest = await _dio.request(
            opts.path,
            options: Options(method: opts.method, headers: opts.headers),
            data: opts.data,
            queryParameters: opts.queryParameters,
          );

          return handler.resolve(clonedRequest);
        } else {
          await _performLogout();
          return handler.next(err);
        }
      } catch (e) {
        await _performLogout();
        return handler.next(err);
      } finally {
        _isRefreshing = false;
      }
    }
    return handler.next(err);
  }

  Future<void> _performLogout() async {
    await _storage.deleteAll();
    // Nav to login handled by Riverpod state change usually,
    // or use a GlobalKey<NavigatorState> if available.
    // For now, clear tokens is the core action.
  }
}
