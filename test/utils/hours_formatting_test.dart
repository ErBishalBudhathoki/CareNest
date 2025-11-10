import 'package:flutter_test/flutter_test.dart';
import 'package:carenest/utils/hours_formatting.dart';

void main() {
  group('HoursFormatting.formatDecimalHours', () => {
    test('formats whole hours to 2 decimals', () {
      expect(HoursFormatting.formatDecimalHours(1.0), '1.00');
      expect(HoursFormatting.formatDecimalHours(0.0), '0.00');
    }),

    test('caps at 4 decimals and trims trailing zeros', () {
      expect(HoursFormatting.formatDecimalHours(1.23), '1.23'); // 1.2300 -> 1.23
      expect(HoursFormatting.formatDecimalHours(1.23008), '1.2301'); // rounded to 4
    }),

    test('shows tiny seconds up to 4 decimals', () {
      expect(HoursFormatting.formatDecimalHours(0.0008333), '0.0008');
    }),

    test('handles seconds in hours with 4 decimals', () {
      expect(HoursFormatting.formatDecimalHours(1.003611), '1.0036');
    }),

    test('pads decimals when needed', () {
      expect(HoursFormatting.formatDecimalHours(0.5), '0.50');
      expect(HoursFormatting.formatDecimalHours(2.2), '2.20');
    }),
  });
}