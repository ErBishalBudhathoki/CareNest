// Milestone 3.3: Flutter sleepover disturbance & cancellation integration tests
import 'package:carenest/app/core/services/offline/worked_time_queue_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Milestone 3.3 - Sleepover Disturbance Payload & Queue Serialization', () {
    test('WorkedTimeQueueService accepts disturbance fields', () async {
      // Verifies that enqueue signature accepts shiftType, disturbances, and convertedToActiveNight
      expect(
        () => WorkedTimeQueueService.instance.enqueue(
          userEmail: 'worker@test.com',
          clientEmail: 'client@test.com',
          workedTime: '08:00:00',
          shiftIndex: 0,
          shiftType: 'sleepover',
          disturbances: [
            {
              'startTime': '2026-10-24T01:00:00.000Z',
              'endTime': '2026-10-24T02:15:00.000Z',
              'durationMinutes': 75,
              'reason': 'Nocturnal assistance and de-escalation',
            }
          ],
          convertedToActiveNight: true,
          clientRequestId: 'test-req-123',
        ),
        returnsNormally,
      );
    });
  });
}
