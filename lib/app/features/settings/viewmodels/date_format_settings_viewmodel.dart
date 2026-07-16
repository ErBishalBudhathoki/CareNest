
import 'package:carenest/app/features/settings/repositories/date_preference_repository.dart';

/// ViewModel for managing the date format preference UI state and lifecycle.
///
/// Exposes loading, error, and save success states, along with the selected
/// preference value ('mdy' or 'dmy').
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/settings_providers.dart';

class DateFormatSettingsState {
  final String selected;
  final bool isLoading;
  final String? errorMessage;
  final bool saveSucceeded;
  final bool isLoaded;

  DateFormatSettingsState({
    this.selected = 'dmy',
    this.isLoading = false,
    this.errorMessage,
    this.saveSucceeded = false,
    this.isLoaded = false,
  });

  DateFormatSettingsState copyWith({
    String? selected,
    bool? isLoading,
    String? errorMessage,
    bool? saveSucceeded,
    bool? isLoaded,
  }) {
    return DateFormatSettingsState(
      selected: selected ?? this.selected,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      saveSucceeded: saveSucceeded ?? this.saveSucceeded,
      isLoaded: isLoaded ?? this.isLoaded,
    );
  }
}

class DateFormatSettingsViewModel extends Notifier<DateFormatSettingsState> {
  late final DatePreferenceRepository _repository;

  @override
  DateFormatSettingsState build() {
    _repository = ref.watch(datePreferenceRepositoryProvider);
    return DateFormatSettingsState();
  }


  /// Load the stored preference. Defaults to 'dmy' when not set.
  Future<void> load() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final pref = await _repository.getPreference();
      state = state.copyWith(selected: (pref == 'mdy' || pref == 'dmy') ? pref! : 'dmy', saveSucceeded: false, isLoaded: true);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to load preference: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  /// Select a preference value. Only 'mdy' or 'dmy' are allowed.
  void select(String preference) {
    final normalized = preference.trim().toLowerCase();
    if (normalized != 'mdy' && normalized != 'dmy') {
      state = state.copyWith(errorMessage: 'Invalid preference');
      return;
    }
    state = state.copyWith(selected: normalized, errorMessage: null);
  }

  /// Persist the selected preference via the repository.
  Future<void> save() async {
    state = state.copyWith(isLoading: true, saveSucceeded: false, errorMessage: null);
    try {
      await _repository.savePreference(state.selected);
      state = state.copyWith(saveSucceeded: true);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), saveSucceeded: false);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}