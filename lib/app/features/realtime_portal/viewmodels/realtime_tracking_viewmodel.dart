import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/realtime_portal/models/realtime_portal_models.dart';
import 'package:carenest/app/features/realtime_portal/repositories/realtime_portal_repository.dart';

const _realtimeTrackingNoChange = Object();

/// State for real-time tracking
class RealtimeTrackingState {
  late final bool isLoading;
  late final String? error;
  late final TrackingSession? activeSession;
  late final LiveLocation? liveLocation;
  late final List<GeofenceEvent> geofenceEvents;
  late final AppointmentStatus? appointmentStatus;
  late final bool isTracking;

  RealtimeTrackingState({
    this.isLoading = false,
    this.error,
    this.activeSession,
    this.liveLocation,
    this.geofenceEvents = const [],
    this.appointmentStatus,
    this.isTracking = false,
  });

  RealtimeTrackingState copyWith({
    bool? isLoading,
    Object? error = _realtimeTrackingNoChange,
    Object? activeSession = _realtimeTrackingNoChange,
    Object? liveLocation = _realtimeTrackingNoChange,
    List<GeofenceEvent>? geofenceEvents,
    Object? appointmentStatus = _realtimeTrackingNoChange,
    bool? isTracking,
  }) {
    return RealtimeTrackingState(
      isLoading: isLoading ?? this.isLoading,
      error: identical(error, _realtimeTrackingNoChange)
          ? this.error
          : error as String?,
      activeSession: identical(activeSession, _realtimeTrackingNoChange)
          ? this.activeSession
          : activeSession as TrackingSession?,
      liveLocation: identical(liveLocation, _realtimeTrackingNoChange)
          ? this.liveLocation
          : liveLocation as LiveLocation?,
      geofenceEvents: geofenceEvents ?? this.geofenceEvents,
      appointmentStatus: identical(appointmentStatus, _realtimeTrackingNoChange)
          ? this.appointmentStatus
          : appointmentStatus as AppointmentStatus?,
      isTracking: isTracking ?? this.isTracking,
    );
  }
}

class RealtimeTrackingViewModel extends Notifier<RealtimeTrackingState> {
  late final RealtimePortalRepository _repository;

  @override
  RealtimeTrackingState build() {

    return RealtimeTrackingState();
  }

  /// Start tracking session
  Future<void> startTracking({
    required String appointmentId,
    required String workerId,
    required ClientLocation clientLocation,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final session = await _repository.startTracking(
        appointmentId: appointmentId,
        workerId: workerId,
        clientLocation: clientLocation,
      );

      state = state.copyWith(
        isLoading: false,
        activeSession: session,
        isTracking: true,
      );
    } catch (e) {
      debugPrint('Error starting tracking: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        isTracking: false,
      );
    }
  }

  /// Update worker location
  Future<void> updateLocation({
    required String appointmentId,
    required String workerId,
    required double latitude,
    required double longitude,
    double? accuracy,
  }) async {
    try {
      final location = await _repository.updateLocation(
        appointmentId: appointmentId,
        workerId: workerId,
        latitude: latitude,
        longitude: longitude,
        accuracy: accuracy,
      );

      state = state.copyWith(liveLocation: location);
    } catch (e) {
      debugPrint('Error updating location: $e');
      state = state.copyWith(error: e.toString());
    }
  }

  /// Stop tracking session
  Future<void> stopTracking({required String appointmentId}) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final session = await _repository.stopTracking(
        appointmentId: appointmentId,
      );

      state = state.copyWith(
        isLoading: false,
        activeSession: session,
        isTracking: false,
        liveLocation: null,
      );
    } catch (e) {
      debugPrint('Error stopping tracking: $e');
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Get live tracking data
  Future<void> getLiveTracking({required String appointmentId}) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final location = await _repository.getLiveTracking(
        appointmentId: appointmentId,
      );

      state = state.copyWith(
        isLoading: false,
        liveLocation: location,
        isTracking: location != null,
      );
    } catch (e) {
      debugPrint('Error getting live tracking: $e');
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Handle geofence event from WebSocket
  void handleGeofenceEvent(GeofenceEvent event) {
    final updatedEvents = [...state.geofenceEvents, event];
    state = state.copyWith(geofenceEvents: updatedEvents);
  }

  /// Handle location update from WebSocket
  void handleLocationUpdate(LiveLocation location) {
    state = state.copyWith(liveLocation: location);
  }

  /// Handle appointment status update from WebSocket
  void handleStatusUpdate(AppointmentStatus status) {
    state = state.copyWith(appointmentStatus: status);
  }

  /// Reset state
  void reset() {
    state = RealtimeTrackingState();
  }
}

/// Provider for realtime tracking viewmodel
final realtimeTrackingViewModelProvider =
    NotifierProvider<RealtimeTrackingViewModel, RealtimeTrackingState>(
      RealtimeTrackingViewModel.new,
    );
