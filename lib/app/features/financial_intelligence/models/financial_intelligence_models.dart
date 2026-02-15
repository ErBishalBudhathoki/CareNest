import 'package:freezed_annotation/freezed_annotation.dart';

part 'financial_intelligence_models.freezed.dart';
part 'financial_intelligence_models.g.dart';

// ============================================================================
// Revenue Forecasting Models
// ============================================================================

@freezed
class RevenueForecast with _$RevenueForecast {
  const factory RevenueForecast({
    required String organizationId,
    required String generatedAt,
    required int horizon,
    required String model,
    required double accuracy,
    required List<DailyPrediction> predictions,
    ConfidenceIntervals? confidenceIntervals,
    ForecastScenarios? scenarios,
    required ForecastMetrics metrics,
    required List<String> insights,
  }) = _RevenueForecast;

  factory RevenueForecast.fromJson(Map<String, dynamic> json) => _$RevenueForecastFromJson(json);
}

@freezed
class DailyPrediction with _$DailyPrediction {
  const factory DailyPrediction({
    required String date,
    required double predicted,
    required double confidence,
  }) = _DailyPrediction;

  factory DailyPrediction.fromJson(Map<String, dynamic> json) => _$DailyPredictionFromJson(json);
}

@freezed
class ConfidenceIntervals with _$ConfidenceIntervals {
  const factory ConfidenceIntervals({
    required List<ConfidenceInterval> intervals,
  }) = _ConfidenceIntervals;

  factory ConfidenceIntervals.fromJson(Map<String, dynamic> json) => _$ConfidenceIntervalsFromJson(json);
}

@freezed
class ConfidenceInterval with _$ConfidenceInterval {
  const factory ConfidenceInterval({
    required String date,
    required double lower,
    required double upper,
    required double confidence,
  }) = _ConfidenceInterval;

  factory ConfidenceInterval.fromJson(Map<String, dynamic> json) => _$ConfidenceIntervalFromJson(json);
}

@freezed
class ForecastScenarios with _$ForecastScenarios {
  const factory ForecastScenarios({
    required double bestCase,
    required double mostLikely,
    required double worstCase,
  }) = _ForecastScenarios;

  factory ForecastScenarios.fromJson(Map<String, dynamic> json) => _$ForecastScenariosFromJson(json);
}

@freezed
class ForecastMetrics with _$ForecastMetrics {
  const factory ForecastMetrics({
    required double arimaAccuracy,
    required double prophetAccuracy,
    required double lstmAccuracy,
    required double ensembleAccuracy,
    required double mae,
    required double rmse,
  }) = _ForecastMetrics;

  factory ForecastMetrics.fromJson(Map<String, dynamic> json) => _$ForecastMetricsFromJson(json);
}

@freezed
class RevenueDrivers with _$RevenueDrivers {
  const factory RevenueDrivers({
    required String organizationId,
    required int period,
    required String analyzedAt,
    required List<PrimaryDriver> primaryDrivers,
    required List<ExternalFactor> externalFactors,
    required List<String> recommendations,
  }) = _RevenueDrivers;

  factory RevenueDrivers.fromJson(Map<String, dynamic> json) => _$RevenueDriversFromJson(json);
}

@freezed
class PrimaryDriver with _$PrimaryDriver {
  const factory PrimaryDriver({
    required String driver,
    required double impact,
    required String trend,
    required double correlation,
    required double elasticity,
  }) = _PrimaryDriver;

  factory PrimaryDriver.fromJson(Map<String, dynamic> json) => _$PrimaryDriverFromJson(json);
}

@freezed
class ExternalFactor with _$ExternalFactor {
  const factory ExternalFactor({
    required String factor,
    required double impact,
    required double probability,
    required String potentialEffect,
  }) = _ExternalFactor;

  factory ExternalFactor.fromJson(Map<String, dynamic> json) => _$ExternalFactorFromJson(json);
}

// ============================================================================
// Pricing Optimization Models
// ============================================================================

@freezed
class PriceOptimization with _$PriceOptimization {
  const factory PriceOptimization({
    required String serviceId,
    required String serviceName,
    required double currentPrice,
    required double optimalPrice,
    required double priceChange,
    required double percentageChange,
    required PriceImpact impact,
    required double confidence,
    required String recommendation,
  }) = _PriceOptimization;

  factory PriceOptimization.fromJson(Map<String, dynamic> json) => _$PriceOptimizationFromJson(json);
}

@freezed
class PriceImpact with _$PriceImpact {
  const factory PriceImpact({
    required double demandChange,
    required double revenueChange,
    required double marginChange,
  }) = _PriceImpact;

  factory PriceImpact.fromJson(Map<String, dynamic> json) => _$PriceImpactFromJson(json);
}

@freezed
class ABTest with _$ABTest {
  const factory ABTest({
    required String testId,
    required String organizationId,
    required String status,
    required String createdAt,
    required Map<String, ABVariant> variants,
    required int duration,
    required int minimumSampleSize,
    required double significanceLevel,
    required List<String> successMetrics,
  }) = _ABTest;

  factory ABTest.fromJson(Map<String, dynamic> json) => _$ABTestFromJson(json);
}

@freezed
class ABVariant with _$ABVariant {
  const factory ABVariant({
    required String name,
    required double price,
    required double allocation,
    required ABMetrics metrics,
  }) = _ABVariant;

  factory ABVariant.fromJson(Map<String, dynamic> json) => _$ABVariantFromJson(json);
}

@freezed
class ABMetrics with _$ABMetrics {
  const factory ABMetrics({
    required int conversions,
    required double revenue,
    required int sampleSize,
  }) = _ABMetrics;

  factory ABMetrics.fromJson(Map<String, dynamic> json) => _$ABMetricsFromJson(json);
}

@freezed
class PricingRecommendations with _$PricingRecommendations {
  const factory PricingRecommendations({
    required String serviceId,
    required String analyzedAt,
    required CurrentPricing current,
    required List<PricingStrategy> strategies,
    required MarketInsights marketInsights,
    required String topRecommendation,
    required String reasoning,
  }) = _PricingRecommendations;

  factory PricingRecommendations.fromJson(Map<String, dynamic> json) => _$PricingRecommendationsFromJson(json);
}

@freezed
class CurrentPricing with _$CurrentPricing {
  const factory CurrentPricing({
    required double price,
    required double demand,
    required double margin,
    required String competitiveness,
  }) = _CurrentPricing;

  factory CurrentPricing.fromJson(Map<String, dynamic> json) => _$CurrentPricingFromJson(json);
}

@freezed
class PricingStrategy with _$PricingStrategy {
  const factory PricingStrategy({
    required String strategy,
    required double recommendedPrice,
    required double expectedRevenue,
    required double expectedMargin,
    required List<String> pros,
    required List<String> cons,
    required double confidence,
  }) = _PricingStrategy;

  factory PricingStrategy.fromJson(Map<String, dynamic> json) => _$PricingStrategyFromJson(json);
}

@freezed
class MarketInsights with _$MarketInsights {
  const factory MarketInsights({
    required CompetitorPricing competitorPricing,
    required double demandElasticity,
    required double priceOptimizationPotential,
  }) = _MarketInsights;

  factory MarketInsights.fromJson(Map<String, dynamic> json) => _$MarketInsightsFromJson(json);
}

@freezed
class CompetitorPricing with _$CompetitorPricing {
  const factory CompetitorPricing({
    required double average,
    required List<double> range,
    required String position,
  }) = _CompetitorPricing;

  factory CompetitorPricing.fromJson(Map<String, dynamic> json) => _$CompetitorPricingFromJson(json);
}

// ============================================================================
// Billing Automation Models
// ============================================================================

@freezed
class Invoice with _$Invoice {
  const factory Invoice({
    required String invoiceId,
    required String organizationId,
    required String clientId,
    required String period,
    required double amount,
    required double gst,
    required double total,
    required String status,
    required String createdAt,
    required List<LineItem> lineItems,
    ValidationResult? validation,
    List<BillingAnomaly>? anomalies,
    String? approvedAt,
  }) = _Invoice;

  factory Invoice.fromJson(Map<String, dynamic> json) => _$InvoiceFromJson(json);
}

@freezed
class LineItem with _$LineItem {
  const factory LineItem({
    required String description,
    required int quantity,
    required double rate,
    required double amount,
  }) = _LineItem;

  factory LineItem.fromJson(Map<String, dynamic> json) => _$LineItemFromJson(json);
}

@freezed
class ValidationResult with _$ValidationResult {
  const factory ValidationResult({
    required bool passed,
    required List<String> errors,
    required List<String> warnings,
    required List<ValidationCheck> checks,
  }) = _ValidationResult;

  factory ValidationResult.fromJson(Map<String, dynamic> json) => _$ValidationResultFromJson(json);
}

@freezed
class ValidationCheck with _$ValidationCheck {
  const factory ValidationCheck({
    required String check,
    required bool passed,
    required List<String> errors,
    required String details,
  }) = _ValidationCheck;

  factory ValidationCheck.fromJson(Map<String, dynamic> json) => _$ValidationCheckFromJson(json);
}

@freezed
class BillingAnomaly with _$BillingAnomaly {
  const factory BillingAnomaly({
    required String type,
    required String severity,
    required String description,
    Map<String, dynamic>? details,
  }) = _BillingAnomaly;

  factory BillingAnomaly.fromJson(Map<String, dynamic> json) => _$BillingAnomalyFromJson(json);
}

@freezed
class CreditNote with _$CreditNote {
  const factory CreditNote({
    required String creditNoteId,
    required String invoiceId,
    required double amount,
    required String reason,
    required String status,
    required String createdAt,
    required double gst,
    required double totalCredit,
    required CreditNoteWorkflow workflow,
    required List<AuditEntry> auditTrail,
    String? approvedAt,
  }) = _CreditNote;

  factory CreditNote.fromJson(Map<String, dynamic> json) => _$CreditNoteFromJson(json);
}

@freezed
class CreditNoteWorkflow with _$CreditNoteWorkflow {
  const factory CreditNoteWorkflow({
    required bool requiresApproval,
    required String approvalLevel,
    required bool autoApprove,
  }) = _CreditNoteWorkflow;

  factory CreditNoteWorkflow.fromJson(Map<String, dynamic> json) => _$CreditNoteWorkflowFromJson(json);
}

@freezed
class AuditEntry with _$AuditEntry {
  const factory AuditEntry({
    required String action,
    required String timestamp,
    required String reason,
  }) = _AuditEntry;

  factory AuditEntry.fromJson(Map<String, dynamic> json) => _$AuditEntryFromJson(json);
}

// ============================================================================
// Cash Flow Models
// ============================================================================

@freezed
class CashFlowForecast with _$CashFlowForecast {
  const factory CashFlowForecast({
    required String organizationId,
    required int horizon,
    required String generatedAt,
    required CashPosition currentPosition,
    required List<DailyCashFlow> dailyForecast,
    required CashFlowSummary summary,
    required List<CashFlowRisk> risks,
    required List<String> recommendations,
  }) = _CashFlowForecast;

  factory CashFlowForecast.fromJson(Map<String, dynamic> json) => _$CashFlowForecastFromJson(json);
}

@freezed
class CashPosition with _$CashPosition {
  const factory CashPosition({
    required double cash,
    required double receivables,
    required double payables,
    required double netPosition,
  }) = _CashPosition;

  factory CashPosition.fromJson(Map<String, dynamic> json) => _$CashPositionFromJson(json);
}

@freezed
class DailyCashFlow with _$DailyCashFlow {
  const factory DailyCashFlow({
    required String date,
    required double openingBalance,
    required double inflows,
    required double outflows,
    required double netFlow,
    required double closingBalance,
    required double confidence,
  }) = _DailyCashFlow;

  factory DailyCashFlow.fromJson(Map<String, dynamic> json) => _$DailyCashFlowFromJson(json);
}

@freezed
class CashFlowSummary with _$CashFlowSummary {
  const factory CashFlowSummary({
    required double projectedInflows,
    required double projectedOutflows,
    required double netCashFlow,
    required double minimumBalance,
    required double maximumBalance,
  }) = _CashFlowSummary;

  factory CashFlowSummary.fromJson(Map<String, dynamic> json) => _$CashFlowSummaryFromJson(json);
}

@freezed
class CashFlowRisk with _$CashFlowRisk {
  const factory CashFlowRisk({
    required String risk,
    required String level,
    required String description,
    required double probability,
  }) = _CashFlowRisk;

  factory CashFlowRisk.fromJson(Map<String, dynamic> json) => _$CashFlowRiskFromJson(json);
}

@freezed
class PaymentPrediction with _$PaymentPrediction {
  const factory PaymentPrediction({
    required String invoiceId,
    required String clientId,
    required double amount,
    required String dueDate,
    required double paymentProbability,
    required String expectedPaymentDate,
    required int expectedDaysLate,
    required String latePaymentRisk,
    required double badDebtProbability,
    required List<String> actions,
  }) = _PaymentPrediction;

  factory PaymentPrediction.fromJson(Map<String, dynamic> json) => _$PaymentPredictionFromJson(json);
}

// ============================================================================
// Financial Analytics Models
// ============================================================================

@freezed
class FinancialDashboard with _$FinancialDashboard {
  const factory FinancialDashboard({
    required String organizationId,
    required String period,
    required String generatedAt,
    required Map<String, KPI> kpis,
    required List<RevenueByService> revenueByService,
    required List<ClientProfitability> profitabilityByClient,
    required CostAnalysis costAnalysis,
    required List<TrendData> trends,
  }) = _FinancialDashboard;

  factory FinancialDashboard.fromJson(Map<String, dynamic> json) => _$FinancialDashboardFromJson(json);
}

@freezed
class KPI with _$KPI {
  const factory KPI({
    required double value,
    required double change,
    required String trend,
  }) = _KPI;

  factory KPI.fromJson(Map<String, dynamic> json) => _$KPIFromJson(json);
}

@freezed
class RevenueByService with _$RevenueByService {
  const factory RevenueByService({
    required String service,
    required double revenue,
    required double percentage,
  }) = _RevenueByService;

  factory RevenueByService.fromJson(Map<String, dynamic> json) => _$RevenueByServiceFromJson(json);
}

@freezed
class ClientProfitability with _$ClientProfitability {
  const factory ClientProfitability({
    required String clientId,
    required double revenue,
    required double cost,
    required double profit,
    required double margin,
  }) = _ClientProfitability;

  factory ClientProfitability.fromJson(Map<String, dynamic> json) => _$ClientProfitabilityFromJson(json);
}

@freezed
class CostAnalysis with _$CostAnalysis {
  const factory CostAnalysis({
    required CostCategory labor,
    required CostCategory overhead,
    required CostCategory materials,
    required CostCategory other,
  }) = _CostAnalysis;

  factory CostAnalysis.fromJson(Map<String, dynamic> json) => _$CostAnalysisFromJson(json);
}

@freezed
class CostCategory with _$CostCategory {
  const factory CostCategory({
    required double amount,
    required double percentage,
  }) = _CostCategory;

  factory CostCategory.fromJson(Map<String, dynamic> json) => _$CostCategoryFromJson(json);
}

@freezed
class TrendData with _$TrendData {
  const factory TrendData({
    required String month,
    required double revenue,
    required double profit,
  }) = _TrendData;

  factory TrendData.fromJson(Map<String, dynamic> json) => _$TrendDataFromJson(json);
}

// ============================================================================
// Budget Management Models
// ============================================================================

@freezed
class Budget with _$Budget {
  const factory Budget({
    required String budgetId,
    required String organizationId,
    required String period,
    required String createdAt,
    required BudgetCategory revenue,
    required BudgetCategory expenses,
    required BudgetCategory profit,
    required List<String> assumptions,
    required BudgetScenarios scenarios,
  }) = _Budget;

  factory Budget.fromJson(Map<String, dynamic> json) => _$BudgetFromJson(json);
}

@freezed
class BudgetCategory with _$BudgetCategory {
  const factory BudgetCategory({
    required double total,
    Map<String, dynamic>? breakdown,
  }) = _BudgetCategory;

  factory BudgetCategory.fromJson(Map<String, dynamic> json) => _$BudgetCategoryFromJson(json);
}

@freezed
class BudgetScenarios with _$BudgetScenarios {
  const factory BudgetScenarios({
    required BudgetScenario best,
    required BudgetScenario base,
    required BudgetScenario worst,
  }) = _BudgetScenarios;

  factory BudgetScenarios.fromJson(Map<String, dynamic> json) => _$BudgetScenariosFromJson(json);
}

@freezed
class BudgetScenario with _$BudgetScenario {
  const factory BudgetScenario({
    required double revenue,
    required double profit,
  }) = _BudgetScenario;

  factory BudgetScenario.fromJson(Map<String, dynamic> json) => _$BudgetScenarioFromJson(json);
}

// ============================================================================
// Payment Processing Models
// ============================================================================

@freezed
class Payment with _$Payment {
  const factory Payment({
    required String paymentId,
    required double amount,
    required String method,
    required String status,
    required String processedAt,
    required PaymentRouting routing,
    required PaymentFees fees,
    required String estimatedCompletion,
  }) = _Payment;

  factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);
}

@freezed
class PaymentRouting with _$PaymentRouting {
  const factory PaymentRouting({
    required String processor,
    required String gateway,
    required double estimatedFee,
  }) = _PaymentRouting;

  factory PaymentRouting.fromJson(Map<String, dynamic> json) => _$PaymentRoutingFromJson(json);
}

@freezed
class PaymentFees with _$PaymentFees {
  const factory PaymentFees({
    required double processing,
    required double gateway,
    required double total,
  }) = _PaymentFees;

  factory PaymentFees.fromJson(Map<String, dynamic> json) => _$PaymentFeesFromJson(json);
}

// ============================================================================
// Compliance Models
// ============================================================================

@freezed
class ComplianceCheck with _$ComplianceCheck {
  const factory ComplianceCheck({
    required String organizationId,
    required String checkedAt,
    required ComplianceArea ndis,
    required ComplianceArea tax,
    required ComplianceArea reporting,
    required String overallStatus,
    required double score,
    required List<String> issues,
    required List<String> recommendations,
  }) = _ComplianceCheck;

  factory ComplianceCheck.fromJson(Map<String, dynamic> json) => _$ComplianceCheckFromJson(json);
}

@freezed
class ComplianceArea with _$ComplianceArea {
  const factory ComplianceArea({
    required String status,
    required List<ComplianceAreaCheck> checks,
  }) = _ComplianceArea;

  factory ComplianceArea.fromJson(Map<String, dynamic> json) => _$ComplianceAreaFromJson(json);
}

@freezed
class ComplianceAreaCheck with _$ComplianceAreaCheck {
  const factory ComplianceAreaCheck({
    required String check,
    required bool passed,
  }) = _ComplianceAreaCheck;

  factory ComplianceAreaCheck.fromJson(Map<String, dynamic> json) => _$ComplianceAreaCheckFromJson(json);
}

// ============================================================================
// Client Financial Models
// ============================================================================

@freezed
class ClientCredit with _$ClientCredit {
  const factory ClientCredit({
    required String clientId,
    required String organizationId,
    required String analyzedAt,
    required CreditCurrent current,
    required CreditRecommended recommended,
    required double riskScore,
    required PaymentHistory paymentHistory,
  }) = _ClientCredit;

  factory ClientCredit.fromJson(Map<String, dynamic> json) => _$ClientCreditFromJson(json);
}

@freezed
class CreditCurrent with _$CreditCurrent {
  const factory CreditCurrent({
    required double limit,
    required double utilized,
    required double available,
    required double utilizationRate,
  }) = _CreditCurrent;

  factory CreditCurrent.fromJson(Map<String, dynamic> json) => _$CreditCurrentFromJson(json);
}

@freezed
class CreditRecommended with _$CreditRecommended {
  const factory CreditRecommended({
    required double limit,
    required String reasoning,
    required double confidence,
  }) = _CreditRecommended;

  factory CreditRecommended.fromJson(Map<String, dynamic> json) => _$CreditRecommendedFromJson(json);
}

@freezed
class PaymentHistory with _$PaymentHistory {
  const factory PaymentHistory({
    required int onTime,
    required int late,
    required int averageDaysLate,
  }) = _PaymentHistory;

  factory PaymentHistory.fromJson(Map<String, dynamic> json) => _$PaymentHistoryFromJson(json);
}

@freezed
class ClientLifetimeValue with _$ClientLifetimeValue {
  const factory ClientLifetimeValue({
    required String clientId,
    required String organizationId,
    required String calculatedAt,
    required CLVCurrent current,
    required CLVPredicted predicted,
    required String segments,
    required List<UpsellOpportunity> opportunities,
  }) = _ClientLifetimeValue;

  factory ClientLifetimeValue.fromJson(Map<String, dynamic> json) => _$ClientLifetimeValueFromJson(json);
}

@freezed
class CLVCurrent with _$CLVCurrent {
  const factory CLVCurrent({
    required double totalRevenue,
    required double totalProfit,
    required int tenure,
  }) = _CLVCurrent;

  factory CLVCurrent.fromJson(Map<String, dynamic> json) => _$CLVCurrentFromJson(json);
}

@freezed
class CLVPredicted with _$CLVPredicted {
  const factory CLVPredicted({
    required double lifetimeValue,
    required double remainingValue,
    required double churnProbability,
    required int expectedTenure,
  }) = _CLVPredicted;

  factory CLVPredicted.fromJson(Map<String, dynamic> json) => _$CLVPredictedFromJson(json);
}

@freezed
class UpsellOpportunity with _$UpsellOpportunity {
  const factory UpsellOpportunity({
    required String opportunity,
    required double potential,
  }) = _UpsellOpportunity;

  factory UpsellOpportunity.fromJson(Map<String, dynamic> json) => _$UpsellOpportunityFromJson(json);
}

// ============================================================================
// Financial Reporting Models
// ============================================================================

@freezed
class ExecutiveReport with _$ExecutiveReport {
  const factory ExecutiveReport({
    required String organizationId,
    required String period,
    required String generatedAt,
    required ProfitAndLoss profitAndLoss,
    required BalanceSheet balanceSheet,
    required CashFlowStatement cashFlow,
    required Map<String, double> keyMetrics,
    required List<String> insights,
  }) = _ExecutiveReport;

  factory ExecutiveReport.fromJson(Map<String, dynamic> json) => _$ExecutiveReportFromJson(json);
}

@freezed
class ProfitAndLoss with _$ProfitAndLoss {
  const factory ProfitAndLoss({
    required double revenue,
    required double costOfSales,
    required double grossProfit,
    required double operatingExpenses,
    required double netProfit,
  }) = _ProfitAndLoss;

  factory ProfitAndLoss.fromJson(Map<String, dynamic> json) => _$ProfitAndLossFromJson(json);
}

@freezed
class BalanceSheet with _$BalanceSheet {
  const factory BalanceSheet({
    required BalanceSheetAssets assets,
    required BalanceSheetLiabilities liabilities,
    required double equity,
  }) = _BalanceSheet;

  factory BalanceSheet.fromJson(Map<String, dynamic> json) => _$BalanceSheetFromJson(json);
}

@freezed
class BalanceSheetAssets with _$BalanceSheetAssets {
  const factory BalanceSheetAssets({
    required double current,
    required double fixed,
    required double total,
  }) = _BalanceSheetAssets;

  factory BalanceSheetAssets.fromJson(Map<String, dynamic> json) => _$BalanceSheetAssetsFromJson(json);
}

@freezed
class BalanceSheetLiabilities with _$BalanceSheetLiabilities {
  const factory BalanceSheetLiabilities({
    required double current,
    required double longTerm,
    required double total,
  }) = _BalanceSheetLiabilities;

  factory BalanceSheetLiabilities.fromJson(Map<String, dynamic> json) => _$BalanceSheetLiabilitiesFromJson(json);
}

@freezed
class CashFlowStatement with _$CashFlowStatement {
  const factory CashFlowStatement({
    required double operating,
    required double investing,
    required double financing,
    required double netChange,
  }) = _CashFlowStatement;

  factory CashFlowStatement.fromJson(Map<String, dynamic> json) => _$CashFlowStatementFromJson(json);
}
