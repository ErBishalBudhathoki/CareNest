// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'smart_expense_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReceiptScan _$ReceiptScanFromJson(Map<String, dynamic> json) {
  return _ReceiptScan.fromJson(json);
}

/// @nodoc
mixin _$ReceiptScan {
  String get merchant => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  List<ReceiptItem> get items => throw _privateConstructorUsedError;
  double get tax => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;
  String get paymentMethod => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReceiptScanCopyWith<ReceiptScan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReceiptScanCopyWith<$Res> {
  factory $ReceiptScanCopyWith(
          ReceiptScan value, $Res Function(ReceiptScan) then) =
      _$ReceiptScanCopyWithImpl<$Res, ReceiptScan>;
  @useResult
  $Res call(
      {String merchant,
      String date,
      double amount,
      String currency,
      List<ReceiptItem> items,
      double tax,
      double total,
      String paymentMethod,
      double confidence});
}

/// @nodoc
class _$ReceiptScanCopyWithImpl<$Res, $Val extends ReceiptScan>
    implements $ReceiptScanCopyWith<$Res> {
  _$ReceiptScanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? merchant = null,
    Object? date = null,
    Object? amount = null,
    Object? currency = null,
    Object? items = null,
    Object? tax = null,
    Object? total = null,
    Object? paymentMethod = null,
    Object? confidence = null,
  }) {
    return _then(_value.copyWith(
      merchant: null == merchant
          ? _value.merchant
          : merchant // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ReceiptItem>,
      tax: null == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReceiptScanImplCopyWith<$Res>
    implements $ReceiptScanCopyWith<$Res> {
  factory _$$ReceiptScanImplCopyWith(
          _$ReceiptScanImpl value, $Res Function(_$ReceiptScanImpl) then) =
      __$$ReceiptScanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String merchant,
      String date,
      double amount,
      String currency,
      List<ReceiptItem> items,
      double tax,
      double total,
      String paymentMethod,
      double confidence});
}

/// @nodoc
class __$$ReceiptScanImplCopyWithImpl<$Res>
    extends _$ReceiptScanCopyWithImpl<$Res, _$ReceiptScanImpl>
    implements _$$ReceiptScanImplCopyWith<$Res> {
  __$$ReceiptScanImplCopyWithImpl(
      _$ReceiptScanImpl _value, $Res Function(_$ReceiptScanImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? merchant = null,
    Object? date = null,
    Object? amount = null,
    Object? currency = null,
    Object? items = null,
    Object? tax = null,
    Object? total = null,
    Object? paymentMethod = null,
    Object? confidence = null,
  }) {
    return _then(_$ReceiptScanImpl(
      merchant: null == merchant
          ? _value.merchant
          : merchant // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ReceiptItem>,
      tax: null == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReceiptScanImpl implements _ReceiptScan {
  const _$ReceiptScanImpl(
      {required this.merchant,
      required this.date,
      required this.amount,
      required this.currency,
      required final List<ReceiptItem> items,
      required this.tax,
      required this.total,
      required this.paymentMethod,
      required this.confidence})
      : _items = items;

  factory _$ReceiptScanImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReceiptScanImplFromJson(json);

  @override
  final String merchant;
  @override
  final String date;
  @override
  final double amount;
  @override
  final String currency;
  final List<ReceiptItem> _items;
  @override
  List<ReceiptItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final double tax;
  @override
  final double total;
  @override
  final String paymentMethod;
  @override
  final double confidence;

  @override
  String toString() {
    return 'ReceiptScan(merchant: $merchant, date: $date, amount: $amount, currency: $currency, items: $items, tax: $tax, total: $total, paymentMethod: $paymentMethod, confidence: $confidence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReceiptScanImpl &&
            (identical(other.merchant, merchant) ||
                other.merchant == merchant) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.tax, tax) || other.tax == tax) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      merchant,
      date,
      amount,
      currency,
      const DeepCollectionEquality().hash(_items),
      tax,
      total,
      paymentMethod,
      confidence);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReceiptScanImplCopyWith<_$ReceiptScanImpl> get copyWith =>
      __$$ReceiptScanImplCopyWithImpl<_$ReceiptScanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReceiptScanImplToJson(
      this,
    );
  }
}

abstract class _ReceiptScan implements ReceiptScan {
  const factory _ReceiptScan(
      {required final String merchant,
      required final String date,
      required final double amount,
      required final String currency,
      required final List<ReceiptItem> items,
      required final double tax,
      required final double total,
      required final String paymentMethod,
      required final double confidence}) = _$ReceiptScanImpl;

  factory _ReceiptScan.fromJson(Map<String, dynamic> json) =
      _$ReceiptScanImpl.fromJson;

  @override
  String get merchant;
  @override
  String get date;
  @override
  double get amount;
  @override
  String get currency;
  @override
  List<ReceiptItem> get items;
  @override
  double get tax;
  @override
  double get total;
  @override
  String get paymentMethod;
  @override
  double get confidence;
  @override
  @JsonKey(ignore: true)
  _$$ReceiptScanImplCopyWith<_$ReceiptScanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReceiptItem _$ReceiptItemFromJson(Map<String, dynamic> json) {
  return _ReceiptItem.fromJson(json);
}

/// @nodoc
mixin _$ReceiptItem {
  String get description => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReceiptItemCopyWith<ReceiptItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReceiptItemCopyWith<$Res> {
  factory $ReceiptItemCopyWith(
          ReceiptItem value, $Res Function(ReceiptItem) then) =
      _$ReceiptItemCopyWithImpl<$Res, ReceiptItem>;
  @useResult
  $Res call({String description, int quantity, double price});
}

/// @nodoc
class _$ReceiptItemCopyWithImpl<$Res, $Val extends ReceiptItem>
    implements $ReceiptItemCopyWith<$Res> {
  _$ReceiptItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? quantity = null,
    Object? price = null,
  }) {
    return _then(_value.copyWith(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReceiptItemImplCopyWith<$Res>
    implements $ReceiptItemCopyWith<$Res> {
  factory _$$ReceiptItemImplCopyWith(
          _$ReceiptItemImpl value, $Res Function(_$ReceiptItemImpl) then) =
      __$$ReceiptItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String description, int quantity, double price});
}

/// @nodoc
class __$$ReceiptItemImplCopyWithImpl<$Res>
    extends _$ReceiptItemCopyWithImpl<$Res, _$ReceiptItemImpl>
    implements _$$ReceiptItemImplCopyWith<$Res> {
  __$$ReceiptItemImplCopyWithImpl(
      _$ReceiptItemImpl _value, $Res Function(_$ReceiptItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? quantity = null,
    Object? price = null,
  }) {
    return _then(_$ReceiptItemImpl(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReceiptItemImpl implements _ReceiptItem {
  const _$ReceiptItemImpl(
      {required this.description, required this.quantity, required this.price});

  factory _$ReceiptItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReceiptItemImplFromJson(json);

  @override
  final String description;
  @override
  final int quantity;
  @override
  final double price;

  @override
  String toString() {
    return 'ReceiptItem(description: $description, quantity: $quantity, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReceiptItemImpl &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.price, price) || other.price == price));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, description, quantity, price);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReceiptItemImplCopyWith<_$ReceiptItemImpl> get copyWith =>
      __$$ReceiptItemImplCopyWithImpl<_$ReceiptItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReceiptItemImplToJson(
      this,
    );
  }
}

abstract class _ReceiptItem implements ReceiptItem {
  const factory _ReceiptItem(
      {required final String description,
      required final int quantity,
      required final double price}) = _$ReceiptItemImpl;

  factory _ReceiptItem.fromJson(Map<String, dynamic> json) =
      _$ReceiptItemImpl.fromJson;

  @override
  String get description;
  @override
  int get quantity;
  @override
  double get price;
  @override
  @JsonKey(ignore: true)
  _$$ReceiptItemImplCopyWith<_$ReceiptItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExpenseCategory _$ExpenseCategoryFromJson(Map<String, dynamic> json) {
  return _ExpenseCategory.fromJson(json);
}

/// @nodoc
mixin _$ExpenseCategory {
  String get category => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  List<CategorySuggestion> get suggestedCategories =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExpenseCategoryCopyWith<ExpenseCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseCategoryCopyWith<$Res> {
  factory $ExpenseCategoryCopyWith(
          ExpenseCategory value, $Res Function(ExpenseCategory) then) =
      _$ExpenseCategoryCopyWithImpl<$Res, ExpenseCategory>;
  @useResult
  $Res call(
      {String category,
      double confidence,
      List<CategorySuggestion> suggestedCategories});
}

/// @nodoc
class _$ExpenseCategoryCopyWithImpl<$Res, $Val extends ExpenseCategory>
    implements $ExpenseCategoryCopyWith<$Res> {
  _$ExpenseCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = null,
    Object? confidence = null,
    Object? suggestedCategories = null,
  }) {
    return _then(_value.copyWith(
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      suggestedCategories: null == suggestedCategories
          ? _value.suggestedCategories
          : suggestedCategories // ignore: cast_nullable_to_non_nullable
              as List<CategorySuggestion>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExpenseCategoryImplCopyWith<$Res>
    implements $ExpenseCategoryCopyWith<$Res> {
  factory _$$ExpenseCategoryImplCopyWith(_$ExpenseCategoryImpl value,
          $Res Function(_$ExpenseCategoryImpl) then) =
      __$$ExpenseCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String category,
      double confidence,
      List<CategorySuggestion> suggestedCategories});
}

/// @nodoc
class __$$ExpenseCategoryImplCopyWithImpl<$Res>
    extends _$ExpenseCategoryCopyWithImpl<$Res, _$ExpenseCategoryImpl>
    implements _$$ExpenseCategoryImplCopyWith<$Res> {
  __$$ExpenseCategoryImplCopyWithImpl(
      _$ExpenseCategoryImpl _value, $Res Function(_$ExpenseCategoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = null,
    Object? confidence = null,
    Object? suggestedCategories = null,
  }) {
    return _then(_$ExpenseCategoryImpl(
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      suggestedCategories: null == suggestedCategories
          ? _value._suggestedCategories
          : suggestedCategories // ignore: cast_nullable_to_non_nullable
              as List<CategorySuggestion>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExpenseCategoryImpl implements _ExpenseCategory {
  const _$ExpenseCategoryImpl(
      {required this.category,
      required this.confidence,
      required final List<CategorySuggestion> suggestedCategories})
      : _suggestedCategories = suggestedCategories;

  factory _$ExpenseCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExpenseCategoryImplFromJson(json);

  @override
  final String category;
  @override
  final double confidence;
  final List<CategorySuggestion> _suggestedCategories;
  @override
  List<CategorySuggestion> get suggestedCategories {
    if (_suggestedCategories is EqualUnmodifiableListView)
      return _suggestedCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_suggestedCategories);
  }

  @override
  String toString() {
    return 'ExpenseCategory(category: $category, confidence: $confidence, suggestedCategories: $suggestedCategories)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpenseCategoryImpl &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            const DeepCollectionEquality()
                .equals(other._suggestedCategories, _suggestedCategories));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, category, confidence,
      const DeepCollectionEquality().hash(_suggestedCategories));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpenseCategoryImplCopyWith<_$ExpenseCategoryImpl> get copyWith =>
      __$$ExpenseCategoryImplCopyWithImpl<_$ExpenseCategoryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExpenseCategoryImplToJson(
      this,
    );
  }
}

abstract class _ExpenseCategory implements ExpenseCategory {
  const factory _ExpenseCategory(
          {required final String category,
          required final double confidence,
          required final List<CategorySuggestion> suggestedCategories}) =
      _$ExpenseCategoryImpl;

  factory _ExpenseCategory.fromJson(Map<String, dynamic> json) =
      _$ExpenseCategoryImpl.fromJson;

  @override
  String get category;
  @override
  double get confidence;
  @override
  List<CategorySuggestion> get suggestedCategories;
  @override
  @JsonKey(ignore: true)
  _$$ExpenseCategoryImplCopyWith<_$ExpenseCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CategorySuggestion _$CategorySuggestionFromJson(Map<String, dynamic> json) {
  return _CategorySuggestion.fromJson(json);
}

/// @nodoc
mixin _$CategorySuggestion {
  String get category => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CategorySuggestionCopyWith<CategorySuggestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategorySuggestionCopyWith<$Res> {
  factory $CategorySuggestionCopyWith(
          CategorySuggestion value, $Res Function(CategorySuggestion) then) =
      _$CategorySuggestionCopyWithImpl<$Res, CategorySuggestion>;
  @useResult
  $Res call({String category, double confidence});
}

/// @nodoc
class _$CategorySuggestionCopyWithImpl<$Res, $Val extends CategorySuggestion>
    implements $CategorySuggestionCopyWith<$Res> {
  _$CategorySuggestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = null,
    Object? confidence = null,
  }) {
    return _then(_value.copyWith(
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CategorySuggestionImplCopyWith<$Res>
    implements $CategorySuggestionCopyWith<$Res> {
  factory _$$CategorySuggestionImplCopyWith(_$CategorySuggestionImpl value,
          $Res Function(_$CategorySuggestionImpl) then) =
      __$$CategorySuggestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String category, double confidence});
}

/// @nodoc
class __$$CategorySuggestionImplCopyWithImpl<$Res>
    extends _$CategorySuggestionCopyWithImpl<$Res, _$CategorySuggestionImpl>
    implements _$$CategorySuggestionImplCopyWith<$Res> {
  __$$CategorySuggestionImplCopyWithImpl(_$CategorySuggestionImpl _value,
      $Res Function(_$CategorySuggestionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = null,
    Object? confidence = null,
  }) {
    return _then(_$CategorySuggestionImpl(
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CategorySuggestionImpl implements _CategorySuggestion {
  const _$CategorySuggestionImpl(
      {required this.category, required this.confidence});

  factory _$CategorySuggestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategorySuggestionImplFromJson(json);

  @override
  final String category;
  @override
  final double confidence;

  @override
  String toString() {
    return 'CategorySuggestion(category: $category, confidence: $confidence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategorySuggestionImpl &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, category, confidence);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CategorySuggestionImplCopyWith<_$CategorySuggestionImpl> get copyWith =>
      __$$CategorySuggestionImplCopyWithImpl<_$CategorySuggestionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CategorySuggestionImplToJson(
      this,
    );
  }
}

abstract class _CategorySuggestion implements CategorySuggestion {
  const factory _CategorySuggestion(
      {required final String category,
      required final double confidence}) = _$CategorySuggestionImpl;

  factory _CategorySuggestion.fromJson(Map<String, dynamic> json) =
      _$CategorySuggestionImpl.fromJson;

  @override
  String get category;
  @override
  double get confidence;
  @override
  @JsonKey(ignore: true)
  _$$CategorySuggestionImplCopyWith<_$CategorySuggestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PolicyValidation _$PolicyValidationFromJson(Map<String, dynamic> json) {
  return _PolicyValidation.fromJson(json);
}

/// @nodoc
mixin _$PolicyValidation {
  bool get isCompliant => throw _privateConstructorUsedError;
  bool get requiresApproval => throw _privateConstructorUsedError;
  List<PolicyViolation> get violations => throw _privateConstructorUsedError;
  List<PolicyViolation> get warnings => throw _privateConstructorUsedError;
  PolicyRule get policyRule => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PolicyValidationCopyWith<PolicyValidation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PolicyValidationCopyWith<$Res> {
  factory $PolicyValidationCopyWith(
          PolicyValidation value, $Res Function(PolicyValidation) then) =
      _$PolicyValidationCopyWithImpl<$Res, PolicyValidation>;
  @useResult
  $Res call(
      {bool isCompliant,
      bool requiresApproval,
      List<PolicyViolation> violations,
      List<PolicyViolation> warnings,
      PolicyRule policyRule});

  $PolicyRuleCopyWith<$Res> get policyRule;
}

/// @nodoc
class _$PolicyValidationCopyWithImpl<$Res, $Val extends PolicyValidation>
    implements $PolicyValidationCopyWith<$Res> {
  _$PolicyValidationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isCompliant = null,
    Object? requiresApproval = null,
    Object? violations = null,
    Object? warnings = null,
    Object? policyRule = null,
  }) {
    return _then(_value.copyWith(
      isCompliant: null == isCompliant
          ? _value.isCompliant
          : isCompliant // ignore: cast_nullable_to_non_nullable
              as bool,
      requiresApproval: null == requiresApproval
          ? _value.requiresApproval
          : requiresApproval // ignore: cast_nullable_to_non_nullable
              as bool,
      violations: null == violations
          ? _value.violations
          : violations // ignore: cast_nullable_to_non_nullable
              as List<PolicyViolation>,
      warnings: null == warnings
          ? _value.warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<PolicyViolation>,
      policyRule: null == policyRule
          ? _value.policyRule
          : policyRule // ignore: cast_nullable_to_non_nullable
              as PolicyRule,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PolicyRuleCopyWith<$Res> get policyRule {
    return $PolicyRuleCopyWith<$Res>(_value.policyRule, (value) {
      return _then(_value.copyWith(policyRule: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PolicyValidationImplCopyWith<$Res>
    implements $PolicyValidationCopyWith<$Res> {
  factory _$$PolicyValidationImplCopyWith(_$PolicyValidationImpl value,
          $Res Function(_$PolicyValidationImpl) then) =
      __$$PolicyValidationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isCompliant,
      bool requiresApproval,
      List<PolicyViolation> violations,
      List<PolicyViolation> warnings,
      PolicyRule policyRule});

  @override
  $PolicyRuleCopyWith<$Res> get policyRule;
}

/// @nodoc
class __$$PolicyValidationImplCopyWithImpl<$Res>
    extends _$PolicyValidationCopyWithImpl<$Res, _$PolicyValidationImpl>
    implements _$$PolicyValidationImplCopyWith<$Res> {
  __$$PolicyValidationImplCopyWithImpl(_$PolicyValidationImpl _value,
      $Res Function(_$PolicyValidationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isCompliant = null,
    Object? requiresApproval = null,
    Object? violations = null,
    Object? warnings = null,
    Object? policyRule = null,
  }) {
    return _then(_$PolicyValidationImpl(
      isCompliant: null == isCompliant
          ? _value.isCompliant
          : isCompliant // ignore: cast_nullable_to_non_nullable
              as bool,
      requiresApproval: null == requiresApproval
          ? _value.requiresApproval
          : requiresApproval // ignore: cast_nullable_to_non_nullable
              as bool,
      violations: null == violations
          ? _value._violations
          : violations // ignore: cast_nullable_to_non_nullable
              as List<PolicyViolation>,
      warnings: null == warnings
          ? _value._warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<PolicyViolation>,
      policyRule: null == policyRule
          ? _value.policyRule
          : policyRule // ignore: cast_nullable_to_non_nullable
              as PolicyRule,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PolicyValidationImpl implements _PolicyValidation {
  const _$PolicyValidationImpl(
      {required this.isCompliant,
      required this.requiresApproval,
      required final List<PolicyViolation> violations,
      required final List<PolicyViolation> warnings,
      required this.policyRule})
      : _violations = violations,
        _warnings = warnings;

  factory _$PolicyValidationImpl.fromJson(Map<String, dynamic> json) =>
      _$$PolicyValidationImplFromJson(json);

  @override
  final bool isCompliant;
  @override
  final bool requiresApproval;
  final List<PolicyViolation> _violations;
  @override
  List<PolicyViolation> get violations {
    if (_violations is EqualUnmodifiableListView) return _violations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_violations);
  }

  final List<PolicyViolation> _warnings;
  @override
  List<PolicyViolation> get warnings {
    if (_warnings is EqualUnmodifiableListView) return _warnings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_warnings);
  }

  @override
  final PolicyRule policyRule;

  @override
  String toString() {
    return 'PolicyValidation(isCompliant: $isCompliant, requiresApproval: $requiresApproval, violations: $violations, warnings: $warnings, policyRule: $policyRule)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PolicyValidationImpl &&
            (identical(other.isCompliant, isCompliant) ||
                other.isCompliant == isCompliant) &&
            (identical(other.requiresApproval, requiresApproval) ||
                other.requiresApproval == requiresApproval) &&
            const DeepCollectionEquality()
                .equals(other._violations, _violations) &&
            const DeepCollectionEquality().equals(other._warnings, _warnings) &&
            (identical(other.policyRule, policyRule) ||
                other.policyRule == policyRule));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      isCompliant,
      requiresApproval,
      const DeepCollectionEquality().hash(_violations),
      const DeepCollectionEquality().hash(_warnings),
      policyRule);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PolicyValidationImplCopyWith<_$PolicyValidationImpl> get copyWith =>
      __$$PolicyValidationImplCopyWithImpl<_$PolicyValidationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PolicyValidationImplToJson(
      this,
    );
  }
}

abstract class _PolicyValidation implements PolicyValidation {
  const factory _PolicyValidation(
      {required final bool isCompliant,
      required final bool requiresApproval,
      required final List<PolicyViolation> violations,
      required final List<PolicyViolation> warnings,
      required final PolicyRule policyRule}) = _$PolicyValidationImpl;

  factory _PolicyValidation.fromJson(Map<String, dynamic> json) =
      _$PolicyValidationImpl.fromJson;

  @override
  bool get isCompliant;
  @override
  bool get requiresApproval;
  @override
  List<PolicyViolation> get violations;
  @override
  List<PolicyViolation> get warnings;
  @override
  PolicyRule get policyRule;
  @override
  @JsonKey(ignore: true)
  _$$PolicyValidationImplCopyWith<_$PolicyValidationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PolicyViolation _$PolicyViolationFromJson(Map<String, dynamic> json) {
  return _PolicyViolation.fromJson(json);
}

/// @nodoc
mixin _$PolicyViolation {
  String get type => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get severity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PolicyViolationCopyWith<PolicyViolation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PolicyViolationCopyWith<$Res> {
  factory $PolicyViolationCopyWith(
          PolicyViolation value, $Res Function(PolicyViolation) then) =
      _$PolicyViolationCopyWithImpl<$Res, PolicyViolation>;
  @useResult
  $Res call({String type, String message, String severity});
}

/// @nodoc
class _$PolicyViolationCopyWithImpl<$Res, $Val extends PolicyViolation>
    implements $PolicyViolationCopyWith<$Res> {
  _$PolicyViolationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? message = null,
    Object? severity = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PolicyViolationImplCopyWith<$Res>
    implements $PolicyViolationCopyWith<$Res> {
  factory _$$PolicyViolationImplCopyWith(_$PolicyViolationImpl value,
          $Res Function(_$PolicyViolationImpl) then) =
      __$$PolicyViolationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, String message, String severity});
}

/// @nodoc
class __$$PolicyViolationImplCopyWithImpl<$Res>
    extends _$PolicyViolationCopyWithImpl<$Res, _$PolicyViolationImpl>
    implements _$$PolicyViolationImplCopyWith<$Res> {
  __$$PolicyViolationImplCopyWithImpl(
      _$PolicyViolationImpl _value, $Res Function(_$PolicyViolationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? message = null,
    Object? severity = null,
  }) {
    return _then(_$PolicyViolationImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PolicyViolationImpl implements _PolicyViolation {
  const _$PolicyViolationImpl(
      {required this.type, required this.message, required this.severity});

  factory _$PolicyViolationImpl.fromJson(Map<String, dynamic> json) =>
      _$$PolicyViolationImplFromJson(json);

  @override
  final String type;
  @override
  final String message;
  @override
  final String severity;

  @override
  String toString() {
    return 'PolicyViolation(type: $type, message: $message, severity: $severity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PolicyViolationImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.severity, severity) ||
                other.severity == severity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, message, severity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PolicyViolationImplCopyWith<_$PolicyViolationImpl> get copyWith =>
      __$$PolicyViolationImplCopyWithImpl<_$PolicyViolationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PolicyViolationImplToJson(
      this,
    );
  }
}

abstract class _PolicyViolation implements PolicyViolation {
  const factory _PolicyViolation(
      {required final String type,
      required final String message,
      required final String severity}) = _$PolicyViolationImpl;

  factory _PolicyViolation.fromJson(Map<String, dynamic> json) =
      _$PolicyViolationImpl.fromJson;

  @override
  String get type;
  @override
  String get message;
  @override
  String get severity;
  @override
  @JsonKey(ignore: true)
  _$$PolicyViolationImplCopyWith<_$PolicyViolationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PolicyRule _$PolicyRuleFromJson(Map<String, dynamic> json) {
  return _PolicyRule.fromJson(json);
}

/// @nodoc
mixin _$PolicyRule {
  double get maxAmount => throw _privateConstructorUsedError;
  bool get requiresReceipt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PolicyRuleCopyWith<PolicyRule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PolicyRuleCopyWith<$Res> {
  factory $PolicyRuleCopyWith(
          PolicyRule value, $Res Function(PolicyRule) then) =
      _$PolicyRuleCopyWithImpl<$Res, PolicyRule>;
  @useResult
  $Res call({double maxAmount, bool requiresReceipt});
}

/// @nodoc
class _$PolicyRuleCopyWithImpl<$Res, $Val extends PolicyRule>
    implements $PolicyRuleCopyWith<$Res> {
  _$PolicyRuleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxAmount = null,
    Object? requiresReceipt = null,
  }) {
    return _then(_value.copyWith(
      maxAmount: null == maxAmount
          ? _value.maxAmount
          : maxAmount // ignore: cast_nullable_to_non_nullable
              as double,
      requiresReceipt: null == requiresReceipt
          ? _value.requiresReceipt
          : requiresReceipt // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PolicyRuleImplCopyWith<$Res>
    implements $PolicyRuleCopyWith<$Res> {
  factory _$$PolicyRuleImplCopyWith(
          _$PolicyRuleImpl value, $Res Function(_$PolicyRuleImpl) then) =
      __$$PolicyRuleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double maxAmount, bool requiresReceipt});
}

/// @nodoc
class __$$PolicyRuleImplCopyWithImpl<$Res>
    extends _$PolicyRuleCopyWithImpl<$Res, _$PolicyRuleImpl>
    implements _$$PolicyRuleImplCopyWith<$Res> {
  __$$PolicyRuleImplCopyWithImpl(
      _$PolicyRuleImpl _value, $Res Function(_$PolicyRuleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxAmount = null,
    Object? requiresReceipt = null,
  }) {
    return _then(_$PolicyRuleImpl(
      maxAmount: null == maxAmount
          ? _value.maxAmount
          : maxAmount // ignore: cast_nullable_to_non_nullable
              as double,
      requiresReceipt: null == requiresReceipt
          ? _value.requiresReceipt
          : requiresReceipt // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PolicyRuleImpl implements _PolicyRule {
  const _$PolicyRuleImpl(
      {required this.maxAmount, required this.requiresReceipt});

  factory _$PolicyRuleImpl.fromJson(Map<String, dynamic> json) =>
      _$$PolicyRuleImplFromJson(json);

  @override
  final double maxAmount;
  @override
  final bool requiresReceipt;

  @override
  String toString() {
    return 'PolicyRule(maxAmount: $maxAmount, requiresReceipt: $requiresReceipt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PolicyRuleImpl &&
            (identical(other.maxAmount, maxAmount) ||
                other.maxAmount == maxAmount) &&
            (identical(other.requiresReceipt, requiresReceipt) ||
                other.requiresReceipt == requiresReceipt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, maxAmount, requiresReceipt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PolicyRuleImplCopyWith<_$PolicyRuleImpl> get copyWith =>
      __$$PolicyRuleImplCopyWithImpl<_$PolicyRuleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PolicyRuleImplToJson(
      this,
    );
  }
}

abstract class _PolicyRule implements PolicyRule {
  const factory _PolicyRule(
      {required final double maxAmount,
      required final bool requiresReceipt}) = _$PolicyRuleImpl;

  factory _PolicyRule.fromJson(Map<String, dynamic> json) =
      _$PolicyRuleImpl.fromJson;

  @override
  double get maxAmount;
  @override
  bool get requiresReceipt;
  @override
  @JsonKey(ignore: true)
  _$$PolicyRuleImplCopyWith<_$PolicyRuleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DuplicateCheck _$DuplicateCheckFromJson(Map<String, dynamic> json) {
  return _DuplicateCheck.fromJson(json);
}

/// @nodoc
mixin _$DuplicateCheck {
  bool get isDuplicate => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  MatchedExpense? get matchedExpense => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DuplicateCheckCopyWith<DuplicateCheck> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DuplicateCheckCopyWith<$Res> {
  factory $DuplicateCheckCopyWith(
          DuplicateCheck value, $Res Function(DuplicateCheck) then) =
      _$DuplicateCheckCopyWithImpl<$Res, DuplicateCheck>;
  @useResult
  $Res call(
      {bool isDuplicate, double confidence, MatchedExpense? matchedExpense});

  $MatchedExpenseCopyWith<$Res>? get matchedExpense;
}

/// @nodoc
class _$DuplicateCheckCopyWithImpl<$Res, $Val extends DuplicateCheck>
    implements $DuplicateCheckCopyWith<$Res> {
  _$DuplicateCheckCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isDuplicate = null,
    Object? confidence = null,
    Object? matchedExpense = freezed,
  }) {
    return _then(_value.copyWith(
      isDuplicate: null == isDuplicate
          ? _value.isDuplicate
          : isDuplicate // ignore: cast_nullable_to_non_nullable
              as bool,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      matchedExpense: freezed == matchedExpense
          ? _value.matchedExpense
          : matchedExpense // ignore: cast_nullable_to_non_nullable
              as MatchedExpense?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MatchedExpenseCopyWith<$Res>? get matchedExpense {
    if (_value.matchedExpense == null) {
      return null;
    }

    return $MatchedExpenseCopyWith<$Res>(_value.matchedExpense!, (value) {
      return _then(_value.copyWith(matchedExpense: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DuplicateCheckImplCopyWith<$Res>
    implements $DuplicateCheckCopyWith<$Res> {
  factory _$$DuplicateCheckImplCopyWith(_$DuplicateCheckImpl value,
          $Res Function(_$DuplicateCheckImpl) then) =
      __$$DuplicateCheckImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isDuplicate, double confidence, MatchedExpense? matchedExpense});

  @override
  $MatchedExpenseCopyWith<$Res>? get matchedExpense;
}

/// @nodoc
class __$$DuplicateCheckImplCopyWithImpl<$Res>
    extends _$DuplicateCheckCopyWithImpl<$Res, _$DuplicateCheckImpl>
    implements _$$DuplicateCheckImplCopyWith<$Res> {
  __$$DuplicateCheckImplCopyWithImpl(
      _$DuplicateCheckImpl _value, $Res Function(_$DuplicateCheckImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isDuplicate = null,
    Object? confidence = null,
    Object? matchedExpense = freezed,
  }) {
    return _then(_$DuplicateCheckImpl(
      isDuplicate: null == isDuplicate
          ? _value.isDuplicate
          : isDuplicate // ignore: cast_nullable_to_non_nullable
              as bool,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      matchedExpense: freezed == matchedExpense
          ? _value.matchedExpense
          : matchedExpense // ignore: cast_nullable_to_non_nullable
              as MatchedExpense?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DuplicateCheckImpl implements _DuplicateCheck {
  const _$DuplicateCheckImpl(
      {required this.isDuplicate,
      required this.confidence,
      this.matchedExpense});

  factory _$DuplicateCheckImpl.fromJson(Map<String, dynamic> json) =>
      _$$DuplicateCheckImplFromJson(json);

  @override
  final bool isDuplicate;
  @override
  final double confidence;
  @override
  final MatchedExpense? matchedExpense;

  @override
  String toString() {
    return 'DuplicateCheck(isDuplicate: $isDuplicate, confidence: $confidence, matchedExpense: $matchedExpense)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DuplicateCheckImpl &&
            (identical(other.isDuplicate, isDuplicate) ||
                other.isDuplicate == isDuplicate) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.matchedExpense, matchedExpense) ||
                other.matchedExpense == matchedExpense));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, isDuplicate, confidence, matchedExpense);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DuplicateCheckImplCopyWith<_$DuplicateCheckImpl> get copyWith =>
      __$$DuplicateCheckImplCopyWithImpl<_$DuplicateCheckImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DuplicateCheckImplToJson(
      this,
    );
  }
}

abstract class _DuplicateCheck implements DuplicateCheck {
  const factory _DuplicateCheck(
      {required final bool isDuplicate,
      required final double confidence,
      final MatchedExpense? matchedExpense}) = _$DuplicateCheckImpl;

  factory _DuplicateCheck.fromJson(Map<String, dynamic> json) =
      _$DuplicateCheckImpl.fromJson;

  @override
  bool get isDuplicate;
  @override
  double get confidence;
  @override
  MatchedExpense? get matchedExpense;
  @override
  @JsonKey(ignore: true)
  _$$DuplicateCheckImplCopyWith<_$DuplicateCheckImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MatchedExpense _$MatchedExpenseFromJson(Map<String, dynamic> json) {
  return _MatchedExpense.fromJson(json);
}

/// @nodoc
mixin _$MatchedExpense {
  String get expenseId => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get merchant => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchedExpenseCopyWith<MatchedExpense> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchedExpenseCopyWith<$Res> {
  factory $MatchedExpenseCopyWith(
          MatchedExpense value, $Res Function(MatchedExpense) then) =
      _$MatchedExpenseCopyWithImpl<$Res, MatchedExpense>;
  @useResult
  $Res call({String expenseId, String date, double amount, String merchant});
}

/// @nodoc
class _$MatchedExpenseCopyWithImpl<$Res, $Val extends MatchedExpense>
    implements $MatchedExpenseCopyWith<$Res> {
  _$MatchedExpenseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expenseId = null,
    Object? date = null,
    Object? amount = null,
    Object? merchant = null,
  }) {
    return _then(_value.copyWith(
      expenseId: null == expenseId
          ? _value.expenseId
          : expenseId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      merchant: null == merchant
          ? _value.merchant
          : merchant // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MatchedExpenseImplCopyWith<$Res>
    implements $MatchedExpenseCopyWith<$Res> {
  factory _$$MatchedExpenseImplCopyWith(_$MatchedExpenseImpl value,
          $Res Function(_$MatchedExpenseImpl) then) =
      __$$MatchedExpenseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String expenseId, String date, double amount, String merchant});
}

/// @nodoc
class __$$MatchedExpenseImplCopyWithImpl<$Res>
    extends _$MatchedExpenseCopyWithImpl<$Res, _$MatchedExpenseImpl>
    implements _$$MatchedExpenseImplCopyWith<$Res> {
  __$$MatchedExpenseImplCopyWithImpl(
      _$MatchedExpenseImpl _value, $Res Function(_$MatchedExpenseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expenseId = null,
    Object? date = null,
    Object? amount = null,
    Object? merchant = null,
  }) {
    return _then(_$MatchedExpenseImpl(
      expenseId: null == expenseId
          ? _value.expenseId
          : expenseId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      merchant: null == merchant
          ? _value.merchant
          : merchant // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchedExpenseImpl implements _MatchedExpense {
  const _$MatchedExpenseImpl(
      {required this.expenseId,
      required this.date,
      required this.amount,
      required this.merchant});

  factory _$MatchedExpenseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchedExpenseImplFromJson(json);

  @override
  final String expenseId;
  @override
  final String date;
  @override
  final double amount;
  @override
  final String merchant;

  @override
  String toString() {
    return 'MatchedExpense(expenseId: $expenseId, date: $date, amount: $amount, merchant: $merchant)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchedExpenseImpl &&
            (identical(other.expenseId, expenseId) ||
                other.expenseId == expenseId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.merchant, merchant) ||
                other.merchant == merchant));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, expenseId, date, amount, merchant);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchedExpenseImplCopyWith<_$MatchedExpenseImpl> get copyWith =>
      __$$MatchedExpenseImplCopyWithImpl<_$MatchedExpenseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchedExpenseImplToJson(
      this,
    );
  }
}

abstract class _MatchedExpense implements MatchedExpense {
  const factory _MatchedExpense(
      {required final String expenseId,
      required final String date,
      required final double amount,
      required final String merchant}) = _$MatchedExpenseImpl;

  factory _MatchedExpense.fromJson(Map<String, dynamic> json) =
      _$MatchedExpenseImpl.fromJson;

  @override
  String get expenseId;
  @override
  String get date;
  @override
  double get amount;
  @override
  String get merchant;
  @override
  @JsonKey(ignore: true)
  _$$MatchedExpenseImplCopyWith<_$MatchedExpenseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MileageCalculation _$MileageCalculationFromJson(Map<String, dynamic> json) {
  return _MileageCalculation.fromJson(json);
}

/// @nodoc
mixin _$MileageCalculation {
  double get totalDistance => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  double get ratePerKm => throw _privateConstructorUsedError;
  double get reimbursement => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  LocationPoint get startLocation => throw _privateConstructorUsedError;
  LocationPoint get endLocation => throw _privateConstructorUsedError;
  int get waypoints => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MileageCalculationCopyWith<MileageCalculation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MileageCalculationCopyWith<$Res> {
  factory $MileageCalculationCopyWith(
          MileageCalculation value, $Res Function(MileageCalculation) then) =
      _$MileageCalculationCopyWithImpl<$Res, MileageCalculation>;
  @useResult
  $Res call(
      {double totalDistance,
      String unit,
      double ratePerKm,
      double reimbursement,
      String currency,
      LocationPoint startLocation,
      LocationPoint endLocation,
      int waypoints});

  $LocationPointCopyWith<$Res> get startLocation;
  $LocationPointCopyWith<$Res> get endLocation;
}

/// @nodoc
class _$MileageCalculationCopyWithImpl<$Res, $Val extends MileageCalculation>
    implements $MileageCalculationCopyWith<$Res> {
  _$MileageCalculationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalDistance = null,
    Object? unit = null,
    Object? ratePerKm = null,
    Object? reimbursement = null,
    Object? currency = null,
    Object? startLocation = null,
    Object? endLocation = null,
    Object? waypoints = null,
  }) {
    return _then(_value.copyWith(
      totalDistance: null == totalDistance
          ? _value.totalDistance
          : totalDistance // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      ratePerKm: null == ratePerKm
          ? _value.ratePerKm
          : ratePerKm // ignore: cast_nullable_to_non_nullable
              as double,
      reimbursement: null == reimbursement
          ? _value.reimbursement
          : reimbursement // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      startLocation: null == startLocation
          ? _value.startLocation
          : startLocation // ignore: cast_nullable_to_non_nullable
              as LocationPoint,
      endLocation: null == endLocation
          ? _value.endLocation
          : endLocation // ignore: cast_nullable_to_non_nullable
              as LocationPoint,
      waypoints: null == waypoints
          ? _value.waypoints
          : waypoints // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LocationPointCopyWith<$Res> get startLocation {
    return $LocationPointCopyWith<$Res>(_value.startLocation, (value) {
      return _then(_value.copyWith(startLocation: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $LocationPointCopyWith<$Res> get endLocation {
    return $LocationPointCopyWith<$Res>(_value.endLocation, (value) {
      return _then(_value.copyWith(endLocation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MileageCalculationImplCopyWith<$Res>
    implements $MileageCalculationCopyWith<$Res> {
  factory _$$MileageCalculationImplCopyWith(_$MileageCalculationImpl value,
          $Res Function(_$MileageCalculationImpl) then) =
      __$$MileageCalculationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double totalDistance,
      String unit,
      double ratePerKm,
      double reimbursement,
      String currency,
      LocationPoint startLocation,
      LocationPoint endLocation,
      int waypoints});

  @override
  $LocationPointCopyWith<$Res> get startLocation;
  @override
  $LocationPointCopyWith<$Res> get endLocation;
}

/// @nodoc
class __$$MileageCalculationImplCopyWithImpl<$Res>
    extends _$MileageCalculationCopyWithImpl<$Res, _$MileageCalculationImpl>
    implements _$$MileageCalculationImplCopyWith<$Res> {
  __$$MileageCalculationImplCopyWithImpl(_$MileageCalculationImpl _value,
      $Res Function(_$MileageCalculationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalDistance = null,
    Object? unit = null,
    Object? ratePerKm = null,
    Object? reimbursement = null,
    Object? currency = null,
    Object? startLocation = null,
    Object? endLocation = null,
    Object? waypoints = null,
  }) {
    return _then(_$MileageCalculationImpl(
      totalDistance: null == totalDistance
          ? _value.totalDistance
          : totalDistance // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      ratePerKm: null == ratePerKm
          ? _value.ratePerKm
          : ratePerKm // ignore: cast_nullable_to_non_nullable
              as double,
      reimbursement: null == reimbursement
          ? _value.reimbursement
          : reimbursement // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      startLocation: null == startLocation
          ? _value.startLocation
          : startLocation // ignore: cast_nullable_to_non_nullable
              as LocationPoint,
      endLocation: null == endLocation
          ? _value.endLocation
          : endLocation // ignore: cast_nullable_to_non_nullable
              as LocationPoint,
      waypoints: null == waypoints
          ? _value.waypoints
          : waypoints // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MileageCalculationImpl implements _MileageCalculation {
  const _$MileageCalculationImpl(
      {required this.totalDistance,
      required this.unit,
      required this.ratePerKm,
      required this.reimbursement,
      required this.currency,
      required this.startLocation,
      required this.endLocation,
      required this.waypoints});

  factory _$MileageCalculationImpl.fromJson(Map<String, dynamic> json) =>
      _$$MileageCalculationImplFromJson(json);

  @override
  final double totalDistance;
  @override
  final String unit;
  @override
  final double ratePerKm;
  @override
  final double reimbursement;
  @override
  final String currency;
  @override
  final LocationPoint startLocation;
  @override
  final LocationPoint endLocation;
  @override
  final int waypoints;

  @override
  String toString() {
    return 'MileageCalculation(totalDistance: $totalDistance, unit: $unit, ratePerKm: $ratePerKm, reimbursement: $reimbursement, currency: $currency, startLocation: $startLocation, endLocation: $endLocation, waypoints: $waypoints)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MileageCalculationImpl &&
            (identical(other.totalDistance, totalDistance) ||
                other.totalDistance == totalDistance) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.ratePerKm, ratePerKm) ||
                other.ratePerKm == ratePerKm) &&
            (identical(other.reimbursement, reimbursement) ||
                other.reimbursement == reimbursement) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.startLocation, startLocation) ||
                other.startLocation == startLocation) &&
            (identical(other.endLocation, endLocation) ||
                other.endLocation == endLocation) &&
            (identical(other.waypoints, waypoints) ||
                other.waypoints == waypoints));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, totalDistance, unit, ratePerKm,
      reimbursement, currency, startLocation, endLocation, waypoints);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MileageCalculationImplCopyWith<_$MileageCalculationImpl> get copyWith =>
      __$$MileageCalculationImplCopyWithImpl<_$MileageCalculationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MileageCalculationImplToJson(
      this,
    );
  }
}

abstract class _MileageCalculation implements MileageCalculation {
  const factory _MileageCalculation(
      {required final double totalDistance,
      required final String unit,
      required final double ratePerKm,
      required final double reimbursement,
      required final String currency,
      required final LocationPoint startLocation,
      required final LocationPoint endLocation,
      required final int waypoints}) = _$MileageCalculationImpl;

  factory _MileageCalculation.fromJson(Map<String, dynamic> json) =
      _$MileageCalculationImpl.fromJson;

  @override
  double get totalDistance;
  @override
  String get unit;
  @override
  double get ratePerKm;
  @override
  double get reimbursement;
  @override
  String get currency;
  @override
  LocationPoint get startLocation;
  @override
  LocationPoint get endLocation;
  @override
  int get waypoints;
  @override
  @JsonKey(ignore: true)
  _$$MileageCalculationImplCopyWith<_$MileageCalculationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LocationPoint _$LocationPointFromJson(Map<String, dynamic> json) {
  return _LocationPoint.fromJson(json);
}

/// @nodoc
mixin _$LocationPoint {
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;
  String? get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocationPointCopyWith<LocationPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationPointCopyWith<$Res> {
  factory $LocationPointCopyWith(
          LocationPoint value, $Res Function(LocationPoint) then) =
      _$LocationPointCopyWithImpl<$Res, LocationPoint>;
  @useResult
  $Res call({double lat, double lng, String? timestamp});
}

/// @nodoc
class _$LocationPointCopyWithImpl<$Res, $Val extends LocationPoint>
    implements $LocationPointCopyWith<$Res> {
  _$LocationPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lat = null,
    Object? lng = null,
    Object? timestamp = freezed,
  }) {
    return _then(_value.copyWith(
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocationPointImplCopyWith<$Res>
    implements $LocationPointCopyWith<$Res> {
  factory _$$LocationPointImplCopyWith(
          _$LocationPointImpl value, $Res Function(_$LocationPointImpl) then) =
      __$$LocationPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double lat, double lng, String? timestamp});
}

/// @nodoc
class __$$LocationPointImplCopyWithImpl<$Res>
    extends _$LocationPointCopyWithImpl<$Res, _$LocationPointImpl>
    implements _$$LocationPointImplCopyWith<$Res> {
  __$$LocationPointImplCopyWithImpl(
      _$LocationPointImpl _value, $Res Function(_$LocationPointImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lat = null,
    Object? lng = null,
    Object? timestamp = freezed,
  }) {
    return _then(_$LocationPointImpl(
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LocationPointImpl implements _LocationPoint {
  const _$LocationPointImpl(
      {required this.lat, required this.lng, this.timestamp});

  factory _$LocationPointImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocationPointImplFromJson(json);

  @override
  final double lat;
  @override
  final double lng;
  @override
  final String? timestamp;

  @override
  String toString() {
    return 'LocationPoint(lat: $lat, lng: $lng, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationPointImpl &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, lat, lng, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationPointImplCopyWith<_$LocationPointImpl> get copyWith =>
      __$$LocationPointImplCopyWithImpl<_$LocationPointImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationPointImplToJson(
      this,
    );
  }
}

abstract class _LocationPoint implements LocationPoint {
  const factory _LocationPoint(
      {required final double lat,
      required final double lng,
      final String? timestamp}) = _$LocationPointImpl;

  factory _LocationPoint.fromJson(Map<String, dynamic> json) =
      _$LocationPointImpl.fromJson;

  @override
  double get lat;
  @override
  double get lng;
  @override
  String? get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$LocationPointImplCopyWith<_$LocationPointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
