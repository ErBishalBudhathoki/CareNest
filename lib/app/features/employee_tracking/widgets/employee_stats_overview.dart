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
    final total = stats['total'] ?? 0;
    final active = stats['active'] ?? 0;
    final onBreak = stats['onBreak'] ?? 0;
    final offline = stats['offline'] ?? 0;

    return Container(
      margin: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceOffWhite,
              border: Border.all(color: BauhausDesign.neutral, width: 2),
              boxShadow: const [BauhausDesign.shadowHardSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'EMPLOYEE OVERVIEW',
                        style: BauhausDesign.getTextTheme(context)
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: BauhausDesign.textDark,
                              letterSpacing: 0.6,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: BauhausDesign.space2,
                        vertical: BauhausDesign.space1,
                      ),
                      decoration: BoxDecoration(
                        color: BauhausDesign.accent,
                        border: Border.all(
                          color: BauhausDesign.neutral,
                          width: 2,
                        ),
                        boxShadow: const [BauhausDesign.shadowHardXs],
                      ),
                      child: Text(
                        isLoading ? 'SYNCING' : 'LIVE',
                        style: BauhausDesign.getTextTheme(context).labelSmall
                            ?.copyWith(
                              color: BauhausDesign.textDark,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    if (onRefresh != null) ...[
                      const SizedBox(width: BauhausDesign.space2),
                      BauhausActionButton(
                        onPressed: isLoading ? null : onRefresh,
                        icon: Icons.refresh,
                        variant: BauhausActionVariant.ghost,
                        isLoading: isLoading,
                        isSmall: true,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: BauhausDesign.space3),
                Text(
                  'TOTAL HEADCOUNT',
                  style: BauhausDesign.getTextTheme(context).labelSmall
                      ?.copyWith(
                        color: BauhausDesign.textMuted,
                        letterSpacing: 1.0,
                      ),
                ),
                const SizedBox(height: BauhausDesign.space1),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    total.toString(),
                    style: BauhausDesign.getTextTheme(context).displayMedium
                        ?.copyWith(
                          color: BauhausDesign.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 350.ms).slideY(begin: 0.08, end: 0),
          const SizedBox(height: BauhausDesign.space4),
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 360;
              final tileWidth = isNarrow
                  ? constraints.maxWidth
                  : (constraints.maxWidth - BauhausDesign.space4) / 2;

              return Wrap(
                spacing: BauhausDesign.space4,
                runSpacing: BauhausDesign.space4,
                children: [
                  _NeoStatTile(
                    width: tileWidth,
                    label: 'Active',
                    value: active.toString(),
                    icon: Icons.work,
                    accentColor: BauhausDesign.success,
                  ),
                  _NeoStatTile(
                    width: tileWidth,
                    label: 'On Break',
                    value: onBreak.toString(),
                    icon: Icons.coffee,
                    accentColor: BauhausDesign.warning,
                  ),
                  _NeoStatTile(
                    width: tileWidth,
                    label: 'Offline',
                    value: offline.toString(),
                    icon: Icons.offline_bolt,
                    accentColor: BauhausDesign.textMuted,
                  ),
                  _NeoStatTile(
                    width: tileWidth,
                    label: 'Total',
                    value: total.toString(),
                    icon: Icons.people,
                    accentColor: BauhausDesign.primary,
                  ),
                ],
              ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.06, end: 0);
            },
          ),
          const SizedBox(height: BauhausDesign.space4),
          _NeoStatusStrip(
            total: total,
            active: active,
            onBreak: onBreak,
            offline: offline,
          ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.06, end: 0),
        ],
      ),
    );
  }
}

class _NeoStatTile extends StatelessWidget {
  final double width;
  final String label;
  final String value;
  final IconData icon;
  final Color accentColor;

  const _NeoStatTile({
    required this.width,
    required this.label,
    required this.value,
    required this.icon,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Container(
        padding: const EdgeInsets.all(BauhausDesign.space3),
        decoration: BoxDecoration(
          color: BauhausDesign.surfaceWhite,
          border: Border.all(color: BauhausDesign.neutral, width: 2),
          boxShadow: const [BauhausDesign.shadowHardSm],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(BauhausDesign.space1),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.15),
                border: Border.all(color: BauhausDesign.neutral, width: 2),
              ),
              child: Icon(icon, size: 16, color: accentColor),
            ),
            const SizedBox(height: BauhausDesign.space2),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                value,
                style: BauhausDesign.getTextTheme(
                  context,
                ).headlineLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: BauhausDesign.space1),
            Text(
              label.toUpperCase(),
              style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                color: BauhausDesign.textMuted,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NeoStatusStrip extends StatelessWidget {
  final int total;
  final int active;
  final int onBreak;
  final int offline;

  const _NeoStatusStrip({
    required this.total,
    required this.active,
    required this.onBreak,
    required this.offline,
  });

  @override
  Widget build(BuildContext context) {
    if (total <= 0) {
      return Container(
        padding: const EdgeInsets.all(BauhausDesign.space3),
        decoration: BoxDecoration(
          color: BauhausDesign.surfaceOffWhite,
          border: Border.all(color: BauhausDesign.neutral, width: 2),
          boxShadow: const [BauhausDesign.shadowHardSm],
        ),
        child: Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: BauhausDesign.neutral,
                border: Border.all(color: BauhausDesign.neutral, width: 2),
              ),
            ),
            const SizedBox(width: BauhausDesign.space2),
            Expanded(
              child: Text(
                'No employee activity yet',
                style: BauhausDesign.getTextTheme(
                  context,
                ).bodyMedium?.copyWith(color: BauhausDesign.textMuted),
              ),
            ),
          ],
        ),
      );
    }

    int safeFlex(int count) => count > 0 ? count : 1;

    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceOffWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'STATUS STRIP',
            style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
              color: BauhausDesign.textMuted,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: BauhausDesign.space2),
          Row(
            children: [
              Expanded(
                flex: safeFlex(active),
                child: Container(height: 10, color: BauhausDesign.success),
              ),
              const SizedBox(width: 2),
              Expanded(
                flex: safeFlex(onBreak),
                child: Container(height: 10, color: BauhausDesign.warning),
              ),
              const SizedBox(width: 2),
              Expanded(
                flex: safeFlex(offline),
                child: Container(height: 10, color: BauhausDesign.textMuted),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space2),
          Wrap(
            spacing: BauhausDesign.space3,
            runSpacing: BauhausDesign.space1,
            children: [
              _LegendChip(
                color: BauhausDesign.success,
                label: 'Active',
                value: active,
              ),
              _LegendChip(
                color: BauhausDesign.warning,
                label: 'On Break',
                value: onBreak,
              ),
              _LegendChip(
                color: BauhausDesign.textMuted,
                label: 'Offline',
                value: offline,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LegendChip extends StatelessWidget {
  final Color color;
  final String label;
  final int value;

  const _LegendChip({
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space2,
        vertical: BauhausDesign.space1,
      ),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              border: Border.all(color: BauhausDesign.neutral, width: 1),
            ),
          ),
          const SizedBox(width: BauhausDesign.space1),
          Text(
            '$label $value',
            style: BauhausDesign.getTextTheme(
              context,
            ).labelSmall?.copyWith(color: BauhausDesign.textDark),
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
    final totalCount = statusCounts.values.fold<int>(
      0,
      (int sum, int count) => sum + count,
    );

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
