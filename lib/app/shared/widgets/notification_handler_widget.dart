import 'dart:convert';
import 'package:carenest/app/features/auth/services/session_timeout_service.dart';
import 'package:carenest/app/services/notificationservice/local_notification_service.dart';
import 'package:carenest/app/features/notifications/providers/notification_provider.dart';
import 'package:carenest/app/features/notifications/models/notification_model.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;

class NotificationHandler extends ConsumerStatefulWidget {
  final Widget child;

  const NotificationHandler({super.key, required this.child});

  @override
  ConsumerState<NotificationHandler> createState() =>
      _NotificationHandlerState();
}

class _NotificationHandlerState extends ConsumerState<NotificationHandler>
    with WidgetsBindingObserver {
  static const bool _enableNotificationDebugLogs = bool.fromEnvironment(
    'ENABLE_NOTIFICATION_DEBUG_LOGS',
    defaultValue: false,
  );

  late LocalNotificationService _localNotificationService;

  void _debugLog(String message) {
    if (kDebugMode && _enableNotificationDebugLogs) {
      debugPrint(message);
    }
  }

  void onDidReceiveNotification(
      NotificationResponse notificationResponse) async {
    // Handle notification tap
    _debugLog(
        'DEBUG_NOTIF_HANDLER: Notification tapped with payload: ${notificationResponse.payload}');

    if (notificationResponse.payload != null) {
      try {
        // Parse the payload (which should be a JSON string)
        final Map<String, dynamic> parsedPayload =
            json.decode(notificationResponse.payload!) as Map<String, dynamic>;

        _debugLog('DEBUG_NOTIF_HANDLER: Parsed payload: $parsedPayload');

        // Handle navigation or actions based on the payload
        _handleNotificationAction(parsedPayload);
      } catch (e) {
        _debugLog(
            'DEBUG_NOTIF_HANDLER: Error parsing notification payload: $e');
      }
    }
  }

  // Method to handle actions when a notification is tapped
  void _handleNotificationAction(Map<String, dynamic> payload) {
    try {
      // Check for notification type to determine action
      if (payload.containsKey('type')) {
        final notificationType = payload['type'];
        _debugLog(
            'DEBUG_NOTIF_HANDLER: Handling notification action for type: $notificationType');

        // Handle different notification types
        switch (notificationType) {
          case 'invoice':
            // Navigate to invoice details
            if (payload.containsKey('invoiceId')) {
              final invoiceId = payload['invoiceId'];
              _debugLog(
                  'DEBUG_NOTIF_HANDLER: Navigating to invoice details for ID: $invoiceId');
              // Example navigation:
              // Navigator.of(context).pushNamed('/invoice_details', arguments: {'invoiceId': invoiceId});
            }
            break;
          case 'timer':
            // Navigate to timer screen
            _debugLog('DEBUG_NOTIF_HANDLER: Navigating to timer screen');
            // Example navigation:
            // Navigator.of(context).pushNamed('/timer');
            break;
          case 'message':
            // Navigate to messages
            if (payload.containsKey('messageId')) {
              final messageId = payload['messageId'];
              _debugLog(
                  'DEBUG_NOTIF_HANDLER: Navigating to message details for ID: $messageId');
              // Example navigation:
              // Navigator.of(context).pushNamed('/messages', arguments: {'messageId': messageId});
            }
            break;
          default:
            // Default action for other notification types
            _debugLog(
                'DEBUG_NOTIF_HANDLER: Performing default action for notification');
            // Example navigation:
            // Navigator.of(context).pushNamed('/notifications');
            break;
        }
      } else if (payload.containsKey('_id')) {
        // Legacy handling for notifications with _id
        final id = payload['_id'];
        _debugLog('DEBUG_NOTIF_HANDLER: Handling notification with ID: $id');
        // Example navigation:
        // Navigator.of(context).pushNamed('/notification_details', arguments: {'id': id});
      } else {
        // Generic handling for notifications without specific type
        _debugLog('DEBUG_NOTIF_HANDLER: Handling generic notification');
        // Example navigation:
        // Navigator.of(context).pushNamed('/notifications');
      }
    } catch (e) {
      _debugLog('DEBUG_NOTIF_HANDLER: Error handling notification action: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeNotificationSystem();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _debugLog('DEBUG_NOTIF_HANDLER: App lifecycle state changed to: $state');

    switch (state) {
      case AppLifecycleState.resumed:
        // App came to foreground, refresh notifications
        _debugLog(
            'DEBUG_NOTIF_HANDLER: App resumed - refreshing notifications');
        _refreshNotificationsOnResume();
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        // App went to surface or became inactive
        _debugLog('DEBUG_NOTIF_HANDLER: App paused/inactive');
        break;
    }
  }

  void _refreshNotificationsOnResume() async {
    try {
      _debugLog(
          'DEBUG_NOTIF_HANDLER: Refreshing notifications after app resume');

      // Add a small delay to ensure SharedPreferences operations complete
      await Future.delayed(const Duration(milliseconds: 100));

      // Refresh the notification provider to load any new surface notifications
      ref.read(notificationProvider.notifier).refresh();

      // Add another small delay to ensure the refresh completes
      await Future.delayed(const Duration(milliseconds: 50));

      _debugLog('DEBUG_NOTIF_HANDLER: Notifications refreshed successfully');
    } catch (e) {
      _debugLog('DEBUG_NOTIF_HANDLER: Error refreshing notifications: $e');
    }
  }

  Future<void> _initializeNotificationSystem() async {
    try {
      _debugLog(
          'DEBUG_NOTIF_HANDLER: Starting notification system initialization');

      // Step 1: Initialize local notification service
      _localNotificationService = LocalNotificationService();
      // Disable auto-requesting permissions here to comply with new flow
      await _localNotificationService.initialize(requestPermissions: false);
      _debugLog('DEBUG_NOTIF_HANDLER: Local notification service initialized');

      // Step 2: Check Firebase permissions (do not request yet)
      final settings =
          await FirebaseMessaging.instance.getNotificationSettings();

      _debugLog(
          'DEBUG_NOTIF_HANDLER: Current Firebase permission status: ${settings.authorizationStatus}');

      // Step 3: Check Android-specific permissions for API 33+
      // We skip manual request here to comply with new flow

      // Step 4: Only proceed if Firebase permissions are granted
      if (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional) {
        _debugLog(
            'DEBUG_NOTIF_HANDLER: ✅ Permissions already granted, initializing services');
        await _initializeServices();
      } else {
        _debugLog(
            'DEBUG_NOTIF_HANDLER: ℹ️ Permissions not yet granted. Waiting for user login/action.');
      }
    } catch (e) {
      _debugLog(
          'DEBUG_NOTIF_HANDLER: ❌ Error initializing notification system: $e');
    }
  }

  Future<void> _initializeServices() async {
    _debugLog(
        'DEBUG_NOTIF_HANDLER: Initializing notification handler services');

    // Configure foreground notification presentation options
    // Set to false to ensure onMessage listener is triggered for custom handling
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: false, // Disable automatic alert display to allow custom handling
      badge: false, // Disable automatic badge updates
      sound: false, // Disable automatic sound
    );
    _debugLog(
        'DEBUG_NOTIF_HANDLER: Foreground notification presentation options set to FALSE for custom handling');

    // Set up the foreground notification listener
    await configureForegroundNotifications();
    _debugLog(
        'DEBUG_NOTIF_HANDLER: Foreground notification listener configured');

    try {
      final sharedUtils = SharedPreferencesUtils();
      await sharedUtils.init();
      final email = sharedUtils.getUserEmail();
      final organizationId = sharedUtils.getOrganizationId();
      if (email != null &&
          email.isNotEmpty &&
          organizationId != null &&
          organizationId.isNotEmpty) {
        final sessionTimeoutService =
            SessionTimeoutService(sharedPrefs: sharedUtils);
        final isValidSession = await sessionTimeoutService.isSessionValid();
        if (!isValidSession) {
          _debugLog(
              'DEBUG_NOTIF_HANDLER: Session invalid/expired. Clearing session and skipping FCM init.');
          await sessionTimeoutService.logoutAndClearSession(
            reason: 'notification_handler_session_validation_failed',
          );
          return;
        }

        await ref
            .read(app_providers.fcmTokenManagerProvider)
            .initialize(email, organizationId);
      }
    } catch (e) {
      _debugLog(
          'DEBUG_NOTIF_HANDLER: Failed to initialize FCM token manager: $e');
    }
  }

  Future<dynamic> createAndDisplayNotification(
      int id, String? title, String? body, String? payload) async {
    // Create NotificationModel for the notification
    final notification = NotificationModel(
      id: id.toString(),
      title: title ?? 'Notification',
      body: body ?? '',
      timestamp: DateTime.now(),
      type: 'general',
    );

    // Parse payload if it's a JSON string, otherwise create empty map
    Map<String, dynamic> payloadData = {};
    if (payload != null && payload.isNotEmpty) {
      try {
        payloadData = json.decode(payload);
      } catch (e) {
        _debugLog('DEBUG_NOTIF_HANDLER: Failed to parse payload: $e');
        payloadData = {'raw_payload': payload};
      }
    }

    // Use the initialized LocalNotificationService instance
    await _localNotificationService.createAndDisplayNotification(
      notification,
      payloadData,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  Future<void> configureForegroundNotifications() async {
    _debugLog(
        'DEBUG_NOTIF_HANDLER: Setting up foreground notification listener');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      _debugLog('\n=== FLUTTER FOREGROUND NOTIFICATION RECEIVED ===');
      _debugLog('Timestamp: ${DateTime.now().toIso8601String()}');
      _debugLog('Message ID: ${message.messageId}');
      _debugLog('Message Data: ${message.data}');
      _debugLog('Message Notification: ${message.notification?.toMap()}');

      // --- START OF REFACTORED LOGIC ---

      // 1. Extract title and body, prioritizing the `notification` payload
      //    but falling back to the `data` payload.
      final String? title =
          message.notification?.title ?? message.data['title'];
      final String? body = message.notification?.body ?? message.data['body'];

      // 2. If we don't have a title and body, we can't show a notification.
      if (title == null || body == null) {
        _debugLog(
            '❌ Message is missing title/body. Cannot display notification.');
        _debugLog('=== END FLUTTER NOTIFICATION PROCESSING ===\n');
        return;
      }

      _debugLog('✅ Processing Title: $title');
      _debugLog('✅ Processing Body: $body');

      try {
        // 3. Determine Channel ID
        final String channelId = message.data['channelId'] ?? 'timer_alerts';
        _debugLog('✅ Using channel ID: $channelId');

        // 4. Create a unified payload for the local notification and storage.
        //    This combines data from both payloads.
        final Map<String, dynamic> combinedPayload = {
          ...message.data, // All original data
          'title': title,
          'body': body,
          'channelId': channelId,
          'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
          'isForeground': 'true',
        };

        // 5. Create the NotificationModel for storage in the app's notification list.
        final notificationForProvider = NotificationModel(
          id: message.messageId ??
              DateTime.now().millisecondsSinceEpoch.toString(),
          title: title,
          body: body,
          timestamp: DateTime.now(),
          isRead: false,
          type: message.data['type'] ??
              channelId, // Use type from data or fallback to channelId
          data: combinedPayload, // Use the combined payload for consistency
        );

        // 6. Store the notification in your Riverpod provider.
        _debugLog('\n--- STORING NOTIFICATION IN PROVIDER ---');
        try {
          ref
              .read(notificationProvider.notifier)
              .addNotification(notificationForProvider);
          _debugLog('✅ Notification stored in provider successfully');
        } catch (e) {
          _debugLog('❌ Failed to store notification in provider: $e');
        }

        // 6.5. Also store in persistent storage for surfaceed app state
        // This ensures notifications are preserved when app is surfaceed but not terminated
        _debugLog('\n--- STORING NOTIFICATION IN PERSISTENT STORAGE ---');
        try {
          await _storeNotificationPersistently(
            notificationForProvider.id,
            title,
            body,
            notificationForProvider.type,
            combinedPayload,
          );
          _debugLog('✅ Notification stored persistently successfully');
        } catch (e) {
          _debugLog('❌ Failed to store notification persistently: $e');
        }

        // 7. Display the local notification using your service.
        _debugLog('\n--- ATTEMPTING TO DISPLAY LOCAL NOTIFICATION ---');
        try {
          await _localNotificationService.createAndDisplayNotification(
            notificationForProvider, // Pass the model
            combinedPayload, // Pass the full payload
          );
          _debugLog('✅ Local notification display attempt completed');

          // 8. Update app UI based on notification data if needed
          _updateAppUI(message);
        } catch (e) {
          _debugLog('❌ Failed to display local notification: $e');
        }
      } catch (e) {
        _debugLog('\n❌ ERROR PROCESSING FOREGROUND MESSAGE');
        _debugLog('Error: $e');
        _debugLog('Stack trace: ${StackTrace.current}');
      } finally {
        _debugLog('=== END FLUTTER NOTIFICATION PROCESSING ===\n');
      }
      // --- END OF REFACTORED LOGIC ---
    }, onError: (error) {
      _debugLog('\n❌ ERROR IN ONMESSAGE LISTENER');
      _debugLog('Error: $error');
    });

    _debugLog(
        'DEBUG_NOTIF_HANDLER: ✅ Foreground notification listener configured');
  }

  // Method to store notification in state management
  Future<void> _storeNotification(
    String id,
    String? title,
    String? body,
    String? type,
    Map<String, dynamic> data,
  ) async {
    try {
      final notification = NotificationModel(
        id: id,
        title: title ?? 'New Notification',
        body: body ?? '',
        timestamp: DateTime.now(),
        isRead: false,
        type: type ?? 'general',
        data: data,
      );

      await ref
          .read(notificationProvider.notifier)
          .addNotification(notification);
      _debugLog('DEBUG_NOTIF_HANDLER: Notification stored successfully: $id');
    } catch (e) {
      _debugLog('DEBUG_NOTIF_HANDLER: Error storing notification: $e');
    }
  }

  // Method to store notification persistently (for surfaceed app state)
  Future<void> _storeNotificationPersistently(
    String id,
    String? title,
    String? body,
    String? type,
    Map<String, dynamic> data,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final existingNotifications =
          prefs.getStringList('surface_notifications') ?? [];

      // Create notification data
      final notificationData = {
        'id': id,
        'title': title ?? 'New Notification',
        'body': body ?? '',
        'type': type ?? 'general',
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'data': data,
      };

      // Add to existing notifications
      existingNotifications.add(jsonEncode(notificationData));

      // Keep only the last 50 notifications to prevent storage bloat
      if (existingNotifications.length > 50) {
        existingNotifications.removeRange(0, existingNotifications.length - 50);
      }

      // Save back to SharedPreferences
      await prefs.setStringList('surface_notifications', existingNotifications);

      _debugLog('DEBUG_NOTIF_HANDLER: Notification stored persistently: $id');
    } catch (e) {
      _debugLog(
          'DEBUG_NOTIF_HANDLER: Error storing notification persistently: $e');
    }
  }

  // Method to update app UI based on notification data
  void _updateAppUI(RemoteMessage message) {
    try {
      // Extract relevant data from the message
      final data = message.data;

      // Example: Update badge count if provided
      if (data.containsKey('count')) {
        final badgeCount = int.tryParse(data['count'] ?? '0') ?? 0;
        _debugLog('DEBUG_NOTIF_HANDLER: Updating badge count to $badgeCount');
      }

      // Example: Handle different notification types
      if (data.containsKey('type')) {
        final notificationType = data['type'];
        _debugLog(
            'DEBUG_NOTIF_HANDLER: Processing notification type: $notificationType');

        // Handle different notification types
        switch (notificationType) {
          case 'invoice':
            // Update invoice-related UI
            break;
          case 'timer':
            // Update timer-related UI
            break;
          case 'message':
            // Update message-related UI
            break;
        }
      }
    } catch (e) {
      _debugLog('DEBUG_NOTIF_HANDLER: Error updating UI: $e');
    }
  }
}
