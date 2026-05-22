import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:carenest/app/features/notifications/repositories/notification_repository.dart';
import 'package:carenest/app/features/notifications/viewmodels/notification_settings_viewmodel.dart';
import 'package:carenest/app/features/notifications/viewmodels/geofence_viewmodel.dart';
import 'package:carenest/app/features/notifications/viewmodels/notification_history_viewmodel.dart';

// Re-export repository provider for convenience
export 'package:carenest/app/features/notifications/repositories/notification_repository.dart' show notificationRepositoryProvider;

final notificationSettingsViewModelProvider = ChangeNotifierProvider<NotificationSettingsViewModel>((ref) {
  final repository = ref.watch(notificationRepositoryProvider);
  return NotificationSettingsViewModel(repository);
});

final geofenceViewModelProvider = ChangeNotifierProvider<GeofenceViewModel>((ref) {
  final repository = ref.watch(notificationRepositoryProvider);
  return GeofenceViewModel(repository);
});

final notificationHistoryViewModelProvider = ChangeNotifierProvider<NotificationHistoryViewModel>((ref) {
  final repository = ref.watch(notificationRepositoryProvider);
  return NotificationHistoryViewModel(repository);
});
