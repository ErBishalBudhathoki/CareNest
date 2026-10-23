import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/invoice_providers.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/backend/api_method.dart';

class FakeApiMethod extends ApiMethod {
  @override
  Future<Map<String, dynamic>> getUserPayDetails(
    String userEmail, {
    String? organizationId,
  }) async {
    return {
      'success': true,
      'data': {
        'id': 'emp_1',
        'organizationId': 'org_1',
        'name': 'Test Employee',
        'email': userEmail,
        'phone': '0400000000',
        'role': 'employee',
        'payRate': 34.44,
        'employmentType': 'Casual',
        'rates': {
          'baseRate': 34.44,
          'saturdayRate': 48.22,
          'sundayRate': 68.88,
          'publicHolidayRate': 86.10,
          'overtimeRate': 48.22,
          'overtimeRate2': 68.88,
          'nightShiftRate': 39.61,
          'eveningShiftRate': 38.75,
        },
      },
    };
  }

  @override
  Future<Map<String, dynamic>> getQuarterlyOTE(
    String userEmail, {
    String? date,
  }) async {
    return {'success': true, 'data': 0.0};
  }

  @override
  Future<double?> getFallbackBaseRate(String organizationId) async {
    return null;
  }
}

void main() {
  group('Employee Overtime Calculation Test', () {
    test('processInvoiceData splits a >8h weekday shift into 8h + 2h OT1 + rest OT2', () async {
      final container = ProviderContainer(
        overrides: [
          app_providers.apiMethodProvider.overrideWithValue(FakeApiMethod()),
        ],
      );

      final processor = container.read(invoiceDataProcessorProvider);

      // Construct assignedClients with a shift of 10.1814 hours
      final assignedClients = {
        'clients': [
          {
            'clientId': 'client_123',
            'clientEmail': 'client@example.com',
            'clientFirstName': 'Client',
            'clientLastName': 'Name',
            'workedTimeData': {
              'success': true,
              'workedTimes': [
                {
                  'actualWorkedTime': 10.1814,
                  'correspondingSchedule': {
                    'date': '2026-05-20', // Wednesday
                    'startTime': '08:00',
                    'endTime': '18:10', // ~10 hours worked
                    'ndisItem': {
                      'itemNumber': '01_011_0107_1_1',
                      'itemName': 'Assistance with self-care',
                    },
                  },
                },
              ],
            },
            'assignments': [
              {
                'clientEmail': 'client@example.com',
                'userEmail': 'employee@example.com',
                'schedule': [
                  {
                    'date': '2026-05-20',
                    'startTime': '08:00',
                    'endTime': '18:10',
                    'ndisItem': {
                      'itemNumber': '01_011_0107_1_1',
                      'itemName': 'Assistance with self-care',
                    },
                  },
                ],
              },
            ],
          },
        ],
        'clientDetail': <Map<String, dynamic>>[
          {
            'clientEmail': 'client@example.com',
            'firstName': 'Client',
            'lastName': 'Name',
          },
        ],
      };

      final result = await processor.processInvoiceData(
        assignedClients: assignedClients,
        lineItems: [],
        invoiceType: 'employee',
      );

      expect(result.containsKey('clients'), isTrue);
      final clientsResult = result['clients'] as List;
      expect(clientsResult.length, equals(1));

      final clientData = clientsResult.first as Map<String, dynamic>;
      expect(clientData.containsKey('items'), isTrue);

      final items = clientData['items'] as List;
      print('Generated items count: ${items.length}');
      for (var item in items) {
        print(
          'Item: ${item['itemName']}, hours: ${item['hours']}, rate: ${item['rate']}, amount: ${item['amount']}',
        );
      }

      // Standard weekday: 8h ordinary, first 2h of OT, remainder at OT2.
      expect(items.length, equals(3));

      final ordinaryItem = items.firstWhere(
        (i) => i['itemName'] == 'Evening Shift',
      );
      expect(ordinaryItem['hours'], equals(8.0));
      expect(ordinaryItem['rate'], equals(38.75));
      expect(ordinaryItem['amount'], closeTo(310.0, 0.01));

      final overtimeFirst = items.firstWhere(
        (i) => i['itemName'] == 'Overtime (first 2h)',
      );
      expect(overtimeFirst['hours'], equals(2.0));
      expect(overtimeFirst['rate'], equals(48.22));
      expect(overtimeFirst['amount'], closeTo(96.44, 0.01));

      final overtimeSecond = items.firstWhere(
        (i) => i['itemName'] == 'Overtime (>2h)',
      );
      expect(overtimeSecond['hours'], closeTo(0.18, 0.01));
      expect(overtimeSecond['rate'], equals(68.88));
      expect(overtimeSecond['amount'], closeTo(12.40, 0.05));
    });

    test('weekend shifts are not overtime-split', () async {
      final container = ProviderContainer(
        overrides: [
          app_providers.apiMethodProvider.overrideWithValue(FakeApiMethod()),
        ],
      );

      final processor = container.read(invoiceDataProcessorProvider);

      // 2026-05-23 is a Saturday. 10 hours are all paid at the Saturday rate,
      // with no daily overtime split (SCHADS OT applies to standard days).
      final assignedClients = {
        'clients': [
          {
            'clientId': 'client_123',
            'clientEmail': 'client@example.com',
            'clientFirstName': 'Client',
            'clientLastName': 'Name',
            'workedTimeData': {
              'success': true,
              'workedTimes': [
                {
                  'actualWorkedTime': 10.0,
                  'correspondingSchedule': {
                    'date': '2026-05-23',
                    'startTime': '08:00',
                    'endTime': '18:00',
                  },
                },
              ],
            },
            'assignments': [
              {
                'clientEmail': 'client@example.com',
                'userEmail': 'employee@example.com',
                'schedule': [
                  {
                    'date': '2026-05-23',
                    'startTime': '08:00',
                    'endTime': '18:00',
                  },
                ],
              },
            ],
          },
        ],
        'clientDetail': <Map<String, dynamic>>[
          {
            'clientEmail': 'client@example.com',
            'firstName': 'Client',
            'lastName': 'Name',
          },
        ],
      };

      final result = await processor.processInvoiceData(
        assignedClients: assignedClients,
        lineItems: [],
        invoiceType: 'employee',
      );

      final items =
          (result['clients'] as List).first['items'] as List;
      final overtime = items.where((i) => i['rateSource'] == 'EMP_OVERTIME');
      expect(overtime, isEmpty);
      expect(items, hasLength(1));
      expect(items.first['hours'], equals(10.0));
      expect(items.first['rate'], equals(48.22)); // Saturday rate
    });

    test(
      'EnhancedInvoiceService recalculates employee invoice totals correctly and aligns lineItems',
      () {
        final container = ProviderContainer(
          overrides: [
            app_providers.apiMethodProvider.overrideWithValue(FakeApiMethod()),
          ],
        );

        final service = container.read(enhancedInvoiceServiceProvider);

        // Create a mock employee client map that only has 'items' (no lineItems)
        // which is what the data processor returns. Service items only have 'amount'.
        final client = <String, dynamic>{
          'items': [
            {
              'itemName': 'Weekday Ordinary',
              'hours': 8.0,
              'rate': 34.44,
              'amount': 275.52,
            },
            {
              'itemName': 'Overtime (first 2h)',
              'hours': 2.0,
              'rate': 48.22,
              'amount': 96.44,
            },
            {
              'itemName': 'Overtime (>2h)',
              'hours': 0.1814,
              'rate': 68.88,
              'amount': 12.49,
            },
          ],
        };

        // Call testRecalculateInvoiceTotal
        service.testRecalculateInvoiceTotal(client, applyTax: false);

        // Verify lineItems was aligned with items
        expect(client.containsKey('lineItems'), isTrue);
        final lineItems = client['lineItems'] as List;
        expect(lineItems.length, equals(3));
        expect(identical(client['items'], client['lineItems']), isTrue);

        // Verify totals are recalculated correctly using fallback to amount
        expect(client['itemsSubtotal'], closeTo(384.45, 0.05));
        expect(client['subtotal'], closeTo(384.45, 0.05));
        expect(client['total'], closeTo(384.45, 0.05));
      },
    );
  });
}
