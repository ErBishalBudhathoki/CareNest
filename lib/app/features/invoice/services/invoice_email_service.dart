import 'package:carenest/backend/api_method.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'dart:io';

class InvoiceEmailService {
  final ApiMethod _apiMethod;

  InvoiceEmailService({required ApiMethod apiMethod}) : _apiMethod = apiMethod;

  Future<dynamic> sendInvoiceEmail(
    String pdfPath,
    List<String> invoiceName,
    String endDate,
    String invoiceNumber,
    String email,
    String genKey,
  ) async {
    final apiMethod = _apiMethod;
    await apiMethod.getEmailDetailToSendEmail(email);

    final File pdfFile = File(pdfPath);
    if (!pdfFile.existsSync()) {
      debugPrint('Invoice PDF not found at $pdfPath');
      return 'Error';
    }

    final List<int> pdfBytes = await pdfFile.readAsBytes();
    final String pdfBase64 = base64Encode(pdfBytes);

    final result = await apiMethod.sendInvoiceEmail(
      userEmail: email,
      recipientEmail: email,
      subject: 'Invoice: $invoiceNumber',
      pdfBase64: pdfBase64,
      fileName: 'invoice_$invoiceNumber.pdf',
      invoiceText: 'Please find the attached invoice.',
    );

    if (result['Success'] == true) {
      debugPrint('Invoice email sent via backend: ${result['messageId']}');
      return 'Success';
    }

    debugPrint('Invoice email failed: ${result['Error']}');
    return result['Error'] ?? 'Error';
  }
}
