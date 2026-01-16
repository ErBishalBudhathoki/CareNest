import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../models/trip.dart';
import '../../../../backend/api_method.dart';
import '../../../shared/utils/shared_preferences_utils.dart';
import '../controllers/mileage_controller.dart';

class MileageViewModel extends ChangeNotifier {
  final MileageController _controller;
  final MileageState _state;

  MileageViewModel(this._controller, this._state) {
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

    // Since controller.submitTrip uses internal state for distance, 
    // we might need a separate method for manual entry or hack it.
    // The controller assumes GPS tracking for distance.
    // Let's check MileageController... 
    // It uses `state.currentDistance`.
    // We should probably add a `submitManualTrip` to controller or just handle it here via API.
    // For now, I'll use API directly here to avoid changing controller too much, 
    // or better: update controller to accept distance.
    
    // I'll call the API directly here for manual entry to keep it simple and robust.
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

      final api = ApiMethod();
      final response = await api.post('api/trips', body: tripData); // Fixed endpoint

      if (response != null && (response['success'] == true || response['status'] == 201)) {
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
        final api = ApiMethod();
        final response = await api.get('api/trips/employee/$userId'); // Fixed endpoint
        
        if (response != null && response['success'] == true) {
          final List<dynamic> data = response['data'];
          _recentTrips = data.map((json) => Trip.fromJson(json)).toList();
        }
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
  return MileageViewModel(controller, state);
});
