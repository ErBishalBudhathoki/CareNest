// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddressImpl _$$AddressImplFromJson(Map<String, dynamic> json) =>
    _$AddressImpl(
      street: json['street'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      postcode: json['postcode'] as String?,
      country: json['country'] as String?,
    );

Map<String, dynamic> _$$AddressImplToJson(_$AddressImpl instance) =>
    <String, dynamic>{
      'street': instance.street,
      'city': instance.city,
      'state': instance.state,
      'postcode': instance.postcode,
      'country': instance.country,
    };

_$ContactDetailsImpl _$$ContactDetailsImplFromJson(Map<String, dynamic> json) =>
    _$ContactDetailsImpl(
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      website: json['website'] as String?,
    );

Map<String, dynamic> _$$ContactDetailsImplToJson(
        _$ContactDetailsImpl instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'email': instance.email,
      'website': instance.website,
    };

_$BankDetailsImpl _$$BankDetailsImplFromJson(Map<String, dynamic> json) =>
    _$BankDetailsImpl(
      bankName: json['bankName'] as String?,
      accountName: json['accountName'] as String?,
      bsb: json['bsb'] as String?,
      accountNumber: json['accountNumber'] as String?,
    );

Map<String, dynamic> _$$BankDetailsImplToJson(_$BankDetailsImpl instance) =>
    <String, dynamic>{
      'bankName': instance.bankName,
      'accountName': instance.accountName,
      'bsb': instance.bsb,
      'accountNumber': instance.accountNumber,
    };

_$NdisRegistrationImpl _$$NdisRegistrationImplFromJson(
        Map<String, dynamic> json) =>
    _$NdisRegistrationImpl(
      isRegistered: json['isRegistered'] as bool?,
      registrationNumber: json['registrationNumber'] as String?,
    );

Map<String, dynamic> _$$NdisRegistrationImplToJson(
        _$NdisRegistrationImpl instance) =>
    <String, dynamic>{
      'isRegistered': instance.isRegistered,
      'registrationNumber': instance.registrationNumber,
    };

_$OrganizationImpl _$$OrganizationImplFromJson(Map<String, dynamic> json) =>
    _$OrganizationImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
      abn: json['abn'] as String?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      contactDetails: json['contactDetails'] == null
          ? null
          : ContactDetails.fromJson(
              json['contactDetails'] as Map<String, dynamic>),
      bankDetails: json['bankDetails'] == null
          ? null
          : BankDetails.fromJson(json['bankDetails'] as Map<String, dynamic>),
      ndisRegistration: json['ndisRegistration'] == null
          ? null
          : NdisRegistration.fromJson(
              json['ndisRegistration'] as Map<String, dynamic>),
      stripeAccountId: json['stripeAccountId'] as String?,
      logoUrl: json['logoUrl'] as String?,
      branding: _brandingFromJson(json['branding']),
      integrations: _integrationsFromJson(json['integrations']),
    );

Map<String, dynamic> _$$OrganizationImplToJson(_$OrganizationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'abn': instance.abn,
      'address': instance.address,
      'contactDetails': instance.contactDetails,
      'bankDetails': instance.bankDetails,
      'ndisRegistration': instance.ndisRegistration,
      'stripeAccountId': instance.stripeAccountId,
      'logoUrl': instance.logoUrl,
      'branding': _brandingToJson(instance.branding),
      'integrations': _integrationsToJson(instance.integrations),
    };
