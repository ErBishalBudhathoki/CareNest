import 'package:carenest/app/features/analytics/models/analytics_models.dart';
import 'package:carenest/app/features/analytics/viewmodels/predictive_insights_viewmodel.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/shared/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class PredictiveInsightsView extends ConsumerWidget {
  const PredictiveInsightsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                .fetchRevenueForecast(),
          ),
        ],
      ),
      body: state.isLoading
          ? const BauhausLoadingState(message: 'Generating forecast...')
          : state.error != null
          ? BauhausErrorState(
              description: state.error!,
              onRetry: () => ref
                  .read(predictiveInsightsViewModelProvider.notifier)
                  .fetchRevenueForecast(),
            )
          : _buildContent(context, state.revenueForecast),
    );
  }

  Widget _buildContent(BuildContext context, List<ForecastMetric> data) {
    if (data.isEmpty) {
      return const Center(child: Text('No forecast data available'));
    }

    final firstMetric = data.first;
    final lastMetric = data.last;
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
          BauhausCard(
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(BauhausDesign.space3),
                  decoration: BoxDecoration(
                    color: trendColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                  ),
                  child: Icon(trendIcon, color: trendColor, size: 32),
                ),
                const SizedBox(width: BauhausDesign.space4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Revenue Trend',
                      style: BauhausDesign.getTextTheme(context).titleMedium,
                    ),
                    Text(
                      isUp ? 'Growing' : 'Declining',
                      style: BauhausDesign.getTextTheme(context).headlineSmall
                          ?.copyWith(
                            color: trendColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const Spacer(),
                if (growthRate != 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: BauhausDesign.space3,
                      vertical: BauhausDesign.space1,
                    ),
                    decoration: BoxDecoration(
                      color: trendColor,
                      borderRadius: BorderRadius.circular(
                        BauhausDesign.radiusFull,
                      ),
                    ),
                    child: Text(
                      '${(growthRate * 100).abs().toStringAsFixed(1)}%',
                      style: BauhausDesign.getTextTheme(context).labelMedium
                          ?.copyWith(color: BauhausDesign.surfaceWhite),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: BauhausDesign.space6),
          Text(
            'Forecast',
            style: BauhausDesign.getTextTheme(context).titleLarge,
          ),
          const SizedBox(height: BauhausDesign.space3),
          ...data.map((item) {
            final date = DateTime.tryParse(item.date);
            final dateStr = date != null
                ? DateFormat('MMM yyyy').format(date)
                : item.date;

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
                          style: BauhausDesign.getTextTheme(
                            context,
                          ).titleMedium,
                        ),
                        Text(
                          '\$${item.predictedRevenue.toStringAsFixed(2)}',
                          style: BauhausDesign.getTextTheme(context).titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
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
                          style: BauhausDesign.getTextTheme(context).bodySmall,
                        ),
                        Text(
                          '${(item.confidence * 100).toStringAsFixed(0)}%',
                          style: BauhausDesign.getTextTheme(context).bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: BauhausDesign.space4),
          Text(
            'Note: Forecast based on historical data analysis.',
            style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
              color: BauhausDesign.textMuted,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
