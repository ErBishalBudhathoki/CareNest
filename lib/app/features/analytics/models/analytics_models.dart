class FinancialMetric {
  final String label;
  final double value;
  final String trend;
  FinancialMetric({required this.label, required this.value, required this.trend});
}

class UtilizationMetric {
  final String label;
  final double value;
  UtilizationMetric({required this.label, required this.value});
}

class OvertimeMetric {
  final String employeeName;
  final double hours;
  OvertimeMetric({required this.employeeName, required this.hours});
}

class ReliabilityMetric {
  final String label;
  final double percentage;
  ReliabilityMetric({required this.label, required this.percentage});
}
