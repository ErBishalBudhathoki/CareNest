import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/notifications/models/geofence_model.dart';
import 'package:carenest/app/features/notifications/repositories/notification_repository.dart';

class GeofenceState {
  final List<GeofenceModel> geofences;
  final bool isLoading;
  final String? errorMessage;
  
  const GeofenceState({
    this.geofences = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  GeofenceState copyWith({
    List<GeofenceModel>? geofences,
    bool? isLoading,
    String? errorMessage,
  }) {
    return GeofenceState(
      geofences: geofences ?? this.geofences,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class GeofenceViewModel extends Notifier<GeofenceState> {
  late final NotificationRepository _repository;

  @override
  GeofenceState build() {
    _repository = ref.watch(notificationRepositoryProvider);
    return const GeofenceState();
  }

  /// Load geofences
  Future<void> loadGeofences({String? clientId}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final geofences = await _repository.getGeofences(clientId: clientId);
      state = state.copyWith(geofences: geofences);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
      // debugPrint('Error loading geofences: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  /// Add a new geofence
  Future<void> addGeofence(GeofenceModel geofence) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final newGeofence = await _repository.createGeofence(geofence);
      state.geofences.add(newGeofence);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
      // debugPrint('Error adding geofence: $e');
      rethrow; // Allow the view to handle the specific error (e.g., show a snackbar)
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  /// Delete a geofence
  Future<void> deleteGeofence(String id) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await _repository.deleteGeofence(id);
      state.geofences.removeWhere((g) => g.id == id);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
      // debugPrint('Error deleting geofence: $e');
      rethrow;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
