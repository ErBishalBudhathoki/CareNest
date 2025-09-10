import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

/// Extension methods for expense calculations and transformations
extension ExpenseListExtension on List<ExpenseModel> {
  /// Calculates the total amount of all expenses in the list
  double get totalAmount =>
      fold<double>(0.0, (sum, expense) => sum + (expense.amount ?? 0.0));

  /// Filters expenses by status and returns a new list
  List<ExpenseModel> filterByStatus(String status) =>
      where((e) => e.status == status).toList();

  /// Calculates the total amount of expenses with a specific status
  double totalAmountByStatus(String status) => filterByStatus(status)
      .fold<double>(0.0, (sum, expense) => sum + (expense.amount ?? 0.0));

  /// Groups expenses by category and returns a map of category to total amount
  Map<String, double> groupByCategory({String? filterStatus}) {
    final filteredList =
        filterStatus != null ? filterByStatus(filterStatus) : this;
    return filteredList.fold<Map<String, double>>(
      {},
      (map, expense) {
        final category = expense.category;
        final amount = expense.amount ?? 0.0;
        map[category] = (map[category] ?? 0.0) + amount;
        return map;
      },
    );
  }

  /// Returns a sorted list of category entries by amount (descending)
  List<MapEntry<String, double>> sortedCategoriesByAmount(
      {String? filterStatus}) {
    final categoryMap = groupByCategory(filterStatus: filterStatus);
    final sortedEntries = categoryMap.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sortedEntries;
  }
}

class ExpenseModel {
  final String id;
  final String title;
  final double amount;
  final String category;
  final DateTime date;
  final String? description;
  final String? receiptUrl;
  final List<String>? receiptPhotos; // List of photo file paths
  final List<String>?
      receiptFiles; // List of all receipt file paths (images, PDFs, Word docs)
  final String? photoDescription; // Description for the photos
  final String? fileDescription; // Description for all attached files
  final String status; // 'pending', 'approved', 'rejected'
  final String submittedBy;
  final String? approvedBy;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isRecurring;
  final String? recurringFrequency; // 'daily', 'weekly', 'monthly', 'yearly'
  final String organizationId;
  final String? clientId; // Optional client attachment for expense allocation

  ExpenseModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    this.description,
    this.receiptUrl,
    this.receiptPhotos,
    this.receiptFiles,
    this.photoDescription,
    this.fileDescription,
    required this.status,
    required this.submittedBy,
    this.approvedBy,
    required this.createdAt,
    this.updatedAt,
    required this.isRecurring,
    this.recurringFrequency,
    required this.organizationId,
    this.clientId,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    debugPrint('=== EXPENSE MODEL DEBUG: Parsing JSON: $json ===');

    // Debug ID parsing
    final id = json['_id'] is Map && json['_id']['\$oid'] != null
        ? json['_id']['\$oid']
        : json['_id'].toString();
    debugPrint('=== EXPENSE MODEL DEBUG: Parsed ID: $id ===');

    // Debug title parsing
    final title = json['supportItemName'] ?? json['description'] ?? 'Expense';
    debugPrint('=== EXPENSE MODEL DEBUG: Parsed title: $title ===');

    // Debug amount parsing
    final amount = (json['amount'] as num).toDouble();
    debugPrint('=== EXPENSE MODEL DEBUG: Parsed amount: $amount ===');

    // Debug category parsing
    final category = json['category'] as String;
    debugPrint('=== EXPENSE MODEL DEBUG: Parsed category: $category ===');

    // Debug date parsing
    DateTime date;
    debugPrint(
        '=== EXPENSE MODEL DEBUG: expenseDate raw: ${json['expenseDate']} ===');
    debugPrint(
        '=== EXPENSE MODEL DEBUG: expenseDate type: ${json['expenseDate'].runtimeType} ===');

    if (json['expenseDate'] is String) {
      date = DateTime.parse(json['expenseDate']);
      debugPrint('=== EXPENSE MODEL DEBUG: Parsed date from string: $date ===');
    } else if (json['expenseDate'] is Map &&
        json['expenseDate']['\$date'] != null) {
      if (json['expenseDate']['\$date'] is Map &&
          json['expenseDate']['\$date']['\$numberLong'] != null) {
        // Handle MongoDB extended JSON format
        final timestamp =
            int.parse(json['expenseDate']['\$date']['\$numberLong']);
        date = DateTime.fromMillisecondsSinceEpoch(timestamp);
        debugPrint(
            '=== EXPENSE MODEL DEBUG: Parsed date from MongoDB extended JSON: $date ===');
      } else {
        date =
            DateTime.fromMillisecondsSinceEpoch(json['expenseDate']['\$date']);
        debugPrint('=== EXPENSE MODEL DEBUG: Parsed date from \$date: $date ===');
      }
    } else if (json['expenseDate'] is int) {
      date = DateTime.fromMillisecondsSinceEpoch(json['expenseDate']);
      debugPrint('=== EXPENSE MODEL DEBUG: Parsed date from timestamp: $date ===');
    } else {
      throw Exception('Unsupported expenseDate format: ${json['expenseDate']}');
    }

    // Debug status parsing
    final status = json['approvalStatus'] as String;
    debugPrint('=== EXPENSE MODEL DEBUG: Parsed status: $status ===');

    // Debug submittedBy parsing
    final submittedBy = json['submittedBy'] as String;
    debugPrint('=== EXPENSE MODEL DEBUG: Parsed submittedBy: $submittedBy ===');

    // Debug createdAt parsing
    DateTime createdAt;
    debugPrint('=== EXPENSE MODEL DEBUG: createdAt raw: ${json['createdAt']} ===');

    if (json['createdAt'] is String) {
      createdAt = DateTime.parse(json['createdAt']);
    } else if (json['createdAt'] is Map &&
        json['createdAt']['\$date'] != null) {
      if (json['createdAt']['\$date'] is Map &&
          json['createdAt']['\$date']['\$numberLong'] != null) {
        final timestamp =
            int.parse(json['createdAt']['\$date']['\$numberLong']);
        createdAt = DateTime.fromMillisecondsSinceEpoch(timestamp);
      } else {
        createdAt =
            DateTime.fromMillisecondsSinceEpoch(json['createdAt']['\$date']);
      }
    } else if (json['createdAt'] is int) {
      createdAt = DateTime.fromMillisecondsSinceEpoch(json['createdAt']);
    } else {
      throw Exception('Unsupported createdAt format: ${json['createdAt']}');
    }
    debugPrint('=== EXPENSE MODEL DEBUG: Parsed createdAt: $createdAt ===');

    // Parse receiptUrl, receiptPhotos, and receiptFiles
    final receiptUrl = json['receiptUrl']?.toString();
    debugPrint('=== EXPENSE MODEL DEBUG: Parsed receiptUrl: $receiptUrl ===');

    final receiptPhotos = json['receiptPhotos'] != null
        ? List<String>.from(json['receiptPhotos'])
        : null;
    debugPrint('=== EXPENSE MODEL DEBUG: Parsed receiptPhotos: $receiptPhotos ===');

    final receiptFiles = json['receiptFiles'] != null
        ? List<String>.from(json['receiptFiles'])
        : null;
    debugPrint('=== EXPENSE MODEL DEBUG: Parsed receiptFiles: $receiptFiles ===');

    final photoDescription = json['photoDescription']?.toString();
    debugPrint(
        '=== EXPENSE MODEL DEBUG: Parsed photoDescription: $photoDescription ===');

    final fileDescription = json['fileDescription']?.toString();
    debugPrint(
        '=== EXPENSE MODEL DEBUG: Parsed fileDescription: $fileDescription ===');

    // Debug organizationId parsing
    final organizationId = json['organizationId'] as String;
    debugPrint(
        '=== EXPENSE MODEL DEBUG: Parsed organizationId: $organizationId ===');

    final expense = ExpenseModel(
      id: id,
      title: title,
      amount: amount,
      category: category,
      date: date,
      description: json['description'] as String?,
      receiptUrl: receiptUrl,
      receiptPhotos: receiptPhotos,
      receiptFiles: receiptFiles,
      photoDescription: photoDescription,
      fileDescription: fileDescription,
      status: status,
      submittedBy: submittedBy,
      approvedBy: json['approvedBy'] as String?,
      createdAt: createdAt,
      updatedAt: json['updatedAt'] != null
          ? (json['updatedAt'] is String
              ? DateTime.parse(json['updatedAt'])
              : (json['updatedAt'] is Map && json['updatedAt']['\$date'] != null
                  ? (json['updatedAt']['\$date'] is Map &&
                          json['updatedAt']['\$date']['\$numberLong'] != null
                      ? DateTime.fromMillisecondsSinceEpoch(int.parse(
                          json['updatedAt']['\$date']['\$numberLong']))
                      : DateTime.fromMillisecondsSinceEpoch(
                          json['updatedAt']['\$date']))
                  : (json['updatedAt'] is int
                      ? DateTime.fromMillisecondsSinceEpoch(json['updatedAt'])
                      : throw Exception(
                          'Unsupported updatedAt format: ${json['updatedAt']}'))))
          : null,
      isRecurring: json['isRecurring'] ?? false,
      recurringFrequency: json['recurringFrequency'] as String?,
      organizationId: organizationId,
      clientId: json['clientId'] as String?,
    );

    debugPrint(
        '=== EXPENSE MODEL DEBUG: Successfully created ExpenseModel: ${expense.id} - ${expense.title} ===');
    return expense;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': category,
      'date': date.toIso8601String(),
      'description': description,
      'receiptUrl': receiptUrl,
      'receiptPhotos': receiptPhotos,
      'receiptFiles': receiptFiles,
      'photoDescription': photoDescription,
      'fileDescription': fileDescription,
      'status': status,
      'submittedBy': submittedBy,
      'approvedBy': approvedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'isRecurring': isRecurring,
      'recurringFrequency': recurringFrequency,
      'organizationId': organizationId,
      'clientId': clientId,
    };
  }

  ExpenseModel copyWith({
    String? id,
    String? title,
    double? amount,
    String? category,
    DateTime? date,
    String? description,
    String? receiptUrl,
    List<String>? receiptPhotos,
    List<String>? receiptFiles,
    String? photoDescription,
    String? fileDescription,
    String? status,
    String? submittedBy,
    String? approvedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isRecurring,
    String? recurringFrequency,
    String? organizationId,
    String? clientId,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      date: date ?? this.date,
      description: description ?? this.description,
      receiptUrl: receiptUrl ?? this.receiptUrl,
      receiptPhotos: receiptPhotos ?? this.receiptPhotos,
      receiptFiles: receiptFiles ?? this.receiptFiles,
      photoDescription: photoDescription ?? this.photoDescription,
      fileDescription: fileDescription ?? this.fileDescription,
      status: status ?? this.status,
      submittedBy: submittedBy ?? this.submittedBy,
      approvedBy: approvedBy ?? this.approvedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isRecurring: isRecurring ?? this.isRecurring,
      recurringFrequency: recurringFrequency ?? this.recurringFrequency,
      organizationId: organizationId ?? this.organizationId,
      clientId: clientId ?? this.clientId,
    );
  }
}
