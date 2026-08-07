import 'dart:convert';
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../backend/api_method.dart';
import '../../../shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;

// State class for Mileage
class MileageState {
  static const Object _noErrorChange = Object();

  late final bool isTracking;
  late final Position? startPosition;
  late final DateTime? startTime;
  late final double currentDistance; // in meters
  late final bool isSyncing;
  late final String? error;
  late final List<Position> routePoints;

  MileageState({
    this.isTracking = false,
    this.startPosition,
    this.startTime,
    this.currentDistance = 0.0,
    this.isSyncing = false,
    this.error,
    this.routePoints = const [],
  });

  MileageState copyWith({
    bool? isTracking,
    Position? startPosition,
    DateTime? startTime,
    double? currentDistance,
    bool? isSyncing,
    List<Position>? routePoints,
    Object? error = _noErrorChange,
  }) {
    return MileageState(
      isTracking: isTracking ?? this.isTracking,
      startPosition: startPosition ?? this.startPosition,
      startTime: startTime ?? this.startTime,
      currentDistance: currentDistance ?? this.currentDistance,
      isSyncing: isSyncing ?? this.isSyncing,
      routePoints: routePoints ?? this.routePoints,
      error: identical(error, _noErrorChange) ? this.error : error as String?,
    );
  }
}

class MileageController extends Notifier<MileageState> {
  late final ApiMethod _api;
  StreamSubscription<Position>? _positionSubscription;

  @override
  MileageState build() {
    _api = ref.watch(app_providers.apiMethodProvider);
    ref.onDispose(() {
      _positionSubscription?.cancel();
    });
    Future.microtask(() => _loadState());
    return MileageState();
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
          headingAccuracy: 0,
        );

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
          error: 'Location permissions are permanently denied',
        );
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
        routePoints: [position],
      );

      _startPositionTracking();
    } catch (e) {
      state = state.copyWith(error: 'Failed to start trip: $e');
    }
  }

  void _startPositionTracking() {
    _positionSubscription?.cancel();
    _positionSubscription =
        Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.bestForNavigation,
            distanceFilter: 5,
          ),
        ).listen(
          (position) {
            if (!state.isTracking) return;

            final points = List<Position>.from(state.routePoints);
            var updatedDistance = state.currentDistance;

            if (points.isNotEmpty) {
              final previous = points.last;
              final segmentMeters = Geolocator.distanceBetween(
                previous.latitude,
                previous.longitude,
                position.latitude,
                position.longitude,
              );
              if (segmentMeters.isFinite && segmentMeters > 0.5) {
                updatedDistance += segmentMeters;
              }
            }

            points.add(position);
            state = state.copyWith(
              routePoints: points,
              currentDistance: updatedDistance,
            );
          },
          onError: (e) {
            state = state.copyWith(error: 'Location tracking error: $e');
          },
        );
  }

  Future<double> stopTracking() async {
    if (!state.isTracking || state.startPosition == null) return 0.0;

    try {
      await _positionSubscription?.cancel();
      _positionSubscription = null;

      // 1. Get End Position
      final endPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final points = List<Position>.from(state.routePoints);
      var totalMeters = state.currentDistance;

      if (points.isEmpty) {
        points.add(state.startPosition!);
      }

      final last = points.last;
      final finalSegment = Geolocator.distanceBetween(
        last.latitude,
        last.longitude,
        endPosition.latitude,
        endPosition.longitude,
      );
      if (finalSegment.isFinite && finalSegment > 0.5) {
        totalMeters += finalSegment;
      }

      if (finalSegment > 0.5 || points.length == 1) {
        points.add(endPosition);
      }

      if (totalMeters <= 0 && points.length >= 2) {
        totalMeters = _computePathDistanceMeters(points);
      }

      // 3. Clear Tracking State (but keep data in memory until submitted)
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_kIsTracking);
      await prefs.remove(_kStartLat);
      await prefs.remove(_kStartLng);
      await prefs.remove(_kStartTime);

      state = state.copyWith(
        isTracking: false,
        currentDistance: totalMeters,
        routePoints: points,
      );

      return totalMeters / 1000;
    } catch (e) {
      state = state.copyWith(error: 'Failed to stop tracking: $e');
      return 0.0;
    }
  }

  double _computePathDistanceMeters(List<Position> points) {
    if (points.length < 2) return 0;
    double total = 0;
    for (var i = 1; i < points.length; i++) {
      total += Geolocator.distanceBetween(
        points[i - 1].latitude,
        points[i - 1].longitude,
        points[i].latitude,
        points[i].longitude,
      );
    }
    return total;
  }

  Future<bool> submitTrip({
    required bool withClient,
    String? clientId,
    String? startLocation,
    String? endLocation,
  }) async {
    state = state.copyWith(isSyncing: true, error: null);
    List<Position> routePointsForPayload = const [];

    try {
      final sharedPrefs = await SharedPreferencesUtils.getInstance();
      final userId = sharedPrefs.getUserId();
      final organizationId = sharedPrefs.getOrganizationId();
      final userEmail =
          sharedPrefs.getUserEmail() ??
          await sharedPrefs.getUserEmailFromSharedPreferences();

      final firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser != null) {
        final freshToken = await firebaseUser.getIdToken(true);
        if (freshToken?.isNotEmpty == true) {
          await sharedPrefs.saveAuthToken(freshToken!);
        }
      }

      if (userId == null ||
          userId.isEmpty ||
          organizationId == null ||
          organizationId.isEmpty) {
        state = state.copyWith(
          isSyncing: false,
          error:
              'Unable to identify user/organization. Please log out and log in again.',
        );
        return false;
      }

      // 1. Prepare Data
      final distanceKm = state.currentDistance / 1000;
      final routePoints = List<Position>.from(state.routePoints);
      routePointsForPayload = routePoints;
      final startPoint = routePoints.isNotEmpty
          ? routePoints.first
          : state.startPosition;
      final endPoint = routePoints.isNotEmpty ? routePoints.last : null;

      final tripData = {
        'organizationId': organizationId,
        'userId': userId,
        if (userEmail != null && userEmail.isNotEmpty) 'userEmail': userEmail,
        'date': DateTime.now().toIso8601String(),
        'startLocation':
            startLocation ??
            (startPoint != null
                ? '${startPoint.latitude}, ${startPoint.longitude}'
                : 'Current Location'),
        'endLocation':
            endLocation ??
            (endPoint != null
                ? '${endPoint.latitude}, ${endPoint.longitude}'
                : 'Current Location'),
        'distance': distanceKm,
        'tripType': withClient ? 'WITH_CLIENT' : 'BETWEEN_CLIENTS',
        'clientId': clientId,
        if (startPoint != null)
          'startCoordinates': {
            'lat': startPoint.latitude,
            'lng': startPoint.longitude,
          },
        if (endPoint != null)
          'endCoordinates': {
            'lat': endPoint.latitude,
            'lng': endPoint.longitude,
          },
        if (routePoints.length >= 2)
          'routePath': routePoints
              .map(
                (p) => {
                  'lat': p.latitude,
                  'lng': p.longitude,
                  'timestamp': p.timestamp.toIso8601String(),
                },
              )
              .toList(),
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
      final errorText = e.toString();
      final isUnauthorized = errorText.toLowerCase().contains('unauthorized');

      if (isUnauthorized) {
        state = state.copyWith(
          isSyncing: false,
          error: 'Unauthorized. Please log out and log in again.',
        );
        return false;
      }

      final sharedPrefs = await SharedPreferencesUtils.getInstance();
      // 3. Offline Handling: Cache Trip
      await _cacheTrip({
        'organizationId': sharedPrefs.getOrganizationId(),
        'userId': sharedPrefs.getUserId(),
        'userEmail':
            sharedPrefs.getUserEmail() ??
            await sharedPrefs.getUserEmailFromSharedPreferences(),
        'date': DateTime.now().toIso8601String(),
        'startLocation': startLocation,
        'endLocation': endLocation,
        'distance': state.currentDistance / 1000,
        'tripType': withClient ? 'WITH_CLIENT' : 'BETWEEN_CLIENTS',
        'clientId': clientId,
        if (routePointsForPayload.length >= 2)
          'routePath': routePointsForPayload
              .map(
                (p) => {
                  'lat': p.latitude,
                  'lng': p.longitude,
                  'timestamp': p.timestamp.toIso8601String(),
                },
              )
              .toList(),
        'error': e.toString(),
      });

      state = state.copyWith(
        isSyncing: false,
        error: 'Offline: Trip saved locally. ($errorText)',
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
    NotifierProvider<MileageController, MileageState>(MileageController.new);
