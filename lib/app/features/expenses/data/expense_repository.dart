import 'dart:io';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/expenses/models/expense_model.dart';
import '../../../core/services/file_upload_service.dart';

class ExpenseRepository {
  final ApiMethod _apiMethod;
  late final FileUploadService _fileUploadService;

  ExpenseRepository(this._apiMethod) {
    _fileUploadService = FileUploadService(api: _apiMethod);
  }

  /// Fetches all expenses for an organization
  Future<List<ExpenseModel>> getOrganizationExpenses(
    String organizationId,
  ) async {
    try {
      final response = await _apiMethod.get(
        'expenses/organization/$organizationId',
      );
      // Backend returns statusCode: 200 and data field containing expenses
      if (response['statusCode'] == 200 && response['data'] != null) {
        final List<dynamic> expensesJson = response['data'];
        // Debug each expense record
        for (int i = 0; i < expensesJson.length; i++) {}

        final expenses = expensesJson.map((json) {
          try {
            final expense = ExpenseModel.fromJson(json);
            return expense;
          } catch (e) {
            rethrow;
          }
        }).toList();
        return expenses;
      } else {
        throw Exception(response['message'] ?? 'Failed to fetch expenses');
      }
    } catch (e) {
      throw Exception('Error fetching expenses: $e');
    }
  }

  /// Creates a new expense
  Future<ExpenseModel> createExpense(ExpenseModel expense) async {
    try {
      List<String>? uploadedReceiptFiles;
      List<String>? uploadedReceiptPhotos;
      String? uploadedReceiptUrl;

      // Upload all receipt files if they exist and are local files
      if (expense.receiptFiles != null && expense.receiptFiles!.isNotEmpty) {
        final List<String> serverUrls = [];
        final List<String> photoUrls = [];

        for (String filePath in expense.receiptFiles!) {
          // Check if this is a local file path or already a server URL
          if (!filePath.startsWith('http://') &&
              !filePath.startsWith('https://')) {
            final receiptFile = File(filePath);
            if (await receiptFile.exists()) {
              try {
                final serverUrl = await _fileUploadService.uploadReceiptFile(
                  receiptFile,
                );
                serverUrls.add(serverUrl);

                // If it's an image, also add to photos array for backward compatibility
                if (_isImageFile(filePath)) {
                  photoUrls.add(serverUrl);
                }
              } catch (e) {
                throw Exception(
                  'Failed to upload file: ${filePath.split('/').last}. Please try again.',
                );
              }
            } else {
              throw Exception('File not found: ${filePath.split('/').last}');
            }
          } else {
            // Already a server URL, keep as is
            serverUrls.add(filePath);
            if (_isImageFile(filePath)) {
              photoUrls.add(filePath);
            }
          }
        }

        uploadedReceiptFiles = serverUrls;
        uploadedReceiptPhotos = photoUrls.isNotEmpty ? photoUrls : null;
        uploadedReceiptUrl = photoUrls.isNotEmpty
            ? photoUrls.first
            : null; // Backward compatibility
      }
      // Fallback to single receiptUrl if receiptFiles is empty
      else if (expense.receiptUrl != null && expense.receiptUrl!.isNotEmpty) {
        if (!expense.receiptUrl!.startsWith('http://') &&
            !expense.receiptUrl!.startsWith('https://')) {
          final receiptFile = File(expense.receiptUrl!);
          if (await receiptFile.exists()) {
            try {
              uploadedReceiptUrl = await _fileUploadService.uploadReceiptFile(
                receiptFile,
              );
              uploadedReceiptFiles = [uploadedReceiptUrl];
              if (_isImageFile(expense.receiptUrl!)) {
                uploadedReceiptPhotos = [uploadedReceiptUrl];
              }
            } catch (e) {
              throw Exception(
                'Failed to upload receipt file. Please try again.',
              );
            }
          } else {
            throw Exception(
              'Receipt file not found. Please select the file again.',
            );
          }
        } else {
          uploadedReceiptUrl = expense.receiptUrl;
          uploadedReceiptFiles = [expense.receiptUrl!];
          if (_isImageFile(expense.receiptUrl!)) {
            uploadedReceiptPhotos = [expense.receiptUrl!];
          }
        }
      }

      // Map frontend fields to backend expected fields
      final requestBody = {
        'organizationId': expense.organizationId,
        'expenseDate': expense.date.toIso8601String(),
        'amount': expense.amount,
        'description': expense.title, // Map title to description for backend
        'category': expense.category,
        'userEmail': expense.submittedBy,
        'receiptUrl': uploadedReceiptUrl, // Backward compatibility
        'receiptFiles': uploadedReceiptFiles, // New field for multiple files
        'receiptPhotos': uploadedReceiptPhotos, // New field for photos
        'fileDescription': expense.fileDescription,
        'photoDescription': expense.photoDescription,
        'notes': expense.description, // Additional description goes to notes
        'requiresApproval': expense.status == 'pending',
        'isReimbursable': true, // Default to true
      };

      // Add clientId only if it exists
      if (expense.clientId != null && expense.clientId!.isNotEmpty) {
        requestBody['clientId'] = expense.clientId;
      }
      final response = await _apiMethod.post(
        'expenses/create',
        body: requestBody,
      );
      final expenseId = response['expenseId'] ?? response['data']?['expenseId'];
      if (response['statusCode'] == 201 && expenseId != null) {
        // Return the expense with the generated ID and uploaded file URLs
        final updatedExpense = expense.copyWith(
          id: expenseId.toString(),
          receiptUrl: uploadedReceiptUrl,
          receiptFiles: uploadedReceiptFiles,
          receiptPhotos: uploadedReceiptPhotos,
        );
        return updatedExpense;
      } else {
        throw Exception(response['message'] ?? 'Failed to create expense');
      }
    } catch (e) {
      throw Exception('Error creating expense: $e');
    }
  }

  /// Helper method to check if a file is an image
  bool _isImageFile(String filePath) {
    final extension = filePath.toLowerCase().split('.').last;
    return ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].contains(extension);
  }

  /// Updates an existing expense
  Future<ExpenseModel> updateExpense(ExpenseModel expense) async {
    try {
      List<String>? uploadedReceiptFiles;
      List<String>? uploadedReceiptPhotos;
      String? uploadedReceiptUrl;

      // Handle file uploads for update - upload only new local files
      if (expense.receiptFiles != null && expense.receiptFiles!.isNotEmpty) {
        final List<String> serverUrls = [];
        final List<String> photoUrls = [];

        for (String filePath in expense.receiptFiles!) {
          // Check if this is a local file path or already a server URL
          if (!filePath.startsWith('http://') &&
              !filePath.startsWith('https://')) {
            final receiptFile = File(filePath);
            if (await receiptFile.exists()) {
              try {
                final serverUrl = await _fileUploadService.uploadReceiptFile(
                  receiptFile,
                );
                serverUrls.add(serverUrl);

                // If it's an image, also add to photos array for backward compatibility
                if (_isImageFile(filePath)) {
                  photoUrls.add(serverUrl);
                }
              } catch (e) {
                throw Exception(
                  'Failed to upload file: ${filePath.split('/').last}. Please try again.',
                );
              }
            } else {
              throw Exception('File not found: ${filePath.split('/').last}');
            }
          } else {
            // Already a server URL, keep as is
            serverUrls.add(filePath);
            if (_isImageFile(filePath)) {
              photoUrls.add(filePath);
            }
          }
        }

        uploadedReceiptFiles = serverUrls;
        uploadedReceiptPhotos = photoUrls.isNotEmpty ? photoUrls : null;
        uploadedReceiptUrl = photoUrls.isNotEmpty
            ? photoUrls.first
            : null; // Backward compatibility
      }
      // Fallback to single receiptUrl if receiptFiles is empty
      else if (expense.receiptUrl != null && expense.receiptUrl!.isNotEmpty) {
        if (!expense.receiptUrl!.startsWith('http://') &&
            !expense.receiptUrl!.startsWith('https://')) {
          final receiptFile = File(expense.receiptUrl!);
          if (await receiptFile.exists()) {
            try {
              uploadedReceiptUrl = await _fileUploadService.uploadReceiptFile(
                receiptFile,
              );
              uploadedReceiptFiles = [uploadedReceiptUrl];
              if (_isImageFile(expense.receiptUrl!)) {
                uploadedReceiptPhotos = [uploadedReceiptUrl];
              }
            } catch (e) {
              throw Exception(
                'Failed to upload receipt file. Please try again.',
              );
            }
          } else {
            throw Exception(
              'Receipt file not found. Please select the file again.',
            );
          }
        } else {
          uploadedReceiptUrl = expense.receiptUrl;
          uploadedReceiptFiles = [expense.receiptUrl!];
          if (_isImageFile(expense.receiptUrl!)) {
            uploadedReceiptPhotos = [expense.receiptUrl!];
          }
        }
      }

      // Map frontend fields to backend expected fields for update
      final requestBody = {
        'organizationId': expense.organizationId,
        'expenseDate': expense.date.toIso8601String(),
        'amount': expense.amount,
        'description': expense.title, // Map title to description for backend
        'category': expense.category,
        'userEmail': expense.submittedBy,
        'receiptUrl': uploadedReceiptUrl, // Backward compatibility
        'receiptFiles': uploadedReceiptFiles, // New field for multiple files
        'receiptPhotos': uploadedReceiptPhotos, // New field for photos
        'fileDescription': expense.fileDescription,
        'photoDescription': expense.photoDescription,
        'notes': expense.description, // Additional description goes to notes
        'requiresApproval': expense.status == 'pending',
        'isReimbursable': true, // Default to true
        'status': expense.status,
      };

      // Add clientId only if it exists
      if (expense.clientId != null && expense.clientId!.isNotEmpty) {
        requestBody['clientId'] = expense.clientId;
      }

      final response = await _apiMethod.put(
        'expenses/${expense.id}',
        body: requestBody,
      );
      if (response['statusCode'] == 200) {
        final directExpense =
            response['expense'] ?? response['data']?['expense'];
        if (directExpense is Map<String, dynamic>) {
          return ExpenseModel.fromJson(directExpense);
        }

        final latest = await _apiMethod.get('expenses/${expense.id}');
        final latestExpense = latest['expense'] ?? latest['data'];
        if (latestExpense is Map<String, dynamic>) {
          return ExpenseModel.fromJson(latestExpense);
        }

        return expense.copyWith(updatedAt: DateTime.now());
      }

      throw Exception(response['message'] ?? 'Failed to update expense');
    } catch (e) {
      throw Exception('Error updating expense: $e');
    }
  }

  /// Deletes an expense
  Future<bool> deleteExpense(String expenseId) async {
    try {
      final response = await _apiMethod.delete('expenses/$expenseId');

      if (response['success'] == true || response['statusCode'] == 200) {
        return true;
      } else {
        throw Exception(response['message'] ?? 'Failed to delete expense');
      }
    } catch (e) {
      throw Exception('Error deleting expense: $e');
    }
  }

  /// Approves an expense
  Future<bool> approveExpense(String expenseId, String approverEmail) async {
    try {
      final response = await _apiMethod.put(
        'expenses/$expenseId/approval',
        body: {
          'status': 'approved',
          'approvalStatus': 'approved',
          'approvedBy': approverEmail,
          'userEmail': approverEmail,
        },
      );

      // Backend returns statusCode, message, and approvalStatus
      if (response['statusCode'] == 200) {
        return true;
      } else {
        throw Exception(response['message'] ?? 'Failed to approve expense');
      }
    } catch (e) {
      throw Exception('Error approving expense: $e');
    }
  }

  /// Rejects an expense
  Future<bool> rejectExpense(String expenseId, String approverEmail) async {
    try {
      final response = await _apiMethod.put(
        'expenses/$expenseId/approval',
        body: {
          'status': 'rejected',
          'approvalStatus': 'rejected',
          'approvedBy': approverEmail,
          'userEmail': approverEmail,
        },
      );

      // Backend returns statusCode, message, and approvalStatus
      if (response['statusCode'] == 200) {
        return true;
      } else {
        throw Exception(response['message'] ?? 'Failed to reject expense');
      }
    } catch (e) {
      throw Exception('Error rejecting expense: $e');
    }
  }

  /// Gets expense categories
  Future<List<String>> getExpenseCategories() async {
    try {
      final response = await _apiMethod.get('expenses/categories');
      if (response['statusCode'] == 200) {
        final dynamic categoriesRaw =
            response['categories'] ?? response['data'];
        if (categoriesRaw is List) {
          return categoriesRaw.map((c) => c.toString()).toList();
        }
        if (categoriesRaw is Map<String, dynamic>) {
          return categoriesRaw.values
              .map(
                (entry) => (entry is Map && entry['name'] != null)
                    ? entry['name'].toString()
                    : entry.toString(),
              )
              .toList();
        }
      }
      throw Exception(
        response['message'] ?? 'Failed to fetch expense categories',
      );
    } catch (e) {
      throw Exception('Error fetching expense categories: $e');
    }
  }

  /// Gets recurring expenses for an organization
  Future<List<ExpenseModel>> getRecurringExpenses(String organizationId) async {
    try {
      final response = await _apiMethod.get(
        'recurring-expenses/templates/$organizationId',
      );

      if (response['statusCode'] == 200 && response['data'] is List<dynamic>) {
        final List<dynamic> expensesJson = response['data'];
        return expensesJson.map((json) => ExpenseModel.fromJson(json)).toList();
      }

      if (response['statusCode'] == 404) {
        return [];
      }

      throw Exception(
        response['message'] ?? 'Failed to fetch recurring expenses',
      );
    } catch (e) {
      throw Exception('Error fetching recurring expenses: $e');
    }
  }

  /// Gets expense statistics for an organization
  Future<Map<String, dynamic>> getExpenseStatistics(
    String organizationId,
  ) async {
    try {
      final response = await _apiMethod.get(
        'expenses/statistics/$organizationId',
      );

      if (response['success'] == true) {
        return response['statistics'];
      } else {
        throw Exception(
          response['message'] ?? 'Failed to fetch expense statistics',
        );
      }
    } catch (e) {
      throw Exception('Error fetching expense statistics: $e');
    }
  }
}
