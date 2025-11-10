import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:carenest/app/features/invoice/services/enhanced_invoice_service.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/invoice/services/invoice_pdf_generator_service.dart';
import 'package:carenest/app/features/invoice/services/invoice_email_service.dart';
import 'package:carenest/app/features/invoice/utils/invoice_data_processor.dart';
import 'package:carenest/app/core/providers/invoice_providers.dart';
// Removed unused: import 'package:carenest/app/core/providers/invoice_providers.dart';
// Removed unused: import 'package:carenest/app/features/invoice/repositories/invoice_repository.dart';

// Mock classes
class MockApiMethod extends Mock implements ApiMethod {}

class MockInvoicePdfGenerator extends Mock implements InvoicePdfGenerator {}

class MockInvoiceEmailService extends Mock implements InvoiceEmailService {}

class MockInvoiceDataProcessor extends Mock implements InvoiceDataProcessor {}

/// Simple stubbed API method to avoid typed argument matcher issues.
/// Allows setting canned responses used by EnhancedInvoiceService tests.
class StubApiMethod extends Mock implements ApiMethod {
  Map<String, dynamic>? bulkReturn;
  List<Map<String, dynamic>>? priceHistoryReturn;

  @override
  Future<Map<String, dynamic>?> getBulkPricingLookup(
      String organizationId, List<String> supportItemNumbers,
      {String? clientId}) async {
    return bulkReturn;
  }

  @override
  Future<List<Map<String, dynamic>>?> getPriceHistory(
      String ndisItemNumber, String clientId) async {
    return priceHistoryReturn ?? <Map<String, dynamic>>[];
  }

  @override
  Future<Map<String, dynamic>> validateInvoicePricing({
    required List<Map<String, dynamic>> lineItems,
    String state = 'NSW',
    String providerType = 'standard',
  }) async {
    return {
      'success': true,
      'data': {
        'validationResults': <dynamic>[],
        'summary': <String, dynamic>{},
      }
    };
  }
}

/// A lightweight fake Ref for tests that maps specific provider.notifier
/// lookups to predefined StateControllers. This avoids Mockito's argument
/// matching issues with provider.notifier instances.
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
  T watch<T>(ProviderListenable<T> provider) {
    // For these tests, watch behaves same as read
    return read(provider);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late FakeRef fakeRef;
  late EnhancedInvoiceService invoiceService;
  late MockApiMethod mockApiMethod;

  setUp(() {
    mockApiMethod = MockApiMethod();
    // Initialize state controllers we want the service to update
    final stateCtrl =
        StateController<InvoiceGenerationState>(InvoiceGenerationState.initial);
    final errorCtrl = StateController<String>('');

    // Map provider.notifier lookups to our controllers
    fakeRef = FakeRef({
      invoiceGenerationStateProvider.notifier: stateCtrl,
      invoiceGenerationErrorProvider.notifier: errorCtrl,
      // In case tests read the providers (not the notifiers)
      invoiceGenerationStateProvider: InvoiceGenerationState.initial,
      invoiceGenerationErrorProvider: '',
    });

    invoiceService = EnhancedInvoiceService(fakeRef, mockApiMethod);
  });

  tearDown(() {
    // No need to dispose anything
  });

  group('Null safety tests', () {
    test('_checkForMissingPrices handles null clients list', () {
      // Create a test method that exposes the private method
      Future<List<Map<String, dynamic>>> testCheckForMissingPrices() async {
        // Call the private method using reflection or a test-only public method
        // This is a simplified version that just tests our fix
        final processedData = {'clients': null};
        return invoiceService.testCheckForMissingPrices(processedData);
      }

      // The test should not throw an error
      expect(testCheckForMissingPrices(), completes);
    });

    test('_applyPriceResolutions handles null clients list', () {
      // Create a test method that exposes the private method
      void testApplyPriceResolutions() {
        // Call the private method using reflection or a test-only public method
        // This is a simplified version that just tests our fix
        final processedData = {'clients': null};
        final resolutions = <Map<String, dynamic>>[];
        invoiceService.testApplyPriceResolutions(processedData, resolutions);
      }

      // The test should not throw an error
      expect(() => testApplyPriceResolutions(), returnsNormally);
    });

    test(
        '_processSelectedEmployeesAndClients handles null selectedClients list',
        () {
      // Create a test method that exposes the private method
      Future<Map<String, dynamic>>
          testProcessSelectedEmployeesAndClients() async {
        // Call the private method using reflection or a test-only public method
        // This is a simplified version that just tests our fix
        final selectedEmployeesAndClients = [
          {
            'email': 'test@example.com',
            'name': 'Test User',
            'selectedClients': null
          }
        ];
        return invoiceService.testProcessSelectedEmployeesAndClients(
            selectedEmployeesAndClients);
      }

      // The test should not throw an error
      expect(testProcessSelectedEmployeesAndClients(), completes);
    });

    test('sendInvoiceEmails handles null _invoices list', () {
      // We can't directly mock the email service since it's created internally
      // This test will just verify that the method doesn't throw when _invoices is null

      // Set _invoices to null internally
      invoiceService.clearInvoicesForTest();

      // The test should not throw an error
      expect(
          invoiceService.sendInvoiceEmails('path', 'email', 'key'), completes);
    });
  });

  group('Totals calculation edge cases', () {
    test('Calculates items/expenses subtotals and applies 10% tax', () {
      final Map<String, dynamic> client = {
        'lineItems': [
          {'total': 100.0},
          {'total': 50.0},
        ],
        'expenses': [
          {'totalAmount': 20.0},
          {'amount': 30.0},
        ],
      };

      invoiceService.testRecalculateInvoiceTotal(
        client,
        applyTax: true,
        taxRate: 0.10,
      );

      expect(client['itemsSubtotal'], 150.0);
      expect(client['expensesTotal'], 50.0);
      expect(client['subtotal'], 200.0);
      expect(client['taxAmount'], closeTo(20.0, 0.0001));
      expect(client['total'], closeTo(220.0, 0.0001));
    });

    test('No tax when applyTax is false even if taxRate > 0', () {
      final Map<String, dynamic> client = {
        'lineItems': [
          {'total': 80.0},
        ],
        'expenses': [
          {'totalAmount': 20.0},
        ],
      };

      invoiceService.testRecalculateInvoiceTotal(
        client,
        applyTax: false,
        taxRate: 0.15,
      );

      expect(client['subtotal'], 100.0);
      expect(client['taxAmount'], 0.0);
      expect(client['total'], 100.0);
    });

    test('applyTax falls back to taxExempt flag when null', () {
      final Map<String, dynamic> clientExempt = {
        'taxExempt': true,
        'lineItems': [
          {'total': 200.0},
        ],
        'expenses': [],
      };

      invoiceService.testRecalculateInvoiceTotal(
        clientExempt,
        applyTax: null,
        taxRate: 0.25,
      );

      expect(clientExempt['subtotal'], 200.0);
      expect(clientExempt['taxAmount'], 0.0);
      expect(clientExempt['total'], 200.0);

      final Map<String, dynamic> clientTaxable = {
        'taxExempt': false,
        'lineItems': [
          {'total': 100.0},
        ],
        'expenses': [
          {'amount': 50.0},
        ],
        'taxRate': 0.20,
      };

      // taxRate omitted in args -> should use client['taxRate']
      invoiceService.testRecalculateInvoiceTotal(
        clientTaxable,
        applyTax: null,
      );

      expect(clientTaxable['subtotal'], 150.0);
      expect(clientTaxable['taxAmount'], closeTo(30.0, 0.0001));
      expect(clientTaxable['total'], closeTo(180.0, 0.0001));
      expect(clientTaxable['taxRate'], 0.20);
    });

    test('Handles empty lineItems/expenses gracefully (all totals zero)', () {
      final Map<String, dynamic> client = {
        'lineItems': <Map<String, dynamic>>[],
        'expenses': <Map<String, dynamic>>[],
      };

      invoiceService.testRecalculateInvoiceTotal(
        client,
        applyTax: true,
        taxRate: 0.10,
      );

      expect(client['itemsSubtotal'], 0.0);
      expect(client['expensesTotal'], 0.0);
      expect(client['subtotal'], 0.0);
      expect(client['taxAmount'], 0.0);
      expect(client['total'], 0.0);
    });

    test('Expense total falls back to amount and unitCost fields', () {
      final Map<String, dynamic> client = {
        'lineItems': [
          {'total': 40.0},
        ],
        'expenses': [
          // Uses amount
          {'amount': 10.0},
          // Uses unitCost
          {'unitCost': 5.0},
        ],
      };

      invoiceService.testRecalculateInvoiceTotal(
        client,
        applyTax: true,
        taxRate: 0.10,
      );

      expect(client['itemsSubtotal'], 40.0);
      expect(client['expensesTotal'], 15.0);
      expect(client['subtotal'], 55.0);
      expect(client['taxAmount'], closeTo(5.5, 0.0001));
      expect(client['total'], closeTo(60.5, 0.0001));
    });

    test('Client taxRate is used when method taxRate is null', () {
      final Map<String, dynamic> client = {
        'lineItems': [
          {'total': 100.0},
        ],
        'expenses': [
          {'amount': 50.0},
        ],
        'taxRate': 0.15,
      };

      invoiceService.testRecalculateInvoiceTotal(
        client,
        applyTax: true,
        taxRate: null,
      );

      expect(client['subtotal'], 150.0);
      expect(client['taxAmount'], closeTo(22.5, 0.0001));
      expect(client['total'], closeTo(172.5, 0.0001));
      expect(client['taxRate'], 0.15);
    });
  });

  group('Top-level validation error cases', () {
    testWidgets('Negative tax rate triggers error state and empty result',
        (tester) async {
      // Minimal widget to obtain BuildContext
      BuildContext? capturedContext;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              capturedContext = context;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(capturedContext, isNotNull);

      final result = await invoiceService.generateInvoicesWithPricing(
        capturedContext!,
        selectedEmployeesAndClients: const [],
        organizationId: 'ORG-TEST',
        validatePrices: false,
        applyTax: true,
        taxRate: -0.05,
        includeExpenses: false,
      );

      expect(result, isEmpty);
      final stateCtrl = fakeRef
          .read(invoiceGenerationStateProvider.notifier) as StateController<InvoiceGenerationState>;
      final errorCtrl = fakeRef
          .read(invoiceGenerationErrorProvider.notifier) as StateController<String>;
      expect(stateCtrl.state, InvoiceGenerationState.error);
      expect(errorCtrl.state, contains('Tax rate cannot be negative'));
    });
  });

  group('Fallback and custom pricing integration', () {
    /// Verifies that when bulk pricing provides a fallback base rate above a cap,
    /// the service clamps to the cap and rounds price and total to 2 decimals,
    /// and does not generate a missing-price prompt for that item.
    test('Applies bulk fallback base rate with cap clamping and rounding', () async {
      // Stub bulk pricing to include price above cap for one item,
      // and standard price info for another (to trigger prompt).
      final stubApi = StubApiMethod()
        ..bulkReturn = {
          '01_020_0120_1_1': {
            'price': 70.0,
            'priceCap': 65.17,
          },
          '03_000_0000_0_0': {
            'standardPrice': 60.0,
            'priceCap': 65.17,
          },
        }
        ..priceHistoryReturn = <Map<String, dynamic>>[];
      invoiceService = EnhancedInvoiceService(fakeRef, stubApi);

      final processedData = {
        'clients': [
          {
            'clientId': 'CID-1',
            'clientName': 'Client A',
            'state': 'NSW',
            'providerType': 'standard',
            // Items used for bulk lookup collection
            'items': [
              {
                'ndisItemNumber': '01_020_0120_1_1',
                'quantity': 2.5,
                'description': 'Transport (per km)'
              },
              {
                'ndisItemNumber': '03_000_0000_0_0',
                'quantity': 1.0,
                'description': 'Unknown Item'
              },
            ],
            // Line items are the ones that get updated
            'lineItems': [
              {
                'ndisItemNumber': '01_020_0120_1_1',
                'quantity': 2.5,
                'description': 'Transport (per km)'
              },
              {
                'ndisItemNumber': '03_000_0000_0_0',
                'quantity': 1.0,
                'description': 'Unknown Item'
              },
            ],
          }
        ]
      };

      final prompts = await invoiceService.testCheckForMissingPrices(
        processedData,
        organizationId: 'ORG-TEST',
      );

      // Item 1 should have price applied from bulk, clamped and rounded.
      final li0 = (processedData['clients'] as List).first['lineItems'][0] as Map<String, dynamic>;
      expect(li0['price'], 65.17);
      expect(li0['pricingSource'], 'Organization fallback base rate');
      expect(li0['exceedsPriceCap'], isFalse);
      expect(li0['total'], 162.93); // 65.17 * 2.5 rounded to 2 decimals

      // Item 2 still needs pricing -> prompt generated with suggested price and cap.
      expect(prompts.length, 1);
      final prompt = prompts.first;
      expect(prompt['ndisItemNumber'], '03_000_0000_0_0');
      expect(prompt['suggestedPrice'], 60.0);
      expect(prompt['priceCap'], 65.17);
    });

    /// Verifies that organization-wide custom pricing from bulk data is
    /// applied immediately even if the line item already has a price.
    test('Prefers custom pricing from bulk over existing item price', () async {
      final stubApi2 = StubApiMethod()
        ..bulkReturn = {
          '04_101_0104_1_1': {
            'customPrice': 45.0,
          },
        }
        ..priceHistoryReturn = <Map<String, dynamic>>[];
      invoiceService = EnhancedInvoiceService(fakeRef, stubApi2);

      final processedData = {
        'clients': [
          {
            'clientId': 'CID-2',
            'clientName': 'Client B',
            'state': 'NSW',
            'providerType': 'standard',
            'items': [
              {
                'ndisItemNumber': '04_101_0104_1_1',
                'quantity': 2.0,
                'description': 'Assistance'
              },
            ],
            'lineItems': [
              {
                'ndisItemNumber': '04_101_0104_1_1',
                'quantity': 2.0,
                'price': 40.0, // existing price should be overridden
                'description': 'Assistance'
              },
            ],
          }
        ]
      };

      final prompts = await invoiceService.testCheckForMissingPrices(
        processedData,
        organizationId: 'ORG-TEST',
      );

      // No prompt expected; custom pricing applied.
      expect(prompts, isEmpty);

      final li0 = (processedData['clients'] as List).first['lineItems'][0] as Map<String, dynamic>;
      expect(li0['price'], 45.0);
      expect(li0['pricingSource'], 'Organization-wide custom price');
      expect(li0['total'], 90.0);
      expect(li0['hasCustomPricing'], isTrue);
    });
  });
}
