import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/features/workforce_optimization/viewmodels/business_intelligence_viewmodel.dart';
import 'package:carenest/app/core/providers/organization_provider.dart';
import 'package:carenest/app/features/workforce_optimization/utils/workforce_export_helper.dart';

class BusinessIntelligenceView extends ConsumerStatefulWidget {
  const BusinessIntelligenceView({super.key});

  @override
  ConsumerState<BusinessIntelligenceView> createState() =>
      _BusinessIntelligenceViewState();
}

class _BusinessIntelligenceViewState
    extends ConsumerState<BusinessIntelligenceView> {
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
      ref
          .read(businessIntelligenceViewModelProvider.notifier)
          .getExecutiveDashboard(organizationId: orgId);

      ref
          .read(businessIntelligenceViewModelProvider.notifier)
          .predictChurn(organizationId: orgId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(businessIntelligenceViewModelProvider);

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
          'Business Intelligence',
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
                  _buildKPIs(state),
                  const SizedBox(height: 24),
                  _buildRevenueForecast(state),
                  const SizedBox(height: 24),
                  _buildChurnPrediction(state),
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
          const Icon(Icons.error_outline, size: 64, color: AppColors.colorRed),
          const SizedBox(height: 16),
          const Text(
            'Error loading data',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.colorFontPrimary,
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
            AppColors.colorPink,
            AppColors.colorPink.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.colorPink.withValues(alpha: 0.3),
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
              Icons.business_center_outlined,
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
                  'Executive Insights',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Strategic business intelligence',
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

  Widget _buildKPIs(BusinessIntelligenceState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Key Performance Indicators',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.colorFontPrimary,
          ),
        ),
        const SizedBox(height: 16),
        if (state.dashboard == null)
          _buildEmptyState('No KPI data available')
        else
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildKPICard(
                      'Revenue',
                      '\$${((state.dashboard?.kpis.totalRevenue ?? 0) / 1000).toStringAsFixed(1)}K',
                      '+12%',
                      true,
                      AppColors.colorGreen,
                      Icons.attach_money,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildKPICard(
                      'Clients',
                      '${state.dashboard?.clients.active ?? 0}',
                      '+8%',
                      true,
                      AppColors.colorBlue,
                      Icons.people,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildKPICard(
                      'Retention',
                      '${((state.dashboard?.clients.retention ?? 0) * 100).toStringAsFixed(0)}%',
                      '+3%',
                      true,
                      AppColors.colorPurple,
                      Icons.loyalty,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildKPICard(
                      'Efficiency',
                      '${((state.dashboard?.operations.efficiency ?? 0) * 100).toStringAsFixed(0)}%',
                      '+5%',
                      true,
                      AppColors.colorOrange,
                      Icons.trending_up,
                    ),
                  ),
                ],
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildKPICard(
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
          BoxShadow(color: AppColors.colorShadow, offset: const Offset(0, 2)),
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
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: isPositive
                      ? AppColors.colorGreen.withValues(alpha: 0.1)
                      : AppColors.colorRed.withValues(alpha: 0.1),
                ),
                child: Text(
                  change,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: isPositive
                        ? AppColors.colorGreen
                        : AppColors.colorRed,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueForecast(BusinessIntelligenceState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Revenue Forecast',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.colorFontPrimary,
          ),
        ),
        const SizedBox(height: 16),
        if (state.revenueForecast.isEmpty)
          _buildEmptyState('No forecast data available')
        else
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: AppColors.colorShadow,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: state.revenueForecast.take(5).map((forecast) {
                return _buildForecastItem(forecast);
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildForecastItem(dynamic forecast) {
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
            decoration: BoxDecoration(
              color: AppColors.colorGreen.withValues(alpha: 0.1),
            ),
            child: Icon(
              Icons.show_chart,
              color: AppColors.colorGreen,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  forecast.period ?? 'N/A',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.colorFontPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Predicted: \$${((forecast.predicted ?? 0) / 1000).toStringAsFixed(1)}K',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '\$${((forecast.predicted ?? 0) / 1000).toStringAsFixed(1)}K',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.colorGreen,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChurnPrediction(BusinessIntelligenceState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Churn Risk',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.colorFontPrimary,
          ),
        ),
        const SizedBox(height: 16),
        if (state.churnPredictions.isEmpty)
          _buildEmptyState('No churn predictions available')
        else
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: AppColors.colorShadow,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: state.churnPredictions.take(5).map((prediction) {
                return _buildChurnItem(prediction);
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildChurnItem(dynamic prediction) {
    final risk = prediction.churnProbability ?? 0.0;
    final riskColor = risk > 0.7
        ? AppColors.colorRed
        : risk > 0.4
        ? AppColors.colorOrange
        : AppColors.colorGreen;

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
            decoration: BoxDecoration(color: riskColor.withValues(alpha: 0.1)),
            child: Icon(Icons.person_outline, color: riskColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  prediction.clientId ?? 'Unknown',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.colorFontPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Risk: ${(risk * 100).toStringAsFixed(0)}%',
                  style: TextStyle(fontSize: 12, color: riskColor),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: riskColor.withValues(alpha: 0.1)),
            child: Text(
              risk > 0.7
                  ? 'High'
                  : risk > 0.4
                  ? 'Medium'
                  : 'Low',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: riskColor,
              ),
            ),
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
            onPressed: () => _runWhatIf(),
            icon: const Icon(Icons.analytics),
            label: const Text('What-If'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.colorPrimary,
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
            label: const Text('Export'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.colorPrimary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: AppColors.colorPrimary),
              shape: RoundedRectangleBorder(),
            ),
          ),
        ),
      ],
    );
  }

  /// Runs a baseline-growth what-if scenario and shows the outcome.
  Future<void> _runWhatIf() async {
    final orgState = ref.read(organizationProvider);
    final orgId = orgState.currentOrganization?.id;
    if (orgId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Organization context is unavailable')),
      );
      return;
    }
    await ref
        .read(businessIntelligenceViewModelProvider.notifier)
        .analyzeWhatIfScenario(
          organizationId: orgId,
          scenario: const {
            'name': 'Baseline growth (+10% demand, +1 worker)',
            'changes': {
              'appointmentGrowth': 0.1,
              'additionalWorkers': 1,
              'revenueGrowth': 0.1,
            },
          },
        );
    if (!mounted) return;
    final scenario = ref
        .read(businessIntelligenceViewModelProvider)
        .whatIfScenario;
    if (scenario == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Scenario analysis failed')));
      return;
    }
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(scenario.name),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Decision: ${scenario.recommendation.decision} '
                '(${scenario.recommendation.confidence} confidence)',
              ),
              const SizedBox(height: 8),
              Text(
                'Revenue change: ${scenario.impact.revenueChange.toStringAsFixed(2)} '
                '(${scenario.impact.revenueChangePercent})',
              ),
              const SizedBox(height: 8),
              Text('Feasibility: ${scenario.feasibility.rating}'),
              const SizedBox(height: 8),
              Text(scenario.recommendation.reasoning),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _exportCsv() async {
    final state = ref.read(businessIntelligenceViewModelProvider);
    final rows = state.revenueForecast
        .map(
          (f) => [
            f.period.toString(),
            f.predicted.toString(),
            f.lower.toString(),
            f.upper.toString(),
          ],
        )
        .toList();
    final csv = WorkforceExportHelper.toCsv(const [
      'period',
      'predicted',
      'lower',
      'upper',
    ], rows);
    final path = await WorkforceExportHelper.shareTextFile(
      filename: 'revenue-forecast-${WorkforceExportHelper.fileTimestamp()}.csv',
      content: csv,
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(path == null ? 'Export failed' : 'Forecast exported'),
      ),
    );
  }
}
