import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/client_appointment_details/models/client_detail_model.dart';
import 'package:carenest/app/features/client_appointment_details/models/visit_history_model.dart';
import 'package:flutter/foundation.dart';

class ClientAppointmentRepository {
  final ApiMethod _apiMethod;

  ClientAppointmentRepository(this._apiMethod);

  Future<ClientDetailModel?> getClientDetails(String clientId, String organizationId) async {
    try {
      final response = await _apiMethod.get('clients/$clientId?organizationId=$organizationId');
      if (response['success'] == true && response['client'] != null) {
        return ClientDetailModel.fromJson(response['client']);
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching client details: $e');
      rethrow;
    }
  }

  Future<bool> updateCareNotes(String clientId, String careNotes, String organizationId, String userEmail) async {
    try {
      final response = await _apiMethod.post(
        'updateCareNotes/$clientId',
        body: {
          'careNotes': careNotes,
          'organizationId': organizationId,
          'userEmail': userEmail,
        },
      );
      return response['success'] == true;
    } catch (e) {
      debugPrint('Error updating care notes: $e');
      return false;
    }
  }

  Future<List<VisitHistoryModel>> getVisitHistory(String clientId, String organizationId) async {
    try {
      final response = await _apiMethod.get('api/worked-time/history/$clientId?organizationId=$organizationId');
      if (response['success'] == true && response['visits'] != null) {
        return (response['visits'] as List)
            .map((e) => VisitHistoryModel.fromJson(e))
            .toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error fetching visit history: $e');
      return [];
    }
  }
}
