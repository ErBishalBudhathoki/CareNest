import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/invoice/utils/invoice_helpers.dart';
import 'package:carenest/app/features/invoice/services/enhanced_invoice_service.dart';
import 'package:carenest/app/features/invoice/models/ndis_matcher.dart';

import 'package:carenest/app/features/auth/models/user_model.dart';
import 'package:carenest/app/features/holiday/services/holiday_service.dart';
import 'package:carenest/app/features/invoice/utils/employee_rate_calculator.dart';

class InvoiceDataProcessor {
  final Ref ref; // Accept ref to access providers
  final InvoiceHelpers helpers = InvoiceHelpers();
  EnhancedInvoiceService? enhancedInvoiceService;
  final NDISMatcher _ndisMatcher;
  bool _matcherLoaded = false;

  InvoiceDataProcessor(this.ref, {this.enhancedInvoiceService})
    : _ndisMatcher = NDISMatcher(apiMethod: ref.read(apiMethodProvider));

  void setEnhancedInvoiceService(EnhancedInvoiceService service) {
    enhancedInvoiceService = service;
  }

  List<String> invoiceName = [];
  String endDate = '';
  // invoiceNumber removed - generated in enhanced_invoice_service

  // Cache for bulk pricing data to avoid multiple API calls
  Map<String, dynamic>? _cachedBulkPricingData;
  String? _cachedOrganizationId;

  /// Get pricing for NDIS items using enhanced pricing service
  /// Returns a map with 'price' and 'source' keys
  ///
  /// When [clientId] is provided, performs a client-specific pricing lookup
  /// which takes precedence over organization-level pricing.
  Future<Map<String, dynamic>> _getEnhancedPricingWithSource(
    String ndisItemNumber,
    String? organizationId, {
    String? clientId,
  }) async {
    debugPrint(
      'InvoiceDataProcessor: Getting enhanced pricing for item: $ndisItemNumber, clientId: $clientId',
    );

    if (enhancedInvoiceService == null) {
      debugPrint(
        'InvoiceDataProcessor: No enhanced service available, using standard price fallback',
      );
      try {
        final api = ref.read(apiMethodProvider);
        final std = await api.getStandardPrice(ndisItemNumber);
        return {
          'price': std > 0 ? std : 0.0,
          'source': std > 0 ? 'standard' : 'missing',
        };
      } catch (e) {
        debugPrint('InvoiceDataProcessor: Error fetching standard price: $e');
        return {'price': 0.0, 'source': 'missing'};
      }
    }

    try {
      double? orgFallbackBaseRate;
      Future<double?> readOrgFallbackBaseRate() async {
        if (orgFallbackBaseRate != null) return orgFallbackBaseRate;
        if (organizationId == null || organizationId.isEmpty) return null;
        try {
          final api = ref.read(apiMethodProvider);
          final fb = await api.getFallbackBaseRate(organizationId);
          if (fb != null && fb > 0) {
            orgFallbackBaseRate = double.parse(fb.toStringAsFixed(2));
          } else {
            orgFallbackBaseRate = null;
          }
        } catch (_) {
          orgFallbackBaseRate = null;
        }
        return orgFallbackBaseRate;
      }

      // Priority 1: client-specific pricing when a client context is present.
      // This must win over organization-level pricing.
      if (clientId != null && clientId.isNotEmpty && organizationId != null) {
        try {
          debugPrint(
            'InvoiceDataProcessor: Performing client-specific pricing lookup for $ndisItemNumber (clientId: $clientId)',
          );
          final api = ref.read(apiMethodProvider);

          final pricingData = await api.getPricingLookup(
            organizationId,
            ndisItemNumber,
            clientId: clientId,
          );

          if (pricingData != null) {
            final dynamic customPriceRaw = pricingData['customPrice'];
            final dynamic priceRaw = pricingData['price'];
            final String? source = pricingData['source']?.toString();

            final double? customPrice = customPriceRaw is num
                ? customPriceRaw.toDouble()
                : double.tryParse(customPriceRaw?.toString() ?? '');
            final double? price = priceRaw is num
                ? priceRaw.toDouble()
                : double.tryParse(priceRaw?.toString() ?? '');

            debugPrint(
              'InvoiceDataProcessor: Client-specific pricing for $ndisItemNumber - customPrice: $customPrice, price: $price, source: $source',
            );

            final double? resolvedPrice =
                (customPrice != null && customPrice > 0) ? customPrice : price;
            if (resolvedPrice != null && resolvedPrice > 0) {
              debugPrint(
                'InvoiceDataProcessor: Using client-specific price: $resolvedPrice (source: $source)',
              );
              return {
                'price': double.parse(resolvedPrice.toStringAsFixed(2)),
                'source': source ?? 'client_specific',
              };
            }
          }
        } catch (e) {
          debugPrint(
            'InvoiceDataProcessor: Client-specific lookup failed for $ndisItemNumber: $e',
          );
        }
      }

      // Priority 2: organization-level custom/fallback pricing cache.
      if (_cachedBulkPricingData != null &&
          _cachedOrganizationId == organizationId) {
        final itemData = _cachedBulkPricingData![ndisItemNumber];
        if (itemData != null) {
          final dynamic customPriceRaw = itemData['customPrice'];
          final dynamic fallbackPriceRaw = itemData['price'];
          final String? source = itemData['source']?.toString();
          final double? customPrice = customPriceRaw is num
              ? customPriceRaw.toDouble()
              : double.tryParse(customPriceRaw?.toString() ?? '');
          final double? fallbackPrice = fallbackPriceRaw is num
              ? fallbackPriceRaw.toDouble()
              : double.tryParse(fallbackPriceRaw?.toString() ?? '');
          debugPrint(
            'InvoiceDataProcessor: Cached org pricing for $ndisItemNumber - custom: $customPrice, fallback price: $fallbackPrice, source: $source',
          );

          if (customPrice != null && customPrice > 0) {
            debugPrint(
              'InvoiceDataProcessor: Using org custom price: $customPrice',
            );
            return {'price': customPrice, 'source': source ?? 'organization'};
          }

          // Use organization fallback base rate from bulk data when available
          if (fallbackPrice != null && fallbackPrice > 0) {
            debugPrint(
              'InvoiceDataProcessor: Using fallback base rate from bulk data: $fallbackPrice',
            );
            return {
              'price': fallbackPrice,
              'source': source ?? 'fallback-base-rate',
            };
          }

          // Avoid trusting any other cached price; fetch standard price via API
          debugPrint(
            'InvoiceDataProcessor: Fetching base standard price via API',
          );
          final stdFromApi = await enhancedInvoiceService!
              .getStandardPriceForItem(ndisItemNumber);
          if (stdFromApi != null && stdFromApi > 0) {
            return {'price': stdFromApi, 'source': 'standard'};
          }

          // If no per-item price is configured, use organization fallback base rate.
          final fallback = await readOrgFallbackBaseRate();
          if (fallback != null && fallback > 0) {
            debugPrint(
              'InvoiceDataProcessor: Using organization fallback base rate for $ndisItemNumber: $fallback',
            );
            return {'price': fallback, 'source': 'fallback-base-rate'};
          }
        }
      }

      debugPrint(
        'InvoiceDataProcessor: No cached pricing found, using standard price fallback for $ndisItemNumber',
      );
      final std = await enhancedInvoiceService!.getStandardPriceForItem(
        ndisItemNumber,
      );
      if (std == null || std <= 0) {
        final fallback = await readOrgFallbackBaseRate();
        if (fallback != null && fallback > 0) {
          debugPrint(
            'InvoiceDataProcessor: Using organization fallback base rate for $ndisItemNumber (no standard): $fallback',
          );
          return {'price': fallback, 'source': 'fallback-base-rate'};
        }
      }
      return {
        'price': std != null && std > 0 ? std : 0.0,
        'source': std != null && std > 0 ? 'standard' : 'missing',
      };
    } catch (e) {
      debugPrint('InvoiceDataProcessor: Error getting enhanced pricing: $e');
      try {
        final std = await enhancedInvoiceService!.getStandardPriceForItem(
          ndisItemNumber,
        );
        return {
          'price': std != null && std > 0 ? std : 0.0,
          'source': std != null && std > 0 ? 'standard' : 'missing',
        };
      } catch (_) {
        return {'price': 0.0, 'source': 'missing'};
      }
    }
  }

  /// Get pricing for NDIS items using enhanced pricing service (legacy method for backward compatibility)
  ///
  /// When [clientId] is provided, performs a client-specific pricing lookup
  /// which takes precedence over organization-level pricing.
  Future<double> _getEnhancedPricing(
    String ndisItemNumber,
    String? organizationId, {
    String? clientId,
  }) async {
    final result = await _getEnhancedPricingWithSource(
      ndisItemNumber,
      organizationId,
      clientId: clientId,
    );
    return (result['price'] as num?)?.toDouble() ?? 0.0;
  }

  /// Load bulk pricing data for all NDIS items
  Future<void> _loadBulkPricingData(
    Set<String> ndisItemNumbers,
    String? organizationId,
  ) async {
    if (enhancedInvoiceService == null || ndisItemNumbers.isEmpty) {
      debugPrint(
        'InvoiceDataProcessor: Cannot load bulk pricing - no service or items',
      );
      return;
    }

    try {
      debugPrint(
        'InvoiceDataProcessor: Loading bulk pricing for ${ndisItemNumbers.length} items',
      );
      debugPrint('InvoiceDataProcessor: Organization ID: $organizationId');
      debugPrint('InvoiceDataProcessor: NDIS items: $ndisItemNumbers');

      final bulkData = await enhancedInvoiceService!.getBulkPricingLookup(
        organizationId ?? 'default-org',
        ndisItemNumbers.toList(),
      );

      _cachedBulkPricingData = bulkData;
      _cachedOrganizationId = organizationId;

      debugPrint('InvoiceDataProcessor: Bulk pricing data loaded successfully');
      debugPrint('InvoiceDataProcessor: Bulk pricing data: $bulkData');

      // Debug specific item mentioned by user
      if (bulkData != null && bulkData.containsKey('01_020_0120_1_1')) {
        final item01020 = bulkData['01_020_0120_1_1'];
        debugPrint(
          'InvoiceDataProcessor: DEBUG - Item 01_020_0120_1_1 data: $item01020',
        );
        if (item01020 != null) {
          debugPrint(
            'InvoiceDataProcessor: DEBUG - Custom price for 01_020_0120_1_1: ${item01020['customPrice']}',
          );
          debugPrint(
            'InvoiceDataProcessor: DEBUG - Standard price for 01_020_0120_1_1: ${item01020['standardPrice']}',
          );
        }
      }
    } catch (e) {
      debugPrint('InvoiceDataProcessor: Error loading bulk pricing data: $e');
      _cachedBulkPricingData = null;
      _cachedOrganizationId = null;
    }
  }

  /// Parse a date string in flexible formats into a `DateTime`.
  ///
  /// Attempts ISO-8601 (`DateTime.tryParse`), `dd/MM/yyyy`, `MM/dd/yyyy`,
  /// and `yyyy-MM-dd`. Returns `null` if parsing fails.
  DateTime? _tryParseDateFlexible(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return null;
    try {
      final iso = DateTime.tryParse(dateStr);
      if (iso != null) return iso;
    } catch (_) {}

    try {
      return DateFormat('dd/MM/yyyy').parse(dateStr);
    } catch (_) {}

    try {
      return DateFormat('MM/dd/yyyy').parse(dateStr);
    } catch (_) {}

    try {
      return DateFormat('yyyy-MM-dd').parse(dateStr);
    } catch (_) {}

    debugPrint('InvoiceDataProcessor: Could not parse date "$dateStr"');
    return null;
  }

  /// Check if a given date string falls within the inclusive [startDate, endDate]
  /// range. If either boundary is `null` or the date cannot be parsed, returns
  /// `true` (do not filter out).
  bool _isDateInSelectedRange(
    String? dateStr,
    DateTime? startDate,
    DateTime? endDate,
  ) {
    if (startDate == null || endDate == null) return true;
    final parsed = _tryParseDateFlexible(dateStr);
    if (parsed == null) return true;

    // Normalize to date-only for safe inclusive comparison
    final d = DateTime(parsed.year, parsed.month, parsed.day);
    final s = DateTime(startDate.year, startDate.month, startDate.day);
    final e = DateTime(endDate.year, endDate.month, endDate.day);

    final inRange = !d.isBefore(s) && !d.isAfter(e);
    if (!inRange) {
      debugPrint(
        'InvoiceDataProcessor: Filtering out item on $dateStr (outside $s - $e)',
      );
    }
    return inRange;
  }

  /// Process invoice data (assignments, line items, expenses) into
  /// a structure suitable for PDF generation and sharing.
  ///
  /// Parameters:
  /// - `assignedClients`: Map with clients, assignments, and optional worked time.
  /// - `lineItems`: List of support items used for item number mapping.
  /// - `expenses`: Optional list of approved expenses to include.
  /// - `applyTax`: Whether to apply tax calculations to totals.
  /// - `taxRate`: Tax rate as a decimal (e.g., 0.10 for 10%).
  /// - `priceOverrides`: Optional per-item pricing overrides.
  /// - `organizationId`: Optional org context for pricing lookups.
  /// - `startDate`/`endDate`: Optional date range for the invoice period; when
  ///   provided, these are used for `clientData['startDate']`/`endDate` display.
  /// - `invoiceType`: 'client' or 'employee' (affects rate calculation).
  Future<Map<String, dynamic>> processInvoiceData({
    required Map<String, dynamic> assignedClients,
    List<Map<String, dynamic>>? lineItems,
    List<Map<String, dynamic>>? expenses,
    bool applyTax = true,
    double taxRate = 0.00,
    Map<String, Map<String, dynamic>>? priceOverrides,
    String? organizationId,
    DateTime? startDate,
    DateTime? endDate,
    String? invoiceType,
    bool applyMinEngagement = true,
  }) async {
    // Load NDIS matcher if needed
    if (!_matcherLoaded) {
      try {
        await _ndisMatcher.loadItems();
        _matcherLoaded = true;
      } catch (e) {
        debugPrint('InvoiceDataProcessor: Failed to load NDIS matcher: $e');
      }
    }

    debugPrint('Processing assigned clients data. Invoice Type: $invoiceType');
    debugPrint('assignedClients structure: ${assignedClients.keys}');
    debugPrint('assignedClients content: $assignedClients');

    // 1. Fetch Holidays if needed (for Employee Pay Rates)
    Set<String> holidaySet = {};
    if (invoiceType == 'employee') {
      try {
        debugPrint(
          'Fetching holidays for employee invoice rate calculation...',
        );
        final holidayService = ref.read(holidayServiceProvider);
        final holidays = await holidayService.getAllHolidays();
        holidaySet = holidays
            .map((h) => h.date.toIso8601String().split('T')[0])
            .toSet();
        debugPrint('Loaded ${holidaySet.length} holidays');
      } catch (e) {
        debugPrint('InvoiceDataProcessor: Failed to load holidays: $e');
      }
    }

    final lineItemViewModel = ref.read(lineItemViewModelProvider.notifier);
    final supportItems = lineItems ?? await lineItemViewModel.getSupportItems();

    Map<String, String> itemMap = _createItemMap(supportItems);
    List<Map<String, dynamic>> processedClients = [];

    // Track processed expenses to handle orphans later
    Set<String> processedExpenseIds = {};

    // Collect all NDIS item numbers for bulk pricing lookup
    Set<String> allNdisItemNumbers = {};
    debugPrint(
      'InvoiceDataProcessor: Collecting NDIS item numbers for bulk pricing lookup',
    );

    // Pre-scan to collect NDIS item numbers from schedules
    if (assignedClients.containsKey('clients')) {
      final clients = assignedClients['clients'] as List<dynamic>? ?? [];
      for (var client in clients) {
        if (client is Map<String, dynamic>) {
          List<dynamic> assignments =
              client['assignments'] as List<dynamic>? ?? [];
          for (var assignment in assignments) {
            if (assignment is Map<String, dynamic>) {
              List<dynamic> schedule =
                  assignment['schedule'] as List<dynamic>? ?? [];
              for (var scheduleItem in schedule) {
                if (scheduleItem is Map<String, dynamic> &&
                    scheduleItem['ndisItem'] != null) {
                  final ndisItem =
                      scheduleItem['ndisItem'] as Map<String, dynamic>;
                  final itemNumber = ndisItem['itemNumber'] as String?;
                  if (itemNumber != null && itemNumber.isNotEmpty) {
                    allNdisItemNumbers.add(itemNumber);
                  }
                }
              }
            }
          }
        }
      }
    }

    debugPrint(
      'InvoiceDataProcessor: Found ${allNdisItemNumbers.length} unique NDIS items: $allNdisItemNumbers',
    );

    // Load bulk pricing data if we have NDIS items and enhanced service
    if (allNdisItemNumbers.isNotEmpty && enhancedInvoiceService != null) {
      await _loadBulkPricingData(allNdisItemNumbers, organizationId);
    }

    if (assignedClients.containsKey('userDocs')) {
      debugPrint('Processing legacy userDocs structure');
      final userDocs = assignedClients['userDocs'] as List<dynamic>? ?? [];
      for (var userDocItem in userDocs) {
        final docs = userDocItem['docs'] as List<dynamic>? ?? [];
        for (var doc in docs) {
          if (doc is Map<String, dynamic>) {
            // Extract clientId from doc if available for client-specific pricing
            final docClientId = doc['clientId']?.toString();
            Map<String, dynamic> clientData = await _processClientData(
              doc,
              assignedClients['clientDetail'] as List<dynamic>? ?? [],
              itemMap,
              applyTax,
              taxRate,
              expenses: expenses,
              priceOverrides: priceOverrides,
              organizationId: organizationId,
              startDate: startDate,
              endDate: endDate,
              clientId: docClientId,
              invoiceType: invoiceType,
              holidaySet: holidaySet,
              applyMinEngagement: applyMinEngagement,
              processedExpenseIds: processedExpenseIds,
            );
            processedClients.add(clientData);
          }
        }
      }
    } else if (assignedClients.containsKey('clients')) {
      debugPrint('Processing current clients array structure');
      final clients = assignedClients['clients'] as List<dynamic>? ?? [];
      for (var client in clients) {
        if (client is Map<String, dynamic>) {
          Map<String, dynamic>? workedTimeData =
              client['workedTimeData'] as Map<String, dynamic>?;
          Map<String, dynamic>? employeeDetails =
              client['employeeDetails'] as Map<String, dynamic>?;

          List<dynamic> assignments =
              client['assignments'] as List<dynamic>? ?? [];
          // Extract clientId for client-specific pricing lookups
          final currentClientId = client['clientId']?.toString();
          for (var assignment in assignments) {
            if (assignment is Map<String, dynamic>) {
              Map<String, dynamic> clientData = await _processClientData(
                assignment,
                assignedClients['clientDetail'] as List<dynamic>? ?? [],
                itemMap,
                applyTax,
                taxRate,
                workedTimeData: workedTimeData,
                employeeDetails: employeeDetails,
                expenses: expenses,
                priceOverrides: priceOverrides,
                organizationId: organizationId,
                startDate: startDate,
                endDate: endDate,
                clientId: currentClientId,
                invoiceType: invoiceType,
                holidaySet: holidaySet,
                applyMinEngagement: applyMinEngagement,
                processedExpenseIds: processedExpenseIds,
              );

              clientData['clientId'] = client['clientId'];
              // Don't overwrite clientName - it's already correctly set in _processClientData
              clientData['clientEmail'] = client['clientEmail'];

              processedClients.add(clientData);
            }
          }
        }
      }
    } else {
      debugPrint(
        'Warning: No recognized data structure found in assignedClients',
      );
      debugPrint('Available keys: ${assignedClients.keys}');
    }

    // Handle Orphan Expenses (only for Employee Invoices)
    if (invoiceType == 'employee' && expenses != null && expenses.isNotEmpty) {
      final orphanExpenses = expenses.where((expense) {
        // Check date range
        if (!_isExpenseDateInRange(expense['expenseDate'], startDate, endDate)) {
          return false;
        }

        // Check approval status
        final approvalStatus = (expense['approvalStatus'] ?? '')
            .toString()
            .toLowerCase();
        if (approvalStatus != 'approved') return false;

        // Check if already processed
        final id = expense['_id']?.toString() ?? expense.hashCode.toString();
        return !processedExpenseIds.contains(id);
      }).toList();

      if (orphanExpenses.isNotEmpty) {
        debugPrint(
          'InvoiceDataProcessor: Found ${orphanExpenses.length} orphan expenses for employee invoice',
        );

        final transformedOrphans = orphanExpenses.map((expense) {
          return _transformExpense(expense, invoiceType: invoiceType);
        }).toList();

        // Calculate totals
        double expensesTotal = transformedOrphans.fold(
          0.0,
          (sum, e) => sum + _getSafeDouble(e['totalAmount']),
        );

        // Get employee details from first processed client if available
        String employeeName = 'Employee';
        String employeeEmail = '';
        String providerABN = '';
        Map<String, dynamic>? empDetails;

        if (processedClients.isNotEmpty) {
          employeeName = processedClients.first['employeeName'] ?? 'Employee';
          employeeEmail = processedClients.first['employeeEmail'] ?? '';
          providerABN = processedClients.first['providerABN'] ?? '';
          empDetails = processedClients.first['employeeDetails'];
        }

        // Create a dedicated block for these expenses
        Map<String, dynamic> orphanBlock = {
          'clientName': 'Additional Expenses / Reimbursements',
          'clientEmail': '',
          'clientFirstName': 'Additional',
          'clientLastName': 'Expenses',
          'businessName': 'Reimbursements',
          'clientAddress': '',
          'clientCity': '',
          'clientState': '',
          'clientZip': '',
          'clientPhone': '',
          'billingAddress': '',
          'shippingAddress': '',
          'employeeName': employeeName,
          'employeeEmail': employeeEmail,
          'providerABN': providerABN,
          'employeeDetails': empDetails,
          'items': <Map<String, dynamic>>[], // Empty items
          'expenses': transformedOrphans,
          'subtotal': expensesTotal,
          'itemsSubtotal': 0.0,
          'expensesTotal': expensesTotal,
          'taxAmount': 0.0,
          'taxRate': 0.0,
          'total': expensesTotal,
          'startDate': startDate != null
              ? DateFormat('dd/MM/yyyy').format(startDate)
              : '',
          'endDate': endDate != null
              ? DateFormat('dd/MM/yyyy').format(endDate)
              : '',
        };

        processedClients.add(orphanBlock);
      }
    }

    debugPrint('Processed ${processedClients.length} clients');
    _setInvoiceDetails(assignedClients);

    // Compute global period ending date from all processed clients
    DateTime? globalLatest;
    for (final client in processedClients) {
      final items = (client['items'] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .toList();
      for (final item in items) {
        final parsed = _tryParseDateFlexible(item['date'] as String?);
        if (parsed != null) {
          final d = DateTime(parsed.year, parsed.month, parsed.day);
          if (globalLatest == null || d.isAfter(globalLatest)) {
            globalLatest = d;
          }
        }
      }
    }
    if (globalLatest != null) {
      this.endDate = DateFormat('dd/MM/yyyy').format(globalLatest);
    }

    debugPrint('Finished processing invoice data');

    return <String, dynamic>{
      'clients': processedClients,
      'invoiceName': invoiceName,
      'endDate': this.endDate,
      // invoiceNumber removed - will be generated in enhanced_invoice_service
    };
  }

  Map<String, String> _createItemMap(List<Map<String, dynamic>> lineItems) {
    Map<String, String> itemMap = {};
    for (var item in lineItems) {
      itemMap[item['itemDescription'] ?? ''] = item['itemNumber'] ?? '';
    }
    return itemMap;
  }

  /// Build a single client's invoice data from assignment and optional worked
  /// time details.
  ///
  /// `startDate`/`endDate` allow the caller to control the displayed period on
  /// the invoice; if null, the current week is used as a fallback.
  ///
  /// `clientId` is used for client-specific pricing lookups, which take
  /// precedence over organization-level pricing.
  Future<Map<String, dynamic>> _processClientData(
    Map<String, dynamic> doc,
    List<dynamic> clientDetails,
    Map<String, String> itemMap,
    bool applyTax,
    double taxRate, {
    Map<String, dynamic>? workedTimeData,
    Map<String, dynamic>? employeeDetails,
    List<Map<String, dynamic>>? expenses,
    Map<String, Map<String, dynamic>>? priceOverrides,
    String? organizationId,
    DateTime? startDate,
    DateTime? endDate,
    String? clientId,
    String? invoiceType,
    Set<String>? holidaySet,
    bool applyMinEngagement = true,
    Set<String>? processedExpenseIds,
  }) async {
    Map<String, dynamic> clientData = {};

    clientData['clientEmail'] = doc['clientEmail'] ?? '';
    // Invoice number will be generated in enhanced_invoice_service

    // Fetch Employee User Profile if needed for rate calculation
    User? employeeUser;
    String userEmail = doc['userEmail'] ?? '';
    if (invoiceType == 'employee' && userEmail.isNotEmpty) {
      try {
        debugPrint(
          'InvoiceDataProcessor: Fetching employee profile for $userEmail',
        );
        final api = ref.read(apiMethodProvider);
        final resp = await api.getUserPayDetails(userEmail);
        if (resp['success'] == true && resp['data'] is Map<String, dynamic>) {
          employeeUser = User.fromJson(resp['data'] as Map<String, dynamic>);
          debugPrint(
            'InvoiceDataProcessor: Loaded employee pay details. PayRate: ${employeeUser.payRate}, BaseRate: ${employeeUser.detailedRates?.baseRate}',
          );
        } else {
          debugPrint(
            'InvoiceDataProcessor: Failed to load employee pay details for $userEmail: ${resp['message'] ?? resp}',
          );
        }
      } catch (e) {
        debugPrint('InvoiceDataProcessor: Error fetching employee profile: $e');
      }
    }

    if (invoiceType == 'employee') {
      final baseRate =
          (employeeUser?.detailedRates?.baseRate ??
                  employeeUser?.payRate ??
                  0.0)
              .toDouble();
      if (employeeUser == null || baseRate <= 0) {
        throw Exception(
          'Employee pay rates are not configured for $userEmail. Please set the Employee Pay Rate before generating an employee invoice.',
        );
      }
    }

    var clientDetail = clientDetails.firstWhere(
      (detail) => detail['clientEmail'] == clientData['clientEmail'],
      orElse: () => <String, dynamic>{},
    );

    // Set individual client name fields for PDF generation
    clientData['clientFirstName'] = clientDetail['clientFirstName'] ?? '';
    clientData['clientLastName'] = clientDetail['clientLastName'] ?? '';
    clientData['clientName'] =
        '${clientDetail['clientFirstName'] ?? ''} ${clientDetail['clientLastName'] ?? ''}';
    clientData['businessName'] = clientDetail['businessName'] ?? '';

    // Set individual address fields for PDF generation
    clientData['clientAddress'] = clientDetail['clientAddress'] ?? '';
    clientData['clientCity'] = clientDetail['clientCity'] ?? '';
    clientData['clientState'] = clientDetail['clientState'] ?? '';
    clientData['clientZip'] = clientDetail['clientZip'] ?? '';
    clientData['clientPhone'] = clientDetail['clientPhone'] ?? '';
    clientData['clientABN'] =
        clientDetail['abn'] ??
        clientDetail['clientABN'] ??
        (clientDetail['taxIdentifiers'] != null
            ? clientDetail['taxIdentifiers']['abn']
            : '');

    clientData['billingAddress'] =
        '${clientDetail['clientAddress'] ?? ''}, ${clientDetail['clientCity'] ?? ''}, ${clientDetail['clientState'] ?? ''} ${clientDetail['clientZip'] ?? ''}';
    clientData['shippingAddress'] = clientData['billingAddress'];

    // Extract employee information from doc
    // userEmail is already defined above
    String employeeName =
        employeeDetails?['name'] ??
        doc['employeeName'] ??
        doc['userName'] ??
        '';
    String providerABN = employeeDetails?['abn'] ?? doc['providerABN'] ?? 'N/A';

    if (employeeName.isEmpty && userEmail.isNotEmpty) {
      String emailName = userEmail.split('@')[0];
      employeeName = emailName.replaceAll('.', ' ').replaceAll('_', ' ');
      employeeName = employeeName
          .split(' ')
          .map(
            (word) => word.isNotEmpty
                ? word[0].toUpperCase() + word.substring(1).toLowerCase()
                : '',
          )
          .join(' ');
    }

    clientData['employeeName'] = employeeName.isNotEmpty
        ? employeeName
        : 'Unknown Employee';
    clientData['employeeEmail'] = userEmail;
    clientData['employeeId'] = (employeeUser?.id.isNotEmpty == true)
        ? employeeUser!.id
        : (employeeDetails?['id'] ??
                  employeeDetails?['_id'] ??
                  employeeDetails?['userId'] ??
                  doc['userId'])
              ?.toString();
    clientData['providerABN'] = providerABN;
    // Preserve employee details for header rendering when employee invoice
    clientData['employeeDetails'] = {
      'id': (employeeUser?.id.isNotEmpty == true)
          ? employeeUser!.id
          : (employeeDetails?['id'] ??
                    employeeDetails?['_id'] ??
                    employeeDetails?['userId'] ??
                    doc['userId'])
                ?.toString(),
      'name': employeeName,
      'email': userEmail,
      'address':
          employeeDetails?['address'] ??
          employeeDetails?['employeeAddress'] ??
          '',
      'phone': employeeDetails?['phone'] ?? employeeDetails?['mobile'] ?? '',
      'firstName': employeeDetails?['firstName'] ?? '',
      'lastName': employeeDetails?['lastName'] ?? '',
      'abn': employeeDetails?['abn'] ?? providerABN,
    };

    // Defer period start/end calculation until items are built.
    // When no date range is selected, the period will be determined from
    // the earliest and latest record dates after sorting.

    List<Map<String, dynamic>> items = [];

    bool hasWorkedTimeData =
        workedTimeData != null &&
        workedTimeData['success'] == true &&
        workedTimeData['workedTimes'] != null;

    if (hasWorkedTimeData) {
      debugPrint('Using worked time data for pricing calculations');
      List<dynamic> workedTimes =
          workedTimeData['workedTimes'] as List<dynamic>;

      for (var record in workedTimes) {
        if (record is Map<String, dynamic>) {
          final schedule =
              record['correspondingSchedule'] as Map<String, dynamic>?;
          if (schedule != null) {
            String date = schedule['date'] ?? '';
            // Strict date-range filtering for worked time entries
            if (!_isDateInSelectedRange(date, startDate, endDate)) {
              continue; // Skip out-of-range entries
            }
            String startTime = schedule['startTime'] ?? '';
            String endTime = schedule['endTime'] ?? '';
            double hoursWorked = _getSafeDouble(record['actualWorkedTime']);
            // Round to 2 decimal places to avoid displaying values like 10.18138888888889
            hoursWorked = double.parse(hoursWorked.toStringAsFixed(2));

            String dayOfWeek = helpers.findDayOfWeek([date])[0];

            // Extract NDIS item information from schedule
            Map<String, dynamic>? ndisItem =
                schedule['ndisItem'] as Map<String, dynamic>?;
            String itemNumber = '';
            String itemName = '';

            if (ndisItem != null) {
              // Use actual NDIS item data from assignment
              itemNumber = ndisItem['itemNumber'] ?? '';
              itemName = ndisItem['itemName'] ?? '';
              debugPrint(
                'Using NDIS item from schedule: $itemNumber - $itemName',
              );
            } else {
              // Fallback to legacy method if no NDIS item data
              String timePeriod = helpers.getTimePeriod(startTime);
              itemName = '$dayOfWeek $timePeriod';
              itemNumber = itemMap[itemName] ?? '';
              debugPrint(
                'Using fallback item generation: $itemNumber - $itemName',
              );
            }

            double rate = 0.0;
            bool rateCalculated = false;
            String resolvedRateSource = 'UNRESOLVED';
            double? expectedRate;

            // 1. Employee Rate Calculation (Highest Priority for Employee Invoices)
            if (invoiceType == 'employee' && employeeUser != null) {
              final employeeItems = _generateEmployeeItems(
                date: date,
                startTime: startTime,
                endTime: endTime,
                hours: hoursWorked,
                employeeUser: employeeUser,
                holidaySet: holidaySet,
                dayOfWeek: dayOfWeek,
                workedTimeSource: 'database',
                applyMinEngagement: applyMinEngagement,
              );

              if (employeeItems.isNotEmpty) {
                items.addAll(employeeItems);
                continue; // Skip standard processing for this item
              }
            }

            // 2. NDIS Item Matching & Pricing (Only if not already calculated AND not an employee invoice)
            // We strictly avoid NDIS fallback for employee invoices to prevent incorrect billing rates
            if (!rateCalculated && invoiceType != 'employee') {
              // Attempt to upgrade NDIS item based on actual shift time (Penalty Rates)
              if (_matcherLoaded) {
                try {
                  // Parse date and time to create DateTime
                  DateTime? shiftDate = _tryParseDateFlexible(date);
                  if (shiftDate != null) {
                    final timeParts = startTime.split(':');
                    final hour = int.tryParse(timeParts[0]) ?? 0;
                    final minute = timeParts.length > 1
                        ? int.tryParse(timeParts[1]) ?? 0
                        : 0;
                    final shiftStartDateTime = DateTime(
                      shiftDate.year,
                      shiftDate.month,
                      shiftDate.day,
                      hour,
                      minute,
                    );

                    // Try to find a better match
                    // We use the current item's registration group as a hint if available
                    // Note: we don't have the full item object here easily without lookup,
                    // but we can trust the matcher to find the best fit from all loaded items.
                    final bestMatch = _ndisMatcher.findBestMatch(
                      shiftStart: shiftStartDateTime,
                      dynamicHolidays:
                          [], // Ideally fetch this from HolidayService
                      // If we have an existing item number, we could look it up to get its category/group
                      // to ensure we stay within the same type of support.
                      // For now, we rely on the matcher's scoring.
                    );

                    if (bestMatch != null) {
                      // Check if we should upgrade
                      // If the current item is "Weekday" and the match is "Saturday"/"Sunday"/"Public Holiday", definitely upgrade.
                      // Or if current is "Daytime" and match is "Evening"/"Night".

                      final currentNameLower = itemName.toLowerCase();
                      final matchNameLower = bestMatch.itemName.toLowerCase();

                      bool shouldUpgrade = false;

                      // Penalty Rate Upgrade Logic
                      if (matchNameLower.contains('saturday') &&
                          !currentNameLower.contains('saturday')) {
                        shouldUpgrade = true;
                      }
                      if (matchNameLower.contains('sunday') &&
                          !currentNameLower.contains('sunday')) {
                        shouldUpgrade = true;
                      }
                      if (matchNameLower.contains('public holiday') &&
                          !currentNameLower.contains('public holiday')) {
                        shouldUpgrade = true;
                      }
                      if (matchNameLower.contains('evening') &&
                          !currentNameLower.contains('evening') &&
                          !currentNameLower.contains('night')) {
                        shouldUpgrade = true;
                      }
                      if (matchNameLower.contains('night') &&
                          !currentNameLower.contains('night')) {
                        shouldUpgrade = true;
                      }

                      // Specific check: If current is generic "Assistance With Self-Care" (often weekday)
                      // and we found a specific time-based one.
                      if (itemNumber != bestMatch.itemNumber && shouldUpgrade) {
                        debugPrint(
                          'InvoiceDataProcessor: Upgrading item from $itemNumber ($itemName) to ${bestMatch.itemNumber} (${bestMatch.itemName})',
                        );
                        itemNumber = bestMatch.itemNumber;
                        itemName = bestMatch.itemName;
                      }
                    }
                  }
                } catch (e) {
                  debugPrint(
                    'InvoiceDataProcessor: Error upgrading NDIS item: $e',
                  );
                }
              }

              // Get enhanced pricing for this NDIS item
              if (itemNumber.isNotEmpty) {
                rate = await _getEnhancedPricing(
                  itemNumber,
                  organizationId,
                  clientId: clientId,
                );
                resolvedRateSource = 'NDIS_PRICING';
                debugPrint(
                  'InvoiceDataProcessor: Enhanced rate for $itemNumber (clientId: $clientId): $rate',
                );
              } else {
                // Use organization fallback base rate when item number is missing
                try {
                  if (organizationId != null) {
                    final api = ref.read(apiMethodProvider);
                    final fb = await api.getFallbackBaseRate(organizationId);
                    rate = fb != null && fb > 0
                        ? double.parse(fb.toStringAsFixed(2))
                        : 0.0;
                    resolvedRateSource = 'ORG_FALLBACK_BASE_RATE';
                    debugPrint(
                      'InvoiceDataProcessor: Using organization fallback base rate for $dayOfWeek: $rate',
                    );
                  } else {
                    // As a last resort, use legacy helper mapping
                    rate = helpers.getRate([dayOfWeek], [])[0];
                    rate = double.parse(rate.toStringAsFixed(2));
                    resolvedRateSource = 'LEGACY_FALLBACK';
                    debugPrint(
                      'InvoiceDataProcessor: Using legacy fallback rate for $dayOfWeek: $rate',
                    );
                  }
                } catch (e) {
                  debugPrint(
                    'InvoiceDataProcessor: Error fetching fallback base rate: $e',
                  );
                  resolvedRateSource = 'FALLBACK_ERROR';
                  rate = 0.0;
                }
              }
            }

            items.add({
              'date': date,
              'day': dayOfWeek,
              'startTime': startTime,
              'endTime': endTime,
              'hours': hoursWorked,
              'rate': rate,
              'expectedRate': expectedRate,
              'amount': hoursWorked * rate,
              'rateSource': resolvedRateSource,
              'itemName': itemName,
              'itemCode':
                  itemNumber, // Use itemNumber as itemCode for consistency
              'workedTimeSource': 'database',
              // Add ndisItem structure for PDF generator compatibility
              'ndisItem': {'itemNumber': itemNumber, 'itemName': itemName},
              // Also add direct fields for backward compatibility
              'ndisItemNumber': itemNumber,
              'ndisItemName': itemName,
            });
          }
        }
      }
    } else {
      debugPrint(
        'Using calculated time data for pricing (no worked time data available)',
      );
      List<String> dateList = List<String>.from(doc['dateList'] ?? []);
      List<String> startTimeList = List<String>.from(
        doc['startTimeList'] ?? [],
      );
      List<String> endTimeList = List<String>.from(doc['endTimeList'] ?? []);
      List<String> timeList = List<String>.from(doc['Time'] ?? []);

      // Try to get schedule data with NDIS items from the document
      List<dynamic> schedule = doc['schedule'] as List<dynamic>? ?? [];

      List<String> dayOfWeek = helpers.findDayOfWeek(dateList);
      List<double> totalHours = helpers.calculateTotalHours(
        startTimeList,
        endTimeList,
        timeList,
      );

      for (int i = 0; i < dateList.length; i++) {
        // Strict date-range filtering for calculated schedule entries
        if (!_isDateInSelectedRange(dateList[i], startDate, endDate)) {
          continue; // Skip out-of-range entries
        }
        String itemNumber = '';
        String itemName = '';

        // Try to find matching schedule entry with NDIS item data
        Map<String, dynamic>? matchingSchedule;
        if (i < schedule.length && schedule[i] is Map<String, dynamic>) {
          matchingSchedule = schedule[i] as Map<String, dynamic>;
        }

        if (matchingSchedule != null && matchingSchedule['ndisItem'] != null) {
          // Use actual NDIS item data from schedule
          Map<String, dynamic> ndisItem =
              matchingSchedule['ndisItem'] as Map<String, dynamic>;
          itemNumber = ndisItem['itemNumber'] ?? '';
          itemName = ndisItem['itemName'] ?? '';
          debugPrint(
            'Using NDIS item from calculated schedule: $itemNumber - $itemName',
          );
        } else {
          // Fallback to legacy method
          String timePeriod = helpers.getTimePeriod(startTimeList[i]);
          itemName = '${dayOfWeek[i]} $timePeriod';
          itemNumber = itemMap[itemName] ?? '';
          debugPrint(
            'Using fallback calculated item generation: $itemNumber - $itemName',
          );
        }

        double rate = 0.0;
        bool rateCalculated = false;
        String resolvedRateSource = 'UNRESOLVED';
        double? expectedRate;

        if (invoiceType == 'employee' && employeeUser != null) {
          final employeeItems = _generateEmployeeItems(
            date: dateList[i],
            startTime: startTimeList[i],
            endTime: endTimeList[i],
            hours: totalHours[i],
            employeeUser: employeeUser,
            holidaySet: holidaySet,
            dayOfWeek: dayOfWeek[i],
            workedTimeSource: 'calculated',
            applyMinEngagement: applyMinEngagement,
          );

          if (employeeItems.isNotEmpty) {
            items.addAll(employeeItems);
            continue;
          }
        } else {
          // If invoiceType is employee but user is null, we are in a bad state.
          // We should ideally throw or handle this, but the loop structure makes it hard.
          // However, the check `if (invoiceType == 'employee' && employeeUser != null)` handles the happy path.
          // If employeeUser IS null, we fall through. We should prevent that fallback too if possible.
        }

        if (invoiceType == 'employee' && !rateCalculated) {
          // If we are here, it means employeeUser was null or something failed above.
          // We should explicitly handle this to avoid NDIS fallback.
          debugPrint(
            'InvoiceDataProcessor: Employee rate calculation skipped (User null?). Using fallback 0.00 rate.',
          );
          rate = 0.0;
          rateCalculated = true; // Prevent NDIS logic
          resolvedRateSource = 'EMP_MISSING_PROFILE';
          itemName = 'Rate Error: Employee Profile Not Found';
          itemNumber = '';
        }

        // 2. NDIS Item Matching & Pricing (Only if not already calculated AND not an employee invoice)
        if (!rateCalculated && invoiceType != 'employee') {
          if (itemNumber.isNotEmpty) {
            rate = await _getEnhancedPricing(
              itemNumber,
              organizationId,
              clientId: clientId,
            );
            resolvedRateSource = 'NDIS_PRICING';
            debugPrint(
              'InvoiceDataProcessor: Enhanced rate for $itemNumber (clientId: $clientId): $rate',
            );
          } else {
            try {
              if (organizationId != null) {
                final api = ref.read(apiMethodProvider);
                final fb = await api.getFallbackBaseRate(organizationId);
                rate = fb != null && fb > 0
                    ? double.parse(fb.toStringAsFixed(2))
                    : 0.0;
                resolvedRateSource = 'ORG_FALLBACK_BASE_RATE';
                debugPrint(
                  'InvoiceDataProcessor: Using organization fallback base rate for ${dayOfWeek[i]}: $rate',
                );
              } else {
                rate = helpers.getRate([dayOfWeek[i]], [])[0];
                rate = double.parse(rate.toStringAsFixed(2));
                resolvedRateSource = 'LEGACY_FALLBACK';
                debugPrint(
                  'InvoiceDataProcessor: Using legacy fallback rate for ${dayOfWeek[i]}: $rate',
                );
              }
            } catch (e) {
              debugPrint(
                'InvoiceDataProcessor: Error fetching fallback base rate: $e',
              );
              resolvedRateSource = 'FALLBACK_ERROR';
              rate = 0.0;
            }
          }
        }

        items.add({
          'date': dateList[i],
          'startTime': startTimeList[i],
          'endTime': endTimeList[i],
          'hours': totalHours[i],
          'rate': rate,
          'expectedRate': expectedRate,
          'amount': totalHours[i] * rate,
          'rateSource': resolvedRateSource,
          'itemName': itemName,
          'itemCode': itemNumber, // Use itemNumber as itemCode for consistency
          'workedTimeSource': 'calculated',
          // Add ndisItem structure for PDF generator compatibility
          'ndisItem': {'itemNumber': itemNumber, 'itemName': itemName},
          // Also add direct fields for backward compatibility
          'ndisItemNumber': itemNumber,
          'ndisItemName': itemName,
        });
      }
    }

    // Sort items chronologically (ascending) by date; unparseable dates last
    items.sort((a, b) {
      final da = _tryParseDateFlexible(a['date'] as String?);
      final db = _tryParseDateFlexible(b['date'] as String?);
      if (da == null && db == null) return 0;
      if (da == null) return 1; // place a after b
      if (db == null) return -1; // place a before b
      return DateTime(
        da.year,
        da.month,
        da.day,
      ).compareTo(DateTime(db.year, db.month, db.day));
    });

    // Determine period start/end based on sorted items if dates not provided
    final DateFormat displayFormat = DateFormat('dd/MM/yyyy');
    DateTime? earliest;
    DateTime? latest;
    for (final item in items) {
      final parsed = _tryParseDateFlexible(item['date'] as String?);
      if (parsed != null) {
        final d = DateTime(parsed.year, parsed.month, parsed.day);
        earliest ??= d;
        if (latest == null || d.isAfter(latest)) {
          latest = d;
        }
      }
    }

    final DateTime? displayStart = startDate ?? earliest;
    final DateTime? displayEnd = endDate ?? latest;
    clientData['startDate'] = displayStart != null
        ? displayFormat.format(displayStart)
        : '';
    clientData['endDate'] = displayEnd != null
        ? displayFormat.format(displayEnd)
        : '';

    clientData['items'] = items;

    // Apply price overrides if provided
    if (invoiceType != 'employee' &&
        priceOverrides != null &&
        priceOverrides.isNotEmpty) {
      final clientEmail = clientData['clientEmail'] as String;
      debugPrint('Applying price overrides for client: $clientEmail');

      for (int i = 0; i < items.length; i++) {
        final item = items[i];
        final itemNumber = item['itemCode'] ?? item['ndisItemNumber'] ?? '';

        if (itemNumber.isNotEmpty && priceOverrides.containsKey(itemNumber)) {
          final override = priceOverrides[itemNumber]!;
          final originalAmount = item['amount'] as double;

          // Apply price override
          if (override.containsKey('price')) {
            final newPrice = override['price'] as double;
            final hours = item['hours'] as double;
            item['rate'] = newPrice;
            item['amount'] = hours * newPrice;

            debugPrint(
              'Applied price override for $itemNumber: \$${originalAmount.toStringAsFixed(2)} -> \$${item['amount'].toStringAsFixed(2)}',
            );
          }

          // Apply description override if provided
          if (override.containsKey('description')) {
            item['itemName'] = override['description'];
            if (item['ndisItem'] != null) {
              item['ndisItem']['itemName'] = override['description'];
            }
            item['ndisItemName'] = override['description'];
          }
        }
      }
    }

    // Add expenses to client data if provided
    debugPrint(
      'Data Processor: Processing expenses - received ${expenses?.length ?? 0} expenses',
    );
    if (expenses != null && expenses.isNotEmpty) {
      debugPrint('Data Processor: First raw expense: ${expenses.first}');

      final clientEmail = clientData['clientEmail'] as String;
      final currentClientId = clientId?.toString() ?? '';

      // Filter expenses for this specific client
      final clientExpensesRaw = expenses.where((expense) {
        // Check date range first
        if (!_isExpenseDateInRange(
          expense['expenseDate'],
          startDate,
          endDate,
        )) {
          return false;
        }

        // Check approval status
        final approvalStatus = (expense['approvalStatus'] ?? '')
            .toString()
            .toLowerCase();
        if (approvalStatus != 'approved') return false;

        bool shouldInclude = false;
        final expenseClientId = expense['clientId']?.toString() ?? '';
        final expenseClientEmail = (expense['clientEmail'] ?? '')
            .toString()
            .trim()
            .toLowerCase();
        final normalizedClientEmail = clientEmail.trim().toLowerCase();

        // Prefer explicit client linkage by clientId, then clientEmail.
        if (currentClientId.isNotEmpty &&
            expenseClientId.isNotEmpty &&
            expenseClientId == currentClientId) {
          shouldInclude = true;
        } else if (expenseClientEmail.isNotEmpty &&
            expenseClientEmail == normalizedClientEmail) {
          shouldInclude = true;
        } else if (expenseClientId.isEmpty && expenseClientEmail.isEmpty) {
          // Legacy payloads may not carry client linkage fields.
          shouldInclude = true;
        }

        if (shouldInclude && processedExpenseIds != null) {
          final id = expense['_id']?.toString() ?? expense.hashCode.toString();
          // For employee invoices, avoid duplicates (e.g. expenses with no clientEmail)
          if (invoiceType == 'employee' && processedExpenseIds.contains(id)) {
            shouldInclude = false;
          } else {
            processedExpenseIds.add(id);
          }
        }

        return shouldInclude;
      }).toList();

      // Transform expense data to match PDF generator expectations
      final transformedExpenses = clientExpensesRaw.map((expense) {
        return _transformExpense(expense, invoiceType: invoiceType);
      }).toList();

      clientData['expenses'] = transformedExpenses;
      debugPrint(
        'Added ${transformedExpenses.length} transformed expenses to client $clientEmail',
      );
      debugPrint(
        'Data Processor: Final expenses in clientData: ${clientData['expenses']}',
      );
    } else {
      clientData['expenses'] = <Map<String, dynamic>>[];
    }

    // Calculate subtotal from items
    double itemsSubtotal = items.fold(
      0.0,
      (sum, item) => sum + _getSafeDouble(item['amount']),
    );

    // Calculate expenses total
    final clientExpensesList = clientData['expenses'] as List<dynamic>? ?? [];
    double expensesTotal = clientExpensesList.fold(0.0, (sum, expense) {
      if (expense is Map<String, dynamic>) {
        return sum + _getSafeDouble(expense['totalAmount']);
      }
      return sum;
    });

    // Total subtotal includes both items and expenses
    double subtotal = itemsSubtotal + expensesTotal;
    clientData['subtotal'] = subtotal;
    clientData['itemsSubtotal'] = itemsSubtotal;
    clientData['expensesTotal'] = expensesTotal;

    if (applyTax) {
      clientData['taxAmount'] = subtotal * taxRate;
      clientData['taxRate'] = taxRate;
      clientData['total'] = subtotal + clientData['taxAmount'];
    } else {
      clientData['taxAmount'] = 0.0;
      clientData['taxRate'] = 0.0;
      clientData['total'] = subtotal;
    }

    // Calculate Superannuation (SCHADS / NES Requirement)
    if (invoiceType == 'employee') {
      // 1. Under 18 Rule: SG applies if > 30 hours in a week
      bool isUnder18 = false;
      if (employeeUser?.dob != null) {
        final age =
            DateTime.now().difference(employeeUser!.dob!).inDays / 365.25;
        if (age < 18) {
          isUnder18 = true;
          debugPrint(
            'InvoiceDataProcessor: Employee is under 18 (Age: ${age.toStringAsFixed(1)})',
          );
        }
      }

      // Group items by week (Monday-Sunday) to check 30h rule
      Map<int, double> weeklyHours = {};
      Map<int, List<Map<String, dynamic>>> weeklyItems = {};

      for (var item in items) {
        // Exclude expenses or non-hourly items if any (usually items have hours)
        final hours = _getSafeDouble(item['hours']);
        if (hours <= 0) continue;

        final dateStr = item['date'] as String?;
        final date = _tryParseDateFlexible(dateStr);
        if (date != null) {
          // Get week number (or unique week ID)
          // Simple week ID: Year * 53 + WeekOfYear.
          // Or just find Monday of the week.
          final monday = date.subtract(
            Duration(days: date.weekday - 1),
          ); // Mon = 1
          final weekId =
              monday.millisecondsSinceEpoch; // Unique ID for the week

          weeklyHours[weekId] = (weeklyHours[weekId] ?? 0.0) + hours;

          if (!weeklyItems.containsKey(weekId)) weeklyItems[weekId] = [];
          weeklyItems[weekId]!.add(item);
        }
      }

      // Filter items for OTE calculation
      double oteTotal = 0.0;

      for (final weekId in weeklyHours.keys) {
        final totalWeekHours = weeklyHours[weekId]!;
        final weekItems = weeklyItems[weekId]!;

        // If Under 18 and worked <= 30 hours, exclude this week from Super
        if (isUnder18 && totalWeekHours <= 30) {
          debugPrint(
            'InvoiceDataProcessor: Under 18 & worked ${totalWeekHours}h in week starting ${DateTime.fromMillisecondsSinceEpoch(weekId)} -> Excluded from Super',
          );
          continue;
        }

        for (final item in weekItems) {
          // Exclude overtime items from Super calculation (General Rule)
          if (item['rateSource'] == 'EMP_OVERTIME') {
            continue;
          }
          oteTotal += _getSafeDouble(item['amount']);
        }
      }

      // 2. Quarterly Cap Check ($62,500 OTE per quarter)
      double superableOTE = oteTotal;
      try {
        // Fetch YTD OTE for the current quarter from backend
        // We use the invoice start date (or earliest item date) as reference
        final refDate =
            clientData['startDate'] ?? DateTime.now().toIso8601String();
        // Convert dd/MM/yyyy to yyyy-MM-dd if needed, or rely on Api method to handle
        String refDateIso = '';
        final parsedRef = _tryParseDateFlexible(refDate);
        if (parsedRef != null) {
          refDateIso = parsedRef.toIso8601String().split('T')[0];
        }

        if (userEmail.isNotEmpty && refDateIso.isNotEmpty) {
          final api = ref.read(apiMethodProvider);

          final capResp = await api.getQuarterlyOTE(
            userEmail,
            date: refDateIso,
          );
          if (capResp['success'] == true && capResp['data'] != null) {
            final ytdOTE = _getSafeDouble(capResp['data']['quarterlyOTE']);
            debugPrint(
              'InvoiceDataProcessor: Quarterly Cap Check - YTD OTE: \$$ytdOTE, Current Invoice OTE: \$$oteTotal',
            );

            const quarterlyCap = 62500.0;
            final remainingCap = quarterlyCap - ytdOTE;

            if (remainingCap <= 0) {
              superableOTE = 0.0;
              debugPrint(
                'InvoiceDataProcessor: Quarterly Cap Exceeded. Superable OTE set to 0.',
              );
            } else if (oteTotal > remainingCap) {
              superableOTE = remainingCap;
              debugPrint(
                'InvoiceDataProcessor: Quarterly Cap Reached. Capping Superable OTE at \$$remainingCap',
              );
            }
          }
        }
      } catch (e) {
        debugPrint('InvoiceDataProcessor: Error checking quarterly cap: $e');
        // Proceed with uncapped OTE on error to avoid underpayment risk?
        // Or assume 0? Safer to assume uncapped and let admin adjust if needed.
      }

      // Calculate 12% Super
      double superAmount = superableOTE * 0.12;
      clientData['superAmount'] = superAmount;
      clientData['superRate'] = 0.12;

      debugPrint(
        'InvoiceDataProcessor: Final Super Calculation: \$$superAmount (OTE: \$$superableOTE)',
      );
    }

    debugPrint(
      'Invoice totals - Items: \$${itemsSubtotal.toStringAsFixed(2)}, Expenses: \$${expensesTotal.toStringAsFixed(2)}, Subtotal: \$${subtotal.toStringAsFixed(2)}, Total: \$${clientData['total'].toStringAsFixed(2)}',
    );

    return clientData;
  }

  /// Helper method to format expense date from MongoDB timestamp
  String _formatExpenseDate(dynamic expenseDate) {
    if (expenseDate == null) return '';

    try {
      if (expenseDate is Map<String, dynamic> &&
          expenseDate.containsKey('\$date')) {
        // Handle MongoDB date format: {"\$date": {"\$numberLong": "1753358992499"}}
        final dateMap = expenseDate['\$date'];
        if (dateMap is Map<String, dynamic> &&
            dateMap.containsKey('\$numberLong')) {
          final timestamp = int.parse(dateMap['\$numberLong']);
          final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
          return '${date.day}/${date.month}/${date.year}';
        }
      } else if (expenseDate is String) {
        // Handle string date format
        final date = DateTime.tryParse(expenseDate);
        if (date != null) {
          return '${date.day}/${date.month}/${date.year}';
        }
      } else if (expenseDate is DateTime) {
        // Handle DateTime object
        return '${expenseDate.day}/${expenseDate.month}/${expenseDate.year}';
      }
    } catch (e) {
      debugPrint('Error formatting expense date: $e');
    }

    return expenseDate.toString();
  }

  /// Parse an expense date that may be in various formats.
  /// Supports MongoDB format: {"$date": {"$numberLong": "<millis>"}},
  /// ISO-8601 string, or DateTime object. Returns null if parsing fails.
  DateTime? _parseExpenseDate(dynamic expenseDate) {
    if (expenseDate == null) return null;
    try {
      if (expenseDate is Map<String, dynamic> &&
          expenseDate.containsKey('\$date')) {
        final dateMap = expenseDate['\$date'];
        if (dateMap is Map<String, dynamic> &&
            dateMap.containsKey('\$numberLong')) {
          final timestamp = int.tryParse(dateMap['\$numberLong'].toString());
          if (timestamp != null) {
            return DateTime.fromMillisecondsSinceEpoch(timestamp);
          }
        }
      } else if (expenseDate is String) {
        final parsed = DateTime.tryParse(expenseDate);
        if (parsed != null) return parsed;
        // Try common alternate formats
        try {
          return DateFormat('dd/MM/yyyy').parse(expenseDate);
        } catch (_) {}
        try {
          return DateFormat('MM/dd/yyyy').parse(expenseDate);
        } catch (_) {}
        try {
          return DateFormat('yyyy-MM-dd').parse(expenseDate);
        } catch (_) {}
      } else if (expenseDate is DateTime) {
        return expenseDate;
      }
    } catch (e) {
      debugPrint('Error parsing expense date: $e');
    }
    return null;
  }

  /// Check if an expense date falls within [startDate, endDate] inclusively.
  /// If either boundary is null or the date cannot be parsed, returns true
  /// to avoid unintentionally dropping expenses.
  bool _isExpenseDateInRange(
    dynamic expenseDate,
    DateTime? startDate,
    DateTime? endDate,
  ) {
    if (startDate == null || endDate == null) return true;
    final parsed = _parseExpenseDate(expenseDate);
    if (parsed == null) return true;

    final d = DateTime(parsed.year, parsed.month, parsed.day);
    final s = DateTime(startDate.year, startDate.month, startDate.day);
    final e = DateTime(endDate.year, endDate.month, endDate.day);
    return !d.isBefore(s) && !d.isAfter(e);
  }

  /// Helper method to safely convert values to double
  double _getSafeDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    }
    if (value is Map<String, dynamic> && value.containsKey('\$numberDouble')) {
      // Handle MongoDB number format: {"\$numberDouble": "23.12"}
      return double.tryParse(value['\$numberDouble']) ?? 0.0;
    }
    return 0.0;
  }

  void _setInvoiceDetails(Map<String, dynamic> assignedClients) {
    Map<String, dynamic>? firstDoc;

    if (assignedClients.containsKey('clients')) {
      final clients = assignedClients['clients'] as List<dynamic>? ?? [];
      if (clients.isNotEmpty) {
        final client = clients[0] as Map<String, dynamic>? ?? {};
        final assignments = client['assignments'] as List<dynamic>? ?? [];
        if (assignments.isNotEmpty) {
          firstDoc = assignments[0] as Map<String, dynamic>? ?? {};
        }
      }
    }

    if (firstDoc != null) {
      invoiceName = [firstDoc['clientEmail'] ?? ''];
      endDate = firstDoc['dateList']?.isNotEmpty == true
          ? firstDoc['dateList'][0]
          : '';
      // invoiceNumber will be generated in enhanced_invoice_service
    } else {
      // Fallback values
      invoiceName = ['Unknown Client'];
      endDate = DateTime.now().toString().split(' ')[0];
      // invoiceNumber will be generated in enhanced_invoice_service
    }
  }

  /// Generate invoice items for an employee shift, applying SCHADS compliance rules:
  /// 1. Minimum Engagement (2 hours)
  /// 2. Daily Overtime (> 10 hours)
  List<Map<String, dynamic>> _generateEmployeeItems({
    required String date,
    required String startTime,
    required String endTime,
    required double hours,
    required User? employeeUser,
    required Set<String>? holidaySet,
    required String dayOfWeek,
    String workedTimeSource = 'calculated',
    bool applyMinEngagement = true,
  }) {
    List<Map<String, dynamic>> resultItems = [];

    // 1. Minimum Shift Logic (SCHADS 10.5)
    // Casuals must be paid for at least 2 hours
    double effectiveHours = hours;
    bool appliedMinShift = false;
    if (applyMinEngagement && effectiveHours < 2.0) {
      effectiveHours = 2.0;
      appliedMinShift = true;
    }

    // 2. Daily Overtime Logic (SCHADS 26)
    // First 10 hours are ordinary/penalty, excess is overtime
    double ordinaryHours = effectiveHours;
    double overtimeHours = 0.0;

    if (effectiveHours > 10.0) {
      ordinaryHours = 10.0;
      overtimeHours = effectiveHours - 10.0;
    }

    debugPrint(
      'InvoiceDataProcessor: Shift $date ($startTime-$endTime) '
      'inputHours=$hours effectiveHours=$effectiveHours '
      'ordinaryHours=$ordinaryHours overtimeHours=$overtimeHours '
      'splitApplied=${effectiveHours > 10.0}',
    );

    // Common Rate Calculation Logic
    DateTime? shiftDate = _tryParseDateFlexible(date);
    if (shiftDate == null) {
      debugPrint(
        'InvoiceDataProcessor: Could not parse date $date for employee item',
      );
      return [];
    }

    final dateStr = shiftDate.toIso8601String().split('T')[0];
    final isHoliday = holidaySet?.contains(dateStr) ?? false;
    final rates = employeeUser?.detailedRates;

    // -- Calculate Rates with Fallback Logic --
    // If specific rates are missing/zero, calculate them on the fly based on employment type
    double base = (rates?.baseRate ?? employeeUser?.payRate ?? 0.0).toDouble();
    double satRate = (rates?.saturdayRate ?? 0.0).toDouble();
    double sunRate = (rates?.sundayRate ?? 0.0).toDouble();
    double phRate = (rates?.publicHolidayRate ?? 0.0).toDouble();
    double eveningRate = (rates?.eveningShiftRate ?? 0.0).toDouble();
    double nightRate = (rates?.nightShiftRate ?? 0.0).toDouble();

    // Only apply fallback if we have a valid base rate but missing penalties
    if (base > 0 && (satRate <= 0 || sunRate <= 0)) {
      debugPrint(
        'InvoiceDataProcessor: Detected incomplete rates for ${employeeUser?.email}. Applying SCHADS fallback calculation.',
      );

      final isCasual = employeeUser?.employmentType == 'Casual';

      // Standard SCHADS multipliers
      double satMult = 1.5;
      double sunMult = 2.0;
      double phMult = 2.5;
      double eveningMult = 1.125;
      double nightMult = 1.15;

      if (isCasual) {
        // Casual multipliers (adjusted for loading included in base)
        satMult = 1.4; // 1.75 / 1.25
        sunMult = 1.8; // 2.25 / 1.25
        phMult = 2.2; // 2.75 / 1.25
        eveningMult = 1.1; // 1.375 / 1.25
        nightMult = 1.12; // 1.40 / 1.25
      }

      if (satRate <= 0) satRate = base * satMult;
      if (sunRate <= 0) sunRate = base * sunMult;
      if (phRate <= 0) phRate = base * phMult;
      if (eveningRate <= 0) eveningRate = base * eveningMult;
      if (nightRate <= 0) nightRate = base * nightMult;
    }

    // -- Calculate Ordinary/Penalty Rate --
    final decision = calculateEmployeeRateDecision(
      baseRate: base,
      saturdayRate: satRate,
      sundayRate: sunRate,
      publicHolidayRate: phRate,
      eveningShiftRate: eveningRate,
      nightShiftRate: nightRate,
      date: shiftDate,
      isHoliday: isHoliday,
      startTime: startTime,
      endTime: endTime,
    );

    double ordinaryRate = (decision['rate'] as num?)?.toDouble() ?? 0.0;
    String rateSource = decision['source']?.toString() ?? 'EMP_UNKNOWN';
    String itemName = _deriveItemName(shiftDate, isHoliday, rateSource);

    if (appliedMinShift) {
      itemName += ' (Min Engagement)';
    }

    // Add Ordinary Item
    resultItems.add({
      'date': date,
      'day': dayOfWeek,
      'startTime': startTime,
      'endTime': endTime,
      'hours': ordinaryHours,
      'rate': ordinaryRate,
      'expectedRate': ordinaryRate,
      'amount': ordinaryHours * ordinaryRate,
      'rateSource': rateSource,
      'itemName': itemName,
      'itemCode': '',
      'workedTimeSource': workedTimeSource,
      'ndisItem': {'itemNumber': '', 'itemName': itemName},
      'ndisItemNumber': '',
      'ndisItemName': itemName,
    });
    debugPrint(
      'InvoiceDataProcessor: ORDINARY item "$itemName" hours=$ordinaryHours '
      'rate=$ordinaryRate amount=${ordinaryHours * ordinaryRate}',
    );

    // -- Calculate Overtime Item (if any) --
    if (overtimeHours > 0) {
      // Use overtimeRate from user model
      double otRate = (rates?.overtimeRate ?? 0.0).toDouble();

      // Fallback: if OT rate is 0, use 1.5x base rate
      if (otRate <= 0) {
        double base = (rates?.baseRate ?? employeeUser?.payRate ?? 0.0)
            .toDouble();
        otRate = base * 1.5;
        debugPrint(
          'InvoiceDataProcessor: Using fallback OT rate (1.5x Base): $otRate',
        );
      }

      String otItemName = 'Overtime (>10h Shift)';

      resultItems.add({
        'date': date,
        'day': dayOfWeek,
        'startTime': startTime,
        'endTime': endTime,
        'hours': overtimeHours,
        'rate': otRate,
        'expectedRate': otRate,
        'amount': overtimeHours * otRate,
        'rateSource': 'EMP_OVERTIME',
        'itemName': otItemName,
        'itemCode': '',
        'workedTimeSource': workedTimeSource,
        'ndisItem': {'itemNumber': '', 'itemName': otItemName},
        'ndisItemNumber': '',
        'ndisItemName': otItemName,
      });
      debugPrint(
        'InvoiceDataProcessor: OVERTIME item "$otItemName" hours=$overtimeHours '
        'rate=$otRate amount=${overtimeHours * otRate}',
      );
    }

    return resultItems;
  }

  String _deriveItemName(
    DateTime shiftDate,
    bool isHoliday,
    String rateSource,
  ) {
    if (isHoliday) return 'Public Holiday Shift';
    if (shiftDate.weekday == DateTime.saturday) return 'Saturday Shift';
    if (shiftDate.weekday == DateTime.sunday) return 'Sunday Shift';
    if (rateSource == 'EMP_EVENING_SHIFT') return 'Evening Shift';
    if (rateSource == 'EMP_NIGHT_SHIFT') return 'Night Shift';
    return 'Weekday Ordinary';
  }

  /// Transform expense data to match PDF generator expectations
  Map<String, dynamic> _transformExpense(
    Map<String, dynamic> expense, {
    String? invoiceType,
  }) {
    // Debug: Log original expense data
    debugPrint('Data Processor: Processing expense: ${expense['description']}');
    debugPrint(
      'Data Processor: Original receiptPhotos: ${expense['receiptPhotos']}',
    );

    // Clean receiptPhotos by removing backticks and trimming
    final originalReceiptPhotos =
        expense['receiptPhotos'] as List<dynamic>? ?? [];
    final cleanedReceiptPhotos = originalReceiptPhotos.map((photo) {
      if (photo is String) {
        final cleaned = photo.trim().replaceAll('`', '');
        return cleaned;
      }
      return photo;
    }).toList();

    String description = expense['description'] ?? 'Expense';

    // For employee invoices, mention the client name if available
    if (invoiceType == 'employee') {
      final clientName = expense['clientName'] ?? '';
      if (clientName.toString().isNotEmpty &&
          !description.contains(clientName)) {
        description = '$description ($clientName)';
      }
    }

    // Convert MongoDB expense structure to PDF generator structure
    final transformedExpense = {
      'description': description,
      'date': _formatExpenseDate(expense['expenseDate']),
      'quantity': 1, // Default quantity for expenses
      'unitCost': _getSafeDouble(expense['amount']),
      'totalAmount': _getSafeDouble(expense['amount']),
      'category': expense['category'] ?? '',
      'subcategory': expense['subcategory'] ?? '',
      'receiptUrl': expense['receiptUrl'] ?? '',
      'receiptFiles': expense['receiptFiles'] ?? [],
      'receiptPhotos': cleanedReceiptPhotos,
      'approvalStatus': expense['approvalStatus'] ?? '',
      'isReimbursable': expense['isReimbursable'] ?? false,
    };

    debugPrint(
      'Data Processor: Transformed receiptPhotos: ${transformedExpense['receiptPhotos']}',
    );
    return transformedExpense;
  }
}
