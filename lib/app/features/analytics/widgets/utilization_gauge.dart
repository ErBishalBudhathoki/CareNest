import 'package:flutter/material.dart';
import '../models/analytics_models.dart';
import '../theme/bauhaus_theme.dart';
import 'bauhaus_container.dart';

class UtilizationGauge extends StatelessWidget {
  final List<UtilizationMetric> metrics;

  const UtilizationGauge({super.key, required this.metrics});

  @override
  Widget build(BuildContext context) {
    // Calculate average utilization
    double avgUtilization = 0;
    List<UtilizationMetric> sortedMetrics = [];
    
    if (metrics.isNotEmpty) {
      avgUtilization =
          metrics.map((e) => e.utilizationRate).reduce((a, b) => a + b) /
              metrics.length;
              
      // Sort by utilization descending for top performers
      sortedMetrics = List.from(metrics)
        ..sort((a, b) => b.utilizationRate.compareTo(a.utilizationRate));
    }

    return BauhausContainer(
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('UTILIZATION', style: BauhausTheme.headerStyle),
          const SizedBox(height: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${avgUtilization.toStringAsFixed(1)}%',
                  style: BauhausTheme.headerStyle.copyWith(fontSize: 48),
                ),
                Text('AVG UTILIZATION', style: BauhausTheme.labelStyle),
                const SizedBox(height: 24),
                _LinearGauge(
                  value: avgUtilization / 100,
                  label: 'Overall',
                ),
                const SizedBox(height: 16),
                // Show top 3 employees
                ...sortedMetrics.take(3).map((m) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: _LinearGauge(
                        value: m.utilizationRate / 100,
                        label: m.employeeName,
                        height: 12,
                        showLabel: true,
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LinearGauge extends StatelessWidget {
  final double value;
  final String label;
  final double height;
  final bool showLabel;

  const _LinearGauge({
    required this.value,
    required this.label,
    this.height = 24,
    this.showLabel = false,
  });

  @override
  Widget build(BuildContext context) {
    final clampedValue = value.clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel)
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label,
                    style: BauhausTheme.labelStyle.copyWith(fontSize: 10)),
                Text('${(value * 100).toInt()}%',
                    style: BauhausTheme.labelStyle.copyWith(fontSize: 10)),
              ],
            ),
          ),
        Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: BauhausTheme.white,
            border: Border.all(color: BauhausTheme.black, width: 2),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: clampedValue,
            child: Container(
              color: BauhausTheme.blue,
            ),
          ),
        ),
      ],
    );
  }
}
