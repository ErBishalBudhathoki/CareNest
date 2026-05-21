// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'organization_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Address {
  String? get street;
  String? get city;
  String? get state;
  String? get postcode;
  String? get country;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AddressCopyWith<Address> get copyWith =>
      _$AddressCopyWithImpl<Address>(this as Address, _$identity);

  /// Serializes this Address to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Address &&
            (identical(other.street, street) || other.street == street) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.postcode, postcode) ||
                other.postcode == postcode) &&
            (identical(other.country, country) || other.country == country));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, street, city, state, postcode, country);

  @override
  String toString() {
    return 'Address(street: $street, city: $city, state: $state, postcode: $postcode, country: $country)';
  }
}

/// @nodoc
abstract mixin class $AddressCopyWith<$Res> {
  factory $AddressCopyWith(Address value, $Res Function(Address) _then) =
      _$AddressCopyWithImpl;
  @useResult
  $Res call(
      {String? street,
      String? city,
      String? state,
      String? postcode,
      String? country});
}

/// @nodoc
class _$AddressCopyWithImpl<$Res> implements $AddressCopyWith<$Res> {
  _$AddressCopyWithImpl(this._self, this._then);

  final Address _self;
  final $Res Function(Address) _then;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? street = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? postcode = freezed,
    Object? country = freezed,
  }) {
    return _then(_self.copyWith(
      street: freezed == street
          ? _self.street
          : street // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _self.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _self.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      postcode: freezed == postcode
          ? _self.postcode
          : postcode // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _self.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Address].
extension AddressPatterns on Address {
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
    TResult Function(_Address value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Address() when $default != null:
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
    TResult Function(_Address value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Address():
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
    TResult? Function(_Address value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Address() when $default != null:
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
    TResult Function(String? street, String? city, String? state,
            String? postcode, String? country)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Address() when $default != null:
        return $default(_that.street, _that.city, _that.state, _that.postcode,
            _that.country);
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
    TResult Function(String? street, String? city, String? state,
            String? postcode, String? country)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Address():
        return $default(_that.street, _that.city, _that.state, _that.postcode,
            _that.country);
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
    TResult? Function(String? street, String? city, String? state,
            String? postcode, String? country)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Address() when $default != null:
        return $default(_that.street, _that.city, _that.state, _that.postcode,
            _that.country);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Address implements Address {
  const _Address(
      {this.street, this.city, this.state, this.postcode, this.country});
  factory _Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  @override
  final String? street;
  @override
  final String? city;
  @override
  final String? state;
  @override
  final String? postcode;
  @override
  final String? country;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AddressCopyWith<_Address> get copyWith =>
      __$AddressCopyWithImpl<_Address>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AddressToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Address &&
            (identical(other.street, street) || other.street == street) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.postcode, postcode) ||
                other.postcode == postcode) &&
            (identical(other.country, country) || other.country == country));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, street, city, state, postcode, country);

  @override
  String toString() {
    return 'Address(street: $street, city: $city, state: $state, postcode: $postcode, country: $country)';
  }
}

/// @nodoc
abstract mixin class _$AddressCopyWith<$Res> implements $AddressCopyWith<$Res> {
  factory _$AddressCopyWith(_Address value, $Res Function(_Address) _then) =
      __$AddressCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? street,
      String? city,
      String? state,
      String? postcode,
      String? country});
}

/// @nodoc
class __$AddressCopyWithImpl<$Res> implements _$AddressCopyWith<$Res> {
  __$AddressCopyWithImpl(this._self, this._then);

  final _Address _self;
  final $Res Function(_Address) _then;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? street = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? postcode = freezed,
    Object? country = freezed,
  }) {
    return _then(_Address(
      street: freezed == street
          ? _self.street
          : street // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _self.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _self.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      postcode: freezed == postcode
          ? _self.postcode
          : postcode // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _self.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$ContactDetails {
  String? get phone;
  String? get email;
  String? get website;

  /// Create a copy of ContactDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ContactDetailsCopyWith<ContactDetails> get copyWith =>
      _$ContactDetailsCopyWithImpl<ContactDetails>(
          this as ContactDetails, _$identity);

  /// Serializes this ContactDetails to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ContactDetails &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.website, website) || other.website == website));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, phone, email, website);

  @override
  String toString() {
    return 'ContactDetails(phone: $phone, email: $email, website: $website)';
  }
}

/// @nodoc
abstract mixin class $ContactDetailsCopyWith<$Res> {
  factory $ContactDetailsCopyWith(
          ContactDetails value, $Res Function(ContactDetails) _then) =
      _$ContactDetailsCopyWithImpl;
  @useResult
  $Res call({String? phone, String? email, String? website});
}

/// @nodoc
class _$ContactDetailsCopyWithImpl<$Res>
    implements $ContactDetailsCopyWith<$Res> {
  _$ContactDetailsCopyWithImpl(this._self, this._then);

  final ContactDetails _self;
  final $Res Function(ContactDetails) _then;

  /// Create a copy of ContactDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = freezed,
    Object? email = freezed,
    Object? website = freezed,
  }) {
    return _then(_self.copyWith(
      phone: freezed == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      website: freezed == website
          ? _self.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ContactDetails].
extension ContactDetailsPatterns on ContactDetails {
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
    TResult Function(_ContactDetails value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContactDetails() when $default != null:
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
    TResult Function(_ContactDetails value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContactDetails():
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
    TResult? Function(_ContactDetails value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContactDetails() when $default != null:
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
    TResult Function(String? phone, String? email, String? website)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContactDetails() when $default != null:
        return $default(_that.phone, _that.email, _that.website);
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
    TResult Function(String? phone, String? email, String? website) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContactDetails():
        return $default(_that.phone, _that.email, _that.website);
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
    TResult? Function(String? phone, String? email, String? website)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContactDetails() when $default != null:
        return $default(_that.phone, _that.email, _that.website);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ContactDetails implements ContactDetails {
  const _ContactDetails({this.phone, this.email, this.website});
  factory _ContactDetails.fromJson(Map<String, dynamic> json) =>
      _$ContactDetailsFromJson(json);

  @override
  final String? phone;
  @override
  final String? email;
  @override
  final String? website;

  /// Create a copy of ContactDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ContactDetailsCopyWith<_ContactDetails> get copyWith =>
      __$ContactDetailsCopyWithImpl<_ContactDetails>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ContactDetailsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ContactDetails &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.website, website) || other.website == website));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, phone, email, website);

  @override
  String toString() {
    return 'ContactDetails(phone: $phone, email: $email, website: $website)';
  }
}

/// @nodoc
abstract mixin class _$ContactDetailsCopyWith<$Res>
    implements $ContactDetailsCopyWith<$Res> {
  factory _$ContactDetailsCopyWith(
          _ContactDetails value, $Res Function(_ContactDetails) _then) =
      __$ContactDetailsCopyWithImpl;
  @override
  @useResult
  $Res call({String? phone, String? email, String? website});
}

/// @nodoc
class __$ContactDetailsCopyWithImpl<$Res>
    implements _$ContactDetailsCopyWith<$Res> {
  __$ContactDetailsCopyWithImpl(this._self, this._then);

  final _ContactDetails _self;
  final $Res Function(_ContactDetails) _then;

  /// Create a copy of ContactDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? phone = freezed,
    Object? email = freezed,
    Object? website = freezed,
  }) {
    return _then(_ContactDetails(
      phone: freezed == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      website: freezed == website
          ? _self.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$BankDetails {
  String? get bankName;
  String? get accountName;
  String? get bsb;
  String? get accountNumber;

  /// Create a copy of BankDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BankDetailsCopyWith<BankDetails> get copyWith =>
      _$BankDetailsCopyWithImpl<BankDetails>(this as BankDetails, _$identity);

  /// Serializes this BankDetails to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BankDetails &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.accountName, accountName) ||
                other.accountName == accountName) &&
            (identical(other.bsb, bsb) || other.bsb == bsb) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, bankName, accountName, bsb, accountNumber);

  @override
  String toString() {
    return 'BankDetails(bankName: $bankName, accountName: $accountName, bsb: $bsb, accountNumber: $accountNumber)';
  }
}

/// @nodoc
abstract mixin class $BankDetailsCopyWith<$Res> {
  factory $BankDetailsCopyWith(
          BankDetails value, $Res Function(BankDetails) _then) =
      _$BankDetailsCopyWithImpl;
  @useResult
  $Res call(
      {String? bankName,
      String? accountName,
      String? bsb,
      String? accountNumber});
}

/// @nodoc
class _$BankDetailsCopyWithImpl<$Res> implements $BankDetailsCopyWith<$Res> {
  _$BankDetailsCopyWithImpl(this._self, this._then);

  final BankDetails _self;
  final $Res Function(BankDetails) _then;

  /// Create a copy of BankDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bankName = freezed,
    Object? accountName = freezed,
    Object? bsb = freezed,
    Object? accountNumber = freezed,
  }) {
    return _then(_self.copyWith(
      bankName: freezed == bankName
          ? _self.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String?,
      accountName: freezed == accountName
          ? _self.accountName
          : accountName // ignore: cast_nullable_to_non_nullable
              as String?,
      bsb: freezed == bsb
          ? _self.bsb
          : bsb // ignore: cast_nullable_to_non_nullable
              as String?,
      accountNumber: freezed == accountNumber
          ? _self.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [BankDetails].
extension BankDetailsPatterns on BankDetails {
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
    TResult Function(_BankDetails value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BankDetails() when $default != null:
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
    TResult Function(_BankDetails value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BankDetails():
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
    TResult? Function(_BankDetails value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BankDetails() when $default != null:
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
    TResult Function(String? bankName, String? accountName, String? bsb,
            String? accountNumber)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BankDetails() when $default != null:
        return $default(
            _that.bankName, _that.accountName, _that.bsb, _that.accountNumber);
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
    TResult Function(String? bankName, String? accountName, String? bsb,
            String? accountNumber)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BankDetails():
        return $default(
            _that.bankName, _that.accountName, _that.bsb, _that.accountNumber);
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
    TResult? Function(String? bankName, String? accountName, String? bsb,
            String? accountNumber)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BankDetails() when $default != null:
        return $default(
            _that.bankName, _that.accountName, _that.bsb, _that.accountNumber);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BankDetails implements BankDetails {
  const _BankDetails(
      {this.bankName, this.accountName, this.bsb, this.accountNumber});
  factory _BankDetails.fromJson(Map<String, dynamic> json) =>
      _$BankDetailsFromJson(json);

  @override
  final String? bankName;
  @override
  final String? accountName;
  @override
  final String? bsb;
  @override
  final String? accountNumber;

  /// Create a copy of BankDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BankDetailsCopyWith<_BankDetails> get copyWith =>
      __$BankDetailsCopyWithImpl<_BankDetails>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BankDetailsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BankDetails &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.accountName, accountName) ||
                other.accountName == accountName) &&
            (identical(other.bsb, bsb) || other.bsb == bsb) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, bankName, accountName, bsb, accountNumber);

  @override
  String toString() {
    return 'BankDetails(bankName: $bankName, accountName: $accountName, bsb: $bsb, accountNumber: $accountNumber)';
  }
}

/// @nodoc
abstract mixin class _$BankDetailsCopyWith<$Res>
    implements $BankDetailsCopyWith<$Res> {
  factory _$BankDetailsCopyWith(
          _BankDetails value, $Res Function(_BankDetails) _then) =
      __$BankDetailsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? bankName,
      String? accountName,
      String? bsb,
      String? accountNumber});
}

/// @nodoc
class __$BankDetailsCopyWithImpl<$Res> implements _$BankDetailsCopyWith<$Res> {
  __$BankDetailsCopyWithImpl(this._self, this._then);

  final _BankDetails _self;
  final $Res Function(_BankDetails) _then;

  /// Create a copy of BankDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? bankName = freezed,
    Object? accountName = freezed,
    Object? bsb = freezed,
    Object? accountNumber = freezed,
  }) {
    return _then(_BankDetails(
      bankName: freezed == bankName
          ? _self.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String?,
      accountName: freezed == accountName
          ? _self.accountName
          : accountName // ignore: cast_nullable_to_non_nullable
              as String?,
      bsb: freezed == bsb
          ? _self.bsb
          : bsb // ignore: cast_nullable_to_non_nullable
              as String?,
      accountNumber: freezed == accountNumber
          ? _self.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$NdisRegistration {
  bool? get isRegistered;
  String? get registrationNumber;

  /// Create a copy of NdisRegistration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NdisRegistrationCopyWith<NdisRegistration> get copyWith =>
      _$NdisRegistrationCopyWithImpl<NdisRegistration>(
          this as NdisRegistration, _$identity);

  /// Serializes this NdisRegistration to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NdisRegistration &&
            (identical(other.isRegistered, isRegistered) ||
                other.isRegistered == isRegistered) &&
            (identical(other.registrationNumber, registrationNumber) ||
                other.registrationNumber == registrationNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, isRegistered, registrationNumber);

  @override
  String toString() {
    return 'NdisRegistration(isRegistered: $isRegistered, registrationNumber: $registrationNumber)';
  }
}

/// @nodoc
abstract mixin class $NdisRegistrationCopyWith<$Res> {
  factory $NdisRegistrationCopyWith(
          NdisRegistration value, $Res Function(NdisRegistration) _then) =
      _$NdisRegistrationCopyWithImpl;
  @useResult
  $Res call({bool? isRegistered, String? registrationNumber});
}

/// @nodoc
class _$NdisRegistrationCopyWithImpl<$Res>
    implements $NdisRegistrationCopyWith<$Res> {
  _$NdisRegistrationCopyWithImpl(this._self, this._then);

  final NdisRegistration _self;
  final $Res Function(NdisRegistration) _then;

  /// Create a copy of NdisRegistration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isRegistered = freezed,
    Object? registrationNumber = freezed,
  }) {
    return _then(_self.copyWith(
      isRegistered: freezed == isRegistered
          ? _self.isRegistered
          : isRegistered // ignore: cast_nullable_to_non_nullable
              as bool?,
      registrationNumber: freezed == registrationNumber
          ? _self.registrationNumber
          : registrationNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [NdisRegistration].
extension NdisRegistrationPatterns on NdisRegistration {
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
    TResult Function(_NdisRegistration value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NdisRegistration() when $default != null:
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
    TResult Function(_NdisRegistration value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NdisRegistration():
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
    TResult? Function(_NdisRegistration value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NdisRegistration() when $default != null:
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
    TResult Function(bool? isRegistered, String? registrationNumber)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NdisRegistration() when $default != null:
        return $default(_that.isRegistered, _that.registrationNumber);
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
    TResult Function(bool? isRegistered, String? registrationNumber) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NdisRegistration():
        return $default(_that.isRegistered, _that.registrationNumber);
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
    TResult? Function(bool? isRegistered, String? registrationNumber)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NdisRegistration() when $default != null:
        return $default(_that.isRegistered, _that.registrationNumber);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _NdisRegistration implements NdisRegistration {
  const _NdisRegistration({this.isRegistered, this.registrationNumber});
  factory _NdisRegistration.fromJson(Map<String, dynamic> json) =>
      _$NdisRegistrationFromJson(json);

  @override
  final bool? isRegistered;
  @override
  final String? registrationNumber;

  /// Create a copy of NdisRegistration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NdisRegistrationCopyWith<_NdisRegistration> get copyWith =>
      __$NdisRegistrationCopyWithImpl<_NdisRegistration>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$NdisRegistrationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NdisRegistration &&
            (identical(other.isRegistered, isRegistered) ||
                other.isRegistered == isRegistered) &&
            (identical(other.registrationNumber, registrationNumber) ||
                other.registrationNumber == registrationNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, isRegistered, registrationNumber);

  @override
  String toString() {
    return 'NdisRegistration(isRegistered: $isRegistered, registrationNumber: $registrationNumber)';
  }
}

/// @nodoc
abstract mixin class _$NdisRegistrationCopyWith<$Res>
    implements $NdisRegistrationCopyWith<$Res> {
  factory _$NdisRegistrationCopyWith(
          _NdisRegistration value, $Res Function(_NdisRegistration) _then) =
      __$NdisRegistrationCopyWithImpl;
  @override
  @useResult
  $Res call({bool? isRegistered, String? registrationNumber});
}

/// @nodoc
class __$NdisRegistrationCopyWithImpl<$Res>
    implements _$NdisRegistrationCopyWith<$Res> {
  __$NdisRegistrationCopyWithImpl(this._self, this._then);

  final _NdisRegistration _self;
  final $Res Function(_NdisRegistration) _then;

  /// Create a copy of NdisRegistration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isRegistered = freezed,
    Object? registrationNumber = freezed,
  }) {
    return _then(_NdisRegistration(
      isRegistered: freezed == isRegistered
          ? _self.isRegistered
          : isRegistered // ignore: cast_nullable_to_non_nullable
              as bool?,
      registrationNumber: freezed == registrationNumber
          ? _self.registrationNumber
          : registrationNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$Organization {
  String get id;
  String get name;
  String get code;
  String? get abn;
  Address? get address;
  ContactDetails? get contactDetails;
  BankDetails? get bankDetails;
  NdisRegistration? get ndisRegistration;
  String? get stripeAccountId;
  String? get logoUrl;
  @JsonKey(fromJson: _brandingFromJson, toJson: _brandingToJson)
  OrganizationBrandingConfig? get branding;
  @JsonKey(fromJson: _integrationsFromJson, toJson: _integrationsToJson)
  OrganizationIntegrations? get integrations;

  /// Create a copy of Organization
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OrganizationCopyWith<Organization> get copyWith =>
      _$OrganizationCopyWithImpl<Organization>(
          this as Organization, _$identity);

  /// Serializes this Organization to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Organization &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.abn, abn) || other.abn == abn) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.contactDetails, contactDetails) ||
                other.contactDetails == contactDetails) &&
            (identical(other.bankDetails, bankDetails) ||
                other.bankDetails == bankDetails) &&
            (identical(other.ndisRegistration, ndisRegistration) ||
                other.ndisRegistration == ndisRegistration) &&
            (identical(other.stripeAccountId, stripeAccountId) ||
                other.stripeAccountId == stripeAccountId) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.branding, branding) ||
                other.branding == branding) &&
            (identical(other.integrations, integrations) ||
                other.integrations == integrations));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      code,
      abn,
      address,
      contactDetails,
      bankDetails,
      ndisRegistration,
      stripeAccountId,
      logoUrl,
      branding,
      integrations);

  @override
  String toString() {
    return 'Organization(id: $id, name: $name, code: $code, abn: $abn, address: $address, contactDetails: $contactDetails, bankDetails: $bankDetails, ndisRegistration: $ndisRegistration, stripeAccountId: $stripeAccountId, logoUrl: $logoUrl, branding: $branding, integrations: $integrations)';
  }
}

/// @nodoc
abstract mixin class $OrganizationCopyWith<$Res> {
  factory $OrganizationCopyWith(
          Organization value, $Res Function(Organization) _then) =
      _$OrganizationCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      String code,
      String? abn,
      Address? address,
      ContactDetails? contactDetails,
      BankDetails? bankDetails,
      NdisRegistration? ndisRegistration,
      String? stripeAccountId,
      String? logoUrl,
      @JsonKey(fromJson: _brandingFromJson, toJson: _brandingToJson)
      OrganizationBrandingConfig? branding,
      @JsonKey(fromJson: _integrationsFromJson, toJson: _integrationsToJson)
      OrganizationIntegrations? integrations});

  $AddressCopyWith<$Res>? get address;
  $ContactDetailsCopyWith<$Res>? get contactDetails;
  $BankDetailsCopyWith<$Res>? get bankDetails;
  $NdisRegistrationCopyWith<$Res>? get ndisRegistration;
  $OrganizationBrandingConfigCopyWith<$Res>? get branding;
  $OrganizationIntegrationsCopyWith<$Res>? get integrations;
}

/// @nodoc
class _$OrganizationCopyWithImpl<$Res> implements $OrganizationCopyWith<$Res> {
  _$OrganizationCopyWithImpl(this._self, this._then);

  final Organization _self;
  final $Res Function(Organization) _then;

  /// Create a copy of Organization
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? code = null,
    Object? abn = freezed,
    Object? address = freezed,
    Object? contactDetails = freezed,
    Object? bankDetails = freezed,
    Object? ndisRegistration = freezed,
    Object? stripeAccountId = freezed,
    Object? logoUrl = freezed,
    Object? branding = freezed,
    Object? integrations = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      abn: freezed == abn
          ? _self.abn
          : abn // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      contactDetails: freezed == contactDetails
          ? _self.contactDetails
          : contactDetails // ignore: cast_nullable_to_non_nullable
              as ContactDetails?,
      bankDetails: freezed == bankDetails
          ? _self.bankDetails
          : bankDetails // ignore: cast_nullable_to_non_nullable
              as BankDetails?,
      ndisRegistration: freezed == ndisRegistration
          ? _self.ndisRegistration
          : ndisRegistration // ignore: cast_nullable_to_non_nullable
              as NdisRegistration?,
      stripeAccountId: freezed == stripeAccountId
          ? _self.stripeAccountId
          : stripeAccountId // ignore: cast_nullable_to_non_nullable
              as String?,
      logoUrl: freezed == logoUrl
          ? _self.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      branding: freezed == branding
          ? _self.branding
          : branding // ignore: cast_nullable_to_non_nullable
              as OrganizationBrandingConfig?,
      integrations: freezed == integrations
          ? _self.integrations
          : integrations // ignore: cast_nullable_to_non_nullable
              as OrganizationIntegrations?,
    ));
  }

  /// Create a copy of Organization
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res>? get address {
    if (_self.address == null) {
      return null;
    }

    return $AddressCopyWith<$Res>(_self.address!, (value) {
      return _then(_self.copyWith(address: value));
    });
  }

  /// Create a copy of Organization
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ContactDetailsCopyWith<$Res>? get contactDetails {
    if (_self.contactDetails == null) {
      return null;
    }

    return $ContactDetailsCopyWith<$Res>(_self.contactDetails!, (value) {
      return _then(_self.copyWith(contactDetails: value));
    });
  }

  /// Create a copy of Organization
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BankDetailsCopyWith<$Res>? get bankDetails {
    if (_self.bankDetails == null) {
      return null;
    }

    return $BankDetailsCopyWith<$Res>(_self.bankDetails!, (value) {
      return _then(_self.copyWith(bankDetails: value));
    });
  }

  /// Create a copy of Organization
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NdisRegistrationCopyWith<$Res>? get ndisRegistration {
    if (_self.ndisRegistration == null) {
      return null;
    }

    return $NdisRegistrationCopyWith<$Res>(_self.ndisRegistration!, (value) {
      return _then(_self.copyWith(ndisRegistration: value));
    });
  }

  /// Create a copy of Organization
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrganizationBrandingConfigCopyWith<$Res>? get branding {
    if (_self.branding == null) {
      return null;
    }

    return $OrganizationBrandingConfigCopyWith<$Res>(_self.branding!, (value) {
      return _then(_self.copyWith(branding: value));
    });
  }

  /// Create a copy of Organization
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrganizationIntegrationsCopyWith<$Res>? get integrations {
    if (_self.integrations == null) {
      return null;
    }

    return $OrganizationIntegrationsCopyWith<$Res>(_self.integrations!,
        (value) {
      return _then(_self.copyWith(integrations: value));
    });
  }
}

/// Adds pattern-matching-related methods to [Organization].
extension OrganizationPatterns on Organization {
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
    TResult Function(_Organization value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Organization() when $default != null:
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
    TResult Function(_Organization value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Organization():
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
    TResult? Function(_Organization value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Organization() when $default != null:
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
            String id,
            String name,
            String code,
            String? abn,
            Address? address,
            ContactDetails? contactDetails,
            BankDetails? bankDetails,
            NdisRegistration? ndisRegistration,
            String? stripeAccountId,
            String? logoUrl,
            @JsonKey(fromJson: _brandingFromJson, toJson: _brandingToJson)
            OrganizationBrandingConfig? branding,
            @JsonKey(
                fromJson: _integrationsFromJson, toJson: _integrationsToJson)
            OrganizationIntegrations? integrations)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Organization() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.code,
            _that.abn,
            _that.address,
            _that.contactDetails,
            _that.bankDetails,
            _that.ndisRegistration,
            _that.stripeAccountId,
            _that.logoUrl,
            _that.branding,
            _that.integrations);
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
            String id,
            String name,
            String code,
            String? abn,
            Address? address,
            ContactDetails? contactDetails,
            BankDetails? bankDetails,
            NdisRegistration? ndisRegistration,
            String? stripeAccountId,
            String? logoUrl,
            @JsonKey(fromJson: _brandingFromJson, toJson: _brandingToJson)
            OrganizationBrandingConfig? branding,
            @JsonKey(
                fromJson: _integrationsFromJson, toJson: _integrationsToJson)
            OrganizationIntegrations? integrations)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Organization():
        return $default(
            _that.id,
            _that.name,
            _that.code,
            _that.abn,
            _that.address,
            _that.contactDetails,
            _that.bankDetails,
            _that.ndisRegistration,
            _that.stripeAccountId,
            _that.logoUrl,
            _that.branding,
            _that.integrations);
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
            String id,
            String name,
            String code,
            String? abn,
            Address? address,
            ContactDetails? contactDetails,
            BankDetails? bankDetails,
            NdisRegistration? ndisRegistration,
            String? stripeAccountId,
            String? logoUrl,
            @JsonKey(fromJson: _brandingFromJson, toJson: _brandingToJson)
            OrganizationBrandingConfig? branding,
            @JsonKey(
                fromJson: _integrationsFromJson, toJson: _integrationsToJson)
            OrganizationIntegrations? integrations)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Organization() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.code,
            _that.abn,
            _that.address,
            _that.contactDetails,
            _that.bankDetails,
            _that.ndisRegistration,
            _that.stripeAccountId,
            _that.logoUrl,
            _that.branding,
            _that.integrations);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Organization implements Organization {
  const _Organization(
      {required this.id,
      required this.name,
      required this.code,
      this.abn,
      this.address,
      this.contactDetails,
      this.bankDetails,
      this.ndisRegistration,
      this.stripeAccountId,
      this.logoUrl,
      @JsonKey(fromJson: _brandingFromJson, toJson: _brandingToJson)
      this.branding,
      @JsonKey(fromJson: _integrationsFromJson, toJson: _integrationsToJson)
      this.integrations});
  factory _Organization.fromJson(Map<String, dynamic> json) =>
      _$OrganizationFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String code;
  @override
  final String? abn;
  @override
  final Address? address;
  @override
  final ContactDetails? contactDetails;
  @override
  final BankDetails? bankDetails;
  @override
  final NdisRegistration? ndisRegistration;
  @override
  final String? stripeAccountId;
  @override
  final String? logoUrl;
  @override
  @JsonKey(fromJson: _brandingFromJson, toJson: _brandingToJson)
  final OrganizationBrandingConfig? branding;
  @override
  @JsonKey(fromJson: _integrationsFromJson, toJson: _integrationsToJson)
  final OrganizationIntegrations? integrations;

  /// Create a copy of Organization
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OrganizationCopyWith<_Organization> get copyWith =>
      __$OrganizationCopyWithImpl<_Organization>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OrganizationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Organization &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.abn, abn) || other.abn == abn) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.contactDetails, contactDetails) ||
                other.contactDetails == contactDetails) &&
            (identical(other.bankDetails, bankDetails) ||
                other.bankDetails == bankDetails) &&
            (identical(other.ndisRegistration, ndisRegistration) ||
                other.ndisRegistration == ndisRegistration) &&
            (identical(other.stripeAccountId, stripeAccountId) ||
                other.stripeAccountId == stripeAccountId) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.branding, branding) ||
                other.branding == branding) &&
            (identical(other.integrations, integrations) ||
                other.integrations == integrations));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      code,
      abn,
      address,
      contactDetails,
      bankDetails,
      ndisRegistration,
      stripeAccountId,
      logoUrl,
      branding,
      integrations);

  @override
  String toString() {
    return 'Organization(id: $id, name: $name, code: $code, abn: $abn, address: $address, contactDetails: $contactDetails, bankDetails: $bankDetails, ndisRegistration: $ndisRegistration, stripeAccountId: $stripeAccountId, logoUrl: $logoUrl, branding: $branding, integrations: $integrations)';
  }
}

/// @nodoc
abstract mixin class _$OrganizationCopyWith<$Res>
    implements $OrganizationCopyWith<$Res> {
  factory _$OrganizationCopyWith(
          _Organization value, $Res Function(_Organization) _then) =
      __$OrganizationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String code,
      String? abn,
      Address? address,
      ContactDetails? contactDetails,
      BankDetails? bankDetails,
      NdisRegistration? ndisRegistration,
      String? stripeAccountId,
      String? logoUrl,
      @JsonKey(fromJson: _brandingFromJson, toJson: _brandingToJson)
      OrganizationBrandingConfig? branding,
      @JsonKey(fromJson: _integrationsFromJson, toJson: _integrationsToJson)
      OrganizationIntegrations? integrations});

  @override
  $AddressCopyWith<$Res>? get address;
  @override
  $ContactDetailsCopyWith<$Res>? get contactDetails;
  @override
  $BankDetailsCopyWith<$Res>? get bankDetails;
  @override
  $NdisRegistrationCopyWith<$Res>? get ndisRegistration;
  @override
  $OrganizationBrandingConfigCopyWith<$Res>? get branding;
  @override
  $OrganizationIntegrationsCopyWith<$Res>? get integrations;
}

/// @nodoc
class __$OrganizationCopyWithImpl<$Res>
    implements _$OrganizationCopyWith<$Res> {
  __$OrganizationCopyWithImpl(this._self, this._then);

  final _Organization _self;
  final $Res Function(_Organization) _then;

  /// Create a copy of Organization
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? code = null,
    Object? abn = freezed,
    Object? address = freezed,
    Object? contactDetails = freezed,
    Object? bankDetails = freezed,
    Object? ndisRegistration = freezed,
    Object? stripeAccountId = freezed,
    Object? logoUrl = freezed,
    Object? branding = freezed,
    Object? integrations = freezed,
  }) {
    return _then(_Organization(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      abn: freezed == abn
          ? _self.abn
          : abn // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      contactDetails: freezed == contactDetails
          ? _self.contactDetails
          : contactDetails // ignore: cast_nullable_to_non_nullable
              as ContactDetails?,
      bankDetails: freezed == bankDetails
          ? _self.bankDetails
          : bankDetails // ignore: cast_nullable_to_non_nullable
              as BankDetails?,
      ndisRegistration: freezed == ndisRegistration
          ? _self.ndisRegistration
          : ndisRegistration // ignore: cast_nullable_to_non_nullable
              as NdisRegistration?,
      stripeAccountId: freezed == stripeAccountId
          ? _self.stripeAccountId
          : stripeAccountId // ignore: cast_nullable_to_non_nullable
              as String?,
      logoUrl: freezed == logoUrl
          ? _self.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      branding: freezed == branding
          ? _self.branding
          : branding // ignore: cast_nullable_to_non_nullable
              as OrganizationBrandingConfig?,
      integrations: freezed == integrations
          ? _self.integrations
          : integrations // ignore: cast_nullable_to_non_nullable
              as OrganizationIntegrations?,
    ));
  }

  /// Create a copy of Organization
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res>? get address {
    if (_self.address == null) {
      return null;
    }

    return $AddressCopyWith<$Res>(_self.address!, (value) {
      return _then(_self.copyWith(address: value));
    });
  }

  /// Create a copy of Organization
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ContactDetailsCopyWith<$Res>? get contactDetails {
    if (_self.contactDetails == null) {
      return null;
    }

    return $ContactDetailsCopyWith<$Res>(_self.contactDetails!, (value) {
      return _then(_self.copyWith(contactDetails: value));
    });
  }

  /// Create a copy of Organization
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BankDetailsCopyWith<$Res>? get bankDetails {
    if (_self.bankDetails == null) {
      return null;
    }

    return $BankDetailsCopyWith<$Res>(_self.bankDetails!, (value) {
      return _then(_self.copyWith(bankDetails: value));
    });
  }

  /// Create a copy of Organization
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NdisRegistrationCopyWith<$Res>? get ndisRegistration {
    if (_self.ndisRegistration == null) {
      return null;
    }

    return $NdisRegistrationCopyWith<$Res>(_self.ndisRegistration!, (value) {
      return _then(_self.copyWith(ndisRegistration: value));
    });
  }

  /// Create a copy of Organization
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrganizationBrandingConfigCopyWith<$Res>? get branding {
    if (_self.branding == null) {
      return null;
    }

    return $OrganizationBrandingConfigCopyWith<$Res>(_self.branding!, (value) {
      return _then(_self.copyWith(branding: value));
    });
  }

  /// Create a copy of Organization
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrganizationIntegrationsCopyWith<$Res>? get integrations {
    if (_self.integrations == null) {
      return null;
    }

    return $OrganizationIntegrationsCopyWith<$Res>(_self.integrations!,
        (value) {
      return _then(_self.copyWith(integrations: value));
    });
  }
}

// dart format on
