import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/trip_model.dart';
import '../repositories/mileage_repository.dart';
import '../../../shared/utils/shared_preferences_utils.dart';
import '../controllers/mileage_controller.dart';

class MileageViewModel extends ChangeNotifier {
  final MileageController _controller;
  final MileageState _state;
  final MileageRepository _repository;

  MileageViewModel(this._controller, this._state, this._repository) {
    _fetchRecentTrips();
  }

  bool get isTracking => _state.isTracking;
  String? get error => _state.error;

  bool _isWithClient = false;
  bool get isWithClient => _isWithClient;
  
  String? _selectedClientId;
  String? get selectedClientId => _selectedClientId;

  // Manual Entry Form Controllers
  final startLocationController = TextEditingController();
  final endLocationController = TextEditingController();
  final distanceController = TextEditingController();

  List<Trip> _recentTrips = [];
  List<Trip> get recentTrips => _recentTrips;
  bool _isLoadingHistory = false;
  bool get isLoadingHistory => _isLoadingHistory;

  // GPS Tracking Actions
  Future<void> startTracking() async {
    await _controller.startTrip();
    notifyListeners();
  }

  Future<double> stopTracking() async {
    final distance = await _controller.stopTracking();
    notifyListeners();
    return distance;
  }
  
  Future<bool> submitTrip(String startLocation, String endLocation) async {
    final success = await _controller.submitTrip(
      withClient: _isWithClient,
      clientId: _selectedClientId,
      startLocation: startLocation,
      endLocation: endLocation,
    );
    
    if (success) {
      _fetchRecentTrips(); // Refresh history
    }
    return success;
  }

  // UI Form Actions
  void toggleWithClient(bool value) {
    _isWithClient = value;
    if (!value) _selectedClientId = null;
    notifyListeners();
  }
  
  void selectClient(String? clientId) {
    _selectedClientId = clientId;
    notifyListeners();
  }

  Future<void> saveManualTrip() async {
    if (startLocationController.text.isEmpty || 
        endLocationController.text.isEmpty || 
        distanceController.text.isEmpty) {
      // Basic validation
      return;
    }

    try {
      final prefs = await SharedPreferencesUtils.getInstance();
      final userId = prefs.getUserId();
      final orgId = prefs.getOrganizationId();

      if (userId == null || orgId == null) return;

      final tripData = {
        'organizationId': orgId,
        'userId': userId,
        'date': DateTime.now().toIso8601String(),
        'startLocation': startLocationController.text,
        'endLocation': endLocationController.text,
        'distance': double.tryParse(distanceController.text) ?? 0.0,
        'tripType': _isWithClient ? 'WITH_CLIENT' : 'BETWEEN_CLIENTS',
        'clientId': _selectedClientId,
      };

      final success = await _repository.saveTrip(tripData);

      if (success) {
        // Clear inputs
        startLocationController.clear();
        endLocationController.clear();
        distanceController.clear();
        _isWithClient = false;
        _selectedClientId = null;
        
        _fetchRecentTrips();
      }
    } catch (e) {
      print('Error saving manual trip: $e');
    }
    notifyListeners();
  }

  Future<void> _fetchRecentTrips() async {
    _isLoadingHistory = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferencesUtils.getInstance();
      final userId = prefs.getUserId();
      
      if (userId != null) {
        // Fetch recent trips (no date filter = all recent)
        // Ideally API supports pagination or limit. 
        // For now, repo fetches all, we might want to optimize this later.
        _recentTrips = await _repository.getTrips(userId);
      }
    } catch (e) {
      print('Error fetching history: $e');
    } finally {
      _isLoadingHistory = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    startLocationController.dispose();
    endLocationController.dispose();
    distanceController.dispose();
    super.dispose();
  }
}

final mileageViewModelProvider = ChangeNotifierProvider<MileageViewModel>((ref) {
  final controller = ref.watch(mileageControllerProvider.notifier);
  final state = ref.watch(mileageControllerProvider);
  final repository = ref.watch(mileageRepositoryProvider);
  return MileageViewModel(controller, state, repository);
});
