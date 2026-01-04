class RequestModel {
  final String? id;
  final String organizationId;
  final String userId;
  final String type;
  final String status;
  final Map<String, dynamic> details;
  final String? note;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  RequestModel({
    this.id,
    required this.organizationId,
    required this.userId,
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
      type: json['type'] ?? '',
      status: json['status'] ?? 'Pending',
      details: json['details'] != null
          ? Map<String, dynamic>.from(json['details'])
          : {},
      note: json['note'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      'organizationId': organizationId,
      'userId': userId,
      'type': type,
      'status': status,
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
    String? type,
    String? status,
    Map<String, dynamic>? details,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RequestModel(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      status: status ?? this.status,
      details: details ?? this.details,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
