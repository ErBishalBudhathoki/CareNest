import 'package:flutter/material.dart';
import 'package:carenest/backend/api_method.dart';

class InvoiceRepository {
  final ApiMethod _apiMethod;

  InvoiceRepository(this._apiMethod);

  Future<Map<String, dynamic>?> getAssignedClients() async {
    return await _apiMethod.getAssignedClients();
  }

  Future<List<Map<String, dynamic>>> getLineItems(
      {bool includeExpenses = false}) async {
    final result =
        await _apiMethod.getLineItems(includeExpenses: includeExpenses);
    debugPrint('Invoice Repository: API returned ${result.length} line items');
    debugPrint(
        'Invoice Repository: includeExpenses parameter was: $includeExpenses');
    if (result.isNotEmpty) {
      debugPrint(
          'Invoice Repository: First line item from API: ${result.first}');
    }
    return result;
  }

  Future<Map<String, dynamic>> getInvoiceData({
    bool includeExpenses = false,
    String? userEmail,
    String? clientEmail,
    String? startDate,
    String? endDate,
  }) async {
    final result = await _apiMethod.getInvoiceData(
      includeExpenses: includeExpenses,
      userEmail: userEmail,
      clientEmail: clientEmail,
      startDate: startDate,
      endDate: endDate,
    );

    debugPrint(
        'Invoice Repository: getInvoiceData called with includeExpenses: $includeExpenses');
    debugPrint(
        'Invoice Repository: API response keys: ${result.keys.toList()}');
    if (result['expenses'] != null) {
      final expenses = result['expenses'] as List<dynamic>? ?? [];
      debugPrint(
          'Invoice Repository: Found ${expenses.length} expenses in response');
      if (expenses.isNotEmpty) {
        debugPrint('Invoice Repository: First expense: ${expenses.first}');
      }
    } else {
      debugPrint('Invoice Repository: No expenses key in API response');
    }

    return result;
  }

  Future<List<String>> checkHolidaysSingle(List<String> dates) async {
    return await _apiMethod.checkHolidaysSingle(dates);
  }
}
