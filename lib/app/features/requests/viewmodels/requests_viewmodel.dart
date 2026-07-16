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
    AsyncNotifierProvider<RequestsViewModel, List<RequestModel>>(
        RequestsViewModel.new);

class RequestsViewModel extends AsyncNotifier<List<RequestModel>> {
  late final RequestRepository _repository;
  User? _user;

  @override
  Future<List<RequestModel>> build() async {
    _repository = ref.watch(requestRepositoryProvider);
    final userAsync = ref.watch(currentUserProvider);
    _user = userAsync.value;
    if (_user != null) {
      return fetchRequests();
    }
    return [];
  }

  Future<List<RequestModel>> fetchRequests() async {
    final user = _user;
    if (user == null) return [];
    final prefs = await SharedPreferences.getInstance();
    final cacheKey = _getStatusCacheKey(user.organizationId, user.email);
    final previousStatuses = _loadCachedStatuses(prefs, cacheKey);

    final requests = await _repository.getRequests(
      user.organizationId,
      userId: user.id.isNotEmpty ? user.id : null,
      userEmail: user.email,
    );

    await _emitStatusChangeNotifications(previousStatuses, requests);
    await _saveCachedStatuses(prefs, cacheKey, requests);
    return requests;
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      state = AsyncValue.data(await fetchRequests());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<bool> createRequest(
      String type, Map<String, dynamic> details, String? note) async {
    final user = _user;
    if (user == null) return false;

    try {
      final newRequest = RequestModel(
        organizationId: user.organizationId,
        userId: user.id.isNotEmpty ? user.id : user.email,
        createdBy: user.email,
        type: type,
        status: RequestStatus.pending,
        details: details,
        note: note,
      );

      await _repository.createRequest(newRequest, user.email);
      await refresh();
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
      next[id] = request.status.name;
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
      if (previous == null || previous == request.status.name) continue;

      final statusLower = request.status.name.toLowerCase();
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

      await ref.read(notificationProvider.notifier).addNotification(
            notification,
          );
    }
  }
}
