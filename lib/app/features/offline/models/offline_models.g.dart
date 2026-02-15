// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OfflineQueueItemImpl _$$OfflineQueueItemImplFromJson(
        Map<String, dynamic> json) =>
    _$OfflineQueueItemImpl(
      queueId: json['queueId'] as String,
      userId: json['userId'] as String,
      dataType: json['dataType'] as String,
      action: json['action'] as String,
      payload: json['payload'] as Map<String, dynamic>,
      timestamp: json['timestamp'] as String,
      status: json['status'] as String,
      retryCount: (json['retryCount'] as num).toInt(),
    );

Map<String, dynamic> _$$OfflineQueueItemImplToJson(
        _$OfflineQueueItemImpl instance) =>
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

_$SyncStatusImpl _$$SyncStatusImplFromJson(Map<String, dynamic> json) =>
    _$SyncStatusImpl(
      total: (json['total'] as num).toInt(),
      successful: (json['successful'] as num).toInt(),
      failed: (json['failed'] as num).toInt(),
      conflicts: (json['conflicts'] as num).toInt(),
      items: (json['items'] as List<dynamic>)
          .map((e) => SyncItemResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SyncStatusImplToJson(_$SyncStatusImpl instance) =>
    <String, dynamic>{
      'total': instance.total,
      'successful': instance.successful,
      'failed': instance.failed,
      'conflicts': instance.conflicts,
      'items': instance.items,
    };

_$SyncItemResultImpl _$$SyncItemResultImplFromJson(Map<String, dynamic> json) =>
    _$SyncItemResultImpl(
      queueId: json['queueId'] as String,
      status: json['status'] as String,
      reason: json['reason'] as String?,
      syncedAt: json['syncedAt'] as String?,
      conflictData: json['conflictData'] == null
          ? null
          : ConflictData.fromJson(json['conflictData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SyncItemResultImplToJson(
        _$SyncItemResultImpl instance) =>
    <String, dynamic>{
      'queueId': instance.queueId,
      'status': instance.status,
      'reason': instance.reason,
      'syncedAt': instance.syncedAt,
      'conflictData': instance.conflictData,
    };

_$ConflictDataImpl _$$ConflictDataImplFromJson(Map<String, dynamic> json) =>
    _$ConflictDataImpl(
      conflictType: json['conflictType'] as String,
      localVersion: (json['localVersion'] as num).toInt(),
      serverVersion: (json['serverVersion'] as num).toInt(),
      conflictFields: (json['conflictFields'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      resolution: json['resolution'] as String,
    );

Map<String, dynamic> _$$ConflictDataImplToJson(_$ConflictDataImpl instance) =>
    <String, dynamic>{
      'conflictType': instance.conflictType,
      'localVersion': instance.localVersion,
      'serverVersion': instance.serverVersion,
      'conflictFields': instance.conflictFields,
      'resolution': instance.resolution,
    };

_$ConflictResolutionImpl _$$ConflictResolutionImplFromJson(
        Map<String, dynamic> json) =>
    _$ConflictResolutionImpl(
      conflictId: json['conflictId'] as String,
      resolution: json['resolution'] as String,
      resolvedAt: json['resolvedAt'] as String,
      finalData: json['finalData'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$ConflictResolutionImplToJson(
        _$ConflictResolutionImpl instance) =>
    <String, dynamic>{
      'conflictId': instance.conflictId,
      'resolution': instance.resolution,
      'resolvedAt': instance.resolvedAt,
      'finalData': instance.finalData,
    };

_$OfflineCapableDataImpl _$$OfflineCapableDataImplFromJson(
        Map<String, dynamic> json) =>
    _$OfflineCapableDataImpl(
      userId: json['userId'] as String,
      downloadedAt: json['downloadedAt'] as String,
      expiresAt: json['expiresAt'] as String,
      data: OfflineDataPackage.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$OfflineCapableDataImplToJson(
        _$OfflineCapableDataImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'downloadedAt': instance.downloadedAt,
      'expiresAt': instance.expiresAt,
      'data': instance.data,
    };

_$OfflineDataPackageImpl _$$OfflineDataPackageImplFromJson(
        Map<String, dynamic> json) =>
    _$OfflineDataPackageImpl(
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

Map<String, dynamic> _$$OfflineDataPackageImplToJson(
        _$OfflineDataPackageImpl instance) =>
    <String, dynamic>{
      'appointments': instance.appointments,
      'clients': instance.clients,
      'forms': instance.forms,
    };

_$OfflineAppointmentImpl _$$OfflineAppointmentImplFromJson(
        Map<String, dynamic> json) =>
    _$OfflineAppointmentImpl(
      id: json['id'] as String,
      clientName: json['clientName'] as String,
      date: json['date'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      address: json['address'] as String,
      notes: json['notes'] as String,
    );

Map<String, dynamic> _$$OfflineAppointmentImplToJson(
        _$OfflineAppointmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'clientName': instance.clientName,
      'date': instance.date,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'address': instance.address,
      'notes': instance.notes,
    };

_$OfflineClientImpl _$$OfflineClientImplFromJson(Map<String, dynamic> json) =>
    _$OfflineClientImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String,
      emergencyContact: json['emergencyContact'] as String,
    );

Map<String, dynamic> _$$OfflineClientImplToJson(_$OfflineClientImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'phone': instance.phone,
      'emergencyContact': instance.emergencyContact,
    };

_$OfflineFormImpl _$$OfflineFormImplFromJson(Map<String, dynamic> json) =>
    _$OfflineFormImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      fields:
          (json['fields'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$OfflineFormImplToJson(_$OfflineFormImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'fields': instance.fields,
    };
