import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/notifications/providers/notification_providers.dart';
import 'package:carenest/app/shared/widgets/app_bar_widget.dart';
import 'package:carenest/app/shared/widgets/bauhaus_switch.dart';
import 'package:carenest/app/shared/widgets/loading_indicator.dart';

class NotificationSettingsView extends ConsumerStatefulWidget {
  const NotificationSettingsView({super.key});

  @override
  ConsumerState<NotificationSettingsView> createState() => _NotificationSettingsViewState();
}

class _NotificationSettingsViewState extends ConsumerState<NotificationSettingsView> {
  @override
  void initState() {
    super.initState();
    // Load settings when the view initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notificationSettingsViewModelProvider).loadSettings();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(notificationSettingsViewModelProvider);
    final settings = viewModel.settings;

    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Notification Settings',
        showBackButton: true,
      ),
      body: viewModel.isLoading
          ? const Center(child: LoadingIndicator())
          : settings == null
              ? _buildErrorState(viewModel)
              : RefreshIndicator(
                  onRefresh: viewModel.loadSettings,
                  child: ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      _buildFeatureSettings(viewModel, settings),
                      const SizedBox(height: 24),
                      _buildQuietHoursSettings(context, viewModel, settings),
                    ],
                  ),
                ),
    );
  }

  Widget _buildErrorState(dynamic viewModel) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            viewModel.errorMessage ?? 'Failed to load settings',
            style: const TextStyle(color: Colors.red),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: viewModel.loadSettings,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureSettings(dynamic viewModel, dynamic settings) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notification Types',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildSwitchRow(
              'Shift Reminders',
              'Get notified about upcoming shifts',
              settings.shiftRemindersEnabled,
              (val) => viewModel.toggleShiftReminders(val),
            ),
            const Divider(),
            _buildSwitchRow(
              'Geofence Alerts',
              'Alerts when entering/exiting client locations',
              settings.geofenceEnabled,
              (val) => viewModel.toggleGeofenceReminders(val),
            ),
            const Divider(),
            _buildSwitchRow(
              'Expense Reminders',
              'Reminders to submit expenses',
              settings.expenseRemindersEnabled,
              (val) => viewModel.toggleExpenseReminders(val),
            ),
            const Divider(),
            _buildSwitchRow(
              'Timesheet Reminders',
              'Daily reminders to submit timesheets',
              settings.timesheetRemindersEnabled,
              (val) => viewModel.toggleTimesheetReminders(val),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchRow(String title, String subtitle, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          BauhausSwitch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildQuietHoursSettings(BuildContext context, dynamic viewModel, dynamic settings) {
    final start = settings.quietHours?.start ?? '22:00';
    final end = settings.quietHours?.end ?? '07:00';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quiet Hours',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Notifications will be muted during this time.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => _selectTime(context, start, (time) {
                      viewModel.updateQuietHours(time, end);
                    }),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Start Time',
                        border: OutlineInputBorder(),
                      ),
                      child: Text(start),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: InkWell(
                    onTap: () => _selectTime(context, end, (time) {
                      viewModel.updateQuietHours(start, time);
                    }),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'End Time',
                        border: OutlineInputBorder(),
                      ),
                      child: Text(end),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context, String currentTime, Function(String) onSelected) async {
    final parts = currentTime.split(':');
    final initialTime = TimeOfDay(
      hour: int.tryParse(parts[0]) ?? 0, 
      minute: int.tryParse(parts[1]) ?? 0
    );

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (picked != null) {
      final formattedTime = '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      onSelected(formattedTime);
    }
  }
}
