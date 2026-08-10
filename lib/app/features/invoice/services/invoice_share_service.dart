import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:carenest/app/features/invoice/models/invoice_list_model.dart';
import 'package:carenest/app/features/invoice/services/invoice_management_service.dart';
import 'package:carenest/app/features/invoice/services/invoice_pdf_generator_service.dart';
import 'package:carenest/app/features/invoice/services/invoice_number_generator_service.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class InvoiceShareService {
  final InvoiceManagementService _invoiceService;
  final InvoicePdfGenerator _pdfGenerator;
  final ApiMethod _apiMethod;

  InvoiceShareService(this._invoiceService, {required ApiMethod apiMethod})
    : _apiMethod = apiMethod,
      _pdfGenerator = InvoicePdfGenerator(api: apiMethod);

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
        shareMethod: 'link',
      );

      String? shareableLink;
      String? shareToken;
      if (result['shareableLink'] != null) {
        shareableLink = result['shareableLink'].toString();
      } else if (result['data'] is Map<String, dynamic>) {
        final data = result['data'] as Map<String, dynamic>;
        shareableLink =
            data['shareUrl']?.toString() ?? data['shareableLink']?.toString();
        shareToken = data['shareToken']?.toString();
      } else {
        shareToken = result['shareToken']?.toString();
      }

      shareableLink = _normalizeShareableLink(
        shareableLink: shareableLink,
        shareToken: shareToken,
      );

      if (result['success'] == true &&
          shareableLink != null &&
          shareableLink.isNotEmpty) {
        await SharePlus.instance.share(
          ShareParams(
            text:
                'Invoice ${invoice.invoiceNumber}\n'
                'Amount: \$${invoice.totalAmount.toStringAsFixed(2)}\n'
                'Due Date: ${invoice.dueDate.toString().split(' ')[0]}\n\n'
                'View invoice: $shareableLink',
            subject: 'Invoice ${invoice.invoiceNumber}',
          ),
        );

        return {
          'success': true,
          'message': 'Invoice shared successfully',
          'shareableLink': shareableLink,
        };
      } else {
        return {
          'success': false,
          'message':
              result['message'] ??
              result['error'] ??
              'Failed to generate shareable link',
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
    return _sharePdfFile(
      invoice: invoice,
      organizationId: organizationId,
      text:
          'Invoice ${invoice.invoiceNumber} - \$${invoice.totalAmount.toStringAsFixed(2)}',
      subject: 'Invoice ${invoice.invoiceNumber}',
    );
  }

  Future<Map<String, dynamic>> _sharePdfFile({
    required InvoiceListModel invoice,
    required String organizationId,
    required String text,
    required String subject,
  }) async {
    try {
      // Check storage permission
      final storagePermission = await _checkStoragePermission();
      if (!storagePermission) {
        return {
          'success': false,
          'message': 'Storage permission required to share PDF',
        };
      }

      // Use the same robust local-lookup/regeneration flow as "View Invoice".
      final pdfResult = await generatePdfForViewing(invoice, organizationId);
      if (pdfResult['success'] != true || pdfResult['pdfPath'] == null) {
        return {
          'success': false,
          'message':
              pdfResult['message'] ?? 'PDF not available for this invoice',
        };
      }

      final pdfFile = File(pdfResult['pdfPath'].toString());
      if (!await pdfFile.exists()) {
        return {'success': false, 'message': 'PDF file not found on device'};
      }

      // Share the PDF file directly
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(pdfFile.path)],
          text: text,
          subject: subject,
        ),
      );

      return {
        'success': true,
        'message': pdfResult['regenerated'] == true
            ? 'Invoice PDF regenerated and shared successfully'
            : 'Invoice PDF shared successfully',
        'filePath': pdfFile.path,
        'regenerated': pdfResult['regenerated'] == true,
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
      // Prefer attaching the actual PDF when sharing from app.
      final emailSubject = 'Invoice ${invoice.invoiceNumber}';
      final emailBody =
          '''
Dear ${invoice.clientName},

Please find your invoice details below:

Invoice Number: ${invoice.invoiceNumber}
Amount: \$${invoice.totalAmount.toStringAsFixed(2)}
Due Date: ${invoice.dueDate.toString().split(' ')[0]}
Status: ${invoice.status}

Please find the invoice PDF attached.

Thank you for your business!

Best regards,
Your Invoice Team
''';

      final pdfResult = await _sharePdfFile(
        invoice: invoice,
        organizationId: organizationId,
        text: emailBody,
        subject: emailSubject,
      );

      if (pdfResult['success'] == true) {
        return {
          'success': true,
          'message': 'Email sharing initiated with PDF attachment',
          'filePath': pdfResult['filePath'],
        };
      }

      // Fallback: share link if PDF is unavailable.
      return await _shareAsLink(invoice, organizationId);
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
      // Prefer attaching the actual PDF when sharing from app.
      final message =
          '''
🧾 *Invoice ${invoice.invoiceNumber}*

💰 Amount: \$${invoice.totalAmount.toStringAsFixed(2)}
📅 Due Date: ${invoice.dueDate.toString().split(' ')[0]}
📊 Status: ${invoice.status}
''';

      final pdfResult = await _sharePdfFile(
        invoice: invoice,
        organizationId: organizationId,
        text: message,
        subject: 'Invoice ${invoice.invoiceNumber}',
      );

      if (pdfResult['success'] == true) {
        return {
          'success': true,
          'message': 'WhatsApp sharing initiated with PDF attachment',
          'filePath': pdfResult['filePath'],
        };
      }

      // Fallback: share link if PDF is unavailable.
      return await _shareAsLink(invoice, organizationId);
    } catch (e) {
      return {
        'success': false,
        'message': 'Error sharing via WhatsApp: ${e.toString()}',
      };
    }
  }

  String? _normalizeShareableLink({
    required String? shareableLink,
    required String? shareToken,
  }) {
    String? link = shareableLink?.trim();
    final token = shareToken?.trim();

    if (link != null && link.isNotEmpty && !_isBrokenShareLink(link)) {
      return link;
    }

    if (token == null || token.isEmpty) {
      return link;
    }

    final fallbackBase = _derivePublicBaseUrl();
    return '$fallbackBase/shared-invoice/$token';
  }

  bool _isBrokenShareLink(String url) {
    final lower = url.toLowerCase();
    return lower.startsWith('undefined/') ||
        lower.contains('://undefined/') ||
        lower.contains('//undefined/');
  }

  String _derivePublicBaseUrl() {
    final apiBase = _apiMethod.baseUrl.replaceAll(RegExp(r'/+$'), '');
    return apiBase.replaceFirst(RegExp(r'/api$'), '');
  }

  // PDF resolution order:
  // 1) Backend-managed immutable artifact
  // 2) Local cached PDF
  // 3) Deterministic snapshot re-render fallback

  /// Generate PDF for viewing (public method)
  Future<Map<String, dynamic>> generatePdfForViewing(
    InvoiceListModel invoice,
    String organizationId,
  ) async {
    try {
      // First priority: retrieve immutable PDF artifact from backend.
      final backendPdfPath = await _fetchPdfFromBackendAndStore(
        invoiceId: invoice.id,
        organizationId: organizationId,
        invoiceNumber: invoice.invoiceNumber,
      );
      if (backendPdfPath != null) {
        debugPrint('PDF loaded from backend artifact: $backendPdfPath');
        return {
          'success': true,
          'message': 'PDF loaded from backend artifact',
          'pdfPath': backendPdfPath,
          'regenerated': false,
          'artifact': true,
        };
      }

      // Check if PDF already exists locally using the same filename generation logic
      final output = await getApplicationDocumentsDirectory();
      final expectedFileName = InvoiceNumberGeneratorService.generateFileName(
        invoice.invoiceNumber,
      );
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

      // Prefer immutable render snapshot when available.
      final calculatedPayloadData = invoiceData['calculatedPayloadData'];
      final persistedSnapshot = _extractPersistedPdfRenderSnapshot(invoiceData);
      final defaultPdfGenerationParams =
          invoiceData['pdfGenerationParams'] is Map
          ? Map<String, dynamic>.from(invoiceData['pdfGenerationParams'] as Map)
          : <String, dynamic>{};
      final snapshotParams = persistedSnapshot?['renderParams'] is Map
          ? Map<String, dynamic>.from(persistedSnapshot!['renderParams'] as Map)
          : <String, dynamic>{};
      final pdfGenerationParams = <String, dynamic>{
        ...defaultPdfGenerationParams,
        ...snapshotParams,
      };
      final snapshotFinancialSummary =
          persistedSnapshot?['financialSummary'] is Map
          ? Map<String, dynamic>.from(
              persistedSnapshot!['financialSummary'] as Map,
            )
          : <String, dynamic>{};
      final metadata = invoiceData['metadata'] ?? {};

      Map<String, dynamic> pdfGenerationData;

      if (persistedSnapshot != null &&
          persistedSnapshot['renderPayload'] is Map) {
        debugPrint(
          'Using immutable pdfRenderSnapshot payload for deterministic PDF re-render',
        );
        pdfGenerationData = Map<String, dynamic>.from(
          persistedSnapshot['renderPayload'] as Map,
        );

        // Keep invoice number authoritative and ensure period dates exist.
        final snapClient = _extractSnapshotClient(pdfGenerationData);
        if (snapClient != null) {
          snapClient['invoiceNumber'] = invoice.invoiceNumber;
          snapClient['startDate'] =
              snapClient['startDate'] ?? invoiceData['startDate'] ?? '';
          snapClient['endDate'] =
              snapClient['endDate'] ?? invoiceData['endDate'] ?? '';

          // Tax must only apply to service items, not to reimbursements.
          // The stored snapshot may have been generated before this fix, so
          // always recalculate here to ensure correctness on every render.
          _correctExpenseTaxInClientData(snapClient);
        }
      } else if (calculatedPayloadData != null) {
        // Use stored calculated payload data for accurate PDF regeneration
        debugPrint('Using stored calculated payload data for PDF regeneration');
        debugPrint(
          'calculatedPayloadData structure: ${calculatedPayloadData.keys}',
        );

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
            'Period dates - Start: ${clientData['startDate']}, End: ${clientData['endDate']}',
          );

          // Debug: Print the complete client data structure to verify all fields are present
          debugPrint('Client data keys: ${clientData.keys}');
          debugPrint('employeeName: ${clientData['employeeName']}');
          debugPrint('providerABN: ${clientData['providerABN']}');
          debugPrint('clientFirstName: ${clientData['clientFirstName']}');
          debugPrint('clientLastName: ${clientData['clientLastName']}');
          debugPrint('clientAddress: ${clientData['clientAddress']}');
          debugPrint(
            'expenses count: ${(clientData['expenses'] as List?)?.length ?? 0}',
          );

          // Enrich missing provider details (employeeName, providerABN) when using calculated payload
          try {
            String employeeName = (clientData['employeeName'] ?? '').toString();
            String providerABN = (clientData['providerABN'] ?? '').toString();
            String employeeEmail =
                (clientData['employeeEmail'] ??
                        invoiceData['employeeEmail'] ??
                        ((clientData['employeeDetails'] is Map)
                            ? (clientData['employeeDetails']['email'] ??
                                  clientData['employeeDetails']['userEmail'])
                            : null) ??
                        ((invoiceData['employeeDetails'] is Map)
                            ? (invoiceData['employeeDetails']['email'] ??
                                  invoiceData['employeeDetails']['userEmail'])
                            : null) ??
                        metadata['employeeEmail'] ??
                        '')
                    .toString();

            // First, try to fill from other available sources before calling APIs
            if (employeeName.trim().isEmpty ||
                employeeName == 'Provider Name') {
              final invName = (invoiceData['employeeName'] ?? '').toString();
              final metaName = (metadata['providerName'] ?? '').toString();
              final ed = clientData['employeeDetails'] as Map<String, dynamic>?;
              final edName =
                  ((ed?['name']) ??
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
                'Provider details missing or generic in calculated payload, fetching fresh employee details...',
              );
              String fetchedEmail = employeeEmail.isNotEmpty
                  ? employeeEmail
                  : (invoiceData['employeeEmail'] ??
                            ((clientData['employeeDetails'] is Map)
                                ? (clientData['employeeDetails']['email'] ??
                                      clientData['employeeDetails']['userEmail'])
                                : null) ??
                            ((invoiceData['employeeDetails'] is Map)
                                ? (invoiceData['employeeDetails']['email'] ??
                                      invoiceData['employeeDetails']['userEmail'])
                                : null) ??
                            metadata['employeeEmail'] ??
                            '')
                        .toString();
              if (fetchedEmail.isNotEmpty) {
                final freshEmployeeDetails = await _apiMethod.checkEmail(
                  fetchedEmail,
                );
                if (freshEmployeeDetails != null) {
                  final userData = freshEmployeeDetails;
                  employeeName =
                      userData['name'] ??
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
                    'Updated provider details - Name: $employeeName, ABN: $providerABN',
                  );
                }
              }
            }
          } catch (e) {
            debugPrint(
              'Failed to enrich employee details in calculated payload branch: $e',
            );
          }

          // Enrich missing client address/phone/business details when using calculated payload
          try {
            String clientAddress = (clientData['clientAddress'] ?? '')
                .toString();
            String clientCity = (clientData['clientCity'] ?? '').toString();
            String clientState = (clientData['clientState'] ?? '').toString();
            String clientZip = (clientData['clientZip'] ?? '').toString();
            String clientPhone = (clientData['clientPhone'] ?? '').toString();
            String businessName = (clientData['businessName'] ?? '').toString();

            if (clientAddress.trim().isEmpty &&
                clientCity.trim().isEmpty &&
                clientState.trim().isEmpty) {
              debugPrint(
                'Client address fields missing in calculated payload, fetching fresh client details...',
              );
              final clientEmail =
                  (clientData['clientEmail'] ??
                          invoiceData['clientEmail'] ??
                          invoice.clientEmail ??
                          '')
                      .toString();
              if (clientEmail.isNotEmpty) {
                final freshClientDetails = await _apiMethod.getClientDetails(
                  clientEmail,
                );
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
                    'Updated client details - Address: ${clientData['clientAddress']}, City: ${clientData['clientCity']}, State: ${clientData['clientState']}, Zip: ${clientData['clientZip']}, Phone: ${clientData['clientPhone']}, Business: ${clientData['businessName']}',
                  );
                }
              }
            }
          } catch (e) {
            debugPrint(
              'Failed to enrich client details in calculated payload branch: $e',
            );
          }
        }
      } else {
        // Fallback to reconstructing data from stored invoice data (legacy support)
        debugPrint(
          'No calculated payload data found, reconstructing from stored invoice data',
        );

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
            final spEmail =
                sp.getUserEmail() ??
                await sp.getUserEmailFromSharedPreferences() ??
                '';
            if (spEmail.isNotEmpty) {
              employeeEmailForMeta = spEmail;
            }
          } catch (_) {}
        }

        // Build complete client data structure that original PDF generator expects
        // First, check if we need to fetch fresh client details for missing address or ABN information
        String clientAddress = invoiceData['clientAddress'] ?? '';
        String clientCity = invoiceData['clientCity'] ?? '';
        String clientState = invoiceData['clientState'] ?? '';
        String clientZip = invoiceData['clientZip'] ?? '';
        String clientPhone = invoiceData['clientPhone'] ?? '';
        String businessName = invoiceData['businessName'] ?? '';
        String clientABN = invoiceData['clientABN'] ?? invoiceData['abn'] ?? '';

        if (clientAddress.trim().isEmpty || clientABN.trim().isEmpty) {
          debugPrint(
            'Client address or ABN missing, fetching fresh client details...',
          );
          try {
            final clientEmail =
                invoiceData['clientEmail'] ?? invoice.clientEmail;
            if (clientEmail.isNotEmpty) {
              final freshClientDetails = await _apiMethod.getClientDetails(
                clientEmail,
                clientId: invoiceData['clientId']?.toString(),
                organizationId: organizationId,
              );
              if (freshClientDetails != null) {
                final clientDataMap =
                    freshClientDetails['clientDetails'] ?? freshClientDetails;
                if (clientAddress.trim().isEmpty) {
                  clientAddress = clientDataMap['clientAddress'] ?? '';
                }
                if (clientCity.trim().isEmpty) {
                  clientCity = clientDataMap['clientCity'] ?? '';
                }
                if (clientState.trim().isEmpty) {
                  clientState = clientDataMap['clientState'] ?? '';
                }
                if (clientZip.trim().isEmpty) {
                  clientZip = clientDataMap['clientZip'] ?? '';
                }
                if (clientPhone.trim().isEmpty) {
                  clientPhone = clientDataMap['clientPhone'] ?? '';
                }
                if (businessName.trim().isEmpty) {
                  businessName = clientDataMap['businessName'] ?? '';
                }
                if (clientABN.trim().isEmpty) {
                  clientABN =
                      clientDataMap['abn'] ??
                      clientDataMap['clientABN'] ??
                      clientDataMap['businessABN'] ??
                      '';
                }
                debugPrint(
                  'Fresh client details fetched - Address: $clientAddress, City: $clientCity, State: $clientState, Zip: $clientZip, Phone: $clientPhone, Business: $businessName, ABN: $clientABN',
                );
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
            'Provider details are missing, fetching fresh employee details...',
          );
          try {
            String employeeEmail = employeeEmailForMeta;
            if (employeeEmail.isNotEmpty) {
              final freshEmployeeDetails = await _apiMethod.checkEmail(
                employeeEmail,
              );
              if (freshEmployeeDetails != null) {
                final userData = freshEmployeeDetails;
                employeeName =
                    userData['name'] ??
                    '${userData['firstName'] ?? ''} ${userData['lastName'] ?? ''}'
                        .trim();
                if (employeeName.trim().isEmpty) {
                  employeeName = userData['firstName'] ?? employeeName;
                }
                providerABN = userData['abn'] ?? userData['ABN'] ?? providerABN;
                debugPrint(
                  'Fresh employee details fetched - Name: $employeeName, ABN: $providerABN',
                );
              }
            }
          } catch (e) {
            debugPrint('Failed to fetch fresh employee details: $e');
          }
        }

        // Fetch and populate adminProfile
        Map<String, dynamic> adminProfile = {};
        try {
          if (organizationId.isNotEmpty) {
            final orgResp = await _apiMethod.getOrganizationDetails(
              organizationId,
            );
            final org =
                (orgResp['organization'] ?? orgResp['data'])
                    as Map<String, dynamic>?;
            if (org != null) {
              adminProfile = {
                'businessName':
                    org['name'] ?? org['organizationName'] ?? 'Business',
                'businessAddress': _composeAddress(org['address']),
                'contactEmail':
                    (org['contactDetails'] ?? const {})['email'] ?? '',
                'contactPhone':
                    (org['contactDetails'] ?? const {})['phone'] ?? '',
                'taxIdentifiers': {'abn': org['abn'] ?? ''},
                'abn': org['abn'] ?? '',
              };
            } else {
              final resp = await _apiMethod.getAdminInvoiceProfile(
                organizationId,
              );
              if (resp['success'] == true &&
                  resp['data'] is Map<String, dynamic>) {
                final Map<String, dynamic> data = Map<String, dynamic>.from(
                  resp['data'] as Map,
                );
                final abn =
                    (data['taxIdentifiers'] ?? const {})['abn'] ??
                    data['abn'] ??
                    '';
                adminProfile = {
                  'businessName': data['businessName'] ?? 'Business',
                  'businessAddress': data['businessAddress'] ?? '',
                  'contactEmail': data['contactEmail'] ?? '',
                  'contactPhone': data['contactPhone'] ?? '',
                  'taxIdentifiers': data['taxIdentifiers'] ?? {'abn': abn},
                  'abn': abn,
                };
              }
            }
          }
        } catch (e) {
          debugPrint('Failed to load admin invoice profile: $e');
        }

        if (adminProfile.isEmpty) {
          adminProfile = {
            'businessName': metadata['providerName'] ?? 'Business',
            'abn': providerABN,
            'taxIdentifiers': {'abn': providerABN},
          };
        }

        final clientFullName =
            (invoiceData['clientFirstName'] != null ||
                invoiceData['clientLastName'] != null)
            ? '${invoiceData['clientFirstName'] ?? ''} ${invoiceData['clientLastName'] ?? ''}'
                  .trim()
            : (invoiceData['clientName'] ?? invoice.clientName ?? '')
                  .toString();

        final billTo = {
          'name': clientFullName.isNotEmpty
              ? clientFullName
              : 'Client Name Not Available',
          'email': invoiceData['clientEmail'] ?? invoice.clientEmail ?? '',
          'address': _composeAddress({
            'clientAddress': clientAddress,
            'clientCity': clientCity,
            'clientState': clientState,
            'clientZip': clientZip,
          }),
          'phone': clientPhone,
          'abn': clientABN,
          'businessName': businessName,
        };

        String startDateStr = '';
        String endDateStr = '';

        dynamic rawStartDate = invoiceData['startDate'];
        dynamic rawEndDate = invoiceData['endDate'];

        if (rawStartDate != null && rawStartDate.toString().trim().isNotEmpty) {
          try {
            final parsedStart = DateTime.parse(rawStartDate.toString());
            startDateStr = DateFormat('dd/MM/yyyy').format(parsedStart);
          } catch (_) {
            startDateStr = rawStartDate.toString();
          }
        }
        if (rawEndDate != null && rawEndDate.toString().trim().isNotEmpty) {
          try {
            final parsedEnd = DateTime.parse(rawEndDate.toString());
            endDateStr = DateFormat('dd/MM/yyyy').format(parsedEnd);
          } catch (_) {
            endDateStr = rawEndDate.toString();
          }
        }

        if (startDateStr.isEmpty || endDateStr.isEmpty) {
          DateTime refDate = invoice.createdAt;
          if (invoiceData['issueDate'] != null) {
            try {
              refDate = DateTime.parse(invoiceData['issueDate'].toString());
            } catch (_) {}
          } else if (invoiceData['createdAt'] != null) {
            try {
              refDate = DateTime.parse(invoiceData['createdAt'].toString());
            } catch (_) {}
          }
          final calculatedStart = refDate.subtract(const Duration(days: 13));
          if (startDateStr.isEmpty) {
            startDateStr = DateFormat('dd/MM/yyyy').format(calculatedStart);
          }
          if (endDateStr.isEmpty) {
            endDateStr = DateFormat('dd/MM/yyyy').format(refDate);
          }
        }

        // Map line items to match what PDF generator expects
        final mappedItems = (lineItems as List).map((item) {
          if (item is Map) {
            final itemMap = Map<String, dynamic>.from(item);

            final String itemName =
                (itemMap['supportItemName'] ??
                        itemMap['itemName'] ??
                        itemMap['ndisItemName'] ??
                        itemMap['description'] ??
                        'Service')
                    .toString();
            final String description =
                (itemMap['description'] ??
                        itemMap['supportItemName'] ??
                        itemMap['itemName'] ??
                        itemMap['ndisItemName'] ??
                        'Service')
                    .toString();

            final double quantity =
                _asNullableDouble(itemMap['quantity'] ?? itemMap['hours']) ??
                1.0;
            final double rate =
                _asNullableDouble(
                  itemMap['price'] ?? itemMap['rate'] ?? itemMap['unitPrice'],
                ) ??
                0.0;
            final double amount =
                _asNullableDouble(
                  itemMap['totalPrice'] ??
                      itemMap['amount'] ??
                      itemMap['total'] ??
                      (quantity * rate),
                ) ??
                0.0;

            final String dateVal =
                (itemMap['date'] ??
                        itemMap['shiftDate'] ??
                        invoiceData['issueDate'] ??
                        invoiceData['createdAt'] ??
                        '')
                    .toString();

            String formattedDate = '';
            if (dateVal.isNotEmpty) {
              try {
                final parsedDate = DateTime.parse(dateVal);
                formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
              } catch (_) {
                formattedDate = dateVal;
              }
            } else {
              formattedDate = DateFormat(
                'yyyy-MM-dd',
              ).format(invoice.createdAt);
            }

            return {
              ...itemMap,
              'itemName': itemName,
              'description': description,
              'hours': quantity,
              'quantity': quantity,
              'rate': rate,
              'unitPrice': rate,
              'amount': amount,
              'total': amount,
              'totalPrice': amount,
              'date': formattedDate,
            };
          }
          return item;
        }).toList();

        final clientData = {
          'adminProfile': adminProfile,
          'billTo': billTo,
          'invoiceType':
              invoiceData['metadata']?['invoiceType'] ?? invoice.invoiceType,

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
          'abn': clientABN,
          'clientABN': clientABN,

          // Period dates
          'startDate': startDateStr,
          'endDate': endDateStr,

          // Invoice metadata (required by _buildInvoiceHeader and _buildBillingInfo)
          'invoiceNumber': invoice.invoiceNumber,
          'jobTitle': invoiceData['jobTitle'] ?? 'Personal Care Assistance',

          // Financial data (match PDF generator expectations)
          'subtotal': financialSummary['subtotal'] ?? 0.0,
          'tax': financialSummary['taxAmount'] ?? 0.0,
          'total': financialSummary['totalAmount'] ?? invoice.totalAmount,
          'totalHours': invoiceData['totalHours'] ?? '0.00',

          // Breakdown totals for expenses (required by _buildInvoiceTotal)
          'itemsSubtotal':
              financialSummary['itemsSubtotal'] ??
              financialSummary['subtotal'] ??
              0.0,
          'expensesTotal': financialSummary['expensesTotal'] ?? 0.0,

          // Line items and expenses (ensure expenses are properly formatted)
          'items': mappedItems,
          'expenses': expenses.map((expense) {
            // Ensure expense has all required fields for PDF generation
            if (expense is Map<String, dynamic>) {
              return {
                ...expense,
                'date': expense['date'] ?? expense['expenseDate'] ?? '',
                'category': expense['category'] ?? 'Other',
                'totalAmount':
                    expense['totalAmount'] ??
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
          'expenses count: ${(clientData['expenses'] as List?)?.length ?? 0}',
        );
        debugPrint(
          'items count: ${(clientData['items'] as List?)?.length ?? 0}',
        );

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

      // Regeneration must be deterministic and match the issued invoice.
      final financialSummary = snapshotFinancialSummary.isNotEmpty
          ? snapshotFinancialSummary
          : (invoiceData['financialSummary'] is Map
                ? Map<String, dynamic>.from(
                    invoiceData['financialSummary'] as Map,
                  )
                : <String, dynamic>{});
      final snapshotClient = _extractSnapshotClient(pdfGenerationData);
      final shouldShowTax = _resolvePersistedShowTax(
        pdfGenerationParams: pdfGenerationParams,
        snapshotClient: snapshotClient,
        invoiceData: invoiceData,
        financialSummary: financialSummary,
      );
      final originalTaxRate = _resolvePersistedTaxRate(
        pdfGenerationParams: pdfGenerationParams,
        snapshotClient: snapshotClient,
        invoiceData: invoiceData,
        financialSummary: financialSummary,
        shouldShowTax: shouldShowTax,
      );
      if (snapshotClient != null) {
        _applyPersistedFinancialSummary(
          snapshotClient: snapshotClient,
          financialSummary: financialSummary,
          showTax: shouldShowTax,
          taxRate: originalTaxRate,
        );
      }

      // Respect current preference for admin vs employee bank details during regeneration
      bool useAdminBankDetails = false;
      try {
        final prefs = await SharedPreferences.getInstance();
        final stored = prefs.getBool(
          SharedPreferencesUtils.kUseAdminBankDetailsKey,
        );
        if (stored != null) useAdminBankDetails = stored;
      } catch (_) {}

      final pdfPaths = await _pdfGenerator.generatePdfs(
        pdfGenerationData,
        showTax: shouldShowTax,
        taxRate: originalTaxRate,
        preserveSnapshotTotals: true,
        attachedPhotos: [], // Attachments are not regenerated
        photoDescription: pdfGenerationParams['photoDescription'] ?? '',
        uploadedPhotoUrls: pdfGenerationParams['uploadedPhotoUrls'] ?? [],
        uploadedAdditionalFileUrls:
            pdfGenerationParams['uploadedAdditionalFileUrls'] ?? [],
        useAdminBankDetails: useAdminBankDetails,
      );

      debugPrint(
        'PDF regeneration - showTax: $shouldShowTax, taxRate: $originalTaxRate',
      );
      debugPrint(
        'PDF regeneration - deterministic snapshot mode enabled; totals and tax flags preserved from stored invoice payload.',
      );

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

  Map<String, dynamic>? _extractSnapshotClient(
    Map<String, dynamic> pdfGenerationData,
  ) {
    final clients = pdfGenerationData['clients'];
    if (clients is! List || clients.isEmpty) {
      return null;
    }

    final first = clients.first;
    if (first is Map<String, dynamic>) {
      return first;
    }
    if (first is Map) {
      final normalized = Map<String, dynamic>.from(first);
      clients[0] = normalized;
      return normalized;
    }
    return null;
  }

  Map<String, dynamic>? _extractPersistedPdfRenderSnapshot(
    Map<String, dynamic> invoiceData,
  ) {
    final raw = invoiceData['pdfRenderSnapshot'];
    if (raw is Map<String, dynamic>) {
      return raw;
    }
    if (raw is Map) {
      return Map<String, dynamic>.from(raw);
    }
    return null;
  }

  Future<String?> _fetchPdfFromBackendAndStore({
    required String invoiceId,
    required String organizationId,
    required String invoiceNumber,
  }) async {
    try {
      final result = await _invoiceService.shareInvoiceAsPdf(
        invoiceId: invoiceId,
        organizationId: organizationId,
      );
      if (result['success'] != true) return null;

      final payload = result['data'];
      final source = (payload is Map<String, dynamic>)
          ? payload['source']?.toString()
          : result['source']?.toString();
      final rawBase64 =
          ((payload is Map<String, dynamic>) ? payload['pdfData'] : null) ??
          result['pdfData'];
      if (rawBase64 == null || rawBase64.toString().trim().isEmpty) {
        return null;
      }

      final normalizedBase64 = rawBase64.toString().contains(',')
          ? rawBase64.toString().split(',').last
          : rawBase64.toString();
      final bytes = base64Decode(normalizedBase64);
      if (bytes.isEmpty) return null;

      final output = await getApplicationDocumentsDirectory();
      final fileName = InvoiceNumberGeneratorService.generateFileName(
        invoiceNumber,
      );
      final targetPath = '${output.path}/$fileName';
      final file = File(targetPath);
      await file.writeAsBytes(bytes, flush: true);
      debugPrint(
        'InvoiceShareService: backend PDF source=${source ?? 'unknown'}',
      );

      if (!await file.exists() || await file.length() <= 0) {
        return null;
      }
      return file.path;
    } catch (e) {
      debugPrint('Failed to retrieve invoice PDF from backend artifact: $e');
      return null;
    }
  }

  bool _resolvePersistedShowTax({
    required Map<String, dynamic> pdfGenerationParams,
    required Map<String, dynamic>? snapshotClient,
    required Map<String, dynamic> invoiceData,
    required Map<String, dynamic> financialSummary,
  }) {
    final invoiceMetadata = invoiceData['metadata'] is Map
        ? Map<String, dynamic>.from(invoiceData['metadata'] as Map)
        : <String, dynamic>{};

    final explicit = _firstBool(<dynamic>[
      pdfGenerationParams['showTax'],
      pdfGenerationParams['applyTax'],
      pdfGenerationParams['includesTax'],
      snapshotClient?['showTax'],
      snapshotClient?['applyTax'],
      snapshotClient?['includesTax'],
      invoiceData['showTax'],
      invoiceData['applyTax'],
      invoiceData['includesTax'],
      invoiceMetadata['showTax'],
      invoiceMetadata['applyTax'],
      invoiceMetadata['includesTax'],
      financialSummary['showTax'],
      financialSummary['applyTax'],
      financialSummary['includesTax'],
    ]);
    if (explicit != null) {
      return explicit;
    }

    // Final fallback: only show tax if persisted tax amount is non-zero.
    final persistedTaxAmount =
        _firstDouble(<dynamic>[
          financialSummary['taxAmount'],
          financialSummary['tax'],
          snapshotClient?['taxAmount'],
          snapshotClient?['tax'],
          invoiceData['taxAmount'],
          invoiceData['tax'],
        ]) ??
        0.0;
    return persistedTaxAmount > 0;
  }

  double _resolvePersistedTaxRate({
    required Map<String, dynamic> pdfGenerationParams,
    required Map<String, dynamic>? snapshotClient,
    required Map<String, dynamic> invoiceData,
    required Map<String, dynamic> financialSummary,
    required bool shouldShowTax,
  }) {
    if (!shouldShowTax) {
      return 0.0;
    }

    final invoiceMetadata = invoiceData['metadata'] is Map
        ? Map<String, dynamic>.from(invoiceData['metadata'] as Map)
        : <String, dynamic>{};

    final explicitRate = _firstDouble(<dynamic>[
      pdfGenerationParams['taxRate'],
      snapshotClient?['taxRate'],
      invoiceData['taxRate'],
      invoiceMetadata['taxRate'],
      financialSummary['taxRate'],
    ]);
    if (explicitRate != null && explicitRate >= 0) {
      return _normalizeTaxRate(explicitRate);
    }

    final subtotal =
        _firstDouble(<dynamic>[
          financialSummary['subtotal'],
          snapshotClient?['subtotal'],
          invoiceData['subtotal'],
        ]) ??
        0.0;
    final taxAmount =
        _firstDouble(<dynamic>[
          financialSummary['taxAmount'],
          financialSummary['tax'],
          snapshotClient?['taxAmount'],
          snapshotClient?['tax'],
          invoiceData['taxAmount'],
          invoiceData['tax'],
        ]) ??
        0.0;

    if (subtotal > 0 && taxAmount > 0) {
      return _normalizeTaxRate(taxAmount / subtotal);
    }
    return 0.0;
  }

  void _applyPersistedFinancialSummary({
    required Map<String, dynamic> snapshotClient,
    required Map<String, dynamic> financialSummary,
    required bool showTax,
    required double taxRate,
  }) {
    final itemsSubtotal =
        _firstDouble(<dynamic>[
          financialSummary['itemsSubtotal'],
          snapshotClient['itemsSubtotal'],
        ]) ??
        0.0;
    final expensesTotal =
        _firstDouble(<dynamic>[
          financialSummary['expensesTotal'],
          snapshotClient['expensesTotal'],
        ]) ??
        0.0;

    double subtotal =
        _firstDouble(<dynamic>[
          financialSummary['subtotal'],
          snapshotClient['subtotal'],
        ]) ??
        0.0;
    if (subtotal == 0.0 && (itemsSubtotal > 0 || expensesTotal > 0)) {
      subtotal = itemsSubtotal + expensesTotal;
    }

    final taxAmount =
        _firstDouble(<dynamic>[
          financialSummary['taxAmount'],
          financialSummary['tax'],
          snapshotClient['taxAmount'],
          snapshotClient['tax'],
        ]) ??
        0.0;

    final total =
        _firstDouble(<dynamic>[
          financialSummary['totalAmount'],
          financialSummary['total'],
          snapshotClient['total'],
        ]) ??
        (subtotal + taxAmount);

    snapshotClient['itemsSubtotal'] = _roundCurrency(itemsSubtotal);
    snapshotClient['expensesTotal'] = _roundCurrency(expensesTotal);
    snapshotClient['subtotal'] = _roundCurrency(subtotal);
    snapshotClient['taxAmount'] = _roundCurrency(taxAmount);
    snapshotClient['tax'] = _roundCurrency(taxAmount);
    snapshotClient['total'] = _roundCurrency(total);
    snapshotClient['taxRate'] = _normalizeTaxRate(taxRate);
    snapshotClient['showTax'] = showTax;
    snapshotClient['applyTax'] = showTax;
    snapshotClient['includesTax'] = showTax;
  }

  bool? _firstBool(List<dynamic> candidates) {
    for (final candidate in candidates) {
      final parsed = _asBool(candidate);
      if (parsed != null) {
        return parsed;
      }
    }
    return null;
  }

  double? _firstDouble(List<dynamic> candidates) {
    for (final candidate in candidates) {
      final parsed = _asNullableDouble(candidate);
      if (parsed != null) {
        return parsed;
      }
    }
    return null;
  }

  bool? _asBool(dynamic value) {
    if (value is bool) return value;
    if (value is num) return value != 0;
    if (value is String) {
      final normalized = value.trim().toLowerCase();
      if (normalized == 'true' || normalized == '1' || normalized == 'yes') {
        return true;
      }
      if (normalized == 'false' ||
          normalized == '0' ||
          normalized == 'no' ||
          normalized.isEmpty) {
        return false;
      }
    }
    return null;
  }

  double? _asNullableDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is String) {
      final normalized = value.trim();
      if (normalized.isEmpty) return null;
      final withoutPercent = normalized.endsWith('%')
          ? normalized.substring(0, normalized.length - 1)
          : normalized;
      return double.tryParse(withoutPercent);
    }
    return null;
  }

  double _normalizeTaxRate(double value) {
    final nonNegative = value < 0 ? 0.0 : value;
    // Stored tax rate can be persisted as "10" (percent) or "0.1" (decimal).
    if (nonNegative > 1.0 && nonNegative <= 100.0) {
      return nonNegative / 100.0;
    }
    return nonNegative;
  }

  double _roundCurrency(double value) {
    return double.parse(value.toStringAsFixed(2));
  }

  String _composeAddress(dynamic address) {
    if (address == null) return '';
    if (address is String) return address.trim();
    try {
      if (address is Map) {
        final parts =
            [
                  address['street'] ??
                      address['clientAddress'] ??
                      address['address'],
                  address['city'] ?? address['clientCity'],
                  address['state'] ?? address['clientState'],
                  address['postcode'] ??
                      address['clientZip'] ??
                      address['zip'] ??
                      address['zipCode'],
                  address['country'],
                ]
                .map((e) => (e ?? '').toString().trim())
                .where((e) => e.isNotEmpty)
                .toList();
        if (parts.isNotEmpty) {
          return parts.join(', ');
        }
      }
    } catch (_) {}
    return address.toString().trim();
  }

  /// Check storage permission
  Future<bool> _checkStoragePermission() async {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        // Sharing files from app documents/cache directories does not require
        // runtime storage permission on modern Android/iOS.
        return true;
      }
      return true;
    } catch (e) {
      // If permission check fails unexpectedly, allow share flow to proceed.
      return true;
    }
  }

  /// Show share options dialog
  static Future<ShareMethod?> showShareOptionsDialog(
    BuildContext context,
  ) async {
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

  /// Recalculates tax and total so that expenses/reimbursements are NOT taxed.
  ///
  /// Expenses are pass-through costs — the business recovers money it already
  /// spent on behalf of the client and must not charge GST on that amount.
  /// Tax applies only to [itemsSubtotal] (billable service hours × rate).
  ///
  /// Called on both the snapshot and calculatedPayloadData paths so invoices
  /// persisted before this fix are also corrected on every render.
  void _correctExpenseTaxInClientData(Map<String, dynamic> clientData) {
    try {
      // 1. Retroactively migrate reimbursements that were incorrectly stored as
      //    service items in older snapshots. If we don't migrate them here,
      //    they'll be taxed.
      if (clientData['items'] is List) {
        final List<dynamic> items = clientData['items'];
        final List<dynamic> expenses = (clientData['expenses'] is List)
            ? clientData['expenses']
            : [];
        final List<dynamic> newItems = [];
        double migratedItemsSubtotal = 0.0;
        double migratedExpensesTotal = _safeDouble(clientData['expensesTotal']);

        for (final item in items) {
          if (item is Map) {
            final String itemName = (item['itemName'] ?? '')
                .toString()
                .toLowerCase();
            if (itemName.contains('reimburse')) {
              // Move to expenses
              expenses.add({
                'description': item['itemName'],
                'totalAmount': item['amount'] ?? 0.0,
                'unitCost': item['rate'] ?? item['amount'] ?? 0.0,
                'quantity': item['hours'] ?? 1.0,
                'isReimbursement': true,
              });
              migratedExpensesTotal += _safeDouble(item['amount']);
            } else {
              newItems.add(item);
              migratedItemsSubtotal += _safeDouble(item['amount']);
            }
          }
        }

        // Apply migrations back to payload
        clientData['items'] = newItems;
        clientData['expenses'] = expenses;
        clientData['itemsSubtotal'] = migratedItemsSubtotal;
        clientData['expensesTotal'] = migratedExpensesTotal;
      }

      final double itemsSubtotal = _safeDouble(clientData['itemsSubtotal']);
      final double expensesTotal = _safeDouble(clientData['expensesTotal']);

      // Only correct when there are actually expenses.
      if (expensesTotal == 0.0) return;

      final double taxRate = _safeDouble(clientData['taxRate']);
      final bool applyTax =
          clientData['applyTax'] == true ||
          clientData['showTax'] == true ||
          _safeDouble(clientData['taxAmount']) > 0;

      // Tax base is service items only — never include reimbursements.
      final double correctTax = applyTax ? itemsSubtotal * taxRate : 0.0;
      final double correctSubtotal = itemsSubtotal + expensesTotal;
      final double correctTotal = correctSubtotal + correctTax;

      clientData['taxAmount'] = double.parse(correctTax.toStringAsFixed(2));
      clientData['tax'] = clientData['taxAmount'];
      clientData['subtotal'] = double.parse(correctSubtotal.toStringAsFixed(2));
      clientData['total'] = double.parse(correctTotal.toStringAsFixed(2));

      debugPrint(
        'Tax correction (reimbursement fix): '
        'itemsSubtotal=$itemsSubtotal, expensesTotal=$expensesTotal, '
        'taxRate=$taxRate, correctTax=$correctTax, correctTotal=$correctTotal',
      );
    } catch (e) {
      debugPrint('_correctExpenseTaxInClientData error: $e');
    }
  }

  double _safeDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0.0;
  }
}

/// Enum for different sharing methods
enum ShareMethod { link, pdf, email, whatsapp }
