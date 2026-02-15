import 'package:freezed_annotation/freezed_annotation.dart';

part 'smart_expense_models.freezed.dart';
part 'smart_expense_models.g.dart';

/// Receipt scan result
@freezed
class ReceiptScan with _$ReceiptScan {
  const factory ReceiptScan({
    required String merchant,
    required String date,
    required double amount,
    required String currency,
    required List<ReceiptItem> items,
    required double tax,
    required double total,
    required String paymentMethod,
    required double confidence,
  }) = _ReceiptScan;

  factory ReceiptScan.fromJson(Map<String, dynamic> json) =>
      _$ReceiptScanFromJson(json);
}

/// Receipt item
@freezed
class ReceiptItem with _$ReceiptItem {
  const factory ReceiptItem({
    required String description,
    required int quantity,
    required double price,
  }) = _ReceiptItem;

  factory ReceiptItem.fromJson(Map<String, dynamic> json) =>
      _$ReceiptItemFromJson(json);
}

/// Expense category with confidence
@freezed
class ExpenseCategory with _$ExpenseCategory {
  const factory ExpenseCategory({
    required String category,
    required double confidence,
    required List<CategorySuggestion> suggestedCategories,
  }) = _ExpenseCategory;

  factory ExpenseCategory.fromJson(Map<String, dynamic> json) =>
      _$ExpenseCategoryFromJson(json);
}

/// Category suggestion
@freezed
class CategorySuggestion with _$CategorySuggestion {
  const factory CategorySuggestion({
    required String category,
    required double confidence,
  }) = _CategorySuggestion;

  factory CategorySuggestion.fromJson(Map<String, dynamic> json) =>
      _$CategorySuggestionFromJson(json);
}

/// Policy validation result
@freezed
class PolicyValidation with _$PolicyValidation {
  const factory PolicyValidation({
    required bool isCompliant,
    required bool requiresApproval,
    required List<PolicyViolation> violations,
    required List<PolicyViolation> warnings,
    required PolicyRule policyRule,
  }) = _PolicyValidation;

  factory PolicyValidation.fromJson(Map<String, dynamic> json) =>
      _$PolicyValidationFromJson(json);
}

/// Policy violation or warning
@freezed
class PolicyViolation with _$PolicyViolation {
  const factory PolicyViolation({
    required String type,
    required String message,
    required String severity,
  }) = _PolicyViolation;

  factory PolicyViolation.fromJson(Map<String, dynamic> json) =>
      _$PolicyViolationFromJson(json);
}

/// Policy rule
@freezed
class PolicyRule with _$PolicyRule {
  const factory PolicyRule({
    required double maxAmount,
    required bool requiresReceipt,
  }) = _PolicyRule;

  factory PolicyRule.fromJson(Map<String, dynamic> json) =>
      _$PolicyRuleFromJson(json);
}

/// Duplicate check result
@freezed
class DuplicateCheck with _$DuplicateCheck {
  const factory DuplicateCheck({
    required bool isDuplicate,
    required double confidence,
    MatchedExpense? matchedExpense,
  }) = _DuplicateCheck;

  factory DuplicateCheck.fromJson(Map<String, dynamic> json) =>
      _$DuplicateCheckFromJson(json);
}

/// Matched expense (for duplicate detection)
@freezed
class MatchedExpense with _$MatchedExpense {
  const factory MatchedExpense({
    required String expenseId,
    required String date,
    required double amount,
    required String merchant,
  }) = _MatchedExpense;

  factory MatchedExpense.fromJson(Map<String, dynamic> json) =>
      _$MatchedExpenseFromJson(json);
}

/// Mileage calculation result
@freezed
class MileageCalculation with _$MileageCalculation {
  const factory MileageCalculation({
    required double totalDistance,
    required String unit,
    required double ratePerKm,
    required double reimbursement,
    required String currency,
    required LocationPoint startLocation,
    required LocationPoint endLocation,
    required int waypoints,
  }) = _MileageCalculation;

  factory MileageCalculation.fromJson(Map<String, dynamic> json) =>
      _$MileageCalculationFromJson(json);
}

/// Location point
@freezed
class LocationPoint with _$LocationPoint {
  const factory LocationPoint({
    required double lat,
    required double lng,
    String? timestamp,
  }) = _LocationPoint;

  factory LocationPoint.fromJson(Map<String, dynamic> json) =>
      _$LocationPointFromJson(json);
}
