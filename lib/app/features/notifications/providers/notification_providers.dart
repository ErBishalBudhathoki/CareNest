import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/notifications/viewmodels/notification_settings_viewmodel.dart';
import 'package:carenest/app/features/notifications/viewmodels/geofence_viewmodel.dart';
import 'package:carenest/app/features/notifications/viewmodels/notification_history_viewmodel.dart';

// Re-export repository provider for convenience
export 'package:carenest/app/features/notifications/repositories/notification_repository.dart'
    show notificationRepositoryProvider;

final notificationSettingsViewModelProvider =
    NotifierProvider<NotificationSettingsViewModel, NotificationSettingsState>(
      NotificationSettingsViewModel.new,
    );

final geofenceViewModelProvider =
    NotifierProvider<GeofenceViewModel, GeofenceState>(GeofenceViewModel.new);

final notificationHistoryViewModelProvider =
    NotifierProvider<NotificationHistoryViewModel, NotificationHistoryState>(
      NotificationHistoryViewModel.new,
    );
