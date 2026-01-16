Map<String, dynamic> calculateEmployeeRateDecision({
  required double baseRate,
  required double saturdayRate,
  required double sundayRate,
  required double publicHolidayRate,
  required DateTime date,
  required bool isHoliday,
}) {
  final base = baseRate.toDouble();

  if (isHoliday) {
    final ph = publicHolidayRate.toDouble();
    final chosen = ph > 0 ? ph : base;
    return {'rate': chosen, 'source': 'EMP_PUBLIC_HOLIDAY'};
  }

  if (date.weekday == DateTime.saturday) {
    final sat = saturdayRate.toDouble();
    final chosen = sat > 0 ? sat : base;
    return {'rate': chosen, 'source': 'EMP_SATURDAY'};
  }

  if (date.weekday == DateTime.sunday) {
    final sun = sundayRate.toDouble();
    final chosen = sun > 0 ? sun : base;
    return {'rate': chosen, 'source': 'EMP_SUNDAY'};
  }

  return {'rate': base, 'source': 'EMP_BASE'};
}

