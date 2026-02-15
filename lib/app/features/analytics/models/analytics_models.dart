class FinancialMetric {
  final String date;
  final double revenue;
  final double laborCost;
  final double margin;

  FinancialMetric({
    required this.date,
    required this.revenue,
    required this.laborCost,
    required this.margin,
  });
  
  factory FinancialMetric.fromJson(Map<String, dynamic> json) {
    return FinancialMetric(
      date: json['date'] ?? '',
      revenue: (json['revenue'] as num?)?.toDouble() ?? 0.0,
      laborCost: (json['laborCost'] as num?)?.toDouble() ?? 0.0,
      margin: (json['margin'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class UtilizationMetric {
  final String employeeName;
  final String email;
  final double billableHours;
  final double capacityHours;
  final double utilizationRate;

  UtilizationMetric({
    required this.employeeName,
    required this.email,
    required this.billableHours,
    required this.capacityHours,
    required this.utilizationRate,
  });
  
  factory UtilizationMetric.fromJson(Map<String, dynamic> json) {
    return UtilizationMetric(
      employeeName: json['employeeName'] ?? 'Unknown',
      email: json['email'] ?? '',
      billableHours: (json['billableHours'] as num?)?.toDouble() ?? 0.0,
      capacityHours: (json['capacityHours'] as num?)?.toDouble() ?? 0.0,
      utilizationRate: (json['utilizationRate'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class OvertimeMetric {
  final String employeeName;
  final String employeeEmail;
  final double totalHours;
  final double overtimeHours;
  final List<DailyOvertime> dailyBreakdown;

  OvertimeMetric({
    required this.employeeName,
    required this.employeeEmail,
    required this.totalHours,
    required this.overtimeHours,
    this.dailyBreakdown = const [],
  });

  factory OvertimeMetric.fromJson(Map<String, dynamic> json) {
    return OvertimeMetric(
      employeeName: json['employeeName'] ?? 'Unknown',
      employeeEmail: json['employeeEmail'] ?? '',
      totalHours: (json['totalHours'] as num?)?.toDouble() ?? 0.0,
      overtimeHours: (json['overtimeHours'] as num?)?.toDouble() ?? 0.0,
      dailyBreakdown: (json['dailyBreakdown'] as List?)
              ?.map((e) => DailyOvertime.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class DailyOvertime {
  final String date;
  final double hours;

  DailyOvertime({required this.date, required this.hours});

  factory DailyOvertime.fromJson(Map<String, dynamic> json) {
    return DailyOvertime(
      date: json['date'] ?? '',
      hours: (json['hours'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class ReliabilityMetric {
  final String employeeEmail;
  final int totalScheduled;
  final int filledShifts;
  final int noShows;
  final double shiftFillRate;
  final double noShowRate;

  ReliabilityMetric({
    required this.employeeEmail,
    required this.totalScheduled,
    required this.filledShifts,
    required this.noShows,
    required this.shiftFillRate,
    required this.noShowRate,
  });

  factory ReliabilityMetric.fromJson(Map<String, dynamic> json) {
    return ReliabilityMetric(
      employeeEmail: json['employeeEmail'] ?? '',
      totalScheduled: json['totalScheduled'] ?? 0,
      filledShifts: json['filledShifts'] ?? 0,
      noShows: json['noShows'] ?? 0,
      shiftFillRate: (json['shiftFillRate'] as num?)?.toDouble() ?? 0.0,
      noShowRate: (json['noShowRate'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class CrossOrgMetric {
  final String organizationId;
  final String organizationName;
  final double revenue;
  final double expenses;
  final double profit;
  final int employeeCount;
  final int clientCount;

  CrossOrgMetric({
    required this.organizationId,
    required this.organizationName,
    required this.revenue,
    required this.expenses,
    required this.profit,
    required this.employeeCount,
    required this.clientCount,
  });

  factory CrossOrgMetric.fromJson(Map<String, dynamic> json) {
    return CrossOrgMetric(
      organizationId: json['organizationId'] ?? '',
      organizationName: json['organizationName'] ?? 'Unknown',
      revenue: (json['revenue'] as num?)?.toDouble() ?? 0.0,
      expenses: (json['expenses'] as num?)?.toDouble() ?? 0.0,
      profit: (json['profit'] as num?)?.toDouble() ?? 0.0,
      employeeCount: json['employeeCount'] ?? 0,
      clientCount: json['clientCount'] ?? 0,
    );
  }
}

class ForecastMetric {
  final String date;
  final double predictedRevenue;
  final double predictedExpenses;
  final double confidence;
  final String metric;

  ForecastMetric({
    required this.date,
    required this.predictedRevenue,
    required this.predictedExpenses,
    required this.confidence,
    required this.metric,
  });

  factory ForecastMetric.fromJson(Map<String, dynamic> json) {
    return ForecastMetric(
      date: json['date'] ?? '',
      predictedRevenue: (json['predictedRevenue'] as num?)?.toDouble() ?? 0.0,
      predictedExpenses: (json['predictedExpenses'] as num?)?.toDouble() ?? 0.0,
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.0,
      metric: json['metric'] ?? '',
    );
  }
}

// NEW: Worker Churn Prediction Model
class ChurnPrediction {
  final String workerId;
  final String workerName;
  final String workerEmail;
  final double churnScore; // 0-100
  final String riskLevel; // low, medium, high
  final List<ChurnFactor> factors;
  final List<String> recommendations;
  final DateTime? predictedDate;
  final double confidence;

  ChurnPrediction({
    required this.workerId,
    required this.workerName,
    required this.workerEmail,
    required this.churnScore,
    required this.riskLevel,
    required this.factors,
    required this.recommendations,
    this.predictedDate,
    required this.confidence,
  });

  factory ChurnPrediction.fromJson(Map<String, dynamic> json) {
    return ChurnPrediction(
      workerId: json['workerId'] ?? '',
      workerName: json['workerName'] ?? 'Unknown',
      workerEmail: json['workerEmail'] ?? '',
      churnScore: (json['churnScore'] as num?)?.toDouble() ?? 0.0,
      riskLevel: json['riskLevel'] ?? 'low',
      factors: (json['factors'] as List?)
              ?.map((e) => ChurnFactor.fromJson(e))
              .toList() ??
          [],
      recommendations: (json['recommendations'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      predictedDate: json['predictedDate'] != null
          ? DateTime.tryParse(json['predictedDate'])
          : null,
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class ChurnFactor {
  final String factor;
  final double impact; // 0-1
  final String description;

  ChurnFactor({
    required this.factor,
    required this.impact,
    required this.description,
  });

  factory ChurnFactor.fromJson(Map<String, dynamic> json) {
    return ChurnFactor(
      factor: json['factor'] ?? '',
      impact: (json['impact'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] ?? '',
    );
  }
}

// NEW: Demand Forecast Model
class DemandForecast {
  final DateTime date;
  final String serviceType;
  final double predictedAppointments;
  final double confidence;
  final List<int> peakHours;
  final String capacityRecommendation;

  DemandForecast({
    required this.date,
    required this.serviceType,
    required this.predictedAppointments,
    required this.confidence,
    required this.peakHours,
    required this.capacityRecommendation,
  });

  factory DemandForecast.fromJson(Map<String, dynamic> json) {
    return DemandForecast(
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      serviceType: json['serviceType'] ?? 'All',
      predictedAppointments: (json['predictedAppointments'] as num?)?.toDouble() ?? 0.0,
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.0,
      peakHours: (json['peakHours'] as List?)?.map((e) => e as int).toList() ?? [],
      capacityRecommendation: json['capacityRecommendation'] ?? '',
    );
  }
}

// NEW: Compliance Risk Model
class ComplianceRisk {
  final String organizationId;
  final double overallScore; // 0-100
  final String riskLevel; // low, medium, high
  final List<ComplianceIssue> issues;
  final List<WorkerCompliance> workerRisks;
  final DateTime lastAudit;
  final DateTime nextAudit;

  ComplianceRisk({
    required this.organizationId,
    required this.overallScore,
    required this.riskLevel,
    required this.issues,
    required this.workerRisks,
    required this.lastAudit,
    required this.nextAudit,
  });

  factory ComplianceRisk.fromJson(Map<String, dynamic> json) {
    return ComplianceRisk(
      organizationId: json['organizationId'] ?? '',
      overallScore: (json['overallScore'] as num?)?.toDouble() ?? 0.0,
      riskLevel: json['riskLevel'] ?? 'low',
      issues: (json['issues'] as List?)
              ?.map((e) => ComplianceIssue.fromJson(e))
              .toList() ??
          [],
      workerRisks: (json['workerRisks'] as List?)
              ?.map((e) => WorkerCompliance.fromJson(e))
              .toList() ??
          [],
      lastAudit: DateTime.tryParse(json['lastAudit'] ?? '') ?? DateTime.now(),
      nextAudit: DateTime.tryParse(json['nextAudit'] ?? '') ?? DateTime.now(),
    );
  }
}

class ComplianceIssue {
  final String type; // certification, document, training
  final String description;
  final String severity; // low, medium, high, critical
  final int count;
  final DateTime? dueDate;

  ComplianceIssue({
    required this.type,
    required this.description,
    required this.severity,
    required this.count,
    this.dueDate,
  });

  factory ComplianceIssue.fromJson(Map<String, dynamic> json) {
    return ComplianceIssue(
      type: json['type'] ?? '',
      description: json['description'] ?? '',
      severity: json['severity'] ?? 'low',
      count: json['count'] ?? 0,
      dueDate: json['dueDate'] != null
          ? DateTime.tryParse(json['dueDate'])
          : null,
    );
  }
}

class WorkerCompliance {
  final String workerId;
  final String workerName;
  final double complianceScore; // 0-100
  final List<String> missingItems;
  final int expiringCount;

  WorkerCompliance({
    required this.workerId,
    required this.workerName,
    required this.complianceScore,
    required this.missingItems,
    required this.expiringCount,
  });

  factory WorkerCompliance.fromJson(Map<String, dynamic> json) {
    return WorkerCompliance(
      workerId: json['workerId'] ?? '',
      workerName: json['workerName'] ?? 'Unknown',
      complianceScore: (json['complianceScore'] as num?)?.toDouble() ?? 0.0,
      missingItems: (json['missingItems'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      expiringCount: json['expiringCount'] ?? 0,
    );
  }
}

// NEW Phase 5: Client Risk Prediction Model
class ClientRisk {
  final String clientId;
  final String clientName;
  final double riskScore; // 0-100
  final String riskLevel; // low, medium, high
  final List<RiskFactor> factors;
  final List<String> recommendations;
  final DateTime? predictedChurnDate;
  final double confidence;
  final int monthsAsClient;

  ClientRisk({
    required this.clientId,
    required this.clientName,
    required this.riskScore,
    required this.riskLevel,
    required this.factors,
    required this.recommendations,
    this.predictedChurnDate,
    required this.confidence,
    required this.monthsAsClient,
  });

  factory ClientRisk.fromJson(Map<String, dynamic> json) {
    return ClientRisk(
      clientId: json['clientId'] ?? '',
      clientName: json['clientName'] ?? 'Unknown',
      riskScore: (json['riskScore'] as num?)?.toDouble() ?? 0.0,
      riskLevel: json['riskLevel'] ?? 'low',
      factors: (json['factors'] as List?)
              ?.map((e) => RiskFactor.fromJson(e))
              .toList() ??
          [],
      recommendations: (json['recommendations'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      predictedChurnDate: json['predictedChurnDate'] != null
          ? DateTime.tryParse(json['predictedChurnDate'])
          : null,
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.0,
      monthsAsClient: json['monthsAsClient'] ?? 0,
    );
  }
}

class RiskFactor {
  final String factor;
  final double impact; // 0-1
  final String description;

  RiskFactor({
    required this.factor,
    required this.impact,
    required this.description,
  });

  factory RiskFactor.fromJson(Map<String, dynamic> json) {
    return RiskFactor(
      factor: json['factor'] ?? '',
      impact: (json['impact'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] ?? '',
    );
  }
}

// NEW Phase 5: Service Demand Prediction Model
class ServiceDemandPrediction {
  final String serviceType;
  final double currentDemand;
  final double predictedDemand;
  final double growthRate;
  final double confidence;
  final String trend; // increasing, decreasing, stable

  ServiceDemandPrediction({
    required this.serviceType,
    required this.currentDemand,
    required this.predictedDemand,
    required this.growthRate,
    required this.confidence,
    required this.trend,
  });

  factory ServiceDemandPrediction.fromJson(Map<String, dynamic> json) {
    return ServiceDemandPrediction(
      serviceType: json['serviceType'] ?? '',
      currentDemand: (json['currentDemand'] as num?)?.toDouble() ?? 0.0,
      predictedDemand: (json['predictedDemand'] as num?)?.toDouble() ?? 0.0,
      growthRate: (json['growthRate'] as num?)?.toDouble() ?? 0.0,
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.0,
      trend: json['trend'] ?? 'stable',
    );
  }
}

class ServiceDemandResult {
  final List<ServiceDemandPrediction> predictions;
  final List<String> recommendations;
  final double overallGrowth;
  final int forecastPeriod;

  ServiceDemandResult({
    required this.predictions,
    required this.recommendations,
    required this.overallGrowth,
    required this.forecastPeriod,
  });

  factory ServiceDemandResult.fromJson(Map<String, dynamic> json) {
    return ServiceDemandResult(
      predictions: (json['predictions'] as List?)
              ?.map((e) => ServiceDemandPrediction.fromJson(e))
              .toList() ??
          [],
      recommendations: (json['recommendations'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      overallGrowth: (json['overallGrowth'] as num?)?.toDouble() ?? 0.0,
      forecastPeriod: json['forecastPeriod'] ?? 30,
    );
  }
}

// NEW Phase 5: Scenario Model Result
class ScenarioResult {
  final String scenarioName;
  final ScenarioMetrics baseline;
  final ScenarioMetrics projected;
  final ScenarioChanges changes;
  final List<String> recommendations;

  ScenarioResult({
    required this.scenarioName,
    required this.baseline,
    required this.projected,
    required this.changes,
    required this.recommendations,
  });

  factory ScenarioResult.fromJson(Map<String, dynamic> json) {
    return ScenarioResult(
      scenarioName: json['scenarioName'] ?? 'Scenario',
      baseline: ScenarioMetrics.fromJson(json['baseline'] ?? {}),
      projected: ScenarioMetrics.fromJson(json['projected'] ?? {}),
      changes: ScenarioChanges.fromJson(json['changes'] ?? {}),
      recommendations: (json['recommendations'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }
}

class ScenarioMetrics {
  final double monthlyRevenue;
  final double monthlyExpenses;
  final double monthlyProfit;
  final int workerCount;
  final int clientCount;
  final double utilizationRate;
  final double avgRevenuePerClient;

  ScenarioMetrics({
    required this.monthlyRevenue,
    required this.monthlyExpenses,
    required this.monthlyProfit,
    required this.workerCount,
    required this.clientCount,
    required this.utilizationRate,
    required this.avgRevenuePerClient,
  });

  factory ScenarioMetrics.fromJson(Map<String, dynamic> json) {
    return ScenarioMetrics(
      monthlyRevenue: (json['monthlyRevenue'] as num?)?.toDouble() ?? 0.0,
      monthlyExpenses: (json['monthlyExpenses'] as num?)?.toDouble() ?? 0.0,
      monthlyProfit: (json['monthlyProfit'] as num?)?.toDouble() ?? 0.0,
      workerCount: json['workerCount'] ?? 0,
      clientCount: json['clientCount'] ?? 0,
      utilizationRate: (json['utilizationRate'] as num?)?.toDouble() ?? 0.0,
      avgRevenuePerClient: (json['avgRevenuePerClient'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class ScenarioChanges {
  final double revenueChange;
  final double revenueChangePercent;
  final double profitChange;
  final double profitChangePercent;
  final int workerChange;
  final int clientChange;

  ScenarioChanges({
    required this.revenueChange,
    required this.revenueChangePercent,
    required this.profitChange,
    required this.profitChangePercent,
    required this.workerChange,
    required this.clientChange,
  });

  factory ScenarioChanges.fromJson(Map<String, dynamic> json) {
    return ScenarioChanges(
      revenueChange: (json['revenueChange'] as num?)?.toDouble() ?? 0.0,
      revenueChangePercent: (json['revenueChangePercent'] as num?)?.toDouble() ?? 0.0,
      profitChange: (json['profitChange'] as num?)?.toDouble() ?? 0.0,
      profitChangePercent: (json['profitChangePercent'] as num?)?.toDouble() ?? 0.0,
      workerChange: json['workerChange'] ?? 0,
      clientChange: json['clientChange'] ?? 0,
    );
  }
}

// NEW Phase 5: AI Recommendation Model
class AIRecommendation {
  final String category; // Worker Retention, Client Retention, etc.
  final String priority; // critical, high, medium, low
  final String title;
  final String description;
  final List<String> actions;
  final String expectedImpact;
  final String difficulty; // low, medium, high
  final String timeframe; // e.g., "1-2 weeks"

  AIRecommendation({
    required this.category,
    required this.priority,
    required this.title,
    required this.description,
    required this.actions,
    required this.expectedImpact,
    required this.difficulty,
    required this.timeframe,
  });

  factory AIRecommendation.fromJson(Map<String, dynamic> json) {
    return AIRecommendation(
      category: json['category'] ?? '',
      priority: json['priority'] ?? 'medium',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      actions: (json['actions'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      expectedImpact: json['expectedImpact'] ?? '',
      difficulty: json['difficulty'] ?? 'medium',
      timeframe: json['timeframe'] ?? '',
    );
  }
}
