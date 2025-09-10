import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carenest/app/features/notifications/models/notification_model.dart';

class NotificationState {
  final List<NotificationModel> notifications;
  final bool isLoading;
  final String? error;

  NotificationState({
    this.notifications = const [],
    this.isLoading = false,
    this.error,
  });

  NotificationState copyWith({
    List<NotificationModel>? notifications,
    bool? isLoading,
    String? error,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  int get unreadCount => notifications.where((n) => !n.isRead).length;
  bool get hasUnreadNotifications => unreadCount > 0;
}

class NotificationNotifier extends StateNotifier<NotificationState> {
  static const String _storageKey = 'app_notifications';
  static const String _backgroundStorageKey = 'background_notifications';

  NotificationNotifier() : super(NotificationState()) {
    // The constructor now calls the single, unified loading method.
    // This handles the "terminated app" scenario automatically and correctly.
    loadNotifications();
  }

  /// This is now the single, authoritative method for loading notifications.
  /// It loads both persisted app notifications and any new notifications
  /// received while the app was in the background.
  // Future<void> loadNotifications() async {
  //   // Guard clause to prevent multiple concurrent loads.
  //   if (state.isLoading) return;

  //   try {
  //     state = state.copyWith(isLoading: true, error: null);

  //     final prefs = await SharedPreferences.getInstance();

  //     // Load regular app notifications that are already persisted.
  //     final appNotificationsJson = prefs.getStringList(_storageKey) ?? [];
  //     final appNotifications = appNotificationsJson
  //         .map((jsonStr) {
  //           try {
  //             return NotificationModel.fromJson(jsonDecode(jsonStr));
  //           } catch (e) {
  //             debugPrint('Error parsing app notification: $e');
  //             return null;
  //           }
  //         })
  //         .whereType<NotificationModel>()
  //         .toList();

  //     // Load any new background notifications from the temporary store.
  //     final backgroundNotificationsJson =
  //         prefs.getStringList(_backgroundStorageKey) ?? [];
  //     debugPrint(
  //         'DEBUG_PROVIDER: Found ${backgroundNotificationsJson.length} background notifications in storage.');

  //     final backgroundNotifications = backgroundNotificationsJson
  //         .map((jsonStr) {
  //           try {
  //             // The data from the background handler is already a NotificationModel
  //             return NotificationModel.fromJson(jsonDecode(jsonStr));
  //           } catch (e) {
  //             debugPrint('Error parsing background notification: $e');
  //             return null;
  //           }
  //         })
  //         .whereType<NotificationModel>()
  //         .toList();

  //     // Merge, de-duplicate, sort, and limit the lists.
  //     final allNotifications = [
  //       ...appNotifications,
  //       ...backgroundNotifications
  //     ];
  //     final uniqueNotifications = <String, NotificationModel>{};
  //     for (final notification in allNotifications) {
  //       // Use the unique message ID from FCM for robust de-duplication.
  //       final uniqueId = notification.data?['google.message_id'] as String? ??
  //           notification.id;
  //       uniqueNotifications[uniqueId] = notification;
  //     }

  //     final notifications = uniqueNotifications.values.toList()
  //       ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

  //     final limitedNotifications = notifications.take(100).toList();

  //     debugPrint(
  //         'DEBUG_PROVIDER: Final merged notifications count: ${limitedNotifications.length}');

  //     state = state.copyWith(
  //       notifications: limitedNotifications,
  //       isLoading: false,
  //     );

  //     // Save the newly merged state back to the primary storage.
  //     await _saveNotifications();
  //     // IMPORTANT: Clear the temporary background store now that they've been merged.
  //     await _clearBackgroundNotifications();

  //     debugPrint(
  //         'DEBUG_PROVIDER: Background notifications merged and cleared. Refresh complete.');
  //   } catch (e) {
  //     state = state.copyWith(
  //         isLoading: false, error: 'Failed to load notifications: $e');
  //     debugPrint('Error in loadNotifications: $e');
  //   }
  // }

  // In: lib/features/notifications/providers/notification_provider.dart
// Inside the NotificationNotifier class

  /// This is the single, authoritative method for loading all notifications.
  /// It is called on provider initialization and on manual refresh (e.g., app resume).
  Future<void> loadNotifications() async {
    // Guard clause to prevent multiple concurrent loads if a refresh is triggered
    // while it's already running.
    if (state.isLoading) return;

    try {
      // Set the state to loading to show a progress indicator in the UI.
      state = state.copyWith(isLoading: true, error: null);

      final prefs = await SharedPreferences.getInstance();

      //====================================================================
      // THE CRITICAL FIX:
      // Force SharedPreferences to reload its data from the device's disk.
      // This clears any stale in-memory cache and ensures we read the fresh
      // data that was written by the background isolate.
      await prefs.reload();
      //====================================================================

      // 1. Load the primary list of notifications already in the app.
      final appNotificationsJson =
          prefs.getStringList('app_notifications') ?? [];
      final appNotifications = appNotificationsJson
          .map((jsonStr) {
            try {
              return NotificationModel.fromJson(jsonDecode(jsonStr));
            } catch (e) {
              debugPrint('Error parsing a stored app notification: $e');
              return null;
            }
          })
          .whereType<NotificationModel>()
          .toList();

      // 2. Load any new notifications from the temporary background store.
      final backgroundNotificationsJson =
          prefs.getStringList('background_notifications') ?? [];
      debugPrint(
          'DEBUG_PROVIDER (After Reload): Found ${backgroundNotificationsJson.length} new background notifications.');

      final backgroundNotifications = backgroundNotificationsJson
          .map((jsonStr) {
            try {
              return NotificationModel.fromJson(jsonDecode(jsonStr));
            } catch (e) {
              debugPrint('Error parsing a stored background notification: $e');
              return null;
            }
          })
          .whereType<NotificationModel>()
          .toList();

      // 3. Merge the two lists into a single comprehensive list.
      final allNotifications = [
        ...appNotifications,
        ...backgroundNotifications
      ];

      // 4. De-duplicate the list to prevent showing the same notification twice.
      // We use a Map with a unique key (the FCM message ID) to ensure each notification appears only once.
      // This is a robust way to handle potential edge cases.
      final uniqueNotifications = <String, NotificationModel>{};
      for (final notification in allNotifications) {
        // Use the unique message ID from FCM for robust de-duplication. Fallback to the model's ID if not present.
        final uniqueId = notification.data?['google.message_id'] as String? ??
            notification.id;
        uniqueNotifications[uniqueId] = notification;
      }

      // 5. Convert the map of unique notifications back to a list.
      final notifications = uniqueNotifications.values.toList();

      // 6. Sort the final list by timestamp so the newest notifications appear at the top.
      notifications.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      // 7. Limit the total number of notifications to prevent the list from growing indefinitely.
      final limitedNotifications = notifications.take(100).toList();

      // 8. Update the app's state with the final, clean list. This will trigger the UI to rebuild.
      state = state.copyWith(
        notifications: limitedNotifications,
        isLoading: false, // Set loading to false
      );

      // 9. Persist the newly merged and cleaned list back to primary storage.
      await _saveNotifications();

      // 10. Clean up the temporary background notification store now that its contents have been processed.
      await _clearBackgroundNotifications();

      debugPrint(
          'DEBUG_PROVIDER: Notification refresh complete. Final list count: ${limitedNotifications.length}');
    } catch (e) {
      // If any error occurs during the process, update the state to show an error message in the UI.
      debugPrint('FATAL ERROR in loadNotifications: $e');
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load notifications: $e',
      );
    }
  }

  /// Saves the current list of notifications to persistent storage.
  Future<void> _saveNotifications() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final notificationsJson = state.notifications
          .map((notification) => jsonEncode(notification.toJson()))
          .toList();
      await prefs.setStringList(_storageKey, notificationsJson);
    } catch (e) {
      debugPrint('Error saving notifications: $e');
    }
  }

  /// Adds a new notification to the top of the list (for foreground messages).
  Future<void> addNotification(NotificationModel notification) async {
    try {
      final updatedNotifications = [notification, ...state.notifications];
      final limitedNotifications = updatedNotifications.take(100).toList();
      state = state.copyWith(notifications: limitedNotifications);
      await _saveNotifications();
    } catch (e) {
      debugPrint('Error adding notification: $e');
    }
  }

  /// Public method to trigger a manual refresh (e.g., on app resume).
  void refresh() {
    debugPrint('DEBUG_PROVIDER: Manual refresh triggered.');
    loadNotifications();
  }

  /// Clears the temporary background notification store.
  Future<void> _clearBackgroundNotifications() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_backgroundStorageKey);
      debugPrint('Background notifications cleared after loading.');
    } catch (e) {
      debugPrint('Error clearing background notifications: $e');
    }
  }

  // --- Other state management methods remain the same ---

  Future<void> markAsRead(String notificationId) async {
    final updatedNotifications = state.notifications.map((n) {
      if (n.id == notificationId) return n.copyWith(isRead: true);
      return n;
    }).toList();
    state = state.copyWith(notifications: updatedNotifications);
    await _saveNotifications();
  }

  Future<void> markAllAsRead() async {
    final updatedNotifications =
        state.notifications.map((n) => n.copyWith(isRead: true)).toList();
    state = state.copyWith(notifications: updatedNotifications);
    await _saveNotifications();
  }

  Future<void> deleteNotification(String notificationId) async {
    final updatedNotifications =
        state.notifications.where((n) => n.id != notificationId).toList();
    state = state.copyWith(notifications: updatedNotifications);
    await _saveNotifications();
  }

  Future<void> clearAllNotifications() async {
    state = state.copyWith(notifications: []);
    await _saveNotifications();
  }
}

// --- Providers remain the same ---

final notificationProvider =
    StateNotifierProvider<NotificationNotifier, NotificationState>(
  (ref) => NotificationNotifier(),
);

final unreadNotificationCountProvider = Provider<int>((ref) {
  return ref.watch(notificationProvider).unreadCount;
});

final hasUnreadNotificationsProvider = Provider<bool>((ref) {
  return ref.watch(notificationProvider).hasUnreadNotifications;
});
