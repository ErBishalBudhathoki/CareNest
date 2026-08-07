import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/features/scheduling/views/shift_matching_view.dart';
import 'package:carenest/app/features/scheduling/viewmodels/shift_matching_viewmodel.dart';

class AutoScheduleDashboard extends ConsumerWidget {
  final String? organizationId;

  const AutoScheduleDashboard({super.key, this.organizationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(shiftMatchingViewModelProvider);

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.textDark,
        title: Text(
          'AUTO-SCHEDULE',
          style: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
            color: BauhausDesign.surfaceWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: BauhausDesign.surfaceWhite),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            BauhausCard(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isCompact = constraints.maxWidth < 520;
                        final leadingIcon = Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: BauhausDesign.secondary.withOpacity(0.1),
                            border: Border.all(
                              color: BauhausDesign.secondary,
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.auto_awesome,
                            color: BauhausDesign.secondary,
                            size: 32,
                          ),
                        );

                        if (isCompact) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              leadingIcon,
                              const SizedBox(height: 12),
                              Text(
                                'INTELLIGENT SCHEDULING',
                                style: BauhausDesign.getTextTheme(context)
                                    .titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Automatically assign optimal workers to shifts',
                                style: BauhausDesign.getTextTheme(context)
                                    .bodyMedium
                                    ?.copyWith(color: BauhausDesign.textDark),
                              ),
                            ],
                          );
                        }

                        return Row(
                          children: [
                            leadingIcon,
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'INTELLIGENT SCHEDULING',
                                    style: BauhausDesign.getTextTheme(context)
                                        .titleLarge
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Automatically assign optimal workers to shifts',
                                    style: BauhausDesign.getTextTheme(context)
                                        .bodyMedium
                                        ?.copyWith(
                                          color: BauhausDesign.textDark,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Stats Cards
            LayoutBuilder(
              builder: (context, constraints) {
                final stats = [
                  const _AutoScheduleStatItem(
                    title: 'OPEN SHIFTS',
                    value: '12',
                    icon: Icons.event_available,
                    color: BauhausDesign.warning,
                  ),
                  const _AutoScheduleStatItem(
                    title: 'FILLED TODAY',
                    value: '8',
                    icon: Icons.check_circle_outline,
                    color: BauhausDesign.success,
                  ),
                  const _AutoScheduleStatItem(
                    title: 'FILL RATE',
                    value: '87%',
                    icon: Icons.trending_up,
                    color: BauhausDesign.secondary,
                  ),
                  const _AutoScheduleStatItem(
                    title: 'AVG MATCH',
                    value: '92%',
                    icon: Icons.stars,
                    color: BauhausDesign.primary,
                  ),
                ];

                final columns = constraints.maxWidth >= 860 ? 2 : 1;
                final cardWidth = columns == 1
                    ? constraints.maxWidth
                    : (constraints.maxWidth - 16) / 2;

                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: stats
                      .map(
                        (stat) => SizedBox(
                          width: cardWidth,
                          child: _buildStatCard(
                            context,
                            title: stat.title,
                            value: stat.value,
                            icon: stat.icon,
                            color: stat.color,
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),

            const SizedBox(height: 32),

            // Auto-Fill Result
            if (viewModel.autoFillResult != null) ...[
              BauhausSectionHeader(title: 'LAST AUTO-FILL RESULT'),
              const SizedBox(height: 16),
              BauhausCard(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'TOTAL SHIFTS',
                            style: BauhausDesign.getTextTheme(context)
                                .bodyMedium
                                ?.copyWith(color: BauhausDesign.textDark),
                          ),
                          Text(
                            '${viewModel.autoFillResult!.totalShifts}',
                            style: BauhausDesign.getTextTheme(
                              context,
                            ).titleLarge?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'FILLED',
                            style: BauhausDesign.getTextTheme(context)
                                .bodyMedium
                                ?.copyWith(color: BauhausDesign.success),
                          ),
                          Text(
                            '${viewModel.autoFillResult!.filledShifts}',
                            style: BauhausDesign.getTextTheme(context)
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: BauhausDesign.success,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'UNFILLED',
                            style: BauhausDesign.getTextTheme(
                              context,
                            ).bodyMedium?.copyWith(color: BauhausDesign.error),
                          ),
                          Text(
                            '${viewModel.autoFillResult!.unfilledShifts}',
                            style: BauhausDesign.getTextTheme(context)
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: BauhausDesign.error,
                                ),
                          ),
                        ],
                      ),
                      if (viewModel.autoFillResult!.optimizationSummary !=
                          null) ...[
                        const SizedBox(height: 16),
                        const Divider(
                          color: BauhausDesign.neutral,
                          thickness: 1,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          viewModel.autoFillResult!.optimizationSummary!,
                          style: BauhausDesign.getTextTheme(context).bodyMedium,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],

            // Action Buttons
            BauhausSectionHeader(title: 'ACTIONS'),
            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: BauhausActionButton(
                onPressed: () {
                  // In production, this would trigger auto-fill
                  _showAutoFillDialog(context);
                },
                text: 'AUTO-FILL SHIFTS',
                icon: Icons.auto_fix_high,
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: BauhausActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ShiftMatchingView(organizationId: organizationId),
                    ),
                  );
                },
                text: 'MANUAL MATCHING',
                icon: Icons.search,
                variant: BauhausActionVariant.ghost,
                isOutlined: true,
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: BauhausActionButton(
                onPressed: () {
                  _showRouteOptimizationDialog(context);
                },
                text: 'OPTIMIZE ROUTES',
                icon: Icons.route,
                variant: BauhausActionVariant.ghost,
                isOutlined: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return BauhausCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 12),
            Text(
              title,
              style: BauhausDesign.getTextTheme(
                context,
              ).bodySmall?.copyWith(color: BauhausDesign.textDark),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: BauhausDesign.getTextTheme(
                context,
              ).headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void _showAutoFillDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('AUTO-FILL SHIFTS'),
        content: const Text(
          'This will automatically assign the best matching workers to all open shifts. Continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // In production, trigger auto-fill
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Auto-fill feature requires shift data'),
                ),
              );
            },
            child: const Text('CONFIRM'),
          ),
        ],
      ),
    );
  }

  void _showRouteOptimizationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('OPTIMIZE ROUTES'),
        content: const Text(
          'This will optimize travel routes for all workers based on their assigned shifts. Continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Route optimization feature requires worker data',
                  ),
                ),
              );
            },
            child: const Text('CONFIRM'),
          ),
        ],
      ),
    );
  }
}

class _AutoScheduleStatItem {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _AutoScheduleStatItem({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });
}
