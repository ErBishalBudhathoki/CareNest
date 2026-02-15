// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationPreferencesImpl _$$NotificationPreferencesImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationPreferencesImpl(
      userId: json['userId'] as String,
      categoryEnabled: (json['categoryEnabled'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry($enumDecode(_$NotificationCategoryEnumMap, k), e as bool),
      ),
      categoryChannels: (json['categoryChannels'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            $enumDecode(_$NotificationCategoryEnumMap, k),
            (e as List<dynamic>)
                .map((e) => $enumDecode(_$NotificationChannelEnumMap, e))
                .toList()),
      ),
      quietHours:
          QuietHours.fromJson(json['quietHours'] as Map<String, dynamic>),
      smartTimingEnabled: json['smartTimingEnabled'] as bool? ?? true,
      geofenceEnabled: json['geofenceEnabled'] as bool? ?? true,
      geofenceRadiusKm: (json['geofenceRadiusKm'] as num?)?.toDouble() ?? 5.0,
      soundEnabled: json['soundEnabled'] as bool? ?? true,
      vibrationEnabled: json['vibrationEnabled'] as bool? ?? true,
      badgeEnabled: json['badgeEnabled'] as bool? ?? true,
      lastUpdated: json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$$NotificationPreferencesImplToJson(
        _$NotificationPreferencesImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'categoryEnabled': instance.categoryEnabled
          .map((k, e) => MapEntry(_$NotificationCategoryEnumMap[k]!, e)),
      'categoryChannels': instance.categoryChannels.map((k, e) => MapEntry(
          _$NotificationCategoryEnumMap[k]!,
          e.map((e) => _$NotificationChannelEnumMap[e]!).toList())),
      'quietHours': instance.quietHours,
      'smartTimingEnabled': instance.smartTimingEnabled,
      'geofenceEnabled': instance.geofenceEnabled,
      'geofenceRadiusKm': instance.geofenceRadiusKm,
      'soundEnabled': instance.soundEnabled,
      'vibrationEnabled': instance.vibrationEnabled,
      'badgeEnabled': instance.badgeEnabled,
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
    };

const _$NotificationCategoryEnumMap = {
  NotificationCategory.shiftChanges: 'shiftChanges',
  NotificationCategory.geofence: 'geofence',
  NotificationCategory.compliance: 'compliance',
  NotificationCategory.approvals: 'approvals',
  NotificationCategory.messages: 'messages',
  NotificationCategory.payments: 'payments',
  NotificationCategory.system: 'system',
};

const _$NotificationChannelEnumMap = {
  NotificationChannel.push: 'push',
  NotificationChannel.sms: 'sms',
  NotificationChannel.email: 'email',
};

_$QuietHoursImpl _$$QuietHoursImplFromJson(Map<String, dynamic> json) =>
    _$QuietHoursImpl(
      enabled: json['enabled'] as bool? ?? false,
      startTime: json['startTime'] as String? ?? '22:00',
      endTime: json['endTime'] as String? ?? '08:00',
      daysOfWeek: (json['daysOfWeek'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$QuietHoursImplToJson(_$QuietHoursImpl instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'daysOfWeek': instance.daysOfWeek,
    };

_$GeofenceEventImpl _$$GeofenceEventImplFromJson(Map<String, dynamic> json) =>
    _$GeofenceEventImpl(
      eventId: json['eventId'] as String,
      workerId: json['workerId'] as String,
      workerName: json['workerName'] as String,
      appointmentId: json['appointmentId'] as String,
      clientName: json['clientName'] as String,
      clientAddress: json['clientAddress'] as String,
      eventType: $enumDecode(_$GeofenceEventTypeEnumMap, json['eventType']),
      timestamp: DateTime.parse(json['timestamp'] as String),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      distanceMeters: (json['distanceMeters'] as num?)?.toDouble(),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$GeofenceEventImplToJson(_$GeofenceEventImpl instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
      'workerId': instance.workerId,
      'workerName': instance.workerName,
      'appointmentId': instance.appointmentId,
      'clientName': instance.clientName,
      'clientAddress': instance.clientAddress,
      'eventType': _$GeofenceEventTypeEnumMap[instance.eventType]!,
      'timestamp': instance.timestamp.toIso8601String(),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'distanceMeters': instance.distanceMeters,
      'notes': instance.notes,
    };

const _$GeofenceEventTypeEnumMap = {
  GeofenceEventType.arrived: 'arrived',
  GeofenceEventType.departed: 'departed',
  GeofenceEventType.runningLate: 'runningLate',
  GeofenceEventType.nearLocation: 'nearLocation',
};

_$ShiftChangeNotificationImpl _$$ShiftChangeNotificationImplFromJson(
        Map<String, dynamic> json) =>
    _$ShiftChangeNotificationImpl(
      notificationId: json['notificationId'] as String,
      shiftId: json['shiftId'] as String,
      workerId: json['workerId'] as String,
      workerName: json['workerName'] as String,
      clientName: json['clientName'] as String,
      changeType: $enumDecode(_$ShiftChangeTypeEnumMap, json['changeType']),
      shiftDate: DateTime.parse(json['shiftDate'] as String),
      shiftTime: json['shiftTime'] as String,
      oldTime: json['oldTime'] as String?,
      newTime: json['newTime'] as String?,
      reason: json['reason'] as String?,
      replacementWorkerId: json['replacementWorkerId'] as String?,
      replacementWorkerName: json['replacementWorkerName'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$ShiftChangeNotificationImplToJson(
        _$ShiftChangeNotificationImpl instance) =>
    <String, dynamic>{
      'notificationId': instance.notificationId,
      'shiftId': instance.shiftId,
      'workerId': instance.workerId,
      'workerName': instance.workerName,
      'clientName': instance.clientName,
      'changeType': _$ShiftChangeTypeEnumMap[instance.changeType]!,
      'shiftDate': instance.shiftDate.toIso8601String(),
      'shiftTime': instance.shiftTime,
      'oldTime': instance.oldTime,
      'newTime': instance.newTime,
      'reason': instance.reason,
      'replacementWorkerId': instance.replacementWorkerId,
      'replacementWorkerName': instance.replacementWorkerName,
      'timestamp': instance.timestamp.toIso8601String(),
    };

const _$ShiftChangeTypeEnumMap = {
  ShiftChangeType.assigned: 'assigned',
  ShiftChangeType.cancelled: 'cancelled',
  ShiftChangeType.timeChanged: 'timeChanged',
  ShiftChangeType.replacementNeeded: 'replacementNeeded',
  ShiftChangeType.replacementFound: 'replacementFound',
};

_$SmartTimingRecommendationImpl _$$SmartTimingRecommendationImplFromJson(
        Map<String, dynamic> json) =>
    _$SmartTimingRecommendationImpl(
      userId: json['userId'] as String,
      category: $enumDecode(_$NotificationCategoryEnumMap, json['category']),
      recommendedTime: DateTime.parse(json['recommendedTime'] as String),
      confidence: (json['confidence'] as num).toDouble(),
      reason: json['reason'] as String,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$SmartTimingRecommendationImplToJson(
        _$SmartTimingRecommendationImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'category': _$NotificationCategoryEnumMap[instance.category]!,
      'recommendedTime': instance.recommendedTime.toIso8601String(),
      'confidence': instance.confidence,
      'reason': instance.reason,
      'metadata': instance.metadata,
    };

_$NotificationDeliveryStatusImpl _$$NotificationDeliveryStatusImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationDeliveryStatusImpl(
      notificationId: json['notificationId'] as String,
      channelResults: (json['channelResults'] as Map<String, dynamic>).map(
        (k, e) => MapEntry($enumDecode(_$NotificationChannelEnumMap, k),
            DeliveryResult.fromJson(e as Map<String, dynamic>)),
      ),
      sentAt: DateTime.parse(json['sentAt'] as String),
      deliveredAt: json['deliveredAt'] == null
          ? null
          : DateTime.parse(json['deliveredAt'] as String),
      readAt: json['readAt'] == null
          ? null
          : DateTime.parse(json['readAt'] as String),
      actionedAt: json['actionedAt'] == null
          ? null
          : DateTime.parse(json['actionedAt'] as String),
    );

Map<String, dynamic> _$$NotificationDeliveryStatusImplToJson(
        _$NotificationDeliveryStatusImpl instance) =>
    <String, dynamic>{
      'notificationId': instance.notificationId,
      'channelResults': instance.channelResults
          .map((k, e) => MapEntry(_$NotificationChannelEnumMap[k]!, e)),
      'sentAt': instance.sentAt.toIso8601String(),
      'deliveredAt': instance.deliveredAt?.toIso8601String(),
      'readAt': instance.readAt?.toIso8601String(),
      'actionedAt': instance.actionedAt?.toIso8601String(),
    };

_$DeliveryResultImpl _$$DeliveryResultImplFromJson(Map<String, dynamic> json) =>
    _$DeliveryResultImpl(
      success: json['success'] as bool,
      errorMessage: json['errorMessage'] as String?,
      messageId: json['messageId'] as String?,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$DeliveryResultImplToJson(
        _$DeliveryResultImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'errorMessage': instance.errorMessage,
      'messageId': instance.messageId,
      'timestamp': instance.timestamp?.toIso8601String(),
    };
