import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/notifications/models/notification_settings_model.dart';
import 'package:carenest/app/features/notifications/repositories/notification_repository.dart';

class NotificationSettingsState {
  final NotificationSettingsModel? settings;
  final bool isLoading;
  final String? errorMessage;

  const NotificationSettingsState({
    this.settings,
    this.isLoading = false,
    this.errorMessage,
  });

  NotificationSettingsState copyWith({
    NotificationSettingsModel? settings,
    bool? isLoading,
    String? errorMessage,
  }) {
    return NotificationSettingsState(
      settings: settings ?? this.settings,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class NotificationSettingsViewModel
    extends Notifier<NotificationSettingsState> {
  late final NotificationRepository _repository;

  @override
  NotificationSettingsState build() {
    _repository = ref.watch(notificationRepositoryProvider);
    return const NotificationSettingsState();
  }

  /// Load notification settings from the backend
  Future<void> loadSettings() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final settings = await _repository.getSettings();
      state = state.copyWith(settings: settings);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  /// Update notification settings
  Future<void> updateSettings(NotificationSettingsModel newSettings) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final settings = await _repository.updateSettings(newSettings);
      state = state.copyWith(settings: settings);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
      // Reload settings to ensure UI is in sync with server
      await loadSettings();
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  /// Toggle Shift Reminders
  Future<void> toggleShiftReminders(bool enabled) async {
    if (state.settings == null) return;
    final newSettings = state.settings!.copyWith(
      shiftRemindersEnabled: enabled,
    );
    await updateSettings(newSettings);
  }

  /// Toggle Geofence Reminders
  Future<void> toggleGeofenceReminders(bool enabled) async {
    if (state.settings == null) return;
    final newSettings = state.settings!.copyWith(geofenceEnabled: enabled);
    await updateSettings(newSettings);
  }

  /// Toggle Expense Reminders
  Future<void> toggleExpenseReminders(bool enabled) async {
    if (state.settings == null) return;
    final newSettings = state.settings!.copyWith(
      expenseRemindersEnabled: enabled,
    );
    await updateSettings(newSettings);
  }

  /// Toggle Timesheet Reminders
  Future<void> toggleTimesheetReminders(bool enabled) async {
    if (state.settings == null) return;
    final newSettings = state.settings!.copyWith(
      timesheetRemindersEnabled: enabled,
    );
    await updateSettings(newSettings);
  }

  /// Update Quiet Hours
  Future<void> updateQuietHours(String start, String end) async {
    if (state.settings == null) return;

    final newQuietHours = QuietHours(
      start: start,
      end: end,
      timezone: state.settings!.quietHours?.timezone ?? 'Australia/Sydney',
    );

    final newSettings = state.settings!.copyWith(quietHours: newQuietHours);
    await updateSettings(newSettings);
  }
}
