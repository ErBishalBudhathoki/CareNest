import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/settings/repositories/date_preference_repository.dart';
import 'package:carenest/app/features/settings/viewmodels/date_format_settings_viewmodel.dart';

/// Repository provider for date format preference.
final datePreferenceRepositoryProvider = Provider<DatePreferenceRepository>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return DatePreferenceRepository(prefs);
});

/// ViewModel provider for the Date Format Settings screen.
final dateFormatSettingsViewModelProvider =
    ChangeNotifierProvider<DateFormatSettingsViewModel>((ref) {
  final repo = ref.watch(datePreferenceRepositoryProvider);
  final vm = DateFormatSettingsViewModel(repo);
  // Lazy load can be triggered by the view; keeping construction simple.
  return vm;
});