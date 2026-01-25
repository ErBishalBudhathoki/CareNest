class NotificationSettingsModel {
  final bool shiftRemindersEnabled;
  final List<double> shiftReminderTimings;
  final QuietHours? quietHours;
  final bool geofenceEnabled;
  final double geofenceRadius;
  final bool expenseRemindersEnabled;
  final int expenseDeadlineHours;
  final bool timesheetRemindersEnabled;
  final String timesheetReminderTime;

  NotificationSettingsModel({
    this.shiftRemindersEnabled = true,
    this.shiftReminderTimings = const [24, 1, 0.5],
    this.quietHours,
    this.geofenceEnabled = true,
    this.geofenceRadius = 100,
    this.expenseRemindersEnabled = true,
    this.expenseDeadlineHours = 48,
    this.timesheetRemindersEnabled = true,
    this.timesheetReminderTime = '18:00',
  });

  factory NotificationSettingsModel.fromJson(Map<String, dynamic> json) {
    return NotificationSettingsModel(
      shiftRemindersEnabled: json['shiftReminders']?['enabled'] ?? true,
      shiftReminderTimings: (json['shiftReminders']?['timings'] as List?)?.map((e) => (e as num).toDouble()).toList() ?? [24, 1, 0.5],
      quietHours: json['shiftReminders']?['quietHours'] != null ? QuietHours.fromJson(json['shiftReminders']['quietHours']) : null,
      geofenceEnabled: json['geofenceReminders']?['enabled'] ?? true,
      geofenceRadius: (json['geofenceReminders']?['radius'] as num?)?.toDouble() ?? 100,
      expenseRemindersEnabled: json['expenseReminders']?['enabled'] ?? true,
      expenseDeadlineHours: json['expenseReminders']?['deadlineHours'] ?? 48,
      timesheetRemindersEnabled: json['timesheetReminders']?['enabled'] ?? true,
      timesheetReminderTime: json['timesheetReminders']?['time'] ?? '18:00',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shiftReminders': {
        'enabled': shiftRemindersEnabled,
        'timings': shiftReminderTimings,
        'quietHours': quietHours?.toJson(),
      },
      'geofenceReminders': {
        'enabled': geofenceEnabled,
        'radius': geofenceRadius,
      },
      'expenseReminders': {
        'enabled': expenseRemindersEnabled,
        'deadlineHours': expenseDeadlineHours,
      },
      'timesheetReminders': {
        'enabled': timesheetRemindersEnabled,
        'time': timesheetReminderTime,
      },
    };
  }

  NotificationSettingsModel copyWith({
    bool? shiftRemindersEnabled,
    List<double>? shiftReminderTimings,
    QuietHours? quietHours,
    bool? geofenceEnabled,
    double? geofenceRadius,
    bool? expenseRemindersEnabled,
    int? expenseDeadlineHours,
    bool? timesheetRemindersEnabled,
    String? timesheetReminderTime,
  }) {
    return NotificationSettingsModel(
      shiftRemindersEnabled: shiftRemindersEnabled ?? this.shiftRemindersEnabled,
      shiftReminderTimings: shiftReminderTimings ?? this.shiftReminderTimings,
      quietHours: quietHours ?? this.quietHours,
      geofenceEnabled: geofenceEnabled ?? this.geofenceEnabled,
      geofenceRadius: geofenceRadius ?? this.geofenceRadius,
      expenseRemindersEnabled: expenseRemindersEnabled ?? this.expenseRemindersEnabled,
      expenseDeadlineHours: expenseDeadlineHours ?? this.expenseDeadlineHours,
      timesheetRemindersEnabled: timesheetRemindersEnabled ?? this.timesheetRemindersEnabled,
      timesheetReminderTime: timesheetReminderTime ?? this.timesheetReminderTime,
    );
  }
}

class QuietHours {
  final String start;
  final String end;
  final String timezone;

  QuietHours({
    required this.start,
    required this.end,
    this.timezone = 'Australia/Sydney',
  });

  factory QuietHours.fromJson(Map<String, dynamic> json) {
    return QuietHours(
      start: json['start'] ?? '22:00',
      end: json['end'] ?? '07:00',
      timezone: json['timezone'] ?? 'Australia/Sydney',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'start': start,
      'end': end,
      'timezone': timezone,
    };
  }
}
