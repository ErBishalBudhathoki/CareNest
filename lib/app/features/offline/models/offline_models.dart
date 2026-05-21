import 'package:freezed_annotation/freezed_annotation.dart';

part 'offline_models.freezed.dart';
part 'offline_models.g.dart';

/// Offline queue item
@freezed
abstract class OfflineQueueItem with _$OfflineQueueItem {
  const factory OfflineQueueItem({
    required String queueId,
    required String userId,
    required String dataType,
    required String action,
    required Map<String, dynamic> payload,
    required String timestamp,
    required String status,
    required int retryCount,
  }) = _OfflineQueueItem;

  factory OfflineQueueItem.fromJson(Map<String, dynamic> json) =>
      _$OfflineQueueItemFromJson(json);
}

/// Sync status
@freezed
abstract class SyncStatus with _$SyncStatus {
  const factory SyncStatus({
    required int total,
    required int successful,
    required int failed,
    required int conflicts,
    required List<SyncItemResult> items,
  }) = _SyncStatus;

  factory SyncStatus.fromJson(Map<String, dynamic> json) =>
      _$SyncStatusFromJson(json);
}

/// Sync item result
@freezed
abstract class SyncItemResult with _$SyncItemResult {
  const factory SyncItemResult({
    required String queueId,
    required String status,
    String? reason,
    String? syncedAt,
    ConflictData? conflictData,
  }) = _SyncItemResult;

  factory SyncItemResult.fromJson(Map<String, dynamic> json) =>
      _$SyncItemResultFromJson(json);
}

/// Conflict data
@freezed
abstract class ConflictData with _$ConflictData {
  const factory ConflictData({
    required String conflictType,
    required int localVersion,
    required int serverVersion,
    required List<String> conflictFields,
    required String resolution,
  }) = _ConflictData;

  factory ConflictData.fromJson(Map<String, dynamic> json) =>
      _$ConflictDataFromJson(json);
}

/// Conflict resolution
@freezed
abstract class ConflictResolution with _$ConflictResolution {
  const factory ConflictResolution({
    required String conflictId,
    required String resolution,
    required String resolvedAt,
    required Map<String, dynamic> finalData,
  }) = _ConflictResolution;

  factory ConflictResolution.fromJson(Map<String, dynamic> json) =>
      _$ConflictResolutionFromJson(json);
}

/// Offline capable data
@freezed
abstract class OfflineCapableData with _$OfflineCapableData {
  const factory OfflineCapableData({
    required String userId,
    required String downloadedAt,
    required String expiresAt,
    required OfflineDataPackage data,
  }) = _OfflineCapableData;

  factory OfflineCapableData.fromJson(Map<String, dynamic> json) =>
      _$OfflineCapableDataFromJson(json);
}

/// Offline data package
@freezed
abstract class OfflineDataPackage with _$OfflineDataPackage {
  const factory OfflineDataPackage({
    required List<OfflineAppointment> appointments,
    required List<OfflineClient> clients,
    required List<OfflineForm> forms,
  }) = _OfflineDataPackage;

  factory OfflineDataPackage.fromJson(Map<String, dynamic> json) =>
      _$OfflineDataPackageFromJson(json);
}

/// Offline appointment
@freezed
abstract class OfflineAppointment with _$OfflineAppointment {
  const factory OfflineAppointment({
    required String id,
    required String clientName,
    required String date,
    required String startTime,
    required String endTime,
    required String address,
    required String notes,
  }) = _OfflineAppointment;

  factory OfflineAppointment.fromJson(Map<String, dynamic> json) =>
      _$OfflineAppointmentFromJson(json);
}

/// Offline client
@freezed
abstract class OfflineClient with _$OfflineClient {
  const factory OfflineClient({
    required String id,
    required String name,
    required String address,
    required String phone,
    required String emergencyContact,
  }) = _OfflineClient;

  factory OfflineClient.fromJson(Map<String, dynamic> json) =>
      _$OfflineClientFromJson(json);
}

/// Offline form
@freezed
abstract class OfflineForm with _$OfflineForm {
  const factory OfflineForm({
    required String id,
    required String name,
    required List<String> fields,
  }) = _OfflineForm;

  factory OfflineForm.fromJson(Map<String, dynamic> json) =>
      _$OfflineFormFromJson(json);
}
