import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/client/models/client_model.dart';
import 'package:carenest/backend/api_method.dart';

// State class for client management
class ClientState {
  final List<Patient> clients;
  final bool isLoading;
  final String? error;

  ClientState({
    required this.clients,
    required this.isLoading,
    this.error,
  });

  ClientState copyWith({
    List<Patient>? clients,
    bool? isLoading,
    String? error,
  }) {
    return ClientState(
      clients: clients ?? this.clients,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Client notifier class
class ClientNotifier extends StateNotifier<ClientState> {
  final ApiMethod _apiMethod;

  ClientNotifier(this._apiMethod)
      : super(ClientState(clients: [], isLoading: false));

  // Fetch clients for an organization
  Future<void> fetchClientsByOrganization(String organizationId) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final List<Map<String, dynamic>> clientsData =
          await _apiMethod.getClientsByOrganizationId(organizationId);

      final List<Patient> clients =
          clientsData.map((json) => Patient.fromJson(json)).toList();

      state = state.copyWith(clients: clients, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to fetch clients: ${e.toString()}',
      );
    }
  }

  // Clear clients
  void clearClients() {
    state = ClientState(clients: [], isLoading: false);
  }
}

// Provider for ApiMethod
final apiMethodProvider = Provider<ApiMethod>((ref) => ApiMethod());

// Provider for ClientNotifier
final clientProvider =
    StateNotifierProvider<ClientNotifier, ClientState>((ref) {
  final apiMethod = ref.watch(apiMethodProvider);
  return ClientNotifier(apiMethod);
});

// Provider for getting clients list
final clientsListProvider = Provider<List<Patient>>((ref) {
  final clientState = ref.watch(clientProvider);
  return clientState.clients;
});

// Provider for checking if clients are loading
final clientsLoadingProvider = Provider<bool>((ref) {
  final clientState = ref.watch(clientProvider);
  return clientState.isLoading;
});

// Provider for client error
final clientErrorProvider = Provider<String?>((ref) {
  final clientState = ref.watch(clientProvider);
  return clientState.error;
});
