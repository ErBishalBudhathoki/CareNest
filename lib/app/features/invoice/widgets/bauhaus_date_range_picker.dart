import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Shared design tokens
// ─────────────────────────────────────────────────────────────────────────────

const _ink = BauhausDesign.neoInk;
const _paper = BauhausDesign.neoPaper;
const _signal = BauhausDesign.neoSignal;
const _danger = BauhausDesign.neoDanger;
const _highlight = BauhausDesign.neoHighlight;
const _rangeLight = Color(0xFFD6E4FF);

// ─────────────────────────────────────────────────────────────────────────────
// Public API
// ─────────────────────────────────────────────────────────────────────────────

/// Shows a Bauhaus Neo-Brutalist styled date range picker dialog.
/// Returns a [DateTimeRange] when the user confirms, or `null` if cancelled.
Future<DateTimeRange?> showBauhausDateRangePicker({
  required BuildContext context,
  DateTime? initialStart,
  DateTime? initialEnd,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  return showDialog<DateTimeRange>(
    context: context,
    barrierColor: _ink.withValues(alpha: 0.55),
    builder: (_) => _BauhausDateRangePickerDialog(
      initialStart: initialStart,
      initialEnd: initialEnd,
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2100),
    ),
  );
}

/// Shows a Bauhaus Neo-Brutalist styled single-date picker dialog.
/// Returns a [DateTime] when confirmed, or `null` if cancelled.
Future<DateTime?> showBauhausDatePicker({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  return showDialog<DateTime>(
    context: context,
    barrierColor: _ink.withValues(alpha: 0.55),
    builder: (_) => _BauhausDatePickerDialog(
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2100),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Internal dialog widget
// ─────────────────────────────────────────────────────────────────────────────

class _BauhausDateRangePickerDialog extends StatefulWidget {
  const _BauhausDateRangePickerDialog({
    this.initialStart,
    this.initialEnd,
    required this.firstDate,
    required this.lastDate,
  });

  final DateTime? initialStart;
  final DateTime? initialEnd;
  final DateTime firstDate;
  final DateTime lastDate;

  @override
  State<_BauhausDateRangePickerDialog> createState() =>
      _BauhausDateRangePickerDialogState();
}

class _BauhausDateRangePickerDialogState
    extends State<_BauhausDateRangePickerDialog> {
  // ── Selection state ──────────────────────────────────────────────────────
  DateTime? _start;
  DateTime? _end;
  bool _pickingEnd = false; // true after first tap selects start

  // ── Displayed month ──────────────────────────────────────────────────────
  late DateTime _viewMonth; // first day of currently shown month

  @override
  void initState() {
    super.initState();
    _start = widget.initialStart;
    _end = widget.initialEnd;
    _pickingEnd = false;
    // Start view on the start date's month, or current month
    final now = DateTime.now();
    _viewMonth = DateTime(
      (widget.initialStart ?? now).year,
      (widget.initialStart ?? now).month,
      1,
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  bool _isInRange(DateTime d) {
    if (_start == null || _end == null) return false;
    final day = DateTime(d.year, d.month, d.day);
    final s = DateTime(_start!.year, _start!.month, _start!.day);
    final e = DateTime(_end!.year, _end!.month, _end!.day);
    return day.isAfter(s) && day.isBefore(e);
  }

  void _onDayTapped(DateTime day) {
    setState(() {
      if (!_pickingEnd || _start == null) {
        // First tap → set start, clear end
        _start = day;
        _end = null;
        _pickingEnd = true;
      } else {
        // Second tap → set end (swap if needed)
        if (day.isBefore(_start!)) {
          _end = _start;
          _start = day;
        } else {
          _end = day;
        }
        _pickingEnd = false;
      }
    });
  }

  void _prevMonth() => setState(() {
    _viewMonth = DateTime(_viewMonth.year, _viewMonth.month - 1, 1);
  });

  void _nextMonth() => setState(() {
    _viewMonth = DateTime(_viewMonth.year, _viewMonth.month + 1, 1);
  });

  String _monthLabel(DateTime d) =>
      '${_monthName(d.month).toUpperCase()}  ${d.year}';

  String _monthName(int m) => const [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ][m - 1];

  String _dayAbbr(int d) => ['MO', 'TU', 'WE', 'TH', 'FR', 'SA', 'SU'][d];

  // Format a date for the summary bar
  String _fmt(DateTime? d) {
    if (d == null) return '— — —';
    return '${d.day.toString().padLeft(2, '0')} '
        '${_monthName(d.month).substring(0, 3).toUpperCase()} '
        '${d.year}';
  }

  // ── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final dialogW = (screenW * 0.92).clamp(300.0, 420.0);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        width: dialogW,
        decoration: BoxDecoration(
          color: _paper,
          border: Border.all(color: _ink, width: BauhausDesign.neoBorderWidth),
          boxShadow: const [
            BoxShadow(color: _ink, offset: Offset(8, 8), blurRadius: 0),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            _buildSelectionSummary(),
            _buildCalendar(),
            _buildStatusHint(),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  // ── Header bar ────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Container(
      color: _ink,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(width: 6, height: 28, color: _highlight),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'SELECT PERIOD',
              style: GoogleFonts.oswald(
                color: _paper,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(null),
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(color: _paper.withValues(alpha: 0.5), width: 1.5),
              ),
              child: const Icon(Icons.close_rounded, color: _paper, size: 16),
            ),
          ),
        ],
      ),
    );
  }

  // ── Selection summary strip ───────────────────────────────────────────────

  Widget _buildSelectionSummary() {
    return Container(
      decoration: BoxDecoration(
        color: _signal,
        border: Border(
          bottom: BorderSide(color: _ink, width: BauhausDesign.neoBorderWidth),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(child: _summaryCell('FROM', _start)),
          Container(width: 1.5, height: 36, color: _paper.withValues(alpha: 0.35)),
          Expanded(child: _summaryCell('TO', _end)),
        ],
      ),
    );
  }

  Widget _summaryCell(String label, DateTime? date) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: GoogleFonts.robotoMono(
              color: _paper.withValues(alpha: 0.65),
              fontSize: 9,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            _fmt(date),
            style: GoogleFonts.oswald(
              color: _paper,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }

  // ── Calendar ──────────────────────────────────────────────────────────────

  Widget _buildCalendar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: Column(
        children: [
          _buildMonthNav(),
          const SizedBox(height: 8),
          _buildWeekdayRow(),
          const SizedBox(height: 4),
          _buildDayGrid(),
        ],
      ),
    );
  }

  Widget _buildMonthNav() {
    return Row(
      children: [
        _navButton(Icons.chevron_left_rounded, _prevMonth),
        Expanded(
          child: Center(
            child: Text(
              _monthLabel(_viewMonth),
              style: GoogleFonts.oswald(
                color: _ink,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
        _navButton(Icons.chevron_right_rounded, _nextMonth),
      ],
    );
  }

  Widget _navButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          border: Border.all(
            color: _ink,
            width: BauhausDesign.neoInnerBorderWidth,
          ),
        ),
        child: Icon(icon, color: _signal, size: 20),
      ),
    );
  }

  Widget _buildWeekdayRow() {
    return Row(
      children: List.generate(7, (i) {
        final isWeekend = i >= 5;
        return Expanded(
          child: Center(
            child: Text(
              _dayAbbr(i),
              style: GoogleFonts.robotoMono(
                color: isWeekend ? _danger : _ink.withValues(alpha: 0.55),
                fontSize: 9,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildDayGrid() {
    final today = DateTime.now();
    // First weekday of month (Monday=0 … Sunday=6)
    int firstWd = (_viewMonth.weekday - 1) % 7;
    int daysInMonth = DateTime(_viewMonth.year, _viewMonth.month + 1, 0).day;
    int totalCells = firstWd + daysInMonth;
    int rows = (totalCells / 7).ceil();

    return Column(
      children: List.generate(rows, (r) {
        return Row(
          children: List.generate(7, (c) {
            int idx = r * 7 + c;
            int dayNum = idx - firstWd + 1;
            if (dayNum < 1 || dayNum > daysInMonth) {
              return const Expanded(child: SizedBox(height: 38));
            }
            final day = DateTime(_viewMonth.year, _viewMonth.month, dayNum);
            return Expanded(child: _buildDayCell(day, today));
          }),
        );
      }),
    );
  }

  Widget _buildDayCell(DateTime day, DateTime today) {
    final isStart = _start != null && _isSameDay(day, _start!);
    final isEnd = _end != null && _isSameDay(day, _end!);
    final isEndpoint = isStart || isEnd;
    final inRange = _isInRange(day);
    final isToday = _isSameDay(day, today);
    final isWeekend = day.weekday >= 6;

    Color bg = Colors.transparent;
    Color fg = isWeekend ? _danger.withValues(alpha: 0.75) : _ink;

    if (isEndpoint) {
      bg = _signal;
      fg = _paper;
    } else if (inRange) {
      bg = _rangeLight;
      fg = _signal;
    }

    Widget cell = GestureDetector(
      onTap: () => _onDayTapped(day),
      child: Container(
        height: 38,
        margin: const EdgeInsets.all(1.5),
        decoration: BoxDecoration(
          color: bg,
          border: isEndpoint
              ? Border.all(
                  color: _ink,
                  width: BauhausDesign.neoInnerBorderWidth,
                )
              : inRange
              ? Border.all(color: _signal.withValues(alpha: 0.3), width: 1)
              : null,
          boxShadow: isEndpoint
              ? [
                  const BoxShadow(
                    color: _ink,
                    offset: Offset(2, 2),
                    blurRadius: 0,
                  ),
                ]
              : null,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              '${day.day}',
              style: GoogleFonts.oswald(
                color: fg,
                fontSize: 15,
                fontWeight: isEndpoint ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
            // Today indicator — yellow dot at bottom
            if (isToday && !isEndpoint)
              Positioned(
                bottom: 4,
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(
                    color: _highlight,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );

    return cell;
  }

  // ── Status hint ───────────────────────────────────────────────────────────

  Widget _buildStatusHint() {
    final msg = _start == null
        ? 'TAP A DAY TO SET START DATE'
        : (_end == null
              ? 'NOW TAP AN END DATE'
              : 'RANGE SELECTED — CONFIRM BELOW');

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 10, 12, 0),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _start != null && _end != null
            ? _highlight.withValues(alpha: 0.18)
            : _ink.withValues(alpha: 0.06),
        border: Border.all(
          color: _start != null && _end != null
              ? _highlight
              : _ink.withValues(alpha: 0.25),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Icon(
            _start != null && _end != null
                ? Icons.check_rounded
                : Icons.touch_app_rounded,
            size: 13,
            color: _start != null && _end != null
                ? _highlight
                : _ink.withValues(alpha: 0.5),
          ),
          const SizedBox(width: 6),
          Text(
            msg,
            style: GoogleFonts.robotoMono(
              color: _ink.withValues(alpha: 0.65),
              fontSize: 9,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }

  // ── Action buttons ────────────────────────────────────────────────────────

  Widget _buildActions() {
    final canConfirm = _start != null && _end != null;

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
      child: Row(
        children: [
          // Clear / Cancel button
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (_start != null || _end != null) {
                  setState(() {
                    _start = null;
                    _end = null;
                    _pickingEnd = false;
                  });
                } else {
                  Navigator.of(context).pop(null);
                }
              },
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: _paper,
                  border: Border.all(
                    color: _ink,
                    width: BauhausDesign.neoInnerBorderWidth,
                  ),
                  boxShadow: const [
                    BoxShadow(color: _ink, offset: Offset(3, 3), blurRadius: 0),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  (_start != null || _end != null) ? 'CLEAR' : 'CANCEL',
                  style: GoogleFonts.oswald(
                    color: _ink,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Confirm button
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: canConfirm
                  ? () => Navigator.of(
                      context,
                    ).pop(DateTimeRange(start: _start!, end: _end!))
                  : null,
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: canConfirm ? _danger : _ink.withValues(alpha: 0.25),
                  border: Border.all(
                    color: _ink,
                    width: BauhausDesign.neoBorderWidth,
                  ),
                  boxShadow: canConfirm
                      ? const [
                          BoxShadow(
                            color: _ink,
                            offset: Offset(4, 4),
                            blurRadius: 0,
                          ),
                        ]
                      : [],
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_rounded,
                      color: canConfirm ? _paper : _paper.withValues(alpha: 0.45),
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'CONFIRM PERIOD',
                      style: GoogleFonts.oswald(
                        color: canConfirm ? _paper : _paper.withValues(alpha: 0.45),
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Single-date picker dialog (same Bauhaus theme)
// ─────────────────────────────────────────────────────────────────────────────

class _BauhausDatePickerDialog extends StatefulWidget {
  const _BauhausDatePickerDialog({
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
  });

  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;

  @override
  State<_BauhausDatePickerDialog> createState() =>
      _BauhausDatePickerDialogState();
}

class _BauhausDatePickerDialogState extends State<_BauhausDatePickerDialog> {
  late DateTime _selected;
  late DateTime _viewMonth;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialDate;
    _viewMonth = DateTime(widget.initialDate.year, widget.initialDate.month, 1);
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  String _monthLabel(DateTime d) =>
      '${['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'][d.month - 1].toUpperCase()}  ${d.year}';

  void _prevMonth() => setState(
    () => _viewMonth = DateTime(_viewMonth.year, _viewMonth.month - 1, 1),
  );
  void _nextMonth() => setState(
    () => _viewMonth = DateTime(_viewMonth.year, _viewMonth.month + 1, 1),
  );

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final dialogW = (screenW * 0.92).clamp(280.0, 380.0);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        width: dialogW,
        decoration: BoxDecoration(
          color: _paper,
          border: Border.all(color: _ink, width: BauhausDesign.neoBorderWidth),
          boxShadow: const [
            BoxShadow(color: _ink, offset: Offset(8, 8), blurRadius: 0),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            const SizedBox(height: 12),
            _buildCalendar(),
            const SizedBox(height: 12),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: _ink,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(width: 6, height: 28, color: _highlight),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'SELECT DATE',
              style: GoogleFonts.oswald(
                color: _paper,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(null),
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(color: _paper.withValues(alpha: 0.5), width: 1.5),
              ),
              child: const Icon(Icons.close_rounded, color: _paper, size: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          _buildMonthNav(),
          const SizedBox(height: 8),
          _buildWeekdayRow(),
          const SizedBox(height: 4),
          _buildDayGrid(),
        ],
      ),
    );
  }

  Widget _buildMonthNav() {
    return Row(
      children: [
        _navButton(Icons.chevron_left_rounded, _prevMonth),
        Expanded(
          child: Center(
            child: Text(
              _monthLabel(_viewMonth),
              style: GoogleFonts.oswald(
                color: _ink,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
        _navButton(Icons.chevron_right_rounded, _nextMonth),
      ],
    );
  }

  Widget _navButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          border: Border.all(
            color: _ink,
            width: BauhausDesign.neoInnerBorderWidth,
          ),
        ),
        child: Icon(icon, color: _signal, size: 20),
      ),
    );
  }

  Widget _buildWeekdayRow() {
    const abbr = ['MO', 'TU', 'WE', 'TH', 'FR', 'SA', 'SU'];
    return Row(
      children: List.generate(
        7,
        (i) => Expanded(
          child: Center(
            child: Text(
              abbr[i],
              style: GoogleFonts.robotoMono(
                color: i >= 5 ? _danger : _ink.withValues(alpha: 0.55),
                fontSize: 9,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDayGrid() {
    final today = DateTime.now();
    int firstWd = (_viewMonth.weekday - 1) % 7;
    int daysInMonth = DateTime(_viewMonth.year, _viewMonth.month + 1, 0).day;
    int totalCells = firstWd + daysInMonth;
    int rows = (totalCells / 7).ceil();

    return Column(
      children: List.generate(
        rows,
        (r) => Row(
          children: List.generate(7, (c) {
            int idx = r * 7 + c;
            int dayNum = idx - firstWd + 1;
            if (dayNum < 1 || dayNum > daysInMonth) {
              return const Expanded(child: SizedBox(height: 38));
            }
            final day = DateTime(_viewMonth.year, _viewMonth.month, dayNum);
            return Expanded(child: _buildDayCell(day, today));
          }),
        ),
      ),
    );
  }

  Widget _buildDayCell(DateTime day, DateTime today) {
    final isSelected = _isSameDay(day, _selected);
    final isToday = _isSameDay(day, today);
    final isWeekend = day.weekday >= 6;

    return GestureDetector(
      onTap: () => setState(() => _selected = day),
      child: Container(
        height: 38,
        margin: const EdgeInsets.all(1.5),
        decoration: BoxDecoration(
          color: isSelected ? _signal : Colors.transparent,
          border: isSelected
              ? Border.all(
                  color: _ink,
                  width: BauhausDesign.neoInnerBorderWidth,
                )
              : null,
          boxShadow: isSelected
              ? const [
                  BoxShadow(color: _ink, offset: Offset(2, 2), blurRadius: 0),
                ]
              : null,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              '${day.day}',
              style: GoogleFonts.oswald(
                color: isSelected
                    ? _paper
                    : (isWeekend ? _danger.withValues(alpha: 0.75) : _ink),
                fontSize: 15,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
            if (isToday && !isSelected)
              Positioned(
                bottom: 4,
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(
                    color: _highlight,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(null),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: _paper,
                  border: Border.all(
                    color: _ink,
                    width: BauhausDesign.neoInnerBorderWidth,
                  ),
                  boxShadow: const [
                    BoxShadow(color: _ink, offset: Offset(3, 3), blurRadius: 0),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  'CANCEL',
                  style: GoogleFonts.oswald(
                    color: _ink,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(_selected),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: _danger,
                  border: Border.all(
                    color: _ink,
                    width: BauhausDesign.neoBorderWidth,
                  ),
                  boxShadow: const [
                    BoxShadow(color: _ink, offset: Offset(4, 4), blurRadius: 0),
                  ],
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check_rounded, color: _paper, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      'CONFIRM DATE',
                      style: GoogleFonts.oswald(
                        color: _paper,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
