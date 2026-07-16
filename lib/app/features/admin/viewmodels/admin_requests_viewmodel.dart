import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/requests/models/request_model.dart';
import 'package:carenest/app/features/requests/repositories/request_repository.dart';
import 'package:carenest/app/features/auth/providers/user_provider.dart';
import 'package:carenest/app/features/auth/models/user_model.dart';

class AdminRequestsViewModel extends AsyncNotifier<List<RequestModel>> {
  late final RequestRepository _repository;
  User? _user;

  @override
  FutureOr<List<RequestModel>> build() async {
    _repository = ref.watch(requestRepositoryProvider);
    final userAsync = ref.watch(currentUserProvider);

    final user = userAsync.value;
    _user = user;
    if (user == null) {
      return [];
    }

    return _fetchRequestsList(user);
  }

  Future<List<RequestModel>> _fetchRequestsList(User user) async {
    final requests = await _repository.getRequests(
      user.organizationId,
      userId: null,
      userEmail: null, // Force admin fetch
    );

    // Sort by date desc
    requests.sort((a, b) => (b.createdAt ?? DateTime.now()).compareTo(a.createdAt ?? DateTime.now()));
    return requests;
  }

  Future<void> fetchRequests() async {
    if (_user == null) return;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchRequestsList(_user!));
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

final adminRequestsViewModelProvider =
    AsyncNotifierProvider<AdminRequestsViewModel, List<RequestModel>>(
  AdminRequestsViewModel.new,
);
