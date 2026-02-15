import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/expenses/repositories/smart_expense_repository.dart';
import 'package:carenest/app/features/expenses/models/smart_expense_models.dart';

/// State for smart expense
class SmartExpenseState {
  final bool isLoading;
  final String? error;
  final ReceiptScan? receiptScan;
  final ExpenseCategory? category;
  final PolicyValidation? policyValidation;
  final DuplicateCheck? duplicateCheck;
  final MileageCalculation? mileageCalculation;

  SmartExpenseState({
    this.isLoading = false,
    this.error,
    this.receiptScan,
    this.category,
    this.policyValidation,
    this.duplicateCheck,
    this.mileageCalculation,
  });

  SmartExpenseState copyWith({
    bool? isLoading,
    String? error,
    ReceiptScan? receiptScan,
    ExpenseCategory? category,
    PolicyValidation? policyValidation,
    DuplicateCheck? duplicateCheck,
    MileageCalculation? mileageCalculation,
  }) {
    return SmartExpenseState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      receiptScan: receiptScan ?? this.receiptScan,
      category: category ?? this.category,
      policyValidation: policyValidation ?? this.policyValidation,
      duplicateCheck: duplicateCheck ?? this.duplicateCheck,
      mileageCalculation: mileageCalculation ?? this.mileageCalculation,
    );
  }
}

/// ViewModel for smart expense
class SmartExpenseViewModel extends StateNotifier<SmartExpenseState> {
  final SmartExpenseRepository repository;

  SmartExpenseViewModel(this.repository) : super(SmartExpenseState());

  /// Scan receipt
  Future<void> scanReceipt(String imageBase64) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final response = await repository.scanReceipt(
        imageBase64: imageBase64,
      );
      
      if (response['success'] == true && response['data'] != null) {
        final receiptScan = ReceiptScan.fromJson(response['data']);
        state = state.copyWith(
          isLoading: false,
          receiptScan: receiptScan,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response['message'] ?? 'Failed to scan receipt',
        );
      }
    } catch (e) {
      debugPrint('Error in scanReceipt: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Categorize expense
  Future<void> categorizeExpense(Map<String, dynamic> expenseData) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final response = await repository.categorizeExpense(
        expenseData: expenseData,
      );
      
      if (response['success'] == true && response['data'] != null) {
        final category = ExpenseCategory.fromJson(response['data']);
        state = state.copyWith(
          isLoading: false,
          category: category,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response['message'] ?? 'Failed to categorize expense',
        );
      }
    } catch (e) {
      debugPrint('Error in categorizeExpense: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Validate expense policy
  Future<void> validateExpensePolicy(Map<String, dynamic> expenseData) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final response = await repository.validateExpensePolicy(
        expenseData: expenseData,
      );
      
      if (response['success'] == true && response['data'] != null) {
        final validation = PolicyValidation.fromJson(response['data']);
        state = state.copyWith(
          isLoading: false,
          policyValidation: validation,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response['message'] ?? 'Failed to validate policy',
        );
      }
    } catch (e) {
      debugPrint('Error in validateExpensePolicy: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Check duplicate receipt
  Future<void> checkDuplicateReceipt(String receiptHash) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final response = await repository.checkDuplicateReceipt(
        receiptHash: receiptHash,
      );
      
      if (response['success'] == true && response['data'] != null) {
        final duplicateCheck = DuplicateCheck.fromJson(response['data']);
        state = state.copyWith(
          isLoading: false,
          duplicateCheck: duplicateCheck,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response['message'] ?? 'Failed to check duplicate',
        );
      }
    } catch (e) {
      debugPrint('Error in checkDuplicateReceipt: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Calculate mileage
  Future<void> calculateMileage(List<Map<String, dynamic>> locations) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final response = await repository.calculateMileage(
        locations: locations,
      );
      
      if (response['success'] == true && response['data'] != null) {
        final mileageCalculation = MileageCalculation.fromJson(response['data']);
        state = state.copyWith(
          isLoading: false,
          mileageCalculation: mileageCalculation,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response['message'] ?? 'Failed to calculate mileage',
        );
      }
    } catch (e) {
      debugPrint('Error in calculateMileage: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

/// Provider for smart expense viewmodel
final smartExpenseViewModelProvider =
    StateNotifierProvider<SmartExpenseViewModel, SmartExpenseState>((ref) {
  final repository = ref.watch(smartExpenseRepositoryProvider);
  return SmartExpenseViewModel(repository);
});
