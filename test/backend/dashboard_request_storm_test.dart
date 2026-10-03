import 'package:carenest/backend/api_response_cache.dart';
import 'package:flutter_test/flutter_test.dart';

/// Reproduces the reported symptom: dashboard navigation and period taps firing
/// backend requests multiple times per second.
///
/// This exercises the cache the same way `ApiMethod.get` does, so a regression
/// here means the storm is back.
void main() {
  group('request storm regression', () {
    late ApiResponseCache cache;
    late int networkCalls;

    setUp(() {
      cache = ApiResponseCache();
      networkCalls = 0;
    });

    Future<Map<String, dynamic>> loader() async {
      networkCalls++;
      // Stand in for real latency.
      await Future<void>.delayed(const Duration(milliseconds: 30));
      return {
        'success': true,
        'data': {'total': 100},
      };
    }

    test(
      'opening the earnings dashboard once costs one request per widget',
      () async {
        // The dashboard loads three widgets: summary, projection, history.
        await Future.wait([
          cache.fetch(
            'earnings/summary/a@b.com?startDate=2026-01-01',
            loader: loader,
          ),
          cache.fetch(
            'earnings/projected/a@b.com?startDate=2026-01-01',
            loader: loader,
          ),
          cache.fetch('earnings/history/a@b.com?bucket=month', loader: loader),
        ]);

        expect(networkCalls, 3);
      },
    );

    test('toggling weekly/monthly back and forth does not refetch', () async {
      for (var i = 0; i < 10; i++) {
        final period = i.isEven ? 'week' : 'month';
        await cache.fetch(
          'earnings/history/a@b.com?bucket=$period',
          loader: loader,
        );
      }

      // Two distinct buckets, first fetch of each. Before the fix this would be
      // ten round trips.
      expect(networkCalls, 2);
    });

    test('rapid identical taps collapse to a single request', () async {
      await Future.wait(
        List.generate(
          12,
          (_) => cache.fetch('earnings/summary/a@b.com', loader: loader),
        ),
      );

      expect(networkCalls, 1);
      expect(cache.stats['coalesced'], 11);
    });

    test(
      're-entering the dashboard within the TTL costs nothing extra',
      () async {
        // Simulates navigating away and back repeatedly.
        for (var visit = 0; visit < 8; visit++) {
          await cache.fetch(
            'api/billing/dashboard/overview?organizationId=org1',
            loader: loader,
          );
        }

        expect(networkCalls, 1);
      },
    );

    test('the user still sees their own write immediately', () async {
      await cache.fetch('earnings/summary/a@b.com', loader: loader);

      await cache.fetch(
        'earnings/rate/a@b.com',
        loader: () async {
          networkCalls++;
          return {'success': true};
        },
      );
      cache.invalidatePrefixes(['earnings/']);

      await cache.fetch('earnings/summary/a@b.com', loader: loader);
      expect(networkCalls, 3, reason: 'summary, rate write, summary refetch');
    });

    test('live tracking still hits the network every time', () async {
      await cache.fetch('active-timers/a@b.com', loader: loader);
      await cache.fetch('active-timers/a@b.com', loader: loader);
      expect(networkCalls, 2, reason: 'a live timer must never be cached');
    });
  });
}
