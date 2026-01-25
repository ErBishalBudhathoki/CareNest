
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/ai_providers.dart';
import '../models/ai_models.dart';

class SmartNotificationDashboard extends ConsumerStatefulWidget {
  const SmartNotificationDashboard({super.key});

  @override
  ConsumerState<SmartNotificationDashboard> createState() => _SmartNotificationDashboardState();
}

class _SmartNotificationDashboardState extends ConsumerState<SmartNotificationDashboard> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(aiViewModelProvider).loadPredictions();
      ref.read(aiViewModelProvider).loadCalendarEvents();
      ref.read(aiViewModelProvider).loadSnoozeRules();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Notifications'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'AI Predictions'),
            Tab(text: 'Calendar'),
            Tab(text: 'Snooze Rules'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          AiPredictionsTab(),
          CalendarEventsTab(),
          SnoozeRulesTab(),
        ],
      ),
    );
  }
}

class AiPredictionsTab extends ConsumerWidget {
  const AiPredictionsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(aiViewModelProvider);

    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.predictions.isEmpty) {
      return const Center(child: Text('No predictions available yet.'));
    }

    return ListView.builder(
      itemCount: viewModel.predictions.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final prediction = viewModel.predictions[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: const Icon(Icons.psychology),
            title: Text('Optimal Time for ${prediction.notificationType}'),
            subtitle: Text('Predicted Hour: ${prediction.predictedHour}:00'),
            trailing: Chip(
              label: Text('${(prediction.confidenceScore * 100).toInt()}% Conf'),
              backgroundColor: Colors.blue.withOpacity(0.1),
            ),
          ),
        );
      },
    );
  }
}

class CalendarEventsTab extends ConsumerWidget {
  const CalendarEventsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(aiViewModelProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              ElevatedButton.icon(
                onPressed: () => ref.read(aiViewModelProvider).syncCalendar('google'),
                icon: const Icon(Icons.sync),
                label: const Text('Sync Google'),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () => ref.read(aiViewModelProvider).syncCalendar('outlook'),
                icon: const Icon(Icons.sync),
                label: const Text('Sync Outlook'),
              ),
            ],
          ),
        ),
        if (viewModel.isLoading)
          const LinearProgressIndicator(),
        Expanded(
          child: ListView.builder(
            itemCount: viewModel.calendarEvents.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final event = viewModel.calendarEvents[index];
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.event),
                  title: Text(event.title),
                  subtitle: Text('${event.startTime.toLocal()}'),
                  trailing: Text(event.status),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class SnoozeRulesTab extends ConsumerWidget {
  const SnoozeRulesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(aiViewModelProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show dialog to create rule
          _showCreateRuleDialog(context, ref);
        },
        child: const Icon(Icons.add),
      ),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: viewModel.snoozeRules.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final rule = viewModel.snoozeRules[index];
                return Card(
                  child: ListTile(
                    title: Text(rule.keyword ?? 'Sender: ${rule.sender}'),
                    subtitle: Text('Snooze: ${rule.snoozeDurationMinutes} mins'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                         if (rule.id != null) {
                            ref.read(aiViewModelProvider).deleteSnoozeRule(rule.id!);
                         }
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _showCreateRuleDialog(BuildContext context, WidgetRef ref) {
    final keywordController = TextEditingController();
    final durationController = TextEditingController(text: '60');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Snooze Rule'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: keywordController,
              decoration: const InputDecoration(labelText: 'Keyword'),
            ),
            TextField(
              controller: durationController,
              decoration: const InputDecoration(labelText: 'Duration (minutes)'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final rule = SnoozeRule(
                userId: 'current-user', // In real app, get from auth provider
                keyword: keywordController.text,
                snoozeDurationMinutes: int.tryParse(durationController.text) ?? 60,
              );
              ref.read(aiViewModelProvider).createSnoozeRule(rule);
              Navigator.pop(context);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}
