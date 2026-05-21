// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_branding.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrganizationBranding _$OrganizationBrandingFromJson(
        Map<String, dynamic> json) =>
    _OrganizationBranding(
      organizationId: json['organizationId'] as String,
      primaryColor: json['primaryColor'] as String? ?? '#DC143C',
      secondaryColor: json['secondaryColor'] as String? ?? '#0066CC',
      logoUrl: json['logoUrl'] as String?,
      invoiceTemplate: json['invoiceTemplate'] == null
          ? null
          : InvoiceTemplate.fromJson(
              json['invoiceTemplate'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrganizationBrandingToJson(
        _OrganizationBranding instance) =>
    <String, dynamic>{
      'organizationId': instance.organizationId,
      'primaryColor': instance.primaryColor,
      'secondaryColor': instance.secondaryColor,
      'logoUrl': instance.logoUrl,
      'invoiceTemplate': instance.invoiceTemplate,
    };

_InvoiceTemplate _$InvoiceTemplateFromJson(Map<String, dynamic> json) =>
    _InvoiceTemplate(
      headerText: json['headerText'] as String?,
      footerText: json['footerText'] as String?,
      showLogo: json['showLogo'] as bool? ?? true,
    );

Map<String, dynamic> _$InvoiceTemplateToJson(_InvoiceTemplate instance) =>
    <String, dynamic>{
      'headerText': instance.headerText,
      'footerText': instance.footerText,
      'showLogo': instance.showLogo,
    };
