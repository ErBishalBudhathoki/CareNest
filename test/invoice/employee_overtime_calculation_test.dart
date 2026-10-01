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
    test('processInvoiceData splits shift exceeding 10 hours correctly', () async {
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

      // We expect two items: Weekday Ordinary (capped at 10.0) and Overtime (0.1814)
      expect(items.length, equals(2));

      final ordinaryItem = items.firstWhere(
        (i) => i['itemName'] == 'Weekday Ordinary',
      );
      expect(ordinaryItem['hours'], equals(10.0));
      expect(ordinaryItem['rate'], equals(34.44));
      expect(ordinaryItem['amount'], equals(344.4));

      final overtimeItem = items.firstWhere(
        (i) => i['itemName'] == 'Overtime (>10h Shift)',
      );
      expect(overtimeItem['hours'], closeTo(0.18, 0.01));
      expect(overtimeItem['rate'], equals(48.22));
      expect(overtimeItem['amount'], closeTo(8.75, 0.1));
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
              'hours': 10.0,
              'rate': 34.44,
              'amount': 344.40,
            },
            {
              'itemName': 'Overtime (>10h Shift)',
              'hours': 0.1814,
              'rate': 48.22,
              'amount': 8.75,
            },
          ],
        };

        // Call testRecalculateInvoiceTotal
        service.testRecalculateInvoiceTotal(client, applyTax: false);

        // Verify lineItems was aligned with items
        expect(client.containsKey('lineItems'), isTrue);
        final lineItems = client['lineItems'] as List;
        expect(lineItems.length, equals(2));
        expect(identical(client['items'], client['lineItems']), isTrue);

        // Verify totals are recalculated correctly using fallback to amount
        expect(client['itemsSubtotal'], closeTo(353.15, 0.01));
        expect(client['subtotal'], closeTo(353.15, 0.01));
        expect(client['total'], closeTo(353.15, 0.01));
      },
    );
  });
}
