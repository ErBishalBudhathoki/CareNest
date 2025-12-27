import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/expenses/models/expense_model.dart';
import 'package:carenest/app/features/expenses/data/expense_repository.dart';
import 'package:carenest/app/di/service_locator.dart';

// State class for expense management
class ExpenseState {
  final List<ExpenseModel> expenses;
  final bool isLoading;
  final String? error;

  ExpenseState({
    required this.expenses,
    required this.isLoading,
    this.error,
  });

  ExpenseState copyWith({
    List<ExpenseModel>? expenses,
    bool? isLoading,
    String? error,
  }) {
    return ExpenseState(
      expenses: expenses ?? this.expenses,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Expense notifier class
class ExpenseNotifier extends StateNotifier<ExpenseState> {
  final ExpenseRepository _repository;

  ExpenseNotifier(this._repository)
      : super(ExpenseState(expenses: [], isLoading: false));

  // Fetch expenses for an organization
  Future<void> fetchExpenses(String organizationId) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final expenses =
          await _repository.getOrganizationExpenses(organizationId);
      state = state.copyWith(expenses: expenses, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to fetch expenses: ${e.toString()}',
      );
    }
  }

  // Add a new expense
  Future<void> addExpense(ExpenseModel expense) async {
    try {
      debugPrint('=== EXPENSE PROVIDER DEBUG: Starting addExpense ===');
      debugPrint(
          '=== EXPENSE PROVIDER DEBUG: Current expenses count: ${state.expenses.length} ===');

      state = state.copyWith(isLoading: true, error: null);

      final createdExpense = await _repository.createExpense(expense);
      debugPrint(
          '=== EXPENSE PROVIDER DEBUG: Created expense with ID: ${createdExpense.id} ===');

      final updatedExpenses = [...state.expenses, createdExpense];
      debugPrint(
          '=== EXPENSE PROVIDER DEBUG: Updated expenses count: ${updatedExpenses.length} ===');

      state = state.copyWith(expenses: updatedExpenses, isLoading: false);
      debugPrint('=== EXPENSE PROVIDER DEBUG: State updated successfully ===');
    } catch (e) {
      debugPrint('=== EXPENSE PROVIDER DEBUG: Error in addExpense: $e ===');
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to add expense: ${e.toString()}',
      );
      rethrow;
    }
  }

  // Update an existing expense
  Future<void> updateExpense(ExpenseModel updatedExpense) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final result = await _repository.updateExpense(updatedExpense);
      final updatedExpenses = state.expenses.map((expense) {
        if (expense.id == result.id) {
          return result;
        }
        return expense;
      }).toList();

      state = state.copyWith(expenses: updatedExpenses, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to update expense: ${e.toString()}',
      );
    }
  }

  // Delete an expense
  Future<void> deleteExpense(String expenseId) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      await _repository.deleteExpense(expenseId);
      final updatedExpenses =
          state.expenses.where((expense) => expense.id != expenseId).toList();

      state = state.copyWith(expenses: updatedExpenses, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to delete expense: ${e.toString()}',
      );
    }
  }

  // Approve an expense
  Future<void> approveExpense(String expenseId, String approverEmail) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final success =
          await _repository.approveExpense(expenseId, approverEmail);
      if (success) {
        // Update the expense status locally
        final updatedExpenses = state.expenses.map((expense) {
          if (expense.id == expenseId) {
            return expense.copyWith(
              status: 'approved',
              approvedBy: approverEmail,
              updatedAt: DateTime.now(),
            );
          }
          return expense;
        }).toList();
        state = state.copyWith(expenses: updatedExpenses, isLoading: false);
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Failed to approve expense',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to approve expense: ${e.toString()}',
      );
      rethrow;
    }
  }

  // Reject an expense
  Future<void> rejectExpense(String expenseId, String approverEmail) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final success = await _repository.rejectExpense(expenseId, approverEmail);
      if (success) {
        // Update the expense status locally
        final updatedExpenses = state.expenses.map((expense) {
          if (expense.id == expenseId) {
            return expense.copyWith(
              status: 'rejected',
              approvedBy: approverEmail,
              updatedAt: DateTime.now(),
            );
          }
          return expense;
        }).toList();
        state = state.copyWith(expenses: updatedExpenses, isLoading: false);
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Failed to reject expense',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to reject expense: ${e.toString()}',
      );
      rethrow;
    }
  }

  // Get expense categories
  Future<List<String>> getExpenseCategories() async {
    try {
      return await _repository.getExpenseCategories();
    } catch (e) {
      state = state.copyWith(
        error: 'Failed to fetch expense categories: ${e.toString()}',
      );
      return [];
    }
  }

  // Get recurring expenses
  Future<void> fetchRecurringExpenses(String organizationId) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final recurringExpenses =
          await _repository.getRecurringExpenses(organizationId);
      // Filter the current state to only include non-recurring expenses
      final nonRecurringExpenses =
          state.expenses.where((e) => !e.isRecurring).toList();

      // Combine non-recurring expenses with the fetched recurring expenses
      final allExpenses = [...nonRecurringExpenses, ...recurringExpenses];
      state = state.copyWith(expenses: allExpenses, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to fetch recurring expenses: ${e.toString()}',
      );
    }
  }
}

// Provider for expense repository
final expenseRepositoryProvider = Provider<ExpenseRepository>((ref) {
  return locator<ExpenseRepository>();
});

// Provider for expense state
final expenseProvider =
    StateNotifierProvider<ExpenseNotifier, ExpenseState>((ref) {
  final repository = ref.watch(expenseRepositoryProvider);
  return ExpenseNotifier(repository);
});
