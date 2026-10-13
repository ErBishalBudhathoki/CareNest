import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;

/// Fetches the organisation's progress-note templates (Phase 2).
///
/// Pass an optional service type to filter templates that declare an
/// `appliesTo.serviceTypes` match.
final noteTemplatesProvider =
    FutureProvider.family<List<Map<String, dynamic>>, String?>((ref, serviceType) async {
  final apiMethod = ref.read(app_providers.apiMethodProvider);
  return apiMethod.getNoteTemplates(serviceType: serviceType);
});
