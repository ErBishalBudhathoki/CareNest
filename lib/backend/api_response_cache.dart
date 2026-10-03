import 'dart:collection';

/// In-memory read-through cache for GET requests, with single-flight request
/// coalescing.
///
/// Two independent problems, two independent mechanisms:
///
///  * **Coalescing** collapses concurrent identical GETs into one network call.
///    This is what fixes rapid repeated taps: the second tap arrives while the
///    first is still awaiting, before any TTL window exists, so TTL alone
///    cannot help.
///  * **TTL** stops repeat calls across taps and screen switches over a longer
///    window.
///
/// Everything here is opt-in. A GET is only ever cached when it matches an
/// explicit allowlist of read-only dashboard prefixes *and* carries a tenant
/// discriminator in the URL. An endpoint that does not name its organization or
/// user is never cached, so switching accounts on a shared device cannot serve
/// one user's data to another.
///
/// Only successful responses are stored. The transport in `ApiMethod.get`
/// swallows exceptions and returns `{'success': false}`, so an error must never
/// be pinned for the length of a TTL.
class ApiResponseCache {
  ApiResponseCache({Map<String, Duration>? ttlByPrefix, int maxEntries = 200})
    : _ttlByPrefix = ttlByPrefix ?? defaultTtlByPrefix,
      _maxEntries = maxEntries;

  /// Per-prefix time-to-live. Earnings are financial records that change on the
  /// order of a shift, so a few minutes is safe; live payment/payout figures
  /// stay short.
  static const Map<String, Duration> defaultTtlByPrefix = {
    'earnings/summary/': Duration(minutes: 5),
    'earnings/projected/': Duration(minutes: 5),
    'earnings/history/': Duration(minutes: 5),
    'billing/dashboard/': Duration(seconds: 60),
    'analytics/': Duration(seconds: 60),
    'financial-intelligence/': Duration(seconds: 60),
    'workforce/bi/': Duration(seconds: 60),
    'workforce/performance/': Duration(seconds: 60),
  };

  /// Never cache these even if a prefix above would match. Live state and
  /// anything touching authentication must always hit the network.
  static const Set<String> neverCachePrefixes = {
    'active-timers/',
    'auth/',
    'realtime-portal/',
    'user/',
    'organization/',
  };

  final Map<String, Duration> _ttlByPrefix;
  final int _maxEntries;

  final LinkedHashMap<String, _CacheEntry> _entries =
      LinkedHashMap<String, _CacheEntry>();
  final Map<String, Future<Map<String, dynamic>>> _inFlight =
      <String, Future<Map<String, dynamic>>>{};

  int _hits = 0;
  int _coalesced = 0;
  int _misses = 0;
  int _rejected = 0;

  /// Strip the optional `api/` prefix and any leading slash so `earnings/...`
  /// and `api/earnings/...` resolve to the same prefix.
  static String normalize(String endpoint) {
    var path = endpoint.trim();
    final queryIndex = path.indexOf('?');
    final query = queryIndex == -1 ? '' : path.substring(queryIndex);
    path = queryIndex == -1 ? path : path.substring(0, queryIndex);
    while (path.startsWith('/')) {
      path = path.substring(1);
    }
    if (path.startsWith('api/')) {
      path = path.substring(4);
    }
    return '$path$query';
  }

  /// The TTL for this endpoint, or null when it must not be cached.
  Duration? ttlFor(String endpoint) {
    final normalized = normalize(endpoint);

    for (final blocked in neverCachePrefixes) {
      if (normalized.startsWith(blocked)) {
        _rejected++;
        return null;
      }
    }

    for (final entry in _ttlByPrefix.entries) {
      if (!normalized.startsWith(entry.key)) {
        continue;
      }
      if (!_hasTenantDiscriminator(normalized, entry.key)) {
        // e.g. `worker/dashboard`-shaped endpoints that resolve the tenant from
        // the auth token alone. Caching those would key on nothing but the URL.
        _rejected++;
        return null;
      }
      return entry.value;
    }

    _rejected++;
    return null;
  }

  /// A cacheable endpoint must identify which organization or user it is for,
  /// either through an `organizationId` query parameter or as a path segment
  /// after the matched prefix (the user email, for earnings).
  static bool _hasTenantDiscriminator(String normalized, String prefix) {
    final queryIndex = normalized.indexOf('?');
    if (queryIndex != -1) {
      final query = normalized.substring(queryIndex);
      if (RegExp('(^|[?&])organizationId=[^&]+').hasMatch(query)) {
        return true;
      }
    }
    final remainder = normalized.substring(
      prefix.length,
      queryIndex == -1 ? normalized.length : queryIndex,
    );
    return remainder.trim().isNotEmpty;
  }

  /// Returns the cached body when still fresh, otherwise runs [loader] and
  /// stores the result on success. Concurrent calls for the same endpoint share
  /// a single [loader] invocation.
  Future<Map<String, dynamic>> fetch(
    String endpoint, {
    required Future<Map<String, dynamic>> Function() loader,
    bool forceRefresh = false,
  }) {
    final key = normalize(endpoint);
    final ttl = ttlFor(endpoint);
    if (ttl == null) {
      return loader();
    }

    if (forceRefresh) {
      // Drop any stale entry, but still let in-flight callers share the request.
      _entries.remove(key);
    } else {
      final existing = _entries[key];
      if (existing != null) {
        if (DateTime.now().difference(existing.storedAt) <= ttl) {
          _hits++;
          _touch(key);
          return Future<Map<String, dynamic>>.value(Map.of(existing.body));
        }
        _entries.remove(key);
      }

      final pending = _inFlight[key];
      if (pending != null) {
        _coalesced++;
        return pending;
      }
    }

    _misses++;
    final future = loader()
        .then((result) {
          _inFlight.remove(key);
          if (result['success'] == true) {
            _store(key, result);
          }
          return Map.of(result);
        })
        .catchError((Object error) {
          _inFlight.remove(key);
          return <String, dynamic>{
            'success': false,
            'message': error.toString(),
          };
        });

    _inFlight[key] = future;
    return future;
  }

  void _store(String key, Map<String, dynamic> body) {
    _entries[key] = _CacheEntry(body: body, storedAt: DateTime.now());
    _evictIfNeeded();
  }

  void _touch(String key) {
    final entry = _entries.remove(key);
    if (entry != null) {
      _entries[key] = entry;
    }
  }

  void _evictIfNeeded() {
    while (_entries.length > _maxEntries) {
      _entries.remove(_entries.keys.first);
    }
  }

  /// Drop cached reads whose endpoint starts with any of [prefixes]. Call after
  /// a mutation so the next read reflects the write. Err toward passing too many
  /// prefixes rather than too few.
  void invalidatePrefixes(Iterable<String> prefixes) {
    final normalizedPrefixes = prefixes.map(normalize).toList(growable: false);
    for (final key in _entries.keys.toList(growable: false)) {
      for (final prefix in normalizedPrefixes) {
        if (key.startsWith(prefix)) {
          _entries.remove(key);
          break;
        }
      }
    }
  }

  void clear() {
    _entries.clear();
    _inFlight.clear();
  }

  int get size => _entries.length;

  int get inFlightCount => _inFlight.length;

  Map<String, int> get stats => {
    'hits': _hits,
    'coalesced': _coalesced,
    'misses': _misses,
    'rejected': _rejected,
    'entries': _entries.length,
    'inFlight': _inFlight.length,
  };

  void resetStats() {
    _hits = 0;
    _coalesced = 0;
    _misses = 0;
    _rejected = 0;
  }
}

class _CacheEntry {
  final Map<String, dynamic> body;
  final DateTime storedAt;

  const _CacheEntry({required this.body, required this.storedAt});
}
