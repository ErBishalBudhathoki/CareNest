import 'package:freezed_annotation/freezed_annotation.dart';

part 'organization_branding.freezed.dart';
part 'organization_branding.g.dart';

@freezed
class OrganizationBranding with _$OrganizationBranding {
  const factory OrganizationBranding({
    required String organizationId,
    @Default('#DC143C') String primaryColor,
    @Default('#0066CC') String secondaryColor,
    String? logoUrl,
    InvoiceTemplate? invoiceTemplate,
  }) = _OrganizationBranding;

  factory OrganizationBranding.fromJson(Map<String, dynamic> json) =>
      _$OrganizationBrandingFromJson(json);

  factory OrganizationBranding.fromBackend(Map<String, dynamic> json) {
    return OrganizationBranding(
      organizationId: json['organizationId']?.toString() ?? '',
      primaryColor: json['primaryColor']?.toString() ?? '#DC143C',
      secondaryColor: json['secondaryColor']?.toString() ?? '#0066CC',
      logoUrl: json['logoUrl']?.toString(),
      invoiceTemplate: json['invoiceTemplate'] != null
          ? InvoiceTemplate.fromJson(
              json['invoiceTemplate'] as Map<String, dynamic>)
          : null,
    );
  }
}

@freezed
class InvoiceTemplate with _$InvoiceTemplate {
  const factory InvoiceTemplate({
    String? headerText,
    String? footerText,
    @Default(true) bool showLogo,
  }) = _InvoiceTemplate;

  factory InvoiceTemplate.fromJson(Map<String, dynamic> json) =>
      _$InvoiceTemplateFromJson(json);
}
