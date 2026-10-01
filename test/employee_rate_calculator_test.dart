import 'package:flutter_test/flutter_test.dart';
import 'package:carenest/app/features/invoice/utils/employee_rate_calculator.dart';

void main() {
  group('calculateEmployeeRateDecision', () {
    test('uses base rate on weekday', () {
      final d = DateTime(2026, 1, 14); // Wednesday
      final decision = calculateEmployeeRateDecision(
        baseRate: 27.74,
        saturdayRate: 0,
        sundayRate: 0,
        publicHolidayRate: 0,
        eveningShiftRate: 0,
        nightShiftRate: 0,
        date: d,
        isHoliday: false,
      );
      expect(decision['rate'], 27.74);
      expect(decision['source'], 'EMP_BASE');
    });

    test('uses saturday rate when set', () {
      final d = DateTime(2026, 1, 17); // Saturday
      final decision = calculateEmployeeRateDecision(
        baseRate: 27.74,
        saturdayRate: 41.61,
        sundayRate: 0,
        publicHolidayRate: 0,
        eveningShiftRate: 0,
        nightShiftRate: 0,
        date: d,
        isHoliday: false,
      );
      expect(decision['rate'], 41.61);
      expect(decision['source'], 'EMP_SATURDAY');
    });

    test('falls back to base on saturday when saturday rate missing', () {
      final d = DateTime(2026, 1, 17); // Saturday
      final decision = calculateEmployeeRateDecision(
        baseRate: 27.74,
        saturdayRate: 0,
        sundayRate: 0,
        publicHolidayRate: 0,
        eveningShiftRate: 0,
        nightShiftRate: 0,
        date: d,
        isHoliday: false,
      );
      expect(decision['rate'], 27.74);
      expect(decision['source'], 'EMP_SATURDAY');
    });

    test('uses sunday rate when set', () {
      final d = DateTime(2026, 1, 18); // Sunday
      final decision = calculateEmployeeRateDecision(
        baseRate: 27.74,
        saturdayRate: 0,
        sundayRate: 55.48,
        publicHolidayRate: 0,
        eveningShiftRate: 0,
        nightShiftRate: 0,
        date: d,
        isHoliday: false,
      );
      expect(decision['rate'], 55.48);
      expect(decision['source'], 'EMP_SUNDAY');
    });

    test('uses public holiday rate when set', () {
      final d = DateTime(2026, 1, 26); // Australia Day (example)
      final decision = calculateEmployeeRateDecision(
        baseRate: 27.74,
        saturdayRate: 0,
        sundayRate: 0,
        publicHolidayRate: 69.35,
        eveningShiftRate: 0,
        nightShiftRate: 0,
        date: d,
        isHoliday: true,
      );
      expect(decision['rate'], 69.35);
      expect(decision['source'], 'EMP_PUBLIC_HOLIDAY');
    });

    test('falls back to base on public holiday when holiday rate missing', () {
      final d = DateTime(2026, 1, 26);
      final decision = calculateEmployeeRateDecision(
        baseRate: 27.74,
        saturdayRate: 0,
        sundayRate: 0,
        publicHolidayRate: 0,
        eveningShiftRate: 0,
        nightShiftRate: 0,
        date: d,
        isHoliday: true,
      );
      expect(decision['rate'], 27.74);
      expect(decision['source'], 'EMP_PUBLIC_HOLIDAY');
    });
  });
}
