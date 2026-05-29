// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'certification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Certification {

@JsonKey(name: '_id') String? get id; String get userId; String get name; String get issuer; String? get certificationNumber; String? get requirementId; String get fileUrl; String get status; DateTime get expiryDate; DateTime get uploadedAt; String? get auditedBy; DateTime? get auditDate; String? get notes;
/// Create a copy of Certification
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CertificationCopyWith<Certification> get copyWith => _$CertificationCopyWithImpl<Certification>(this as Certification, _$identity);

  /// Serializes this Certification to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Certification&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.issuer, issuer) || other.issuer == issuer)&&(identical(other.certificationNumber, certificationNumber) || other.certificationNumber == certificationNumber)&&(identical(other.requirementId, requirementId) || other.requirementId == requirementId)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.uploadedAt, uploadedAt) || other.uploadedAt == uploadedAt)&&(identical(other.auditedBy, auditedBy) || other.auditedBy == auditedBy)&&(identical(other.auditDate, auditDate) || other.auditDate == auditDate)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,name,issuer,certificationNumber,requirementId,fileUrl,status,expiryDate,uploadedAt,auditedBy,auditDate,notes);

@override
String toString() {
  return 'Certification(id: $id, userId: $userId, name: $name, issuer: $issuer, certificationNumber: $certificationNumber, requirementId: $requirementId, fileUrl: $fileUrl, status: $status, expiryDate: $expiryDate, uploadedAt: $uploadedAt, auditedBy: $auditedBy, auditDate: $auditDate, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $CertificationCopyWith<$Res>  {
  factory $CertificationCopyWith(Certification value, $Res Function(Certification) _then) = _$CertificationCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: '_id') String? id, String userId, String name, String issuer, String? certificationNumber, String? requirementId, String fileUrl, String status, DateTime expiryDate, DateTime uploadedAt, String? auditedBy, DateTime? auditDate, String? notes
});




}
/// @nodoc
class _$CertificationCopyWithImpl<$Res>
    implements $CertificationCopyWith<$Res> {
  _$CertificationCopyWithImpl(this._self, this._then);

  final Certification _self;
  final $Res Function(Certification) _then;

/// Create a copy of Certification
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? userId = null,Object? name = null,Object? issuer = null,Object? certificationNumber = freezed,Object? requirementId = freezed,Object? fileUrl = null,Object? status = null,Object? expiryDate = null,Object? uploadedAt = null,Object? auditedBy = freezed,Object? auditDate = freezed,Object? notes = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,issuer: null == issuer ? _self.issuer : issuer // ignore: cast_nullable_to_non_nullable
as String,certificationNumber: freezed == certificationNumber ? _self.certificationNumber : certificationNumber // ignore: cast_nullable_to_non_nullable
as String?,requirementId: freezed == requirementId ? _self.requirementId : requirementId // ignore: cast_nullable_to_non_nullable
as String?,fileUrl: null == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,expiryDate: null == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime,uploadedAt: null == uploadedAt ? _self.uploadedAt : uploadedAt // ignore: cast_nullable_to_non_nullable
as DateTime,auditedBy: freezed == auditedBy ? _self.auditedBy : auditedBy // ignore: cast_nullable_to_non_nullable
as String?,auditDate: freezed == auditDate ? _self.auditDate : auditDate // ignore: cast_nullable_to_non_nullable
as DateTime?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Certification].
extension CertificationPatterns on Certification {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Certification value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Certification() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Certification value)  $default,){
final _that = this;
switch (_that) {
case _Certification():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Certification value)?  $default,){
final _that = this;
switch (_that) {
case _Certification() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String? id,  String userId,  String name,  String issuer,  String? certificationNumber,  String? requirementId,  String fileUrl,  String status,  DateTime expiryDate,  DateTime uploadedAt,  String? auditedBy,  DateTime? auditDate,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Certification() when $default != null:
return $default(_that.id,_that.userId,_that.name,_that.issuer,_that.certificationNumber,_that.requirementId,_that.fileUrl,_that.status,_that.expiryDate,_that.uploadedAt,_that.auditedBy,_that.auditDate,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String? id,  String userId,  String name,  String issuer,  String? certificationNumber,  String? requirementId,  String fileUrl,  String status,  DateTime expiryDate,  DateTime uploadedAt,  String? auditedBy,  DateTime? auditDate,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _Certification():
return $default(_that.id,_that.userId,_that.name,_that.issuer,_that.certificationNumber,_that.requirementId,_that.fileUrl,_that.status,_that.expiryDate,_that.uploadedAt,_that.auditedBy,_that.auditDate,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: '_id')  String? id,  String userId,  String name,  String issuer,  String? certificationNumber,  String? requirementId,  String fileUrl,  String status,  DateTime expiryDate,  DateTime uploadedAt,  String? auditedBy,  DateTime? auditDate,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _Certification() when $default != null:
return $default(_that.id,_that.userId,_that.name,_that.issuer,_that.certificationNumber,_that.requirementId,_that.fileUrl,_that.status,_that.expiryDate,_that.uploadedAt,_that.auditedBy,_that.auditDate,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Certification implements Certification {
  const _Certification({@JsonKey(name: '_id') this.id, required this.userId, required this.name, required this.issuer, this.certificationNumber, this.requirementId, required this.fileUrl, this.status = 'Pending', required this.expiryDate, required this.uploadedAt, this.auditedBy, this.auditDate, this.notes});
  factory _Certification.fromJson(Map<String, dynamic> json) => _$CertificationFromJson(json);

@override@JsonKey(name: '_id') final  String? id;
@override final  String userId;
@override final  String name;
@override final  String issuer;
@override final  String? certificationNumber;
@override final  String? requirementId;
@override final  String fileUrl;
@override@JsonKey() final  String status;
@override final  DateTime expiryDate;
@override final  DateTime uploadedAt;
@override final  String? auditedBy;
@override final  DateTime? auditDate;
@override final  String? notes;

/// Create a copy of Certification
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CertificationCopyWith<_Certification> get copyWith => __$CertificationCopyWithImpl<_Certification>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CertificationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Certification&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.issuer, issuer) || other.issuer == issuer)&&(identical(other.certificationNumber, certificationNumber) || other.certificationNumber == certificationNumber)&&(identical(other.requirementId, requirementId) || other.requirementId == requirementId)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.uploadedAt, uploadedAt) || other.uploadedAt == uploadedAt)&&(identical(other.auditedBy, auditedBy) || other.auditedBy == auditedBy)&&(identical(other.auditDate, auditDate) || other.auditDate == auditDate)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,name,issuer,certificationNumber,requirementId,fileUrl,status,expiryDate,uploadedAt,auditedBy,auditDate,notes);

@override
String toString() {
  return 'Certification(id: $id, userId: $userId, name: $name, issuer: $issuer, certificationNumber: $certificationNumber, requirementId: $requirementId, fileUrl: $fileUrl, status: $status, expiryDate: $expiryDate, uploadedAt: $uploadedAt, auditedBy: $auditedBy, auditDate: $auditDate, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$CertificationCopyWith<$Res> implements $CertificationCopyWith<$Res> {
  factory _$CertificationCopyWith(_Certification value, $Res Function(_Certification) _then) = __$CertificationCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: '_id') String? id, String userId, String name, String issuer, String? certificationNumber, String? requirementId, String fileUrl, String status, DateTime expiryDate, DateTime uploadedAt, String? auditedBy, DateTime? auditDate, String? notes
});




}
/// @nodoc
class __$CertificationCopyWithImpl<$Res>
    implements _$CertificationCopyWith<$Res> {
  __$CertificationCopyWithImpl(this._self, this._then);

  final _Certification _self;
  final $Res Function(_Certification) _then;

/// Create a copy of Certification
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? userId = null,Object? name = null,Object? issuer = null,Object? certificationNumber = freezed,Object? requirementId = freezed,Object? fileUrl = null,Object? status = null,Object? expiryDate = null,Object? uploadedAt = null,Object? auditedBy = freezed,Object? auditDate = freezed,Object? notes = freezed,}) {
  return _then(_Certification(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,issuer: null == issuer ? _self.issuer : issuer // ignore: cast_nullable_to_non_nullable
as String,certificationNumber: freezed == certificationNumber ? _self.certificationNumber : certificationNumber // ignore: cast_nullable_to_non_nullable
as String?,requirementId: freezed == requirementId ? _self.requirementId : requirementId // ignore: cast_nullable_to_non_nullable
as String?,fileUrl: null == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,expiryDate: null == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime,uploadedAt: null == uploadedAt ? _self.uploadedAt : uploadedAt // ignore: cast_nullable_to_non_nullable
as DateTime,auditedBy: freezed == auditedBy ? _self.auditedBy : auditedBy // ignore: cast_nullable_to_non_nullable
as String?,auditDate: freezed == auditDate ? _self.auditDate : auditDate // ignore: cast_nullable_to_non_nullable
as DateTime?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
