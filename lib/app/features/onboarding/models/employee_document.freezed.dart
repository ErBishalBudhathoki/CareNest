// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'employee_document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EmployeeDocument {

@JsonKey(name: '_id') String? get id; String get userId; String get organizationId; String get type; String? get documentNumber; String get fileUrl; DateTime? get expiryDate; String get status; String? get rejectionReason; DateTime? get uploadedAt; DateTime? get verifiedAt; String? get verifiedBy;
/// Create a copy of EmployeeDocument
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmployeeDocumentCopyWith<EmployeeDocument> get copyWith => _$EmployeeDocumentCopyWithImpl<EmployeeDocument>(this as EmployeeDocument, _$identity);

  /// Serializes this EmployeeDocument to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmployeeDocument&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.type, type) || other.type == type)&&(identical(other.documentNumber, documentNumber) || other.documentNumber == documentNumber)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.uploadedAt, uploadedAt) || other.uploadedAt == uploadedAt)&&(identical(other.verifiedAt, verifiedAt) || other.verifiedAt == verifiedAt)&&(identical(other.verifiedBy, verifiedBy) || other.verifiedBy == verifiedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,organizationId,type,documentNumber,fileUrl,expiryDate,status,rejectionReason,uploadedAt,verifiedAt,verifiedBy);

@override
String toString() {
  return 'EmployeeDocument(id: $id, userId: $userId, organizationId: $organizationId, type: $type, documentNumber: $documentNumber, fileUrl: $fileUrl, expiryDate: $expiryDate, status: $status, rejectionReason: $rejectionReason, uploadedAt: $uploadedAt, verifiedAt: $verifiedAt, verifiedBy: $verifiedBy)';
}


}

/// @nodoc
abstract mixin class $EmployeeDocumentCopyWith<$Res>  {
  factory $EmployeeDocumentCopyWith(EmployeeDocument value, $Res Function(EmployeeDocument) _then) = _$EmployeeDocumentCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: '_id') String? id, String userId, String organizationId, String type, String? documentNumber, String fileUrl, DateTime? expiryDate, String status, String? rejectionReason, DateTime? uploadedAt, DateTime? verifiedAt, String? verifiedBy
});




}
/// @nodoc
class _$EmployeeDocumentCopyWithImpl<$Res>
    implements $EmployeeDocumentCopyWith<$Res> {
  _$EmployeeDocumentCopyWithImpl(this._self, this._then);

  final EmployeeDocument _self;
  final $Res Function(EmployeeDocument) _then;

/// Create a copy of EmployeeDocument
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? userId = null,Object? organizationId = null,Object? type = null,Object? documentNumber = freezed,Object? fileUrl = null,Object? expiryDate = freezed,Object? status = null,Object? rejectionReason = freezed,Object? uploadedAt = freezed,Object? verifiedAt = freezed,Object? verifiedBy = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,documentNumber: freezed == documentNumber ? _self.documentNumber : documentNumber // ignore: cast_nullable_to_non_nullable
as String?,fileUrl: null == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String,expiryDate: freezed == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,uploadedAt: freezed == uploadedAt ? _self.uploadedAt : uploadedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,verifiedAt: freezed == verifiedAt ? _self.verifiedAt : verifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,verifiedBy: freezed == verifiedBy ? _self.verifiedBy : verifiedBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EmployeeDocument].
extension EmployeeDocumentPatterns on EmployeeDocument {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmployeeDocument value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmployeeDocument() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmployeeDocument value)  $default,){
final _that = this;
switch (_that) {
case _EmployeeDocument():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmployeeDocument value)?  $default,){
final _that = this;
switch (_that) {
case _EmployeeDocument() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String? id,  String userId,  String organizationId,  String type,  String? documentNumber,  String fileUrl,  DateTime? expiryDate,  String status,  String? rejectionReason,  DateTime? uploadedAt,  DateTime? verifiedAt,  String? verifiedBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmployeeDocument() when $default != null:
return $default(_that.id,_that.userId,_that.organizationId,_that.type,_that.documentNumber,_that.fileUrl,_that.expiryDate,_that.status,_that.rejectionReason,_that.uploadedAt,_that.verifiedAt,_that.verifiedBy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String? id,  String userId,  String organizationId,  String type,  String? documentNumber,  String fileUrl,  DateTime? expiryDate,  String status,  String? rejectionReason,  DateTime? uploadedAt,  DateTime? verifiedAt,  String? verifiedBy)  $default,) {final _that = this;
switch (_that) {
case _EmployeeDocument():
return $default(_that.id,_that.userId,_that.organizationId,_that.type,_that.documentNumber,_that.fileUrl,_that.expiryDate,_that.status,_that.rejectionReason,_that.uploadedAt,_that.verifiedAt,_that.verifiedBy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: '_id')  String? id,  String userId,  String organizationId,  String type,  String? documentNumber,  String fileUrl,  DateTime? expiryDate,  String status,  String? rejectionReason,  DateTime? uploadedAt,  DateTime? verifiedAt,  String? verifiedBy)?  $default,) {final _that = this;
switch (_that) {
case _EmployeeDocument() when $default != null:
return $default(_that.id,_that.userId,_that.organizationId,_that.type,_that.documentNumber,_that.fileUrl,_that.expiryDate,_that.status,_that.rejectionReason,_that.uploadedAt,_that.verifiedAt,_that.verifiedBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EmployeeDocument implements EmployeeDocument {
  const _EmployeeDocument({@JsonKey(name: '_id') this.id, required this.userId, required this.organizationId, required this.type, this.documentNumber, required this.fileUrl, this.expiryDate, required this.status, this.rejectionReason, this.uploadedAt, this.verifiedAt, this.verifiedBy});
  factory _EmployeeDocument.fromJson(Map<String, dynamic> json) => _$EmployeeDocumentFromJson(json);

@override@JsonKey(name: '_id') final  String? id;
@override final  String userId;
@override final  String organizationId;
@override final  String type;
@override final  String? documentNumber;
@override final  String fileUrl;
@override final  DateTime? expiryDate;
@override final  String status;
@override final  String? rejectionReason;
@override final  DateTime? uploadedAt;
@override final  DateTime? verifiedAt;
@override final  String? verifiedBy;

/// Create a copy of EmployeeDocument
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmployeeDocumentCopyWith<_EmployeeDocument> get copyWith => __$EmployeeDocumentCopyWithImpl<_EmployeeDocument>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmployeeDocumentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmployeeDocument&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.type, type) || other.type == type)&&(identical(other.documentNumber, documentNumber) || other.documentNumber == documentNumber)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.uploadedAt, uploadedAt) || other.uploadedAt == uploadedAt)&&(identical(other.verifiedAt, verifiedAt) || other.verifiedAt == verifiedAt)&&(identical(other.verifiedBy, verifiedBy) || other.verifiedBy == verifiedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,organizationId,type,documentNumber,fileUrl,expiryDate,status,rejectionReason,uploadedAt,verifiedAt,verifiedBy);

@override
String toString() {
  return 'EmployeeDocument(id: $id, userId: $userId, organizationId: $organizationId, type: $type, documentNumber: $documentNumber, fileUrl: $fileUrl, expiryDate: $expiryDate, status: $status, rejectionReason: $rejectionReason, uploadedAt: $uploadedAt, verifiedAt: $verifiedAt, verifiedBy: $verifiedBy)';
}


}

/// @nodoc
abstract mixin class _$EmployeeDocumentCopyWith<$Res> implements $EmployeeDocumentCopyWith<$Res> {
  factory _$EmployeeDocumentCopyWith(_EmployeeDocument value, $Res Function(_EmployeeDocument) _then) = __$EmployeeDocumentCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: '_id') String? id, String userId, String organizationId, String type, String? documentNumber, String fileUrl, DateTime? expiryDate, String status, String? rejectionReason, DateTime? uploadedAt, DateTime? verifiedAt, String? verifiedBy
});




}
/// @nodoc
class __$EmployeeDocumentCopyWithImpl<$Res>
    implements _$EmployeeDocumentCopyWith<$Res> {
  __$EmployeeDocumentCopyWithImpl(this._self, this._then);

  final _EmployeeDocument _self;
  final $Res Function(_EmployeeDocument) _then;

/// Create a copy of EmployeeDocument
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? userId = null,Object? organizationId = null,Object? type = null,Object? documentNumber = freezed,Object? fileUrl = null,Object? expiryDate = freezed,Object? status = null,Object? rejectionReason = freezed,Object? uploadedAt = freezed,Object? verifiedAt = freezed,Object? verifiedBy = freezed,}) {
  return _then(_EmployeeDocument(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,documentNumber: freezed == documentNumber ? _self.documentNumber : documentNumber // ignore: cast_nullable_to_non_nullable
as String?,fileUrl: null == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String,expiryDate: freezed == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,uploadedAt: freezed == uploadedAt ? _self.uploadedAt : uploadedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,verifiedAt: freezed == verifiedAt ? _self.verifiedAt : verifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,verifiedBy: freezed == verifiedBy ? _self.verifiedBy : verifiedBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
