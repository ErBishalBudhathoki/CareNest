enum RequestStatus {
  claimed,
  declined,
  pending,
  approved,
  rejected,
  cancelled,
  pendingLocal;

  String get label {
    switch (this) {
      case RequestStatus.claimed:
        return 'Claimed';
      case RequestStatus.declined:
        return 'Declined';
      case RequestStatus.pending:
        return 'Pending';
      case RequestStatus.approved:
        return 'Approved';
      case RequestStatus.rejected:
        return 'Rejected';
      case RequestStatus.cancelled:
        return 'Cancelled';
      case RequestStatus.pendingLocal:
        return 'Pending (Local)';
    }
  }

  static RequestStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'claimed':
        return RequestStatus.claimed;
      case 'pending':
        return RequestStatus.pending;
      case 'approved':
        return RequestStatus.approved;
      case 'declined':
        return RequestStatus.declined;
      case 'rejected':
        return RequestStatus.rejected;
      case 'cancelled':
        return RequestStatus.cancelled;
      case 'pending (local)':
      case 'pendinglocal':
        return RequestStatus.pendingLocal;
      default:
        return RequestStatus.pending;
    }
  }
}

class RequestModel {
  final String? id;
  final String organizationId;
  final String userId;
  final String? createdBy;
  final String type;
  final RequestStatus status;
  final Map<String, dynamic> details;
  final String? note;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  RequestModel({
    this.id,
    required this.organizationId,
    required this.userId,
    this.createdBy,
    required this.type,
    required this.status,
    required this.details,
    this.note,
    this.createdAt,
    this.updatedAt,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      id: json['_id'],
      organizationId: json['organizationId'] ?? '',
      userId: json['userId'] ?? '',
      createdBy: json['createdBy']?.toString(),
      type: json['type'] ?? '',
      status: RequestStatus.fromString(json['status'] ?? 'Pending'),
      details: json['details'] != null
          ? Map<String, dynamic>.from(json['details'])
          : {},
      note: json['note'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      'organizationId': organizationId,
      'userId': userId,
      if (createdBy != null) 'createdBy': createdBy,
      'type': type,
      'status': status.label,
      'details': details,
      'note': note,
      if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
    };
  }

  RequestModel copyWith({
    String? id,
    String? organizationId,
    String? userId,
    String? createdBy,
    String? type,
    RequestStatus? status,
    Map<String, dynamic>? details,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RequestModel(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      userId: userId ?? this.userId,
      createdBy: createdBy ?? this.createdBy,
      type: type ?? this.type,
      status: status ?? this.status,
      details: details ?? this.details,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
