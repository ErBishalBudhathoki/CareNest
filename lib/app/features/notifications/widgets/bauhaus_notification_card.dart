import 'package:carenest/app/features/notifications/models/notification_model.dart';
import 'package:carenest/app/shared/design_system/bauhaus_design_system.dart';
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
        return BauhausDesign.accent; // Yellow for default
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

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: BauhausDesign.neutral,
          width: 2,
        ),
        boxShadow: const [
          BoxShadow(
            color: BauhausDesign.neutral,
            offset: Offset(4, 4),
            blurRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon Box
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: themeColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: BauhausDesign.neutral,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: (themeColor == BauhausDesign.accent)
                        ? BauhausDesign.textDark
                        : BauhausDesign.textLight,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),

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
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                                color: BauhausDesign.textDark,
                                height: 1.2,
                              ),
                            ),
                          ),
                          if (isUnread) ...[
                            const SizedBox(width: 8),
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
                      const SizedBox(height: 8),
                      Text(
                        notification.body,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: BauhausDesign.textDark.withOpacity(0.7),
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 14,
                            color: BauhausDesign.neutral.withOpacity(0.6),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            notification.timeAgo,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: BauhausDesign.neutral.withOpacity(0.6),
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
          ),
        ),
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
          color: BauhausDesign.neutral,
          size: 20,
        ),
        color: BauhausDesign.surfaceLight,
        shadowColor: BauhausDesign.neutral,
        elevation:
            0, // We'll use custom decoration if possible, but PopupMenu is tricky.
        // Standard Material popup is okay for now, or minimal style.
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: BauhausDesign.neutral, width: 2),
        ),
        onSelected: (value) {
          if (value == 'read' && onMarkRead != null) onMarkRead!();
          if (value == 'delete' && onDelete != null) onDelete!();
        },
        itemBuilder: (context) => [
          if (!notification.isRead && onMarkRead != null)
            PopupMenuItem(
              value: 'read',
              child: const Row(
                children: [
                  Icon(Icons.check_circle_outline,
                      color: BauhausDesign.success, size: 18),
                  SizedBox(width: 8),
                  Text('Mark as read',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: BauhausDesign.textDark)),
                ],
              ),
            ),
          if (onDelete != null)
            PopupMenuItem(
              value: 'delete',
              child: const Row(
                children: [
                  Icon(Icons.delete_outline,
                      color: BauhausDesign.error, size: 18),
                  SizedBox(width: 8),
                  Text('Delete',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: BauhausDesign.textDark)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
