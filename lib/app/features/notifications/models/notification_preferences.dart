import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_preferences.freezed.dart';
part 'notification_preferences.g.dart';

/// Notification channel types
enum NotificationChannel { push, sms, email }

/// Notification category types
enum NotificationCategory {
  shiftChanges,
  geofence,
  compliance,
  approvals,
  messages,
  payments,
  system,
}

/// Priority levels for notifications
enum NotificationPriority { low, medium, high, urgent }

/// User notification preferences
@freezed
abstract class NotificationPreferences with _$NotificationPreferences {
  const factory NotificationPreferences({
    required String userId,
    required Map<NotificationCategory, bool> categoryEnabled,
    required Map<NotificationCategory, List<NotificationChannel>>
    categoryChannels,
    required QuietHours quietHours,
    @Default(true) bool smartTimingEnabled,
    @Default(true) bool geofenceEnabled,
    @Default(5.0) double geofenceRadiusKm,
    @Default(true) bool soundEnabled,
    @Default(true) bool vibrationEnabled,
    @Default(true) bool badgeEnabled,
    DateTime? lastUpdated,
  }) = _NotificationPreferences;

  factory NotificationPreferences.fromJson(Map<String, dynamic> json) =>
      _$NotificationPreferencesFromJson(json);

  /// Default preferences for new users
  factory NotificationPreferences.defaultPreferences(String userId) {
    return NotificationPreferences(
      userId: userId,
      categoryEnabled: {
        NotificationCategory.shiftChanges: true,
        NotificationCategory.geofence: true,
        NotificationCategory.compliance: true,
        NotificationCategory.approvals: true,
        NotificationCategory.messages: true,
        NotificationCategory.payments: true,
        NotificationCategory.system: true,
      },
      categoryChannels: {
        NotificationCategory.shiftChanges: [
          NotificationChannel.push,
          NotificationChannel.sms,
        ],
        NotificationCategory.geofence: [NotificationChannel.push],
        NotificationCategory.compliance: [
          NotificationChannel.push,
          NotificationChannel.email,
        ],
        NotificationCategory.approvals: [NotificationChannel.push],
        NotificationCategory.messages: [
          NotificationChannel.push,
          NotificationChannel.sms,
        ],
        NotificationCategory.payments: [
          NotificationChannel.push,
          NotificationChannel.email,
        ],
        NotificationCategory.system: [NotificationChannel.push],
      },
      quietHours: QuietHours.defaultQuietHours(),
      lastUpdated: DateTime.now(),
    );
  }
}

/// Quiet hours configuration
@freezed
abstract class QuietHours with _$QuietHours {
  const factory QuietHours({
    @Default(false) bool enabled,
    @Default('22:00') String startTime, // HH:mm format
    @Default('08:00') String endTime, // HH:mm format
    @Default([]) List<int> daysOfWeek, // 0=Sunday, 6=Saturday
  }) = _QuietHours;

  factory QuietHours.fromJson(Map<String, dynamic> json) =>
      _$QuietHoursFromJson(json);

  factory QuietHours.defaultQuietHours() {
    return const QuietHours(
      enabled: true,
      startTime: '22:00',
      endTime: '08:00',
      daysOfWeek: [0, 1, 2, 3, 4, 5, 6], // All days
    );
  }
}

/// Geofence notification event
@freezed
abstract class GeofenceEvent with _$GeofenceEvent {
  const factory GeofenceEvent({
    required String eventId,
    required String workerId,
    required String workerName,
    required String appointmentId,
    required String clientName,
    required String clientAddress,
    required GeofenceEventType eventType,
    required DateTime timestamp,
    required double latitude,
    required double longitude,
    double? distanceMeters,
    String? notes,
  }) = _GeofenceEvent;

  factory GeofenceEvent.fromJson(Map<String, dynamic> json) =>
      _$GeofenceEventFromJson(json);
}

/// Geofence event types
enum GeofenceEventType { arrived, departed, runningLate, nearLocation }

/// Shift change notification
@freezed
abstract class ShiftChangeNotification with _$ShiftChangeNotification {
  const factory ShiftChangeNotification({
    required String notificationId,
    required String shiftId,
    required String workerId,
    required String workerName,
    required String clientName,
    required ShiftChangeType changeType,
    required DateTime shiftDate,
    required String shiftTime,
    String? oldTime,
    String? newTime,
    String? reason,
    String? replacementWorkerId,
    String? replacementWorkerName,
    required DateTime timestamp,
  }) = _ShiftChangeNotification;

  factory ShiftChangeNotification.fromJson(Map<String, dynamic> json) =>
      _$ShiftChangeNotificationFromJson(json);
}

/// Shift change types
enum ShiftChangeType {
  assigned,
  cancelled,
  timeChanged,
  replacementNeeded,
  replacementFound,
}

/// Smart timing recommendation
@freezed
abstract class SmartTimingRecommendation with _$SmartTimingRecommendation {
  const factory SmartTimingRecommendation({
    required String userId,
    required NotificationCategory category,
    required DateTime recommendedTime,
    required double confidence,
    required String reason,
    Map<String, dynamic>? metadata,
  }) = _SmartTimingRecommendation;

  factory SmartTimingRecommendation.fromJson(Map<String, dynamic> json) =>
      _$SmartTimingRecommendationFromJson(json);
}

/// Notification delivery status
@freezed
abstract class NotificationDeliveryStatus with _$NotificationDeliveryStatus {
  const factory NotificationDeliveryStatus({
    required String notificationId,
    required Map<NotificationChannel, DeliveryResult> channelResults,
    required DateTime sentAt,
    DateTime? deliveredAt,
    DateTime? readAt,
    DateTime? actionedAt,
  }) = _NotificationDeliveryStatus;

  factory NotificationDeliveryStatus.fromJson(Map<String, dynamic> json) =>
      _$NotificationDeliveryStatusFromJson(json);
}

/// Delivery result for a channel
@freezed
abstract class DeliveryResult with _$DeliveryResult {
  const factory DeliveryResult({
    required bool success,
    String? errorMessage,
    String? messageId,
    DateTime? timestamp,
  }) = _DeliveryResult;

  factory DeliveryResult.fromJson(Map<String, dynamic> json) =>
      _$DeliveryResultFromJson(json);
}
