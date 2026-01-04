import 'package:freezed_annotation/freezed_annotation.dart';

part 'organization_model.freezed.dart';
part 'organization_model.g.dart';

@freezed
class Address with _$Address {
  const factory Address({
    String? street,
    String? city,
    String? state,
    String? postcode,
    String? country,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}

@freezed
class ContactDetails with _$ContactDetails {
  const factory ContactDetails({
    String? phone,
    String? email,
    String? website,
  }) = _ContactDetails;

  factory ContactDetails.fromJson(Map<String, dynamic> json) =>
      _$ContactDetailsFromJson(json);
}

@freezed
class BankDetails with _$BankDetails {
  const factory BankDetails({
    String? bankName,
    String? accountName,
    String? bsb,
    String? accountNumber,
  }) = _BankDetails;

  factory BankDetails.fromJson(Map<String, dynamic> json) =>
      _$BankDetailsFromJson(json);
}

@freezed
class NdisRegistration with _$NdisRegistration {
  const factory NdisRegistration({
    bool? isRegistered,
    String? registrationNumber,
  }) = _NdisRegistration;

  factory NdisRegistration.fromJson(Map<String, dynamic> json) =>
      _$NdisRegistrationFromJson(json);
}

@freezed
class Organization with _$Organization {
  const factory Organization({
    required String id,
    required String name,
    required String code,
    String? abn,
    Address? address,
    ContactDetails? contactDetails,
    BankDetails? bankDetails,
    NdisRegistration? ndisRegistration,
  }) = _Organization;

  factory Organization.fromJson(Map<String, dynamic> json) =>
      _$OrganizationFromJson(json);
}
