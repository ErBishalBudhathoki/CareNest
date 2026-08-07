import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/features/scheduling/models/shift_matching_models.dart';
import 'package:carenest/app/features/scheduling/viewmodels/shift_matching_viewmodel.dart';

class ShiftMatchingView extends ConsumerStatefulWidget {
  final String? organizationId;

  const ShiftMatchingView({super.key, this.organizationId});

  @override
  ConsumerState<ShiftMatchingView> createState() => _ShiftMatchingViewState();
}

class _ShiftMatchingViewState extends ConsumerState<ShiftMatchingView> {
  String? _selectedShiftId;
  final _criteriaController = MatchingCriteria();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(shiftMatchingViewModelProvider);

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.textDark,
        title: Text(
          'SHIFT MATCHING',
          style: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
            color: BauhausDesign.surfaceWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: BauhausDesign.surfaceWhite),
      ),
      body: state.isLoading
          ? const Center(child: BauhausLoadingState())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  BauhausCard(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: BauhausDesign.primary.withOpacity(0.1),
                                  border: Border.all(
                                    color: BauhausDesign.primary,
                                    width: 2,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.people_outline,
                                  color: BauhausDesign.primary,
                                  size: 32,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'AI-POWERED MATCHING',
                                      style: BauhausDesign.getTextTheme(context)
                                          .titleLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Find the best workers for your shifts',
                                      style: BauhausDesign.getTextTheme(context)
                                          .bodyMedium
                                          ?.copyWith(
                                            color: BauhausDesign.neutral,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Error Display
                  if (state.error != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: BauhausDesign.error.withOpacity(0.1),
                          border: Border.all(
                            color: BauhausDesign.error,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: BauhausDesign.error,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                state.error!,
                                style: BauhausDesign.getTextTheme(
                                  context,
                                ).bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // Matches Display
                  if (state.matches.isNotEmpty) ...[
                    BauhausSectionHeader(
                      title: 'WORKER MATCHES (${state.matches.length})',
                    ),
                    const SizedBox(height: 16),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.matches.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final match = state.matches[index];
                        return _buildWorkerMatchCard(match);
                      },
                    ),
                  ] else
                    BauhausEmptyState(
                      title: 'NO MATCHES YET',
                      message: 'Select a shift to find matching workers',
                      icon: Icons.search_off,
                    ),

                  const SizedBox(height: 24),

                  // Action Button
                  SizedBox(
                    width: double.infinity,
                    child: BauhausActionButton(
                      onPressed: _showShiftSelectionDialog,
                      text: 'FIND MATCHES',
                      icon: Icons.search,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildWorkerMatchCard(WorkerMatch match) {
    Color matchColor;
    switch (match.matchLevel) {
      case 'excellent':
        matchColor = BauhausDesign.success;
        break;
      case 'good':
        matchColor = BauhausDesign.secondary;
        break;
      case 'fair':
        matchColor = BauhausDesign.warning;
        break;
      default:
        matchColor = BauhausDesign.neutral;
    }

    return BauhausCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        match.workerName.toUpperCase(),
                        style: BauhausDesign.getTextTheme(
                          context,
                        ).titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        match.workerEmail,
                        style: BauhausDesign.getTextTheme(
                          context,
                        ).bodySmall?.copyWith(color: BauhausDesign.neutral),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: matchColor.withOpacity(0.1),
                    border: Border.all(color: matchColor, width: 2),
                  ),
                  child: Text(
                    '${match.matchScore.toStringAsFixed(0)}%',
                    style: BauhausDesign.getTextTheme(context).titleLarge
                        ?.copyWith(
                          color: matchColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(color: BauhausDesign.neutral, thickness: 1),
            const SizedBox(height: 12),
            ...match.factors.map(
              (factor) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        factor.factor,
                        style: BauhausDesign.getTextTheme(context).bodySmall,
                      ),
                    ),
                    Text(
                      '${factor.score.toStringAsFixed(0)}%',
                      style: BauhausDesign.getTextTheme(
                        context,
                      ).bodySmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            if (match.conflicts.isNotEmpty) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: BauhausDesign.warning.withOpacity(0.1),
                  border: Border.all(color: BauhausDesign.warning),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CONFLICTS:',
                      style: BauhausDesign.getTextTheme(context).bodySmall
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: BauhausDesign.warning,
                          ),
                    ),
                    ...match.conflicts.map(
                      (conflict) => Text(
                        '• $conflict',
                        style: BauhausDesign.getTextTheme(context).bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showShiftSelectionDialog() {
    // In production, this would show a dialog to select a shift
    // For now, show a placeholder message
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('SELECT SHIFT'),
        content: const Text(
          'This feature requires integration with your shift management system. '
          'Please provide a shift ID to find matching workers.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
