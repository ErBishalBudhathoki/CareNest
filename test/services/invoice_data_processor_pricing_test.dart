import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:carenest/app/features/invoice/utils/invoice_data_processor.dart';
import 'package:carenest/app/features/invoice/services/enhanced_invoice_service.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/features/invoice/viewmodels/line_items_viewmodel.dart';
import 'package:carenest/backend/api_method.dart';

// Mock ApiMethod for stubbing backend interactions.
class MockApiMethod extends Mock implements ApiMethod {}

/// Simple stubbed API method to provide canned responses for processor tests.
class StubApiMethod extends Mock implements ApiMethod {
  Map<String, dynamic>? bulkReturn;
  List<Map<String, dynamic>>? priceHistoryReturn;

  @override
  Future<Map<String, dynamic>?> getBulkPricingLookup(
    String organizationId,
    List<String> supportItemNumbers, {
    String? clientId,
  }) async {
    return bulkReturn;
  }

  @override
  Future<List<Map<String, dynamic>>?> getPriceHistory(
    String ndisItemNumber,
    String clientId,
  ) async {
    return priceHistoryReturn ?? <Map<String, dynamic>>[];
  }
}

/// Test-specific LineItemViewModel that returns an empty list to satisfy dependencies.
class TestLineItemViewModel extends LineItemViewModel {
  @override
  Future<List<Map<String, dynamic>>> getSupportItems() async {
    return <Map<String, dynamic>>[];
  }
}

void main() {
  late Ref ref;
  late StubApiMethod mockApiMethod;
  late InvoiceDataProcessor processor;

  setUp(() {
    mockApiMethod = StubApiMethod();

    final container = ProviderContainer(
      overrides: [
        app_providers.lineItemViewModelProvider.overrideWith(
          TestLineItemViewModel.new,
        ),
        app_providers.apiMethodProvider.overrideWith((ref) => mockApiMethod),
      ],
    );
    addTearDown(container.dispose);

    ref = container.read(Provider<Ref>((ref) => ref));
    processor = InvoiceDataProcessor(ref);
  });

  group('Bulk pricing via cached data', () {
    /// Ensures that when bulk pricing provides a fallback base rate (`price`),
    /// the data processor uses it as the item rate for entries with item numbers.
    test(
      'Uses organization fallback base rate from bulk when item number present',
      () async {
        // Provide canned bulk pricing data via stub.
        mockApiMethod.bulkReturn = {
          'ITEM_B': {'price': 62.375},
          'ITEM_A': {'customPrice': 75.5},
        };
        mockApiMethod.priceHistoryReturn = <Map<String, dynamic>>[];

        // Prepare assignedClients data using calculated schedule entries with NDIS items.
        final Map<String, dynamic> assignedClients = {
          'clients': [
            {
              'clientId': 'CID-1',
              'clientEmail': 'client@example.com',
              'assignments': [
                {
                  'dateList': ['2025-07-12', '2025-07-13'],
                  'startTimeList': ['9:00 AM', '1:00 PM'],
                  'endTimeList': ['11:00 AM', '3:00 PM'],
                  'Time': ['02:00', '02:00'],
                  'schedule': [
                    {
                      'date': '2025-07-12',
                      'startTime': '9:00 AM',
                      'endTime': '11:00 AM',
                      'clientState': 'NSW',
                      'ndisItem': {
                        'itemNumber': 'ITEM_B',
                        'itemName': 'Support B',
                      },
                    },
                    {
                      'date': '2025-07-13',
                      'startTime': '1:00 PM',
                      'endTime': '3:00 PM',
                      'clientState': 'NSW',
                      'ndisItem': {
                        'itemNumber': 'ITEM_A',
                        'itemName': 'Support A',
                      },
                    },
                  ],
                },
              ],
            },
          ],
          'clientDetail': <dynamic>[
            {
              'clientEmail': 'client@example.com',
              'clientFirstName': 'John',
              'clientLastName': 'Doe',
              'clientState': 'NSW',
            },
          ],
        };

        // Provide lineItems list; not used directly since schedule has explicit NDIS items.
        final supportItems = <Map<String, dynamic>>[
          {'itemNumber': 'ITEM_B', 'itemDescription': 'Support B'},
          {'itemNumber': 'ITEM_A', 'itemDescription': 'Support A'},
        ];

        // Hook up the processor with an EnhancedInvoiceService using the same ref and mock api.
        // This enables bulk pricing caching/usage via the service.
        final invoiceService = EnhancedInvoiceService(ref, mockApiMethod);
        processor.setEnhancedInvoiceService(invoiceService);

        final result = await processor.processInvoiceData(
          assignedClients: assignedClients,
          lineItems: supportItems,
          organizationId: 'ORG-TEST',
        );

        final clients = result['clients'] as List<dynamic>;
        final items = clients.first['items'] as List<dynamic>;

        // First item (ITEM_B) uses fallback base rate from bulk.
        final itemB =
            items.firstWhere((e) => e['ndisItemNumber'] == 'ITEM_B')
                as Map<String, dynamic>;
        expect(itemB['rate'], 62.375);
        expect(itemB['hours'], 2.0); // 9:00-11:00
        expect(itemB['amount'], closeTo(124.75, 0.0001));

        // Second item (ITEM_A) prefers custom price from bulk.
        final itemA =
            items.firstWhere((e) => e['ndisItemNumber'] == 'ITEM_A')
                as Map<String, dynamic>;
        expect(itemA['rate'], 75.5);
        expect(itemA['hours'], 2.0); // 1:00-3:00
        expect(itemA['amount'], closeTo(151.0, 0.0001));
      },
    );
  });
}
