/// Date/time parsing for schedule payloads.
///
/// The app's canonical date format is **day-first** (`DD/MM/YYYY`); ISO
/// (`YYYY-MM-DD`) is also accepted. Two home-dashboard calculators used to try
/// `MM/DD/YYYY` first, which silently swapped the day and month for any date
/// where both were <= 12 (e.g. 03/10/2026 read as March 10 instead of
/// 3 October), affecting in-progress/overtime/overdue badges.
class ScheduleTimeParser {
  const ScheduleTimeParser._();

  /// Parses a date value into a [DateTime] at midnight, or null.
  static DateTime? parseDate(dynamic value) {
    if (value == null) return null;

    final text = value.toString().trim();
    if (text.isEmpty) return null;

    // ISO date or datetime.
    if (text.contains('-') && !text.contains('/')) {
      final parsed = DateTime.tryParse(text);
      if (parsed == null) return null;
      return DateTime(parsed.year, parsed.month, parsed.day);
    }

    if (!text.contains('/')) return null;

    final parts = text.split('/');
    if (parts.length != 3) return null;

    final first = int.tryParse(parts[0]);
    final second = int.tryParse(parts[1]);
    final third = int.tryParse(parts[2]);
    if (first == null || second == null || third == null) return null;

    int year;
    int day;
    int month;

    if (parts[0].length == 4) {
      // YYYY/MM/DD
      year = first;
      month = second;
      day = third;
    } else {
      year = third;
      if (first > 12) {
        // Day-first is the only valid reading.
        day = first;
        month = second;
      } else if (second > 12) {
        // Month-first is the only valid reading.
        month = first;
        day = second;
      } else {
        // Ambiguous: the project stores day-first.
        day = first;
        month = second;
      }
    }

    final parsed = DateTime(year, month, day);
    // Reject rollover (e.g. 31/02 -> March).
    if (parsed.year != year || parsed.month != month || parsed.day != day) {
      return null;
    }
    return parsed;
  }

  /// Parses a time of day (`"09:00"`, `"9:00 AM"`, `"11:00\u202FPM"`).
  /// Returns null when the value is not a recognised time.
  static ({int hour, int minute})? parseTimeOfDay(dynamic value) {
    if (value == null) return null;

    final normalized = value
        .toString()
        .replaceAll(RegExp('[\u00A0\u202F]'), ' ')
        .replaceAll('.', '')
        .trim()
        .toUpperCase();
    if (normalized.isEmpty) return null;

    final match = RegExp(
      r'^(\d{1,2}):(\d{2})(?::\d{2})?\s*([AP]M)?$',
    ).firstMatch(normalized);
    if (match == null) {
      final hourOnly = RegExp(r'^(\d{1,2})\s*([AP]M)?$').firstMatch(normalized);
      if (hourOnly == null) return null;
      final hour = _to24Hour(int.parse(hourOnly.group(1)!), hourOnly.group(2));
      return (hour: hour, minute: 0);
    }

    final hour = _to24Hour(int.parse(match.group(1)!), match.group(3));
    final minute = int.parse(match.group(2)!);
    if (minute > 59) return null;
    return (hour: hour, minute: minute);
  }

  /// Combines a date and a time into a single [DateTime]. Overnight shifts are
  /// not rolled here; callers add a day when the end is before the start.
  static DateTime? parseDateTime(dynamic date, dynamic time) {
    final parsedDate = parseDate(date);
    final parsedTime = parseTimeOfDay(time);
    if (parsedDate == null || parsedTime == null) return null;
    return DateTime(
      parsedDate.year,
      parsedDate.month,
      parsedDate.day,
      parsedTime.hour,
      parsedTime.minute,
    );
  }

  static int _to24Hour(int hour, String? meridiem) {
    if (meridiem == null) return hour % 24;
    if (meridiem == 'AM') return hour == 12 ? 0 : hour % 12;
    return hour == 12 ? 12 : (hour % 12) + 12;
  }
}
