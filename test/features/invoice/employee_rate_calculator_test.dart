import 'package:carenest/app/features/invoice/utils/employee_rate_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Employee Rate Calculator', () {
    // Helper to call function with default zero values unless specified
    Map<String, dynamic> calc({
      double baseRate = 25.0,
      double saturdayRate = 35.0,
      double sundayRate = 45.0,
      double publicHolidayRate = 55.0,
      double eveningShiftRate = 28.0,
      double nightShiftRate = 30.0,
      required DateTime date,
      bool isHoliday = false,
      String? startTime,
      String? endTime,
    }) {
      return calculateEmployeeRateDecision(
        baseRate: baseRate,
        saturdayRate: saturdayRate,
        sundayRate: sundayRate,
        publicHolidayRate: publicHolidayRate,
        eveningShiftRate: eveningShiftRate,
        nightShiftRate: nightShiftRate,
        date: date,
        isHoliday: isHoliday,
        startTime: startTime,
        endTime: endTime,
      );
    }

    test('Public Holiday should have highest priority', () {
      final date = DateTime(2023, 10, 2); // Monday
      final result = calc(date: date, isHoliday: true);

      expect(result['rate'], 55.0);
      expect(result['source'], 'EMP_PUBLIC_HOLIDAY');
    });

    test('Sunday rate should apply on Sundays', () {
      final date = DateTime(2023, 10, 1); // Sunday
      final result = calc(date: date, isHoliday: false);

      expect(result['rate'], 45.0);
      expect(result['source'], 'EMP_SUNDAY');
    });

    test('Saturday rate should apply on Saturdays', () {
      final date = DateTime(2023, 9, 30); // Saturday
      final result = calc(date: date, isHoliday: false);

      expect(result['rate'], 35.0);
      expect(result['source'], 'EMP_SATURDAY');
    });

    test('Public Holiday rate should override Sunday rate', () {
      final date = DateTime(2023, 10, 1); // Sunday
      final result = calc(date: date, isHoliday: true); // Also a holiday

      expect(result['rate'], 55.0); // Holiday > Sunday
      expect(result['source'], 'EMP_PUBLIC_HOLIDAY');
    });

    test('Base rate should apply on normal weekday', () {
      final date = DateTime(2023, 10, 2); // Monday
      final result = calc(
        date: date,
        isHoliday: false,
        startTime: '09:00 AM',
        endTime: '05:00 PM',
      );

      expect(result['rate'], 25.0);
      expect(result['source'], 'EMP_BASE');
    });

    test('Evening shift should apply when finishing after 8 PM', () {
      final date = DateTime(2023, 10, 2); // Monday
      // 2:00 PM to 9:00 PM (finishes after 8 PM)
      final result = calc(
        date: date,
        startTime: '02:00 PM',
        endTime: '09:00 PM',
      );

      expect(result['rate'], 28.0);
      expect(result['source'], 'EMP_EVENING_SHIFT');
    });

    test('Night shift should apply when starting before 6 AM', () {
      final date = DateTime(2023, 10, 2); // Monday
      // 4:00 AM to 12:00 PM
      final result = calc(
        date: date,
        startTime: '04:00 AM',
        endTime: '12:00 PM',
      );

      expect(result['rate'], 30.0);
      expect(result['source'], 'EMP_NIGHT_SHIFT');
    });

    test('Night shift should apply when crossing midnight (Overnight)', () {
      final date = DateTime(2023, 10, 2); // Monday
      // 10:00 PM to 6:00 AM (next day)
      // Note: Calculator assumes end < start means overnight
      final result = calc(
        date: date,
        startTime: '10:00 PM',
        endTime: '06:00 AM',
      );

      expect(result['rate'], 30.0);
      expect(result['source'], 'EMP_NIGHT_SHIFT');
    });

    test('Fallback to Base Rate if special rate is 0', () {
      final date = DateTime(2023, 10, 1); // Sunday
      // Sunday rate is 0, Base is 25
      final result = calc(date: date, sundayRate: 0.0, baseRate: 25.0);

      expect(result['rate'], 25.0);
      expect(
        result['source'],
        'EMP_SUNDAY',
      ); // It keeps source label but uses base value logic in code?
      // Wait, let's check code logic:
      // if (date.weekday == DateTime.sunday) {
      //   final sun = sundayRate.toDouble();
      //   final chosen = sun > 0 ? sun : base;
      //   return {'rate': chosen, 'source': 'EMP_SUNDAY'};
      // }
      // Yes, it returns EMP_SUNDAY source even if using base rate. Correct.
    });

    test('Time parsing handles "at" format', () {
      final date = DateTime(2023, 10, 2);
      // "04:00 AM at Client Location" - sanitization check
      final result = calc(
        date: date,
        startTime: '04:00 AM at Home',
        endTime: '12:00 PM',
      );

      expect(result['rate'], 30.0); // Night shift
      expect(result['source'], 'EMP_NIGHT_SHIFT');
    });
  });
}
