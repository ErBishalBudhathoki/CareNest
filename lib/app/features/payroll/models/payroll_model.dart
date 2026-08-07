class PayrollSummary {
  final SummaryTotals summary;
  final BreakdownTotals breakdown;
  final List<PayrollEmployee> employees;
  final List<PayrollAnomaly> anomalies;

  PayrollSummary({
    required this.summary,
    required this.breakdown,
    required this.employees,
    required this.anomalies,
  });

  factory PayrollSummary.fromJson(Map<String, dynamic> json) {
    return PayrollSummary(
      summary: SummaryTotals.fromJson(json['summary']),
      breakdown: BreakdownTotals.fromJson(json['breakdown']),
      employees: (json['employees'] as List)
          .map((e) => PayrollEmployee.fromJson(e))
          .toList(),
      anomalies: (json['anomalies'] as List)
          .map((e) => PayrollAnomaly.fromJson(e))
          .toList(),
    );
  }
}

class SummaryTotals {
  final int totalEmployees;
  final double totalGrossPay;
  final double totalHours;
  final double totalTax;
  final double totalSuper;
  final String periodStart;
  final String periodEnd;

  SummaryTotals({
    required this.totalEmployees,
    required this.totalGrossPay,
    required this.totalHours,
    required this.totalTax,
    required this.totalSuper,
    required this.periodStart,
    required this.periodEnd,
  });

  factory SummaryTotals.fromJson(Map<String, dynamic> json) {
    return SummaryTotals(
      totalEmployees: json['totalEmployees'] ?? 0,
      totalGrossPay: (json['totalGrossPay'] ?? 0).toDouble(),
      totalHours: (json['totalHours'] ?? 0).toDouble(),
      totalTax: (json['totalTax'] ?? 0).toDouble(),
      totalSuper: (json['totalSuper'] ?? 0).toDouble(),
      periodStart: json['periodStart'] ?? '',
      periodEnd: json['periodEnd'] ?? '',
    );
  }
}

class BreakdownTotals {
  final double basePay;
  final double saturdayPenalties;
  final double sundayPenalties;
  final double publicHolidayPenalties;
  final double nightShiftPenalties;
  final double overtimeFirst2h;
  final double overtimeAfter2h;

  BreakdownTotals({
    required this.basePay,
    required this.saturdayPenalties,
    required this.sundayPenalties,
    required this.publicHolidayPenalties,
    required this.nightShiftPenalties,
    required this.overtimeFirst2h,
    required this.overtimeAfter2h,
  });

  factory BreakdownTotals.fromJson(Map<String, dynamic> json) {
    return BreakdownTotals(
      basePay: (json['basePay'] ?? 0).toDouble(),
      saturdayPenalties: (json['saturdayPenalties'] ?? 0).toDouble(),
      sundayPenalties: (json['sundayPenalties'] ?? 0).toDouble(),
      publicHolidayPenalties: (json['publicHolidayPenalties'] ?? 0).toDouble(),
      nightShiftPenalties: (json['nightShiftPenalties'] ?? 0).toDouble(),
      overtimeFirst2h: (json['overtimeFirst2h'] ?? 0).toDouble(),
      overtimeAfter2h: (json['overtimeAfter2h'] ?? 0).toDouble(),
    );
  }
}

class PayrollEmployee {
  final String employeeId;
  final String name;
  final String email;
  final double grossPay;
  final double hoursWorked;
  final double tax;
  final double superAmount;
  final BreakdownTotals
  breakdown; // Assuming same structure for individual breakdown
  final List<PayrollAnomaly> anomalies;

  PayrollEmployee({
    required this.employeeId,
    required this.name,
    required this.email,
    required this.grossPay,
    required this.hoursWorked,
    required this.tax,
    required this.superAmount,
    required this.breakdown,
    this.anomalies = const [],
  });

  factory PayrollEmployee.fromJson(Map<String, dynamic> json) {
    return PayrollEmployee(
      employeeId: json['employeeId'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      grossPay: (json['grossPay'] ?? 0).toDouble(),
      hoursWorked: (json['hoursWorked'] ?? 0).toDouble(),
      tax: (json['tax'] ?? 0).toDouble(),
      superAmount: (json['super'] ?? 0).toDouble(),
      breakdown: BreakdownTotals.fromJson(json['breakdown'] ?? {}),
      anomalies:
          (json['anomalies'] as List?)
              ?.map((e) => PayrollAnomaly.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class PayrollAnomaly {
  final String type;
  final String description;
  final String severity;
  final String? employeeName;

  PayrollAnomaly({
    required this.type,
    required this.description,
    required this.severity,
    this.employeeName,
  });

  factory PayrollAnomaly.fromJson(Map<String, dynamic> json) {
    return PayrollAnomaly(
      type: json['type'] ?? '',
      description: json['description'] ?? '',
      severity: json['severity'] ?? 'medium',
      employeeName: json['employeeName'],
    );
  }
}
