class TimesheetEntry {
  final String id;
  final String userEmail;
  final String? clientEmail;
  final String? timeWorked; // "00:00:12"
  final String? shiftDate; // "2025-07-30"
  final String? shiftStartTime; // "8:00 AM"
  final String? shiftEndTime; // "9:00 AM"
  final String? totalHours; // Can be int or string in JSON
  final DateTime? workDate;
  final String? status;

  TimesheetEntry({
    required this.id,
    required this.userEmail,
    this.clientEmail,
    this.timeWorked,
    this.shiftDate,
    this.shiftStartTime,
    this.shiftEndTime,
    this.totalHours,
    this.workDate,
    this.status,
  });

  factory TimesheetEntry.fromJson(Map<String, dynamic> json) {
    // Handle MongoDB _id
    String id = '';
    if (json['_id'] is Map && json['_id']['\$oid'] != null) {
      id = json['_id']['\$oid'];
    } else if (json['_id'] is String) {
      id = json['_id'];
    } else if (json['id'] != null) {
      id = json['id'].toString();
    }

    // Handle Dates
    DateTime? workDateParsed;
    if (json['workDate'] != null) {
      if (json['workDate'] is Map && json['workDate']['\$date'] != null) {
        workDateParsed = DateTime.tryParse(json['workDate']['\$date']);
      } else if (json['workDate'] is String) {
        workDateParsed = DateTime.tryParse(json['workDate']);
      }
    }

    // Handle timeWorked
    String? timeWorkedStr;
    if (json['timeWorked'] is num) {
      int seconds = (json['timeWorked'] as num).toInt();
      int h = seconds ~/ 3600;
      int m = (seconds % 3600) ~/ 60;
      int s = seconds % 60;
      timeWorkedStr = '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
    } else {
      timeWorkedStr = json['timeWorked']?.toString();
    }

    return TimesheetEntry(
      id: id,
      userEmail: json['userEmail']?.toString() ?? '',
      clientEmail: json['clientEmail']?.toString(),
      timeWorked: timeWorkedStr,
      shiftDate: json['shiftDate']?.toString(),
      shiftStartTime:
          json['shiftStartTime']?.toString() ?? json['startTime']?.toString(),
      shiftEndTime:
          json['shiftEndTime']?.toString() ?? json['endTime']?.toString(),
      totalHours: json['totalHours']?.toString(),
      workDate: workDateParsed,
      status: json['status']?.toString(),
    );
  }
}
