import 'dart:math' as math;

import 'package:carenest/app/features/timesheet/models/timesheet_model.dart';
import 'package:carenest/app/features/timesheet/viewmodels/timesheet_viewmodel.dart';
import 'package:carenest/app/features/timesheet/views/timesheet_history_view.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
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
      backgroundColor: BauhausDesign.surfaceWhite,
      appBar: _buildBauhausAppBar(context, ref, email),
      body: Column(
        children: [
          _WeekRangeHeader(
            weekStart: weekStart,
            weekEnd: weekEnd,
            onPreviousWeek: () {
              ref.read(timesheetDateProvider.notifier).setDate(
                  weekStart.subtract(const Duration(days: 7)));
            },
            onNextWeek: () {
              ref.read(timesheetDateProvider.notifier).setDate(
                  weekStart.add(const Duration(days: 7)));
            },
            onThisWeek: () {
              final now = DateTime.now();
              final monday = now.subtract(Duration(days: now.weekday - 1));
              ref.read(timesheetDateProvider.notifier).setDate(
                  DateTime(monday.year, monday.month, monday.day));
            },
          ),
          Expanded(
            child: entriesAsync.when(
              loading: () => const BauhausLoadingState(showMessage: false),
              error: (error, _) => BauhausErrorState(
                title: AppLocalizations.of(context)!
                    .errorFetchingWorkedTime(error.toString()),
                onRetry: () =>
                    ref.invalidate(timesheetViewModelProvider(email)),
              ),
              data: (entries) => _TimesheetDataBody(
                entries: entries,
                weekStart: weekStart,
                weekEnd: weekEnd,
                email: email,
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

  PreferredSizeWidget _buildBauhausAppBar(
    BuildContext context,
    WidgetRef ref,
    String email,
  ) {
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
                  onPressed: () => Navigator.pop(context),
                  icon: Icons.arrow_back,
                  variant: BauhausActionVariant.ghost,
                ),
                const SizedBox(width: BauhausDesign.space2),
                Text(
                  AppLocalizations.of(context)!.timesheetTitle,
                  style: BauhausDesign.getTextTheme(context)
                      .displaySmall
                      ?.copyWith(color: BauhausDesign.textDark),
                ),
                const Spacer(),
                BauhausIconButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          TimesheetHistoryView(email: email),
                    ),
                  ),
                  icon: Icons.history_rounded,
                  variant: BauhausActionVariant.ghost,
                  tooltip: AppLocalizations.of(context)!.historyTitle,
                ),
                BauhausIconButton(
                  onPressed: () async {
                    final viewModel = ref.read(
                      timesheetViewModelProvider(email).notifier,
                    );
                    final path = await viewModel.exportTimesheet();
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          path == null
                              ? 'Failed to export timesheet'
                              : 'Exported timesheet: $path',
                        ),
                      ),
                    );
                  },
                  icon: Icons.file_download_outlined,
                  variant: BauhausActionVariant.ghost,
                  tooltip: 'Export',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── WEEK NAVIGATION ──────────────────────────────────────────────

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
        horizontal: BauhausDesign.space4,
        vertical: BauhausDesign.space3,
      ),
      decoration: const BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border(
          bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
        ),
      ),
      child: Row(
        children: [
          BauhausIconButton(
            onPressed: onPreviousWeek,
            icon: Icons.chevron_left,
            variant: BauhausActionVariant.neutral,
            isSmall: true,
          ),
          Expanded(
            child: Center(
              child: Text(
                '${DateFormat('MMM dd').format(weekStart)} – ${DateFormat('MMM dd, yyyy').format(weekEnd)}'
                    .toUpperCase(),
                style:
                    BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: BauhausDesign.textDark,
                          letterSpacing: 1.0,
                        ),
              ),
            ),
          ),
          BauhausIconButton(
            onPressed: onNextWeek,
            icon: Icons.chevron_right,
            variant: BauhausActionVariant.neutral,
            isSmall: true,
          ),
          const SizedBox(width: BauhausDesign.space2),
          BauhausActionButton(
            onPressed: onThisWeek,
            text: 'THIS WEEK',
            variant: BauhausActionVariant.neutral,
            isSmall: true,
          ),
        ],
      ),
    );
  }
}

// ─── BODY ─────────────────────────────────────────────────────────

class _TimesheetDataBody extends StatelessWidget {
  final List<TimesheetEntry> entries;
  final DateTime weekStart;
  final DateTime weekEnd;
  final String email;
  final VoidCallback onOpenHistory;

  const _TimesheetDataBody({
    required this.entries,
    required this.weekStart,
    required this.weekEnd,
    required this.email,
    required this.onOpenHistory,
  });

  @override
  Widget build(BuildContext context) {
    final days = _buildWeekSummaries(entries, weekStart);
    final weekTotals = _calculateWeekTotals(days);
    final hasAnyWork = days.any((d) => d.totalSeconds > 0);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Hero Summary Panels ──
          _HeroSummaryCard(totals: weekTotals),
          const SizedBox(height: BauhausDesign.space3),

          // ── Weekly Target Progress ──
          _WeeklyProgressBar(totalSeconds: weekTotals.totalSeconds),
          const SizedBox(height: BauhausDesign.space5),

          // ── Section Label ──
          Padding(
            padding:
                const EdgeInsets.only(bottom: BauhausDesign.space3),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 20,
                  color: BauhausDesign.secondary,
                ),
                const SizedBox(width: BauhausDesign.space2),
                Text(
                  'DAILY BREAKDOWN',
                  style: GoogleFonts.oswald(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: BauhausDesign.textDark,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),

          // ── Day Cards ──
          if (!hasAnyWork)
            _EmptyWeekState(weekStart: weekStart, weekEnd: weekEnd),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: days.length,
            separatorBuilder: (_, __) =>
                const SizedBox(height: BauhausDesign.space3),
            itemBuilder: (context, index) =>
                _DayCard(summary: days[index]),
          ),

          const SizedBox(height: BauhausDesign.space5),

          // ── History Banner ──
          _HistoryBanner(
            entryCount: entries.length,
            onTap: onOpenHistory,
          ),

          const SizedBox(height: BauhausDesign.space4),
        ],
      ),
    );
  }
}

// ─── HERO SUMMARY ─────────────────────────────────────────────────

class _HeroSummaryCard extends StatelessWidget {
  final _WeekTotals totals;

  const _HeroSummaryCard({required this.totals});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Regular hours
        Expanded(
          child: _SummaryPanel(
            label: AppLocalizations.of(context)!.regularLabel.toUpperCase(),
            value: _formatHoursMinutes(totals.regularSeconds),
            accentColor: BauhausDesign.secondary,
          ),
        ),
        const SizedBox(width: BauhausDesign.space3),
        // Overtime hours
        Expanded(
          child: _SummaryPanel(
            label: AppLocalizations.of(context)!.otLabel.toUpperCase(),
            value: _formatHoursMinutes(totals.overtimeSeconds),
            accentColor: BauhausDesign.primary,
          ),
        ),
        const SizedBox(width: BauhausDesign.space3),
        // Total hours — highlighted
        Expanded(
          child: _TotalPanel(
            label: AppLocalizations.of(context)!.totalLabel.toUpperCase(),
            value: _formatHoursMinutes(totals.totalSeconds),
            absenceDays: totals.absenceDays,
          ),
        ),
      ],
    );
  }
}

class _SummaryPanel extends StatelessWidget {
  final String label;
  final String value;
  final Color accentColor;

  const _SummaryPanel({
    required this.label,
    required this.value,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Accent strip at top
          Container(height: 4, color: accentColor),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space3,
              vertical: BauhausDesign.space3,
            ),
            child: Column(
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: BauhausDesign.textMuted,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: BauhausDesign.space1),
                Text(
                  value,
                  style: GoogleFonts.robotoMono(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: BauhausDesign.textDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TotalPanel extends StatelessWidget {
  final String label;
  final String value;
  final int absenceDays;

  const _TotalPanel({
    required this.label,
    required this.value,
    required this.absenceDays,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.accent,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(height: 4, color: BauhausDesign.accent),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space3,
              vertical: BauhausDesign.space3,
            ),
            child: Column(
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: BauhausDesign.textDark.withOpacity(0.7),
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: BauhausDesign.space1),
                Text(
                  value,
                  style: GoogleFonts.robotoMono(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: BauhausDesign.textDark,
                  ),
                ),
                if (absenceDays > 0) ...[
                  const SizedBox(height: BauhausDesign.space1),
                  Text(
                    '$absenceDays ABSENT',
                    style: GoogleFonts.inter(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: BauhausDesign.primary,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── WEEKLY PROGRESS BAR ──────────────────────────────────────────

class _WeeklyProgressBar extends StatelessWidget {
  final int totalSeconds;
  static const int _weeklyTargetSeconds = 40 * 3600; // 40 hours

  const _WeeklyProgressBar({required this.totalSeconds});

  @override
  Widget build(BuildContext context) {
    final fraction =
        (totalSeconds / _weeklyTargetSeconds).clamp(0.0, 1.0);
    final hours = totalSeconds / 3600;

    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'WEEKLY TARGET',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: BauhausDesign.textMuted,
                  letterSpacing: 1.0,
                ),
              ),
              Text(
                '${hours.toStringAsFixed(1)}h / 40h',
                style: GoogleFonts.robotoMono(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: BauhausDesign.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space2),
          Container(
            height: 10,
            decoration: BoxDecoration(
              color: BauhausDesign.neutral.withOpacity(0.1),
              border:
                  Border.all(color: BauhausDesign.neutral, width: 1),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: fraction,
              child: Container(
                color: fraction >= 1.0
                    ? BauhausDesign.success
                    : BauhausDesign.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── DAY CARD ─────────────────────────────────────────────────────

class _DayCard extends StatelessWidget {
  final _DayTimesheetSummary summary;

  const _DayCard({required this.summary});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final isToday = summary.date.year == today.year &&
        summary.date.month == today.month &&
        summary.date.day == today.day;
    final hasWork = summary.totalSeconds > 0;
    final regularFraction =
        (summary.regularSeconds / (8 * 3600)).clamp(0.0, 1.0);
    final overtimeFraction =
        (summary.overtimeSeconds / (8 * 3600)).clamp(0.0, 1.0);

    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Colored left border strip ──
            Container(
              width: 5,
              color: isToday
                  ? BauhausDesign.primary
                  : (hasWork
                      ? BauhausDesign.secondary
                      : BauhausDesign.neutral.withOpacity(0.2)),
            ),
            // ── Date column ──
            Container(
              width: 56,
              padding: const EdgeInsets.symmetric(
                vertical: BauhausDesign.space3,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('dd').format(summary.date),
                    style: GoogleFonts.oswald(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: isToday
                          ? BauhausDesign.primary
                          : BauhausDesign.textDark,
                    ),
                  ),
                  Text(
                    DateFormat('EEE').format(summary.date).toUpperCase(),
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: isToday
                          ? BauhausDesign.primary
                          : BauhausDesign.textMuted,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ),
            // ── Vertical divider ──
            Container(
              width: 1.5,
              color: BauhausDesign.neutral.withOpacity(0.3),
            ),
            // ── Content ──
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(BauhausDesign.space3),
                child: hasWork
                    ? _buildWorkContent(
                        context, regularFraction, overtimeFraction)
                    : _buildEmptyContent(context, isToday),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkContent(
    BuildContext context,
    double regularFraction,
    double overtimeFraction,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Hours progress bar ──
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: BauhausDesign.neutral.withOpacity(0.08),
            border: Border.all(
              color: BauhausDesign.neutral.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Flexible(
                flex: (regularFraction * 100).round().clamp(0, 100),
                child: Container(color: BauhausDesign.secondary),
              ),
              if (overtimeFraction > 0)
                Flexible(
                  flex:
                      (overtimeFraction * 100).round().clamp(0, 100),
                  child: Container(color: BauhausDesign.primary),
                ),
              Flexible(
                flex: math.max(
                  0,
                  100 -
                      (regularFraction * 100).round() -
                      (overtimeFraction * 100).round(),
                ),
                child: const SizedBox(),
              ),
            ],
          ),
        ),
        const SizedBox(height: BauhausDesign.space2),
        // ── Time labels ──
        Row(
          children: [
            _TimeChip(
              label: 'REG',
              value: _formatHoursMinutes(summary.regularSeconds),
              color: BauhausDesign.secondary,
            ),
            const SizedBox(width: BauhausDesign.space2),
            _TimeChip(
              label: 'OT',
              value: _formatHoursMinutes(summary.overtimeSeconds),
              color: BauhausDesign.primary,
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: BauhausDesign.space2,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: BauhausDesign.accent,
                border: Border.all(
                  color: BauhausDesign.neutral,
                  width: 1.5,
                ),
              ),
              child: Text(
                _formatHoursMinutes(summary.totalSeconds),
                style: GoogleFonts.robotoMono(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: BauhausDesign.textDark,
                ),
              ),
            ),
          ],
        ),
        // ── Shift time chip ──
        if (summary.primaryShiftLabel != null) ...[
          const SizedBox(height: BauhausDesign.space2),
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 13,
                color: BauhausDesign.textMuted,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  summary.primaryShiftLabel!,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: BauhausDesign.textMuted,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildEmptyContent(BuildContext context, bool isToday) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 8,
            height: 1.5,
            color: BauhausDesign.neutral.withOpacity(0.3),
          ),
          const SizedBox(width: BauhausDesign.space2),
          Text(
            isToday ? 'TODAY — NO HOURS YET' : 'NO HOURS',
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: BauhausDesign.textMuted,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(width: BauhausDesign.space2),
          Container(
            width: 8,
            height: 1.5,
            color: BauhausDesign.neutral.withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}

class _TimeChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _TimeChip({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 6, height: 6, color: color),
        const SizedBox(width: 4),
        Text(
          '$label ',
          style: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: BauhausDesign.textMuted,
            letterSpacing: 0.5,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.robotoMono(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: BauhausDesign.textDark,
          ),
        ),
      ],
    );
  }
}

// ─── EMPTY WEEK STATE ─────────────────────────────────────────────

class _EmptyWeekState extends StatelessWidget {
  final DateTime weekStart;
  final DateTime weekEnd;

  const _EmptyWeekState({
    required this.weekStart,
    required this.weekEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: BauhausDesign.space4),
      child: Container(
        padding: const EdgeInsets.all(BauhausDesign.space6),
        decoration: BoxDecoration(
          color: BauhausDesign.surfaceWhite,
          border: Border.all(
            color: BauhausDesign.neutral.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            Icon(
              Icons.event_busy,
              size: 32,
              color: BauhausDesign.textMuted,
            ),
            const SizedBox(height: BauhausDesign.space2),
            Text(
              'NO WORKED TIME',
              style: GoogleFonts.oswald(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: BauhausDesign.textMuted,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: BauhausDesign.space1),
            Text(
              '${DateFormat('MMM dd').format(weekStart)} – ${DateFormat('MMM dd').format(weekEnd)}',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: BauhausDesign.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── HISTORY BANNER ───────────────────────────────────────────────

class _HistoryBanner extends StatelessWidget {
  final int entryCount;
  final VoidCallback onTap;

  const _HistoryBanner({
    required this.entryCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: BauhausDesign.neutral,
          border: Border.all(color: BauhausDesign.neutral, width: 2),
          boxShadow: const [BauhausDesign.shadowHard],
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: BauhausDesign.space4,
          vertical: BauhausDesign.space3,
        ),
        child: Row(
          children: [
            const Icon(
              Icons.history_rounded,
              color: BauhausDesign.surfaceWhite,
              size: 20,
            ),
            const SizedBox(width: BauhausDesign.space3),
            Expanded(
              child: Text(
                'VIEW ALL HISTORY',
                style: GoogleFonts.oswald(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: BauhausDesign.surfaceWhite,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            if (entryCount > 0)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: BauhausDesign.space2,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: BauhausDesign.accent,
                  border: Border.all(
                    color: BauhausDesign.neutral,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  '$entryCount',
                  style: GoogleFonts.robotoMono(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: BauhausDesign.textDark,
                  ),
                ),
              ),
            const SizedBox(width: BauhausDesign.space2),
            const Icon(
              Icons.arrow_forward,
              color: BauhausDesign.surfaceWhite,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── DATA MODELS & HELPERS ────────────────────────────────────────

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
  List<TimesheetEntry> entries,
  DateTime weekStart,
) {
  final baseStart = DateTime(weekStart.year, weekStart.month, weekStart.day);
  final summaries = List.generate(
    7,
    (index) =>
        _DayTimesheetSummary(date: baseStart.add(Duration(days: index))),
  );

  for (final entry in entries) {
    final entryDate = _entryDate(entry);
    if (entryDate == null) continue;

    final normalized =
        DateTime(entryDate.year, entryDate.month, entryDate.day);
    final dayDiff = normalized.difference(baseStart).inDays;
    if (dayDiff < 0 || dayDiff > 6) continue;

    final day = summaries[dayDiff];
    final seconds = _entryDurationSeconds(entry);
    day.totalSeconds += seconds;
    day.shiftCount += 1;

    if (day.primaryShiftLabel == null) {
      final start = _formatTimeStr(entry.shiftStartTime);
      final end = _formatTimeStr(entry.shiftEndTime);
      if (start.isNotEmpty && end.isNotEmpty) {
        day.primaryShiftLabel = '$start – $end';
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

String _formatTimeStr(String? rawTime) {
  if (rawTime == null || rawTime.trim().isEmpty) return '';
  final trimmed = rawTime.trim();

  // Try to parse it as a DateTime (e.g. ISO string)
  final parsed = DateTime.tryParse(trimmed);
  if (parsed != null) {
    return DateFormat('hh:mm a').format(parsed.toLocal());
  }

  // If parsing fails, return the trimmed raw string
  return trimmed;
}
