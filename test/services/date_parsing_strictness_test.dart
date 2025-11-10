import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:carenest/services/date_period_service.dart';
import 'package:carenest/services/date_parser_service.dart';
import 'package:carenest/repositories/period_config_repository.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/models/date_period.dart';

/// Fake SharedPreferencesUtils backed by in-memory map for deterministic tests.
class _FakePrefs extends SharedPreferencesUtils {
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

/// Tests to ensure strict date parsing rejects invalid inputs across formats
/// and continues to accept valid edge cases (e.g., leap day).
void main() {
  group('DatePeriodService strict parsing - invalid inputs', () {
    test('Invalid dd/MM - 99/99/9999 throws PeriodCalculationException', () {
      final svc = DatePeriodService(PeriodConfigRepository(_FakePrefs()));
      expect(
        () => svc.derivePeriodFromItems(['99/99/9999']),
        throwsA(isA<PeriodCalculationException>()),
      );
    });

    test('Invalid day - 32/01/2025 throws PeriodCalculationException', () {
      final svc = DatePeriodService(PeriodConfigRepository(_FakePrefs()));
      expect(
        () => svc.derivePeriodFromItems(['32/01/2025']),
        throwsA(isA<PeriodCalculationException>()),
      );
    });

    test('Non-existent date - 31/02/2025 throws PeriodCalculationException', () {
      final svc = DatePeriodService(PeriodConfigRepository(_FakePrefs()));
      expect(
        () => svc.derivePeriodFromItems(['31/02/2025']),
        throwsA(isA<PeriodCalculationException>()),
      );
    });

    test('Invalid ISO-like - 2025-02-30 throws PeriodCalculationException', () {
      final svc = DatePeriodService(PeriodConfigRepository(_FakePrefs()));
      expect(
        () => svc.derivePeriodFromItems(['2025-02-30']),
        throwsA(isA<PeriodCalculationException>()),
      );
    });

    test('Non-leap year Feb 29 - 02/29/2021 throws PeriodCalculationException', () {
      final svc = DatePeriodService(PeriodConfigRepository(_FakePrefs()));
      expect(
        () => svc.derivePeriodFromItems(['02/29/2021']),
        throwsA(isA<PeriodCalculationException>()),
      );
    });

    test('Non-date string - abc throws PeriodCalculationException', () {
      final svc = DatePeriodService(PeriodConfigRepository(_FakePrefs()));
      expect(
        () => svc.derivePeriodFromItems(['abc']),
        throwsA(isA<PeriodCalculationException>()),
      );
    });

    test('Empty string throws PeriodCalculationException', () {
      final svc = DatePeriodService(PeriodConfigRepository(_FakePrefs()));
      expect(
        () => svc.derivePeriodFromItems(['']),
        throwsA(isA<PeriodCalculationException>()),
      );
    });
  });

  group('DatePeriodService strict parsing - valid edge cases', () {
    test('Valid leap day dd/MM/yyyy accepted and snaps to week', () {
      final svc = DatePeriodService(PeriodConfigRepository(_FakePrefs()));
      final p = svc.derivePeriodFromItems(['29/02/2024']);
      expect(p.start, DateTime(2024, 2, 26));
      expect(p.end, DateTime(2024, 3, 3));
    });

    test('Valid leap day yyyy-MM-dd accepted and snaps to week', () {
      final svc = DatePeriodService(PeriodConfigRepository(_FakePrefs()));
      final p = svc.derivePeriodFromItems(['2024-02-29']);
      expect(p.start, DateTime(2024, 2, 26));
      expect(p.end, DateTime(2024, 3, 3));
    });
  });

  group('DatePeriodService mixed lists and additional formats', () {
    test('Mixed valid + invalid dates logs summary and derives week', () {
      final svc = DatePeriodService(PeriodConfigRepository(_FakePrefs()));
      final captured = <String>[];
      final originalDebugPrint = debugPrint;
      debugPrint = (String? message, {int? wrapWidth}) {
        if (message != null) captured.add(message);
      };
      try {
        final p = svc.derivePeriodFromItems(['2025-11-08', '31/02/2025', 'abc']);
        expect(p.start, DateTime(2025, 11, 3));
        expect(p.end, DateTime(2025, 11, 9));
        expect(
          captured.any((m) => m.contains(
              'DatePeriodService.derivePeriodFromItems: Ignoring invalid dates: [31/02/2025, abc]')),
          isTrue,
        );
      } finally {
        debugPrint = originalDebugPrint;
      }
    });

    test('Supports time-inclusive ISO yyyy-MM-ddTHH:mm:ssZ valid', () {
      final svc = DatePeriodService(PeriodConfigRepository(_FakePrefs()));
      final p = svc.derivePeriodFromItems(['2024-02-29T10:30:00Z']);
      expect(p.start, DateTime(2024, 2, 26));
      expect(p.end, DateTime(2024, 3, 3));
    });

    test('Rejects invalid time-inclusive ISO yyyy-MM-ddTHH:mm:ssZ', () {
      final svc = DatePeriodService(PeriodConfigRepository(_FakePrefs()));
      expect(
        () => svc.derivePeriodFromItems(['2025-02-30T10:30:00Z']),
        throwsA(isA<PeriodCalculationException>()),
      );
    });

    test('Accepts d/M/yyyy without leading zeros', () {
      final svc = DatePeriodService(PeriodConfigRepository(_FakePrefs()));
      final p = svc.derivePeriodFromItems(['1/2/2025']); // 1 Feb 2025
      expect(p.start, DateTime(2025, 1, 27));
      expect(p.end, DateTime(2025, 2, 2));
    });

    test('Accepts M/d/yyyy without leading zeros', () {
      final svc = DatePeriodService(PeriodConfigRepository(_FakePrefs()));
      final p = svc.derivePeriodFromItems(['2/13/2025']); // Feb 13, 2025
      expect(p.start, DateTime(2025, 2, 10));
      expect(p.end, DateTime(2025, 2, 16));
    });
  });

  group('Locale preference for ambiguous numeric dates', () {
    test('Ambiguous 1/2/2025 respects US preference (M/d => Jan 2, 2025)', () {
      final parser = DateParserService(preferUsFormat: true);
      final svc = DatePeriodService(PeriodConfigRepository(_FakePrefs()), parser);
      final p = svc.derivePeriodFromItems(['1/2/2025']);
      expect(p.start, DateTime(2024, 12, 30)); // week of Jan 2, 2025
      expect(p.end, DateTime(2025, 1, 5));
    });
  });

  group('Extended ISO datetime variations', () {
    test('Valid ISO with milliseconds 2024-02-29T10:30:00.123Z', () {
      final svc = DatePeriodService(PeriodConfigRepository(_FakePrefs()));
      final p = svc.derivePeriodFromItems(['2024-02-29T10:30:00.123Z']);
      expect(p.start, DateTime(2024, 2, 26));
      expect(p.end, DateTime(2024, 3, 3));
    });

    test('Valid ISO with offset 2024-02-29T10:30:00+05:30', () {
      final svc = DatePeriodService(PeriodConfigRepository(_FakePrefs()));
      final p = svc.derivePeriodFromItems(['2024-02-29T10:30:00+05:30']);
      expect(p.start, DateTime(2024, 2, 26));
      expect(p.end, DateTime(2024, 3, 3));
    });

    test('Valid ISO with microseconds 2024-02-29T10:30:00.123456Z', () {
      final svc = DatePeriodService(PeriodConfigRepository(_FakePrefs()));
      final p = svc.derivePeriodFromItems(['2024-02-29T10:30:00.123456Z']);
      expect(p.start, DateTime(2024, 2, 26));
      expect(p.end, DateTime(2024, 3, 3));
    });

    test('Invalid ISO non-leap 2021-02-29T00:00:00Z throws', () {
      final svc = DatePeriodService(PeriodConfigRepository(_FakePrefs()));
      expect(
        () => svc.derivePeriodFromItems(['2021-02-29T00:00:00Z']),
        throwsA(isA<PeriodCalculationException>()),
      );
    });
  });
}