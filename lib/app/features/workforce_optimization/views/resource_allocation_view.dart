import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/features/workforce_optimization/viewmodels/resource_allocation_viewmodel.dart';
import 'package:carenest/app/core/providers/organization_provider.dart';

class ResourceAllocationView extends ConsumerStatefulWidget {
  const ResourceAllocationView({super.key});

  @override
  ConsumerState<ResourceAllocationView> createState() =>
      _ResourceAllocationViewState();
}

class _ResourceAllocationViewState
    extends ConsumerState<ResourceAllocationView> {
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
          .read(resourceAllocationViewModelProvider.notifier)
          .optimizeAllocation(
            organizationId: orgId,
            date: DateTime.now().toIso8601String(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(resourceAllocationViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: AppBar(
        backgroundColor: AppColors.colorPrimary,
        elevation: 0,
        title: const Text(
          'Resource Allocation',
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
                  _buildWorkloadAnalysis(state),
                  const SizedBox(height: 24),
                  _buildRecommendations(state),
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
            style: const TextStyle(
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
          colors: [
            AppColors.colorPurple,
            AppColors.colorPurple.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.colorPurple.withValues(alpha: 0.3),
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
              Icons.assignment_outlined,
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
                  'Intelligent Allocation',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.colorWhite,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Optimize worker assignments',
                  style: TextStyle(fontSize: 14, color: AppColors.colorWhite),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkloadAnalysis(ResourceAllocationState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Workload Analysis',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.colorFontPrimary,
          ),
        ),
        const SizedBox(height: 16),
        if (state.workloadAnalysis.isEmpty)
          _buildEmptyState('No workload data available')
        else
          Container(
            padding: const EdgeInsets.all(20),
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
              children: [
                _buildWorkloadMetric(
                  'Average Utilization',
                  '${((state.metrics?.utilizationRate ?? 0) * 100).toStringAsFixed(0)}%',
                  AppColors.colorBlue,
                  Icons.trending_up,
                ),
                const Divider(height: 32),
                _buildWorkloadMetric(
                  'Average Score',
                  '${((state.metrics?.averageScore ?? 0) * 100).toStringAsFixed(0)}%',
                  AppColors.colorGreen,
                  Icons.balance,
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildWorkloadMetric(
    String label,
    String value,
    Color color,
    IconData icon,
  ) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.colorFontPrimary,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendations(ResourceAllocationState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recommendations',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.colorFontPrimary,
          ),
        ),
        const SizedBox(height: 16),
        if (state.recommendations.isEmpty)
          _buildEmptyState('No recommendations available')
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
              children: state.recommendations.take(5).map((rec) {
                return _buildRecommendationItem(rec);
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildRecommendationItem(dynamic recommendation) {
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
              color: AppColors.colorPurple.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.lightbulb_outline,
              color: AppColors.colorPurple,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recommendation.workerName ?? 'Unknown',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.colorFontPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Match: ${((recommendation.score ?? 0) * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward,
            color: AppColors.colorPurple,
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
              // TODO: Implement optimization
            },
            icon: const Icon(Icons.auto_fix_high),
            label: const Text('Optimize'),
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
