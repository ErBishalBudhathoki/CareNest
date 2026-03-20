import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_switch.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import '../models/notification_preferences.dart';
import '../viewmodels/notification_preferences_viewmodel.dart';

class NotificationSettingsView extends ConsumerWidget {
  const NotificationSettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferencesState =
        ref.watch(notificationPreferencesViewModelProvider);
    final preferencesNotifier =
        ref.read(notificationPreferencesViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.surfaceLight,
        elevation: 0,
        iconTheme: const IconThemeData(color: BauhausDesign.textDark),
        title: Text(
          'Notification Settings',
          style: BauhausDesign.getTextTheme(context).headlineLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: BauhausDesign.textDark,
              ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(height: 2, color: BauhausDesign.textDark),
        ),
      ),
      body: preferencesState.when(
        data: (preferences) => _buildSettings(context, ref, preferences),
        loading: () => const BauhausLoadingState(showMessage: true),
        error: (error, stack) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BauhausErrorState(
                title: 'Unable to load notification settings',
                description: error.toString(),
                onRetry: () =>
                    ref.refresh(notificationPreferencesViewModelProvider),
              ),
              const SizedBox(height: BauhausDesign.space4),
              BauhausActionButton(
                text: 'Retry',
                onPressed: () =>
                    ref.refresh(notificationPreferencesViewModelProvider),
                variant: BauhausActionVariant.primary,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: preferencesState.when(
        data: (_) => SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              BauhausDesign.space4,
              BauhausDesign.space2,
              BauhausDesign.space4,
              BauhausDesign.space4,
            ),
            child: BauhausActionButton(
              text: preferencesNotifier.isSaving
                  ? 'SAVING...'
                  : preferencesNotifier.hasUnsavedChanges
                      ? 'SAVE / UPDATE SETTINGS'
                      : 'ALL CHANGES SAVED',
              onPressed: (!preferencesNotifier.hasUnsavedChanges ||
                      preferencesNotifier.isSaving)
                  ? null
                  : () async {
                      final success =
                          await preferencesNotifier.savePreferences();
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            success
                                ? 'Notification settings saved.'
                                : (preferencesNotifier.saveError ??
                                    'Failed to save notification settings.'),
                          ),
                          backgroundColor: success
                              ? BauhausDesign.success
                              : BauhausDesign.error,
                        ),
                      );
                    },
              variant: BauhausActionVariant.primary,
              isFullWidth: true,
            ),
          ),
        ),
        loading: () => null,
        error: (_, __) => null,
      ),
    );
  }

  Widget _buildSettings(
    BuildContext context,
    WidgetRef ref,
    NotificationPreferences preferences,
  ) {
    return ListView(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      children: [
        _buildSectionHeader(context, 'Notification Categories'),
        _buildCategorySettings(context, ref, preferences),
        const SizedBox(height: BauhausDesign.space6),
        _buildSectionHeader(context, 'Quiet Hours'),
        _buildQuietHoursSettings(context, ref, preferences),
        const SizedBox(height: BauhausDesign.space6),
        _buildSectionHeader(context, 'Geofence Settings'),
        _buildGeofenceSettings(context, ref, preferences),
        const SizedBox(height: BauhausDesign.space6),
        _buildSectionHeader(context, 'Smart Features'),
        _buildSmartFeatures(context, ref, preferences),
        const SizedBox(height: BauhausDesign.space6),
        _buildSectionHeader(context, 'Notification Behavior'),
        _buildBehaviorSettings(context, ref, preferences),
        const SizedBox(height: BauhausDesign.space4),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: BauhausDesign.space3),
      child: Text(
        title,
        style: BauhausDesign.getTextTheme(context).headlineMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: BauhausDesign.textDark,
            ),
      ),
    );
  }

  Widget _buildCategorySettings(
    BuildContext context,
    WidgetRef ref,
    NotificationPreferences preferences,
  ) {
    return BauhausCard(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        children: NotificationCategory.values.map((category) {
          final isEnabled = preferences.categoryEnabled[category] ?? true;
          final channels = preferences.categoryChannels[category] ?? [];

          return Container(
            margin: const EdgeInsets.only(bottom: BauhausDesign.space3),
            padding: const EdgeInsets.all(BauhausDesign.space3),
            decoration: BoxDecoration(
              border: Border.all(color: BauhausDesign.neutral, width: 1.5),
              color: BauhausDesign.surfaceLight,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _buildIconBadge(
                      icon: _getCategoryIcon(category),
                      color: isEnabled
                          ? BauhausDesign.secondary
                          : BauhausDesign.textMuted,
                    ),
                    const SizedBox(width: BauhausDesign.space3),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getCategoryName(category),
                            style: BauhausDesign.getTextTheme(context)
                                .labelLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: BauhausDesign.textDark,
                                ),
                          ),
                          const SizedBox(height: BauhausDesign.space1),
                          Text(
                            isEnabled
                                ? '${channels.length} channel(s) enabled'
                                : 'Disabled',
                            style: BauhausDesign.getTextTheme(context)
                                .bodySmall
                                ?.copyWith(
                                  color: BauhausDesign.textMuted,
                                ),
                          ),
                        ],
                      ),
                    ),
                    BauhausSwitch(
                      value: isEnabled,
                      variant: BauhausSwitchVariant.secondary,
                      onChanged: (value) {
                        ref
                            .read(notificationPreferencesViewModelProvider
                                .notifier)
                            .toggleCategory(category, value);
                      },
                    ),
                  ],
                ),
                if (isEnabled) ...[
                  const SizedBox(height: BauhausDesign.space3),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: BauhausDesign.neutral,
                  ),
                  const SizedBox(height: BauhausDesign.space3),
                  Text(
                    'Delivery Channels',
                    style: BauhausDesign.getTextTheme(context)
                        .labelLarge
                        ?.copyWith(
                          color: BauhausDesign.textDark,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: BauhausDesign.space2),
                  ...NotificationChannel.values.map((channel) {
                    final isChannelEnabled = channels.contains(channel);
                    return _buildCheckboxRow(
                      context: context,
                      label: _getChannelName(channel),
                      value: isChannelEnabled,
                      onChanged: (value) {
                        ref
                            .read(notificationPreferencesViewModelProvider
                                .notifier)
                            .toggleChannel(category, channel, value ?? false);
                      },
                    );
                  }),
                ],
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildQuietHoursSettings(
    BuildContext context,
    WidgetRef ref,
    NotificationPreferences preferences,
  ) {
    final quietHours = preferences.quietHours;

    return BauhausCard(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildToggleRow(
            context: context,
            title: 'Enable Quiet Hours',
            subtitle: 'Silence non-urgent notifications',
            value: quietHours.enabled,
            icon: Icons.bedtime_outlined,
            variant: BauhausSwitchVariant.secondary,
            onChanged: (value) {
              ref
                  .read(notificationPreferencesViewModelProvider.notifier)
                  .updateQuietHours(quietHours.copyWith(enabled: value));
            },
          ),
          if (quietHours.enabled) ...[
            const SizedBox(height: BauhausDesign.space3),
            _buildActionRow(
              context: context,
              icon: Icons.schedule,
              label: 'Start Time',
              value: quietHours.startTime,
              onTap: () => _selectTime(
                context,
                ref,
                quietHours.startTime,
                (time) => ref
                    .read(notificationPreferencesViewModelProvider.notifier)
                    .updateQuietHours(quietHours.copyWith(startTime: time)),
              ),
            ),
            const SizedBox(height: BauhausDesign.space2),
            _buildActionRow(
              context: context,
              icon: Icons.wb_sunny_outlined,
              label: 'End Time',
              value: quietHours.endTime,
              onTap: () => _selectTime(
                context,
                ref,
                quietHours.endTime,
                (time) => ref
                    .read(notificationPreferencesViewModelProvider.notifier)
                    .updateQuietHours(quietHours.copyWith(endTime: time)),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildGeofenceSettings(
    BuildContext context,
    WidgetRef ref,
    NotificationPreferences preferences,
  ) {
    return BauhausCard(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        children: [
          _buildToggleRow(
            context: context,
            title: 'Geofence Notifications',
            subtitle: 'Get notified when workers arrive or depart',
            value: preferences.geofenceEnabled,
            icon: Icons.location_on_outlined,
            variant: BauhausSwitchVariant.primary,
            onChanged: (value) {
              ref
                  .read(notificationPreferencesViewModelProvider.notifier)
                  .updateGeofenceEnabled(value);
            },
          ),
          if (preferences.geofenceEnabled) ...[
            const SizedBox(height: BauhausDesign.space3),
            Container(
              padding: const EdgeInsets.all(BauhausDesign.space3),
              decoration: BoxDecoration(
                border: Border.all(color: BauhausDesign.neutral, width: 1.5),
                color: BauhausDesign.backgroundLight,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildIconBadge(
                        icon: Icons.radar_outlined,
                        color: BauhausDesign.secondary,
                      ),
                      const SizedBox(width: BauhausDesign.space3),
                      Expanded(
                        child: Text(
                          'Geofence Radius',
                          style: BauhausDesign.getTextTheme(context)
                              .labelLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: BauhausDesign.textDark,
                              ),
                        ),
                      ),
                      Text(
                        '${preferences.geofenceRadiusKm.toStringAsFixed(1)} km',
                        style: BauhausDesign.getTextTheme(context)
                            .labelLarge
                            ?.copyWith(
                              color: BauhausDesign.textDark,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: BauhausDesign.space2),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 8,
                      thumbShape:
                          const RoundSliderThumbShape(enabledThumbRadius: 10),
                      activeTrackColor: BauhausDesign.secondary,
                      inactiveTrackColor:
                          BauhausDesign.neutral.withOpacity(0.2),
                      thumbColor: BauhausDesign.accent,
                      overlayShape: SliderComponentShape.noOverlay,
                    ),
                    child: Slider(
                      value: preferences.geofenceRadiusKm,
                      min: 0.1,
                      max: 10.0,
                      divisions: 99,
                      onChanged: (value) {
                        ref
                            .read(notificationPreferencesViewModelProvider
                                .notifier)
                            .updateGeofenceRadius(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSmartFeatures(
    BuildContext context,
    WidgetRef ref,
    NotificationPreferences preferences,
  ) {
    return BauhausCard(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: _buildToggleRow(
        context: context,
        title: 'Smart Timing',
        subtitle: 'Optimize notification delivery times',
        value: preferences.smartTimingEnabled,
        icon: Icons.psychology_outlined,
        variant: BauhausSwitchVariant.primary,
        onChanged: (value) {
          ref
              .read(notificationPreferencesViewModelProvider.notifier)
              .updateSmartTiming(value);
        },
      ),
    );
  }

  Widget _buildBehaviorSettings(
    BuildContext context,
    WidgetRef ref,
    NotificationPreferences preferences,
  ) {
    return BauhausCard(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        children: [
          _buildToggleRow(
            context: context,
            title: 'Sound',
            value: preferences.soundEnabled,
            icon: Icons.volume_up_outlined,
            variant: BauhausSwitchVariant.secondary,
            onChanged: (value) {
              ref
                  .read(notificationPreferencesViewModelProvider.notifier)
                  .updateSound(value);
            },
          ),
          const SizedBox(height: BauhausDesign.space2),
          _buildToggleRow(
            context: context,
            title: 'Vibration',
            value: preferences.vibrationEnabled,
            icon: Icons.vibration_outlined,
            variant: BauhausSwitchVariant.secondary,
            onChanged: (value) {
              ref
                  .read(notificationPreferencesViewModelProvider.notifier)
                  .updateVibration(value);
            },
          ),
          const SizedBox(height: BauhausDesign.space2),
          _buildToggleRow(
            context: context,
            title: 'Badge',
            subtitle: 'Show unread count on app icon',
            value: preferences.badgeEnabled,
            icon: Icons.circle_notifications_outlined,
            variant: BauhausSwitchVariant.secondary,
            onChanged: (value) {
              ref
                  .read(notificationPreferencesViewModelProvider.notifier)
                  .updateBadge(value);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildIconBadge({required IconData icon, required Color color}) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        border: Border.all(color: color, width: 2),
      ),
      child: Icon(icon, size: 18, color: color),
    );
  }

  Widget _buildToggleRow({
    required BuildContext context,
    required String title,
    String? subtitle,
    required bool value,
    required IconData icon,
    required BauhausSwitchVariant variant,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        border: Border.all(color: BauhausDesign.neutral, width: 1.5),
        color: BauhausDesign.surfaceLight,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIconBadge(icon: icon, color: BauhausDesign.secondary),
          const SizedBox(width: BauhausDesign.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                      BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: BauhausDesign.textDark,
                          ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: BauhausDesign.space1),
                  Text(
                    subtitle,
                    style: BauhausDesign.getTextTheme(context)
                        .bodySmall
                        ?.copyWith(color: BauhausDesign.textMuted),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: BauhausDesign.space2),
          BauhausSwitch(
            value: value,
            variant: variant,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildActionRow({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(BauhausDesign.space3),
        decoration: BoxDecoration(
          border: Border.all(color: BauhausDesign.neutral, width: 1.5),
          color: BauhausDesign.surfaceLight,
        ),
        child: Row(
          children: [
            _buildIconBadge(icon: icon, color: BauhausDesign.primary),
            const SizedBox(width: BauhausDesign.space3),
            Expanded(
              child: Text(
                label,
                style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                      color: BauhausDesign.textDark,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            Text(
              value,
              style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(width: BauhausDesign.space2),
            const Icon(Icons.chevron_right, color: BauhausDesign.textDark),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckboxRow({
    required BuildContext context,
    required String label,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: BauhausDesign.space1),
      child: Row(
        children: [
          BauhausCheckbox(value: value, onChanged: onChanged),
          const SizedBox(width: BauhausDesign.space2),
          Expanded(
            child: Text(
              label,
              style: BauhausDesign.getTextTheme(context)
                  .bodyMedium
                  ?.copyWith(color: BauhausDesign.textDark),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectTime(
    BuildContext context,
    WidgetRef ref,
    String currentTime,
    Function(String) onTimeSelected,
  ) async {
    final parts = currentTime.split(':');
    final initialTime = TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );

    final selectedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (selectedTime != null) {
      final timeString =
          '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}';
      onTimeSelected(timeString);
    }
  }

  IconData _getCategoryIcon(NotificationCategory category) {
    switch (category) {
      case NotificationCategory.shiftChanges:
        return Icons.schedule;
      case NotificationCategory.geofence:
        return Icons.location_on;
      case NotificationCategory.compliance:
        return Icons.verified_user;
      case NotificationCategory.approvals:
        return Icons.check_circle;
      case NotificationCategory.messages:
        return Icons.message;
      case NotificationCategory.payments:
        return Icons.payment;
      case NotificationCategory.system:
        return Icons.settings;
    }
  }

  String _getCategoryName(NotificationCategory category) {
    switch (category) {
      case NotificationCategory.shiftChanges:
        return 'Shift Changes';
      case NotificationCategory.geofence:
        return 'Location Updates';
      case NotificationCategory.compliance:
        return 'Compliance Alerts';
      case NotificationCategory.approvals:
        return 'Approvals';
      case NotificationCategory.messages:
        return 'Messages';
      case NotificationCategory.payments:
        return 'Payments';
      case NotificationCategory.system:
        return 'System';
    }
  }

  String _getChannelName(NotificationChannel channel) {
    switch (channel) {
      case NotificationChannel.push:
        return 'Push Notification';
      case NotificationChannel.sms:
        return 'SMS';
      case NotificationChannel.email:
        return 'Email';
    }
  }
}
