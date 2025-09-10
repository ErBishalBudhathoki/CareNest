import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:io';
import 'package:carenest/app/features/notifications/models/notification_model.dart';
import 'package:flutter/foundation.dart';

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    debugPrint('DEBUG_LOCAL_NOTIF: Initializing LocalNotificationService...');

    // Initialization settings for Android
    final AndroidInitializationSettings androidInitSettings =
        const AndroidInitializationSettings('@drawable/ic_notification');

    // Initialization settings for iOS
    final DarwinInitializationSettings iosInitSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      // Note: onDidReceiveLocalNotification was removed in flutter_local_notifications 18.0.1+
    );

    // Request notification permissions for Android 13+ (API level 33+)
    if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
          _notificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      if (androidPlugin != null) {
        final bool? granted =
            await androidPlugin.requestNotificationsPermission();
        debugPrint(
            'DEBUG_LOCAL_NOTIF: Android notification permission granted: $granted');
      }
    }

    // Combined initialization settings
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitSettings,
      iOS: iosInitSettings,
    );

    // Initialize the plugin
    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotification,
    );

    // Create notification channels for Android
    await _createNotificationChannels();

    debugPrint(
        'DEBUG_LOCAL_NOTIF: LocalNotificationService initialized successfully');
  }

  Future<void> createAndDisplayNotification(
      NotificationModel notificationModel, Map<String, dynamic> payload) async {
    try {
      // Extract channelId from payload, default to 'timer_alerts'
      final String channelId = payload['channelId'] ?? 'timer_alerts';

      debugPrint('\n=== LOCAL NOTIFICATION DISPLAY ATTEMPT ===');
      debugPrint('Timestamp: ${DateTime.now().toIso8601String()}');
      debugPrint('Channel ID: $channelId');
      debugPrint('Notification ID: ${notificationModel.hashCode}');
      debugPrint('Title: ${notificationModel.title}');
      debugPrint('Body: ${notificationModel.body}');
      debugPrint('Payload Keys: ${payload.keys.toList()}');
      debugPrint('Full Payload: ${jsonEncode(payload)}');

      // Check if notification plugin is initialized
      debugPrint('\n--- PLUGIN STATUS CHECK ---');
      try {
        // Test if plugin is responsive
        final pendingNotifications =
            await _notificationsPlugin.pendingNotificationRequests();
        debugPrint(
            '✅ Plugin is responsive - Pending notifications: ${pendingNotifications.length}');
      } catch (e) {
        debugPrint('❌ Plugin may not be initialized properly: $e');
      }

      // Use the actual channelId for Android notification details
      final AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
        channelId, // Use the dynamic channelId
        _getChannelName(channelId),
        channelDescription: _getChannelDescription(channelId),
        importance: Importance.high,
        priority: Priority.high,
        fullScreenIntent: true,
        category: AndroidNotificationCategory.alarm,
        enableVibration: true,
        playSound: true,
        showWhen: true,
        when: DateTime.now().millisecondsSinceEpoch,
      );

      // Create iOS notification details
      const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        sound: 'default',
        badgeNumber: 1,
        interruptionLevel: InterruptionLevel.timeSensitive,
      );

      // Combine platform-specific details
      final NotificationDetails notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      final notificationId = notificationModel.hashCode;

      debugPrint('\n--- NOTIFICATION DISPLAY CALL ---');
      debugPrint('Final Notification ID: $notificationId');
      debugPrint('Final Channel ID: $channelId');
      debugPrint('Final Title: ${notificationModel.title}');
      debugPrint('Final Body: ${notificationModel.body}');
      debugPrint(
          'Android Details: Channel=$channelId, Priority=High, Sound=true');
      debugPrint('iOS Details: Alert=true, Badge=true, Sound=default');
      debugPrint('Payload JSON: ${jsonEncode(payload)}');

      debugPrint('\n🚀 CALLING _notificationsPlugin.show() NOW...');
      final stopwatch = Stopwatch()..start();

      await _notificationsPlugin.show(
        notificationId, // Notification ID
        notificationModel.title,
        notificationModel.body,
        notificationDetails,
        payload: jsonEncode(payload),
      );

      stopwatch.stop();
      debugPrint(
          '✅ _notificationsPlugin.show() completed in ${stopwatch.elapsedMilliseconds}ms');
      debugPrint('✅ LOCAL NOTIFICATION DISPLAY ATTEMPT FINISHED');
      debugPrint(
          '🔍 Check device notification tray/center for the notification');
      debugPrint(
          '🔍 If not visible, check device notification settings and permissions');
      debugPrint('=== END LOCAL NOTIFICATION DISPLAY ===\n');
    } catch (e) {
      debugPrint('DEBUG_LOCAL_NOTIF: ❌ Error creating notification: $e');
      rethrow;
    }
  }

  String _getChannelName(String channelId) {
    switch (channelId) {
      case 'invoice':
        return 'Invoice Notifications';
      case 'timer_alerts':
        return 'Timer Alerts';
      case 'message':
        return 'Message Notifications';
      default:
        return 'General Notifications';
    }
  }

  String _getChannelDescription(String channelId) {
    switch (channelId) {
      case 'invoice':
        return 'Notifications for invoice updates';
      case 'timer_alerts':
        return 'Notifications for timer alerts';
      case 'message':
        return 'Notifications for messages';
      default:
        return 'General application notifications';
    }
  }

  Future<void> onDidReceiveNotification(
      NotificationResponse notificationResponse) async {
    // Handle notification tap
    debugPrint(
        'DEBUG_LOCAL_NOTIF: Notification tapped with payload: ${notificationResponse.payload}');
    if (notificationResponse.payload != null) {
      try {
        // Parse the payload (which should be a JSON string)
        final Map<String, dynamic> parsedPayload =
            json.decode(notificationResponse.payload!) as Map<String, dynamic>;

        debugPrint('DEBUG_LOCAL_NOTIF: Parsed payload: $parsedPayload');

        // Handle the notification based on its type or content
        // For example, navigate to a specific screen based on the payload data

        // Example: Check for specific data in the payload
        if (parsedPayload.containsKey('type')) {
          final notificationType = parsedPayload['type'];
          debugPrint('DEBUG_LOCAL_NOTIF: Notification type: $notificationType');

          // Handle different notification types
          switch (notificationType) {
            case 'timer':
              // Navigate to timer screen
              // navigatorKey.currentState?.pushNamed('/timer', arguments: parsedPayload);
              break;
            case 'invoice':
              // Navigate to invoice details
              // navigatorKey.currentState?.pushNamed('/invoice_details', arguments: parsedPayload);
              break;
            case 'message':
              // Navigate to messages
              // navigatorKey.currentState?.pushNamed('/messages', arguments: parsedPayload);
              break;
            default:
              // Default action for other notification types
              // navigatorKey.currentState?.pushNamed('/notifications');
              break;
          }
        }
      } catch (e) {
        debugPrint('DEBUG_LOCAL_NOTIF: Error parsing notification payload: $e');
      }
    }
  }

  Future<void> _createNotificationChannels() async {
    debugPrint('DEBUG_LOCAL_NOTIF: Creating notification channels');

    if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
          _notificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      if (androidPlugin != null) {
        // Main notification channel for general notifications
        const AndroidNotificationChannel mainChannel =
            AndroidNotificationChannel(
          'invoice',
          'Invoice Notifications',
          description: 'General notifications from the app',
          importance: Importance.max,
          playSound: true,
          sound: null, // Use default system notification sound
          enableVibration: true,
          enableLights: true,
          showBadge: true,
        );

        // Timer alerts channel for employee tracking notifications
        const AndroidNotificationChannel timerChannel =
            AndroidNotificationChannel(
          'timer_alerts',
          'Timer Alerts',
          description: 'Notifications for timer events and reminders',
          importance: Importance.max,
          playSound: true,
          sound: null, // Use default system notification sound
          enableVibration: true,
          enableLights: true,
          showBadge: true,
        );

        // Message notifications channel for general messaging
        const AndroidNotificationChannel messageChannel =
            AndroidNotificationChannel(
          'message',
          'Message Notifications',
          description: 'Notifications for messages and general communications',
          importance: Importance.max,
          playSound: true,
          sound: null, // Use default system notification sound
          enableVibration: true,
          enableLights: true,
          showBadge: true,
        );

        // Create the notification channels
        await androidPlugin.createNotificationChannel(mainChannel);
        await androidPlugin.createNotificationChannel(timerChannel);
        await androidPlugin.createNotificationChannel(messageChannel);
        debugPrint(
            'DEBUG_LOCAL_NOTIF: Created notification channels: invoice, timer_alerts, message');
      }
    }
  }
}
