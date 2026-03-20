import 'package:carenest/app/features/analytics/models/analytics_models.dart';
import 'package:carenest/app/features/analytics/viewmodels/predictive_insights_viewmodel.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/shared/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class EnhancedPredictiveInsightsView extends ConsumerStatefulWidget {
  const EnhancedPredictiveInsightsView({super.key});

  @override
  ConsumerState<EnhancedPredictiveInsightsView> createState() =>
      _EnhancedPredictiveInsightsViewState();
}

class _EnhancedPredictiveInsightsViewState
    extends ConsumerState<EnhancedPredictiveInsightsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(predictiveInsightsViewModelProvider);

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBarWidget(
        title: 'Predictive Insights',
        showBackButton: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: BauhausDesign.primary),
            onPressed: () => ref
                .read(predictiveInsightsViewModelProvider.notifier)
                .fetchAllPredictions(),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: BauhausDesign.surfaceWhite,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelPadding: const EdgeInsets.symmetric(
                horizontal: BauhausDesign.space3,
              ),
              labelColor: BauhausDesign.primary,
              unselectedLabelColor: BauhausDesign.textMuted,
              indicatorColor: BauhausDesign.primary,
              indicatorWeight: 3,
              labelStyle: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
              tabs: const [
                Tab(text: 'REVENUE'),
                Tab(text: 'CHURN'),
                Tab(text: 'DEMAND'),
                Tab(text: 'COMPLIANCE'),
              ],
            ),
          ),
          Expanded(
            child: state.isLoading
                ? const BauhausLoadingState(
                    message: 'Generating predictions...')
                : state.error != null
                    ? BauhausErrorState(
                        description: state.error!,
                        onRetry: () => ref
                            .read(predictiveInsightsViewModelProvider.notifier)
                            .fetchAllPredictions(),
                      )
                    : TabBarView(
                        controller: _tabController,
                        children: [
                          _buildRevenueForecastTab(state),
                          _buildChurnPredictionTab(state),
                          _buildDemandForecastTab(state),
                          _buildComplianceRiskTab(state),
                        ],
                      ),
          ),
        ],
      ),
    );
  }

  // Revenue Forecast Tab
  Widget _buildRevenueForecastTab(PredictiveInsightsState state) {
    if (state.revenueForecast.isEmpty) {
      return const Center(child: Text('No revenue forecast available'));
    }

    final firstMetric = state.revenueForecast.first;
    final lastMetric = state.revenueForecast.last;
    final isUp = lastMetric.predictedRevenue > firstMetric.predictedRevenue;
    final trendColor = isUp ? BauhausDesign.success : BauhausDesign.warning;
    final trendIcon = isUp ? Icons.trending_up : Icons.trending_down;
    final growthRate = firstMetric.predictedRevenue > 0
        ? (lastMetric.predictedRevenue - firstMetric.predictedRevenue) /
            firstMetric.predictedRevenue
        : 0.0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Trend Summary Card
          BauhausCard(
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(BauhausDesign.space3),
                  decoration: BoxDecoration(
                    color: trendColor.withOpacity(0.1),
                    border: Border.all(color: trendColor, width: 2),
                  ),
                  child: Icon(trendIcon, color: trendColor, size: 32),
                ),
                const SizedBox(width: BauhausDesign.space4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Revenue Trend',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: BauhausDesign.textDark,
                        ),
                      ),
                      Text(
                        isUp ? 'Growing' : 'Declining',
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: trendColor,
                        ),
                      ),
                    ],
                  ),
                ),
                if (growthRate != 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: BauhausDesign.space3,
                      vertical: BauhausDesign.space2,
                    ),
                    decoration: BoxDecoration(
                      color: trendColor,
                      border:
                          Border.all(color: BauhausDesign.neutral, width: 2),
                    ),
                    child: Text(
                      '${(growthRate * 100).abs().toStringAsFixed(1)}%',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: BauhausDesign.surfaceWhite,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: BauhausDesign.space6),
          Text(
            'FORECAST',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: BauhausDesign.textDark,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          ...state.revenueForecast.map((item) {
            final date = DateTime.tryParse(item.date);
            final dateStr =
                date != null ? DateFormat('MMM yyyy').format(date) : item.date;

            return Padding(
              padding: const EdgeInsets.only(bottom: BauhausDesign.space3),
              child: BauhausCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          dateStr,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: BauhausDesign.textDark,
                          ),
                        ),
                        Text(
                          '\$${item.predictedRevenue.toStringAsFixed(2)}',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: BauhausDesign.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: BauhausDesign.space2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Confidence',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: BauhausDesign.textMuted,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: BauhausDesign.space2,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _getConfidenceColor(item.confidence)
                                .withOpacity(0.1),
                            border: Border.all(
                              color: _getConfidenceColor(item.confidence),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            '${(item.confidence * 100).toStringAsFixed(0)}%',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: _getConfidenceColor(item.confidence),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // Worker Churn Prediction Tab
  Widget _buildChurnPredictionTab(PredictiveInsightsState state) {
    if (state.churnPredictions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 64, color: BauhausDesign.success),
            const SizedBox(height: BauhausDesign.space4),
            Text(
              'No High-Risk Workers',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: BauhausDesign.textDark,
              ),
            ),
            const SizedBox(height: BauhausDesign.space2),
            Text(
              'All workers have low churn risk',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: BauhausDesign.textMuted,
              ),
            ),
          ],
        ),
      );
    }

    // Sort by churn score (highest first)
    final sortedPredictions = List<ChurnPrediction>.from(state.churnPredictions)
      ..sort((a, b) => b.churnScore.compareTo(a.churnScore));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Card
          BauhausCard(
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(BauhausDesign.space3),
                  decoration: BoxDecoration(
                    color: BauhausDesign.warning.withOpacity(0.1),
                    border: Border.all(color: BauhausDesign.warning, width: 2),
                  ),
                  child: const Icon(Icons.warning_amber,
                      color: BauhausDesign.warning, size: 32),
                ),
                const SizedBox(width: BauhausDesign.space4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'At-Risk Workers',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: BauhausDesign.textDark,
                        ),
                      ),
                      Text(
                        '${sortedPredictions.where((p) => p.riskLevel == 'high').length} High Risk',
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: BauhausDesign.warning,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: BauhausDesign.space6),
          Text(
            'WORKER CHURN PREDICTIONS',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: BauhausDesign.textDark,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          ...sortedPredictions.map((prediction) {
            final riskColor = _getRiskColor(prediction.riskLevel);

            return Padding(
              padding: const EdgeInsets.only(bottom: BauhausDesign.space3),
              child: BauhausCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: riskColor.withOpacity(0.1),
                            border: Border.all(color: riskColor, width: 2),
                          ),
                          child: Center(
                            child: Text(
                              prediction.workerName
                                  .substring(0, 1)
                                  .toUpperCase(),
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: riskColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: BauhausDesign.space3),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                prediction.workerName,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: BauhausDesign.textDark,
                                ),
                              ),
                              Text(
                                prediction.workerEmail,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: BauhausDesign.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: BauhausDesign.space3,
                            vertical: BauhausDesign.space2,
                          ),
                          decoration: BoxDecoration(
                            color: riskColor,
                            border: Border.all(
                                color: BauhausDesign.neutral, width: 2),
                          ),
                          child: Text(
                            '${prediction.churnScore.toStringAsFixed(0)}%',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: BauhausDesign.surfaceWhite,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (prediction.factors.isNotEmpty) ...[
                      const SizedBox(height: BauhausDesign.space3),
                      Container(
                        padding: const EdgeInsets.all(BauhausDesign.space2),
                        decoration: BoxDecoration(
                          color: BauhausDesign.surfaceOffWhite,
                          border: Border.all(
                              color: BauhausDesign.neutral, width: 1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Risk Factors:',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: BauhausDesign.textDark,
                              ),
                            ),
                            const SizedBox(height: BauhausDesign.space1),
                            ...prediction.factors
                                .take(3)
                                .map((factor) => Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 4,
                                            height: 4,
                                            decoration: BoxDecoration(
                                              color: riskColor,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              factor.description,
                                              style: GoogleFonts.inter(
                                                fontSize: 11,
                                                color: BauhausDesign.textDark,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                          ],
                        ),
                      ),
                    ],
                    if (prediction.recommendations.isNotEmpty) ...[
                      const SizedBox(height: BauhausDesign.space2),
                      Container(
                        padding: const EdgeInsets.all(BauhausDesign.space2),
                        decoration: BoxDecoration(
                          color: BauhausDesign.info.withOpacity(0.1),
                          border:
                              Border.all(color: BauhausDesign.info, width: 1),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.lightbulb_outline,
                                size: 16, color: BauhausDesign.info),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                prediction.recommendations.first,
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  color: BauhausDesign.textDark,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // Demand Forecast Tab
  Widget _buildDemandForecastTab(PredictiveInsightsState state) {
    if (state.demandForecast.isEmpty) {
      return const Center(child: Text('No demand forecast available'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DEMAND FORECAST',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: BauhausDesign.textDark,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          ...state.demandForecast.map((forecast) {
            final dateStr = DateFormat('EEE, MMM d').format(forecast.date);

            return Padding(
              padding: const EdgeInsets.only(bottom: BauhausDesign.space3),
              child: BauhausCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final badge = Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: BauhausDesign.space3,
                            vertical: BauhausDesign.space2,
                          ),
                          decoration: BoxDecoration(
                            color: BauhausDesign.primary,
                            border: Border.all(
                              color: BauhausDesign.neutral,
                              width: 2,
                            ),
                          ),
                          child: Text(
                            '${forecast.predictedAppointments.toStringAsFixed(0)} appointments',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: BauhausDesign.surfaceWhite,
                            ),
                          ),
                        );

                        if (constraints.maxWidth < 460) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dateStr,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: BauhausDesign.textDark,
                                ),
                              ),
                              const SizedBox(height: BauhausDesign.space2),
                              badge,
                            ],
                          );
                        }

                        return Row(
                          children: [
                            Expanded(
                              child: Text(
                                dateStr,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: BauhausDesign.textDark,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: BauhausDesign.space2),
                            badge,
                          ],
                        );
                      },
                    ),
                    if (forecast.peakHours.isNotEmpty) ...[
                      const SizedBox(height: BauhausDesign.space2),
                      Text(
                        'Peak Hours: ${forecast.peakHours.map((h) => '$h:00').join(', ')}',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: BauhausDesign.textMuted,
                        ),
                      ),
                    ],
                    if (forecast.capacityRecommendation.isNotEmpty) ...[
                      const SizedBox(height: BauhausDesign.space2),
                      Container(
                        padding: const EdgeInsets.all(BauhausDesign.space2),
                        decoration: BoxDecoration(
                          color: BauhausDesign.info.withOpacity(0.1),
                          border:
                              Border.all(color: BauhausDesign.info, width: 1),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.info_outline,
                                size: 16, color: BauhausDesign.info),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                forecast.capacityRecommendation,
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  color: BauhausDesign.textDark,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // Compliance Risk Tab
  Widget _buildComplianceRiskTab(PredictiveInsightsState state) {
    final risk = state.complianceRisk;

    if (risk == null) {
      return const Center(child: Text('No compliance data available'));
    }

    final riskColor = _getRiskColor(risk.riskLevel);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Overall Score Card
          BauhausCard(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(BauhausDesign.space3),
                      decoration: BoxDecoration(
                        color: riskColor.withOpacity(0.1),
                        border: Border.all(color: riskColor, width: 2),
                      ),
                      child: Icon(
                        risk.riskLevel == 'low'
                            ? Icons.check_circle
                            : Icons.warning_amber,
                        color: riskColor,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: BauhausDesign.space4),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Compliance Score',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: BauhausDesign.textDark,
                            ),
                          ),
                          Text(
                            '${risk.overallScore.toStringAsFixed(0)}%',
                            style: GoogleFonts.inter(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: riskColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: BauhausDesign.space3,
                        vertical: BauhausDesign.space2,
                      ),
                      decoration: BoxDecoration(
                        color: riskColor,
                        border:
                            Border.all(color: BauhausDesign.neutral, width: 2),
                      ),
                      child: Text(
                        risk.riskLevel.toUpperCase(),
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: BauhausDesign.surfaceWhite,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: BauhausDesign.space3),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final stats = [
                      _buildComplianceStat(
                          'Issues', risk.issues.length.toString()),
                      _buildComplianceStat(
                        'At-Risk Workers',
                        risk.workerRisks.length.toString(),
                      ),
                      _buildComplianceStat(
                        'Next Audit',
                        DateFormat('MMM d').format(risk.nextAudit),
                      ),
                    ];

                    if (constraints.maxWidth < 560) {
                      return Wrap(
                        spacing: BauhausDesign.space4,
                        runSpacing: BauhausDesign.space3,
                        alignment: WrapAlignment.center,
                        children: stats
                            .map((stat) => SizedBox(width: 108, child: stat))
                            .toList(),
                      );
                    }

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: stats,
                    );
                  },
                ),
              ],
            ),
          ),
          if (risk.issues.isNotEmpty) ...[
            const SizedBox(height: BauhausDesign.space6),
            Text(
              'COMPLIANCE ISSUES',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: BauhausDesign.textDark,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: BauhausDesign.space3),
            ...risk.issues.map((issue) {
              final severityColor = _getSeverityColor(issue.severity);

              return Padding(
                padding: const EdgeInsets.only(bottom: BauhausDesign.space3),
                child: BauhausCard(
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: severityColor.withOpacity(0.1),
                          border: Border.all(color: severityColor, width: 2),
                        ),
                        child: Center(
                          child: Text(
                            issue.count.toString(),
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: severityColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: BauhausDesign.space3),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              issue.description,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: BauhausDesign.textDark,
                              ),
                            ),
                            Text(
                              issue.type.toUpperCase(),
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: BauhausDesign.textMuted,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: BauhausDesign.space2,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: severityColor,
                          border: Border.all(
                              color: BauhausDesign.neutral, width: 1),
                        ),
                        child: Text(
                          issue.severity.toUpperCase(),
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: BauhausDesign.surfaceWhite,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ],
      ),
    );
  }

  Widget _buildComplianceStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: BauhausDesign.primary,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 11,
            color: BauhausDesign.textMuted,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Color _getConfidenceColor(double confidence) {
    if (confidence >= 0.8) return BauhausDesign.success;
    if (confidence >= 0.6) return BauhausDesign.info;
    return BauhausDesign.warning;
  }

  Color _getRiskColor(String riskLevel) {
    switch (riskLevel.toLowerCase()) {
      case 'high':
        return BauhausDesign.error;
      case 'medium':
        return BauhausDesign.warning;
      default:
        return BauhausDesign.success;
    }
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'critical':
        return BauhausDesign.error;
      case 'high':
        return BauhausDesign.warning;
      case 'medium':
        return BauhausDesign.info;
      default:
        return BauhausDesign.success;
    }
  }
}
