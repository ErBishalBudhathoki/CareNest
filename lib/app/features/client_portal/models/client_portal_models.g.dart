// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_portal_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClientDashboardImpl _$$ClientDashboardImplFromJson(
        Map<String, dynamic> json) =>
    _$ClientDashboardImpl(
      clientId: json['clientId'] as String,
      clientName: json['clientName'] as String,
      todayAppointments: (json['todayAppointments'] as List<dynamic>)
          .map((e) => TodayAppointment.fromJson(e as Map<String, dynamic>))
          .toList(),
      upcomingAppointments: (json['upcomingAppointments'] as List<dynamic>)
          .map((e) => UpcomingAppointment.fromJson(e as Map<String, dynamic>))
          .toList(),
      recentActivity: (json['recentActivity'] as List<dynamic>)
          .map((e) => RecentActivity.fromJson(e as Map<String, dynamic>))
          .toList(),
      notifications: (json['notifications'] as List<dynamic>)
          .map((e) => ClientNotification.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ClientDashboardImplToJson(
        _$ClientDashboardImpl instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'clientName': instance.clientName,
      'todayAppointments': instance.todayAppointments,
      'upcomingAppointments': instance.upcomingAppointments,
      'recentActivity': instance.recentActivity,
      'notifications': instance.notifications,
    };

_$TodayAppointmentImpl _$$TodayAppointmentImplFromJson(
        Map<String, dynamic> json) =>
    _$TodayAppointmentImpl(
      appointmentId: json['appointmentId'] as String,
      workerName: json['workerName'] as String,
      serviceName: json['serviceName'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      status: json['status'] as String,
      eta: json['eta'] as String?,
      workerPhoto: json['workerPhoto'] as String?,
    );

Map<String, dynamic> _$$TodayAppointmentImplToJson(
        _$TodayAppointmentImpl instance) =>
    <String, dynamic>{
      'appointmentId': instance.appointmentId,
      'workerName': instance.workerName,
      'serviceName': instance.serviceName,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'status': instance.status,
      'eta': instance.eta,
      'workerPhoto': instance.workerPhoto,
    };

_$UpcomingAppointmentImpl _$$UpcomingAppointmentImplFromJson(
        Map<String, dynamic> json) =>
    _$UpcomingAppointmentImpl(
      appointmentId: json['appointmentId'] as String,
      workerName: json['workerName'] as String,
      serviceName: json['serviceName'] as String,
      date: json['date'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$$UpcomingAppointmentImplToJson(
        _$UpcomingAppointmentImpl instance) =>
    <String, dynamic>{
      'appointmentId': instance.appointmentId,
      'workerName': instance.workerName,
      'serviceName': instance.serviceName,
      'date': instance.date,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'status': instance.status,
    };

_$RecentActivityImpl _$$RecentActivityImplFromJson(Map<String, dynamic> json) =>
    _$RecentActivityImpl(
      type: json['type'] as String,
      message: json['message'] as String,
      timestamp: json['timestamp'] as String,
    );

Map<String, dynamic> _$$RecentActivityImplToJson(
        _$RecentActivityImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'message': instance.message,
      'timestamp': instance.timestamp,
    };

_$ClientNotificationImpl _$$ClientNotificationImplFromJson(
        Map<String, dynamic> json) =>
    _$ClientNotificationImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      message: json['message'] as String,
      timestamp: json['timestamp'] as String,
      read: json['read'] as bool,
    );

Map<String, dynamic> _$$ClientNotificationImplToJson(
        _$ClientNotificationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'message': instance.message,
      'timestamp': instance.timestamp,
      'read': instance.read,
    };

_$WorkerLocationImpl _$$WorkerLocationImplFromJson(Map<String, dynamic> json) =>
    _$WorkerLocationImpl(
      appointmentId: json['appointmentId'] as String,
      workerName: json['workerName'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      accuracy: (json['accuracy'] as num).toDouble(),
      timestamp: json['timestamp'] as String,
      isEnRoute: json['isEnRoute'] as bool,
      eta: json['eta'] as String?,
      distanceRemaining: (json['distanceRemaining'] as num?)?.toDouble(),
      lastUpdated: json['lastUpdated'] as String?,
    );

Map<String, dynamic> _$$WorkerLocationImplToJson(
        _$WorkerLocationImpl instance) =>
    <String, dynamic>{
      'appointmentId': instance.appointmentId,
      'workerName': instance.workerName,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'accuracy': instance.accuracy,
      'timestamp': instance.timestamp,
      'isEnRoute': instance.isEnRoute,
      'eta': instance.eta,
      'distanceRemaining': instance.distanceRemaining,
      'lastUpdated': instance.lastUpdated,
    };

_$AppointmentStatusImpl _$$AppointmentStatusImplFromJson(
        Map<String, dynamic> json) =>
    _$AppointmentStatusImpl(
      appointmentId: json['appointmentId'] as String,
      status: json['status'] as String,
      workerName: json['workerName'] as String,
      serviceName: json['serviceName'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      actualStartTime: json['actualStartTime'] as String?,
      actualEndTime: json['actualEndTime'] as String?,
      eta: json['eta'] as String?,
      notes: (json['notes'] as List<dynamic>).map((e) => e as String).toList(),
      photos:
          (json['photos'] as List<dynamic>).map((e) => e as String).toList(),
      checklistItems: (json['checklistItems'] as List<dynamic>)
          .map((e) => ChecklistItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastUpdated: json['lastUpdated'] as String,
    );

Map<String, dynamic> _$$AppointmentStatusImplToJson(
        _$AppointmentStatusImpl instance) =>
    <String, dynamic>{
      'appointmentId': instance.appointmentId,
      'status': instance.status,
      'workerName': instance.workerName,
      'serviceName': instance.serviceName,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'actualStartTime': instance.actualStartTime,
      'actualEndTime': instance.actualEndTime,
      'eta': instance.eta,
      'notes': instance.notes,
      'photos': instance.photos,
      'checklistItems': instance.checklistItems,
      'lastUpdated': instance.lastUpdated,
    };

_$ChecklistItemImpl _$$ChecklistItemImplFromJson(Map<String, dynamic> json) =>
    _$ChecklistItemImpl(
      item: json['item'] as String,
      completed: json['completed'] as bool,
    );

Map<String, dynamic> _$$ChecklistItemImplToJson(_$ChecklistItemImpl instance) =>
    <String, dynamic>{
      'item': instance.item,
      'completed': instance.completed,
    };

_$ServiceHistoryImpl _$$ServiceHistoryImplFromJson(Map<String, dynamic> json) =>
    _$ServiceHistoryImpl(
      serviceId: json['serviceId'] as String,
      workerName: json['workerName'] as String,
      serviceName: json['serviceName'] as String,
      date: json['date'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      rating: (json['rating'] as num).toInt(),
      feedback: json['feedback'] as String?,
    );

Map<String, dynamic> _$$ServiceHistoryImplToJson(
        _$ServiceHistoryImpl instance) =>
    <String, dynamic>{
      'serviceId': instance.serviceId,
      'workerName': instance.workerName,
      'serviceName': instance.serviceName,
      'date': instance.date,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'rating': instance.rating,
      'feedback': instance.feedback,
    };

_$ClientAppointmentImpl _$$ClientAppointmentImplFromJson(
        Map<String, dynamic> json) =>
    _$ClientAppointmentImpl(
      id: json['id'] as String,
      date: json['date'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      userEmail: json['userEmail'] as String?,
      assignmentId: json['assignmentId'] as String?,
      scheduleId: json['scheduleId'] as String?,
    );

Map<String, dynamic> _$$ClientAppointmentImplToJson(
        _$ClientAppointmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'userEmail': instance.userEmail,
      'assignmentId': instance.assignmentId,
      'scheduleId': instance.scheduleId,
    };

_$ClientAppointmentDetailImpl _$$ClientAppointmentDetailImplFromJson(
        Map<String, dynamic> json) =>
    _$ClientAppointmentDetailImpl(
      id: json['id'] as String,
      date: json['date'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      status: json['status'] as String,
      notes: json['notes'] as String?,
      employee: json['employee'] == null
          ? null
          : ClientEmployee.fromJson(json['employee'] as Map<String, dynamic>),
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      serviceName: json['serviceName'] as String?,
      location: json['location'] as String?,
      assignmentId: json['assignmentId'] as String?,
      scheduleId: json['scheduleId'] as String?,
    );

Map<String, dynamic> _$$ClientAppointmentDetailImplToJson(
        _$ClientAppointmentDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'status': instance.status,
      'notes': instance.notes,
      'employee': instance.employee,
      'services': instance.services,
      'serviceName': instance.serviceName,
      'location': instance.location,
      'assignmentId': instance.assignmentId,
      'scheduleId': instance.scheduleId,
    };

_$ClientEmployeeImpl _$$ClientEmployeeImplFromJson(Map<String, dynamic> json) =>
    _$ClientEmployeeImpl(
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phone: json['phone'] as String?,
      photo: json['photo'] as String?,
    );

Map<String, dynamic> _$$ClientEmployeeImplToJson(
        _$ClientEmployeeImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phone': instance.phone,
      'photo': instance.photo,
    };

_$ClientInvoiceImpl _$$ClientInvoiceImplFromJson(Map<String, dynamic> json) =>
    _$ClientInvoiceImpl(
      id: json['id'] as String,
      invoiceNumber: json['invoiceNumber'] as String,
      workflow: json['workflow'] as Map<String, dynamic>,
      financialSummary: json['financialSummary'] as Map<String, dynamic>,
      lineItems: json['lineItems'] as List<dynamic>?,
    );

Map<String, dynamic> _$$ClientInvoiceImplToJson(_$ClientInvoiceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'invoiceNumber': instance.invoiceNumber,
      'workflow': instance.workflow,
      'financialSummary': instance.financialSummary,
      'lineItems': instance.lineItems,
    };

_$AppointmentParamsImpl _$$AppointmentParamsImplFromJson(
        Map<String, dynamic> json) =>
    _$AppointmentParamsImpl(
      assignmentId: json['assignmentId'] as String,
      scheduleId: json['scheduleId'] as String,
    );

Map<String, dynamic> _$$AppointmentParamsImplToJson(
        _$AppointmentParamsImpl instance) =>
    <String, dynamic>{
      'assignmentId': instance.assignmentId,
      'scheduleId': instance.scheduleId,
    };
