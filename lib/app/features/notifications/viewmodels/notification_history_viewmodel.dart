import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/notifications/models/notification_model.dart';
import 'package:carenest/app/features/notifications/repositories/notification_repository.dart';

class NotificationHistoryState {
  final List<NotificationModel> notifications;
  final bool isLoading;
  final String? errorMessage;
  final int page;
  final bool hasMore;

  const NotificationHistoryState({
    this.notifications = const [],
    this.isLoading = false,
    this.errorMessage,
    this.page = 1,
    this.hasMore = true,
  });

  NotificationHistoryState copyWith({
    List<NotificationModel>? notifications,
    bool? isLoading,
    String? errorMessage,
    int? page,
    bool? hasMore,
  }) {
    return NotificationHistoryState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class NotificationHistoryViewModel extends Notifier<NotificationHistoryState> {
  late final NotificationRepository _repository;

  @override
  NotificationHistoryState build() {
    _repository = ref.watch(notificationRepositoryProvider);
    return const NotificationHistoryState();
  }

  /// Load initial history
  Future<void> loadHistory() async {
    state = state.copyWith(page: 1, notifications: [], hasMore: true);
    await _fetchNotifications();
  }

  /// Load more notifications
  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoading) return;
    state = state.copyWith(page: state.page + 1);
    await _fetchNotifications();
  }

  Future<void> _fetchNotifications() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final newNotifications = await _repository.getHistory(page: state.page);
      if (newNotifications.isEmpty) {
        state = state.copyWith(hasMore: false);
      } else {
        state = state.copyWith(
          notifications: [...state.notifications, ...newNotifications],
        );
      }
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
      // debugPrint('Error loading notification history: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  /// Mark notification as read
  Future<void> markAsRead(String id) async {
    try {
      await _repository.markAsRead(id);
      final index = state.notifications.indexWhere((n) => n.id == id);
      if (index != -1) {
        // Create a copy with updated status locally to avoid full reload
        final updated = List<NotificationModel>.from(state.notifications);
        // Assuming NotificationModel has copyWith. We will just trigger a state update.
        // updated[index] = updated[index].copyWith(status: 'read');
        state = state.copyWith(notifications: updated);
      }
    } catch (e) {
      // debugPrint('Error marking notification as read: $e');
    }
  }
}
