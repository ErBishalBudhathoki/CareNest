import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/client_appointment_details/models/client_detail_model.dart';
import 'package:carenest/app/features/client_appointment_details/models/visit_history_model.dart';
import 'package:flutter/foundation.dart';

class ClientAppointmentRepository {
  final ApiMethod _apiMethod;

  ClientAppointmentRepository(this._apiMethod);

  Future<ClientDetailModel?> getClientDetails(
    String clientId,
    String organizationId,
  ) async {
    try {
      final endpoint =
          'details/$clientId?organizationId=${Uri.encodeComponent(organizationId)}';
      final response = await _apiMethod.get(endpoint);
      if (response['success'] == true && response['client'] != null) {
        return ClientDetailModel.fromJson(
          _normalizeClientJson(Map<String, dynamic>.from(response['client'])),
        );
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching client details: $e');
      rethrow;
    }
  }

  Future<ClientDetailModel?> getClientByEmail(
    String clientEmail,
    String organizationId,
  ) async {
    try {
      final encodedEmail = Uri.encodeComponent(clientEmail);
      final response = await _apiMethod.get('getMultipleClients/$encodedEmail');
      final data = response['data'];
      if (data is List && data.isNotEmpty) {
        final candidates = data
            .whereType<Map>()
            .map((item) => Map<String, dynamic>.from(item))
            .toList();

        if (candidates.isEmpty) return null;

        final match = candidates.firstWhere(
          (item) => item['organizationId']?.toString() == organizationId,
          orElse: () => candidates.first,
        );

        return ClientDetailModel.fromJson(_normalizeClientJson(match));
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching client by email: $e');
      return null;
    }
  }

  Map<String, dynamic> _normalizeClientJson(Map<String, dynamic> json) {
    if (!json.containsKey('id') || json['id'] == null) {
      final fallbackId = json['_id'] ?? json['clientId'] ?? json['uid'];
      if (fallbackId != null) {
        json['id'] = fallbackId.toString();
      }
    }
    return json;
  }

  Future<bool> updateCareNotes(
    String clientId,
    String careNotes,
    String organizationId,
    String userEmail,
  ) async {
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

  Future<List<VisitHistoryModel>> getVisitHistory(
    String clientId,
    String organizationId,
  ) async {
    try {
      final response = await _apiMethod.get(
        'api/worked-time/history/$clientId?organizationId=$organizationId',
      );
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
