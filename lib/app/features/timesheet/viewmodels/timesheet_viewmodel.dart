import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/timesheet/models/timesheet_model.dart';
import 'package:carenest/app/features/timesheet/repositories/timesheet_repository.dart';
import 'package:carenest/app/features/timesheet/services/timesheet_pdf_service.dart';

class TimesheetDateNotifier extends Notifier<DateTime> {
  @override
  DateTime build() {
    // Start on Monday of the current week at 00:00 local time.
    final now = DateTime.now();
    final monday = now.subtract(Duration(days: now.weekday - 1));
    return DateTime(monday.year, monday.month, monday.day);
  }

  void setDate(DateTime date) {
    state = date;
  }
}

final timesheetDateProvider = NotifierProvider<TimesheetDateNotifier, DateTime>(
  () {
    return TimesheetDateNotifier();
  },
);

final timesheetViewModelProvider =
    AsyncNotifierProvider.family<
      TimesheetViewModel,
      List<TimesheetEntry>,
      String
    >((email) {
      return TimesheetViewModel(email);
    });

class TimesheetViewModel extends AsyncNotifier<List<TimesheetEntry>> {
  late final TimesheetRepository _repository;
  final String _email;
  late final DateTime _startDate;

  TimesheetViewModel(this._email);

  @override
  FutureOr<List<TimesheetEntry>> build() {
    _repository = ref.watch(timesheetRepositoryProvider);
    _startDate = ref.watch(timesheetDateProvider);
    final endDate = _startDate.add(const Duration(days: 6));
    return _repository.fetchTimesheets(
      email: _email,
      startDate: _startDate,
      endDate: endDate,
    );
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
          final h = int.tryParse(parts[0]) ?? 0;
          final m = int.tryParse(parts[1]) ?? 0;
          final s = int.tryParse(parts[2]) ?? 0;
          totalSeconds += (h * 3600) + (m * 60) + s;
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
            totalHours: weeklyTotal,
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
