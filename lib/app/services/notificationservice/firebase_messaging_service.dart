import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:carenest/app/services/notificationservice/local_notification_service.dart';
import 'package:carenest/app/features/notifications/models/notification_model.dart';
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class FirebaseMessagingService {
  final LocalNotificationService _localNotificationService;

  FirebaseMessagingService(this._localNotificationService);

  Future<void> initialize() async {
    debugPrint('DEBUG_FCM: Initializing FirebaseMessagingService...');

    // Request permission with more detailed options
    final settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      criticalAlert: true,
      announcement: false,
      carPlay: false,
    );

    // For Android 13+, we also need to request POST_NOTIFICATIONS permission
    if (Platform.isAndroid) {
      // Initialize local notifications to trigger permission request
      await _localNotificationService.initialize();
    }

    debugPrint(
        'DEBUG_FCM: User notification permission status: ${settings.authorizationStatus}');

    // Disable automatic foreground notifications to allow manual handling
    // This ensures FirebaseMessaging.onMessage.listen callback is triggered
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: false, // Disable automatic alert display
      badge: false, // Disable automatic badge updates
      sound: false, // Disable automatic sound
    );

    debugPrint(
        'DEBUG_FCM: FirebaseMessagingService initialized with foreground notification options.');

    // Foreground message handling is now done by NotificationHandler widget
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   debugPrint('DEBUG_FCM: Foreground message received!');
    //   _handleMessage(message, foreground: true);
    // });
    debugPrint(
        'DEBUG_FCM: Foreground message handling delegated to NotificationHandler widget');

    // Handle when app is opened from a background state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      debugPrint('DEBUG_FCM: App opened from background via notification!');
      await _handleMessage(message, foreground: false);
      // Here you can navigate to specific screen based on the message data
      // For example: navigatorKey.currentState?.pushNamed('/notification_details', arguments: message.data);
    });

    // Check if the app was opened from a terminated state via notification
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      if (message != null) {
        debugPrint(
            'DEBUG_FCM: App opened from terminated state via notification!');
        await _handleMessage(message, foreground: false);
        // Here you can navigate to specific screen based on the message data
        // For example: navigatorKey.currentState?.pushNamed('/notification_details', arguments: message.data);
      }
    });

    // Background message handler is registered in main.dart to avoid conflicts
    // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Get and log the FCM token for this device
    if (Platform.isIOS) {
      final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      if (apnsToken == null) {
        debugPrint(
            'DEBUG_FCM: APNS token not available, skipping FCM token retrieval.');
        return;
      }
    }
    final fcmToken = await FirebaseMessaging.instance.getToken();
    debugPrint('DEBUG_FCM: FCM Token: ${fcmToken ?? "token not available"}');

    // Add token refresh listener
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      debugPrint(
          'DEBUG_FCM: FCM token refreshed: ${newToken.substring(0, 15)}...');
    });

    debugPrint('DEBUG_FCM: FirebaseMessagingService initialized successfully');
  }

  Future<void> _handleMessage(RemoteMessage message,
      {bool foreground = false}) async {
    debugPrint('DEBUG_FCM: Message received! Foreground: $foreground');
    debugPrint('DEBUG_FCM: Message data: ${message.data}');
    debugPrint('DEBUG_FCM: Message notification: ${message.notification}');

    try {
      // Process notification messages
      if (message.notification != null) {
        debugPrint(
            'DEBUG_FCM: Notification title: ${message.notification!.title}');
        debugPrint(
            'DEBUG_FCM: Notification body: ${message.notification!.body}');

        // For foreground messages, we need to manually show the notification
        // since FCM doesn't automatically display them when app is in foreground
        if (foreground) {
          // Extract notification data
          final title = message.notification!.title ?? 'New Notification';
          final body = message.notification!.body ?? '';

          // Extract Android-specific notification details if available
          String? imageUrl;
          if (Platform.isAndroid &&
              message.notification?.android?.imageUrl != null) {
            imageUrl = message.notification!.android!.imageUrl;
            debugPrint('DEBUG_FCM: Android notification image URL: $imageUrl');
          }

          // Create a more structured payload with all available data
          final Map<String, dynamic> payloadData = {
            ...message.data,
            'title': title,
            'body': body,
            'timestamp': DateTime.now().millisecondsSinceEpoch,
            'isForeground': true, // Add flag to indicate foreground message
          };

          // Add image URL if available
          if (imageUrl != null) {
            payloadData['imageUrl'] = imageUrl;
          }

          // Add notification type if available in data
          if (message.data.containsKey('type')) {
            payloadData['type'] = message.data['type'];
          } else {
            // Default type if not specified
            payloadData['type'] = 'general';
          }

          // Convert message data to a JSON string for the payload
          final payload = json.encode(payloadData);

          // Create NotificationModel for the notification
          final notification = NotificationModel(
            id: message.hashCode.toString(),
            title: title,
            body: body,
            timestamp: DateTime.now(),
            type: payloadData['type'] ?? 'message',
            data: payloadData,
          );

          // Display the notification using local notification service
          await _localNotificationService.createAndDisplayNotification(
            notification,
            payloadData,
          );

          // Process any UI updates or actions based on the notification
          _processNotificationData(message.data);
        }

        // For background and terminated state messages, the system already shows the notification
        // We only need to handle any specific actions when the user taps on them
        else {
          debugPrint(
              'DEBUG_FCM: Background/terminated notification, system will display it');
        }
      }

      // Handle data-only messages (no notification payload)
      else if (message.data.isNotEmpty) {
        debugPrint('DEBUG_FCM: Data-only message received: ${message.data}');

        // For foreground data-only messages, you might want to show a notification
        // or handle the data directly in the app
        if (foreground) {
          // Extract data for notification
          final title = message.data['title'] ?? 'New Message';
          final body = message.data['body'] ?? 'You have a new message';

          // Add timestamp and foreground flag to payload
          final Map<String, dynamic> payloadData = {
            ...message.data,
            'timestamp': DateTime.now().millisecondsSinceEpoch,
            'isForeground': true, // Add flag to indicate foreground message
          };

          // Add notification type if available
          if (!payloadData.containsKey('type')) {
            payloadData['type'] = 'data';
          }

          final payload = json.encode(payloadData);

          // Create NotificationModel for the data message
          final notification = NotificationModel(
            id: message.hashCode.toString(),
            title: title,
            body: body,
            timestamp: DateTime.now(),
            type: payloadData['type'] ?? 'data',
            data: payloadData,
          );

          // Display notification for data message
          await _localNotificationService.createAndDisplayNotification(
            notification,
            payloadData,
          );

          // Process any UI updates or actions based on the data
          _processNotificationData(message.data);
        }
        // For background data messages
        else {
          debugPrint('DEBUG_FCM: Background data message, processing silently');
          // Process any background tasks if needed
        }
      }
    } catch (e) {
      debugPrint('DEBUG_FCM: Error handling message: $e');
    }
  }

  // Process notification data for UI updates or other actions
  void _processNotificationData(Map<String, dynamic> data) {
    try {
      debugPrint('DEBUG_FCM: Processing notification data for UI updates');

      // Example: Update badge count if provided
      if (data.containsKey('count')) {
        final badgeCount = int.tryParse(data['count'] ?? '0') ?? 0;
        debugPrint('DEBUG_FCM: Badge count in notification: $badgeCount');
        // Here you would typically use a state management solution to update UI
        // For example with Provider or Riverpod
      }

      // Example: Process different notification types
      if (data.containsKey('type')) {
        final notificationType = data['type'];
        debugPrint(
            'DEBUG_FCM: Processing notification type: $notificationType');

        // Handle different notification types
        switch (notificationType) {
          case 'invoice':
            // Process invoice notification data
            if (data.containsKey('invoiceId')) {
              debugPrint(
                  'DEBUG_FCM: Processing invoice notification for ID: ${data['invoiceId']}');
              // Update invoice-related UI or data
            }
            break;
          case 'timer':
            // Process timer notification data
            debugPrint('DEBUG_FCM: Processing timer notification');
            // Update timer-related UI or data
            break;
          case 'message':
            // Process message notification data
            debugPrint('DEBUG_FCM: Processing message notification');
            // Update message-related UI or data
            break;
        }
      }
    } catch (e) {
      debugPrint('DEBUG_FCM: Error processing notification data: $e');
    }
  }
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('DEBUG_FCM: Background handler triggered!');
  debugPrint('DEBUG_FCM: Background message data: ${message.data}');
  debugPrint(
      'DEBUG_FCM: Background message notification: ${message.notification}');

  // For background messages with notification payload
  if (message.notification != null) {
    debugPrint(
        'DEBUG_FCM: Background notification message received: ${message.notification!.title}');

    final Map<String, dynamic> payloadData = {
      ...message.data,
      'title': message.notification!.title,
      'body': message.notification!.body,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'type': message.data['type'] ?? 'general',
      'isForeground': false, // Add flag to indicate background message
    };

    // Store notification in persistent storage
    await storeBackgroundNotification(
      message.hashCode.toString(),
      message.notification!.title,
      message.notification!.body,
      message.data['type'] ?? 'general',
      payloadData, // Store the enhanced payload data
    );
  }
  // Handle data-only background messages
  else if (message.data.isNotEmpty) {
    debugPrint('DEBUG_FCM: Background data-only message received');

    final title = message.data['title'] ?? 'New Message';
    final body = message.data['body'] ?? 'You have a new update';

    // Create enhanced payload with background flag
    final Map<String, dynamic> payloadData = {
      ...message.data,
      'title': title,
      'body': body,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'type': message.data['type'] ?? 'data',
      'isForeground': false, // Add flag to indicate background message
    };

    // Store notification in persistent storage with enhanced payload
    await storeBackgroundNotification(
      message.hashCode.toString(),
      title,
      body,
      message.data['type'] ?? 'data',
      payloadData, // Store the enhanced payload data
    );

    // Initialize local notification service for data-only messages
    final localNotificationService = LocalNotificationService();
    await localNotificationService.initialize();

    // Create NotificationModel for the background notification
    final notification = NotificationModel(
      id: message.hashCode.toString(),
      title: title,
      body: body,
      timestamp: DateTime.now(),
      type: payloadData['type'] ?? 'background',
      data: payloadData,
    );

    // Display the notification
    await localNotificationService.createAndDisplayNotification(
      notification,
      payloadData,
    );
  }
}

// Helper function to store background notifications in persistent storage
Future<void> storeBackgroundNotification(
  String id,
  String? title,
  String? body,
  String type,
  Map<String, dynamic> data,
) async {
  try {
    // Use SharedPreferences to store background notifications
    // These will be loaded when the app starts
    final prefs = await SharedPreferences.getInstance();
    // CRITICAL: Force a reload to get the most recent list from disk before adding to it.
    await prefs.reload();

    // Get existing background notifications
    final existingNotifications =
        prefs.getStringList('background_notifications') ?? [];

    // Create a proper NotificationModel instance first.
    final notificationModel = NotificationModel(
      id: id,
      title: title ?? 'New Notification',
      body: body ?? '',
      timestamp: DateTime.now(),
      isRead: false, // Always unread when new
      type: type,
      data: data,
    );

    // Add new notification to the list
    existingNotifications.add(json.encode(notificationModel.toJson()));

    // Keep only the last 50 notifications to prevent storage bloat
    if (existingNotifications.length > 50) {
      existingNotifications.removeRange(0, existingNotifications.length - 50);
    }

    // Save back to SharedPreferences
    await prefs.setStringList(
        'background_notifications', existingNotifications);

    debugPrint('DEBUG_FCM: Background notification stored successfully: $id');
  } catch (e) {
    debugPrint('DEBUG_FCM: Error storing background notification: $e');
  }
}
