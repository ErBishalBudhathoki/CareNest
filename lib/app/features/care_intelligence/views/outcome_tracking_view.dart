import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/features/care_intelligence/viewmodels/intelligence_viewmodel.dart';
import 'package:carenest/app/core/providers/app_providers.dart';

class OutcomeTrackingView extends ConsumerStatefulWidget {
  const OutcomeTrackingView({super.key});

  @override
  ConsumerState<OutcomeTrackingView> createState() =>
      _OutcomeTrackingViewState();
}

class _OutcomeTrackingViewState extends ConsumerState<OutcomeTrackingView> {
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
      ref
          .read(intelligenceViewModelProvider.notifier)
          .predictCareNeeds(clientId: clientId, organizationId: orgId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(intelligenceViewModelProvider);

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.secondary,
        foregroundColor: BauhausDesign.surfaceWhite,
        title: Text(
          'OUTCOME INSIGHTS',
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
                  BauhausSectionHeader(title: 'OUTCOME PROGRESS'),
                  const SizedBox(height: 16),
                  _buildOutcomeSummaryCard(state),
                  const SizedBox(height: 32),
                  BauhausSectionHeader(title: 'KEY MILESTONES'),
                  const SizedBox(height: 16),
                  _buildMilestoneCard(
                    title: 'MOBILITY IMPROVEMENT',
                    progress: 0.75,
                    status: 'On Track',
                    color: BauhausDesign.success,
                  ),
                  const SizedBox(height: 16),
                  _buildMilestoneCard(
                    title: 'SOCIAL ENGAGEMENT',
                    progress: 0.40,
                    status: 'Action Needed',
                    color: BauhausDesign.warning,
                  ),
                  const SizedBox(height: 16),
                  _buildMilestoneCard(
                    title: 'INDEPENDENT LIVING',
                    progress: 0.90,
                    status: 'Exceeding',
                    color: BauhausDesign.primary,
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildOutcomeSummaryCard(IntelligenceState state) {
    return BauhausCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.auto_graph_outlined,
                  color: BauhausDesign.secondary,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  'OVERALL PROGRESS: 68%',
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).titleMedium?.copyWith(fontWeight: FontWeight.w900),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'User is showing consistent improvement in physical mobility but may require more social intervention to meet quarterly goals.',
              style: TextStyle(color: BauhausDesign.textDark),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMilestoneCard({
    required String title,
    required double progress,
    required String status,
    required Color color,
  }) {
    return BauhausCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  status.toUpperCase(),
                  style: TextStyle(
                    color: color,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: BauhausDesign.neutral.withValues(alpha: 0.1),
                color: color,
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${(progress * 100).toInt()}% completed',
              style: TextStyle(
                fontSize: 10,
                color: BauhausDesign.textDark.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
