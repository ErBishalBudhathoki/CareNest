import 'package:flutter/widgets.dart';
import 'dart:io';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/config/environment.dart';
import 'package:carenest/app/features/invoice/utils/hours_formatting.dart';
import '../../../shared/utils/shared_preferences_utils.dart';
import '../../../core/services/file_conversion_service.dart';
import 'invoice_number_generator_service.dart';

class InvoicePdfGenerator {
  final ApiMethod _api;
  final FileConversionService _fileConversionService = FileConversionService();

  InvoicePdfGenerator({required ApiMethod api}) : _api = api;

  Future<List<String>> generatePdfs(
    Map<String, dynamic> invoices, {
    bool showTax = true,
    required double taxRate,
    bool preserveSnapshotTotals = false,
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

        // Ensure organization bank details flag is present for downstream usage
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

        // For regeneration/rebuild flows, keep persisted totals unchanged.
        // For normal generation flows, continue applying tax/total fixes.
        if (!preserveSnapshotTotals) {
          _applyTaxFixesAndPersistableTotals(clientData, showTax, taxRate);
        }

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

        final invoiceTotalWidget =
            await _buildInvoiceTotal(clientData, showTax, taxRate);

        pdf.addPage(
          pw.MultiPage(
            pageFormat: PdfPageFormat.a4.copyWith(
                marginLeft: 15,
                marginRight: 15,
                marginTop: 35,
                marginBottom: 25),
            maxPages: 200,
            build: (pw.Context context) => [
              if (watermark.isNotEmpty)
                pw.Text(
                  watermark,
                  style: pw.TextStyle(
                    fontSize: 0.1,
                    color: PdfColors.white,
                  ),
                ),
              _buildInvoiceHeader(clientData),
              pw.SizedBox(height: 24),
              pw.SizedBox(height: 1, child: pw.Divider(color: PdfColors.black)),
              pw.SizedBox(height: 24),
              _buildBillingInfo(clientData),
              pw.SizedBox(height: 24),
              _buildInvoiceDetails(clientData),
              pw.SizedBox(height: 6),
              _buildInvoiceItemsNote(clientData),
              pw.SizedBox(height: 24),
              if (_hasExpenses(clientData)) ...[
                _buildExpensesTable(clientData),
                pw.SizedBox(height: 24),
              ],
              invoiceTotalWidget,
              pw.SizedBox(height: 24),
              if (photoAttachmentsSection != null) ...[
                photoAttachmentsSection,
                pw.SizedBox(height: 24),
              ],
              if ((uploadedPhotoUrls != null && uploadedPhotoUrls.isNotEmpty) ||
                  (uploadedAdditionalFileUrls != null &&
                      uploadedAdditionalFileUrls.isNotEmpty)) ...[
                _buildDownloadLinksSection(
                    uploadedPhotoUrls, uploadedAdditionalFileUrls),
                pw.SizedBox(height: 24),
              ],
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
    } catch (e, st) {
      debugPrint('Error generating PDFs: $e');
      debugPrint('Stack trace: $st');
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
                  // Admin/Business name - left aligned (issuer)
                  pw.Text(
                      _getSafeString(clientData['adminProfile']
                              ?['businessName'] ??
                          'Business'),
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(height: 8),
                  // Key-value pairs with justified alignment
                  _buildAlignedKeyValue(
                      'ABN:',
                      _getSafeString(
                        clientData['adminProfile']?['abn'] ??
                            clientData['adminProfile']?['taxIdentifiers']
                                ?['abn'] ??
                            clientData['taxIdentifiers']?['abn'] ??
                            'N/A',
                      )),
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
                        _calculateTotalHours(clientData) > 0
                            ? _calculateTotalHours(clientData)
                            : _getSafeDouble(clientData['totalHours']),
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
        if (_isMileageItem(item)) continue;
        // Skip items marked to be excluded from total hours (e.g. penalty loadings)
        if (item['excludeFromTotalHours'] == true) continue;

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
              pw.Text(_getSafeString(clientData['billTo']?['name'] ?? '')),
              pw.Text(_getSafeString(clientData['billTo']?['email'] ?? '')),
              pw.Text(_getSafeString(clientData['billTo']?['address'] ?? '')),
              pw.Text(_getSafeString(clientData['billTo']?['phone'] ?? '')),
              if (_getSafeString(clientData['billTo']?['abn'] ?? '')
                      .isNotEmpty &&
                  (_getSafeString(clientData['invoiceType'] ?? '') ==
                          'employee' ||
                      _getSafeString(clientData['invoiceType'] ?? '') ==
                          'client'))
                pw.Text('ABN: ${_getSafeString(clientData['billTo']?['abn'])}'),
              if (_getSafeString(clientData['billTo']?['businessName'] ?? '')
                  .isNotEmpty)
                pw.Text(
                    '(${_getSafeString(clientData['billTo']?['businessName'])})')
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
    final allItems = clientData['items'] as List<dynamic>? ?? [];
    final serviceItems = <Map<String, dynamic>>[];
    final mileageItems = <Map<String, dynamic>>[];

    for (final rawItem in allItems) {
      if (rawItem is! Map) continue;
      final item = Map<String, dynamic>.from(rawItem);
      if (_isMileageItem(item)) {
        mileageItems.add(item);
      } else {
        serviceItems.add(item);
      }
    }

    final widgets = <pw.Widget>[];
    if (serviceItems.isNotEmpty) {
      widgets.add(_buildServiceItemsTable(clientData, serviceItems));
    }
    if (mileageItems.isNotEmpty) {
      if (widgets.isNotEmpty) {
        widgets.add(pw.SizedBox(height: 14));
      }
      widgets.add(_buildMileageItemsTable(mileageItems));
    }
    if (widgets.isEmpty) {
      widgets.add(pw.Text('No invoice items available.'));
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: widgets,
    );
  }

  pw.Widget _buildServiceItemsTable(
    Map<String, dynamic> clientData,
    List<Map<String, dynamic>> items,
  ) {
    final rows = <List<String>>[
      ['Invoice Components', 'Time Worked', 'Hours', 'Rate', 'Total Amount'],
    ];

    for (final item in items) {
      final date = _getSafeString(item['date']);
      final startTime = _getSafeString(item['startTime'] ?? item['timeStart']);
      final endTime = _getSafeString(item['endTime'] ?? item['timeEnd']);
      final clientState = _getSafeString(clientData['clientState'] ?? 'NSW');

      String timeWorked = '';
      if (date.isNotEmpty && startTime.isNotEmpty && endTime.isNotEmpty) {
        final hoursDouble = _getSafeDouble(item['hours']);
        final formattedHours = HoursFormatting.formatDecimalHours(
          hoursDouble,
          minDecimals: 2,
          maxDecimals: 4,
        );
        timeWorked =
            '$date - $startTime to $endTime - $clientState ($formattedHours hours)';
      } else if (date.isNotEmpty) {
        // For non-shift rows without a time range, show date only.
        timeWorked = date;
      }

      final description = _buildItemDescription(item);
      final hoursText = HoursFormatting.formatDecimalHours(
        _getSafeDouble(item['hours']),
        minDecimals: 2,
        maxDecimals: 4,
      );
      final rateText =
          '\$${_getSafeDouble(item['rate'] ?? item['unitPrice']).toStringAsFixed(2)}';
      final amountText = '\$${_getSafeDouble(
        item['amount'] ??
            item['total'] ??
            (_getSafeDouble(item['hours']) * _getSafeDouble(item['rate'])),
      ).toStringAsFixed(2)}';

      rows.add([description, timeWorked, hoursText, rateText, amountText]);
    }

    return pw.Container(
      width: double.infinity,
      child: pw.TableHelper.fromTextArray(
        border: pw.TableBorder.all(color: PdfColors.black),
        headerCount: 1,
        headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
        cellPadding: const pw.EdgeInsets.all(5),
        columnWidths: {
          0: const pw.FlexColumnWidth(3),
          1: const pw.FlexColumnWidth(2),
          2: const pw.FlexColumnWidth(1),
          3: const pw.FlexColumnWidth(1),
          4: const pw.FlexColumnWidth(1),
        },
        cellAlignments: {
          0: pw.Alignment.centerLeft,
          1: pw.Alignment.centerLeft,
          2: pw.Alignment.centerRight,
          3: pw.Alignment.centerRight,
          4: pw.Alignment.centerRight,
        },
        headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
        data: rows,
      ),
    );
  }

  pw.Widget _buildMileageItemsTable(List<Map<String, dynamic>> mileageItems) {
    final rows = <List<String>>[
      ['Mileage', 'Date', 'Distance (km)', 'Rate', 'Total Amount'],
    ];

    for (final item in mileageItems) {
      final description = _buildItemDescription(item);
      final date = _getSafeString(item['date']);
      final distanceKm = _getSafeDouble(
        item['quantity'] ?? item['distance'] ?? item['hours'],
      );
      final rate = _getSafeDouble(item['rate'] ?? item['unitPrice']);
      final amount = _getSafeDouble(
        item['amount'] ?? item['total'] ?? (distanceKm * rate),
      );

      rows.add([
        description,
        date,
        distanceKm.toStringAsFixed(2),
        '\$${rate.toStringAsFixed(2)}',
        '\$${amount.toStringAsFixed(2)}',
      ]);
    }

    return pw.Container(
      width: double.infinity,
      child: pw.TableHelper.fromTextArray(
        border: pw.TableBorder.all(color: PdfColors.black),
        headerCount: 1,
        headerDecoration: const pw.BoxDecoration(color: PdfColors.grey200),
        cellPadding: const pw.EdgeInsets.all(5),
        // Keep identical proportions as service table for visual symmetry.
        columnWidths: {
          0: const pw.FlexColumnWidth(3),
          1: const pw.FlexColumnWidth(2),
          2: const pw.FlexColumnWidth(1),
          3: const pw.FlexColumnWidth(1),
          4: const pw.FlexColumnWidth(1),
        },
        cellAlignments: {
          0: pw.Alignment.centerLeft,
          1: pw.Alignment.centerLeft,
          2: pw.Alignment.centerRight,
          3: pw.Alignment.centerRight,
          4: pw.Alignment.centerRight,
        },
        headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
        data: rows,
      ),
    );
  }

  String _buildItemDescription(Map<String, dynamic> item) {
    if (item['ndisItem'] != null &&
        item['ndisItem'] is Map &&
        item['ndisItem']['itemNumber'] != null &&
        item['ndisItem']['itemName'] != null) {
      final number = _getSafeString(item['ndisItem']['itemNumber']);
      final name = _getSafeString(item['ndisItem']['itemName']);
      return number.isNotEmpty ? '$number $name' : name;
    }
    if (item['ndisItemNumber'] != null && item['ndisItemName'] != null) {
      final number = _getSafeString(item['ndisItemNumber']);
      final name = _getSafeString(item['ndisItemName']);
      return number.isNotEmpty ? '$number $name' : name;
    }
    if (item['itemCode'] != null) {
      final number = _getSafeString(item['itemCode']);
      final name = _getSafeString(
          item['itemName'] ?? item['description'] ?? 'Invoice Item');
      return number.isNotEmpty ? '$number $name' : name;
    }
    return _getSafeString(item['itemName'] ?? item['description'] ?? '');
  }

  bool _isMileageItem(Map<String, dynamic> item) {
    if (item['isMileage'] == true || item['mileageTripId'] != null) {
      return true;
    }

    final itemCode = _getSafeString(item['itemCode'] ?? item['ndisItemNumber'])
        .toUpperCase();
    if (itemCode == 'ALW-VEH' || itemCode == '07_001_0106_8_3') {
      return true;
    }

    final itemName = _getSafeString(
      item['itemName'] ?? item['description'] ?? item['ndisItemName'],
    ).toLowerCase();
    return itemName.contains('mileage') ||
        itemName.contains('vehicle allowance') ||
        itemName.contains('travel with client');
  }

  pw.Widget _buildInvoiceItemsNote(Map<String, dynamic> clientData) {
    final items = clientData['items'] as List<dynamic>? ?? [];
    final hasMileage = items.any(
      (item) => item is Map && _isMileageItem(Map<String, dynamic>.from(item)),
    );
    final note = hasMileage
        ? 'Service hours are shown in the service table. Mileage is shown separately and billed by distance (km).'
        : 'Hours include seconds and are shown up to 4 decimals. Totals are Hours × Rate, rounded to 2 decimals.';
    return pw.Text(
      'Note: $note',
      style: pw.TextStyle(fontSize: 8),
    );
  }

  /// Builds the totals section and resolves bank details for display.
  ///
  /// Bank details resolution strategy:
  /// - If `invoiceType` is `client` or `clientData['useAdminBankDetails']` is true,
  ///   prefer organization bank details.
  /// - If employee bank details are missing, fall back to organization bank details.
  /// - If both employee and organization bank details are unavailable, throws
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

              // Superannuation Display (SCHADS/Employee Invoices)
              if (_getSafeDouble(clientData['superAmount']) > 0) ...[
                pw.SizedBox(height: 5),
                _buildTotalRow(
                    'Superannuation (${_formatPercentage(_getSafeDouble(clientData['superRate']) > 0 ? _getSafeDouble(clientData['superRate']) : 0.12)}%)',
                    _getSafeDouble(clientData['superAmount']),
                    isBold: false),
                pw.Text('(Paid to Super Fund)',
                    style: pw.TextStyle(fontSize: 8, color: PdfColors.grey700)),
              ],
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
  /// - clientData: Map containing client invoice data, `invoiceType`, and
  ///   `useAdminBankDetails` flag.
  ///
  /// Returns:
  /// - Map<String, String> with keys: `bankName`, `accountName`, `bsb`, `accountNumber`.
  ///
  /// Notes:
  /// - Returns placeholder values ('N/A') when neither employee nor organization
  ///   bank details are available so PDF generation can still complete.
  Future<Map<String, String>> _resolveBankDetailsForClient(
      Map<String, dynamic> clientData) async {
    final sharedUtils = SharedPreferencesUtils();
    await sharedUtils.init();

    final String organizationId = _getSafeString(
      clientData['organizationId'] ?? sharedUtils.getString('organizationId'),
    ).trim();

    final inlineInvoice = _extractBankDetailsFromCandidates([
      clientData,
    ]);

    final inlineEmployee = _extractBankDetailsFromCandidates([
      clientData['employeeDetails'],
      clientData['employeeProfile'],
      clientData['providerProfile'],
    ]);

    final inlineOrganization = _extractBankDetailsFromCandidates([
      clientData['organizationProfile'],
      clientData['organizationDetails'],
      clientData['organization'],
      clientData['organizationInfo'],
      clientData['businessProfile'],
      clientData['invoiceProfile'],
    ]);

    final inlineAdmin = _extractBankDetailsFromCandidates([
      clientData['adminProfile'],
    ]);

    final String employeeEmail = _extractEmployeeEmail(clientData);
    final invoiceType = _getSafeString(clientData['invoiceType']).toLowerCase();
    final bool preferOrganization =
        invoiceType == 'client' || clientData['useAdminBankDetails'] == true;

    if (inlineInvoice != null) {
      return inlineInvoice;
    }

    if (preferOrganization) {
      if (inlineOrganization != null) {
        return inlineOrganization;
      }

      final fetchedOrg = await _fetchOrganizationBankDetails(
        organizationId: organizationId,
      );
      if (fetchedOrg != null) {
        return fetchedOrg;
      }

      if (inlineEmployee != null) {
        return inlineEmployee;
      }

      final fetchedEmployee = await _fetchBankDetailsByEmail(
        userEmail: employeeEmail,
        organizationId: organizationId,
      );
      if (fetchedEmployee != null) {
        return fetchedEmployee;
      }

      if (inlineAdmin != null) {
        return inlineAdmin;
      }
    } else {
      if (inlineEmployee != null) {
        return inlineEmployee;
      }

      final fetchedEmployee = await _fetchBankDetailsByEmail(
        userEmail: employeeEmail,
        organizationId: organizationId,
      );
      if (fetchedEmployee != null) {
        return fetchedEmployee;
      }

      if (inlineOrganization != null) {
        return inlineOrganization;
      }

      final fetchedOrg = await _fetchOrganizationBankDetails(
        organizationId: organizationId,
      );
      if (fetchedOrg != null) {
        return fetchedOrg;
      }

      if (inlineAdmin != null) {
        return inlineAdmin;
      }
    }

    // Do not block PDF rendering when bank details are unavailable in client portal.
    debugPrint(
        'Bank details unavailable for invoice PDF. Rendering with placeholders.');
    return const {
      'bankName': 'N/A',
      'accountName': 'N/A',
      'bsb': 'N/A',
      'accountNumber': 'N/A',
    };
  }

  Future<Map<String, String>?> _fetchOrganizationBankDetails({
    required String organizationId,
  }) async {
    if (organizationId.trim().isEmpty) {
      return null;
    }

    try {
      final resp = await _api.getOrganizationDetails(organizationId.trim());
      if (resp['success'] != true) {
        return null;
      }

      final rawOrg = resp['organization'] ?? resp['data'];
      if (rawOrg is! Map) {
        return null;
      }

      final Map<String, dynamic> orgMap = Map<String, dynamic>.from(rawOrg);
      final nestedOrg = orgMap['organization'];
      final Map<String, dynamic> resolvedOrg =
          nestedOrg is Map ? Map<String, dynamic>.from(nestedOrg) : orgMap;

      return _extractBankDetailsFromCandidates([resolvedOrg]);
    } catch (e) {
      debugPrint('Failed to fetch organization bank details: $e');
      return null;
    }
  }

  Future<Map<String, String>?> _fetchBankDetailsByEmail({
    required String userEmail,
    required String organizationId,
  }) async {
    if (userEmail.trim().isEmpty || organizationId.trim().isEmpty) {
      return null;
    }

    try {
      final resp = await _api.getBankDetailsForUserEmail(
        userEmail.trim(),
        organizationId.trim(),
      );
      if (resp['success'] != true || resp['data'] is! Map) {
        return null;
      }

      return _extractBankDetailsFromCandidates([resp['data']]);
    } catch (e) {
      debugPrint('Failed to fetch bank details for $userEmail: $e');
      return null;
    }
  }

  Map<String, String>? _extractBankDetailsFromCandidates(
      List<dynamic> sources) {
    final List<Map<String, dynamic>> maps = [];
    for (final source in sources) {
      if (source is Map) {
        final map = Map<String, dynamic>.from(source);
        maps.add(map);
        for (final nestedKey in const [
          'bankDetails',
          'paymentDetails',
          'bank',
          'billing',
          'invoiceProfile',
        ]) {
          final nested = map[nestedKey];
          if (nested is Map) {
            maps.add(Map<String, dynamic>.from(nested));
          }
        }
      }
    }

    for (final map in maps) {
      final bankName = _getSafeString(
        map['bankName'] ?? map['bank'] ?? map['bank_name'],
      ).trim();
      final accountName = _getSafeString(
        map['accountName'] ??
            map['accountHolderName'] ??
            map['account_holder_name'],
      ).trim();
      final bsb = _getSafeString(
        map['bsb'] ?? map['BSB'] ?? map['routingNumber'],
      ).trim();
      final accountNumber = _getSafeString(
        map['accountNumber'] ?? map['accountNo'] ?? map['account_number'],
      ).trim();

      final isComplete = bankName.isNotEmpty &&
          accountName.isNotEmpty &&
          bsb.isNotEmpty &&
          accountNumber.isNotEmpty;

      if (isComplete) {
        return {
          'bankName': bankName,
          'accountName': accountName,
          'bsb': bsb,
          'accountNumber': accountNumber,
        };
      }
    }

    return null;
  }

  String _extractEmployeeEmail(Map<String, dynamic> clientData) {
    final employeeDetails = clientData['employeeDetails'];
    final employee = clientData['employee'];
    final candidates = [
      clientData['employeeEmail'],
      clientData['workerEmail'],
      clientData['providerEmail'],
      if (employeeDetails is Map) employeeDetails['email'],
      if (employeeDetails is Map) employeeDetails['userEmail'],
      if (employee is Map) employee['email'],
      if (employee is Map) employee['userEmail'],
    ];

    for (final candidate in candidates) {
      final value = _getSafeString(candidate).trim();
      if (value.contains('@')) {
        return value;
      }
    }

    return '';
  }

  String _extractAdminEmail(Map<String, dynamic> clientData) {
    final adminProfile = clientData['adminProfile'];
    final candidates = [
      clientData['adminEmail'],
      clientData['ownerEmail'],
      if (adminProfile is Map) adminProfile['email'],
      if (adminProfile is Map) adminProfile['userEmail'],
      if (adminProfile is Map) adminProfile['adminEmail'],
      if (adminProfile is Map) adminProfile['ownerEmail'],
    ];

    for (final candidate in candidates) {
      final value = _getSafeString(candidate).trim();
      if (value.contains('@')) {
        return value;
      }
    }

    return '';
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

    String? resolveToHttpUrl(String value) {
      final resolved = AppConfig.resolveResourceUrl(value);
      if (resolved.startsWith('http://') || resolved.startsWith('https://')) {
        return resolved;
      }
      return null;
    }

    String buildDownloadUrl(String originalUrl) {
      try {
        return AppConfig.buildFilesDownloadUrl(originalUrl);
      } catch (e) {
        debugPrint('DEBUG_RECEIPT_LINKS: Failed to build download URL: $e');
        return originalUrl;
      }
    }

    // Add from receiptFiles (preferred)
    for (var file in receiptFiles) {
      if (file is String && file.trim().isNotEmpty) {
        final cleanUrl = file.trim().replaceAll('`', '');
        final fullUrl = resolveToHttpUrl(cleanUrl);
        if (fullUrl != null) {
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
        final fullUrl = resolveToHttpUrl(cleanUrl);
        if (fullUrl != null) {
          debugPrint(
              'DEBUG_RECEIPT_LINKS: Adding URL from receiptPhotos: $fullUrl');
          allReceiptUrls.add(fullUrl);
        }
      }
    }

    // Add from receiptUrl (backward compatibility)
    if (receiptUrl != null && receiptUrl.trim().isNotEmpty) {
      final cleanUrl = receiptUrl.trim().replaceAll('`', '');
      final fullUrl = resolveToHttpUrl(cleanUrl);
      if (fullUrl != null) {
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
          destination: buildDownloadUrl(allReceiptUrls.first),
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
              destination: buildDownloadUrl(url),
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
      final response = await _api.getRawUrl(
        url,
        timeout: const Duration(seconds: 30),
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

    String buildDownloadUrl(String originalUrl) {
      try {
        return AppConfig.buildFilesDownloadUrl(originalUrl);
      } catch (_) {
        return originalUrl;
      }
    }

    // Add photo download links
    if (uploadedPhotoUrls != null && uploadedPhotoUrls.isNotEmpty) {
      widgets.addAll([
        pw.Text('Photo Attachments:',
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 5),
      ]);

      for (int i = 0; i < uploadedPhotoUrls.length; i++) {
        final resolvedUrl = AppConfig.resolveResourceUrl(uploadedPhotoUrls[i]);
        if (!(resolvedUrl.startsWith('http://') ||
            resolvedUrl.startsWith('https://'))) {
          continue;
        }
        widgets.add(
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 3),
            child: pw.UrlLink(
              destination: buildDownloadUrl(resolvedUrl),
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
        final resolvedUrl =
            AppConfig.resolveResourceUrl(uploadedAdditionalFileUrls[i]);
        if (!(resolvedUrl.startsWith('http://') ||
            resolvedUrl.startsWith('https://'))) {
          continue;
        }
        widgets.add(
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 3),
            child: pw.UrlLink(
              destination: buildDownloadUrl(resolvedUrl),
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
