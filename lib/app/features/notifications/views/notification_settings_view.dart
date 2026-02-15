import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/notification_preferences.dart';
import '../viewmodels/notification_preferences_viewmodel.dart';
import 'package:carenest/app/shared/theme/bauhaus_colors.dart';

class NotificationSettingsView extends ConsumerWidget {
  const NotificationSettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferencesState = ref.watch(notificationPreferencesViewModelProvider);

    return Scaffold(
      backgroundColor: BauhausColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausColors.primaryRed,
        title: const Text(
          'Notification Settings',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: preferencesState.when(
        data: (preferences) => _buildSettings(context, ref, preferences),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error loading preferences: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(notificationPreferencesViewModelProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettings(
    BuildContext context,
    WidgetRef ref,
    NotificationPreferences preferences,
  ) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionHeader('Notification Categories'),
        _buildCategorySettings(context, ref, preferences),
        const SizedBox(height: 24),
        _buildSectionHeader('Quiet Hours'),
        _buildQuietHoursSettings(context, ref, preferences),
        const SizedBox(height: 24),
        _buildSectionHeader('Geofence Settings'),
        _buildGeofenceSettings(context, ref, preferences),
        const SizedBox(height: 24),
        _buildSectionHeader('Smart Features'),
        _buildSmartFeatures(context, ref, preferences),
        const SizedBox(height: 24),
        _buildSectionHeader('Notification Behavior'),
        _buildBehaviorSettings(context, ref, preferences),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: BauhausColors.textDark,
        ),
      ),
    );
  }

  Widget _buildCategorySettings(
    BuildContext context,
    WidgetRef ref,
    NotificationPreferences preferences,
  ) {
    return Card(
      child: Column(
        children: NotificationCategory.values.map((category) {
          final isEnabled = preferences.categoryEnabled[category] ?? true;
          final channels = preferences.categoryChannels[category] ?? [];

          return ExpansionTile(
            leading: Icon(
              _getCategoryIcon(category),
              color: isEnabled ? BauhausColors.primaryBlue : Colors.grey,
            ),
            title: Text(_getCategoryName(category)),
            subtitle: Text(
              isEnabled
                  ? '${channels.length} channel(s) enabled'
                  : 'Disabled',
              style: TextStyle(
                color: isEnabled ? BauhausColors.textMedium : Colors.grey,
              ),
            ),
            trailing: Switch(
              value: isEnabled,
              activeColor: BauhausColors.primaryBlue,
              onChanged: (value) {
                ref
                    .read(notificationPreferencesViewModelProvider.notifier)
                    .toggleCategory(category, value);
              },
            ),
            children: [
              if (isEnabled)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Delivery Channels:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ...NotificationChannel.values.map((channel) {
                        final isChannelEnabled = channels.contains(channel);
                        return CheckboxListTile(
                          dense: true,
                          title: Text(_getChannelName(channel)),
                          value: isChannelEnabled,
                          activeColor: BauhausColors.primaryBlue,
                          onChanged: (value) {
                            ref
                                .read(notificationPreferencesViewModelProvider.notifier)
                                .toggleChannel(category, channel, value ?? false);
                          },
                        );
                      }),
                    ],
                  ),
                ),
            ],
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

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: const Text('Enable Quiet Hours'),
              subtitle: const Text('Silence non-urgent notifications'),
              value: quietHours.enabled,
              activeColor: BauhausColors.primaryBlue,
              onChanged: (value) {
                ref
                    .read(notificationPreferencesViewModelProvider.notifier)
                    .updateQuietHours(quietHours.copyWith(enabled: value));
              },
            ),
            if (quietHours.enabled) ...[
              const Divider(),
              ListTile(
                leading: const Icon(Icons.bedtime),
                title: const Text('Start Time'),
                subtitle: Text(quietHours.startTime),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _selectTime(
                  context,
                  ref,
                  quietHours.startTime,
                  (time) => ref
                      .read(notificationPreferencesViewModelProvider.notifier)
                      .updateQuietHours(quietHours.copyWith(startTime: time)),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.wb_sunny),
                title: const Text('End Time'),
                subtitle: Text(quietHours.endTime),
                trailing: const Icon(Icons.chevron_right),
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
      ),
    );
  }

  Widget _buildGeofenceSettings(
    BuildContext context,
    WidgetRef ref,
    NotificationPreferences preferences,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Geofence Notifications'),
              subtitle: const Text('Get notified when workers arrive/depart'),
              value: preferences.geofenceEnabled,
              activeColor: BauhausColors.primaryBlue,
              onChanged: (value) {
                ref
                    .read(notificationPreferencesViewModelProvider.notifier)
                    .updateGeofenceEnabled(value);
              },
            ),
            if (preferences.geofenceEnabled) ...[
              const Divider(),
              ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text('Geofence Radius'),
                subtitle: Text('${preferences.geofenceRadiusKm.toStringAsFixed(1)} km'),
                trailing: SizedBox(
                  width: 200,
                  child: Slider(
                    value: preferences.geofenceRadiusKm,
                    min: 0.1,
                    max: 10.0,
                    divisions: 99,
                    activeColor: BauhausColors.primaryBlue,
                    label: '${preferences.geofenceRadiusKm.toStringAsFixed(1)} km',
                    onChanged: (value) {
                      ref
                          .read(notificationPreferencesViewModelProvider.notifier)
                          .updateGeofenceRadius(value);
                    },
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSmartFeatures(
    BuildContext context,
    WidgetRef ref,
    NotificationPreferences preferences,
  ) {
    return Card(
      child: Column(
        children: [
          SwitchListTile(
            title: const Row(
              children: [
                Icon(Icons.psychology),
                SizedBox(width: 8),
                Text('Smart Timing'),
              ],
            ),
            subtitle: const Text('Optimize notification delivery times'),
            value: preferences.smartTimingEnabled,
            activeColor: BauhausColors.primaryBlue,
            onChanged: (value) {
              ref
                  .read(notificationPreferencesViewModelProvider.notifier)
                  .updateSmartTiming(value);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBehaviorSettings(
    BuildContext context,
    WidgetRef ref,
    NotificationPreferences preferences,
  ) {
    return Card(
      child: Column(
        children: [
          SwitchListTile(
            title: const Row(
              children: [
                Icon(Icons.volume_up),
                SizedBox(width: 8),
                Text('Sound'),
              ],
            ),
            value: preferences.soundEnabled,
            activeColor: BauhausColors.primaryBlue,
            onChanged: (value) {
              ref
                  .read(notificationPreferencesViewModelProvider.notifier)
                  .updateSound(value);
            },
          ),
          SwitchListTile(
            title: const Row(
              children: [
                Icon(Icons.vibration),
                SizedBox(width: 8),
                Text('Vibration'),
              ],
            ),
            value: preferences.vibrationEnabled,
            activeColor: BauhausColors.primaryBlue,
            onChanged: (value) {
              ref
                  .read(notificationPreferencesViewModelProvider.notifier)
                  .updateVibration(value);
            },
          ),
          SwitchListTile(
            title: const Row(
              children: [
                Icon(Icons.circle_notifications),
                SizedBox(width: 8),
                Text('Badge'),
              ],
            ),
            subtitle: const Text('Show unread count on app icon'),
            value: preferences.badgeEnabled,
            activeColor: BauhausColors.primaryBlue,
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
