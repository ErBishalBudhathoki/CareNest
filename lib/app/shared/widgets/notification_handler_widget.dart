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
import 'package:carenest/app/features/home/viewmodels/home_viewmodel.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';

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
    NotificationResponse notificationResponse,
  ) async {
    // Handle notification tap
    _debugLog(
      'DEBUG_NOTIF_HANDLER: Notification tapped with payload: ${notificationResponse.payload}',
    );

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
          'DEBUG_NOTIF_HANDLER: Error parsing notification payload: $e',
        );
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
          'DEBUG_NOTIF_HANDLER: Handling notification action for type: $notificationType',
        );

        // Handle different notification types
        switch (notificationType) {
          case 'invoice':
            // Navigate to invoice details
            if (payload.containsKey('invoiceId')) {
              final invoiceId = payload['invoiceId'];
              _debugLog(
                'DEBUG_NOTIF_HANDLER: Navigating to invoice details for ID: $invoiceId',
              );
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
                'DEBUG_NOTIF_HANDLER: Navigating to message details for ID: $messageId',
              );
              // Example navigation:
              // Navigator.of(context).pushNamed('/messages', arguments: {'messageId': messageId});
            }
            break;
          case 'emergency_broadcast':
            _debugLog(
              'DEBUG_NOTIF_HANDLER: Navigating to home for emergency broadcast',
            );
            // Navigation to home will trigger refresh on load
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/bottomNavBar',
              (route) => false,
              arguments: {
                'email': SharedPreferencesUtils().getUserEmail() ?? '',
                'role': UserRole.employee, // Default to employee for this view
              },
            );
            break;
          default:
            // Default action for other notification types
            _debugLog(
              'DEBUG_NOTIF_HANDLER: Performing default action for notification',
            );
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
          'DEBUG_NOTIF_HANDLER: App resumed - refreshing notifications',
        );
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
        'DEBUG_NOTIF_HANDLER: Refreshing notifications after app resume',
      );

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
        'DEBUG_NOTIF_HANDLER: Starting notification system initialization',
      );

      // Step 1: Initialize local notification service (channels, plugin)
      _localNotificationService = LocalNotificationService();
      await _localNotificationService.initialize(requestPermissions: false);
      _debugLog('DEBUG_NOTIF_HANDLER: Local notification service initialized');

      // Step 2: ALWAYS register the FCM token, regardless of notification permission.
      // Firebase can retrieve and send a token even when the user hasn't granted
      // POST_NOTIFICATIONS permission (Android 13+). Without this, the backend
      // has no token to push to and emergency alerts are silently dropped.
      await _registerFcmToken();

      // Step 3: Check Firebase permission status
      final settings = await FirebaseMessaging.instance
          .getNotificationSettings();
      _debugLog(
        'DEBUG_NOTIF_HANDLER: Firebase permission status: ${settings.authorizationStatus}',
      );

      // Step 4: Request permission if not yet determined (Android 13+ / iOS)
      if (settings.authorizationStatus == AuthorizationStatus.notDetermined) {
        final newSettings = await FirebaseMessaging.instance.requestPermission(
          alert: true,
          badge: true,
          sound: true,
          provisional: false,
        );
        _debugLog(
          'DEBUG_NOTIF_HANDLER: Permission requested — result: ${newSettings.authorizationStatus}',
        );
      }

      // Step 5: Set up foreground notification display pipeline only if granted.
      // The system tray still shows FCM push notifications in background/terminated
      // state without this (handled by Firebase directly on Android).
      final currentSettings = await FirebaseMessaging.instance
          .getNotificationSettings();
      if (currentSettings.authorizationStatus ==
              AuthorizationStatus.authorized ||
          currentSettings.authorizationStatus ==
              AuthorizationStatus.provisional) {
        _debugLog(
          'DEBUG_NOTIF_HANDLER: ✅ Permissions granted, setting up foreground notification pipeline',
        );
        await _initializeForegroundNotificationPipeline();
      } else {
        _debugLog(
          'DEBUG_NOTIF_HANDLER: ℹ️ Permissions not granted — FCM token registered, foreground display skipped',
        );
      }
    } catch (e) {
      _debugLog(
        'DEBUG_NOTIF_HANDLER: ❌ Error initializing notification system: $e',
      );
    }
  }

  /// Register the FCM device token with the backend.
  /// This runs unconditionally — notification permission is NOT required to
  /// obtain or upload an FCM token.
  Future<void> _registerFcmToken() async {
    try {
      // Always-on logging for this critical path — silent failures here mean
      // zero push notifications for the user.
      debugPrint('🔔 FCM_REG: Starting FCM token registration...');
      final sharedUtils = SharedPreferencesUtils();
      await sharedUtils.init();
      final email = sharedUtils.getUserEmail();
      final organizationId = sharedUtils.getOrganizationId();
      debugPrint('🔔 FCM_REG: email=$email, orgId=$organizationId');
      if (email != null &&
          email.isNotEmpty &&
          organizationId != null &&
          organizationId.isNotEmpty) {
        final sessionTimeoutService = SessionTimeoutService(
          sharedPrefs: sharedUtils,
        );
        final isValidSession = await sessionTimeoutService.isSessionValid();
        debugPrint('🔔 FCM_REG: Session valid=$isValidSession');
        if (!isValidSession) {
          debugPrint(
            '🔔 FCM_REG: ❌ Session invalid — skipping FCM token registration & logging out',
          );
          await sessionTimeoutService.logoutAndClearSession(
            reason: 'notification_handler_session_validation_failed',
          );
          return;
        }
        debugPrint(
          '🔔 FCM_REG: Registering FCM token for $email with org $organizationId',
        );
        await ref
            .read(app_providers.fcmTokenManagerProvider)
            .initialize(email, organizationId);
        debugPrint(
          '🔔 FCM_REG: ✅ FCM token registered successfully for $email',
        );
      } else {
        debugPrint(
          '🔔 FCM_REG: ⚠️ No email/orgId in prefs — skipping FCM token registration (email=$email, orgId=$organizationId)',
        );
      }
    } catch (e, stackTrace) {
      debugPrint('🔔 FCM_REG: ❌ Failed to register FCM token: $e');
      debugPrint('🔔 FCM_REG: Stack: $stackTrace');
    }
  }

  /// Configure foreground notification presentation and the onMessage listener.
  /// Only called when notification permission is granted.
  Future<void> _initializeForegroundNotificationPipeline() async {
    // Suppress automatic FCM-overlay so our custom in-app handler fires
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: false,
          badge: false,
          sound: false,
        );
    _debugLog(
      'DEBUG_NOTIF_HANDLER: Foreground presentation options set (custom handling active)',
    );

    await configureForegroundNotifications();
    _debugLog(
      'DEBUG_NOTIF_HANDLER: Foreground notification listener configured',
    );
  }

  // Legacy entry point kept for backward compatibility — delegates to the new split methods.
  Future<void> _initializeServices() async {
    await _registerFcmToken();
    await _initializeForegroundNotificationPipeline();
  }

  Future<dynamic> createAndDisplayNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
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
      'DEBUG_NOTIF_HANDLER: Setting up foreground notification listener',
    );

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
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
            '❌ Message is missing title/body. Cannot display notification.',
          );
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
            id:
                message.messageId ??
                DateTime.now().millisecondsSinceEpoch.toString(),
            title: title,
            body: body,
            timestamp: DateTime.now(),
            isRead: false,
            type:
                message.data['type'] ??
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
            await _updateAppUI(message);
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
      },
      onError: (error) {
        _debugLog('\n❌ ERROR IN ONMESSAGE LISTENER');
        _debugLog('Error: $error');
      },
    );

    _debugLog(
      'DEBUG_NOTIF_HANDLER: ✅ Foreground notification listener configured',
    );
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
        'DEBUG_NOTIF_HANDLER: Error storing notification persistently: $e',
      );
    }
  }

  // Method to update app UI based on notification data
  Future<void> _updateAppUI(RemoteMessage message) async {
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
          'DEBUG_NOTIF_HANDLER: Processing notification type: $notificationType',
        );

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
          case 'emergency_broadcast':
            _debugLog(
              'DEBUG_NOTIF_HANDLER: Emergency broadcast received - refreshing home dashboard',
            );
            final sharedUtils = SharedPreferencesUtils();
            await sharedUtils.init();
            final email = sharedUtils.getUserEmail();
            if (email != null && email.isNotEmpty) {
              ref.read(homeViewModelProvider.notifier).refreshSilently(email);
            }
            break;
        }
      }
    } catch (e) {
      _debugLog('DEBUG_NOTIF_HANDLER: Error updating UI: $e');
    }
  }
}
