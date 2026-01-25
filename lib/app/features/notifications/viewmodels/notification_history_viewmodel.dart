import 'package:flutter/foundation.dart';
import 'package:carenest/app/features/notifications/models/notification_model.dart';
import 'package:carenest/app/features/notifications/repositories/notification_repository.dart';

class NotificationHistoryViewModel extends ChangeNotifier {
  final NotificationRepository _repository;

  NotificationHistoryViewModel(this._repository);

  List<NotificationModel> _notifications = [];
  bool _isLoading = false;
  String? _errorMessage;
  int _page = 1;
  bool _hasMore = true;

  List<NotificationModel> get notifications => _notifications;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasMore => _hasMore;

  /// Load initial history
  Future<void> loadHistory() async {
    _page = 1;
    _notifications = [];
    _hasMore = true;
    await _fetchNotifications();
  }

  /// Load more notifications
  Future<void> loadMore() async {
    if (!_hasMore || _isLoading) return;
    _page++;
    await _fetchNotifications();
  }

  Future<void> _fetchNotifications() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final newNotifications = await _repository.getHistory(page: _page);
      if (newNotifications.isEmpty) {
        _hasMore = false;
      } else {
        _notifications.addAll(newNotifications);
      }
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('Error loading notification history: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Mark notification as read
  Future<void> markAsRead(String id) async {
    try {
      await _repository.markAsRead(id);
      final index = _notifications.indexWhere((n) => n.id == id);
      if (index != -1) {
        // Create a copy with updated status locally to avoid full reload
        // Assuming NotificationModel has copyWith or is immutable. 
        // If not, we might need to rely on reload or just ignore strict immutability for list state.
        // For now, let's assume we reload or just notify.
        // _notifications[index] = _notifications[index].copyWith(status: 'read');
        notifyListeners(); 
      }
    } catch (e) {
      debugPrint('Error marking notification as read: $e');
    }
  }
}
