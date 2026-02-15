import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import '../models/notification_preferences.dart';

/// Service for handling geofence-based notifications
class GeofenceNotificationService {
  static final GeofenceNotificationService _instance =
      GeofenceNotificationService._internal();
  factory GeofenceNotificationService() => _instance;
  GeofenceNotificationService._internal();

  final Map<String, GeofenceMonitor> _activeMonitors = {};
  StreamController<GeofenceEvent>? _eventController;

  Stream<GeofenceEvent> get eventStream {
    _eventController ??= StreamController<GeofenceEvent>.broadcast();
    return _eventController!.stream;
  }

  /// Start monitoring a geofence for an appointment
  Future<void> startMonitoring({
    required String appointmentId,
    required String workerId,
    required String workerName,
    required String clientName,
    required String clientAddress,
    required double latitude,
    required double longitude,
    required double radiusMeters,
    required DateTime appointmentTime,
  }) async {
    // Check location permissions
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      debugPrint('Location permission denied for geofence monitoring');
      return;
    }

    // Create monitor
    final monitor = GeofenceMonitor(
      appointmentId: appointmentId,
      workerId: workerId,
      workerName: workerName,
      clientName: clientName,
      clientAddress: clientAddress,
      targetLatitude: latitude,
      targetLongitude: longitude,
      radiusMeters: radiusMeters,
      appointmentTime: appointmentTime,
      onEvent: _handleGeofenceEvent,
    );

    _activeMonitors[appointmentId] = monitor;
    await monitor.start();

    debugPrint('Started geofence monitoring for appointment: $appointmentId');
  }

  /// Stop monitoring a geofence
  Future<void> stopMonitoring(String appointmentId) async {
    final monitor = _activeMonitors.remove(appointmentId);
    if (monitor != null) {
      await monitor.stop();
      debugPrint('Stopped geofence monitoring for appointment: $appointmentId');
    }
  }

  /// Stop all active monitors
  Future<void> stopAllMonitoring() async {
    for (final monitor in _activeMonitors.values) {
      await monitor.stop();
    }
    _activeMonitors.clear();
    debugPrint('Stopped all geofence monitoring');
  }

  void _handleGeofenceEvent(GeofenceEvent event) {
    _eventController?.add(event);
    debugPrint('Geofence event: ${event.eventType} for ${event.workerName}');
  }

  void dispose() {
    stopAllMonitoring();
    _eventController?.close();
    _eventController = null;
  }
}

/// Individual geofence monitor for an appointment
class GeofenceMonitor {
  final String appointmentId;
  final String workerId;
  final String workerName;
  final String clientName;
  final String clientAddress;
  final double targetLatitude;
  final double targetLongitude;
  final double radiusMeters;
  final DateTime appointmentTime;
  final Function(GeofenceEvent) onEvent;

  StreamSubscription<Position>? _positionSubscription;
  bool _hasArrived = false;
  bool _hasDeparted = false;
  bool _hasNotifiedLate = false;
  Position? _lastPosition;

  GeofenceMonitor({
    required this.appointmentId,
    required this.workerId,
    required this.workerName,
    required this.clientName,
    required this.clientAddress,
    required this.targetLatitude,
    required this.targetLongitude,
    required this.radiusMeters,
    required this.appointmentTime,
    required this.onEvent,
  });

  Future<void> start() async {
    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10, // Update every 10 meters
    );

    _positionSubscription = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen(_handlePositionUpdate);
  }

  Future<void> stop() async {
    await _positionSubscription?.cancel();
    _positionSubscription = null;
  }

  void _handlePositionUpdate(Position position) {
    _lastPosition = position;

    final distance = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      targetLatitude,
      targetLongitude,
    );

    final now = DateTime.now();
    final isInsideGeofence = distance <= radiusMeters;

    // Check for arrival
    if (isInsideGeofence && !_hasArrived) {
      _hasArrived = true;
      _triggerEvent(
        GeofenceEventType.arrived,
        position,
        distance,
        'Worker arrived at appointment location',
      );
    }

    // Check for departure
    if (!isInsideGeofence && _hasArrived && !_hasDeparted) {
      _hasDeparted = true;
      _triggerEvent(
        GeofenceEventType.departed,
        position,
        distance,
        'Worker departed from appointment location',
      );
    }

    // Check for running late (15 minutes before appointment, not yet arrived)
    final minutesUntilAppointment =
        appointmentTime.difference(now).inMinutes;
    if (minutesUntilAppointment <= 15 &&
        minutesUntilAppointment > 0 &&
        !_hasArrived &&
        !_hasNotifiedLate) {
      _hasNotifiedLate = true;
      _triggerEvent(
        GeofenceEventType.runningLate,
        position,
        distance,
        'Worker may be running late (${distance.toInt()}m away)',
      );
    }

    // Check for near location (within 2x radius, approaching)
    if (distance <= radiusMeters * 2 && distance > radiusMeters && !_hasArrived) {
      _triggerEvent(
        GeofenceEventType.nearLocation,
        position,
        distance,
        'Worker approaching appointment location',
      );
    }
  }

  void _triggerEvent(
    GeofenceEventType eventType,
    Position position,
    double distance,
    String notes,
  ) {
    final event = GeofenceEvent(
      eventId: '${appointmentId}_${eventType.name}_${DateTime.now().millisecondsSinceEpoch}',
      workerId: workerId,
      workerName: workerName,
      appointmentId: appointmentId,
      clientName: clientName,
      clientAddress: clientAddress,
      eventType: eventType,
      timestamp: DateTime.now(),
      latitude: position.latitude,
      longitude: position.longitude,
      distanceMeters: distance,
      notes: notes,
    );

    onEvent(event);
  }
}
