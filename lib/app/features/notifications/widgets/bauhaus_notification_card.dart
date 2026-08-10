import 'package:carenest/app/features/notifications/models/notification_model.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:flutter/material.dart';

class BauhausNotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;
  final VoidCallback? onMarkRead;
  final VoidCallback? onDelete;

  const BauhausNotificationCard({
    super.key,
    required this.notification,
    required this.onTap,
    this.onMarkRead,
    this.onDelete,
  });

  Color _getTypeColor(String? type) {
    switch (type) {
      case 'timer':
        return BauhausDesign.success;
      case 'message':
        return BauhausDesign.secondary;
      case 'warning':
        return BauhausDesign.warning;
      case 'error':
        return BauhausDesign.error;
      default:
        return BauhausDesign.secondary; // Default blueish
    }
  }

  IconData _getTypeIcon(String? type) {
    switch (type) {
      case 'timer':
        return Icons.timer_outlined;
      case 'message':
        return Icons.message_outlined;
      case 'warning':
        return Icons.warning_amber_rounded;
      case 'error':
        return Icons.error_outline_rounded;
      default:
        return Icons.notifications_none_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = _getTypeColor(notification.type);
    final icon = _getTypeIcon(notification.type);
    final isUnread = !notification.isRead;

    return BauhausCard(
      onTap: onTap,
      padding: const EdgeInsets.all(BauhausDesign.space4),
      margin: const EdgeInsets.only(bottom: BauhausDesign.space4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Box
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: themeColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
              border: Border.all(color: themeColor, width: 2),
            ),
            child: Icon(icon, color: themeColor, size: 24),
          ),
          const SizedBox(width: BauhausDesign.space4),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        style: BauhausDesign.getTextTheme(context).bodyLarge
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: BauhausDesign.textDark,
                            ),
                      ),
                    ),
                    if (isUnread) ...[
                      const SizedBox(width: BauhausDesign.space2),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: BauhausDesign.primary,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: BauhausDesign.neutral,
                            width: 1,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: BauhausDesign.space2),
                Text(
                  notification.body,
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).bodyMedium?.copyWith(color: BauhausDesign.textMuted),
                ),
                const SizedBox(height: BauhausDesign.space3),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 14,
                      color: BauhausDesign.textMuted,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      notification.timeAgo,
                      style: BauhausDesign.getTextTheme(context).labelSmall
                          ?.copyWith(
                            color: BauhausDesign.textMuted,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const Spacer(),
                    // Context Menu / Options
                    if (onMarkRead != null || onDelete != null)
                      _buildOptionsMenu(context),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionsMenu(BuildContext context) {
    return SizedBox(
      height: 24,
      width: 24,
      child: PopupMenuButton<String>(
        padding: EdgeInsets.zero,
        icon: const Icon(
          Icons.more_horiz_rounded,
          color: BauhausDesign.textMuted,
          size: 20,
        ),
        color: BauhausDesign.surfaceWhite,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          side: const BorderSide(color: BauhausDesign.neutral, width: 1),
        ),
        onSelected: (value) {
          if (value == 'read' && onMarkRead != null) onMarkRead!();
          if (value == 'delete' && onDelete != null) onDelete!();
        },
        itemBuilder: (context) => [
          if (!notification.isRead && onMarkRead != null)
            PopupMenuItem(
              value: 'read',
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    color: BauhausDesign.success,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Mark as read',
                    style: BauhausDesign.getTextTheme(
                      context,
                    ).bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          if (onDelete != null)
            PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  const Icon(
                    Icons.delete_outline,
                    color: BauhausDesign.error,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Delete',
                    style: BauhausDesign.getTextTheme(
                      context,
                    ).bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
