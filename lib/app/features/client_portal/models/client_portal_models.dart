import 'package:freezed_annotation/freezed_annotation.dart';

part 'client_portal_models.freezed.dart';
part 'client_portal_models.g.dart';

@freezed
class ClientDashboard with _$ClientDashboard {
  const factory ClientDashboard({
    required String clientId,
    required String clientName,
    required List<TodayAppointment> todayAppointments,
    required List<UpcomingAppointment> upcomingAppointments,
    required List<RecentActivity> recentActivity,
    required List<ClientNotification> notifications,
  }) = _ClientDashboard;

  factory ClientDashboard.fromJson(Map<String, dynamic> json) =>
      _$ClientDashboardFromJson(json);
}

@freezed
class TodayAppointment with _$TodayAppointment {
  const factory TodayAppointment({
    required String appointmentId,
    required String workerName,
    required String serviceName,
    required String startTime,
    required String endTime,
    required String status,
    String? eta,
    String? workerPhoto,
  }) = _TodayAppointment;

  factory TodayAppointment.fromJson(Map<String, dynamic> json) =>
      _$TodayAppointmentFromJson(json);
}

@freezed
class UpcomingAppointment with _$UpcomingAppointment {
  const factory UpcomingAppointment({
    required String appointmentId,
    required String workerName,
    required String serviceName,
    required String date,
    required String startTime,
    required String endTime,
    required String status,
  }) = _UpcomingAppointment;

  factory UpcomingAppointment.fromJson(Map<String, dynamic> json) =>
      _$UpcomingAppointmentFromJson(json);
}

@freezed
class RecentActivity with _$RecentActivity {
  const factory RecentActivity({
    required String type,
    required String message,
    required String timestamp,
  }) = _RecentActivity;

  factory RecentActivity.fromJson(Map<String, dynamic> json) =>
      _$RecentActivityFromJson(json);
}

@freezed
class ClientNotification with _$ClientNotification {
  const factory ClientNotification({
    required String id,
    required String type,
    required String message,
    required String timestamp,
    required bool read,
  }) = _ClientNotification;

  factory ClientNotification.fromJson(Map<String, dynamic> json) =>
      _$ClientNotificationFromJson(json);
}

@freezed
class WorkerLocation with _$WorkerLocation {
  const factory WorkerLocation({
    required String appointmentId,
    required String workerName,
    required double latitude,
    required double longitude,
    required double accuracy,
    required String timestamp,
    required bool isEnRoute,
    String? eta,
    double? distanceRemaining,
    String? lastUpdated,
  }) = _WorkerLocation;

  factory WorkerLocation.fromJson(Map<String, dynamic> json) =>
      _$WorkerLocationFromJson(json);
}

@freezed
class AppointmentStatus with _$AppointmentStatus {
  const factory AppointmentStatus({
    required String appointmentId,
    required String status,
    required String workerName,
    required String serviceName,
    required String startTime,
    required String endTime,
    String? actualStartTime,
    String? actualEndTime,
    String? eta,
    required List<String> notes,
    required List<String> photos,
    required List<ChecklistItem> checklistItems,
    required String lastUpdated,
  }) = _AppointmentStatus;

  factory AppointmentStatus.fromJson(Map<String, dynamic> json) =>
      _$AppointmentStatusFromJson(json);
}

@freezed
class ChecklistItem with _$ChecklistItem {
  const factory ChecklistItem({
    required String item,
    required bool completed,
  }) = _ChecklistItem;

  factory ChecklistItem.fromJson(Map<String, dynamic> json) =>
      _$ChecklistItemFromJson(json);
}

@freezed
class ServiceHistory with _$ServiceHistory {
  const factory ServiceHistory({
    required String serviceId,
    required String workerName,
    required String serviceName,
    required String date,
    required String startTime,
    required String endTime,
    required int rating,
    String? feedback,
  }) = _ServiceHistory;

  factory ServiceHistory.fromJson(Map<String, dynamic> json) =>
      _$ServiceHistoryFromJson(json);
}


// Additional models for existing client portal views
@freezed
class ClientAppointment with _$ClientAppointment {
  const factory ClientAppointment({
    required String id,
    required String date,
    required String startTime,
    required String endTime,
    String? userEmail,
    String? assignmentId,
    String? scheduleId,
  }) = _ClientAppointment;

  factory ClientAppointment.fromJson(Map<String, dynamic> json) =>
      _$ClientAppointmentFromJson(json);
}

@freezed
class ClientAppointmentDetail with _$ClientAppointmentDetail {
  const factory ClientAppointmentDetail({
    required String id,
    required String date,
    required String startTime,
    required String endTime,
    required String status,
    String? notes,
    ClientEmployee? employee,
    List<String>? services,
    String? serviceName,
    String? location,
    String? assignmentId,
    String? scheduleId,
  }) = _ClientAppointmentDetail;

  factory ClientAppointmentDetail.fromJson(Map<String, dynamic> json) =>
      _$ClientAppointmentDetailFromJson(json);
}

@freezed
class ClientEmployee with _$ClientEmployee {
  const factory ClientEmployee({
    required String email,
    required String firstName,
    required String lastName,
    String? phone,
    String? photo,
  }) = _ClientEmployee;

  factory ClientEmployee.fromJson(Map<String, dynamic> json) =>
      _$ClientEmployeeFromJson(json);
}

@freezed
class ClientInvoice with _$ClientInvoice {
  const factory ClientInvoice({
    required String id,
    required String invoiceNumber,
    required Map<String, dynamic> workflow,
    required Map<String, dynamic> financialSummary,
    List<dynamic>? lineItems,
  }) = _ClientInvoice;

  factory ClientInvoice.fromJson(Map<String, dynamic> json) =>
      _$ClientInvoiceFromJson(json);
}

@freezed
class AppointmentParams with _$AppointmentParams {
  const factory AppointmentParams({
    required String assignmentId,
    required String scheduleId,
  }) = _AppointmentParams;

  factory AppointmentParams.fromJson(Map<String, dynamic> json) =>
      _$AppointmentParamsFromJson(json);
}
