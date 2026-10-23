import 'package:carenest/app/features/invoice/utils/weekly_overtime_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

WeeklyOvertimeSegment segment(
  int day,
  double hours, {
  double rate = 25,
  int month = 6,
}) {
  return WeeklyOvertimeSegment(
    start: DateTime(2026, month, day, 9),
    hours: hours,
    rate: rate,
  );
}

void main() {
  group('calculateWeeklyOvertime', () {
    test('full-time 40 hours pays 2h of OT1 premium', () {
      final result = calculateWeeklyOvertime(
        // 2026-06-01 is a Monday.
        segments: [
          segment(1, 8),
          segment(2, 8),
          segment(3, 8),
          segment(4, 8),
          segment(5, 8),
        ],
        employmentType: 'Full Time',
        baseRate: 25,
      );
      expect(result.hours, 2);
      expect(result.ot1Hours, 2);
      expect(result.ot2Hours, 0);
      expect(result.amount, 25);
    });

    test('full-time 42 hours pays 2h OT1 and 2h OT2', () {
      final result = calculateWeeklyOvertime(
        segments: [
          segment(1, 8),
          segment(2, 8),
          segment(3, 8),
          segment(4, 8),
          segment(5, 8),
          segment(6, 2),
        ],
        employmentType: 'Full Time',
        baseRate: 25,
      );
      expect(result.hours, 4);
      expect(result.amount, 75);
    });

    test('part-time uses a 76-hour two-week cap', () {
      final result = calculateWeeklyOvertime(
        segments: [
          for (var week = 0; week < 2; week++)
            for (var day = 0; day < 5; day++) segment(1 + week * 7 + day, 8),
        ],
        employmentType: 'Permanent Part Time',
        baseRate: 25,
      );
      expect(result.cycleWeeks, 2);
      expect(result.hours, 4);
      expect(result.amount, 75);
    });

    test('casual uses a 152-hour four-week cap', () {
      final result = calculateWeeklyOvertime(
        segments: [
          for (var week = 0; week < 4; week++)
            for (var day = 0; day < 5; day++) segment(1 + week * 7 + day, 8),
        ],
        employmentType: 'Casual',
        baseRate: 25,
      );
      expect(result.cycleWeeks, 4);
      expect(result.hours, 8);
      expect(result.ot1Hours, 2);
      expect(result.ot2Hours, 6);
      expect(result.amount, 175);
    });

    test('premium is never negative for hours already paid above OT', () {
      final result = calculateWeeklyOvertime(
        segments: [
          for (var day = 1; day <= 5; day++) segment(day, 8, rate: 50),
        ],
        employmentType: 'Full Time',
        baseRate: 25,
      );
      expect(result.amount, 0);
      expect(result.hours, 2);
    });

    test('no base rate or no segments returns zero', () {
      expect(
        calculateWeeklyOvertime(
          segments: [segment(1, 8)],
          employmentType: 'Full Time',
          baseRate: 0,
        ).amount,
        0,
      );
      expect(
        calculateWeeklyOvertime(
          segments: const [],
          employmentType: 'Full Time',
          baseRate: 25,
        ).amount,
        0,
      );
    });
  });
}
