import 'package:flutter/material.dart';
import '../models/analytics_models.dart';
import '../theme/bauhaus_theme.dart';
import 'bauhaus_container.dart';

class OvertimeHeatmap extends StatelessWidget {
  final List<OvertimeMetric> metrics;

  const OvertimeHeatmap({super.key, required this.metrics});

  @override
  Widget build(BuildContext context) {
    return BauhausContainer(
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('OVERTIME HOTSPOTS', style: BauhausTheme.headerStyle),
          const SizedBox(height: 16),
          Expanded(
            child: metrics.isEmpty
                ? const Center(child: Text('No Overtime Data'))
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5, // 5 columns
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                    ),
                    itemCount: metrics.length,
                    itemBuilder: (context, index) {
                      final metric = metrics[index];
                      return Tooltip(
                        message:
                            '${metric.employeeName}\n${metric.totalHours} hrs',
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: BauhausTheme.black,
                          borderRadius: BorderRadius.zero,
                        ),
                        textStyle: const TextStyle(color: BauhausTheme.white),
                        child: Container(
                          decoration: BoxDecoration(
                            color: _getColor(metric.totalHours),
                            border:
                                Border.all(color: BauhausTheme.black, width: 1),
                          ),
                          child: Center(
                            child: Text(
                              _getInitials(metric.employeeName),
                              style: BauhausTheme.labelStyle.copyWith(
                                color: metric.totalHours > 40
                                    ? BauhausTheme.white
                                    : BauhausTheme.black,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _LegendItem(color: BauhausTheme.white, label: '< 35h'),
              _LegendItem(color: BauhausTheme.yellow, label: '35-40h'),
              _LegendItem(color: BauhausTheme.red, label: '> 40h'),
            ],
          ),
        ],
      ),
    );
  }

  Color _getColor(double hours) {
    if (hours > 40) {
      return BauhausTheme.red;
    }
    if (hours >= 35) {
      return BauhausTheme.yellow;
    }
    return BauhausTheme.white;
  }

  String _getInitials(String name) {
    if (name.isEmpty) return '';
    final parts = name.split(' ');
    if (parts.length > 1) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name[0].toUpperCase();
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
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: BauhausTheme.black, width: 1),
          ),
        ),
        const SizedBox(width: 4),
        Text(label, style: BauhausTheme.labelStyle.copyWith(fontSize: 10)),
      ],
    );
  }
}
