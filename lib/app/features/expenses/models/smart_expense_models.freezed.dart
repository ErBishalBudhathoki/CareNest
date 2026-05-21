// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'smart_expense_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReceiptScan {
  String get merchant;
  String get date;
  double get amount;
  String get currency;
  List<ReceiptItem> get items;
  double get tax;
  double get total;
  String get paymentMethod;
  double get confidence;

  /// Create a copy of ReceiptScan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReceiptScanCopyWith<ReceiptScan> get copyWith =>
      _$ReceiptScanCopyWithImpl<ReceiptScan>(this as ReceiptScan, _$identity);

  /// Serializes this ReceiptScan to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ReceiptScan &&
            (identical(other.merchant, merchant) ||
                other.merchant == merchant) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            const DeepCollectionEquality().equals(other.items, items) &&
            (identical(other.tax, tax) || other.tax == tax) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      merchant,
      date,
      amount,
      currency,
      const DeepCollectionEquality().hash(items),
      tax,
      total,
      paymentMethod,
      confidence);

  @override
  String toString() {
    return 'ReceiptScan(merchant: $merchant, date: $date, amount: $amount, currency: $currency, items: $items, tax: $tax, total: $total, paymentMethod: $paymentMethod, confidence: $confidence)';
  }
}

/// @nodoc
abstract mixin class $ReceiptScanCopyWith<$Res> {
  factory $ReceiptScanCopyWith(
          ReceiptScan value, $Res Function(ReceiptScan) _then) =
      _$ReceiptScanCopyWithImpl;
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
class _$ReceiptScanCopyWithImpl<$Res> implements $ReceiptScanCopyWith<$Res> {
  _$ReceiptScanCopyWithImpl(this._self, this._then);

  final ReceiptScan _self;
  final $Res Function(ReceiptScan) _then;

  /// Create a copy of ReceiptScan
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(_self.copyWith(
      merchant: null == merchant
          ? _self.merchant
          : merchant // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _self.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ReceiptItem>,
      tax: null == tax
          ? _self.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      paymentMethod: null == paymentMethod
          ? _self.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _self.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [ReceiptScan].
extension ReceiptScanPatterns on ReceiptScan {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ReceiptScan value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ReceiptScan() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ReceiptScan value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReceiptScan():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ReceiptScan value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReceiptScan() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String merchant,
            String date,
            double amount,
            String currency,
            List<ReceiptItem> items,
            double tax,
            double total,
            String paymentMethod,
            double confidence)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ReceiptScan() when $default != null:
        return $default(
            _that.merchant,
            _that.date,
            _that.amount,
            _that.currency,
            _that.items,
            _that.tax,
            _that.total,
            _that.paymentMethod,
            _that.confidence);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String merchant,
            String date,
            double amount,
            String currency,
            List<ReceiptItem> items,
            double tax,
            double total,
            String paymentMethod,
            double confidence)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReceiptScan():
        return $default(
            _that.merchant,
            _that.date,
            _that.amount,
            _that.currency,
            _that.items,
            _that.tax,
            _that.total,
            _that.paymentMethod,
            _that.confidence);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String merchant,
            String date,
            double amount,
            String currency,
            List<ReceiptItem> items,
            double tax,
            double total,
            String paymentMethod,
            double confidence)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReceiptScan() when $default != null:
        return $default(
            _that.merchant,
            _that.date,
            _that.amount,
            _that.currency,
            _that.items,
            _that.tax,
            _that.total,
            _that.paymentMethod,
            _that.confidence);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ReceiptScan implements ReceiptScan {
  const _ReceiptScan(
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
  factory _ReceiptScan.fromJson(Map<String, dynamic> json) =>
      _$ReceiptScanFromJson(json);

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

  /// Create a copy of ReceiptScan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReceiptScanCopyWith<_ReceiptScan> get copyWith =>
      __$ReceiptScanCopyWithImpl<_ReceiptScan>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ReceiptScanToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReceiptScan &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  String toString() {
    return 'ReceiptScan(merchant: $merchant, date: $date, amount: $amount, currency: $currency, items: $items, tax: $tax, total: $total, paymentMethod: $paymentMethod, confidence: $confidence)';
  }
}

/// @nodoc
abstract mixin class _$ReceiptScanCopyWith<$Res>
    implements $ReceiptScanCopyWith<$Res> {
  factory _$ReceiptScanCopyWith(
          _ReceiptScan value, $Res Function(_ReceiptScan) _then) =
      __$ReceiptScanCopyWithImpl;
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
class __$ReceiptScanCopyWithImpl<$Res> implements _$ReceiptScanCopyWith<$Res> {
  __$ReceiptScanCopyWithImpl(this._self, this._then);

  final _ReceiptScan _self;
  final $Res Function(_ReceiptScan) _then;

  /// Create a copy of ReceiptScan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_ReceiptScan(
      merchant: null == merchant
          ? _self.merchant
          : merchant // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _self.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ReceiptItem>,
      tax: null == tax
          ? _self.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      paymentMethod: null == paymentMethod
          ? _self.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _self.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
mixin _$ReceiptItem {
  String get description;
  int get quantity;
  double get price;

  /// Create a copy of ReceiptItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReceiptItemCopyWith<ReceiptItem> get copyWith =>
      _$ReceiptItemCopyWithImpl<ReceiptItem>(this as ReceiptItem, _$identity);

  /// Serializes this ReceiptItem to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ReceiptItem &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.price, price) || other.price == price));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, description, quantity, price);

  @override
  String toString() {
    return 'ReceiptItem(description: $description, quantity: $quantity, price: $price)';
  }
}

/// @nodoc
abstract mixin class $ReceiptItemCopyWith<$Res> {
  factory $ReceiptItemCopyWith(
          ReceiptItem value, $Res Function(ReceiptItem) _then) =
      _$ReceiptItemCopyWithImpl;
  @useResult
  $Res call({String description, int quantity, double price});
}

/// @nodoc
class _$ReceiptItemCopyWithImpl<$Res> implements $ReceiptItemCopyWith<$Res> {
  _$ReceiptItemCopyWithImpl(this._self, this._then);

  final ReceiptItem _self;
  final $Res Function(ReceiptItem) _then;

  /// Create a copy of ReceiptItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? quantity = null,
    Object? price = null,
  }) {
    return _then(_self.copyWith(
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [ReceiptItem].
extension ReceiptItemPatterns on ReceiptItem {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ReceiptItem value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ReceiptItem() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ReceiptItem value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReceiptItem():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ReceiptItem value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReceiptItem() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String description, int quantity, double price)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ReceiptItem() when $default != null:
        return $default(_that.description, _that.quantity, _that.price);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String description, int quantity, double price) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReceiptItem():
        return $default(_that.description, _that.quantity, _that.price);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String description, int quantity, double price)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReceiptItem() when $default != null:
        return $default(_that.description, _that.quantity, _that.price);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ReceiptItem implements ReceiptItem {
  const _ReceiptItem(
      {required this.description, required this.quantity, required this.price});
  factory _ReceiptItem.fromJson(Map<String, dynamic> json) =>
      _$ReceiptItemFromJson(json);

  @override
  final String description;
  @override
  final int quantity;
  @override
  final double price;

  /// Create a copy of ReceiptItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReceiptItemCopyWith<_ReceiptItem> get copyWith =>
      __$ReceiptItemCopyWithImpl<_ReceiptItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ReceiptItemToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReceiptItem &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.price, price) || other.price == price));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, description, quantity, price);

  @override
  String toString() {
    return 'ReceiptItem(description: $description, quantity: $quantity, price: $price)';
  }
}

/// @nodoc
abstract mixin class _$ReceiptItemCopyWith<$Res>
    implements $ReceiptItemCopyWith<$Res> {
  factory _$ReceiptItemCopyWith(
          _ReceiptItem value, $Res Function(_ReceiptItem) _then) =
      __$ReceiptItemCopyWithImpl;
  @override
  @useResult
  $Res call({String description, int quantity, double price});
}

/// @nodoc
class __$ReceiptItemCopyWithImpl<$Res> implements _$ReceiptItemCopyWith<$Res> {
  __$ReceiptItemCopyWithImpl(this._self, this._then);

  final _ReceiptItem _self;
  final $Res Function(_ReceiptItem) _then;

  /// Create a copy of ReceiptItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? description = null,
    Object? quantity = null,
    Object? price = null,
  }) {
    return _then(_ReceiptItem(
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
mixin _$ExpenseCategory {
  String get category;
  double get confidence;
  List<CategorySuggestion> get suggestedCategories;

  /// Create a copy of ExpenseCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExpenseCategoryCopyWith<ExpenseCategory> get copyWith =>
      _$ExpenseCategoryCopyWithImpl<ExpenseCategory>(
          this as ExpenseCategory, _$identity);

  /// Serializes this ExpenseCategory to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExpenseCategory &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            const DeepCollectionEquality()
                .equals(other.suggestedCategories, suggestedCategories));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, category, confidence,
      const DeepCollectionEquality().hash(suggestedCategories));

  @override
  String toString() {
    return 'ExpenseCategory(category: $category, confidence: $confidence, suggestedCategories: $suggestedCategories)';
  }
}

/// @nodoc
abstract mixin class $ExpenseCategoryCopyWith<$Res> {
  factory $ExpenseCategoryCopyWith(
          ExpenseCategory value, $Res Function(ExpenseCategory) _then) =
      _$ExpenseCategoryCopyWithImpl;
  @useResult
  $Res call(
      {String category,
      double confidence,
      List<CategorySuggestion> suggestedCategories});
}

/// @nodoc
class _$ExpenseCategoryCopyWithImpl<$Res>
    implements $ExpenseCategoryCopyWith<$Res> {
  _$ExpenseCategoryCopyWithImpl(this._self, this._then);

  final ExpenseCategory _self;
  final $Res Function(ExpenseCategory) _then;

  /// Create a copy of ExpenseCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = null,
    Object? confidence = null,
    Object? suggestedCategories = null,
  }) {
    return _then(_self.copyWith(
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _self.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      suggestedCategories: null == suggestedCategories
          ? _self.suggestedCategories
          : suggestedCategories // ignore: cast_nullable_to_non_nullable
              as List<CategorySuggestion>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ExpenseCategory].
extension ExpenseCategoryPatterns on ExpenseCategory {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ExpenseCategory value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExpenseCategory() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ExpenseCategory value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExpenseCategory():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ExpenseCategory value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExpenseCategory() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String category, double confidence,
            List<CategorySuggestion> suggestedCategories)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExpenseCategory() when $default != null:
        return $default(
            _that.category, _that.confidence, _that.suggestedCategories);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String category, double confidence,
            List<CategorySuggestion> suggestedCategories)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExpenseCategory():
        return $default(
            _that.category, _that.confidence, _that.suggestedCategories);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String category, double confidence,
            List<CategorySuggestion> suggestedCategories)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExpenseCategory() when $default != null:
        return $default(
            _that.category, _that.confidence, _that.suggestedCategories);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ExpenseCategory implements ExpenseCategory {
  const _ExpenseCategory(
      {required this.category,
      required this.confidence,
      required final List<CategorySuggestion> suggestedCategories})
      : _suggestedCategories = suggestedCategories;
  factory _ExpenseCategory.fromJson(Map<String, dynamic> json) =>
      _$ExpenseCategoryFromJson(json);

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

  /// Create a copy of ExpenseCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExpenseCategoryCopyWith<_ExpenseCategory> get copyWith =>
      __$ExpenseCategoryCopyWithImpl<_ExpenseCategory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ExpenseCategoryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExpenseCategory &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            const DeepCollectionEquality()
                .equals(other._suggestedCategories, _suggestedCategories));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, category, confidence,
      const DeepCollectionEquality().hash(_suggestedCategories));

  @override
  String toString() {
    return 'ExpenseCategory(category: $category, confidence: $confidence, suggestedCategories: $suggestedCategories)';
  }
}

/// @nodoc
abstract mixin class _$ExpenseCategoryCopyWith<$Res>
    implements $ExpenseCategoryCopyWith<$Res> {
  factory _$ExpenseCategoryCopyWith(
          _ExpenseCategory value, $Res Function(_ExpenseCategory) _then) =
      __$ExpenseCategoryCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String category,
      double confidence,
      List<CategorySuggestion> suggestedCategories});
}

/// @nodoc
class __$ExpenseCategoryCopyWithImpl<$Res>
    implements _$ExpenseCategoryCopyWith<$Res> {
  __$ExpenseCategoryCopyWithImpl(this._self, this._then);

  final _ExpenseCategory _self;
  final $Res Function(_ExpenseCategory) _then;

  /// Create a copy of ExpenseCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? category = null,
    Object? confidence = null,
    Object? suggestedCategories = null,
  }) {
    return _then(_ExpenseCategory(
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _self.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      suggestedCategories: null == suggestedCategories
          ? _self._suggestedCategories
          : suggestedCategories // ignore: cast_nullable_to_non_nullable
              as List<CategorySuggestion>,
    ));
  }
}

/// @nodoc
mixin _$CategorySuggestion {
  String get category;
  double get confidence;

  /// Create a copy of CategorySuggestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CategorySuggestionCopyWith<CategorySuggestion> get copyWith =>
      _$CategorySuggestionCopyWithImpl<CategorySuggestion>(
          this as CategorySuggestion, _$identity);

  /// Serializes this CategorySuggestion to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CategorySuggestion &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, category, confidence);

  @override
  String toString() {
    return 'CategorySuggestion(category: $category, confidence: $confidence)';
  }
}

/// @nodoc
abstract mixin class $CategorySuggestionCopyWith<$Res> {
  factory $CategorySuggestionCopyWith(
          CategorySuggestion value, $Res Function(CategorySuggestion) _then) =
      _$CategorySuggestionCopyWithImpl;
  @useResult
  $Res call({String category, double confidence});
}

/// @nodoc
class _$CategorySuggestionCopyWithImpl<$Res>
    implements $CategorySuggestionCopyWith<$Res> {
  _$CategorySuggestionCopyWithImpl(this._self, this._then);

  final CategorySuggestion _self;
  final $Res Function(CategorySuggestion) _then;

  /// Create a copy of CategorySuggestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = null,
    Object? confidence = null,
  }) {
    return _then(_self.copyWith(
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _self.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [CategorySuggestion].
extension CategorySuggestionPatterns on CategorySuggestion {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_CategorySuggestion value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CategorySuggestion() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_CategorySuggestion value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CategorySuggestion():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_CategorySuggestion value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CategorySuggestion() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String category, double confidence)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CategorySuggestion() when $default != null:
        return $default(_that.category, _that.confidence);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String category, double confidence) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CategorySuggestion():
        return $default(_that.category, _that.confidence);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String category, double confidence)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CategorySuggestion() when $default != null:
        return $default(_that.category, _that.confidence);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CategorySuggestion implements CategorySuggestion {
  const _CategorySuggestion({required this.category, required this.confidence});
  factory _CategorySuggestion.fromJson(Map<String, dynamic> json) =>
      _$CategorySuggestionFromJson(json);

  @override
  final String category;
  @override
  final double confidence;

  /// Create a copy of CategorySuggestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CategorySuggestionCopyWith<_CategorySuggestion> get copyWith =>
      __$CategorySuggestionCopyWithImpl<_CategorySuggestion>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CategorySuggestionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CategorySuggestion &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, category, confidence);

  @override
  String toString() {
    return 'CategorySuggestion(category: $category, confidence: $confidence)';
  }
}

/// @nodoc
abstract mixin class _$CategorySuggestionCopyWith<$Res>
    implements $CategorySuggestionCopyWith<$Res> {
  factory _$CategorySuggestionCopyWith(
          _CategorySuggestion value, $Res Function(_CategorySuggestion) _then) =
      __$CategorySuggestionCopyWithImpl;
  @override
  @useResult
  $Res call({String category, double confidence});
}

/// @nodoc
class __$CategorySuggestionCopyWithImpl<$Res>
    implements _$CategorySuggestionCopyWith<$Res> {
  __$CategorySuggestionCopyWithImpl(this._self, this._then);

  final _CategorySuggestion _self;
  final $Res Function(_CategorySuggestion) _then;

  /// Create a copy of CategorySuggestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? category = null,
    Object? confidence = null,
  }) {
    return _then(_CategorySuggestion(
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _self.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
mixin _$PolicyValidation {
  bool get isCompliant;
  bool get requiresApproval;
  List<PolicyViolation> get violations;
  List<PolicyViolation> get warnings;
  PolicyRule get policyRule;

  /// Create a copy of PolicyValidation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PolicyValidationCopyWith<PolicyValidation> get copyWith =>
      _$PolicyValidationCopyWithImpl<PolicyValidation>(
          this as PolicyValidation, _$identity);

  /// Serializes this PolicyValidation to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PolicyValidation &&
            (identical(other.isCompliant, isCompliant) ||
                other.isCompliant == isCompliant) &&
            (identical(other.requiresApproval, requiresApproval) ||
                other.requiresApproval == requiresApproval) &&
            const DeepCollectionEquality()
                .equals(other.violations, violations) &&
            const DeepCollectionEquality().equals(other.warnings, warnings) &&
            (identical(other.policyRule, policyRule) ||
                other.policyRule == policyRule));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      isCompliant,
      requiresApproval,
      const DeepCollectionEquality().hash(violations),
      const DeepCollectionEquality().hash(warnings),
      policyRule);

  @override
  String toString() {
    return 'PolicyValidation(isCompliant: $isCompliant, requiresApproval: $requiresApproval, violations: $violations, warnings: $warnings, policyRule: $policyRule)';
  }
}

/// @nodoc
abstract mixin class $PolicyValidationCopyWith<$Res> {
  factory $PolicyValidationCopyWith(
          PolicyValidation value, $Res Function(PolicyValidation) _then) =
      _$PolicyValidationCopyWithImpl;
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
class _$PolicyValidationCopyWithImpl<$Res>
    implements $PolicyValidationCopyWith<$Res> {
  _$PolicyValidationCopyWithImpl(this._self, this._then);

  final PolicyValidation _self;
  final $Res Function(PolicyValidation) _then;

  /// Create a copy of PolicyValidation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isCompliant = null,
    Object? requiresApproval = null,
    Object? violations = null,
    Object? warnings = null,
    Object? policyRule = null,
  }) {
    return _then(_self.copyWith(
      isCompliant: null == isCompliant
          ? _self.isCompliant
          : isCompliant // ignore: cast_nullable_to_non_nullable
              as bool,
      requiresApproval: null == requiresApproval
          ? _self.requiresApproval
          : requiresApproval // ignore: cast_nullable_to_non_nullable
              as bool,
      violations: null == violations
          ? _self.violations
          : violations // ignore: cast_nullable_to_non_nullable
              as List<PolicyViolation>,
      warnings: null == warnings
          ? _self.warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<PolicyViolation>,
      policyRule: null == policyRule
          ? _self.policyRule
          : policyRule // ignore: cast_nullable_to_non_nullable
              as PolicyRule,
    ));
  }

  /// Create a copy of PolicyValidation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PolicyRuleCopyWith<$Res> get policyRule {
    return $PolicyRuleCopyWith<$Res>(_self.policyRule, (value) {
      return _then(_self.copyWith(policyRule: value));
    });
  }
}

/// Adds pattern-matching-related methods to [PolicyValidation].
extension PolicyValidationPatterns on PolicyValidation {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_PolicyValidation value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PolicyValidation() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_PolicyValidation value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PolicyValidation():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_PolicyValidation value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PolicyValidation() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            bool isCompliant,
            bool requiresApproval,
            List<PolicyViolation> violations,
            List<PolicyViolation> warnings,
            PolicyRule policyRule)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PolicyValidation() when $default != null:
        return $default(_that.isCompliant, _that.requiresApproval,
            _that.violations, _that.warnings, _that.policyRule);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            bool isCompliant,
            bool requiresApproval,
            List<PolicyViolation> violations,
            List<PolicyViolation> warnings,
            PolicyRule policyRule)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PolicyValidation():
        return $default(_that.isCompliant, _that.requiresApproval,
            _that.violations, _that.warnings, _that.policyRule);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            bool isCompliant,
            bool requiresApproval,
            List<PolicyViolation> violations,
            List<PolicyViolation> warnings,
            PolicyRule policyRule)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PolicyValidation() when $default != null:
        return $default(_that.isCompliant, _that.requiresApproval,
            _that.violations, _that.warnings, _that.policyRule);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PolicyValidation implements PolicyValidation {
  const _PolicyValidation(
      {required this.isCompliant,
      required this.requiresApproval,
      required final List<PolicyViolation> violations,
      required final List<PolicyViolation> warnings,
      required this.policyRule})
      : _violations = violations,
        _warnings = warnings;
  factory _PolicyValidation.fromJson(Map<String, dynamic> json) =>
      _$PolicyValidationFromJson(json);

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

  /// Create a copy of PolicyValidation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PolicyValidationCopyWith<_PolicyValidation> get copyWith =>
      __$PolicyValidationCopyWithImpl<_PolicyValidation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PolicyValidationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PolicyValidation &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      isCompliant,
      requiresApproval,
      const DeepCollectionEquality().hash(_violations),
      const DeepCollectionEquality().hash(_warnings),
      policyRule);

  @override
  String toString() {
    return 'PolicyValidation(isCompliant: $isCompliant, requiresApproval: $requiresApproval, violations: $violations, warnings: $warnings, policyRule: $policyRule)';
  }
}

/// @nodoc
abstract mixin class _$PolicyValidationCopyWith<$Res>
    implements $PolicyValidationCopyWith<$Res> {
  factory _$PolicyValidationCopyWith(
          _PolicyValidation value, $Res Function(_PolicyValidation) _then) =
      __$PolicyValidationCopyWithImpl;
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
class __$PolicyValidationCopyWithImpl<$Res>
    implements _$PolicyValidationCopyWith<$Res> {
  __$PolicyValidationCopyWithImpl(this._self, this._then);

  final _PolicyValidation _self;
  final $Res Function(_PolicyValidation) _then;

  /// Create a copy of PolicyValidation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isCompliant = null,
    Object? requiresApproval = null,
    Object? violations = null,
    Object? warnings = null,
    Object? policyRule = null,
  }) {
    return _then(_PolicyValidation(
      isCompliant: null == isCompliant
          ? _self.isCompliant
          : isCompliant // ignore: cast_nullable_to_non_nullable
              as bool,
      requiresApproval: null == requiresApproval
          ? _self.requiresApproval
          : requiresApproval // ignore: cast_nullable_to_non_nullable
              as bool,
      violations: null == violations
          ? _self._violations
          : violations // ignore: cast_nullable_to_non_nullable
              as List<PolicyViolation>,
      warnings: null == warnings
          ? _self._warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<PolicyViolation>,
      policyRule: null == policyRule
          ? _self.policyRule
          : policyRule // ignore: cast_nullable_to_non_nullable
              as PolicyRule,
    ));
  }

  /// Create a copy of PolicyValidation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PolicyRuleCopyWith<$Res> get policyRule {
    return $PolicyRuleCopyWith<$Res>(_self.policyRule, (value) {
      return _then(_self.copyWith(policyRule: value));
    });
  }
}

/// @nodoc
mixin _$PolicyViolation {
  String get type;
  String get message;
  String get severity;

  /// Create a copy of PolicyViolation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PolicyViolationCopyWith<PolicyViolation> get copyWith =>
      _$PolicyViolationCopyWithImpl<PolicyViolation>(
          this as PolicyViolation, _$identity);

  /// Serializes this PolicyViolation to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PolicyViolation &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.severity, severity) ||
                other.severity == severity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, message, severity);

  @override
  String toString() {
    return 'PolicyViolation(type: $type, message: $message, severity: $severity)';
  }
}

/// @nodoc
abstract mixin class $PolicyViolationCopyWith<$Res> {
  factory $PolicyViolationCopyWith(
          PolicyViolation value, $Res Function(PolicyViolation) _then) =
      _$PolicyViolationCopyWithImpl;
  @useResult
  $Res call({String type, String message, String severity});
}

/// @nodoc
class _$PolicyViolationCopyWithImpl<$Res>
    implements $PolicyViolationCopyWith<$Res> {
  _$PolicyViolationCopyWithImpl(this._self, this._then);

  final PolicyViolation _self;
  final $Res Function(PolicyViolation) _then;

  /// Create a copy of PolicyViolation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? message = null,
    Object? severity = null,
  }) {
    return _then(_self.copyWith(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _self.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [PolicyViolation].
extension PolicyViolationPatterns on PolicyViolation {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_PolicyViolation value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PolicyViolation() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_PolicyViolation value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PolicyViolation():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_PolicyViolation value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PolicyViolation() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String type, String message, String severity)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PolicyViolation() when $default != null:
        return $default(_that.type, _that.message, _that.severity);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String type, String message, String severity) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PolicyViolation():
        return $default(_that.type, _that.message, _that.severity);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String type, String message, String severity)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PolicyViolation() when $default != null:
        return $default(_that.type, _that.message, _that.severity);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PolicyViolation implements PolicyViolation {
  const _PolicyViolation(
      {required this.type, required this.message, required this.severity});
  factory _PolicyViolation.fromJson(Map<String, dynamic> json) =>
      _$PolicyViolationFromJson(json);

  @override
  final String type;
  @override
  final String message;
  @override
  final String severity;

  /// Create a copy of PolicyViolation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PolicyViolationCopyWith<_PolicyViolation> get copyWith =>
      __$PolicyViolationCopyWithImpl<_PolicyViolation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PolicyViolationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PolicyViolation &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.severity, severity) ||
                other.severity == severity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, message, severity);

  @override
  String toString() {
    return 'PolicyViolation(type: $type, message: $message, severity: $severity)';
  }
}

/// @nodoc
abstract mixin class _$PolicyViolationCopyWith<$Res>
    implements $PolicyViolationCopyWith<$Res> {
  factory _$PolicyViolationCopyWith(
          _PolicyViolation value, $Res Function(_PolicyViolation) _then) =
      __$PolicyViolationCopyWithImpl;
  @override
  @useResult
  $Res call({String type, String message, String severity});
}

/// @nodoc
class __$PolicyViolationCopyWithImpl<$Res>
    implements _$PolicyViolationCopyWith<$Res> {
  __$PolicyViolationCopyWithImpl(this._self, this._then);

  final _PolicyViolation _self;
  final $Res Function(_PolicyViolation) _then;

  /// Create a copy of PolicyViolation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? type = null,
    Object? message = null,
    Object? severity = null,
  }) {
    return _then(_PolicyViolation(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _self.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$PolicyRule {
  double get maxAmount;
  bool get requiresReceipt;

  /// Create a copy of PolicyRule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PolicyRuleCopyWith<PolicyRule> get copyWith =>
      _$PolicyRuleCopyWithImpl<PolicyRule>(this as PolicyRule, _$identity);

  /// Serializes this PolicyRule to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PolicyRule &&
            (identical(other.maxAmount, maxAmount) ||
                other.maxAmount == maxAmount) &&
            (identical(other.requiresReceipt, requiresReceipt) ||
                other.requiresReceipt == requiresReceipt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, maxAmount, requiresReceipt);

  @override
  String toString() {
    return 'PolicyRule(maxAmount: $maxAmount, requiresReceipt: $requiresReceipt)';
  }
}

/// @nodoc
abstract mixin class $PolicyRuleCopyWith<$Res> {
  factory $PolicyRuleCopyWith(
          PolicyRule value, $Res Function(PolicyRule) _then) =
      _$PolicyRuleCopyWithImpl;
  @useResult
  $Res call({double maxAmount, bool requiresReceipt});
}

/// @nodoc
class _$PolicyRuleCopyWithImpl<$Res> implements $PolicyRuleCopyWith<$Res> {
  _$PolicyRuleCopyWithImpl(this._self, this._then);

  final PolicyRule _self;
  final $Res Function(PolicyRule) _then;

  /// Create a copy of PolicyRule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxAmount = null,
    Object? requiresReceipt = null,
  }) {
    return _then(_self.copyWith(
      maxAmount: null == maxAmount
          ? _self.maxAmount
          : maxAmount // ignore: cast_nullable_to_non_nullable
              as double,
      requiresReceipt: null == requiresReceipt
          ? _self.requiresReceipt
          : requiresReceipt // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [PolicyRule].
extension PolicyRulePatterns on PolicyRule {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_PolicyRule value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PolicyRule() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_PolicyRule value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PolicyRule():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_PolicyRule value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PolicyRule() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(double maxAmount, bool requiresReceipt)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PolicyRule() when $default != null:
        return $default(_that.maxAmount, _that.requiresReceipt);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(double maxAmount, bool requiresReceipt) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PolicyRule():
        return $default(_that.maxAmount, _that.requiresReceipt);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(double maxAmount, bool requiresReceipt)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PolicyRule() when $default != null:
        return $default(_that.maxAmount, _that.requiresReceipt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PolicyRule implements PolicyRule {
  const _PolicyRule({required this.maxAmount, required this.requiresReceipt});
  factory _PolicyRule.fromJson(Map<String, dynamic> json) =>
      _$PolicyRuleFromJson(json);

  @override
  final double maxAmount;
  @override
  final bool requiresReceipt;

  /// Create a copy of PolicyRule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PolicyRuleCopyWith<_PolicyRule> get copyWith =>
      __$PolicyRuleCopyWithImpl<_PolicyRule>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PolicyRuleToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PolicyRule &&
            (identical(other.maxAmount, maxAmount) ||
                other.maxAmount == maxAmount) &&
            (identical(other.requiresReceipt, requiresReceipt) ||
                other.requiresReceipt == requiresReceipt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, maxAmount, requiresReceipt);

  @override
  String toString() {
    return 'PolicyRule(maxAmount: $maxAmount, requiresReceipt: $requiresReceipt)';
  }
}

/// @nodoc
abstract mixin class _$PolicyRuleCopyWith<$Res>
    implements $PolicyRuleCopyWith<$Res> {
  factory _$PolicyRuleCopyWith(
          _PolicyRule value, $Res Function(_PolicyRule) _then) =
      __$PolicyRuleCopyWithImpl;
  @override
  @useResult
  $Res call({double maxAmount, bool requiresReceipt});
}

/// @nodoc
class __$PolicyRuleCopyWithImpl<$Res> implements _$PolicyRuleCopyWith<$Res> {
  __$PolicyRuleCopyWithImpl(this._self, this._then);

  final _PolicyRule _self;
  final $Res Function(_PolicyRule) _then;

  /// Create a copy of PolicyRule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? maxAmount = null,
    Object? requiresReceipt = null,
  }) {
    return _then(_PolicyRule(
      maxAmount: null == maxAmount
          ? _self.maxAmount
          : maxAmount // ignore: cast_nullable_to_non_nullable
              as double,
      requiresReceipt: null == requiresReceipt
          ? _self.requiresReceipt
          : requiresReceipt // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$DuplicateCheck {
  bool get isDuplicate;
  double get confidence;
  MatchedExpense? get matchedExpense;

  /// Create a copy of DuplicateCheck
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DuplicateCheckCopyWith<DuplicateCheck> get copyWith =>
      _$DuplicateCheckCopyWithImpl<DuplicateCheck>(
          this as DuplicateCheck, _$identity);

  /// Serializes this DuplicateCheck to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DuplicateCheck &&
            (identical(other.isDuplicate, isDuplicate) ||
                other.isDuplicate == isDuplicate) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.matchedExpense, matchedExpense) ||
                other.matchedExpense == matchedExpense));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, isDuplicate, confidence, matchedExpense);

  @override
  String toString() {
    return 'DuplicateCheck(isDuplicate: $isDuplicate, confidence: $confidence, matchedExpense: $matchedExpense)';
  }
}

/// @nodoc
abstract mixin class $DuplicateCheckCopyWith<$Res> {
  factory $DuplicateCheckCopyWith(
          DuplicateCheck value, $Res Function(DuplicateCheck) _then) =
      _$DuplicateCheckCopyWithImpl;
  @useResult
  $Res call(
      {bool isDuplicate, double confidence, MatchedExpense? matchedExpense});

  $MatchedExpenseCopyWith<$Res>? get matchedExpense;
}

/// @nodoc
class _$DuplicateCheckCopyWithImpl<$Res>
    implements $DuplicateCheckCopyWith<$Res> {
  _$DuplicateCheckCopyWithImpl(this._self, this._then);

  final DuplicateCheck _self;
  final $Res Function(DuplicateCheck) _then;

  /// Create a copy of DuplicateCheck
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isDuplicate = null,
    Object? confidence = null,
    Object? matchedExpense = freezed,
  }) {
    return _then(_self.copyWith(
      isDuplicate: null == isDuplicate
          ? _self.isDuplicate
          : isDuplicate // ignore: cast_nullable_to_non_nullable
              as bool,
      confidence: null == confidence
          ? _self.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      matchedExpense: freezed == matchedExpense
          ? _self.matchedExpense
          : matchedExpense // ignore: cast_nullable_to_non_nullable
              as MatchedExpense?,
    ));
  }

  /// Create a copy of DuplicateCheck
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MatchedExpenseCopyWith<$Res>? get matchedExpense {
    if (_self.matchedExpense == null) {
      return null;
    }

    return $MatchedExpenseCopyWith<$Res>(_self.matchedExpense!, (value) {
      return _then(_self.copyWith(matchedExpense: value));
    });
  }
}

/// Adds pattern-matching-related methods to [DuplicateCheck].
extension DuplicateCheckPatterns on DuplicateCheck {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_DuplicateCheck value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DuplicateCheck() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_DuplicateCheck value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DuplicateCheck():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_DuplicateCheck value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DuplicateCheck() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(bool isDuplicate, double confidence,
            MatchedExpense? matchedExpense)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DuplicateCheck() when $default != null:
        return $default(
            _that.isDuplicate, _that.confidence, _that.matchedExpense);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            bool isDuplicate, double confidence, MatchedExpense? matchedExpense)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DuplicateCheck():
        return $default(
            _that.isDuplicate, _that.confidence, _that.matchedExpense);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(bool isDuplicate, double confidence,
            MatchedExpense? matchedExpense)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DuplicateCheck() when $default != null:
        return $default(
            _that.isDuplicate, _that.confidence, _that.matchedExpense);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _DuplicateCheck implements DuplicateCheck {
  const _DuplicateCheck(
      {required this.isDuplicate,
      required this.confidence,
      this.matchedExpense});
  factory _DuplicateCheck.fromJson(Map<String, dynamic> json) =>
      _$DuplicateCheckFromJson(json);

  @override
  final bool isDuplicate;
  @override
  final double confidence;
  @override
  final MatchedExpense? matchedExpense;

  /// Create a copy of DuplicateCheck
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DuplicateCheckCopyWith<_DuplicateCheck> get copyWith =>
      __$DuplicateCheckCopyWithImpl<_DuplicateCheck>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DuplicateCheckToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DuplicateCheck &&
            (identical(other.isDuplicate, isDuplicate) ||
                other.isDuplicate == isDuplicate) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.matchedExpense, matchedExpense) ||
                other.matchedExpense == matchedExpense));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, isDuplicate, confidence, matchedExpense);

  @override
  String toString() {
    return 'DuplicateCheck(isDuplicate: $isDuplicate, confidence: $confidence, matchedExpense: $matchedExpense)';
  }
}

/// @nodoc
abstract mixin class _$DuplicateCheckCopyWith<$Res>
    implements $DuplicateCheckCopyWith<$Res> {
  factory _$DuplicateCheckCopyWith(
          _DuplicateCheck value, $Res Function(_DuplicateCheck) _then) =
      __$DuplicateCheckCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isDuplicate, double confidence, MatchedExpense? matchedExpense});

  @override
  $MatchedExpenseCopyWith<$Res>? get matchedExpense;
}

/// @nodoc
class __$DuplicateCheckCopyWithImpl<$Res>
    implements _$DuplicateCheckCopyWith<$Res> {
  __$DuplicateCheckCopyWithImpl(this._self, this._then);

  final _DuplicateCheck _self;
  final $Res Function(_DuplicateCheck) _then;

  /// Create a copy of DuplicateCheck
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isDuplicate = null,
    Object? confidence = null,
    Object? matchedExpense = freezed,
  }) {
    return _then(_DuplicateCheck(
      isDuplicate: null == isDuplicate
          ? _self.isDuplicate
          : isDuplicate // ignore: cast_nullable_to_non_nullable
              as bool,
      confidence: null == confidence
          ? _self.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      matchedExpense: freezed == matchedExpense
          ? _self.matchedExpense
          : matchedExpense // ignore: cast_nullable_to_non_nullable
              as MatchedExpense?,
    ));
  }

  /// Create a copy of DuplicateCheck
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MatchedExpenseCopyWith<$Res>? get matchedExpense {
    if (_self.matchedExpense == null) {
      return null;
    }

    return $MatchedExpenseCopyWith<$Res>(_self.matchedExpense!, (value) {
      return _then(_self.copyWith(matchedExpense: value));
    });
  }
}

/// @nodoc
mixin _$MatchedExpense {
  String get expenseId;
  String get date;
  double get amount;
  String get merchant;

  /// Create a copy of MatchedExpense
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MatchedExpenseCopyWith<MatchedExpense> get copyWith =>
      _$MatchedExpenseCopyWithImpl<MatchedExpense>(
          this as MatchedExpense, _$identity);

  /// Serializes this MatchedExpense to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MatchedExpense &&
            (identical(other.expenseId, expenseId) ||
                other.expenseId == expenseId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.merchant, merchant) ||
                other.merchant == merchant));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, expenseId, date, amount, merchant);

  @override
  String toString() {
    return 'MatchedExpense(expenseId: $expenseId, date: $date, amount: $amount, merchant: $merchant)';
  }
}

/// @nodoc
abstract mixin class $MatchedExpenseCopyWith<$Res> {
  factory $MatchedExpenseCopyWith(
          MatchedExpense value, $Res Function(MatchedExpense) _then) =
      _$MatchedExpenseCopyWithImpl;
  @useResult
  $Res call({String expenseId, String date, double amount, String merchant});
}

/// @nodoc
class _$MatchedExpenseCopyWithImpl<$Res>
    implements $MatchedExpenseCopyWith<$Res> {
  _$MatchedExpenseCopyWithImpl(this._self, this._then);

  final MatchedExpense _self;
  final $Res Function(MatchedExpense) _then;

  /// Create a copy of MatchedExpense
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expenseId = null,
    Object? date = null,
    Object? amount = null,
    Object? merchant = null,
  }) {
    return _then(_self.copyWith(
      expenseId: null == expenseId
          ? _self.expenseId
          : expenseId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      merchant: null == merchant
          ? _self.merchant
          : merchant // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [MatchedExpense].
extension MatchedExpensePatterns on MatchedExpense {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_MatchedExpense value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MatchedExpense() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_MatchedExpense value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MatchedExpense():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_MatchedExpense value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MatchedExpense() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String expenseId, String date, double amount, String merchant)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MatchedExpense() when $default != null:
        return $default(
            _that.expenseId, _that.date, _that.amount, _that.merchant);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String expenseId, String date, double amount, String merchant)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MatchedExpense():
        return $default(
            _that.expenseId, _that.date, _that.amount, _that.merchant);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String expenseId, String date, double amount, String merchant)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MatchedExpense() when $default != null:
        return $default(
            _that.expenseId, _that.date, _that.amount, _that.merchant);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MatchedExpense implements MatchedExpense {
  const _MatchedExpense(
      {required this.expenseId,
      required this.date,
      required this.amount,
      required this.merchant});
  factory _MatchedExpense.fromJson(Map<String, dynamic> json) =>
      _$MatchedExpenseFromJson(json);

  @override
  final String expenseId;
  @override
  final String date;
  @override
  final double amount;
  @override
  final String merchant;

  /// Create a copy of MatchedExpense
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MatchedExpenseCopyWith<_MatchedExpense> get copyWith =>
      __$MatchedExpenseCopyWithImpl<_MatchedExpense>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MatchedExpenseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MatchedExpense &&
            (identical(other.expenseId, expenseId) ||
                other.expenseId == expenseId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.merchant, merchant) ||
                other.merchant == merchant));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, expenseId, date, amount, merchant);

  @override
  String toString() {
    return 'MatchedExpense(expenseId: $expenseId, date: $date, amount: $amount, merchant: $merchant)';
  }
}

/// @nodoc
abstract mixin class _$MatchedExpenseCopyWith<$Res>
    implements $MatchedExpenseCopyWith<$Res> {
  factory _$MatchedExpenseCopyWith(
          _MatchedExpense value, $Res Function(_MatchedExpense) _then) =
      __$MatchedExpenseCopyWithImpl;
  @override
  @useResult
  $Res call({String expenseId, String date, double amount, String merchant});
}

/// @nodoc
class __$MatchedExpenseCopyWithImpl<$Res>
    implements _$MatchedExpenseCopyWith<$Res> {
  __$MatchedExpenseCopyWithImpl(this._self, this._then);

  final _MatchedExpense _self;
  final $Res Function(_MatchedExpense) _then;

  /// Create a copy of MatchedExpense
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? expenseId = null,
    Object? date = null,
    Object? amount = null,
    Object? merchant = null,
  }) {
    return _then(_MatchedExpense(
      expenseId: null == expenseId
          ? _self.expenseId
          : expenseId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      merchant: null == merchant
          ? _self.merchant
          : merchant // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$MileageCalculation {
  double get totalDistance;
  String get unit;
  double get ratePerKm;
  double get reimbursement;
  String get currency;
  LocationPoint get startLocation;
  LocationPoint get endLocation;
  int get waypoints;

  /// Create a copy of MileageCalculation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MileageCalculationCopyWith<MileageCalculation> get copyWith =>
      _$MileageCalculationCopyWithImpl<MileageCalculation>(
          this as MileageCalculation, _$identity);

  /// Serializes this MileageCalculation to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MileageCalculation &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, totalDistance, unit, ratePerKm,
      reimbursement, currency, startLocation, endLocation, waypoints);

  @override
  String toString() {
    return 'MileageCalculation(totalDistance: $totalDistance, unit: $unit, ratePerKm: $ratePerKm, reimbursement: $reimbursement, currency: $currency, startLocation: $startLocation, endLocation: $endLocation, waypoints: $waypoints)';
  }
}

/// @nodoc
abstract mixin class $MileageCalculationCopyWith<$Res> {
  factory $MileageCalculationCopyWith(
          MileageCalculation value, $Res Function(MileageCalculation) _then) =
      _$MileageCalculationCopyWithImpl;
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
class _$MileageCalculationCopyWithImpl<$Res>
    implements $MileageCalculationCopyWith<$Res> {
  _$MileageCalculationCopyWithImpl(this._self, this._then);

  final MileageCalculation _self;
  final $Res Function(MileageCalculation) _then;

  /// Create a copy of MileageCalculation
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(_self.copyWith(
      totalDistance: null == totalDistance
          ? _self.totalDistance
          : totalDistance // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _self.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      ratePerKm: null == ratePerKm
          ? _self.ratePerKm
          : ratePerKm // ignore: cast_nullable_to_non_nullable
              as double,
      reimbursement: null == reimbursement
          ? _self.reimbursement
          : reimbursement // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _self.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      startLocation: null == startLocation
          ? _self.startLocation
          : startLocation // ignore: cast_nullable_to_non_nullable
              as LocationPoint,
      endLocation: null == endLocation
          ? _self.endLocation
          : endLocation // ignore: cast_nullable_to_non_nullable
              as LocationPoint,
      waypoints: null == waypoints
          ? _self.waypoints
          : waypoints // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of MileageCalculation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationPointCopyWith<$Res> get startLocation {
    return $LocationPointCopyWith<$Res>(_self.startLocation, (value) {
      return _then(_self.copyWith(startLocation: value));
    });
  }

  /// Create a copy of MileageCalculation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationPointCopyWith<$Res> get endLocation {
    return $LocationPointCopyWith<$Res>(_self.endLocation, (value) {
      return _then(_self.copyWith(endLocation: value));
    });
  }
}

/// Adds pattern-matching-related methods to [MileageCalculation].
extension MileageCalculationPatterns on MileageCalculation {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_MileageCalculation value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MileageCalculation() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_MileageCalculation value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MileageCalculation():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_MileageCalculation value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MileageCalculation() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            double totalDistance,
            String unit,
            double ratePerKm,
            double reimbursement,
            String currency,
            LocationPoint startLocation,
            LocationPoint endLocation,
            int waypoints)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MileageCalculation() when $default != null:
        return $default(
            _that.totalDistance,
            _that.unit,
            _that.ratePerKm,
            _that.reimbursement,
            _that.currency,
            _that.startLocation,
            _that.endLocation,
            _that.waypoints);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            double totalDistance,
            String unit,
            double ratePerKm,
            double reimbursement,
            String currency,
            LocationPoint startLocation,
            LocationPoint endLocation,
            int waypoints)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MileageCalculation():
        return $default(
            _that.totalDistance,
            _that.unit,
            _that.ratePerKm,
            _that.reimbursement,
            _that.currency,
            _that.startLocation,
            _that.endLocation,
            _that.waypoints);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            double totalDistance,
            String unit,
            double ratePerKm,
            double reimbursement,
            String currency,
            LocationPoint startLocation,
            LocationPoint endLocation,
            int waypoints)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MileageCalculation() when $default != null:
        return $default(
            _that.totalDistance,
            _that.unit,
            _that.ratePerKm,
            _that.reimbursement,
            _that.currency,
            _that.startLocation,
            _that.endLocation,
            _that.waypoints);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MileageCalculation implements MileageCalculation {
  const _MileageCalculation(
      {required this.totalDistance,
      required this.unit,
      required this.ratePerKm,
      required this.reimbursement,
      required this.currency,
      required this.startLocation,
      required this.endLocation,
      required this.waypoints});
  factory _MileageCalculation.fromJson(Map<String, dynamic> json) =>
      _$MileageCalculationFromJson(json);

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

  /// Create a copy of MileageCalculation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MileageCalculationCopyWith<_MileageCalculation> get copyWith =>
      __$MileageCalculationCopyWithImpl<_MileageCalculation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MileageCalculationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MileageCalculation &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, totalDistance, unit, ratePerKm,
      reimbursement, currency, startLocation, endLocation, waypoints);

  @override
  String toString() {
    return 'MileageCalculation(totalDistance: $totalDistance, unit: $unit, ratePerKm: $ratePerKm, reimbursement: $reimbursement, currency: $currency, startLocation: $startLocation, endLocation: $endLocation, waypoints: $waypoints)';
  }
}

/// @nodoc
abstract mixin class _$MileageCalculationCopyWith<$Res>
    implements $MileageCalculationCopyWith<$Res> {
  factory _$MileageCalculationCopyWith(
          _MileageCalculation value, $Res Function(_MileageCalculation) _then) =
      __$MileageCalculationCopyWithImpl;
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
class __$MileageCalculationCopyWithImpl<$Res>
    implements _$MileageCalculationCopyWith<$Res> {
  __$MileageCalculationCopyWithImpl(this._self, this._then);

  final _MileageCalculation _self;
  final $Res Function(_MileageCalculation) _then;

  /// Create a copy of MileageCalculation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_MileageCalculation(
      totalDistance: null == totalDistance
          ? _self.totalDistance
          : totalDistance // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _self.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      ratePerKm: null == ratePerKm
          ? _self.ratePerKm
          : ratePerKm // ignore: cast_nullable_to_non_nullable
              as double,
      reimbursement: null == reimbursement
          ? _self.reimbursement
          : reimbursement // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _self.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      startLocation: null == startLocation
          ? _self.startLocation
          : startLocation // ignore: cast_nullable_to_non_nullable
              as LocationPoint,
      endLocation: null == endLocation
          ? _self.endLocation
          : endLocation // ignore: cast_nullable_to_non_nullable
              as LocationPoint,
      waypoints: null == waypoints
          ? _self.waypoints
          : waypoints // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of MileageCalculation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationPointCopyWith<$Res> get startLocation {
    return $LocationPointCopyWith<$Res>(_self.startLocation, (value) {
      return _then(_self.copyWith(startLocation: value));
    });
  }

  /// Create a copy of MileageCalculation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationPointCopyWith<$Res> get endLocation {
    return $LocationPointCopyWith<$Res>(_self.endLocation, (value) {
      return _then(_self.copyWith(endLocation: value));
    });
  }
}

/// @nodoc
mixin _$LocationPoint {
  double get lat;
  double get lng;
  String? get timestamp;

  /// Create a copy of LocationPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LocationPointCopyWith<LocationPoint> get copyWith =>
      _$LocationPointCopyWithImpl<LocationPoint>(
          this as LocationPoint, _$identity);

  /// Serializes this LocationPoint to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LocationPoint &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, lat, lng, timestamp);

  @override
  String toString() {
    return 'LocationPoint(lat: $lat, lng: $lng, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class $LocationPointCopyWith<$Res> {
  factory $LocationPointCopyWith(
          LocationPoint value, $Res Function(LocationPoint) _then) =
      _$LocationPointCopyWithImpl;
  @useResult
  $Res call({double lat, double lng, String? timestamp});
}

/// @nodoc
class _$LocationPointCopyWithImpl<$Res>
    implements $LocationPointCopyWith<$Res> {
  _$LocationPointCopyWithImpl(this._self, this._then);

  final LocationPoint _self;
  final $Res Function(LocationPoint) _then;

  /// Create a copy of LocationPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lat = null,
    Object? lng = null,
    Object? timestamp = freezed,
  }) {
    return _then(_self.copyWith(
      lat: null == lat
          ? _self.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _self.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      timestamp: freezed == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [LocationPoint].
extension LocationPointPatterns on LocationPoint {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_LocationPoint value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LocationPoint() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_LocationPoint value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LocationPoint():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_LocationPoint value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LocationPoint() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(double lat, double lng, String? timestamp)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LocationPoint() when $default != null:
        return $default(_that.lat, _that.lng, _that.timestamp);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(double lat, double lng, String? timestamp) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LocationPoint():
        return $default(_that.lat, _that.lng, _that.timestamp);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(double lat, double lng, String? timestamp)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LocationPoint() when $default != null:
        return $default(_that.lat, _that.lng, _that.timestamp);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LocationPoint implements LocationPoint {
  const _LocationPoint({required this.lat, required this.lng, this.timestamp});
  factory _LocationPoint.fromJson(Map<String, dynamic> json) =>
      _$LocationPointFromJson(json);

  @override
  final double lat;
  @override
  final double lng;
  @override
  final String? timestamp;

  /// Create a copy of LocationPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LocationPointCopyWith<_LocationPoint> get copyWith =>
      __$LocationPointCopyWithImpl<_LocationPoint>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LocationPointToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LocationPoint &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, lat, lng, timestamp);

  @override
  String toString() {
    return 'LocationPoint(lat: $lat, lng: $lng, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class _$LocationPointCopyWith<$Res>
    implements $LocationPointCopyWith<$Res> {
  factory _$LocationPointCopyWith(
          _LocationPoint value, $Res Function(_LocationPoint) _then) =
      __$LocationPointCopyWithImpl;
  @override
  @useResult
  $Res call({double lat, double lng, String? timestamp});
}

/// @nodoc
class __$LocationPointCopyWithImpl<$Res>
    implements _$LocationPointCopyWith<$Res> {
  __$LocationPointCopyWithImpl(this._self, this._then);

  final _LocationPoint _self;
  final $Res Function(_LocationPoint) _then;

  /// Create a copy of LocationPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? lat = null,
    Object? lng = null,
    Object? timestamp = freezed,
  }) {
    return _then(_LocationPoint(
      lat: null == lat
          ? _self.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _self.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      timestamp: freezed == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
