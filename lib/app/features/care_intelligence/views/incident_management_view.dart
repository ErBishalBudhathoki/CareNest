import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/features/care_intelligence/viewmodels/incident_management_viewmodel.dart';
import 'package:carenest/app/core/providers/app_providers.dart';

class IncidentManagementView extends ConsumerStatefulWidget {
  const IncidentManagementView({super.key});

  @override
  ConsumerState<IncidentManagementView> createState() =>
      _IncidentManagementViewState();
}

class _IncidentManagementViewState
    extends ConsumerState<IncidentManagementView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  void _loadData() {
    final orgId = ref.read(organizationIdProvider);
    if (orgId != null) {
      ref
          .read(incidentManagementViewModelProvider.notifier)
          .detectIncidentPatterns(
            organizationId: orgId,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(incidentManagementViewModelProvider);

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.secondary,
        foregroundColor: BauhausDesign.surfaceWhite,
        title: Text(
          'INCIDENT MANAGEMENT',
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
                      BauhausSectionHeader(title: 'INCIDENT TRENDS & PATTERNS'),
                      const SizedBox(height: 16),
                      _buildPatternsCard(state),
                      const SizedBox(height: 32),
                      BauhausSectionHeader(title: 'RECENT INCIDENTS'),
                      const SizedBox(height: 16),
                      if (state.incident == null && !state.isLoading)
                        const BauhausEmptyState(
                          title: 'No Recent Incidents',
                          message:
                              'All clear. No incidents reported in the last 30 days.',
                          icon: Icons.verified_user_outlined,
                        )
                      else if (state.incident != null)
                        _buildIncidentCard(state.incident!),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: BauhausActionButton(
                          onPressed: () {
                            // Logic to report new incident
                          },
                          text: 'REPORT NEW INCIDENT',
                          variant: BauhausActionVariant.warning,
                          isFullWidth: true,
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildPatternsCard(IncidentManagementState state) {
    return BauhausCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.analytics_outlined,
                    color: BauhausDesign.secondary, size: 28),
                const SizedBox(width: 12),
                Text(
                  'SMART INSIGHTS',
                  style:
                      BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Incident frequency has decreased by 15% compared to last month. Most incidents occur during evening shifts.',
              style: TextStyle(color: BauhausDesign.textDark),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIncidentCard(dynamic incident) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: BauhausCard(
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: const Icon(Icons.warning_amber_rounded,
              color: BauhausDesign.error),
          title: Text(
            incident.category,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(incident.reportedAt),
          trailing:
              const Icon(Icons.chevron_right, color: BauhausDesign.neutral),
        ),
      ),
    );
  }
}
