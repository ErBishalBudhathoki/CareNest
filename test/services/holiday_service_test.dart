import 'package:carenest/app/features/holiday/services/holiday_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HolidayService.normalizeStateCode', () {
    test('accepts two- and three-letter codes', () {
      expect(HolidayService.normalizeStateCode('NSW'), 'NSW');
      expect(HolidayService.normalizeStateCode('nsw'), 'NSW');
      expect(HolidayService.normalizeStateCode('ACT'), 'ACT');
    });

    test('accepts Nager county format', () {
      expect(HolidayService.normalizeStateCode('AU-VIC'), 'VIC');
    });

    test('accepts full state names', () {
      expect(HolidayService.normalizeStateCode('New South Wales'), 'NSW');
      expect(HolidayService.normalizeStateCode('victoria'), 'VIC');
      expect(HolidayService.normalizeStateCode('Western Australia'), 'WA');
    });

    test('returns null for missing values', () {
      expect(HolidayService.normalizeStateCode(null), isNull);
      expect(HolidayService.normalizeStateCode(''), isNull);
      expect(HolidayService.normalizeStateCode('   '), isNull);
    });
  });
}
