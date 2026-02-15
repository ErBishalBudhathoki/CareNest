// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_intelligence_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RevenueForecastImpl _$$RevenueForecastImplFromJson(
        Map<String, dynamic> json) =>
    _$RevenueForecastImpl(
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
              json['confidenceIntervals'] as Map<String, dynamic>),
      scenarios: json['scenarios'] == null
          ? null
          : ForecastScenarios.fromJson(
              json['scenarios'] as Map<String, dynamic>),
      metrics:
          ForecastMetrics.fromJson(json['metrics'] as Map<String, dynamic>),
      insights:
          (json['insights'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$RevenueForecastImplToJson(
        _$RevenueForecastImpl instance) =>
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

_$DailyPredictionImpl _$$DailyPredictionImplFromJson(
        Map<String, dynamic> json) =>
    _$DailyPredictionImpl(
      date: json['date'] as String,
      predicted: (json['predicted'] as num).toDouble(),
      confidence: (json['confidence'] as num).toDouble(),
    );

Map<String, dynamic> _$$DailyPredictionImplToJson(
        _$DailyPredictionImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'predicted': instance.predicted,
      'confidence': instance.confidence,
    };

_$ConfidenceIntervalsImpl _$$ConfidenceIntervalsImplFromJson(
        Map<String, dynamic> json) =>
    _$ConfidenceIntervalsImpl(
      intervals: (json['intervals'] as List<dynamic>)
          .map((e) => ConfidenceInterval.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ConfidenceIntervalsImplToJson(
        _$ConfidenceIntervalsImpl instance) =>
    <String, dynamic>{
      'intervals': instance.intervals,
    };

_$ConfidenceIntervalImpl _$$ConfidenceIntervalImplFromJson(
        Map<String, dynamic> json) =>
    _$ConfidenceIntervalImpl(
      date: json['date'] as String,
      lower: (json['lower'] as num).toDouble(),
      upper: (json['upper'] as num).toDouble(),
      confidence: (json['confidence'] as num).toDouble(),
    );

Map<String, dynamic> _$$ConfidenceIntervalImplToJson(
        _$ConfidenceIntervalImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'lower': instance.lower,
      'upper': instance.upper,
      'confidence': instance.confidence,
    };

_$ForecastScenariosImpl _$$ForecastScenariosImplFromJson(
        Map<String, dynamic> json) =>
    _$ForecastScenariosImpl(
      bestCase: (json['bestCase'] as num).toDouble(),
      mostLikely: (json['mostLikely'] as num).toDouble(),
      worstCase: (json['worstCase'] as num).toDouble(),
    );

Map<String, dynamic> _$$ForecastScenariosImplToJson(
        _$ForecastScenariosImpl instance) =>
    <String, dynamic>{
      'bestCase': instance.bestCase,
      'mostLikely': instance.mostLikely,
      'worstCase': instance.worstCase,
    };

_$ForecastMetricsImpl _$$ForecastMetricsImplFromJson(
        Map<String, dynamic> json) =>
    _$ForecastMetricsImpl(
      arimaAccuracy: (json['arimaAccuracy'] as num).toDouble(),
      prophetAccuracy: (json['prophetAccuracy'] as num).toDouble(),
      lstmAccuracy: (json['lstmAccuracy'] as num).toDouble(),
      ensembleAccuracy: (json['ensembleAccuracy'] as num).toDouble(),
      mae: (json['mae'] as num).toDouble(),
      rmse: (json['rmse'] as num).toDouble(),
    );

Map<String, dynamic> _$$ForecastMetricsImplToJson(
        _$ForecastMetricsImpl instance) =>
    <String, dynamic>{
      'arimaAccuracy': instance.arimaAccuracy,
      'prophetAccuracy': instance.prophetAccuracy,
      'lstmAccuracy': instance.lstmAccuracy,
      'ensembleAccuracy': instance.ensembleAccuracy,
      'mae': instance.mae,
      'rmse': instance.rmse,
    };

_$RevenueDriversImpl _$$RevenueDriversImplFromJson(Map<String, dynamic> json) =>
    _$RevenueDriversImpl(
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

Map<String, dynamic> _$$RevenueDriversImplToJson(
        _$RevenueDriversImpl instance) =>
    <String, dynamic>{
      'organizationId': instance.organizationId,
      'period': instance.period,
      'analyzedAt': instance.analyzedAt,
      'primaryDrivers': instance.primaryDrivers,
      'externalFactors': instance.externalFactors,
      'recommendations': instance.recommendations,
    };

_$PrimaryDriverImpl _$$PrimaryDriverImplFromJson(Map<String, dynamic> json) =>
    _$PrimaryDriverImpl(
      driver: json['driver'] as String,
      impact: (json['impact'] as num).toDouble(),
      trend: json['trend'] as String,
      correlation: (json['correlation'] as num).toDouble(),
      elasticity: (json['elasticity'] as num).toDouble(),
    );

Map<String, dynamic> _$$PrimaryDriverImplToJson(_$PrimaryDriverImpl instance) =>
    <String, dynamic>{
      'driver': instance.driver,
      'impact': instance.impact,
      'trend': instance.trend,
      'correlation': instance.correlation,
      'elasticity': instance.elasticity,
    };

_$ExternalFactorImpl _$$ExternalFactorImplFromJson(Map<String, dynamic> json) =>
    _$ExternalFactorImpl(
      factor: json['factor'] as String,
      impact: (json['impact'] as num).toDouble(),
      probability: (json['probability'] as num).toDouble(),
      potentialEffect: json['potentialEffect'] as String,
    );

Map<String, dynamic> _$$ExternalFactorImplToJson(
        _$ExternalFactorImpl instance) =>
    <String, dynamic>{
      'factor': instance.factor,
      'impact': instance.impact,
      'probability': instance.probability,
      'potentialEffect': instance.potentialEffect,
    };

_$PriceOptimizationImpl _$$PriceOptimizationImplFromJson(
        Map<String, dynamic> json) =>
    _$PriceOptimizationImpl(
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

Map<String, dynamic> _$$PriceOptimizationImplToJson(
        _$PriceOptimizationImpl instance) =>
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

_$PriceImpactImpl _$$PriceImpactImplFromJson(Map<String, dynamic> json) =>
    _$PriceImpactImpl(
      demandChange: (json['demandChange'] as num).toDouble(),
      revenueChange: (json['revenueChange'] as num).toDouble(),
      marginChange: (json['marginChange'] as num).toDouble(),
    );

Map<String, dynamic> _$$PriceImpactImplToJson(_$PriceImpactImpl instance) =>
    <String, dynamic>{
      'demandChange': instance.demandChange,
      'revenueChange': instance.revenueChange,
      'marginChange': instance.marginChange,
    };

_$ABTestImpl _$$ABTestImplFromJson(Map<String, dynamic> json) => _$ABTestImpl(
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

Map<String, dynamic> _$$ABTestImplToJson(_$ABTestImpl instance) =>
    <String, dynamic>{
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

_$ABVariantImpl _$$ABVariantImplFromJson(Map<String, dynamic> json) =>
    _$ABVariantImpl(
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      allocation: (json['allocation'] as num).toDouble(),
      metrics: ABMetrics.fromJson(json['metrics'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ABVariantImplToJson(_$ABVariantImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'allocation': instance.allocation,
      'metrics': instance.metrics,
    };

_$ABMetricsImpl _$$ABMetricsImplFromJson(Map<String, dynamic> json) =>
    _$ABMetricsImpl(
      conversions: (json['conversions'] as num).toInt(),
      revenue: (json['revenue'] as num).toDouble(),
      sampleSize: (json['sampleSize'] as num).toInt(),
    );

Map<String, dynamic> _$$ABMetricsImplToJson(_$ABMetricsImpl instance) =>
    <String, dynamic>{
      'conversions': instance.conversions,
      'revenue': instance.revenue,
      'sampleSize': instance.sampleSize,
    };

_$PricingRecommendationsImpl _$$PricingRecommendationsImplFromJson(
        Map<String, dynamic> json) =>
    _$PricingRecommendationsImpl(
      serviceId: json['serviceId'] as String,
      analyzedAt: json['analyzedAt'] as String,
      current: CurrentPricing.fromJson(json['current'] as Map<String, dynamic>),
      strategies: (json['strategies'] as List<dynamic>)
          .map((e) => PricingStrategy.fromJson(e as Map<String, dynamic>))
          .toList(),
      marketInsights: MarketInsights.fromJson(
          json['marketInsights'] as Map<String, dynamic>),
      topRecommendation: json['topRecommendation'] as String,
      reasoning: json['reasoning'] as String,
    );

Map<String, dynamic> _$$PricingRecommendationsImplToJson(
        _$PricingRecommendationsImpl instance) =>
    <String, dynamic>{
      'serviceId': instance.serviceId,
      'analyzedAt': instance.analyzedAt,
      'current': instance.current,
      'strategies': instance.strategies,
      'marketInsights': instance.marketInsights,
      'topRecommendation': instance.topRecommendation,
      'reasoning': instance.reasoning,
    };

_$CurrentPricingImpl _$$CurrentPricingImplFromJson(Map<String, dynamic> json) =>
    _$CurrentPricingImpl(
      price: (json['price'] as num).toDouble(),
      demand: (json['demand'] as num).toDouble(),
      margin: (json['margin'] as num).toDouble(),
      competitiveness: json['competitiveness'] as String,
    );

Map<String, dynamic> _$$CurrentPricingImplToJson(
        _$CurrentPricingImpl instance) =>
    <String, dynamic>{
      'price': instance.price,
      'demand': instance.demand,
      'margin': instance.margin,
      'competitiveness': instance.competitiveness,
    };

_$PricingStrategyImpl _$$PricingStrategyImplFromJson(
        Map<String, dynamic> json) =>
    _$PricingStrategyImpl(
      strategy: json['strategy'] as String,
      recommendedPrice: (json['recommendedPrice'] as num).toDouble(),
      expectedRevenue: (json['expectedRevenue'] as num).toDouble(),
      expectedMargin: (json['expectedMargin'] as num).toDouble(),
      pros: (json['pros'] as List<dynamic>).map((e) => e as String).toList(),
      cons: (json['cons'] as List<dynamic>).map((e) => e as String).toList(),
      confidence: (json['confidence'] as num).toDouble(),
    );

Map<String, dynamic> _$$PricingStrategyImplToJson(
        _$PricingStrategyImpl instance) =>
    <String, dynamic>{
      'strategy': instance.strategy,
      'recommendedPrice': instance.recommendedPrice,
      'expectedRevenue': instance.expectedRevenue,
      'expectedMargin': instance.expectedMargin,
      'pros': instance.pros,
      'cons': instance.cons,
      'confidence': instance.confidence,
    };

_$MarketInsightsImpl _$$MarketInsightsImplFromJson(Map<String, dynamic> json) =>
    _$MarketInsightsImpl(
      competitorPricing: CompetitorPricing.fromJson(
          json['competitorPricing'] as Map<String, dynamic>),
      demandElasticity: (json['demandElasticity'] as num).toDouble(),
      priceOptimizationPotential:
          (json['priceOptimizationPotential'] as num).toDouble(),
    );

Map<String, dynamic> _$$MarketInsightsImplToJson(
        _$MarketInsightsImpl instance) =>
    <String, dynamic>{
      'competitorPricing': instance.competitorPricing,
      'demandElasticity': instance.demandElasticity,
      'priceOptimizationPotential': instance.priceOptimizationPotential,
    };

_$CompetitorPricingImpl _$$CompetitorPricingImplFromJson(
        Map<String, dynamic> json) =>
    _$CompetitorPricingImpl(
      average: (json['average'] as num).toDouble(),
      range: (json['range'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      position: json['position'] as String,
    );

Map<String, dynamic> _$$CompetitorPricingImplToJson(
        _$CompetitorPricingImpl instance) =>
    <String, dynamic>{
      'average': instance.average,
      'range': instance.range,
      'position': instance.position,
    };

_$InvoiceImpl _$$InvoiceImplFromJson(Map<String, dynamic> json) =>
    _$InvoiceImpl(
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
          : ValidationResult.fromJson(
              json['validation'] as Map<String, dynamic>),
      anomalies: (json['anomalies'] as List<dynamic>?)
          ?.map((e) => BillingAnomaly.fromJson(e as Map<String, dynamic>))
          .toList(),
      approvedAt: json['approvedAt'] as String?,
    );

Map<String, dynamic> _$$InvoiceImplToJson(_$InvoiceImpl instance) =>
    <String, dynamic>{
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

_$LineItemImpl _$$LineItemImplFromJson(Map<String, dynamic> json) =>
    _$LineItemImpl(
      description: json['description'] as String,
      quantity: (json['quantity'] as num).toInt(),
      rate: (json['rate'] as num).toDouble(),
      amount: (json['amount'] as num).toDouble(),
    );

Map<String, dynamic> _$$LineItemImplToJson(_$LineItemImpl instance) =>
    <String, dynamic>{
      'description': instance.description,
      'quantity': instance.quantity,
      'rate': instance.rate,
      'amount': instance.amount,
    };

_$ValidationResultImpl _$$ValidationResultImplFromJson(
        Map<String, dynamic> json) =>
    _$ValidationResultImpl(
      passed: json['passed'] as bool,
      errors:
          (json['errors'] as List<dynamic>).map((e) => e as String).toList(),
      warnings:
          (json['warnings'] as List<dynamic>).map((e) => e as String).toList(),
      checks: (json['checks'] as List<dynamic>)
          .map((e) => ValidationCheck.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ValidationResultImplToJson(
        _$ValidationResultImpl instance) =>
    <String, dynamic>{
      'passed': instance.passed,
      'errors': instance.errors,
      'warnings': instance.warnings,
      'checks': instance.checks,
    };

_$ValidationCheckImpl _$$ValidationCheckImplFromJson(
        Map<String, dynamic> json) =>
    _$ValidationCheckImpl(
      check: json['check'] as String,
      passed: json['passed'] as bool,
      errors:
          (json['errors'] as List<dynamic>).map((e) => e as String).toList(),
      details: json['details'] as String,
    );

Map<String, dynamic> _$$ValidationCheckImplToJson(
        _$ValidationCheckImpl instance) =>
    <String, dynamic>{
      'check': instance.check,
      'passed': instance.passed,
      'errors': instance.errors,
      'details': instance.details,
    };

_$BillingAnomalyImpl _$$BillingAnomalyImplFromJson(Map<String, dynamic> json) =>
    _$BillingAnomalyImpl(
      type: json['type'] as String,
      severity: json['severity'] as String,
      description: json['description'] as String,
      details: json['details'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$BillingAnomalyImplToJson(
        _$BillingAnomalyImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'severity': instance.severity,
      'description': instance.description,
      'details': instance.details,
    };

_$CreditNoteImpl _$$CreditNoteImplFromJson(Map<String, dynamic> json) =>
    _$CreditNoteImpl(
      creditNoteId: json['creditNoteId'] as String,
      invoiceId: json['invoiceId'] as String,
      amount: (json['amount'] as num).toDouble(),
      reason: json['reason'] as String,
      status: json['status'] as String,
      createdAt: json['createdAt'] as String,
      gst: (json['gst'] as num).toDouble(),
      totalCredit: (json['totalCredit'] as num).toDouble(),
      workflow:
          CreditNoteWorkflow.fromJson(json['workflow'] as Map<String, dynamic>),
      auditTrail: (json['auditTrail'] as List<dynamic>)
          .map((e) => AuditEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      approvedAt: json['approvedAt'] as String?,
    );

Map<String, dynamic> _$$CreditNoteImplToJson(_$CreditNoteImpl instance) =>
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

_$CreditNoteWorkflowImpl _$$CreditNoteWorkflowImplFromJson(
        Map<String, dynamic> json) =>
    _$CreditNoteWorkflowImpl(
      requiresApproval: json['requiresApproval'] as bool,
      approvalLevel: json['approvalLevel'] as String,
      autoApprove: json['autoApprove'] as bool,
    );

Map<String, dynamic> _$$CreditNoteWorkflowImplToJson(
        _$CreditNoteWorkflowImpl instance) =>
    <String, dynamic>{
      'requiresApproval': instance.requiresApproval,
      'approvalLevel': instance.approvalLevel,
      'autoApprove': instance.autoApprove,
    };

_$AuditEntryImpl _$$AuditEntryImplFromJson(Map<String, dynamic> json) =>
    _$AuditEntryImpl(
      action: json['action'] as String,
      timestamp: json['timestamp'] as String,
      reason: json['reason'] as String,
    );

Map<String, dynamic> _$$AuditEntryImplToJson(_$AuditEntryImpl instance) =>
    <String, dynamic>{
      'action': instance.action,
      'timestamp': instance.timestamp,
      'reason': instance.reason,
    };

_$CashFlowForecastImpl _$$CashFlowForecastImplFromJson(
        Map<String, dynamic> json) =>
    _$CashFlowForecastImpl(
      organizationId: json['organizationId'] as String,
      horizon: (json['horizon'] as num).toInt(),
      generatedAt: json['generatedAt'] as String,
      currentPosition: CashPosition.fromJson(
          json['currentPosition'] as Map<String, dynamic>),
      dailyForecast: (json['dailyForecast'] as List<dynamic>)
          .map((e) => DailyCashFlow.fromJson(e as Map<String, dynamic>))
          .toList(),
      summary:
          CashFlowSummary.fromJson(json['summary'] as Map<String, dynamic>),
      risks: (json['risks'] as List<dynamic>)
          .map((e) => CashFlowRisk.fromJson(e as Map<String, dynamic>))
          .toList(),
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$CashFlowForecastImplToJson(
        _$CashFlowForecastImpl instance) =>
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

_$CashPositionImpl _$$CashPositionImplFromJson(Map<String, dynamic> json) =>
    _$CashPositionImpl(
      cash: (json['cash'] as num).toDouble(),
      receivables: (json['receivables'] as num).toDouble(),
      payables: (json['payables'] as num).toDouble(),
      netPosition: (json['netPosition'] as num).toDouble(),
    );

Map<String, dynamic> _$$CashPositionImplToJson(_$CashPositionImpl instance) =>
    <String, dynamic>{
      'cash': instance.cash,
      'receivables': instance.receivables,
      'payables': instance.payables,
      'netPosition': instance.netPosition,
    };

_$DailyCashFlowImpl _$$DailyCashFlowImplFromJson(Map<String, dynamic> json) =>
    _$DailyCashFlowImpl(
      date: json['date'] as String,
      openingBalance: (json['openingBalance'] as num).toDouble(),
      inflows: (json['inflows'] as num).toDouble(),
      outflows: (json['outflows'] as num).toDouble(),
      netFlow: (json['netFlow'] as num).toDouble(),
      closingBalance: (json['closingBalance'] as num).toDouble(),
      confidence: (json['confidence'] as num).toDouble(),
    );

Map<String, dynamic> _$$DailyCashFlowImplToJson(_$DailyCashFlowImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'openingBalance': instance.openingBalance,
      'inflows': instance.inflows,
      'outflows': instance.outflows,
      'netFlow': instance.netFlow,
      'closingBalance': instance.closingBalance,
      'confidence': instance.confidence,
    };

_$CashFlowSummaryImpl _$$CashFlowSummaryImplFromJson(
        Map<String, dynamic> json) =>
    _$CashFlowSummaryImpl(
      projectedInflows: (json['projectedInflows'] as num).toDouble(),
      projectedOutflows: (json['projectedOutflows'] as num).toDouble(),
      netCashFlow: (json['netCashFlow'] as num).toDouble(),
      minimumBalance: (json['minimumBalance'] as num).toDouble(),
      maximumBalance: (json['maximumBalance'] as num).toDouble(),
    );

Map<String, dynamic> _$$CashFlowSummaryImplToJson(
        _$CashFlowSummaryImpl instance) =>
    <String, dynamic>{
      'projectedInflows': instance.projectedInflows,
      'projectedOutflows': instance.projectedOutflows,
      'netCashFlow': instance.netCashFlow,
      'minimumBalance': instance.minimumBalance,
      'maximumBalance': instance.maximumBalance,
    };

_$CashFlowRiskImpl _$$CashFlowRiskImplFromJson(Map<String, dynamic> json) =>
    _$CashFlowRiskImpl(
      risk: json['risk'] as String,
      level: json['level'] as String,
      description: json['description'] as String,
      probability: (json['probability'] as num).toDouble(),
    );

Map<String, dynamic> _$$CashFlowRiskImplToJson(_$CashFlowRiskImpl instance) =>
    <String, dynamic>{
      'risk': instance.risk,
      'level': instance.level,
      'description': instance.description,
      'probability': instance.probability,
    };

_$PaymentPredictionImpl _$$PaymentPredictionImplFromJson(
        Map<String, dynamic> json) =>
    _$PaymentPredictionImpl(
      invoiceId: json['invoiceId'] as String,
      clientId: json['clientId'] as String,
      amount: (json['amount'] as num).toDouble(),
      dueDate: json['dueDate'] as String,
      paymentProbability: (json['paymentProbability'] as num).toDouble(),
      expectedPaymentDate: json['expectedPaymentDate'] as String,
      expectedDaysLate: (json['expectedDaysLate'] as num).toInt(),
      latePaymentRisk: json['latePaymentRisk'] as String,
      badDebtProbability: (json['badDebtProbability'] as num).toDouble(),
      actions:
          (json['actions'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$PaymentPredictionImplToJson(
        _$PaymentPredictionImpl instance) =>
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

_$FinancialDashboardImpl _$$FinancialDashboardImplFromJson(
        Map<String, dynamic> json) =>
    _$FinancialDashboardImpl(
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
      costAnalysis:
          CostAnalysis.fromJson(json['costAnalysis'] as Map<String, dynamic>),
      trends: (json['trends'] as List<dynamic>)
          .map((e) => TrendData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$FinancialDashboardImplToJson(
        _$FinancialDashboardImpl instance) =>
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

_$KPIImpl _$$KPIImplFromJson(Map<String, dynamic> json) => _$KPIImpl(
      value: (json['value'] as num).toDouble(),
      change: (json['change'] as num).toDouble(),
      trend: json['trend'] as String,
    );

Map<String, dynamic> _$$KPIImplToJson(_$KPIImpl instance) => <String, dynamic>{
      'value': instance.value,
      'change': instance.change,
      'trend': instance.trend,
    };

_$RevenueByServiceImpl _$$RevenueByServiceImplFromJson(
        Map<String, dynamic> json) =>
    _$RevenueByServiceImpl(
      service: json['service'] as String,
      revenue: (json['revenue'] as num).toDouble(),
      percentage: (json['percentage'] as num).toDouble(),
    );

Map<String, dynamic> _$$RevenueByServiceImplToJson(
        _$RevenueByServiceImpl instance) =>
    <String, dynamic>{
      'service': instance.service,
      'revenue': instance.revenue,
      'percentage': instance.percentage,
    };

_$ClientProfitabilityImpl _$$ClientProfitabilityImplFromJson(
        Map<String, dynamic> json) =>
    _$ClientProfitabilityImpl(
      clientId: json['clientId'] as String,
      revenue: (json['revenue'] as num).toDouble(),
      cost: (json['cost'] as num).toDouble(),
      profit: (json['profit'] as num).toDouble(),
      margin: (json['margin'] as num).toDouble(),
    );

Map<String, dynamic> _$$ClientProfitabilityImplToJson(
        _$ClientProfitabilityImpl instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'revenue': instance.revenue,
      'cost': instance.cost,
      'profit': instance.profit,
      'margin': instance.margin,
    };

_$CostAnalysisImpl _$$CostAnalysisImplFromJson(Map<String, dynamic> json) =>
    _$CostAnalysisImpl(
      labor: CostCategory.fromJson(json['labor'] as Map<String, dynamic>),
      overhead: CostCategory.fromJson(json['overhead'] as Map<String, dynamic>),
      materials:
          CostCategory.fromJson(json['materials'] as Map<String, dynamic>),
      other: CostCategory.fromJson(json['other'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CostAnalysisImplToJson(_$CostAnalysisImpl instance) =>
    <String, dynamic>{
      'labor': instance.labor,
      'overhead': instance.overhead,
      'materials': instance.materials,
      'other': instance.other,
    };

_$CostCategoryImpl _$$CostCategoryImplFromJson(Map<String, dynamic> json) =>
    _$CostCategoryImpl(
      amount: (json['amount'] as num).toDouble(),
      percentage: (json['percentage'] as num).toDouble(),
    );

Map<String, dynamic> _$$CostCategoryImplToJson(_$CostCategoryImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'percentage': instance.percentage,
    };

_$TrendDataImpl _$$TrendDataImplFromJson(Map<String, dynamic> json) =>
    _$TrendDataImpl(
      month: json['month'] as String,
      revenue: (json['revenue'] as num).toDouble(),
      profit: (json['profit'] as num).toDouble(),
    );

Map<String, dynamic> _$$TrendDataImplToJson(_$TrendDataImpl instance) =>
    <String, dynamic>{
      'month': instance.month,
      'revenue': instance.revenue,
      'profit': instance.profit,
    };

_$BudgetImpl _$$BudgetImplFromJson(Map<String, dynamic> json) => _$BudgetImpl(
      budgetId: json['budgetId'] as String,
      organizationId: json['organizationId'] as String,
      period: json['period'] as String,
      createdAt: json['createdAt'] as String,
      revenue: BudgetCategory.fromJson(json['revenue'] as Map<String, dynamic>),
      expenses:
          BudgetCategory.fromJson(json['expenses'] as Map<String, dynamic>),
      profit: BudgetCategory.fromJson(json['profit'] as Map<String, dynamic>),
      assumptions: (json['assumptions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      scenarios:
          BudgetScenarios.fromJson(json['scenarios'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$BudgetImplToJson(_$BudgetImpl instance) =>
    <String, dynamic>{
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

_$BudgetCategoryImpl _$$BudgetCategoryImplFromJson(Map<String, dynamic> json) =>
    _$BudgetCategoryImpl(
      total: (json['total'] as num).toDouble(),
      breakdown: json['breakdown'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$BudgetCategoryImplToJson(
        _$BudgetCategoryImpl instance) =>
    <String, dynamic>{
      'total': instance.total,
      'breakdown': instance.breakdown,
    };

_$BudgetScenariosImpl _$$BudgetScenariosImplFromJson(
        Map<String, dynamic> json) =>
    _$BudgetScenariosImpl(
      best: BudgetScenario.fromJson(json['best'] as Map<String, dynamic>),
      base: BudgetScenario.fromJson(json['base'] as Map<String, dynamic>),
      worst: BudgetScenario.fromJson(json['worst'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$BudgetScenariosImplToJson(
        _$BudgetScenariosImpl instance) =>
    <String, dynamic>{
      'best': instance.best,
      'base': instance.base,
      'worst': instance.worst,
    };

_$BudgetScenarioImpl _$$BudgetScenarioImplFromJson(Map<String, dynamic> json) =>
    _$BudgetScenarioImpl(
      revenue: (json['revenue'] as num).toDouble(),
      profit: (json['profit'] as num).toDouble(),
    );

Map<String, dynamic> _$$BudgetScenarioImplToJson(
        _$BudgetScenarioImpl instance) =>
    <String, dynamic>{
      'revenue': instance.revenue,
      'profit': instance.profit,
    };

_$PaymentImpl _$$PaymentImplFromJson(Map<String, dynamic> json) =>
    _$PaymentImpl(
      paymentId: json['paymentId'] as String,
      amount: (json['amount'] as num).toDouble(),
      method: json['method'] as String,
      status: json['status'] as String,
      processedAt: json['processedAt'] as String,
      routing: PaymentRouting.fromJson(json['routing'] as Map<String, dynamic>),
      fees: PaymentFees.fromJson(json['fees'] as Map<String, dynamic>),
      estimatedCompletion: json['estimatedCompletion'] as String,
    );

Map<String, dynamic> _$$PaymentImplToJson(_$PaymentImpl instance) =>
    <String, dynamic>{
      'paymentId': instance.paymentId,
      'amount': instance.amount,
      'method': instance.method,
      'status': instance.status,
      'processedAt': instance.processedAt,
      'routing': instance.routing,
      'fees': instance.fees,
      'estimatedCompletion': instance.estimatedCompletion,
    };

_$PaymentRoutingImpl _$$PaymentRoutingImplFromJson(Map<String, dynamic> json) =>
    _$PaymentRoutingImpl(
      processor: json['processor'] as String,
      gateway: json['gateway'] as String,
      estimatedFee: (json['estimatedFee'] as num).toDouble(),
    );

Map<String, dynamic> _$$PaymentRoutingImplToJson(
        _$PaymentRoutingImpl instance) =>
    <String, dynamic>{
      'processor': instance.processor,
      'gateway': instance.gateway,
      'estimatedFee': instance.estimatedFee,
    };

_$PaymentFeesImpl _$$PaymentFeesImplFromJson(Map<String, dynamic> json) =>
    _$PaymentFeesImpl(
      processing: (json['processing'] as num).toDouble(),
      gateway: (json['gateway'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );

Map<String, dynamic> _$$PaymentFeesImplToJson(_$PaymentFeesImpl instance) =>
    <String, dynamic>{
      'processing': instance.processing,
      'gateway': instance.gateway,
      'total': instance.total,
    };

_$ComplianceCheckImpl _$$ComplianceCheckImplFromJson(
        Map<String, dynamic> json) =>
    _$ComplianceCheckImpl(
      organizationId: json['organizationId'] as String,
      checkedAt: json['checkedAt'] as String,
      ndis: ComplianceArea.fromJson(json['ndis'] as Map<String, dynamic>),
      tax: ComplianceArea.fromJson(json['tax'] as Map<String, dynamic>),
      reporting:
          ComplianceArea.fromJson(json['reporting'] as Map<String, dynamic>),
      overallStatus: json['overallStatus'] as String,
      score: (json['score'] as num).toDouble(),
      issues:
          (json['issues'] as List<dynamic>).map((e) => e as String).toList(),
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$ComplianceCheckImplToJson(
        _$ComplianceCheckImpl instance) =>
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

_$ComplianceAreaImpl _$$ComplianceAreaImplFromJson(Map<String, dynamic> json) =>
    _$ComplianceAreaImpl(
      status: json['status'] as String,
      checks: (json['checks'] as List<dynamic>)
          .map((e) => ComplianceAreaCheck.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ComplianceAreaImplToJson(
        _$ComplianceAreaImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'checks': instance.checks,
    };

_$ComplianceAreaCheckImpl _$$ComplianceAreaCheckImplFromJson(
        Map<String, dynamic> json) =>
    _$ComplianceAreaCheckImpl(
      check: json['check'] as String,
      passed: json['passed'] as bool,
    );

Map<String, dynamic> _$$ComplianceAreaCheckImplToJson(
        _$ComplianceAreaCheckImpl instance) =>
    <String, dynamic>{
      'check': instance.check,
      'passed': instance.passed,
    };

_$ClientCreditImpl _$$ClientCreditImplFromJson(Map<String, dynamic> json) =>
    _$ClientCreditImpl(
      clientId: json['clientId'] as String,
      organizationId: json['organizationId'] as String,
      analyzedAt: json['analyzedAt'] as String,
      current: CreditCurrent.fromJson(json['current'] as Map<String, dynamic>),
      recommended: CreditRecommended.fromJson(
          json['recommended'] as Map<String, dynamic>),
      riskScore: (json['riskScore'] as num).toDouble(),
      paymentHistory: PaymentHistory.fromJson(
          json['paymentHistory'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ClientCreditImplToJson(_$ClientCreditImpl instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'organizationId': instance.organizationId,
      'analyzedAt': instance.analyzedAt,
      'current': instance.current,
      'recommended': instance.recommended,
      'riskScore': instance.riskScore,
      'paymentHistory': instance.paymentHistory,
    };

_$CreditCurrentImpl _$$CreditCurrentImplFromJson(Map<String, dynamic> json) =>
    _$CreditCurrentImpl(
      limit: (json['limit'] as num).toDouble(),
      utilized: (json['utilized'] as num).toDouble(),
      available: (json['available'] as num).toDouble(),
      utilizationRate: (json['utilizationRate'] as num).toDouble(),
    );

Map<String, dynamic> _$$CreditCurrentImplToJson(_$CreditCurrentImpl instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'utilized': instance.utilized,
      'available': instance.available,
      'utilizationRate': instance.utilizationRate,
    };

_$CreditRecommendedImpl _$$CreditRecommendedImplFromJson(
        Map<String, dynamic> json) =>
    _$CreditRecommendedImpl(
      limit: (json['limit'] as num).toDouble(),
      reasoning: json['reasoning'] as String,
      confidence: (json['confidence'] as num).toDouble(),
    );

Map<String, dynamic> _$$CreditRecommendedImplToJson(
        _$CreditRecommendedImpl instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'reasoning': instance.reasoning,
      'confidence': instance.confidence,
    };

_$PaymentHistoryImpl _$$PaymentHistoryImplFromJson(Map<String, dynamic> json) =>
    _$PaymentHistoryImpl(
      onTime: (json['onTime'] as num).toInt(),
      late: (json['late'] as num).toInt(),
      averageDaysLate: (json['averageDaysLate'] as num).toInt(),
    );

Map<String, dynamic> _$$PaymentHistoryImplToJson(
        _$PaymentHistoryImpl instance) =>
    <String, dynamic>{
      'onTime': instance.onTime,
      'late': instance.late,
      'averageDaysLate': instance.averageDaysLate,
    };

_$ClientLifetimeValueImpl _$$ClientLifetimeValueImplFromJson(
        Map<String, dynamic> json) =>
    _$ClientLifetimeValueImpl(
      clientId: json['clientId'] as String,
      organizationId: json['organizationId'] as String,
      calculatedAt: json['calculatedAt'] as String,
      current: CLVCurrent.fromJson(json['current'] as Map<String, dynamic>),
      predicted:
          CLVPredicted.fromJson(json['predicted'] as Map<String, dynamic>),
      segments: json['segments'] as String,
      opportunities: (json['opportunities'] as List<dynamic>)
          .map((e) => UpsellOpportunity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ClientLifetimeValueImplToJson(
        _$ClientLifetimeValueImpl instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'organizationId': instance.organizationId,
      'calculatedAt': instance.calculatedAt,
      'current': instance.current,
      'predicted': instance.predicted,
      'segments': instance.segments,
      'opportunities': instance.opportunities,
    };

_$CLVCurrentImpl _$$CLVCurrentImplFromJson(Map<String, dynamic> json) =>
    _$CLVCurrentImpl(
      totalRevenue: (json['totalRevenue'] as num).toDouble(),
      totalProfit: (json['totalProfit'] as num).toDouble(),
      tenure: (json['tenure'] as num).toInt(),
    );

Map<String, dynamic> _$$CLVCurrentImplToJson(_$CLVCurrentImpl instance) =>
    <String, dynamic>{
      'totalRevenue': instance.totalRevenue,
      'totalProfit': instance.totalProfit,
      'tenure': instance.tenure,
    };

_$CLVPredictedImpl _$$CLVPredictedImplFromJson(Map<String, dynamic> json) =>
    _$CLVPredictedImpl(
      lifetimeValue: (json['lifetimeValue'] as num).toDouble(),
      remainingValue: (json['remainingValue'] as num).toDouble(),
      churnProbability: (json['churnProbability'] as num).toDouble(),
      expectedTenure: (json['expectedTenure'] as num).toInt(),
    );

Map<String, dynamic> _$$CLVPredictedImplToJson(_$CLVPredictedImpl instance) =>
    <String, dynamic>{
      'lifetimeValue': instance.lifetimeValue,
      'remainingValue': instance.remainingValue,
      'churnProbability': instance.churnProbability,
      'expectedTenure': instance.expectedTenure,
    };

_$UpsellOpportunityImpl _$$UpsellOpportunityImplFromJson(
        Map<String, dynamic> json) =>
    _$UpsellOpportunityImpl(
      opportunity: json['opportunity'] as String,
      potential: (json['potential'] as num).toDouble(),
    );

Map<String, dynamic> _$$UpsellOpportunityImplToJson(
        _$UpsellOpportunityImpl instance) =>
    <String, dynamic>{
      'opportunity': instance.opportunity,
      'potential': instance.potential,
    };

_$ExecutiveReportImpl _$$ExecutiveReportImplFromJson(
        Map<String, dynamic> json) =>
    _$ExecutiveReportImpl(
      organizationId: json['organizationId'] as String,
      period: json['period'] as String,
      generatedAt: json['generatedAt'] as String,
      profitAndLoss:
          ProfitAndLoss.fromJson(json['profitAndLoss'] as Map<String, dynamic>),
      balanceSheet:
          BalanceSheet.fromJson(json['balanceSheet'] as Map<String, dynamic>),
      cashFlow:
          CashFlowStatement.fromJson(json['cashFlow'] as Map<String, dynamic>),
      keyMetrics: (json['keyMetrics'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      insights:
          (json['insights'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$ExecutiveReportImplToJson(
        _$ExecutiveReportImpl instance) =>
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

_$ProfitAndLossImpl _$$ProfitAndLossImplFromJson(Map<String, dynamic> json) =>
    _$ProfitAndLossImpl(
      revenue: (json['revenue'] as num).toDouble(),
      costOfSales: (json['costOfSales'] as num).toDouble(),
      grossProfit: (json['grossProfit'] as num).toDouble(),
      operatingExpenses: (json['operatingExpenses'] as num).toDouble(),
      netProfit: (json['netProfit'] as num).toDouble(),
    );

Map<String, dynamic> _$$ProfitAndLossImplToJson(_$ProfitAndLossImpl instance) =>
    <String, dynamic>{
      'revenue': instance.revenue,
      'costOfSales': instance.costOfSales,
      'grossProfit': instance.grossProfit,
      'operatingExpenses': instance.operatingExpenses,
      'netProfit': instance.netProfit,
    };

_$BalanceSheetImpl _$$BalanceSheetImplFromJson(Map<String, dynamic> json) =>
    _$BalanceSheetImpl(
      assets:
          BalanceSheetAssets.fromJson(json['assets'] as Map<String, dynamic>),
      liabilities: BalanceSheetLiabilities.fromJson(
          json['liabilities'] as Map<String, dynamic>),
      equity: (json['equity'] as num).toDouble(),
    );

Map<String, dynamic> _$$BalanceSheetImplToJson(_$BalanceSheetImpl instance) =>
    <String, dynamic>{
      'assets': instance.assets,
      'liabilities': instance.liabilities,
      'equity': instance.equity,
    };

_$BalanceSheetAssetsImpl _$$BalanceSheetAssetsImplFromJson(
        Map<String, dynamic> json) =>
    _$BalanceSheetAssetsImpl(
      current: (json['current'] as num).toDouble(),
      fixed: (json['fixed'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );

Map<String, dynamic> _$$BalanceSheetAssetsImplToJson(
        _$BalanceSheetAssetsImpl instance) =>
    <String, dynamic>{
      'current': instance.current,
      'fixed': instance.fixed,
      'total': instance.total,
    };

_$BalanceSheetLiabilitiesImpl _$$BalanceSheetLiabilitiesImplFromJson(
        Map<String, dynamic> json) =>
    _$BalanceSheetLiabilitiesImpl(
      current: (json['current'] as num).toDouble(),
      longTerm: (json['longTerm'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );

Map<String, dynamic> _$$BalanceSheetLiabilitiesImplToJson(
        _$BalanceSheetLiabilitiesImpl instance) =>
    <String, dynamic>{
      'current': instance.current,
      'longTerm': instance.longTerm,
      'total': instance.total,
    };

_$CashFlowStatementImpl _$$CashFlowStatementImplFromJson(
        Map<String, dynamic> json) =>
    _$CashFlowStatementImpl(
      operating: (json['operating'] as num).toDouble(),
      investing: (json['investing'] as num).toDouble(),
      financing: (json['financing'] as num).toDouble(),
      netChange: (json['netChange'] as num).toDouble(),
    );

Map<String, dynamic> _$$CashFlowStatementImplToJson(
        _$CashFlowStatementImpl instance) =>
    <String, dynamic>{
      'operating': instance.operating,
      'investing': instance.investing,
      'financing': instance.financing,
      'netChange': instance.netChange,
    };
