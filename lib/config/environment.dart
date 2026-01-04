import 'package:carenest/config/env/development.dart';
import 'package:carenest/config/env/production.dart';
import 'package:flutter/foundation.dart';

enum Flavor {
  development,
  production,
}

class AppConfig {
  static Flavor appFlavor = Flavor.development;

  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.development:
        return Development.baseUrl;
      case Flavor.production:
        return Production.baseUrl;
      default:
        return Development.baseUrl;
    }
  }

  static bool get enableLogging {
    switch (appFlavor) {
      case Flavor.development:
        return Development.enableLogging;
      case Flavor.production:
        return Production.enableLogging;
      default:
        return Development.enableLogging;
    }
  }

  static String get flavorName {
    switch (appFlavor) {
      case Flavor.development:
        return 'development';
      case Flavor.production:
        return 'production';
      default:
        return 'development';
    }
  }

  static String normalizeBaseUrl([String? rawBaseUrl]) {
    final value = (rawBaseUrl ?? baseUrl).trim();
    final withoutTrailing = value.replaceAll(RegExp(r'/+$'), '');
    return '$withoutTrailing/';
  }

  static String buildFilesDownloadUrl(
    String resourceUrl, {
    String? baseUrlOverride,
  }) {
    final normalizedBaseUrl = normalizeBaseUrl(baseUrlOverride);
    final baseUri = Uri.parse(normalizedBaseUrl);

    final path = baseUri.path;
    final endsWithApi = path.endsWith('/api/') || path.endsWith('/api');
    final endpointUri =
        endsWithApi ? baseUri.resolve('files/download') : baseUri.resolve('api/files/download');

    return '$endpointUri?url=${Uri.encodeComponent(resourceUrl)}';
  }

  static String resolveResourceUrl(
    String? rawUrlOrPath, {
    String? baseUrlOverride,
  }) {
    final raw = (rawUrlOrPath ?? '').trim().replaceAll('`', '');
    if (raw.isEmpty) return raw;

    if (raw.startsWith('file://')) return raw;

    final normalizedBaseUrl = normalizeBaseUrl(baseUrlOverride);
    Uri? baseUri;
    try {
      baseUri = Uri.parse(normalizedBaseUrl);
    } catch (_) {
      baseUri = null;
    }

    if (raw.startsWith('http://') || raw.startsWith('https://')) {
      try {
        final uri = Uri.parse(raw);
        final host = uri.host.toLowerCase();

        if (baseUri != null &&
            _shouldRewriteAbsoluteUrlHost(host, baseUri.host.toLowerCase())) {
          final rebuilt = Uri(
            scheme: baseUri.scheme,
            userInfo: uri.userInfo,
            host: baseUri.host,
            port: baseUri.hasPort ? baseUri.port : null,
            path: uri.path,
            query: uri.hasQuery ? uri.query : null,
            fragment: uri.hasFragment ? uri.fragment : null,
          );
          if (enableLogging) {
            debugPrint(
                'URL resolver: Rewrote local URL host "$host" to "${baseUri.host}"');
          }
          return rebuilt.toString();
        }

        return uri.toString();
      } catch (_) {
        return raw;
      }
    }

    final clean = raw.startsWith('/') ? raw.substring(1) : raw;
    try {
      return Uri.parse(normalizedBaseUrl).resolve(clean).toString();
    } catch (_) {
      return '$normalizedBaseUrl$clean';
    }
  }

  static bool _shouldRewriteAbsoluteUrlHost(String host, String baseHost) {
    if (host == baseHost) return false;
    if (_isLikelyLocalHost(host)) return true;
    if (_isIPv4Literal(host)) return true;
    return false;
  }

  static bool _isLikelyLocalHost(String host) {
    if (host == 'localhost' || host == '127.0.0.1' || host == '10.0.2.2') {
      return true;
    }
    return _isPrivateIPv4(host);
  }

  static bool _isIPv4Literal(String host) {
    final parts = host.split('.');
    if (parts.length != 4) return false;
    for (final part in parts) {
      final value = int.tryParse(part);
      if (value == null || value < 0 || value > 255) return false;
    }
    return true;
  }

  static bool _isPrivateIPv4(String host) {
    final parts = host.split('.');
    if (parts.length != 4) return false;
    final octets = <int>[];
    for (final part in parts) {
      final value = int.tryParse(part);
      if (value == null || value < 0 || value > 255) return false;
      octets.add(value);
    }
    final a = octets[0];
    final b = octets[1];
    if (a == 10) return true;
    if (a == 127) return true;
    if (a == 0) return true;
    if (a == 169 && b == 254) return true;
    if (a == 192 && b == 168) return true;
    if (a == 172 && b >= 16 && b <= 31) return true;
    return false;
  }
}
