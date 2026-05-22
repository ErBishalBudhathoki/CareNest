import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import '../models/notification_preferences.dart';

class NotificationPreferencesViewModel
    extends StateNotifier<AsyncValue<NotificationPreferences>> {
  final ApiMethod _apiMethod;
  final SharedPreferencesUtils _sharedPrefs;
  bool _hasUnsavedChanges = false;
  bool _isSaving = false;
  String? _saveError;
  DateTime? _lastSavedAt;
  List<String>? _userIdentifierCandidates;

  bool _isPlaceholderIdentifier(String value) {
    final normalized = value.trim().toLowerCase();
    return normalized.isEmpty ||
        normalized == 'current-user-id' ||
        normalized == 'me' ||
        normalized == 'self' ||
        normalized == 'local-user';
  }

  NotificationPreferencesViewModel(this._apiMethod, this._sharedPrefs)
      : super(const AsyncValue.loading()) {
    loadPreferences();
  }

  bool get hasUnsavedChanges => _hasUnsavedChanges;
  bool get isSaving => _isSaving;
  String? get saveError => _saveError;
  DateTime? get lastSavedAt => _lastSavedAt;

  Future<List<String>> _resolveUserIdentifierCandidates() async {
    if (_userIdentifierCandidates != null &&
        _userIdentifierCandidates!.isNotEmpty) {
      return _userIdentifierCandidates!;
    }

    await _sharedPrefs.init();

    final candidates = <String>[];
    final userId = _sharedPrefs.getUserId()?.trim();
    final userEmail = _sharedPrefs.getUserEmail()?.trim().toLowerCase();

    if (userId != null &&
        userId.isNotEmpty &&
        !_isPlaceholderIdentifier(userId)) {
      candidates.add(userId);
    }
    if (userEmail != null &&
        userEmail.isNotEmpty &&
        !candidates.contains(userEmail)) {
      candidates.add(userEmail);
    }

    _userIdentifierCandidates = candidates;
    return candidates;
  }

  void _refreshState() {
    final current = state.value;
    if (current != null) {
      state = AsyncValue.data(current.copyWith());
    }
  }

  Future<void> loadPreferences() async {
    state = const AsyncValue.loading();

    try {
      final candidates = await _resolveUserIdentifierCandidates();
      if (candidates.isEmpty) {
        final localFallback =
            NotificationPreferences.defaultPreferences('local-user');
        state = AsyncValue.data(localFallback);
        _hasUnsavedChanges = false;
        _saveError = 'User session not found. Please log in again.';
        _refreshState();
        return;
      }

      Map<String, dynamic>? successfulResponse;
      for (final identifier in candidates) {
        final endpoint =
            'notifications/preferences/${Uri.encodeComponent(identifier)}';
        final response = await _apiMethod.get(endpoint);
        if (response['success'] == true && response['data'] != null) {
          successfulResponse = response;
          break;
        }
      }

      if (successfulResponse != null) {
        final parsedPreferences =
            NotificationPreferences.fromJson(successfulResponse['data']);
        final canonicalIdentifier = candidates.first;
        final preferences =
            parsedPreferences.copyWith(userId: canonicalIdentifier);
        state = AsyncValue.data(preferences);
        _hasUnsavedChanges = false;
        _saveError = null;
        return;
      }

      final defaultPrefs =
          NotificationPreferences.defaultPreferences(candidates.first);
      state = AsyncValue.data(defaultPrefs);
      _hasUnsavedChanges = true;
      _saveError = 'No saved notification preferences found yet.';
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
    _hasUnsavedChanges = true;
    _saveError = null;
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
    _hasUnsavedChanges = true;
    _saveError = null;
  }

  Future<void> updateQuietHours(QuietHours quietHours) async {
    final currentPrefs = state.value;
    if (currentPrefs == null) return;

    final updatedPrefs = currentPrefs.copyWith(
      quietHours: quietHours,
      lastUpdated: DateTime.now(),
    );

    state = AsyncValue.data(updatedPrefs);
    _hasUnsavedChanges = true;
    _saveError = null;
  }

  Future<void> updateGeofenceEnabled(bool enabled) async {
    final currentPrefs = state.value;
    if (currentPrefs == null) return;

    final updatedPrefs = currentPrefs.copyWith(
      geofenceEnabled: enabled,
      lastUpdated: DateTime.now(),
    );

    state = AsyncValue.data(updatedPrefs);
    _hasUnsavedChanges = true;
    _saveError = null;
  }

  Future<void> updateGeofenceRadius(double radiusKm) async {
    final currentPrefs = state.value;
    if (currentPrefs == null) return;

    final updatedPrefs = currentPrefs.copyWith(
      geofenceRadiusKm: radiusKm,
      lastUpdated: DateTime.now(),
    );

    state = AsyncValue.data(updatedPrefs);
    _hasUnsavedChanges = true;
    _saveError = null;
  }

  Future<void> updateSmartTiming(bool enabled) async {
    final currentPrefs = state.value;
    if (currentPrefs == null) return;

    final updatedPrefs = currentPrefs.copyWith(
      smartTimingEnabled: enabled,
      lastUpdated: DateTime.now(),
    );

    state = AsyncValue.data(updatedPrefs);
    _hasUnsavedChanges = true;
    _saveError = null;
  }

  Future<void> updateSound(bool enabled) async {
    final currentPrefs = state.value;
    if (currentPrefs == null) return;

    final updatedPrefs = currentPrefs.copyWith(
      soundEnabled: enabled,
      lastUpdated: DateTime.now(),
    );

    state = AsyncValue.data(updatedPrefs);
    _hasUnsavedChanges = true;
    _saveError = null;
  }

  Future<void> updateVibration(bool enabled) async {
    final currentPrefs = state.value;
    if (currentPrefs == null) return;

    final updatedPrefs = currentPrefs.copyWith(
      vibrationEnabled: enabled,
      lastUpdated: DateTime.now(),
    );

    state = AsyncValue.data(updatedPrefs);
    _hasUnsavedChanges = true;
    _saveError = null;
  }

  Future<void> updateBadge(bool enabled) async {
    final currentPrefs = state.value;
    if (currentPrefs == null) return;

    final updatedPrefs = currentPrefs.copyWith(
      badgeEnabled: enabled,
      lastUpdated: DateTime.now(),
    );

    state = AsyncValue.data(updatedPrefs);
    _hasUnsavedChanges = true;
    _saveError = null;
  }

  Future<bool> savePreferences() async {
    final preferences = state.value;
    if (preferences == null) {
      _saveError = 'No preferences available to save.';
      _refreshState();
      return false;
    }

    if (_isSaving) return false;
    _isSaving = true;
    _saveError = null;
    _refreshState();

    try {
      final candidates = await _resolveUserIdentifierCandidates();
      final resolvedIdentifier =
          candidates.isNotEmpty ? candidates.first : preferences.userId.trim();
      if (resolvedIdentifier.isEmpty) {
        _saveError = 'User session not found. Please log in again.';
        _isSaving = false;
        _refreshState();
        return false;
      }

      final payload = preferences.copyWith(userId: resolvedIdentifier).toJson();
      final endpoint =
          'notifications/preferences/${Uri.encodeComponent(resolvedIdentifier)}';
      final response = await _apiMethod.put(
        endpoint,
        body: payload,
      );

      if (response['success'] != true) {
        _saveError =
            response['message']?.toString() ?? 'Failed to save preferences.';
        _isSaving = false;
        _refreshState();
        return false;
      }

      state = AsyncValue.data(
        preferences.copyWith(userId: resolvedIdentifier),
      );
      _hasUnsavedChanges = false;
      _lastSavedAt = DateTime.now();
      _saveError = null;
      _isSaving = false;
      _refreshState();
      return true;
    } catch (e) {
      _saveError = e.toString();
      _isSaving = false;
      _refreshState();
      return false;
    }
  }
}

final notificationPreferencesViewModelProvider = StateNotifierProvider<
    NotificationPreferencesViewModel,
    AsyncValue<NotificationPreferences>>((ref) {
  return NotificationPreferencesViewModel(
    ref.read(app_providers.apiMethodProvider),
    ref.read(app_providers.sharedPreferencesProvider),
  );
});
