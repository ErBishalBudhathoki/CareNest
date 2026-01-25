import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/client_portal_repository.dart';
import '../models/client_portal_models.dart';

final clientAppointmentsProvider = FutureProvider.autoDispose<List<ClientAppointment>>((ref) async {
  final repository = ref.watch(clientPortalRepositoryProvider);
  return repository.getAppointments();
});
