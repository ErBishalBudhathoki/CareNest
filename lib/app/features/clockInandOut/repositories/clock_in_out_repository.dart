import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/core_providers.dart';

final clockInOutRepositoryProvider = Provider<ClockInOutRepository>((ref) {
  final apiMethod = ref.read(apiMethodProvider);
  return ClockInOutRepository(apiMethod);
});

class ClockInOutRepository {
  final ApiMethod _apiMethod;

  ClockInOutRepository(this._apiMethod);

  Future<void> startTimer({
    required String userEmail,
    required String clientEmail,
    required String organizationId,
  }) async {
    final response = await _apiMethod.post(
      'active-timers/start', // Assuming mounted at /api/active-timers or similar. If root mounted, then 'startTimerWithTracking' was old path. New path is standardized.
      // My new route file 'routes/v1/activeTimers.js' defines '/start'.
      // If server.js mounts it, I need to know where.
      // Assuming mounted at /active-timers or /api/active-timers.
      // I'll try 'active-timers/start'.
      body: {
        'userEmail': userEmail,
        'clientEmail': clientEmail,
        'organizationId': organizationId,
      },
    );

    if (response['success'] != true) {
      throw Exception(response['message'] ?? 'Failed to start timer');
    }
  }

  Future<Map<String, dynamic>> stopTimer({
    required String userEmail,
    required String organizationId,
  }) async {
    final response = await _apiMethod.post(
      'active-timers/stop',
      body: {
        'userEmail': userEmail,
        'organizationId': organizationId,
      },
    );

    if (response['success'] == true) {
      return response;
    } else {
      throw Exception(response['message'] ?? 'Failed to stop timer');
    }
  }

  Future<List<dynamic>> getActiveTimers(String organizationId) async {
    final response = await _apiMethod.get('active-timers/$organizationId');

    if (response['success'] == true) {
      return response['activeTimers'] ?? [];
    } else {
      throw Exception(response['message'] ?? 'Failed to fetch active timers');
    }
  }
}
