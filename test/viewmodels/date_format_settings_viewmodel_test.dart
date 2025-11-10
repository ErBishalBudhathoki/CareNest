import 'package:flutter_test/flutter_test.dart';
import 'package:carenest/app/features/settings/repositories/date_preference_repository.dart';
import 'package:carenest/app/features/settings/viewmodels/date_format_settings_viewmodel.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';

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
  group('DateFormatSettingsViewModel', () {
    test('loads default dmy when no preference set', () async {
      final repo = DatePreferenceRepository(_FakePrefs());
      final vm = DateFormatSettingsViewModel(repo);
      await vm.load();
      expect(vm.selected, 'dmy');
      expect(vm.errorMessage, isNull);
      expect(vm.isLoading, false);
    });

    test('save mdy persists and reports success', () async {
      final prefs = _FakePrefs();
      final repo = DatePreferenceRepository(prefs);
      final vm = DateFormatSettingsViewModel(repo);
      await vm.load();
      vm.select('mdy');
      await vm.save();
      expect(vm.saveSucceeded, true);
      expect(prefs.getString(SharedPreferencesUtils.kDateFormatPreferenceKey), 'mdy');
    });

    test('invalid selection sets error and does not change selected', () async {
      final repo = DatePreferenceRepository(_FakePrefs());
      final vm = DateFormatSettingsViewModel(repo);
      await vm.load();
      final initial = vm.selected;
      vm.select('xyz');
      expect(vm.errorMessage, isNotNull);
      expect(vm.selected, initial);
    });
  });
}