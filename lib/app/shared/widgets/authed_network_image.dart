import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:carenest/config/environment.dart';

/// `Image.network` that authenticates backend file requests.
///
/// The backend serves `/uploads` (except public `logos/`) only to
/// authenticated callers, and plain `Image.network` sends no credentials.
/// This widget attaches the current Firebase ID token as an
/// `Authorization` header — **but only when the URL points at our own
/// backend host**. Third-party URLs render as plain `Image.network` so
/// tokens are never leaked cross-origin.
class AuthedNetworkImage extends StatelessWidget {
  const AuthedNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.loadingBuilder,
    this.errorBuilder,
  });

  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final ImageLoadingBuilder? loadingBuilder;
  final ImageErrorWidgetBuilder? errorBuilder;

  /// Backend host derived from the configured API base URL, or null when
  /// unresolvable (fail closed: no auth headers).
  static String? _backendHost() {
    try {
      return Uri.parse(AppConfig.baseUrl).host.toLowerCase();
    } catch (_) {
      return null;
    }
  }

  /// True when [url] targets our backend (and therefore needs credentials).
  static bool needsAuth(String url) {
    final backendHost = _backendHost();
    if (backendHost == null || backendHost.isEmpty) return false;
    return matchesBackendHost(url, backendHost);
  }

  /// Pure host comparison behind [needsAuth] (separated for testability).
  static bool matchesBackendHost(String url, String backendHost) {
    final uri = Uri.tryParse(url);
    if (uri == null || !uri.hasScheme || uri.host.isEmpty) return false;
    if (uri.scheme != 'https' && uri.scheme != 'http') return false;
    return uri.host.toLowerCase() == backendHost.toLowerCase();
  }

  /// Firebase bearer headers for backend URLs, null otherwise (or when
  /// no user is signed in — callers then fall back to an unauthenticated
  /// request, e.g. public logos).
  static Future<Map<String, String>?> authedHeadersFor(String url) async {
    if (!needsAuth(url)) return null;
    try {
      final token = await FirebaseAuth.instance.currentUser?.getIdToken();
      if (token == null || token.isEmpty) return null;
      return {'Authorization': 'Bearer $token'};
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!needsAuth(url)) {
      return Image.network(
        url,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: loadingBuilder,
        errorBuilder: errorBuilder,
      );
    }
    return FutureBuilder<Map<String, String>?>(
      future: authedHeadersFor(url),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return SizedBox(
            width: width,
            height: height,
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        }
        return Image.network(
          url,
          headers: snapshot.data,
          width: width,
          height: height,
          fit: fit,
          loadingBuilder: loadingBuilder,
          errorBuilder: errorBuilder,
        );
      },
    );
  }
}

/// Drop-in `CacheManager` for `CachedNetworkImage` that injects Firebase
/// credentials for backend-hosted files (same rule as [AuthedNetworkImage]).
/// Non-backend URLs pass through untouched. Uses its own cache namespace so
/// authed responses never mix with the default public cache.
class AuthedCacheManager extends CacheManager {
  static const key = 'carenestAuthedCache';

  static AuthedCacheManager? _instance;
  static AuthedCacheManager get instance =>
      _instance ??= AuthedCacheManager._();

  AuthedCacheManager._()
      : super(Config(key, fileService: _AuthedFileService()));
}

class _AuthedFileService extends HttpFileService {
  @override
  Future<FileServiceResponse> get(
    String url, {
    Map<String, String>? headers,
  }) async {
    final authed = await AuthedNetworkImage.authedHeadersFor(url);
    return super.get(url, headers: {...?headers, ...?authed});
  }
}
