// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_expense_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReceiptScan _$ReceiptScanFromJson(Map<String, dynamic> json) => _ReceiptScan(
  merchant: json['merchant'] as String,
  date: json['date'] as String,
  amount: (json['amount'] as num).toDouble(),
  currency: json['currency'] as String,
  items: (json['items'] as List<dynamic>)
      .map((e) => ReceiptItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  tax: (json['tax'] as num).toDouble(),
  total: (json['total'] as num).toDouble(),
  paymentMethod: json['paymentMethod'] as String,
  confidence: (json['confidence'] as num).toDouble(),
);

Map<String, dynamic> _$ReceiptScanToJson(_ReceiptScan instance) =>
    <String, dynamic>{
      'merchant': instance.merchant,
      'date': instance.date,
      'amount': instance.amount,
      'currency': instance.currency,
      'items': instance.items,
      'tax': instance.tax,
      'total': instance.total,
      'paymentMethod': instance.paymentMethod,
      'confidence': instance.confidence,
    };

_ReceiptItem _$ReceiptItemFromJson(Map<String, dynamic> json) => _ReceiptItem(
  description: json['description'] as String,
  quantity: (json['quantity'] as num).toInt(),
  price: (json['price'] as num).toDouble(),
);

Map<String, dynamic> _$ReceiptItemToJson(_ReceiptItem instance) =>
    <String, dynamic>{
      'description': instance.description,
      'quantity': instance.quantity,
      'price': instance.price,
    };

_ExpenseCategory _$ExpenseCategoryFromJson(Map<String, dynamic> json) =>
    _ExpenseCategory(
      category: json['category'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      suggestedCategories: (json['suggestedCategories'] as List<dynamic>)
          .map((e) => CategorySuggestion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExpenseCategoryToJson(_ExpenseCategory instance) =>
    <String, dynamic>{
      'category': instance.category,
      'confidence': instance.confidence,
      'suggestedCategories': instance.suggestedCategories,
    };

_CategorySuggestion _$CategorySuggestionFromJson(Map<String, dynamic> json) =>
    _CategorySuggestion(
      category: json['category'] as String,
      confidence: (json['confidence'] as num).toDouble(),
    );

Map<String, dynamic> _$CategorySuggestionToJson(_CategorySuggestion instance) =>
    <String, dynamic>{
      'category': instance.category,
      'confidence': instance.confidence,
    };

_PolicyValidation _$PolicyValidationFromJson(Map<String, dynamic> json) =>
    _PolicyValidation(
      isCompliant: json['isCompliant'] as bool,
      requiresApproval: json['requiresApproval'] as bool,
      violations: (json['violations'] as List<dynamic>)
          .map((e) => PolicyViolation.fromJson(e as Map<String, dynamic>))
          .toList(),
      warnings: (json['warnings'] as List<dynamic>)
          .map((e) => PolicyViolation.fromJson(e as Map<String, dynamic>))
          .toList(),
      policyRule: PolicyRule.fromJson(
        json['policyRule'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$PolicyValidationToJson(_PolicyValidation instance) =>
    <String, dynamic>{
      'isCompliant': instance.isCompliant,
      'requiresApproval': instance.requiresApproval,
      'violations': instance.violations,
      'warnings': instance.warnings,
      'policyRule': instance.policyRule,
    };

_PolicyViolation _$PolicyViolationFromJson(Map<String, dynamic> json) =>
    _PolicyViolation(
      type: json['type'] as String,
      message: json['message'] as String,
      severity: json['severity'] as String,
    );

Map<String, dynamic> _$PolicyViolationToJson(_PolicyViolation instance) =>
    <String, dynamic>{
      'type': instance.type,
      'message': instance.message,
      'severity': instance.severity,
    };

_PolicyRule _$PolicyRuleFromJson(Map<String, dynamic> json) => _PolicyRule(
  maxAmount: (json['maxAmount'] as num).toDouble(),
  requiresReceipt: json['requiresReceipt'] as bool,
);

Map<String, dynamic> _$PolicyRuleToJson(_PolicyRule instance) =>
    <String, dynamic>{
      'maxAmount': instance.maxAmount,
      'requiresReceipt': instance.requiresReceipt,
    };

_DuplicateCheck _$DuplicateCheckFromJson(Map<String, dynamic> json) =>
    _DuplicateCheck(
      isDuplicate: json['isDuplicate'] as bool,
      confidence: (json['confidence'] as num).toDouble(),
      matchedExpense: json['matchedExpense'] == null
          ? null
          : MatchedExpense.fromJson(
              json['matchedExpense'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$DuplicateCheckToJson(_DuplicateCheck instance) =>
    <String, dynamic>{
      'isDuplicate': instance.isDuplicate,
      'confidence': instance.confidence,
      'matchedExpense': instance.matchedExpense,
    };

_MatchedExpense _$MatchedExpenseFromJson(Map<String, dynamic> json) =>
    _MatchedExpense(
      expenseId: json['expenseId'] as String,
      date: json['date'] as String,
      amount: (json['amount'] as num).toDouble(),
      merchant: json['merchant'] as String,
    );

Map<String, dynamic> _$MatchedExpenseToJson(_MatchedExpense instance) =>
    <String, dynamic>{
      'expenseId': instance.expenseId,
      'date': instance.date,
      'amount': instance.amount,
      'merchant': instance.merchant,
    };

_MileageCalculation _$MileageCalculationFromJson(Map<String, dynamic> json) =>
    _MileageCalculation(
      totalDistance: (json['totalDistance'] as num).toDouble(),
      unit: json['unit'] as String,
      ratePerKm: (json['ratePerKm'] as num).toDouble(),
      reimbursement: (json['reimbursement'] as num).toDouble(),
      currency: json['currency'] as String,
      startLocation: LocationPoint.fromJson(
        json['startLocation'] as Map<String, dynamic>,
      ),
      endLocation: LocationPoint.fromJson(
        json['endLocation'] as Map<String, dynamic>,
      ),
      waypoints: (json['waypoints'] as num).toInt(),
    );

Map<String, dynamic> _$MileageCalculationToJson(_MileageCalculation instance) =>
    <String, dynamic>{
      'totalDistance': instance.totalDistance,
      'unit': instance.unit,
      'ratePerKm': instance.ratePerKm,
      'reimbursement': instance.reimbursement,
      'currency': instance.currency,
      'startLocation': instance.startLocation,
      'endLocation': instance.endLocation,
      'waypoints': instance.waypoints,
    };

_LocationPoint _$LocationPointFromJson(Map<String, dynamic> json) =>
    _LocationPoint(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      timestamp: json['timestamp'] as String?,
    );

Map<String, dynamic> _$LocationPointToJson(_LocationPoint instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
      'timestamp': instance.timestamp,
    };
