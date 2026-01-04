import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';
import '../models/request_model.dart';

final requestsViewModelProvider =
    StateNotifierProvider<RequestsViewModel, AsyncValue<RequestState>>((ref) {
  return RequestsViewModel();
});

class RequestState {
  final List<Request> requests;
  final Map<RequestStatus, int> statusCounts;
  final DateTimeRange? dateRange;

  RequestState({
    required this.requests,
    required this.statusCounts,
    this.dateRange,
  });

  RequestState copyWith({
    List<Request>? requests,
    Map<RequestStatus, int>? statusCounts,
    DateTimeRange? dateRange,
  }) {
    return RequestState(
      requests: requests ?? this.requests,
      statusCounts: statusCounts ?? this.statusCounts,
      dateRange: dateRange ?? this.dateRange,
    );
  }
}

class RequestsViewModel extends StateNotifier<AsyncValue<RequestState>> {
  final ApiMethod _apiMethod = ApiMethod();

  RequestsViewModel() : super(const AsyncValue.loading()) {
    loadRequests();
  }

  Map<RequestStatus, int> _calculateStatusCounts(List<Request> requests) {
    final counts = <RequestStatus, int>{};
    for (final status in RequestStatus.values) {
      counts[status] = requests.where((r) => r.status == status).length;
    }
    return counts;
  }

  Future<void> loadRequests() async {
    try {
      state = const AsyncValue.loading();
      final response = await _apiMethod.getRequests();

      if (response['success'] == true) {
        final List<Request> requests = (response['data'] as List)
            .map((json) => Request.fromJson(json))
            .toList();

        final statusCounts = _calculateStatusCounts(requests);

        state = AsyncValue.data(RequestState(
          requests: requests,
          statusCounts: statusCounts,
        ));
      } else {
        throw Exception(response['message'] ?? 'Failed to load requests');
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addRequest(Request request) async {
    try {
      final response = await _apiMethod.createRequest(request.toJson());

      if (response['success'] == true) {
        final currentState = state.value!;
        final newRequest = Request.fromJson(response['data']);
        final updatedRequests = [...currentState.requests, newRequest];

        state = AsyncValue.data(currentState.copyWith(
          requests: updatedRequests,
          statusCounts: _calculateStatusCounts(updatedRequests),
        ));
      } else {
        throw Exception(response['message'] ?? 'Failed to create request');
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateRequest(Request request) async {
    try {
      final response = await _apiMethod.updateRequest(request.toJson());

      if (response['success'] == true) {
        final currentState = state.value!;
        final updatedRequest = Request.fromJson(response['data']);
        final updatedRequests = currentState.requests
            .map((r) => r.id == updatedRequest.id ? updatedRequest : r)
            .toList();

        state = AsyncValue.data(currentState.copyWith(
          requests: updatedRequests,
          statusCounts: _calculateStatusCounts(updatedRequests),
        ));
      } else {
        throw Exception(response['message'] ?? 'Failed to update request');
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void updateDateRange(DateTimeRange dateRange) {
    final currentState = state.value!;
    state = AsyncValue.data(currentState.copyWith(dateRange: dateRange));
    loadRequests(); // Reload requests with new date range
  }
}
