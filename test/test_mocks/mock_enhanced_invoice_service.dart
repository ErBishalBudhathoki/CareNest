import 'dart:io';
import 'package:flutter/material.dart';
import 'package:carenest/app/features/invoice/services/enhanced_invoice_service.dart';

class MockEnhancedInvoiceService extends EnhancedInvoiceService {
  final List<Map<String, dynamic>> _invoices = [];

  @override
  List<Map<String, dynamic>> get invoices => _invoices;

  MockEnhancedInvoiceService(super.ref, super.apiMethod);

  @override
  Future<List<String>> generateInvoicesWithPricing(
    BuildContext context, {
    List<Map<String, dynamic>>? selectedEmployeesAndClients,
    String? organizationId,
    bool validatePrices = true,
    bool allowPriceCapOverride = false,
    bool includeDetailedPricingInfo = true,
    bool applyTax = true,
    required double taxRate,
    bool includeExpenses = true,
    List<File>? attachedPhotos,
    String? photoDescription,
    List<File>? additionalAttachments,
    Map<String, Map<String, dynamic>>? priceOverrides,
    bool useAdminBankDetails = false,
    DateTime? startDate,
    DateTime? endDate,
    String? invoiceType,
    bool applyMinEngagement = true,
    Map<String, dynamic>? recurrence,
  }) async {
    final paths = <String>[];
    _invoices.clear();

    if (selectedEmployeesAndClients == null ||
        selectedEmployeesAndClients.isEmpty) {
      return paths;
    }

    for (final pair in selectedEmployeesAndClients) {
      final employee = pair['employee'] as Map<String, dynamic>? ?? {};
      final clients = pair['clients'] as List<dynamic>? ?? [];

      for (final client in clients) {
        final clientMap = client as Map<String, dynamic>;
        final clientEmail = clientMap['email'] as String? ?? 'unknown';
        final employeeEmail = employee['email'] as String?;

        final type = invoiceType ?? 'Standard';
        paths.add('/tmp/${type}_${clientEmail}_$employeeEmail.pdf');

        _invoices.add({
          'type': type,
          'employeeEmail': employeeEmail,
          'clientEmail': clientEmail ?? '',
          'applyTax': applyTax,
          'taxRate': taxRate,
          'total': 100.0 * (applyTax ? (1 + taxRate) : 1),
          'useAdminBankDetails': useAdminBankDetails,
        });
      }
    }

    return paths;
  }
}
