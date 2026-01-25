import 'package:flutter/foundation.dart';
import 'package:carenest/app/features/notifications/models/notification_settings_model.dart';
import 'package:carenest/app/features/notifications/repositories/notification_repository.dart';

class NotificationSettingsViewModel extends ChangeNotifier {
  final NotificationRepository _repository;

  NotificationSettingsViewModel(this._repository);

  NotificationSettingsModel? _settings;
  bool _isLoading = false;
  String? _errorMessage;

  NotificationSettingsModel? get settings => _settings;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Load notification settings from the backend
  Future<void> loadSettings() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _settings = await _repository.getSettings();
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('Error loading notification settings: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Update notification settings
  Future<void> updateSettings(NotificationSettingsModel newSettings) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _settings = await _repository.updateSettings(newSettings);
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('Error updating notification settings: $e');
      // Reload settings to ensure UI is in sync with server
      await loadSettings(); 
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Toggle Shift Reminders
  Future<void> toggleShiftReminders(bool enabled) async {
    if (_settings == null) return;
    final newSettings = _settings!.copyWith(shiftRemindersEnabled: enabled);
    await updateSettings(newSettings);
  }

  /// Toggle Geofence Reminders
  Future<void> toggleGeofenceReminders(bool enabled) async {
    if (_settings == null) return;
    final newSettings = _settings!.copyWith(geofenceEnabled: enabled);
    await updateSettings(newSettings);
  }

  /// Toggle Expense Reminders
  Future<void> toggleExpenseReminders(bool enabled) async {
    if (_settings == null) return;
    final newSettings = _settings!.copyWith(expenseRemindersEnabled: enabled);
    await updateSettings(newSettings);
  }

  /// Toggle Timesheet Reminders
  Future<void> toggleTimesheetReminders(bool enabled) async {
    if (_settings == null) return;
    final newSettings = _settings!.copyWith(timesheetRemindersEnabled: enabled);
    await updateSettings(newSettings);
  }

  /// Update Quiet Hours
  Future<void> updateQuietHours(String start, String end) async {
    if (_settings == null) return;
    
    final newQuietHours = QuietHours(
      start: start,
      end: end,
      timezone: _settings!.quietHours?.timezone ?? 'Australia/Sydney',
    );
    
    final newSettings = _settings!.copyWith(quietHours: newQuietHours);
    await updateSettings(newSettings);
  }
}
