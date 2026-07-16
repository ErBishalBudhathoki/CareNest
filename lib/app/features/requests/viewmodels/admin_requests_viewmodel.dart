import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/requests/models/request_model.dart';
import 'package:carenest/app/features/requests/repositories/request_repository.dart';
import 'package:carenest/app/features/auth/providers/user_provider.dart';
import 'package:carenest/app/features/auth/models/user_model.dart';

final adminRequestsViewModelProvider = AsyncNotifierProvider<AdminRequestsViewModel, List<RequestModel>>(AdminRequestsViewModel.new);

class AdminRequestsViewModel extends AsyncNotifier<List<RequestModel>> {
  late final RequestRepository _repository;
  User? _user;

  @override
  Future<List<RequestModel>> build() async {
    _repository = ref.watch(requestRepositoryProvider);
    final userAsync = ref.watch(currentUserProvider);
    _user = userAsync.value;

    if (userAsync.isLoading) {
      // Keep loading
      return Future.any([]);
    }

    if (userAsync.hasError) {
      throw userAsync.error!;
    }

    if (_user == null) {
      throw Exception('User not authenticated');
    }
    
    if (!_user!.hasAdminAccess) {
      throw Exception('Unauthorized');
    }

    return _fetchRequestsDirectly();
  }
  
  Future<List<RequestModel>> _fetchRequestsDirectly() async {
    debugPrint('AdminRequestsViewModel: Fetching requests for organization: ${_user!.organizationId}');
    final requests = await _repository.getRequests(_user!.organizationId);
    debugPrint('AdminRequestsViewModel: Fetched ${requests.length} requests');
    return requests;
  }


  Future<void> fetchRequests() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchRequestsDirectly());
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
