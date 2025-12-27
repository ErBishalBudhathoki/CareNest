/// PeriodConfig model representing per employee-client period preferences.
///
/// Stores the preferred week start day for period calculations.
class PeriodConfig {
  /// Employee email identifier.
  final String employeeEmail;

  /// Client email identifier.
  final String clientEmail;

  /// Preferred week start day (1..7 aligning with DateTime.monday..sunday).
  /// Defaults to `DateTime.monday` if not specified.
  final int weekStartDay;

  /// Optional human-readable notes or metadata.
  final String? notes;

  const PeriodConfig({
    required this.employeeEmail,
    required this.clientEmail,
    this.weekStartDay = DateTime.monday,
    this.notes,
  });

  /// Construct from JSON map.
  factory PeriodConfig.fromJson(Map<String, dynamic> json) {
    return PeriodConfig(
      employeeEmail: (json['employeeEmail'] as String?)?.trim() ?? '',
      clientEmail: (json['clientEmail'] as String?)?.trim() ?? '',
      weekStartDay: (json['weekStartDay'] as int?) ?? DateTime.monday,
      notes: json['notes'] as String?,
    );
  }

  /// Convert to JSON map.
  Map<String, dynamic> toJson() => {
        'employeeEmail': employeeEmail,
        'clientEmail': clientEmail,
        'weekStartDay': weekStartDay,
        'notes': notes,
      };

  /// Returns a copy with optional changes.
  PeriodConfig copyWith({
    String? employeeEmail,
    String? clientEmail,
    int? weekStartDay,
    String? notes,
  }) {
    return PeriodConfig(
      employeeEmail: employeeEmail ?? this.employeeEmail,
      clientEmail: clientEmail ?? this.clientEmail,
      weekStartDay: weekStartDay ?? this.weekStartDay,
      notes: notes ?? this.notes,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PeriodConfig &&
        other.employeeEmail == employeeEmail &&
        other.clientEmail == clientEmail &&
        other.weekStartDay == weekStartDay &&
        other.notes == notes;
  }

  @override
  int get hashCode => Object.hash(employeeEmail, clientEmail, weekStartDay, notes);
}