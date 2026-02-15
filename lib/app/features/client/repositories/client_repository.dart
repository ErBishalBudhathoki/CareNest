import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/core_providers.dart';
import '../models/client_model.dart';

final clientRepositoryProvider = Provider<ClientRepository>((ref) {
  final apiMethod = ref.read(apiMethodProvider);
  return ClientRepository(apiMethod);
});

class ClientRepository {
  final ApiMethod _apiMethod;

  ClientRepository(this._apiMethod);

  Future<List<Patient>> getClients(String organizationId) async {
    final response = await _apiMethod.get('clients/$organizationId');

    if (response['success'] == true || response['statusCode'] == 200) {
      final List<dynamic> list = response['clients'] ?? response['data'] ?? [];
      return list.map((e) => Patient.fromJson(e)).toList();
    } else {
      throw Exception(response['message'] ?? 'Failed to fetch clients');
    }
  }

  Future<void> activateClient(String email) async {
    final response = await _apiMethod.post('activate', body: {'email': email});

    if (response['success'] != true && response['statusCode'] != 200) {
      throw Exception(response['message'] ?? 'Failed to activate client');
    }
  }

  Future<void> addClient(Map<String, dynamic> clientData) async {
    final response = await _apiMethod.post('addClient', body: clientData);

    if (response['success'] != true && response['statusCode'] != 201) {
      throw Exception(response['message'] ?? 'Failed to add client');
    }
  }
}
