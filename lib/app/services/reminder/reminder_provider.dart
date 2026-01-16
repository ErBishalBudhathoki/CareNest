import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/services/reminder/reminder_scheduler_service.dart';

/// Provider for the ReminderSchedulerService singleton.
final reminderSchedulerProvider = Provider<ReminderSchedulerService>((ref) {
  return ReminderSchedulerService();
});

/// Provider to initialize the reminder scheduler on app startup.
final reminderSchedulerInitializerProvider = FutureProvider<void>((ref) async {
  final scheduler = ref.read(reminderSchedulerProvider);
  await scheduler.initialize();
});
