class EarningsSummary {
  final double totalHours;
  final double totalEarnings;
  final double payRate;
  final String payType;
  final List<EarningsHistoryItem> history;

  EarningsSummary({
    required this.totalHours,
    required this.totalEarnings,
    required this.payRate,
    required this.payType,
    required this.history,
  });

  factory EarningsSummary.fromJson(Map<String, dynamic> json) {
    return EarningsSummary(
      totalHours: (json['totalHours'] as num? ?? 0).toDouble(),
      totalEarnings: (json['totalEarnings'] as num? ?? 0).toDouble(),
      payRate: (json['payRate'] as num? ?? 0).toDouble(),
      payType: json['payType'] ?? 'Hourly',
      history:
          (json['history'] as List?)
              ?.map((e) => EarningsHistoryItem.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class EarningsHistoryItem {
  final String date;
  final double hours;
  final double earnings;

  EarningsHistoryItem({
    required this.date,
    required this.hours,
    required this.earnings,
  });

  factory EarningsHistoryItem.fromJson(Map<String, dynamic> json) {
    return EarningsHistoryItem(
      date: json['date'] ?? '',
      hours: (json['hours'] as num? ?? 0).toDouble(),
      earnings: (json['earnings'] as num? ?? 0).toDouble(),
    );
  }
}

class ProjectedEarnings {
  final double projectedHours;
  final double projectedEarnings;
  final List<ProjectedItem> breakdown;

  ProjectedEarnings({
    required this.projectedHours,
    required this.projectedEarnings,
    required this.breakdown,
  });

  factory ProjectedEarnings.fromJson(Map<String, dynamic> json) {
    return ProjectedEarnings(
      projectedHours: (json['projectedHours'] as num? ?? 0).toDouble(),
      projectedEarnings: (json['projectedEarnings'] as num? ?? 0).toDouble(),
      breakdown:
          (json['breakdown'] as List?)
              ?.map((e) => ProjectedItem.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class ProjectedItem {
  final String date;
  final String clientEmail;
  final double hours;
  final double earnings;

  ProjectedItem({
    required this.date,
    required this.clientEmail,
    required this.hours,
    required this.earnings,
  });

  factory ProjectedItem.fromJson(Map<String, dynamic> json) {
    return ProjectedItem(
      date: json['date'] ?? '',
      clientEmail: json['clientEmail'] ?? '',
      hours: (json['hours'] as num? ?? 0).toDouble(),
      earnings: (json['earnings'] as num? ?? 0).toDouble(),
    );
  }
}

class EarningsPeriodHistory {
  final String bucket;
  final double payRate;
  final List<EarningsPeriodHistoryItem> items;

  EarningsPeriodHistory({
    required this.bucket,
    required this.payRate,
    required this.items,
  });

  factory EarningsPeriodHistory.fromJson(Map<String, dynamic> json) {
    return EarningsPeriodHistory(
      bucket: json['bucket'] ?? 'month',
      payRate: (json['payRate'] as num? ?? 0).toDouble(),
      items:
          (json['items'] as List?)
              ?.map((e) => EarningsPeriodHistoryItem.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class EarningsPeriodHistoryItem {
  final String periodStart;
  final String periodEnd;
  final double hours;
  final double earnings;

  EarningsPeriodHistoryItem({
    required this.periodStart,
    required this.periodEnd,
    required this.hours,
    required this.earnings,
  });

  factory EarningsPeriodHistoryItem.fromJson(Map<String, dynamic> json) {
    return EarningsPeriodHistoryItem(
      periodStart: json['periodStart'] ?? '',
      periodEnd: json['periodEnd'] ?? '',
      hours: (json['hours'] as num? ?? 0).toDouble(),
      earnings: (json['earnings'] as num? ?? 0).toDouble(),
    );
  }
}
