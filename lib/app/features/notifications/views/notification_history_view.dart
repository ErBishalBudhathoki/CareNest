import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/notifications/providers/notification_providers.dart';
import 'package:carenest/app/features/notifications/models/notification_model.dart';
import 'package:carenest/app/shared/widgets/app_bar_widget.dart';
import 'package:carenest/app/shared/widgets/loading_indicator.dart';

class NotificationHistoryView extends ConsumerStatefulWidget {
  const NotificationHistoryView({super.key});

  @override
  ConsumerState<NotificationHistoryView> createState() => _NotificationHistoryViewState();
}

class _NotificationHistoryViewState extends ConsumerState<NotificationHistoryView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notificationHistoryViewModelProvider).loadHistory();
    });

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      ref.read(notificationHistoryViewModelProvider).loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(notificationHistoryViewModelProvider);

    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Notifications',
        showBackButton: true,
      ),
      body: viewModel.isLoading && viewModel.notifications.isEmpty
          ? const Center(child: LoadingIndicator())
          : viewModel.notifications.isEmpty
              ? _buildEmptyState()
              : RefreshIndicator(
                  onRefresh: viewModel.loadHistory,
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: viewModel.notifications.length + (viewModel.hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == viewModel.notifications.length) {
                        return const Center(child: Padding(padding: EdgeInsets.all(16.0), child: LoadingIndicator()));
                      }
                      final notification = viewModel.notifications[index];
                      return _buildNotificationItem(notification, viewModel);
                    },
                  ),
                ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.notifications_none, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'No notifications yet',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(NotificationModel notification, dynamic viewModel) {
    return Card(
      color: notification.isRead ? Colors.white : Colors.blue.shade50,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: notification.isRead ? Colors.grey.shade300 : Colors.blue,
          child: Icon(
            _getIconForType(notification.type),
            color: Colors.white,
          ),
        ),
        title: Text(
          notification.title,
          style: TextStyle(
            fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(notification.body),
            const SizedBox(height: 4),
            Text(
              notification.timeAgo,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        onTap: () {
          if (!notification.isRead) {
            viewModel.markAsRead(notification.id);
          }
          // Handle navigation if data present
        },
      ),
    );
  }

  IconData _getIconForType(String? type) {
    switch (type) {
      case 'shift':
        return Icons.calendar_today;
      case 'geofence':
        return Icons.location_on;
      case 'expense':
        return Icons.receipt;
      case 'timesheet':
        return Icons.access_time;
      default:
        return Icons.notifications;
    }
  }
}
