// invoice_line_item.dart

enum LineItemSource {
  ndisMatcherAlgorithm,
  manualPlaceholder,
  userAdded,
}

enum PriceComplianceStatus {
  compliant,        // Price is within NDIS caps
  nonCompliant,     // Price exceeds NDIS caps
  unknown,          // Validation not performed or failed
  manuallyResolved, // Price was manually provided via price prompt
  validating,       // Price validation is in progress
  missingItem,      // NDIS item number not found
  quoteRequired,    // Item requires a quote for approval
  missingPricing,   // Price information is missing
  abovePriceCap,    // Price exceeds the maximum allowed cap
}

class InvoiceLineItem {
  String? id; // Unique identifier for the line item
  String description;
  double quantity;
  double unitPrice;
  String type;
  String? ndisItemNumber; // NDIS support item number for price validation
  LineItemSource source; // Ensure this field exists
  // int? matcherScore; // This would be null if NDISMatcher doesn't return score
  DateTime? serviceDate; // Date when the service was provided
  
  // Enhanced price validation fields
  PriceComplianceStatus complianceStatus;
  String? validationMessage;
  double? recommendedPrice;
  double? excessAmount;
  double? priceCap;
  bool? isQuoteRequired;
  String? overrideReason;
  String? validationId; // For tracking validation requests

  InvoiceLineItem({
    this.id,
    required this.description,
    required this.quantity,
    required this.unitPrice,
    required this.type,
    this.ndisItemNumber,
    this.source = LineItemSource.userAdded, // Default for items added via UI
    // this.matcherScore,
    this.serviceDate,
    this.complianceStatus = PriceComplianceStatus.unknown,
    this.validationMessage,
    this.recommendedPrice,
    this.excessAmount,
    this.priceCap,
    this.isQuoteRequired,
    this.overrideReason,
    this.validationId,
  });

  double get total => quantity * unitPrice;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'type': type,
      'ndisItemNumber': ndisItemNumber,
      'total': total,
      'source': source.toString(),
      // 'matcherScore': matcherScore,
      'serviceDate': serviceDate?.toIso8601String(),
      'complianceStatus': complianceStatus.toString(),
      'validationMessage': validationMessage,
      'recommendedPrice': recommendedPrice,
      'excessAmount': excessAmount,
      'priceCap': priceCap,
      'isQuoteRequired': isQuoteRequired,
      'overrideReason': overrideReason,
      'validationId': validationId,
    };
  }

  InvoiceLineItem copyWith({
    String? id,
    String? description,
    double? quantity,
    double? unitPrice,
    String? type,
    String? ndisItemNumber,
    LineItemSource? source,
    // int? matcherScore,
    // bool clearMatcherScore = false,
    DateTime? serviceDate,
    PriceComplianceStatus? complianceStatus,
    String? validationMessage,
    double? recommendedPrice,
    double? excessAmount,
    double? priceCap,
    bool? isQuoteRequired,
    String? overrideReason,
    String? validationId,
  }) {
    return InvoiceLineItem(
      id: id ?? this.id,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      type: type ?? this.type,
      ndisItemNumber: ndisItemNumber ?? this.ndisItemNumber,
      source: source ?? this.source,
      // matcherScore: clearMatcherScore ? null : (matcherScore ?? this.matcherScore),
      serviceDate: serviceDate ?? this.serviceDate,
      complianceStatus: complianceStatus ?? this.complianceStatus,
      validationMessage: validationMessage ?? this.validationMessage,
      recommendedPrice: recommendedPrice ?? this.recommendedPrice,
      excessAmount: excessAmount ?? this.excessAmount,
      priceCap: priceCap ?? this.priceCap,
      isQuoteRequired: isQuoteRequired ?? this.isQuoteRequired,
      overrideReason: overrideReason ?? this.overrideReason,
      validationId: validationId ?? this.validationId,
    );
  }
}
