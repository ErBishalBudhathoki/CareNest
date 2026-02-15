class MultiOrgRollup {
  final String organizationId;
  final String organizationName;
  final int invoiceCount;
  final int clientCount;
  final double revenue;

  MultiOrgRollup({
    required this.organizationId,
    required this.organizationName,
    required this.invoiceCount,
    required this.clientCount,
    required this.revenue,
  });

  factory MultiOrgRollup.fromJson(Map<String, dynamic> json) {
    return MultiOrgRollup(
      organizationId: json['organizationId']?.toString() ?? '',
      organizationName:
          json['organizationName']?.toString() ?? 'Unknown Organization',
      invoiceCount: (json['invoiceCount'] as num?)?.toInt() ?? 0,
      clientCount: (json['clientCount'] as num?)?.toInt() ?? 0,
      revenue: (json['revenue'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'organizationId': organizationId,
      'organizationName': organizationName,
      'invoiceCount': invoiceCount,
      'clientCount': clientCount,
      'revenue': revenue,
    };
  }

  MultiOrgRollup copyWith({
    String? organizationId,
    String? organizationName,
    int? invoiceCount,
    int? clientCount,
    double? revenue,
  }) {
    return MultiOrgRollup(
      organizationId: organizationId ?? this.organizationId,
      organizationName: organizationName ?? this.organizationName,
      invoiceCount: invoiceCount ?? this.invoiceCount,
      clientCount: clientCount ?? this.clientCount,
      revenue: revenue ?? this.revenue,
    );
  }
}
