import 'dart:math' as math;

import 'package:carenest/app/features/timesheet/models/timesheet_model.dart';
import 'package:carenest/app/features/timesheet/viewmodels/timesheet_viewmodel.dart';
import 'package:carenest/app/features/timesheet/views/timesheet_history_view.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TimesheetView extends ConsumerWidget {
  final String email;

  const TimesheetView({super.key, required this.email});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weekStart = ref.watch(timesheetDateProvider);
    final weekEnd = weekStart.add(const Duration(days: 6));
    final entriesAsync = ref.watch(timesheetViewModelProvider(email));

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppLocalizations.of(context)!.timesheetTitle,
          style: BauhausDesign.getTextTheme(context)
              .titleLarge
              ?.copyWith(color: BauhausDesign.textDark),
        ),
        centerTitle: true,
        backgroundColor: BauhausDesign.surfaceWhite,
        foregroundColor: BauhausDesign.textDark,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: BauhausDesign.neutral),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history_rounded),
            tooltip: AppLocalizations.of(context)!.historyTitle,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TimesheetHistoryView(email: email),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.file_download_outlined),
            tooltip: 'Export',
            onPressed: () async {
              final viewModel =
                  ref.read(timesheetViewModelProvider(email).notifier);
              final path = await viewModel.exportTimesheet();
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(path == null
                      ? 'Failed to export timesheet'
                      : 'Exported timesheet: $path'),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _WeekRangeHeader(
            weekStart: weekStart,
            weekEnd: weekEnd,
            onPreviousWeek: () {
              ref.read(timesheetDateProvider.notifier).state =
                  weekStart.subtract(const Duration(days: 7));
            },
            onNextWeek: () {
              ref.read(timesheetDateProvider.notifier).state =
                  weekStart.add(const Duration(days: 7));
            },
            onThisWeek: () {
              final now = DateTime.now();
              final monday = now.subtract(Duration(days: now.weekday - 1));
              ref.read(timesheetDateProvider.notifier).state =
                  DateTime(monday.year, monday.month, monday.day);
            },
          ),
          Expanded(
            child: entriesAsync.when(
              loading: () => const Center(
                child: CircularProgressIndicator(color: BauhausDesign.primary),
              ),
              error: (error, _) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(BauhausDesign.space6),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppLocalizations.of(context)!
                            .errorFetchingWorkedTime(error.toString()),
                        textAlign: TextAlign.center,
                        style: BauhausDesign.getTextTheme(context)
                            .bodyMedium
                            ?.copyWith(color: BauhausDesign.textDark),
                      ),
                      const SizedBox(height: BauhausDesign.space3),
                      ElevatedButton(
                        onPressed: () {
                          ref.invalidate(timesheetViewModelProvider(email));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: BauhausDesign.backgroundLight,
                          foregroundColor: BauhausDesign.textDark,
                          side: const BorderSide(color: BauhausDesign.neutral),
                        ),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
              data: (entries) => _TimesheetDataBody(
                entries: entries,
                weekStart: weekStart,
                weekEnd: weekEnd,
                onOpenHistory: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TimesheetHistoryView(email: email),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WeekRangeHeader extends StatelessWidget {
  final DateTime weekStart;
  final DateTime weekEnd;
  final VoidCallback onPreviousWeek;
  final VoidCallback onNextWeek;
  final VoidCallback onThisWeek;

  const _WeekRangeHeader({
    required this.weekStart,
    required this.weekEnd,
    required this.onPreviousWeek,
    required this.onNextWeek,
    required this.onThisWeek,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space5,
        vertical: BauhausDesign.space4,
      ),
      color: BauhausDesign.surfaceWhite,
      child: Row(
        children: [
          IconButton(
            onPressed: onPreviousWeek,
            icon: const Icon(Icons.chevron_left, color: BauhausDesign.textDark),
          ),
          Expanded(
            child: Center(
              child: Text(
                '${DateFormat('MMM dd').format(weekStart)} - ${DateFormat('MMM dd, yyyy').format(weekEnd)}',
                style:
                    BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: BauhausDesign.textDark,
                        ),
              ),
            ),
          ),
          IconButton(
            onPressed: onNextWeek,
            icon:
                const Icon(Icons.chevron_right, color: BauhausDesign.textDark),
          ),
          const SizedBox(width: BauhausDesign.space1),
          TextButton(
            onPressed: onThisWeek,
            style:
                TextButton.styleFrom(foregroundColor: BauhausDesign.textDark),
            child: const Text('This Week'),
          ),
        ],
      ),
    );
  }
}

class _TimesheetDataBody extends StatelessWidget {
  final List<TimesheetEntry> entries;
  final DateTime weekStart;
  final DateTime weekEnd;
  final VoidCallback onOpenHistory;

  const _TimesheetDataBody({
    required this.entries,
    required this.weekStart,
    required this.weekEnd,
    required this.onOpenHistory,
  });

  @override
  Widget build(BuildContext context) {
    final days = _buildWeekSummaries(entries, weekStart);
    final weekTotals = _calculateWeekTotals(days);
    final hasAnyWork = days.any((d) => d.totalSeconds > 0);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(BauhausDesign.space6),
      child: Column(
        children: [
          BauhausCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTimeColumn(
                  context,
                  AppLocalizations.of(context)!.regularLabel,
                  _formatHoursMinutes(weekTotals.regularSeconds),
                ),
                _buildTimeColumn(
                  context,
                  AppLocalizations.of(context)!.otLabel,
                  _formatHoursMinutes(weekTotals.overtimeSeconds),
                ),
                _buildTimeColumn(
                  context,
                  AppLocalizations.of(context)!.totalLabel,
                  _formatHoursMinutes(weekTotals.totalSeconds),
                ),
                _buildTimeColumn(
                  context,
                  AppLocalizations.of(context)!.absenceLabel,
                  '${weekTotals.absenceDays}d',
                ),
              ],
            ),
          ),
          const SizedBox(height: BauhausDesign.space4),
          BauhausActionTile(
            title: AppLocalizations.of(context)!.historyTitle,
            icon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: BauhausDesign.backgroundLight,
                borderRadius: BorderRadius.circular(BauhausDesign.radiusPill),
                border: Border.all(color: BauhausDesign.neutral),
              ),
              child: Text(
                '${entries.length}',
                style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                      color: BauhausDesign.textDark,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            onTap: onOpenHistory,
            showChevron: true,
          ),
          const SizedBox(height: BauhausDesign.space2),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: BauhausDesign.space2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.weekTotalLabel(
                      _formatHoursMinutes(weekTotals.totalSeconds)),
                  style:
                      BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                            color: BauhausDesign.textDark,
                          ),
                ),
                TextButton(
                  onPressed: onOpenHistory,
                  child: Text(
                    AppLocalizations.of(context)!.moreLabel,
                    style: BauhausDesign.getTextTheme(context)
                        .labelLarge
                        ?.copyWith(
                          color: BauhausDesign.textDark,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: BauhausDesign.space2),
          if (!hasAnyWork)
            Padding(
              padding: const EdgeInsets.only(bottom: BauhausDesign.space4),
              child: BauhausEmptyState(
                title: AppLocalizations.of(context)!.noHistoryTitle,
                subtitle:
                    'No worked time found for ${DateFormat('MMM dd').format(weekStart)} - ${DateFormat('MMM dd').format(weekEnd)}.',
                icon: Icons.event_busy,
              ),
            ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: days.length,
            separatorBuilder: (_, __) =>
                const SizedBox(height: BauhausDesign.space3),
            itemBuilder: (context, index) => _DayCard(summary: days[index]),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeColumn(BuildContext context, String label, String time) {
    return Column(
      children: [
        Text(
          label,
          style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                color: BauhausDesign.textDark,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          time,
          style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: BauhausDesign.textDark,
              ),
        ),
      ],
    );
  }
}

class _DayCard extends StatelessWidget {
  final _DayTimesheetSummary summary;

  const _DayCard({required this.summary});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final isToday = summary.date.year == today.year &&
        summary.date.month == today.month &&
        summary.date.day == today.day;

    return BauhausCard(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 50,
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color:
                          isToday ? BauhausDesign.primary : Colors.transparent,
                      width: 4,
                    ),
                  ),
                ),
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  children: [
                    Text(
                      DateFormat('dd').format(summary.date),
                      style: BauhausDesign.getTextTheme(context)
                          .headlineSmall
                          ?.copyWith(
                            color: isToday
                                ? BauhausDesign.primary
                                : BauhausDesign.textDark,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      DateFormat('EEE').format(summary.date),
                      style: BauhausDesign.getTextTheme(context)
                          .bodyMedium
                          ?.copyWith(
                            color: isToday
                                ? BauhausDesign.primary
                                : BauhausDesign.textDark,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: BauhausDesign.space4),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTimeDetail(
                      context,
                      AppLocalizations.of(context)!.regularLabel,
                      _formatHoursMinutes(summary.regularSeconds),
                    ),
                    _buildTimeDetail(
                      context,
                      AppLocalizations.of(context)!.otLabel,
                      _formatHoursMinutes(summary.overtimeSeconds),
                    ),
                    _buildTimeDetail(
                      context,
                      AppLocalizations.of(context)!.totalLabel,
                      _formatHoursMinutes(summary.totalSeconds),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (summary.shiftCount > 0) ...[
            const SizedBox(height: BauhausDesign.space3),
            Row(
              children: [
                Icon(Icons.schedule, size: 16, color: BauhausDesign.textDark),
                const SizedBox(width: BauhausDesign.space2),
                Expanded(
                  child: Text(
                    summary.primaryShiftLabel ??
                        '${summary.shiftCount} shift(s) recorded',
                    style: BauhausDesign.getTextTheme(context)
                        .bodySmall
                        ?.copyWith(color: BauhausDesign.textDark),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTimeDetail(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                color: BauhausDesign.textDark,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: BauhausDesign.textDark,
              ),
        ),
      ],
    );
  }
}

class _DayTimesheetSummary {
  final DateTime date;
  int totalSeconds;
  int regularSeconds;
  int overtimeSeconds;
  int shiftCount;
  String? primaryShiftLabel;

  _DayTimesheetSummary({required this.date})
      : totalSeconds = 0,
        regularSeconds = 0,
        overtimeSeconds = 0,
        shiftCount = 0;
}

class _WeekTotals {
  final int totalSeconds;
  final int regularSeconds;
  final int overtimeSeconds;
  final int absenceDays;

  const _WeekTotals({
    required this.totalSeconds,
    required this.regularSeconds,
    required this.overtimeSeconds,
    required this.absenceDays,
  });
}

List<_DayTimesheetSummary> _buildWeekSummaries(
    List<TimesheetEntry> entries, DateTime weekStart) {
  final baseStart = DateTime(weekStart.year, weekStart.month, weekStart.day);
  final summaries = List.generate(
    7,
    (index) => _DayTimesheetSummary(
      date: baseStart.add(Duration(days: index)),
    ),
  );

  for (final entry in entries) {
    final entryDate = _entryDate(entry);
    if (entryDate == null) continue;

    final normalized = DateTime(entryDate.year, entryDate.month, entryDate.day);
    final dayDiff = normalized.difference(baseStart).inDays;
    if (dayDiff < 0 || dayDiff > 6) continue;

    final day = summaries[dayDiff];
    final seconds = _entryDurationSeconds(entry);
    day.totalSeconds += seconds;
    day.shiftCount += 1;

    if (day.primaryShiftLabel == null) {
      final start = entry.shiftStartTime?.trim() ?? '';
      final end = entry.shiftEndTime?.trim() ?? '';
      if (start.isNotEmpty && end.isNotEmpty) {
        day.primaryShiftLabel = '$start - $end';
      }
    }
  }

  for (final day in summaries) {
    day.regularSeconds = math.min(day.totalSeconds, 8 * 3600);
    day.overtimeSeconds = math.max(0, day.totalSeconds - (8 * 3600));
  }

  return summaries;
}

_WeekTotals _calculateWeekTotals(List<_DayTimesheetSummary> days) {
  int total = 0;
  int regular = 0;
  int overtime = 0;
  int absences = 0;

  for (final day in days) {
    total += day.totalSeconds;
    regular += day.regularSeconds;
    overtime += day.overtimeSeconds;
    if (day.date.weekday <= 5 && day.totalSeconds == 0) {
      absences += 1;
    }
  }

  return _WeekTotals(
    totalSeconds: total,
    regularSeconds: regular,
    overtimeSeconds: overtime,
    absenceDays: absences,
  );
}

DateTime? _entryDate(TimesheetEntry entry) {
  if (entry.workDate != null) {
    return entry.workDate!.toLocal();
  }
  if (entry.shiftDate != null && entry.shiftDate!.trim().isNotEmpty) {
    return DateTime.tryParse(entry.shiftDate!.trim());
  }
  return null;
}

int _entryDurationSeconds(TimesheetEntry entry) {
  if (entry.timeWorked != null && entry.timeWorked!.trim().isNotEmpty) {
    final parts = entry.timeWorked!.trim().split(':');
    if (parts.length == 3) {
      final h = int.tryParse(parts[0]) ?? 0;
      final m = int.tryParse(parts[1]) ?? 0;
      final s = int.tryParse(parts[2]) ?? 0;
      return (h * 3600) + (m * 60) + s;
    }
  }

  final totalHours = double.tryParse(entry.totalHours ?? '');
  if (totalHours != null && totalHours >= 0) {
    return (totalHours * 3600).round();
  }

  return 0;
}

String _formatHoursMinutes(int seconds) {
  final hours = seconds ~/ 3600;
  final minutes = (seconds % 3600) ~/ 60;
  return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
}
