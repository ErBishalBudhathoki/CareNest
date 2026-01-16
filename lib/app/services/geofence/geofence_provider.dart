import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:carenest/app/services/geofence/geofence_service.dart';
import 'package:carenest/app/features/notifications/models/notification_model.dart';
import 'package:carenest/app/services/notificationservice/local_notification_service.dart';


/// Provider for the GeofenceService singleton
final geofenceServiceProvider = Provider<GeofenceService>((ref) {
  return GeofenceService();
});

/// Provider for geofence enabled state
final geofenceEnabledProvider = FutureProvider<bool>((ref) async {
  final service = ref.watch(geofenceServiceProvider);
  return service.isGeofencingEnabled();
});

/// Handler for geofence events - sends clock-in reminder notifications
class GeofenceNotificationHandler {
  final LocalNotificationService _notificationService;
  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  GeofenceNotificationHandler(this._notificationService);

  /// Handle when user enters a client's geofence
  Future<void> onGeofenceEnter(GeofenceLocation location) async {
    // Create notification model
    final notification = NotificationModel(
      id: 'geofence_${location.clientId}_${DateTime.now().millisecondsSinceEpoch}',
      title: '📍 Arrived at ${location.clientName}',
      body: 'Tap to clock in and start your shift timer.',
      timestamp: DateTime.now(),
      type: 'timer',
      data: {
        'type': 'geofence_arrival',
        'clientId': location.clientId,
        'clientName': location.clientName,
        'appointmentId': location.appointmentId ?? '',
        'latitude': location.latitude.toString(),
        'longitude': location.longitude.toString(),
      },
    );

    // Display local notification
    await _notificationService.createAndDisplayNotification(
      notification,
      {
        'type': 'geofence_arrival',
        'clientId': location.clientId,
        'clientName': location.clientName,
        'appointmentId': location.appointmentId ?? '',
        'channelId': 'shift_reminders',
      },
    );
  }

  /// Handle when user exits a client's geofence (optional feature)
  Future<void> onGeofenceExit(GeofenceLocation location) async {
    // Could prompt to clock out if they haven't already
    // For now, we'll just log this
  }
}

/// Provider for the notification handler
final geofenceNotificationHandlerProvider = Provider<GeofenceNotificationHandler>((ref) {
  return GeofenceNotificationHandler(LocalNotificationService());
});

/// Initialize geofence monitoring with notification handling
Future<void> initializeGeofenceMonitoring(WidgetRef ref) async {
  final geofenceService = ref.read(geofenceServiceProvider);
  final notificationHandler = ref.read(geofenceNotificationHandlerProvider);
  
  // Load any saved geofences
  await geofenceService.loadSavedGeofences();
  
  // Check if geofencing is enabled
  final isEnabled = await geofenceService.isGeofencingEnabled();
  if (!isEnabled) return;
  
  // Start monitoring with notification callback
  await geofenceService.startMonitoring(
    onEvent: (location, isEntry) async {
      if (isEntry) {
        await notificationHandler.onGeofenceEnter(location);
      } else {
        await notificationHandler.onGeofenceExit(location);
      }
    },
  );
}
