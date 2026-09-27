import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/features/workforce_optimization/viewmodels/workforce_planning_viewmodel.dart';
import 'package:carenest/app/core/providers/organization_provider.dart';
import 'package:carenest/app/features/workforce_optimization/utils/workforce_export_helper.dart';

class WorkforcePlanningView extends ConsumerStatefulWidget {
  const WorkforcePlanningView({super.key});

  @override
  ConsumerState<WorkforcePlanningView> createState() =>
      _WorkforcePlanningViewState();
}

class _WorkforcePlanningViewState extends ConsumerState<WorkforcePlanningView> {
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
      final startDate = now.toIso8601String();
      final endDate = now.add(const Duration(days: 30)).toIso8601String();

      ref
          .read(workforcePlanningViewModelProvider.notifier)
          .forecastDemand(
            organizationId: orgId,
            startDate: startDate,
            endDate: endDate,
            horizon: 30,
          );

      ref
          .read(workforcePlanningViewModelProvider.notifier)
          .predictTurnover(organizationId: orgId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(workforcePlanningViewModelProvider);

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
          'Workforce Planning',
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
                  _buildDemandForecast(state),
                  const SizedBox(height: 24),
                  _buildTurnoverPredictions(state),
                  const SizedBox(height: 24),
                  _buildSkillGaps(state),
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
          Text(
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
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _loadData,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.colorPrimary,
            ),
            child: const Text('Retry'),
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
            AppColors.colorBlue,
            AppColors.colorBlue.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.colorBlue.withValues(alpha: 0.3),
            blurRadius: 12,
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
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.people_outline,
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
                  'AI-Powered Planning',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Forecast demand and optimize staffing',
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

  Widget _buildDemandForecast(WorkforcePlanningState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Demand Forecast',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.colorFontPrimary,
              ),
            ),
            if (state.confidence != null)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.colorGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${(state.confidence!.accuracy * 100).toStringAsFixed(0)}% Confidence',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.colorGreen,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        if (state.forecast.isEmpty)
          _buildEmptyState('No forecast data available')
        else
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.colorShadow,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: state.forecast.take(7).map((forecast) {
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
              color: AppColors.colorBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.calendar_today,
              color: AppColors.colorBlue,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  forecast.date ?? 'N/A',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.colorFontPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Predicted: ${forecast.predicted ?? 0} workers',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${forecast.predicted ?? 0}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.colorBlue,
                ),
              ),
              Text(
                '±${forecast.confidence ?? 0}',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTurnoverPredictions(WorkforcePlanningState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Turnover Risk',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.colorFontPrimary,
          ),
        ),
        const SizedBox(height: 16),
        if (state.turnoverPredictions.isEmpty)
          _buildEmptyState('No turnover predictions available')
        else
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.colorShadow,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: state.turnoverPredictions.take(5).map((prediction) {
                return _buildTurnoverItem(prediction);
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildTurnoverItem(dynamic prediction) {
    final risk = prediction.riskScore ?? 0.0;
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
            decoration: BoxDecoration(
              color: riskColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.person_outline, color: riskColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  prediction.employeeId ?? 'Unknown',
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
            decoration: BoxDecoration(
              color: riskColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
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

  Widget _buildSkillGaps(WorkforcePlanningState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Skill Gaps',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.colorFontPrimary,
          ),
        ),
        const SizedBox(height: 16),
        if (state.skillGaps.isEmpty)
          _buildEmptyState('No skill gaps identified')
        else
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.colorShadow,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: state.skillGaps.take(5).map((gap) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.warning_amber,
                        color: AppColors.colorOrange,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          gap.skill,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.colorFontPrimary,
                          ),
                        ),
                      ),
                      Text(
                        'Gap: ${gap.gap}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.colorOrange,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildEmptyState(String message) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
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
            onPressed: () => _runScenarioAnalysis(),
            icon: const Icon(Icons.analytics),
            label: const Text('Run Scenario'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.colorPrimary,
              foregroundColor: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Compares two staffing scenarios (+2 and +5 staff) and shows the outcome.
  Future<void> _runScenarioAnalysis() async {
    final orgState = ref.read(organizationProvider);
    final orgId = orgState.currentOrganization?.id;
    if (orgId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Organization context is unavailable')),
      );
      return;
    }
    await ref
        .read(workforcePlanningViewModelProvider.notifier)
        .analyzeScenarios(
          organizationId: orgId,
          scenarios: const [
            {
              'name': 'Conservative (+2 staff)',
              'parameters': {'staffIncrease': 2},
            },
            {
              'name': 'Aggressive (+5 staff)',
              'parameters': {'staffIncrease': 5},
            },
          ],
        );
    if (!mounted) return;
    final scenarios = ref.read(workforcePlanningViewModelProvider).scenarios;
    if (scenarios.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Scenario analysis failed')));
      return;
    }
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Scenario Comparison'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final s in scenarios) ...[
                Text(s.name, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  'Net benefit: ${s.netBenefit.toStringAsFixed(2)} • '
                  'ROI: ${s.roi.toStringAsFixed(2)} • '
                  'Feasibility: ${s.feasibility}',
                ),
                const SizedBox(height: 8),
              ],
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
    final state = ref.read(workforcePlanningViewModelProvider);
    final rows = state.scenarios
        .map(
          (s) => [
            s.name,
            s.projectedRevenue.toString(),
            s.projectedCost.toString(),
            s.netBenefit.toString(),
            s.roi.toString(),
            s.feasibility,
          ],
        )
        .toList();
    final csv = WorkforceExportHelper.toCsv(const [
      'scenario',
      'projected_revenue',
      'projected_cost',
      'net_benefit',
      'roi',
      'feasibility',
    ], rows);
    final path = await WorkforceExportHelper.shareTextFile(
      filename:
          'workforce-scenarios-${WorkforceExportHelper.fileTimestamp()}.csv',
      content: csv,
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(path == null ? 'Export failed' : 'Scenarios exported'),
      ),
    );
  }
}
