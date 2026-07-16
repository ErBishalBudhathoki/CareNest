import 'package:carenest/app/features/home/models/home_dashboard_data.dart';
import 'package:carenest/app/features/home/repositories/home_repository.dart';
import 'package:carenest/app/core/services/timer_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for HomeViewModel
final homeViewModelProvider =
    AsyncNotifierProvider<HomeViewModel, HomeDashboardData>(HomeViewModel.new);

/// Home View Model
///
/// Manages the state of the Employee Home View dashboard.
class HomeViewModel extends AsyncNotifier<HomeDashboardData> {
  late final HomeRepository _repository;

  @override
  Future<HomeDashboardData> build() async {
    _repository = ref.watch(homeRepositoryProvider);
    // Don't auto-load, let the initialization happen via return
    // Wait, the original code doesn't load immediately in constructor.
    // Wait, actually I should check if it needs manual load or just returns
    return const HomeDashboardData(
      upcomingAppointments: [],
      activeBroadcasts: [],
    ); // Placeholder, will fix next
  }

  /// Load home dashboard data
  Future<void> loadDashboard(String email) async {
    state = const AsyncLoading();
    try {
      final data = await _repository.getHomeDashboardData(email);
      state = AsyncData(data);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// Refresh dashboard data silently (full reload)
  Future<void> refreshSilently(String email) async {
    try {
      final data = await _repository.getHomeDashboardData(email);
      state = AsyncData(data);
    } catch (e) {
      // Keep previous state on silent error
      debugPrint('Silent refresh error: $e');
    }
  }

  /// Poll only the active broadcasts and merge into the current state.
  ///
  /// Called every 15 seconds by a timer in [EmployeeHomeView] so employees
  /// see emergency alerts immediately without a manual pull-to-refresh.
  /// Preserves existing appointment data so the UI does not flicker.
  Future<void> pollBroadcasts() async {
    try {
      final freshBroadcasts = await _repository.getActiveBroadcasts();

      final current = state.value;
      if (current == null) return;

      // Skip rebuild when the broadcast list has not changed.
      final currentIds = current.activeBroadcasts.map((b) => b.id).toSet();
      final freshIds = freshBroadcasts.map((b) => b.id).toSet();
      if (currentIds.length == freshIds.length &&
          currentIds.containsAll(freshIds)) {
        return;
      }

      state = AsyncData(current.copyWith(activeBroadcasts: freshBroadcasts));
    } catch (e) {
      // Swallow polling errors silently – they should never disrupt the UI.
      debugPrint('pollBroadcasts error: $e');
    }
  }

  /// Acknowledge a broadcast then silently refresh so the banner disappears.
  Future<void> acknowledgeBroadcast(String email, String broadcastId) async {
    try {
      await _repository.acknowledgeBroadcast(broadcastId);
      await refreshSilently(email);
    } catch (e) {
      rethrow;
    }
  }

  /// Recompute `_shiftStatus` for all upcoming appointments based on current
  /// time and timer state. Called periodically so badges update in real time.
  void recomputeShiftStatuses() {
    final current = state.value;
    if (current == null) return;

    final now = DateTime.now();
    var changed = false;

    final updatedAppointments = current.upcomingAppointments.map((appt) {
      final scheduleList = appt['schedule'] as List?;
      if (scheduleList == null || scheduleList.isEmpty) return appt;

      final schedule = scheduleList[0] as Map<String, dynamic>;
      final shiftStart = _parseScheduleDateTime(
        schedule['date']?.toString(),
        schedule['startTime']?.toString(),
      );
      var shiftEnd = _parseScheduleDateTime(
        schedule['date']?.toString(),
        schedule['endTime']?.toString(),
      );

      // Handle cross-midnight shifts: if end is before start, add a day
      if (shiftEnd != null &&
          shiftStart != null &&
          shiftEnd.isBefore(shiftStart)) {
        shiftEnd = shiftEnd.add(const Duration(days: 1));
      }

      String? newStatus;

      if (shiftStart != null && shiftStart.isBefore(now)) {
        final effectiveEnd =
            shiftEnd ?? shiftStart.add(const Duration(hours: 4));

        final clientEmail = appt['clientEmail']?.toString();
        final timerRunning =
            TimerService.instance.isRunning &&
            clientEmail != null &&
            TimerService.instance.timerClientEmail == clientEmail;

        if (effectiveEnd.isAfter(now)) {
          newStatus = 'in_progress';
        } else if (timerRunning) {
          newStatus = 'overtime';
        } else {
          newStatus = 'overdue';
        }
      }

      if (newStatus != appt['_shiftStatus']?.toString()) {
        changed = true;
        final copy = Map<String, dynamic>.from(appt);
        if (newStatus != null) {
          copy['_shiftStatus'] = newStatus;
        } else {
          copy.remove('_shiftStatus');
        }
        return copy;
      }
      return appt;
    }).toList();

    if (changed) {
      state = AsyncData(
        current.copyWith(upcomingAppointments: updatedAppointments),
      );
    }
  }

  DateTime? _parseScheduleDateTime(String? dateStr, String? timeStr) {
    if (dateStr == null || timeStr == null) return null;
    try {
      DateTime parsedDate;
      if (dateStr.contains('-')) {
        parsedDate = DateTime.parse(dateStr);
      } else if (dateStr.contains('/')) {
        final parts = dateStr.split('/');
        if (parts.length == 3) {
          parsedDate = DateTime(
            int.parse(parts[2]),
            int.parse(parts[0]),
            int.parse(parts[1]),
          );
        } else {
          return null;
        }
      } else {
        return null;
      }

      final timeParts = timeStr.split(':');
      if (timeParts.length >= 2) {
        int hour = int.parse(timeParts[0].trim());
        final minutePart = timeParts[1].replaceAll(RegExp(r'[^0-9]'), '');
        int minute = minutePart.isNotEmpty ? int.parse(minutePart) : 0;

        if (timeStr.toUpperCase().contains('PM') && hour != 12) hour += 12;
        if (timeStr.toUpperCase().contains('AM') && hour == 12) hour = 0;

        return DateTime(
          parsedDate.year,
          parsedDate.month,
          parsedDate.day,
          hour,
          minute,
        );
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
