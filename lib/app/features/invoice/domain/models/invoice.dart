import 'invoice_line_item.dart';

class Invoice {
  final String invoiceNumber;
  final String clientName;
  final String clientAddress;
  final String providerName;
  final String providerABN;
  final DateTime periodStart;
  final DateTime periodEnd;
  final List<InvoiceLineItem> lineItems;
  final DateTime dateIssued;
  final Map<String, dynamic> otherFields;

  Invoice({
    required this.invoiceNumber,
    required this.clientName,
    required this.clientAddress,
    required this.providerName,
    required this.providerABN,
    required this.periodStart,
    required this.periodEnd,
    required this.lineItems,
    required this.dateIssued,
    this.otherFields = const {},
  });

  num get totalAmount => lineItems.fold(0, (sum, item) => sum + item.total);

  Invoice copyWith({
    String? invoiceNumber,
    String? clientName,
    String? clientAddress,
    String? providerName,
    String? providerABN,
    DateTime? periodStart,
    DateTime? periodEnd,
    List<InvoiceLineItem>? lineItems,
    DateTime? dateIssued,
    Map<String, dynamic>? otherFields,
  }) {
    return Invoice(
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      clientName: clientName ?? this.clientName,
      clientAddress: clientAddress ?? this.clientAddress,
      providerName: providerName ?? this.providerName,
      providerABN: providerABN ?? this.providerABN,
      periodStart: periodStart ?? this.periodStart,
      periodEnd: periodEnd ?? this.periodEnd,
      lineItems: lineItems ?? this.lineItems,
      dateIssued: dateIssued ?? this.dateIssued,
      otherFields: otherFields ?? this.otherFields,
    );
  }
}