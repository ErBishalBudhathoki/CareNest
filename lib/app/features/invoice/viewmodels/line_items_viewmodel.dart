import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';

class LineItemViewModel extends StateNotifier<List<Map<String, dynamic>>> {
  final ApiMethod _apiMethod;

  LineItemViewModel(this._apiMethod) : super([]);

  /// Fetch all support items from the backend
  Future<List<Map<String, dynamic>>> getSupportItems() async {
    try {
      if (state.isEmpty) {
        final List<Map<String, dynamic>> supportItems =
            await _apiMethod.getLineItems();
        state = supportItems; // Update state immutably
      }
      return state;
    } catch (e) {
      debugPrint('Failed to get support items: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> searchSupportItems(String query) async {
    try {
      return await _apiMethod.searchSupportItems(query);
    } catch (e) {
      debugPrint('Error searching support items: $e');
      return [];
    }
  }
}
