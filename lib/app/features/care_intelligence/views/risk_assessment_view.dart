import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/features/care_intelligence/viewmodels/risk_prediction_viewmodel.dart';
import 'package:carenest/app/core/providers/app_providers.dart';

class RiskAssessmentView extends ConsumerStatefulWidget {
  const RiskAssessmentView({super.key});

  @override
  ConsumerState<RiskAssessmentView> createState() => _RiskAssessmentViewState();
}

class _RiskAssessmentViewState extends ConsumerState<RiskAssessmentView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  void _loadData() {
    final orgId = ref.read(organizationIdProvider);
    // Note: For now, we're using a placeholder clientId if not available
    // In a real app, this would come from a client selector or route arguments
    const clientId = 'placeholder_client_id';

    if (orgId != null) {
      ref
          .read(riskPredictionViewModelProvider.notifier)
          .predictAllRisks(clientId: clientId, organizationId: orgId);
      ref
          .read(riskPredictionViewModelProvider.notifier)
          .predictFallsRisk(clientId: clientId, organizationId: orgId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(riskPredictionViewModelProvider);

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.secondary,
        foregroundColor: BauhausDesign.surfaceWhite,
        title: Text(
          'RISK ASSESSMENT',
          style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
            color: BauhausDesign.surfaceWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: state.isLoading
          ? const Center(child: BauhausLoadingState())
          : state.error != null
          ? Center(
              child: BauhausEmptyState(
                title: 'Error',
                message: state.error!,
                icon: Icons.error_outline,
                onAction: _loadData,
                actionLabel: 'RETRY',
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BauhausSectionHeader(title: 'OVERALL RISK STATUS'),
                  const SizedBox(height: 16),
                  _buildOverallRiskCard(state),
                  const SizedBox(height: 32),
                  BauhausSectionHeader(title: 'SPECIFIC RISK FACTORS'),
                  const SizedBox(height: 16),
                  if (state.fallsRisk != null)
                    _buildFallsRiskCard(state.fallsRisk!),
                  const SizedBox(height: 16),
                  _buildPlaceHolderRiskCard(
                    title: 'BEHAVIOR ESCALATION',
                    subtitle: 'No imminent escalation predicted',
                    color: BauhausDesign.success,
                    icon: Icons.psychology_alt,
                  ),
                  const SizedBox(height: 16),
                  _buildPlaceHolderRiskCard(
                    title: 'MEDICATION ADHERENCE',
                    subtitle: '95% adherence rate - Low risk',
                    color: BauhausDesign.secondary,
                    icon: Icons.medication,
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildOverallRiskCard(RiskPredictionState state) {
    final score = state.assessment?.overallRisk ?? 35;
    final level = state.assessment?.fallsRisk.level ?? 'Low';

    Color riskColor = BauhausDesign.success;
    if (level.toUpperCase() == 'HIGH') {
      riskColor = BauhausDesign.error;
    } else if (level.toUpperCase() == 'MEDIUM') {
      riskColor = BauhausDesign.warning;
    }

    return BauhausCard(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: riskColor.withOpacity(0.1),
                border: Border.all(color: riskColor, width: 3),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$score',
                  style: BauhausDesign.getTextTheme(context).headlineMedium
                      ?.copyWith(color: riskColor, fontWeight: FontWeight.w900),
                ),
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${level.toUpperCase()} RISK LEVEL',
                    style: BauhausDesign.getTextTheme(context).titleSmall
                        ?.copyWith(
                          color: riskColor,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Based on recent incident patterns and health indicators.',
                    style: BauhausDesign.getTextTheme(context).bodySmall
                        ?.copyWith(
                          color: BauhausDesign.textDark.withOpacity(0.7),
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallsRiskCard(dynamic fallsRisk) {
    return BauhausCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  color: BauhausDesign.warning,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'FALLS RISK',
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).titleMedium?.copyWith(fontWeight: FontWeight.w900),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'High risk detected due to recent medication changes and mobility patterns.',
              style: TextStyle(color: BauhausDesign.textDark),
            ),
            const SizedBox(height: 16),
            BauhausActionButton(
              onPressed: () {},
              text: 'VIEW MITIGATION PLAN',
              variant: BauhausActionVariant.warning,
              isSmall: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceHolderRiskCard({
    required String title,
    required String subtitle,
    required Color color,
    required IconData icon,
  }) {
    return BauhausCard(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            border: Border.all(color: color, width: 2),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: BauhausDesign.getTextTheme(
            context,
          ).titleSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          style: BauhausDesign.getTextTheme(context).bodySmall,
        ),
        trailing: const Icon(Icons.chevron_right, color: BauhausDesign.neutral),
      ),
    );
  }
}
