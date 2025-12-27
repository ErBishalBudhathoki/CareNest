
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:carenest/app/core/providers/invoice_providers.dart';
import 'package:carenest/app/core/services/file_upload_service.dart';
import 'package:carenest/app/features/invoice/services/invoice_pdf_generator_service.dart';
import 'package:carenest/app/features/invoice/services/invoice_email_service.dart';
import 'package:carenest/app/features/invoice/services/invoice_number_generator_service.dart';
import 'package:carenest/app/features/invoice/utils/invoice_data_processor.dart';
import 'package:carenest/app/features/invoice/utils/invoice_helpers.dart';
import 'package:carenest/app/features/invoice/repositories/invoice_repository.dart';
import 'package:carenest/app/features/invoice/presentation/widgets/price_prompt_dialog.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/providers/period_providers.dart';

/// Enhanced Invoice Service with Pricing Integration
/// Task 5.4: Update invoice service with enhanced pricing integration
class EnhancedInvoiceService {
  final Ref ref;
  final InvoiceRepository _repository;
  final InvoiceHelpers _helpers;
  final InvoiceEmailService _emailService;
  final InvoiceDataProcessor _dataProcessor;
  final InvoicePdfGenerator _pdfGenerator;
  final ApiMethod _apiMethod;
  final FileUploadService _fileUploadService;

  // Test-only methods
  // These methods are only used for testing and expose private methods
  @visibleForTesting
  Future<List<Map<String, dynamic>>> testCheckForMissingPrices(
    Map<String, dynamic> processedData, {
    String? organizationId,
  }) async {
    return _checkForMissingPrices(processedData,
        organizationId: organizationId);
  }

  @visibleForTesting
  void testApplyPriceResolutions(Map<String, dynamic> processedData,
      List<Map<String, dynamic>> resolutions,
      {bool? applyTax, double? taxRate}) {
    // Ensure taxRate is never null to prevent 'Null is not a subtype of double' error
    taxRate = taxRate ?? 0.0;
    _applyPriceResolutions(processedData, resolutions,
        applyTax: applyTax, taxRate: taxRate);
  }

  @visibleForTesting
  Future<Map<String, dynamic>> testProcessSelectedEmployeesAndClients(
      List<Map<String, dynamic>> selectedEmployeesAndClients) async {
    return _processSelectedEmployeesAndClients(selectedEmployeesAndClients);
  }

  @visibleForTesting
  void clearInvoicesForTest() {
    _invoices = [];
  }

  @visibleForTesting
  void testRecalculateInvoiceTotal(Map<String, dynamic> client,
      {bool? applyTax, double? taxRate}) {
    _recalculateInvoiceTotal(client, applyTax: applyTax, taxRate: taxRate);
  }

  EnhancedInvoiceService(this.ref, this._apiMethod)
      : _repository = InvoiceRepository(_apiMethod),
        _helpers = InvoiceHelpers(),
        _emailService = InvoiceEmailService(),
        _dataProcessor = InvoiceDataProcessor(ref),
        _pdfGenerator = InvoicePdfGenerator(),
        _fileUploadService = FileUploadService() {
    // Set the enhanced service reference after initialization
    _dataProcessor.setEnhancedInvoiceService(this);
  }

  bool _isLoading = false;
  String _errorMessage = '';
  List<Map<String, dynamic>> _invoices = [];

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  List<Map<String, dynamic>> get invoices => _invoices;

  /// Safely convert a dynamic value to a double.
  /// Supports `num` and numeric `String` values; returns `defaultValue` when
  /// the value is null or cannot be parsed.
  double _safeDouble(dynamic value, {double defaultValue = 0.0}) {
    if (value == null) return defaultValue;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? defaultValue;
    return defaultValue;
  }

  /// Parse a date string in flexible formats to a DateTime.
  /// Supports ISO-8601, `dd/MM/yyyy`, `MM/dd/yyyy`, and `yyyy-MM-dd`.
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

    debugPrint('EnhancedInvoiceService: Could not parse date "$dateStr"');
    return null;
  }

  /// Derive an inclusive period [earliest, latest] from all dates present
  /// in `assignedClients`. Considers worked times and assignment schedules.
  /// Returns a tuple as a `Map` with keys `start` and `end`.
  Map<String, DateTime?> _derivePeriodFromAssignedClients(
      Map<String, dynamic>? assignedClients) {
    if (assignedClients == null) {
      return {'start': null, 'end': null};
    }

    DateTime? derivedStart;
    DateTime? derivedEnd;

    void considerDate(String? dateStr) {
      final parsed = _tryParseDateFlexible(dateStr);
      if (parsed != null) {
        final d = DateTime(parsed.year, parsed.month, parsed.day);
        if (derivedStart == null || d.isBefore(derivedStart!)) {
          derivedStart = d;
        }
        if (derivedEnd == null || d.isAfter(derivedEnd!)) {
          derivedEnd = d;
        }
      }
    }

    try {
      // Current structure: assignedClients['clients'] is a List<Map>
      final clients = assignedClients['clients'] as List<dynamic>? ?? [];
      for (final c in clients) {
        if (c is! Map<String, dynamic>) continue;

        // Worked times
        final workedTimeData = c['workedTimeData'] as Map<String, dynamic>?;
        final workedTimes = workedTimeData?['workedTimes'] as List<dynamic>? ?? [];
        for (final wt in workedTimes) {
          if (wt is Map<String, dynamic>) {
            final schedule = wt['correspondingSchedule'] as Map<String, dynamic>?;
            considerDate(schedule?['date'] as String?);
          }
        }

        // Assignments
        final assignments = c['assignments'] as List<dynamic>? ?? [];
        for (final assignment in assignments) {
          if (assignment is! Map<String, dynamic>) continue;

          // dateList entries
          final dateList = (assignment['dateList'] as List<dynamic>? ?? [])
              .whereType<String>()
              .toList();
          for (final ds in dateList) {
            considerDate(ds);
          }

          // schedule entries
          final schedule = assignment['schedule'] as List<dynamic>? ?? [];
          for (final s in schedule) {
            if (s is Map<String, dynamic>) {
              considerDate(s['date'] as String?);
            }
          }
        }
      }

      // Legacy structure: assignedClients['userDocs']
      final userDocs = assignedClients['userDocs'] as List<dynamic>? ?? [];
      for (final userDocItem in userDocs) {
        if (userDocItem is! Map<String, dynamic>) continue;
        final docs = userDocItem['docs'] as List<dynamic>? ?? [];
        for (final doc in docs) {
          if (doc is! Map<String, dynamic>) continue;
          final assignments = doc['assignments'] as List<dynamic>? ?? [];
          for (final assignment in assignments) {
            if (assignment is! Map<String, dynamic>) continue;
            final dateList = (assignment['dateList'] as List<dynamic>? ?? [])
                .whereType<String>()
                .toList();
            for (final ds in dateList) {
              considerDate(ds);
            }
            final schedule = assignment['schedule'] as List<dynamic>? ?? [];
            for (final s in schedule) {
              if (s is Map<String, dynamic>) {
                considerDate(s['date'] as String?);
              }
            }
          }
        }
      }
    } catch (e) {
      debugPrint('EnhancedInvoiceService: Error deriving period: $e');
    }

    return {'start': derivedStart, 'end': derivedEnd};
  }

  /// Generate invoices with enhanced pricing integration
  /// Enhanced with better validation, pricing metadata, and detailed logging.
  ///
  /// Parameters:
  /// - `selectedEmployeesAndClients`: Selection of employees and clients to include.
  /// - `organizationId`: Optional organization context for pricing and validation.
  /// - `validatePrices`: When true, validates items against price caps.
  /// - `allowPriceCapOverride`: Allow user-provided overrides when items exceed caps.
  /// - `includeDetailedPricingInfo`: Include pricing metadata in the output.
  /// - `applyTax`: Whether to apply tax to invoice totals.
  /// - `taxRate`: Tax percentage; set to 0 when `applyTax` is false.
  /// - `includeExpenses`: Whether to include approved expenses in generation.
  /// - `attachedPhotos`, `photoDescription`, `additionalAttachments`: Optional attachments.
  /// - `priceOverrides`: Optional map for item-specific price adjustments.
  /// - `useAdminBankDetails`: Use admin bank details for invoices when available.
  /// - `startDate`, `endDate`: Optional date range to filter line items and expenses. If omitted,
  ///   the full history for the employee-client is retrieved and the period is
  ///   determined automatically from the earliest and latest record dates.
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
  }) async {
    try {
      _isLoading = true;
      _errorMessage = '';

      // Validate tax rate based on applyTax flag
      // Allow 0% tax for businesses with zero GST; only block negatives
      if (applyTax && taxRate < 0) {
        throw Exception('Tax rate cannot be negative when tax is applied');
      } else if (!applyTax && taxRate != 0) {
        taxRate = 0.0; // Force tax rate to 0 when tax is not applied
      }

      // Establish an effective period used across API calls and display.
      // If the UI provides start/end, use them; otherwise retrieve full history
      // by deriving the range from available assignment records and worked time.
      final now = DateTime.now();
      DateTime? effectiveStart;
      DateTime? effectiveEnd;

      if (startDate != null && endDate != null) {
        // Normalize provided dates to remove time component
        effectiveStart = DateTime(startDate.year, startDate.month, startDate.day);
        effectiveEnd = DateTime(endDate.year, endDate.month, endDate.day);
      } else {
        // No dates selected initially; will derive after loading clients
        effectiveStart = null;
        effectiveEnd = null;
      }

      // Check if running on web platform
      if (kIsWeb) {
        // Show a more helpful error message for web users
        _errorMessage =
            'Invoice generation is not fully supported on web browsers due to platform limitations. Please use the mobile or desktop app for this feature.';
        debugPrint('Web platform detected, showing platform-specific message');

        // Update state to indicate error
        ref.read(invoiceGenerationStateProvider.notifier).state =
            InvoiceGenerationState.error;
        ref.read(invoiceGenerationErrorProvider.notifier).state = _errorMessage;

        return [];
      }

      // Update the invoice generation state
      ref.read(invoiceGenerationStateProvider.notifier).state =
          InvoiceGenerationState.loading;

      // Initialize validation tracking
      Map<String, dynamic> validationSummary = {
        'totalItems': 0,
        'compliantItems': 0,
        'nonCompliantItems': 0,
        'compliancePercentage': 100.0,
        'totalInvoiceAmount': 0.0,
        'compliantAmount': 0.0,
      };

      debugPrint('Starting enhanced invoice generation process');
      debugPrint('=== DEBUG: validatePrices parameter: $validatePrices ===');
      debugPrint(
          '🔥🔥🔥 ENHANCED INVOICE SERVICE CALLED - validatePrices: $validatePrices 🔥🔥🔥');
      final startTime = DateTime.now();

      // Get assigned clients and line items
      Map<String, dynamic>? assignedClients;

      try {
        if (selectedEmployeesAndClients != null &&
            selectedEmployeesAndClients.isNotEmpty) {
          // Use selected employees and clients data
          debugPrint(
              'Using selected employees and clients: ${selectedEmployeesAndClients.length} employees');
          assignedClients = await _processSelectedEmployeesAndClients(
              selectedEmployeesAndClients);

          // Check if we have a critical error in processing
          if (assignedClients.containsKey('metadata') &&
              (assignedClients['metadata'] as Map<String, dynamic>)
                  .containsKey('criticalError')) {
            final errorMsg = assignedClients['metadata']['criticalError'];
            debugPrint(
                'Critical error in processing selected employees and clients: $errorMsg');

            _errorMessage = errorMsg;
            ref.read(invoiceGenerationStateProvider.notifier).state =
                InvoiceGenerationState.error;
            ref.read(invoiceGenerationErrorProvider.notifier).state = errorMsg;
            return [];
          }

          // Check if we have any clients to process
          if (assignedClients['clients'] == null ||
              (assignedClients['clients'] as List).isEmpty) {
            const errorMsg = 'No valid clients found for invoice generation';
            debugPrint(errorMsg);

            _errorMessage = errorMsg;
            ref.read(invoiceGenerationStateProvider.notifier).state =
                InvoiceGenerationState.error;
            ref.read(invoiceGenerationErrorProvider.notifier).state = errorMsg;
            return [];
          }
        } else {
          // Fallback to getting all assigned clients
          debugPrint('Using all assigned clients');
          assignedClients = await _repository.getAssignedClients();

          // Check if we have any clients
          final clientsList = assignedClients?['clients'] as List?;
          if (assignedClients == null ||
              !assignedClients.containsKey('clients') ||
              clientsList == null ||
              clientsList.isEmpty) {
            const errorMsg =
                'No assigned clients found. Please check your client assignments and try again.';
            debugPrint(errorMsg);

            _errorMessage = errorMsg;
            ref.read(invoiceGenerationStateProvider.notifier).state =
                InvoiceGenerationState.error;
            ref.read(invoiceGenerationErrorProvider.notifier).state = errorMsg;
            return [];
          }
        }
      } catch (e) {
        final errorMsg = 'Error retrieving client data: ${e.toString()}';
        debugPrint(errorMsg);

        _errorMessage = errorMsg;
        ref.read(invoiceGenerationStateProvider.notifier).state =
            InvoiceGenerationState.error;
        ref.read(invoiceGenerationErrorProvider.notifier).state = errorMsg;
        return [];
      }

      // Get invoice data (line items and expenses separately)
      Map<String, dynamic> invoiceData = {};
      List<dynamic> lineItems = [];
      List<dynamic> expenses = [];

      // Extract client emails and employee emails from assigned clients for API call
      String? clientEmail;
      String? userEmail;

      try {
        if (assignedClients['clients'] != null) {
          final clients = assignedClients['clients'] as List;
          if (clients.isNotEmpty) {
            clientEmail = clients.first['clientEmail'] as String?;

            // Extract employee email from the client data
            final firstClient = clients.first as Map<String, dynamic>;
            if (firstClient.containsKey('invoiceMetadata') &&
                firstClient['invoiceMetadata'] != null) {
              final metadata =
                  firstClient['invoiceMetadata'] as Map<String, dynamic>;
              userEmail = metadata['employeeEmail'] as String?;
            }

            // If not found in metadata, try to get from employeeDetails
            if (userEmail == null &&
                firstClient.containsKey('employeeDetails') &&
                firstClient['employeeDetails'] != null) {
              final employeeDetails =
                  firstClient['employeeDetails'] as Map<String, dynamic>;
              userEmail = employeeDetails['email'] as String?;
            }

            // Defer defaulting userEmail; perform SharedPreferences fallback later
          }
        }

        // Ensure userEmail has a fallback value with SharedPreferences check
        if (userEmail == null || userEmail.isEmpty) {
          try {
            final sp = SharedPreferencesUtils();
            await sp.init();
            final spEmail = sp.getUserEmail() ??
                await sp.getUserEmailFromSharedPreferences() ??
                '';
            if (spEmail.isNotEmpty) {
              userEmail = spEmail;
            }
          } catch (_) {}
        }
        userEmail ??= 'system@example.com';

        // If no client email is available, use a placeholder or skip the API call
        if (clientEmail == null || clientEmail.isEmpty) {
          debugPrint(
              'Warning: No client email available for invoice data retrieval');
          // Set empty data instead of making API call that will fail
          invoiceData = {
            'lineItems': <dynamic>[],
            'expenses': <dynamic>[],
            'summary': <String, dynamic>{},
            'validation': <String, dynamic>{},
          };
          lineItems = [];
          expenses = [];
        } else {
          // Determine date range for invoice data
          // Using the effective period computed above

          debugPrint(
              'Calling getInvoiceData with userEmail: $userEmail, clientEmail: $clientEmail');

          // If no dates were provided, resolve a period using employee-client configuration
          if (effectiveStart == null && effectiveEnd == null) {
            try {
              final periodService = ref.read(datePeriodServiceProvider);

              // Collect date strings for the specific employee-client pair from assignedClients
              final itemDates = <String>[];
              try {
                final clients = assignedClients['clients'] as List<dynamic>? ?? [];
                for (final c in clients) {
                  if (c is! Map<String, dynamic>) continue;
                  if ((c['clientEmail'] as String?) != clientEmail) continue;

                  // Worked times -> correspondingSchedule.date
                  final workedTimeData = c['workedTimeData'] as Map<String, dynamic>?;
                  final workedTimes = workedTimeData?['workedTimes'] as List<dynamic>? ?? [];
                  for (final wt in workedTimes) {
                    if (wt is Map<String, dynamic>) {
                      final schedule = wt['correspondingSchedule'] as Map<String, dynamic>?;
                      final d = schedule?['date'] as String?;
                      if (d != null) itemDates.add(d);
                    }
                  }

                  // Assignments dateList and schedule dates
                  final assignments = c['assignments'] as List<dynamic>? ?? [];
                  for (final a in assignments) {
                    if (a is! Map<String, dynamic>) continue;
                    final dateList = (a['dateList'] as List<dynamic>? ?? []).whereType<String>();
                    itemDates.addAll(dateList);
                    final sched = a['schedule'] as List<dynamic>? ?? [];
                    for (final s in sched) {
                      if (s is Map<String, dynamic>) {
                        final d = s['date'] as String?;
                        if (d != null) itemDates.add(d);
                      }
                    }
                  }
                }
              } catch (e) {
                debugPrint('EnhancedInvoiceService: Error collecting itemDates for $userEmail/$clientEmail: $e');
              }

              final resolved = await periodService.resolvePeriodForEmployeeClient(
                employeeEmail: userEmail ?? 'unknown@example.com',
                clientEmail: clientEmail ?? 'unknown@example.com',
                itemDates: itemDates,
              );

              effectiveStart = resolved.start;
              effectiveEnd = resolved.end;
              debugPrint('EnhancedInvoiceService: Resolved period => $effectiveStart to $effectiveEnd');
            } catch (e) {
              debugPrint('EnhancedInvoiceService: Period resolution failed: $e');
              // Month fallback to ensure a valid range exists
              final prevMonthStart = DateTime(now.year, now.month - 1, 1);
              final prevMonthEnd = DateTime(prevMonthStart.year, prevMonthStart.month + 1, 0);
              effectiveStart = prevMonthStart;
              effectiveEnd = prevMonthEnd;
              debugPrint('EnhancedInvoiceService: Applied previous-month fallback => $effectiveStart to $effectiveEnd');
            }
          }

          invoiceData = await _repository.getInvoiceData(
            includeExpenses: includeExpenses,
            userEmail: userEmail,
            clientEmail: clientEmail,
            startDate: effectiveStart?.toIso8601String(),
            endDate: effectiveEnd?.toIso8601String(),
          );
          lineItems = List<dynamic>.from(invoiceData['lineItems'] ?? []);
          expenses = List<dynamic>.from(invoiceData['expenses'] ?? []);
        }
        debugPrint(
            'Retrieved ${lineItems.length} line items and ${expenses.length} expenses');
        debugPrint('Include expenses: $includeExpenses');

        if (lineItems.isEmpty && expenses.isEmpty) {
          debugPrint(
              'Warning: No line items or expenses found. Invoices may be empty.');
        }
      } catch (e) {
        final errorMsg = 'Error retrieving invoice data: ${e.toString()}';
        debugPrint(errorMsg);

        _errorMessage = errorMsg;
        ref.read(invoiceGenerationStateProvider.notifier).state =
            InvoiceGenerationState.error;
        ref.read(invoiceGenerationErrorProvider.notifier).state = errorMsg;
        return [];
      }

      // Process data and create invoice models
      Map<String, dynamic> processedData;
      try {
        // Only pass explicit dates when the user selected a period.
        // Otherwise, allow per-client period derivation.
        final bool userProvidedPeriod = startDate != null && endDate != null;
        processedData = await _dataProcessor.processInvoiceData(
          assignedClients: assignedClients,
          lineItems: lineItems.cast<Map<String, dynamic>>(),
          expenses: expenses.cast<Map<String, dynamic>>(),
          applyTax: applyTax,
          taxRate: taxRate,
          priceOverrides: priceOverrides,
          organizationId: organizationId,
          startDate: userProvidedPeriod ? effectiveStart : null,
          endDate: userProvidedPeriod ? effectiveEnd : null,
        );

        // Validate processed data structure
        if (!processedData.containsKey('clients')) {
          processedData['clients'] = [];
          debugPrint(
              'Warning: Processed data missing clients key, adding empty list');
        }

        debugPrint('=== DEBUG: processedData structure ===');
        debugPrint('processedData keys: ${processedData.keys.toList()}');
        if (processedData['clients'] != null) {
          final clients = processedData['clients'] as List;
          debugPrint('Number of clients: ${clients.length}');
          for (int i = 0; i < clients.length && i < 2; i++) {
            final client = clients[i] as Map<String, dynamic>;
            debugPrint('Client $i keys: ${client.keys.toList()}');
            if (client['items'] != null) {
              final items = client['items'] as List;
              debugPrint('Client $i has ${items.length} items');
              if (items.isNotEmpty) {
                final firstItem = items[0] as Map<String, dynamic>;
                debugPrint('First item keys: ${firstItem.keys.toList()}');
                debugPrint(
                    'First item ndisItemNumber: ${firstItem['ndisItemNumber']}');
              }
            }
          }
        }
        debugPrint('=== END DEBUG: processedData structure ===');

        // Derive period per client when no explicit date range was selected.
        if (!userProvidedPeriod) {
          try {
            final periodService = ref.read(datePeriodServiceProvider);
            final df = DateFormat('dd/MM/yyyy');
            final clients = (processedData['clients'] as List<dynamic>? ?? [])
                .whereType<Map<String, dynamic>>()
                .toList();

            for (final client in clients) {
              final items = (client['items'] as List<dynamic>? ?? [])
                  .whereType<Map<String, dynamic>>()
                  .toList();
              final expensesList = (client['expenses'] as List<dynamic>? ?? [])
                  .whereType<Map<String, dynamic>>()
                  .toList();

              // Collect date strings from items and expenses
              final itemDates = <String>[];
              for (final item in items) {
                final d = item['date'] as String?;
                if (d != null && d.isNotEmpty) itemDates.add(d);
              }
              for (final exp in expensesList) {
                final d = exp['date'] as String?;
                if (d != null && d.isNotEmpty) itemDates.add(d);
              }

              if (itemDates.isNotEmpty) {
                try {
                  final resolved = await periodService.resolvePeriodForEmployeeClient(
                    employeeEmail: client['employeeEmail'] as String? ?? 'unknown@example.com',
                    clientEmail: client['clientEmail'] as String? ?? 'unknown@example.com',
                    itemDates: itemDates,
                  );
                  client['startDate'] = df.format(resolved.start);
                  client['endDate'] = df.format(resolved.end);
                } catch (e) {
                  debugPrint('EnhancedInvoiceService: Per-client period derivation failed: $e');
                }
              }
            }
          } catch (e) {
            debugPrint('EnhancedInvoiceService: Error during per-client period calculation: $e');
          }
        }

        // Check if we have any clients after processing
        if ((processedData['clients'] as List).isEmpty) {
          const errorMsg =
              'No valid clients found after data processing. Please check your data and try again.';
          debugPrint(errorMsg);

          _errorMessage = errorMsg;
          ref.read(invoiceGenerationStateProvider.notifier).state =
              InvoiceGenerationState.error;
          ref.read(invoiceGenerationErrorProvider.notifier).state = errorMsg;
          return [];
        }
      } catch (e) {
        final errorMsg = 'Error processing invoice data: ${e.toString()}';
        debugPrint(errorMsg);

        _errorMessage = errorMsg;
        ref.read(invoiceGenerationStateProvider.notifier).state =
            InvoiceGenerationState.error;
        ref.read(invoiceGenerationErrorProvider.notifier).state = errorMsg;
        return [];
      }

      // Add generation metadata
      if (!processedData.containsKey('metadata')) {
        processedData['metadata'] = <String, dynamic>{};
      }

      // Merge with existing metadata if present
      final metadata = processedData['metadata'] as Map<String, dynamic>;
      metadata.addAll({
        'generationTimestamp': DateTime.now().toIso8601String(),
        'validatePrices': validatePrices,
        'allowPriceCapOverride': allowPriceCapOverride,
        'includeDetailedPricingInfo': includeDetailedPricingInfo,
        'version': '2.0', // Enhanced invoice version
      });

      // Add photo attachment data if provided
      if (attachedPhotos != null && attachedPhotos.isNotEmpty) {
        metadata['attachedPhotos'] =
            attachedPhotos.map((photo) => photo.path).toList();
        metadata['photoCount'] = attachedPhotos.length;
      }
      if (photoDescription != null && photoDescription.isNotEmpty) {
        metadata['photoDescription'] = photoDescription;
      }

      // If there were errors in client processing, add them to metadata
      if (assignedClients.containsKey('metadata') &&
          (assignedClients['metadata'] as Map<String, dynamic>)
              .containsKey('errors')) {
        metadata['processingErrors'] = assignedClients['metadata']['errors'];
        metadata['hasProcessingErrors'] = true;
      }

      // Check for missing prices and collect prompts if validation is enabled
      List<Map<String, dynamic>> missingPricePrompts = [];
      if (validatePrices) {
        debugPrint('Validating prices for line items');
        missingPricePrompts = await _checkForMissingPrices(processedData,
            organizationId: organizationId);
        debugPrint(
            'Found ${missingPricePrompts.length} items with missing prices');
      }

      // If there are missing prices, show price prompt dialog
      if (missingPricePrompts.isNotEmpty) {
        // Update state to indicate we're waiting for price inputs
        ref.read(invoiceGenerationStateProvider.notifier).state =
            InvoiceGenerationState.pricePrompting;

        final resolutions = await PricePromptManager.handleMultiplePrompts(
          context: context,
          prompts: missingPricePrompts,
          allowPriceCapOverride: allowPriceCapOverride,
        );

        // If user cancelled, return empty list
        if (resolutions.isEmpty) {
          _errorMessage = 'Invoice generation cancelled by user';
          debugPrint('Invoice generation cancelled by user');

          // Update state to indicate error
          ref.read(invoiceGenerationStateProvider.notifier).state =
              InvoiceGenerationState.error;
          ref.read(invoiceGenerationErrorProvider.notifier).state =
              'Invoice generation cancelled by user';

          return [];
        }

        // Apply price resolutions to processed data
        debugPrint('Applying ${resolutions.length} price resolutions');
        _applyPriceResolutions(processedData, resolutions,
            applyTax: applyTax, taxRate: taxRate);

        // Save custom pricing if requested
        await _saveCustomPricing(resolutions,
            userEmail: userEmail,
            organizationId: assignedClients['organizationId'] as String?);

        // Re-validate after applying price resolutions
        debugPrint('Re-validating prices after resolution');
        await _checkForMissingPrices(processedData,
            organizationId: organizationId);
      }

      // Store processed invoices
      _invoices = List<Map<String, dynamic>>.from(processedData['clients']);
      debugPrint('Generated ${_invoices.length} invoices');

      // Add detailed pricing information if requested
      if (includeDetailedPricingInfo) {
        _addDetailedPricingInfo(_invoices);
      }

      // Compile validation summary from all clients
      if (validatePrices) {
        int totalItems = 0;
        int compliantItems = 0;
        int nonCompliantItems = 0;
        double totalAmount = 0.0;
        double compliantAmount = 0.0;
        List<Map<String, dynamic>> itemsExceedingPriceCap = [];

        for (final client in _invoices) {
          if (client['pricingValidation'] != null) {
            final validation =
                client['pricingValidation'] as Map<String, dynamic>;
            totalItems += (validation['validItems'] as num).toInt() +
                (validation['invalidItems'] as num).toInt();
            compliantItems += (validation['validItems'] as num).toInt();
            nonCompliantItems += (validation['invalidItems'] as num).toInt();
            totalAmount += validation['totalAmount'] as double? ?? 0.0;
            compliantAmount += validation['compliantAmount'] as double? ?? 0.0;
          }

          // Count non-compliant items for tracking
          final lineItems = client['lineItems'] as List<dynamic>? ?? [];
          for (final item in lineItems) {
            if (item is Map<String, dynamic> &&
                item['exceedsPriceCap'] == true) {
              itemsExceedingPriceCap.add({
                'clientName': client['clientName'],
                'ndisItemNumber': item['ndisItemNumber'],
                'description': item['description'],
                'price': item['price'],
                'priceCap': item['priceCap'],
                'difference':
                    (item['price'] - item['priceCap']).toStringAsFixed(2),
              });
            }
          }
        }

        // Calculate overall compliance percentage
        double compliancePercentage =
            totalItems > 0 ? (compliantItems / totalItems) * 100 : 100.0;

        // Update validation summary
        validationSummary = {
          'totalItems': totalItems,
          'compliantItems': compliantItems,
          'nonCompliantItems': nonCompliantItems,
          'compliancePercentage': compliancePercentage,
          'totalInvoiceAmount': totalAmount,
          'compliantAmount': compliantAmount,
          'itemsExceedingPriceCap': itemsExceedingPriceCap,
        };

        // Add validation summary to metadata
        processedData['metadata']['validationSummary'] = validationSummary;
      }

      // Upload attachments before generating PDFs
      List<String>? uploadedPhotoUrls;
      List<String>? uploadedAdditionalFileUrls;

      try {
        // Upload photo attachments if provided
        if (attachedPhotos != null && attachedPhotos.isNotEmpty) {
          debugPrint('Uploading ${attachedPhotos.length} photo attachments...');
          uploadedPhotoUrls = await _fileUploadService
              .uploadMultipleReceiptFiles(attachedPhotos);
          debugPrint(
              'Successfully uploaded ${uploadedPhotoUrls.length} photo attachments');

          // Add uploaded photo URLs to metadata
          metadata['uploadedPhotoUrls'] = uploadedPhotoUrls;
          metadata['uploadedPhotoCount'] = uploadedPhotoUrls.length;
        }

        // Upload additional file attachments if provided
        if (additionalAttachments != null && additionalAttachments.isNotEmpty) {
          debugPrint(
              'Uploading ${additionalAttachments.length} additional file attachments...');
          uploadedAdditionalFileUrls = await _fileUploadService
              .uploadMultipleReceiptFiles(additionalAttachments);
          debugPrint(
              'Successfully uploaded ${uploadedAdditionalFileUrls.length} additional file attachments');

          // Add uploaded additional file URLs to metadata
          metadata['uploadedAdditionalFileUrls'] = uploadedAdditionalFileUrls;
          metadata['uploadedAdditionalFileCount'] =
              uploadedAdditionalFileUrls.length;
        }
      } catch (e) {
        debugPrint('Error uploading attachments: $e');
        // Continue with PDF generation even if upload fails, but log the error
        metadata['attachmentUploadError'] = e.toString();
      }

      // Update state to indicate we're generating PDFs
      ref.read(invoiceGenerationStateProvider.notifier).state =
          InvoiceGenerationState.generating;

      // Generate PDFs for each invoice
      debugPrint(
          'Enhanced Invoice Service: About to generate PDFs for ${_invoices.length} invoices');

      // Debug: Check what data we're passing to PDF generator
      debugPrint(
          'Enhanced Invoice Service: includeExpenses flag was: $includeExpenses');
      for (int i = 0; i < _invoices.length; i++) {
        final client = _invoices[i];
        final expenses = client['expenses'] as List<dynamic>? ?? [];
        debugPrint(
            'Enhanced Invoice Service: Client ${i + 1} (${client['clientName']}) has ${expenses.length} expenses');
        debugPrint(
            'Enhanced Invoice Service: Client data keys: ${client.keys.toList()}');
        if (expenses.isNotEmpty) {
          debugPrint(
              'Enhanced Invoice Service: First expense for client ${i + 1}: ${expenses.first}');
          debugPrint(
              'Enhanced Invoice Service: All expenses for client ${i + 1}: $expenses');
        } else {
          debugPrint(
              'Enhanced Invoice Service: No expenses found for client ${i + 1}');
        }
      }

      // Propagate admin bank details flag into each client before PDF generation
      // This clarifies data contract: generator reads from clientData['useAdminBankDetails']
      if (useAdminBankDetails == true) {
        for (int i = 0; i < _invoices.length; i++) {
          final client = _invoices[i];
          client['useAdminBankDetails'] = true;
                }
      } else {
        // Ensure explicit false for consistency if not present
        for (int i = 0; i < _invoices.length; i++) {
          final client = _invoices[i];
          if (!client.containsKey('useAdminBankDetails')) {
            client['useAdminBankDetails'] = false;
          }
        }
      }

      final pdfPaths = await _pdfGenerator.generatePdfs({
        'clients': _invoices,
        'metadata': processedData['metadata'],
      },
          showTax: applyTax,
          taxRate: taxRate,
          attachedPhotos: attachedPhotos,
          photoDescription: photoDescription,
          uploadedPhotoUrls: uploadedPhotoUrls,
          uploadedAdditionalFileUrls: uploadedAdditionalFileUrls,
          useAdminBankDetails: useAdminBankDetails);
      debugPrint(
          'Enhanced Invoice Service: PDF generation returned ${pdfPaths.length} paths');
      debugPrint('Enhanced Invoice Service: PDF paths: $pdfPaths');

      final endTime = DateTime.now();
      final duration = endTime.difference(startTime);
      debugPrint(
          'Invoice generation completed in ${duration.inSeconds} seconds');

      // Update state to indicate completion
      ref.read(invoiceGenerationStateProvider.notifier).state =
          InvoiceGenerationState.completed;

      // Store generated paths in provider
      ref.read(generatedInvoicePathsProvider.notifier).state = pdfPaths;

      // Save invoices to backend database and get updated invoice numbers
      final updatedPdfPaths =
          await _saveInvoicesToBackend(processedData, pdfPaths, organizationId);

      return updatedPdfPaths ?? pdfPaths;
    } catch (e) {
      // Enhanced error handling with platform-specific checks
      String errorMsg = 'Error generating invoices';

      // Check for web-specific errors related to Argon2
      if (e.toString().contains('0xFFFFFFFFFFFFFFFF') ||
          e
              .toString()
              .contains('cannot be represented exactly in JavaScript')) {
        errorMsg =
            'Error generating invoices: Web platform limitation with encryption. Please use the mobile or desktop app for this feature.';
        debugPrint('Web-specific Argon2 error detected: ${e.toString()}');
      } else if (e.toString().contains('BANK_DETAILS_REQUIRED')) {
        errorMsg =
            'Bank details are missing for both employee and admin. Please add bank details before generating invoices.';
        debugPrint('Bank details missing for both employee and admin');
      } else {
        errorMsg = 'Error generating invoices: ${e.toString()}';
        debugPrint('General error in invoice generation: ${e.toString()}');
      }

      _errorMessage = errorMsg;

      // Update state to indicate error
      ref.read(invoiceGenerationStateProvider.notifier).state =
          InvoiceGenerationState.error;
      ref.read(invoiceGenerationErrorProvider.notifier).state = errorMsg;

      // Log detailed error information
      debugPrint('Stack trace: ${StackTrace.current}');

      return [];
    } finally {
      _isLoading = false;
    }
  }

  /// Add detailed pricing information to invoices
  void _addDetailedPricingInfo(List<Map<String, dynamic>> invoices) {
    for (final invoice in invoices) {
      final lineItems = invoice['lineItems'] as List<dynamic>? ?? [];

      // Add pricing summary to invoice
      int manualPriceCount = 0;
      int customPriceCount = 0;
      int standardPriceCount = 0;
      int exceedsPriceCapCount = 0;

      for (final item in lineItems) {
        if (item is Map<String, dynamic>) {
          // Count pricing sources
          if (item['manuallyPriced'] == true) {
            manualPriceCount++;
          }
          if (item['pricingSource'] == 'Client-specific custom price') {
            customPriceCount++;
          } else if (item['pricingSource'] ==
              'Organization-wide custom price') {
            customPriceCount++;
          } else if (item['pricingSource'] == 'Standard price') {
            standardPriceCount++;
          }

          // Count items exceeding price cap
          if (item['exceedsPriceCap'] == true) {
            exceedsPriceCapCount++;
          }
        }
      }

      // Add pricing summary to invoice
      invoice['pricingSummary'] = {
        'manualPriceCount': manualPriceCount,
        'customPriceCount': customPriceCount,
        'standardPriceCount': standardPriceCount,
        'exceedsPriceCapCount': exceedsPriceCapCount,
        'totalLineItems': lineItems.length,
      };
    }
  }

  /// Public method to get bulk pricing lookup for external use
  /// This allows other services to access pricing data
  Future<Map<String, dynamic>?> getBulkPricingLookup(
    String organizationId,
    List<String> ndisItemNumbers,
  ) async {
    try {
      debugPrint('EnhancedInvoiceService: Public getBulkPricingLookup called');
      debugPrint('EnhancedInvoiceService: Organization ID: $organizationId');
      debugPrint('EnhancedInvoiceService: NDIS items: $ndisItemNumbers');

      final result = await _apiMethod.getBulkPricingLookup(
        organizationId,
        ndisItemNumbers,
      );

      debugPrint(
          'EnhancedInvoiceService: Public getBulkPricingLookup result: $result');
      return result;
    } catch (e) {
      debugPrint(
          'EnhancedInvoiceService: Error in public getBulkPricingLookup: $e');
      return null;
    }
  }

  /// Check for missing prices in the processed data and validate pricing.
  ///
  /// - Prefers organization-wide custom pricing when present.
  /// - Auto-applies the organization fallback base rate from bulk lookup
  ///   for items with missing prices, clamped to `priceCap` when available.
  /// - Rounds applied prices and totals to 2 decimals for consistency.
  /// - Falls back to suggested price and cap APIs when bulk data is absent.
  /// - Returns a list of prompt payloads for items still missing pricing.
  Future<List<Map<String, dynamic>>> _checkForMissingPrices(
    Map<String, dynamic> processedData, {
    String? organizationId,
  }) async {
    debugPrint(
        'Enhanced Invoice Service: _checkForMissingPrices method called!');
    final List<Map<String, dynamic>> missingPricePrompts = [];
    final List<String> validationErrors = [];

    // Validate input structure
    if (!processedData.containsKey('clients')) {
      debugPrint(
          'Warning: processedData missing clients key in _checkForMissingPrices');
      return missingPricePrompts; // Return empty list
    }

    final clients = processedData['clients'] as List<dynamic>? ?? [];
    if (clients.isEmpty) {
      debugPrint('Warning: No clients found in _checkForMissingPrices');
      return missingPricePrompts; // Return empty list
    }

    // Collect all unique NDIS item numbers for bulk pricing lookup
    Set<String> ndisItemNumbers = {};
    for (final client in clients) {
      final clientMap = client as Map<String, dynamic>;
      // The processed data uses 'items' as the key, not 'lineItems'
      final items = clientMap['items'] as List<dynamic>? ?? [];
      debugPrint('Enhanced Invoice Service: Client items structure: $items');
      for (final item in items) {
        debugPrint('Enhanced Invoice Service: Processing item: $item');
        final itemMap = item as Map<String, dynamic>;
        // Check both possible field names for NDIS item number
        final ndisItemNumber = itemMap['ndisItemNumber'] as String? ??
            itemMap['itemCode'] as String?;
        debugPrint(
            'Enhanced Invoice Service: Found NDIS item number: $ndisItemNumber');
        if (ndisItemNumber != null && ndisItemNumber.isNotEmpty) {
          ndisItemNumbers.add(ndisItemNumber);
        }
      }
    }

    debugPrint(
        'Enhanced Invoice Service: Collected NDIS item numbers for bulk lookup: $ndisItemNumbers');

    // Perform bulk pricing lookup if we have NDIS item numbers
    Map<String, dynamic>? bulkPricingData = {};
    if (ndisItemNumbers.isNotEmpty) {
      try {
        // Get organizationId from parameter, first client, or use a default
        String? finalOrganizationId = organizationId;
        if (finalOrganizationId == null && clients.isNotEmpty) {
          final firstClient = clients.first as Map<String, dynamic>;
          finalOrganizationId = firstClient['organizationId'] as String? ??
              processedData['organizationId'] as String?;
        }
        finalOrganizationId ??=
            'default-org'; // Fallback if no organizationId found

        debugPrint(
            'Enhanced Invoice Service: About to call getBulkPricingLookup with organizationId: $finalOrganizationId');
        debugPrint(
            'Enhanced Invoice Service: Performing bulk pricing lookup for ${ndisItemNumbers.length} items');
        bulkPricingData = await _apiMethod.getBulkPricingLookup(
          finalOrganizationId,
          ndisItemNumbers.toList(),
        );
        debugPrint(
            'Enhanced Invoice Service: Bulk pricing lookup completed successfully');
        debugPrint(
            'Enhanced Invoice Service: Organization ID used: $finalOrganizationId');
        debugPrint(
            'Enhanced Invoice Service: NDIS items requested: $ndisItemNumbers');
        debugPrint(
            'Enhanced Invoice Service: Bulk pricing data received: $bulkPricingData');

        // Debug: Check specific items mentioned by user
        if (bulkPricingData != null) {
          final item01020 = bulkPricingData['01_020_0120_1_1'];
          debugPrint(
              'Enhanced Invoice Service: DEBUG - Item 01_020_0120_1_1 data: $item01020');
          if (item01020 != null) {
            debugPrint(
                'Enhanced Invoice Service: DEBUG - Custom price for 01_020_0120_1_1: ${item01020['customPrice']}');
            debugPrint(
                'Enhanced Invoice Service: DEBUG - Standard price for 01_020_0120_1_1: ${item01020['standardPrice']}');
          }
        }
      } catch (e) {
        debugPrint(
            'Enhanced Invoice Service: Error in bulk pricing lookup: $e');
        bulkPricingData = {};
      }
    }

    // Process each client
    for (int clientIndex = 0; clientIndex < clients.length; clientIndex++) {
      try {
        final client = clients[clientIndex] as Map<String, dynamic>;
        if (!client.containsKey('lineItems')) {
          debugPrint('Warning: Client at index $clientIndex has no lineItems');
          continue; // Skip to next client
        }

        final lineItems = client['lineItems'] as List<dynamic>? ?? [];
        if (lineItems.isEmpty) {
          debugPrint(
              'Warning: Client at index $clientIndex has empty lineItems');
          continue; // Skip to next client
        }

        final clientId = client['clientId'];
        if (clientId == null) {
          debugPrint('Warning: Client at index $clientIndex has no clientId');
          continue; // Skip to next client
        }

        final clientName = client['clientName'] as String? ?? 'Unknown Client';

        // Prepare line items for validation
        final List<Map<String, dynamic>> itemsToValidate = [];

        // First pass: collect items for validation
        for (int itemIndex = 0; itemIndex < lineItems.length; itemIndex++) {
          try {
            final item = lineItems[itemIndex] as Map<String, dynamic>;
            final ndisItemNumber = item['ndisItemNumber'];
            final price = (item['price'] is num)
                ? (item['price'] as num).toDouble()
                : 0.0;

            // Add to validation list if it has a price and NDIS item number
            if (ndisItemNumber != null && price > 0) {
              itemsToValidate.add({
                'ndisItemNumber': ndisItemNumber,
                'unitPrice': price,
                'quantity': item['quantity'] is num
                    ? (item['quantity'] as num).toDouble()
                    : 1.0,
                'description': item['description'] as String? ?? '',
                'clientId': clientId,
              });
            }
          } catch (e) {
            debugPrint(
                'Error processing line item $itemIndex for client $clientName: $e');
            validationErrors
                .add('Error processing line item for $clientName: $e');
          }
        }

        // Validate pricing for items with prices
        if (itemsToValidate.isNotEmpty) {
          try {
            final validationResult = await _apiMethod.validateInvoicePricing(
              lineItems: itemsToValidate,
              state: client['state'] as String? ?? 'NSW',
              providerType: client['providerType'] as String? ?? 'standard',
            );

            if (validationResult['success'] == true &&
                validationResult['data'] != null &&
                validationResult['data']['validationResults'] != null) {
              // Process validation results
              final validationResults = validationResult['data']
                  ['validationResults'] as List<dynamic>;

              // Update line items with validation information
              for (int itemIndex = 0;
                  itemIndex < lineItems.length;
                  itemIndex++) {
                try {
                  final item = lineItems[itemIndex] as Map<String, dynamic>;
                  final ndisItemNumber = item['ndisItemNumber'];
                  if (ndisItemNumber == null) continue;

                  // Find matching validation result
                  Map<String, dynamic>? matchingResult;
                  try {
                    for (final result in validationResults) {
                      if (result is Map<String, dynamic> &&
                          result['ndisItemNumber'] == ndisItemNumber) {
                        matchingResult = result;
                        break;
                      }
                    }
                  } catch (e) {
                    debugPrint('Error finding matching validation result: $e');
                    matchingResult = null;
                  }

                  if (matchingResult != null) {
                    // Update item with validation information
                    item['isCompliant'] = matchingResult['isCompliant'] ?? true;
                    item['priceCap'] = matchingResult['priceCap'];
                    item['exceedsPriceCap'] =
                        matchingResult['isCompliant'] == false;
                    item['complianceStatus'] =
                        matchingResult['complianceStatus'] ?? 'unknown';

                    // Add validation metadata
                    if (item['metadata'] == null) {
                      item['metadata'] = {};
                    }
                    (item['metadata'] as Map<String, dynamic>)['validation'] = {
                      'timestamp': DateTime.now().toIso8601String(),
                      'isValid': matchingResult['isValid'] ?? true,
                      'validationSource': 'price_validation_service',
                    };
                  }
                } catch (e) {
                  debugPrint(
                      'Error updating line item $itemIndex with validation info: $e');
                }
              }

              // Add validation summary to client
              try {
                final summary = validationResult['data']['summary']
                        as Map<String, dynamic>? ??
                    {};
                client['pricingValidation'] = {
                  'compliancePercentage':
                      summary['compliancePercentage'] ?? 100,
                  'hasNonCompliantItems':
                      (summary['invalidItems'] as num? ?? 0) > 0,
                  'validItems': summary['validItems'] as num? ?? 0,
                  'invalidItems': summary['invalidItems'] as num? ?? 0,
                  'totalAmount': summary['totalInvoiceAmount'] as num? ?? 0,
                  'compliantAmount':
                      summary['totalCompliantAmount'] as num? ?? 0,
                };
              } catch (e) {
                debugPrint(
                    'Error adding validation summary to client $clientName: $e');
                validationErrors.add(
                    'Error adding validation summary to client $clientName: $e');

                // Add default validation summary
                client['pricingValidation'] = {
                  'compliancePercentage': 100,
                  'hasNonCompliantItems': false,
                  'validItems': 0,
                  'invalidItems': 0,
                  'totalAmount': 0,
                  'compliantAmount': 0,
                  'error': 'Failed to process validation summary: $e'
                };
              }
            } else {
              // Handle unsuccessful validation
              final errorMsg =
                  validationResult['message'] ?? 'Unknown validation error';
              debugPrint('Validation error for client $clientName: $errorMsg');
              validationErrors
                  .add('Validation error for client $clientName: $errorMsg');

              // Add error validation summary
              client['pricingValidation'] = {
                'compliancePercentage': 0,
                'hasNonCompliantItems': false,
                'validItems': 0,
                'invalidItems': 0,
                'totalAmount': 0,
                'compliantAmount': 0,
                'error': errorMsg
              };
            }
          } catch (e) {
            debugPrint('Error validating pricing for client $clientName: $e');
            validationErrors
                .add('Error validating pricing for client $clientName: $e');

            // Add error validation summary
            client['pricingValidation'] = {
              'compliancePercentage': 0,
              'hasNonCompliantItems': false,
              'validItems': 0,
              'invalidItems': 0,
              'totalAmount': 0,
              'compliantAmount': 0,
              'error': 'Validation failed: $e'
            };
          }
        } else {
          // No items to validate
          debugPrint('No items to validate for client $clientName');

          // Add empty validation summary
          client['pricingValidation'] = {
            'compliancePercentage': 100,
            'hasNonCompliantItems': false,
            'validItems': 0,
            'invalidItems': 0,
            'totalAmount': 0,
            'compliantAmount': 0,
            'note': 'No items to validate'
          };
        }

        // Check for missing prices
        for (int itemIndex = 0; itemIndex < lineItems.length; itemIndex++) {
          try {
            final item = lineItems[itemIndex] as Map<String, dynamic>;
            final ndisItemNumber = item['ndisItemNumber'];
            final itemDescription =
                item['description'] as String? ?? 'Unknown Item';
            final price = item['price'];

            // Check if price is missing, zero, or if custom pricing is available
            bool needsPricing = price == null || (price is num && price <= 0);
            bool hasCustomPricing = false;
            double? customPrice;

            // Check for custom pricing in bulk data regardless of existing price
            final cachedPricing = bulkPricingData?[ndisItemNumber];
            debugPrint(
                'Enhanced Invoice Service: DEBUG - Processing item $ndisItemNumber with existing price: $price');
            debugPrint(
                'Enhanced Invoice Service: DEBUG - Cached pricing data for $ndisItemNumber: $cachedPricing');

            if (cachedPricing != null && cachedPricing['customPrice'] != null) {
              final customPriceStr = cachedPricing['customPrice'].toString();
              debugPrint(
                  'Enhanced Invoice Service: DEBUG - Custom price string for $ndisItemNumber: "$customPriceStr"');
              if (customPriceStr.isNotEmpty && customPriceStr != 'null') {
                customPrice = double.tryParse(customPriceStr);
                debugPrint(
                    'Enhanced Invoice Service: DEBUG - Parsed custom price for $ndisItemNumber: $customPrice');
                if (customPrice != null && customPrice > 0) {
                  hasCustomPricing = true;
                  debugPrint(
                      'Enhanced Invoice Service: Found custom price for $ndisItemNumber: $customPrice');
                } else {
                  debugPrint(
                      'Enhanced Invoice Service: DEBUG - Custom price is null or zero for $ndisItemNumber');
                }
              } else {
                debugPrint(
                    'Enhanced Invoice Service: DEBUG - Custom price string is empty or null for $ndisItemNumber');
              }
            } else {
              debugPrint(
                  'Enhanced Invoice Service: DEBUG - No cached pricing or custom price for $ndisItemNumber');
            }

            // Apply custom pricing immediately if available
            if (hasCustomPricing && customPrice != null) {
              item['price'] = customPrice;
              item['pricingSource'] = 'Organization-wide custom price';
              item['hasCustomPricing'] = true;
              debugPrint(
                  'Enhanced Invoice Service: Applied custom price $customPrice to $ndisItemNumber');

              // Recalculate total for this line item
              final quantity = item['quantity'] ?? 1;
              item['total'] = customPrice * quantity;
            }

            // If price is missing, try to use fallback base rate from bulk lookup first
            if (needsPricing) {
              // Apply organization fallback base rate from bulk pricing if available
              final fallbackFromBulk = () {
                try {
                  final cachedPricing = bulkPricingData?[ndisItemNumber];
                  if (cachedPricing != null) {
                    final priceField = cachedPricing['price'];
                    if (priceField != null) {
                      final parsed = double.tryParse(priceField.toString());
                      if (parsed != null && parsed > 0) {
                        // Attach price cap if present in bulk data
                        double? cap;
                        final priceCapStr = cachedPricing['priceCap']?.toString();
                        if (priceCapStr != null && priceCapStr.isNotEmpty && priceCapStr != 'null') {
                          cap = double.tryParse(priceCapStr);
                        }

                        // Clamp to price cap when present
                        double applied = parsed;
                        if (cap != null && cap > 0 && applied > cap) {
                          applied = cap;
                        }
                        // Round to 2 decimals
                        final roundedPrice = double.parse(applied.toStringAsFixed(2));

                        item['price'] = roundedPrice;
                        item['pricingSource'] = 'Organization fallback base rate';
                        item['hasCustomPricing'] = false;
                        if (cap != null) {
                          item['priceCap'] = cap;
                          item['exceedsPriceCap'] = roundedPrice > cap;
                        }
                        // Recalculate total for this line item
                        final quantity = item['quantity'] ?? 1;
                        final qty = (quantity is num) ? (quantity).toDouble() : 1.0;
                        item['total'] = double.parse((roundedPrice * qty).toStringAsFixed(2));
                        return true;
                      }
                    }
                  }
                } catch (e) {
                  debugPrint('Enhanced Invoice Service: Error applying fallback base rate from bulk pricing for $ndisItemNumber: $e');
                }
                return false;
              }();

              // If we successfully applied fallback base rate, we no longer need prompting
              if (fallbackFromBulk) {
                needsPricing = false;
              }

              // Only proceed with missing price prompts if price is still actually missing
              if (needsPricing) {
              // Get pricing information from bulk pricing data
              double? priceCap;
              double? suggestedPrice =
                  customPrice; // Use custom price if available
              List<Map<String, dynamic>>? priceHistory = [];

              // Use bulk pricing data if available
              debugPrint(
                  'Enhanced Invoice Service: Using cached pricing for $ndisItemNumber: $cachedPricing');

              if (cachedPricing != null) {
                try {
                  // Custom price already handled above

                  // Fallback to standard price if no custom price
                  if (suggestedPrice == null || suggestedPrice <= 0) {
                    if (cachedPricing['standardPrice'] != null) {
                      final standardPriceStr =
                          cachedPricing['standardPrice'].toString();
                      if (standardPriceStr.isNotEmpty &&
                          standardPriceStr != 'null') {
                        suggestedPrice = double.tryParse(standardPriceStr);
                        debugPrint(
                            'Enhanced Invoice Service: Using standard price for $ndisItemNumber: $suggestedPrice');
                      }
                    }
                  }

                  // Get price cap from bulk data
                  if (cachedPricing['priceCap'] != null) {
                    final priceCapStr = cachedPricing['priceCap'].toString();
                    if (priceCapStr.isNotEmpty && priceCapStr != 'null') {
                      priceCap = double.tryParse(priceCapStr);
                    }
                  }
                } catch (e) {
                  debugPrint(
                      'Enhanced Invoice Service: Error parsing cached pricing for $ndisItemNumber: $e');
                }
              }

              // Fallback to individual API calls if bulk data is not available
              if (suggestedPrice == null || suggestedPrice <= 0) {
                try {
                  suggestedPrice =
                      await _getSuggestedPrice(ndisItemNumber, clientId);
                } catch (e) {
                  debugPrint(
                      'Enhanced Invoice Service: Error getting suggested price for $ndisItemNumber: $e');
                  suggestedPrice = null;
                }
              }

              if (priceCap == null) {
                try {
                  priceCap = await _getPriceCap(ndisItemNumber);
                } catch (e) {
                  debugPrint(
                      'Enhanced Invoice Service: Error getting price cap for $ndisItemNumber: $e');
                  priceCap = null;
                }
              }

              // Get price history (this is not typically in bulk data)
              try {
                priceHistory = await _getPriceHistory(ndisItemNumber, clientId);
              } catch (e) {
                debugPrint(
                    'Enhanced Invoice Service: Error getting price history for $ndisItemNumber: $e');
                priceHistory = [];
              }

              missingPricePrompts.add({
                'promptId': 'client${clientIndex}_item$itemIndex',
                'clientIndex': clientIndex,
                'itemIndex': itemIndex,
                'clientId': clientId,
                'clientName': clientName,
                'ndisItemNumber': ndisItemNumber ?? 'N/A',
                'itemDescription': itemDescription,
                'quantity': item['quantity'] is num
                    ? (item['quantity'] as num).toDouble()
                    : 1.0,
                'unit': item['unit'] as String? ?? 'unit',
                'priceCap': priceCap,
                'suggestedPrice': suggestedPrice,
                'priceHistory': priceHistory ?? [],
                'hasCustomPricing': suggestedPrice != null &&
                    suggestedPrice > 0 &&
                    priceCap != null &&
                    suggestedPrice != priceCap,
              });
              }
            }
          } catch (e) {
            debugPrint(
                'Error checking for missing prices in item $itemIndex for client $clientName: $e');
            validationErrors.add(
                'Error checking prices for item in client $clientName: $e');
          }
        }
      } catch (e) {
        debugPrint('Error processing client at index $clientIndex: $e');
        validationErrors
            .add('Error processing client at index $clientIndex: $e');
      }
    }

    // Add validation errors to processedData metadata
    if (validationErrors.isNotEmpty) {
      if (!processedData.containsKey('metadata')) {
        processedData['metadata'] = {};
      }

      final metadata = processedData['metadata'] as Map<String, dynamic>;
      metadata['validationErrors'] = validationErrors;
      metadata['hasValidationErrors'] = true;
    }

    return missingPricePrompts;
  }

  /// Get price cap for NDIS item
  /// Enhanced with better error handling and logging
  Future<double?> _getPriceCap(String? ndisItemNumber) async {
    if (ndisItemNumber == null) return null;

    try {
      // Get price cap from API
      final priceCap = await _apiMethod.getNdisItemPriceCap(ndisItemNumber);
      return priceCap;
    } catch (e) {
      debugPrint('Error getting price cap: $e');
      return null;
    }
  }

  /// Get suggested price for NDIS item
  /// Enhanced with prioritized pricing sources and better logging.
  /// Note: Standard price is metadata-only (NDIS cap); not used as a billable rate.
  Future<double?> _getSuggestedPrice(
      String? ndisItemNumber, String? clientId) async {
    if (ndisItemNumber == null) return null;

    try {
      // Try to get custom price for this client first
      if (clientId != null) {
        final clientPrice =
            await _apiMethod.getCustomPriceForClient(ndisItemNumber, clientId);
        if (clientPrice > 0) {
          debugPrint(
              'Using client-specific price for $ndisItemNumber: $clientPrice');
          return clientPrice;
        }
      }

      // Try to get organization-wide custom price
      final orgPrice =
          await _apiMethod.getCustomPriceForOrganization(ndisItemNumber);
      if (orgPrice > 0) {
        debugPrint(
            'Using organization-wide price for $ndisItemNumber: $orgPrice');
        return orgPrice;
      }

      // Fall back to standard price (metadata only)
      final standardPrice = await _apiMethod.getStandardPrice(ndisItemNumber);
      debugPrint('Using standard price metadata for $ndisItemNumber: $standardPrice');
      return standardPrice;
    } catch (e) {
      debugPrint('Error getting suggested price: $e');
      return null;
    }
  }

  /// Get standard price metadata for an item (NDIS cap; not a billable rate).
  ///
  /// Parameters:
  /// - `ndisItemNumber`: The NDIS support item number.
  /// - `clientId`: Optional client ID to allow state-aware resolution when supported.
  ///
  /// Returns: The standard price as `double` if available; otherwise `null`.
  /// Backend now returns `price: null` and cap metadata only; this method returns
  /// `null` when backend indicates no base price is available.
  Future<double?> getStandardPriceForItem(String ndisItemNumber, {String? clientId}) async {
    try {
      final price = await _apiMethod.getStandardPrice(ndisItemNumber);
      return price > 0 ? price : null;
    } catch (e) {
      debugPrint('EnhancedInvoiceService: Error fetching standard price for $ndisItemNumber: $e');
      return null;
    }
  }

  /// Get price history for an NDIS item
  /// Returns recent pricing decisions for this item
  Future<List<Map<String, dynamic>>> _getPriceHistory(
      String? ndisItemNumber, String? clientId) async {
    if (ndisItemNumber == null) return [];

    try {
      // Get price history from API if available
      if (clientId != null) {
        final history =
            await _apiMethod.getPriceHistory(ndisItemNumber, clientId);
        return history ?? [];
      }
      return [];
    } catch (e) {
      debugPrint('Error getting price history: $e');
      return [];
    }
  }

  /// Apply price resolutions to processed data
  /// Enhanced with better validation and detailed pricing information
  void _applyPriceResolutions(Map<String, dynamic> processedData,
      List<Map<String, dynamic>> resolutions,
      {bool? applyTax, double? taxRate}) {
    final clients = processedData['clients'] as List<dynamic>? ?? [];

    for (final resolution in resolutions) {
      final promptId = resolution['promptId'] as String;
      final parts = promptId.split('_');
      final clientIndexStr = parts[0].replaceAll('client', '');
      final itemIndexStr = parts[1].replaceAll('item', '');

      final clientIndex = int.parse(clientIndexStr);
      final itemIndex = int.parse(itemIndexStr);

      if (clientIndex < clients.length) {
        final client = clients[clientIndex] as Map<String, dynamic>;
        final lineItems = client['lineItems'] as List<dynamic>? ?? [];

        if (itemIndex < lineItems.length) {
          final item = lineItems[itemIndex] as Map<String, dynamic>;
          final resolutionData =
              resolution['resolution'] as Map<String, dynamic>;
          final providedPrice = resolutionData['providedPrice'] as double;

          // Update the price in the line item with enhanced information
          item['price'] = providedPrice;
          item['pricingNotes'] = resolutionData['notes'];
          item['pricingSource'] = _determinePricingSource(resolutionData);
          item['pricingDate'] = DateTime.now().toIso8601String();

          // Add validation information
          if (item['priceCap'] != null &&
              providedPrice > (item['priceCap'] as double)) {
            item['exceedsPriceCap'] = true;
            item['priceCapExceedReason'] =
                resolutionData['notes'] ?? 'Manual override';
          } else {
            item['exceedsPriceCap'] = false;
          }

          // Recalculate total for this line item
          final quantity = item['quantity'] ?? 1;
          item['total'] = providedPrice * quantity;

          // Add flags for pricing source
          item['manuallyPriced'] = true;
          item['saveAsCustomPrice'] =
              resolutionData['saveAsCustomPricing'] ?? false;
          item['applyToClientOnly'] = resolutionData['applyToClient'] ?? false;
          item['applyToOrganization'] =
              resolutionData['applyToOrganization'] ?? false;
        }
      }
    }

    // Recalculate invoice totals for each client
    for (final client in clients) {
      if (client is Map<String, dynamic>) {
        _recalculateInvoiceTotal(client, applyTax: applyTax, taxRate: taxRate);
      }
    }
  }

  /// Determine the source of pricing based on resolution data
  String _determinePricingSource(Map<String, dynamic> resolutionData) {
    if (resolutionData['applyToClient'] == true) {
      return 'Client-specific custom price';
    } else if (resolutionData['applyToOrganization'] == true) {
      return 'Organization-wide custom price';
    } else {
      return 'Manual price entry';
    }
  }

  /// Recalculate invoice total for a client
  void _recalculateInvoiceTotal(Map<String, dynamic> client,
      {bool? applyTax, double? taxRate}) {
    final lineItems = client['lineItems'] as List<dynamic>? ?? [];
    final expenses = client['expenses'] as List<dynamic>? ?? [];

    // Calculate items subtotal (line items only)
    double itemsSubtotal = 0;
    for (final item in lineItems) {
      if (item is Map<String, dynamic>) {
        itemsSubtotal += item['total'] ?? 0;
      }
    }

    // Calculate expenses total
    double expensesTotal = 0;
    for (final expense in expenses) {
      if (expense is Map<String, dynamic>) {
        expensesTotal += expense['totalAmount'] ??
            expense['amount'] ??
            expense['unitCost'] ??
            0;
      }
    }

    // Calculate overall subtotal (items + expenses)
    final subtotal = itemsSubtotal + expensesTotal;

    client['itemsSubtotal'] = itemsSubtotal;
    client['expensesTotal'] = expensesTotal;
    client['subtotal'] = subtotal;

    // Calculate tax if applicable - use provided parameters or fall back to client data
    final shouldApplyTax = applyTax ?? (client['taxExempt'] != true);
    debugPrint(
        'Enhanced Invoice Service _recalculateInvoiceTotal: applyTax=$applyTax, taxRate=$taxRate');
    final currentTaxRate =
        taxRate ?? client['taxRate'] ?? 0.0; // Default 0% tax
    final taxAmount = shouldApplyTax ? (subtotal * currentTaxRate) : 0.0;

    client['taxAmount'] = taxAmount;
    client['tax'] = taxAmount; // PDF generator expects 'tax' field
    client['taxRate'] = currentTaxRate;
    client['total'] = subtotal + taxAmount;
  }

  /// Save custom pricing if requested
  /// Enhanced with better validation, error handling, and pricing metadata
  Future<Map<String, dynamic>> _saveCustomPricing(
    List<Map<String, dynamic>> resolutions, {
    String? userEmail,
    String? organizationId,
  }) async {
    final Map<String, dynamic> result = {
      'success': true,
      'savedCount': 0,
      'skippedCount': 0,
      'errors': <String>[],
    };

    if (resolutions.isEmpty) {
      debugPrint('Warning: No price resolutions to save');
      result['message'] = 'No price resolutions to save';
      return result;
    }

    for (final resolution in resolutions) {
      try {
        final res = resolution['resolution'] as Map<String, dynamic>;

        if (res['saveAsCustomPricing'] == true) {
          final promptId = resolution['promptId'] as String;
          final parts = promptId.split('_');
          final clientIndexStr = parts[0].replaceAll('client', '');
          final itemIndexStr = parts[1].replaceAll('item', '');

          final clientIndex = int.parse(clientIndexStr);
          final itemIndex = int.parse(itemIndexStr);

          if (clientIndex < _invoices.length) {
            final client = _invoices[clientIndex];
            final lineItems = client['lineItems'] as List<dynamic>? ?? [];

            if (itemIndex < lineItems.length) {
              final item = lineItems[itemIndex] as Map<String, dynamic>;
              final ndisItemNumber = item['ndisItemNumber'];
              final price = (res['providedPrice'] as num).toDouble();
              final notes = res['notes'] as String?;

              // Enhanced pricing metadata
              final pricingMetadata = {
                'timestamp': DateTime.now().toIso8601String(),
                'notes': notes ?? '',
                'originalPrice': item['originalPrice'] ?? 0.0,
                'suggestedPrice': item['suggestedPrice'] ?? 0.0,
                'priceCap': item['priceCap'],
                'exceedsPriceCap': item['priceCap'] != null &&
                    price > (item['priceCap'] as double),
                'source': 'invoice_generation',
                'itemDescription': item['description'] ?? '',
              };

              if (ndisItemNumber != null) {
                bool saved = false;
                try {
                  if (res['applyToClient'] == true &&
                      client['clientId'] != null) {
                    // Save custom price for this client
                    debugPrint(
                        'Saving client-specific custom price for $ndisItemNumber: $price');
                    final saveResult =
                        await _apiMethod.saveCustomPriceForClient(
                      ndisItemNumber,
                      client['clientId'],
                      price,
                      notes ?? '',
                      metadata: pricingMetadata,
                      userEmail: userEmail,
                      organizationId: organizationId,
                    );

                    if (saveResult != null && saveResult['success'] == true) {
                      saved = true;
                    } else {
                      final errorMsg = saveResult?['message'] ??
                          'Unknown error saving client price';
                      result['errors'].add(
                          'Error saving client price for $ndisItemNumber: $errorMsg');
                      debugPrint('Error saving client price: $errorMsg');
                    }
                  } else if (res['applyToOrganization'] == true) {
                    // Save custom price for the entire organization
                    debugPrint(
                        'Saving organization-wide custom price for $ndisItemNumber: $price');
                    final saveResult =
                        await _apiMethod.saveCustomPriceForOrganization(
                      ndisItemNumber,
                      price,
                      notes ?? '',
                      metadata: pricingMetadata,
                      userEmail: userEmail,
                      organizationId: organizationId,
                    );

                    if (saveResult != null && saveResult['success'] == true) {
                      saved = true;
                    } else {
                      final errorMsg = saveResult?['message'] ??
                          'Unknown error saving organization price';
                      result['errors'].add(
                          'Error saving organization price for $ndisItemNumber: $errorMsg');
                      debugPrint('Error saving organization price: $errorMsg');
                    }
                  } else {
                    // Just for this invoice, no need to save to database
                    debugPrint(
                        'Using custom price for this invoice only: $ndisItemNumber: $price');
                    result['skippedCount'] =
                        (result['skippedCount'] as int) + 1;
                  }

                  if (saved) {
                    result['savedCount'] = (result['savedCount'] as int) + 1;
                  }
                } catch (e) {
                  debugPrint('Error saving custom pricing: $e');
                  result['errors']
                      .add('Error saving price for $ndisItemNumber: $e');
                  result['skippedCount'] = (result['skippedCount'] as int) + 1;
                  // Continue with other price saves even if one fails
                }
              } else {
                debugPrint(
                    'Cannot save custom price: Missing NDIS item number');
                result['skippedCount'] = (result['skippedCount'] as int) + 1;
                result['errors'].add('Missing NDIS item number for price save');
              }
            } else {
              result['skippedCount'] = (result['skippedCount'] as int) + 1;
              result['errors'].add('Invalid item index: $itemIndex');
            }
          } else {
            result['skippedCount'] = (result['skippedCount'] as int) + 1;
            result['errors'].add('Invalid client index: $clientIndex');
          }
        } else {
          result['skippedCount'] = (result['skippedCount'] as int) + 1;
        }
      } catch (e) {
        debugPrint('Error processing resolution: $e');
        result['errors'].add('Error processing resolution: $e');
        result['skippedCount'] = (result['skippedCount'] as int) + 1;
      }
    }

    // Update success flag if there were errors
    if (result['errors'].isNotEmpty) {
      result['success'] = false;
      result['message'] = 'Completed with ${result['errors'].length} errors';
    } else {
      result['message'] =
          'Successfully saved ${result['savedCount']} custom prices';
    }

    return result;
  }

  /// Send invoice emails
  /// Enhanced with better validation, error handling, and pricing metadata
  Future<bool> sendInvoiceEmails(
      String pdfPath, String email, String genKey) async {
    try {
      bool isLoading = true;
      String errorMessage = '';

      // Validate inputs
      if (pdfPath.isEmpty) {
        throw ArgumentError('PDF path cannot be empty');
      }
      if (email.isEmpty) {
        throw ArgumentError('Email address cannot be empty');
      }
      if (genKey.isEmpty) {
        throw ArgumentError('Generation key cannot be empty');
      }

      // Update the invoice generation state
      ref.read(invoiceGenerationStateProvider.notifier).state =
          InvoiceGenerationState.loading;

      // Get invoice details from the first invoice
      final invoiceNumber = _invoices[0]['invoiceNumber'] ?? '';
      final endDate = _invoices[0]['endDate'] ?? '';

      // Create invoice name list
      final List<String> invoiceName = [];
      for (var invoice in _invoices) {
        invoiceName.add(invoice['clientName'] ?? 'Unknown');
      }

      // Send email
      final emailResult = await _emailService.sendInvoiceEmail(
        pdfPath,
        invoiceName,
        endDate,
        invoiceNumber,
        email,
        genKey,
      );

      if (emailResult == "Success") {
        // Update state to completed
        ref.read(invoiceGenerationStateProvider.notifier).state =
            InvoiceGenerationState.completed;
        return true;
      } else {
        // Update error state
        _errorMessage = emailResult;
        ref.read(invoiceGenerationStateProvider.notifier).state =
            InvoiceGenerationState.error;
        ref.read(invoiceGenerationErrorProvider.notifier).state = _errorMessage;
        return false;
      }
    } catch (e) {
      // Handle exceptions
      final errorMsg = 'Error sending invoice email: ${e.toString()}';
      debugPrint(errorMsg);

      // Update error state
      _errorMessage = errorMsg;
      ref.read(invoiceGenerationStateProvider.notifier).state =
          InvoiceGenerationState.error;
      ref.read(invoiceGenerationErrorProvider.notifier).state = errorMsg;

      return false;
    } finally {
      _isLoading = false;
    }
  }

  /// Get assigned clients from repository
  Future<Map<String, dynamic>?> getAssignedClients() async {
    return await _repository.getAssignedClients();
  }

  /// Process selected employees and clients data
  /// Enhanced with pricing information and metadata
  /// Enhanced method to process selected employees and clients with comprehensive data fetching
  /// This method implements the complex data relationships described in the requirements:
  /// 1. Fetch client details including businessName from clients collection
  /// 2. Get employee details from login collection
  /// 3. Match clientAssignments with workedTime using shiftIndex
  /// 4. Handle break time calculations (30 min deduction if shiftBreak = "Yes")
  Future<Map<String, dynamic>> _processSelectedEmployeesAndClients(
      List<Map<String, dynamic>> selectedEmployeesAndClients) async {
    // Create a structure similar to what getAssignedClients() returns
    Map<String, dynamic> result = {
      'clients': [],
      'clientDetail': [], // Added to hold all client details
      'employeeDetails': [], // Added to hold all employee details
      'metadata': {
        'generationMethod': 'enhanced_selective',
        'timestamp': DateTime.now().toIso8601String(),
        'employeeCount': selectedEmployeesAndClients.length,
        'dataEnhancements': [
          'client_business_names',
          'employee_details_from_login',
          'worked_time_with_break_calculation',
          'schedule_to_worked_time_mapping'
        ],
      },
    };

    int totalClientCount = 0;
    int processedClientCount = 0;
    int skippedClientCount = 0;
    List<String> errors = [];

    // For each selected employee
    for (var employee in selectedEmployeesAndClients) {
      // Add null check for clients
      final selectedClients = employee['clients'] as List<dynamic>? ?? [];
      totalClientCount += selectedClients.length;
      debugPrint(
          'Processing employee with ${employee['employee']?['email']} email');

      String employeeEmail = employee['employee']?['email'] as String? ?? '';
      if (employeeEmail.isEmpty) {
        try {
          final sp = SharedPreferencesUtils();
          await sp.init();
          final spEmail = sp.getUserEmail() ??
              await sp.getUserEmailFromSharedPreferences() ??
              '';
          if (spEmail.isNotEmpty) {
            employeeEmail = spEmail;
            debugPrint(
                'Using SharedPreferences fallback for employee email: $employeeEmail');
          } else {
            debugPrint('Warning: Employee with no email found, skipping');
            continue;
          }
        } catch (_) {
          debugPrint('Warning: Employee with no email found, skipping');
          continue;
        }
      }

      debugPrint(
          'Processing employee: $employeeEmail with ${selectedClients.length} clients');

      // ENHANCEMENT 1: Get detailed employee information from login collection
      Map<String, dynamic>? employeeDetails;
      try {
        final employeeResponse = await _apiMethod.checkEmail(employeeEmail);
        if (employeeResponse != null) {
          // Handle the response structure: { statusCode: 200, message: "...", firstName: "...", lastName: "...", abn: "...", name: "..." }
          employeeDetails = employeeResponse;
          (result['employeeDetails'] as List).add(employeeDetails);
        }
        debugPrint('Employee details from login collection: $employeeDetails');
      } catch (e) {
        debugPrint(
            'Warning: Could not fetch employee details from login collection: $e');
        employeeDetails = {
          'email': employeeEmail,
          'name': employee['employee']?['name'] ?? 'Unknown Employee',
        };
        (result['employeeDetails'] as List).add(employeeDetails);
      }

      // Get user assignments for this employee once to avoid multiple API calls
      Map<String, dynamic>? assignments;
      try {
        assignments = await _apiMethod.getUserAssignments(employeeEmail);
        debugPrint('Assignments from getUserAssignments: $assignments');
        // Validate assignments structure
        if (!assignments.containsKey('assignments')) {
          String errorMsg =
              'Invalid assignments data structure for $employeeEmail';
          debugPrint(errorMsg);
          errors.add(errorMsg);
          continue;
        }

        if (assignments['success'] == false) {
          String errorMsg =
              'Failed to get assignments: ${assignments['message']}';
          debugPrint(errorMsg);
          errors.add(errorMsg);
          continue;
        }
      } catch (e) {
        String errorMsg = 'Error retrieving assignments for $employeeEmail: $e';
        debugPrint(errorMsg);
        errors.add(errorMsg);
        continue;
      }

      // For each selected client of this employee
      for (var client in selectedClients) {
        try {
          // Get client details using the client ID
          final clientId = client['id'];
          if (clientId == null) {
            skippedClientCount++;
            debugPrint('Warning: Client with no ID found, skipping');
            continue;
          }

          final clientName = client['name'] as String? ?? 'Unknown Client';
          final clientEmail = client['email'] as String? ?? '';

          debugPrint(
              'Processing client: $clientEmail for employee: $employeeEmail with ID: $clientId and name: $clientName');

          // ENHANCEMENT 2: Get detailed client information including businessName from clients collection
          Map<String, dynamic>? clientDetails;
          try {
            // Fetch client details from clients collection
            final clientResponse =
                await _apiMethod.getClientDetails(clientEmail);
            if (clientResponse != null) {
              // Handle the response structure: { statusCode: 200, message: "...", clientDetails: {...} }
              clientDetails = clientResponse['clientDetails'] ?? clientResponse;
              (result['clientDetail'] as List).add(clientDetails);
            }
            debugPrint(
                'Client details from clients collection: $clientDetails');
          } catch (e) {
            debugPrint(
                'Warning: Could not fetch client details from clients collection: $e');
            clientDetails = {
              'clientEmail': clientEmail,
              'clientFirstName': clientName.split(' ').first,
              'clientLastName': clientName.split(' ').length > 1
                  ? clientName.split(' ').last
                  : '',
              'businessName': '', // Empty if not available
            };
            (result['clientDetail'] as List).add(clientDetails);
          }

          // Find the assignment for this specific client
          Map<String, dynamic>? clientAssignment;
          final assignmentsList =
              assignments['assignments'] as List<dynamic>? ?? [];

          debugPrint('Looking for assignment for client: $clientEmail');
          debugPrint('Available assignments count: ${assignmentsList.length}');

          // Debug: Print all assignment emails for comparison
          for (int i = 0; i < assignmentsList.length; i++) {
            final assignment = assignmentsList[i];
            if (assignment is Map<String, dynamic>) {
              final assignmentClientEmail =
                  assignment['clientEmail'] as String? ?? '';
              debugPrint(
                  'Assignment $i: clientEmail = "$assignmentClientEmail"');
            }
          }

          for (var assignment in assignmentsList) {
            if (assignment is Map<String, dynamic>) {
              final assignmentClientEmail =
                  assignment['clientEmail'] as String? ?? '';
              debugPrint(
                  'Checking assignment with clientEmail: $assignmentClientEmail');

              if (assignmentClientEmail == clientEmail) {
                clientAssignment = assignment;
                debugPrint(
                    'Found matching assignment for client: $clientEmail');
                break;
              }
            }
          }

          if (clientAssignment == null) {
            debugPrint('No assignment found for client: $clientEmail');
          }

          // Add client to the result if assignment was found
          if (clientAssignment != null) {
            // Get pricing preferences for this client if available
            Map<String, dynamic> pricingPreferences = {};
            try {
              // This would be a new API method to get client pricing preferences
              // For now, we'll use default values
              pricingPreferences = {
                'preferredPricingSource':
                    'client', // 'client', 'organization', or 'standard'
                'allowPriceCapOverride': false,
                'requirePricingNotes': true,
                'defaultTaxRate': 0.0, // 0%
                'taxExempt': false,
              };
            } catch (e) {
              debugPrint('Error getting pricing preferences: $e');
              // Use defaults if error occurs
            }

            // ENHANCEMENT 3: Fetch worked time data with enhanced break calculation
            Map<String, dynamic> workedTimeData = {};
            Map<String, dynamic> enhancedWorkedTimeData = {};
            try {
              // Get organization ID from employee data or assignment
              final organizationId =
                  employee['employee']?['organizationId'] as String? ??
                      clientAssignment['organizationId'] as String? ??
                      employeeDetails?['organizationId'] as String? ??
                      '';

              if (organizationId.isNotEmpty) {
                debugPrint(
                    'Fetching worked time data for $employeeEmail and $clientEmail in organization $organizationId');
                workedTimeData = await _apiMethod.getWorkedTime(
                    employeeEmail, clientEmail, organizationId);
                debugPrint('Raw worked time data response: $workedTimeData');

                // ENHANCEMENT 4: Process worked time data with break calculations and schedule mapping
                enhancedWorkedTimeData = _processWorkedTimeWithBreaks(
                    workedTimeData,
                    clientAssignment,
                    employeeEmail,
                    clientEmail);
                debugPrint(
                    'Enhanced worked time data: $enhancedWorkedTimeData');
              } else {
                debugPrint(
                    'Warning: No organization ID found for worked time lookup');
                workedTimeData = {
                  'success': false,
                  'message': 'No organization ID available',
                  'workedTimes': []
                };
                enhancedWorkedTimeData = workedTimeData;
              }
            } catch (e) {
              debugPrint('Error fetching worked time data: $e');
              workedTimeData = {
                'success': false,
                'message': 'Error fetching worked time: $e',
                'workedTimes': []
              };
              enhancedWorkedTimeData = workedTimeData;
            }

            // Create enhanced client data structure
            final enhancedClientData = {
              'clientId': clientId,
              'clientName': clientName,
              'clientEmail': clientEmail,
              'clientDetails':
                  clientDetails, // Full client details including businessName
              'employeeDetails':
                  employeeDetails, // Full employee details from login collection
              'assignments': [clientAssignment],
              'workedTimeData':
                  enhancedWorkedTimeData, // Enhanced worked time with break calculations
              'rawWorkedTimeData':
                  workedTimeData, // Original data for debugging
              'pricingPreferences': pricingPreferences,
              'invoiceMetadata': {
                'generatedBy': employeeDetails?['name'] ??
                    employee['employee']?['name'] ??
                    employeeEmail,
                'generatedFor': _formatClientDisplayName(clientDetails),
                'generationTimestamp': DateTime.now().toIso8601String(),
                'employeeEmail': employeeEmail,
                'organizationId': clientAssignment['organizationId'],
              },
            };

            result['clients'].add(enhancedClientData);
            debugPrint(
                'Adding enhanced client to result. processedClientCount before increment: $processedClientCount');
            processedClientCount++;
            debugPrint(
                'processedClientCount after increment: $processedClientCount');
          } else {
            skippedClientCount++;
            String errorMsg =
                'No assignment found for client $clientName ($clientId)';
            debugPrint(errorMsg);
            errors.add(errorMsg);
          }
        } catch (e) {
          skippedClientCount++;
          String errorMsg = 'Error processing client: $e';
          debugPrint(errorMsg);
          errors.add(errorMsg);
        }
      }
    }

    // Update metadata with counts and errors
    final metadata = result['metadata'] as Map<String, dynamic>;
    metadata['clientCount'] = totalClientCount;
    metadata['processedClientCount'] = processedClientCount;
    metadata['skippedClientCount'] = skippedClientCount;

    if (errors.isNotEmpty) {
      metadata['errors'] = errors;
      metadata['hasErrors'] = true;
    }

    // If no clients were processed successfully, add an error message
    debugPrint(
        'Final validation: processedClientCount = $processedClientCount, totalClientCount = $totalClientCount');
    if (processedClientCount == 0) {
      if (result['clients'] is List) {
        (result['clients'] as List).clear(); // Ensure it's empty
      }
      metadata['criticalError'] =
          'No clients could be processed. Please check assignments and try again.';
    }
    debugPrint('Enhanced processing result: $result');
    return result;
  }

  /// Process worked time data with break calculations and schedule mapping
  /// This method implements the complex business logic for calculating actual worked time
  Map<String, dynamic> _processWorkedTimeWithBreaks(
    Map<String, dynamic> workedTimeData,
    Map<String, dynamic> clientAssignment,
    String employeeEmail,
    String clientEmail,
  ) {
    try {
      if (workedTimeData['success'] != true) {
        return workedTimeData; // Return as-is if not successful
      }

      final workedTimes = workedTimeData['workedTimes'] as List<dynamic>? ?? [];
      final schedule = clientAssignment['schedule'] as List<dynamic>? ?? [];

      List<Map<String, dynamic>> enhancedWorkedTimes = [];
      double totalHoursWorked = 0.0;
      double totalBreakTime = 0.0;

      debugPrint(
          'Processing ${workedTimes.length} worked time entries with ${schedule.length} schedule entries');

      for (var workedTime in workedTimes) {
        if (workedTime is! Map<String, dynamic>) continue;

        final shiftIndex = workedTime['shiftIndex'] as int? ?? -1;
        final timeWorkedRaw = workedTime['timeWorked'];
        double timeWorked = 0.0;

        // Handle different timeWorked formats (String "HH:MM:SS" or number)
        if (timeWorkedRaw is String) {
          timeWorked = _parseTimeStringToHours(timeWorkedRaw);
        } else if (timeWorkedRaw is num) {
          timeWorked = timeWorkedRaw.toDouble();
        }

        final shiftBreak =
            workedTime['shiftBreak']?.toString().toLowerCase() ?? 'no';

        // Calculate break time (30 minutes if shiftBreak is "yes")
        double breakTime = 0.0;
        if (shiftBreak == 'yes' || shiftBreak == 'true') {
          breakTime = 0.5; // 30 minutes = 0.5 hours
          totalBreakTime += breakTime;
        }

        // Get corresponding schedule entry if shiftIndex is valid
        Map<String, dynamic>? correspondingSchedule;
        if (shiftIndex >= 0 && shiftIndex < schedule.length) {
          correspondingSchedule = schedule[shiftIndex] as Map<String, dynamic>?;
        }

        // Calculate actual worked time (subtract break if applicable)
        double actualWorkedTime = timeWorked;
        if (breakTime > 0) {
          actualWorkedTime = timeWorked - breakTime;
        }

        // Fallback: if actualWorkedTime is zero or negative, compute from schedule start/end
        if ((actualWorkedTime <= 0.0) && correspondingSchedule != null) {
          final startStr = correspondingSchedule['startTime']?.toString() ?? '';
          final endStr = correspondingSchedule['endTime']?.toString() ?? '';

          double scheduledHours = 0.0;
          try {
            scheduledHours = _helpers.hoursBetweenPerListItem(startStr, endStr);
          } catch (e) {
            debugPrint('Fallback hoursBetweenPerListItem failed: $e');
          }

          // Use schedule-provided breakMinutes if available; otherwise retain breakTime
          double scheduleBreakHours = breakTime;
          final breakVal = correspondingSchedule['breakMinutes'];
          if (breakVal != null) {
            try {
              scheduleBreakHours = _parseBreakMinutesToHours(breakVal);
            } catch (e) {
              debugPrint('Failed to parse schedule breakMinutes "$breakVal": $e');
            }
          }

          actualWorkedTime = scheduledHours - scheduleBreakHours;
          if (actualWorkedTime < 0) actualWorkedTime = 0.0; // Ensure non-negative
        } else if (actualWorkedTime < 0) {
          actualWorkedTime = 0.0; // Ensure non-negative
        }

        totalHoursWorked += actualWorkedTime;

        // Create enhanced worked time entry
        final enhancedEntry = Map<String, dynamic>.from(workedTime);
        enhancedEntry.addAll({
          'actualWorkedTime': actualWorkedTime,
          'breakTime': breakTime,
          'hasBreak': breakTime > 0,
          'correspondingSchedule': correspondingSchedule,
          'scheduleMatched': correspondingSchedule != null,
        });

        enhancedWorkedTimes.add(enhancedEntry);

        debugPrint(
            'Processed worked time entry: shiftIndex=$shiftIndex, timeWorked=$timeWorked, breakTime=$breakTime, actualWorkedTime=$actualWorkedTime');
      }

      // Create enhanced response
      final enhancedResponse = Map<String, dynamic>.from(workedTimeData);
      enhancedResponse['workedTimes'] = enhancedWorkedTimes;
      enhancedResponse['summary'] = {
        'totalEntries': enhancedWorkedTimes.length,
        'totalHoursWorked': totalHoursWorked,
        'totalBreakTime': totalBreakTime,
        'totalScheduledEntries': schedule.length,
        'entriesWithBreaks':
            enhancedWorkedTimes.where((e) => e['hasBreak'] == true).length,
        'entriesWithScheduleMatch': enhancedWorkedTimes
            .where((e) => e['scheduleMatched'] == true)
            .length,
      };

      debugPrint(
          'Enhanced worked time summary: ${enhancedResponse['summary']}');
      return enhancedResponse;
    } catch (e) {
      debugPrint('Error processing worked time with breaks: $e');
      return {
        'success': false,
        'message': 'Error processing worked time data: $e',
        'workedTimes': [],
        'originalData': workedTimeData,
      };
    }
  }

  /// Format client display name with business name if available
  /// Format: "Client Name (Business Name)" or just "Client Name" if no business
  String _formatClientDisplayName(Map<String, dynamic>? clientDetails) {
    if (clientDetails == null) return 'Unknown Client';

    final firstName = clientDetails['clientFirstName']?.toString() ?? '';
    final lastName = clientDetails['clientLastName']?.toString() ?? '';
    final businessName = clientDetails['businessName']?.toString() ?? '';

    String clientName = '$firstName $lastName'.trim();
    if (clientName.isEmpty) {
      clientName = 'Unknown Client';
    }

    // Add business name in parentheses if available and not empty
    if (businessName.isNotEmpty) {
      return '$clientName ($businessName)';
    }

    return clientName;
  }

  /// Parse time string (HH:MM:SS or HH:MM) to decimal hours
  double _parseTimeStringToHours(String timeString) {
    try {
      if (timeString.isEmpty) return 0.0;

      final parts = timeString.split(':');
      if (parts.length >= 2) {
        final hours = int.tryParse(parts[0]) ?? 0;
        final minutes = int.tryParse(parts[1]) ?? 0;
        final seconds = parts.length >= 3 ? (int.tryParse(parts[2]) ?? 0) : 0;

        return hours + (minutes / 60.0) + (seconds / 3600.0);
      }

      // Try to parse as a simple number
      return double.tryParse(timeString) ?? 0.0;
    } catch (e) {
      debugPrint('Error parsing time string "$timeString": $e');
      return 0.0;
    }
  }

  /// Convert a break value to decimal hours.
  ///
  /// Accepts a variety of formats commonly seen in schedules:
  /// - Numeric minutes (e.g., `30`, `15`) -> treated as minutes
  /// - Hour decimals (e.g., `0.5`, `1`) -> treated as hours
  /// - Clock format strings (e.g., `00:30`, `1:15`) -> `H:MM`
  /// - Unit suffixes (e.g., `30m`, `1h`, `45 min`, `0.5 hr`)
  /// - Non-numeric strings (e.g., `no`, `none`, `n/a`) -> 0.0 hours
  ///
  /// Returns decimal hours for consistency with amount calculations.
  double _parseBreakMinutesToHours(dynamic breakValue) {
    try {
      if (breakValue == null) return 0.0;

      // Direct numeric inputs
      if (breakValue is num) {
        final v = breakValue.toDouble();
        // Heuristic: values >= 10 likely represent minutes
        return v >= 10 ? (v / 60.0) : v; // if 0.5 -> hours, if 30 -> minutes
      }

      // String inputs
      final raw = breakValue.toString().trim().toLowerCase();
      if (raw.isEmpty) return 0.0;

      // Non-break indicators
      const noneSet = {'no', 'none', 'n/a', 'na', 'false', '0'};
      if (noneSet.contains(raw)) return 0.0;

      // Clock format 'H:MM' or 'HH:MM' (optionally ':SS')
      if (raw.contains(':')) {
        final parts = raw.split(':');
        final h = int.tryParse(parts[0]) ?? 0;
        final m = int.tryParse(parts.length > 1 ? parts[1].replaceAll(RegExp(r'[^0-9]'), '') : '0') ?? 0;
        return h + (m / 60.0);
      }

      // Unit suffixes
      if (raw.endsWith('h')) {
        final numPart = double.tryParse(raw.replaceAll('h', ''));
        return numPart ?? 0.0;
      }
      if (raw.endsWith('m')) {
        final numPart = double.tryParse(raw.replaceAll('m', ''));
        return numPart != null ? (numPart / 60.0) : 0.0;
      }
      if (raw.endsWith('min')) {
        final numPart = double.tryParse(raw.replaceAll('min', ''));
        return numPart != null ? (numPart / 60.0) : 0.0;
      }
      if (raw.endsWith('hr')) {
        final numPart = double.tryParse(raw.replaceAll('hr', ''));
        return numPart ?? 0.0;
      }

      // Plain numeric string: decide minutes vs hours using heuristic
      final plain = double.tryParse(raw);
      if (plain != null) {
        return plain >= 10 ? (plain / 60.0) : plain;
      }

      // Fallback: strip non-numeric except dot and parse
      final cleaned = raw.replaceAll(RegExp(r'[^0-9\.]'), '');
      final fallbackNum = double.tryParse(cleaned) ?? 0.0;
      return fallbackNum >= 10 ? (fallbackNum / 60.0) : fallbackNum;
    } catch (e) {
      debugPrint('Error parsing break value "$breakValue": $e');
      return 0.0;
    }
  }

  /// Get line items from repository
  Future<List<Map<String, dynamic>>> getLineItems(
      {bool includeExpenses = false}) async {
    return await _repository.getLineItems(includeExpenses: includeExpenses);
  }

  /// Save generated invoices to backend database and regenerate PDFs with correct invoice numbers
  Future<List<String>?> _saveInvoicesToBackend(
    Map<String, dynamic> processedData,
    List<String> pdfPaths,
    String? organizationId,
  ) async {
    try {
      if (organizationId == null || organizationId.isEmpty) {
        debugPrint('Cannot save invoices: organizationId is null or empty');
        return null;
      }

      final invoices = _invoices;
      if (invoices.isEmpty) {
        debugPrint('No invoices to save');
        return null;
      }

      for (int i = 0; i < invoices.length; i++) {
        final invoice = invoices[i];
        final pdfPath = i < pdfPaths.length ? pdfPaths[i] : null;

        // Extract provider details from employee data
        final employeeDetails =
            invoice['employeeDetails'] as Map<String, dynamic>? ?? {};
        final providerName = employeeDetails['name'] ??
            employeeDetails['firstName'] ??
            'Provider Name';
        final providerABN =
            employeeDetails['abn'] ?? employeeDetails['providerABN'] ?? 'N/A';
        String employeeEmailForSave = (employeeDetails['email'] ??
                invoice['employeeEmail'] ??
                (processedData['metadata']?['employeeEmail'] ?? ''))
            .toString();
        if (employeeEmailForSave.isEmpty) {
          try {
            final sp = SharedPreferencesUtils();
            await sp.init();
            final spEmail = sp.getUserEmail() ??
                await sp.getUserEmailFromSharedPreferences() ??
                '';
            if (spEmail.isNotEmpty) {
              employeeEmailForSave = spEmail;
            }
          } catch (_) {}
        }

        // Extract client details for proper name formatting
        final clientDetails =
            invoice['clientDetails'] as Map<String, dynamic>? ?? {};
        final clientNameStr = invoice['clientName']?.toString() ?? '';
        final nameParts = clientNameStr.split(' ');
        final clientFirstName = clientDetails['clientFirstName'] ??
            (nameParts.isNotEmpty ? nameParts.first : '');
        final clientLastName = clientDetails['clientLastName'] ??
            (nameParts.length > 1 ? nameParts.last : '');
        final clientAddress = clientDetails['clientAddress'] ?? '';
        final clientCity = clientDetails['clientCity'] ?? '';
        final clientState = clientDetails['clientState'] ?? '';
        final clientZip = clientDetails['clientZip'] ?? '';
        final clientPhone = clientDetails['clientPhone'] ?? '';
        final businessName =
            clientDetails['businessName'] ?? invoice['businessName'] ?? '';

        // Generate unique invoice number (always generate new format)
        String invoiceNumber = invoice['invoiceNumber'] ?? '';
        // Force regeneration to use new ultra-compact format
        if (invoiceNumber.isEmpty ||
            invoiceNumber.contains('-') ||
            invoiceNumber.length > 12) {
          try {
            // Get organization details for invoice number generation
            final sp = SharedPreferencesUtils();
            await sp.init();
            final orgId = sp.getOrganizationId() ?? organizationId ?? 'DEFAULT';
            // Get organization code from SharedPreferences (saved during login)
            final organizationCode = sp.getOrganizationCode() ?? 'ORG';

            // Generate unique invoice number
            invoiceNumber =
                await InvoiceNumberGeneratorService.generateInvoiceNumber(
              organizationId: organizationId,
              organizationCode: organizationCode,
              clientId: invoice['clientId'] ?? '',
              clientName: invoice['clientName'] ?? '',
              employeeId:
                  employeeDetails['id'] ?? employeeDetails['employeeId'] ?? '',
              employeeName: providerName,
              issueDate: DateTime.now(),
            );
            debugPrint("invoice number here: $invoiceNumber");
            // Update the invoice with the generated number
            invoice['invoiceNumber'] = invoiceNumber;
            _invoices[i]['invoiceNumber'] = invoiceNumber;

            debugPrint(
                'Generated invoice number: $invoiceNumber for client: ${invoice['clientName']}');
          } catch (e) {
            debugPrint('Error generating invoice number: $e');
            // Fallback to timestamp-based number
            final timestamp = DateTime.now().millisecondsSinceEpoch;
            invoiceNumber = 'INV-$timestamp';
            invoice['invoiceNumber'] = invoiceNumber;
            _invoices[i]['invoiceNumber'] = invoiceNumber;
          }
        }

        // Extract period dates from the original invoice data
        final startDate = invoice['startDate'] ?? '';
        final endDate = invoice['endDate'] ?? '';

        // Derive persisted tax flags and rate from mutated invoice data, with processedData as fallback
        final bool persistedShowTax = ((invoice['applyTax'] ??
                    invoice['showTax'] ??
                    invoice['includesTax'] ??
                    processedData['applyTax'] ??
                    (processedData['metadata']?['includesTax'])) ??
                false) ==
            true;
        final dynamic taxRateSource = invoice['taxRate'] ??
            processedData['taxRate'] ??
            (processedData['metadata']?['taxRate']);
        double persistedTaxRate = 0.0;
        if (taxRateSource is num) {
          persistedTaxRate = taxRateSource.toDouble();
        } else if (taxRateSource is String) {
          persistedTaxRate = double.tryParse(taxRateSource) ?? 0.0;
        }

        // Prepare complete calculated payload data for PDF regeneration
        final calculatedPayloadData = {
          'clients': [
            {
              'clientId': invoice['clientId'] ?? '',
              'clientEmail': invoice['clientEmail'] ?? '',
              'clientName': invoice['clientName'] ?? '',
              'clientFirstName': clientFirstName,
              'clientLastName': clientLastName,
              'clientAddress': clientAddress,
              'clientCity': clientCity,
              'clientState': clientState,
              'clientZip': clientZip,
              'clientPhone': clientPhone,
              'businessName': businessName,
              'employeeName': providerName,
              'providerABN': providerABN,
              'employeeEmail': employeeEmailForSave,
              'startDate': startDate,
              'endDate': endDate,
              // invoiceNumber removed to prevent duplicates; invoiceData.invoiceNumber is authoritative
              'items': invoice['items'] ?? [],
              'expenses': invoice['expenses'] ?? [],
              'itemsSubtotal': invoice['itemsSubtotal'] ?? 0.0,
              'expensesTotal': invoice['expensesTotal'] ?? 0.0,
              'subtotal': invoice['subtotal'] ?? 0.0,
              'taxAmount': invoice['taxAmount'] ?? 0.0,
              'total': invoice['total'] ?? 0.0,
              // Persist tax settings for reliable regeneration
              'applyTax': persistedShowTax,
              'showTax': persistedShowTax,
              'includesTax': persistedShowTax,
              'taxRate': persistedTaxRate,
              'employeeDetails': employeeDetails,
              'clientDetails': clientDetails,
            }
          ],
          // invoiceNumber removed from calculatedPayloadData root to prevent duplicates; invoiceData.invoiceNumber is authoritative
          'metadata': processedData['metadata'] ?? {},
        };

        for (int i = 0; i < _invoices.length; i++) {
          debugPrint("OOr $i ${_invoices[i]['invoiceNumber']}");
        }

        // Prepare complete invoice data for backend including all calculated payload data
        final invoiceData = {
          'organizationId': organizationId,
          'invoiceNumber': _invoices[i]
              ['invoiceNumber'] ?? 'INV-${DateTime.now().millisecondsSinceEpoch}', // Include the generated invoice number with fallback
          'clientId': invoice['clientId'] ?? '',
          'clientEmail': invoice['clientEmail'] ?? '',
          'clientName': invoice['clientName'] ?? '',
          'businessName': businessName,
          'jobTitle': invoice['jobTitle'] ?? 'Personal Care Assistance', // Ensure job title is always set

          // Add provider details for PDF generation
          'employeeName': providerName,
          'providerABN': providerABN,
          'employeeEmail': employeeEmailForSave,

          // Add complete client details for PDF generation
          'clientFirstName': clientFirstName,
          'clientLastName': clientLastName,
          'clientAddress': clientAddress,
          'clientCity': clientCity,
          'clientState': clientState,
          'clientZip': clientZip,
          'clientPhone': clientPhone,

          // Save complete line items with all calculated data
          'lineItems': invoice['items'] ?? [],

          // Save expenses data if available
          'expenses': invoice['expenses'] ?? [],

          // Save complete financial summary
          'financialSummary': {
            'itemsSubtotal': invoice['itemsSubtotal'] ?? 0.0,
            'expensesTotal': invoice['expensesTotal'] ?? 0.0,
            'subtotal': invoice['subtotal'] ?? 0.0,
            'taxAmount': invoice['taxAmount'] ?? 0.0,
            'totalAmount': invoice['total'] ?? 0.0,
            'currency': 'AUD',
            'paymentTerms': 30,
          },

          // Save complete calculated payload data for PDF regeneration
          'calculatedPayloadData': calculatedPayloadData,

          // Save PDF generation parameters
          'pdfGenerationParams': {
            'showTax': persistedShowTax,
            'taxRate': persistedTaxRate,
            'includeExpenses': processedData['includeExpenses'] ?? false,
            'attachedPhotos': processedData['attachedPhotos'] ?? [],
            'photoDescription': processedData['photoDescription'] ?? '',
            'uploadedPhotoUrls': processedData['uploadedPhotoUrls'] ?? [],
            'uploadedAdditionalFileUrls':
                processedData['uploadedAdditionalFileUrls'] ?? [],
          },

          'pdfPath': pdfPath,
          'generatedAt': DateTime.now().toIso8601String(),

          'metadata': {
            'generationMethod': 'enhanced_service',
            'includesTax': persistedShowTax,
            'taxRate': persistedTaxRate,
            'includesExpenses': processedData['includeExpenses'] ?? false,
            'hasAttachments':
                (processedData['attachedPhotos'] as List?)?.isNotEmpty ?? false,
            'validationSummary': processedData['metadata']
                ?['validationSummary'],
            'uploadedPhotoUrls': processedData['uploadedPhotoUrls'],
            'uploadedAdditionalFileUrls':
                processedData['uploadedAdditionalFileUrls'],
            'employeeEmail': employeeEmailForSave,
          },
        };

        // Call backend API to save invoice
        debugPrint(
            'Saving invoice for client: ${invoice['clientName']} to /api/invoices' '\n\n' ' $invoiceData');
        final response =
            await _apiMethod.post('/api/invoices', body: invoiceData);

        debugPrint('Save invoice response: $response');

        if (response['success'] == true) {
          debugPrint(
              'Invoice saved successfully for client: ${invoice['clientName']}');

          // Skip backend invoice number override to preserve ultra-compact format
          if (response['data'] != null &&
              response['data']['invoiceNumber'] != null) {
            final backendInvoiceNumber = response['data']['invoiceNumber'];
            debugPrint(
                'Backend generated invoice number: $backendInvoiceNumber (skipped to preserve ultra-compact format)');

            // Keep using locally generated ultra-compact invoice number
            // Do not override with backend number to maintain ORGYMNNCC format
            debugPrint(
                'Using local ultra-compact invoice number: ${invoice['invoiceNumber']}');
          }
        } else {
          final errorMessage =
              response['message'] ?? response['error'] ?? 'Unknown error';
          debugPrint(
              'Failed to save invoice for client: ${invoice['clientName']}, error: $errorMessage');
          debugPrint('Full response: $response');
        }
      }
    } catch (e) {
      debugPrint('Error saving invoices to backend: $e');
      // Don't throw error as this is non-critical for PDF generation
      return null;
    }

    // Regenerate PDFs with correct backend invoice numbers
    try {
      debugPrint(
          'Regenerating PDFs with backend invoice numbers... $processedData');
      // Resolve tax rate safely with robust fallbacks to avoid null → double errors
      double resolvedTaxRate = _safeDouble(
        processedData['taxRate'] ?? processedData['metadata']?['taxRate'],
        defaultValue: 0.0,
      );

      // If still zero, try deriving from first client's totals (tax/subtotal)
      if (resolvedTaxRate == 0.0) {
        try {
          final List<dynamic> clientsRoot =
              processedData['clients'] as List<dynamic>? ?? [];
          Map<String, dynamic>? firstClient;
          if (clientsRoot.isNotEmpty && clientsRoot.first is Map) {
            firstClient = clientsRoot.first as Map<String, dynamic>;
          } else {
            final List<dynamic> altClients =
                processedData['calculatedPayloadData']?['clients']
                        as List<dynamic>? ??
                    [];
            if (altClients.isNotEmpty && altClients.first is Map) {
              firstClient = altClients.first as Map<String, dynamic>;
            }
          }
          if (firstClient != null) {
            final double subtotal =
                _safeDouble(firstClient['subtotal'], defaultValue: 0.0);
            final double taxAmount = _safeDouble(
                firstClient['tax'] ?? firstClient['taxAmount'],
                defaultValue: 0.0);
            if (subtotal > 0 && taxAmount > 0) {
              resolvedTaxRate = taxAmount / subtotal;
            }
          }
        } catch (_) {}
      }

      // Respect processedData's tax display preference when regenerating PDFs
      final bool showTaxFlag = ((processedData['applyTax'] ??
              processedData['metadata']?['includesTax'] ??
              processedData['pdfGenerationParams']?['showTax'] ??
              true) ==
          true);

      final updatedPdfPaths = await _pdfGenerator.generatePdfs(
        processedData,
        showTax: showTaxFlag,
        taxRate: resolvedTaxRate,
      );
      debugPrint(
          'Successfully regenerated ${updatedPdfPaths.length} PDFs with backend invoice numbers');
      return updatedPdfPaths;
    } catch (e) {
      debugPrint('Error regenerating PDFs with backend invoice numbers: $e');
      return null;
    }
  }
}

// Note: Providers for this service are defined in lib/app/core/providers/invoice_providers.dart
