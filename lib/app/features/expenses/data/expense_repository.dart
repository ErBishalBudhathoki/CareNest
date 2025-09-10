import 'dart:convert';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/expenses/models/expense_model.dart';
import '../../../core/services/file_upload_service.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class ExpenseRepository {
  final ApiMethod _apiMethod;
  late final FileUploadService _fileUploadService;

  ExpenseRepository(this._apiMethod) {
    _fileUploadService = FileUploadService();
  }

  /// Fetches all expenses for an organization
  Future<List<ExpenseModel>> getOrganizationExpenses(
      String organizationId) async {
    try {
      debugPrint(
          '=== EXPENSE REPO DEBUG: Fetching expenses for organizationId: $organizationId ===');
      final response = await _apiMethod.get(
        'api/expenses/organization/$organizationId',
      );

      debugPrint('=== EXPENSE REPO DEBUG: API Response: $response ===');
      debugPrint(
          '=== EXPENSE REPO DEBUG: Response statusCode: ${response['statusCode']} ===');
      debugPrint(
          '=== EXPENSE REPO DEBUG: Response data: ${response['data']} ===');
      debugPrint(
          '=== EXPENSE REPO DEBUG: Response data type: ${response['data'].runtimeType} ===');
      debugPrint(
          '=== EXPENSE REPO DEBUG: Response data length: ${response['data']?.length} ===');

      // Backend returns statusCode: 200 and data field containing expenses
      if (response['statusCode'] == 200 && response['data'] != null) {
        final List<dynamic> expensesJson = response['data'];
        debugPrint(
            '=== EXPENSE REPO DEBUG: Processing ${expensesJson.length} expenses ===');

        // Debug each expense record
        for (int i = 0; i < expensesJson.length; i++) {
          debugPrint(
              '=== EXPENSE REPO DEBUG: Expense $i: ${expensesJson[i]} ===');
        }

        final expenses = expensesJson.map((json) {
          try {
            final expense = ExpenseModel.fromJson(json);
            debugPrint(
                '=== EXPENSE REPO DEBUG: Successfully parsed expense: ${expense.id} - ${expense.title} ===');
            return expense;
          } catch (e) {
            debugPrint(
                '=== EXPENSE REPO DEBUG: Error parsing expense: $json ===');
            debugPrint('=== EXPENSE REPO DEBUG: Parse error: $e ===');
            rethrow;
          }
        }).toList();

        debugPrint(
            '=== EXPENSE REPO DEBUG: Returning ${expenses.length} expenses ===');
        return expenses;
      } else {
        debugPrint(
            '=== EXPENSE REPO DEBUG: API call failed - statusCode: ${response['statusCode']}, message: ${response['message']} ===');
        throw Exception(response['message'] ?? 'Failed to fetch expenses');
      }
    } catch (e) {
      debugPrint(
          '=== EXPENSE REPO DEBUG: Exception in getOrganizationExpenses: $e ===');
      throw Exception('Error fetching expenses: $e');
    }
  }

  /// Creates a new expense
  Future<ExpenseModel> createExpense(ExpenseModel expense) async {
    debugPrint('=== EXPENSE REPO DEBUG: createExpense method started ===');
    debugPrint('=== EXPENSE REPO DEBUG: Input expense ID: ${expense.id} ===');
    debugPrint(
        '=== EXPENSE REPO DEBUG: Input expense title: ${expense.title} ===');
    debugPrint(
        '=== EXPENSE REPO DEBUG: Input expense amount: ${expense.amount} ===');

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
                final serverUrl =
                    await _fileUploadService.uploadReceiptFile(receiptFile);
                serverUrls.add(serverUrl);

                // If it's an image, also add to photos array for backward compatibility
                if (_isImageFile(filePath)) {
                  photoUrls.add(serverUrl);
                }

                debugPrint('Successfully uploaded receipt file: $serverUrl');
              } catch (e) {
                debugPrint('Failed to upload receipt file $filePath: $e');
                throw Exception(
                    'Failed to upload file: ${filePath.split('/').last}. Please try again.');
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
              uploadedReceiptUrl =
                  await _fileUploadService.uploadReceiptFile(receiptFile);
              uploadedReceiptFiles = [uploadedReceiptUrl];
              if (_isImageFile(expense.receiptUrl!)) {
                uploadedReceiptPhotos = [uploadedReceiptUrl];
              }
              debugPrint(
                  'Successfully uploaded receipt file: $uploadedReceiptUrl');
            } catch (e) {
              debugPrint('Failed to upload receipt file: $e');
              throw Exception(
                  'Failed to upload receipt file. Please try again.');
            }
          } else {
            throw Exception(
                'Receipt file not found. Please select the file again.');
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

      debugPrint('=== EXPENSE REPO DEBUG: Starting createExpense method ===');
      debugPrint('=== EXPENSE REPO DEBUG: Base URL: ${_apiMethod.baseUrl} ===');
      debugPrint(
          '=== EXPENSE REPO DEBUG: Full URL will be: ${_apiMethod.baseUrl}api/expenses/create ===');
      debugPrint(
          '=== EXPENSE REPO DEBUG: Request body (string): ${requestBody.toString()} ===');
      debugPrint(
          '=== EXPENSE REPO DEBUG: Request body (JSON encoded): ${json.encode(requestBody)} ===');
      debugPrint(
          '=== EXPENSE REPO DEBUG: Request body keys: ${requestBody.keys.toList()} ===');
      debugPrint(
          '=== EXPENSE REPO DEBUG: Request body values: ${requestBody.values.toList()} ===');

      debugPrint('=== EXPENSE REPO DEBUG: About to make API call ===');
      debugPrint(
          '=== EXPENSE REPO DEBUG: API base URL: ${_apiMethod.baseUrl} ===');
      debugPrint(
          '=== EXPENSE REPO DEBUG: API endpoint: api/expenses/create ===');
      debugPrint(
          '=== EXPENSE REPO DEBUG: Full URL will be: ${_apiMethod.baseUrl}api/expenses/create ===');
      debugPrint(
          '=== EXPENSE REPO DEBUG: Request body: ${json.encode(requestBody)} ===');

      debugPrint('=== EXPENSE REPO DEBUG: Making POST request now... ===');
      final response = await _apiMethod.post(
        'api/expenses/create',
        body: requestBody,
      );
      debugPrint('=== EXPENSE REPO DEBUG: API call completed ===');

      debugPrint('=== EXPENSE REPO DEBUG: Raw backend response: $response ===');
      debugPrint(
          '=== EXPENSE REPO DEBUG: Response type: ${response.runtimeType} ===');
      debugPrint(
          '=== EXPENSE REPO DEBUG: Response keys: ${response.keys.toList()} ===');
      debugPrint(
          '=== EXPENSE REPO DEBUG: Response success field: ${response['success']} ===');
      debugPrint(
          '=== EXPENSE REPO DEBUG: Response expense field: ${response['expense']} ===');
      debugPrint(
          '=== EXPENSE REPO DEBUG: Response message field: ${response['message']} ===');
      debugPrint('=== EXPENSE REPO DEBUG: Backend response: $response ===');
      debugPrint(
          '=== EXPENSE REPO DEBUG: Response success status: ${response['success']} ===');

      if (response['statusCode'] == 201 && response['expenseId'] != null) {
        // Return the expense with the generated ID and uploaded file URLs
        final updatedExpense = expense.copyWith(
          id: response['expenseId'],
          receiptUrl: uploadedReceiptUrl,
          receiptFiles: uploadedReceiptFiles,
          receiptPhotos: uploadedReceiptPhotos,
        );
        debugPrint(
            '=== EXPENSE REPO DEBUG: Returning updated expense with ID: ${updatedExpense.id} ===');
        return updatedExpense;
      } else {
        debugPrint(
            '=== EXPENSE REPO DEBUG: Backend error response: ${response.toString()} ===');
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
                final serverUrl =
                    await _fileUploadService.uploadReceiptFile(receiptFile);
                serverUrls.add(serverUrl);

                // If it's an image, also add to photos array for backward compatibility
                if (_isImageFile(filePath)) {
                  photoUrls.add(serverUrl);
                }

                debugPrint(
                    'Successfully uploaded receipt file during update: $serverUrl');
              } catch (e) {
                debugPrint(
                    'Failed to upload receipt file $filePath during update: $e');
                throw Exception(
                    'Failed to upload file: ${filePath.split('/').last}. Please try again.');
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
              uploadedReceiptUrl =
                  await _fileUploadService.uploadReceiptFile(receiptFile);
              uploadedReceiptFiles = [uploadedReceiptUrl];
              if (_isImageFile(expense.receiptUrl!)) {
                uploadedReceiptPhotos = [uploadedReceiptUrl];
              }
              debugPrint(
                  'Successfully uploaded receipt file during update: $uploadedReceiptUrl');
            } catch (e) {
              debugPrint('Failed to upload receipt file during update: $e');
              throw Exception(
                  'Failed to upload receipt file. Please try again.');
            }
          } else {
            throw Exception(
                'Receipt file not found. Please select the file again.');
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
        'api/expenses/${expense.id}',
        body: requestBody,
      );

      if (response['success'] == true && response['expense'] != null) {
        return ExpenseModel.fromJson(response['expense']);
      } else {
        throw Exception(response['message'] ?? 'Failed to update expense');
      }
    } catch (e) {
      throw Exception('Error updating expense: $e');
    }
  }

  /// Deletes an expense
  Future<bool> deleteExpense(String expenseId) async {
    try {
      final response = await _apiMethod.delete(
        'api/expenses/$expenseId',
      );

      if (response['success'] == true) {
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
        'api/expenses/$expenseId/approval',
        body: {
          'approvalStatus': 'approved',
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
        'api/expenses/$expenseId/approval',
        body: {
          'approvalStatus': 'rejected',
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
      final response = await _apiMethod.get('api/expenses/categories');

      if (response['success'] == true && response['categories'] != null) {
        final List<dynamic> categoriesJson = response['categories'];
        return categoriesJson.map((c) => c.toString()).toList();
      } else {
        throw Exception(
            response['message'] ?? 'Failed to fetch expense categories');
      }
    } catch (e) {
      throw Exception('Error fetching expense categories: $e');
    }
  }

  /// Gets recurring expenses for an organization
  Future<List<ExpenseModel>> getRecurringExpenses(String organizationId) async {
    try {
      final response = await _apiMethod.get(
        'api/recurring-expenses/organization/$organizationId',
      );

      if (response['success'] == true &&
          response['recurringExpenses'] != null) {
        final List<dynamic> expensesJson = response['recurringExpenses'];
        return expensesJson.map((json) => ExpenseModel.fromJson(json)).toList();
      } else {
        throw Exception(
            response['message'] ?? 'Failed to fetch recurring expenses');
      }
    } catch (e) {
      throw Exception('Error fetching recurring expenses: $e');
    }
  }

  /// Gets expense statistics for an organization
  Future<Map<String, dynamic>> getExpenseStatistics(
      String organizationId) async {
    try {
      final response = await _apiMethod.get(
        'api/expenses/statistics/$organizationId',
      );

      if (response['success'] == true) {
        return response['statistics'];
      } else {
        throw Exception(
            response['message'] ?? 'Failed to fetch expense statistics');
      }
    } catch (e) {
      throw Exception('Error fetching expense statistics: $e');
    }
  }
}
