import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/features/requests/models/job_role_model.dart';
import 'package:carenest/app/features/requests/models/leave_type_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final configRepositoryProvider = Provider<ConfigRepository>((ref) {
  return ConfigRepository(ref.read(app_providers.apiMethodProvider));
});

class ConfigRepository {
  final ApiMethod _apiMethod;

  ConfigRepository(this._apiMethod);

  Future<List<JobRoleModel>> getJobRoles(String organizationId) async {
    try {
      final response =
          await _apiMethod.get('api/config/job-roles/$organizationId');

      if (response['success'] == true) {
        final List data = response['data'];
        return data.map((e) => JobRoleModel.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<List<LeaveTypeModel>> getLeaveTypes(String organizationId) async {
    try {
      final response =
          await _apiMethod.get('api/config/leave-types/$organizationId');

      if (response['success'] == true) {
        final List data = response['data'];
        return data.map((e) => LeaveTypeModel.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
