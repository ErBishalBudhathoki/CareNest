// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_expense_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReceiptScanImpl _$$ReceiptScanImplFromJson(Map<String, dynamic> json) =>
    _$ReceiptScanImpl(
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

Map<String, dynamic> _$$ReceiptScanImplToJson(_$ReceiptScanImpl instance) =>
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

_$ReceiptItemImpl _$$ReceiptItemImplFromJson(Map<String, dynamic> json) =>
    _$ReceiptItemImpl(
      description: json['description'] as String,
      quantity: (json['quantity'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$$ReceiptItemImplToJson(_$ReceiptItemImpl instance) =>
    <String, dynamic>{
      'description': instance.description,
      'quantity': instance.quantity,
      'price': instance.price,
    };

_$ExpenseCategoryImpl _$$ExpenseCategoryImplFromJson(
        Map<String, dynamic> json) =>
    _$ExpenseCategoryImpl(
      category: json['category'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      suggestedCategories: (json['suggestedCategories'] as List<dynamic>)
          .map((e) => CategorySuggestion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ExpenseCategoryImplToJson(
        _$ExpenseCategoryImpl instance) =>
    <String, dynamic>{
      'category': instance.category,
      'confidence': instance.confidence,
      'suggestedCategories': instance.suggestedCategories,
    };

_$CategorySuggestionImpl _$$CategorySuggestionImplFromJson(
        Map<String, dynamic> json) =>
    _$CategorySuggestionImpl(
      category: json['category'] as String,
      confidence: (json['confidence'] as num).toDouble(),
    );

Map<String, dynamic> _$$CategorySuggestionImplToJson(
        _$CategorySuggestionImpl instance) =>
    <String, dynamic>{
      'category': instance.category,
      'confidence': instance.confidence,
    };

_$PolicyValidationImpl _$$PolicyValidationImplFromJson(
        Map<String, dynamic> json) =>
    _$PolicyValidationImpl(
      isCompliant: json['isCompliant'] as bool,
      requiresApproval: json['requiresApproval'] as bool,
      violations: (json['violations'] as List<dynamic>)
          .map((e) => PolicyViolation.fromJson(e as Map<String, dynamic>))
          .toList(),
      warnings: (json['warnings'] as List<dynamic>)
          .map((e) => PolicyViolation.fromJson(e as Map<String, dynamic>))
          .toList(),
      policyRule:
          PolicyRule.fromJson(json['policyRule'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PolicyValidationImplToJson(
        _$PolicyValidationImpl instance) =>
    <String, dynamic>{
      'isCompliant': instance.isCompliant,
      'requiresApproval': instance.requiresApproval,
      'violations': instance.violations,
      'warnings': instance.warnings,
      'policyRule': instance.policyRule,
    };

_$PolicyViolationImpl _$$PolicyViolationImplFromJson(
        Map<String, dynamic> json) =>
    _$PolicyViolationImpl(
      type: json['type'] as String,
      message: json['message'] as String,
      severity: json['severity'] as String,
    );

Map<String, dynamic> _$$PolicyViolationImplToJson(
        _$PolicyViolationImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'message': instance.message,
      'severity': instance.severity,
    };

_$PolicyRuleImpl _$$PolicyRuleImplFromJson(Map<String, dynamic> json) =>
    _$PolicyRuleImpl(
      maxAmount: (json['maxAmount'] as num).toDouble(),
      requiresReceipt: json['requiresReceipt'] as bool,
    );

Map<String, dynamic> _$$PolicyRuleImplToJson(_$PolicyRuleImpl instance) =>
    <String, dynamic>{
      'maxAmount': instance.maxAmount,
      'requiresReceipt': instance.requiresReceipt,
    };

_$DuplicateCheckImpl _$$DuplicateCheckImplFromJson(Map<String, dynamic> json) =>
    _$DuplicateCheckImpl(
      isDuplicate: json['isDuplicate'] as bool,
      confidence: (json['confidence'] as num).toDouble(),
      matchedExpense: json['matchedExpense'] == null
          ? null
          : MatchedExpense.fromJson(
              json['matchedExpense'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DuplicateCheckImplToJson(
        _$DuplicateCheckImpl instance) =>
    <String, dynamic>{
      'isDuplicate': instance.isDuplicate,
      'confidence': instance.confidence,
      'matchedExpense': instance.matchedExpense,
    };

_$MatchedExpenseImpl _$$MatchedExpenseImplFromJson(Map<String, dynamic> json) =>
    _$MatchedExpenseImpl(
      expenseId: json['expenseId'] as String,
      date: json['date'] as String,
      amount: (json['amount'] as num).toDouble(),
      merchant: json['merchant'] as String,
    );

Map<String, dynamic> _$$MatchedExpenseImplToJson(
        _$MatchedExpenseImpl instance) =>
    <String, dynamic>{
      'expenseId': instance.expenseId,
      'date': instance.date,
      'amount': instance.amount,
      'merchant': instance.merchant,
    };

_$MileageCalculationImpl _$$MileageCalculationImplFromJson(
        Map<String, dynamic> json) =>
    _$MileageCalculationImpl(
      totalDistance: (json['totalDistance'] as num).toDouble(),
      unit: json['unit'] as String,
      ratePerKm: (json['ratePerKm'] as num).toDouble(),
      reimbursement: (json['reimbursement'] as num).toDouble(),
      currency: json['currency'] as String,
      startLocation:
          LocationPoint.fromJson(json['startLocation'] as Map<String, dynamic>),
      endLocation:
          LocationPoint.fromJson(json['endLocation'] as Map<String, dynamic>),
      waypoints: (json['waypoints'] as num).toInt(),
    );

Map<String, dynamic> _$$MileageCalculationImplToJson(
        _$MileageCalculationImpl instance) =>
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

_$LocationPointImpl _$$LocationPointImplFromJson(Map<String, dynamic> json) =>
    _$LocationPointImpl(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      timestamp: json['timestamp'] as String?,
    );

Map<String, dynamic> _$$LocationPointImplToJson(_$LocationPointImpl instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
      'timestamp': instance.timestamp,
    };
