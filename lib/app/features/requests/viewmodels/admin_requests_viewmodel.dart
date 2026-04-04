import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/requests/models/request_model.dart';
import 'package:carenest/app/features/requests/repositories/request_repository.dart';
import 'package:carenest/app/features/auth/providers/user_provider.dart';
import 'package:carenest/app/features/auth/models/user_model.dart';

final adminRequestsViewModelProvider = StateNotifierProvider.autoDispose<
    AdminRequestsViewModel, AsyncValue<List<RequestModel>>>((ref) {
  final repository = ref.watch(requestRepositoryProvider);
  final userAsync = ref.watch(currentUserProvider);

  return userAsync.when(
    data: (user) => AdminRequestsViewModel(repository, user),
    loading: () => AdminRequestsViewModel(repository, null, loading: true),
    error: (e, st) => AdminRequestsViewModel(repository, null, error: e),
  );
});

class AdminRequestsViewModel
    extends StateNotifier<AsyncValue<List<RequestModel>>> {
  final RequestRepository _repository;
  final User? _user;

  AdminRequestsViewModel(this._repository, this._user,
      {bool loading = false, Object? error})
      : super(loading
            ? const AsyncValue.loading()
            : (error != null
                ? AsyncValue.error(error, StackTrace.current)
                : const AsyncValue.loading())) {
    if (_user != null) {
      if (_user!.hasAdminAccess) {
        fetchRequests();
      } else {
        state = AsyncValue.error('Unauthorized', StackTrace.current);
      }
    } else if (!loading && error == null) {
      state = AsyncValue.error('User not authenticated', StackTrace.current);
    }
  }

  Future<void> fetchRequests() async {
    if (_user == null || !_user!.hasAdminAccess) {
      debugPrint(
          'AdminRequestsViewModel: Unauthorized or no user. Role: ${_user?.role}, roles: ${_user?.roles}, organizationRole: ${_user?.organizationRole}');
      return;
    }
    try {
      debugPrint(
          'AdminRequestsViewModel: Fetching requests for organization: ${_user!.organizationId}');
      // Pass null for userEmail to fetch all requests for organization
      final requests = await _repository.getRequests(_user!.organizationId);
      debugPrint('AdminRequestsViewModel: Fetched ${requests.length} requests');
      state = AsyncValue.data(requests);
    } catch (e, st) {
      debugPrint('AdminRequestsViewModel: Error fetching requests: $e');
      state = AsyncValue.error(e, st);
    }
  }

  Future<bool> updateRequestStatus(String requestId, String status,
      {String? reason}) async {
    if (_user == null || !_user!.hasAdminAccess) return false;

    try {
      final success = await _repository
          .updateRequestStatus(requestId, status, _user!.email, reason: reason);
      if (success) {
        await fetchRequests(); // Refresh list
      }
      return success;
    } catch (e) {
      return false;
    }
  }
}
