import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/features/analytics/models/analytics_models.dart';
import 'package:carenest/app/features/analytics/widgets/bauhaus_container.dart';
import 'package:carenest/app/features/analytics/widgets/bauhaus_empty_state.dart';

class UtilizationGauge extends StatelessWidget {
  final List<UtilizationMetric> metrics;

  const UtilizationGauge({super.key, required this.metrics});

  @override
  Widget build(BuildContext context) {
    if (metrics.isEmpty) {
      return const BauhausEmptyState(message: 'No Utilization Data');
    }

    // Calculate Average
    final avgUtilization =
        metrics.fold<double>(0, (sum, item) => sum + item.utilizationRate) /
        metrics.length;

    // Identify status
    final isOverutilized = avgUtilization > 90;
    final isUnderutilized = avgUtilization < 60;
    final statusColor = isOverutilized
        ? BauhausDesign.error
        : (isUnderutilized ? BauhausDesign.secondary : BauhausDesign.success);
    final statusText = isOverutilized
        ? 'OVERLOADED'
        : (isUnderutilized ? 'UNDERUTILIZED' : 'HEALTHY');

    return BauhausContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'RESOURCE UTILIZATION',
                style: BauhausDesign.getTextTheme(context).headlineSmall
                    ?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: BauhausDesign.textDark,
                    ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  statusText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Main Gauge / Indicator
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${avgUtilization.toStringAsFixed(1)}%',
                style: BauhausDesign.getTextTheme(context).displayMedium
                    ?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: BauhausDesign.textDark,
                      fontSize: 48,
                    ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'AVG. RATE',
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).labelSmall?.copyWith(color: BauhausDesign.textMuted),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: (avgUtilization / 100).clamp(0.0, 1.0),
            backgroundColor: BauhausDesign.neutral.withOpacity(0.1),
            color: statusColor,
            minHeight: 12,
            borderRadius: BorderRadius.circular(6),
          ),

          const SizedBox(height: 24),
          Text(
            'TEAM BREAKDOWN',
            style: BauhausDesign.getTextTheme(
              context,
            ).labelSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          Expanded(
            child: ListView.builder(
              itemCount: metrics.take(5).length, // Show top 5
              itemBuilder: (context, index) {
                final m = metrics[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          m.employeeName,
                          style: BauhausDesign.getTextTheme(
                            context,
                          ).bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Stack(
                          children: [
                            Container(
                              height: 8,
                              decoration: BoxDecoration(
                                color: BauhausDesign.neutral.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            FractionallySizedBox(
                              widthFactor: (m.utilizationRate / 100).clamp(
                                0.0,
                                1.0,
                              ),
                              child: Container(
                                height: 8,
                                decoration: BoxDecoration(
                                  color: m.utilizationRate > 90
                                      ? BauhausDesign.error
                                      : (m.utilizationRate < 50
                                            ? BauhausDesign.secondary
                                            : BauhausDesign.success),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 50,
                        child: Text(
                          '${m.utilizationRate.toStringAsFixed(0)}%',
                          textAlign: TextAlign.right,
                          style: BauhausDesign.getTextTheme(
                            context,
                          ).labelSmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
