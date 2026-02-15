// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'organization_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Address _$AddressFromJson(Map<String, dynamic> json) {
  return _Address.fromJson(json);
}

/// @nodoc
mixin _$Address {
  String? get street => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;
  String? get postcode => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddressCopyWith<Address> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressCopyWith<$Res> {
  factory $AddressCopyWith(Address value, $Res Function(Address) then) =
      _$AddressCopyWithImpl<$Res, Address>;
  @useResult
  $Res call(
      {String? street,
      String? city,
      String? state,
      String? postcode,
      String? country});
}

/// @nodoc
class _$AddressCopyWithImpl<$Res, $Val extends Address>
    implements $AddressCopyWith<$Res> {
  _$AddressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? street = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? postcode = freezed,
    Object? country = freezed,
  }) {
    return _then(_value.copyWith(
      street: freezed == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      postcode: freezed == postcode
          ? _value.postcode
          : postcode // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddressImplCopyWith<$Res> implements $AddressCopyWith<$Res> {
  factory _$$AddressImplCopyWith(
          _$AddressImpl value, $Res Function(_$AddressImpl) then) =
      __$$AddressImplCopyWithImpl<$Res>;
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
class __$$AddressImplCopyWithImpl<$Res>
    extends _$AddressCopyWithImpl<$Res, _$AddressImpl>
    implements _$$AddressImplCopyWith<$Res> {
  __$$AddressImplCopyWithImpl(
      _$AddressImpl _value, $Res Function(_$AddressImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? street = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? postcode = freezed,
    Object? country = freezed,
  }) {
    return _then(_$AddressImpl(
      street: freezed == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      postcode: freezed == postcode
          ? _value.postcode
          : postcode // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddressImpl implements _Address {
  const _$AddressImpl(
      {this.street, this.city, this.state, this.postcode, this.country});

  factory _$AddressImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddressImplFromJson(json);

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

  @override
  String toString() {
    return 'Address(street: $street, city: $city, state: $state, postcode: $postcode, country: $country)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressImpl &&
            (identical(other.street, street) || other.street == street) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.postcode, postcode) ||
                other.postcode == postcode) &&
            (identical(other.country, country) || other.country == country));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, street, city, state, postcode, country);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressImplCopyWith<_$AddressImpl> get copyWith =>
      __$$AddressImplCopyWithImpl<_$AddressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddressImplToJson(
      this,
    );
  }
}

abstract class _Address implements Address {
  const factory _Address(
      {final String? street,
      final String? city,
      final String? state,
      final String? postcode,
      final String? country}) = _$AddressImpl;

  factory _Address.fromJson(Map<String, dynamic> json) = _$AddressImpl.fromJson;

  @override
  String? get street;
  @override
  String? get city;
  @override
  String? get state;
  @override
  String? get postcode;
  @override
  String? get country;
  @override
  @JsonKey(ignore: true)
  _$$AddressImplCopyWith<_$AddressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ContactDetails _$ContactDetailsFromJson(Map<String, dynamic> json) {
  return _ContactDetails.fromJson(json);
}

/// @nodoc
mixin _$ContactDetails {
  String? get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get website => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ContactDetailsCopyWith<ContactDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactDetailsCopyWith<$Res> {
  factory $ContactDetailsCopyWith(
          ContactDetails value, $Res Function(ContactDetails) then) =
      _$ContactDetailsCopyWithImpl<$Res, ContactDetails>;
  @useResult
  $Res call({String? phone, String? email, String? website});
}

/// @nodoc
class _$ContactDetailsCopyWithImpl<$Res, $Val extends ContactDetails>
    implements $ContactDetailsCopyWith<$Res> {
  _$ContactDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = freezed,
    Object? email = freezed,
    Object? website = freezed,
  }) {
    return _then(_value.copyWith(
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContactDetailsImplCopyWith<$Res>
    implements $ContactDetailsCopyWith<$Res> {
  factory _$$ContactDetailsImplCopyWith(_$ContactDetailsImpl value,
          $Res Function(_$ContactDetailsImpl) then) =
      __$$ContactDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? phone, String? email, String? website});
}

/// @nodoc
class __$$ContactDetailsImplCopyWithImpl<$Res>
    extends _$ContactDetailsCopyWithImpl<$Res, _$ContactDetailsImpl>
    implements _$$ContactDetailsImplCopyWith<$Res> {
  __$$ContactDetailsImplCopyWithImpl(
      _$ContactDetailsImpl _value, $Res Function(_$ContactDetailsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = freezed,
    Object? email = freezed,
    Object? website = freezed,
  }) {
    return _then(_$ContactDetailsImpl(
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContactDetailsImpl implements _ContactDetails {
  const _$ContactDetailsImpl({this.phone, this.email, this.website});

  factory _$ContactDetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContactDetailsImplFromJson(json);

  @override
  final String? phone;
  @override
  final String? email;
  @override
  final String? website;

  @override
  String toString() {
    return 'ContactDetails(phone: $phone, email: $email, website: $website)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactDetailsImpl &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.website, website) || other.website == website));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, phone, email, website);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactDetailsImplCopyWith<_$ContactDetailsImpl> get copyWith =>
      __$$ContactDetailsImplCopyWithImpl<_$ContactDetailsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContactDetailsImplToJson(
      this,
    );
  }
}

abstract class _ContactDetails implements ContactDetails {
  const factory _ContactDetails(
      {final String? phone,
      final String? email,
      final String? website}) = _$ContactDetailsImpl;

  factory _ContactDetails.fromJson(Map<String, dynamic> json) =
      _$ContactDetailsImpl.fromJson;

  @override
  String? get phone;
  @override
  String? get email;
  @override
  String? get website;
  @override
  @JsonKey(ignore: true)
  _$$ContactDetailsImplCopyWith<_$ContactDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BankDetails _$BankDetailsFromJson(Map<String, dynamic> json) {
  return _BankDetails.fromJson(json);
}

/// @nodoc
mixin _$BankDetails {
  String? get bankName => throw _privateConstructorUsedError;
  String? get accountName => throw _privateConstructorUsedError;
  String? get bsb => throw _privateConstructorUsedError;
  String? get accountNumber => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BankDetailsCopyWith<BankDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BankDetailsCopyWith<$Res> {
  factory $BankDetailsCopyWith(
          BankDetails value, $Res Function(BankDetails) then) =
      _$BankDetailsCopyWithImpl<$Res, BankDetails>;
  @useResult
  $Res call(
      {String? bankName,
      String? accountName,
      String? bsb,
      String? accountNumber});
}

/// @nodoc
class _$BankDetailsCopyWithImpl<$Res, $Val extends BankDetails>
    implements $BankDetailsCopyWith<$Res> {
  _$BankDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bankName = freezed,
    Object? accountName = freezed,
    Object? bsb = freezed,
    Object? accountNumber = freezed,
  }) {
    return _then(_value.copyWith(
      bankName: freezed == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String?,
      accountName: freezed == accountName
          ? _value.accountName
          : accountName // ignore: cast_nullable_to_non_nullable
              as String?,
      bsb: freezed == bsb
          ? _value.bsb
          : bsb // ignore: cast_nullable_to_non_nullable
              as String?,
      accountNumber: freezed == accountNumber
          ? _value.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BankDetailsImplCopyWith<$Res>
    implements $BankDetailsCopyWith<$Res> {
  factory _$$BankDetailsImplCopyWith(
          _$BankDetailsImpl value, $Res Function(_$BankDetailsImpl) then) =
      __$$BankDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? bankName,
      String? accountName,
      String? bsb,
      String? accountNumber});
}

/// @nodoc
class __$$BankDetailsImplCopyWithImpl<$Res>
    extends _$BankDetailsCopyWithImpl<$Res, _$BankDetailsImpl>
    implements _$$BankDetailsImplCopyWith<$Res> {
  __$$BankDetailsImplCopyWithImpl(
      _$BankDetailsImpl _value, $Res Function(_$BankDetailsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bankName = freezed,
    Object? accountName = freezed,
    Object? bsb = freezed,
    Object? accountNumber = freezed,
  }) {
    return _then(_$BankDetailsImpl(
      bankName: freezed == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String?,
      accountName: freezed == accountName
          ? _value.accountName
          : accountName // ignore: cast_nullable_to_non_nullable
              as String?,
      bsb: freezed == bsb
          ? _value.bsb
          : bsb // ignore: cast_nullable_to_non_nullable
              as String?,
      accountNumber: freezed == accountNumber
          ? _value.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BankDetailsImpl implements _BankDetails {
  const _$BankDetailsImpl(
      {this.bankName, this.accountName, this.bsb, this.accountNumber});

  factory _$BankDetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$BankDetailsImplFromJson(json);

  @override
  final String? bankName;
  @override
  final String? accountName;
  @override
  final String? bsb;
  @override
  final String? accountNumber;

  @override
  String toString() {
    return 'BankDetails(bankName: $bankName, accountName: $accountName, bsb: $bsb, accountNumber: $accountNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BankDetailsImpl &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.accountName, accountName) ||
                other.accountName == accountName) &&
            (identical(other.bsb, bsb) || other.bsb == bsb) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, bankName, accountName, bsb, accountNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BankDetailsImplCopyWith<_$BankDetailsImpl> get copyWith =>
      __$$BankDetailsImplCopyWithImpl<_$BankDetailsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BankDetailsImplToJson(
      this,
    );
  }
}

abstract class _BankDetails implements BankDetails {
  const factory _BankDetails(
      {final String? bankName,
      final String? accountName,
      final String? bsb,
      final String? accountNumber}) = _$BankDetailsImpl;

  factory _BankDetails.fromJson(Map<String, dynamic> json) =
      _$BankDetailsImpl.fromJson;

  @override
  String? get bankName;
  @override
  String? get accountName;
  @override
  String? get bsb;
  @override
  String? get accountNumber;
  @override
  @JsonKey(ignore: true)
  _$$BankDetailsImplCopyWith<_$BankDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NdisRegistration _$NdisRegistrationFromJson(Map<String, dynamic> json) {
  return _NdisRegistration.fromJson(json);
}

/// @nodoc
mixin _$NdisRegistration {
  bool? get isRegistered => throw _privateConstructorUsedError;
  String? get registrationNumber => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NdisRegistrationCopyWith<NdisRegistration> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NdisRegistrationCopyWith<$Res> {
  factory $NdisRegistrationCopyWith(
          NdisRegistration value, $Res Function(NdisRegistration) then) =
      _$NdisRegistrationCopyWithImpl<$Res, NdisRegistration>;
  @useResult
  $Res call({bool? isRegistered, String? registrationNumber});
}

/// @nodoc
class _$NdisRegistrationCopyWithImpl<$Res, $Val extends NdisRegistration>
    implements $NdisRegistrationCopyWith<$Res> {
  _$NdisRegistrationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isRegistered = freezed,
    Object? registrationNumber = freezed,
  }) {
    return _then(_value.copyWith(
      isRegistered: freezed == isRegistered
          ? _value.isRegistered
          : isRegistered // ignore: cast_nullable_to_non_nullable
              as bool?,
      registrationNumber: freezed == registrationNumber
          ? _value.registrationNumber
          : registrationNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NdisRegistrationImplCopyWith<$Res>
    implements $NdisRegistrationCopyWith<$Res> {
  factory _$$NdisRegistrationImplCopyWith(_$NdisRegistrationImpl value,
          $Res Function(_$NdisRegistrationImpl) then) =
      __$$NdisRegistrationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? isRegistered, String? registrationNumber});
}

/// @nodoc
class __$$NdisRegistrationImplCopyWithImpl<$Res>
    extends _$NdisRegistrationCopyWithImpl<$Res, _$NdisRegistrationImpl>
    implements _$$NdisRegistrationImplCopyWith<$Res> {
  __$$NdisRegistrationImplCopyWithImpl(_$NdisRegistrationImpl _value,
      $Res Function(_$NdisRegistrationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isRegistered = freezed,
    Object? registrationNumber = freezed,
  }) {
    return _then(_$NdisRegistrationImpl(
      isRegistered: freezed == isRegistered
          ? _value.isRegistered
          : isRegistered // ignore: cast_nullable_to_non_nullable
              as bool?,
      registrationNumber: freezed == registrationNumber
          ? _value.registrationNumber
          : registrationNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NdisRegistrationImpl implements _NdisRegistration {
  const _$NdisRegistrationImpl({this.isRegistered, this.registrationNumber});

  factory _$NdisRegistrationImpl.fromJson(Map<String, dynamic> json) =>
      _$$NdisRegistrationImplFromJson(json);

  @override
  final bool? isRegistered;
  @override
  final String? registrationNumber;

  @override
  String toString() {
    return 'NdisRegistration(isRegistered: $isRegistered, registrationNumber: $registrationNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NdisRegistrationImpl &&
            (identical(other.isRegistered, isRegistered) ||
                other.isRegistered == isRegistered) &&
            (identical(other.registrationNumber, registrationNumber) ||
                other.registrationNumber == registrationNumber));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, isRegistered, registrationNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NdisRegistrationImplCopyWith<_$NdisRegistrationImpl> get copyWith =>
      __$$NdisRegistrationImplCopyWithImpl<_$NdisRegistrationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NdisRegistrationImplToJson(
      this,
    );
  }
}

abstract class _NdisRegistration implements NdisRegistration {
  const factory _NdisRegistration(
      {final bool? isRegistered,
      final String? registrationNumber}) = _$NdisRegistrationImpl;

  factory _NdisRegistration.fromJson(Map<String, dynamic> json) =
      _$NdisRegistrationImpl.fromJson;

  @override
  bool? get isRegistered;
  @override
  String? get registrationNumber;
  @override
  @JsonKey(ignore: true)
  _$$NdisRegistrationImplCopyWith<_$NdisRegistrationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Organization _$OrganizationFromJson(Map<String, dynamic> json) {
  return _Organization.fromJson(json);
}

/// @nodoc
mixin _$Organization {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String? get abn => throw _privateConstructorUsedError;
  Address? get address => throw _privateConstructorUsedError;
  ContactDetails? get contactDetails => throw _privateConstructorUsedError;
  BankDetails? get bankDetails => throw _privateConstructorUsedError;
  NdisRegistration? get ndisRegistration => throw _privateConstructorUsedError;
  String? get stripeAccountId => throw _privateConstructorUsedError;
  String? get logoUrl => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _brandingFromJson, toJson: _brandingToJson)
  OrganizationBrandingConfig? get branding =>
      throw _privateConstructorUsedError;
  @JsonKey(fromJson: _integrationsFromJson, toJson: _integrationsToJson)
  OrganizationIntegrations? get integrations =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrganizationCopyWith<Organization> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrganizationCopyWith<$Res> {
  factory $OrganizationCopyWith(
          Organization value, $Res Function(Organization) then) =
      _$OrganizationCopyWithImpl<$Res, Organization>;
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
class _$OrganizationCopyWithImpl<$Res, $Val extends Organization>
    implements $OrganizationCopyWith<$Res> {
  _$OrganizationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      abn: freezed == abn
          ? _value.abn
          : abn // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      contactDetails: freezed == contactDetails
          ? _value.contactDetails
          : contactDetails // ignore: cast_nullable_to_non_nullable
              as ContactDetails?,
      bankDetails: freezed == bankDetails
          ? _value.bankDetails
          : bankDetails // ignore: cast_nullable_to_non_nullable
              as BankDetails?,
      ndisRegistration: freezed == ndisRegistration
          ? _value.ndisRegistration
          : ndisRegistration // ignore: cast_nullable_to_non_nullable
              as NdisRegistration?,
      stripeAccountId: freezed == stripeAccountId
          ? _value.stripeAccountId
          : stripeAccountId // ignore: cast_nullable_to_non_nullable
              as String?,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      branding: freezed == branding
          ? _value.branding
          : branding // ignore: cast_nullable_to_non_nullable
              as OrganizationBrandingConfig?,
      integrations: freezed == integrations
          ? _value.integrations
          : integrations // ignore: cast_nullable_to_non_nullable
              as OrganizationIntegrations?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res>? get address {
    if (_value.address == null) {
      return null;
    }

    return $AddressCopyWith<$Res>(_value.address!, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ContactDetailsCopyWith<$Res>? get contactDetails {
    if (_value.contactDetails == null) {
      return null;
    }

    return $ContactDetailsCopyWith<$Res>(_value.contactDetails!, (value) {
      return _then(_value.copyWith(contactDetails: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $BankDetailsCopyWith<$Res>? get bankDetails {
    if (_value.bankDetails == null) {
      return null;
    }

    return $BankDetailsCopyWith<$Res>(_value.bankDetails!, (value) {
      return _then(_value.copyWith(bankDetails: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $NdisRegistrationCopyWith<$Res>? get ndisRegistration {
    if (_value.ndisRegistration == null) {
      return null;
    }

    return $NdisRegistrationCopyWith<$Res>(_value.ndisRegistration!, (value) {
      return _then(_value.copyWith(ndisRegistration: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $OrganizationBrandingConfigCopyWith<$Res>? get branding {
    if (_value.branding == null) {
      return null;
    }

    return $OrganizationBrandingConfigCopyWith<$Res>(_value.branding!, (value) {
      return _then(_value.copyWith(branding: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $OrganizationIntegrationsCopyWith<$Res>? get integrations {
    if (_value.integrations == null) {
      return null;
    }

    return $OrganizationIntegrationsCopyWith<$Res>(_value.integrations!,
        (value) {
      return _then(_value.copyWith(integrations: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrganizationImplCopyWith<$Res>
    implements $OrganizationCopyWith<$Res> {
  factory _$$OrganizationImplCopyWith(
          _$OrganizationImpl value, $Res Function(_$OrganizationImpl) then) =
      __$$OrganizationImplCopyWithImpl<$Res>;
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
class __$$OrganizationImplCopyWithImpl<$Res>
    extends _$OrganizationCopyWithImpl<$Res, _$OrganizationImpl>
    implements _$$OrganizationImplCopyWith<$Res> {
  __$$OrganizationImplCopyWithImpl(
      _$OrganizationImpl _value, $Res Function(_$OrganizationImpl) _then)
      : super(_value, _then);

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
    return _then(_$OrganizationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      abn: freezed == abn
          ? _value.abn
          : abn // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      contactDetails: freezed == contactDetails
          ? _value.contactDetails
          : contactDetails // ignore: cast_nullable_to_non_nullable
              as ContactDetails?,
      bankDetails: freezed == bankDetails
          ? _value.bankDetails
          : bankDetails // ignore: cast_nullable_to_non_nullable
              as BankDetails?,
      ndisRegistration: freezed == ndisRegistration
          ? _value.ndisRegistration
          : ndisRegistration // ignore: cast_nullable_to_non_nullable
              as NdisRegistration?,
      stripeAccountId: freezed == stripeAccountId
          ? _value.stripeAccountId
          : stripeAccountId // ignore: cast_nullable_to_non_nullable
              as String?,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      branding: freezed == branding
          ? _value.branding
          : branding // ignore: cast_nullable_to_non_nullable
              as OrganizationBrandingConfig?,
      integrations: freezed == integrations
          ? _value.integrations
          : integrations // ignore: cast_nullable_to_non_nullable
              as OrganizationIntegrations?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrganizationImpl implements _Organization {
  const _$OrganizationImpl(
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

  factory _$OrganizationImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrganizationImplFromJson(json);

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

  @override
  String toString() {
    return 'Organization(id: $id, name: $name, code: $code, abn: $abn, address: $address, contactDetails: $contactDetails, bankDetails: $bankDetails, ndisRegistration: $ndisRegistration, stripeAccountId: $stripeAccountId, logoUrl: $logoUrl, branding: $branding, integrations: $integrations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrganizationImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrganizationImplCopyWith<_$OrganizationImpl> get copyWith =>
      __$$OrganizationImplCopyWithImpl<_$OrganizationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrganizationImplToJson(
      this,
    );
  }
}

abstract class _Organization implements Organization {
  const factory _Organization(
      {required final String id,
      required final String name,
      required final String code,
      final String? abn,
      final Address? address,
      final ContactDetails? contactDetails,
      final BankDetails? bankDetails,
      final NdisRegistration? ndisRegistration,
      final String? stripeAccountId,
      final String? logoUrl,
      @JsonKey(fromJson: _brandingFromJson, toJson: _brandingToJson)
      final OrganizationBrandingConfig? branding,
      @JsonKey(fromJson: _integrationsFromJson, toJson: _integrationsToJson)
      final OrganizationIntegrations? integrations}) = _$OrganizationImpl;

  factory _Organization.fromJson(Map<String, dynamic> json) =
      _$OrganizationImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get code;
  @override
  String? get abn;
  @override
  Address? get address;
  @override
  ContactDetails? get contactDetails;
  @override
  BankDetails? get bankDetails;
  @override
  NdisRegistration? get ndisRegistration;
  @override
  String? get stripeAccountId;
  @override
  String? get logoUrl;
  @override
  @JsonKey(fromJson: _brandingFromJson, toJson: _brandingToJson)
  OrganizationBrandingConfig? get branding;
  @override
  @JsonKey(fromJson: _integrationsFromJson, toJson: _integrationsToJson)
  OrganizationIntegrations? get integrations;
  @override
  @JsonKey(ignore: true)
  _$$OrganizationImplCopyWith<_$OrganizationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
