import 'package:carenest/app/core/providers/core_providers.dart';
import 'package:carenest/app/features/worker/models/worker_dashboard_data.dart';
import 'package:carenest/app/features/schedule/models/shift_model.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for WorkerRepository
///
/// This follows the Repository pattern in Clean Architecture
/// Repository is the single source of truth for worker data
final workerRepositoryProvider = Provider<WorkerRepository>((ref) {
  final apiMethod = ref.read(apiMethodProvider);
  return WorkerRepository(apiMethod);
});

/// Worker Repository
///
/// Handles all worker-related API calls through the ApiMethod gateway
/// NEVER makes direct HTTP calls - always uses ApiMethod for:
/// - Automatic token attachment
/// - Organization ID header injection
/// - Token refresh on 401
/// - Retry logic
/// - Centralized error handling
class WorkerRepository {
  final ApiMethod _apiMethod;

  WorkerRepository(this._apiMethod);

  /// Get worker dashboard data
  ///
  /// Fetches:
  /// - Active timer (clock-in status)
  /// - Today's shifts
  /// - Next upcoming shift
  /// - Recent expenses (last 3)
  /// - Leave balances
  ///
  /// Throws [Exception] on failure with error message from backend
  Future<WorkerDashboardData> getDashboardData() async {
    try {
      // ApiMethod automatically:
      // 1. Attaches JWT token from secure storage
      // 2. Adds x-organization-id header from SharedPreferences
      // 3. Handles token refresh on 401
      // 4. Retries on network errors
      final response = await _apiMethod.get('worker/dashboard');

      // Backend returns standardized format:
      // {
      //   "success": true,
      //   "code": "DASHBOARD_FETCHED",
      //   "data": {...}
      // }
      if (response['success'] == true && response['data'] != null) {
        return WorkerDashboardData.fromJson(response['data']);
      } else {
        // Backend returned success: false
        throw Exception(
          response['message'] ??
              'Failed to fetch worker dashboard: ${response['code'] ?? 'UNKNOWN_ERROR'}',
        );
      }
    } catch (e) {
      // Re-throw with context for better error messages
      if (e is Exception) {
        rethrow;
      } else {
        throw Exception('Unexpected error fetching worker dashboard: $e');
      }
    }
  }

  /// Refresh dashboard data (convenience method with same behavior)
  Future<WorkerDashboardData> refreshDashboard() => getDashboardData();

  /// Get full past shift history for worker dashboard.
  ///
  /// [days]:
  /// - `7` => last 7 days
  /// - `30` => last 30 days
  /// - `90` => last 90 days
  /// - `null` => all available history (bounded by backend limit)
  Future<List<ShiftModel>> getShiftHistory({int? days, int limit = 200}) async {
    try {
      final params = <String>[if (days != null) 'days=$days', 'limit=$limit'];
      final endpoint = params.isEmpty
          ? 'worker/shift-history'
          : 'worker/shift-history?${params.join('&')}';

      final response = await _apiMethod.get(endpoint);
      if (response['success'] == true) {
        final raw = response['data'];
        if (raw is! List) return [];
        return raw
            .whereType<Map<String, dynamic>>()
            .map(ShiftModel.fromJson)
            .toList();
      }

      throw Exception(
        response['message'] ??
            'Failed to fetch shift history: ${response['code'] ?? 'UNKNOWN_ERROR'}',
      );
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Unexpected error fetching shift history: $e');
    }
  }

  /// Acknowledge an emergency broadcast
  ///
  /// [broadcastId]: The ID of the broadcast to acknowledge
  Future<void> acknowledgeBroadcast(String broadcastId) async {
    try {
      final response = await _apiMethod.post(
        'emergency/acknowledge/$broadcastId',
      );

      if (response['success'] != true) {
        throw Exception(
          response['message'] ?? 'Failed to acknowledge broadcast',
        );
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Unexpected error acknowledging broadcast: $e');
    }
  }
}
