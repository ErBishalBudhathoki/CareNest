// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'organization_branding.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrganizationBranding _$OrganizationBrandingFromJson(Map<String, dynamic> json) {
  return _OrganizationBranding.fromJson(json);
}

/// @nodoc
mixin _$OrganizationBranding {
  String get organizationId => throw _privateConstructorUsedError;
  String get primaryColor => throw _privateConstructorUsedError;
  String get secondaryColor => throw _privateConstructorUsedError;
  String? get logoUrl => throw _privateConstructorUsedError;
  InvoiceTemplate? get invoiceTemplate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrganizationBrandingCopyWith<OrganizationBranding> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrganizationBrandingCopyWith<$Res> {
  factory $OrganizationBrandingCopyWith(OrganizationBranding value,
          $Res Function(OrganizationBranding) then) =
      _$OrganizationBrandingCopyWithImpl<$Res, OrganizationBranding>;
  @useResult
  $Res call(
      {String organizationId,
      String primaryColor,
      String secondaryColor,
      String? logoUrl,
      InvoiceTemplate? invoiceTemplate});

  $InvoiceTemplateCopyWith<$Res>? get invoiceTemplate;
}

/// @nodoc
class _$OrganizationBrandingCopyWithImpl<$Res,
        $Val extends OrganizationBranding>
    implements $OrganizationBrandingCopyWith<$Res> {
  _$OrganizationBrandingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organizationId = null,
    Object? primaryColor = null,
    Object? secondaryColor = null,
    Object? logoUrl = freezed,
    Object? invoiceTemplate = freezed,
  }) {
    return _then(_value.copyWith(
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      primaryColor: null == primaryColor
          ? _value.primaryColor
          : primaryColor // ignore: cast_nullable_to_non_nullable
              as String,
      secondaryColor: null == secondaryColor
          ? _value.secondaryColor
          : secondaryColor // ignore: cast_nullable_to_non_nullable
              as String,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      invoiceTemplate: freezed == invoiceTemplate
          ? _value.invoiceTemplate
          : invoiceTemplate // ignore: cast_nullable_to_non_nullable
              as InvoiceTemplate?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $InvoiceTemplateCopyWith<$Res>? get invoiceTemplate {
    if (_value.invoiceTemplate == null) {
      return null;
    }

    return $InvoiceTemplateCopyWith<$Res>(_value.invoiceTemplate!, (value) {
      return _then(_value.copyWith(invoiceTemplate: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrganizationBrandingImplCopyWith<$Res>
    implements $OrganizationBrandingCopyWith<$Res> {
  factory _$$OrganizationBrandingImplCopyWith(_$OrganizationBrandingImpl value,
          $Res Function(_$OrganizationBrandingImpl) then) =
      __$$OrganizationBrandingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String organizationId,
      String primaryColor,
      String secondaryColor,
      String? logoUrl,
      InvoiceTemplate? invoiceTemplate});

  @override
  $InvoiceTemplateCopyWith<$Res>? get invoiceTemplate;
}

/// @nodoc
class __$$OrganizationBrandingImplCopyWithImpl<$Res>
    extends _$OrganizationBrandingCopyWithImpl<$Res, _$OrganizationBrandingImpl>
    implements _$$OrganizationBrandingImplCopyWith<$Res> {
  __$$OrganizationBrandingImplCopyWithImpl(_$OrganizationBrandingImpl _value,
      $Res Function(_$OrganizationBrandingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organizationId = null,
    Object? primaryColor = null,
    Object? secondaryColor = null,
    Object? logoUrl = freezed,
    Object? invoiceTemplate = freezed,
  }) {
    return _then(_$OrganizationBrandingImpl(
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      primaryColor: null == primaryColor
          ? _value.primaryColor
          : primaryColor // ignore: cast_nullable_to_non_nullable
              as String,
      secondaryColor: null == secondaryColor
          ? _value.secondaryColor
          : secondaryColor // ignore: cast_nullable_to_non_nullable
              as String,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      invoiceTemplate: freezed == invoiceTemplate
          ? _value.invoiceTemplate
          : invoiceTemplate // ignore: cast_nullable_to_non_nullable
              as InvoiceTemplate?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrganizationBrandingImpl implements _OrganizationBranding {
  const _$OrganizationBrandingImpl(
      {required this.organizationId,
      this.primaryColor = '#DC143C',
      this.secondaryColor = '#0066CC',
      this.logoUrl,
      this.invoiceTemplate});

  factory _$OrganizationBrandingImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrganizationBrandingImplFromJson(json);

  @override
  final String organizationId;
  @override
  @JsonKey()
  final String primaryColor;
  @override
  @JsonKey()
  final String secondaryColor;
  @override
  final String? logoUrl;
  @override
  final InvoiceTemplate? invoiceTemplate;

  @override
  String toString() {
    return 'OrganizationBranding(organizationId: $organizationId, primaryColor: $primaryColor, secondaryColor: $secondaryColor, logoUrl: $logoUrl, invoiceTemplate: $invoiceTemplate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrganizationBrandingImpl &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.primaryColor, primaryColor) ||
                other.primaryColor == primaryColor) &&
            (identical(other.secondaryColor, secondaryColor) ||
                other.secondaryColor == secondaryColor) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.invoiceTemplate, invoiceTemplate) ||
                other.invoiceTemplate == invoiceTemplate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, organizationId, primaryColor,
      secondaryColor, logoUrl, invoiceTemplate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrganizationBrandingImplCopyWith<_$OrganizationBrandingImpl>
      get copyWith =>
          __$$OrganizationBrandingImplCopyWithImpl<_$OrganizationBrandingImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrganizationBrandingImplToJson(
      this,
    );
  }
}

abstract class _OrganizationBranding implements OrganizationBranding {
  const factory _OrganizationBranding(
      {required final String organizationId,
      final String primaryColor,
      final String secondaryColor,
      final String? logoUrl,
      final InvoiceTemplate? invoiceTemplate}) = _$OrganizationBrandingImpl;

  factory _OrganizationBranding.fromJson(Map<String, dynamic> json) =
      _$OrganizationBrandingImpl.fromJson;

  @override
  String get organizationId;
  @override
  String get primaryColor;
  @override
  String get secondaryColor;
  @override
  String? get logoUrl;
  @override
  InvoiceTemplate? get invoiceTemplate;
  @override
  @JsonKey(ignore: true)
  _$$OrganizationBrandingImplCopyWith<_$OrganizationBrandingImpl>
      get copyWith => throw _privateConstructorUsedError;
}

InvoiceTemplate _$InvoiceTemplateFromJson(Map<String, dynamic> json) {
  return _InvoiceTemplate.fromJson(json);
}

/// @nodoc
mixin _$InvoiceTemplate {
  String? get headerText => throw _privateConstructorUsedError;
  String? get footerText => throw _privateConstructorUsedError;
  bool get showLogo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InvoiceTemplateCopyWith<InvoiceTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoiceTemplateCopyWith<$Res> {
  factory $InvoiceTemplateCopyWith(
          InvoiceTemplate value, $Res Function(InvoiceTemplate) then) =
      _$InvoiceTemplateCopyWithImpl<$Res, InvoiceTemplate>;
  @useResult
  $Res call({String? headerText, String? footerText, bool showLogo});
}

/// @nodoc
class _$InvoiceTemplateCopyWithImpl<$Res, $Val extends InvoiceTemplate>
    implements $InvoiceTemplateCopyWith<$Res> {
  _$InvoiceTemplateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? headerText = freezed,
    Object? footerText = freezed,
    Object? showLogo = null,
  }) {
    return _then(_value.copyWith(
      headerText: freezed == headerText
          ? _value.headerText
          : headerText // ignore: cast_nullable_to_non_nullable
              as String?,
      footerText: freezed == footerText
          ? _value.footerText
          : footerText // ignore: cast_nullable_to_non_nullable
              as String?,
      showLogo: null == showLogo
          ? _value.showLogo
          : showLogo // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvoiceTemplateImplCopyWith<$Res>
    implements $InvoiceTemplateCopyWith<$Res> {
  factory _$$InvoiceTemplateImplCopyWith(_$InvoiceTemplateImpl value,
          $Res Function(_$InvoiceTemplateImpl) then) =
      __$$InvoiceTemplateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? headerText, String? footerText, bool showLogo});
}

/// @nodoc
class __$$InvoiceTemplateImplCopyWithImpl<$Res>
    extends _$InvoiceTemplateCopyWithImpl<$Res, _$InvoiceTemplateImpl>
    implements _$$InvoiceTemplateImplCopyWith<$Res> {
  __$$InvoiceTemplateImplCopyWithImpl(
      _$InvoiceTemplateImpl _value, $Res Function(_$InvoiceTemplateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? headerText = freezed,
    Object? footerText = freezed,
    Object? showLogo = null,
  }) {
    return _then(_$InvoiceTemplateImpl(
      headerText: freezed == headerText
          ? _value.headerText
          : headerText // ignore: cast_nullable_to_non_nullable
              as String?,
      footerText: freezed == footerText
          ? _value.footerText
          : footerText // ignore: cast_nullable_to_non_nullable
              as String?,
      showLogo: null == showLogo
          ? _value.showLogo
          : showLogo // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvoiceTemplateImpl implements _InvoiceTemplate {
  const _$InvoiceTemplateImpl(
      {this.headerText, this.footerText, this.showLogo = true});

  factory _$InvoiceTemplateImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvoiceTemplateImplFromJson(json);

  @override
  final String? headerText;
  @override
  final String? footerText;
  @override
  @JsonKey()
  final bool showLogo;

  @override
  String toString() {
    return 'InvoiceTemplate(headerText: $headerText, footerText: $footerText, showLogo: $showLogo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvoiceTemplateImpl &&
            (identical(other.headerText, headerText) ||
                other.headerText == headerText) &&
            (identical(other.footerText, footerText) ||
                other.footerText == footerText) &&
            (identical(other.showLogo, showLogo) ||
                other.showLogo == showLogo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, headerText, footerText, showLogo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InvoiceTemplateImplCopyWith<_$InvoiceTemplateImpl> get copyWith =>
      __$$InvoiceTemplateImplCopyWithImpl<_$InvoiceTemplateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvoiceTemplateImplToJson(
      this,
    );
  }
}

abstract class _InvoiceTemplate implements InvoiceTemplate {
  const factory _InvoiceTemplate(
      {final String? headerText,
      final String? footerText,
      final bool showLogo}) = _$InvoiceTemplateImpl;

  factory _InvoiceTemplate.fromJson(Map<String, dynamic> json) =
      _$InvoiceTemplateImpl.fromJson;

  @override
  String? get headerText;
  @override
  String? get footerText;
  @override
  bool get showLogo;
  @override
  @JsonKey(ignore: true)
  _$$InvoiceTemplateImplCopyWith<_$InvoiceTemplateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
