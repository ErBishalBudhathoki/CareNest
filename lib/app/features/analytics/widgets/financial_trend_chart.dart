import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import '../models/analytics_models.dart';
import 'bauhaus_container.dart';

class FinancialTrendChart extends StatelessWidget {
  final List<FinancialMetric> metrics;

  const FinancialTrendChart({super.key, required this.metrics});

  @override
  Widget build(BuildContext context) {
    return BauhausContainer(
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FINANCIAL TREND',
            style: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
              color: BauhausDesign.textDark,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: metrics.isEmpty
                ? const Center(child: Text('No Data'))
                : BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: _getMaxY(),
                      barTouchData: BarTouchData(
                        enabled: true,
                        touchTooltipData: BarTouchTooltipData(
                          getTooltipColor: (_) => BauhausDesign.neutral,
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            return BarTooltipItem(
                              '${rod.toY.toInt()}',
                              TextStyle(color: BauhausDesign.surfaceWhite),
                            );
                          },
                        ),
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              if (value.toInt() >= 0 &&
                                  value.toInt() < metrics.length) {
                                try {
                                  final date = DateTime.parse(
                                    metrics[value.toInt()].date,
                                  );
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      '${date.day}/${date.month}',
                                      style: BauhausDesign.getTextTheme(context)
                                          .labelSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  );
                                } catch (_) {
                                  return const Text('');
                                }
                              }
                              return const Text('');
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toInt().toString(),
                                style: BauhausDesign.getTextTheme(
                                  context,
                                ).labelSmall?.copyWith(fontSize: 10),
                              );
                            },
                          ),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: true,
                        getDrawingHorizontalLine: (value) => FlLine(
                          color: BauhausDesign.neutral,
                          strokeWidth: 0.5,
                          dashArray: [5, 5],
                        ),
                        getDrawingVerticalLine: (value) => FlLine(
                          color: BauhausDesign.neutral,
                          strokeWidth: 0.5,
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(
                          color: BauhausDesign.neutral,
                          width: 2,
                        ),
                      ),
                      barGroups: metrics.asMap().entries.map((entry) {
                        final index = entry.key;
                        final metric = entry.value;
                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: metric.revenue,
                              color: BauhausDesign.primary,
                              width: 12,
                              borderRadius: BorderRadius.zero,
                            ),
                            BarChartRodData(
                              toY: metric.laborCost,
                              color: BauhausDesign.secondary,
                              width: 12,
                              borderRadius: BorderRadius.zero,
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _LegendItem(color: BauhausDesign.primary, label: 'REVENUE'),
              const SizedBox(width: 16),
              _LegendItem(color: BauhausDesign.secondary, label: 'LABOR COST'),
            ],
          ),
        ],
      ),
    );
  }

  double _getMaxY() {
    if (metrics.isEmpty) return 100;
    double max = 0;
    for (var m in metrics) {
      if (m.revenue > max) max = m.revenue;
      if (m.laborCost > max) max = m.laborCost;
    }
    return max * 1.2; // Add buffer
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 12, height: 12, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: BauhausDesign.getTextTheme(
            context,
          ).labelSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
