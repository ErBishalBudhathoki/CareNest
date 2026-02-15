import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;

final organizationRepositoryProvider = Provider<OrganizationRepository>((ref) {
  return OrganizationRepository(ref.read(app_providers.apiMethodProvider));
});

class OrganizationRepository {
  final ApiMethod _apiMethod;

  OrganizationRepository(this._apiMethod);

  Future<Map<String, dynamic>?> getOrganization(String orgId) async {
    try {
      final response = await _apiMethod.get('api/organizations/$orgId');
      if (response != null && response['success'] == true) {
        return response['data'];
      }
      return null;
    } catch (e) {
      print('Error fetching organization: $e');
      return null;
    }
  }

  Future<bool> updateOrganization(
      String orgId, Map<String, dynamic> data) async {
    try {
      final response =
          await _apiMethod.put('api/organizations/$orgId', body: data);
      return response != null && response['success'] == true;
    } catch (e) {
      print('Error updating organization: $e');
      return false;
    }
  }
}
