
import 'package:carenest/app/features/settings/repositories/date_preference_repository.dart';
import 'package:flutter/material.dart';

/// ViewModel for managing the date format preference UI state and lifecycle.
///
/// Exposes loading, error, and save success states, along with the selected
/// preference value ('mdy' or 'dmy').
class DateFormatSettingsViewModel extends ChangeNotifier {
  final DatePreferenceRepository _repository;

  String _selected = 'dmy';
  bool _isLoading = false;
  String? _errorMessage;
  bool _saveSucceeded = false;
  bool _loaded = false;

  /// Construct with an injected repository.
  DateFormatSettingsViewModel(this._repository);

  /// Currently selected preference ('mdy' or 'dmy').
  String get selected => _selected;

  /// True while loading or saving.
  bool get isLoading => _isLoading;

  /// Last error message, if any.
  String? get errorMessage => _errorMessage;

  /// True when the last save completed successfully.
  bool get saveSucceeded => _saveSucceeded;

  /// True once a load attempt has completed.
  bool get isLoaded => _loaded;

  /// Load the stored preference. Defaults to 'dmy' when not set.
  Future<void> load() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final pref = await _repository.getPreference();
      _selected = (pref == 'mdy' || pref == 'dmy') ? pref! : 'dmy';
      _saveSucceeded = false;
      _loaded = true;
    } catch (e) {
      _errorMessage = 'Failed to load preference: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Select a preference value. Only 'mdy' or 'dmy' are allowed.
  void select(String preference) {
    final normalized = preference.trim().toLowerCase();
    if (normalized != 'mdy' && normalized != 'dmy') {
      _errorMessage = 'Invalid preference';
      notifyListeners();
      return;
    }
    _selected = normalized;
    _errorMessage = null;
    notifyListeners();
  }

  /// Persist the selected preference via the repository.
  Future<void> save() async {
    _isLoading = true;
    _saveSucceeded = false;
    _errorMessage = null;
    notifyListeners();
    try {
      await _repository.savePreference(_selected);
      _saveSucceeded = true;
    } catch (e) {
      _errorMessage = e.toString();
      _saveSucceeded = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}