import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/features/client_appointment_details/repositories/client_appointment_repository.dart';
import 'package:carenest/app/features/client_appointment_details/viewmodels/client_appointment_details_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final clientAppointmentRepositoryProvider =
    Provider<ClientAppointmentRepository>((ref) {
  return ClientAppointmentRepository(ref.read(app_providers.apiMethodProvider));
});

class ClientAppointmentDetailsParams {
  final String clientId;
  final String? clientEmail;

  const ClientAppointmentDetailsParams({
    required this.clientId,
    this.clientEmail,
  });

  @override
  bool operator ==(Object other) {
    return other is ClientAppointmentDetailsParams &&
        other.clientId == clientId &&
        other.clientEmail == clientEmail;
  }

  @override
  int get hashCode => Object.hash(clientId, clientEmail);
}



final clientAppointmentDetailsViewModelProvider = NotifierProvider.autoDispose<ClientAppointmentDetailsViewModel, int>(ClientAppointmentDetailsViewModel.new);
