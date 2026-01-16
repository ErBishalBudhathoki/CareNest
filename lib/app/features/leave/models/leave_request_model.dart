class LeaveRequest {
  final String id;
  final String userEmail;
  final String leaveType;
  final DateTime startDate;
  final DateTime endDate;
  final double totalHours;
  final String reason;
  final String status;
  final DateTime createdAt;

  LeaveRequest({
    required this.id,
    required this.userEmail,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.totalHours,
    required this.reason,
    required this.status,
    required this.createdAt,
  });

  factory LeaveRequest.fromJson(Map<String, dynamic> json) {
    return LeaveRequest(
      id: json['_id']?.toString() ?? '',
      userEmail: json['userEmail']?.toString() ?? '',
      leaveType: json['leaveType']?.toString() ?? '',
      startDate: DateTime.tryParse(json['startDate'].toString()) ?? DateTime.now(),
      endDate: DateTime.tryParse(json['endDate'].toString()) ?? DateTime.now(),
      totalHours: (json['totalHours'] as num?)?.toDouble() ?? 0.0,
      reason: json['reason']?.toString() ?? '',
      status: json['status']?.toString() ?? 'Pending',
      createdAt: DateTime.tryParse(json['createdAt'].toString()) ?? DateTime.now(),
    );
  }
}
