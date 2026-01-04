import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/requests/models/request_model.dart';
import 'package:carenest/app/features/requests/repositories/request_repository.dart';
import 'package:carenest/app/features/auth/providers/user_provider.dart';
import 'package:carenest/app/features/auth/models/user_model.dart';
import 'package:carenest/app/features/notifications/models/notification_model.dart';
import 'package:carenest/app/features/notifications/providers/notification_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final requestsViewModelProvider =
    StateNotifierProvider<RequestsViewModel, AsyncValue<List<RequestModel>>>(
        (ref) {
  final repository = ref.watch(requestRepositoryProvider);
  final userAsync = ref.watch(currentUserProvider);

  return userAsync.when(
    data: (user) => RequestsViewModel(ref, repository, user),
    loading: () => RequestsViewModel(ref, repository, null, loading: true),
    error: (e, st) => RequestsViewModel(ref, repository, null, error: e),
  );
});

class RequestsViewModel extends StateNotifier<AsyncValue<List<RequestModel>>> {
  final Ref _ref;
  final RequestRepository _repository;
  final User? _user;

  RequestsViewModel(this._ref, this._repository, this._user,
      {bool loading = false, Object? error})
      : super(loading
            ? const AsyncValue.loading()
            : (error != null
                ? AsyncValue.error(error, StackTrace.current)
                : const AsyncValue.loading())) {
    if (_user != null) {
      fetchRequests();
    } else if (!loading && error == null) {
      // If user is null and no error/loading passed, it means we failed to get user
      state = AsyncValue.error('User not authenticated', StackTrace.current);
    }
  }

  Future<void> fetchRequests() async {
    if (_user == null) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      final cacheKey = _getStatusCacheKey(_user!.organizationId, _user!.email);
      final previousStatuses = _loadCachedStatuses(prefs, cacheKey);

      final requests = await _repository.getRequests(
        _user!.organizationId,
        userId: _user!.id.isNotEmpty ? _user!.id : null,
        userEmail: _user!.email,
      );

      await _emitStatusChangeNotifications(previousStatuses, requests);
      await _saveCachedStatuses(prefs, cacheKey, requests);

      state = AsyncValue.data(requests);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<bool> createRequest(
      String type, Map<String, dynamic> details, String? note) async {
    if (_user == null) return false;

    try {
      final newRequest = RequestModel(
        organizationId: _user!.organizationId,
        userId: _user!.id.isNotEmpty ? _user!.id : _user!.email,
        type: type,
        status: 'Pending',
        details: details,
        note: note,
      );

      await _repository.createRequest(newRequest, _user!.email);
      await fetchRequests(); // Refresh list
      return true;
    } catch (e) {
      return false;
    }
  }

  String _getStatusCacheKey(String organizationId, String userEmail) {
    return 'request_status_cache_${organizationId}_$userEmail';
  }

  Map<String, String> _loadCachedStatuses(
      SharedPreferences prefs, String cacheKey) {
    final raw = prefs.getString(cacheKey);
    if (raw == null || raw.isEmpty) return {};
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map) return {};
      return decoded.map(
        (key, value) => MapEntry(key.toString(), value.toString()),
      );
    } catch (_) {
      return {};
    }
  }

  Future<void> _saveCachedStatuses(
      SharedPreferences prefs, String cacheKey, List<RequestModel> requests) {
    final next = <String, String>{};
    for (final request in requests) {
      final id = request.id;
      if (id == null || id.isEmpty) continue;
      next[id] = request.status;
    }
    return prefs.setString(cacheKey, jsonEncode(next));
  }

  Future<void> _emitStatusChangeNotifications(
    Map<String, String> previousStatuses,
    List<RequestModel> currentRequests,
  ) async {
    if (previousStatuses.isEmpty) return;

    for (final request in currentRequests) {
      final id = request.id;
      if (id == null || id.isEmpty) continue;

      final previous = previousStatuses[id];
      if (previous == null || previous == request.status) continue;

      final statusLower = request.status.toLowerCase();
      final title = 'Request ${request.status}';
      final body = 'Your ${request.type} request has been $statusLower.';

      final notification = NotificationModel(
        id: 'request_update_${id}_${request.status}',
        title: title,
        body: body,
        timestamp: DateTime.now(),
        type: 'request_update',
        data: {
          'type': 'request_update',
          'requestId': id,
          'status': request.status,
        },
      );

      await _ref.read(notificationProvider.notifier).addNotification(
            notification,
          );
    }
  }
}
