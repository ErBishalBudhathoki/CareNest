import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/features/workforce_optimization/viewmodels/business_intelligence_viewmodel.dart';
import 'package:carenest/app/core/providers/organization_provider.dart';

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

    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: AppBar(
        backgroundColor: AppColors.colorPrimary,
        elevation: 0,
        title: const Text(
          'Business Intelligence',
          style: TextStyle(
            color: AppColors.colorWhite,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.colorWhite),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: AppColors.colorWhite),
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
            style: const TextStyle(fontSize: 14, color: Color(0xFF666666)),
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
          colors: [AppColors.colorPink, AppColors.colorPink.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.colorPink.withValues(alpha: 0.3),
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
              color: AppColors.colorWhite.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.business_center_outlined,
              color: AppColors.colorWhite,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Executive Insights',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.colorWhite,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Strategic business intelligence',
                  style: TextStyle(fontSize: 14, color: AppColors.colorWhite),
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
        color: AppColors.colorWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2), width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.colorShadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
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
                style: const TextStyle(fontSize: 12, color: Color(0xFF666666)),
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
                  borderRadius: BorderRadius.circular(4),
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
              color: AppColors.colorWhite,
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
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF1A1A1A), width: 1)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.colorGreen.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
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
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.colorFontPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Predicted: \$${((forecast.predicted ?? 0) / 1000).toStringAsFixed(1)}K',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ),
          Text(
            '\$${((forecast.predicted ?? 0) / 1000).toStringAsFixed(1)}K',
            style: const TextStyle(
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
              color: AppColors.colorWhite,
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
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF1A1A1A), width: 1)),
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
                  prediction.clientId ?? 'Unknown',
                  style: const TextStyle(
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

  Widget _buildEmptyState(String message) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.colorWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF1A1A1A)),
      ),
      child: Center(
        child: Column(
          children: [
            const Icon(
              Icons.inbox_outlined,
              size: 48,
              color: Color(0xFF666666),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: const TextStyle(fontSize: 14, color: Color(0xFF666666)),
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
            onPressed: () {
              // TODO: Implement scenario planning
            },
            icon: const Icon(Icons.analytics),
            label: const Text('What-If'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.colorPrimary,
              foregroundColor: AppColors.colorWhite,
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
            onPressed: () {
              // TODO: Implement export
            },
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
}
