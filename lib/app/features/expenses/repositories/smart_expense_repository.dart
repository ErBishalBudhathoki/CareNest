import 'package:flutter/foundation.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Repository for smart expense operations
class SmartExpenseRepository {
  final Ref ref;

  SmartExpenseRepository(this.ref);

  /// Scan receipt using OCR
  Future<Map<String, dynamic>> scanReceipt({
    required String imageBase64,
  }) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      return await apiMethod.scanReceipt(
        imageBase64: imageBase64,
      );
    } catch (e) {
      debugPrint('Error scanning receipt: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Categorize expense using AI
  Future<Map<String, dynamic>> categorizeExpense({
    required Map<String, dynamic> expenseData,
  }) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      return await apiMethod.categorizeExpense(
        expenseData: expenseData,
      );
    } catch (e) {
      debugPrint('Error categorizing expense: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Validate expense against policy
  Future<Map<String, dynamic>> validateExpensePolicy({
    required Map<String, dynamic> expenseData,
  }) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      return await apiMethod.validateExpensePolicy(
        expenseData: expenseData,
      );
    } catch (e) {
      debugPrint('Error validating expense policy: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Check for duplicate receipt
  Future<Map<String, dynamic>> checkDuplicateReceipt({
    required String receiptHash,
  }) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      return await apiMethod.checkDuplicateReceipt(
        receiptHash: receiptHash,
      );
    } catch (e) {
      debugPrint('Error checking duplicate receipt: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Calculate mileage from GPS locations
  Future<Map<String, dynamic>> calculateMileage({
    required List<Map<String, dynamic>> locations,
  }) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      return await apiMethod.calculateMileage(
        locations: locations,
      );
    } catch (e) {
      debugPrint('Error calculating mileage: $e');
      return {'success': false, 'message': e.toString()};
    }
  }
}

/// Provider for smart expense repository
final smartExpenseRepositoryProvider = Provider<SmartExpenseRepository>((ref) {
  return SmartExpenseRepository(ref);
});
