import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:carenest/app/features/realtime_portal/models/realtime_portal_models.dart';

/// Geofence service for location monitoring
class GeofenceService {
  StreamSubscription<Position>? _positionSubscription;
  Timer? _locationTimer;
  bool _isMonitoring = false;

  // Geofence configuration
  final double _geofenceRadius = 100.0; // meters
  final int _locationUpdateInterval = 30; // seconds

  // Callbacks
  Function(Position)? onLocationUpdate;
  Function(GeofenceEvent)? onGeofenceEvent;
  Function(String)? onError;

  // Current state
  Position? _lastPosition;
  ClientLocation? _targetLocation;
  bool _insideGeofence = false;
  String? _appointmentId;

  /// Start monitoring location
  Future<void> startMonitoring({
    required String appointmentId,
    required ClientLocation targetLocation,
  }) async {
    if (_isMonitoring) {
      debugPrint('Geofence monitoring already active');
      return;
    }

    _appointmentId = appointmentId;
    _targetLocation = targetLocation;

    // Check location permissions
    final hasPermission = await _checkLocationPermission();
    if (!hasPermission) {
      onError?.call('Location permission denied');
      return;
    }

    // Check if location services are enabled
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      onError?.call('Location services are disabled');
      return;
    }

    _isMonitoring = true;
    debugPrint('Started geofence monitoring for appointment: $appointmentId');

    // Start periodic location updates
    _startLocationUpdates();
  }

  /// Stop monitoring location
  void stopMonitoring() {
    _positionSubscription?.cancel();
    _locationTimer?.cancel();
    _isMonitoring = false;
    _lastPosition = null;
    _targetLocation = null;
    _insideGeofence = false;
    _appointmentId = null;
    debugPrint('Stopped geofence monitoring');
  }

  /// Start location updates
  void _startLocationUpdates() {
    // Use timer for battery-efficient updates
    _locationTimer = Timer.periodic(
      Duration(seconds: _locationUpdateInterval),
      (_) => _updateLocation(),
    );

    // Get initial location
    _updateLocation();
  }

  /// Update current location
  Future<void> _updateLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _lastPosition = position;
      onLocationUpdate?.call(position);

      // Check geofence
      if (_targetLocation != null) {
        _checkGeofence(position);
      }
    } catch (e) {
      debugPrint('Error getting location: $e');
      onError?.call(e.toString());
    }
  }

  /// Check if position is inside geofence
  void _checkGeofence(Position position) {
    if (_targetLocation == null || _appointmentId == null) return;

    final distance = _calculateDistance(
      position.latitude,
      position.longitude,
      _targetLocation!.lat,
      _targetLocation!.lng,
    );

    final wasInside = _insideGeofence;
    final isInside = distance <= _geofenceRadius;

    // Detect geofence events
    if (!wasInside && isInside) {
      // Entered geofence
      _insideGeofence = true;
      _emitGeofenceEvent('arrived', distance);
    } else if (wasInside && !isInside) {
      // Exited geofence
      _insideGeofence = false;
      _emitGeofenceEvent('departed', distance);
    } else if (isInside && distance <= _geofenceRadius * 2) {
      // Approaching (within 2x radius)
      _emitGeofenceEvent('approaching', distance);
    }
  }

  /// Emit geofence event
  void _emitGeofenceEvent(String event, double distance) {
    if (_appointmentId == null || _lastPosition == null) return;

    final geofenceEvent = GeofenceEvent(
      appointmentId: _appointmentId!,
      event: event,
      distance: distance,
      timestamp: DateTime.now(),
      insideGeofence: _insideGeofence,
      approaching: event == 'approaching',
    );

    onGeofenceEvent?.call(geofenceEvent);
    debugPrint(
      'Geofence event: $event (distance: ${distance.toStringAsFixed(1)}m)',
    );
  }

  /// Calculate distance between two coordinates (Haversine formula)
  double _calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const earthRadius = 6371000.0; // meters

    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);

    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) *
            cos(_toRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  /// Convert degrees to radians
  double _toRadians(double degrees) {
    return degrees * pi / 180.0;
  }

  /// Check location permission
  Future<bool> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  /// Get current position
  Future<Position?> getCurrentPosition() async {
    try {
      final hasPermission = await _checkLocationPermission();
      if (!hasPermission) return null;

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      debugPrint('Error getting current position: $e');
      return null;
    }
  }

  /// Calculate ETA based on distance and average speed
  ETACalculation calculateETA({
    required Position currentPosition,
    required ClientLocation targetLocation,
    double averageSpeed = 30.0, // km/h
  }) {
    final distance = _calculateDistance(
      currentPosition.latitude,
      currentPosition.longitude,
      targetLocation.lat,
      targetLocation.lng,
    );

    // Convert speed from km/h to m/s
    final speedMs = averageSpeed * 1000 / 3600;

    // Calculate time in seconds
    final timeSeconds = distance / speedMs;

    // Add traffic factor (20% increase)
    final timeWithTraffic = timeSeconds * 1.2;

    final eta = DateTime.now().add(Duration(seconds: timeWithTraffic.round()));

    return ETACalculation(
      estimatedArrival: eta,
      distance: distance,
      avgSpeed: averageSpeed,
      minutes: (timeWithTraffic / 60).round(),
      trafficCondition: 'moderate',
    );
  }

  /// Check if monitoring is active
  bool get isMonitoring => _isMonitoring;

  /// Get last known position
  Position? get lastPosition => _lastPosition;

  /// Get target location
  ClientLocation? get targetLocation => _targetLocation;

  /// Check if inside geofence
  bool get insideGeofence => _insideGeofence;

  /// Dispose
  void dispose() {
    stopMonitoring();
  }
}
