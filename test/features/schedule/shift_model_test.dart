import 'package:carenest/app/features/schedule/models/shift_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Shift Model Tests', () {
    test('durationHours should be correct', () {
      final startTime = DateTime(2023, 10, 1, 9, 0); // 9:00 AM
      final endTime = DateTime(2023, 10, 1, 17, 0); // 5:00 PM
      // 8 hours total, minus 30 min break = 7.5 hours

      final shift = ShiftModel(
        id: '1',
        organizationId: 'org',
        startTime: startTime,
        endTime: endTime,
        breakDuration: 30,
      );

      expect(shift.durationHours, 7.5);
    });

    test('isActive should be true if current time is within shift', () {
      // Mocking DateTime.now() is hard in Dart without a clock wrapper.
      // So we will set start/end relative to "now".
      final now = DateTime.now();
      final startTime = now.subtract(const Duration(hours: 1));
      final endTime = now.add(const Duration(hours: 1));

      final shift = ShiftModel(
        id: '1',
        organizationId: 'org',
        startTime: startTime,
        endTime: endTime,
      );

      expect(shift.isActive, true);
      expect(shift.isPast, false);
      expect(shift.isUpcoming, false);
    });

    test('isPast should be true if shift ended', () {
      final now = DateTime.now();
      final startTime = now.subtract(const Duration(hours: 2));
      final endTime = now.subtract(const Duration(hours: 1));

      final shift = ShiftModel(
        id: '1',
        organizationId: 'org',
        startTime: startTime,
        endTime: endTime,
      );

      expect(shift.isActive, false);
      expect(shift.isPast, true);
      expect(shift.isUpcoming, false);
    });

    test('isUpcoming should be true if shift hasn\'t started', () {
      final now = DateTime.now();
      final startTime = now.add(const Duration(hours: 1));
      final endTime = now.add(const Duration(hours: 2));

      final shift = ShiftModel(
        id: '1',
        organizationId: 'org',
        startTime: startTime,
        endTime: endTime,
      );

      expect(shift.isActive, false);
      expect(shift.isPast, false);
      expect(shift.isUpcoming, true);
    });

    test('fromJson should parse nested objects', () {
      final json = {
        'id': 'shift_1',
        'organizationId': 'org_1',
        'startTime': '2023-10-01T09:00:00.000',
        'endTime': '2023-10-01T17:00:00.000',
        'location': {
          'type': 'Point',
          'coordinates': [151.2093, -33.8688], // Long, Lat
        },
        'supportItems': [
          {
            'itemNumber': '01_011_0107_1_1',
            'itemName': 'Assistance with Self-Care',
          },
        ],
        'status': 'approved',
      };

      final shift = ShiftModel.fromJson(json);

      expect(shift.id, 'shift_1');
      expect(shift.location, isNotNull);
      expect(shift.location!.longitude, 151.2093);
      expect(shift.location!.latitude, -33.8688);
      expect(shift.supportItems.length, 1);
      expect(shift.supportItems.first.itemNumber, '01_011_0107_1_1');
      expect(shift.status, ShiftStatus.approved);
    });
  });
}
