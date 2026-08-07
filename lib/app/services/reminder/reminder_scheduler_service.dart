import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

/// Service for scheduling and managing shift reminders.
/// Handles 30-minute, 1-hour, and 1-day advance notifications.
class ReminderSchedulerService {
  static const String _scheduledRemindersKey = 'scheduled_shift_reminders';

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  /// Initialize the reminder scheduler with timezone support.
  Future<void> initialize() async {
    if (_isInitialized) return;

    // Initialize timezone database
    tz_data.initializeTimeZones();

    // Create reminder-specific notification channels
    await _createReminderChannels();

    _isInitialized = true;
    debugPrint('ReminderSchedulerService: Initialized');
  }

  /// Schedule reminders for an upcoming appointment/shift.
  ///
  /// Creates notifications at:
  /// - 1 day before
  /// - 1 hour before
  /// - 30 minutes before
  Future<void> scheduleShiftReminders({
    required String appointmentId,
    required String clientName,
    required DateTime shiftStartTime,
    required String userEmail,
    String? clientAddress,
  }) async {
    await initialize();

    final now = DateTime.now();

    // Don't schedule reminders for past appointments
    if (shiftStartTime.isBefore(now)) {
      debugPrint(
        'ReminderSchedulerService: Skipping past appointment $appointmentId',
      );
      return;
    }

    // Cancel any existing reminders for this appointment
    await cancelShiftReminders(appointmentId);

    final List<_ReminderConfig> reminders = [
      _ReminderConfig(
        offsetMinutes: 24 * 60, // 1 day
        title: 'Shift Tomorrow',
        body:
            'You have a shift with $clientName tomorrow at ${_formatTime(shiftStartTime)}',
        idSuffix: 'day',
      ),
      _ReminderConfig(
        offsetMinutes: 60, // 1 hour
        title: 'Shift in 1 Hour',
        body:
            'Your shift with $clientName starts in 1 hour${clientAddress != null ? ' at $clientAddress' : ''}',
        idSuffix: 'hour',
      ),
      _ReminderConfig(
        offsetMinutes: 30, // 30 minutes
        title: 'Shift Starting Soon',
        body:
            'Your shift with $clientName starts in 30 minutes. Time to head out!',
        idSuffix: '30min',
      ),
    ];

    final List<String> scheduledIds = [];

    for (final reminder in reminders) {
      final reminderTime = shiftStartTime.subtract(
        Duration(minutes: reminder.offsetMinutes),
      );

      // Only schedule if reminder time is in the future
      if (reminderTime.isAfter(now)) {
        final notificationId = _generateNotificationId(
          appointmentId,
          reminder.idSuffix,
        );

        await _scheduleNotification(
          id: notificationId,
          title: reminder.title,
          body: reminder.body,
          scheduledTime: reminderTime,
          payload: {
            'type': 'shift_reminder',
            'appointmentId': appointmentId,
            'clientName': clientName,
            'shiftStartTime': shiftStartTime.toIso8601String(),
            'userEmail': userEmail,
            'reminderType': reminder.idSuffix,
          },
        );

        scheduledIds.add('${appointmentId}_${reminder.idSuffix}');
        debugPrint(
          'ReminderSchedulerService: Scheduled ${reminder.idSuffix} reminder for $appointmentId at $reminderTime',
        );
      }
    }

    // Persist scheduled reminder IDs for later cancellation
    await _persistScheduledReminders(appointmentId, scheduledIds);
  }

  /// Cancel all reminders for a specific appointment.
  Future<void> cancelShiftReminders(String appointmentId) async {
    final suffixes = ['day', 'hour', '30min'];

    for (final suffix in suffixes) {
      final notificationId = _generateNotificationId(appointmentId, suffix);
      await _notificationsPlugin.cancel(id: notificationId);
    }

    await _removePersistedReminders(appointmentId);
    debugPrint(
      'ReminderSchedulerService: Cancelled reminders for $appointmentId',
    );
  }

  /// Reschedule all reminders on app startup.
  /// This is needed because scheduled notifications may be cleared on device restart.
  Future<void> rescheduleAllReminders(
    List<Map<String, dynamic>> upcomingAppointments,
  ) async {
    await initialize();

    debugPrint(
      'ReminderSchedulerService: Rescheduling ${upcomingAppointments.length} appointments',
    );

    for (final appointment in upcomingAppointments) {
      try {
        final appointmentId = appointment['id']?.toString();
        final clientName = appointment['clientName']?.toString() ?? 'Client';
        final shiftStartTimeStr = appointment['shiftStartTime']?.toString();
        final userEmail = appointment['userEmail']?.toString() ?? '';
        final clientAddress = appointment['clientAddress']?.toString();

        if (appointmentId == null || shiftStartTimeStr == null) continue;

        final shiftStartTime = DateTime.tryParse(shiftStartTimeStr);
        if (shiftStartTime == null) continue;

        await scheduleShiftReminders(
          appointmentId: appointmentId,
          clientName: clientName,
          shiftStartTime: shiftStartTime,
          userEmail: userEmail,
          clientAddress: clientAddress,
        );
      } catch (e) {
        debugPrint(
          'ReminderSchedulerService: Error rescheduling appointment: $e',
        );
      }
    }
  }

  /// Get all pending notifications for debugging.
  Future<List<PendingNotificationRequest>> getPendingReminders() async {
    return _notificationsPlugin.pendingNotificationRequests();
  }

  // Private methods

  Future<void> _scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
    required Map<String, dynamic> payload,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'shift_reminders',
          'Shift Reminders',
          channelDescription: 'Reminders for upcoming shifts',
          importance: Importance.high,
          priority: Priority.high,
          enableVibration: true,
          playSound: true,
          category: AndroidNotificationCategory.reminder,
        );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      interruptionLevel: InterruptionLevel.timeSensitive,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    final tz.TZDateTime tzScheduledTime = tz.TZDateTime.from(
      scheduledTime,
      tz.local,
    );

    try {
      await _notificationsPlugin.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: tzScheduledTime,
        notificationDetails: notificationDetails,
        payload: jsonEncode(payload),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: null,
      );
    } on PlatformException catch (e) {
      if (e.code == 'exact_alarms_not_permitted') {
        debugPrint(
          'ReminderSchedulerService: Exact alarms not permitted, falling back to inexact',
        );
        await _notificationsPlugin.zonedSchedule(
          id: id,
          title: title,
          body: body,
          scheduledDate: tzScheduledTime,
          notificationDetails: notificationDetails,
          payload: jsonEncode(payload),
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          matchDateTimeComponents: null,
        );
      } else {
        rethrow;
      }
    }
  }

  Future<void> _createReminderChannels() async {
    final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
        _notificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();

    if (androidPlugin != null) {
      const AndroidNotificationChannel shiftReminderChannel =
          AndroidNotificationChannel(
            'shift_reminders',
            'Shift Reminders',
            description: 'Reminders for upcoming shifts and appointments',
            importance: Importance.high,
            playSound: true,
            enableVibration: true,
            showBadge: true,
          );

      const AndroidNotificationChannel timesheetReminderChannel =
          AndroidNotificationChannel(
            'timesheet_reminders',
            'Timesheet Reminders',
            description: 'Weekly reminders to submit timesheets',
            importance: Importance.high,
            playSound: true,
            enableVibration: true,
            showBadge: true,
          );

      const AndroidNotificationChannel expenseReminderChannel =
          AndroidNotificationChannel(
            'expense_reminders',
            'Expense Reminders',
            description: 'Reminders to upload expense receipts',
            importance: Importance.defaultImportance,
            playSound: true,
            enableVibration: true,
            showBadge: true,
          );

      await androidPlugin.createNotificationChannel(shiftReminderChannel);
      await androidPlugin.createNotificationChannel(timesheetReminderChannel);
      await androidPlugin.createNotificationChannel(expenseReminderChannel);

      debugPrint(
        'ReminderSchedulerService: Created reminder notification channels',
      );
    }
  }

  int _generateNotificationId(String appointmentId, String suffix) {
    // Create a unique but deterministic ID from appointment ID and suffix
    return '${appointmentId}_$suffix'.hashCode & 0x7fffffff;
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:$minute $period';
  }

  Future<void> _persistScheduledReminders(
    String appointmentId,
    List<String> ids,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final existing = prefs.getStringList(_scheduledRemindersKey) ?? [];

      // Remove old entries for this appointment
      existing.removeWhere((entry) => entry.startsWith('$appointmentId:'));

      // Add new entry
      existing.add('$appointmentId:${ids.join(',')}');

      await prefs.setStringList(_scheduledRemindersKey, existing);
    } catch (e) {
      debugPrint('ReminderSchedulerService: Error persisting reminders: $e');
    }
  }

  Future<void> _removePersistedReminders(String appointmentId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final existing = prefs.getStringList(_scheduledRemindersKey) ?? [];

      existing.removeWhere((entry) => entry.startsWith('$appointmentId:'));

      await prefs.setStringList(_scheduledRemindersKey, existing);
    } catch (e) {
      debugPrint(
        'ReminderSchedulerService: Error removing persisted reminders: $e',
      );
    }
  }
}

/// Internal configuration for reminder types.
class _ReminderConfig {
  final int offsetMinutes;
  final String title;
  final String body;
  final String idSuffix;

  const _ReminderConfig({
    required this.offsetMinutes,
    required this.title,
    required this.body,
    required this.idSuffix,
  });
}
