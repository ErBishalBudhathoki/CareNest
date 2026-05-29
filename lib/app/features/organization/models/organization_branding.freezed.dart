// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'organization_branding.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrganizationBranding {

 String get organizationId; String get primaryColor; String get secondaryColor; String? get logoUrl; InvoiceTemplate? get invoiceTemplate;
/// Create a copy of OrganizationBranding
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrganizationBrandingCopyWith<OrganizationBranding> get copyWith => _$OrganizationBrandingCopyWithImpl<OrganizationBranding>(this as OrganizationBranding, _$identity);

  /// Serializes this OrganizationBranding to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrganizationBranding&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.primaryColor, primaryColor) || other.primaryColor == primaryColor)&&(identical(other.secondaryColor, secondaryColor) || other.secondaryColor == secondaryColor)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.invoiceTemplate, invoiceTemplate) || other.invoiceTemplate == invoiceTemplate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,organizationId,primaryColor,secondaryColor,logoUrl,invoiceTemplate);

@override
String toString() {
  return 'OrganizationBranding(organizationId: $organizationId, primaryColor: $primaryColor, secondaryColor: $secondaryColor, logoUrl: $logoUrl, invoiceTemplate: $invoiceTemplate)';
}


}

/// @nodoc
abstract mixin class $OrganizationBrandingCopyWith<$Res>  {
  factory $OrganizationBrandingCopyWith(OrganizationBranding value, $Res Function(OrganizationBranding) _then) = _$OrganizationBrandingCopyWithImpl;
@useResult
$Res call({
 String organizationId, String primaryColor, String secondaryColor, String? logoUrl, InvoiceTemplate? invoiceTemplate
});


$InvoiceTemplateCopyWith<$Res>? get invoiceTemplate;

}
/// @nodoc
class _$OrganizationBrandingCopyWithImpl<$Res>
    implements $OrganizationBrandingCopyWith<$Res> {
  _$OrganizationBrandingCopyWithImpl(this._self, this._then);

  final OrganizationBranding _self;
  final $Res Function(OrganizationBranding) _then;

/// Create a copy of OrganizationBranding
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? organizationId = null,Object? primaryColor = null,Object? secondaryColor = null,Object? logoUrl = freezed,Object? invoiceTemplate = freezed,}) {
  return _then(_self.copyWith(
organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,primaryColor: null == primaryColor ? _self.primaryColor : primaryColor // ignore: cast_nullable_to_non_nullable
as String,secondaryColor: null == secondaryColor ? _self.secondaryColor : secondaryColor // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,invoiceTemplate: freezed == invoiceTemplate ? _self.invoiceTemplate : invoiceTemplate // ignore: cast_nullable_to_non_nullable
as InvoiceTemplate?,
  ));
}
/// Create a copy of OrganizationBranding
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InvoiceTemplateCopyWith<$Res>? get invoiceTemplate {
    if (_self.invoiceTemplate == null) {
    return null;
  }

  return $InvoiceTemplateCopyWith<$Res>(_self.invoiceTemplate!, (value) {
    return _then(_self.copyWith(invoiceTemplate: value));
  });
}
}


/// Adds pattern-matching-related methods to [OrganizationBranding].
extension OrganizationBrandingPatterns on OrganizationBranding {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrganizationBranding value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrganizationBranding() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrganizationBranding value)  $default,){
final _that = this;
switch (_that) {
case _OrganizationBranding():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrganizationBranding value)?  $default,){
final _that = this;
switch (_that) {
case _OrganizationBranding() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String organizationId,  String primaryColor,  String secondaryColor,  String? logoUrl,  InvoiceTemplate? invoiceTemplate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrganizationBranding() when $default != null:
return $default(_that.organizationId,_that.primaryColor,_that.secondaryColor,_that.logoUrl,_that.invoiceTemplate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String organizationId,  String primaryColor,  String secondaryColor,  String? logoUrl,  InvoiceTemplate? invoiceTemplate)  $default,) {final _that = this;
switch (_that) {
case _OrganizationBranding():
return $default(_that.organizationId,_that.primaryColor,_that.secondaryColor,_that.logoUrl,_that.invoiceTemplate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String organizationId,  String primaryColor,  String secondaryColor,  String? logoUrl,  InvoiceTemplate? invoiceTemplate)?  $default,) {final _that = this;
switch (_that) {
case _OrganizationBranding() when $default != null:
return $default(_that.organizationId,_that.primaryColor,_that.secondaryColor,_that.logoUrl,_that.invoiceTemplate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrganizationBranding implements OrganizationBranding {
  const _OrganizationBranding({required this.organizationId, this.primaryColor = '#DC143C', this.secondaryColor = '#0066CC', this.logoUrl, this.invoiceTemplate});
  factory _OrganizationBranding.fromJson(Map<String, dynamic> json) => _$OrganizationBrandingFromJson(json);

@override final  String organizationId;
@override@JsonKey() final  String primaryColor;
@override@JsonKey() final  String secondaryColor;
@override final  String? logoUrl;
@override final  InvoiceTemplate? invoiceTemplate;

/// Create a copy of OrganizationBranding
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrganizationBrandingCopyWith<_OrganizationBranding> get copyWith => __$OrganizationBrandingCopyWithImpl<_OrganizationBranding>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrganizationBrandingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrganizationBranding&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.primaryColor, primaryColor) || other.primaryColor == primaryColor)&&(identical(other.secondaryColor, secondaryColor) || other.secondaryColor == secondaryColor)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.invoiceTemplate, invoiceTemplate) || other.invoiceTemplate == invoiceTemplate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,organizationId,primaryColor,secondaryColor,logoUrl,invoiceTemplate);

@override
String toString() {
  return 'OrganizationBranding(organizationId: $organizationId, primaryColor: $primaryColor, secondaryColor: $secondaryColor, logoUrl: $logoUrl, invoiceTemplate: $invoiceTemplate)';
}


}

/// @nodoc
abstract mixin class _$OrganizationBrandingCopyWith<$Res> implements $OrganizationBrandingCopyWith<$Res> {
  factory _$OrganizationBrandingCopyWith(_OrganizationBranding value, $Res Function(_OrganizationBranding) _then) = __$OrganizationBrandingCopyWithImpl;
@override @useResult
$Res call({
 String organizationId, String primaryColor, String secondaryColor, String? logoUrl, InvoiceTemplate? invoiceTemplate
});


@override $InvoiceTemplateCopyWith<$Res>? get invoiceTemplate;

}
/// @nodoc
class __$OrganizationBrandingCopyWithImpl<$Res>
    implements _$OrganizationBrandingCopyWith<$Res> {
  __$OrganizationBrandingCopyWithImpl(this._self, this._then);

  final _OrganizationBranding _self;
  final $Res Function(_OrganizationBranding) _then;

/// Create a copy of OrganizationBranding
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? organizationId = null,Object? primaryColor = null,Object? secondaryColor = null,Object? logoUrl = freezed,Object? invoiceTemplate = freezed,}) {
  return _then(_OrganizationBranding(
organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,primaryColor: null == primaryColor ? _self.primaryColor : primaryColor // ignore: cast_nullable_to_non_nullable
as String,secondaryColor: null == secondaryColor ? _self.secondaryColor : secondaryColor // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,invoiceTemplate: freezed == invoiceTemplate ? _self.invoiceTemplate : invoiceTemplate // ignore: cast_nullable_to_non_nullable
as InvoiceTemplate?,
  ));
}

/// Create a copy of OrganizationBranding
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InvoiceTemplateCopyWith<$Res>? get invoiceTemplate {
    if (_self.invoiceTemplate == null) {
    return null;
  }

  return $InvoiceTemplateCopyWith<$Res>(_self.invoiceTemplate!, (value) {
    return _then(_self.copyWith(invoiceTemplate: value));
  });
}
}


/// @nodoc
mixin _$InvoiceTemplate {

 String? get headerText; String? get footerText; bool get showLogo;
/// Create a copy of InvoiceTemplate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvoiceTemplateCopyWith<InvoiceTemplate> get copyWith => _$InvoiceTemplateCopyWithImpl<InvoiceTemplate>(this as InvoiceTemplate, _$identity);

  /// Serializes this InvoiceTemplate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvoiceTemplate&&(identical(other.headerText, headerText) || other.headerText == headerText)&&(identical(other.footerText, footerText) || other.footerText == footerText)&&(identical(other.showLogo, showLogo) || other.showLogo == showLogo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,headerText,footerText,showLogo);

@override
String toString() {
  return 'InvoiceTemplate(headerText: $headerText, footerText: $footerText, showLogo: $showLogo)';
}


}

/// @nodoc
abstract mixin class $InvoiceTemplateCopyWith<$Res>  {
  factory $InvoiceTemplateCopyWith(InvoiceTemplate value, $Res Function(InvoiceTemplate) _then) = _$InvoiceTemplateCopyWithImpl;
@useResult
$Res call({
 String? headerText, String? footerText, bool showLogo
});




}
/// @nodoc
class _$InvoiceTemplateCopyWithImpl<$Res>
    implements $InvoiceTemplateCopyWith<$Res> {
  _$InvoiceTemplateCopyWithImpl(this._self, this._then);

  final InvoiceTemplate _self;
  final $Res Function(InvoiceTemplate) _then;

/// Create a copy of InvoiceTemplate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? headerText = freezed,Object? footerText = freezed,Object? showLogo = null,}) {
  return _then(_self.copyWith(
headerText: freezed == headerText ? _self.headerText : headerText // ignore: cast_nullable_to_non_nullable
as String?,footerText: freezed == footerText ? _self.footerText : footerText // ignore: cast_nullable_to_non_nullable
as String?,showLogo: null == showLogo ? _self.showLogo : showLogo // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [InvoiceTemplate].
extension InvoiceTemplatePatterns on InvoiceTemplate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InvoiceTemplate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InvoiceTemplate() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InvoiceTemplate value)  $default,){
final _that = this;
switch (_that) {
case _InvoiceTemplate():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InvoiceTemplate value)?  $default,){
final _that = this;
switch (_that) {
case _InvoiceTemplate() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? headerText,  String? footerText,  bool showLogo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InvoiceTemplate() when $default != null:
return $default(_that.headerText,_that.footerText,_that.showLogo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? headerText,  String? footerText,  bool showLogo)  $default,) {final _that = this;
switch (_that) {
case _InvoiceTemplate():
return $default(_that.headerText,_that.footerText,_that.showLogo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? headerText,  String? footerText,  bool showLogo)?  $default,) {final _that = this;
switch (_that) {
case _InvoiceTemplate() when $default != null:
return $default(_that.headerText,_that.footerText,_that.showLogo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InvoiceTemplate implements InvoiceTemplate {
  const _InvoiceTemplate({this.headerText, this.footerText, this.showLogo = true});
  factory _InvoiceTemplate.fromJson(Map<String, dynamic> json) => _$InvoiceTemplateFromJson(json);

@override final  String? headerText;
@override final  String? footerText;
@override@JsonKey() final  bool showLogo;

/// Create a copy of InvoiceTemplate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InvoiceTemplateCopyWith<_InvoiceTemplate> get copyWith => __$InvoiceTemplateCopyWithImpl<_InvoiceTemplate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InvoiceTemplateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvoiceTemplate&&(identical(other.headerText, headerText) || other.headerText == headerText)&&(identical(other.footerText, footerText) || other.footerText == footerText)&&(identical(other.showLogo, showLogo) || other.showLogo == showLogo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,headerText,footerText,showLogo);

@override
String toString() {
  return 'InvoiceTemplate(headerText: $headerText, footerText: $footerText, showLogo: $showLogo)';
}


}

/// @nodoc
abstract mixin class _$InvoiceTemplateCopyWith<$Res> implements $InvoiceTemplateCopyWith<$Res> {
  factory _$InvoiceTemplateCopyWith(_InvoiceTemplate value, $Res Function(_InvoiceTemplate) _then) = __$InvoiceTemplateCopyWithImpl;
@override @useResult
$Res call({
 String? headerText, String? footerText, bool showLogo
});




}
/// @nodoc
class __$InvoiceTemplateCopyWithImpl<$Res>
    implements _$InvoiceTemplateCopyWith<$Res> {
  __$InvoiceTemplateCopyWithImpl(this._self, this._then);

  final _InvoiceTemplate _self;
  final $Res Function(_InvoiceTemplate) _then;

/// Create a copy of InvoiceTemplate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? headerText = freezed,Object? footerText = freezed,Object? showLogo = null,}) {
  return _then(_InvoiceTemplate(
headerText: freezed == headerText ? _self.headerText : headerText // ignore: cast_nullable_to_non_nullable
as String?,footerText: freezed == footerText ? _self.footerText : footerText // ignore: cast_nullable_to_non_nullable
as String?,showLogo: null == showLogo ? _self.showLogo : showLogo // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
