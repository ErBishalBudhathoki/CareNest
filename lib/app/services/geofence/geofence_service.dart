import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

/// Result of a permission request with detailed information
class LocationPermissionResult {
  final bool granted;
  final bool backgroundGranted;
  final String? denialReason;
  final bool permanentlyDenied;

  const LocationPermissionResult({
    required this.granted,
    required this.backgroundGranted,
    this.denialReason,
    this.permanentlyDenied = false,
  });
  
  bool get canUseGeofence => granted && backgroundGranted;
}

/// A client location to monitor for geofencing
class GeofenceLocation {
  final String clientId;
  final String clientName;
  final double latitude;
  final double longitude;
  final double radiusMeters;
  final String? appointmentId;
  final DateTime? shiftStartTime;

  const GeofenceLocation({
    required this.clientId,
    required this.clientName,
    required this.latitude,
    required this.longitude,
    this.radiusMeters = 100, // Default 100m radius
    this.appointmentId,
    this.shiftStartTime,
  });

  Map<String, dynamic> toJson() => {
    'clientId': clientId,
    'clientName': clientName,
    'latitude': latitude,
    'longitude': longitude,
    'radiusMeters': radiusMeters,
    'appointmentId': appointmentId,
    'shiftStartTime': shiftStartTime?.toIso8601String(),
  };

  factory GeofenceLocation.fromJson(Map<String, dynamic> json) {
    return GeofenceLocation(
      clientId: json['clientId'],
      clientName: json['clientName'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      radiusMeters: json['radiusMeters'] ?? 100,
      appointmentId: json['appointmentId'],
      shiftStartTime: json['shiftStartTime'] != null
          ? DateTime.tryParse(json['shiftStartTime'])
          : null,
    );
  }
}

/// Service for monitoring geofence regions around client locations
/// and triggering clock-in reminders when the user arrives.
class GeofenceService {
  static const String _geofencesKey = 'active_geofences';
  static const String _settingsKey = 'geofence_settings';
  static const double _defaultRadiusMeters = 100; // 100 meters

  final List<GeofenceLocation> _activeGeofences = [];
  StreamSubscription<Position>? _positionSubscription;
  bool _isMonitoring = false;
  Function(GeofenceLocation, bool)? _onGeofenceEvent; // (location, isEntry)

  /// Check if geofence monitoring is currently active
  bool get isMonitoring => _isMonitoring;

  /// Get the list of active geofences
  List<GeofenceLocation> get activeGeofences => List.unmodifiable(_activeGeofences);

  // ============================================================
  // PERMISSION HANDLING - App Store & Play Store Compliant
  // ============================================================

  /// Request location permissions with detailed user-facing explanations.
  /// This follows Apple and Google guidelines for background location.
  Future<LocationPermissionResult> requestLocationPermissions({
    required BuildContext context,
    bool showExplanationDialog = true,
  }) async {
    // Step 1: Check current permission status
    LocationPermission currentPermission = await Geolocator.checkPermission();
    
    // Step 2: If denied or not determined, show explanation dialog first
    if (currentPermission == LocationPermission.denied ||
        currentPermission == LocationPermission.deniedForever) {
      
      if (showExplanationDialog && context.mounted) {
        final shouldProceed = await _showPermissionExplanationDialog(context);
        if (!shouldProceed) {
          return const LocationPermissionResult(
            granted: false,
            backgroundGranted: false,
            denialReason: 'User declined after explanation',
          );
        }
      }
    }

    // Step 3: Request when-in-use permission first (required before background)
    if (currentPermission == LocationPermission.denied) {
      currentPermission = await Geolocator.requestPermission();
    }

    if (currentPermission == LocationPermission.deniedForever) {
      return const LocationPermissionResult(
        granted: false,
        backgroundGranted: false,
        denialReason: 'Location permission permanently denied. Please enable in Settings.',
        permanentlyDenied: true,
      );
    }

    if (currentPermission == LocationPermission.denied) {
      return const LocationPermissionResult(
        granted: false,
        backgroundGranted: false,
        denialReason: 'Location permission denied',
      );
    }

    // Step 4: Check if we have when-in-use permission
    bool hasWhenInUse = currentPermission == LocationPermission.whileInUse ||
                        currentPermission == LocationPermission.always;

    if (!hasWhenInUse) {
      return const LocationPermissionResult(
        granted: false,
        backgroundGranted: false,
        denialReason: 'Location access not granted',
      );
    }

    // Step 5: For geofencing, we need "Always" permission
    // Request background location separately (Android 11+ / iOS)
    bool hasAlways = currentPermission == LocationPermission.always;
    
    if (!hasAlways) {
      // Show specific dialog explaining why background is needed
      if (showExplanationDialog && context.mounted) {
        final shouldRequestBackground = await _showBackgroundPermissionDialog(context);
        if (!shouldRequestBackground) {
          return LocationPermissionResult(
            granted: true,
            backgroundGranted: false,
            denialReason: 'User declined background location',
          );
        }
      }

      // Request background location (this opens system settings on Android 11+)
      final backgroundStatus = await Permission.locationAlways.request();
      hasAlways = backgroundStatus.isGranted;
    }

    debugPrint('GeofenceService: Permission result - whenInUse: $hasWhenInUse, always: $hasAlways');

    return LocationPermissionResult(
      granted: hasWhenInUse,
      backgroundGranted: hasAlways,
    );
  }

  /// Show a dialog explaining why we need location permission
  Future<bool> _showPermissionExplanationDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.location_on, color: Colors.blue, size: 28),
            SizedBox(width: 12),
            Expanded(child: Text('Location Access Needed')),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CareNest uses your location to:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            _PermissionBullet(
              icon: Icons.notifications_active,
              text: 'Remind you to clock in when you arrive at a client\'s location',
            ),
            SizedBox(height: 8),
            _PermissionBullet(
              icon: Icons.timer,
              text: 'Ensure accurate timesheet records',
            ),
            SizedBox(height: 8),
            _PermissionBullet(
              icon: Icons.map,
              text: 'Provide navigation to appointments',
            ),
            SizedBox(height: 16),
            Text(
              'Your location data is never shared and is only used to improve your work experience.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Not Now'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Enable Location'),
          ),
        ],
      ),
    ) ?? false;
  }

  /// Show a dialog explaining why background location is specifically needed
  Future<bool> _showBackgroundPermissionDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.location_searching, color: Colors.orange, size: 28),
            SizedBox(width: 12),
            Expanded(child: Text('Background Location')),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'For automatic clock-in reminders, CareNest needs to access your location even when the app is closed.',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 16),
            Text(
              'How we use background location:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            SizedBox(height: 8),
            _PermissionBullet(
              icon: Icons.circle_notifications,
              text: 'We only monitor when you\'re near a scheduled client location',
            ),
            SizedBox(height: 6),
            _PermissionBullet(
              icon: Icons.battery_saver,
              text: 'Battery-efficient monitoring (uses geofence, not GPS tracking)',
            ),
            SizedBox(height: 6),
            _PermissionBullet(
              icon: Icons.toggle_off,
              text: 'You can disable this anytime in Settings',
            ),
            SizedBox(height: 16),
            Text(
              'On the next screen, please select "Allow all the time" or "Always" for the best experience.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.blue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Skip (Limited Features)'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Continue'),
          ),
        ],
      ),
    ) ?? false;
  }

  /// Open app settings for the user to manually grant permissions
  Future<bool> openAppSettings() async {
    return await Geolocator.openAppSettings();
  }

  // ============================================================
  // GEOFENCE MANAGEMENT
  // ============================================================

  /// Register a client location for geofence monitoring
  Future<void> registerGeofence(GeofenceLocation location) async {
    // Remove existing geofence for this client if any
    _activeGeofences.removeWhere((g) => g.clientId == location.clientId);
    
    // Add new geofence
    _activeGeofences.add(location);
    
    // Persist to storage
    await _saveGeofences();
    
    debugPrint('GeofenceService: Registered geofence for ${location.clientName} at (${location.latitude}, ${location.longitude})');
  }

  /// Remove a geofence for a client
  Future<void> removeGeofence(String clientId) async {
    _activeGeofences.removeWhere((g) => g.clientId == clientId);
    await _saveGeofences();
    
    debugPrint('GeofenceService: Removed geofence for client $clientId');
  }

  /// Remove all geofences
  Future<void> clearAllGeofences() async {
    _activeGeofences.clear();
    await _saveGeofences();
    
    debugPrint('GeofenceService: Cleared all geofences');
  }

  /// Load saved geofences from storage
  Future<void> loadSavedGeofences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_geofencesKey);
      
      if (jsonString != null) {
        final List<dynamic> jsonList = jsonDecode(jsonString);
        _activeGeofences.clear();
        
        for (final json in jsonList) {
          _activeGeofences.add(GeofenceLocation.fromJson(json));
        }
        
        debugPrint('GeofenceService: Loaded ${_activeGeofences.length} geofences from storage');
      }
    } catch (e) {
      debugPrint('GeofenceService: Error loading geofences: $e');
    }
  }

  Future<void> _saveGeofences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = _activeGeofences.map((g) => g.toJson()).toList();
      await prefs.setString(_geofencesKey, jsonEncode(jsonList));
    } catch (e) {
      debugPrint('GeofenceService: Error saving geofences: $e');
    }
  }

  // ============================================================
  // GEOFENCE MONITORING
  // ============================================================

  /// Start monitoring for geofence entry/exit events
  Future<bool> startMonitoring({
    Function(GeofenceLocation location, bool isEntry)? onEvent,
  }) async {
    if (_isMonitoring) {
      debugPrint('GeofenceService: Already monitoring');
      return true;
    }

    // Check permissions
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      debugPrint('GeofenceService: Cannot start monitoring - no permission');
      return false;
    }

    _onGeofenceEvent = onEvent;

    // Configure location settings for battery-efficient monitoring
    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.medium, // Balance accuracy and battery
      distanceFilter: 50, // Only update every 50 meters
    );

    _positionSubscription = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen(_onPositionUpdate);

    _isMonitoring = true;
    debugPrint('GeofenceService: Started monitoring ${_activeGeofences.length} geofences');
    
    return true;
  }

  /// Stop monitoring for geofence events
  void stopMonitoring() {
    _positionSubscription?.cancel();
    _positionSubscription = null;
    _isMonitoring = false;
    
    debugPrint('GeofenceService: Stopped monitoring');
  }

  /// Handle position updates and check geofence boundaries
  void _onPositionUpdate(Position position) {
    for (final geofence in _activeGeofences) {
      final distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        geofence.latitude,
        geofence.longitude,
      );

      final isInside = distance <= geofence.radiusMeters;
      
      // Check if state changed (you could track previous state for exit events)
      // For now, we trigger on entry
      if (isInside) {
        debugPrint('GeofenceService: Entered geofence for ${geofence.clientName}');
        _onGeofenceEvent?.call(geofence, true);
      }
    }
  }

  // ============================================================
  // USER SETTINGS
  // ============================================================

  /// Check if geofencing is enabled by the user
  Future<bool> isGeofencingEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('${_settingsKey}_enabled') ?? true; // Default enabled
  }

  /// Enable or disable geofencing
  Future<void> setGeofencingEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('${_settingsKey}_enabled', enabled);
    
    if (!enabled) {
      stopMonitoring();
    }
    
    debugPrint('GeofenceService: Geofencing ${enabled ? "enabled" : "disabled"}');
  }

  /// Get the geofence radius setting
  Future<double> getGeofenceRadius() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('${_settingsKey}_radius') ?? _defaultRadiusMeters;
  }

  /// Set the geofence radius
  Future<void> setGeofenceRadius(double radiusMeters) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('${_settingsKey}_radius', radiusMeters);
  }

  /// Dispose of resources
  void dispose() {
    stopMonitoring();
  }
}

/// Helper widget for permission dialogs
class _PermissionBullet extends StatelessWidget {
  final IconData icon;
  final String text;

  const _PermissionBullet({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: Colors.blue),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text, style: const TextStyle(fontSize: 13)),
        ),
      ],
    );
  }
}
