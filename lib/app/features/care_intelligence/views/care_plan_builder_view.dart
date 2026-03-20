import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/features/care_intelligence/viewmodels/care_plan_viewmodel.dart';
import 'package:carenest/app/core/providers/app_providers.dart';

class CarePlanBuilderView extends ConsumerStatefulWidget {
  const CarePlanBuilderView({super.key});

  @override
  ConsumerState<CarePlanBuilderView> createState() =>
      _CarePlanBuilderViewState();
}

class _CarePlanBuilderViewState extends ConsumerState<CarePlanBuilderView> {
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
      ref.read(carePlanViewModelProvider.notifier).generateCarePlan(
            clientId: clientId,
            organizationId: orgId,
          );
      ref.read(carePlanViewModelProvider.notifier).generateSmartGoals(
            clientId: clientId,
            organizationId: orgId,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(carePlanViewModelProvider);

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.secondary,
        foregroundColor: BauhausDesign.surfaceWhite,
        title: Text(
          'CARE PLAN BUILDER',
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
                      BauhausSectionHeader(title: 'INTELLIGENT CARE PLAN'),
                      const SizedBox(height: 16),
                      _buildCarePlanInfo(state),
                      const SizedBox(height: 32),
                      BauhausSectionHeader(title: 'SMART GOALS'),
                      const SizedBox(height: 16),
                      if (state.goals.isEmpty)
                        const BauhausEmptyState(
                          title: 'No Goals Generated',
                          message:
                              'Tap generate to create AI-powered SMART goals.',
                          icon: Icons.track_changes,
                        )
                      else
                        ...state.goals.map((goal) => _buildGoalCard(goal)),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: BauhausActionButton(
                          onPressed: () {
                            // Logic to save or further adapt the plan
                          },
                          text: 'SAVE CARE PLAN',
                          variant: BauhausActionVariant.primary,
                          isFullWidth: true,
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildCarePlanInfo(CarePlanState state) {
    return BauhausCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Generated on: ${DateTime.now().toLocal().toString().split(' ')[0]}',
              style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                    color: BauhausDesign.textDark.withOpacity(0.5),
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              'AI-OPTIMIZED STRATEGY',
              style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
            ),
            const SizedBox(height: 8),
            const Text(
              'This care plan has been customized based on recent assessments, risk factors, and desired outcomes.',
              style: TextStyle(color: BauhausDesign.textDark),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalCard(dynamic goal) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: BauhausCard(
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: const Icon(Icons.check_circle_outline,
              color: BauhausDesign.primary),
          title: Text(
            goal.title ?? 'Goal',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(goal.description ?? 'Goal description...'),
          trailing:
              const Icon(Icons.chevron_right, color: BauhausDesign.neutral),
        ),
      ),
    );
  }
}
