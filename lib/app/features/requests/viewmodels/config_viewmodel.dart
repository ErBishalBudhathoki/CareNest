import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/requests/models/job_role_model.dart';
import 'package:carenest/app/features/requests/models/leave_type_model.dart';
import 'package:carenest/app/features/requests/repositories/config_repository.dart';
import 'package:carenest/app/features/auth/providers/user_provider.dart';

final jobRolesProvider = FutureProvider<List<JobRoleModel>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user == null) return [];
  final repository = ref.watch(configRepositoryProvider);
  return repository.getJobRoles(user.organizationId);
});

final leaveTypesProvider = FutureProvider<List<LeaveTypeModel>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user == null) return [];
  final repository = ref.watch(configRepositoryProvider);
  return repository.getLeaveTypes(user.organizationId);
});
