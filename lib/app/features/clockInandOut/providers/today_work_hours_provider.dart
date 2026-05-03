import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/timesheet/viewmodels/timesheet_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

/// Returns today's total work hours as a double (e.g. 4.8).
///
/// Combines completed timesheet entries for today with the currently
/// running timer's elapsed seconds. Reacts to changes in both sources.
final todayWorkHoursProvider =
    FutureProvider.family.autoDispose<double, String>((ref, email) async {
  final timesheetState = ref.watch(timesheetViewModelProvider(email));
  final timerService = ref.watch(timerServiceProvider);

  double totalSeconds = 0;

  // Sum completed timesheet entries for today
  timesheetState.whenData((entries) {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    for (final entry in entries) {
      if (entry.shiftDate == today) {
        totalSeconds += _parseTimeWorkedToSeconds(entry.timeWorked);
      }
    }
  });

  // Add active timer seconds if currently running
  if (timerService.isRunning) {
    totalSeconds += timerService.elapsedSeconds;
  }

  return totalSeconds / 3600.0;
});

int _parseTimeWorkedToSeconds(String? timeWorked) {
  if (timeWorked == null) return 0;
  final parts = timeWorked.split(':');
  if (parts.length != 3) return 0;
  final h = int.tryParse(parts[0]) ?? 0;
  final m = int.tryParse(parts[1]) ?? 0;
  final s = int.tryParse(parts[2]) ?? 0;
  return h * 3600 + m * 60 + s;
}
