// Appointment Providers - Appointment scheduling and management
//
// Contains providers for appointment data and state management.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/core_providers.dart';

// ==================== APPOINTMENT STATE ====================

// State for appointment list with loading and error tracking
class AppointmentState {
  final List<dynamic> appointments;
  final bool isLoading;
  final String? error;

  const AppointmentState({
    this.appointments = const [],
    this.isLoading = false,
    this.error,
  });

  AppointmentState copyWith({
    List<dynamic>? appointments,
    bool? isLoading,
    String? error,
  }) {
    return AppointmentState(
      appointments: appointments ?? this.appointments,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

// Notifier for appointment state management
class AppointmentNotifier extends StateNotifier<AppointmentState> {
  final ApiMethod _apiMethod;

  AppointmentNotifier(this._apiMethod) : super(const AppointmentState());

  /// Fetch appointments for a specific user
  Future<void> fetchAppointments(String email) async {
    state = state.copyWith(isLoading: true);
    try {
      final data = await _apiMethod.getAppointmentData(email);
      state = state.copyWith(appointments: data, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  /// Clear all appointments
  void clearAppointments() {
    state = const AppointmentState();
  }
}

// Appointment provider
final appointmentProvider = StateNotifierProvider<AppointmentNotifier, AppointmentState>((ref) {
  return AppointmentNotifier(ref.read(apiMethodProvider));
});

// Derived provider for appointment count
final appointmentCountProvider = Provider<int>((ref) {
  final state = ref.watch(appointmentProvider);
  return state.appointments.length;
});

// Derived provider for loading status
final appointmentsLoadingProvider = Provider<bool>((ref) {
  final state = ref.watch(appointmentProvider);
  return state.isLoading;
});
