import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/timesheet/models/timesheet_model.dart';
import 'package:carenest/app/features/timesheet/repositories/timesheet_repository.dart';
import 'package:carenest/app/features/timesheet/services/timesheet_pdf_service.dart';

// Provider for the current week's start date
final timesheetDateProvider = StateProvider<DateTime>((ref) {
  // Start on Monday of the current week (or Sunday depending on locale, let's pick Monday)
  final now = DateTime.now();
  return now.subtract(Duration(days: now.weekday - 1));
});

// Provider for the Timesheet ViewModel
final timesheetViewModelProvider = StateNotifierProvider.family<
    TimesheetViewModel, AsyncValue<List<TimesheetEntry>>, String>((ref, email) {
  final repository = ref.watch(timesheetRepositoryProvider);
  final startDate = ref.watch(timesheetDateProvider);
  return TimesheetViewModel(repository, email, startDate);
});

class TimesheetViewModel
    extends StateNotifier<AsyncValue<List<TimesheetEntry>>> {
  final TimesheetRepository _repository;
  final String _email;
  final DateTime _startDate;

  TimesheetViewModel(this._repository, this._email, this._startDate)
      : super(const AsyncValue.loading()) {
    _fetchTimesheets();
  }

  Future<void> _fetchTimesheets() async {
    state = const AsyncValue.loading();
    try {
      final endDate = _startDate.add(const Duration(days: 6));
      final entries = await _repository.fetchTimesheets(
        email: _email,
        startDate: _startDate,
        endDate: endDate,
      );
      state = AsyncValue.data(entries);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  // Helper to get total hours for the week
  String get weeklyTotal {
    return state.maybeWhen(
      data: (entries) {
        // Simple logic to sum durations "HH:MM:SS" or numbers
        // This is a placeholder for complex duration summing logic
        // Ideally we parse "00:00:12" and sum it up
        return _calculateTotalDuration(entries);
      },
      orElse: () => "00:00",
    );
  }

  String _calculateTotalDuration(List<TimesheetEntry> entries) {
    int totalSeconds = 0;
    for (var entry in entries) {
      if (entry.timeWorked != null) {
        final parts = entry.timeWorked!.split(':');
        if (parts.length == 3) {
          totalSeconds += int.parse(parts[0]) * 3600 +
              int.parse(parts[1]) * 60 +
              int.parse(parts[2]);
        }
      } else if (entry.totalHours != null) {
        // Handle numeric total hours if any
        try {
          final hours = double.parse(entry.totalHours.toString());
          totalSeconds += (hours * 3600).toInt();
        } catch (_) {}
      }
    }

    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }

  Future<String?> exportTimesheet() async {
    return state.maybeWhen(
      data: (entries) async {
        try {
            final endDate = _startDate.add(const Duration(days: 6));
            final service = TimesheetPdfService();
            final path = await service.generateTimesheetPdf(
                entries: entries,
                startDate: _startDate,
                endDate: endDate,
                userEmail: _email,
                totalHours: weeklyTotal
            );
            return path;
        } catch (e) {
            return null;
        }
      },
      orElse: () => null,
    );
  }
}
