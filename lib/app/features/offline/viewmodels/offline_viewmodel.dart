import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/offline/repositories/offline_repository.dart';
import 'package:carenest/app/features/offline/models/offline_models.dart';

/// State for offline sync
class OfflineState {
  late final bool isLoading;
  late final String? error;
  late final List<OfflineQueueItem> queueItems;
  late final SyncStatus? syncStatus;
  late final OfflineCapableData? offlineData;
  late final ConflictResolution? conflictResolution;
  late final bool isOnline;

  OfflineState({
    this.isLoading = false,
    this.error,
    this.queueItems = const [],
    this.syncStatus,
    this.offlineData,
    this.conflictResolution,
    this.isOnline = true,
  });

  OfflineState copyWith({
    bool? isLoading,
    String? error,
    List<OfflineQueueItem>? queueItems,
    SyncStatus? syncStatus,
    OfflineCapableData? offlineData,
    ConflictResolution? conflictResolution,
    bool? isOnline,
  }) {
    return OfflineState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      queueItems: queueItems ?? this.queueItems,
      syncStatus: syncStatus ?? this.syncStatus,
      offlineData: offlineData ?? this.offlineData,
      conflictResolution: conflictResolution ?? this.conflictResolution,
      isOnline: isOnline ?? this.isOnline,
    );
  }
}

/// ViewModel for offline sync
class OfflineViewModel extends Notifier<OfflineState> {
  late final OfflineRepository repository;

  @override
  OfflineState build() {

    return OfflineState();
  }

  /// Queue data for offline sync
  Future<void> queueData(Map<String, dynamic> data) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await repository.queueData(data: data);

      if (response['success'] == true && response['data'] != null) {
        final queueItem = OfflineQueueItem.fromJson(response['data']);
        final updatedQueue = [...state.queueItems, queueItem];
        state = state.copyWith(isLoading: false, queueItems: updatedQueue);
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response['message'] ?? 'Failed to queue data',
        );
      }
    } catch (e) {
      debugPrint('Error in queueData: $e');
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Sync queued data to server
  Future<void> syncData(String userId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final queueItemsJson = state.queueItems
          .map(
            (item) => {
              'queueId': item.queueId,
              'userId': item.userId,
              'dataType': item.dataType,
              'action': item.action,
              'payload': item.payload,
              'timestamp': item.timestamp,
              'status': item.status,
              'retryCount': item.retryCount,
            },
          )
          .toList();

      final response = await repository.syncData(
        userId: userId,
        queueItems: queueItemsJson,
      );

      if (response['success'] == true && response['data'] != null) {
        final syncStatus = SyncStatus.fromJson(response['data']);

        // Remove successfully synced items from queue
        final remainingQueue = state.queueItems.where((item) {
          final syncedItem = syncStatus.items.firstWhere(
            (result) =>
                result.queueId == item.queueId && result.status == 'synced',
            orElse: () => SyncItemResult(queueId: '', status: ''),
          );
          return syncedItem.queueId.isEmpty;
        }).toList();

        state = state.copyWith(
          isLoading: false,
          syncStatus: syncStatus,
          queueItems: remainingQueue,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response['message'] ?? 'Failed to sync data',
        );
      }
    } catch (e) {
      debugPrint('Error in syncData: $e');
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Get offline-capable data
  Future<void> getOfflineData(String userId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await repository.getOfflineData(userId: userId);

      if (response['success'] == true && response['data'] != null) {
        final offlineData = OfflineCapableData.fromJson(response['data']);
        state = state.copyWith(isLoading: false, offlineData: offlineData);
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response['message'] ?? 'Failed to get offline data',
        );
      }
    } catch (e) {
      debugPrint('Error in getOfflineData: $e');
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Resolve sync conflict
  Future<void> resolveConflict(
    String conflictId,
    String resolution, {
    Map<String, dynamic>? mergedData,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await repository.resolveConflict(
        conflictId: conflictId,
        resolution: resolution,
        mergedData: mergedData,
      );

      if (response['success'] == true && response['data'] != null) {
        final conflictResolution = ConflictResolution.fromJson(
          response['data'],
        );
        state = state.copyWith(
          isLoading: false,
          conflictResolution: conflictResolution,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response['message'] ?? 'Failed to resolve conflict',
        );
      }
    } catch (e) {
      debugPrint('Error in resolveConflict: $e');
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Update online status
  void setOnlineStatus(bool isOnline) {
    state = state.copyWith(isOnline: isOnline);
  }
}

/// Provider for offline viewmodel
final offlineViewModelProvider =
    NotifierProvider<OfflineViewModel, OfflineState>(OfflineViewModel.new);
