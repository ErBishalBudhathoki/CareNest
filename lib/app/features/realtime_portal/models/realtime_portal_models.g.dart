// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realtime_portal_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LiveLocationImpl _$$LiveLocationImplFromJson(Map<String, dynamic> json) =>
    _$LiveLocationImpl(
      appointmentId: json['appointmentId'] as String,
      workerId: json['workerId'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      accuracy: (json['accuracy'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      distance: (json['distance'] as num?)?.toDouble(),
      eta: (json['eta'] as num?)?.toInt(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$LiveLocationImplToJson(_$LiveLocationImpl instance) =>
    <String, dynamic>{
      'appointmentId': instance.appointmentId,
      'workerId': instance.workerId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'accuracy': instance.accuracy,
      'timestamp': instance.timestamp.toIso8601String(),
      'distance': instance.distance,
      'eta': instance.eta,
      'status': instance.status,
    };

_$LocationUpdateImpl _$$LocationUpdateImplFromJson(Map<String, dynamic> json) =>
    _$LocationUpdateImpl(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      accuracy: (json['accuracy'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$LocationUpdateImplToJson(
        _$LocationUpdateImpl instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'accuracy': instance.accuracy,
      'timestamp': instance.timestamp.toIso8601String(),
    };

_$GeofenceEventImpl _$$GeofenceEventImplFromJson(Map<String, dynamic> json) =>
    _$GeofenceEventImpl(
      appointmentId: json['appointmentId'] as String,
      event: json['event'] as String,
      distance: (json['distance'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      insideGeofence: json['insideGeofence'] as bool?,
      approaching: json['approaching'] as bool?,
    );

Map<String, dynamic> _$$GeofenceEventImplToJson(_$GeofenceEventImpl instance) =>
    <String, dynamic>{
      'appointmentId': instance.appointmentId,
      'event': instance.event,
      'distance': instance.distance,
      'timestamp': instance.timestamp.toIso8601String(),
      'insideGeofence': instance.insideGeofence,
      'approaching': instance.approaching,
    };

_$TrackingSessionImpl _$$TrackingSessionImplFromJson(
        Map<String, dynamic> json) =>
    _$TrackingSessionImpl(
      sessionId: json['sessionId'] as String,
      appointmentId: json['appointmentId'] as String,
      workerId: json['workerId'] as String,
      status: json['status'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      clientLocation: json['clientLocation'] == null
          ? null
          : ClientLocation.fromJson(
              json['clientLocation'] as Map<String, dynamic>),
      locations: (json['locations'] as List<dynamic>?)
          ?.map((e) => LocationUpdate.fromJson(e as Map<String, dynamic>))
          .toList(),
      duration: (json['duration'] as num?)?.toInt(),
      totalDistance: (json['totalDistance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$TrackingSessionImplToJson(
        _$TrackingSessionImpl instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'appointmentId': instance.appointmentId,
      'workerId': instance.workerId,
      'status': instance.status,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'clientLocation': instance.clientLocation,
      'locations': instance.locations,
      'duration': instance.duration,
      'totalDistance': instance.totalDistance,
    };

_$ClientLocationImpl _$$ClientLocationImplFromJson(Map<String, dynamic> json) =>
    _$ClientLocationImpl(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      address: json['address'] as String?,
    );

Map<String, dynamic> _$$ClientLocationImplToJson(
        _$ClientLocationImpl instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
      'address': instance.address,
    };

_$ETACalculationImpl _$$ETACalculationImplFromJson(Map<String, dynamic> json) =>
    _$ETACalculationImpl(
      minutes: (json['minutes'] as num).toInt(),
      distance: (json['distance'] as num).toDouble(),
      avgSpeed: (json['avgSpeed'] as num).toDouble(),
      estimatedArrival: DateTime.parse(json['estimatedArrival'] as String),
      trafficCondition: json['trafficCondition'] as String?,
    );

Map<String, dynamic> _$$ETACalculationImplToJson(
        _$ETACalculationImpl instance) =>
    <String, dynamic>{
      'minutes': instance.minutes,
      'distance': instance.distance,
      'avgSpeed': instance.avgSpeed,
      'estimatedArrival': instance.estimatedArrival.toIso8601String(),
      'trafficCondition': instance.trafficCondition,
    };

_$AppointmentStatusImpl _$$AppointmentStatusImplFromJson(
        Map<String, dynamic> json) =>
    _$AppointmentStatusImpl(
      appointmentId: json['appointmentId'] as String,
      status: json['status'] as String,
      progress: (json['progress'] as num).toInt(),
      notes: json['notes'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$AppointmentStatusImplToJson(
        _$AppointmentStatusImpl instance) =>
    <String, dynamic>{
      'appointmentId': instance.appointmentId,
      'status': instance.status,
      'progress': instance.progress,
      'notes': instance.notes,
      'timestamp': instance.timestamp.toIso8601String(),
    };

_$ServiceProgressImpl _$$ServiceProgressImplFromJson(
        Map<String, dynamic> json) =>
    _$ServiceProgressImpl(
      appointmentId: json['appointmentId'] as String,
      progress: (json['progress'] as num).toInt(),
      steps: (json['steps'] as List<dynamic>)
          .map((e) => ProgressStep.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentStep: json['currentStep'] as String?,
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      estimatedCompletion: json['estimatedCompletion'] == null
          ? null
          : DateTime.parse(json['estimatedCompletion'] as String),
    );

Map<String, dynamic> _$$ServiceProgressImplToJson(
        _$ServiceProgressImpl instance) =>
    <String, dynamic>{
      'appointmentId': instance.appointmentId,
      'progress': instance.progress,
      'steps': instance.steps,
      'currentStep': instance.currentStep,
      'startTime': instance.startTime?.toIso8601String(),
      'estimatedCompletion': instance.estimatedCompletion?.toIso8601String(),
    };

_$ProgressStepImpl _$$ProgressStepImplFromJson(Map<String, dynamic> json) =>
    _$ProgressStepImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      completed: json['completed'] as bool,
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$$ProgressStepImplToJson(_$ProgressStepImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'completed': instance.completed,
      'completedAt': instance.completedAt?.toIso8601String(),
    };

_$SecureMessageImpl _$$SecureMessageImplFromJson(Map<String, dynamic> json) =>
    _$SecureMessageImpl(
      id: json['id'] as String,
      conversationId: json['conversationId'] as String,
      senderId: json['senderId'] as String,
      senderType: json['senderType'] as String,
      senderName: json['senderName'] as String,
      recipientId: json['recipientId'] as String,
      message: json['message'] as String,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => MessageAttachment.fromJson(e as Map<String, dynamic>))
          .toList(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      read: json['read'] as bool,
      readAt: json['readAt'] == null
          ? null
          : DateTime.parse(json['readAt'] as String),
      type: json['type'] as String?,
    );

Map<String, dynamic> _$$SecureMessageImplToJson(_$SecureMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'conversationId': instance.conversationId,
      'senderId': instance.senderId,
      'senderType': instance.senderType,
      'senderName': instance.senderName,
      'recipientId': instance.recipientId,
      'message': instance.message,
      'attachments': instance.attachments,
      'timestamp': instance.timestamp.toIso8601String(),
      'read': instance.read,
      'readAt': instance.readAt?.toIso8601String(),
      'type': instance.type,
    };

_$MessageThreadImpl _$$MessageThreadImplFromJson(Map<String, dynamic> json) =>
    _$MessageThreadImpl(
      id: json['id'] as String,
      appointmentId: json['appointmentId'] as String,
      clientId: json['clientId'] as String,
      workerId: json['workerId'] as String,
      organizationId: json['organizationId'] as String,
      participants: (json['participants'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastMessage: json['lastMessage'] as String?,
      lastMessageAt: json['lastMessageAt'] == null
          ? null
          : DateTime.parse(json['lastMessageAt'] as String),
      unreadCount: (json['unreadCount'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
    );

Map<String, dynamic> _$$MessageThreadImplToJson(_$MessageThreadImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'appointmentId': instance.appointmentId,
      'clientId': instance.clientId,
      'workerId': instance.workerId,
      'organizationId': instance.organizationId,
      'participants': instance.participants,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastMessage': instance.lastMessage,
      'lastMessageAt': instance.lastMessageAt?.toIso8601String(),
      'unreadCount': instance.unreadCount,
    };

_$MessageAttachmentImpl _$$MessageAttachmentImplFromJson(
        Map<String, dynamic> json) =>
    _$MessageAttachmentImpl(
      url: json['url'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      size: (json['size'] as num).toInt(),
      thumbnail: json['thumbnail'] as String?,
    );

Map<String, dynamic> _$$MessageAttachmentImplToJson(
        _$MessageAttachmentImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'name': instance.name,
      'type': instance.type,
      'size': instance.size,
      'thumbnail': instance.thumbnail,
    };

_$VoiceMessageImpl _$$VoiceMessageImplFromJson(Map<String, dynamic> json) =>
    _$VoiceMessageImpl(
      id: json['id'] as String,
      conversationId: json['conversationId'] as String,
      senderId: json['senderId'] as String,
      audioUrl: json['audioUrl'] as String,
      duration: (json['duration'] as num).toInt(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      played: json['played'] as bool?,
    );

Map<String, dynamic> _$$VoiceMessageImplToJson(_$VoiceMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'conversationId': instance.conversationId,
      'senderId': instance.senderId,
      'audioUrl': instance.audioUrl,
      'duration': instance.duration,
      'timestamp': instance.timestamp.toIso8601String(),
      'played': instance.played,
    };

_$TypingIndicatorImpl _$$TypingIndicatorImplFromJson(
        Map<String, dynamic> json) =>
    _$TypingIndicatorImpl(
      conversationId: json['conversationId'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      isTyping: json['isTyping'] as bool,
    );

Map<String, dynamic> _$$TypingIndicatorImplToJson(
        _$TypingIndicatorImpl instance) =>
    <String, dynamic>{
      'conversationId': instance.conversationId,
      'userId': instance.userId,
      'userName': instance.userName,
      'isTyping': instance.isTyping,
    };

_$DigitalSignatureImpl _$$DigitalSignatureImplFromJson(
        Map<String, dynamic> json) =>
    _$DigitalSignatureImpl(
      id: json['id'] as String,
      appointmentId: json['appointmentId'] as String,
      clientId: json['clientId'] as String,
      signatureData: json['signatureData'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      hash: json['hash'] as String,
      verified: json['verified'] as bool,
      ipAddress: json['ipAddress'] as String?,
      deviceInfo: json['deviceInfo'] as String?,
    );

Map<String, dynamic> _$$DigitalSignatureImplToJson(
        _$DigitalSignatureImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'appointmentId': instance.appointmentId,
      'clientId': instance.clientId,
      'signatureData': instance.signatureData,
      'timestamp': instance.timestamp.toIso8601String(),
      'hash': instance.hash,
      'verified': instance.verified,
      'ipAddress': instance.ipAddress,
      'deviceInfo': instance.deviceInfo,
    };

_$ServiceConfirmationImpl _$$ServiceConfirmationImplFromJson(
        Map<String, dynamic> json) =>
    _$ServiceConfirmationImpl(
      id: json['id'] as String,
      appointmentId: json['appointmentId'] as String,
      clientId: json['clientId'] as String,
      workerId: json['workerId'] as String,
      signatureId: json['signatureId'] as String,
      rating: (json['rating'] as num?)?.toInt(),
      feedback: json['feedback'] as String?,
      checklist: (json['checklist'] as List<dynamic>?)
          ?.map((e) => ChecklistItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      photos:
          (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
      incidents: (json['incidents'] as List<dynamic>?)
          ?.map((e) => IncidentReport.fromJson(e as Map<String, dynamic>))
          .toList(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      status: json['status'] as String,
      reportUrl: json['reportUrl'] as String?,
    );

Map<String, dynamic> _$$ServiceConfirmationImplToJson(
        _$ServiceConfirmationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'appointmentId': instance.appointmentId,
      'clientId': instance.clientId,
      'workerId': instance.workerId,
      'signatureId': instance.signatureId,
      'rating': instance.rating,
      'feedback': instance.feedback,
      'checklist': instance.checklist,
      'photos': instance.photos,
      'incidents': instance.incidents,
      'timestamp': instance.timestamp.toIso8601String(),
      'status': instance.status,
      'reportUrl': instance.reportUrl,
    };

_$ChecklistItemImpl _$$ChecklistItemImplFromJson(Map<String, dynamic> json) =>
    _$ChecklistItemImpl(
      id: (json['id'] as num).toInt(),
      item: json['item'] as String,
      required: json['required'] as bool,
      completed: json['completed'] as bool?,
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$ChecklistItemImplToJson(_$ChecklistItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'item': instance.item,
      'required': instance.required,
      'completed': instance.completed,
      'completedAt': instance.completedAt?.toIso8601String(),
      'notes': instance.notes,
    };

_$ClientRatingImpl _$$ClientRatingImplFromJson(Map<String, dynamic> json) =>
    _$ClientRatingImpl(
      stars: (json['stars'] as num).toInt(),
      feedback: json['feedback'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$ClientRatingImplToJson(_$ClientRatingImpl instance) =>
    <String, dynamic>{
      'stars': instance.stars,
      'feedback': instance.feedback,
      'tags': instance.tags,
      'timestamp': instance.timestamp?.toIso8601String(),
    };

_$IncidentReportImpl _$$IncidentReportImplFromJson(Map<String, dynamic> json) =>
    _$IncidentReportImpl(
      id: json['id'] as String,
      appointmentId: json['appointmentId'] as String,
      reportedBy: json['reportedBy'] as String,
      reporterType: json['reporterType'] as String,
      severity: json['severity'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      photos:
          (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      status: json['status'] as String,
      resolution: json['resolution'] as String?,
      resolvedAt: json['resolvedAt'] == null
          ? null
          : DateTime.parse(json['resolvedAt'] as String),
    );

Map<String, dynamic> _$$IncidentReportImplToJson(
        _$IncidentReportImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'appointmentId': instance.appointmentId,
      'reportedBy': instance.reportedBy,
      'reporterType': instance.reporterType,
      'severity': instance.severity,
      'category': instance.category,
      'description': instance.description,
      'photos': instance.photos,
      'timestamp': instance.timestamp.toIso8601String(),
      'status': instance.status,
      'resolution': instance.resolution,
      'resolvedAt': instance.resolvedAt?.toIso8601String(),
    };

_$ServiceReportImpl _$$ServiceReportImplFromJson(Map<String, dynamic> json) =>
    _$ServiceReportImpl(
      appointmentId: json['appointmentId'] as String,
      reportUrl: json['reportUrl'] as String,
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      pdfPath: json['pdfPath'] as String?,
    );

Map<String, dynamic> _$$ServiceReportImplToJson(_$ServiceReportImpl instance) =>
    <String, dynamic>{
      'appointmentId': instance.appointmentId,
      'reportUrl': instance.reportUrl,
      'generatedAt': instance.generatedAt.toIso8601String(),
      'pdfPath': instance.pdfPath,
    };

_$FamilyMemberImpl _$$FamilyMemberImplFromJson(Map<String, dynamic> json) =>
    _$FamilyMemberImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      clientId: json['clientId'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      relationship: json['relationship'] as String,
      role: json['role'] as String,
      permissions: FamilyPermissions.fromJson(
          json['permissions'] as Map<String, dynamic>),
      status: json['status'] as String,
      joinedAt: DateTime.parse(json['joinedAt'] as String),
      notificationPreferences: json['notificationPreferences'] == null
          ? null
          : NotificationPreferences.fromJson(
              json['notificationPreferences'] as Map<String, dynamic>),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      updatedBy: json['updatedBy'] as String?,
    );

Map<String, dynamic> _$$FamilyMemberImplToJson(_$FamilyMemberImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'clientId': instance.clientId,
      'name': instance.name,
      'email': instance.email,
      'relationship': instance.relationship,
      'role': instance.role,
      'permissions': instance.permissions,
      'status': instance.status,
      'joinedAt': instance.joinedAt.toIso8601String(),
      'notificationPreferences': instance.notificationPreferences,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'updatedBy': instance.updatedBy,
    };

_$FamilyPermissionsImpl _$$FamilyPermissionsImplFromJson(
        Map<String, dynamic> json) =>
    _$FamilyPermissionsImpl(
      viewAppointments: json['viewAppointments'] as bool,
      viewDocuments: json['viewDocuments'] as bool,
      viewInvoices: json['viewInvoices'] as bool,
      editProfile: json['editProfile'] as bool,
      approveServices: json['approveServices'] as bool,
      manageFamily: json['manageFamily'] as bool,
      viewMessages: json['viewMessages'] as bool,
      sendMessages: json['sendMessages'] as bool,
      viewLocation: json['viewLocation'] as bool,
      receiveNotifications: json['receiveNotifications'] as bool,
    );

Map<String, dynamic> _$$FamilyPermissionsImplToJson(
        _$FamilyPermissionsImpl instance) =>
    <String, dynamic>{
      'viewAppointments': instance.viewAppointments,
      'viewDocuments': instance.viewDocuments,
      'viewInvoices': instance.viewInvoices,
      'editProfile': instance.editProfile,
      'approveServices': instance.approveServices,
      'manageFamily': instance.manageFamily,
      'viewMessages': instance.viewMessages,
      'sendMessages': instance.sendMessages,
      'viewLocation': instance.viewLocation,
      'receiveNotifications': instance.receiveNotifications,
    };

_$FamilyInvitationImpl _$$FamilyInvitationImplFromJson(
        Map<String, dynamic> json) =>
    _$FamilyInvitationImpl(
      id: json['id'] as String,
      clientId: json['clientId'] as String,
      invitedBy: json['invitedBy'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      relationship: json['relationship'] as String,
      role: json['role'] as String,
      permissions: FamilyPermissions.fromJson(
          json['permissions'] as Map<String, dynamic>),
      status: json['status'] as String,
      invitedAt: DateTime.parse(json['invitedAt'] as String),
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      token: json['token'] as String,
    );

Map<String, dynamic> _$$FamilyInvitationImplToJson(
        _$FamilyInvitationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'clientId': instance.clientId,
      'invitedBy': instance.invitedBy,
      'email': instance.email,
      'name': instance.name,
      'relationship': instance.relationship,
      'role': instance.role,
      'permissions': instance.permissions,
      'status': instance.status,
      'invitedAt': instance.invitedAt.toIso8601String(),
      'expiresAt': instance.expiresAt.toIso8601String(),
      'token': instance.token,
    };

_$AccessAuditLogImpl _$$AccessAuditLogImplFromJson(Map<String, dynamic> json) =>
    _$AccessAuditLogImpl(
      id: json['id'] as String,
      clientId: json['clientId'] as String,
      userId: json['userId'] as String,
      action: json['action'] as String,
      targetUserId: json['targetUserId'] as String?,
      details: json['details'] as Map<String, dynamic>?,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$AccessAuditLogImplToJson(
        _$AccessAuditLogImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'clientId': instance.clientId,
      'userId': instance.userId,
      'action': instance.action,
      'targetUserId': instance.targetUserId,
      'details': instance.details,
      'timestamp': instance.timestamp.toIso8601String(),
    };

_$NotificationPreferencesImpl _$$NotificationPreferencesImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationPreferencesImpl(
      email: json['email'] as bool? ?? true,
      sms: json['sms'] as bool? ?? false,
      push: json['push'] as bool? ?? true,
      appointmentReminders: json['appointmentReminders'] as bool? ?? true,
      statusUpdates: json['statusUpdates'] as bool? ?? true,
      emergencyAlerts: json['emergencyAlerts'] as bool? ?? true,
      serviceConfirmations: json['serviceConfirmations'] as bool? ?? true,
      quietHours: json['quietHours'] == null
          ? null
          : QuietHours.fromJson(json['quietHours'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$NotificationPreferencesImplToJson(
        _$NotificationPreferencesImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'sms': instance.sms,
      'push': instance.push,
      'appointmentReminders': instance.appointmentReminders,
      'statusUpdates': instance.statusUpdates,
      'emergencyAlerts': instance.emergencyAlerts,
      'serviceConfirmations': instance.serviceConfirmations,
      'quietHours': instance.quietHours,
    };

_$QuietHoursImpl _$$QuietHoursImplFromJson(Map<String, dynamic> json) =>
    _$QuietHoursImpl(
      start: json['start'] as String,
      end: json['end'] as String,
    );

Map<String, dynamic> _$$QuietHoursImplToJson(_$QuietHoursImpl instance) =>
    <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
    };

_$DocumentShareImpl _$$DocumentShareImplFromJson(Map<String, dynamic> json) =>
    _$DocumentShareImpl(
      id: json['id'] as String,
      clientId: json['clientId'] as String,
      documentId: json['documentId'] as String,
      sharedBy: json['sharedBy'] as String,
      sharedWith: (json['sharedWith'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      permissions: (json['permissions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      sharedAt: DateTime.parse(json['sharedAt'] as String),
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
    );

Map<String, dynamic> _$$DocumentShareImplToJson(_$DocumentShareImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'clientId': instance.clientId,
      'documentId': instance.documentId,
      'sharedBy': instance.sharedBy,
      'sharedWith': instance.sharedWith,
      'permissions': instance.permissions,
      'sharedAt': instance.sharedAt.toIso8601String(),
      'expiresAt': instance.expiresAt?.toIso8601String(),
    };

_$PushNotificationImpl _$$PushNotificationImplFromJson(
        Map<String, dynamic> json) =>
    _$PushNotificationImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      type: json['type'] as String,
      priority: json['priority'] as String,
      data: json['data'] as Map<String, dynamic>?,
      actions: (json['actions'] as List<dynamic>?)
          ?.map((e) => NotificationAction.fromJson(e as Map<String, dynamic>))
          .toList(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      read: json['read'] as bool?,
      readAt: json['readAt'] == null
          ? null
          : DateTime.parse(json['readAt'] as String),
    );

Map<String, dynamic> _$$PushNotificationImplToJson(
        _$PushNotificationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'body': instance.body,
      'type': instance.type,
      'priority': instance.priority,
      'data': instance.data,
      'actions': instance.actions,
      'timestamp': instance.timestamp.toIso8601String(),
      'read': instance.read,
      'readAt': instance.readAt?.toIso8601String(),
    };

_$NotificationActionImpl _$$NotificationActionImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationActionImpl(
      id: json['id'] as String,
      label: json['label'] as String,
      action: json['action'] as String,
    );

Map<String, dynamic> _$$NotificationActionImplToJson(
        _$NotificationActionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'action': instance.action,
    };

_$WebSocketEventImpl _$$WebSocketEventImplFromJson(Map<String, dynamic> json) =>
    _$WebSocketEventImpl(
      event: json['event'] as String,
      data: json['data'] as Map<String, dynamic>,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$WebSocketEventImplToJson(
        _$WebSocketEventImpl instance) =>
    <String, dynamic>{
      'event': instance.event,
      'data': instance.data,
      'timestamp': instance.timestamp.toIso8601String(),
    };

_$ConnectionStatusImpl _$$ConnectionStatusImplFromJson(
        Map<String, dynamic> json) =>
    _$ConnectionStatusImpl(
      connected: json['connected'] as bool,
      error: json['error'] as String?,
      lastConnected: json['lastConnected'] == null
          ? null
          : DateTime.parse(json['lastConnected'] as String),
      lastDisconnected: json['lastDisconnected'] == null
          ? null
          : DateTime.parse(json['lastDisconnected'] as String),
    );

Map<String, dynamic> _$$ConnectionStatusImplToJson(
        _$ConnectionStatusImpl instance) =>
    <String, dynamic>{
      'connected': instance.connected,
      'error': instance.error,
      'lastConnected': instance.lastConnected?.toIso8601String(),
      'lastDisconnected': instance.lastDisconnected?.toIso8601String(),
    };

_$EmergencyAlertImpl _$$EmergencyAlertImplFromJson(Map<String, dynamic> json) =>
    _$EmergencyAlertImpl(
      id: json['id'] as String,
      appointmentId: json['appointmentId'] as String,
      userId: json['userId'] as String,
      userType: json['userType'] as String,
      location:
          ClientLocation.fromJson(json['location'] as Map<String, dynamic>),
      message: json['message'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      status: json['status'] as String,
      priority: json['priority'] as String,
    );

Map<String, dynamic> _$$EmergencyAlertImplToJson(
        _$EmergencyAlertImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'appointmentId': instance.appointmentId,
      'userId': instance.userId,
      'userType': instance.userType,
      'location': instance.location,
      'message': instance.message,
      'timestamp': instance.timestamp.toIso8601String(),
      'status': instance.status,
      'priority': instance.priority,
    };

_$RealtimePortalDashboardImpl _$$RealtimePortalDashboardImplFromJson(
        Map<String, dynamic> json) =>
    _$RealtimePortalDashboardImpl(
      upcomingAppointments: (json['upcomingAppointments'] as List<dynamic>)
          .map((e) => AppointmentStatus.fromJson(e as Map<String, dynamic>))
          .toList(),
      activeTracking: json['activeTracking'] == null
          ? null
          : LiveLocation.fromJson(
              json['activeTracking'] as Map<String, dynamic>),
      unreadMessages: (json['unreadMessages'] as num?)?.toInt(),
      recentNotifications: (json['recentNotifications'] as List<dynamic>?)
          ?.map((e) => PushNotification.fromJson(e as Map<String, dynamic>))
          .toList(),
      familyMembers: (json['familyMembers'] as List<dynamic>?)
          ?.map((e) => FamilyMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastServiceConfirmation: json['lastServiceConfirmation'] == null
          ? null
          : ServiceConfirmation.fromJson(
              json['lastServiceConfirmation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$RealtimePortalDashboardImplToJson(
        _$RealtimePortalDashboardImpl instance) =>
    <String, dynamic>{
      'upcomingAppointments': instance.upcomingAppointments,
      'activeTracking': instance.activeTracking,
      'unreadMessages': instance.unreadMessages,
      'recentNotifications': instance.recentNotifications,
      'familyMembers': instance.familyMembers,
      'lastServiceConfirmation': instance.lastServiceConfirmation,
    };
