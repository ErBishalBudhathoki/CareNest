class Trip {
  final String id;
  final String userId;
  final String organizationId;
  final DateTime date;
  final String startLocation;
  final String endLocation;
  final double distance;
  final String tripType; // 'WITH_CLIENT' or 'BETWEEN_CLIENTS'
  final String? clientId;
  final String status; // 'PENDING', 'APPROVED', 'REJECTED'
  final bool isReimbursable;
  final String? rejectionReason;

  Trip({
    required this.id,
    required this.userId,
    required this.organizationId,
    required this.date,
    required this.startLocation,
    required this.endLocation,
    required this.distance,
    required this.tripType,
    this.clientId,
    this.status = 'PENDING',
    this.isReimbursable = true,
    this.rejectionReason,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['_id'] ?? json['id'] ?? '',
      userId: json['userId'] ?? '',
      organizationId: json['organizationId'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      startLocation: json['startLocation'] ?? '',
      endLocation: json['endLocation'] ?? '',
      distance: (json['distance'] as num?)?.toDouble() ?? 0.0,
      tripType: json['tripType'] ?? 'BETWEEN_CLIENTS',
      clientId: json['clientId'],
      status: json['status'] ?? 'PENDING',
      isReimbursable: json['isReimbursable'] ?? true,
      rejectionReason: json['rejectionReason'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'organizationId': organizationId,
      'date': date.toIso8601String(),
      'startLocation': startLocation,
      'endLocation': endLocation,
      'distance': distance,
      'tripType': tripType,
      'clientId': clientId,
      'status': status,
      'isReimbursable': isReimbursable,
      'rejectionReason': rejectionReason,
    };
  }
}
