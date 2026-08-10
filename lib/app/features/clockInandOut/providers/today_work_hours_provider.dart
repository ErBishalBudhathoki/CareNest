import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/timesheet/viewmodels/timesheet_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Returns today's total work hours as a double (e.g. 4.8).
///
/// Combines completed timesheet entries for today with the currently
/// running timer's elapsed seconds. Reacts to changes in both sources.
final todayWorkHoursProvider = FutureProvider.family
    .autoDispose<double, String>((ref, email) async {

      final entries = ref.watch(timesheetViewModelProvider(email)).value ?? [];
      final timerService = ref.watch(timerServiceProvider);

      final secondsFromEntries = entries.fold<double>(
        0,
        (sum, entry) => sum + _parseTimeWorkedToSeconds(entry.timeWorked),
      );

      final timerSeconds = timerService.isRunning
          ? timerService.elapsedSeconds
          : 0;
      final totalSeconds = secondsFromEntries + timerSeconds;

      return totalSeconds / 3600.0;
    });

/// Parses a timesheet duration string in "HH:mm:ss" format to total seconds.
///
/// Returns 0 for null or malformed input.
int _parseTimeWorkedToSeconds(String? timeWorked) {
  if (timeWorked == null) return 0;
  final parts = timeWorked.split(':');
  if (parts.length != 3) return 0;
  final h = int.tryParse(parts[0]) ?? 0;
  final m = int.tryParse(parts[1]) ?? 0;
  final s = int.tryParse(parts[2]) ?? 0;
  return h * 3600 + m * 60 + s;
}
