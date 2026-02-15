import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;

// State class for Mileage
class MileageState {
  final bool isTracking;
  final Position? startPosition;
  final DateTime? startTime;
  final double currentDistance; // in meters
  final bool isSyncing;
  final String? error;

  MileageState({
    this.isTracking = false,
    this.startPosition,
    this.startTime,
    this.currentDistance = 0.0,
    this.isSyncing = false,
    this.error,
  });

  MileageState copyWith({
    bool? isTracking,
    Position? startPosition,
    DateTime? startTime,
    double? currentDistance,
    bool? isSyncing,
    String? error,
  }) {
    return MileageState(
      isTracking: isTracking ?? this.isTracking,
      startPosition: startPosition ?? this.startPosition,
      startTime: startTime ?? this.startTime,
      currentDistance: currentDistance ?? this.currentDistance,
      isSyncing: isSyncing ?? this.isSyncing,
      error: error ?? this.error,
    );
  }
}

class MileageController extends StateNotifier<MileageState> {
  final ApiMethod _api;

  MileageController(this._api) : super(MileageState()) {
    _loadState();
  }

  // Keys for SharedPreferences
  static const String _kIsTracking = 'mileage_is_tracking';
  static const String _kStartLat = 'mileage_start_lat';
  static const String _kStartLng = 'mileage_start_lng';
  static const String _kStartTime = 'mileage_start_time';
  static const String _kUnsyncedTrips = 'mileage_unsynced_trips';

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    final isTracking = prefs.getBool(_kIsTracking) ?? false;

    if (isTracking) {
      final lat = prefs.getDouble(_kStartLat);
      final lng = prefs.getDouble(_kStartLng);
      final timeStr = prefs.getString(_kStartTime);

      if (lat != null && lng != null && timeStr != null) {
        // Reconstruct position (mocking timestamp/accuracy for simplicity as they aren't stored)
        final position = Position(
            latitude: lat,
            longitude: lng,
            timestamp: DateTime.parse(timeStr),
            accuracy: 0,
            altitude: 0,
            heading: 0,
            speed: 0,
            speedAccuracy: 0,
            altitudeAccuracy: 0,
            headingAccuracy: 0);

        state = state.copyWith(
          isTracking: true,
          startPosition: position,
          startTime: DateTime.parse(timeStr),
        );
      }
    }
  }

  Future<void> startTrip() async {
    try {
      state = state.copyWith(error: null);

      // 1. Check Permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          state = state.copyWith(error: 'Location permissions are denied');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        state = state.copyWith(
            error: 'Location permissions are permanently denied');
        return;
      }

      // 2. Get Current Position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // 3. Save to Local Storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_kIsTracking, true);
      await prefs.setDouble(_kStartLat, position.latitude);
      await prefs.setDouble(_kStartLng, position.longitude);
      await prefs.setString(_kStartTime, DateTime.now().toIso8601String());

      // 4. Update State
      state = state.copyWith(
        isTracking: true,
        startPosition: position,
        startTime: DateTime.now(),
        currentDistance: 0,
      );
    } catch (e) {
      state = state.copyWith(error: 'Failed to start trip: $e');
    }
  }

  Future<double> stopTracking() async {
    if (!state.isTracking || state.startPosition == null) return 0.0;

    try {
      // 1. Get End Position
      final endPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // 2. Calculate Distance (in meters)
      final distanceMeters = Geolocator.distanceBetween(
        state.startPosition!.latitude,
        state.startPosition!.longitude,
        endPosition.latitude,
        endPosition.longitude,
      );

      // Convert to KM
      final distanceKm = distanceMeters / 1000;

      // 3. Clear Tracking State (but keep data in memory until submitted)
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_kIsTracking);
      await prefs.remove(_kStartLat);
      await prefs.remove(_kStartLng);
      await prefs.remove(_kStartTime);

      state = state.copyWith(
        isTracking: false,
        currentDistance: distanceMeters,
      );

      return distanceKm;
    } catch (e) {
      state = state.copyWith(error: 'Failed to stop tracking: $e');
      return 0.0;
    }
  }

  Future<bool> submitTrip({
    required bool withClient,
    String? clientId,
    String? startLocation,
    String? endLocation,
  }) async {
    state = state.copyWith(isSyncing: true, error: null);

    try {
      // 1. Prepare Data
      final distanceKm = state.currentDistance / 1000;
      final tripData = {
        'date': DateTime.now().toIso8601String(),
        'startLocation': startLocation ??
            '${state.startPosition?.latitude}, ${state.startPosition?.longitude}',
        'endLocation':
            endLocation ?? 'Current Location', // Ideally reverse geocode this
        'distance': distanceKm,
        'tripType': withClient ? 'WITH_CLIENT' : 'BETWEEN_CLIENTS',
        'clientId': clientId,
      };

      // 2. Call API
      final response = await _api.post('api/trips', body: tripData);

      if (response != null &&
          (response['success'] == true || response['status'] == 201)) {
        // Success
        state = MileageState(); // Reset completely
        return true;
      } else {
        // API Error
        final message = response == null ? null : response['message'];
        throw Exception(message?.toString() ?? 'API failed');
      }
    } catch (e) {
      // 3. Offline Handling: Cache Trip
      await _cacheTrip({
        'date': DateTime.now().toIso8601String(),
        'startLocation': startLocation,
        'endLocation': endLocation,
        'distance': state.currentDistance / 1000,
        'tripType': withClient ? 'WITH_CLIENT' : 'BETWEEN_CLIENTS',
        'clientId': clientId,
        'error': e.toString(),
      });

      state = state.copyWith(
        isSyncing: false,
        error: 'Offline: Trip saved locally. ($e)',
      );
      return false;
    }
  }

  Future<void> _cacheTrip(Map<String, dynamic> tripData) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> unsynced = prefs.getStringList(_kUnsyncedTrips) ?? [];
    unsynced.add(jsonEncode(tripData));
    await prefs.setStringList(_kUnsyncedTrips, unsynced);
  }
}

final mileageControllerProvider =
    StateNotifierProvider<MileageController, MileageState>((ref) {
  return MileageController(ref.read(app_providers.apiMethodProvider));
});
