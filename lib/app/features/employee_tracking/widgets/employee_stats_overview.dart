import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import '../models/employee_tracking_model.dart';

class EmployeeStatsOverview extends StatelessWidget {
  final Map<String, int> stats;
  final VoidCallback? onRefresh;
  final bool isLoading;

  const EmployeeStatsOverview({
    super.key,
    required this.stats,
    this.onRefresh,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'Employee Overview',
                  style: BauhausDesign.getTextTheme(context)
                      .headlineMedium
                      ?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: BauhausDesign.textDark,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (onRefresh != null)
                BauhausActionButton(
                  onPressed: isLoading ? null : onRefresh,
                  icon: Icons.refresh,
                  variant: BauhausActionVariant.ghost,
                  isLoading: isLoading,
                  isSmall: true,
                ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space4),
          Flexible(
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: BauhausDesign.space4,
              crossAxisSpacing: BauhausDesign.space4,
              childAspectRatio: 1.4,
              children: [
                BauhausStatCard(
                  title: 'Total Employees',
                  value: (stats['total'] ?? 0).toString(),
                  icon: Icons.people,
                  iconColor: BauhausDesign.primary,
                ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.2, end: 0),
                BauhausStatCard(
                  title: 'Active',
                  value: (stats['active'] ?? 0).toString(),
                  icon: Icons.work,
                  iconColor: BauhausDesign.success,
                )
                    .animate(delay: 100.ms)
                    .fadeIn(duration: 400.ms)
                    .slideX(begin: 0.2, end: 0),
                BauhausStatCard(
                  title: 'On Break',
                  value: (stats['onBreak'] ?? 0).toString(),
                  icon: Icons.coffee,
                  iconColor: BauhausDesign.warning,
                )
                    .animate(delay: 200.ms)
                    .fadeIn(duration: 400.ms)
                    .slideX(begin: 0.2, end: 0),
                BauhausStatCard(
                  title: 'Offline',
                  value: (stats['offline'] ?? 0).toString(),
                  icon: Icons.offline_bolt,
                  iconColor: BauhausDesign.textMuted,
                )
                    .animate(delay: 300.ms)
                    .fadeIn(duration: 400.ms)
                    .slideX(begin: 0.2, end: 0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EmployeeFilterChips extends StatelessWidget {
  final WorkStatus? selectedFilter;
  final Function(WorkStatus?) onFilterChanged;
  final Map<WorkStatus, int> statusCounts;

  const EmployeeFilterChips({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
    required this.statusCounts,
  });

  @override
  Widget build(BuildContext context) {
    final totalCount =
        statusCounts.values.fold<int>(0, (int sum, int count) => sum + count);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filter by Status',
            style: BauhausDesign.getTextTheme(context).headlineMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: BauhausDesign.space2),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                BauhausChip(
                  label: 'All ($totalCount)',
                  isSelected: selectedFilter == null,
                  onTap: () => onFilterChanged(null),
                  variant: BauhausChipVariant.neutral,
                ),
                const SizedBox(width: BauhausDesign.space2),
                BauhausChip(
                  label: 'Active (${statusCounts[WorkStatus.active] ?? 0})',
                  isSelected: selectedFilter == WorkStatus.active,
                  onTap: () => onFilterChanged(WorkStatus.active),
                  variant: BauhausChipVariant.success,
                ),
                const SizedBox(width: BauhausDesign.space2),
                BauhausChip(
                  label: 'On Break (${statusCounts[WorkStatus.onBreak] ?? 0})',
                  isSelected: selectedFilter == WorkStatus.onBreak,
                  onTap: () => onFilterChanged(WorkStatus.onBreak),
                  variant: BauhausChipVariant.warning,
                ),
                const SizedBox(width: BauhausDesign.space2),
                BauhausChip(
                  label: 'Offline (${statusCounts[WorkStatus.offline] ?? 0})',
                  isSelected: selectedFilter == WorkStatus.offline,
                  onTap: () => onFilterChanged(WorkStatus.offline),
                  variant:
                      BauhausChipVariant.neutral, // Using neutral for offline
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
