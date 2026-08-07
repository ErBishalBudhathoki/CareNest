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
  final String? businessName;
  final String? clientName; // Added for cases where only clientName is provided
  final String? careNotes;
  final Map<String, dynamic>? preferences;
  final bool isActive;
  final bool isActivated;
  final bool activationPending;
  final DateTime? deletedAt;
  final DateTime? purgeAfter;

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
    this.businessName,
    this.clientName,
    this.careNotes,
    this.preferences,
    this.isActive = true,
    this.isActivated = false,
    this.activationPending = false,
    this.deletedAt,
    this.purgeAfter,
  });

  static DateTime? _parseDate(dynamic value) {
    if (value is String && value.isNotEmpty) {
      return DateTime.tryParse(value);
    }
    return null;
  }

  static bool _parseBool(dynamic value, {required bool defaultValue}) {
    if (value is bool) return value;
    if (value is num) return value != 0;
    if (value is String) {
      final normalized = value.trim().toLowerCase();
      if (normalized == 'true' || normalized == '1' || normalized == 'yes') {
        return true;
      }
      if (normalized == 'false' || normalized == '0' || normalized == 'no') {
        return false;
      }
    }
    return defaultValue;
  }

  factory Patient.fromJson(Map<String, dynamic> json) {
    final activationStatus =
        (json['activationStatus'] ?? json['activation_state'] ?? '')
            .toString()
            .trim()
            .toLowerCase();
    final activationPendingFromStatus = activationStatus == 'pending';
    final isActivatedFromStatus =
        activationStatus == 'activated' ||
        activationStatus == 'completed' ||
        activationStatus == 'active';

    return Patient(
      id: (json['_id'] ?? json['id']) as String?, // Map MongoDB _id to id field
      clientFirstName: json['clientFirstName'] as String?,
      clientLastName: json['clientLastName'] as String?,
      clientEmail: json['clientEmail'] as String,
      clientPhone: json['clientPhone'] as String?,
      clientAddress: json['clientAddress'] as String?,
      clientCity: json['clientCity'] as String?,
      clientState: json['clientState'] as String?,
      clientZip: json['clientZip'] as String?,
      businessName: json['businessName'] as String?,
      clientName: json['clientName'] as String?,
      careNotes: json['careNotes'] as String?,
      preferences: json['preferences'] as Map<String, dynamic>?,
      isActive: _parseBool(json['isActive'], defaultValue: true),
      isActivated:
          _parseBool(json['isActivated'], defaultValue: false) ||
          isActivatedFromStatus,
      activationPending:
          _parseBool(json['activationPending'], defaultValue: false) ||
          activationPendingFromStatus,
      deletedAt: _parseDate(json['deletedAt']),
      purgeAfter: _parseDate(json['purgeAfter']),
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
