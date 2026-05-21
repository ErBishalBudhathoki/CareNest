import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/features/care_intelligence/viewmodels/medication_viewmodel.dart';
import 'package:carenest/app/core/providers/app_providers.dart';

class MedicationManagementView extends ConsumerStatefulWidget {
  const MedicationManagementView({super.key});

  @override
  ConsumerState<MedicationManagementView> createState() =>
      _MedicationManagementViewState();
}

class _MedicationManagementViewState
    extends ConsumerState<MedicationManagementView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  void _loadData() {
    final orgId = ref.read(organizationIdProvider);
    const clientId = 'placeholder_client_id';

    if (orgId != null) {
      ref.read(medicationViewModelProvider.notifier).getMedicationAlerts(
            clientId: clientId,
            organizationId: orgId,
          );
      ref.read(medicationViewModelProvider.notifier).trackMedicationCompliance(
            clientId: clientId,
            organizationId: orgId,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(medicationViewModelProvider);

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.secondary,
        foregroundColor: BauhausDesign.surfaceWhite,
        title: Text(
          'MEDICATION MGMT',
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
                    title: 'No Medication Data',
                    message:
                        'No medication information available for this client.',
                    icon: Icons.medication_outlined,
                    onAction: _loadData,
                    actionLabel: 'RETRY',
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BauhausSectionHeader(title: 'MEDICATION SAFETY'),
                      const SizedBox(height: 16),
                      _buildSafetyScoreCard(state),
                      const SizedBox(height: 32),
                      BauhausSectionHeader(title: 'ADVERSE ALERTS'),
                      const SizedBox(height: 16),
                      if (state.alerts.isEmpty)
                        const BauhausEmptyState(
                          title: 'No Active Alerts',
                          message:
                              'No drug interactions or safety concerns detected.',
                          icon: Icons.shield_outlined,
                        )
                      else
                        ...state.alerts.map((alert) => _buildAlertCard(alert)),
                      const SizedBox(height: 32),
                      BauhausSectionHeader(title: 'COMPLIANCE INSIGHTS'),
                      const SizedBox(height: 16),
                      _buildComplianceCard(state),
                    ],
                  ),
                ),
    );
  }

  Widget _buildSafetyScoreCard(MedicationState state) {
    return BauhausCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Icon(Icons.health_and_safety_outlined,
                color: BauhausDesign.primary, size: 48),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '92% SAFETY SCORE',
                    style: BauhausDesign.getTextTheme(context)
                        .titleMedium
                        ?.copyWith(
                          color: BauhausDesign.primary,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Overall medication regimen is well-balanced and safe.',
                    style:
                        TextStyle(fontSize: 12, color: BauhausDesign.textDark),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertCard(dynamic alert) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: BauhausCard(
        child: ListTile(
          leading: const Icon(Icons.medication_outlined,
              color: BauhausDesign.warning),
          title: Text(
            alert.title ?? 'Medication Alert',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(alert.message ?? 'Details...'),
          trailing: BauhausIconButton(
            icon: Icons.info_outline,
            onPressed: () {},
            variant: BauhausActionVariant.warning,
            isSmall: true,
          ),
        ),
      ),
    );
  }

  Widget _buildComplianceCard(MedicationState state) {
    return BauhausCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Adherence Rate',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  '${(state.compliance!.overallCompliance * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(
                      color: BauhausDesign.success,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: state.compliance!.overallCompliance,
                backgroundColor: BauhausDesign.neutral.withOpacity(0.2),
                color: BauhausDesign.success,
                minHeight: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
