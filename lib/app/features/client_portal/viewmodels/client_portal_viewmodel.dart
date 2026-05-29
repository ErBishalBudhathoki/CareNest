import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:carenest/app/features/client_portal/repositories/client_portal_repository.dart';
import 'package:carenest/app/features/client_portal/models/client_portal_models.dart';

final clientPortalViewModelProvider =
    StateNotifierProvider<ClientPortalViewModel, ClientPortalState>((ref) {
  final repository = ref.watch(clientPortalRepositoryProvider);
  return ClientPortalViewModel(repository);
});

const Object _stateUnset = Object();

class ClientPortalState {
  final bool isLoading;
  final String? error;
  final ClientDashboard? dashboard;
  final WorkerLocation? workerLocation;
  final AppointmentStatus? appointmentStatus;
  final List<ServiceHistory> serviceHistory;

  ClientPortalState({
    this.isLoading = false,
    this.error,
    this.dashboard,
    this.workerLocation,
    this.appointmentStatus,
    this.serviceHistory = const [],
  });

  ClientPortalState copyWith({
    bool? isLoading,
    String? error,
    ClientDashboard? dashboard,
    Object? workerLocation = _stateUnset,
    Object? appointmentStatus = _stateUnset,
    List<ServiceHistory>? serviceHistory,
  }) {
    return ClientPortalState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      dashboard: dashboard ?? this.dashboard,
      workerLocation: identical(workerLocation, _stateUnset)
          ? this.workerLocation
          : workerLocation as WorkerLocation?,
      appointmentStatus: identical(appointmentStatus, _stateUnset)
          ? this.appointmentStatus
          : appointmentStatus as AppointmentStatus?,
      serviceHistory: serviceHistory ?? this.serviceHistory,
    );
  }
}

class ClientPortalViewModel extends StateNotifier<ClientPortalState> {
  final ClientPortalRepository _repository;

  ClientPortalViewModel(this._repository) : super(ClientPortalState());

  /// Load client dashboard data
  Future<void> loadDashboard(String clientId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _repository.getClientDashboard(clientId: clientId);
      if (response['success'] == true && response['data'] != null) {
        final dashboard = ClientDashboard.fromJson(response['data']);
        state = state.copyWith(isLoading: false, dashboard: dashboard);
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response['message'] ?? 'Failed to load dashboard',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Get real-time worker location
  Future<void> getWorkerLocation(String appointmentId) async {
    try {
      final response =
          await _repository.getWorkerLocation(appointmentId: appointmentId);
      if (response['success'] == true && response['data'] != null) {
        try {
          final location = WorkerLocation.fromJson(response['data']);
          state = state.copyWith(workerLocation: location, error: null);
        } catch (e) {
          state = state.copyWith(
            workerLocation: null,
            error: 'Worker location data is currently unavailable',
          );
        }
      } else {
        state = state.copyWith(
          workerLocation: null,
          error: response['message'] ?? 'Location is currently unavailable',
        );
      }
    } catch (e) {
      state = state.copyWith(workerLocation: null, error: e.toString());
    }
  }

  /// Get appointment status with ETA
  Future<void> getAppointmentStatus(String appointmentId) async {
    try {
      final response =
          await _repository.getAppointmentStatus(appointmentId: appointmentId);
      if (response['success'] == true && response['data'] != null) {
        final status = AppointmentStatus.fromJson(response['data']);
        state = state.copyWith(appointmentStatus: status, error: null);
      } else {
        state = state.copyWith(
          appointmentStatus: null,
          error: response['message'] ?? 'Unable to load appointment status',
        );
      }
    } catch (e) {
      state = state.copyWith(appointmentStatus: null, error: e.toString());
    }
  }

  /// Send message to worker
  Future<bool> sendMessage(Map<String, dynamic> messageData) async {
    try {
      final response = await _repository.sendMessage(messageData: messageData);
      final success = response['success'] == true;
      state = state.copyWith(
        error: success ? null : response['message'] ?? 'Failed to send message',
      );
      return success;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  /// Submit service feedback
  Future<bool> submitFeedback(Map<String, dynamic> feedbackData) async {
    try {
      final response =
          await _repository.submitFeedback(feedbackData: feedbackData);
      final success = response['success'] == true;
      state = state.copyWith(
        error: success
            ? null
            : response['message'] ?? 'Failed to submit service feedback',
      );
      return success;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  /// Load service history
  Future<void> loadServiceHistory(
    String clientId, {
    bool silent = false,
    int? limit,
  }) async {
    if (silent) {
      state = state.copyWith(error: null);
    } else {
      state = state.copyWith(isLoading: true, error: null);
    }
    try {
      final response = await _repository.getServiceHistory(
        clientId: clientId,
        limit: limit,
      );
      if (response['success'] == true && response['data'] != null) {
        final history = (response['data'] as List)
            .map((item) => ServiceHistory.fromJson(item))
            .toList();
        state = state.copyWith(
          isLoading: silent ? state.isLoading : false,
          serviceHistory: history,
        );
      } else {
        state = state.copyWith(
          isLoading: silent ? state.isLoading : false,
          error: response['message'] ?? 'Failed to load service history',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: silent ? state.isLoading : false,
        error: e.toString(),
      );
    }
  }
}
