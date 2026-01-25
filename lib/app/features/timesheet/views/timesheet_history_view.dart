import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/features/timesheet/viewmodels/timesheet_viewmodel.dart';
import 'package:carenest/app/features/timesheet/models/timesheet_model.dart';
import 'package:carenest/app/features/timesheet/repositories/timesheet_repository.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

// Simple provider for history, fetching last 365 days
final timesheetHistoryProvider = FutureProvider.autoDispose
    .family<List<TimesheetEntry>, String>((ref, email) async {
  final repository = ref.read(timesheetRepositoryProvider);
  final end = DateTime.now();
  final start = end.subtract(
      const Duration(days: 365)); // Last year to catch older test data
  debugPrint(
      'TIMESHEET_HISTORY: Fetching from ${start.toIso8601String()} to ${end.toIso8601String()} for $email');
  final result = await repository.fetchTimesheets(
      email: email, startDate: start, endDate: end);
  debugPrint('TIMESHEET_HISTORY: Found ${result.length} entries');
  return result;
});

class TimesheetHistoryView extends ConsumerWidget {
  final String email;

  const TimesheetHistoryView({super.key, required this.email});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(timesheetHistoryProvider(email));

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: _buildBauhausAppBar(context),
      body: RefreshIndicator(
        onRefresh: () async {
          debugPrint('TIMESHEET_HISTORY: Refreshing...');
          return ref.refresh(timesheetHistoryProvider(email).future);
        },
        color: BauhausDesign.primary,
        child: historyAsync.when(
          data: (entries) {
            // Group entries by week
            final weeks = _groupByWeek(entries);
            if (weeks.isEmpty) {
              return Stack(
                children: [
                  ListView(), // Ensure RefreshIndicator works even when empty
                  Center(
                    child: BauhausEmptyState(
                      title: AppLocalizations.of(context)!.noHistoryTitle,
                      subtitle: AppLocalizations.of(context)!.noHistorySubtitle,
                      icon: Icons.history_outlined,
                    ),
                  ),
                ],
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(BauhausDesign.space4),
              itemCount: weeks.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: BauhausDesign.space4),
              itemBuilder: (context, index) {
                final weekStart = weeks.keys.elementAt(index);
                final weekEntries = weeks[weekStart]!;
                final weekEnd = weekStart.add(const Duration(days: 6));

                return _buildWeekCard(
                    context, ref, weekStart, weekEnd, weekEntries);
              },
            );
          },
          loading: () => const Center(
              child: CircularProgressIndicator(color: BauhausDesign.primary)),
          error: (e, s) => Stack(
            children: [
              ListView(),
              Center(
                child: BauhausErrorState(
                  message: 'Error: $e',
                  onRetry: () => ref.refresh(timesheetHistoryProvider(email)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildBauhausAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        decoration: const BoxDecoration(
          color: BauhausDesign.surfaceLight,
          border: Border(
            bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: BauhausDesign.space4),
            child: Row(
              children: [
                BauhausIconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icons.arrow_back,
                  variant: BauhausActionVariant.ghost,
                ),
                const SizedBox(width: BauhausDesign.space2),
                Text(
                  AppLocalizations.of(context)!.historyTitle,
                  style: BauhausDesign.getTextTheme(context).displaySmall,
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper to group entries by Monday of their week
  Map<DateTime, List<TimesheetEntry>> _groupByWeek(
      List<TimesheetEntry> entries) {
    final Map<DateTime, List<TimesheetEntry>> groups = {};
    for (var entry in entries) {
      final date = entry.workDate ??
          (entry.shiftDate != null
              ? DateTime.tryParse(entry.shiftDate!)
              : null);
      if (date != null) {
        // Find Monday
        final monday = date.subtract(Duration(days: date.weekday - 1));
        final key = DateTime(monday.year, monday.month, monday.day);
        if (!groups.containsKey(key)) {
          groups[key] = [];
        }
        groups[key]!.add(entry);
      }
    }
    // Sort keys descending
    final sortedKeys = groups.keys.toList()..sort((a, b) => b.compareTo(a));
    return Map.fromEntries(sortedKeys.map((k) => MapEntry(k, groups[k]!)));
  }

  Widget _buildWeekCard(BuildContext context, WidgetRef ref, DateTime start,
      DateTime end, List<TimesheetEntry> entries) {
    final dateFormat = DateFormat('MMM dd');
    // Calculate total hours
    int totalSeconds = 0;
    for (var e in entries) {
      if (e.timeWorked != null) {
        final parts = e.timeWorked!.split(':');
        if (parts.length == 3) {
          totalSeconds += int.parse(parts[0]) * 3600 +
              int.parse(parts[1]) * 60 +
              int.parse(parts[2]);
        }
      }
    }
    final h = totalSeconds ~/ 3600;
    final m = (totalSeconds % 3600) ~/ 60;
    final totalStr =
        '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';

    return BauhausCard(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${dateFormat.format(start)} - ${dateFormat.format(end)}',
                style:
                    BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: BauhausDesign.textDark,
                        ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: BauhausDesign.space2,
                    vertical: BauhausDesign.space1),
                decoration: BoxDecoration(
                  color: BauhausDesign.primary,
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusXs),
                ),
                child: Text(
                  totalStr,
                  style:
                      BauhausDesign.getTextTheme(context).labelMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: BauhausDesign.surfaceWhite,
                            fontFamily: 'monospace',
                          ),
                ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space2),
          Text(
            AppLocalizations.of(context)!.shiftsCount(entries.length),
            style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                  color: BauhausDesign.textMuted,
                ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // Logic to navigate to TimesheetView focused on this week
                debugPrint(
                    'TIMESHEET_DEBUG: View Details tapped for week starting $start');
                ref.read(timesheetDateProvider.notifier).state = start;
                debugPrint(
                    'TIMESHEET_DEBUG: Provider state updated. Popping context.');
                Navigator.pop(context);
              },
              child: Text(
                AppLocalizations.of(context)!.viewDetailsButton,
                style:
                    BauhausDesign.getTextTheme(context).labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: BauhausDesign.primary,
                        ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
