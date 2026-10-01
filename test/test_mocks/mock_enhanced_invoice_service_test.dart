import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/invoice/services/enhanced_invoice_service.dart';
import 'mock_enhanced_invoice_service.dart';
import 'package:carenest/app/core/providers/invoice_providers.dart';

// Mock ApiMethod
class MockApiMethod extends Mock implements ApiMethod {}

// Mock BuildContext
class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockEnhancedInvoiceService mockService;
  late MockApiMethod mockApi;
  late Ref ref;

  setUp(() {
    mockApi = MockApiMethod();

    final container = ProviderContainer(
      overrides: [apiMethodProvider.overrideWith((ref) => mockApi)],
    );
    addTearDown(container.dispose);

    ref = container.read(Provider<Ref>((ref) => ref));
    mockService = MockEnhancedInvoiceService(ref, mockApi);
  });

  group('MockEnhancedInvoiceService Tests', () {
    test('should implement EnhancedInvoiceService', () {
      expect(mockService, isA<EnhancedInvoiceService>());
    });

    test(
      'generateInvoicesWithPricing should return correct paths and populate invoices',
      () async {
        final selectedEmployeesAndClients = [
          {
            'employee': {'email': 'emp@test.com'},
            'clients': [
              {'email': 'client1@test.com'},
              {'email': 'client2@test.com'},
            ],
          },
        ];
        final organizationId = 'org123';
        final invoiceType = 'NDIS';

        final paths = await mockService.generateInvoicesWithPricing(
          MockBuildContext(),
          selectedEmployeesAndClients: selectedEmployeesAndClients,
          organizationId: organizationId,
          invoiceType: invoiceType,
          applyTax: true,
          taxRate: 0.1,
        );

        // Verify return paths
        expect(paths.length, 2);
        expect(paths[0], '/tmp/NDIS_client1@test.com_emp@test.com.pdf');
        expect(paths[1], '/tmp/NDIS_client2@test.com_emp@test.com.pdf');

        // Verify invoices list population
        expect(mockService.invoices.length, 2);

        final invoice1 = mockService.invoices[0];
        expect(invoice1['type'], 'NDIS');
        expect(invoice1['employeeEmail'], 'emp@test.com');
        expect(invoice1['clientEmail'], 'client1@test.com');
        expect(invoice1['applyTax'], true);
        expect(invoice1['taxRate'], 0.1);
        expect(invoice1['total'], closeTo(110.0, 0.0001)); // 100 * 1.1

        final invoice2 = mockService.invoices[1];
        expect(invoice2['clientEmail'], 'client2@test.com');
        expect(invoice2['total'], closeTo(110.0, 0.0001));
      },
    );

    test('generateInvoicesWithPricing should handle no tax', () async {
      final selectedEmployeesAndClients = [
        {
          'employee': {'email': 'emp@test.com'},
          'clients': [
            {'email': 'client1@test.com'},
          ],
        },
      ];

      await mockService.generateInvoicesWithPricing(
        MockBuildContext(),
        selectedEmployeesAndClients: selectedEmployeesAndClients,
        organizationId: 'org1',
        invoiceType: 'Private',
        applyTax: false,
        taxRate: 0.0,
      );

      expect(mockService.invoices.length, 1);
      expect(mockService.invoices[0]['total'], 100.0);
      expect(mockService.invoices[0]['applyTax'], false);
    });

    test('generateInvoicesWithPricing should handle empty selection', () async {
      final paths = await mockService.generateInvoicesWithPricing(
        MockBuildContext(),
        selectedEmployeesAndClients: [],
        organizationId: 'org1',
        invoiceType: 'NDIS',
        taxRate: 0.0,
      );

      expect(paths, isEmpty);
      expect(mockService.invoices, isEmpty);
    });

    test(
      'generateInvoicesWithPricing should handle useAdminBankDetails flag',
      () async {
        final selectedEmployeesAndClients = [
          {
            'employee': {'email': 'emp@test.com'},
            'clients': [
              {'email': 'client1@test.com'},
            ],
          },
        ];

        await mockService.generateInvoicesWithPricing(
          MockBuildContext(),
          selectedEmployeesAndClients: selectedEmployeesAndClients,
          organizationId: 'org1',
          invoiceType: 'NDIS',
          useAdminBankDetails: true,
          taxRate: 0.0,
        );

        expect(mockService.invoices[0]['useAdminBankDetails'], true);
      },
    );

    test(
      'generateInvoicesWithPricing should handle missing employee/client data gracefully',
      () async {
        // The mock implementation has checks:
        // final employee = pair['employee'] as Map<String, dynamic>? ?? {};
        // final clients = pair['clients'] as List<dynamic>? ?? [];

        final selectedEmployeesAndClients = [
          {
            // missing employee
            'clients': [
              {'email': 'client1@test.com'},
            ],
          },
          {
            'employee': {'email': 'emp2@test.com'},
            // missing clients
          },
        ];

        final paths = await mockService.generateInvoicesWithPricing(
          MockBuildContext(),
          selectedEmployeesAndClients: selectedEmployeesAndClients,
          organizationId: 'org1',
          invoiceType: 'NDIS',
          taxRate: 0.0,
        );

        // First pair: employee is {}, clients has 1. Path will use null for employee email -> likely "null" or crash if map access fails.
        // employee['email'] will be null.

        expect(paths.length, 1);
        expect(paths[0], '/tmp/NDIS_client1@test.com_null.pdf');

        expect(mockService.invoices.length, 1);
        expect(mockService.invoices[0]['employeeEmail'], isNull);
      },
    );

    test(
      'generateInvoicesWithPricing should handle null selectedEmployeesAndClients',
      () async {
        final paths = await mockService.generateInvoicesWithPricing(
          MockBuildContext(),
          selectedEmployeesAndClients: null,
          organizationId: 'org1',
          invoiceType: 'NDIS',
          taxRate: 0.0,
        );

        expect(paths, isEmpty);
        expect(mockService.invoices, isEmpty);
      },
    );

    test(
      'generateInvoicesWithPricing should default invoiceType to Standard if null',
      () async {
        final selectedEmployeesAndClients = [
          {
            'employee': {'email': 'emp@test.com'},
            'clients': [
              {'email': 'client1@test.com'},
            ],
          },
        ];

        final paths = await mockService.generateInvoicesWithPricing(
          MockBuildContext(),
          selectedEmployeesAndClients: selectedEmployeesAndClients,
          organizationId: 'org1',
          invoiceType: null,
          taxRate: 0.0,
        );

        expect(paths.length, 1);
        expect(paths[0], '/tmp/Standard_client1@test.com_emp@test.com.pdf');
        expect(mockService.invoices[0]['type'], 'Standard');
      },
    );
  });
}
