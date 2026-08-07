import 'package:flutter/foundation.dart';

class SendInvoiceService {
  Future<bool> sendInvoice(Map<String, dynamic> invoiceData) async {
    // Simulate sending the invoice
    debugPrint('Sending invoice: $invoiceData');
    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 2));
    // Simulate a successful response
    debugPrint('Invoice sent successfully!');
    return true;
  }
}
