import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
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
        const Duration(days: 365),
      ); // Last year to catch older test data
      debugPrint(
        'TIMESHEET_HISTORY: Fetching from ${start.toIso8601String()} to ${end.toIso8601String()} for $email',
      );
      final result = await repository.fetchTimesheets(
        email: email,
        startDate: start,
        endDate: end,
      );
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
      backgroundColor: BauhausDesign.surfaceWhite,
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

            final items = <Widget>[];
            String? lastMonthYear;

            for (var i = 0; i < weeks.length; i++) {
              final weekStart = weeks.keys.elementAt(i);
              final weekEntries = weeks[weekStart]!;
              final weekEnd = weekStart.add(const Duration(days: 6));

              // Check if we should insert a month header
              final monthYear = DateFormat('MMMM yyyy').format(weekStart);
              if (monthYear != lastMonthYear) {
                lastMonthYear = monthYear;
                items.add(_buildMonthHeader(context, monthYear));
              }

              items.add(
                _buildWeekCard(context, ref, weekStart, weekEnd, weekEntries),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: BauhausDesign.space4,
                vertical: BauhausDesign.space2,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return items[index];
              },
            );
          },
          loading: () => const BauhausLoadingState(showMessage: false),
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
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space4,
            ),
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
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).displaySmall?.copyWith(color: BauhausDesign.textDark),
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
    List<TimesheetEntry> entries,
  ) {
    final Map<DateTime, List<TimesheetEntry>> groups = {};
    for (var entry in entries) {
      final date =
          entry.workDate ??
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

  Widget _buildMonthHeader(BuildContext context, String monthYear) {
    return Padding(
      padding: const EdgeInsets.only(
        top: BauhausDesign.space4,
        bottom: BauhausDesign.space2,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space3,
              vertical: BauhausDesign.space1,
            ),
            decoration: BoxDecoration(
              color: BauhausDesign.accent, // Yellow accent
              border: Border.all(color: BauhausDesign.neutral, width: 2),
              boxShadow: const [
                BoxShadow(
                  color: BauhausDesign.neutral,
                  offset: Offset(2, 2),
                  blurRadius: 0,
                ),
              ],
            ),
            child: Text(
              monthYear.toUpperCase(),
              style: GoogleFonts.oswald(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: BauhausDesign.textDark,
                letterSpacing: 1.5,
              ),
            ),
          ),
          const SizedBox(width: BauhausDesign.space2),
          Expanded(child: Container(height: 2, color: BauhausDesign.neutral)),
        ],
      ),
    );
  }

  Widget _buildWeekCard(
    BuildContext context,
    WidgetRef ref,
    DateTime start,
    DateTime end,
    List<TimesheetEntry> entries,
  ) {
    final dateFormat = DateFormat('MMM dd');
    final yearFormat = DateFormat('yyyy');

    // Group entries by weekday to show in the timeline
    final List<List<TimesheetEntry>> dayEntries = List.generate(7, (i) => []);
    int totalSeconds = 0;

    for (var e in entries) {
      final date =
          e.workDate ??
          (e.shiftDate != null ? DateTime.tryParse(e.shiftDate!) : null);
      if (date != null) {
        final dayIndex = date.weekday - 1; // Monday = 0
        if (dayIndex >= 0 && dayIndex < 7) {
          dayEntries[dayIndex].add(e);
        }
      }

      if (e.timeWorked != null) {
        final parts = e.timeWorked!.split(':');
        if (parts.length == 3) {
          final hPart = int.tryParse(parts[0]) ?? 0;
          final mPart = int.tryParse(parts[1]) ?? 0;
          final sPart = int.tryParse(parts[2]) ?? 0;
          totalSeconds += (hPart * 3600) + (mPart * 60) + sPart;
        }
      }
    }

    final h = totalSeconds ~/ 3600;
    final m = (totalSeconds % 3600) ~/ 60;
    final totalStr =
        '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';

    final weekDays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    final List<DateTime> datesOfWeek = List.generate(
      7,
      (i) => start.add(Duration(days: i)),
    );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: BauhausDesign.space2),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2.5),
        boxShadow: const [
          BoxShadow(
            color: BauhausDesign.neutral,
            offset: Offset(6, 6),
            blurRadius: 0,
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Left color-blocked indicator strip
            Container(width: 6, color: BauhausDesign.secondary),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(BauhausDesign.space4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${dateFormat.format(start).toUpperCase()} – ${dateFormat.format(end).toUpperCase()}, ${yearFormat.format(end)}',
                                style: GoogleFonts.oswald(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: BauhausDesign.textDark,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: BauhausDesign.space1),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: BauhausDesign.space2,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: BauhausDesign.surfaceOffWhite,
                                      border: Border.all(
                                        color: BauhausDesign.neutral,
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .shiftsCount(entries.length)
                                          .toUpperCase(),
                                      style: GoogleFonts.inter(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w800,
                                        color: BauhausDesign.textDark,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Total Hours Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: BauhausDesign.space3,
                            vertical: 6.0,
                          ),
                          decoration: BoxDecoration(
                            color: BauhausDesign.accent, // Yellow accent
                            border: Border.all(
                              color: BauhausDesign.neutral,
                              width: 2,
                            ),
                            boxShadow: const [BauhausDesign.shadowHardSm],
                          ),
                          child: Text(
                            totalStr,
                            style: GoogleFonts.robotoMono(
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                              color: BauhausDesign.textDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: BauhausDesign.space4),

                    // Daily mini timeline
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: BauhausDesign.space2_5,
                        horizontal: BauhausDesign.space2,
                      ),
                      decoration: BoxDecoration(
                        color: BauhausDesign.surfaceOffWhite.withValues(alpha: 0.3),
                        border: Border.all(
                          color: BauhausDesign.neutral.withValues(alpha: 0.15),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(7, (i) {
                          final dayAbbr = weekDays[i];
                          final dayNum = datesOfWeek[i].day;

                          int daySeconds = 0;
                          for (var e in dayEntries[i]) {
                            if (e.timeWorked != null) {
                              final parts = e.timeWorked!.split(':');
                              if (parts.length == 3) {
                                daySeconds +=
                                    (int.tryParse(parts[0]) ?? 0) * 3600 +
                                    (int.tryParse(parts[1]) ?? 0) * 60 +
                                    (int.tryParse(parts[2]) ?? 0);
                              }
                            }
                          }
                          final dayHours = daySeconds / 3600;
                          final hasWork = daySeconds > 0;

                          return _buildDayTimelineBox(
                            context,
                            dayAbbr,
                            dayNum,
                            dayHours,
                            hasWork,
                          );
                        }),
                      ),
                    ),

                    const SizedBox(height: BauhausDesign.space3),

                    // Shifts list details
                    ...entries.map(
                      (entry) => _buildShiftDetailRow(context, entry),
                    ),

                    const SizedBox(height: BauhausDesign.space4),

                    // Action button at bottom
                    Align(
                      alignment: Alignment.centerRight,
                      child: BauhausActionButton(
                        onPressed: () {
                          debugPrint(
                            'TIMESHEET_DEBUG: View Details tapped for week starting $start',
                          );
                          ref
                              .read(timesheetDateProvider.notifier)
                              .setDate(start);
                          Navigator.pop(context);
                        },
                        text: AppLocalizations.of(
                          context,
                        )!.viewDetailsButton.toUpperCase(),
                        icon: Icons.launch_rounded,
                        variant: BauhausActionVariant.neutral,
                        isSmall: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayTimelineBox(
    BuildContext context,
    String dayAbbr,
    int dayNum,
    double hours,
    bool hasWork,
  ) {
    return Column(
      children: [
        Text(
          dayAbbr,
          style: GoogleFonts.inter(
            fontSize: 9,
            fontWeight: FontWeight.w800,
            color: hasWork ? BauhausDesign.secondary : BauhausDesign.textMuted,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: hasWork
                ? BauhausDesign.secondary
                : BauhausDesign.surfaceWhite,
            border: Border.all(
              color: hasWork
                  ? BauhausDesign.neutral
                  : BauhausDesign.neutral.withValues(alpha: 0.2),
              width: hasWork ? 1.5 : 1,
            ),
            boxShadow: hasWork ? const [BauhausDesign.shadowHardXs] : null,
          ),
          child: Text(
            dayNum.toString(),
            style: GoogleFonts.robotoMono(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: hasWork ? Colors.white : BauhausDesign.textMuted,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          hasWork ? '${hours.toStringAsFixed(1)}h' : '-',
          style: GoogleFonts.robotoMono(
            fontSize: 9,
            fontWeight: FontWeight.w700,
            color: hasWork ? BauhausDesign.textDark : BauhausDesign.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildShiftDetailRow(BuildContext context, TimesheetEntry entry) {
    final entryDate =
        entry.workDate ??
        (entry.shiftDate != null ? DateTime.tryParse(entry.shiftDate!) : null);
    final entryDateStr = entryDate != null
        ? DateFormat('EEE, MMM dd').format(entryDate)
        : 'Unknown Date';

    final startTime = entry.shiftStartTime ?? '00:00';
    final endTime = entry.shiftEndTime ?? '00:00';

    String durationStr = '0.0h';
    if (entry.timeWorked != null) {
      final parts = entry.timeWorked!.split(':');
      if (parts.length == 3) {
        final hrs = int.tryParse(parts[0]) ?? 0;
        final mins = int.tryParse(parts[1]) ?? 0;
        durationStr = '${hrs}h ${mins}m';
      }
    }

    return Container(
      margin: const EdgeInsets.only(top: BauhausDesign.space2),
      padding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space3,
        vertical: BauhausDesign.space2,
      ),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceOffWhite.withValues(alpha: 0.5),
        border: Border.all(
          color: BauhausDesign.neutral.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(width: 4, height: 24, color: BauhausDesign.accent),
          const SizedBox(width: BauhausDesign.space2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entryDateStr.toUpperCase(),
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: BauhausDesign.textDark,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(
                      Icons.schedule_outlined,
                      size: 12,
                      color: BauhausDesign.textMuted,
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        '$startTime - $endTime',
                        style: BauhausDesign.getTextTheme(context).bodySmall
                            ?.copyWith(
                              color: BauhausDesign.textMuted,
                              fontWeight: FontWeight.w500,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Shift Hours Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceWhite,
              border: Border.all(color: BauhausDesign.neutral, width: 1),
            ),
            child: Text(
              durationStr,
              style: GoogleFonts.robotoMono(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: BauhausDesign.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
