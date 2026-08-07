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
    final details = json['details'] as Map<String, dynamic>? ?? {};

    return LeaveRequest(
      id: json['_id']?.toString() ?? '',
      userEmail: json['createdBy']?.toString() ?? '', // Backend uses createdBy
      leaveType:
          details['leaveType']?.toString() ?? json['type']?.toString() ?? '',
      startDate:
          DateTime.tryParse(details['startDate']?.toString() ?? '') ??
          DateTime.now(),
      endDate:
          DateTime.tryParse(details['endDate']?.toString() ?? '') ??
          DateTime.now(),
      totalHours: (details['totalHours'] as num?)?.toDouble() ?? 0.0,
      reason: json['note']?.toString() ?? '', // Backend uses note
      status: json['status']?.toString() ?? 'Pending',
      createdAt:
          DateTime.tryParse(json['createdAt'].toString()) ?? DateTime.now(),
    );
  }
}
