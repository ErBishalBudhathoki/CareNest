import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:carenest/app/shared/theme/bauhaus_colors.dart';
import '../models/dashboard_models.dart';

class RevenueChartWidget extends StatelessWidget {
  final RevenueComparison? revenueData;
  final bool isLoading;

  const RevenueChartWidget({
    super.key,
    this.revenueData,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildLoadingState();
    }

    if (revenueData == null) {
      return _buildEmptyState();
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: BauhausColors.accentGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.trending_up,
                    color: BauhausColors.accentGreen,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Revenue Trends',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: BauhausColors.textDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildComparisonCards(),
            const SizedBox(height: 16),
            const Text(
              'Last 7 Days',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: BauhausColors.textDark,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(height: 200, child: _buildChart()),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonCards() {
    return Row(
      children: [
        Expanded(
          child: _buildComparisonCard(
            label: 'Today vs Yesterday',
            value: revenueData!.todayVsYesterdayPercent,
            trend: revenueData!.todayTrend,
            amount: revenueData!.todayRevenue,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildComparisonCard(
            label: 'Week to Date',
            value: revenueData!.weekVsLastWeekPercent,
            trend: revenueData!.weekTrend,
            amount: revenueData!.weekToDateRevenue,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildComparisonCard(
            label: 'Month to Date',
            value: revenueData!.monthVsLastMonthPercent,
            trend: revenueData!.monthTrend,
            amount: revenueData!.monthToDateRevenue,
          ),
        ),
      ],
    );
  }

  Widget _buildComparisonCard({
    required String label,
    required double value,
    required TrendDirection trend,
    required double amount,
  }) {
    final color = _getTrendColor(trend);
    final icon = _getTrendIcon(trend);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: BauhausColors.textMedium,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Text(
            '\$${amount.toStringAsFixed(0)}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: BauhausColors.textDark,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(icon, color: color, size: 14),
              const SizedBox(width: 4),
              Text(
                '${value.abs().toStringAsFixed(1)}%',
                style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChart() {
    final spots = revenueData!.last7Days
        .asMap()
        .entries
        .map((entry) => FlSpot(entry.key.toDouble(), entry.value.revenue))
        .toList();

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 1000,
          getDrawingHorizontalLine: (value) {
            return FlLine(color: Colors.grey.withOpacity(0.1), strokeWidth: 1);
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: (value, meta) {
                if (value.toInt() >= 0 &&
                    value.toInt() < revenueData!.last7Days.length) {
                  final date = revenueData!.last7Days[value.toInt()].date;
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      '${date.day}/${date.month}',
                      style: const TextStyle(
                        color: BauhausColors.textMedium,
                        fontSize: 10,
                      ),
                    ),
                  );
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1000,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(
                  '\$${(value / 1000).toStringAsFixed(0)}k',
                  style: const TextStyle(
                    color: BauhausColors.textMedium,
                    fontSize: 10,
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: (revenueData!.last7Days.length - 1).toDouble(),
        minY: 0,
        maxY: spots.map((e) => e.y).reduce((a, b) => a > b ? a : b) * 1.2,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: BauhausColors.accentGreen,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: BauhausColors.accentGreen,
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              color: BauhausColors.accentGreen.withOpacity(0.1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const Padding(
        padding: EdgeInsets.all(32),
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const Padding(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            children: [
              Icon(Icons.show_chart, size: 48, color: Colors.grey),
              SizedBox(height: 16),
              Text('No revenue data', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  Color _getTrendColor(TrendDirection trend) {
    switch (trend) {
      case TrendDirection.up:
        return BauhausColors.accentGreen;
      case TrendDirection.down:
        return BauhausColors.primaryRed;
      case TrendDirection.flat:
        return BauhausColors.textMedium;
    }
  }

  IconData _getTrendIcon(TrendDirection trend) {
    switch (trend) {
      case TrendDirection.up:
        return Icons.arrow_upward;
      case TrendDirection.down:
        return Icons.arrow_downward;
      case TrendDirection.flat:
        return Icons.remove;
    }
  }
}
