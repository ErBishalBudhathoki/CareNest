// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_integrations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntegrationConfig _$IntegrationConfigFromJson(Map<String, dynamic> json) =>
    _IntegrationConfig(
      isConnected: json['isConnected'] as bool? ?? false,
      apiKey: json['apiKey'] as String?,
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      connectedAt: json['connectedAt'] == null
          ? null
          : DateTime.parse(json['connectedAt'] as String),
      lastSyncAt: json['lastSyncAt'] == null
          ? null
          : DateTime.parse(json['lastSyncAt'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$IntegrationConfigToJson(_IntegrationConfig instance) =>
    <String, dynamic>{
      'isConnected': instance.isConnected,
      'apiKey': instance.apiKey,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'connectedAt': instance.connectedAt?.toIso8601String(),
      'lastSyncAt': instance.lastSyncAt?.toIso8601String(),
      'metadata': instance.metadata,
    };

_OrganizationIntegrations _$OrganizationIntegrationsFromJson(
        Map<String, dynamic> json) =>
    _OrganizationIntegrations(
      xero: json['xero'] == null
          ? null
          : IntegrationConfig.fromJson(json['xero'] as Map<String, dynamic>),
      myob: json['myob'] == null
          ? null
          : IntegrationConfig.fromJson(json['myob'] as Map<String, dynamic>),
      quickbooks: json['quickbooks'] == null
          ? null
          : IntegrationConfig.fromJson(
              json['quickbooks'] as Map<String, dynamic>),
      googleCalendar: json['googleCalendar'] == null
          ? null
          : IntegrationConfig.fromJson(
              json['googleCalendar'] as Map<String, dynamic>),
      outlookCalendar: json['outlookCalendar'] == null
          ? null
          : IntegrationConfig.fromJson(
              json['outlookCalendar'] as Map<String, dynamic>),
      appleCalendar: json['appleCalendar'] == null
          ? null
          : IntegrationConfig.fromJson(
              json['appleCalendar'] as Map<String, dynamic>),
      slack: json['slack'] == null
          ? null
          : IntegrationConfig.fromJson(json['slack'] as Map<String, dynamic>),
      teams: json['teams'] == null
          ? null
          : IntegrationConfig.fromJson(json['teams'] as Map<String, dynamic>),
      discord: json['discord'] == null
          ? null
          : IntegrationConfig.fromJson(json['discord'] as Map<String, dynamic>),
      stripe: json['stripe'] == null
          ? null
          : IntegrationConfig.fromJson(json['stripe'] as Map<String, dynamic>),
      paypal: json['paypal'] == null
          ? null
          : IntegrationConfig.fromJson(json['paypal'] as Map<String, dynamic>),
      square: json['square'] == null
          ? null
          : IntegrationConfig.fromJson(json['square'] as Map<String, dynamic>),
      salesforce: json['salesforce'] == null
          ? null
          : IntegrationConfig.fromJson(
              json['salesforce'] as Map<String, dynamic>),
      hubspot: json['hubspot'] == null
          ? null
          : IntegrationConfig.fromJson(json['hubspot'] as Map<String, dynamic>),
      zapier: json['zapier'] == null
          ? null
          : IntegrationConfig.fromJson(json['zapier'] as Map<String, dynamic>),
      webhooks: json['webhooks'] == null
          ? null
          : IntegrationConfig.fromJson(
              json['webhooks'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrganizationIntegrationsToJson(
        _OrganizationIntegrations instance) =>
    <String, dynamic>{
      'xero': instance.xero,
      'myob': instance.myob,
      'quickbooks': instance.quickbooks,
      'googleCalendar': instance.googleCalendar,
      'outlookCalendar': instance.outlookCalendar,
      'appleCalendar': instance.appleCalendar,
      'slack': instance.slack,
      'teams': instance.teams,
      'discord': instance.discord,
      'stripe': instance.stripe,
      'paypal': instance.paypal,
      'square': instance.square,
      'salesforce': instance.salesforce,
      'hubspot': instance.hubspot,
      'zapier': instance.zapier,
      'webhooks': instance.webhooks,
    };

_OrganizationBrandingConfig _$OrganizationBrandingConfigFromJson(
        Map<String, dynamic> json) =>
    _OrganizationBrandingConfig(
      primaryColor: json['primaryColor'] as String?,
      secondaryColor: json['secondaryColor'] as String?,
      accentColor: json['accentColor'] as String?,
      logoUrl: json['logoUrl'] as String?,
      faviconUrl: json['faviconUrl'] as String?,
      fontFamily: json['fontFamily'] as String?,
      customStyles: json['customStyles'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$OrganizationBrandingConfigToJson(
        _OrganizationBrandingConfig instance) =>
    <String, dynamic>{
      'primaryColor': instance.primaryColor,
      'secondaryColor': instance.secondaryColor,
      'accentColor': instance.accentColor,
      'logoUrl': instance.logoUrl,
      'faviconUrl': instance.faviconUrl,
      'fontFamily': instance.fontFamily,
      'customStyles': instance.customStyles,
    };
