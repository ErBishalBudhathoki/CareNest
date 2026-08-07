import 'package:freezed_annotation/freezed_annotation.dart';

part 'organization_integrations.freezed.dart';
part 'organization_integrations.g.dart';

/// Individual integration configuration
@freezed
abstract class IntegrationConfig with _$IntegrationConfig {
  const factory IntegrationConfig({
    @Default(false) bool isConnected,
    String? apiKey,
    String? accessToken,
    String? refreshToken,
    DateTime? connectedAt,
    DateTime? lastSyncAt,
    Map<String, dynamic>? metadata,
  }) = _IntegrationConfig;

  factory IntegrationConfig.fromJson(Map<String, dynamic> json) =>
      _$IntegrationConfigFromJson(json);
}

/// Organization integrations container
@freezed
abstract class OrganizationIntegrations with _$OrganizationIntegrations {
  const factory OrganizationIntegrations({
    // Accounting
    IntegrationConfig? xero,
    IntegrationConfig? myob,
    IntegrationConfig? quickbooks,

    // Calendar
    IntegrationConfig? googleCalendar,
    IntegrationConfig? outlookCalendar,
    IntegrationConfig? appleCalendar,

    // Communication
    IntegrationConfig? slack,
    IntegrationConfig? teams,
    IntegrationConfig? discord,

    // Payment
    IntegrationConfig? stripe,
    IntegrationConfig? paypal,
    IntegrationConfig? square,

    // CRM
    IntegrationConfig? salesforce,
    IntegrationConfig? hubspot,

    // Other
    IntegrationConfig? zapier,
    IntegrationConfig? webhooks,
  }) = _OrganizationIntegrations;

  factory OrganizationIntegrations.fromJson(Map<String, dynamic> json) =>
      _$OrganizationIntegrationsFromJson(json);

  /// Helper to convert from generic Map (for backward compatibility)
  static OrganizationIntegrations fromMap(Map<String, dynamic>? map) {
    if (map == null) return const OrganizationIntegrations();

    IntegrationConfig? parseConfig(dynamic value) {
      if (value == null) return null;
      if (value is Map<String, dynamic>) {
        return IntegrationConfig.fromJson(value);
      }
      // Handle simple boolean format
      if (value is bool) {
        return IntegrationConfig(isConnected: value);
      }
      return null;
    }

    return OrganizationIntegrations(
      xero: parseConfig(map['xero']),
      myob: parseConfig(map['myob']),
      quickbooks: parseConfig(map['quickbooks']),
      googleCalendar: parseConfig(map['googleCalendar']),
      outlookCalendar: parseConfig(map['outlookCalendar']),
      appleCalendar: parseConfig(map['appleCalendar']),
      slack: parseConfig(map['slack']),
      teams: parseConfig(map['teams']),
      discord: parseConfig(map['discord']),
      stripe: parseConfig(map['stripe']),
      paypal: parseConfig(map['paypal']),
      square: parseConfig(map['square']),
      salesforce: parseConfig(map['salesforce']),
      hubspot: parseConfig(map['hubspot']),
      zapier: parseConfig(map['zapier']),
      webhooks: parseConfig(map['webhooks']),
    );
  }
}

/// Organization branding configuration
@freezed
abstract class OrganizationBrandingConfig with _$OrganizationBrandingConfig {
  const factory OrganizationBrandingConfig({
    String? primaryColor,
    String? secondaryColor,
    String? accentColor,
    String? logoUrl,
    String? faviconUrl,
    String? fontFamily,
    Map<String, dynamic>? customStyles,
  }) = _OrganizationBrandingConfig;

  factory OrganizationBrandingConfig.fromJson(Map<String, dynamic> json) =>
      _$OrganizationBrandingConfigFromJson(json);

  /// Helper to convert from generic Map (for backward compatibility)
  static OrganizationBrandingConfig fromMap(Map<String, dynamic>? map) {
    if (map == null) return const OrganizationBrandingConfig();
    return OrganizationBrandingConfig.fromJson(map);
  }
}
