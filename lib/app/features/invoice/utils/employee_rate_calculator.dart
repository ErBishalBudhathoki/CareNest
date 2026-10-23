import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

Map<String, dynamic> calculateEmployeeRateDecision({
  required double baseRate,
  required double saturdayRate,
  required double sundayRate,
  required double publicHolidayRate,
  required double eveningShiftRate,
  required double nightShiftRate,
  required DateTime date,
  required bool isHoliday,
  String? startTime,
  String? endTime,
}) {
  final base = baseRate.toDouble();

  // 1. Public Holiday (Highest Priority)
  if (isHoliday) {
    final ph = publicHolidayRate.toDouble();
    final chosen = ph > 0 ? ph : base;
    return {'rate': chosen, 'source': 'EMP_PUBLIC_HOLIDAY'};
  }

  // 2. Sunday
  if (date.weekday == DateTime.sunday) {
    final sun = sundayRate.toDouble();
    final chosen = sun > 0 ? sun : base;
    return {'rate': chosen, 'source': 'EMP_SUNDAY'};
  }

  // 3. Saturday
  if (date.weekday == DateTime.saturday) {
    final sat = saturdayRate.toDouble();
    final chosen = sat > 0 ? sat : base;
    return {'rate': chosen, 'source': 'EMP_SATURDAY'};
  }

  // 4. Time-based Penalties (Evening/Night Shift)
  // Only applies if not a weekend/holiday (already handled above)
  if (startTime != null &&
      endTime != null &&
      startTime.isNotEmpty &&
      endTime.isNotEmpty) {
    try {
      final startDt = _parseTime(startTime);
      final endDt = _parseTime(endTime);

      if (startDt != null && endDt != null) {
        final startHour = startDt.hour;
        final startMinute = startDt.minute;
        final endHour = endDt.hour;
        final endMinute = endDt.minute;

        // Determine if overnight (end time is before start time or effectively next day)
        // Simple check: if end time < start time, assume next day
        bool isOvernight = false;
        if (endHour < startHour ||
            (endHour == startHour && endMinute < startMinute)) {
          isOvernight = true;
        }

        // Night Shift Logic (SCHADS):
        // 1. Finishes after midnight and at or before 6.00 am, or
        // 2. Runs 00:00–06:00.
        // An early-morning start that finishes after 06:00 is a day shift.
        final finishesBySix = endHour < 6 || (endHour == 6 && endMinute == 0);
        if (isOvernight || finishesBySix) {
          final night = nightShiftRate.toDouble();
          final chosen = night > 0 ? night : base;
          return {'rate': chosen, 'source': 'EMP_NIGHT_SHIFT'};
        }

        // Evening Shift Logic:
        // Finishes after 6.00 pm (18:00) and at or before midnight.
        final finishesAfter6pm =
            endHour > 18 || (endHour == 18 && endMinute > 0);

        if (finishesAfter6pm) {
          final evening = eveningShiftRate.toDouble();
          final chosen = evening > 0 ? evening : base;
          return {'rate': chosen, 'source': 'EMP_EVENING_SHIFT'};
        }
      }
    } catch (e) {
      debugPrint('Error calculating shift times: $e');
    }
  }

  return {'rate': base, 'source': 'EMP_BASE'};
}

DateTime? _parseTime(String timeStr) {
  if (timeStr.isEmpty) return null;

  // Sanitize
  timeStr = timeStr.trim();
  if (timeStr.contains(' at ')) {
    timeStr = timeStr.split(' at ')[0].trim();
  }
  timeStr = timeStr.replaceAll(RegExp(r'\s+'), ' ');
  timeStr = timeStr.replaceAllMapped(
    RegExp(r'\b(am|pm)\b', caseSensitive: false),
    (match) => match.group(0)!.toUpperCase(),
  );

  // Parse strictly to avoid lenient mismatches like "05:00 PM" -> 05:00.
  const patterns = <String>[
    'h:mm a',
    'hh:mm a',
    'h:mma',
    'hh:mma',
    'H:mm',
    'HH:mm',
    'H:mm:ss',
    'HH:mm:ss',
  ];
  for (final pattern in patterns) {
    try {
      return DateFormat(pattern).parseStrict(timeStr);
    } catch (_) {}
  }

  return null;
}
