import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/notifications/providers/notification_provider.dart';
import '../widgets/bauhaus_notification_card.dart';

class NotificationListView extends ConsumerStatefulWidget {
  const NotificationListView({super.key});

  @override
  ConsumerState<NotificationListView> createState() =>
      _NotificationListViewState();
}

class _NotificationListViewState extends ConsumerState<NotificationListView>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notificationState = ref.watch(notificationProvider);
    final notificationNotifier = ref.read(notificationProvider.notifier);

    return Scaffold(
      backgroundColor: BauhausDesign.surfaceLight,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(context, notificationState, notificationNotifier),

            // Notification List
            Expanded(
              child: _buildNotificationList(
                notificationState,
                notificationNotifier,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    NotificationState state,
    NotificationNotifier notifier,
  ) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          padding: const EdgeInsets.all(BauhausDesign.space4),
          decoration: const BoxDecoration(
            color: BauhausDesign.surfaceLight,
            border: Border(
              bottom: BorderSide(color: BauhausDesign.neutral, width: 1),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  // Back button
                  BauhausIconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icons.arrow_back_ios_new,
                    variant: BauhausActionVariant.ghost,
                    isSmall: true,
                  ),
                  const SizedBox(width: BauhausDesign.space2),

                  // Title
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notifications',
                          style: BauhausDesign.getTextTheme(
                            context,
                          ).headlineSmall,
                        ),
                        if (state.unreadCount > 0)
                          Text(
                            '${state.unreadCount} unread',
                            style: BauhausDesign.getTextTheme(context)
                                .labelSmall
                                ?.copyWith(
                                  color: BauhausDesign.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                      ],
                    ),
                  ),

                  // Actions
                  if (state.notifications.isNotEmpty) ...[
                    // Mark all as read
                    BauhausIconButton(
                      onPressed: state.hasUnreadNotifications
                          ? () => notifier.markAllAsRead()
                          : null,
                      icon: Icons.done_all,
                      variant: state.hasUnreadNotifications
                          ? BauhausActionVariant.primary
                          : BauhausActionVariant.neutral,
                      isSmall: true,
                      tooltip: 'Mark all as read',
                    ),
                    const SizedBox(width: BauhausDesign.space2),
                    // Clear all
                    BauhausIconButton(
                      onPressed: () => _showClearAllDialog(context, notifier),
                      icon: Icons.delete_sweep_outlined,
                      variant: BauhausActionVariant.danger,
                      isSmall: true,
                      tooltip: 'Clear all',
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationList(
    NotificationState state,
    NotificationNotifier notifier,
  ) {
    if (state.isLoading) {
      return Center(
        child: BauhausLoadingState(message: 'Loading notifications...'),
      );
    }

    if (state.error != null) {
      return BauhausErrorState(
        title: 'Error loading notifications',
        message: state.error!,
        onRetry: () => notifier.refresh(),
      );
    }

    if (state.notifications.isEmpty) {
      return FadeTransition(
        opacity: _fadeAnimation,
        child: const BauhausEmptyState(
          title: 'No notifications yet',
          message: 'You\'re all caught up! New notifications will appear here.',
          icon: Icons.notifications_off_outlined,
        ),
      );
    }

    return FadeTransition(
      opacity: _fadeAnimation,
      child: RefreshIndicator(
        onRefresh: () async => notifier.refresh(),
        color: BauhausDesign.primary,
        backgroundColor: BauhausDesign.surfaceWhite,
        child: ListView.builder(
          padding: const EdgeInsets.all(BauhausDesign.space4),
          itemCount: state.notifications.length,
          itemBuilder: (context, index) {
            final notification = state.notifications[index];
            return TweenAnimationBuilder<double>(
              duration: Duration(milliseconds: 300 + (index * 50)),
              tween: Tween(begin: 0.0, end: 1.0),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, 20 * (1 - value)),
                  child: Opacity(
                    opacity: value,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: BauhausNotificationCard(
                        notification: notification,
                        onTap: () {
                          if (!notification.isRead) {
                            notifier.markAsRead(notification.id);
                          }
                          // Add navigation logic if expanded
                        },
                        onMarkRead: !notification.isRead
                            ? () => notifier.markAsRead(notification.id)
                            : null,
                        onDelete: () =>
                            notifier.deleteNotification(notification.id),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _showClearAllDialog(
    BuildContext context,
    NotificationNotifier notifier,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: BauhausCard(
          padding: const EdgeInsets.all(BauhausDesign.space6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Clear All Notifications?',
                style: BauhausDesign.getTextTheme(context).headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: BauhausDesign.space4),
              Text(
                'Are you sure you want to clear all notifications? This action cannot be undone.',
                style: BauhausDesign.getTextTheme(context).bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: BauhausDesign.space6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: BauhausActionButton(
                      onPressed: () => Navigator.of(context).pop(),
                      text: 'Cancel',
                      variant: BauhausActionVariant.secondary,
                    ),
                  ),
                  const SizedBox(width: BauhausDesign.space4),
                  Expanded(
                    child: BauhausActionButton(
                      onPressed: () {
                        notifier.clearAllNotifications();
                        Navigator.of(context).pop();
                      },
                      text: 'Clear All',
                      variant: BauhausActionVariant.danger,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
