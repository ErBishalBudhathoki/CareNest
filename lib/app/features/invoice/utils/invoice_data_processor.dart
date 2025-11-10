import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/invoice/viewmodels/line_items_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/invoice/utils/invoice_helpers.dart';
import 'package:carenest/app/features/invoice/services/enhanced_invoice_service.dart';
import 'package:flutter/foundation.dart';
import 'package:carenest/backend/api_method.dart';

class InvoiceDataProcessor {
  final Ref ref; // Accept ref to access providers
  final InvoiceHelpers helpers = InvoiceHelpers();
  EnhancedInvoiceService? enhancedInvoiceService;

  InvoiceDataProcessor(this.ref, {this.enhancedInvoiceService});

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
  Future<double> _getEnhancedPricing(
      String ndisItemNumber, String? organizationId) async {
    debugPrint(
        'InvoiceDataProcessor: Getting enhanced pricing for item: $ndisItemNumber');

    if (enhancedInvoiceService == null) {
      debugPrint(
          'InvoiceDataProcessor: No enhanced service available, using standard price fallback');
      try {
        final api = ApiMethod();
        final std = await api.getStandardPrice(ndisItemNumber);
        return std > 0 ? std : 0.0;
      } catch (e) {
        debugPrint('InvoiceDataProcessor: Error fetching standard price: $e');
        return 0.0;
      }
    }

    try {
      // Use cached data if available and organization matches
      if (_cachedBulkPricingData != null &&
          _cachedOrganizationId == organizationId) {
        final itemData = _cachedBulkPricingData![ndisItemNumber];
        if (itemData != null) {
          final dynamic customPriceRaw = itemData['customPrice'];
          final dynamic fallbackPriceRaw = itemData['price'];
          final double? customPrice = customPriceRaw is num
              ? customPriceRaw.toDouble()
              : double.tryParse(customPriceRaw?.toString() ?? '');
          final double? fallbackPrice = fallbackPriceRaw is num
              ? fallbackPriceRaw.toDouble()
              : double.tryParse(fallbackPriceRaw?.toString() ?? '');
          debugPrint(
              'InvoiceDataProcessor: Cached pricing for $ndisItemNumber - custom: $customPrice, fallback price: $fallbackPrice');

          if (customPrice != null && customPrice > 0) {
            debugPrint('InvoiceDataProcessor: Using custom price: $customPrice');
            return customPrice;
          }

          // Use organization fallback base rate from bulk data when available
          if (fallbackPrice != null && fallbackPrice > 0) {
            debugPrint(
                'InvoiceDataProcessor: Using fallback base rate from bulk data: $fallbackPrice');
            return fallbackPrice;
          }

          // Avoid trusting any other cached price; fetch standard price via API
          debugPrint('InvoiceDataProcessor: Fetching base standard price via API');
          final stdFromApi = await enhancedInvoiceService!.getStandardPriceForItem(ndisItemNumber);
          if (stdFromApi != null && stdFromApi > 0) {
            return stdFromApi;
          }
        }
      }

      debugPrint(
          'InvoiceDataProcessor: No cached pricing found, using standard price fallback for $ndisItemNumber');
      final std = await enhancedInvoiceService!.getStandardPriceForItem(ndisItemNumber);
      return std != null && std > 0 ? std : 0.0;
    } catch (e) {
      debugPrint('InvoiceDataProcessor: Error getting enhanced pricing: $e');
      try {
        final std = await enhancedInvoiceService!.getStandardPriceForItem(ndisItemNumber);
        return std != null && std > 0 ? std : 0.0;
      } catch (_) {
        return 0.0;
      }
    }
  }

  /// Load bulk pricing data for all NDIS items
  Future<void> _loadBulkPricingData(
      Set<String> ndisItemNumbers, String? organizationId) async {
    if (enhancedInvoiceService == null || ndisItemNumbers.isEmpty) {
      debugPrint(
          'InvoiceDataProcessor: Cannot load bulk pricing - no service or items');
      return;
    }

    try {
      debugPrint(
          'InvoiceDataProcessor: Loading bulk pricing for ${ndisItemNumbers.length} items');
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
            'InvoiceDataProcessor: DEBUG - Item 01_020_0120_1_1 data: $item01020');
        if (item01020 != null) {
          debugPrint(
              'InvoiceDataProcessor: DEBUG - Custom price for 01_020_0120_1_1: ${item01020['customPrice']}');
          debugPrint(
              'InvoiceDataProcessor: DEBUG - Standard price for 01_020_0120_1_1: ${item01020['standardPrice']}');
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
  bool _isDateInSelectedRange(String? dateStr, DateTime? startDate, DateTime? endDate) {
    if (startDate == null || endDate == null) return true;
    final parsed = _tryParseDateFlexible(dateStr);
    if (parsed == null) return true;

    // Normalize to date-only for safe inclusive comparison
    final d = DateTime(parsed.year, parsed.month, parsed.day);
    final s = DateTime(startDate.year, startDate.month, startDate.day);
    final e = DateTime(endDate.year, endDate.month, endDate.day);

    final inRange = !d.isBefore(s) && !d.isAfter(e);
    if (!inRange) {
      debugPrint('InvoiceDataProcessor: Filtering out item on $dateStr (outside $s - $e)');
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
  Future<Map<String, dynamic>> processInvoiceData({
    required Map<String, dynamic> assignedClients,
    required List<Map<String, dynamic>> lineItems,
    List<Map<String, dynamic>>? expenses,
    bool applyTax = true,
    double taxRate = 0.00,
    Map<String, Map<String, dynamic>>? priceOverrides,
    String? organizationId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    if (assignedClients == null) {
      throw Exception('No assigned clients data');
    }

    debugPrint('Processing assigned clients data');
    debugPrint('assignedClients structure: ${assignedClients.keys}');
    debugPrint('assignedClients content: $assignedClients');

    final lineItemViewModel = ref.read(lineItemViewModelProvider.notifier);
    final supportItems = lineItems ?? await lineItemViewModel.getSupportItems();

    Map<String, String> itemMap = _createItemMap(supportItems!);
    List<Map<String, dynamic>> processedClients = [];

    // Collect all NDIS item numbers for bulk pricing lookup
    Set<String> allNdisItemNumbers = {};
    debugPrint(
        'InvoiceDataProcessor: Collecting NDIS item numbers for bulk pricing lookup');

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
        'InvoiceDataProcessor: Found ${allNdisItemNumbers.length} unique NDIS items: $allNdisItemNumbers');

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
          'Warning: No recognized data structure found in assignedClients');
      debugPrint('Available keys: ${assignedClients.keys}');
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
          if (globalLatest == null || d.isAfter(globalLatest!)) {
            globalLatest = d;
          }
        }
      }
    }
    if (globalLatest != null) {
      this.endDate = DateFormat('dd/MM/yyyy').format(globalLatest!);
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
  }) async {
    Map<String, dynamic> clientData = {};

    clientData['clientEmail'] = doc['clientEmail'] ?? '';
    // Invoice number will be generated in enhanced_invoice_service

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

    clientData['billingAddress'] =
        '${clientDetail['clientAddress'] ?? ''}, ${clientDetail['clientCity'] ?? ''}, ${clientDetail['clientState'] ?? ''} ${clientDetail['clientZip'] ?? ''}';
    clientData['shippingAddress'] = clientData['billingAddress'];

    // Extract employee information from doc
    String userEmail = doc['userEmail'] ?? '';
    String employeeName = employeeDetails?['name'] ??
        doc['employeeName'] ??
        doc['userName'] ??
        '';
    String providerABN = employeeDetails?['abn'] ?? doc['providerABN'] ?? 'N/A';

    if (employeeName.isEmpty && userEmail.isNotEmpty) {
      String emailName = userEmail.split('@')[0];
      employeeName = emailName.replaceAll('.', ' ').replaceAll('_', ' ');
      employeeName = employeeName
          .split(' ')
          .map((word) => word.isNotEmpty
              ? word[0].toUpperCase() + word.substring(1).toLowerCase()
              : '')
          .join(' ');
    }

    clientData['employeeName'] =
        employeeName.isNotEmpty ? employeeName : 'Unknown Employee';
    clientData['employeeEmail'] = userEmail;
    clientData['providerABN'] = providerABN;

    // Defer period start/end calculation until items are built.
    // When no date range is selected, the period will be determined from
    // the earliest and latest record dates after sorting.

    List<Map<String, dynamic>> items = [];

    bool hasWorkedTimeData = workedTimeData != null &&
        workedTimeData['success'] == true &&
        workedTimeData['workedTimes'] != null;

    if (hasWorkedTimeData) {
      debugPrint('Using worked time data for pricing calculations');
      List<dynamic> workedTimes =
          workedTimeData!['workedTimes'] as List<dynamic>;

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
            double hoursWorked = record['actualWorkedTime'] as double? ?? 0.0;

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
                  'Using NDIS item from schedule: $itemNumber - $itemName');
            } else {
              // Fallback to legacy method if no NDIS item data
              String timePeriod = helpers.getTimePeriod(startTime);
              itemName = '${dayOfWeek} $timePeriod';
              itemNumber = itemMap[itemName] ?? '';
              debugPrint(
                  'Using fallback item generation: $itemNumber - $itemName');
            }

            // Get enhanced pricing for this NDIS item
            double rate;
            if (itemNumber.isNotEmpty) {
              rate = await _getEnhancedPricing(itemNumber, organizationId);
              debugPrint(
                  'InvoiceDataProcessor: Enhanced rate for $itemNumber: $rate');
            } else {
              // Use organization fallback base rate when item number is missing
              try {
                if (organizationId != null) {
                  final api = ApiMethod();
                  final fb = await api.getFallbackBaseRate(organizationId);
                  rate = fb != null && fb > 0
                      ? double.parse(fb.toStringAsFixed(2))
                      : 0.0;
                  debugPrint(
                      'InvoiceDataProcessor: Using organization fallback base rate for $dayOfWeek: $rate');
                } else {
                  // As a last resort, use legacy helper mapping
                  rate = helpers.getRate([dayOfWeek], [])[0];
                  rate = double.parse(rate.toStringAsFixed(2));
                  debugPrint(
                      'InvoiceDataProcessor: Using legacy fallback rate for $dayOfWeek: $rate');
                }
              } catch (e) {
                debugPrint(
                    'InvoiceDataProcessor: Error fetching fallback base rate: $e');
                rate = 0.0;
              }
            }

            items.add({
              'date': date,
              'day': dayOfWeek,
              'startTime': startTime,
              'endTime': endTime,
              'hours': hoursWorked,
              'rate': rate,
              'amount': hoursWorked * rate,
              'itemName': itemName,
              'itemCode':
                  itemNumber, // Use itemNumber as itemCode for consistency
              'workedTimeSource': 'database',
              // Add ndisItem structure for PDF generator compatibility
              'ndisItem': {
                'itemNumber': itemNumber,
                'itemName': itemName,
              },
              // Also add direct fields for backward compatibility
              'ndisItemNumber': itemNumber,
              'ndisItemName': itemName,
            });
          }
        }
      }
    } else {
      debugPrint(
          'Using calculated time data for pricing (no worked time data available)');
      List<String> dateList = List<String>.from(doc['dateList'] ?? []);
      List<String> startTimeList =
          List<String>.from(doc['startTimeList'] ?? []);
      List<String> endTimeList = List<String>.from(doc['endTimeList'] ?? []);
      List<String> timeList = List<String>.from(doc['Time'] ?? []);

      // Try to get schedule data with NDIS items from the document
      List<dynamic> schedule = doc['schedule'] as List<dynamic>? ?? [];

      List<String> dayOfWeek = helpers.findDayOfWeek(dateList);
      List<double> totalHours =
          helpers.calculateTotalHours(startTimeList, endTimeList, timeList);

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
              'Using NDIS item from calculated schedule: $itemNumber - $itemName');
        } else {
          // Fallback to legacy method
          String timePeriod = helpers.getTimePeriod(startTimeList[i]);
          itemName = '${dayOfWeek[i]} $timePeriod';
          itemNumber = itemMap[itemName] ?? '';
          debugPrint(
              'Using fallback calculated item generation: $itemNumber - $itemName');
        }

        // Get enhanced pricing for this NDIS item
        double rate;
        if (itemNumber.isNotEmpty) {
          rate = await _getEnhancedPricing(itemNumber, organizationId);
          debugPrint(
              'InvoiceDataProcessor: Enhanced rate for $itemNumber: $rate');
        } else {
          // Use organization fallback base rate when item number is missing
          try {
            if (organizationId != null) {
              final api = ApiMethod();
              final fb = await api.getFallbackBaseRate(organizationId);
              rate = fb != null && fb > 0
                  ? double.parse(fb.toStringAsFixed(2))
                  : 0.0;
              debugPrint(
                  'InvoiceDataProcessor: Using organization fallback base rate for ${dayOfWeek[i]}: $rate');
            } else {
              // As a last resort, use legacy helper mapping
              rate = helpers.getRate([dayOfWeek[i]], [])[0];
              rate = double.parse(rate.toStringAsFixed(2));
              debugPrint(
                  'InvoiceDataProcessor: Using legacy fallback rate for ${dayOfWeek[i]}: $rate');
            }
          } catch (e) {
            debugPrint(
                'InvoiceDataProcessor: Error fetching fallback base rate: $e');
            rate = 0.0;
          }
        }

        items.add({
          'date': dateList[i],
          'day': dayOfWeek[i],
          'startTime': startTimeList[i],
          'endTime': endTimeList[i],
          'hours': totalHours[i],
          'rate': rate,
          'amount': totalHours[i] * rate,
          'itemName': itemName,
          'itemCode': itemNumber, // Use itemNumber as itemCode for consistency
          'workedTimeSource': 'calculated',
          // Add ndisItem structure for PDF generator compatibility
          'ndisItem': {
            'itemNumber': itemNumber,
            'itemName': itemName,
          },
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
      return DateTime(da.year, da.month, da.day)
          .compareTo(DateTime(db.year, db.month, db.day));
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
        if (latest == null || d.isAfter(latest!)) {
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
    if (priceOverrides != null && priceOverrides.isNotEmpty) {
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
                'Applied price override for $itemNumber: \$${originalAmount.toStringAsFixed(2)} -> \$${item['amount'].toStringAsFixed(2)}');
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
        'Data Processor: Processing expenses - received ${expenses?.length ?? 0} expenses');
    if (expenses != null && expenses.isNotEmpty) {
      debugPrint('Data Processor: First raw expense: ${expenses.first}');
      // Filter expenses for this specific client if needed
      final clientEmail = clientData['clientEmail'] as String;
      final clientExpensesRaw = expenses.where((expense) {
        // If expense has clientEmail field, filter by it
        if (expense.containsKey('clientEmail')) {
          return expense['clientEmail'] == clientEmail;
        }
        // Otherwise include all expenses (for backward compatibility)
        return true;
      }).toList();

      // Further filter expenses by selected date range if provided
      final clientExpenses = clientExpensesRaw.where((expense) {
        final inRange = _isExpenseDateInRange(expense['expenseDate'], startDate, endDate);
        if (!inRange) {
          debugPrint(
              'Data Processor: Filtering out expense on ${_formatExpenseDate(expense['expenseDate'])} (outside selected range)');
        }
        return inRange;
      }).toList();

      // Transform expense data to match PDF generator expectations
      final transformedExpenses = clientExpenses.map((expense) {
        // Debug: Log original expense data
        debugPrint(
            'Data Processor: Processing expense: ${expense['description']}');
        debugPrint(
            'Data Processor: Original receiptPhotos: ${expense['receiptPhotos']}');

        // Clean receiptPhotos by removing backticks and trimming
        final originalReceiptPhotos =
            expense['receiptPhotos'] as List<dynamic>? ?? [];
        final cleanedReceiptPhotos = originalReceiptPhotos.map((photo) {
          if (photo is String) {
            final cleaned = photo.trim().replaceAll('`', '');
            debugPrint(
                'Data Processor: Cleaned photo URL: "$photo" -> "$cleaned"');
            return cleaned;
          }
          return photo;
        }).toList();

        // Convert MongoDB expense structure to PDF generator structure
        final transformedExpense = {
          'description': expense['description'] ?? 'Expense',
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
            'Data Processor: Transformed receiptPhotos: ${transformedExpense['receiptPhotos']}');
        return transformedExpense;
      }).toList();

      clientData['expenses'] = transformedExpenses;
      debugPrint(
          'Added ${transformedExpenses.length} transformed expenses to client $clientEmail');
      debugPrint(
          'Data Processor: Final expenses in clientData: ${clientData['expenses']}');
    } else {
      clientData['expenses'] = <Map<String, dynamic>>[];
    }

    // Calculate subtotal from items
    double itemsSubtotal =
        items.fold(0, (sum, item) => sum + (item['amount'] as double));

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

    debugPrint(
        'Invoice totals - Items: \$${itemsSubtotal.toStringAsFixed(2)}, Expenses: \$${expensesTotal.toStringAsFixed(2)}, Subtotal: \$${subtotal.toStringAsFixed(2)}, Total: \$${clientData['total'].toStringAsFixed(2)}');

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
      if (expenseDate is Map<String, dynamic> && expenseDate.containsKey('\$date')) {
        final dateMap = expenseDate['\$date'];
        if (dateMap is Map<String, dynamic> && dateMap.containsKey('\$numberLong')) {
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
  bool _isExpenseDateInRange(dynamic expenseDate, DateTime? startDate, DateTime? endDate) {
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
}
