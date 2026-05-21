// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OfflineQueueItem _$OfflineQueueItemFromJson(Map<String, dynamic> json) =>
    _OfflineQueueItem(
      queueId: json['queueId'] as String,
      userId: json['userId'] as String,
      dataType: json['dataType'] as String,
      action: json['action'] as String,
      payload: json['payload'] as Map<String, dynamic>,
      timestamp: json['timestamp'] as String,
      status: json['status'] as String,
      retryCount: (json['retryCount'] as num).toInt(),
    );

Map<String, dynamic> _$OfflineQueueItemToJson(_OfflineQueueItem instance) =>
    <String, dynamic>{
      'queueId': instance.queueId,
      'userId': instance.userId,
      'dataType': instance.dataType,
      'action': instance.action,
      'payload': instance.payload,
      'timestamp': instance.timestamp,
      'status': instance.status,
      'retryCount': instance.retryCount,
    };

_SyncStatus _$SyncStatusFromJson(Map<String, dynamic> json) => _SyncStatus(
      total: (json['total'] as num).toInt(),
      successful: (json['successful'] as num).toInt(),
      failed: (json['failed'] as num).toInt(),
      conflicts: (json['conflicts'] as num).toInt(),
      items: (json['items'] as List<dynamic>)
          .map((e) => SyncItemResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SyncStatusToJson(_SyncStatus instance) =>
    <String, dynamic>{
      'total': instance.total,
      'successful': instance.successful,
      'failed': instance.failed,
      'conflicts': instance.conflicts,
      'items': instance.items,
    };

_SyncItemResult _$SyncItemResultFromJson(Map<String, dynamic> json) =>
    _SyncItemResult(
      queueId: json['queueId'] as String,
      status: json['status'] as String,
      reason: json['reason'] as String?,
      syncedAt: json['syncedAt'] as String?,
      conflictData: json['conflictData'] == null
          ? null
          : ConflictData.fromJson(json['conflictData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SyncItemResultToJson(_SyncItemResult instance) =>
    <String, dynamic>{
      'queueId': instance.queueId,
      'status': instance.status,
      'reason': instance.reason,
      'syncedAt': instance.syncedAt,
      'conflictData': instance.conflictData,
    };

_ConflictData _$ConflictDataFromJson(Map<String, dynamic> json) =>
    _ConflictData(
      conflictType: json['conflictType'] as String,
      localVersion: (json['localVersion'] as num).toInt(),
      serverVersion: (json['serverVersion'] as num).toInt(),
      conflictFields: (json['conflictFields'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      resolution: json['resolution'] as String,
    );

Map<String, dynamic> _$ConflictDataToJson(_ConflictData instance) =>
    <String, dynamic>{
      'conflictType': instance.conflictType,
      'localVersion': instance.localVersion,
      'serverVersion': instance.serverVersion,
      'conflictFields': instance.conflictFields,
      'resolution': instance.resolution,
    };

_ConflictResolution _$ConflictResolutionFromJson(Map<String, dynamic> json) =>
    _ConflictResolution(
      conflictId: json['conflictId'] as String,
      resolution: json['resolution'] as String,
      resolvedAt: json['resolvedAt'] as String,
      finalData: json['finalData'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$ConflictResolutionToJson(_ConflictResolution instance) =>
    <String, dynamic>{
      'conflictId': instance.conflictId,
      'resolution': instance.resolution,
      'resolvedAt': instance.resolvedAt,
      'finalData': instance.finalData,
    };

_OfflineCapableData _$OfflineCapableDataFromJson(Map<String, dynamic> json) =>
    _OfflineCapableData(
      userId: json['userId'] as String,
      downloadedAt: json['downloadedAt'] as String,
      expiresAt: json['expiresAt'] as String,
      data: OfflineDataPackage.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OfflineCapableDataToJson(_OfflineCapableData instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'downloadedAt': instance.downloadedAt,
      'expiresAt': instance.expiresAt,
      'data': instance.data,
    };

_OfflineDataPackage _$OfflineDataPackageFromJson(Map<String, dynamic> json) =>
    _OfflineDataPackage(
      appointments: (json['appointments'] as List<dynamic>)
          .map((e) => OfflineAppointment.fromJson(e as Map<String, dynamic>))
          .toList(),
      clients: (json['clients'] as List<dynamic>)
          .map((e) => OfflineClient.fromJson(e as Map<String, dynamic>))
          .toList(),
      forms: (json['forms'] as List<dynamic>)
          .map((e) => OfflineForm.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OfflineDataPackageToJson(_OfflineDataPackage instance) =>
    <String, dynamic>{
      'appointments': instance.appointments,
      'clients': instance.clients,
      'forms': instance.forms,
    };

_OfflineAppointment _$OfflineAppointmentFromJson(Map<String, dynamic> json) =>
    _OfflineAppointment(
      id: json['id'] as String,
      clientName: json['clientName'] as String,
      date: json['date'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      address: json['address'] as String,
      notes: json['notes'] as String,
    );

Map<String, dynamic> _$OfflineAppointmentToJson(_OfflineAppointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'clientName': instance.clientName,
      'date': instance.date,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'address': instance.address,
      'notes': instance.notes,
    };

_OfflineClient _$OfflineClientFromJson(Map<String, dynamic> json) =>
    _OfflineClient(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String,
      emergencyContact: json['emergencyContact'] as String,
    );

Map<String, dynamic> _$OfflineClientToJson(_OfflineClient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'phone': instance.phone,
      'emergencyContact': instance.emergencyContact,
    };

_OfflineForm _$OfflineFormFromJson(Map<String, dynamic> json) => _OfflineForm(
      id: json['id'] as String,
      name: json['name'] as String,
      fields:
          (json['fields'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$OfflineFormToJson(_OfflineForm instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'fields': instance.fields,
    };
