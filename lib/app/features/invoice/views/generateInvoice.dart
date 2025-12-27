import 'package:carenest/app/features/invoice/domain/models/invoice_line_item.dart';
import 'dart:io';
import 'package:carenest/app/features/invoice/domain/models/ndis_item.dart';
import 'package:carenest/app/features/invoice/models/ndis_matcher.dart';
import 'package:carenest/app/shared/utils/logging.dart';
import 'package:carenest/app/shared/utils/pdf/pdf_viewer_io.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/invoice_providers.dart';
import 'package:carenest/app/features/invoice/services/enhanced_invoice_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carenest/app/features/invoice/presentation/widgets/dynamic_line_item_entry.dart';
import 'package:carenest/app/shared/design_system/modern_pricing_design_system.dart';

class GenerateInvoice extends ConsumerStatefulWidget {
  final String adminEmail;
  final String organizationId;

  const GenerateInvoice({
    super.key,
    required this.adminEmail,
    required this.organizationId,
  });

  @override
  ConsumerState<GenerateInvoice> createState() => _GenerateInvoiceState();
}

class _GenerateInvoiceState extends ConsumerState<GenerateInvoice> {
  bool _isLoading = true;
  String _statusMessage = 'Loading...';
  List<InvoiceLineItem> _lineItems = [];
  String? _selectedEmployeeEmail;
  String? _selectedClientEmail;
  String? _selectedClientId;
  List<Map<String, dynamic>> _clientAssignments = [];

  String _providerName = '';
  String _providerABN = '';
  String _clientName = '';
  String _startDate = '';
  String _endDate = '';
  String _pdfPath = '';
  final double _taxRate = 0.0;

  final ApiMethod _apiMethod = ApiMethod();
  final NDISMatcher _ndisMatcher = NDISMatcher();
  late final EnhancedInvoiceService _invoiceService;
  List<String> _apiHolidays = [];
  // ignore: unused_field
  final PriceRegion _currentRegionForInvoice =
      PriceRegion.nsw; // Default, this should be configurable

  static const double _kDefaultBaseRate = 30.00;

  @override
  void initState() {
    super.initState();
    // Initialize the invoice service using the provider
    _invoiceService = ref.read(enhancedInvoiceServiceProvider);
    _initializeInvoiceGeneration();
  }

  Future<void> _initializeInvoiceGeneration() async {
    if (!mounted) return;
    log.info("GenerateInvoice: Initializing...");
    setState(() {
      _isLoading = true;
      _statusMessage = 'Loading NDIS items...';
    });
    try {
      await _ndisMatcher.loadItems(); // This now uses the logger internally
      log.info("GenerateInvoice: NDIS items loaded. Starting admin flow.");
      await _startAdminInvoiceFlow();
    } catch (e, s) {
      log.severe("GenerateInvoice: Initialization Error", e, s);
      if (mounted) {
        setState(() {
          _statusMessage = 'Initialization Error. Please try again.';
          _isLoading = false;
        });
        _showErrorSnackBar('Initialization failed: ${e.toString()}');
      }
    }
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: ModernPricingDesign.errorColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ModernPricingDesign.radiusMd)),
        margin: const EdgeInsets.all(ModernPricingDesign.spacingMd),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  Future<void> _startAdminInvoiceFlow() async {
    if (!mounted) return;
    log.info("GenerateInvoice: Starting admin invoice flow...");
    setState(() {
      _isLoading = true;
      _statusMessage = 'Fetching employees...';
    });

    try {
      final employeesResp =
          await _apiMethod.getOrganizationEmployees(widget.organizationId);
      if (!mounted) return;

      if (employeesResp['success'] != true) {
        log.warning(
            "Failed to fetch employees for org ${widget.organizationId}: ${employeesResp['message'] ?? 'Unknown API error'}");
        setState(() => _statusMessage =
            "Error fetching employees: ${employeesResp['message'] ?? 'Please try again.'}");
        _isLoading = false;
        return;
      }
      if ((employeesResp['employees'] as List).isEmpty) {
        log.info(
            "No employees found for organization ${widget.organizationId}");
        setState(
            () => _statusMessage = 'No employees found in your organization.');
        _isLoading = false;
        return;
      }
      final List<Map<String, dynamic>> employees =
          List.from(employeesResp['employees']);
      log.fine("Fetched ${employees.length} employees.");

      final selectedEmployee = await showDialog<Map<String, dynamic>>(
        context: context,
        barrierDismissible: false,
        builder: (context) => _buildEmployeeSelectionDialog(employees),
      );
      if (!mounted || selectedEmployee == null) {
        log.info("Employee selection cancelled by user.");
        setState(() => _statusMessage = 'Invoice generation cancelled.');
        _isLoading = false;
        return;
      }
      _selectedEmployeeEmail = selectedEmployee['email'];
      _providerName =
          '${selectedEmployee['firstName']} ${selectedEmployee['lastName']}';
      _providerABN = selectedEmployee['abn'] ?? 'N/A';
      log.info("Selected Employee: $_providerName ($_selectedEmployeeEmail)");

      if (!mounted) return;
      setState(
          () => _statusMessage = 'Fetching assignments for $_providerName...');

      final assignmentsResp =
          await _apiMethod.getUserAssignments(_selectedEmployeeEmail!);
      if (!mounted) return;
      if (assignmentsResp['success'] != true) {
        log.warning(
            "Failed to fetch assignments for $_selectedEmployeeEmail: ${assignmentsResp['message'] ?? 'Unknown API error'}");
        setState(() => _statusMessage =
            "Error fetching client assignments: ${assignmentsResp['message'] ?? 'Please try again.'}");
        _isLoading = false;
        return;
      }
      if ((assignmentsResp['assignments'] as List).isEmpty) {
        log.info("No clients assigned to employee $_selectedEmployeeEmail");
        setState(
            () => _statusMessage = 'No clients are assigned to this employee.');
        _isLoading = false;
        return;
      }
      _clientAssignments = List.from(assignmentsResp['assignments']);
      log.fine(
          "Fetched ${_clientAssignments.length} client assignments for $_selectedEmployeeEmail.");

      final selectedClient = await showDialog<Map<String, dynamic>>(
        context: context,
        barrierDismissible: false,
        builder: (context) => _buildClientSelectionDialog(_clientAssignments),
      );
      if (!mounted || selectedClient == null) {
        log.info("Client selection cancelled by user.");
        setState(() => _statusMessage = 'Invoice generation cancelled.');
        _isLoading = false;
        return;
      }
      _selectedClientEmail = selectedClient['clientEmail'];
      final clientDetails =
          (selectedClient['clientDetails'] is Map<String, dynamic>)
              ? selectedClient['clientDetails'] as Map<String, dynamic>
              : <String, dynamic>{};
      _clientName =
          '${clientDetails['clientFirstName'] ?? 'N/A'} ${clientDetails['clientLastName'] ?? 'N/A'}';

      // Extract the client ID from clientDetails for pricing lookup
      _selectedClientId = clientDetails['_id'];
      log.info(
          "Selected Client: $_clientName ($_selectedClientEmail), ID: $_selectedClientId");

      await _generateDataForPair(
          _selectedEmployeeEmail!, _selectedClientEmail!, selectedClient);
    } catch (e, s) {
      log.severe("Error in _startAdminInvoiceFlow", e, s);
      if (mounted) {
        _statusMessage = 'An error occurred during invoice setup.';
        _showErrorSnackBar('Operation failed: ${e.toString()}');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Widget _buildEmployeeSelectionDialog(List<Map<String, dynamic>> employees) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ModernGradientCard(
        gradientColors: const [Colors.white, Colors.white],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Employee', style: ModernPricingDesign.headingMd),
            const SizedBox(height: ModernPricingDesign.spacingMd),
            SizedBox(
              height: 300,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: employees.length,
                separatorBuilder: (_, __) => const Divider(
                    height: 1, color: ModernPricingDesign.borderColor),
                itemBuilder: (context, index) {
                  final employee = employees[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                        '${employee['firstName']} ${employee['lastName']}',
                        style: ModernPricingDesign.bodyMd
                            .copyWith(fontWeight: FontWeight.w600)),
                    subtitle: Text(employee['email'] ?? 'No email',
                        style: ModernPricingDesign.bodySm.copyWith(
                            color: ModernPricingDesign.textSecondary)),
                    onTap: () => Navigator.of(context).pop(employee),
                  );
                },
              ),
            ),
            const SizedBox(height: ModernPricingDesign.spacingMd),
            Align(
              alignment: Alignment.centerRight,
              child: ModernActionButton(
                text: 'Cancel',
                variant: ModernActionButtonVariant.ghost,
                onPressed: () => Navigator.of(context).pop(null),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClientSelectionDialog(List<Map<String, dynamic>> assignments) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ModernGradientCard(
        gradientColors: const [Colors.white, Colors.white],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Client', style: ModernPricingDesign.headingMd),
            const SizedBox(height: ModernPricingDesign.spacingMd),
            SizedBox(
              height: 300,
              child: assignments.isEmpty
                  ? Center(
                      child: Text(
                          "No clients found assigned to the selected employee.",
                          textAlign: TextAlign.center,
                          style: ModernPricingDesign.bodyMd.copyWith(
                              color: ModernPricingDesign.textSecondary)),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      itemCount: assignments.length,
                      separatorBuilder: (_, __) => const Divider(
                          height: 1, color: ModernPricingDesign.borderColor),
                      itemBuilder: (context, index) {
                        final assignment = assignments[index];
                        final details = (assignment['clientDetails']
                                is Map<String, dynamic>)
                            ? assignment['clientDetails']
                                as Map<String, dynamic>
                            : <String, dynamic>{};
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                              '${details['clientFirstName'] ?? 'N/A'} ${details['clientLastName'] ?? 'N/A'}',
                              style: ModernPricingDesign.bodyMd
                                  .copyWith(fontWeight: FontWeight.w600)),
                          subtitle: Text(
                              details['clientEmail'] ?? 'No email provided',
                              style: ModernPricingDesign.bodySm.copyWith(
                                  color: ModernPricingDesign.textSecondary)),
                          onTap: () => Navigator.of(context).pop(assignment),
                        );
                      },
                    ),
            ),
            const SizedBox(height: ModernPricingDesign.spacingMd),
            Align(
              alignment: Alignment.centerRight,
              child: ModernActionButton(
                text: 'Cancel',
                variant: ModernActionButtonVariant.ghost,
                onPressed: () => Navigator.of(context).pop(null),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _generateDataForPair(String employeeEmail, String clientEmail,
      Map<String, dynamic> selectedClient) async {
    if (!mounted) return;
    log.info(
        "--- Starting _generateDataForPair for Employee: $employeeEmail, Client: $clientEmail ---");
    setState(() {
      _isLoading = true; // Set loading true for this specific operation
      _statusMessage = 'Analyzing worked time...';
    });

    try {
      final workedTimeResp = await _apiMethod.getWorkedTime(
          employeeEmail, clientEmail, widget.organizationId);
      if (!mounted) return;

      if (workedTimeResp['success'] != true) {
        log.warning(
            "Worked time fetch failed or no records for $employeeEmail / $clientEmail: ${workedTimeResp['message']}");
        setState(() => _statusMessage = workedTimeResp['message'] ??
            'No worked time records for this selection.');
        _isLoading = false;
        return;
      }

      final List<dynamic> workedTimes = workedTimeResp['workedTimes'] ?? [];
      if (workedTimes.isEmpty) {
        log.info(
            "Empty workedTimes list for $employeeEmail / $clientEmail. No line items to generate.");
        setState(() => _statusMessage =
            'No worked time records found for this client/employee combination.');
        _isLoading = false;
        return;
      }
      log.fine("Fetched ${workedTimes.length} worked time records.");

      final allDatesForHolidayCheck = workedTimes
          .map((r) => r['shiftDate']?.toString())
          .whereType<String>()
          .toSet()
          .toList();

      if (allDatesForHolidayCheck.isNotEmpty) {
        try {
          _apiHolidays =
              await _apiMethod.checkHolidaysSingle(allDatesForHolidayCheck);
          log.fine(
              "Fetched API Holidays: $_apiHolidays for dates: $allDatesForHolidayCheck");
        } catch (e, s) {
          log.warning(
              "Error fetching holidays: $e. Using empty holiday list.", e, s);
          _apiHolidays = [];
          if (mounted) {
            _showErrorSnackBar(
                'Could not fetch holiday data. Proceeding without it.');
          }
        }
      } else {
        _apiHolidays = [];
        log.info("No dates for holiday check. API Holidays set to empty.");
      }

      if (!mounted) return;
      setState(() => _statusMessage = 'Generating invoice lines...');
      log.info("Status: Generating invoice lines...");

      final workedDates = workedTimes
          .map((r) =>
              r['shiftDate'] != null ? DateTime.tryParse(r['shiftDate']) : null)
          .whereType<DateTime>()
          .toList();

      if (workedDates.isEmpty) {
        log.warning("No valid dates found in worked time records.");
        if (mounted) {
          setState(() =>
              _statusMessage = 'No valid dates found in worked time records.');
          _isLoading = false;
        }
        return;
      }
      workedDates.sort();
      _startDate = DateFormat('yyyy-MM-dd').format(workedDates.first);
      _endDate = DateFormat('yyyy-MM-dd').format(workedDates.last);
      log.fine("Invoice period: $_startDate to $_endDate");

      // Pre-process to collect all NDIS item numbers for bulk pricing lookup
      Set<String> ndisItemNumbers = {};
      for (final record in workedTimes) {
        final dateStr = record['shiftDate']?.toString();
        final startTimeStr = record['shiftStartTime']?.toString().trim() ?? '';
        final timeWorkedStr = record['timeWorked']?.toString().trim() ?? '';

        if (dateStr == null || startTimeStr.isEmpty || timeWorkedStr.isEmpty) {
          continue;
        }

        final double hours = _hoursFromTimeString(timeWorkedStr);
        if (hours <= 0) {
          continue;
        }

        DateTime parsedShiftStart;
        try {
          final datePart = DateTime.parse(dateStr);
          final timePart = DateFormat.jm().parseLoose(startTimeStr);
          parsedShiftStart = DateTime(datePart.year, datePart.month,
              datePart.day, timePart.hour, timePart.minute);
        } catch (e) {
          continue;
        }

        NDISItem? matchedNdisItem;
        final String? assignedNdisItemNumber =
            selectedClient['assignedNdisItemNumber'];

        if (assignedNdisItemNumber != null &&
            assignedNdisItemNumber.isNotEmpty) {
          matchedNdisItem =
              _ndisMatcher.getItemByNumber(assignedNdisItemNumber);
        }

        matchedNdisItem ??= _ndisMatcher.findBestMatch(
          shiftStart: parsedShiftStart,
          dynamicHolidays: _apiHolidays,
          preferredSupportCategoryNumber: null,
          preferredRegistrationGroupNumber: null,
          isHighIntensityShift: false,
          preferTTP: false,
        );

        if (matchedNdisItem != null) {
          ndisItemNumbers.add(matchedNdisItem.itemNumber);
        }
      }

      // Perform bulk pricing lookup
      log.info("Collected NDIS item numbers for bulk lookup: $ndisItemNumbers");
      Map<String, dynamic>? bulkPricingData = {};
      if (ndisItemNumbers.isNotEmpty) {
        setState(() => _statusMessage = 'Fetching pricing data...');
        log.info(
            "Performing bulk pricing lookup for ${ndisItemNumbers.length} unique NDIS items");

        try {
          log.info(
              "DEBUG: Calling getBulkPricingLookup with organizationId: ${widget.organizationId}");
          log.info("DEBUG: NDIS items: ${ndisItemNumbers.toList()}");
          log.info("DEBUG: Client ID: $_selectedClientId");

          bulkPricingData = await _apiMethod.getBulkPricingLookup(
            widget.organizationId,
            ndisItemNumbers.toList(),
            clientId: _selectedClientId,
          );
          log.info("Bulk pricing lookup completed successfully");
          log.info("Bulk pricing data received: $bulkPricingData");

          // Debug specific item mentioned by user
          if (bulkPricingData != null &&
              bulkPricingData.containsKey('01_020_0120_1_1')) {
            final item01020 = bulkPricingData['01_020_0120_1_1'];
            log.info("DEBUG: Item 01_020_0120_1_1 data: $item01020");
            log.info(
                "DEBUG: Item 01_020_0120_1_1 source: ${item01020?['source']}");
            log.info(
                "DEBUG: Item 01_020_0120_1_1 price: ${item01020?['price']}");
          }
        } catch (e) {
          log.warning(
              "Error in bulk pricing lookup: $e. Will use standard pricing.");
          bulkPricingData = {};
        }
      }

      setState(() => _statusMessage = 'Processing invoice lines...');
      List<InvoiceLineItem> generatedItems = [];

      for (final record in workedTimes) {
        final dateStr = record['shiftDate']?.toString();
        final startTimeStr = record['shiftStartTime']?.toString().trim() ?? '';
        final timeWorkedStr = record['timeWorked']?.toString().trim() ?? '';
        log.finer(
            "\nProcessing Record: Date=$dateStr, StartTime=$startTimeStr, TimeWorked=$timeWorkedStr");

        if (dateStr == null || startTimeStr.isEmpty || timeWorkedStr.isEmpty) {
          log.fine(
              "Skipping record due to missing data: Date: $dateStr, StartTime: $startTimeStr, TimeWorked: $timeWorkedStr");
          continue;
        }

        DateTime parsedShiftStart;
        try {
          final datePart = DateTime.parse(dateStr);
          final timePart = DateFormat.jm().parseLoose(startTimeStr);
          parsedShiftStart = DateTime(datePart.year, datePart.month,
              datePart.day, timePart.hour, timePart.minute);
          log.finest("  Parsed Shift Start: $parsedShiftStart");
        } catch (e) {
          log.warning(
              "Error parsing shift start datetime: $dateStr $startTimeStr. Error: $e. Skipping record.");
          continue;
        }

        final double hours = _hoursFromTimeString(timeWorkedStr);
        if (hours <= 0) {
          log.finer(
              "Skipping record with zero or negative hours: $timeWorkedStr for $dateStr");
          continue;
        }

        bool isHighIntensityShift = false;
        String? preferredSupportCategory;
        String? preferredRegGroup;
        bool preferTTPProvider = false;
        log.finest(
            "  Context for Matcher: isHighIntensity=$isHighIntensityShift, preferredCat=$preferredSupportCategory, preferredRegGrp=$preferredRegGroup, TTP=$preferTTPProvider");

        NDISItem? matchedNdisItem;
        final String? assignedNdisItemNumber =
            selectedClient['assignedNdisItemNumber'];

        if (assignedNdisItemNumber != null &&
            assignedNdisItemNumber.isNotEmpty) {
          matchedNdisItem =
              _ndisMatcher.getItemByNumber(assignedNdisItemNumber);
          if (matchedNdisItem != null) {
            log.fine(
                "Using pre-assigned NDIS item: ${matchedNdisItem.itemNumber}");
          } else {
            log.warning(
                "Pre-assigned NDIS item $assignedNdisItemNumber not found. Falling back to matcher.");
          }
        }

        matchedNdisItem ??= _ndisMatcher.findBestMatch(
          shiftStart: parsedShiftStart,
          dynamicHolidays: _apiHolidays,
          preferredSupportCategoryNumber: preferredSupportCategory,
          preferredRegistrationGroupNumber: preferredRegGroup,
          isHighIntensityShift: isHighIntensityShift,
          preferTTP: preferTTPProvider,
        );

        if (matchedNdisItem != null) {
          log.fine(
              "  MATCHER RESULT for $dateStr $startTimeStr: Found NDIS Item: ${matchedNdisItem.itemNumber} - ${matchedNdisItem.itemName}");
          final description =
              '${matchedNdisItem.itemNumber} - ${matchedNdisItem.itemName}';
          final String itemType =
              matchedNdisItem.unit.toUpperCase() == 'E' ? 'item' : 'service';

          // Implement correct pricing logic as per user requirements
          double unitPrice = _kDefaultBaseRate; // Default base rate
          // ignore: unused_local_variable
          String pricingSource = 'base_rate';

          // Check if we have pricing data from bulk lookup
          final cachedPricing = bulkPricingData?[matchedNdisItem.itemNumber];
          log.info("DEBUG: Processing item ${matchedNdisItem.itemNumber}");
          log.info(
              "DEBUG: Cached pricing for ${matchedNdisItem.itemNumber}: $cachedPricing");
          log.info("DEBUG: Cached pricing source: ${cachedPricing?['source']}");
          log.info("DEBUG: Cached pricing price: ${cachedPricing?['price']}");

          if (cachedPricing != null && cachedPricing['error'] == null) {
            // Check if custom pricing exists in customPricing collection
            if (cachedPricing['source'] == 'client_specific' ||
                cachedPricing['source'] == 'organization') {
              try {
                double customPrice =
                    double.parse(cachedPricing['price'].toString());

                // Check for price cap warnings from backend
                if (cachedPricing['priceCapWarning'] != null) {
                  log.warning(
                      "Price cap warning for ${matchedNdisItem.itemNumber}: ${cachedPricing['priceCapWarning']}");
                }

                // Use custom pricing regardless of cap compliance (as per user requirement)
                unitPrice = customPrice;
                pricingSource = cachedPricing['source'] ?? 'custom';
                log.info(
                    "Using custom $pricingSource pricing for ${matchedNdisItem.itemNumber}: \$${unitPrice.toStringAsFixed(2)}");
              } catch (e) {
                log.warning(
                    "Error parsing custom pricing for ${matchedNdisItem.itemNumber}: $e. Using base rate.");
                unitPrice = _kDefaultBaseRate;
                pricingSource = 'base_rate';
              }
            } else if (cachedPricing['source'] == 'base-rate' &&
                cachedPricing['price'] != null) {
              // Use base rate pricing (30.00) as specified in requirements
              try {
                unitPrice = double.parse(cachedPricing['price'].toString());
                pricingSource = 'base_rate';

                // Check for price cap warnings
                if (cachedPricing['priceCapWarning'] != null) {
                  log.warning(
                      "Price cap warning for ${matchedNdisItem.itemNumber}: ${cachedPricing['priceCapWarning']}");
                }

                log.info(
                    "Using base rate pricing for ${matchedNdisItem.itemNumber}: \$${unitPrice.toStringAsFixed(2)}");
              } catch (e) {
                log.warning(
                    "Error parsing base rate pricing for ${matchedNdisItem.itemNumber}: $e. Using fallback base rate.");
                unitPrice = _kDefaultBaseRate;
                pricingSource = 'base_rate';
              }
            } else {
              // No pricing found, use base rate fallback
              unitPrice = _kDefaultBaseRate;
              pricingSource = 'base_rate';
              log.info(
                  "No pricing found for ${matchedNdisItem.itemNumber}, using base rate fallback: \$${unitPrice.toStringAsFixed(2)}");
            }
          } else {
            // No cached pricing data available, use base rate
            unitPrice = _kDefaultBaseRate;
            pricingSource = 'base_rate';
            log.info(
                "No pricing data available for ${matchedNdisItem.itemNumber}, using base rate: \$${unitPrice.toStringAsFixed(2)}");
          }

          double quantity =
              (matchedNdisItem.unit.toUpperCase() == 'H') ? hours : 1.0;

          if (matchedNdisItem.type == "Unit Price = 0.1") {
            unitPrice = 1.0;
            if (matchedNdisItem.unit.toUpperCase() == 'E') quantity = 1.0;
          }
          log.finest(
              "  Generated Line Item Details: Desc='$description', Qty=$quantity, Price=$unitPrice, Type='$itemType'");

          if (unitPrice > 0.0 ||
              matchedNdisItem.type != "Price Limited Supports" ||
              matchedNdisItem.type == "Unit Price = 0.1") {
            generatedItems.add(InvoiceLineItem(
              description: description,
              quantity: quantity,
              unitPrice: unitPrice,
              type: itemType,
              source: LineItemSource.ndisMatcherAlgorithm,
            ));
            log.finer("    ADDED: Line item from NDIS Matcher for $dateStr.");
          } else {
            log.warning(
                "Matched Price Limited item ${matchedNdisItem.itemNumber} has an invalid price ($unitPrice). Shift: $parsedShiftStart. Using placeholder.");
            generatedItems.add(InvoiceLineItem(
              description:
                  "Service on $dateStr (Review Pricing: ${matchedNdisItem.itemNumber})",
              quantity: hours,
              unitPrice: 0.0,
              type: "service",
              source: LineItemSource.manualPlaceholder,
            ));
          }
        } else {
          log.warning(
              "No NDIS item found by matcher for shift on $dateStr at $startTimeStr ($hours hrs). Shift Start: $parsedShiftStart. Holidays: $_apiHolidays. Adding placeholder.");
          generatedItems.add(InvoiceLineItem(
            description:
                "Manual Review Required: Shift $dateStr $startTimeStr ($hours hrs)",
            quantity: hours,
            unitPrice: 0.0,
            type: "service",
            source: LineItemSource.manualPlaceholder,
          ));
        }
      }

      log.info(
          "--- Finished _generateDataForPair. Total generated items: ${generatedItems.length} ---");
      if (!mounted) return;
      setState(() {
        _lineItems = generatedItems;
        if (generatedItems.isEmpty && workedTimes.isNotEmpty) {
          _statusMessage =
              "Could not automatically generate line items for all shifts. Please review or add manually.";
        } else if (generatedItems.isEmpty && workedTimes.isEmpty) {
          _statusMessage = "No worked time data to generate line items from.";
        } else if (generatedItems.isNotEmpty) {
          _statusMessage =
              "${generatedItems.length} line item(s) generated. Review and proceed.";
        }
      });
    } catch (e, s) {
      log.severe("Error in _generateDataForPair", e, s);
      if (mounted) {
        _statusMessage = 'Error processing shift data.';
        _showErrorSnackBar('Failed to process shifts: ${e.toString()}');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  double _hoursFromTimeString(String timeString) {
    if (timeString.isEmpty) return 0.0;
    try {
      List<String> parts = timeString.split(':');
      if (parts.length != 3) {
        log.warning(
            "Invalid timeString format for hours: $timeString. Expected HH:MM:SS");
        return 0.0;
      }
      int hours = int.tryParse(parts[0]) ?? 0;
      int minutes = int.tryParse(parts[1]) ?? 0;
      int seconds = int.tryParse(parts[2].split(' ')[0]) ?? 0;
      double totalHours = hours + (minutes / 60.0) + (seconds / 3600.0);
      return double.parse(totalHours.toStringAsFixed(2));
    } catch (e) {
      log.warning("Error parsing hours from timeString '$timeString': $e");
      return 0.0;
    }
  }

  /// Generate and show PDF using the enhanced invoice service
  /// Follows the same pattern as the enhanced invoice generation system
  Future<void> _generateAndShowPdf() async {
    if (_lineItems.isEmpty) {
      log.info("Attempted to generate PDF with no line items.");
      _showErrorSnackBar('No line items available to generate PDF.');
      return;
    }
    if (!mounted) return;
    setState(() => _isLoading = true);
    log.info("Starting PDF generation...");
    try {
      // Create selected employees and clients data structure
      // that matches the enhanced invoice service expectations
      final List<Map<String, dynamic>> selectedEmployeesAndClients = [
        {
          'employeeEmail': _selectedEmployeeEmail ?? '',
          'clientEmail': _selectedClientEmail ?? '',
          'clientName': _clientName,
          'providerName': _providerName,
          'providerABN': _providerABN,
          'startDate': _startDate,
          'endDate': _endDate,
          'lineItems': _lineItems.map((item) => item.toJson()).toList(),
        }
      ];

      // Use the enhanced invoice service to generate PDFs
      final pdfPaths = await _invoiceService.generateInvoicesWithPricing(
        taxRate: _taxRate,
        context,
        selectedEmployeesAndClients: selectedEmployeesAndClients,
        validatePrices: true,
        allowPriceCapOverride: false,
        includeDetailedPricingInfo: true,
        includeExpenses: true, // Include expenses in the invoice
        attachedPhotos: [], // No attached photos in this view
        photoDescription: '', // No photo description
        additionalAttachments: [], // No additional attachments in this view
        priceOverrides: null, // No price overrides in this view
      );

      if (!mounted) return;

      if (pdfPaths.isNotEmpty) {
        setState(() {
          _pdfPath = pdfPaths.first;
          _isLoading = false;
        });
        log.info("PDF generated successfully at $_pdfPath");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Invoice PDF generated! Tap again to view.'),
            backgroundColor: ModernPricingDesign.successColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(ModernPricingDesign.radiusMd)),
            margin: const EdgeInsets.all(ModernPricingDesign.spacingMd)));
      } else {
        setState(() => _isLoading = false);
        _showErrorSnackBar('No PDF was generated. Please check your data.');
      }
    } catch (e, s) {
      log.severe("Error in _generateAndShowPdf", e, s);
      if (!mounted) return;
      setState(() => _isLoading = false);
      _showErrorSnackBar('Error generating PDF: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: ModernPricingDesign.backgroundPrimary,
        appBar: AppBar(
          title: Text('Generate Invoice', style: ModernPricingDesign.headingMd),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme:
              const IconThemeData(color: ModernPricingDesign.textPrimary),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(
                  color: ModernPricingDesign.primaryColor),
              const SizedBox(height: ModernPricingDesign.spacingLg),
              Text(_statusMessage,
                  style: ModernPricingDesign.bodyLg
                      .copyWith(color: ModernPricingDesign.textSecondary)),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: ModernPricingDesign.backgroundPrimary,
      appBar: AppBar(
        title: Text('Review & Generate',
            style: ModernPricingDesign.headingMd
                .copyWith(color: ModernPricingDesign.textPrimary)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: ModernPricingDesign.textPrimary),
        actions: [
          if (_pdfPath.isNotEmpty && File(_pdfPath).existsSync())
            IconButton(
              icon: const Icon(Icons.share,
                  color: ModernPricingDesign.primaryColor),
              onPressed: () {
                log.info("Share PDF button pressed. Path: $_pdfPath");
                _showErrorSnackBar('Sharing functionality to be implemented.');
              },
            )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(ModernPricingDesign.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_providerName.isNotEmpty)
              ModernGradientCard(
                gradientColors: const [Colors.white, Colors.white],
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: ModernPricingDesign.primaryColor
                          .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.business_center_outlined,
                        color: ModernPricingDesign.primaryColor),
                  ),
                  title: Text("Provider",
                      style: ModernPricingDesign.caption
                          .copyWith(color: ModernPricingDesign.textSecondary)),
                  subtitle: Text(_providerName,
                      style: ModernPricingDesign.bodyMd
                          .copyWith(fontWeight: FontWeight.w600)),
                  trailing: Text("ABN: $_providerABN",
                      style: ModernPricingDesign.caption),
                ),
              ),
            const SizedBox(height: ModernPricingDesign.spacingMd),
            if (_clientName.isNotEmpty)
              ModernGradientCard(
                gradientColors: const [Colors.white, Colors.white],
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: ModernPricingDesign.secondaryColor
                          .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.person_outline,
                        color: ModernPricingDesign.secondaryColor),
                  ),
                  title: Text("Client",
                      style: ModernPricingDesign.caption
                          .copyWith(color: ModernPricingDesign.textSecondary)),
                  subtitle: Text(_clientName,
                      style: ModernPricingDesign.bodyMd
                          .copyWith(fontWeight: FontWeight.w600)),
                  trailing: Text("$_startDate to $_endDate",
                      style: ModernPricingDesign.caption),
                ),
              ),
            const SizedBox(height: ModernPricingDesign.spacingLg),
            if (_lineItems.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: ModernPricingDesign.spacingSm),
                child: Text('Generated Line Items (${_lineItems.length})',
                    style: ModernPricingDesign.headingSm),
              )
            else if (!_isLoading)
              ModernEmptyState(
                title: "No Items Generated",
                message: _statusMessage,
                icon: Icons.receipt_long_outlined,
                action: (_statusMessage
                            .contains("Could not automatically generate") ||
                        _statusMessage.contains("No worked time") ||
                        _statusMessage.contains("No clients assigned") ||
                        _statusMessage.contains("No employees found"))
                    ? ModernActionButton(
                        text: 'Add Items Manually',
                        icon: Icons.add_circle_outline,
                        variant: ModernActionButtonVariant.secondary,
                        onPressed: () {
                          setState(() {
                            _lineItems.add(InvoiceLineItem(
                                description: '',
                                quantity: 1,
                                unitPrice: 0,
                                type: 'service',
                                source: LineItemSource.userAdded));
                          });
                        },
                      )
                    : null,
              ),
            const SizedBox(height: ModernPricingDesign.spacingSm),
            if (_lineItems.isNotEmpty)
              DynamicLineItemEntry(
                lineItems: _lineItems,
                onChanged: (items) => setState(() => _lineItems = items),
              ),
            const SizedBox(height: ModernPricingDesign.spacingXl),
            Center(
              child: ModernActionButton(
                text: 'Generate & View PDF',
                icon: Icons.picture_as_pdf_rounded,
                variant: ModernActionButtonVariant.primary,
                padding:
                    const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                onPressed: _lineItems.isEmpty && !_isLoading
                    ? null
                    : _generateAndShowPdf,
              ),
            ),
            const SizedBox(height: ModernPricingDesign.spacingLg),
            if (_pdfPath.isNotEmpty && File(_pdfPath).existsSync())
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: ModernPricingDesign.borderColor),
                    borderRadius:
                        BorderRadius.circular(ModernPricingDesign.radiusMd),
                    boxShadow: ModernPricingDesign.cardShadow),
                height: MediaQuery.of(context).size.height * 0.75,
                child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(ModernPricingDesign.radiusMd),
                    child: PdfViewPage(pdfPath: _pdfPath)),
              )
            else if (_pdfPath.isNotEmpty && !File(_pdfPath).existsSync())
              Padding(
                padding: const EdgeInsets.all(ModernPricingDesign.spacingMd),
                child: Center(
                    child: Text(
                  "Error: Generated PDF file not found at path:\n$_pdfPath\nPlease try generating again.",
                  style: ModernPricingDesign.bodyMd
                      .copyWith(color: ModernPricingDesign.errorColor),
                  textAlign: TextAlign.center,
                )),
              ),
          ],
        ),
      ),
    );
  }
}
