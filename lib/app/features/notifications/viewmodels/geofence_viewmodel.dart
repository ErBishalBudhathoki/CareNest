import 'package:flutter/foundation.dart';
import 'package:carenest/app/features/notifications/models/geofence_model.dart';
import 'package:carenest/app/features/notifications/repositories/notification_repository.dart';

class GeofenceViewModel extends ChangeNotifier {
  final NotificationRepository _repository;

  GeofenceViewModel(this._repository);

  List<GeofenceModel> _geofences = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<GeofenceModel> get geofences => _geofences;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Load geofences
  Future<void> loadGeofences({String? clientId}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _geofences = await _repository.getGeofences(clientId: clientId);
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('Error loading geofences: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Add a new geofence
  Future<void> addGeofence(GeofenceModel geofence) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final newGeofence = await _repository.createGeofence(geofence);
      _geofences.add(newGeofence);
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('Error adding geofence: $e');
      rethrow; // Allow the view to handle the specific error (e.g., show a snackbar)
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Delete a geofence
  Future<void> deleteGeofence(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _repository.deleteGeofence(id);
      _geofences.removeWhere((g) => g.id == id);
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('Error deleting geofence: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
