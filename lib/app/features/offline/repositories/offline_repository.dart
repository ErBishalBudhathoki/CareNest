import 'package:flutter/foundation.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Repository for offline sync operations
class OfflineRepository {
  final Ref ref;

  OfflineRepository(this.ref);

  /// Queue offline data for later sync
  Future<Map<String, dynamic>> queueData({
    required Map<String, dynamic> data,
  }) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      return await apiMethod.queueOfflineData(data: data);
    } catch (e) {
      debugPrint('Error queueing offline data: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Sync offline data to server
  Future<Map<String, dynamic>> syncData({
    required String userId,
    required List<Map<String, dynamic>> queueItems,
  }) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      return await apiMethod.syncOfflineData(
        userId: userId,
        queueItems: queueItems,
      );
    } catch (e) {
      debugPrint('Error syncing offline data: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Get offline-capable data for user
  Future<Map<String, dynamic>> getOfflineData({required String userId}) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      return await apiMethod.getOfflineCapableData(userId: userId);
    } catch (e) {
      debugPrint('Error getting offline data: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Resolve sync conflict
  Future<Map<String, dynamic>> resolveConflict({
    required String conflictId,
    required String resolution,
    Map<String, dynamic>? mergedData,
  }) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      return await apiMethod.resolveConflict(
        conflictId: conflictId,
        resolution: resolution,
        mergedData: mergedData,
      );
    } catch (e) {
      debugPrint('Error resolving conflict: $e');
      return {'success': false, 'message': e.toString()};
    }
  }
}

/// Provider for offline repository
final offlineRepositoryProvider = Provider<OfflineRepository>((ref) {
  return OfflineRepository(ref);
});
