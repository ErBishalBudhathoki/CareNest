class FinancialMetric {
  final String date;
  final double revenue;
  final double laborCost;
  final double margin;

  FinancialMetric({
    required this.date,
    required this.revenue,
    required this.laborCost,
    required this.margin,
  });
  
  factory FinancialMetric.fromJson(Map<String, dynamic> json) {
    return FinancialMetric(
      date: json['date'] ?? '',
      revenue: (json['revenue'] as num?)?.toDouble() ?? 0.0,
      laborCost: (json['laborCost'] as num?)?.toDouble() ?? 0.0,
      margin: (json['margin'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class UtilizationMetric {
  final String employeeName;
  final String email;
  final double billableHours;
  final double capacityHours;
  final double utilizationRate;

  UtilizationMetric({
    required this.employeeName,
    required this.email,
    required this.billableHours,
    required this.capacityHours,
    required this.utilizationRate,
  });
  
  factory UtilizationMetric.fromJson(Map<String, dynamic> json) {
    return UtilizationMetric(
      employeeName: json['employeeName'] ?? 'Unknown',
      email: json['email'] ?? '',
      billableHours: (json['billableHours'] as num?)?.toDouble() ?? 0.0,
      capacityHours: (json['capacityHours'] as num?)?.toDouble() ?? 0.0,
      utilizationRate: (json['utilizationRate'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class OvertimeMetric {
  final String employeeName;
  final String employeeEmail;
  final double totalHours;
  final double overtimeHours;
  final List<DailyOvertime> dailyBreakdown;

  OvertimeMetric({
    required this.employeeName,
    required this.employeeEmail,
    required this.totalHours,
    required this.overtimeHours,
    this.dailyBreakdown = const [],
  });

  factory OvertimeMetric.fromJson(Map<String, dynamic> json) {
    return OvertimeMetric(
      employeeName: json['employeeName'] ?? 'Unknown',
      employeeEmail: json['employeeEmail'] ?? '',
      totalHours: (json['totalHours'] as num?)?.toDouble() ?? 0.0,
      overtimeHours: (json['overtimeHours'] as num?)?.toDouble() ?? 0.0,
      dailyBreakdown: (json['dailyBreakdown'] as List?)
              ?.map((e) => DailyOvertime.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class DailyOvertime {
  final String date;
  final double hours;

  DailyOvertime({required this.date, required this.hours});

  factory DailyOvertime.fromJson(Map<String, dynamic> json) {
    return DailyOvertime(
      date: json['date'] ?? '',
      hours: (json['hours'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class ReliabilityMetric {
  final String employeeEmail;
  final int totalScheduled;
  final int filledShifts;
  final int noShows;
  final double shiftFillRate;
  final double noShowRate;

  ReliabilityMetric({
    required this.employeeEmail,
    required this.totalScheduled,
    required this.filledShifts,
    required this.noShows,
    required this.shiftFillRate,
    required this.noShowRate,
  });

  factory ReliabilityMetric.fromJson(Map<String, dynamic> json) {
    return ReliabilityMetric(
      employeeEmail: json['employeeEmail'] ?? '',
      totalScheduled: json['totalScheduled'] ?? 0,
      filledShifts: json['filledShifts'] ?? 0,
      noShows: json['noShows'] ?? 0,
      shiftFillRate: (json['shiftFillRate'] as num?)?.toDouble() ?? 0.0,
      noShowRate: (json['noShowRate'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
