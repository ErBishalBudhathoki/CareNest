import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/client_portal_repository.dart';
import '../models/client_portal_models.dart';

final clientAppointmentsProvider = FutureProvider.autoDispose<List<ClientAppointment>>((ref) async {
  final repository = ref.watch(clientPortalRepositoryProvider);
  final response = await repository.getAppointments();
  return response.map((e) => ClientAppointment.fromJson(e as Map<String, dynamic>)).toList();
});

final clientAppointmentDetailProvider = FutureProvider.autoDispose
    .family<ClientAppointmentDetail, AppointmentParams>((ref, params) async {
  final repository = ref.watch(clientPortalRepositoryProvider);
  final response = await repository.getAppointmentDetail(
    assignmentId: params.assignmentId,
    scheduleId: params.scheduleId,
  );
  if (response['success'] == true && response['data'] != null) {
    return ClientAppointmentDetail.fromJson(response['data']);
  }
  throw Exception(response['message'] ?? 'Failed to load appointment detail');
});

