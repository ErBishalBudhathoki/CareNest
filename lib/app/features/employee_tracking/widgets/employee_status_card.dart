import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/shared/constants/values/themes/app_theme_config.dart';
import 'package:carenest/app/shared/widgets/profile_image_widget.dart';
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
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFFE0E0E0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _buildAvatar(),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            employee.name,
                            style: const TextStyle(fontSize: 14).copyWith(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1F2937),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            employee.email,
                            style: const TextStyle(fontSize: 12).copyWith(
                              color: const Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildStatusBadge(),
                  ],
                ),
                if (showDetails) ...[
                  const SizedBox(height: 16.0),
                  _buildDetailsSection(),
                ],
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).slideX(begin: 0.2, end: 0);
  }

  Widget _buildAvatar() {
    debugPrint('🔍 DEBUG: Building avatar for ${employee.name}');
    debugPrint('🔍 DEBUG: ProfileImage value: ${employee.profileImage}');
    debugPrint(
        '🔍 DEBUG: ProfileImage is null: ${employee.profileImage == null}');
    debugPrint(
        '🔍 DEBUG: ProfileImage length: ${employee.profileImage?.length}');

    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.colorGrey200,
        border: Border.all(
          color: _getStatusColor(),
          width: 2,
        ),
      ),
      child: (employee.photoData != null && employee.photoData!.isNotEmpty) ||
              (employee.profileImage != null &&
                  employee.profileImage!.isNotEmpty)
          ? ClipOval(
              child: _buildProfileImage(),
            )
          : _buildDefaultAvatar(),
    );
  }

  /// Builds the profile image using the unified ProfileImageWidget
  ///
  /// Uses EmployeeProfileImage for consistent styling and status indication
  Widget _buildProfileImage() {
    debugPrint('🔍 DEBUG: _buildProfileImage called for ${employee.name}');
    debugPrint('🔍 DEBUG: Filename for ${employee.name}: ${employee.filename}');

    return EmployeeProfileImage(
      profileImage: employee.profileImage,
      photoData: employee.photoData,
      employeeName: employee.name,
      filename: employee.filename,
      size: 50.0,
      isActive: employee.status == WorkStatus.active,
      statusColor: _getStatusIndicatorColor(),
      onTap: onTap,
    );
  }

  /// Builds a default avatar when no profile image is available
  ///
  /// Returns a circular container with person icon as fallback
  Widget _buildDefaultAvatar() {
    return Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.colorGrey200,
      ),
      child: Icon(
        Icons.person,
        size: 30.0,
        color: AppColors.colorGrey600,
      ),
    );
  }

  /// Gets the status indicator color based on employee work status
  ///
  /// Returns appropriate color for the status indicator dot
  Color? _getStatusIndicatorColor() {
    switch (employee.status) {
      case WorkStatus.active:
        return Colors.green;
      case WorkStatus.onBreak:
        return Colors.orange;
      case WorkStatus.offline:
        return Colors.grey;
      case WorkStatus.clockedOut:
        return Colors.red;
      default:
        return null;
    }
  }

  Widget _buildStatusBadge() {
    final statusColor = _getStatusColor();
    final statusText = _getStatusText();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            statusColor,
            statusColor.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: statusColor.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        statusText,
        style: const TextStyle(fontSize: 12).copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildDetailsSection() {
    return Container(
      padding: const EdgeInsets.all(AppThemeConfig.spacingS),
      decoration: BoxDecoration(
        color: AppColors.colorGrey50,
        borderRadius: AppThemeConfig.borderRadiusS,
      ),
      child: Column(
        children: [
          if (employee.currentLocation != null)
            _buildDetailRow(
              Icons.location_on,
              'Location',
              employee.currentLocation!,
            ),
          if (employee.hoursWorked > 0)
            _buildDetailRow(
              Icons.access_time,
              'Hours Worked',
              '${employee.hoursWorked.toStringAsFixed(1)}h',
            ),
          if (employee.lastSeen != null)
            _buildDetailRow(
              Icons.schedule,
              'Last Seen',
              _formatLastSeen(employee.lastSeen!),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppThemeConfig.spacingXS),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: AppColors.colorGrey600,
          ),
          const SizedBox(width: AppThemeConfig.spacingS),
          Text(
            '$label:',
            style: AppThemeConfig.captionStyle.copyWith(
              fontWeight: AppThemeConfig.fontWeightMedium,
            ),
          ),
          const SizedBox(width: AppThemeConfig.spacingXS),
          Expanded(
            child: Text(
              value,
              style: AppThemeConfig.captionStyle,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor() {
    switch (employee.status) {
      case WorkStatus.active:
        return AppColors.colorSuccess;
      case WorkStatus.onBreak:
        return AppColors.colorWarning;
      case WorkStatus.offline:
      case WorkStatus.clockedOut:
        return AppColors.colorGrey500;
    }
  }

  String _getStatusText() {
    switch (employee.status) {
      case WorkStatus.active:
        return 'Active';
      case WorkStatus.onBreak:
        return 'On Break';
      case WorkStatus.offline:
        return 'Offline';
      case WorkStatus.clockedOut:
        return 'Clocked Out';
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
