import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/requests/models/request_model.dart';
import 'package:carenest/app/features/requests/repositories/request_repository.dart';
import 'package:carenest/app/features/auth/providers/user_provider.dart';
import 'package:carenest/app/features/auth/models/user_model.dart';

final adminRequestsViewModelProvider =
    StateNotifierProvider<AdminRequestsViewModel, AsyncValue<List<RequestModel>>>(
        (ref) {
  final repository = ref.watch(requestRepositoryProvider);
  final userAsync = ref.watch(currentUserProvider);

  return userAsync.when(
    data: (user) => AdminRequestsViewModel(repository, user),
    loading: () => AdminRequestsViewModel(repository, null, loading: true),
    error: (e, st) => AdminRequestsViewModel(repository, null, error: e),
  );
});

class AdminRequestsViewModel extends StateNotifier<AsyncValue<List<RequestModel>>> {
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
      fetchRequests();
    }
  }

  Future<void> fetchRequests() async {
    if (_user == null) return;
    try {
      state = const AsyncValue.loading();
      // Fetch ALL requests for the organization (userId: null)
      final requests = await _repository.getRequests(
        _user!.organizationId,
        userId: null,
        userEmail: null, // Force admin fetch
      );

      // Sort by date desc
      requests.sort((a, b) => (b.createdAt ?? DateTime.now()).compareTo(a.createdAt ?? DateTime.now()));

      state = AsyncValue.data(requests);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<bool> updateStatus(String requestId, RequestStatus status, {String? reason}) async {
    if (_user == null) return false;
    try {
      final success = await _repository.updateRequestStatus(
        requestId,
        status.name,
        _user!.email,
        reason: reason,
      );

      if (success) {
        await fetchRequests(); // Refresh list
      }
      return success;
    } catch (e) {
      return false;
    }
  }
}
