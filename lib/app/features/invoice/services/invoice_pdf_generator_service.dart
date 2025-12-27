

import 'package:flutter/widgets.dart';
import 'dart:io';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/config/environment.dart';
import 'package:carenest/app/features/invoice/utils/hours_formatting.dart';
import '../../../shared/utils/shared_preferences_utils.dart';
import '../../../core/services/file_conversion_service.dart';
import 'invoice_number_generator_service.dart';

class InvoicePdfGenerator {
  final FileConversionService _fileConversionService = FileConversionService();

  Future<List<String>> generatePdfs(
    Map<String, dynamic> invoices, {
    bool showTax = true,
    required double taxRate,
    List<File>? attachedPhotos,
    String? photoDescription,
    List<File>? additionalAttachments,
    List<String>? uploadedPhotoUrls,
    List<String>? uploadedAdditionalFileUrls,
    bool useAdminBankDetails = false,
  }) async {
    List<String> generatedPdfPaths = [];

    try {
      debugPrint('PDF Generator: Starting PDF generation $taxRate');
      final clients = invoices['clients'] as List<dynamic>? ?? [];
      debugPrint('PDF Generator: Found ${clients.length} clients to process');

      for (var clientData in clients) {
        if (clientData is! Map<String, dynamic>) {
          debugPrint('Warning: Invalid client data format');
          continue;
        }

        // Ensure admin bank details flag is present for downstream usage
        // If the generator was invoked with useAdminBankDetails=true, propagate it to each client
        if (useAdminBankDetails == true) {
          clientData['useAdminBankDetails'] = true;
        } else if (!clientData.containsKey('useAdminBankDetails')) {
          clientData['useAdminBankDetails'] = false;
        }

        debugPrint(
            'PDF Generator: Processing client: ${clientData['clientName']}');

        // Debug: Check if expenses data exists
        final expenses = clientData['expenses'] as List<dynamic>? ?? [];
        debugPrint('PDF Generator: Client has ${expenses.length} expenses');
        if (expenses.isNotEmpty) {
          debugPrint('PDF Generator: First expense: ${expenses.first}');
          debugPrint('PDF Generator: All expenses: $expenses');
        }
        debugPrint(
            'PDF Generator: _hasExpenses result: ${_hasExpenses(clientData)}');
        debugPrint('PDF Generator: clientData keys: ${clientData.keys}');
        debugPrint(
            "PDF Generator: expenses key exists: ${clientData.containsKey('expenses')}");

        // Recalculate and apply tax fixes so corrected totals are persisted downstream
        _applyTaxFixesAndPersistableTotals(clientData, showTax, taxRate);

        final pdf = pw.Document();

        // Generate invisible watermark for the invoice
        final invoiceNum = _getSafeString(clientData['invoiceNumber']);
        debugPrint('PDF Generator: invoiceNum: $invoiceNum');
        final String watermark = invoiceNum.isNotEmpty
            ? InvoiceNumberGeneratorService.generateWatermark(invoiceNum)
                .toString()
            : '';

        // Build photo attachments section asynchronously if needed
        pw.Widget? photoAttachmentsSection;
        if (_hasPhotoAttachments(clientData, attachedPhotos)) {
          photoAttachmentsSection = await _buildPhotoAttachmentsSectionAsync(
              clientData, attachedPhotos, photoDescription);
        }

        final invoiceTotalWidget = await _buildInvoiceTotal(clientData, showTax, taxRate);

        pdf.addPage(
          pw.MultiPage(
            pageFormat: PdfPageFormat.a4.copyWith(
                marginLeft: 15,
                marginRight: 15,
                marginTop: 35,
                marginBottom: 25),
            build: (pw.Context context) => [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // Add invisible watermark for app-based detection
                  if (watermark.isNotEmpty)
                    pw.Positioned(
                      left: 0,
                      top: 0,
                      child: pw.Text(
                        watermark,
                        style: pw.TextStyle(
                          fontSize: 0.1, // Nearly invisible
                          color:
                              PdfColors.white, // White text on white surface
                        ),
                      ),
                    ),
                  _buildInvoiceHeader(clientData),
                  pw.SizedBox(height: 24),
                  pw.SizedBox(
                      height: 1, child: pw.Divider(color: PdfColors.black)),
                  pw.SizedBox(height: 24),
                  _buildBillingInfo(clientData),
                  pw.SizedBox(height: 24),
                  _buildInvoiceDetails(clientData),
                  pw.SizedBox(height: 24),
                  // Add expenses table if expenses are included
                  if (_hasExpenses(clientData)) ...[
                    _buildExpensesTable(clientData),
                    pw.SizedBox(height: 24),
                  ],
                  invoiceTotalWidget,
                  pw.SizedBox(height: 24),
                  // Add photo attachments section if photos are provided or if expenses have photos
                  if (photoAttachmentsSection != null) ...[
                    photoAttachmentsSection,
                    pw.SizedBox(height: 24),
                  ],
                  // Add download links section if uploaded files exist
                  if ((uploadedPhotoUrls != null &&
                          uploadedPhotoUrls.isNotEmpty) ||
                      (uploadedAdditionalFileUrls != null &&
                          uploadedAdditionalFileUrls.isNotEmpty)) ...[
                    _buildDownloadLinksSection(
                        uploadedPhotoUrls, uploadedAdditionalFileUrls),
                    pw.SizedBox(height: 24),
                  ],
                ],
              ),
            ],
          ),
        );

        // Generate safe filename using invoice number generator service
        final invoiceNumber = _getSafeString(clientData['invoiceNumber']);
        final fileName = invoiceNumber.isNotEmpty
            ? InvoiceNumberGeneratorService.generateFileName(invoiceNumber)
            : 'Invoice_${_getSafeString(clientData['clientName']).replaceAll(' ', '_').replaceAll(RegExp(r'[^\w\s-]'), '')}_${DateTime.now().millisecondsSinceEpoch}.pdf';
        debugPrint('PDF Generator: Generated filename: $fileName');

        final output = await getApplicationDocumentsDirectory();
        debugPrint('PDF Generator: Documents directory: ${output.path}');

        final file = File('${output.path}/$fileName');
        debugPrint('PDF Generator: Full file path: ${file.path}');

        await file.writeAsBytes(await pdf.save());
        debugPrint('PDF Generator: PDF saved successfully');

        // Verify file exists
        final exists = await file.exists();
        debugPrint('PDF Generator: File exists after save: $exists');

        if (exists) {
          final fileSize = await file.length();
          debugPrint('PDF Generator: File size: $fileSize bytes');
        }

        // Handle additional file attachments if provided
        File finalPdfFile = file;
        if (additionalAttachments != null && additionalAttachments.isNotEmpty) {
          try {
            debugPrint(
                'PDF Generator: Processing ${additionalAttachments.length} additional attachments');

            // Filter out unsupported files and log them
            final supportedAttachments = additionalAttachments.where((file) {
              final isSupported =
                  FileConversionService.isFileSupported(file.path);
              if (!isSupported) {
                debugPrint(
                    'PDF Generator: Skipping unsupported file: ${file.path}');
              }
              return isSupported;
            }).toList();

            if (supportedAttachments.isNotEmpty) {
              debugPrint(
                  'PDF Generator: Converting and merging ${supportedAttachments.length} supported attachments');
              finalPdfFile = await _fileConversionService
                  .convertAndMergeWithInvoice(file, supportedAttachments);
              debugPrint(
                  'PDF Generator: Successfully merged attachments. Final PDF: ${finalPdfFile.path}');

              // Delete the original invoice PDF since we now have the merged version
              try {
                await file.delete();
                debugPrint('PDF Generator: Deleted original invoice PDF');
              } catch (e) {
                debugPrint(
                    'PDF Generator: Warning - Could not delete original PDF: $e');
              }
            } else {
              debugPrint(
                  'PDF Generator: No supported attachments found for conversion');
            }
          } catch (e) {
            debugPrint('PDF Generator: Error processing attachments: $e');
            debugPrint(
                'PDF Generator: Using original invoice PDF without attachments');
            // Continue with the original PDF if attachment processing fails
          }
        }

        generatedPdfPaths.add(finalPdfFile.path);
        debugPrint(
            'PDF Generator: Added final path to list: ${finalPdfFile.path}');
      }
    } catch (e) {
      debugPrint('Error generating PDFs: $e');
      debugPrint('Stack trace: ${StackTrace.current}');
    }

    debugPrint(
        'PDF Generator: Completed. Generated ${generatedPdfPaths.length} PDFs');
    debugPrint('PDF Generator: Paths: $generatedPdfPaths');
    return generatedPdfPaths;
  }

  String _getSafeString(dynamic value) {
    if (value == null) return '';
    if (value is String) return value;
    return value.toString();
  }

  String _getSafeStringWithDefault(dynamic value, String defaultValue) {
    if (value == null) return defaultValue;
    if (value is String && value.isEmpty) return defaultValue;
    return value.toString();
  }

  // Format a tax rate (fraction) into a human-friendly percentage without over-rounding.
  // Examples: 0.135 -> "13.5", 0.10 -> "10", 0.0725 -> "7.25"
  String _formatPercentage(double rate) {
    final double p = (_getSafeDouble(rate) * 100);
    // Handle floating point noise
    double rounded0 = p.roundToDouble();
    if ((p - rounded0).abs() < 1e-9) {
      return rounded0.toStringAsFixed(0);
    }
    double rounded1 = (p * 10).roundToDouble() / 10.0;
    if ((p - rounded1).abs() < 1e-9) {
      return rounded1.toStringAsFixed(1);
    }
    return p.toStringAsFixed(2);
  }

  String _buildClientName(Map<String, dynamic> clientData) {
    final firstName = _getSafeString(clientData['clientFirstName']).trim();
    final lastName = _getSafeString(clientData['clientLastName']).trim();

    if (firstName.isEmpty && lastName.isEmpty) {
      return 'Client Name Not Available';
    }

    return '$firstName $lastName'.trim();
  }

  String _buildClientAddress(Map<String, dynamic> clientData) {
    final address = _getSafeString(clientData['clientAddress']).trim();
    final city = _getSafeString(clientData['clientCity']).trim();
    final state = _getSafeString(clientData['clientState']).trim();
    final zip = _getSafeString(clientData['clientZip']).trim();

    List<String> addressParts = [];

    if (address.isNotEmpty) addressParts.add(address);
    if (city.isNotEmpty) addressParts.add(city);
    if (state.isNotEmpty) addressParts.add(state);
    if (zip.isNotEmpty) addressParts.add(zip);

    return addressParts.isEmpty
        ? 'Address Not Available'
        : addressParts.join(', ');
  }

  pw.Widget _buildInvoiceHeader(Map<String, dynamic> clientData) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Container(
              padding: const pw.EdgeInsets.all(8),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.black),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // Employee name - left aligned (not key-value)
                  pw.Text(
                      _getSafeString(
                          clientData['employeeName'] ?? 'Provider Name'),
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(height: 8),
                  // Key-value pairs with justified alignment
                  _buildAlignedKeyValue('ABN:',
                      _getSafeString(clientData['providerABN'] ?? 'N/A')),
                  pw.SizedBox(height: 3),
                  _buildAlignedKeyValue('Period Starting:',
                      _getSafeString(clientData['startDate'] ?? 'N/A')),
                  pw.SizedBox(height: 3),
                  _buildAlignedKeyValue('Period Ending:',
                      _getSafeString(clientData['endDate'] ?? 'N/A')),
                  pw.SizedBox(height: 3),
                  _buildAlignedKeyValue('Total Amount:',
                      '\$${_getSafeDouble(clientData['total']).toStringAsFixed(2)}'),
                  pw.SizedBox(height: 3),
                  _buildAlignedKeyValue(
                      'Hours Completed:',
                      HoursFormatting.formatDecimalHours(
                        _getSafeDouble(
                          clientData['totalHours'] ??
                              _calculateTotalHours(clientData),
                        ),
                        minDecimals: 2,
                        maxDecimals: 4,
                      )),
                ],
              ),
            ),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text('INVOICE',
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  double _calculateTotalHours(Map<String, dynamic> clientData) {
    final items = clientData['items'] as List<dynamic>? ?? [];
    double totalHours = 0.0;
    for (var item in items) {
      if (item is Map<String, dynamic>) {
        totalHours += _getSafeDouble(item['hours']);
      }
    }
    // Return precise total; format for display at usage sites.
    return totalHours;
  }

  // Ensure tax-related totals are correct and stored back on the invoice data
  void _applyTaxFixesAndPersistableTotals(
      Map<String, dynamic> clientData, bool showTax, double taxRate) {
    try {
      debugPrint(
          'Invoice PDF Generator _applyTaxFixesAndPersistableTotals: showTax=$showTax, taxRate=$taxRate');
      // Calculate items subtotal with robust fallbacks
      final items = clientData['items'] as List<dynamic>? ?? [];
      double itemsSubtotal = 0.0;
      for (final item in items) {
        if (item is Map<String, dynamic>) {
          final double amount = _getSafeDouble(
            item['amount'] ??
                item['total'] ??
                ((_getSafeDouble(item['rate']) *
                    _getSafeDouble(item['hours']))),
          );
          itemsSubtotal += amount;
        }
      }

      // Calculate expenses total with fallbacks
      final expenses = clientData['expenses'] as List<dynamic>? ?? [];
      double expensesTotal = 0.0;
      for (final expense in expenses) {
        if (expense is Map<String, dynamic>) {
          expensesTotal += _getSafeDouble(expense['totalAmount'] ??
              expense['unitCost'] ??
              expense['amount']);
        }
      }

      final double subtotal = itemsSubtotal + expensesTotal;
      final bool shouldApplyTax = showTax == true; // respect caller intent
      final double effectiveTaxRate =
          _getSafeDouble(taxRate); // Convert percentage to decimal
      final double taxAmount =
          shouldApplyTax ? subtotal * effectiveTaxRate : 0.0;
      final double total = subtotal + taxAmount;

      // Write back into clientData so downstream save uses corrected values
      clientData['itemsSubtotal'] =
          double.parse(itemsSubtotal.toStringAsFixed(2));
      clientData['expensesTotal'] =
          double.parse(expensesTotal.toStringAsFixed(2));
      clientData['subtotal'] = double.parse(subtotal.toStringAsFixed(2));
      clientData['taxAmount'] = double.parse(taxAmount.toStringAsFixed(2));
      clientData['tax'] = clientData['taxAmount']; // PDF expects 'tax'
      clientData['taxRate'] = effectiveTaxRate;
      clientData['total'] = double.parse(total.toStringAsFixed(2));
      // Also persist boolean flags for downstream services to save reliably
      clientData['applyTax'] = shouldApplyTax;
      clientData['showTax'] = shouldApplyTax;
      clientData['includesTax'] = shouldApplyTax;

      debugPrint(
          'PDF Generator: Applied tax fixes -> itemsSubtotal=$itemsSubtotal, expensesTotal=$expensesTotal, subtotal=$subtotal, tax=$taxAmount (rate=$effectiveTaxRate), total=$total, showTax=$shouldApplyTax');
    } catch (e) {
      debugPrint('PDF Generator: Error applying tax fixes: $e');
    }
  }

  pw.Widget _buildBillingInfo(Map<String, dynamic> clientData) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Bill To:',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text(_buildClientName(clientData)),
              pw.Text(_getSafeString(clientData['clientEmail'] ?? '')),
              pw.Text(_buildClientAddress(clientData)),
              pw.Text(_getSafeString(clientData['clientPhone'] ?? '')),
              // Only display business name in braces if it's not empty
              if (_getSafeString(clientData['businessName'] ?? '').isNotEmpty)
                pw.Text('(${_getSafeString(clientData['businessName'])})')
            ],
          ),
        ),
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text(
                  'Invoice Number: ${_getSafeString(clientData['invoiceNumber'])}',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text(
                  'Job Title: ${_getSafeString(clientData['jobTitle'] ?? 'Personal Care Assistance')}'),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _buildInvoiceDetails(Map<String, dynamic> clientData) {
    final items = clientData['items'] as List<dynamic>? ?? [];
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // pw.Text('Invoice Components',
        //     style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 10),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.black),
          columnWidths: {
            0: const pw.FlexColumnWidth(3), // Invoice Components
            1: const pw.FlexColumnWidth(2), // Time Worked
            2: const pw.FlexColumnWidth(1), // Hours/Units
            3: const pw.FlexColumnWidth(1), // Rate
            4: const pw.FlexColumnWidth(1), // Total Amount
          },
          children: [
            pw.TableRow(
              decoration: pw.BoxDecoration(color: PdfColors.grey300),
              children: [
                _buildTableHeader('Invoice Components'),
                _buildTableHeader('Time Worked'),
                _buildTableHeader('Hours'),
                _buildTableHeader('Rate'),
                _buildTableHeader('Total Amount'),
              ],
            ),
            ...items.map<pw.TableRow>((item) {
              if (item is! Map<String, dynamic>) {
                debugPrint('Warning: Invalid item format');
                return pw.TableRow(children: List.filled(5, pw.Container()));
              }
              // Debug print to check item structure
              debugPrint("""\n\nitem: ${item.toString()}\n\n""");
              // Format the time worked string with state and hours
              String timeWorked = '';
              if (item['date'] != null &&
                  item['startTime'] != null &&
                  item['endTime'] != null) {
                String date = _getSafeString(item['date']);
                String startTime = _getSafeString(item['startTime']);
                String endTime = _getSafeString(item['endTime']);
                String clientState =
                    _getSafeString(clientData['clientState'] ?? 'NSW');
                String hours = _getSafeString(item['hours']);

                // Display exact hours with up to 4 decimals (includes seconds)
                double hoursDouble = _getSafeDouble(item['hours']);
                String formattedHours = HoursFormatting.formatDecimalHours(
                  hoursDouble,
                  minDecimals: 2,
                  maxDecimals: 4,
                );

                timeWorked =
                    '$date - $startTime to $endTime - $clientState ($formattedHours hours)';
              } else if (item['date'] != null &&
                  item['timeStart'] != null &&
                  item['timeEnd'] != null) {
                // Fallback for legacy timeStart/timeEnd field names
                String date = _getSafeString(item['date']);
                String startTime = _getSafeString(item['timeStart']);
                String endTime = _getSafeString(item['timeEnd']);
                String clientState =
                    _getSafeString(clientData['clientState'] ?? 'NSW');

                // Display exact hours with up to 4 decimals (includes seconds)
                double hoursDouble = _getSafeDouble(item['hours']);
                String formattedHours = HoursFormatting.formatDecimalHours(
                  hoursDouble,
                  minDecimals: 2,
                  maxDecimals: 4,
                );

                timeWorked =
                    '$date - $startTime to $endTime - $clientState ($formattedHours hours)';
              }

              // Format the description using itemNumber and itemName from nested ndisItem object
              String description = '';
              if (item['ndisItem'] != null &&
                  item['ndisItem']['itemNumber'] != null &&
                  item['ndisItem']['itemName'] != null) {
                description =
                    '${_getSafeString(item['ndisItem']['itemNumber'])} ${_getSafeString(item['ndisItem']['itemName'])}';
                // if (item['day'] != null) {
                //   description += ' - ${_getSafeString(item['day'])}';
                // }
                // if (item['activityType'] != null) {
                //   description += ' - ${_getSafeString(item['activityType'])}';
                // }
                // if (item['dayType'] != null) {
                //   description += ' - ${_getSafeString(item['dayType'])}';
                // }
              } else if (item['ndisItemNumber'] != null &&
                  item['ndisItemName'] != null) {
                // Fallback for direct ndisItem fields (backward compatibility)
                description =
                    '${_getSafeString(item['ndisItemNumber'])} ${_getSafeString(item['ndisItemName'])}';
                // if (item['day'] != null) {
                //   description += ' - ${_getSafeString(item['day'])}';
                // }
                // if (item['activityType'] != null) {
                //   description += ' - ${_getSafeString(item['activityType'])}';
                // }
                // if (item['dayType'] != null) {
                //   description += ' - ${_getSafeString(item['dayType'])}';
                // }
              } else if (item['itemCode'] != null) {
                // Fallback to legacy format if ndisItem data is not available
                description =
                    '${_getSafeString(item['itemCode'])} ${_getSafeString(item['itemName'] ?? 'Assistance With Self-Care Activities')}';
                // if (item['day'] != null) {
                //   description += ' - ${_getSafeString(item['day'])}';
                // }
                // if (item['activityType'] != null) {
                //   description += ' - ${_getSafeString(item['activityType'])}';
                // }
                // if (item['dayType'] != null) {
                //   description += ' - ${_getSafeString(item['dayType'])}';
                // }
              }

              return pw.TableRow(
                children: [
                  _buildTableCell(description),
                  _buildTableCell(timeWorked),
                  _buildNumericTableCell(
                    HoursFormatting.formatDecimalHours(
                      _getSafeDouble(item['hours']),
                      minDecimals: 2,
                      maxDecimals: 4,
                    ),
                  ),
                  _buildNumericTableCell(
                      '\$${_getSafeDouble(item['rate']).toStringAsFixed(2)}'),
                  _buildNumericTableCell(
                      '\$${_getSafeDouble(item['amount']).toStringAsFixed(2)}'),
                ],
              );
            }),
          ],
        ),
        pw.SizedBox(height: 6),
        pw.Text(
          'Note: Hours include seconds and are shown up to 4 decimals. Totals are Hours × Rate, rounded to 2 decimals.',
          style: pw.TextStyle(fontSize: 8),
        ),
      ],
    );
  }

  /// Builds the totals section and resolves bank details for display.
  ///
  /// Bank details resolution strategy:
  /// - If `clientData['useAdminBankDetails']` is true, prefer admin bank details.
  /// - If employee bank details are missing, fall back to admin bank details.
  /// - If both employee and admin bank details are unavailable, throws
  ///   `Exception('BANK_DETAILS_REQUIRED')` for upstream UI to prompt user.
  Future<pw.Widget> _buildInvoiceTotal(
      Map<String, dynamic> clientData, bool showTax, double taxRate) async {
    // Debug: Log tax-related values
    debugPrint(
        'PDF Generator _buildInvoiceTotal: showTax=$showTax, taxRate=$taxRate');
    debugPrint(
        'PDF Generator _buildInvoiceTotal: clientData["tax"]=${clientData['tax']}');
    debugPrint(
        'PDF Generator _buildInvoiceTotal: clientData["taxAmount"]=${clientData['taxAmount']}');
    debugPrint(
        'PDF Generator _buildInvoiceTotal: clientData["subtotal"]=${clientData['subtotal']}');
    debugPrint(
        'PDF Generator _buildInvoiceTotal: clientData["total"]=${clientData['total']}');

    final itemsSubtotal = _getSafeDouble(clientData['itemsSubtotal']);
    final expensesTotal = _getSafeDouble(clientData['expensesTotal']);
    final hasExpenses = expensesTotal > 0;

    final resolved = await _resolveBankDetailsForClient(clientData);
    final String bankName = resolved['bankName']!;
    final String accountName = resolved['accountName']!;
    final String bsb = resolved['bsb']!;
    final String accountNumber = resolved['accountNumber']!;

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          alignment: pw.Alignment.centerRight,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              // Show breakdown if there are expenses
              if (hasExpenses) _buildTotalRow('Items Subtotal', itemsSubtotal),
              if (hasExpenses) _buildTotalRow('Expenses Total', expensesTotal),
              if (hasExpenses) pw.Divider(color: PdfColors.grey),
              _buildTotalRow(
                  'Subtotal', _getSafeDouble(clientData['subtotal'])),
              if (showTax)
                _buildTotalRow('Tax (${_formatPercentage(taxRate)}%)',
                        _getSafeDouble(clientData['taxAmount'])),
              pw.Divider(color: PdfColors.black),
              _buildTotalRow('Total', _getSafeDouble(clientData['total']),
                  isBold: true),
            ],
          ),
        ),
        pw.SizedBox(height: 30),
        pw.Text('Bank Details:',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Text('Bank Name: $bankName'),
        pw.Text('Account Name: $accountName'),
        pw.Text('BSB: $bsb'),
        pw.Text('Account Number: $accountNumber'),
      ],
    );
  }

  /// Resolve bank details to print on the invoice.
  ///
  /// Parameters:
  /// - clientData: Map containing client invoice data and `useAdminBankDetails` flag.
  ///
  /// Returns:
  /// - Map<String, String> with keys: `bankName`, `accountName`, `bsb`, `accountNumber`.
  ///
  /// Throws:
  /// - Exception('BANK_DETAILS_REQUIRED') when neither employee nor admin bank
  ///   details are available.
  Future<Map<String, String>> _resolveBankDetailsForClient(
      Map<String, dynamic> clientData) async {
    final prefs = await SharedPreferences.getInstance();
    final sharedUtils = SharedPreferencesUtils();
    await sharedUtils.init();

    // Determine whether admin bank details should be used
    final bool useAdmin = clientData['useAdminBankDetails'] == true;
    // Branch strictly on selection to avoid cross-overriding
    if (useAdmin) {
      // Admin selected: fetch admin bank details from backend using configured owner email
      try {
        final api = ApiMethod();
        final String adminEmail = AppConfig.ownerEmail.trim();
        final String? organizationId = sharedUtils.getString('organizationId');
        if (adminEmail.isEmpty || organizationId == null || organizationId.isEmpty) {
          throw Exception('Missing adminEmail or organizationId');
        }
        final resp = await api.getBankDetailsForUserEmail(adminEmail, organizationId);
        if (resp['success'] == true && resp['data'] is Map) {
          final data = Map<String, dynamic>.from(resp['data']);
          final adminBankName = (data['bankName'] ?? '').toString();
          final adminAccountName = (data['accountName'] ?? '').toString();
          final adminBsb = (data['bsb'] ?? '').toString();
          final adminAccountNumber = (data['accountNumber'] ?? '').toString();
          if (adminBankName.isEmpty ||
              adminAccountName.isEmpty ||
              adminBsb.isEmpty ||
              adminAccountNumber.isEmpty) {
            throw Exception('BANK_DETAILS_REQUIRED');
          }
          return {
            'bankName': adminBankName,
            'accountName': adminAccountName,
            'bsb': adminBsb,
            'accountNumber': adminAccountNumber,
          };
        }
        throw Exception('BANK_DETAILS_REQUIRED');
      } catch (e) {
        debugPrint('Failed to fetch admin bank details: $e');
        throw Exception('BANK_DETAILS_REQUIRED');
      }
    } else {
      // Employee selected: prefer employee bank details; fall back to admin only if employee is missing
      String bankName = (clientData['bankName'] ?? '').toString();
      String accountName = (clientData['accountName'] ?? '').toString();
      String bsb = (clientData['bsb'] ?? '').toString();
      String accountNumber = (clientData['accountNumber'] ?? '').toString();

      final bool employeeIncomplete = bankName.isEmpty ||
          accountName.isEmpty ||
          bsb.isEmpty ||
          accountNumber.isEmpty;

      if (employeeIncomplete) {
        try {
          final api = ApiMethod();
          String employeeEmail = '';
          final dynamic emailCandidate = clientData['employeeEmail'];
          if (emailCandidate is String && emailCandidate.isNotEmpty) {
            employeeEmail = emailCandidate;
          } else {
            final String? spEmail = sharedUtils.getString('userEmail');
            if (spEmail != null && spEmail.isNotEmpty) {
              employeeEmail = spEmail;
            }
          }
          final String? organizationId = sharedUtils.getString('organizationId');
          if (employeeEmail.isNotEmpty && organizationId != null && organizationId.isNotEmpty) {
            final resp = await api.getBankDetailsForUserEmail(employeeEmail, organizationId);
            if (resp['success'] == true && resp['data'] is Map) {
              final data = Map<String, dynamic>.from(resp['data']);
              bankName = bankName.isNotEmpty ? bankName : (data['bankName'] ?? '').toString();
              accountName = accountName.isNotEmpty ? accountName : (data['accountName'] ?? '').toString();
              bsb = bsb.isNotEmpty ? bsb : (data['bsb'] ?? '').toString();
              accountNumber = accountNumber.isNotEmpty ? accountNumber : (data['accountNumber'] ?? '').toString();
            }
          }
        } catch (e) {
          debugPrint('Failed to fetch employee bank details: $e');
        }
      }

      final bool employeeComplete = bankName.isNotEmpty &&
          accountName.isNotEmpty &&
          bsb.isNotEmpty &&
          accountNumber.isNotEmpty;
      if (employeeComplete) {
        return {
          'bankName': bankName,
          'accountName': accountName,
          'bsb': bsb,
          'accountNumber': accountNumber,
        };
      }

      // Employee missing: fall back to admin (network only)
      try {
        final api = ApiMethod();
        final String adminEmail = AppConfig.ownerEmail.trim();
        final String? organizationId = sharedUtils.getString('organizationId');
        if (adminEmail.isEmpty || organizationId == null || organizationId.isEmpty) {
          throw Exception('BANK_DETAILS_REQUIRED');
        }
        final resp = await api.getBankDetailsForUserEmail(adminEmail, organizationId);
        if (resp['success'] == true && resp['data'] is Map) {
          final data = Map<String, dynamic>.from(resp['data']);
          final adminBankName = (data['bankName'] ?? '').toString();
          final adminAccountName = (data['accountName'] ?? '').toString();
          final adminBsb = (data['bsb'] ?? '').toString();
          final adminAccountNumber = (data['accountNumber'] ?? '').toString();
          if (adminBankName.isEmpty ||
              adminAccountName.isEmpty ||
              adminBsb.isEmpty ||
              adminAccountNumber.isEmpty) {
            throw Exception('BANK_DETAILS_REQUIRED');
          }
          return {
            'bankName': adminBankName,
            'accountName': adminAccountName,
            'bsb': adminBsb,
            'accountNumber': adminAccountNumber,
          };
        }
        throw Exception('BANK_DETAILS_REQUIRED');
      } catch (e) {
        debugPrint('Failed to fetch admin bank details for fallback: $e');
        throw Exception('BANK_DETAILS_REQUIRED');
      }
    }
  }

  pw.Widget _buildTableHeader(String text) {
    return pw.Container(
      padding: pw.EdgeInsets.all(5),
      child: pw.Text(
        text,
        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
      ),
    );
  }

  pw.Widget _buildTableCell(String text) {
    return pw.Container(
      padding: pw.EdgeInsets.all(5),
      child: pw.Text(text),
    );
  }

  pw.Widget _buildNumericTableCell(String text) {
    return pw.Container(
      padding: pw.EdgeInsets.all(5),
      alignment: pw.Alignment.centerRight,
      child: pw.Text(text),
    );
  }

  pw.Widget _buildTotalRow(String label, double amount, {bool isBold = false}) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(label),
        pw.Text(
          '\$${amount.toStringAsFixed(2)}',
          style: isBold ? pw.TextStyle(fontWeight: pw.FontWeight.bold) : null,
        ),
      ],
    );
  }

  double _getSafeDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    }
    return 0.0;
  }

  /// Helper method to build key-value rows with proper alignment
  /// Simple row with space between for reliable alignment
  pw.Widget _buildAlignedKeyValue(String key, String value) {
    return pw.Container(
      width: 180,
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            key,
            style: pw.TextStyle(fontWeight: pw.FontWeight.normal),
          ),
          pw.Text(
            value,
            style: pw.TextStyle(fontWeight: pw.FontWeight.normal),
          ),
        ],
      ),
    );
  }

  /// Check if client data contains expenses
  bool _hasExpenses(Map<String, dynamic> clientData) {
    final expenses = clientData['expenses'] as List<dynamic>? ?? [];
    debugPrint('PDF Generator: Checking expenses - ${expenses.length}');
    debugPrint('PDF Generator: Expenses data - $expenses');
    return expenses.isNotEmpty;
  }

  /// Build expenses table section with proper expense format
  /// Format: Expense Date | Category | Amount | Description | Receipt
  pw.Widget _buildExpensesTable(Map<String, dynamic> clientData) {
    final expenses = clientData['expenses'] as List<dynamic>? ?? [];

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Approved Expenses',
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 10),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.black),
          columnWidths: {
            0: const pw.FlexColumnWidth(1.5), // Expense Date
            1: const pw.FlexColumnWidth(1.5), // Category
            2: const pw.FlexColumnWidth(1.2), // Amount
            3: const pw.FlexColumnWidth(2.5), // Description
            4: const pw.FlexColumnWidth(1.3), // Receipt
          },
          children: [
            pw.TableRow(
              decoration: pw.BoxDecoration(color: PdfColors.grey300),
              children: [
                _buildTableHeader('Expense Date'),
                _buildTableHeader('Category'),
                _buildTableHeader('Amount'),
                _buildTableHeader('Description'),
                _buildTableHeader('Receipt'),
              ],
            ),
            ...expenses.map<pw.TableRow>((expense) {
              if (expense is! Map<String, dynamic>) {
                return pw.TableRow(children: List.filled(5, pw.Container()));
              }

              // Extract expense data with proper field mapping
              final expenseDate = _getSafeString(expense['date'] ?? '');
              final category = _getSafeString(expense['category'] ?? 'Other');
              final amount = _getSafeDouble(
                  expense['totalAmount'] ?? expense['unitCost'] ?? 0.0);
              final description =
                  _getSafeString(expense['description'] ?? 'Expense');

              return pw.TableRow(
                children: [
                  _buildTableCell(expenseDate),
                  _buildTableCell(category),
                  _buildNumericTableCell('\$${amount.toStringAsFixed(2)}'),
                  _buildTableCell(description),
                  _buildReceiptLinksCell(expense),
                ],
              );
            }),
          ],
        ),
      ],
    );
  }

  /// Build receipt links cell for expense table
  pw.Widget _buildReceiptLinksCell(Map<String, dynamic> expense) {
    debugPrint(
        'DEBUG_RECEIPT_LINKS: Processing expense: ${expense['description'] ?? 'Unknown'} - ${expense['amount'] ?? 'No amount'}');
    debugPrint('DEBUG_RECEIPT_LINKS: Full expense data: $expense');

    final receiptFiles = expense['receiptFiles'] as List<dynamic>? ?? [];
    final receiptPhotos = expense['receiptPhotos'] as List<dynamic>? ?? [];
    final receiptUrl = expense['receiptUrl'] as String?;

    debugPrint('DEBUG_RECEIPT_LINKS: receiptFiles: $receiptFiles');
    debugPrint('DEBUG_RECEIPT_LINKS: receiptPhotos: $receiptPhotos');
    debugPrint('DEBUG_RECEIPT_LINKS: receiptUrl: $receiptUrl');

    // Collect all receipt URLs
    List<String> allReceiptUrls = [];

    // Get the base URL from AppConfig
    final baseUrl = AppConfig.baseUrl.endsWith('/')
        ? AppConfig.baseUrl.substring(0, AppConfig.baseUrl.length - 1)
        : AppConfig.baseUrl;

    // Helper to create a full URL from a relative path
    String toFullUrl(String url) {
      if (url.startsWith('/')) {
        return '$baseUrl$url';
      }
      return url;
    }

    // Add from receiptFiles (preferred)
    for (var file in receiptFiles) {
      if (file is String && file.trim().isNotEmpty) {
        final cleanUrl = file.trim().replaceAll('`', '');
        if (cleanUrl.startsWith('http') || cleanUrl.startsWith('/')) {
          final fullUrl = toFullUrl(cleanUrl);
          debugPrint(
              'DEBUG_RECEIPT_LINKS: Adding URL from receiptFiles: $fullUrl');
          allReceiptUrls.add(fullUrl);
        }
      }
    }

    // Add from receiptPhotos (backward compatibility)
    for (var photo in receiptPhotos) {
      if (photo is String && photo.trim().isNotEmpty) {
        final cleanUrl = photo.trim().replaceAll('`', '');
        if (cleanUrl.startsWith('http') || cleanUrl.startsWith('/')) {
          final fullUrl = toFullUrl(cleanUrl);
          debugPrint(
              'DEBUG_RECEIPT_LINKS: Adding URL from receiptPhotos: $fullUrl');
          allReceiptUrls.add(fullUrl);
        }
      }
    }

    // Add from receiptUrl (backward compatibility)
    if (receiptUrl != null && receiptUrl.trim().isNotEmpty) {
      final cleanUrl = receiptUrl.trim().replaceAll('`', '');
      if (cleanUrl.startsWith('http') || cleanUrl.startsWith('/')) {
        final fullUrl = toFullUrl(cleanUrl);
        debugPrint('DEBUG_RECEIPT_LINKS: Adding URL from receiptUrl: $fullUrl');
        allReceiptUrls.add(fullUrl);
      }
    }

    // Remove duplicates
    allReceiptUrls = allReceiptUrls.toSet().toList();

    debugPrint('DEBUG_RECEIPT_LINKS: Final unique URLs: $allReceiptUrls');

    if (allReceiptUrls.isEmpty) {
      debugPrint('DEBUG_RECEIPT_LINKS: No URLs found, returning "No Receipt"');
      return _buildTableCell('No Receipt');
    }

    if (allReceiptUrls.length == 1) {
      // Single receipt - create one download link
      debugPrint(
          'DEBUG_RECEIPT_LINKS: Creating single receipt link for: ${allReceiptUrls.first}');
      return pw.Container(
        padding: const pw.EdgeInsets.all(4),
        child: pw.UrlLink(
          destination: allReceiptUrls.first,
          child: pw.Text(
            'Download Receipt',
            style: pw.TextStyle(
              fontSize: 10,
              color: PdfColors.blue,
              decoration: pw.TextDecoration.underline,
            ),
          ),
        ),
      );
    } else {
      // Multiple receipts - create numbered links
      debugPrint(
          'DEBUG_RECEIPT_LINKS: Creating ${allReceiptUrls.length} receipt links');
      return pw.Container(
        padding: const pw.EdgeInsets.all(4),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: allReceiptUrls.asMap().entries.map((entry) {
            final index = entry.key + 1;
            final url = entry.value;
            return pw.UrlLink(
              destination: url,
              child: pw.Text(
                'Receipt $index',
                style: pw.TextStyle(
                  fontSize: 10,
                  color: PdfColors.blue,
                  decoration: pw.TextDecoration.underline,
                ),
              ),
            );
          }).toList(),
        ),
      );
    }
  }

  /// Download image from URL and return bytes
  /// Returns null if download fails or image is invalid
  /// Includes timeout to prevent hanging
  Future<Uint8List?> _downloadImageFromUrl(String url) async {
    try {
      debugPrint('PDF Generator: Downloading image from URL: $url');

      // Add timeout to prevent hanging
      final response = await http.get(Uri.parse(url)).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          debugPrint('PDF Generator: Timeout downloading image from $url');
          throw Exception('Download timeout');
        },
      );

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        debugPrint(
            'PDF Generator: Successfully downloaded image (${bytes.length} bytes)');

        // Basic validation - check if it's a reasonable image size
        if (bytes.length < 100) {
          debugPrint(
              'PDF Generator: Downloaded file too small to be a valid image');
          return null;
        }

        return bytes;
      } else {
        debugPrint(
            'PDF Generator: Failed to download image. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('PDF Generator: Error downloading image from $url: $e');
      return null;
    }
  }

  /// Build UI photos section with embedded images
  Future<List<pw.Widget>> _buildUIPhotosSectionAsync(
      List<File> uiPhotos, String? photoDescription) async {
    final widgets = <pw.Widget>[
      pw.Text('Invoice Photos:',
          style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
      pw.SizedBox(height: 5),
      if (photoDescription != null && photoDescription.isNotEmpty)
        pw.Text('Description: $photoDescription',
            style: pw.TextStyle(fontStyle: pw.FontStyle.italic)),
      if (photoDescription != null && photoDescription.isNotEmpty)
        pw.SizedBox(height: 5),
    ];

    // Add each photo as an embedded image
    for (int i = 0; i < uiPhotos.length; i++) {
      final photo = uiPhotos[i];
      try {
        final imageBytes = await photo.readAsBytes();
        final image = pw.MemoryImage(imageBytes);

        widgets.addAll([
          pw.Text('Photo ${i + 1}: ${photo.path.split('/').last}',
              style:
                  pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 5),
          pw.Container(
            height: 200,
            width: double.infinity,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey400),
              borderRadius: pw.BorderRadius.circular(4),
            ),
            child: pw.ClipRRect(
              horizontalRadius: 4,
              verticalRadius: 4,
              child: pw.Image(
                image,
                fit: pw.BoxFit.contain,
              ),
            ),
          ),
          pw.SizedBox(height: 10),
        ]);
      } catch (e) {
        debugPrint(
            'PDF Generator: Error loading local image ${photo.path}: $e');
        // Add error placeholder
        widgets.addAll([
          pw.Text(
              'Photo ${i + 1}: ${photo.path.split('/').last} (Error loading image)',
              style: pw.TextStyle(fontSize: 12, color: PdfColors.red)),
          pw.SizedBox(height: 10),
        ]);
      }
    }

    return widgets;
  }

  /// Build download links section for uploaded attachments
  pw.Widget _buildDownloadLinksSection(List<String>? uploadedPhotoUrls,
      List<String>? uploadedAdditionalFileUrls) {
    final widgets = <pw.Widget>[
      pw.Text('Attachment Download Links',
          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
      pw.SizedBox(height: 10),
    ];

    // Add photo download links
    if (uploadedPhotoUrls != null && uploadedPhotoUrls.isNotEmpty) {
      widgets.addAll([
        pw.Text('Photo Attachments:',
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 5),
      ]);

      for (int i = 0; i < uploadedPhotoUrls.length; i++) {
        widgets.add(
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 3),
            child: pw.UrlLink(
              destination: uploadedPhotoUrls[i],
              child: pw.Text(
                'Download Photo ${i + 1}',
                style: pw.TextStyle(
                  fontSize: 12,
                  color: PdfColors.blue,
                  decoration: pw.TextDecoration.underline,
                ),
              ),
            ),
          ),
        );
      }
      widgets.add(pw.SizedBox(height: 10));
    }

    // Add additional file download links
    if (uploadedAdditionalFileUrls != null &&
        uploadedAdditionalFileUrls.isNotEmpty) {
      widgets.addAll([
        pw.Text('Additional File Attachments:',
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 5),
      ]);

      for (int i = 0; i < uploadedAdditionalFileUrls.length; i++) {
        widgets.add(
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 3),
            child: pw.UrlLink(
              destination: uploadedAdditionalFileUrls[i],
              child: pw.Text(
                'Download File ${i + 1}',
                style: pw.TextStyle(
                  fontSize: 12,
                  color: PdfColors.blue,
                  decoration: pw.TextDecoration.underline,
                ),
              ),
            ),
          ),
        );
      }
    }

    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey),
        borderRadius: pw.BorderRadius.circular(4),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: widgets,
      ),
    );
  }

  /// Check if there are any photo attachments (from UI only)
  bool _hasPhotoAttachments(
      Map<String, dynamic> clientData, List<File>? attachedPhotos) {
    return attachedPhotos != null && attachedPhotos.isNotEmpty;
  }

  /// Build photo attachments section combining UI photos (if any)
  Future<pw.Widget> _buildPhotoAttachmentsSectionAsync(
      Map<String, dynamic> clientData,
      List<File>? attachedPhotos,
      String? photoDescription) async {
    final uiPhotos = attachedPhotos ?? [];

    final widgets = <pw.Widget>[
      pw.Text('Photo Attachments',
          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
      pw.SizedBox(height: 10),
    ];

    if (uiPhotos.isNotEmpty) {
      final uiPhotoWidgets =
          await _buildUIPhotosSectionAsync(uiPhotos, photoDescription);
      widgets.addAll(uiPhotoWidgets);
    } else {
      widgets.add(pw.Text('No photos attached'));
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
