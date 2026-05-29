// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_intelligence_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RevenueForecast _$RevenueForecastFromJson(
  Map<String, dynamic> json,
) => _RevenueForecast(
  organizationId: json['organizationId'] as String,
  generatedAt: json['generatedAt'] as String,
  horizon: (json['horizon'] as num).toInt(),
  model: json['model'] as String,
  accuracy: (json['accuracy'] as num).toDouble(),
  predictions: (json['predictions'] as List<dynamic>)
      .map((e) => DailyPrediction.fromJson(e as Map<String, dynamic>))
      .toList(),
  confidenceIntervals: json['confidenceIntervals'] == null
      ? null
      : ConfidenceIntervals.fromJson(
          json['confidenceIntervals'] as Map<String, dynamic>,
        ),
  scenarios: json['scenarios'] == null
      ? null
      : ForecastScenarios.fromJson(json['scenarios'] as Map<String, dynamic>),
  metrics: ForecastMetrics.fromJson(json['metrics'] as Map<String, dynamic>),
  insights: (json['insights'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$RevenueForecastToJson(_RevenueForecast instance) =>
    <String, dynamic>{
      'organizationId': instance.organizationId,
      'generatedAt': instance.generatedAt,
      'horizon': instance.horizon,
      'model': instance.model,
      'accuracy': instance.accuracy,
      'predictions': instance.predictions,
      'confidenceIntervals': instance.confidenceIntervals,
      'scenarios': instance.scenarios,
      'metrics': instance.metrics,
      'insights': instance.insights,
    };

_DailyPrediction _$DailyPredictionFromJson(Map<String, dynamic> json) =>
    _DailyPrediction(
      date: json['date'] as String,
      predicted: (json['predicted'] as num).toDouble(),
      confidence: (json['confidence'] as num).toDouble(),
    );

Map<String, dynamic> _$DailyPredictionToJson(_DailyPrediction instance) =>
    <String, dynamic>{
      'date': instance.date,
      'predicted': instance.predicted,
      'confidence': instance.confidence,
    };

_ConfidenceIntervals _$ConfidenceIntervalsFromJson(Map<String, dynamic> json) =>
    _ConfidenceIntervals(
      intervals: (json['intervals'] as List<dynamic>)
          .map((e) => ConfidenceInterval.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ConfidenceIntervalsToJson(
  _ConfidenceIntervals instance,
) => <String, dynamic>{'intervals': instance.intervals};

_ConfidenceInterval _$ConfidenceIntervalFromJson(Map<String, dynamic> json) =>
    _ConfidenceInterval(
      date: json['date'] as String,
      lower: (json['lower'] as num).toDouble(),
      upper: (json['upper'] as num).toDouble(),
      confidence: (json['confidence'] as num).toDouble(),
    );

Map<String, dynamic> _$ConfidenceIntervalToJson(_ConfidenceInterval instance) =>
    <String, dynamic>{
      'date': instance.date,
      'lower': instance.lower,
      'upper': instance.upper,
      'confidence': instance.confidence,
    };

_ForecastScenarios _$ForecastScenariosFromJson(Map<String, dynamic> json) =>
    _ForecastScenarios(
      bestCase: (json['bestCase'] as num).toDouble(),
      mostLikely: (json['mostLikely'] as num).toDouble(),
      worstCase: (json['worstCase'] as num).toDouble(),
    );

Map<String, dynamic> _$ForecastScenariosToJson(_ForecastScenarios instance) =>
    <String, dynamic>{
      'bestCase': instance.bestCase,
      'mostLikely': instance.mostLikely,
      'worstCase': instance.worstCase,
    };

_ForecastMetrics _$ForecastMetricsFromJson(Map<String, dynamic> json) =>
    _ForecastMetrics(
      arimaAccuracy: (json['arimaAccuracy'] as num).toDouble(),
      prophetAccuracy: (json['prophetAccuracy'] as num).toDouble(),
      lstmAccuracy: (json['lstmAccuracy'] as num).toDouble(),
      ensembleAccuracy: (json['ensembleAccuracy'] as num).toDouble(),
      mae: (json['mae'] as num).toDouble(),
      rmse: (json['rmse'] as num).toDouble(),
    );

Map<String, dynamic> _$ForecastMetricsToJson(_ForecastMetrics instance) =>
    <String, dynamic>{
      'arimaAccuracy': instance.arimaAccuracy,
      'prophetAccuracy': instance.prophetAccuracy,
      'lstmAccuracy': instance.lstmAccuracy,
      'ensembleAccuracy': instance.ensembleAccuracy,
      'mae': instance.mae,
      'rmse': instance.rmse,
    };

_RevenueDrivers _$RevenueDriversFromJson(Map<String, dynamic> json) =>
    _RevenueDrivers(
      organizationId: json['organizationId'] as String,
      period: (json['period'] as num).toInt(),
      analyzedAt: json['analyzedAt'] as String,
      primaryDrivers: (json['primaryDrivers'] as List<dynamic>)
          .map((e) => PrimaryDriver.fromJson(e as Map<String, dynamic>))
          .toList(),
      externalFactors: (json['externalFactors'] as List<dynamic>)
          .map((e) => ExternalFactor.fromJson(e as Map<String, dynamic>))
          .toList(),
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$RevenueDriversToJson(_RevenueDrivers instance) =>
    <String, dynamic>{
      'organizationId': instance.organizationId,
      'period': instance.period,
      'analyzedAt': instance.analyzedAt,
      'primaryDrivers': instance.primaryDrivers,
      'externalFactors': instance.externalFactors,
      'recommendations': instance.recommendations,
    };

_PrimaryDriver _$PrimaryDriverFromJson(Map<String, dynamic> json) =>
    _PrimaryDriver(
      driver: json['driver'] as String,
      impact: (json['impact'] as num).toDouble(),
      trend: json['trend'] as String,
      correlation: (json['correlation'] as num).toDouble(),
      elasticity: (json['elasticity'] as num).toDouble(),
    );

Map<String, dynamic> _$PrimaryDriverToJson(_PrimaryDriver instance) =>
    <String, dynamic>{
      'driver': instance.driver,
      'impact': instance.impact,
      'trend': instance.trend,
      'correlation': instance.correlation,
      'elasticity': instance.elasticity,
    };

_ExternalFactor _$ExternalFactorFromJson(Map<String, dynamic> json) =>
    _ExternalFactor(
      factor: json['factor'] as String,
      impact: (json['impact'] as num).toDouble(),
      probability: (json['probability'] as num).toDouble(),
      potentialEffect: json['potentialEffect'] as String,
    );

Map<String, dynamic> _$ExternalFactorToJson(_ExternalFactor instance) =>
    <String, dynamic>{
      'factor': instance.factor,
      'impact': instance.impact,
      'probability': instance.probability,
      'potentialEffect': instance.potentialEffect,
    };

_PriceOptimization _$PriceOptimizationFromJson(Map<String, dynamic> json) =>
    _PriceOptimization(
      serviceId: json['serviceId'] as String,
      serviceName: json['serviceName'] as String,
      currentPrice: (json['currentPrice'] as num).toDouble(),
      optimalPrice: (json['optimalPrice'] as num).toDouble(),
      priceChange: (json['priceChange'] as num).toDouble(),
      percentageChange: (json['percentageChange'] as num).toDouble(),
      impact: PriceImpact.fromJson(json['impact'] as Map<String, dynamic>),
      confidence: (json['confidence'] as num).toDouble(),
      recommendation: json['recommendation'] as String,
    );

Map<String, dynamic> _$PriceOptimizationToJson(_PriceOptimization instance) =>
    <String, dynamic>{
      'serviceId': instance.serviceId,
      'serviceName': instance.serviceName,
      'currentPrice': instance.currentPrice,
      'optimalPrice': instance.optimalPrice,
      'priceChange': instance.priceChange,
      'percentageChange': instance.percentageChange,
      'impact': instance.impact,
      'confidence': instance.confidence,
      'recommendation': instance.recommendation,
    };

_PriceImpact _$PriceImpactFromJson(Map<String, dynamic> json) => _PriceImpact(
  demandChange: (json['demandChange'] as num).toDouble(),
  revenueChange: (json['revenueChange'] as num).toDouble(),
  marginChange: (json['marginChange'] as num).toDouble(),
);

Map<String, dynamic> _$PriceImpactToJson(_PriceImpact instance) =>
    <String, dynamic>{
      'demandChange': instance.demandChange,
      'revenueChange': instance.revenueChange,
      'marginChange': instance.marginChange,
    };

_ABTest _$ABTestFromJson(Map<String, dynamic> json) => _ABTest(
  testId: json['testId'] as String,
  organizationId: json['organizationId'] as String,
  status: json['status'] as String,
  createdAt: json['createdAt'] as String,
  variants: (json['variants'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, ABVariant.fromJson(e as Map<String, dynamic>)),
  ),
  duration: (json['duration'] as num).toInt(),
  minimumSampleSize: (json['minimumSampleSize'] as num).toInt(),
  significanceLevel: (json['significanceLevel'] as num).toDouble(),
  successMetrics: (json['successMetrics'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$ABTestToJson(_ABTest instance) => <String, dynamic>{
  'testId': instance.testId,
  'organizationId': instance.organizationId,
  'status': instance.status,
  'createdAt': instance.createdAt,
  'variants': instance.variants,
  'duration': instance.duration,
  'minimumSampleSize': instance.minimumSampleSize,
  'significanceLevel': instance.significanceLevel,
  'successMetrics': instance.successMetrics,
};

_ABVariant _$ABVariantFromJson(Map<String, dynamic> json) => _ABVariant(
  name: json['name'] as String,
  price: (json['price'] as num).toDouble(),
  allocation: (json['allocation'] as num).toDouble(),
  metrics: ABMetrics.fromJson(json['metrics'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ABVariantToJson(_ABVariant instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'allocation': instance.allocation,
      'metrics': instance.metrics,
    };

_ABMetrics _$ABMetricsFromJson(Map<String, dynamic> json) => _ABMetrics(
  conversions: (json['conversions'] as num).toInt(),
  revenue: (json['revenue'] as num).toDouble(),
  sampleSize: (json['sampleSize'] as num).toInt(),
);

Map<String, dynamic> _$ABMetricsToJson(_ABMetrics instance) =>
    <String, dynamic>{
      'conversions': instance.conversions,
      'revenue': instance.revenue,
      'sampleSize': instance.sampleSize,
    };

_PricingRecommendations _$PricingRecommendationsFromJson(
  Map<String, dynamic> json,
) => _PricingRecommendations(
  serviceId: json['serviceId'] as String,
  analyzedAt: json['analyzedAt'] as String,
  current: CurrentPricing.fromJson(json['current'] as Map<String, dynamic>),
  strategies: (json['strategies'] as List<dynamic>)
      .map((e) => PricingStrategy.fromJson(e as Map<String, dynamic>))
      .toList(),
  marketInsights: MarketInsights.fromJson(
    json['marketInsights'] as Map<String, dynamic>,
  ),
  topRecommendation: json['topRecommendation'] as String,
  reasoning: json['reasoning'] as String,
);

Map<String, dynamic> _$PricingRecommendationsToJson(
  _PricingRecommendations instance,
) => <String, dynamic>{
  'serviceId': instance.serviceId,
  'analyzedAt': instance.analyzedAt,
  'current': instance.current,
  'strategies': instance.strategies,
  'marketInsights': instance.marketInsights,
  'topRecommendation': instance.topRecommendation,
  'reasoning': instance.reasoning,
};

_CurrentPricing _$CurrentPricingFromJson(Map<String, dynamic> json) =>
    _CurrentPricing(
      price: (json['price'] as num).toDouble(),
      demand: (json['demand'] as num).toDouble(),
      margin: (json['margin'] as num).toDouble(),
      competitiveness: json['competitiveness'] as String,
    );

Map<String, dynamic> _$CurrentPricingToJson(_CurrentPricing instance) =>
    <String, dynamic>{
      'price': instance.price,
      'demand': instance.demand,
      'margin': instance.margin,
      'competitiveness': instance.competitiveness,
    };

_PricingStrategy _$PricingStrategyFromJson(Map<String, dynamic> json) =>
    _PricingStrategy(
      strategy: json['strategy'] as String,
      recommendedPrice: (json['recommendedPrice'] as num).toDouble(),
      expectedRevenue: (json['expectedRevenue'] as num).toDouble(),
      expectedMargin: (json['expectedMargin'] as num).toDouble(),
      pros: (json['pros'] as List<dynamic>).map((e) => e as String).toList(),
      cons: (json['cons'] as List<dynamic>).map((e) => e as String).toList(),
      confidence: (json['confidence'] as num).toDouble(),
    );

Map<String, dynamic> _$PricingStrategyToJson(_PricingStrategy instance) =>
    <String, dynamic>{
      'strategy': instance.strategy,
      'recommendedPrice': instance.recommendedPrice,
      'expectedRevenue': instance.expectedRevenue,
      'expectedMargin': instance.expectedMargin,
      'pros': instance.pros,
      'cons': instance.cons,
      'confidence': instance.confidence,
    };

_MarketInsights _$MarketInsightsFromJson(Map<String, dynamic> json) =>
    _MarketInsights(
      competitorPricing: CompetitorPricing.fromJson(
        json['competitorPricing'] as Map<String, dynamic>,
      ),
      demandElasticity: (json['demandElasticity'] as num).toDouble(),
      priceOptimizationPotential: (json['priceOptimizationPotential'] as num)
          .toDouble(),
    );

Map<String, dynamic> _$MarketInsightsToJson(_MarketInsights instance) =>
    <String, dynamic>{
      'competitorPricing': instance.competitorPricing,
      'demandElasticity': instance.demandElasticity,
      'priceOptimizationPotential': instance.priceOptimizationPotential,
    };

_CompetitorPricing _$CompetitorPricingFromJson(Map<String, dynamic> json) =>
    _CompetitorPricing(
      average: (json['average'] as num).toDouble(),
      range: (json['range'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      position: json['position'] as String,
    );

Map<String, dynamic> _$CompetitorPricingToJson(_CompetitorPricing instance) =>
    <String, dynamic>{
      'average': instance.average,
      'range': instance.range,
      'position': instance.position,
    };

_Invoice _$InvoiceFromJson(Map<String, dynamic> json) => _Invoice(
  invoiceId: json['invoiceId'] as String,
  organizationId: json['organizationId'] as String,
  clientId: json['clientId'] as String,
  period: json['period'] as String,
  amount: (json['amount'] as num).toDouble(),
  gst: (json['gst'] as num).toDouble(),
  total: (json['total'] as num).toDouble(),
  status: json['status'] as String,
  createdAt: json['createdAt'] as String,
  lineItems: (json['lineItems'] as List<dynamic>)
      .map((e) => LineItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  validation: json['validation'] == null
      ? null
      : ValidationResult.fromJson(json['validation'] as Map<String, dynamic>),
  anomalies: (json['anomalies'] as List<dynamic>?)
      ?.map((e) => BillingAnomaly.fromJson(e as Map<String, dynamic>))
      .toList(),
  approvedAt: json['approvedAt'] as String?,
);

Map<String, dynamic> _$InvoiceToJson(_Invoice instance) => <String, dynamic>{
  'invoiceId': instance.invoiceId,
  'organizationId': instance.organizationId,
  'clientId': instance.clientId,
  'period': instance.period,
  'amount': instance.amount,
  'gst': instance.gst,
  'total': instance.total,
  'status': instance.status,
  'createdAt': instance.createdAt,
  'lineItems': instance.lineItems,
  'validation': instance.validation,
  'anomalies': instance.anomalies,
  'approvedAt': instance.approvedAt,
};

_LineItem _$LineItemFromJson(Map<String, dynamic> json) => _LineItem(
  description: json['description'] as String,
  quantity: (json['quantity'] as num).toInt(),
  rate: (json['rate'] as num).toDouble(),
  amount: (json['amount'] as num).toDouble(),
);

Map<String, dynamic> _$LineItemToJson(_LineItem instance) => <String, dynamic>{
  'description': instance.description,
  'quantity': instance.quantity,
  'rate': instance.rate,
  'amount': instance.amount,
};

_ValidationResult _$ValidationResultFromJson(Map<String, dynamic> json) =>
    _ValidationResult(
      passed: json['passed'] as bool,
      errors: (json['errors'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      warnings: (json['warnings'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      checks: (json['checks'] as List<dynamic>)
          .map((e) => ValidationCheck.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ValidationResultToJson(_ValidationResult instance) =>
    <String, dynamic>{
      'passed': instance.passed,
      'errors': instance.errors,
      'warnings': instance.warnings,
      'checks': instance.checks,
    };

_ValidationCheck _$ValidationCheckFromJson(Map<String, dynamic> json) =>
    _ValidationCheck(
      check: json['check'] as String,
      passed: json['passed'] as bool,
      errors: (json['errors'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      details: json['details'] as String,
    );

Map<String, dynamic> _$ValidationCheckToJson(_ValidationCheck instance) =>
    <String, dynamic>{
      'check': instance.check,
      'passed': instance.passed,
      'errors': instance.errors,
      'details': instance.details,
    };

_BillingAnomaly _$BillingAnomalyFromJson(Map<String, dynamic> json) =>
    _BillingAnomaly(
      type: json['type'] as String,
      severity: json['severity'] as String,
      description: json['description'] as String,
      details: json['details'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$BillingAnomalyToJson(_BillingAnomaly instance) =>
    <String, dynamic>{
      'type': instance.type,
      'severity': instance.severity,
      'description': instance.description,
      'details': instance.details,
    };

_CreditNote _$CreditNoteFromJson(Map<String, dynamic> json) => _CreditNote(
  creditNoteId: json['creditNoteId'] as String,
  invoiceId: json['invoiceId'] as String,
  amount: (json['amount'] as num).toDouble(),
  reason: json['reason'] as String,
  status: json['status'] as String,
  createdAt: json['createdAt'] as String,
  gst: (json['gst'] as num).toDouble(),
  totalCredit: (json['totalCredit'] as num).toDouble(),
  workflow: CreditNoteWorkflow.fromJson(
    json['workflow'] as Map<String, dynamic>,
  ),
  auditTrail: (json['auditTrail'] as List<dynamic>)
      .map((e) => AuditEntry.fromJson(e as Map<String, dynamic>))
      .toList(),
  approvedAt: json['approvedAt'] as String?,
);

Map<String, dynamic> _$CreditNoteToJson(_CreditNote instance) =>
    <String, dynamic>{
      'creditNoteId': instance.creditNoteId,
      'invoiceId': instance.invoiceId,
      'amount': instance.amount,
      'reason': instance.reason,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'gst': instance.gst,
      'totalCredit': instance.totalCredit,
      'workflow': instance.workflow,
      'auditTrail': instance.auditTrail,
      'approvedAt': instance.approvedAt,
    };

_CreditNoteWorkflow _$CreditNoteWorkflowFromJson(Map<String, dynamic> json) =>
    _CreditNoteWorkflow(
      requiresApproval: json['requiresApproval'] as bool,
      approvalLevel: json['approvalLevel'] as String,
      autoApprove: json['autoApprove'] as bool,
    );

Map<String, dynamic> _$CreditNoteWorkflowToJson(_CreditNoteWorkflow instance) =>
    <String, dynamic>{
      'requiresApproval': instance.requiresApproval,
      'approvalLevel': instance.approvalLevel,
      'autoApprove': instance.autoApprove,
    };

_AuditEntry _$AuditEntryFromJson(Map<String, dynamic> json) => _AuditEntry(
  action: json['action'] as String,
  timestamp: json['timestamp'] as String,
  reason: json['reason'] as String,
);

Map<String, dynamic> _$AuditEntryToJson(_AuditEntry instance) =>
    <String, dynamic>{
      'action': instance.action,
      'timestamp': instance.timestamp,
      'reason': instance.reason,
    };

_CashFlowForecast _$CashFlowForecastFromJson(Map<String, dynamic> json) =>
    _CashFlowForecast(
      organizationId: json['organizationId'] as String,
      horizon: (json['horizon'] as num).toInt(),
      generatedAt: json['generatedAt'] as String,
      currentPosition: CashPosition.fromJson(
        json['currentPosition'] as Map<String, dynamic>,
      ),
      dailyForecast: (json['dailyForecast'] as List<dynamic>)
          .map((e) => DailyCashFlow.fromJson(e as Map<String, dynamic>))
          .toList(),
      summary: CashFlowSummary.fromJson(
        json['summary'] as Map<String, dynamic>,
      ),
      risks: (json['risks'] as List<dynamic>)
          .map((e) => CashFlowRisk.fromJson(e as Map<String, dynamic>))
          .toList(),
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CashFlowForecastToJson(_CashFlowForecast instance) =>
    <String, dynamic>{
      'organizationId': instance.organizationId,
      'horizon': instance.horizon,
      'generatedAt': instance.generatedAt,
      'currentPosition': instance.currentPosition,
      'dailyForecast': instance.dailyForecast,
      'summary': instance.summary,
      'risks': instance.risks,
      'recommendations': instance.recommendations,
    };

_CashPosition _$CashPositionFromJson(Map<String, dynamic> json) =>
    _CashPosition(
      cash: (json['cash'] as num).toDouble(),
      receivables: (json['receivables'] as num).toDouble(),
      payables: (json['payables'] as num).toDouble(),
      netPosition: (json['netPosition'] as num).toDouble(),
    );

Map<String, dynamic> _$CashPositionToJson(_CashPosition instance) =>
    <String, dynamic>{
      'cash': instance.cash,
      'receivables': instance.receivables,
      'payables': instance.payables,
      'netPosition': instance.netPosition,
    };

_DailyCashFlow _$DailyCashFlowFromJson(Map<String, dynamic> json) =>
    _DailyCashFlow(
      date: json['date'] as String,
      openingBalance: (json['openingBalance'] as num).toDouble(),
      inflows: (json['inflows'] as num).toDouble(),
      outflows: (json['outflows'] as num).toDouble(),
      netFlow: (json['netFlow'] as num).toDouble(),
      closingBalance: (json['closingBalance'] as num).toDouble(),
      confidence: (json['confidence'] as num).toDouble(),
    );

Map<String, dynamic> _$DailyCashFlowToJson(_DailyCashFlow instance) =>
    <String, dynamic>{
      'date': instance.date,
      'openingBalance': instance.openingBalance,
      'inflows': instance.inflows,
      'outflows': instance.outflows,
      'netFlow': instance.netFlow,
      'closingBalance': instance.closingBalance,
      'confidence': instance.confidence,
    };

_CashFlowSummary _$CashFlowSummaryFromJson(Map<String, dynamic> json) =>
    _CashFlowSummary(
      projectedInflows: (json['projectedInflows'] as num).toDouble(),
      projectedOutflows: (json['projectedOutflows'] as num).toDouble(),
      netCashFlow: (json['netCashFlow'] as num).toDouble(),
      minimumBalance: (json['minimumBalance'] as num).toDouble(),
      maximumBalance: (json['maximumBalance'] as num).toDouble(),
    );

Map<String, dynamic> _$CashFlowSummaryToJson(_CashFlowSummary instance) =>
    <String, dynamic>{
      'projectedInflows': instance.projectedInflows,
      'projectedOutflows': instance.projectedOutflows,
      'netCashFlow': instance.netCashFlow,
      'minimumBalance': instance.minimumBalance,
      'maximumBalance': instance.maximumBalance,
    };

_CashFlowRisk _$CashFlowRiskFromJson(Map<String, dynamic> json) =>
    _CashFlowRisk(
      risk: json['risk'] as String,
      level: json['level'] as String,
      description: json['description'] as String,
      probability: (json['probability'] as num).toDouble(),
    );

Map<String, dynamic> _$CashFlowRiskToJson(_CashFlowRisk instance) =>
    <String, dynamic>{
      'risk': instance.risk,
      'level': instance.level,
      'description': instance.description,
      'probability': instance.probability,
    };

_PaymentPrediction _$PaymentPredictionFromJson(Map<String, dynamic> json) =>
    _PaymentPrediction(
      invoiceId: json['invoiceId'] as String,
      clientId: json['clientId'] as String,
      amount: (json['amount'] as num).toDouble(),
      dueDate: json['dueDate'] as String,
      paymentProbability: (json['paymentProbability'] as num).toDouble(),
      expectedPaymentDate: json['expectedPaymentDate'] as String,
      expectedDaysLate: (json['expectedDaysLate'] as num).toInt(),
      latePaymentRisk: json['latePaymentRisk'] as String,
      badDebtProbability: (json['badDebtProbability'] as num).toDouble(),
      actions: (json['actions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PaymentPredictionToJson(_PaymentPrediction instance) =>
    <String, dynamic>{
      'invoiceId': instance.invoiceId,
      'clientId': instance.clientId,
      'amount': instance.amount,
      'dueDate': instance.dueDate,
      'paymentProbability': instance.paymentProbability,
      'expectedPaymentDate': instance.expectedPaymentDate,
      'expectedDaysLate': instance.expectedDaysLate,
      'latePaymentRisk': instance.latePaymentRisk,
      'badDebtProbability': instance.badDebtProbability,
      'actions': instance.actions,
    };

_FinancialDashboard _$FinancialDashboardFromJson(Map<String, dynamic> json) =>
    _FinancialDashboard(
      organizationId: json['organizationId'] as String,
      period: json['period'] as String,
      generatedAt: json['generatedAt'] as String,
      kpis: (json['kpis'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, KPI.fromJson(e as Map<String, dynamic>)),
      ),
      revenueByService: (json['revenueByService'] as List<dynamic>)
          .map((e) => RevenueByService.fromJson(e as Map<String, dynamic>))
          .toList(),
      profitabilityByClient: (json['profitabilityByClient'] as List<dynamic>)
          .map((e) => ClientProfitability.fromJson(e as Map<String, dynamic>))
          .toList(),
      costAnalysis: CostAnalysis.fromJson(
        json['costAnalysis'] as Map<String, dynamic>,
      ),
      trends: (json['trends'] as List<dynamic>)
          .map((e) => TrendData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FinancialDashboardToJson(_FinancialDashboard instance) =>
    <String, dynamic>{
      'organizationId': instance.organizationId,
      'period': instance.period,
      'generatedAt': instance.generatedAt,
      'kpis': instance.kpis,
      'revenueByService': instance.revenueByService,
      'profitabilityByClient': instance.profitabilityByClient,
      'costAnalysis': instance.costAnalysis,
      'trends': instance.trends,
    };

_KPI _$KPIFromJson(Map<String, dynamic> json) => _KPI(
  value: (json['value'] as num).toDouble(),
  change: (json['change'] as num).toDouble(),
  trend: json['trend'] as String,
);

Map<String, dynamic> _$KPIToJson(_KPI instance) => <String, dynamic>{
  'value': instance.value,
  'change': instance.change,
  'trend': instance.trend,
};

_RevenueByService _$RevenueByServiceFromJson(Map<String, dynamic> json) =>
    _RevenueByService(
      service: json['service'] as String,
      revenue: (json['revenue'] as num).toDouble(),
      percentage: (json['percentage'] as num).toDouble(),
    );

Map<String, dynamic> _$RevenueByServiceToJson(_RevenueByService instance) =>
    <String, dynamic>{
      'service': instance.service,
      'revenue': instance.revenue,
      'percentage': instance.percentage,
    };

_ClientProfitability _$ClientProfitabilityFromJson(Map<String, dynamic> json) =>
    _ClientProfitability(
      clientId: json['clientId'] as String,
      revenue: (json['revenue'] as num).toDouble(),
      cost: (json['cost'] as num).toDouble(),
      profit: (json['profit'] as num).toDouble(),
      margin: (json['margin'] as num).toDouble(),
    );

Map<String, dynamic> _$ClientProfitabilityToJson(
  _ClientProfitability instance,
) => <String, dynamic>{
  'clientId': instance.clientId,
  'revenue': instance.revenue,
  'cost': instance.cost,
  'profit': instance.profit,
  'margin': instance.margin,
};

_CostAnalysis _$CostAnalysisFromJson(Map<String, dynamic> json) =>
    _CostAnalysis(
      labor: CostCategory.fromJson(json['labor'] as Map<String, dynamic>),
      overhead: CostCategory.fromJson(json['overhead'] as Map<String, dynamic>),
      materials: CostCategory.fromJson(
        json['materials'] as Map<String, dynamic>,
      ),
      other: CostCategory.fromJson(json['other'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CostAnalysisToJson(_CostAnalysis instance) =>
    <String, dynamic>{
      'labor': instance.labor,
      'overhead': instance.overhead,
      'materials': instance.materials,
      'other': instance.other,
    };

_CostCategory _$CostCategoryFromJson(Map<String, dynamic> json) =>
    _CostCategory(
      amount: (json['amount'] as num).toDouble(),
      percentage: (json['percentage'] as num).toDouble(),
    );

Map<String, dynamic> _$CostCategoryToJson(_CostCategory instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'percentage': instance.percentage,
    };

_TrendData _$TrendDataFromJson(Map<String, dynamic> json) => _TrendData(
  month: json['month'] as String,
  revenue: (json['revenue'] as num).toDouble(),
  profit: (json['profit'] as num).toDouble(),
);

Map<String, dynamic> _$TrendDataToJson(_TrendData instance) =>
    <String, dynamic>{
      'month': instance.month,
      'revenue': instance.revenue,
      'profit': instance.profit,
    };

_Budget _$BudgetFromJson(Map<String, dynamic> json) => _Budget(
  budgetId: json['budgetId'] as String,
  organizationId: json['organizationId'] as String,
  period: json['period'] as String,
  createdAt: json['createdAt'] as String,
  revenue: BudgetCategory.fromJson(json['revenue'] as Map<String, dynamic>),
  expenses: BudgetCategory.fromJson(json['expenses'] as Map<String, dynamic>),
  profit: BudgetCategory.fromJson(json['profit'] as Map<String, dynamic>),
  assumptions: (json['assumptions'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  scenarios: BudgetScenarios.fromJson(
    json['scenarios'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$BudgetToJson(_Budget instance) => <String, dynamic>{
  'budgetId': instance.budgetId,
  'organizationId': instance.organizationId,
  'period': instance.period,
  'createdAt': instance.createdAt,
  'revenue': instance.revenue,
  'expenses': instance.expenses,
  'profit': instance.profit,
  'assumptions': instance.assumptions,
  'scenarios': instance.scenarios,
};

_BudgetCategory _$BudgetCategoryFromJson(Map<String, dynamic> json) =>
    _BudgetCategory(
      total: (json['total'] as num).toDouble(),
      breakdown: json['breakdown'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$BudgetCategoryToJson(_BudgetCategory instance) =>
    <String, dynamic>{'total': instance.total, 'breakdown': instance.breakdown};

_BudgetScenarios _$BudgetScenariosFromJson(Map<String, dynamic> json) =>
    _BudgetScenarios(
      best: BudgetScenario.fromJson(json['best'] as Map<String, dynamic>),
      base: BudgetScenario.fromJson(json['base'] as Map<String, dynamic>),
      worst: BudgetScenario.fromJson(json['worst'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BudgetScenariosToJson(_BudgetScenarios instance) =>
    <String, dynamic>{
      'best': instance.best,
      'base': instance.base,
      'worst': instance.worst,
    };

_BudgetScenario _$BudgetScenarioFromJson(Map<String, dynamic> json) =>
    _BudgetScenario(
      revenue: (json['revenue'] as num).toDouble(),
      profit: (json['profit'] as num).toDouble(),
    );

Map<String, dynamic> _$BudgetScenarioToJson(_BudgetScenario instance) =>
    <String, dynamic>{'revenue': instance.revenue, 'profit': instance.profit};

_Payment _$PaymentFromJson(Map<String, dynamic> json) => _Payment(
  paymentId: json['paymentId'] as String,
  amount: (json['amount'] as num).toDouble(),
  method: json['method'] as String,
  status: json['status'] as String,
  processedAt: json['processedAt'] as String,
  routing: PaymentRouting.fromJson(json['routing'] as Map<String, dynamic>),
  fees: PaymentFees.fromJson(json['fees'] as Map<String, dynamic>),
  estimatedCompletion: json['estimatedCompletion'] as String,
);

Map<String, dynamic> _$PaymentToJson(_Payment instance) => <String, dynamic>{
  'paymentId': instance.paymentId,
  'amount': instance.amount,
  'method': instance.method,
  'status': instance.status,
  'processedAt': instance.processedAt,
  'routing': instance.routing,
  'fees': instance.fees,
  'estimatedCompletion': instance.estimatedCompletion,
};

_PaymentRouting _$PaymentRoutingFromJson(Map<String, dynamic> json) =>
    _PaymentRouting(
      processor: json['processor'] as String,
      gateway: json['gateway'] as String,
      estimatedFee: (json['estimatedFee'] as num).toDouble(),
    );

Map<String, dynamic> _$PaymentRoutingToJson(_PaymentRouting instance) =>
    <String, dynamic>{
      'processor': instance.processor,
      'gateway': instance.gateway,
      'estimatedFee': instance.estimatedFee,
    };

_PaymentFees _$PaymentFeesFromJson(Map<String, dynamic> json) => _PaymentFees(
  processing: (json['processing'] as num).toDouble(),
  gateway: (json['gateway'] as num).toDouble(),
  total: (json['total'] as num).toDouble(),
);

Map<String, dynamic> _$PaymentFeesToJson(_PaymentFees instance) =>
    <String, dynamic>{
      'processing': instance.processing,
      'gateway': instance.gateway,
      'total': instance.total,
    };

_ComplianceCheck _$ComplianceCheckFromJson(
  Map<String, dynamic> json,
) => _ComplianceCheck(
  organizationId: json['organizationId'] as String,
  checkedAt: json['checkedAt'] as String,
  ndis: ComplianceArea.fromJson(json['ndis'] as Map<String, dynamic>),
  tax: ComplianceArea.fromJson(json['tax'] as Map<String, dynamic>),
  reporting: ComplianceArea.fromJson(json['reporting'] as Map<String, dynamic>),
  overallStatus: json['overallStatus'] as String,
  score: (json['score'] as num).toDouble(),
  issues: (json['issues'] as List<dynamic>).map((e) => e as String).toList(),
  recommendations: (json['recommendations'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$ComplianceCheckToJson(_ComplianceCheck instance) =>
    <String, dynamic>{
      'organizationId': instance.organizationId,
      'checkedAt': instance.checkedAt,
      'ndis': instance.ndis,
      'tax': instance.tax,
      'reporting': instance.reporting,
      'overallStatus': instance.overallStatus,
      'score': instance.score,
      'issues': instance.issues,
      'recommendations': instance.recommendations,
    };

_ComplianceArea _$ComplianceAreaFromJson(Map<String, dynamic> json) =>
    _ComplianceArea(
      status: json['status'] as String,
      checks: (json['checks'] as List<dynamic>)
          .map((e) => ComplianceAreaCheck.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ComplianceAreaToJson(_ComplianceArea instance) =>
    <String, dynamic>{'status': instance.status, 'checks': instance.checks};

_ComplianceAreaCheck _$ComplianceAreaCheckFromJson(Map<String, dynamic> json) =>
    _ComplianceAreaCheck(
      check: json['check'] as String,
      passed: json['passed'] as bool,
    );

Map<String, dynamic> _$ComplianceAreaCheckToJson(
  _ComplianceAreaCheck instance,
) => <String, dynamic>{'check': instance.check, 'passed': instance.passed};

_ClientCredit _$ClientCreditFromJson(Map<String, dynamic> json) =>
    _ClientCredit(
      clientId: json['clientId'] as String,
      organizationId: json['organizationId'] as String,
      analyzedAt: json['analyzedAt'] as String,
      current: CreditCurrent.fromJson(json['current'] as Map<String, dynamic>),
      recommended: CreditRecommended.fromJson(
        json['recommended'] as Map<String, dynamic>,
      ),
      riskScore: (json['riskScore'] as num).toDouble(),
      paymentHistory: PaymentHistory.fromJson(
        json['paymentHistory'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ClientCreditToJson(_ClientCredit instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'organizationId': instance.organizationId,
      'analyzedAt': instance.analyzedAt,
      'current': instance.current,
      'recommended': instance.recommended,
      'riskScore': instance.riskScore,
      'paymentHistory': instance.paymentHistory,
    };

_CreditCurrent _$CreditCurrentFromJson(Map<String, dynamic> json) =>
    _CreditCurrent(
      limit: (json['limit'] as num).toDouble(),
      utilized: (json['utilized'] as num).toDouble(),
      available: (json['available'] as num).toDouble(),
      utilizationRate: (json['utilizationRate'] as num).toDouble(),
    );

Map<String, dynamic> _$CreditCurrentToJson(_CreditCurrent instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'utilized': instance.utilized,
      'available': instance.available,
      'utilizationRate': instance.utilizationRate,
    };

_CreditRecommended _$CreditRecommendedFromJson(Map<String, dynamic> json) =>
    _CreditRecommended(
      limit: (json['limit'] as num).toDouble(),
      reasoning: json['reasoning'] as String,
      confidence: (json['confidence'] as num).toDouble(),
    );

Map<String, dynamic> _$CreditRecommendedToJson(_CreditRecommended instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'reasoning': instance.reasoning,
      'confidence': instance.confidence,
    };

_PaymentHistory _$PaymentHistoryFromJson(Map<String, dynamic> json) =>
    _PaymentHistory(
      onTime: (json['onTime'] as num).toInt(),
      late: (json['late'] as num).toInt(),
      averageDaysLate: (json['averageDaysLate'] as num).toInt(),
    );

Map<String, dynamic> _$PaymentHistoryToJson(_PaymentHistory instance) =>
    <String, dynamic>{
      'onTime': instance.onTime,
      'late': instance.late,
      'averageDaysLate': instance.averageDaysLate,
    };

_ClientLifetimeValue _$ClientLifetimeValueFromJson(Map<String, dynamic> json) =>
    _ClientLifetimeValue(
      clientId: json['clientId'] as String,
      organizationId: json['organizationId'] as String,
      calculatedAt: json['calculatedAt'] as String,
      current: CLVCurrent.fromJson(json['current'] as Map<String, dynamic>),
      predicted: CLVPredicted.fromJson(
        json['predicted'] as Map<String, dynamic>,
      ),
      segments: json['segments'] as String,
      opportunities: (json['opportunities'] as List<dynamic>)
          .map((e) => UpsellOpportunity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClientLifetimeValueToJson(
  _ClientLifetimeValue instance,
) => <String, dynamic>{
  'clientId': instance.clientId,
  'organizationId': instance.organizationId,
  'calculatedAt': instance.calculatedAt,
  'current': instance.current,
  'predicted': instance.predicted,
  'segments': instance.segments,
  'opportunities': instance.opportunities,
};

_CLVCurrent _$CLVCurrentFromJson(Map<String, dynamic> json) => _CLVCurrent(
  totalRevenue: (json['totalRevenue'] as num).toDouble(),
  totalProfit: (json['totalProfit'] as num).toDouble(),
  tenure: (json['tenure'] as num).toInt(),
);

Map<String, dynamic> _$CLVCurrentToJson(_CLVCurrent instance) =>
    <String, dynamic>{
      'totalRevenue': instance.totalRevenue,
      'totalProfit': instance.totalProfit,
      'tenure': instance.tenure,
    };

_CLVPredicted _$CLVPredictedFromJson(Map<String, dynamic> json) =>
    _CLVPredicted(
      lifetimeValue: (json['lifetimeValue'] as num).toDouble(),
      remainingValue: (json['remainingValue'] as num).toDouble(),
      churnProbability: (json['churnProbability'] as num).toDouble(),
      expectedTenure: (json['expectedTenure'] as num).toInt(),
    );

Map<String, dynamic> _$CLVPredictedToJson(_CLVPredicted instance) =>
    <String, dynamic>{
      'lifetimeValue': instance.lifetimeValue,
      'remainingValue': instance.remainingValue,
      'churnProbability': instance.churnProbability,
      'expectedTenure': instance.expectedTenure,
    };

_UpsellOpportunity _$UpsellOpportunityFromJson(Map<String, dynamic> json) =>
    _UpsellOpportunity(
      opportunity: json['opportunity'] as String,
      potential: (json['potential'] as num).toDouble(),
    );

Map<String, dynamic> _$UpsellOpportunityToJson(_UpsellOpportunity instance) =>
    <String, dynamic>{
      'opportunity': instance.opportunity,
      'potential': instance.potential,
    };

_ExecutiveReport _$ExecutiveReportFromJson(Map<String, dynamic> json) =>
    _ExecutiveReport(
      organizationId: json['organizationId'] as String,
      period: json['period'] as String,
      generatedAt: json['generatedAt'] as String,
      profitAndLoss: ProfitAndLoss.fromJson(
        json['profitAndLoss'] as Map<String, dynamic>,
      ),
      balanceSheet: BalanceSheet.fromJson(
        json['balanceSheet'] as Map<String, dynamic>,
      ),
      cashFlow: CashFlowStatement.fromJson(
        json['cashFlow'] as Map<String, dynamic>,
      ),
      keyMetrics: (json['keyMetrics'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      insights: (json['insights'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ExecutiveReportToJson(_ExecutiveReport instance) =>
    <String, dynamic>{
      'organizationId': instance.organizationId,
      'period': instance.period,
      'generatedAt': instance.generatedAt,
      'profitAndLoss': instance.profitAndLoss,
      'balanceSheet': instance.balanceSheet,
      'cashFlow': instance.cashFlow,
      'keyMetrics': instance.keyMetrics,
      'insights': instance.insights,
    };

_ProfitAndLoss _$ProfitAndLossFromJson(Map<String, dynamic> json) =>
    _ProfitAndLoss(
      revenue: (json['revenue'] as num).toDouble(),
      costOfSales: (json['costOfSales'] as num).toDouble(),
      grossProfit: (json['grossProfit'] as num).toDouble(),
      operatingExpenses: (json['operatingExpenses'] as num).toDouble(),
      netProfit: (json['netProfit'] as num).toDouble(),
    );

Map<String, dynamic> _$ProfitAndLossToJson(_ProfitAndLoss instance) =>
    <String, dynamic>{
      'revenue': instance.revenue,
      'costOfSales': instance.costOfSales,
      'grossProfit': instance.grossProfit,
      'operatingExpenses': instance.operatingExpenses,
      'netProfit': instance.netProfit,
    };

_BalanceSheet _$BalanceSheetFromJson(Map<String, dynamic> json) =>
    _BalanceSheet(
      assets: BalanceSheetAssets.fromJson(
        json['assets'] as Map<String, dynamic>,
      ),
      liabilities: BalanceSheetLiabilities.fromJson(
        json['liabilities'] as Map<String, dynamic>,
      ),
      equity: (json['equity'] as num).toDouble(),
    );

Map<String, dynamic> _$BalanceSheetToJson(_BalanceSheet instance) =>
    <String, dynamic>{
      'assets': instance.assets,
      'liabilities': instance.liabilities,
      'equity': instance.equity,
    };

_BalanceSheetAssets _$BalanceSheetAssetsFromJson(Map<String, dynamic> json) =>
    _BalanceSheetAssets(
      current: (json['current'] as num).toDouble(),
      fixed: (json['fixed'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );

Map<String, dynamic> _$BalanceSheetAssetsToJson(_BalanceSheetAssets instance) =>
    <String, dynamic>{
      'current': instance.current,
      'fixed': instance.fixed,
      'total': instance.total,
    };

_BalanceSheetLiabilities _$BalanceSheetLiabilitiesFromJson(
  Map<String, dynamic> json,
) => _BalanceSheetLiabilities(
  current: (json['current'] as num).toDouble(),
  longTerm: (json['longTerm'] as num).toDouble(),
  total: (json['total'] as num).toDouble(),
);

Map<String, dynamic> _$BalanceSheetLiabilitiesToJson(
  _BalanceSheetLiabilities instance,
) => <String, dynamic>{
  'current': instance.current,
  'longTerm': instance.longTerm,
  'total': instance.total,
};

_CashFlowStatement _$CashFlowStatementFromJson(Map<String, dynamic> json) =>
    _CashFlowStatement(
      operating: (json['operating'] as num).toDouble(),
      investing: (json['investing'] as num).toDouble(),
      financing: (json['financing'] as num).toDouble(),
      netChange: (json['netChange'] as num).toDouble(),
    );

Map<String, dynamic> _$CashFlowStatementToJson(_CashFlowStatement instance) =>
    <String, dynamic>{
      'operating': instance.operating,
      'investing': instance.investing,
      'financing': instance.financing,
      'netChange': instance.netChange,
    };
