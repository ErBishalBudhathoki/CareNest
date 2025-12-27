import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:carenest/app/features/invoice/utils/invoice_data_processor.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/invoice/viewmodels/line_items_viewmodel.dart';
import 'package:carenest/backend/api_method.dart';

// Mock ApiMethod to satisfy LineItemViewModel dependency
class MockApiMethod extends Mock implements ApiMethod {}

/// Minimal concrete ApiMethod to satisfy LineItemViewModel when avoiding mocks.

/// Test-specific subclass of LineItemViewModel that returns empty support items
class TestLineItemViewModel extends LineItemViewModel {
  TestLineItemViewModel(super.api);

  @override
  Future<List<Map<String, dynamic>>> getSupportItems() async {
    return <Map<String, dynamic>>[];
  }
}

/// Lightweight fake Ref to stub provider reads in tests.
class FakeRef implements Ref {
  final Map<Object, Object> _overrides;
  FakeRef(this._overrides);

  @override
  T read<T>(ProviderListenable<T> provider) {
    final value = _overrides[provider];
    if (value == null) {
      throw StateError('Provider read not stubbed: $provider');
    }
    return value as T;
  }

  @override
  T watch<T>(ProviderListenable<T> provider) => read(provider);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late FakeRef fakeRef;
  late MockApiMethod mockApiMethod;
  late InvoiceDataProcessor processor;

  setUp(() {
    mockApiMethod = MockApiMethod();
    // Use a test-specific viewmodel to avoid complex mocking
    final lineItemVM = TestLineItemViewModel(mockApiMethod);

    fakeRef = FakeRef({
      lineItemViewModelProvider.notifier: lineItemVM,
      // Optionally provide base state
      lineItemViewModelProvider: <Map<String, dynamic>>[],
      apiMethodProvider: mockApiMethod,
    });

    processor = InvoiceDataProcessor(fakeRef);
  });

  group('Date range filtering', () {
    test('filters worked time entries outside selected range', () async {
      final Map<String, dynamic> assignedClients = {
        'clients': [
          {
            'clientId': 'CID-1',
            'clientEmail': 'client@example.com',
            'workedTimeData': {
              'success': true,
              'workedTimes': [
                {
                  'correspondingSchedule': {
                    'date': '2025-07-11',
                    'startTime': '6:00 AM',
                    'endTime': '7:00 AM',
                    'clientState': 'NSW',
                    'ndisItem': {'itemNumber': '04_101_0104_1_1', 'itemName': 'Assistance'}
                  },
                  'actualWorkedTime': 1.0
                },
                {
                  'correspondingSchedule': {
                    'date': '2025-07-30',
                    'startTime': '8:00 AM',
                    'endTime': '9:00 AM',
                    'clientState': 'NSW',
                    'ndisItem': {'itemNumber': '04_101_0104_1_1', 'itemName': 'Assistance'}
                  },
                  'actualWorkedTime': 1.0
                }
              ]
            },
            'assignments': [
              {
                'schedule': [
                  {
                    'date': '2025-07-11',
                    'startTime': '6:00 AM',
                    'endTime': '7:00 AM',
                    'clientState': 'NSW',
                    'ndisItem': {'itemNumber': '04_101_0104_1_1', 'itemName': 'Assistance'}
                  },
                  {
                    'date': '2025-07-30',
                    'startTime': '8:00 AM',
                    'endTime': '9:00 AM',
                    'clientState': 'NSW',
                    'ndisItem': {'itemNumber': '04_101_0104_1_1', 'itemName': 'Assistance'}
                  }
                ],
              }
            ]
          }
        ],
        'clientDetail': <dynamic>[
          {
            'clientEmail': 'client@example.com',
            'clientFirstName': 'John',
            'clientLastName': 'Doe',
            'clientState': 'NSW'
          }
        ]
      };

      final supportItems = [
        {
          'itemNumber': '04_101_0104_1_1',
          'itemDescription': 'Assistance',
          'price': 50.0
        }
      ];

      final result = await processor.processInvoiceData(
        assignedClients: assignedClients,
        lineItems: supportItems,
        startDate: DateTime(2025, 7, 7),
        endDate: DateTime(2025, 7, 14),
      );

      final clients = result['clients'] as List<dynamic>;
      final items = clients.first['items'] as List<dynamic>;
      expect(items.length, 1);
      expect(items.first['date'], '2025-07-11');
    });

    test('filters calculated schedule entries outside selected range', () async {
      final Map<String, dynamic> assignedClients = {
        'userDocs': [
          {
            'docs': [
              {
                'clientEmail': 'client2@example.com',
                'userEmail': 'employee@example.com',
                'dateList': ['2025-07-12', '2025-08-02'],
                'startTimeList': ['12:00 PM', '9:00 PM'],
                'endTimeList': ['2:00 PM', '10:00 PM'],
                'Time': ['00:00', '00:00'],
              }
            ]
          }
        ],
        'clientDetail': <dynamic>[
          {
            'clientEmail': 'client2@example.com',
            'clientFirstName': 'Alex',
            'clientLastName': 'Smith',
            'clientState': 'NSW'
          }
        ]
      };

      final supportItems = [
        {
          'itemNumber': '04_101_0104_1_1',
          'itemDescription': 'Assistance',
          'price': 50.0
        }
      ];

      final result = await processor.processInvoiceData(
        assignedClients: assignedClients,
        lineItems: supportItems,
        startDate: DateTime(2025, 7, 7),
        endDate: DateTime(2025, 7, 14),
      );

      final clients = result['clients'] as List<dynamic>;
      final items = clients.first['items'] as List<dynamic>;
      // Only 2025-07-12 is in-range, 2025-08-02 should be filtered out
      expect(items.length, 1);
      expect(items.first['date'], '2025-07-12');
    });
  });
}