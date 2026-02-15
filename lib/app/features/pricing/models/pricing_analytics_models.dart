/// Model for pricing analytics metrics
class PricingAnalyticsMetrics {
  final int totalItems;
  final int customPricedItems;
  final int standardPricedItems;
  final int ndisPricedItems;
  final double customPricingPercentage;
  final double totalRevenue;
  final double customRevenue;
  final double standardRevenue;
  final double ndisRevenue;
  final double complianceRate;
  final int compliantItems;
  final int nonCompliantItems;

  PricingAnalyticsMetrics({
    required this.totalItems,
    required this.customPricedItems,
    required this.standardPricedItems,
    required this.ndisPricedItems,
    required this.customPricingPercentage,
    required this.totalRevenue,
    required this.customRevenue,
    required this.standardRevenue,
    required this.ndisRevenue,
    required this.complianceRate,
    required this.compliantItems,
    required this.nonCompliantItems,
  });

  factory PricingAnalyticsMetrics.fromBackend(Map<String, dynamic> json) {
    return PricingAnalyticsMetrics(
      totalItems: json['totalItems'] ?? 0,
      customPricedItems: json['customPricedItems'] ?? 0,
      standardPricedItems: json['standardPricedItems'] ?? 0,
      ndisPricedItems: json['ndisPricedItems'] ?? 0,
      customPricingPercentage:
          (json['customPricingPercentage'] ?? 0).toDouble(),
      totalRevenue: (json['totalRevenue'] ?? 0).toDouble(),
      customRevenue: (json['customRevenue'] ?? 0).toDouble(),
      standardRevenue: (json['standardRevenue'] ?? 0).toDouble(),
      ndisRevenue: (json['ndisRevenue'] ?? 0).toDouble(),
      complianceRate: (json['complianceRate'] ?? 0).toDouble(),
      compliantItems: json['compliantItems'] ?? 0,
      nonCompliantItems: json['nonCompliantItems'] ?? 0,
    );
  }
}

/// Model for pricing analytics summary
class PricingAnalyticsSummary {
  final int totalCustomPricing;
  final int totalInvoiceItems;
  final DateTime? startDate;
  final DateTime? endDate;
  final String organizationId;
  final DateTime generatedAt;

  PricingAnalyticsSummary({
    required this.totalCustomPricing,
    required this.totalInvoiceItems,
    this.startDate,
    this.endDate,
    required this.organizationId,
    required this.generatedAt,
  });

  factory PricingAnalyticsSummary.fromBackend(Map<String, dynamic> json) {
    return PricingAnalyticsSummary(
      totalCustomPricing: json['totalCustomPricing'] ?? 0,
      totalInvoiceItems: json['totalInvoiceItems'] ?? 0,
      startDate: json['dateRange']?['startDate'] != null
          ? DateTime.parse(json['dateRange']['startDate'])
          : null,
      endDate: json['dateRange']?['endDate'] != null
          ? DateTime.parse(json['dateRange']['endDate'])
          : null,
      organizationId: json['organizationId'] ?? '',
      generatedAt: json['generatedAt'] != null
          ? DateTime.parse(json['generatedAt'])
          : DateTime.now(),
    );
  }
}

/// Model for complete pricing analytics response
class PricingAnalytics {
  final PricingAnalyticsMetrics metrics;
  final PricingAnalyticsSummary summary;

  PricingAnalytics({
    required this.metrics,
    required this.summary,
  });

  factory PricingAnalytics.fromBackend(Map<String, dynamic> json) {
    return PricingAnalytics(
      metrics: PricingAnalyticsMetrics.fromBackend(json['metrics'] ?? {}),
      summary: PricingAnalyticsSummary.fromBackend(json['summary'] ?? {}),
    );
  }
}

/// Model for pricing compliance data
class PricingComplianceData {
  final int totalItems;
  final int compliantItems;
  final int nonCompliantItems;
  final double overallCompliance;
  final String complianceGrade;

  PricingComplianceData({
    required this.totalItems,
    required this.compliantItems,
    required this.nonCompliantItems,
    required this.overallCompliance,
    required this.complianceGrade,
  });

  factory PricingComplianceData.fromBackend(Map<String, dynamic> json) {
    return PricingComplianceData(
      totalItems: json['totalItems'] ?? 0,
      compliantItems: json['compliantItems'] ?? 0,
      nonCompliantItems: json['nonCompliantItems'] ?? 0,
      overallCompliance: (json['overallCompliance'] ?? 0).toDouble(),
      complianceGrade: json['complianceGrade'] ?? 'N/A',
    );
  }
}

/// Model for pricing violation
class PricingViolation {
  final String itemId;
  final String? clientId;
  final String? supportItemNumber;
  final double unitPrice;
  final String violationType;
  final String severity;
  final double amount;
  final DateTime date;

  PricingViolation({
    required this.itemId,
    this.clientId,
    this.supportItemNumber,
    required this.unitPrice,
    required this.violationType,
    required this.severity,
    required this.amount,
    required this.date,
  });

  factory PricingViolation.fromBackend(Map<String, dynamic> json) {
    return PricingViolation(
      itemId: json['itemId'] ?? '',
      clientId: json['clientId'],
      supportItemNumber: json['supportItemNumber'],
      unitPrice: (json['unitPrice'] ?? 0).toDouble(),
      violationType: json['violationType'] ?? 'unknown',
      severity: json['severity'] ?? 'medium',
      amount: (json['amount'] ?? 0).toDouble(),
      date:
          json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
    );
  }
}

/// Model for compliance recommendation
class ComplianceRecommendation {
  final String type;
  final String priority;
  final String message;
  final String action;

  ComplianceRecommendation({
    required this.type,
    required this.priority,
    required this.message,
    required this.action,
  });

  factory ComplianceRecommendation.fromBackend(Map<String, dynamic> json) {
    return ComplianceRecommendation(
      type: json['type'] ?? '',
      priority: json['priority'] ?? '',
      message: json['message'] ?? '',
      action: json['action'] ?? '',
    );
  }
}

/// Model for compliance summary
class PricingComplianceSummary {
  final double overallCompliance;
  final bool meetsThreshold;
  final int totalViolations;
  final DateTime generatedAt;

  PricingComplianceSummary({
    required this.overallCompliance,
    required this.meetsThreshold,
    required this.totalViolations,
    required this.generatedAt,
  });

  factory PricingComplianceSummary.fromBackend(Map<String, dynamic> json) {
    return PricingComplianceSummary(
      overallCompliance: (json['overallCompliance'] ?? 0).toDouble(),
      meetsThreshold: json['meetsThreshold'] ?? false,
      totalViolations: json['totalViolations'] ?? 0,
      generatedAt: json['generatedAt'] != null
          ? DateTime.parse(json['generatedAt'])
          : DateTime.now(),
    );
  }
}

/// Model for complete pricing compliance report
class PricingComplianceReport {
  final PricingComplianceData compliance;
  final List<PricingViolation> violations;
  final List<ComplianceRecommendation> recommendations;
  final PricingComplianceSummary summary;

  PricingComplianceReport({
    required this.compliance,
    required this.violations,
    required this.recommendations,
    required this.summary,
  });

  factory PricingComplianceReport.fromBackend(Map<String, dynamic> json) {
    return PricingComplianceReport(
      compliance: PricingComplianceData.fromBackend(json['compliance'] ?? {}),
      violations: (json['violations'] as List? ?? [])
          .map((e) => PricingViolation.fromBackend(e))
          .toList(),
      recommendations: (json['recommendations'] as List? ?? [])
          .map((e) => ComplianceRecommendation.fromBackend(e))
          .toList(),
      summary: PricingComplianceSummary.fromBackend(json['summary'] ?? {}),
    );
  }
}
