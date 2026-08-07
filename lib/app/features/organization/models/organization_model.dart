import 'package:freezed_annotation/freezed_annotation.dart';
import 'organization_integrations.dart';

part 'organization_model.freezed.dart';
part 'organization_model.g.dart';

@freezed
abstract class Address with _$Address {
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
abstract class ContactDetails with _$ContactDetails {
  const factory ContactDetails({
    String? phone,
    String? email,
    String? website,
  }) = _ContactDetails;

  factory ContactDetails.fromJson(Map<String, dynamic> json) =>
      _$ContactDetailsFromJson(json);
}

@freezed
abstract class BankDetails with _$BankDetails {
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
abstract class NdisRegistration with _$NdisRegistration {
  const factory NdisRegistration({
    bool? isRegistered,
    String? registrationNumber,
  }) = _NdisRegistration;

  factory NdisRegistration.fromJson(Map<String, dynamic> json) =>
      _$NdisRegistrationFromJson(json);
}

@freezed
abstract class Organization with _$Organization {
  const factory Organization({
    required String id,
    required String name,
    required String code,
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
    OrganizationIntegrations? integrations,
  }) = _Organization;

  factory Organization.fromJson(Map<String, dynamic> json) =>
      _$OrganizationFromJson(json);

  static Organization fromBackend(Map<String, dynamic> json) {
    return Organization.fromJson(json);
  }
}

// Helper functions for backward compatibility with Map-based storage
OrganizationBrandingConfig? _brandingFromJson(dynamic json) {
  if (json == null) return null;
  if (json is Map<String, dynamic>) {
    return OrganizationBrandingConfig.fromMap(json);
  }
  return null;
}

Map<String, dynamic>? _brandingToJson(OrganizationBrandingConfig? branding) {
  return branding?.toJson();
}

OrganizationIntegrations? _integrationsFromJson(dynamic json) {
  if (json == null) return null;
  if (json is Map<String, dynamic>) {
    return OrganizationIntegrations.fromMap(json);
  }
  return null;
}

Map<String, dynamic>? _integrationsToJson(
  OrganizationIntegrations? integrations,
) {
  return integrations?.toJson();
}
