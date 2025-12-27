import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/shared/constants/values/themes/app_theme_config.dart';
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
      margin: const EdgeInsets.all(AppThemeConfig.spacingM),
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
                  style: AppThemeConfig.titleStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (onRefresh != null)
                IconButton(
                  onPressed: isLoading ? null : onRefresh,
                  icon: Icon(
                    Icons.refresh,
                    color: isLoading
                        ? AppColors.colorGrey400
                        : AppColors.colorPrimary,
                  ),
                ).animate(target: isLoading ? 1 : 0).rotate(duration: 1000.ms),
            ],
          ),
          const SizedBox(height: AppThemeConfig.spacingM),
          Flexible(
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: AppThemeConfig.spacingM,
              crossAxisSpacing: AppThemeConfig.spacingM,
              childAspectRatio: 1.4,
              children: [
                _buildStatCard(
                  'Total Employees',
                  stats['total'] ?? 0,
                  Icons.people,
                  AppColors.colorBlue,
                  0,
                ),
                _buildStatCard(
                  'Active',
                  stats['active'] ?? 0,
                  Icons.work,
                  AppColors.colorSuccess,
                  100,
                ),
                _buildStatCard(
                  'On Break',
                  stats['onBreak'] ?? 0,
                  Icons.coffee,
                  AppColors.colorWarning,
                  200,
                ),
                _buildStatCard(
                  'Offline',
                  stats['offline'] ?? 0,
                  Icons.offline_bolt,
                  AppColors.colorGrey500,
                  300,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    int value,
    IconData icon,
    Color color,
    int animationDelay,
  ) {
    final gradientColors = _getGradientColors(color);

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: gradientColors.first.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius:
                  BorderRadius.circular(8.0),
            ),
            child: Icon(
              icon,
              size: 22,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            value.toString(),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600).copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: const TextStyle(fontSize: 14).copyWith(
              color: Colors.white.withOpacity(0.1),
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    )
        .animate(delay: Duration(milliseconds: animationDelay))
        .fadeIn(duration: 600.ms)
        .slideX(begin: 0.2, end: 0);
  }

  List<Color> _getGradientColors(Color baseColor) {
    if (baseColor == AppColors.colorBlue) {
      return [const Color(0xFF667eea), const Color(0xFF764ba2)];
    } else if (baseColor == AppColors.colorSuccess) {
      return [const Color(0xFF11998e), const Color(0xFF38ef7d)];
    } else if (baseColor == AppColors.colorWarning) {
      return [const Color(0xFFf093fb), const Color(0xFFf5576c)];
    } else {
      return [const Color(0xFF667eea), const Color(0xFF764ba2)];
    }
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

  List<Color> _getGradientColors(Color baseColor) {
    if (baseColor == AppColors.colorBlue) {
      return [const Color(0xFF667eea), const Color(0xFF764ba2)];
    } else if (baseColor == AppColors.colorSuccess) {
      return [const Color(0xFF11998e), const Color(0xFF38ef7d)];
    } else if (baseColor == AppColors.colorWarning) {
      return [const Color(0xFFf093fb), const Color(0xFFf5576c)];
    } else {
      return [const Color(0xFF667eea), const Color(0xFF764ba2)];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppThemeConfig.spacingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filter by Status',
            style: AppThemeConfig.subtitleStyle.copyWith(
              fontSize: AppThemeConfig.fontSizeMedium,
            ),
          ),
          const SizedBox(height: AppThemeConfig.spacingS),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(
                  'All',
                  statusCounts.values.fold(0, (sum, count) => sum + count),
                  null,
                  AppColors.colorGrey600,
                ),
                const SizedBox(width: 8.0),
                _buildFilterChip(
                  'Active',
                  statusCounts[WorkStatus.active] ?? 0,
                  WorkStatus.active,
                  AppColors.colorSuccess,
                ),
                const SizedBox(width: 8.0),
                _buildFilterChip(
                  'On Break',
                  statusCounts[WorkStatus.onBreak] ?? 0,
                  WorkStatus.onBreak,
                  AppColors.colorWarning,
                ),
                const SizedBox(width: 8.0),
                _buildFilterChip(
                  'Offline',
                  statusCounts[WorkStatus.offline] ?? 0,
                  WorkStatus.offline,
                  AppColors.colorGrey500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    String label,
    int count,
    WorkStatus? status,
    Color color,
  ) {
    final isSelected = selectedFilter == status;
    final gradientColors = _getGradientColors(color);

    return GestureDetector(
      onTap: () => onFilterChanged(status),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 8.0,
        ),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color:
                isSelected ? Colors.transparent : color.withOpacity(0.1),
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: gradientColors.first.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 14).copyWith(
                color: isSelected ? Colors.white : color,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
            if (count > 0) ...[
              const SizedBox(width: 4.0),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4.0,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withOpacity(0.1)
                      : color.withOpacity(0.1),
                  borderRadius:
                      BorderRadius.circular(8.0),
                ),
                child: Text(
                  count.toString(),
                  style: const TextStyle(fontSize: 12).copyWith(
                    color: isSelected ? Colors.white : color,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 300.ms)
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0));
  }
}
