import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/providers/period_providers.dart';
import 'package:carenest/services/date_parser_service.dart';
import 'package:carenest/services/date_period_service.dart';

/// Fake SharedPreferencesUtils backed by in-memory map to simulate persistence.
class _FakePrefs extends SharedPreferencesUtils {
  final Map<String, String> _store = {};
  bool _inited = false;

  @override
  Future<void> init() async {
    _inited = true;
  }

  @override
  Future<void> saveDateFormatPreference(String preference) async {
    if (!_inited) await init();
    final normalized = preference.trim().toLowerCase();
    if (normalized != 'mdy' && normalized != 'dmy') {
      throw ArgumentError('Invalid date format preference: $preference');
    }
    _store[SharedPreferencesUtils.kDateFormatPreferenceKey] = normalized;
  }

  @override
  String? getDateFormatPreference() {
    final v = _store[SharedPreferencesUtils.kDateFormatPreferenceKey];
    switch (v?.toLowerCase()) {
      case 'mdy':
        return 'mdy';
      case 'dmy':
        return 'dmy';
      default:
        return null;
    }
  }
}

void main() {
  group('Date format preference integration via providers', () {
    test('dateParserServiceProvider reflects dmy by default and mdy after change', () async {
      final fakePrefs = _FakePrefs();
      await fakePrefs.init();

      // No preference saved => defaults to DMY (preferUs=false)
      final container = ProviderContainer(overrides: [
        sharedPreferencesProvider.overrideWith((ref) => fakePrefs),
      ]);

      final parserDmy = container.read(dateParserServiceProvider);
      final d1 = parserDmy.parseFlexible('01/02/2025');
      expect(d1, isNotNull);
      // DMY => 1 Feb 2025
      expect(d1, DateTime(2025, 2, 1));

      // Now save US preference and refresh provider
      await fakePrefs.saveDateFormatPreference('mdy');
      final parserMdy = container.refresh(dateParserServiceProvider);
      final d2 = parserMdy.parseFlexible('01/02/2025');
      expect(d2, isNotNull);
      // MDY => Jan 2, 2025
      expect(d2, DateTime(2025, 1, 2));
    });

    test('datePeriodServiceProvider uses parser preference in derivePeriodFromItems', () async {
      final fakePrefsDmy = _FakePrefs();
      await fakePrefsDmy.init();
      await fakePrefsDmy.saveDateFormatPreference('dmy');
      final containerDmy = ProviderContainer(overrides: [
        sharedPreferencesProvider.overrideWith((ref) => fakePrefsDmy),
      ]);

      final svcDmy = containerDmy.read(datePeriodServiceProvider);
      // Items: "01/02/2025" and "02/02/2025"
      // DMY => dates are 1 Feb and 2 Feb 2025, same week (Mon start)
      final periodDmy = svcDmy.derivePeriodFromItems(['01/02/2025', '02/02/2025']);
      expect(periodDmy.start, DateTime(2025, 1, 27)); // Monday of that week
      expect(periodDmy.end, DateTime(2025, 2, 2));   // Sunday of that week

      final fakePrefsMdy = _FakePrefs();
      await fakePrefsMdy.init();
      await fakePrefsMdy.saveDateFormatPreference('mdy');
      final containerMdy = ProviderContainer(overrides: [
        sharedPreferencesProvider.overrideWith((ref) => fakePrefsMdy),
      ]);

      final svcMdy = containerMdy.read(datePeriodServiceProvider);
      // MDY => dates are Jan 2 and Feb 2 2025 => multiple weeks, union from earliest week-start to latest week-end
      final periodMdy = svcMdy.derivePeriodFromItems(['01/02/2025', '02/02/2025']);
      expect(periodMdy.start, DateTime(2024, 12, 30)); // Monday of week containing 2025-01-02
      expect(periodMdy.end, DateTime(2025, 2, 2));     // Sunday of week containing 2025-02-02
    });
  });
}