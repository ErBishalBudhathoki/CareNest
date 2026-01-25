import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import '../models/analytics_models.dart';
import 'bauhaus_container.dart';

class OvertimeHeatmap extends StatelessWidget {
  final List<OvertimeMetric> metrics;

  const OvertimeHeatmap({super.key, required this.metrics});

  @override
  Widget build(BuildContext context) {
    // Process metrics for temporal analysis (Day of Week)
    final Map<int, double> dayOfWeekHours = {
      1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0
    };
    
    for (var m in metrics) {
      for (var d in m.dailyBreakdown) {
        if (d.date.isNotEmpty) {
          try {
            final date = DateTime.parse(d.date);
            dayOfWeekHours[date.weekday] = (dayOfWeekHours[date.weekday] ?? 0) + d.hours;
          } catch (_) {}
        }
      }
    }

    final maxDayHours = dayOfWeekHours.values.reduce((a, b) => a > b ? a : b);
    final hasTemporalData = maxDayHours > 0;

    return BauhausContainer(
      height: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('OVERTIME HOTSPOTS',
              style:
                  BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: BauhausDesign.textDark,
                      )),
          const SizedBox(height: 16),
          
          if (!hasTemporalData && metrics.isEmpty)
             const Expanded(child: Center(child: Text('No Overtime Data')))
          else ...[
            // 1. Temporal Analysis (Bar Chart)
            if (hasTemporalData) ...[
              Text('WEEKLY DISTRIBUTION',
                  style: BauhausDesign.getTextTheme(context)
                      .labelSmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              SizedBox(
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int i = 1; i <= 7; i++)
                      _DayBar(
                        day: _getDayName(i),
                        value: dayOfWeekHours[i] ?? 0,
                        max: maxDayHours,
                        isWeekend: i >= 6,
                      ),
                  ],
                ),
              ),
              const Divider(height: 24, thickness: 1),
            ],

            // 2. Employee List (Top Contributors)
            Text('TOP CONTRIBUTORS',
                style: BauhausDesign.getTextTheme(context)
                    .labelSmall
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: metrics.length,
                itemBuilder: (context, index) {
                  final metric = metrics[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: _getColor(metric.totalHours),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              _getInitials(metric.employeeName),
                              style: TextStyle(
                                color: metric.totalHours > 40 ? Colors.white : BauhausDesign.textDark,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(metric.employeeName,
                                  style: BauhausDesign.getTextTheme(context)
                                      .bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.bold)),
                              Text('${metric.totalHours.toStringAsFixed(1)} hrs total',
                                  style: BauhausDesign.getTextTheme(context)
                                      .labelSmall),
                            ],
                          ),
                        ),
                        if (metric.overtimeHours > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: BauhausDesign.error.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: BauhausDesign.error),
                            ),
                            child: Text('+${metric.overtimeHours.toStringAsFixed(1)}h OT',
                                style: TextStyle(
                                  color: BauhausDesign.error,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                )),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _getDayName(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }

  Color _getColor(double hours) {
    if (hours > 40) return BauhausDesign.error;
    if (hours >= 35) return BauhausDesign.warning;
    return BauhausDesign.surfaceWhite;
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

class _DayBar extends StatelessWidget {
  final String day;
  final double value;
  final double max;
  final bool isWeekend;

  const _DayBar({
    required this.day,
    required this.value,
    required this.max,
    required this.isWeekend,
  });

  @override
  Widget build(BuildContext context) {
    final heightFactor = max > 0 ? (value / max) : 0.0;
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (value > 0)
          Text(value.toStringAsFixed(0),
              style: const TextStyle(fontSize: 10, color: BauhausDesign.textMuted)),
        const SizedBox(height: 4),
        Container(
          width: 20,
          height: 60 * heightFactor,
          decoration: BoxDecoration(
            color: isWeekend ? BauhausDesign.secondary : BauhausDesign.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 4),
        Text(day,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: isWeekend ? BauhausDesign.secondary : BauhausDesign.textDark,
            )),
      ],
    );
  }
}
