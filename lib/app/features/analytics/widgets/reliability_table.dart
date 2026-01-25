import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import '../models/analytics_models.dart';
import 'bauhaus_container.dart';

class ReliabilityTable extends StatelessWidget {
  final List<ReliabilityMetric> metrics;

  const ReliabilityTable({super.key, required this.metrics});

  @override
  Widget build(BuildContext context) {
    // Sort by No-Show Rate Descending
    final sortedMetrics = List<ReliabilityMetric>.from(metrics)
      ..sort((a, b) => b.noShowRate.compareTo(a.noShowRate));

    return BauhausContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('RELIABILITY METRICS',
              style:
                  BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: BauhausDesign.textDark,
                      )),
          const SizedBox(height: 16),
          if (metrics.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('No Reliability Data'),
            )
          else
            Table(
              columnWidths: const {
                0: FlexColumnWidth(1.5),
                1: FlexColumnWidth(0.8),
                2: FlexColumnWidth(0.8),
                3: FlexColumnWidth(0.9),
              },
              border: TableBorder(
                horizontalInside:
                    BorderSide(color: BauhausDesign.neutral, width: 1),
                bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
              ),
              children: [
                TableRow(
                  decoration: BoxDecoration(color: BauhausDesign.neutral),
                  children: [
                    _HeaderCell('EMPLOYEE', align: TextAlign.left),
                    _HeaderCell('SCHED.'),
                    _HeaderCell('NO-SHOW'),
                    _HeaderCell('RATE'),
                  ],
                ),
                ...sortedMetrics.take(10).map((m) => TableRow(
                      children: [
                        _DataCell(
                            m.employeeEmail.contains('@')
                                ? m.employeeEmail.split('@')[0]
                                : m.employeeEmail,
                            align: TextAlign.left), // Safe name extraction
                        _DataCell(m.totalScheduled.toString()),
                        _DataCell(m.noShows.toString(), isAlert: m.noShows > 0),
                        _DataCell('${m.noShowRate.toStringAsFixed(1)}%',
                            isAlert: m.noShowRate > 5),
                      ],
                    )),
              ],
            ),
        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String text;
  final TextAlign align;

  const _HeaderCell(this.text, {this.align = TextAlign.center});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12.0),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: align,
        style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
            color: BauhausDesign.surfaceWhite, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _DataCell extends StatelessWidget {
  final String text;
  final bool isAlert;
  final TextAlign align;

  const _DataCell(this.text, {this.isAlert = false, this.align = TextAlign.center});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12.0),
      child: Text(
        text,
        maxLines: 1,
        textAlign: align,
        style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
              color: isAlert ? BauhausDesign.error : BauhausDesign.textDark,
              fontWeight: isAlert ? FontWeight.bold : FontWeight.normal,
            ),
      ),
    );
  }
}
