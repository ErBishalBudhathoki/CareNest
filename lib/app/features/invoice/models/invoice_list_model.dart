class InvoiceListModel {
  final String id;
  final String invoiceNumber;
  final String organizationId;
  final String clientName;
  final String clientEmail;
  final DateTime issueDate;
  final DateTime dueDate;
  final double totalAmount;
  final double taxAmount;
  final double subtotalAmount;
  final String status;
  final String paymentStatus;
  final String deliveryStatus;
  final String invoiceType;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? pdfPath;
  final String? shareableLink;
  final bool isDeleted;

  InvoiceListModel({
    required this.id,
    required this.invoiceNumber,
    required this.organizationId,
    required this.clientName,
    required this.clientEmail,
    required this.issueDate,
    required this.dueDate,
    required this.totalAmount,
    required this.taxAmount,
    required this.subtotalAmount,
    required this.status,
    required this.paymentStatus,
    required this.deliveryStatus,
    required this.invoiceType,
    required this.createdAt,
    required this.updatedAt,
    this.pdfPath,
    this.shareableLink,
    this.isDeleted = false,
  });

  factory InvoiceListModel.fromJson(Map<String, dynamic> json) {
    return InvoiceListModel(
      id: json['_id'] ?? '',
      invoiceNumber: json['invoiceNumber'] ?? '',
      organizationId: json['organizationId'] ?? '',
      clientName: json['clientName'] ?? '',
      clientEmail: json['clientEmail'] ?? '',
      issueDate: DateTime.parse(
          json['auditTrail']?['createdAt'] ?? DateTime.now().toIso8601String()),
      dueDate: DateTime.parse(json['financialSummary']?['dueDate'] ??
          DateTime.now().toIso8601String()),
      totalAmount: (json['financialSummary']?['totalAmount'] ?? 0.0).toDouble(),
      taxAmount: (json['financialSummary']?['taxAmount'] ?? 0.0).toDouble(),
      subtotalAmount: (json['financialSummary']?['subtotal'] ?? 0.0).toDouble(),
      status: json['workflow']?['status'] ?? 'draft',
      paymentStatus: json['payment']?['status'] ?? 'pending',
      deliveryStatus: json['delivery']?['status'] ?? 'pending',
      invoiceType: json['metadata']?['invoiceType'] ?? 'standard',
      createdAt: DateTime.parse(
          json['auditTrail']?['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(
          json['auditTrail']?['updatedAt'] ?? DateTime.now().toIso8601String()),
      pdfPath: json['metadata']?['pdfPath'],
      shareableLink: json['sharing']?['shareableLink'],
      isDeleted: json['deletion']?['isDeleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'invoiceNumber': invoiceNumber,
      'organizationId': organizationId,
      'clientInfo': {
        'name': clientName,
        'email': clientEmail,
      },
      'issueDate': issueDate.toIso8601String(),
      'dueDate': dueDate.toIso8601String(),
      'financialSummary': {
        'totalAmount': totalAmount,
        'taxAmount': taxAmount,
        'subtotalAmount': subtotalAmount,
      },
      'workflowStatus': {
        'status': status,
      },
      'paymentStatus': paymentStatus,
      'deliveryStatus': deliveryStatus,
      'invoiceType': invoiceType,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deliveryInfo': {
        'pdfPath': pdfPath,
      },
      'sharing': {
        'shareableLink': shareableLink,
      },
      'isDeleted': isDeleted,
    };
  }

  InvoiceListModel copyWith({
    String? id,
    String? invoiceNumber,
    String? organizationId,
    String? clientName,
    String? clientEmail,
    DateTime? issueDate,
    DateTime? dueDate,
    double? totalAmount,
    double? taxAmount,
    double? subtotalAmount,
    String? status,
    String? paymentStatus,
    String? deliveryStatus,
    String? invoiceType,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? pdfPath,
    String? shareableLink,
    bool? isDeleted,
  }) {
    return InvoiceListModel(
      id: id ?? this.id,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      organizationId: organizationId ?? this.organizationId,
      clientName: clientName ?? this.clientName,
      clientEmail: clientEmail ?? this.clientEmail,
      issueDate: issueDate ?? this.issueDate,
      dueDate: dueDate ?? this.dueDate,
      totalAmount: totalAmount ?? this.totalAmount,
      taxAmount: taxAmount ?? this.taxAmount,
      subtotalAmount: subtotalAmount ?? this.subtotalAmount,
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      deliveryStatus: deliveryStatus ?? this.deliveryStatus,
      invoiceType: invoiceType ?? this.invoiceType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      pdfPath: pdfPath ?? this.pdfPath,
      shareableLink: shareableLink ?? this.shareableLink,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
