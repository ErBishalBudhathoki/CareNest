import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/settings/repositories/date_preference_repository.dart';
import 'package:carenest/app/features/settings/viewmodels/date_format_settings_viewmodel.dart';
import 'package:carenest/app/features/settings/providers/settings_providers.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';

/// Fake SharedPreferencesUtils backed by in-memory map for deterministic tests.
class _FakePrefs extends SharedPreferencesUtils {
  final Map<String, String> _store = {};

  _FakePrefs() : super.forTesting();

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
  late ProviderContainer container;
  late DateFormatSettingsViewModel vm;

  setUp(() {
    container = ProviderContainer(overrides: [
      datePreferenceRepositoryProvider
          .overrideWith((ref) => DatePreferenceRepository(_FakePrefs())),
    ]);
    vm = container.read(dateFormatSettingsViewModelProvider.notifier);
  });

  tearDown(() {
    container.dispose();
  });

  group('DateFormatSettingsViewModel', () {
    test('loads default dmy when no preference set', () async {
      await vm.load();
      expect(vm.state.selected, 'dmy');
      expect(vm.state.errorMessage, isNull);
      expect(vm.state.isLoading, false);
    });

    test('save mdy persists and reports success', () async {
      await vm.load();
      vm.select('mdy');
      await vm.save();
      expect(vm.state.saveSucceeded, true);
    });

    test('invalid selection sets error and does not change selected', () async {
      await vm.load();
      final initial = vm.state.selected;
      vm.select('xyz');
      expect(vm.state.errorMessage, isNotNull);
      expect(vm.state.selected, initial);
    });
  });
}
