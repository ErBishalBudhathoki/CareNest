class BusinessModel {
  final String? id;
  final String businessName;
  final String businessEmail;
  final String businessPhone;
  final String businessAddress;
  final String businessCity;
  final String businessState;
  final String businessZip;
  final String? organizationId;
  final String? createdBy;
  final DateTime? createdAt;
  final bool isActive;

  BusinessModel({
    this.id,
    required this.businessName,
    required this.businessEmail,
    required this.businessPhone,
    required this.businessAddress,
    required this.businessCity,
    required this.businessState,
    required this.businessZip,
    this.organizationId,
    this.createdBy,
    this.createdAt,
    this.isActive = true,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      id: (json['_id'] ?? json['id'])?.toString(),
      businessName: json['businessName'] ?? '',
      businessEmail: json['businessEmail'] ?? '',
      businessPhone: json['businessPhone'] ?? '',
      businessAddress: json['businessAddress'] ?? '',
      businessCity: json['businessCity'] ?? '',
      businessState: json['businessState'] ?? '',
      businessZip: json['businessZip'] ?? '',
      organizationId: json['organizationId']?.toString(),
      createdBy: json['createdBy']?.toString(),
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      'businessName': businessName,
      'businessEmail': businessEmail,
      'businessPhone': businessPhone,
      'businessAddress': businessAddress,
      'businessCity': businessCity,
      'businessState': businessState,
      'businessZip': businessZip,
      if (organizationId != null) 'organizationId': organizationId,
      if (createdBy != null) 'createdBy': createdBy,
      if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
      'isActive': isActive,
    };
  }
}
