import 'package:carenest/app/features/analytics/models/analytics_models.dart';
import 'package:carenest/app/features/analytics/viewmodels/cross_org_viewmodel.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/shared/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CrossOrgDashboardView extends ConsumerWidget {
  const CrossOrgDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(crossOrgViewModelProvider);

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBarWidget(
        title: 'Cross-Org Analytics',
        showBackButton: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: BauhausDesign.primary),
            onPressed: () =>
                ref.read(crossOrgViewModelProvider.notifier).fetchMetrics(),
          ),
        ],
      ),
      body: state.when(
        data: (data) => _buildContent(context, data),
        loading: () =>
            const BauhausLoadingState(message: 'Aggregating data...'),
        error: (e, _) => BauhausErrorState(
          description: e.toString(),
          onRetry: () =>
              ref.read(crossOrgViewModelProvider.notifier).fetchMetrics(),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<CrossOrgMetric> data) {
    final totalRevenue = data.fold<double>(
      0,
      (sum, metric) => sum + metric.revenue,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BauhausCard(
            backgroundColor: BauhausDesign.primary,
            child: Column(
              children: [
                Text(
                  'Total Consolidated Revenue',
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).titleMedium?.copyWith(color: BauhausDesign.surfaceWhite),
                ),
                const SizedBox(height: BauhausDesign.space2),
                Text(
                  '\$${totalRevenue.toStringAsFixed(2)}',
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).displayLarge?.copyWith(color: BauhausDesign.surfaceWhite),
                ),
              ],
            ),
          ),
          const SizedBox(height: BauhausDesign.space6),
          Text(
            'Organization Breakdown',
            style: BauhausDesign.getTextTheme(context).titleLarge,
          ),
          const SizedBox(height: BauhausDesign.space3),
          if (data.isEmpty)
            const BauhausEmptyState(
              title: 'No Data',
              message: 'No revenue data found for this period.',
            ),
          ...data.map(
            (org) => Padding(
              padding: const EdgeInsets.only(bottom: BauhausDesign.space3),
              child: BauhausCard(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            org.organizationName,
                            style: BauhausDesign.getTextTheme(
                              context,
                            ).titleMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          '\$${org.revenue.toStringAsFixed(2)}',
                          style: BauhausDesign.getTextTheme(
                            context,
                          ).titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: BauhausDesign.space2),
                    LinearProgressIndicator(
                      value: totalRevenue > 0 ? org.revenue / totalRevenue : 0,
                      backgroundColor: BauhausDesign.surfaceOffWhite,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        BauhausDesign.primary,
                      ),
                    ),
                    const SizedBox(height: BauhausDesign.space1),
                    Text(
                      '${totalRevenue > 0 ? ((org.revenue / totalRevenue) * 100).toStringAsFixed(1) : "0.0"}% Contribution',
                      style: BauhausDesign.getTextTheme(context).bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
