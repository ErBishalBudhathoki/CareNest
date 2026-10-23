import 'package:carenest/app/shared/utils/schedule_time_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('parseDate', () {
    test('parses ISO dates and datetimes', () {
      expect(ScheduleTimeParser.parseDate('2026-10-23'), DateTime(2026, 10, 23));
      expect(
        ScheduleTimeParser.parseDate('2026-10-23T09:00:00.000Z'),
        DateTime(2026, 10, 23),
      );
    });

    test('treats ambiguous slash dates as day-first (DD/MM/YYYY)', () {
      // Both 03 and 10 are <= 12: must be 3 October, not March 10.
      expect(ScheduleTimeParser.parseDate('03/10/2026'), DateTime(2026, 10, 3));
      expect(ScheduleTimeParser.parseDate('01/02/2026'), DateTime(2026, 2, 1));
    });

    test('still reads month-first when the day cannot be a month', () {
      expect(ScheduleTimeParser.parseDate('03/25/2026'), DateTime(2026, 3, 25));
      expect(ScheduleTimeParser.parseDate('25/03/2026'), DateTime(2026, 3, 25));
    });

    test('rejects rolled-over and malformed dates', () {
      expect(ScheduleTimeParser.parseDate('31/02/2026'), isNull);
      expect(ScheduleTimeParser.parseDate('not-a-date'), isNull);
      expect(ScheduleTimeParser.parseDate(null), isNull);
      expect(ScheduleTimeParser.parseDate(''), isNull);
    });
  });

  group('parseTimeOfDay', () {
    test('parses 24-hour times', () {
      expect(ScheduleTimeParser.parseTimeOfDay('09:00'), (hour: 9, minute: 0));
      expect(ScheduleTimeParser.parseTimeOfDay('22:30'), (hour: 22, minute: 30));
      expect(ScheduleTimeParser.parseTimeOfDay('09:15:45'), (hour: 9, minute: 15));
    });

    test('parses 12-hour times including ICU narrow no-break spaces', () {
      expect(
        ScheduleTimeParser.parseTimeOfDay('9:00 AM'),
        (hour: 9, minute: 0),
      );
      expect(
        ScheduleTimeParser.parseTimeOfDay('5:00 PM'),
        (hour: 17, minute: 0),
      );
      // U+202F is what intl/ICU emits between minutes and meridiem.
      expect(
        ScheduleTimeParser.parseTimeOfDay('11:00\u202FPM'),
        (hour: 23, minute: 0),
      );
      expect(
        ScheduleTimeParser.parseTimeOfDay('12:00 AM'),
        (hour: 0, minute: 0),
      );
      expect(
        ScheduleTimeParser.parseTimeOfDay('12:30 PM'),
        (hour: 12, minute: 30),
      );
    });

    test('accepts hour-only values', () {
      expect(ScheduleTimeParser.parseTimeOfDay('6'), (hour: 6, minute: 0));
      expect(ScheduleTimeParser.parseTimeOfDay('6 PM'), (hour: 18, minute: 0));
    });

    test('returns null for invalid times', () {
      expect(ScheduleTimeParser.parseTimeOfDay('nope'), isNull);
      expect(ScheduleTimeParser.parseTimeOfDay(''), isNull);
      expect(ScheduleTimeParser.parseTimeOfDay('09:75'), isNull);
      expect(ScheduleTimeParser.parseTimeOfDay(null), isNull);
    });
  });

  group('parseDateTime', () {
    test('combines day-first date with 12-hour time', () {
      expect(
        ScheduleTimeParser.parseDateTime('03/10/2026', '11:00 PM'),
        DateTime(2026, 10, 3, 23, 0),
      );
    });

    test('combines ISO date with 24-hour time', () {
      expect(
        ScheduleTimeParser.parseDateTime('2026-10-23', '22:00'),
        DateTime(2026, 10, 23, 22, 0),
      );
    });

    test('returns null when either part is missing', () {
      expect(ScheduleTimeParser.parseDateTime(null, '09:00'), isNull);
      expect(ScheduleTimeParser.parseDateTime('2026-10-23', null), isNull);
      expect(ScheduleTimeParser.parseDateTime('2026-10-23', 'nope'), isNull);
    });
  });
}
