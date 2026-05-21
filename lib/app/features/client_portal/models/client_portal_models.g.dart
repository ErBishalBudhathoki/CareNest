// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_portal_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ClientDashboard _$ClientDashboardFromJson(Map<String, dynamic> json) =>
    _ClientDashboard(
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

Map<String, dynamic> _$ClientDashboardToJson(_ClientDashboard instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'clientName': instance.clientName,
      'todayAppointments': instance.todayAppointments,
      'upcomingAppointments': instance.upcomingAppointments,
      'recentActivity': instance.recentActivity,
      'notifications': instance.notifications,
    };

_TodayAppointment _$TodayAppointmentFromJson(Map<String, dynamic> json) =>
    _TodayAppointment(
      appointmentId: json['appointmentId'] as String,
      workerName: json['workerName'] as String,
      serviceName: json['serviceName'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      status: json['status'] as String,
      eta: json['eta'] as String?,
      workerPhoto: json['workerPhoto'] as String?,
    );

Map<String, dynamic> _$TodayAppointmentToJson(_TodayAppointment instance) =>
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

_UpcomingAppointment _$UpcomingAppointmentFromJson(Map<String, dynamic> json) =>
    _UpcomingAppointment(
      appointmentId: json['appointmentId'] as String,
      workerName: json['workerName'] as String,
      serviceName: json['serviceName'] as String,
      date: json['date'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$UpcomingAppointmentToJson(
        _UpcomingAppointment instance) =>
    <String, dynamic>{
      'appointmentId': instance.appointmentId,
      'workerName': instance.workerName,
      'serviceName': instance.serviceName,
      'date': instance.date,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'status': instance.status,
    };

_RecentActivity _$RecentActivityFromJson(Map<String, dynamic> json) =>
    _RecentActivity(
      type: json['type'] as String,
      message: json['message'] as String,
      timestamp: json['timestamp'] as String,
    );

Map<String, dynamic> _$RecentActivityToJson(_RecentActivity instance) =>
    <String, dynamic>{
      'type': instance.type,
      'message': instance.message,
      'timestamp': instance.timestamp,
    };

_ClientNotification _$ClientNotificationFromJson(Map<String, dynamic> json) =>
    _ClientNotification(
      id: json['id'] as String,
      type: json['type'] as String,
      message: json['message'] as String,
      timestamp: json['timestamp'] as String,
      read: json['read'] as bool,
    );

Map<String, dynamic> _$ClientNotificationToJson(_ClientNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'message': instance.message,
      'timestamp': instance.timestamp,
      'read': instance.read,
    };

_WorkerLocation _$WorkerLocationFromJson(Map<String, dynamic> json) =>
    _WorkerLocation(
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

Map<String, dynamic> _$WorkerLocationToJson(_WorkerLocation instance) =>
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

_AppointmentStatus _$AppointmentStatusFromJson(Map<String, dynamic> json) =>
    _AppointmentStatus(
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

Map<String, dynamic> _$AppointmentStatusToJson(_AppointmentStatus instance) =>
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

_ChecklistItem _$ChecklistItemFromJson(Map<String, dynamic> json) =>
    _ChecklistItem(
      item: json['item'] as String,
      completed: json['completed'] as bool,
    );

Map<String, dynamic> _$ChecklistItemToJson(_ChecklistItem instance) =>
    <String, dynamic>{
      'item': instance.item,
      'completed': instance.completed,
    };

_ServiceHistory _$ServiceHistoryFromJson(Map<String, dynamic> json) =>
    _ServiceHistory(
      serviceId: json['serviceId'] as String,
      workerName: json['workerName'] as String,
      serviceName: json['serviceName'] as String,
      date: json['date'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      rating: (json['rating'] as num).toInt(),
      feedback: json['feedback'] as String?,
    );

Map<String, dynamic> _$ServiceHistoryToJson(_ServiceHistory instance) =>
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

_ClientAppointment _$ClientAppointmentFromJson(Map<String, dynamic> json) =>
    _ClientAppointment(
      id: json['id'] as String,
      date: json['date'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      userEmail: json['userEmail'] as String?,
      assignmentId: json['assignmentId'] as String?,
      scheduleId: json['scheduleId'] as String?,
    );

Map<String, dynamic> _$ClientAppointmentToJson(_ClientAppointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'userEmail': instance.userEmail,
      'assignmentId': instance.assignmentId,
      'scheduleId': instance.scheduleId,
    };

_ClientAppointmentDetail _$ClientAppointmentDetailFromJson(
        Map<String, dynamic> json) =>
    _ClientAppointmentDetail(
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

Map<String, dynamic> _$ClientAppointmentDetailToJson(
        _ClientAppointmentDetail instance) =>
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

_ClientEmployee _$ClientEmployeeFromJson(Map<String, dynamic> json) =>
    _ClientEmployee(
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phone: json['phone'] as String?,
      photo: json['photo'] as String?,
    );

Map<String, dynamic> _$ClientEmployeeToJson(_ClientEmployee instance) =>
    <String, dynamic>{
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phone': instance.phone,
      'photo': instance.photo,
    };

_ClientInvoice _$ClientInvoiceFromJson(Map<String, dynamic> json) =>
    _ClientInvoice(
      id: json['id'] as String,
      invoiceNumber: json['invoiceNumber'] as String,
      workflow: json['workflow'] as Map<String, dynamic>,
      financialSummary: json['financialSummary'] as Map<String, dynamic>,
      lineItems: json['lineItems'] as List<dynamic>?,
    );

Map<String, dynamic> _$ClientInvoiceToJson(_ClientInvoice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'invoiceNumber': instance.invoiceNumber,
      'workflow': instance.workflow,
      'financialSummary': instance.financialSummary,
      'lineItems': instance.lineItems,
    };

_AppointmentParams _$AppointmentParamsFromJson(Map<String, dynamic> json) =>
    _AppointmentParams(
      assignmentId: json['assignmentId'] as String,
      scheduleId: json['scheduleId'] as String,
    );

Map<String, dynamic> _$AppointmentParamsToJson(_AppointmentParams instance) =>
    <String, dynamic>{
      'assignmentId': instance.assignmentId,
      'scheduleId': instance.scheduleId,
    };
