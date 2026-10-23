/// Weekly overtime for SCHADS employee invoices.
///
/// Daily overtime is applied per shift by `_generateEmployeeItems`. This
/// calculator adds the separate weekly obligation:
///
///   Full-time    38 ordinary hours per week
///   Part-time    76 ordinary hours per 2-week cycle
///   Casual      152 ordinary hours per 4-week cycle
///
/// Excess ordinary hours are paid at 150% for the first 2 hours in the cycle
/// and 200% thereafter. Only the premium over what was already paid is
/// returned, so daily-overtime hours and penalty-rate hours are never paid
/// twice. A premium is never negative.
class WeeklyOvertimeSegment {
  final DateTime start;
  final double hours;
  final double rate;

  const WeeklyOvertimeSegment({
    required this.start,
    required this.hours,
    required this.rate,
  });
}

class WeeklyOvertimeResult {
  final double amount;
  final double hours;
  final double ot1Hours;
  final double ot2Hours;
  final double capHours;
  final int cycleWeeks;

  const WeeklyOvertimeResult({
    required this.amount,
    required this.hours,
    required this.ot1Hours,
    required this.ot2Hours,
    required this.capHours,
    required this.cycleWeeks,
  });

  static const empty = WeeklyOvertimeResult(
    amount: 0,
    hours: 0,
    ot1Hours: 0,
    ot2Hours: 0,
    capHours: 38,
    cycleWeeks: 1,
  );
}

int weeklyOvertimeCycleWeeks(String employmentType) {
  final type = employmentType.toLowerCase();
  if (type.contains('casual')) return 4;
  if (type.contains('part') ||
      RegExp(r'(^|[_\s-])pt($|[_\s-])').hasMatch(type)) {
    return 2;
  }
  return 1;
}

WeeklyOvertimeResult calculateWeeklyOvertime({
  required List<WeeklyOvertimeSegment> segments,
  required String employmentType,
  required double baseRate,
  DateTime? cycleAnchor,
}) {
  if (segments.isEmpty || baseRate <= 0) {
    return WeeklyOvertimeResult.empty;
  }

  final cycleWeeks = weeklyOvertimeCycleWeeks(employmentType);
  final capHours = 38.0 * cycleWeeks;
  final ot1Rate = baseRate * 1.5;
  final ot2Rate = baseRate * 2.0;

  final sorted = [...segments]..sort((a, b) => a.start.compareTo(b.start));

  final cycleAnchorDate = cycleAnchor != null
      ? DateTime(cycleAnchor.year, cycleAnchor.month, cycleAnchor.day)
      : _mondayOf(sorted.first.start);

  // Map each segment to its cycle.
  final byCycle = <int, List<WeeklyOvertimeSegment>>{};
  for (final segment in sorted) {
    final monday = _mondayOf(segment.start);
    final cycleIndex =
        monday.difference(cycleAnchorDate).inDays ~/ (7 * cycleWeeks);
    byCycle.putIfAbsent(cycleIndex, () => []).add(segment);
  }

  double amount = 0;
  double hours = 0;
  double ot1Hours = 0;
  double ot2Hours = 0;

  for (final cycle in byCycle.keys.toList()..sort()) {
    final cycleSegments = byCycle[cycle]!;
    double ordinaryHours = 0;
    double overtimeAllocated = 0;

    for (final segment in cycleSegments) {
      if (segment.hours <= 0) continue;
      final before = ordinaryHours;
      ordinaryHours += segment.hours;
      if (ordinaryHours <= capHours) continue;

      final excessStart = (capHours - before).clamp(0.0, segment.hours);
      final excessHours = segment.hours - excessStart;
      if (excessHours <= 0) continue;

      final ot1Remaining = (2.0 - overtimeAllocated).clamp(0.0, 2.0);
      final excessOt1 = excessHours < ot1Remaining ? excessHours : ot1Remaining;
      final excessOt2 = excessHours - excessOt1;

      final paidRate = segment.rate;
      amount += (ot1Rate - paidRate).clamp(0.0, double.infinity) * excessOt1;
      amount += (ot2Rate - paidRate).clamp(0.0, double.infinity) * excessOt2;
      hours += excessHours;
      ot1Hours += excessOt1;
      ot2Hours += excessOt2;
      overtimeAllocated += excessHours;
    }
  }

  return WeeklyOvertimeResult(
    amount: double.parse(amount.toStringAsFixed(2)),
    hours: double.parse(hours.toStringAsFixed(2)),
    ot1Hours: double.parse(ot1Hours.toStringAsFixed(2)),
    ot2Hours: double.parse(ot2Hours.toStringAsFixed(2)),
    capHours: capHours,
    cycleWeeks: cycleWeeks,
  );
}

DateTime _mondayOf(DateTime date) {
  final day = DateTime(date.year, date.month, date.day);
  return day.subtract(Duration(days: day.weekday - 1));
}
