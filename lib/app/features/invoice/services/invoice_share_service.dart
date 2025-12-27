
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:carenest/app/features/invoice/models/invoice_list_model.dart';
import 'package:carenest/app/features/invoice/services/invoice_management_service.dart';
import 'package:carenest/app/features/invoice/services/invoice_pdf_generator_service.dart';
import 'package:carenest/app/features/invoice/services/invoice_number_generator_service.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';

import 'package:shared_preferences/shared_preferences.dart';

class InvoiceShareService {
  final InvoiceManagementService _invoiceService;
  final InvoicePdfGenerator _pdfGenerator = InvoicePdfGenerator();

  InvoiceShareService(this._invoiceService);

  /// Share invoice with multiple options
  Future<Map<String, dynamic>> shareInvoice({
    required InvoiceListModel invoice,
    required String organizationId,
    ShareMethod method = ShareMethod.link,
  }) async {
    try {
      switch (method) {
        case ShareMethod.link:
          return await _shareAsLink(invoice, organizationId);
        case ShareMethod.pdf:
          return await _shareAsPDF(invoice, organizationId);
        case ShareMethod.email:
          return await _shareViaEmail(invoice, organizationId);
        case ShareMethod.whatsapp:
          return await _shareViaWhatsApp(invoice, organizationId);
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error sharing invoice: ${e.toString()}',
      };
    }
  }

  /// Share invoice as a shareable link
  Future<Map<String, dynamic>> _shareAsLink(
    InvoiceListModel invoice,
    String organizationId,
  ) async {
    try {
      // Call the backend to generate/get shareable link
      final result = await _invoiceService.shareInvoice(
        invoiceId: invoice.id,
        organizationId: organizationId,
      );

      if (result['success'] == true && result['shareableLink'] != null) {
        final shareableLink = result['shareableLink'] as String;

        await Share.share(
          'Invoice ${invoice.invoiceNumber}\n'
          'Amount: \$${invoice.totalAmount.toStringAsFixed(2)}\n'
          'Due Date: ${invoice.dueDate.toString().split(' ')[0]}\n\n'
          'View invoice: $shareableLink',
          subject: 'Invoice ${invoice.invoiceNumber}',
        );

        return {
          'success': true,
          'message': 'Invoice shared successfully',
          'shareableLink': shareableLink,
        };
      } else {
        return {
          'success': false,
          'message': result['message'] ?? 'Failed to generate shareable link',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error sharing invoice link: ${e.toString()}',
      };
    }
  }

  /// Share invoice as PDF
  Future<Map<String, dynamic>> _shareAsPDF(
    InvoiceListModel invoice,
    String organizationId,
  ) async {
    try {
      // Check storage permission
      final storagePermission = await _checkStoragePermission();
      if (!storagePermission) {
        return {
          'success': false,
          'message': 'Storage permission required to share PDF',
        };
      }

      // Check if PDF path exists in invoice metadata
      if (invoice.pdfPath == null || invoice.pdfPath!.isEmpty) {
        return {
          'success': false,
          'message': 'PDF not available for this invoice',
        };
      }

      // Check if the PDF file exists on device
      final pdfFile = File(invoice.pdfPath!);
      if (!await pdfFile.exists()) {
        // Try to regenerate PDF from backend data
        debugPrint('PDF file not found locally, attempting to regenerate...');
        final regenerationResult = await _regeneratePdfFromBackend(
          invoice,
          organizationId,
        );

        if (!regenerationResult['success']) {
          return {
            'success': false,
            'message': regenerationResult['message'] ??
                'PDF file not found on device and could not be regenerated',
          };
        }

        // Update the PDF file path with the newly generated one
        final newPdfPath = regenerationResult['pdfPath'];
        if (newPdfPath != null) {
          final newPdfFile = File(newPdfPath);
          if (await newPdfFile.exists()) {
            // Use the newly generated PDF
            await Share.shareXFiles(
              [XFile(newPdfFile.path)],
              text:
                  'Invoice ${invoice.invoiceNumber} - \$${invoice.totalAmount.toStringAsFixed(2)}',
              subject: 'Invoice ${invoice.invoiceNumber}',
            );

            return {
              'success': true,
              'message': 'Invoice PDF regenerated and shared successfully',
              'filePath': newPdfFile.path,
              'regenerated': true,
            };
          }
        }

        return {
          'success': false,
          'message': 'PDF file not found on device and regeneration failed',
        };
      }

      // Share the PDF file directly
      await Share.shareXFiles(
        [XFile(pdfFile.path)],
        text:
            'Invoice ${invoice.invoiceNumber} - \$${invoice.totalAmount.toStringAsFixed(2)}',
        subject: 'Invoice ${invoice.invoiceNumber}',
      );

      return {
        'success': true,
        'message': 'Invoice PDF shared successfully',
        'filePath': pdfFile.path,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error sharing invoice PDF: ${e.toString()}',
      };
    }
  }

  /// Share invoice via email
  Future<Map<String, dynamic>> _shareViaEmail(
    InvoiceListModel invoice,
    String organizationId,
  ) async {
    try {
      // Get shareable link first
      final linkResult = await _shareAsLink(invoice, organizationId);

      if (linkResult['success'] == true) {
        final shareableLink = linkResult['shareableLink'] as String;

        // Compose email content
        final emailSubject = 'Invoice ${invoice.invoiceNumber}';
        final emailBody = '''
Dear ${invoice.clientName},

Please find your invoice details below:

Invoice Number: ${invoice.invoiceNumber}
Amount: \$${invoice.totalAmount.toStringAsFixed(2)}
Due Date: ${invoice.dueDate.toString().split(' ')[0]}
Status: ${invoice.status}

You can view and download your invoice using this link:
$shareableLink

Thank you for your business!

Best regards,
Your Invoice Team
''';

        // Use mailto URL scheme
        await Share.share(
          emailBody,
          subject: emailSubject,
        );

        return {
          'success': true,
          'message': 'Email sharing initiated',
          'shareableLink': shareableLink,
        };
      } else {
        return linkResult;
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error sharing via email: ${e.toString()}',
      };
    }
  }

  /// Share invoice via WhatsApp
  Future<Map<String, dynamic>> _shareViaWhatsApp(
    InvoiceListModel invoice,
    String organizationId,
  ) async {
    try {
      // Get shareable link first
      final linkResult = await _shareAsLink(invoice, organizationId);

      if (linkResult['success'] == true) {
        final shareableLink = linkResult['shareableLink'] as String;

        // Compose WhatsApp message
        final message = '''
🧾 *Invoice ${invoice.invoiceNumber}*

💰 Amount: \$${invoice.totalAmount.toStringAsFixed(2)}
📅 Due Date: ${invoice.dueDate.toString().split(' ')[0]}
📊 Status: ${invoice.status}

👆 View invoice: $shareableLink
''';

        await Share.share(
          message,
          subject: 'Invoice ${invoice.invoiceNumber}',
        );

        return {
          'success': true,
          'message': 'WhatsApp sharing initiated',
          'shareableLink': shareableLink,
        };
      } else {
        return linkResult;
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error sharing via WhatsApp: ${e.toString()}',
      };
    }
  }

  // Note: PDF files are now read directly from device storage in _shareAsPDF method
  // No need to call backend for PDF data

  /// Generate PDF for viewing (public method)
  Future<Map<String, dynamic>> generatePdfForViewing(
    InvoiceListModel invoice,
    String organizationId,
  ) async {
    try {
      // Check if PDF already exists locally using the same filename generation logic
      final output = await getApplicationDocumentsDirectory();
      final expectedFileName =
          InvoiceNumberGeneratorService.generateFileName(invoice.invoiceNumber);
      final expectedFilePath = '${output.path}/$expectedFileName';

      debugPrint('Checking for existing PDF at: $expectedFilePath');
      final file = File(expectedFilePath);

      if (await file.exists()) {
        debugPrint('PDF file found locally at: $expectedFilePath');
        return {
          'success': true,
          'message': 'PDF found locally',
          'pdfPath': expectedFilePath,
          'regenerated': false,
        };
      } else {
        debugPrint('No existing PDF found, will regenerate');
      }

      // If no local PDF file found, regenerate from backend
      debugPrint('Regenerating PDF from backend data...');
      return await _regeneratePdfFromBackend(invoice, organizationId);
    } catch (e) {
      return {
        'success': false,
        'message': 'Error checking for existing PDF: ${e.toString()}',
      };
    }
  }

  /// Regenerate PDF from backend invoice data
  Future<Map<String, dynamic>> _regeneratePdfFromBackend(
    InvoiceListModel invoice,
    String organizationId,
  ) async {
    try {
      debugPrint('Fetching invoice details from backend for regeneration...');

      // Fetch full invoice data from backend
      final invoiceDetailsResult = await _invoiceService.getInvoiceDetails(
        invoiceId: invoice.id,
        organizationId: organizationId,
      );

      if (!invoiceDetailsResult['success']) {
        return {
          'success': false,
          'message':
              'Failed to fetch invoice details from backend: ${invoiceDetailsResult['message']}',
        };
      }

      final invoiceData = invoiceDetailsResult['data'];
      if (invoiceData == null) {
        return {
          'success': false,
          'message': 'No invoice data received from backend',
        };
      }

      debugPrint('Invoice data fetched, generating PDF...');

      // Check if we have stored calculated payload data
      final calculatedPayloadData = invoiceData['calculatedPayloadData'];
      final pdfGenerationParams = invoiceData['pdfGenerationParams'] ?? {};
      final metadata = invoiceData['metadata'] ?? {};

      Map<String, dynamic> pdfGenerationData;

      if (calculatedPayloadData != null) {
        // Use stored calculated payload data for accurate PDF regeneration
        debugPrint('Using stored calculated payload data for PDF regeneration');
        debugPrint(
            'calculatedPayloadData structure: ${calculatedPayloadData.keys}');

        // The calculatedPayloadData contains the complete structure with clients array
        pdfGenerationData = Map<String, dynamic>.from(calculatedPayloadData);

        // Ensure the first client has the correct invoice number and period dates from the current invoice
        if (pdfGenerationData['clients'] != null &&
            (pdfGenerationData['clients'] as List).isNotEmpty) {
          final clientData =
              pdfGenerationData['clients'][0] as Map<String, dynamic>;
          clientData['invoiceNumber'] =
              invoice.invoiceNumber; // Use the actual invoice number

          // Ensure period dates are included in the client data
          clientData['startDate'] =
              clientData['startDate'] ?? invoiceData['startDate'] ?? '';
          clientData['endDate'] =
              clientData['endDate'] ?? invoiceData['endDate'] ?? '';

          debugPrint('Updated invoice number to: ${invoice.invoiceNumber}');
          debugPrint(
              'Period dates - Start: ${clientData['startDate']}, End: ${clientData['endDate']}');

          // Debug: Print the complete client data structure to verify all fields are present
          debugPrint('Client data keys: ${clientData.keys}');
          debugPrint('employeeName: ${clientData['employeeName']}');
          debugPrint('providerABN: ${clientData['providerABN']}');
          debugPrint('clientFirstName: ${clientData['clientFirstName']}');
          debugPrint('clientLastName: ${clientData['clientLastName']}');
          debugPrint('clientAddress: ${clientData['clientAddress']}');
          debugPrint(
              'expenses count: ${(clientData['expenses'] as List?)?.length ?? 0}');

          // Enrich missing provider details (employeeName, providerABN) when using calculated payload
          try {
            String employeeName = (clientData['employeeName'] ?? '').toString();
            String providerABN = (clientData['providerABN'] ?? '').toString();
            String employeeEmail = (clientData['employeeEmail'] ??
                    invoiceData['employeeEmail'] ??
                    metadata['employeeEmail'] ??
                    '')
                .toString();
            if (employeeEmail.isEmpty) {
              try {
                final sp = SharedPreferencesUtils();
                await sp.init();
                final spEmail = sp.getUserEmail() ??
                    await sp.getUserEmailFromSharedPreferences() ??
                    '';
                if (spEmail.isNotEmpty) {
                  employeeEmail = spEmail;
                }
              } catch (_) {}
            }

            // First, try to fill from other available sources before calling APIs
            if (employeeName.trim().isEmpty ||
                employeeName == 'Provider Name') {
              final invName = (invoiceData['employeeName'] ?? '').toString();
              final metaName = (metadata['providerName'] ?? '').toString();
              final ed = clientData['employeeDetails'] as Map<String, dynamic>?;
              final edName = ((ed?['name']) ??
                      ('${(ed?['firstName'] ?? '')} ${(ed?['lastName'] ?? '')}'))
                  .toString()
                  .trim();

              if (invName.isNotEmpty) employeeName = invName;
              if (employeeName.trim().isEmpty && metaName.isNotEmpty) {
                employeeName = metaName;
              }
              if (employeeName.trim().isEmpty && edName.isNotEmpty) {
                employeeName = edName;
              }
            }

            if (providerABN.trim().isEmpty || providerABN == 'N/A') {
              final invAbn = (invoiceData['providerABN'] ?? '').toString();
              final metaAbn = (metadata['providerABN'] ?? '').toString();
              final ed = clientData['employeeDetails'] as Map<String, dynamic>?;
              final edAbn = ((ed?['abn']) ?? (ed?['providerABN']) ?? '')
                  .toString()
                  .trim();

              if (invAbn.isNotEmpty && invAbn != 'N/A') providerABN = invAbn;
              if ((providerABN.trim().isEmpty || providerABN == 'N/A') &&
                  metaAbn.isNotEmpty &&
                  metaAbn != 'N/A') {
                providerABN = metaAbn;
              }
              if ((providerABN.trim().isEmpty || providerABN == 'N/A') &&
                  edAbn.isNotEmpty &&
                  edAbn != 'N/A') {
                providerABN = edAbn;
              }
            }

            // Ensure employeeEmail is present in clientData and metadata
            if (employeeEmail.isNotEmpty) {
              clientData['employeeEmail'] = employeeEmail;
              pdfGenerationData['metadata'] = {
                ...(pdfGenerationData['metadata'] ?? {}),
                'employeeEmail': employeeEmail,
              };
            }

            // Apply any found values immediately
            if (employeeName.trim().isNotEmpty &&
                employeeName != 'Provider Name') {
              clientData['employeeName'] = employeeName;
            }
            if (providerABN.trim().isNotEmpty && providerABN != 'N/A') {
              clientData['providerABN'] = providerABN;
            }
            if ((pdfGenerationData['metadata'] is Map)) {
              pdfGenerationData['metadata'] = {
                ...(pdfGenerationData['metadata'] as Map),
                if (employeeName.trim().isNotEmpty &&
                    employeeName != 'Provider Name')
                  'providerName': employeeName,
                if (providerABN.trim().isNotEmpty && providerABN != 'N/A')
                  'providerABN': providerABN,
              };
            }

            // If still missing or generic, fall back to fetching fresh employee details
            if (employeeName.trim().isEmpty ||
                employeeName == 'Provider Name' ||
                providerABN.trim().isEmpty ||
                providerABN == 'N/A') {
              debugPrint(
                  'Provider details missing or generic in calculated payload, fetching fresh employee details...');
              final apiMethod = ApiMethod();
              String fetchedEmail = employeeEmail.isNotEmpty
                  ? employeeEmail
                  : (invoiceData['employeeEmail'] ??
                          metadata['employeeEmail'] ??
                          '')
                      .toString();
              if (fetchedEmail.isEmpty) {
                try {
                  final sp = SharedPreferencesUtils();
                  await sp.init();
                  final spEmail = sp.getUserEmail() ??
                      await sp.getUserEmailFromSharedPreferences() ??
                      '';
                  if (spEmail.isNotEmpty) {
                    fetchedEmail = spEmail;
                  }
                } catch (_) {}
              }
              if (fetchedEmail.isNotEmpty) {
                final freshEmployeeDetails =
                    await apiMethod.checkEmail(fetchedEmail);
                if (freshEmployeeDetails != null) {
                  final userData = freshEmployeeDetails;
                  employeeName = userData['name'] ??
                      '${userData['firstName'] ?? ''} ${userData['lastName'] ?? ''}'
                          .trim();
                  if (employeeName.trim().isEmpty) {
                    employeeName = userData['firstName'] ?? employeeName;
                  }
                  providerABN =
                      userData['abn'] ?? userData['ABN'] ?? providerABN;

                  clientData['employeeName'] = employeeName;
                  clientData['providerABN'] = providerABN;
                  clientData['employeeEmail'] = fetchedEmail;

                  // Keep metadata in sync for downstream usage
                  pdfGenerationData['metadata'] = {
                    ...(pdfGenerationData['metadata'] ?? {}),
                    'providerName': employeeName,
                    'providerABN': providerABN,
                    'employeeEmail': fetchedEmail,
                  };

                  debugPrint(
                      'Updated provider details - Name: $employeeName, ABN: $providerABN');
                }
              }
            }
          } catch (e) {
            debugPrint(
                'Failed to enrich employee details in calculated payload branch: $e');
          }

          // Enrich missing client address/phone/business details when using calculated payload
          try {
            String clientAddress =
                (clientData['clientAddress'] ?? '').toString();
            String clientCity = (clientData['clientCity'] ?? '').toString();
            String clientState = (clientData['clientState'] ?? '').toString();
            String clientZip = (clientData['clientZip'] ?? '').toString();
            String clientPhone = (clientData['clientPhone'] ?? '').toString();
            String businessName = (clientData['businessName'] ?? '').toString();

            if (clientAddress.trim().isEmpty &&
                clientCity.trim().isEmpty &&
                clientState.trim().isEmpty) {
              debugPrint(
                  'Client address fields missing in calculated payload, fetching fresh client details...');
              final apiMethod = ApiMethod();
              final clientEmail = (clientData['clientEmail'] ??
                      invoiceData['clientEmail'] ??
                      invoice.clientEmail ??
                      '')
                  .toString();
              if (clientEmail.isNotEmpty) {
                final freshClientDetails =
                    await apiMethod.getClientDetails(clientEmail);
                if (freshClientDetails != null) {
                  final c =
                      freshClientDetails['clientDetails'] ?? freshClientDetails;
                  clientData['clientAddress'] =
                      c['clientAddress'] ?? clientAddress;
                  clientData['clientCity'] = c['clientCity'] ?? clientCity;
                  clientData['clientState'] = c['clientState'] ?? clientState;
                  clientData['clientZip'] = c['clientZip'] ?? clientZip;
                  clientData['clientPhone'] = c['clientPhone'] ?? clientPhone;
                  clientData['businessName'] =
                      c['businessName'] ?? businessName;

                  debugPrint(
                      'Updated client details - Address: ${clientData['clientAddress']}, City: ${clientData['clientCity']}, State: ${clientData['clientState']}, Zip: ${clientData['clientZip']}, Phone: ${clientData['clientPhone']}, Business: ${clientData['businessName']}');
                }
              }
            }
          } catch (e) {
            debugPrint(
                'Failed to enrich client details in calculated payload branch: $e');
          }
        }
      } else {
        // Fallback to reconstructing data from stored invoice data (legacy support)
        debugPrint(
            'No calculated payload data found, reconstructing from stored invoice data');

        // Extract basic invoice data
        final lineItems = invoiceData['lineItems'] ?? [];
        final expenses = invoiceData['expenses'] ?? [];
        final financialSummary = invoiceData['financialSummary'] ?? {};
        final metadata = invoiceData['metadata'] ?? {};

        // Determine employee email with fallbacks (invoiceData -> metadata -> SharedPreferences)
        String employeeEmailForMeta =
            (invoiceData['employeeEmail'] ?? metadata['employeeEmail'] ?? '')
                .toString();
        if (employeeEmailForMeta.isEmpty) {
          try {
            final sp = SharedPreferencesUtils();
            await sp.init();
            final spEmail = sp.getUserEmail() ??
                await sp.getUserEmailFromSharedPreferences() ??
                '';
            if (spEmail.isNotEmpty) {
              employeeEmailForMeta = spEmail;
            }
          } catch (_) {}
        }

        // Build complete client data structure that original PDF generator expects
        // First, check if we need to fetch fresh client details for missing address information
        String clientAddress = invoiceData['clientAddress'] ?? '';
        String clientCity = invoiceData['clientCity'] ?? '';
        String clientState = invoiceData['clientState'] ?? '';
        String clientZip = invoiceData['clientZip'] ?? '';
        String clientPhone = invoiceData['clientPhone'] ?? '';
        String businessName = invoiceData['businessName'] ?? '';

        // If address fields are missing, try to fetch fresh client details
        if (clientAddress.trim().isEmpty &&
            clientCity.trim().isEmpty &&
            clientState.trim().isEmpty) {
          debugPrint(
              'Address fields are empty, fetching fresh client details...');
          try {
            final apiMethod = ApiMethod();
            final clientEmail =
                invoiceData['clientEmail'] ?? invoice.clientEmail;
            if (clientEmail.isNotEmpty) {
              final freshClientDetails =
                  await apiMethod.getClientDetails(clientEmail);
              if (freshClientDetails != null) {
                // Handle the response structure: { statusCode: 200, message: "...", clientDetails: {...} }
                final clientData =
                    freshClientDetails['clientDetails'] ?? freshClientDetails;
                clientAddress = clientData['clientAddress'] ?? clientAddress;
                clientCity = clientData['clientCity'] ?? clientCity;
                clientState = clientData['clientState'] ?? clientState;
                clientZip = clientData['clientZip'] ?? clientZip;
                clientPhone = clientData['clientPhone'] ?? clientPhone;
                businessName = clientData['businessName'] ?? businessName;
                debugPrint(
                    'Fresh client details fetched - Address: $clientAddress, City: $clientCity, State: $clientState, Zip: $clientZip, Phone: $clientPhone, Business: $businessName');
              }
            }
          } catch (e) {
            debugPrint('Failed to fetch fresh client details: $e');
          }
        }

        // Check if we need to fetch fresh employee details for missing provider information
        String employeeName =
            invoiceData['employeeName'] ?? metadata['providerName'] ?? '';
        String providerABN =
            invoiceData['providerABN'] ?? metadata['providerABN'] ?? '';

        // If provider details are missing, try to fetch fresh employee details
        if (employeeName.trim().isEmpty ||
            employeeName == 'Provider Name' ||
            providerABN.trim().isEmpty ||
            providerABN == 'N/A') {
          debugPrint(
              'Provider details are missing, fetching fresh employee details...');
          try {
            final apiMethod = ApiMethod();
            String employeeEmail = employeeEmailForMeta;
            if (employeeEmail.isNotEmpty) {
              final freshEmployeeDetails =
                  await apiMethod.checkEmail(employeeEmail);
              if (freshEmployeeDetails != null) {
                // Handle the response structure: { statusCode: 200, message: "...", firstName: "...", lastName: "...", abn: "...", name: "..." }
                final userData = freshEmployeeDetails;
                employeeName = userData['name'] ??
                    '${userData['firstName'] ?? ''} ${userData['lastName'] ?? ''}'
                        .trim();
                if (employeeName.trim().isEmpty) {
                  employeeName = userData['firstName'] ?? employeeName;
                }
                providerABN = userData['abn'] ?? userData['ABN'] ?? providerABN;
                debugPrint(
                    'Fresh employee details fetched - Name: $employeeName, ABN: $providerABN');
              }
            }
          } catch (e) {
            debugPrint('Failed to fetch fresh employee details: $e');
          }
        }

        final clientData = {
          // Provider details (use fetched fresh data or fallback to stored data)
          'employeeName': employeeName,
          'providerABN': providerABN,
          'employeeEmail': employeeEmailForMeta,

          // Client details (use fresh data if available, otherwise fallback to stored data)
          'clientFirstName': invoiceData['clientFirstName'] ?? '',
          'clientLastName': invoiceData['clientLastName'] ?? '',
          'clientName': invoiceData['clientName'] ?? invoice.clientName,
          'clientEmail': invoiceData['clientEmail'] ?? invoice.clientEmail,
          'clientAddress': clientAddress,
          'clientCity': clientCity,
          'clientState': clientState,
          'clientZip': clientZip,
          'clientPhone': clientPhone,
          'businessName': businessName,

          // Period dates (use stored data from calculated payload)
          'startDate': invoiceData['startDate'] ?? '',
          'endDate': invoiceData['endDate'] ?? '',

          // Invoice metadata (required by _buildInvoiceHeader and _buildBillingInfo)
          'invoiceNumber': invoice
              .invoiceNumber, // Always use the actual invoice number from the invoice object
          'jobTitle': invoiceData['jobTitle'] ?? 'Personal Care Assistance',

          // Financial data (match PDF generator expectations)
          'subtotal': financialSummary['subtotal'] ?? 0.0,
          'tax': financialSummary['taxAmount'] ??
              0.0, // PDF generator expects 'tax' not 'taxAmount'
          'total': financialSummary['totalAmount'] ?? invoice.totalAmount,
          'totalHours': invoiceData['totalHours'] ?? '0.00',

          // Breakdown totals for expenses (required by _buildInvoiceTotal)
          'itemsSubtotal': financialSummary['itemsSubtotal'] ??
              financialSummary['subtotal'] ??
              0.0,
          'expensesTotal': financialSummary['expensesTotal'] ?? 0.0,

          // Line items and expenses (ensure expenses are properly formatted)
          'items': lineItems,
          'expenses': expenses.map((expense) {
            // Ensure expense has all required fields for PDF generation
            if (expense is Map<String, dynamic>) {
              return {
                ...expense,
                'date': expense['date'] ?? expense['expenseDate'] ?? '',
                'category': expense['category'] ?? 'Other',
                'totalAmount': expense['totalAmount'] ??
                    expense['amount'] ??
                    expense['unitCost'] ??
                    0.0,
                'description': expense['description'] ?? 'Expense',
                'receiptFiles': expense['receiptFiles'] ?? [],
                'receiptPhotos': expense['receiptPhotos'] ?? [],
                'receiptUrl': expense['receiptUrl'],
              };
            }
            return expense;
          }).toList(),

          // Additional metadata
          'clientId': invoiceData['clientId'] ?? '',
        };

        // Debug: Print the reconstructed client data to verify all fields are present
        debugPrint('Reconstructed client data keys: ${clientData.keys}');
        debugPrint('employeeName: ${clientData['employeeName']}');
        debugPrint('providerABN: ${clientData['providerABN']}');
        debugPrint('clientFirstName: ${clientData['clientFirstName']}');
        debugPrint('clientLastName: ${clientData['clientLastName']}');
        debugPrint('clientAddress: ${clientData['clientAddress']}');
        debugPrint(
            'expenses count: ${(clientData['expenses'] as List?)?.length ?? 0}');
        debugPrint(
            'items count: ${(clientData['items'] as List?)?.length ?? 0}');

        pdfGenerationData = {
          'clients': [clientData],
          'metadata': {
            ...metadata,
            'providerName': employeeName,
            'providerABN': providerABN,
            if (employeeEmailForMeta.isNotEmpty)
              'employeeEmail': employeeEmailForMeta,
          },
        };
      }

      // Generate PDF using the PDF generator service with stored parameters
      // Fix: Only show tax if it was originally applied (don't default to true)
      // Determine showTax with robust fallbacks (pdfGenerationParams -> calculatedPayloadData -> metadata -> infer from totals)
      bool shouldShowTax = false;
      final dynamic showTaxSource = pdfGenerationParams['showTax'];
      if (showTaxSource is bool) {
        shouldShowTax = showTaxSource;
      } else if (showTaxSource is String) {
        shouldShowTax =
            showTaxSource.toLowerCase() == 'true' || showTaxSource == '1';
      } else if (showTaxSource is num) {
        shouldShowTax = showTaxSource != 0;
      } else {
        // Try calculated payload client flags
        final List clientsList =
            (calculatedPayloadData?['clients'] as List?) ?? [];
        if (clientsList.isNotEmpty &&
            clientsList.first is Map<String, dynamic>) {
          final c = clientsList.first as Map<String, dynamic>;
          final dynamic persistedFlag =
              c['applyTax'] ?? c['showTax'] ?? c['includesTax'];
          if (persistedFlag is bool) {
            shouldShowTax = persistedFlag;
          } else if (persistedFlag is String) {
            shouldShowTax =
                persistedFlag.toLowerCase() == 'true' || persistedFlag == '1';
          } else if (persistedFlag is num) {
            shouldShowTax = persistedFlag != 0;
          }
          // Default-off policy: do NOT infer showTax from totals when no explicit flag is present
        }
        // Try metadata includesTax as another fallback
        if (!shouldShowTax) {
          final dynamic metaIncludesTax =
              (invoiceData['metadata'] ?? {})['includesTax'];
          if (metaIncludesTax is bool) {
            shouldShowTax = metaIncludesTax;
          } else if (metaIncludesTax is String) {
            shouldShowTax = metaIncludesTax.toLowerCase() == 'true' ||
                metaIncludesTax == '1';
          } else if (metaIncludesTax is num) {
            shouldShowTax = metaIncludesTax != 0;
          }
        }
      }

      // Determine taxRate with robust fallbacks (pdfGenerationParams -> calculatedPayloadData -> metadata -> derive from tax/subtotal)
      double originalTaxRate = 0.0;
      final dynamic taxRateSource2 = pdfGenerationParams['taxRate'];
      if (taxRateSource2 is num) {
        originalTaxRate = taxRateSource2.toDouble();
      } else if (taxRateSource2 is String) {
        originalTaxRate = double.tryParse(taxRateSource2) ?? 0.0;
      }
      if (originalTaxRate == 0.0) {
        final List clientsList =
            (calculatedPayloadData?['clients'] as List?) ?? [];
        if (clientsList.isNotEmpty &&
            clientsList.first is Map<String, dynamic>) {
          final c = clientsList.first as Map<String, dynamic>;
          final dynamic persistedRate = c['taxRate'];
          if (persistedRate is num) {
            originalTaxRate = persistedRate.toDouble();
          } else if (persistedRate is String) {
            originalTaxRate = double.tryParse(persistedRate) ?? 0.0;
          }
          // Derive from tax/subtotal if still zero
          if (originalTaxRate == 0.0) {
            final dynamic taxVal = c['tax'] ?? c['taxAmount'];
            final dynamic subtotalVal = c['subtotal'];
            final double taxNum = taxVal is num
                ? taxVal.toDouble()
                : (taxVal is String ? (double.tryParse(taxVal) ?? 0.0) : 0.0);
            final double subtotalNum = subtotalVal is num
                ? subtotalVal.toDouble()
                : (subtotalVal is String
                    ? (double.tryParse(subtotalVal) ?? 0.0)
                    : 0.0);
            if (subtotalNum > 0.0 && taxNum > 0.0) {
              final derived = taxNum / subtotalNum;
              originalTaxRate =
                  derived < 0 ? 0.0 : (derived > 1.0 ? 1.0 : derived);
            }
          }
        }
        if (originalTaxRate == 0.0) {
          final dynamic metaRate = (invoiceData['metadata'] ?? {})['taxRate'];
          if (metaRate is num) {
            originalTaxRate = metaRate.toDouble();
          } else if (metaRate is String) {
            originalTaxRate = double.tryParse(metaRate) ?? 0.0;
          }
        }
      }

      // EXTRA safety: also look directly at the client payload we are about to render (pdfGenerationData)
      try {
        final List pgClients = (pdfGenerationData['clients'] as List?) ?? [];
        if (pgClients.isNotEmpty && pgClients.first is Map<String, dynamic>) {
          final Map<String, dynamic> pg =
              pgClients.first as Map<String, dynamic>;

          if (!shouldShowTax) {
            final dynamic f =
                pg['applyTax'] ?? pg['showTax'] ?? pg['includesTax'];
            if (f is bool) {
              shouldShowTax = f;
            } else if (f is String) {
              shouldShowTax = f.toLowerCase() == 'true' || f == '1';
            } else if (f is num) {
              shouldShowTax = f != 0;
            }
            // Default-off policy: do NOT infer showTax from totals when no explicit flag is present.
          }

          if (originalTaxRate == 0.0) {
            final dynamic r = pg['taxRate'];
            if (r is num) {
              originalTaxRate = r.toDouble();
            } else if (r is String) {
              originalTaxRate = double.tryParse(r) ?? 0.0;
            }
            if (originalTaxRate == 0.0) {
              final double taxNum = pg['tax'] is num
                  ? (pg['tax'] as num).toDouble()
                  : (pg['tax'] is String
                      ? (double.tryParse(pg['tax']) ?? 0.0)
                      : 0.0);
              final double subtotalNum = pg['subtotal'] is num
                  ? (pg['subtotal'] as num).toDouble()
                  : (pg['subtotal'] is String
                      ? (double.tryParse(pg['subtotal']) ?? 0.0)
                      : 0.0);
              if (subtotalNum > 0.0 && taxNum > 0.0) {
                originalTaxRate = taxNum / subtotalNum;
              }
            }
          }
        }
      } catch (_) {}

      // Normalize percentage vs fraction (e.g., 10 -> 0.10)
      if (originalTaxRate > 1.0 && originalTaxRate <= 100.0) {
        originalTaxRate = originalTaxRate / 100.0;
      }
      if (originalTaxRate < 0) originalTaxRate = 0.0;
      if (originalTaxRate > 1.0) originalTaxRate = 1.0;

      // Only apply default tax rate if no explicit rate was provided in pdfGenerationParams
      if (originalTaxRate == 0.0 && shouldShowTax && !pdfGenerationParams.containsKey('taxRate')) {
      originalTaxRate = 0.10;
      }

      // If taxRate is known and no explicit decision yet, default to showing tax unless the invoice is tax-exempt
      // Enforce default-off policy: do NOT auto-enable tax merely because taxRate > 0.
      bool isTaxExempt = false;
      try {
        final List pgClients = (pdfGenerationData['clients'] as List?) ?? [];
        if (pgClients.isNotEmpty && pgClients.first is Map<String, dynamic>) {
          final Map<String, dynamic> pg =
              pgClients.first as Map<String, dynamic>;
          final dynamic exempt = pg['taxExempt'] ?? pg['isTaxExempt'];
          if (exempt is bool) isTaxExempt = exempt;
          if (exempt is String) {
            isTaxExempt = exempt.toLowerCase() == 'true' || exempt == '1';
          }
        }
      } catch (_) {}
      if (isTaxExempt) {
        shouldShowTax = false;
      }

      // Respect current preference for admin vs employee bank details during regeneration
      bool useAdminBankDetails = false;
      try {
        final prefs = await SharedPreferences.getInstance();
        final stored =
            prefs.getBool(SharedPreferencesUtils.kUseAdminBankDetailsKey);
        if (stored != null) useAdminBankDetails = stored;
      } catch (_) {}

      final pdfPaths = await _pdfGenerator.generatePdfs(
        pdfGenerationData,
        showTax: shouldShowTax,
        taxRate: originalTaxRate,
        attachedPhotos: [], // Attachments are not regenerated
        photoDescription: pdfGenerationParams['photoDescription'] ?? '',
        uploadedPhotoUrls: pdfGenerationParams['uploadedPhotoUrls'] ?? [],
        uploadedAdditionalFileUrls:
            pdfGenerationParams['uploadedAdditionalFileUrls'] ?? [],
        useAdminBankDetails: useAdminBankDetails,
      );

      debugPrint(
          'PDF regeneration - showTax: $shouldShowTax, taxRate: $originalTaxRate');
      debugPrint(
          'PDF regeneration - default-off policy applied (will not auto-enable based on taxRate). isTaxExempt=$isTaxExempt, final showTax=$shouldShowTax, taxRate=$originalTaxRate');

      if (pdfPaths.isEmpty) {
        return {
          'success': false,
          'message': 'Failed to generate PDF - no output files created',
        };
      }

      final pdfPath = pdfPaths.first;
      debugPrint('PDF regenerated successfully at: $pdfPath');

      return {
        'success': true,
        'message': 'PDF regenerated successfully',
        'pdfPath': pdfPath,
        'regenerated': true,
      };
    } catch (e) {
      debugPrint('Error regenerating PDF: $e');
      return {
        'success': false,
        'message': 'Error regenerating PDF: ${e.toString()}',
      };
    }
  }

  /// Check storage permission
  Future<bool> _checkStoragePermission() async {
    try {
      if (Platform.isAndroid) {
        // For Android 11+ (API 30+), we don't need storage permission for app-specific directories
        // and sharing files through the share intent
        if (await Permission.storage.isGranted) {
          return true;
        }

        // Try to request storage permission
        final result = await Permission.storage.request();

        // If storage permission is denied, we can still share files from temp directory
        // which doesn't require storage permission on modern Android
        if (result.isDenied || result.isPermanentlyDenied) {
          // Return true because we can still use temporary directory for sharing
          return true;
        }

        return result.isGranted;
      } else if (Platform.isIOS) {
        // iOS doesn't require explicit storage permission for app documents
        return true;
      }
      return false;
    } catch (e) {
      // If permission check fails, we can still try to share from temp directory
      return true;
    }
  }

  /// Show share options dialog
  static Future<ShareMethod?> showShareOptionsDialog(
      BuildContext context) async {
    return showDialog<ShareMethod>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Share Invoice'),
          content: const Text('Choose how you want to share this invoice:'),
          actions: [
            TextButton.icon(
              onPressed: () => Navigator.of(context).pop(ShareMethod.link),
              icon: const Icon(Icons.link),
              label: const Text('Share Link'),
            ),
            TextButton.icon(
              onPressed: () => Navigator.of(context).pop(ShareMethod.pdf),
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text('Share PDF'),
            ),
            TextButton.icon(
              onPressed: () => Navigator.of(context).pop(ShareMethod.email),
              icon: const Icon(Icons.email),
              label: const Text('Email'),
            ),
            TextButton.icon(
              onPressed: () => Navigator.of(context).pop(ShareMethod.whatsapp),
              icon: const Icon(Icons.chat),
              label: const Text('WhatsApp'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}

/// Enum for different sharing methods
enum ShareMethod {
  link,
  pdf,
  email,
  whatsapp,
}
