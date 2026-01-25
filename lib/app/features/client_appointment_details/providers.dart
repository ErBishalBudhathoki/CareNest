import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/client_appointment_details/repositories/client_appointment_repository.dart';
import 'package:carenest/app/features/client_appointment_details/viewmodels/client_appointment_details_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final clientAppointmentRepositoryProvider = Provider<ClientAppointmentRepository>((ref) {
  return ClientAppointmentRepository(ApiMethod());
});

final clientAppointmentDetailsViewModelProvider = ChangeNotifierProvider.family.autoDispose<ClientAppointmentDetailsViewModel, String>((ref, clientId) {
  final repository = ref.watch(clientAppointmentRepositoryProvider);
  return ClientAppointmentDetailsViewModel(repository, clientId);
});
