import 'dart:async';

import 'package:carenest/backend/api_response_cache.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ApiResponseCache cache;
  late int loaderCalls;

  Future<Map<String, dynamic>> okLoader([String value = 'v']) async {
    loaderCalls++;
    return {'success': true, 'data': value};
  }

  setUp(() {
    cache = ApiResponseCache();
    loaderCalls = 0;
  });

  group('cacheability', () {
    test('caches allowlisted dashboard endpoints that carry a tenant', () {
      expect(cache.ttlFor('earnings/summary/a@b.com'), isNotNull);
      expect(
        cache.ttlFor('earnings/history/a@b.com?startDate=2026-01-01'),
        isNotNull,
      );
      expect(
        cache.ttlFor('api/billing/dashboard/overview?organizationId=org1'),
        isNotNull,
      );
      expect(
        cache.ttlFor('workforce/bi/dashboard?organizationId=org1&period=30d'),
        isNotNull,
      );
    });

    test('treats a leading api/ prefix as equivalent', () {
      expect(
        cache.ttlFor('api/earnings/summary/a@b.com'),
        cache.ttlFor('earnings/summary/a@b.com'),
      );
    });

    test('refuses live state, auth and tenant-less endpoints', () {
      // No tenant discriminator anywhere in the URL: caching would key on
      // nothing but the path.
      expect(cache.ttlFor('worker/dashboard'), isNull);
      expect(cache.ttlFor('active-timers/x@y.com'), isNull);
      expect(cache.ttlFor('auth/login'), isNull);
      expect(cache.ttlFor('realtime-portal/timeline'), isNull);
      expect(cache.ttlFor('earnings/summary/'), isNull);
      expect(cache.ttlFor('something/entirely/unknown'), isNull);
    });

    test('refuses an allowlisted prefix with an empty tenant segment', () {
      expect(cache.ttlFor('earnings/summary/'), isNull);
      expect(cache.ttlFor('earnings/projected/'), isNull);
    });
  });

  group('single-flight coalescing', () {
    test(
      'collapses concurrent identical requests into one network call',
      () async {
        final barrier = Completer<void>();
        Future<Map<String, dynamic>> slowLoader() async {
          loaderCalls++;
          await barrier.future;
          return {'success': true, 'data': 'once'};
        }

        // Simulates the reported behaviour: taps landing in the same instant,
        // before any TTL window can exist.
        final futures = List.generate(6, (_) {
          return cache.fetch('earnings/summary/a@b.com', loader: slowLoader);
        });

        barrier.complete();
        final results = await Future.wait(futures);

        expect(loaderCalls, 1, reason: 'expected one shared request');
        expect(results.every((r) => r['data'] == 'once'), isTrue);
        expect(cache.stats['coalesced'], 5);
      },
    );

    test('does not coalesce different endpoints', () async {
      await Future.wait([
        cache.fetch('earnings/summary/a@b.com', loader: okLoader),
        cache.fetch('earnings/summary/other@b.com', loader: okLoader),
      ]);
      expect(loaderCalls, 2);
    });

    test('clears the in-flight entry once settled', () async {
      await cache.fetch('earnings/summary/a@b.com', loader: okLoader);
      expect(cache.inFlightCount, 0);
    });
  });

  group('TTL behaviour', () {
    test('serves a fresh entry without hitting the loader', () async {
      await cache.fetch('earnings/summary/a@b.com', loader: okLoader);
      final second = await cache.fetch(
        'earnings/summary/a@b.com',
        loader: okLoader,
      );

      expect(loaderCalls, 1);
      expect(second['data'], 'v');
      expect(cache.stats['hits'], 1);
    });

    test('refetches once the entry has expired', () async {
      final shortLived = ApiResponseCache(
        ttlByPrefix: {'earnings/summary/': const Duration(milliseconds: 40)},
      );
      await shortLived.fetch('earnings/summary/a@b.com', loader: okLoader);
      await Future<void>.delayed(const Duration(milliseconds: 80));
      await shortLived.fetch('earnings/summary/a@b.com', loader: okLoader);

      expect(loaderCalls, 2);
    });

    test('forceRefresh bypasses a fresh entry', () async {
      await cache.fetch('earnings/summary/a@b.com', loader: okLoader);
      await cache.fetch(
        'earnings/summary/a@b.com',
        loader: okLoader,
        forceRefresh: true,
      );

      expect(loaderCalls, 2);
    });

    test('forceRefresh still writes the fresh value', () async {
      await cache.fetch(
        'earnings/summary/a@b.com',
        loader: () async {
          loaderCalls++;
          return {'success': true, 'data': 'new'};
        },
        forceRefresh: true,
      );
      final after = await cache.fetch(
        'earnings/summary/a@b.com',
        loader: okLoader,
      );

      expect(after['data'], 'new');
      expect(loaderCalls, 1);
    });
  });

  group('error handling', () {
    test('never caches a failed response', () async {
      await cache.fetch(
        'earnings/summary/a@b.com',
        loader: () async {
          loaderCalls++;
          return {'success': false, 'message': 'boom'};
        },
      );

      await cache.fetch('earnings/summary/a@b.com', loader: okLoader);

      expect(
        loaderCalls,
        2,
        reason: 'a failure must not be pinned for the TTL',
      );
      expect(cache.size, 1);
    });

    test('never caches a thrown error', () async {
      await cache.fetch(
        'earnings/summary/a@b.com',
        loader: () async {
          loaderCalls++;
          throw StateError('network down');
        },
      );

      final retry = await cache.fetch(
        'earnings/summary/a@b.com',
        loader: okLoader,
      );

      expect(retry['success'], isTrue);
      expect(loaderCalls, 2);
    });

    test('non-cacheable endpoints always reach the loader', () async {
      await cache.fetch('worker/dashboard', loader: okLoader);
      await cache.fetch('worker/dashboard', loader: okLoader);
      expect(loaderCalls, 2);
    });
  });

  group('isolation', () {
    test('callers cannot mutate the cached body', () async {
      await cache.fetch('earnings/summary/a@b.com', loader: okLoader);
      final first = await cache.fetch(
        'earnings/summary/a@b.com',
        loader: okLoader,
      );
      first['data'] = 'tampered';

      final second = await cache.fetch(
        'earnings/summary/a@b.com',
        loader: okLoader,
      );

      expect(second['data'], 'v');
      expect(loaderCalls, 1);
    });

    test('different tenants do not share an entry', () async {
      await cache.fetch(
        'api/billing/dashboard/overview?organizationId=org1',
        loader: () async {
          loaderCalls++;
          return {'success': true, 'data': 'org1'};
        },
      );
      final org2 = await cache.fetch(
        'api/billing/dashboard/overview?organizationId=org2',
        loader: () async {
          loaderCalls++;
          return {'success': true, 'data': 'org2'};
        },
      );

      expect(org2['data'], 'org2');
      expect(loaderCalls, 2);
    });

    test('bounds the number of retained entries', () async {
      final bounded = ApiResponseCache(maxEntries: 3);
      for (var i = 0; i < 6; i++) {
        await bounded.fetch('earnings/summary/user$i@b.com', loader: okLoader);
      }
      expect(bounded.size, 3);
    });
  });

  group('invalidation', () {
    test('invalidatePrefixes drops only matching entries', () async {
      await cache.fetch('earnings/summary/a@b.com', loader: okLoader);
      await cache.fetch(
        'api/billing/dashboard/overview?organizationId=org1',
        loader: okLoader,
      );

      cache.invalidatePrefixes(['earnings/']);

      expect(cache.size, 1);
      await cache.fetch('earnings/summary/a@b.com', loader: okLoader);
      expect(
        loaderCalls,
        3,
        reason: 'earnings should refetch, billing should not',
      );
    });

    test('invalidation tolerates a leading api/ prefix', () async {
      await cache.fetch(
        'api/billing/dashboard/overview?organizationId=org1',
        loader: okLoader,
      );
      cache.invalidatePrefixes(['billing/dashboard/']);
      expect(cache.size, 0);
    });

    test('clear empties everything', () async {
      await cache.fetch('earnings/summary/a@b.com', loader: okLoader);
      cache.clear();
      expect(cache.size, 0);
    });
  });
}
