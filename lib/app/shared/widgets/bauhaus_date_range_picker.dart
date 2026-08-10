import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';

class BauhausDateRangePicker extends StatefulWidget {
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueChanged<DateTimeRange?>? onDateRangeChanged;

  const BauhausDateRangePicker({
    super.key,
    this.initialStartDate,
    this.initialEndDate,
    required this.firstDate,
    required this.lastDate,
    this.onDateRangeChanged,
  });

  @override
  State<BauhausDateRangePicker> createState() => _BauhausDateRangePickerState();
}

class _BauhausDateRangePickerState extends State<BauhausDateRangePicker> {
  late DateTime _focusedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;

  late TextEditingController _startController;
  late TextEditingController _endController;
  final _dateFormat = DateFormat('MM/dd/yyyy');

  @override
  void initState() {
    super.initState();

    // Sanitize focusedDay
    var focused = widget.initialStartDate ?? DateTime.now();
    if (focused.isBefore(widget.firstDate)) focused = widget.firstDate;
    if (focused.isAfter(widget.lastDate)) focused = widget.lastDate;
    _focusedDay = focused;

    // Sanitize range start
    _rangeStart = widget.initialStartDate;
    if (_rangeStart != null) {
      if (_rangeStart!.isBefore(widget.firstDate)) {
        _rangeStart = widget.firstDate;
      }
      if (_rangeStart!.isAfter(widget.lastDate)) _rangeStart = widget.lastDate;
    }

    // Sanitize range end
    _rangeEnd = widget.initialEndDate;
    if (_rangeEnd != null) {
      if (_rangeEnd!.isBefore(widget.firstDate)) _rangeEnd = widget.firstDate;
      if (_rangeEnd!.isAfter(widget.lastDate)) _rangeEnd = widget.lastDate;
    }

    _startController = TextEditingController();
    _endController = TextEditingController();
    _updateControllers();
  }

  @override
  void dispose() {
    _startController.dispose();
    _endController.dispose();
    super.dispose();
  }

  void _updateControllers() {
    if (_rangeStart != null) {
      _startController.text = _dateFormat.format(_rangeStart!);
    } else {
      _startController.clear();
    }

    if (_rangeEnd != null) {
      _endController.text = _dateFormat.format(_rangeEnd!);
    } else {
      _endController.clear();
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _rangeStart = start;
      _rangeEnd = end;
      _focusedDay = focusedDay;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });
    _updateControllers();
  }

  void _parseDate(
    String value, {
    required bool isStart,
    bool updateControllers = true,
  }) {
    if (value.isEmpty) return;
    try {
      // Normalize separator
      final normalized = value.replaceAll('-', '/').replaceAll('.', '/');
      final date = _dateFormat.parse(normalized);

      if (date.isBefore(widget.firstDate) || date.isAfter(widget.lastDate)) {
        if (updateControllers) _updateControllers(); // Revert if out of bounds
        return;
      }

      setState(() {
        if (isStart) {
          _rangeStart = date;
          // If start is after end, reset end
          if (_rangeEnd != null && date.isAfter(_rangeEnd!)) {
            _rangeEnd = null;
          }
          _focusedDay = date;
        } else {
          // If end is before start, update start or reset?
          // Usually end date selection allows setting end.
          if (_rangeStart != null && date.isBefore(_rangeStart!)) {
            _rangeStart = date;
            _rangeEnd = null; // Reset end to be picked again or just set start
          } else {
            _rangeEnd = date;
          }
          _focusedDay = date;
        }
      });
      if (updateControllers) _updateControllers();
    } catch (e) {
      if (updateControllers) _updateControllers(); // Revert on error
    }
  }

  @override
  Widget build(BuildContext context) {
    // Custom colors from image/Bauhaus system
    const selectionColor = Color(0xFF0055FF); // Electric Blue
    const okButtonColor = BauhausDesign.primary; // Red
    const neutralColor = BauhausDesign.neutral; // Black
    const surfaceColor = BauhausDesign.surfaceWhite;

    final headerDf = DateFormat('MMM dd, yyyy');

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        decoration: BoxDecoration(
          color: surfaceColor,
          border: Border.all(color: neutralColor, width: 3),
          boxShadow: const [
            BoxShadow(color: neutralColor, offset: Offset(8, 8), blurRadius: 0),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Section
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SELECT TIMEFRAME',
                            style: BauhausDesign.getTextTheme(context)
                                .labelSmall
                                ?.copyWith(
                                  letterSpacing: 1.5,
                                  fontWeight: FontWeight.w900,
                                  color: neutralColor,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _rangeStart != null
                                ? headerDf.format(_rangeStart!).toUpperCase()
                                : 'SELECT START',
                            style: BauhausDesign.getTextTheme(context)
                                .headlineMedium
                                ?.copyWith(
                                  fontSize: 24,
                                  height: 1.0,
                                  fontWeight: FontWeight.w800,
                                  color: neutralColor,
                                ),
                          ),
                          Text(
                            _rangeEnd != null
                                ? headerDf.format(_rangeEnd!).toUpperCase()
                                : (_rangeStart != null ? '...' : ''),
                            style: BauhausDesign.getTextTheme(context)
                                .headlineMedium
                                ?.copyWith(
                                  fontSize: 24,
                                  height: 1.0,
                                  fontWeight: FontWeight.w800,
                                  color: neutralColor,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: neutralColor, width: 2.5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.calendar_today_outlined,
                        size: 28,
                        color: neutralColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Tabs & Inputs
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Main Input Container
                        Container(
                          margin: const EdgeInsets.only(top: 24),
                          height: 56,
                          decoration: BoxDecoration(
                            border: Border.all(color: neutralColor, width: 3),
                          ),
                          child: Row(
                            children: [
                              // Start Date Input
                              Expanded(
                                child: Container(
                                  color: selectionColor,
                                  alignment: Alignment.center,
                                  child: TextField(
                                    controller: _startController,
                                    textAlign: TextAlign.center,
                                    style: BauhausDesign.getTextTheme(context)
                                        .headlineMedium
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                        ),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                      hintText: 'MM/DD/YYYY',
                                      hintStyle: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      filled: false,
                                    ),
                                    keyboardType: TextInputType.datetime,
                                    onSubmitted: (val) =>
                                        _parseDate(val, isStart: true),
                                  ),
                                ),
                              ),
                              // Divider
                              Container(width: 3, color: neutralColor),
                              // End Date Input
                              Expanded(
                                child: Container(
                                  color: surfaceColor,
                                  alignment: Alignment.center,
                                  child: TextField(
                                    controller: _endController,
                                    textAlign: TextAlign.center,
                                    style: BauhausDesign.getTextTheme(context)
                                        .headlineMedium
                                        ?.copyWith(
                                          color: neutralColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                        ),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                      hintText: 'MM/DD/YYYY',
                                      hintStyle: TextStyle(
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      filled: false,
                                    ),
                                    keyboardType: TextInputType.datetime,
                                    onSubmitted: (val) =>
                                        _parseDate(val, isStart: false),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Start Date Label
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            decoration: const BoxDecoration(
                              color: neutralColor,
                            ),
                            child: Text(
                              'START DATE',
                              style: BauhausDesign.getTextTheme(context)
                                  .labelSmall
                                  ?.copyWith(
                                    color: surfaceColor,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 11,
                                    letterSpacing: 0.5,
                                  ),
                            ),
                          ),
                        ),
                        // End Date Label
                        Positioned(
                          top: 0,
                          // Position exactly at the start of the second half + divider width offset
                          // Half width is constraints.maxWidth / 2
                          // Divider is 3px wide, centered? No, it takes space in Row.
                          // Row: Expanded + 3px + Expanded
                          // Total width = W
                          // Expanded width = (W - 3) / 2
                          // Second box starts at: Expanded + 3 = (W - 3)/2 + 3 = W/2 - 1.5 + 3 = W/2 + 1.5
                          left: (constraints.maxWidth / 2) + 1.5,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            decoration: const BoxDecoration(
                              color: neutralColor,
                            ),
                            child: Text(
                              'END DATE',
                              style: BauhausDesign.getTextTheme(context)
                                  .labelSmall
                                  ?.copyWith(
                                    color: surfaceColor,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 11,
                                    letterSpacing: 0.5,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Calendar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: neutralColor, width: 2.5),
                  ),
                  child: TableCalendar(
                    firstDay: widget.firstDate,
                    lastDay: widget.lastDate,
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) => isSameDay(_rangeStart, day),
                    rangeStartDay: _rangeStart,
                    rangeEndDay: _rangeEnd,
                    calendarFormat: CalendarFormat.month,
                    rangeSelectionMode: _rangeSelectionMode,
                    onRangeSelected: _onRangeSelected,
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                    daysOfWeekHeight: 40,
                    headerStyle: HeaderStyle(
                      titleCentered: true,
                      formatButtonVisible: false,
                      titleTextStyle: BauhausDesign.getTextTheme(context)
                          .titleMedium!
                          .copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: neutralColor,
                          ),
                      leftChevronIcon: const Icon(
                        Icons.chevron_left,
                        color: neutralColor,
                      ),
                      rightChevronIcon: const Icon(
                        Icons.chevron_right,
                        color: neutralColor,
                      ),
                      headerPadding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: neutralColor, width: 2.5),
                        ),
                      ),
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: const TextStyle(
                        color: neutralColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      weekendStyle: const TextStyle(
                        color: neutralColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: neutralColor, width: 2.5),
                        ),
                      ),
                    ),
                    calendarStyle: CalendarStyle(
                      isTodayHighlighted: false,
                      outsideDaysVisible: false,
                      rangeHighlightColor: selectionColor.withValues(alpha: 0.2),
                      rangeStartDecoration: const BoxDecoration(
                        color: selectionColor,
                        shape: BoxShape.rectangle,
                      ),
                      rangeEndDecoration: const BoxDecoration(
                        color: selectionColor,
                        shape: BoxShape.rectangle,
                      ),
                      withinRangeTextStyle: const TextStyle(
                        color: neutralColor,
                        fontWeight: FontWeight.bold,
                      ),
                      defaultTextStyle: const TextStyle(
                        color: neutralColor,
                        fontWeight: FontWeight.w600,
                      ),
                      weekendTextStyle: const TextStyle(
                        color: neutralColor,
                        fontWeight: FontWeight.w600,
                      ),
                      selectedDecoration: const BoxDecoration(
                        color: selectionColor,
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Buttons
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildButton(
                        context,
                        label: 'CANCEL',
                        color: surfaceColor,
                        textColor: neutralColor,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildButton(
                        context,
                        label: 'OK',
                        color: okButtonColor,
                        textColor: Colors.white,
                        onPressed: () {
                          // Force parse current text values without auto-updating controllers
                          // This ensures manually typed dates are captured even if Enter wasn't pressed
                          _parseDate(
                            _startController.text,
                            isStart: true,
                            updateControllers: false,
                          );
                          _parseDate(
                            _endController.text,
                            isStart: false,
                            updateControllers: false,
                          );

                          if (_rangeStart != null && _rangeEnd != null) {
                            Navigator.of(context).pop(
                              DateTimeRange(
                                start: _rangeStart!,
                                end: _rangeEnd!,
                                // Ensure start <= end
                              ),
                            );
                          } else {
                            // Allow single day selection as range
                            if (_rangeStart != null) {
                              Navigator.of(context).pop(
                                DateTimeRange(
                                  start: _rangeStart!,
                                  end: _rangeStart!,
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required String label,
    required Color color,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: BauhausDesign.neutral, width: 3),
          boxShadow: const [
            BoxShadow(
              color: BauhausDesign.neutral,
              offset: Offset(4, 4),
              blurRadius: 0,
            ),
          ],
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.0,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
