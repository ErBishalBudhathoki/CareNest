import 'package:flutter/material.dart';
import '../models/dashboard_models.dart';

class ComplianceAlertsWidget extends StatelessWidget {
  final List<ComplianceAlert>? alerts;
  final bool isLoading;
  final Function(ComplianceAlert)? onAlertTap;

  const ComplianceAlertsWidget({
    super.key,
    this.alerts,
    this.isLoading = false,
    this.onAlertTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (isLoading) {
      return _buildLoadingState();
    }

    if (alerts == null || alerts!.isEmpty) {
      return _buildEmptyState(context);
    }

    // Sort by severity (critical first)
    final sortedAlerts = List<ComplianceAlert>.from(alerts!)
      ..sort(
        (a, b) => _getSeverityOrder(
          b.severity,
        ).compareTo(_getSeverityOrder(a.severity)),
      );

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
                    color: colorScheme.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.warning_amber_rounded,
                    color: colorScheme.error,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Compliance Alerts',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.error,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    sortedAlerts.length.toString(),
                    style: TextStyle(
                      color: colorScheme.onError,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...sortedAlerts.map((alert) => _buildAlertTile(context, alert)),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertTile(BuildContext context, ComplianceAlert alert) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = _getSeverityColor(alert.severity, colorScheme);
    final foregroundColor = color == colorScheme.error
        ? colorScheme.onError
        : color == colorScheme.primary
        ? colorScheme.onPrimary
        : colorScheme.onSecondary;
    final icon = _getAlertIcon(alert.type);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onAlertTap?.call(alert),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: color.withValues(alpha: 0.3),
                width: 1.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(icon, color: color, size: 18),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  alert.title,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: colorScheme.onSurface,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  alert.count.toString(),
                                  style: TextStyle(
                                    color: foregroundColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            alert.description,
                            style: TextStyle(
                              fontSize: 12,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 12, color: color),
                    const SizedBox(width: 4),
                    Text(
                      'Due: ${_formatDate(alert.dueDate)}',
                      style: TextStyle(
                        fontSize: 11,
                        color: color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        _getSeverityLabel(alert.severity),
                        style: TextStyle(
                          fontSize: 10,
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
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
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.check_circle,
                size: 48,
                color: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(height: 16),
              Text(
                'All compliant!',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'No compliance issues',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getSeverityColor(
    ComplianceSeverity severity,
    ColorScheme colorScheme,
  ) {
    switch (severity) {
      case ComplianceSeverity.critical:
        return colorScheme.error;
      case ComplianceSeverity.high:
        return colorScheme.primary;
      case ComplianceSeverity.medium:
        return colorScheme.primary;
      case ComplianceSeverity.low:
        return colorScheme.secondary;
    }
  }

  int _getSeverityOrder(ComplianceSeverity severity) {
    switch (severity) {
      case ComplianceSeverity.critical:
        return 4;
      case ComplianceSeverity.high:
        return 3;
      case ComplianceSeverity.medium:
        return 2;
      case ComplianceSeverity.low:
        return 1;
    }
  }

  String _getSeverityLabel(ComplianceSeverity severity) {
    switch (severity) {
      case ComplianceSeverity.critical:
        return 'CRITICAL';
      case ComplianceSeverity.high:
        return 'HIGH';
      case ComplianceSeverity.medium:
        return 'MEDIUM';
      case ComplianceSeverity.low:
        return 'LOW';
    }
  }

  IconData _getAlertIcon(ComplianceAlertType type) {
    switch (type) {
      case ComplianceAlertType.expiringCertifications:
        return Icons.card_membership;
      case ComplianceAlertType.missingDocuments:
        return Icons.description;
      case ComplianceAlertType.overdueTraining:
        return Icons.school;
      case ComplianceAlertType.expiredInsurance:
        return Icons.shield;
      case ComplianceAlertType.pendingScreening:
        return Icons.verified_user;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now);

    if (difference.inDays < 0) {
      return 'Overdue';
    } else if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Tomorrow';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
