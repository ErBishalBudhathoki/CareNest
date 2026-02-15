import 'package:flutter/material.dart';
import 'package:carenest/app/shared/theme/bauhaus_colors.dart';
import '../models/dashboard_models.dart';

class QuickActionsWidget extends StatelessWidget {
  final List<QuickAction>? actions;
  final bool isLoading;
  final Function(QuickAction)? onActionTap;

  const QuickActionsWidget({
    super.key,
    this.actions,
    this.isLoading = false,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildLoadingState();
    }

    if (actions == null || actions!.isEmpty) {
      return _buildEmptyState();
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: BauhausColors.primaryBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.flash_on,
                    color: BauhausColors.primaryBlue,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Quick Actions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: BauhausColors.textDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...actions!.map((action) => _buildActionTile(context, action)),
          ],
        ),
      ),
    );
  }

  Widget _buildActionTile(BuildContext context, QuickAction action) {
    final color = _getActionColor(action.type);
    final icon = _getActionIcon(action.type);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onActionTap?.call(action),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        action.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: BauhausColors.textDark,
                        ),
                      ),
                      if (action.count > 0) ...[
                        const SizedBox(height: 2),
                        Text(
                          '${action.count} pending',
                          style: TextStyle(
                            fontSize: 12,
                            color: color,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (action.count > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      action.count.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                const SizedBox(width: 8),
                Icon(
                  Icons.chevron_right,
                  color: color.withOpacity(0.5),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const Padding(
        padding: EdgeInsets.all(32),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const Padding(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            children: [
              Icon(Icons.check_circle_outline, size: 48, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'All caught up!',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'No pending actions',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getActionColor(QuickActionType type) {
    switch (type) {
      case QuickActionType.approveTimesheets:
        return BauhausColors.primaryBlue;
      case QuickActionType.reviewExpenses:
        return BauhausColors.accentOrange;
      case QuickActionType.assignShifts:
        return BauhausColors.primaryYellow;
      case QuickActionType.sendMessages:
        return BauhausColors.accentPurple;
      case QuickActionType.viewReports:
        return BauhausColors.accentGreen;
      case QuickActionType.manageCompliance:
        return BauhausColors.primaryRed;
    }
  }

  IconData _getActionIcon(QuickActionType type) {
    switch (type) {
      case QuickActionType.approveTimesheets:
        return Icons.access_time;
      case QuickActionType.reviewExpenses:
        return Icons.receipt_long;
      case QuickActionType.assignShifts:
        return Icons.calendar_today;
      case QuickActionType.sendMessages:
        return Icons.message;
      case QuickActionType.viewReports:
        return Icons.bar_chart;
      case QuickActionType.manageCompliance:
        return Icons.verified_user;
    }
  }
}
