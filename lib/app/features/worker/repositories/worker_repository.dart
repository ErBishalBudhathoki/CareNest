import 'package:carenest/app/core/providers/core_providers.dart';
import 'package:carenest/app/features/worker/models/worker_dashboard_data.dart';
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
        throw Exception(response['message'] ??
            'Failed to fetch worker dashboard: ${response['code'] ?? 'UNKNOWN_ERROR'}');
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
}
