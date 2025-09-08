class Patient {
  final String? id; // MongoDB ObjectId from backend
  final String? clientFirstName;
  final String? clientLastName;
  final String clientEmail;
  final String? clientPhone;
  final String? clientAddress;
  final String? clientCity;
  final String? clientState;
  final String? clientZip;
  final String? clientName; // Added for cases where only clientName is provided

  Patient({
    this.id,
    this.clientFirstName,
    this.clientLastName,
    required this.clientEmail,
    this.clientPhone,
    this.clientAddress,
    this.clientCity,
    this.clientState,
    this.clientZip,
    this.clientName,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['_id'] as String?, // Map MongoDB _id to id field
      clientFirstName: json['clientFirstName'] as String?,
      clientLastName: json['clientLastName'] as String?,
      clientEmail: json['clientEmail'] as String,
      clientPhone: json['clientPhone'] as String?,
      clientAddress: json['clientAddress'] as String?,
      clientCity: json['clientCity'] as String?,
      clientState: json['clientState'] as String?,
      clientZip: json['clientZip'] as String?,
      clientName: json['clientName'] as String?,
    );
  }

  String get displayName {
    if (clientFirstName != null && clientLastName != null) {
      return '${clientFirstName!} ${clientLastName!}';
    } else if (clientFirstName != null) {
      return clientFirstName!;
    } else if (clientLastName != null) {
      return clientLastName!;
    } else if (clientName != null) {
      return clientName!;
    } else {
      return clientEmail; // Fallback to email if no name is available
    }
  }
}
