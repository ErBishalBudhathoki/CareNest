class TimingPrediction {
  final String? id;
  final String userId;
  final String notificationType;
  final int predictedHour;
  final double confidenceScore;
  final bool active;
  final DateTime lastUpdated;

  const TimingPrediction({
    this.id,
    required this.userId,
    required this.notificationType,
    required this.predictedHour,
    required this.confidenceScore,
    this.active = true,
    required this.lastUpdated,
  });

  factory TimingPrediction.fromJson(Map<String, dynamic> json) {
    return TimingPrediction(
      id: json['_id'] as String?,
      userId: json['userId'] as String,
      notificationType: json['notificationType'] as String,
      predictedHour: json['predictedHour'] as int,
      confidenceScore: (json['confidenceScore'] as num).toDouble(),
      active: json['active'] as bool? ?? true,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      'userId': userId,
      'notificationType': notificationType,
      'predictedHour': predictedHour,
      'confidenceScore': confidenceScore,
      'active': active,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  TimingPrediction copyWith({
    String? id,
    String? userId,
    String? notificationType,
    int? predictedHour,
    double? confidenceScore,
    bool? active,
    DateTime? lastUpdated,
  }) {
    return TimingPrediction(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      notificationType: notificationType ?? this.notificationType,
      predictedHour: predictedHour ?? this.predictedHour,
      confidenceScore: confidenceScore ?? this.confidenceScore,
      active: active ?? this.active,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}

class CalendarEvent {
  final String? id;
  final String userId;
  final String provider;
  final String externalEventId;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final bool isAllDay;
  final String? location;
  final String status;

  const CalendarEvent({
    this.id,
    required this.userId,
    required this.provider,
    required this.externalEventId,
    required this.title,
    required this.startTime,
    required this.endTime,
    this.isAllDay = false,
    this.location,
    this.status = 'confirmed',
  });

  factory CalendarEvent.fromJson(Map<String, dynamic> json) {
    return CalendarEvent(
      id: json['_id'] as String?,
      userId: json['userId'] as String,
      provider: json['provider'] as String,
      externalEventId: json['externalEventId'] as String,
      title: json['title'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      isAllDay: json['isAllDay'] as bool? ?? false,
      location: json['location'] as String?,
      status: json['status'] as String? ?? 'confirmed',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      'userId': userId,
      'provider': provider,
      'externalEventId': externalEventId,
      'title': title,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'isAllDay': isAllDay,
      'location': location,
      'status': status,
    };
  }
}

class SnoozeRule {
  final String? id;
  final String userId;
  final String? keyword;
  final String? sender;
  final int snoozeDurationMinutes;
  final DateTime? snoozeUntil;
  final bool autoReply;
  final String? autoReplyMessage;
  final bool active;

  const SnoozeRule({
    this.id,
    required this.userId,
    this.keyword,
    this.sender,
    required this.snoozeDurationMinutes,
    this.snoozeUntil,
    this.autoReply = false,
    this.autoReplyMessage,
    this.active = true,
  });

  factory SnoozeRule.fromJson(Map<String, dynamic> json) {
    return SnoozeRule(
      id: json['_id'] as String?,
      userId: json['userId'] as String,
      keyword: json['keyword'] as String?,
      sender: json['sender'] as String?,
      snoozeDurationMinutes: json['snoozeDurationMinutes'] as int,
      snoozeUntil: json['snoozeUntil'] != null
          ? DateTime.parse(json['snoozeUntil'] as String)
          : null,
      autoReply: json['autoReply'] as bool? ?? false,
      autoReplyMessage: json['autoReplyMessage'] as String?,
      active: json['active'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      'userId': userId,
      'keyword': keyword,
      'sender': sender,
      'snoozeDurationMinutes': snoozeDurationMinutes,
      'snoozeUntil': snoozeUntil?.toIso8601String(),
      'autoReply': autoReply,
      'autoReplyMessage': autoReplyMessage,
      'active': active,
    };
  }

  SnoozeRule copyWith({
    String? id,
    String? userId,
    String? keyword,
    String? sender,
    int? snoozeDurationMinutes,
    DateTime? snoozeUntil,
    bool? autoReply,
    String? autoReplyMessage,
    bool? active,
  }) {
    return SnoozeRule(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      keyword: keyword ?? this.keyword,
      sender: sender ?? this.sender,
      snoozeDurationMinutes:
          snoozeDurationMinutes ?? this.snoozeDurationMinutes,
      snoozeUntil: snoozeUntil ?? this.snoozeUntil,
      autoReply: autoReply ?? this.autoReply,
      autoReplyMessage: autoReplyMessage ?? this.autoReplyMessage,
      active: active ?? this.active,
    );
  }
}
