import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/core_providers.dart';
import '../models/assigned_appointment_model.dart';
import 'package:carenest/app/features/client_appointment_details/models/client_detail_model.dart';

final appointmentRepositoryProvider = Provider<AppointmentRepository>((ref) {
  final apiMethod = ref.read(apiMethodProvider);
  return AppointmentRepository(apiMethod);
});

class AppointmentRepository {
  final ApiMethod _apiMethod;

  AppointmentRepository(this._apiMethod);

  Future<List<dynamic>> loadAppointments(String email) async {
    final response = await _apiMethod.get('loadAppointments/$email');

    if (response['success'] == true) {
      return response['data'] ?? [];
    }
    throw Exception(response['error'] ?? 'Failed to load appointments');
  }

  Future<ClientDetailModel?> loadAppointmentDetails(
      String userEmail, String clientEmail) async {
    final response =
        await _apiMethod.get('loadAppointmentDetails/$userEmail/$clientEmail');

    if (response['success'] == true) {
      final data = response['data'];
      if (data != null) {
        return ClientDetailModel.fromBackend(data);
      }
    }
    return null;
  }

  Future<void> setWorkedTime(Map<String, dynamic> data) async {
    final response = await _apiMethod.post('setWorkedTime', body: data);

    if (response['success'] != true && response['statusCode'] != 200) {
      throw Exception(response['message'] ??
          response['error'] ??
          'Failed to set worked time');
    }
  }

  Future<List<AssignedClientAppointment>> getOrganizationAssignments(
      String organizationId) async {
    final response =
        await _apiMethod.get('getOrganizationAssignments/$organizationId');

    if (response['success'] == true) {
      final List data = response['assignments'] ?? [];
      return data.map((e) => AssignedClientAppointment.fromJson(e)).toList();
    }
    throw Exception(
        response['error'] ?? 'Failed to get organization assignments');
  }

  Future<void> removeClientAssignment(
      String userEmail, String clientEmail) async {
    // Manually constructing query params for DELETE as per previous fix
    final endpoint =
        'removeClientAssignment?userEmail=$userEmail&clientEmail=$clientEmail';
    final response = await _apiMethod.delete(endpoint);

    if (response['success'] != true && response['statusCode'] != 200) {
      throw Exception(response['error'] ??
          response['message'] ??
          'Failed to remove assignment');
    }
  }

  Future<Map<String, dynamic>> assignClientToUser({
    required String userEmail,
    required String clientEmail,
    required List<String> dateList,
    required List<String> startTimeList,
    required List<String> endTimeList,
    required List<String> breakList,
    required Map<String, dynamic> ndisItem,
    required List<bool> highIntensityList,
    List<Map<String, dynamic>>? scheduleWithNdisItems,
  }) async {
    final body = {
      'userEmail': userEmail,
      'clientEmail': clientEmail,
      'dateList': dateList,
      'startTimeList': startTimeList,
      'endTimeList': endTimeList,
      'breakList': breakList,
      'ndisItem': ndisItem,
      'highIntensityList': highIntensityList,
      if (scheduleWithNdisItems != null)
        'scheduleWithNdisItems': scheduleWithNdisItems,
    };

    // Use standard 'assignments' endpoint
    final response = await _apiMethod.post('assignments', body: body);

    return response;
  }
}
