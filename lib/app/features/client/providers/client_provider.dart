import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/client/models/client_model.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;

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
class ClientNotifier extends Notifier<ClientState> {
  late final ApiMethod _apiMethod;

  @override
  ClientState build() {
    _apiMethod = ref.watch(apiMethodProvider);
    return ClientState(clients: [], isLoading: false);
  }

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

  Future<void> fetchDeletedClientsByOrganization(String organizationId) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final List<Map<String, dynamic>> clientsData =
          await _apiMethod.getDeletedClientsByOrganizationId(organizationId);

      final List<Patient> clients =
          clientsData.map((json) => Patient.fromJson(json)).toList();

      state = state.copyWith(clients: clients, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to fetch client history: ${e.toString()}',
      );
    }
  }

  // Activate client
  Future<Map<String, dynamic>> activateClient(String email) async {
    state = state.copyWith(error: null);
    final response = await _apiMethod.post('activate', body: {'email': email});
    if (response['success'] != true && response['statusCode'] != 200) {
      final message = response['message']?.toString() ?? 'Activation failed';
      state = state.copyWith(error: message);
      throw Exception(message);
    }
    return response;
  }

  Future<Map<String, dynamic>> updateClient({
    required String clientId,
    required String clientFirstName,
    required String clientLastName,
    required String clientPhone,
    required String clientAddress,
    required String clientCity,
    required String clientState,
    required String clientZip,
    String? businessName,
    required String userEmail,
    required String organizationId,
  }) async {
    state = state.copyWith(error: null);
    final response = await _apiMethod.updateClient(
      clientId: clientId,
      clientFirstName: clientFirstName,
      clientLastName: clientLastName,
      clientPhone: clientPhone,
      clientAddress: clientAddress,
      clientCity: clientCity,
      clientState: clientState,
      clientZip: clientZip,
      businessName: businessName,
      userEmail: userEmail,
      organizationId: organizationId,
    );

    if (response['success'] != true &&
        response['statusCode'] != 200 &&
        response['statusCode'] != 201) {
      final message = response['message']?.toString() ?? 'Update failed';
      state = state.copyWith(error: message);
      throw Exception(message);
    }

    return response;
  }

  Future<Map<String, dynamic>> deleteClient({
    required String clientId,
    required String userEmail,
    required String organizationId,
    bool forceDelete = false,
  }) async {
    state = state.copyWith(error: null);
    final response = await _apiMethod.deleteClient(
      clientId: clientId,
      userEmail: userEmail,
      organizationId: organizationId,
      forceDelete: forceDelete,
    );

    if (response['success'] != true &&
        response['statusCode'] != 200 &&
        response['statusCode'] != 201) {
      final message = response['message']?.toString() ?? 'Delete failed';
      state = state.copyWith(error: message);
      throw Exception(message);
    }

    return response;
  }

  Future<Map<String, dynamic>> restoreClient({
    required String clientId,
    required String userEmail,
    required String organizationId,
    String? clientFirstName,
    String? clientLastName,
    String? clientPhone,
    String? clientAddress,
    String? clientCity,
    String? clientState,
    String? clientZip,
    String? businessName,
  }) async {
    state = state.copyWith(error: null);
    final response = await _apiMethod.restoreClient(
      clientId: clientId,
      userEmail: userEmail,
      organizationId: organizationId,
      clientFirstName: clientFirstName,
      clientLastName: clientLastName,
      clientPhone: clientPhone,
      clientAddress: clientAddress,
      clientCity: clientCity,
      clientState: clientState,
      clientZip: clientZip,
      businessName: businessName,
    );

    if (response['success'] != true &&
        response['statusCode'] != 200 &&
        response['statusCode'] != 201) {
      final message = response['message']?.toString() ?? 'Restore failed';
      state = state.copyWith(error: message);
      throw Exception(message);
    }

    return response;
  }

  Future<Map<String, dynamic>> markClientActivatedByAdmin({
    required String clientId,
    required String userEmail,
    required String organizationId,
  }) async {
    state = state.copyWith(error: null);
    final response = await _apiMethod.markClientActivatedByAdmin(
      clientId: clientId,
      userEmail: userEmail,
      organizationId: organizationId,
    );

    if (response['success'] != true &&
        response['statusCode'] != 200 &&
        response['statusCode'] != 201) {
      final message = response['message']?.toString() ?? 'Activation failed';
      state = state.copyWith(error: message);
      throw Exception(message);
    }

    return response;
  }

  // Clear clients
  void clearClients() {
    state = ClientState(clients: [], isLoading: false);
  }
}

// Provider for ApiMethod
final apiMethodProvider = Provider<ApiMethod>(
  (ref) => ref.read(app_providers.apiMethodProvider),
);

// Provider for ClientNotifier
final clientProvider =
    NotifierProvider<ClientNotifier, ClientState>(() {
  return ClientNotifier();
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
