import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/features/workforce_optimization/viewmodels/performance_analytics_viewmodel.dart';
import 'package:carenest/app/core/providers/organization_provider.dart';
import 'package:carenest/app/features/workforce_optimization/utils/workforce_export_helper.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class PerformanceAnalyticsView extends ConsumerStatefulWidget {
  const PerformanceAnalyticsView({super.key});

  @override
  ConsumerState<PerformanceAnalyticsView> createState() =>
      _PerformanceAnalyticsViewState();
}

class _PerformanceAnalyticsViewState
    extends ConsumerState<PerformanceAnalyticsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  void _loadData() {
    final orgState = ref.read(organizationProvider);
    final orgId = orgState.currentOrganization?.id;
    if (orgId != null) {
      final now = DateTime.now();
      final startDate = now
          .subtract(const Duration(days: 30))
          .toIso8601String();
      final endDate = now.toIso8601String();

      ref
          .read(performanceAnalyticsViewModelProvider.notifier)
          .getPerformanceAnalytics(
            organizationId: orgId,
            employeeId: 'all',
            startDate: startDate,
            endDate: endDate,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(performanceAnalyticsViewModelProvider);

    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.secondary,
        foregroundColor: colorScheme.onSecondary,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: 0,
        title: Text(
          'Performance Analytics',
          style: TextStyle(
            color: colorScheme.onSecondary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSecondary),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: colorScheme.onSecondary),
            onPressed: _loadData,
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
          ? _buildError(state.error!)
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildPerformanceMetrics(state),
                  const SizedBox(height: 24),
                  _buildTrendAnalysis(state),
                  const SizedBox(height: 24),
                  _buildActionButtons(),
                ],
              ),
            ),
    );
  }

  Widget _buildError(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: BauhausDesign.error),
          const SizedBox(height: 16),
          Text(
            'Error loading data',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            BauhausDesign.success,
            BauhausDesign.success.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: BauhausDesign.success.withValues(alpha: 0.3),
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.surface.withValues(alpha: 0.2),
            ),
            child: Icon(
              Icons.trending_up,
              color: Theme.of(context).colorScheme.surface,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Performance Insights',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Track and predict performance',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceMetrics(PerformanceAnalyticsState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Metrics',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                'Avg Score',
                '4.6',
                '+0.3',
                true,
                BauhausDesign.success,
                Icons.star,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                'Efficiency',
                '87%',
                '+5%',
                true,
                BauhausDesign.primaryBlue,
                Icons.speed,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                'Quality',
                '92%',
                '+2%',
                true,
                BauhausDesign.secondaryDeep,
                Icons.verified,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                'On-Time',
                '95%',
                '+1%',
                true,
                BauhausDesign.warning,
                Icons.schedule,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    String label,
    String value,
    String change,
    bool isPositive,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(color: color.withValues(alpha: 0.2), width: 2),
        boxShadow: [
          BoxShadow(color: BauhausDesign.shadowColor, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isPositive
                      ? BauhausDesign.success.withValues(alpha: 0.1)
                      : BauhausDesign.error.withValues(alpha: 0.1),
                ),
                child: Text(
                  change,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isPositive
                        ? BauhausDesign.success
                        : BauhausDesign.error,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrendAnalysis(PerformanceAnalyticsState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Trend Analysis',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        if (state.analytics.isEmpty)
          _buildEmptyState('No trend data available')
        else
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: BauhausDesign.shadowColor,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: state.analytics.take(5).map((data) {
                return _buildTrendItem(data);
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildTrendItem(dynamic data) {
    final score = data.overallScore ?? 0.0;
    final isPositive = score >= 0.7;
    final color = isPositive
        ? BauhausDesign.success
        : score >= 0.5
        ? BauhausDesign.warning
        : BauhausDesign.error;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1)),
            child: Icon(
              isPositive ? Icons.trending_up : Icons.trending_down,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.employeeId ?? 'Unknown',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Score: ${(score * 100).toStringAsFixed(0)}%',
                  style: TextStyle(fontSize: 12, color: color),
                ),
              ],
            ),
          ),
          Icon(
            isPositive ? Icons.arrow_upward : Icons.arrow_downward,
            color: color,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 48,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _viewReport(),
            icon: const Icon(Icons.assessment),
            label: Text(AppLocalizations.of(context)!.viewReport),
            style: ElevatedButton.styleFrom(
              backgroundColor: BauhausDesign.neutral,
              foregroundColor: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _exportCsv(),
            icon: const Icon(Icons.download),
            label: Text(AppLocalizations.of(context)!.export),
            style: OutlinedButton.styleFrom(
              foregroundColor: BauhausDesign.neutral,
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: BauhausDesign.neutral),
              shape: RoundedRectangleBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _viewReport() async {
    final orgState = ref.read(organizationProvider);
    final orgId = orgState.currentOrganization?.id;
    if (orgId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.organizationContextUnavailable)),
      );
      return;
    }
    await ref
        .read(performanceAnalyticsViewModelProvider.notifier)
        .analyzePerformanceTrends(employeeId: 'all', organizationId: orgId);
    if (!mounted) return;
    final trends = ref.read(performanceAnalyticsViewModelProvider).trends;
    final entries = trends?.entries
        .map((e) => '${e.key}: ${e.value}')
        .join('\n');
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.performanceTrends),
        content: SingleChildScrollView(
          child: Text(
            (entries == null || entries.isEmpty)
                ? 'No trend data returned.'
                : entries,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(AppLocalizations.of(context)!.close),
          ),
        ],
      ),
    );
  }

  Future<void> _exportCsv() async {
    final state = ref.read(performanceAnalyticsViewModelProvider);
    final rows = state.analytics
        .map(
          (a) => [
            a.employeeId,
            a.employeeName,
            a.score.toString(),
            a.metrics.completionRate.toString(),
            a.metrics.avgRating.toString(),
          ],
        )
        .toList();
    final csv = WorkforceExportHelper.toCsv(const [
      'employee_id',
      'name',
      'score',
      'completion_rate',
      'avg_rating',
    ], rows);
    final path = await WorkforceExportHelper.shareTextFile(
      filename:
          'performance-analytics-${WorkforceExportHelper.fileTimestamp()}.csv',
      content: csv,
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          path == null ? 'Export failed' : 'Performance report exported',
        ),
      ),
    );
  }
}
