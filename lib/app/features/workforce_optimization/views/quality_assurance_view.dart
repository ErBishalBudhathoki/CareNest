import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/features/workforce_optimization/viewmodels/quality_assurance_viewmodel.dart';
import 'package:carenest/app/core/providers/organization_provider.dart';

class QualityAssuranceView extends ConsumerStatefulWidget {
  const QualityAssuranceView({super.key});

  @override
  ConsumerState<QualityAssuranceView> createState() => _QualityAssuranceViewState();
}

class _QualityAssuranceViewState extends ConsumerState<QualityAssuranceView> {
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
      ref.read(qualityAssuranceViewModelProvider.notifier).scoreServiceQuality(
        organizationId: orgId,
        appointmentId: 'all',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(qualityAssuranceViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: AppBar(
        backgroundColor: AppColors.colorPrimary,
        elevation: 0,
        title: const Text(
          'Quality Assurance',
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
                      _buildQualityScore(state),
                      const SizedBox(height: 24),
                      _buildComplianceStatus(state),
                      const SizedBox(height: 24),
                      _buildRiskAssessment(state),
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
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF666666), // BauhausDesign.textMuted
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
          colors: [AppColors.colorOrange, AppColors.colorOrange.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.colorOrange.withOpacity(0.3),
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
              color: AppColors.colorWhite.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.verified_outlined,
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
                  'Quality Control',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.colorWhite,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Automated quality checks',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.colorWhite,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQualityScore(QualityAssuranceState state) {
    final score = state.qualityScore?.overallScore ?? 0.0;
    final scorePercent = (score * 100).toStringAsFixed(0);
    final scoreColor = score >= 0.8
        ? AppColors.colorGreen
        : score >= 0.6
            ? AppColors.colorOrange
            : AppColors.colorRed;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quality Score',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.colorFontPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(24),
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
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: scoreColor, width: 8),
                  color: scoreColor.withOpacity(0.1),
                ),
                child: Center(
                  child: Text(
                    scorePercent,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      color: scoreColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                score >= 0.8 ? 'Excellent' : score >= 0.6 ? 'Good' : 'Needs Improvement',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: scoreColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildComplianceStatus(QualityAssuranceState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Compliance Status',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.colorFontPrimary,
          ),
        ),
        const SizedBox(height: 16),
        if (state.complianceChecks.isEmpty)
          _buildEmptyState('No compliance data available')
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
              children: state.complianceChecks.take(5).map((result) {
                return _buildComplianceItem(result);
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildComplianceItem(dynamic result) {
    final isCompliant = result.isCompliant ?? false;
    final color = isCompliant ? AppColors.colorGreen : AppColors.colorRed;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFF1A1A1A), width: 2), // BauhausDesign.neutral
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isCompliant ? Icons.check_circle : Icons.cancel,
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
                  result.checkName ?? 'Unknown',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.colorFontPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isCompliant ? 'Compliant' : 'Non-compliant',
                  style: TextStyle(
                    fontSize: 12,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            isCompliant ? Icons.check : Icons.warning,
            color: color,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildRiskAssessment(QualityAssuranceState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Risk Assessment',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.colorFontPrimary,
          ),
        ),
        const SizedBox(height: 16),
        if (state.riskAssessments.isEmpty)
          _buildEmptyState('No risk data available')
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
                _buildRiskMetric(
                  'Overall Risk',
                  '${((state.riskAssessments.first.riskScore ?? 0) * 100).toStringAsFixed(0)}%',
                  state.riskAssessments.first.riskScore ?? 0,
                ),
                const Divider(height: 32),
                _buildRiskMetric(
                  'Risk Level',
                  state.riskAssessments.first.riskLevel ?? 'Unknown',
                  state.riskAssessments.first.riskScore ?? 0,
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildRiskMetric(String label, String value, double risk) {
    final color = risk > 0.7
        ? AppColors.colorRed
        : risk > 0.4
            ? AppColors.colorOrange
            : AppColors.colorGreen;

    return Row(
      children: [
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

  Widget _buildEmptyState(String message) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.colorWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF1A1A1A), width: 2), // BauhausDesign.neutral
      ),
      child: Center(
        child: Column(
          children: [
            const Icon(Icons.inbox_outlined, size: 48, color: Color(0xFF666666)), // BauhausDesign.textMuted
            const SizedBox(height: 12),
            Text(
              message,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF666666), // BauhausDesign.textMuted
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
            onPressed: () {
              // TODO: Implement audit
            },
            icon: const Icon(Icons.fact_check),
            label: const Text('Run Audit'),
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
