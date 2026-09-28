import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:carenest/app/shared/widgets/profile_image_widget.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import '../models/employee_tracking_model.dart';

class EmployeeStatusCard extends StatelessWidget {
  final EmployeeStatus employee;
  final VoidCallback? onTap;
  final bool showDetails;

  const EmployeeStatusCard({
    super.key,
    required this.employee,
    this.onTap,
    this.showDetails = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: BauhausCard(
        onTap: onTap,
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildAvatar(context),
                const SizedBox(width: BauhausDesign.space4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        employee.name,
                        style: BauhausDesign.getTextTheme(context).bodyLarge
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        employee.email,
                        style: BauhausDesign.getTextTheme(context).bodyMedium
                            ?.copyWith(
                              color: BauhausDesign.textMuted,
                              fontSize: 12,
                            ),
                      ),
                    ],
                  ),
                ),
                _buildStatusBadge(context),
              ],
            ),
            if (showDetails) ...[
              const SizedBox(height: BauhausDesign.space4),
              _buildDetailsSection(context),
            ],
          ],
        ),
      ).animate().fadeIn(duration: 300.ms).slideX(begin: 0.2, end: 0),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainer.withValues(alpha: 0.1),
        border: Border.all(color: _getStatusColor(context), width: 2),
      ),
      child:
          (employee.photoData != null && employee.photoData!.isNotEmpty) ||
              (employee.profileImage != null &&
                  employee.profileImage!.isNotEmpty)
          ? ClipOval(child: _buildProfileImage(context))
          : _buildDefaultAvatar(context),
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return EmployeeProfileImage(
      profileImage: employee.profileImage,
      photoData: employee.photoData,
      employeeName: employee.name,
      filename: employee.filename,
      size: 50.0,
      isActive: employee.status == WorkStatus.active,
      statusColor: _getStatusIndicatorColor(context),
      onTap: onTap,
    );
  }

  Widget _buildDefaultAvatar(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainer.withValues(alpha: 0.1),
      ),
      child: Icon(Icons.person, size: 30.0, color: BauhausDesign.textMuted),
    );
  }

  Color? _getStatusIndicatorColor(BuildContext context) {
    switch (employee.status) {
      case WorkStatus.active:
        return BauhausDesign.success;
      case WorkStatus.onBreak:
        return BauhausDesign.warning;
      case WorkStatus.offline:
        return Theme.of(context).colorScheme.onSurfaceVariant;
      case WorkStatus.clockedOut:
        return BauhausDesign.error;
    }
  }

  Widget _buildStatusBadge(BuildContext context) {
    // Map status to chip variant
    BauhausChipVariant variant;
    String label;

    switch (employee.status) {
      case WorkStatus.active:
        variant = BauhausChipVariant.success;
        label = 'Active';
        break;
      case WorkStatus.onBreak:
        variant = BauhausChipVariant.warning;
        label = 'On Break';
        break;
      case WorkStatus.offline:
        variant = BauhausChipVariant.neutral;
        label = 'Offline';
        break;
      case WorkStatus.clockedOut:
        variant = BauhausChipVariant.error; // or neutral/outlined
        label = 'Clocked Out';
        break;
    }

    return BauhausChip(
      label: label,
      variant: variant,
      isSmall: true,
      onTap: null, // Non-interactive badge
    );
  }

  Widget _buildDetailsSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
      ),
      child: Column(
        children: [
          if (employee.currentLocation != null)
            _buildDetailRow(
              context,
              Icons.location_on,
              'Location',
              employee.currentLocation!,
            ),
          if (employee.hoursWorked > 0)
            _buildDetailRow(
              context,
              Icons.access_time,
              'Hours Worked',
              '${employee.hoursWorked.toStringAsFixed(1)}h',
            ),
          if (employee.lastSeen != null)
            _buildDetailRow(
              context,
              Icons.schedule,
              'Last Seen',
              _formatLastSeen(employee.lastSeen!),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: BauhausDesign.space1),
      child: Row(
        children: [
          Icon(icon, size: 16, color: BauhausDesign.textMuted),
          const SizedBox(width: BauhausDesign.space2),
          Text(
            '$label:',
            style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: BauhausDesign.textMuted,
            ),
          ),
          const SizedBox(width: BauhausDesign.space2),
          Expanded(
            child: Text(
              value,
              style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(BuildContext context) {
    switch (employee.status) {
      case WorkStatus.active:
        return BauhausDesign.success;
      case WorkStatus.onBreak:
        return BauhausDesign.warning;
      case WorkStatus.offline:
      case WorkStatus.clockedOut:
        return Theme.of(context).colorScheme.onSurfaceVariant;
    }
  }

  String _formatLastSeen(DateTime lastSeen) {
    final now = DateTime.now();
    final difference = now.difference(lastSeen);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}
