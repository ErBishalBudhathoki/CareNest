import 'package:flutter/foundation.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClientPortalRepository {
  final Ref ref;

  ClientPortalRepository(this.ref);

  Future<Map<String, dynamic>> getClientDashboard({required String clientId}) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      return await apiMethod.getClientDashboard(clientId: clientId);
    } catch (e) {
      debugPrint('Error getting client dashboard: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getWorkerLocation({required String appointmentId}) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      return await apiMethod.getWorkerLocation(appointmentId: appointmentId);
    } catch (e) {
      debugPrint('Error getting worker location: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getAppointmentStatus({required String appointmentId}) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      return await apiMethod.getAppointmentStatus(appointmentId: appointmentId);
    } catch (e) {
      debugPrint('Error getting appointment status: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> sendMessage({required Map<String, dynamic> messageData}) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      return await apiMethod.sendClientMessage(messageData: messageData);
    } catch (e) {
      debugPrint('Error sending message: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> submitFeedback({required Map<String, dynamic> feedbackData}) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      return await apiMethod.submitServiceFeedback(feedbackData: feedbackData);
    } catch (e) {
      debugPrint('Error submitting feedback: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getServiceHistory({required String clientId}) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      return await apiMethod.getServiceHistory(clientId: clientId);
    } catch (e) {
      debugPrint('Error getting service history: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Get appointments for client (for existing client portal views)
  Future<List<dynamic>> getAppointments() async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      final response = await apiMethod.get('api/client-portal/appointments');
      if (response['success'] == true && response['data'] != null) {
        return response['data'] as List;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  /// Get appointment detail (for existing client portal views)
  Future<Map<String, dynamic>> getAppointmentDetail({
    required String assignmentId,
    required String scheduleId,
  }) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      final response = await apiMethod.get(
        'api/client-portal/appointment/$assignmentId/$scheduleId',
      );
      return response;
    } catch (e) {
      return {'success': false, 'message': 'Error fetching appointment detail: $e'};
    }
  }

  /// Get invoices for client (for existing client portal views)
  Future<List<dynamic>> getInvoices() async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      final response = await apiMethod.get('api/client-portal/invoices');
      if (response['success'] == true && response['data'] != null) {
        return response['data'] as List;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  /// Get invoice detail (for existing client portal views)
  Future<Map<String, dynamic>> getInvoiceDetail(String invoiceId) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      final response = await apiMethod.get('api/client-portal/invoice/$invoiceId');
      return response;
    } catch (e) {
      return {'success': false, 'message': 'Error fetching invoice detail: $e'};
    }
  }

  /// Approve invoice (for existing client portal views)
  Future<void> approveInvoice(String invoiceId) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      await apiMethod.post('api/client-portal/invoice/$invoiceId/approve');
    } catch (e) {
      throw Exception('Error approving invoice: $e');
    }
  }

  /// Dispute invoice (for existing client portal views)
  Future<void> disputeInvoice(String invoiceId, String reason) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      await apiMethod.post(
        'api/client-portal/invoice/$invoiceId/dispute',
        body: {'reason': reason},
      );
    } catch (e) {
      throw Exception('Error disputing invoice: $e');
    }
  }

  /// Request appointment (for existing client portal views)
  Future<Map<String, dynamic>> requestAppointment(Map<String, dynamic> requestData) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      final response = await apiMethod.post(
        'api/client-portal/appointment/request',
        body: requestData,
      );
      return response;
    } catch (e) {
      return {'success': false, 'message': 'Error requesting appointment: $e'};
    }
  }
}

final clientPortalRepositoryProvider = Provider<ClientPortalRepository>((ref) {
  return ClientPortalRepository(ref);
});

