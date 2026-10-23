import 'package:carenest/app/features/invoice/utils/invoice_helpers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final helpers = InvoiceHelpers();

  group('hoursFromTimeString', () {
    test('parses HH:mm:ss without truncating minutes or seconds', () {
      expect(helpers.hoursFromTimeString('01:30:00'), closeTo(1.5, 1e-9));
      expect(helpers.hoursFromTimeString('00:30:00'), closeTo(0.5, 1e-9));
      expect(
        helpers.hoursFromTimeString('02:15:30'),
        closeTo(2 + 15 / 60 + 30 / 3600, 1e-9),
      );
    });

    test('accepts numeric hours', () {
      expect(helpers.hoursFromTimeString('7.5'), 7.5);
      expect(helpers.hoursFromTimeString('8'), 8.0);
    });

    test('returns 0 for empty/unparseable input', () {
      expect(helpers.hoursFromTimeString(''), 0.0);
      expect(helpers.hoursFromTimeString('not-a-time'), 0.0);
    });
  });

  group('hoursBetweenPerListItem', () {
    test('same-day shift', () {
      expect(helpers.hoursBetweenPerListItem('09:00', '11:00'), closeTo(2, 1e-9));
      expect(
        helpers.hoursBetweenPerListItem('09:15', '17:45'),
        closeTo(8.5, 1e-9),
      );
    });

    test('overnight shift rolls end time to the next day', () {
      expect(helpers.hoursBetweenPerListItem('22:00', '01:00'), closeTo(3, 1e-9));
      expect(
        helpers.hoursBetweenPerListItem('11:00 PM', '01:00 AM'),
        closeTo(2, 1e-9),
      );
      expect(
        helpers.hoursBetweenPerListItem('23:30', '00:15'),
        closeTo(0.75, 1e-9),
      );
    });

    test('handles 12-hour clock input', () {
      expect(
        helpers.hoursBetweenPerListItem('9:00 AM', '5:00 PM'),
        closeTo(8, 1e-9),
      );
      expect(
        helpers.hoursBetweenPerListItem('9:30 AM', '5:00 PM'),
        closeTo(7.5, 1e-9),
      );
    });

    test('returns 0 for empty input', () {
      expect(helpers.hoursBetweenPerListItem('', '10:00'), 0.0);
      expect(helpers.hoursBetweenPerListItem('09:00', ''), 0.0);
    });
  });

  group('calculateTotalHours', () {
    test('prefers the recorded worked time', () {
      final hours = helpers.calculateTotalHours(
        ['09:00'],
        ['17:00'],
        ['02:30:00'],
      );
      expect(hours.single, closeTo(2.5, 1e-9));
    });

    test('falls back to schedule times when worked time is missing', () {
      final hours = helpers.calculateTotalHours(
        ['09:00', '22:00'],
        ['11:00', '01:00'],
        ['', ''],
      );
      expect(hours, hasLength(2));
      expect(hours[0], closeTo(2, 1e-9));
      expect(hours[1], closeTo(3, 1e-9));
    });
  });
}
