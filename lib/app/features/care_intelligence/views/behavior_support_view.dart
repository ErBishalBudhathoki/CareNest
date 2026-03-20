import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/features/care_intelligence/viewmodels/behavior_support_viewmodel.dart';
import 'package:carenest/app/core/providers/app_providers.dart';

class BehaviorSupportView extends ConsumerStatefulWidget {
  const BehaviorSupportView({super.key});

  @override
  ConsumerState<BehaviorSupportView> createState() =>
      _BehaviorSupportViewState();
}

class _BehaviorSupportViewState extends ConsumerState<BehaviorSupportView> {
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
          .read(behaviorSupportViewModelProvider.notifier)
          .analyzeBehaviorPatterns(
            clientId: clientId,
            organizationId: orgId,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(behaviorSupportViewModelProvider);

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.secondary,
        foregroundColor: BauhausDesign.surfaceWhite,
        title: Text(
          'BEHAVIOR SUPPORT',
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
                      BauhausSectionHeader(title: 'BEHAVIORAL INSIGHTS'),
                      const SizedBox(height: 16),
                      _buildInsightsCard(state),
                      const SizedBox(height: 32),
                      BauhausSectionHeader(title: 'RECENT PATTERNS'),
                      const SizedBox(height: 16),
                      if (state.behaviorAnalysis?['patterns'] != null &&
                          (state.behaviorAnalysis!['patterns'] as List)
                              .isNotEmpty)
                        _buildPatternsList(
                            state.behaviorAnalysis!['patterns'] as List)
                      else
                        const BauhausEmptyState(
                          title: 'No Patterns Detected',
                          message:
                              'No behavioral triggers or escalations identified recently.',
                          icon: Icons.psychology_outlined,
                        ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: BauhausActionButton(
                          onPressed: () {},
                          text: 'LOG NEW BEHAVIOR',
                          variant: BauhausActionVariant.primary,
                          isFullWidth: true,
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildInsightsCard(BehaviorSupportState state) {
    return BauhausCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.lightbulb_outline,
                    color: BauhausDesign.warning, size: 28),
                const SizedBox(width: 12),
                Text(
                  'AI RECOMMENDATION',
                  style:
                      BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Escalations typically occur on Tuesdays between 2 PM and 4 PM. Suggest proactive engagement during these times.',
              style: TextStyle(color: BauhausDesign.textDark),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPatternsList(dynamic patterns) {
    return Column(
      children: [
        BauhausCard(
          child: ListTile(
            leading: const Icon(Icons.warning_amber_outlined,
                color: BauhausDesign.error),
            title: const Text('Anxiety Trigger',
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text('Identified 3 times this week.'),
            trailing:
                const Icon(Icons.chevron_right, color: BauhausDesign.neutral),
          ),
        ),
      ],
    );
  }
}
