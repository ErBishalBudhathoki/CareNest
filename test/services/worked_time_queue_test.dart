import 'dart:io';

import 'package:carenest/app/core/services/offline/worked_time_queue_service.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

class _FakeApi extends ApiMethod {
  int calls = 0;
  bool failPermanently = false;

  @override
  Future<dynamic> setWorkedTime(
    String userEmail,
    String clientEmail,
    String workedTime,
    int shiftIndex, {
    String? shiftDate,
    String? shiftStartTime,
    String? shiftEndTime,
    dynamic shiftBreak,
    String? clientRequestId,
  }) async {
    calls += 1;
    if (failPermanently) {
      throw Exception('Bad request, please check your input data');
    }
    return {'success': true};
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;

  setUpAll(() async {
    tempDir = await Directory.systemTemp.createTemp('worked_time_queue_test');
    Hive.init(tempDir.path);
  });

  tearDownAll(() async {
    await Hive.close();
    await tempDir.delete(recursive: true);
  });

  setUp(() async {
    await Hive.deleteFromDisk();
  });

  test('queues an offline save and replays it', () async {
    final queue = WorkedTimeQueueService.instance;
    await queue.enqueue(
      userEmail: 'worker@example.com',
      clientEmail: 'sil.ndia@mailinator.com',
      workedTime: '08:00:00',
      shiftIndex: 0,
      shiftDate: '2026-10-24',
      shiftStartTime: '15:00',
      shiftEndTime: '23:00',
      shiftBreak: '00:30',
    );

    expect(await queue.pendingCount(), 1);

    final api = _FakeApi();
    final synced = await queue.flush(api);
    expect(synced, 1);
    expect(api.calls, 1);
    expect(await queue.pendingCount(), 0);
  });

  test(
    'drops a permanently invalid save instead of retrying forever',
    () async {
      final queue = WorkedTimeQueueService.instance;
      await queue.enqueue(
        userEmail: 'worker@example.com',
        clientEmail: 'sil.ndia@mailinator.com',
        workedTime: '08:00:00',
        shiftIndex: 0,
        shiftDate: '2026-10-24',
        shiftStartTime: '15:00',
        shiftEndTime: '23:00',
      );

      final api = _FakeApi()..failPermanently = true;
      final synced = await queue.flush(api);
      expect(synced, 0);
      expect(await queue.pendingCount(), 0);
    },
  );
}
