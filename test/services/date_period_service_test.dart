import 'package:flutter_test/flutter_test.dart';
import 'package:carenest/models/date_period.dart';
import 'package:carenest/models/period_config.dart';
import 'package:carenest/services/date_period_service.dart';
import 'package:carenest/repositories/period_config_repository.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';

/// A lightweight fake repository backed by in-memory map for tests.
class FakePrefs extends SharedPreferencesUtils {
  final Map<String, String> _store = {};
  bool _inited = false;
  @override
  Future<void> init() async {
    _inited = true;
  }
  @override
  Future<void> setString(String key, String value) async {
    if (!_inited) await init();
    _store[key] = value;
  }
  @override
  String? getString(String key) {
    return _store[key];
  }
  @override
  Future<void> remove(String key) async {
    if (!_inited) await init();
    _store.remove(key);
  }
}

void main() {
  group('DatePeriodService.weekPeriodFor', () {
    test('Monday-Sunday period for 08/11/2025 (Saturday) is 03/11 to 09/11', () {
      final prefs = FakePrefs();
      final repo = PeriodConfigRepository(prefs);
      final svc = DatePeriodService(repo);
      final date = DateTime(2025, 11, 8);
      final p = svc.weekPeriodFor(date, weekStartDay: DateTime.monday);
      expect(p.start, DateTime(2025, 11, 3));
      expect(p.end, DateTime(2025, 11, 9));
    });

    test('Sunday-start convention: week containing 2025-11-08 starts 2025-11-02', () {
      final prefs = FakePrefs();
      final repo = PeriodConfigRepository(prefs);
      final svc = DatePeriodService(repo);
      final date = DateTime(2025, 11, 8);
      final p = svc.weekPeriodFor(date, weekStartDay: DateTime.sunday);
      expect(p.start, DateTime(2025, 11, 2));
      expect(p.end, DateTime(2025, 11, 8));
    });
  });

  group('DatePeriodService.derivePeriodFromItems', () {
    test('Single valid date snaps to its week', () {
      final svc = DatePeriodService(PeriodConfigRepository(FakePrefs()));
      final p = svc.derivePeriodFromItems(['08/11/2025']);
      expect(p.start, DateTime(2025, 11, 3));
      expect(p.end, DateTime(2025, 11, 9));
    });

    test('Multiple dates across two weeks returns union', () {
      final svc = DatePeriodService(PeriodConfigRepository(FakePrefs()));
      final p = svc.derivePeriodFromItems(['2025-11-08', '2025-11-10']);
      expect(p.start, DateTime(2025, 11, 3));
      expect(p.end, DateTime(2025, 11, 16));
    });

    test('Mixed date formats resolve to same week', () {
      final svc = DatePeriodService(PeriodConfigRepository(FakePrefs()));
      final p = svc.derivePeriodFromItems(['2025-11-08', '08/11/2025']);
      expect(p.start, DateTime(2025, 11, 3));
      expect(p.end, DateTime(2025, 11, 9));
    });

    test('Invalid dates throw PeriodCalculationException', () {
      final svc = DatePeriodService(PeriodConfigRepository(FakePrefs()));
      expect(
        () => svc.derivePeriodFromItems(['abc', '99/99/9999']),
        throwsA(isA<PeriodCalculationException>()),
      );
    });

    test('Empty items list throws PeriodCalculationException', () {
      final svc = DatePeriodService(PeriodConfigRepository(FakePrefs()));
      expect(() => svc.derivePeriodFromItems([]),
          throwsA(isA<PeriodCalculationException>()));
    });
  });

  group('DatePeriodService.resolvePeriodForEmployeeClient', () {
    test('Uses explicit dates when provided', () async {
      final svc = DatePeriodService(PeriodConfigRepository(FakePrefs()));
      final s = DateTime(2025, 1, 1);
      final e = DateTime(2025, 1, 5);
      final p = await svc.resolvePeriodForEmployeeClient(
        employeeEmail: 'e@x.com',
        clientEmail: 'c@x.com',
        startDate: s,
        endDate: e,
      );
      expect(p.start, s);
      expect(p.end, e);
    });

    test('Loads config and derives from items with Sunday start', () async {
      final fake = FakePrefs();
      final repo = PeriodConfigRepository(fake);
      final svc = DatePeriodService(repo);
      final cfg = PeriodConfig(
        employeeEmail: 'e@x.com',
        clientEmail: 'c@x.com',
        weekStartDay: DateTime.sunday,
      );
      await repo.saveConfig(cfg);
      final p = await svc.resolvePeriodForEmployeeClient(
        employeeEmail: 'e@x.com',
        clientEmail: 'c@x.com',
        itemDates: ['2025-11-08'],
      );
      expect(p.start, DateTime(2025, 11, 2));
      expect(p.end, DateTime(2025, 11, 8));
    });

    test('Fallback to previous week when no inputs are provided', () async {
      final svc = DatePeriodService(PeriodConfigRepository(FakePrefs()));
      final p = await svc.resolvePeriodForEmployeeClient(
        employeeEmail: 'e@x.com',
        clientEmail: 'c@x.com',
      );
      // Cannot assert exact dates (depends on current date), but ensure 7-day length
      final diff = p.end.difference(p.start).inDays;
      expect(diff, 6); // inclusive period has 6-day difference
    });

    test('Partial explicit start only returns end at end-of-week', () async {
      final svc = DatePeriodService(PeriodConfigRepository(FakePrefs()));
      final s = DateTime(2025, 1, 1);
      final p = await svc.resolvePeriodForEmployeeClient(
        employeeEmail: 'e@x.com',
        clientEmail: 'c@x.com',
        startDate: s,
      );
      expect(p.start, s);
      expect(p.end, DateTime(2025, 1, 5));
    });

    test('Partial explicit end only returns start at start-of-week', () async {
      final svc = DatePeriodService(PeriodConfigRepository(FakePrefs()));
      final e = DateTime(2025, 1, 5);
      final p = await svc.resolvePeriodForEmployeeClient(
        employeeEmail: 'e@x.com',
        clientEmail: 'c@x.com',
        endDate: e,
      );
      expect(p.start, DateTime(2024, 12, 30));
      expect(p.end, e);
    });
  });
}