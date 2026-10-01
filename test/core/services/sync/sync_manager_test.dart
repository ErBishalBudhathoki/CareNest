import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';
import 'package:carenest/app/core/services/sync/sync_manager.dart';

// Generate mocks
@GenerateMocks([Connectivity, Box])
import 'sync_manager_test.mocks.dart';

void main() {
  late SyncManager syncManager;
  late MockConnectivity mockConnectivity;
  late MockBox<String> mockBox;

  setUp(() {
    mockConnectivity = MockConnectivity();
    mockBox = MockBox<String>();

    // Inject mock connectivity
    syncManager = SyncManager(connectivity: mockConnectivity);
    // Inject mock box
    syncManager.setQueueBox(mockBox);
  });

  group('SyncManager Tests', () {
    test('queueRequest adds item to Hive box', () async {
      final endpoint = '/api/test';
      final method = 'POST';
      final body = {'key': 'value'};

      // Stub put
      when(mockBox.put(any, any)).thenAnswer((_) async => {});

      await syncManager.queueRequest(endpoint, method, body: body);

      // Verify put was called
      verify(mockBox.put(any, any)).called(1);
    });

    test('processQueue processes items when online', () async {
      // Setup mock data
      final item = SyncQueueItem(
        id: '123',
        endpoint: '/api/test',
        method: 'POST',
        timestamp: DateTime.now(),
      );
      final jsonItem = jsonEncode(item.toJson());

      // Stub getQueue behavior
      when(mockBox.values).thenReturn([jsonItem]);
      when(mockBox.isEmpty).thenReturn(false);

      // Stub delete
      when(mockBox.delete(any)).thenAnswer((_) async => {});

      // Setup request performer to succeed
      bool requestCalled = false;
      syncManager.requestPerformer = (item) async {
        requestCalled = true;
        return true; // Success
      };

      // Execute
      await syncManager.processQueue();

      // Verify
      expect(requestCalled, true);
      verify(mockBox.delete('123')).called(1);
    });

    test('processQueue does NOT delete item on failure', () async {
      // Setup mock data
      final item = SyncQueueItem(
        id: '123',
        endpoint: '/api/test',
        method: 'POST',
        timestamp: DateTime.now(),
      );
      final jsonItem = jsonEncode(item.toJson());

      when(mockBox.values).thenReturn([jsonItem]);
      when(mockBox.isEmpty).thenReturn(false);

      // Setup request performer to fail
      syncManager.requestPerformer = (item) async {
        return false; // Failure
      };

      // Execute
      await syncManager.processQueue();

      // Verify delete was NOT called
      verifyNever(mockBox.delete(any));
    });
  });
}
