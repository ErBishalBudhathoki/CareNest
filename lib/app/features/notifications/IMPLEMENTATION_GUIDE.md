# Notification System Implementation Guide

This guide provides detailed implementation instructions and code examples for developers working with the notification system.

## Quick Start

### 1. Basic Setup

Ensure your app is wrapped with `ProviderScope` for Riverpod:

```dart
// main.dart
void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}
```

### 2. Adding Notifications

```dart
// In any ConsumerWidget or ConsumerStatefulWidget
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(notificationProvider.notifier);
    
    return ElevatedButton(
      onPressed: () {
        // Create and add a notification
        final notification = NotificationModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: 'Task Completed',
          body: 'Your task has been completed successfully',
          timestamp: DateTime.now(),
          type: 'success',
          data: {'taskId': '12345'},
        );
        
        notifier.addNotification(notification);
      },
      child: Text('Add Notification'),
    );
  }
}
```

### 3. Displaying Notification Count

```dart
class NotificationBadge extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unreadCount = ref.watch(unreadNotificationCountProvider);
    
    return Badge(
      count: unreadCount,
      child: IconButton(
        icon: Icon(Icons.notifications),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotificationListView(),
            ),
          );
        },
      ),
    );
  }
}
```

## Advanced Implementation Patterns

### 1. Custom Notification Types

```dart
// Define notification types as constants
class NotificationTypes {
  static const String timer = 'timer';
  static const String message = 'message';
  static const String warning = 'warning';
  static const String error = 'error';
  static const String success = 'success';
  static const String info = 'info';
}

// Helper method for creating typed notifications
class NotificationHelper {
  static NotificationModel createTimerNotification({
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) {
    return NotificationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      body: body,
      timestamp: DateTime.now(),
      type: NotificationTypes.timer,
      data: data,
    );
  }
  
  static NotificationModel createErrorNotification({
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) {
    return NotificationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      body: body,
      timestamp: DateTime.now(),
      type: NotificationTypes.error,
      data: data,
    );
  }
}
```

### 2. Notification Service Layer

```dart
// Create a service layer for notification management
class NotificationService {
  final WidgetRef _ref;
  
  NotificationService(this._ref);
  
  // High-level methods for common operations
  Future<void> notifyTaskCompletion(String taskName) async {
    final notification = NotificationHelper.createTimerNotification(
      title: 'Task Completed',
      body: '$taskName has been completed',
      data: {'taskName': taskName, 'completedAt': DateTime.now().toIso8601String()},
    );
    
    await _ref.read(notificationProvider.notifier).addNotification(notification);
  }
  
  Future<void> notifyError(String errorMessage) async {
    final notification = NotificationHelper.createErrorNotification(
      title: 'Error Occurred',
      body: errorMessage,
      data: {'timestamp': DateTime.now().toIso8601String()},
    );
    
    await _ref.read(notificationProvider.notifier).addNotification(notification);
  }
  
  Future<void> markAllAsRead() async {
    await _ref.read(notificationProvider.notifier).markAllAsRead();
  }
  
  int getUnreadCount() {
    return _ref.read(unreadNotificationCountProvider);
  }
}

// Provider for the service
final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService(ref);
});
```

### 3. Custom Notification Widget

```dart
class CustomNotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final VoidCallback? onMarkRead;
  
  const CustomNotificationCard({
    Key? key,
    required this.notification,
    this.onTap,
    this.onDelete,
    this.onMarkRead,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      color: notification.isRead ? Colors.grey[100] : Colors.white,
      child: ListTile(
        leading: _buildIcon(),
        title: Text(
          notification.title,
          style: TextStyle(
            fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification.body),
            SizedBox(height: 4),
            Text(
              notification.timeAgo,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
        trailing: _buildActions(),
        onTap: onTap,
      ),
    );
  }
  
  Widget _buildIcon() {
    IconData iconData;
    Color color;
    
    switch (notification.type) {
      case NotificationTypes.timer:
        iconData = Icons.timer;
        color = Colors.green;
        break;
      case NotificationTypes.error:
        iconData = Icons.error;
        color = Colors.red;
        break;
      case NotificationTypes.warning:
        iconData = Icons.warning;
        color = Colors.orange;
        break;
      case NotificationTypes.message:
        iconData = Icons.message;
        color = Colors.blue;
        break;
      default:
        iconData = Icons.notifications;
        color = Colors.grey;
    }
    
    return CircleAvatar(
      backgroundColor: color.withValues(alpha:0.1),
      child: Icon(iconData, color: color),
    );
  }
  
  Widget _buildActions() {
    return PopupMenuButton<String>(
      onSelected: (value) {
        switch (value) {
          case 'mark_read':
            onMarkRead?.call();
            break;
          case 'delete':
            onDelete?.call();
            break;
        }
      },
      itemBuilder: (context) => [
        if (!notification.isRead)
          PopupMenuItem(
            value: 'mark_read',
            child: Row(
              children: [
                Icon(Icons.done, size: 16),
                SizedBox(width: 8),
                Text('Mark as read'),
              ],
            ),
          ),
        PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(Icons.delete, size: 16, color: Colors.red),
              SizedBox(width: 8),
              Text('Delete', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ],
    );
  }
}
```

## Integration Examples

### 1. Timer Integration

```dart
class TimerService extends ConsumerNotifier<TimerState> {
  @override
  TimerState build() => TimerState.initial();
  
  void startTimer(String taskName) {
    // Timer logic...
    
    // Notify timer started
    final notification = NotificationHelper.createTimerNotification(
      title: 'Timer Started',
      body: 'Timer for $taskName has started',
      data: {'taskName': taskName, 'startTime': DateTime.now().toIso8601String()},
    );
    
    ref.read(notificationProvider.notifier).addNotification(notification);
  }
  
  void completeTimer(String taskName, Duration duration) {
    // Timer completion logic...
    
    // Notify timer completed
    final notification = NotificationHelper.createTimerNotification(
      title: 'Timer Completed',
      body: '$taskName completed in ${duration.inMinutes} minutes',
      data: {
        'taskName': taskName,
        'duration': duration.inSeconds,
        'completedAt': DateTime.now().toIso8601String(),
      },
    );
    
    ref.read(notificationProvider.notifier).addNotification(notification);
  }
}
```

### 2. Error Handling Integration

```dart
class ApiService {
  final WidgetRef ref;
  
  ApiService(this.ref);
  
  Future<ApiResponse> makeRequest(String endpoint) async {
    try {
      // API call logic...
      return response;
    } catch (e) {
      // Create error notification
      final notification = NotificationHelper.createErrorNotification(
        title: 'API Error',
        body: 'Failed to connect to server: ${e.toString()}',
        data: {
          'endpoint': endpoint,
          'error': e.toString(),
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
      
      ref.read(notificationProvider.notifier).addNotification(notification);
      rethrow;
    }
  }
}
```

### 3. Background Task Integration

```dart
class BackgroundTaskManager {
  static Future<void> handleBackgroundNotification(Map<String, dynamic> data) async {
    // This would be called from background message handler
    final container = ProviderContainer();
    
    try {
      final notification = NotificationModel(
        id: data['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: data['title'] ?? 'Background Notification',
        body: data['body'] ?? '',
        timestamp: DateTime.now(),
        type: data['type'],
        data: data,
      );
      
      await container.read(notificationProvider.notifier).addNotification(notification);
    } finally {
      container.dispose();
    }
  }
}
```

## Testing Implementation

### 1. Unit Tests

```dart
// test/notification_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  group('NotificationProvider Tests', () {
    late ProviderContainer container;
    
    setUp(() {
      container = ProviderContainer();
    });
    
    tearDown(() {
      container.dispose();
    });
    
    test('should add notification correctly', () async {
      final notifier = container.read(notificationProvider.notifier);
      
      final notification = NotificationModel(
        id: 'test-1',
        title: 'Test',
        body: 'Test body',
        timestamp: DateTime.now(),
      );
      
      await notifier.addNotification(notification);
      
      final state = container.read(notificationProvider);
      expect(state.notifications.length, 1);
      expect(state.notifications.first.id, 'test-1');
    });
    
    test('should mark notification as read', () async {
      final notifier = container.read(notificationProvider.notifier);
      
      final notification = NotificationModel(
        id: 'test-1',
        title: 'Test',
        body: 'Test body',
        timestamp: DateTime.now(),
      );
      
      await notifier.addNotification(notification);
      await notifier.markAsRead('test-1');
      
      final state = container.read(notificationProvider);
      expect(state.notifications.first.isRead, true);
      expect(state.unreadCount, 0);
    });
  });
}
```

### 2. Widget Tests

```dart
// test/notification_widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  group('NotificationListView Tests', () {
    testWidgets('should display empty state when no notifications', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: NotificationListView(),
          ),
        ),
      );
      
      await tester.pumpAndSettle();
      
      expect(find.text('No notifications yet'), findsOneWidget);
    });
    
    testWidgets('should display notifications when available', (tester) async {
      final container = ProviderContainer();
      
      // Add test notification
      await container.read(notificationProvider.notifier).addNotification(
        NotificationModel(
          id: 'test-1',
          title: 'Test Notification',
          body: 'Test body',
          timestamp: DateTime.now(),
        ),
      );
      
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            home: NotificationListView(),
          ),
        ),
      );
      
      await tester.pumpAndSettle();
      
      expect(find.text('Test Notification'), findsOneWidget);
      expect(find.text('Test body'), findsOneWidget);
      
      container.dispose();
    });
  });
}
```

## Performance Optimization

### 1. Efficient List Rendering

```dart
class OptimizedNotificationList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationProvider.select((state) => state.notifications));
    
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        
        // Use keys for efficient rebuilds
        return NotificationCard(
          key: ValueKey(notification.id),
          notification: notification,
        );
      },
    );
  }
}
```

### 2. Selective Rebuilds

```dart
class NotificationBadge extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Only rebuild when unread count changes
    final unreadCount = ref.watch(
      notificationProvider.select((state) => state.unreadCount),
    );
    
    return Badge(
      count: unreadCount,
      child: Icon(Icons.notifications),
    );
  }
}
```

## Debugging Tips

### 1. Debug Logging

```dart
class DebugNotificationProvider extends NotificationNotifier {
  @override
  Future<void> addNotification(NotificationModel notification) async {
    debugPrint('Adding notification: ${notification.title}');
    await super.addNotification(notification);
    debugPrint('Total notifications: ${state.notifications.length}');
  }
  
  @override
  Future<void> markAsRead(String notificationId) async {
    debugPrint('Marking notification as read: $notificationId');
    await super.markAsRead(notificationId);
    debugPrint('Unread count: ${state.unreadCount}');
  }
}
```

### 2. State Inspection

```dart
// Add this to your debug tools
class NotificationDebugPanel extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationProvider);
    
    return Column(
      children: [
        Text('Total: ${state.notifications.length}'),
        Text('Unread: ${state.unreadCount}'),
        Text('Loading: ${state.isLoading}'),
        if (state.error != null) Text('Error: ${state.error}'),
        ElevatedButton(
          onPressed: () => ref.read(notificationProvider.notifier).clearAllNotifications(),
          child: Text('Clear All'),
        ),
      ],
    );
  }
}
```

This implementation guide provides comprehensive examples and patterns for effectively using the notification system in your Flutter application. Follow these patterns for consistent and maintainable code.