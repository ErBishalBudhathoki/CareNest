import 'package:flutter/foundation.dart';
import 'package:carenest/config/environment.dart';
import 'package:carenest/app/features/invoice/models/payment_info.dart';
import 'package:carenest/app/features/invoice/models/recurrence_info.dart';

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
  final List<String> receiptUrls;
  final PaymentInfo? payment;
  final RecurrenceInfo? recurrence;

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
    this.receiptUrls = const [],
    this.payment,
    this.recurrence,
  });

  factory InvoiceListModel.fromJson(Map<String, dynamic> json) {
    // Extract receipt URLs from calculatedPayloadData
    List<String> extractedReceiptUrls = [];
    try {
      debugPrint('🔍 InvoiceListModel: Extracting receipt URLs from JSON...');
      if (json['calculatedPayloadData'] != null) {
        debugPrint('🔍 InvoiceListModel: Found calculatedPayloadData');
        final clients = json['calculatedPayloadData']['clients'] as List?;
        if (clients != null && clients.isNotEmpty) {
          final expenses = clients[0]['expenses'] as List?;
          if (expenses != null) {
            debugPrint(
                '🔍 InvoiceListModel: Found ${expenses.length} expenses');
            for (var expense in expenses) {
              if (expense is Map<String, dynamic>) {
                final receiptFiles = expense['receiptFiles'] as List?;
                final receiptPhotos = expense['receiptPhotos'] as List?;
                final receiptUrl = expense['receiptUrl'] as String?;

                debugPrint(
                    '🔍 InvoiceListModel: Expense has - receiptUrl: $receiptUrl, files: ${receiptFiles?.length}, photos: ${receiptPhotos?.length}');

                String? resolveToHttpUrl(String value) {
                  final resolved = AppConfig.resolveResourceUrl(value);
                  if (resolved.startsWith('http://') ||
                      resolved.startsWith('https://')) {
                    return resolved;
                  }
                  return null;
                }

                // Add from receiptFiles
                if (receiptFiles != null) {
                  for (var file in receiptFiles) {
                    if (file is String && file.trim().isNotEmpty) {
                      final fullUrl = resolveToHttpUrl(file.trim());
                      if (fullUrl != null) extractedReceiptUrls.add(fullUrl);
                    }
                  }
                }

                // Add from receiptPhotos
                if (receiptPhotos != null) {
                  for (var photo in receiptPhotos) {
                    if (photo is String && photo.trim().isNotEmpty) {
                      final fullUrl = resolveToHttpUrl(photo.trim());
                      if (fullUrl != null) extractedReceiptUrls.add(fullUrl);
                    }
                  }
                }

                // Add from receiptUrl
                if (receiptUrl != null && receiptUrl.trim().isNotEmpty) {
                  final fullUrl = resolveToHttpUrl(receiptUrl.trim());
                  if (fullUrl != null) extractedReceiptUrls.add(fullUrl);
                }
              }
            }
          } else {
            debugPrint(
                '🔍 InvoiceListModel: No expenses found in calculatedPayloadData');
          }
        }
      } else if (json['extractedReceiptUrls'] != null) {
        // Fallback to cached URLs
        debugPrint('🔍 InvoiceListModel: Using cached extractedReceiptUrls');
        extractedReceiptUrls = List<String>.from(json['extractedReceiptUrls']);
      } else {
        debugPrint(
            '🔍 InvoiceListModel: No calculatedPayloadData or extractedReceiptUrls found');
      }
    } catch (e) {
      debugPrint('Error extracting receipt URLs in InvoiceListModel: $e');
    }

    // Remove duplicates
    extractedReceiptUrls = extractedReceiptUrls.toSet().toList();
    debugPrint(
        '🔍 InvoiceListModel: Final extracted URLs: $extractedReceiptUrls');

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
      receiptUrls: extractedReceiptUrls,
      payment: json['payment'] != null ? PaymentInfo.fromJson(json['payment']) : null,
      recurrence: json['recurrence'] != null ? RecurrenceInfo.fromJson(json['recurrence']) : null,
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
      'deletion': {
        'isDeleted': isDeleted,
      },
      'extractedReceiptUrls': receiptUrls,
      'payment': payment?.toJson(),
      'recurrence': recurrence?.toJson(),
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
    List<String>? receiptUrls,
    PaymentInfo? payment,
    RecurrenceInfo? recurrence,
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
      receiptUrls: receiptUrls ?? this.receiptUrls,
      payment: payment ?? this.payment,
      recurrence: recurrence ?? this.recurrence,
    );
  }
}
