import 'package:flutter/material.dart';
import '../models/analytics_models.dart';
import '../theme/bauhaus_theme.dart';
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
          Text('RELIABILITY METRICS', style: BauhausTheme.headerStyle),
          const SizedBox(height: 16),
          if (metrics.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('No Reliability Data'),
            )
          else
            Table(
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1),
              },
              border: TableBorder(
                horizontalInside:
                    BorderSide(color: BauhausTheme.black, width: 1),
                bottom: BorderSide(color: BauhausTheme.black, width: 2),
              ),
              children: [
                TableRow(
                  decoration: const BoxDecoration(color: BauhausTheme.black),
                  children: [
                    _HeaderCell('EMPLOYEE'),
                    _HeaderCell('SCHEDULED'),
                    _HeaderCell('NO-SHOW'),
                    _HeaderCell('RATE'),
                  ],
                ),
                ...sortedMetrics.take(10).map((m) => TableRow(
                      children: [
                        _DataCell(m.employeeEmail.contains('@') 
                            ? m.employeeEmail.split('@')[0] 
                            : m.employeeEmail), // Safe name extraction
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

  const _HeaderCell(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        text,
        style: BauhausTheme.labelStyle.copyWith(color: BauhausTheme.white),
      ),
    );
  }
}

class _DataCell extends StatelessWidget {
  final String text;
  final bool isAlert;

  const _DataCell(this.text, {this.isAlert = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        text,
        style: BauhausTheme.bodyStyle.copyWith(
          color: isAlert ? BauhausTheme.red : BauhausTheme.black,
          fontWeight: isAlert ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
