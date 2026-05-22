import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/trip_model.dart';
import '../repositories/mileage_repository.dart';
import '../../../shared/utils/shared_preferences_utils.dart';
import '../controllers/mileage_controller.dart';

class MileageViewModel extends ChangeNotifier {
  final MileageController _controller;
  MileageState _state;
  final MileageRepository _repository;
  bool _isDisposed = false;
  String? _localError;

  MileageViewModel(this._controller, this._state, this._repository) {
    _fetchRecentTrips();
    _loadAssignableClients();
  }

  bool get isTracking => _state.isTracking;
  DateTime? get trackingStartTime => _state.startTime;
  String? get error => _localError ?? _state.error;

  bool _isWithClient = false;
  bool get isWithClient => _isWithClient;

  String? _selectedClientId;
  String? get selectedClientId => _selectedClientId;

  List<Map<String, String>> _assignableClients = [];
  List<Map<String, String>> get assignableClients => _assignableClients;
  bool _loadingClients = false;
  bool get isLoadingClients => _loadingClients;

  // Manual Entry Form Controllers
  final startLocationController = TextEditingController();
  final endLocationController = TextEditingController();
  final distanceController = TextEditingController();

  List<Trip> _recentTrips = [];
  List<Trip> get recentTrips => _recentTrips;
  bool _isLoadingHistory = false;
  bool get isLoadingHistory => _isLoadingHistory;

  void updateState(MileageState nextState) {
    _state = nextState;
    _notifyListenersSafely();
  }

  void _notifyListenersSafely() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }

  void _setLocalError(String? message) {
    _localError = message;
    _notifyListenersSafely();
  }

  // GPS Tracking Actions
  Future<void> startTracking() async {
    _localError = null;
    await _controller.startTrip();
  }

  Future<double> stopTracking() async {
    _localError = null;
    final distance = await _controller.stopTracking();
    return distance;
  }

  Future<bool> submitTrip({
    bool? withClient,
    String? clientId,
    String? startLocation,
    String? endLocation,
  }) async {
    final useWithClient = withClient ?? _isWithClient;
    final resolvedClientId =
        useWithClient ? (clientId ?? _selectedClientId) : null;
    if (useWithClient &&
        (resolvedClientId == null || resolvedClientId.isEmpty)) {
      _setLocalError('Please select a client before submitting a client trip.');
      return false;
    }

    _localError = null;
    final success = await _controller.submitTrip(
      withClient: useWithClient,
      clientId: resolvedClientId,
      startLocation: startLocation,
      endLocation: endLocation,
    );

    if (success) {
      await _fetchRecentTrips();
    }
    return success;
  }

  // UI Form Actions
  void toggleWithClient(bool value) {
    _isWithClient = value;
    if (!value) _selectedClientId = null;
    if (value && _assignableClients.isEmpty) {
      _loadAssignableClients(force: true);
    }
    notifyListeners();
  }

  void selectClient(String? clientId) {
    _selectedClientId = clientId;
    notifyListeners();
  }

  Future<void> saveManualTrip() async {
    _localError = null;
    if (startLocationController.text.isEmpty ||
        endLocationController.text.isEmpty ||
        distanceController.text.isEmpty) {
      _setLocalError('Please fill start location, end location and distance.');
      return;
    }
    if (_isWithClient &&
        (_selectedClientId == null || _selectedClientId!.isEmpty)) {
      _setLocalError('Please select a client before logging a client trip.');
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

        await _fetchRecentTrips();
      } else {
        _setLocalError('Could not save trip right now. Please try again.');
      }
    } catch (e) {
      print('Error saving manual trip: $e');
      _setLocalError('Failed to save manual trip.');
    }
    _notifyListenersSafely();
  }

  Future<void> _loadAssignableClients({bool force = false}) async {
    if (_loadingClients && !force) return;
    if (_assignableClients.isNotEmpty && !force) return;

    _loadingClients = true;
    _notifyListenersSafely();

    try {
      final prefs = await SharedPreferencesUtils.getInstance();
      String? userEmail =
          prefs.getUserEmail() ?? await prefs.getUserEmailFromSharedPreferences();

      if ((userEmail == null || userEmail.isEmpty) &&
          FirebaseAuth.instance.currentUser != null) {
        userEmail = FirebaseAuth.instance.currentUser!.email;
      }

      if (userEmail == null || userEmail.isEmpty) {
        return;
      }

      _assignableClients = await _repository
          .getAssignableClients(userEmail.toLowerCase().trim());

      if (_selectedClientId != null &&
          !_assignableClients.any((c) => c['id'] == _selectedClientId)) {
        _selectedClientId = null;
      }
    } catch (e) {
      print('Error loading assignable clients: $e');
    } finally {
      _loadingClients = false;
      _notifyListenersSafely();
    }
  }

  Future<void> _fetchRecentTrips() async {
    _isLoadingHistory = true;
    _notifyListenersSafely();

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
      if (!_isDisposed) {
        _isLoadingHistory = false;
        _notifyListenersSafely();
      }
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    startLocationController.dispose();
    endLocationController.dispose();
    distanceController.dispose();
    super.dispose();
  }
}

final mileageViewModelProvider =
    ChangeNotifierProvider<MileageViewModel>((ref) {
  final controller = ref.read(mileageControllerProvider.notifier);
  final initialState = ref.read(mileageControllerProvider);
  final repository = ref.read(mileageRepositoryProvider);
  final viewModel = MileageViewModel(controller, initialState, repository);

  ref.listen<MileageState>(mileageControllerProvider, (_, next) {
    viewModel.updateState(next);
  });

  return viewModel;
});
