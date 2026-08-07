class RecurrenceInfo {
  final bool isRecurring;
  final String frequency; // 'weekly', 'monthly', etc.
  final DateTime? nextDate;

  RecurrenceInfo({
    required this.isRecurring,
    required this.frequency,
    this.nextDate,
  });

  factory RecurrenceInfo.fromJson(Map<String, dynamic> json) {
    return RecurrenceInfo(
      isRecurring: json['isRecurring'] ?? false,
      frequency: json['frequency'] ?? 'monthly',
      nextDate: json['nextDate'] != null
          ? DateTime.parse(json['nextDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isRecurring': isRecurring,
      'frequency': frequency,
      'nextDate': nextDate?.toIso8601String(),
    };
  }
}
