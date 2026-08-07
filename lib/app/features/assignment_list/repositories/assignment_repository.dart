import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/core_providers.dart';

final assignmentRepositoryProvider = Provider<AssignmentRepository>((ref) {
  final apiMethod = ref.read(apiMethodProvider);
  return AssignmentRepository(apiMethod);
});

class AssignmentRepository {
  final ApiMethod _apiMethod;

  AssignmentRepository(this._apiMethod);

  Future<Map<String, dynamic>> getOrganizationAssignments(
    String organizationId,
  ) async {
    // Manually construct query string
    final endpoint = 'assignments?organizationId=$organizationId';

    final response = await _apiMethod.get(endpoint);

    if (response['success'] == true) {
      return {'success': true, 'assignments': response['data']};
    } else {
      return response;
    }
  }
}
