import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/trip_model.dart';
import '../repositories/mileage_repository.dart';
import '../../../shared/utils/shared_preferences_utils.dart';
import '../controllers/mileage_controller.dart';

class MileageViewState {
  final bool isTracking;
  final DateTime? trackingStartTime;
  final String? error;
  final bool isWithClient;
  final String? selectedClientId;
  final List<Map<String, String>> assignableClients;
  final bool isLoadingClients;
  final List<Trip> recentTrips;
  final bool isLoadingHistory;

  const MileageViewState({
    this.isTracking = false,
    this.trackingStartTime,
    this.error,
    this.isWithClient = false,
    this.selectedClientId,
    this.assignableClients = const [],
    this.isLoadingClients = false,
    this.recentTrips = const [],
    this.isLoadingHistory = false,
  });

  MileageViewState copyWith({
    bool? isTracking,
    DateTime? trackingStartTime,
    String? error,
    bool? isWithClient,
    String? selectedClientId,
    List<Map<String, String>>? assignableClients,
    bool? isLoadingClients,
    List<Trip>? recentTrips,
    bool? isLoadingHistory,
  }) {
    return MileageViewState(
      isTracking: isTracking ?? this.isTracking,
      trackingStartTime: trackingStartTime ?? this.trackingStartTime,
      error: error,
      isWithClient: isWithClient ?? this.isWithClient,
      selectedClientId: selectedClientId ?? this.selectedClientId,
      assignableClients: assignableClients ?? this.assignableClients,
      isLoadingClients: isLoadingClients ?? this.isLoadingClients,
      recentTrips: recentTrips ?? this.recentTrips,
      isLoadingHistory: isLoadingHistory ?? this.isLoadingHistory,
    );
  }
}

final mileageViewModelProvider =
    NotifierProvider<MileageViewModel, MileageViewState>(MileageViewModel.new);

class MileageViewModel extends Notifier<MileageViewState> {
  late final MileageController _controller;
  late final MileageRepository _repository;

  // TextEditingControllers are not in state (they are Flutter objects, not serializable)
  final startLocationController = TextEditingController();
  final endLocationController = TextEditingController();
  final distanceController = TextEditingController();

  @override
  MileageViewState build() {
    _controller = ref.watch(mileageControllerProvider.notifier);
    _repository = ref.watch(mileageRepositoryProvider);

    // Sync from the backing MileageController state
    final controllerState = ref.watch(mileageControllerProvider);
    ref.onDispose(() {
      startLocationController.dispose();
      endLocationController.dispose();
      distanceController.dispose();
    });

    Future.microtask(() {
      _fetchRecentTrips();
      _loadAssignableClients();
    });

    return MileageViewState(
      isTracking: controllerState.isTracking,
      trackingStartTime: controllerState.startTime,
      error: controllerState.error,
    );
  }

  // GPS Tracking Actions
  Future<void> startTracking() async {
    state = state.copyWith(error: null);
    await _controller.startTrip();
    _syncFromController();
  }

  Future<double> stopTracking() async {
    state = state.copyWith(error: null);
    final distance = await _controller.stopTracking();
    _syncFromController();
    return distance;
  }

  void _syncFromController() {
    final cs = ref.read(mileageControllerProvider);
    state = state.copyWith(
      isTracking: cs.isTracking,
      trackingStartTime: cs.startTime,
      error: cs.error,
    );
  }

  Future<bool> submitTrip({
    bool? withClient,
    String? clientId,
    String? startLocation,
    String? endLocation,
  }) async {
    final useWithClient = withClient ?? state.isWithClient;
    final resolvedClientId = useWithClient
        ? (clientId ?? state.selectedClientId)
        : null;
    if (useWithClient &&
        (resolvedClientId == null || resolvedClientId.isEmpty)) {
      state = state.copyWith(
        error: 'Please select a client before submitting a client trip.',
      );
      return false;
    }

    state = state.copyWith(error: null);
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

  void toggleWithClient(bool value) {
    state = state.copyWith(
      isWithClient: value,
      selectedClientId: value ? state.selectedClientId : null,
    );
    if (value && state.assignableClients.isEmpty) {
      _loadAssignableClients(force: true);
    }
  }

  void selectClient(String? clientId) {
    state = state.copyWith(selectedClientId: clientId);
  }

  Future<void> saveManualTrip() async {
    state = state.copyWith(error: null);
    if (startLocationController.text.isEmpty ||
        endLocationController.text.isEmpty ||
        distanceController.text.isEmpty) {
      state = state.copyWith(
        error: 'Please fill start location, end location and distance.',
      );
      return;
    }
    if (state.isWithClient &&
        (state.selectedClientId == null || state.selectedClientId!.isEmpty)) {
      state = state.copyWith(
        error: 'Please select a client before logging a client trip.',
      );
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
        'tripType': state.isWithClient ? 'WITH_CLIENT' : 'BETWEEN_CLIENTS',
        'clientId': state.selectedClientId,
      };

      final success = await _repository.saveTrip(tripData);

      if (success) {
        startLocationController.clear();
        endLocationController.clear();
        distanceController.clear();
        state = state.copyWith(isWithClient: false, selectedClientId: null);
        await _fetchRecentTrips();
      } else {
        state = state.copyWith(
          error: 'Could not save trip right now. Please try again.',
        );
      }
    } catch (e) {
      state = state.copyWith(error: 'Failed to save manual trip.');
    }
  }

  Future<void> _loadAssignableClients({bool force = false}) async {
    if (state.isLoadingClients && !force) return;
    if (state.assignableClients.isNotEmpty && !force) return;

    state = state.copyWith(isLoadingClients: true);

    try {
      final prefs = await SharedPreferencesUtils.getInstance();
      String? userEmail =
          prefs.getUserEmail() ??
          await prefs.getUserEmailFromSharedPreferences();

      if ((userEmail == null || userEmail.isEmpty) &&
          FirebaseAuth.instance.currentUser != null) {
        userEmail = FirebaseAuth.instance.currentUser!.email;
      }

      if (userEmail == null || userEmail.isEmpty) {
        state = state.copyWith(isLoadingClients: false);
        return;
      }

      final clients = await _repository.getAssignableClients(
        userEmail.toLowerCase().trim(),
      );

      final resolvedClientId =
          state.selectedClientId != null &&
              !clients.any((c) => c['id'] == state.selectedClientId)
          ? null
          : state.selectedClientId;

      state = state.copyWith(
        assignableClients: clients,
        selectedClientId: resolvedClientId,
        isLoadingClients: false,
      );
    } catch (e) {
      state = state.copyWith(isLoadingClients: false);
    }
  }

  Future<void> _fetchRecentTrips() async {
    state = state.copyWith(isLoadingHistory: true);

    try {
      final prefs = await SharedPreferencesUtils.getInstance();
      final userId = prefs.getUserId();

      if (userId != null) {
        final trips = await _repository.getTrips(userId);
        state = state.copyWith(recentTrips: trips, isLoadingHistory: false);
      } else {
        state = state.copyWith(isLoadingHistory: false);
      }
    } catch (e) {
      state = state.copyWith(isLoadingHistory: false);
    }
  }
}
