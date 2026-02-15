import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import '../models/notification_preferences.dart';

class NotificationPreferencesViewModel
    extends StateNotifier<AsyncValue<NotificationPreferences>> {
  final ApiMethod _apiMethod;
  final String _userId;

  NotificationPreferencesViewModel(this._apiMethod, this._userId)
      : super(const AsyncValue.loading()) {
    loadPreferences();
  }

  Future<void> loadPreferences() async {
    state = const AsyncValue.loading();

    try {
      final response =
          await _apiMethod.get('api/notifications/preferences/$_userId');

      if (response['success'] == true && response['data'] != null) {
        final preferences = NotificationPreferences.fromJson(response['data']);
        state = AsyncValue.data(preferences);
      } else {
        // Use default preferences if none exist
        final defaultPrefs =
            NotificationPreferences.defaultPreferences(_userId);
        state = AsyncValue.data(defaultPrefs);
        // Save default preferences
        await _savePreferences(defaultPrefs);
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> toggleCategory(
      NotificationCategory category, bool enabled) async {
    final currentPrefs = state.value;
    if (currentPrefs == null) return;

    final updatedCategories = Map<NotificationCategory, bool>.from(
      currentPrefs.categoryEnabled,
    );
    updatedCategories[category] = enabled;

    final updatedPrefs = currentPrefs.copyWith(
      categoryEnabled: updatedCategories,
      lastUpdated: DateTime.now(),
    );

    state = AsyncValue.data(updatedPrefs);
    await _savePreferences(updatedPrefs);
  }

  Future<void> toggleChannel(
    NotificationCategory category,
    NotificationChannel channel,
    bool enabled,
  ) async {
    final currentPrefs = state.value;
    if (currentPrefs == null) return;

    final updatedChannels =
        Map<NotificationCategory, List<NotificationChannel>>.from(
      currentPrefs.categoryChannels,
    );

    final currentCategoryChannels = List<NotificationChannel>.from(
      updatedChannels[category] ?? [],
    );

    if (enabled) {
      if (!currentCategoryChannels.contains(channel)) {
        currentCategoryChannels.add(channel);
      }
    } else {
      currentCategoryChannels.remove(channel);
    }

    updatedChannels[category] = currentCategoryChannels;

    final updatedPrefs = currentPrefs.copyWith(
      categoryChannels: updatedChannels,
      lastUpdated: DateTime.now(),
    );

    state = AsyncValue.data(updatedPrefs);
    await _savePreferences(updatedPrefs);
  }

  Future<void> updateQuietHours(QuietHours quietHours) async {
    final currentPrefs = state.value;
    if (currentPrefs == null) return;

    final updatedPrefs = currentPrefs.copyWith(
      quietHours: quietHours,
      lastUpdated: DateTime.now(),
    );

    state = AsyncValue.data(updatedPrefs);
    await _savePreferences(updatedPrefs);
  }

  Future<void> updateGeofenceEnabled(bool enabled) async {
    final currentPrefs = state.value;
    if (currentPrefs == null) return;

    final updatedPrefs = currentPrefs.copyWith(
      geofenceEnabled: enabled,
      lastUpdated: DateTime.now(),
    );

    state = AsyncValue.data(updatedPrefs);
    await _savePreferences(updatedPrefs);
  }

  Future<void> updateGeofenceRadius(double radiusKm) async {
    final currentPrefs = state.value;
    if (currentPrefs == null) return;

    final updatedPrefs = currentPrefs.copyWith(
      geofenceRadiusKm: radiusKm,
      lastUpdated: DateTime.now(),
    );

    state = AsyncValue.data(updatedPrefs);
    await _savePreferences(updatedPrefs);
  }

  Future<void> updateSmartTiming(bool enabled) async {
    final currentPrefs = state.value;
    if (currentPrefs == null) return;

    final updatedPrefs = currentPrefs.copyWith(
      smartTimingEnabled: enabled,
      lastUpdated: DateTime.now(),
    );

    state = AsyncValue.data(updatedPrefs);
    await _savePreferences(updatedPrefs);
  }

  Future<void> updateSound(bool enabled) async {
    final currentPrefs = state.value;
    if (currentPrefs == null) return;

    final updatedPrefs = currentPrefs.copyWith(
      soundEnabled: enabled,
      lastUpdated: DateTime.now(),
    );

    state = AsyncValue.data(updatedPrefs);
    await _savePreferences(updatedPrefs);
  }

  Future<void> updateVibration(bool enabled) async {
    final currentPrefs = state.value;
    if (currentPrefs == null) return;

    final updatedPrefs = currentPrefs.copyWith(
      vibrationEnabled: enabled,
      lastUpdated: DateTime.now(),
    );

    state = AsyncValue.data(updatedPrefs);
    await _savePreferences(updatedPrefs);
  }

  Future<void> updateBadge(bool enabled) async {
    final currentPrefs = state.value;
    if (currentPrefs == null) return;

    final updatedPrefs = currentPrefs.copyWith(
      badgeEnabled: enabled,
      lastUpdated: DateTime.now(),
    );

    state = AsyncValue.data(updatedPrefs);
    await _savePreferences(updatedPrefs);
  }

  Future<void> _savePreferences(NotificationPreferences preferences) async {
    try {
      await _apiMethod.put(
        'api/notifications/preferences/${preferences.userId}',
        body: preferences.toJson(),
      );
    } catch (e) {
      // Log error but don't throw - we've already updated local state
      print('Error saving notification preferences: $e');
    }
  }
}

final notificationPreferencesViewModelProvider = StateNotifierProvider<
    NotificationPreferencesViewModel,
    AsyncValue<NotificationPreferences>>((ref) {
  // In production, get userId from auth provider
  const userId = 'current-user-id'; // TODO: Get from auth
  return NotificationPreferencesViewModel(
    ref.read(app_providers.apiMethodProvider),
    userId,
  );
});
