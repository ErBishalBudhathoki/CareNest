import 'package:freezed_annotation/freezed_annotation.dart';

part 'realtime_portal_models.freezed.dart';
part 'realtime_portal_models.g.dart';

// ============================================================================
// Real-Time Tracking Models
// ============================================================================

@freezed
class LiveLocation with _$LiveLocation {
  const factory LiveLocation({
    required String appointmentId,
    required String workerId,
    required double latitude,
    required double longitude,
    required double accuracy,
    required DateTime timestamp,
    double? distance,
    int? eta,
    String? status,
  }) = _LiveLocation;

  factory LiveLocation.fromJson(Map<String, dynamic> json) =>
      _$LiveLocationFromJson(json);
}

@freezed
class LocationUpdate with _$LocationUpdate {
  const factory LocationUpdate({
    required double latitude,
    required double longitude,
    required double accuracy,
    required DateTime timestamp,
  }) = _LocationUpdate;

  factory LocationUpdate.fromJson(Map<String, dynamic> json) =>
      _$LocationUpdateFromJson(json);
}

@freezed
class GeofenceEvent with _$GeofenceEvent {
  const factory GeofenceEvent({
    required String appointmentId,
    required String event, // 'approaching', 'arrived', 'departed'
    required double distance,
    required DateTime timestamp,
    bool? insideGeofence,
    bool? approaching,
  }) = _GeofenceEvent;

  factory GeofenceEvent.fromJson(Map<String, dynamic> json) =>
      _$GeofenceEventFromJson(json);
}

@freezed
class TrackingSession with _$TrackingSession {
  const factory TrackingSession({
    required String sessionId,
    required String appointmentId,
    required String workerId,
    required String status,
    required DateTime startTime,
    DateTime? endTime,
    ClientLocation? clientLocation,
    List<LocationUpdate>? locations,
    int? duration,
    double? totalDistance,
  }) = _TrackingSession;

  factory TrackingSession.fromJson(Map<String, dynamic> json) =>
      _$TrackingSessionFromJson(json);
}

@freezed
class ClientLocation with _$ClientLocation {
  const factory ClientLocation({
    required double lat,
    required double lng,
    String? address,
  }) = _ClientLocation;

  factory ClientLocation.fromJson(Map<String, dynamic> json) =>
      _$ClientLocationFromJson(json);
}

@freezed
class ETACalculation with _$ETACalculation {
  const factory ETACalculation({
    required int minutes,
    required double distance,
    required double avgSpeed,
    required DateTime estimatedArrival,
    String? trafficCondition,
  }) = _ETACalculation;

  factory ETACalculation.fromJson(Map<String, dynamic> json) =>
      _$ETACalculationFromJson(json);
}

@freezed
class AppointmentStatus with _$AppointmentStatus {
  const factory AppointmentStatus({
    required String appointmentId,
    required String status, // 'scheduled', 'en_route', 'arrived', 'in_progress', 'completed'
    required int progress, // 0-100
    String? notes,
    required DateTime timestamp,
  }) = _AppointmentStatus;

  factory AppointmentStatus.fromJson(Map<String, dynamic> json) =>
      _$AppointmentStatusFromJson(json);
}

@freezed
class ServiceProgress with _$ServiceProgress {
  const factory ServiceProgress({
    required String appointmentId,
    required int progress,
    required List<ProgressStep> steps,
    String? currentStep,
    DateTime? startTime,
    DateTime? estimatedCompletion,
  }) = _ServiceProgress;

  factory ServiceProgress.fromJson(Map<String, dynamic> json) =>
      _$ServiceProgressFromJson(json);
}

@freezed
class ProgressStep with _$ProgressStep {
  const factory ProgressStep({
    required String id,
    required String name,
    required bool completed,
    DateTime? completedAt,
  }) = _ProgressStep;

  factory ProgressStep.fromJson(Map<String, dynamic> json) =>
      _$ProgressStepFromJson(json);
}

// ============================================================================
// Messaging Models
// ============================================================================

@freezed
class SecureMessage with _$SecureMessage {
  const factory SecureMessage({
    required String id,
    required String conversationId,
    required String senderId,
    required String senderType,
    required String senderName,
    required String recipientId,
    required String message,
    List<MessageAttachment>? attachments,
    required DateTime timestamp,
    required bool read,
    DateTime? readAt,
    String? type, // 'text', 'voice', 'file'
  }) = _SecureMessage;

  factory SecureMessage.fromJson(Map<String, dynamic> json) =>
      _$SecureMessageFromJson(json);
}

@freezed
class MessageThread with _$MessageThread {
  const factory MessageThread({
    required String id,
    required String appointmentId,
    required String clientId,
    required String workerId,
    required String organizationId,
    required List<String> participants,
    required DateTime createdAt,
    String? lastMessage,
    DateTime? lastMessageAt,
    Map<String, int>? unreadCount,
  }) = _MessageThread;

  factory MessageThread.fromJson(Map<String, dynamic> json) =>
      _$MessageThreadFromJson(json);
}

@freezed
class MessageAttachment with _$MessageAttachment {
  const factory MessageAttachment({
    required String url,
    required String name,
    required String type,
    required int size,
    String? thumbnail,
  }) = _MessageAttachment;

  factory MessageAttachment.fromJson(Map<String, dynamic> json) =>
      _$MessageAttachmentFromJson(json);
}

@freezed
class VoiceMessage with _$VoiceMessage {
  const factory VoiceMessage({
    required String id,
    required String conversationId,
    required String senderId,
    required String audioUrl,
    required int duration,
    required DateTime timestamp,
    bool? played,
  }) = _VoiceMessage;

  factory VoiceMessage.fromJson(Map<String, dynamic> json) =>
      _$VoiceMessageFromJson(json);
}

@freezed
class TypingIndicator with _$TypingIndicator {
  const factory TypingIndicator({
    required String conversationId,
    required String userId,
    required String userName,
    required bool isTyping,
  }) = _TypingIndicator;

  factory TypingIndicator.fromJson(Map<String, dynamic> json) =>
      _$TypingIndicatorFromJson(json);
}

// ============================================================================
// Digital Signature Models
// ============================================================================

@freezed
class DigitalSignature with _$DigitalSignature {
  const factory DigitalSignature({
    required String id,
    required String appointmentId,
    required String clientId,
    required String signatureData,
    required DateTime timestamp,
    required String hash,
    required bool verified,
    String? ipAddress,
    String? deviceInfo,
  }) = _DigitalSignature;

  factory DigitalSignature.fromJson(Map<String, dynamic> json) =>
      _$DigitalSignatureFromJson(json);
}

@freezed
class ServiceConfirmation with _$ServiceConfirmation {
  const factory ServiceConfirmation({
    required String id,
    required String appointmentId,
    required String clientId,
    required String workerId,
    required String signatureId,
    int? rating,
    String? feedback,
    List<ChecklistItem>? checklist,
    List<String>? photos,
    List<IncidentReport>? incidents,
    required DateTime timestamp,
    required String status,
    String? reportUrl,
  }) = _ServiceConfirmation;

  factory ServiceConfirmation.fromJson(Map<String, dynamic> json) =>
      _$ServiceConfirmationFromJson(json);
}

@freezed
class ChecklistItem with _$ChecklistItem {
  const factory ChecklistItem({
    required int id,
    required String item,
    required bool required,
    bool? completed,
    DateTime? completedAt,
    String? notes,
  }) = _ChecklistItem;

  factory ChecklistItem.fromJson(Map<String, dynamic> json) =>
      _$ChecklistItemFromJson(json);
}

@freezed
class ClientRating with _$ClientRating {
  const factory ClientRating({
    required int stars, // 1-5
    String? feedback,
    List<String>? tags,
    DateTime? timestamp,
  }) = _ClientRating;

  factory ClientRating.fromJson(Map<String, dynamic> json) =>
      _$ClientRatingFromJson(json);
}

@freezed
class IncidentReport with _$IncidentReport {
  const factory IncidentReport({
    required String id,
    required String appointmentId,
    required String reportedBy,
    required String reporterType,
    required String severity, // 'low', 'medium', 'high', 'critical'
    required String category, // 'safety', 'quality', 'behavior', 'equipment', 'other'
    required String description,
    List<String>? photos,
    required DateTime timestamp,
    required String status,
    String? resolution,
    DateTime? resolvedAt,
  }) = _IncidentReport;

  factory IncidentReport.fromJson(Map<String, dynamic> json) =>
      _$IncidentReportFromJson(json);
}

@freezed
class ServiceReport with _$ServiceReport {
  const factory ServiceReport({
    required String appointmentId,
    required String reportUrl,
    required DateTime generatedAt,
    String? pdfPath,
  }) = _ServiceReport;

  factory ServiceReport.fromJson(Map<String, dynamic> json) =>
      _$ServiceReportFromJson(json);
}

// ============================================================================
// Family Access Models
// ============================================================================

@freezed
class FamilyMember with _$FamilyMember {
  const factory FamilyMember({
    required String id,
    required String userId,
    required String clientId,
    required String name,
    required String email,
    required String relationship,
    required String role,
    required FamilyPermissions permissions,
    required String status,
    required DateTime joinedAt,
    NotificationPreferences? notificationPreferences,
    DateTime? updatedAt,
    String? updatedBy,
  }) = _FamilyMember;

  factory FamilyMember.fromJson(Map<String, dynamic> json) =>
      _$FamilyMemberFromJson(json);
}

@freezed
class FamilyPermissions with _$FamilyPermissions {
  const factory FamilyPermissions({
    required bool viewAppointments,
    required bool viewDocuments,
    required bool viewInvoices,
    required bool editProfile,
    required bool approveServices,
    required bool manageFamily,
    required bool viewMessages,
    required bool sendMessages,
    required bool viewLocation,
    required bool receiveNotifications,
  }) = _FamilyPermissions;

  factory FamilyPermissions.fromJson(Map<String, dynamic> json) =>
      _$FamilyPermissionsFromJson(json);
}

@freezed
class FamilyInvitation with _$FamilyInvitation {
  const factory FamilyInvitation({
    required String id,
    required String clientId,
    required String invitedBy,
    required String email,
    required String name,
    required String relationship,
    required String role,
    required FamilyPermissions permissions,
    required String status,
    required DateTime invitedAt,
    required DateTime expiresAt,
    required String token,
  }) = _FamilyInvitation;

  factory FamilyInvitation.fromJson(Map<String, dynamic> json) =>
      _$FamilyInvitationFromJson(json);
}

@freezed
class AccessAuditLog with _$AccessAuditLog {
  const factory AccessAuditLog({
    required String id,
    required String clientId,
    required String userId,
    required String action,
    String? targetUserId,
    Map<String, dynamic>? details,
    required DateTime timestamp,
  }) = _AccessAuditLog;

  factory AccessAuditLog.fromJson(Map<String, dynamic> json) =>
      _$AccessAuditLogFromJson(json);
}

@freezed
class NotificationPreferences with _$NotificationPreferences {
  const factory NotificationPreferences({
    @Default(true) bool email,
    @Default(false) bool sms,
    @Default(true) bool push,
    @Default(true) bool appointmentReminders,
    @Default(true) bool statusUpdates,
    @Default(true) bool emergencyAlerts,
    @Default(true) bool serviceConfirmations,
    QuietHours? quietHours,
  }) = _NotificationPreferences;

  factory NotificationPreferences.fromJson(Map<String, dynamic> json) =>
      _$NotificationPreferencesFromJson(json);
}

@freezed
class QuietHours with _$QuietHours {
  const factory QuietHours({
    required String start,
    required String end,
  }) = _QuietHours;

  factory QuietHours.fromJson(Map<String, dynamic> json) =>
      _$QuietHoursFromJson(json);
}

@freezed
class DocumentShare with _$DocumentShare {
  const factory DocumentShare({
    required String id,
    required String clientId,
    required String documentId,
    required String sharedBy,
    required List<String> sharedWith,
    required List<String> permissions,
    required DateTime sharedAt,
    DateTime? expiresAt,
  }) = _DocumentShare;

  factory DocumentShare.fromJson(Map<String, dynamic> json) =>
      _$DocumentShareFromJson(json);
}

// ============================================================================
// Notification Models
// ============================================================================

@freezed
class PushNotification with _$PushNotification {
  const factory PushNotification({
    required String id,
    required String userId,
    required String title,
    required String body,
    required String type,
    required String priority, // 'critical', 'high', 'normal', 'low'
    Map<String, dynamic>? data,
    List<NotificationAction>? actions,
    required DateTime timestamp,
    bool? read,
    DateTime? readAt,
  }) = _PushNotification;

  factory PushNotification.fromJson(Map<String, dynamic> json) =>
      _$PushNotificationFromJson(json);
}

@freezed
class NotificationAction with _$NotificationAction {
  const factory NotificationAction({
    required String id,
    required String label,
    required String action,
  }) = _NotificationAction;

  factory NotificationAction.fromJson(Map<String, dynamic> json) =>
      _$NotificationActionFromJson(json);
}

// ============================================================================
// WebSocket Models
// ============================================================================

@freezed
class WebSocketEvent with _$WebSocketEvent {
  const factory WebSocketEvent({
    required String event,
    required Map<String, dynamic> data,
    required DateTime timestamp,
  }) = _WebSocketEvent;

  factory WebSocketEvent.fromJson(Map<String, dynamic> json) =>
      _$WebSocketEventFromJson(json);
}

@freezed
class ConnectionStatus with _$ConnectionStatus {
  const factory ConnectionStatus({
    required bool connected,
    String? error,
    DateTime? lastConnected,
    DateTime? lastDisconnected,
  }) = _ConnectionStatus;

  factory ConnectionStatus.fromJson(Map<String, dynamic> json) =>
      _$ConnectionStatusFromJson(json);
}

// ============================================================================
// Emergency Models
// ============================================================================

@freezed
class EmergencyAlert with _$EmergencyAlert {
  const factory EmergencyAlert({
    required String id,
    required String appointmentId,
    required String userId,
    required String userType,
    required ClientLocation location,
    required String message,
    required DateTime timestamp,
    required String status,
    required String priority,
  }) = _EmergencyAlert;

  factory EmergencyAlert.fromJson(Map<String, dynamic> json) =>
      _$EmergencyAlertFromJson(json);
}

// ============================================================================
// Dashboard Models
// ============================================================================

@freezed
class RealtimePortalDashboard with _$RealtimePortalDashboard {
  const factory RealtimePortalDashboard({
    required List<AppointmentStatus> upcomingAppointments,
    LiveLocation? activeTracking,
    int? unreadMessages,
    List<PushNotification>? recentNotifications,
    List<FamilyMember>? familyMembers,
    ServiceConfirmation? lastServiceConfirmation,
  }) = _RealtimePortalDashboard;

  factory RealtimePortalDashboard.fromJson(Map<String, dynamic> json) =>
      _$RealtimePortalDashboardFromJson(json);
}

