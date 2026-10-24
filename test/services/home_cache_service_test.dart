import 'package:carenest/app/features/home/models/home_dashboard_data.dart';
import 'package:carenest/app/features/home/services/home_cache_service.dart';
import 'package:carenest/app/features/teams/models/team_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('caches and restores the worker home cards', () async {
    final cache = HomeCacheService();
    final data = HomeDashboardData(
      upcomingAppointments: [
        {
          'clientEmail': 'sil.ndia@mailinator.com',
          'schedule': [
            {'date': '2026-10-24', 'startTime': '15:00', 'endTime': '23:00'},
          ],
        },
      ],
      activeBroadcasts: [
        EmergencyBroadcast(
          id: 'b1',
          teamId: 't1',
          initiatorId: 'u1',
          type: 'general',
          message: 'Test',
          createdAt: DateTime(2026, 10, 24),
        ),
      ],
    );

    await cache.save('worker@example.com', data);
    final snapshot = await cache.read('worker@example.com');

    expect(snapshot, isNotNull);
    expect(snapshot!.data.upcomingAppointments, hasLength(1));
    expect(
      snapshot.data.upcomingAppointments.first['clientEmail'],
      'sil.ndia@mailinator.com',
    );
    expect(snapshot.data.activeBroadcasts.single.message, 'Test');
    expect(cache.isFresh(snapshot.cachedAt), isTrue);
  });

  test('returns null for an uncached user', () async {
    final cache = HomeCacheService();
    expect(await cache.read('missing@example.com'), isNull);
  });
}
