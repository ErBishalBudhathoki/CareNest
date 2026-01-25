class GeofenceModel {
  final String id;
  final String clientId;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final double radius;
  final bool isActive;

  GeofenceModel({
    required this.id,
    required this.clientId,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.radius,
    this.isActive = true,
  });

  factory GeofenceModel.fromJson(Map<String, dynamic> json) {
    return GeofenceModel(
      id: json['_id'] ?? '',
      clientId: json['clientId'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      latitude: (json['coordinates']?['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['coordinates']?['longitude'] as num?)?.toDouble() ?? 0.0,
      radius: (json['radius'] as num?)?.toDouble() ?? 100.0,
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clientId': clientId,
      'name': name,
      'address': address,
      'coordinates': {
        'latitude': latitude,
        'longitude': longitude,
      },
      'radius': radius,
      'isActive': isActive,
    };
  }
}
