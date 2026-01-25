class LeaveBalance {
  final double annualLeave;
  final double sickLeave;
  final double personalLeave;
  final double longServiceLeave;

  LeaveBalance({
    required this.annualLeave,
    required this.sickLeave,
    required this.personalLeave,
    required this.longServiceLeave,
  });

  factory LeaveBalance.fromJson(Map<String, dynamic> json) {
    return LeaveBalance(
      annualLeave: (json['annualLeave'] as num?)?.toDouble() ?? 0.0,
      sickLeave: (json['sickLeave'] as num?)?.toDouble() ?? 0.0,
      personalLeave: (json['personalLeave'] as num?)?.toDouble() ?? 0.0,
      longServiceLeave: (json['longServiceLeave'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
