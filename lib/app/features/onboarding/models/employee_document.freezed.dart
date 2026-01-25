// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'employee_document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EmployeeDocument _$EmployeeDocumentFromJson(Map<String, dynamic> json) {
  return _EmployeeDocument.fromJson(json);
}

/// @nodoc
mixin _$EmployeeDocument {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String? get documentNumber => throw _privateConstructorUsedError;
  String get fileUrl => throw _privateConstructorUsedError;
  DateTime? get expiryDate => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get rejectionReason => throw _privateConstructorUsedError;
  DateTime? get uploadedAt => throw _privateConstructorUsedError;
  DateTime? get verifiedAt => throw _privateConstructorUsedError;
  String? get verifiedBy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmployeeDocumentCopyWith<EmployeeDocument> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeeDocumentCopyWith<$Res> {
  factory $EmployeeDocumentCopyWith(
          EmployeeDocument value, $Res Function(EmployeeDocument) then) =
      _$EmployeeDocumentCopyWithImpl<$Res, EmployeeDocument>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String userId,
      String organizationId,
      String type,
      String? documentNumber,
      String fileUrl,
      DateTime? expiryDate,
      String status,
      String? rejectionReason,
      DateTime? uploadedAt,
      DateTime? verifiedAt,
      String? verifiedBy});
}

/// @nodoc
class _$EmployeeDocumentCopyWithImpl<$Res, $Val extends EmployeeDocument>
    implements $EmployeeDocumentCopyWith<$Res> {
  _$EmployeeDocumentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = null,
    Object? organizationId = null,
    Object? type = null,
    Object? documentNumber = freezed,
    Object? fileUrl = null,
    Object? expiryDate = freezed,
    Object? status = null,
    Object? rejectionReason = freezed,
    Object? uploadedAt = freezed,
    Object? verifiedAt = freezed,
    Object? verifiedBy = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      documentNumber: freezed == documentNumber
          ? _value.documentNumber
          : documentNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      fileUrl: null == fileUrl
          ? _value.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      rejectionReason: freezed == rejectionReason
          ? _value.rejectionReason
          : rejectionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      uploadedAt: freezed == uploadedAt
          ? _value.uploadedAt
          : uploadedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      verifiedAt: freezed == verifiedAt
          ? _value.verifiedAt
          : verifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      verifiedBy: freezed == verifiedBy
          ? _value.verifiedBy
          : verifiedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmployeeDocumentImplCopyWith<$Res>
    implements $EmployeeDocumentCopyWith<$Res> {
  factory _$$EmployeeDocumentImplCopyWith(_$EmployeeDocumentImpl value,
          $Res Function(_$EmployeeDocumentImpl) then) =
      __$$EmployeeDocumentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String userId,
      String organizationId,
      String type,
      String? documentNumber,
      String fileUrl,
      DateTime? expiryDate,
      String status,
      String? rejectionReason,
      DateTime? uploadedAt,
      DateTime? verifiedAt,
      String? verifiedBy});
}

/// @nodoc
class __$$EmployeeDocumentImplCopyWithImpl<$Res>
    extends _$EmployeeDocumentCopyWithImpl<$Res, _$EmployeeDocumentImpl>
    implements _$$EmployeeDocumentImplCopyWith<$Res> {
  __$$EmployeeDocumentImplCopyWithImpl(_$EmployeeDocumentImpl _value,
      $Res Function(_$EmployeeDocumentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = null,
    Object? organizationId = null,
    Object? type = null,
    Object? documentNumber = freezed,
    Object? fileUrl = null,
    Object? expiryDate = freezed,
    Object? status = null,
    Object? rejectionReason = freezed,
    Object? uploadedAt = freezed,
    Object? verifiedAt = freezed,
    Object? verifiedBy = freezed,
  }) {
    return _then(_$EmployeeDocumentImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      documentNumber: freezed == documentNumber
          ? _value.documentNumber
          : documentNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      fileUrl: null == fileUrl
          ? _value.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      rejectionReason: freezed == rejectionReason
          ? _value.rejectionReason
          : rejectionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      uploadedAt: freezed == uploadedAt
          ? _value.uploadedAt
          : uploadedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      verifiedAt: freezed == verifiedAt
          ? _value.verifiedAt
          : verifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      verifiedBy: freezed == verifiedBy
          ? _value.verifiedBy
          : verifiedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmployeeDocumentImpl implements _EmployeeDocument {
  const _$EmployeeDocumentImpl(
      {@JsonKey(name: '_id') this.id,
      required this.userId,
      required this.organizationId,
      required this.type,
      this.documentNumber,
      required this.fileUrl,
      this.expiryDate,
      required this.status,
      this.rejectionReason,
      this.uploadedAt,
      this.verifiedAt,
      this.verifiedBy});

  factory _$EmployeeDocumentImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmployeeDocumentImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final String userId;
  @override
  final String organizationId;
  @override
  final String type;
  @override
  final String? documentNumber;
  @override
  final String fileUrl;
  @override
  final DateTime? expiryDate;
  @override
  final String status;
  @override
  final String? rejectionReason;
  @override
  final DateTime? uploadedAt;
  @override
  final DateTime? verifiedAt;
  @override
  final String? verifiedBy;

  @override
  String toString() {
    return 'EmployeeDocument(id: $id, userId: $userId, organizationId: $organizationId, type: $type, documentNumber: $documentNumber, fileUrl: $fileUrl, expiryDate: $expiryDate, status: $status, rejectionReason: $rejectionReason, uploadedAt: $uploadedAt, verifiedAt: $verifiedAt, verifiedBy: $verifiedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeDocumentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.documentNumber, documentNumber) ||
                other.documentNumber == documentNumber) &&
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.rejectionReason, rejectionReason) ||
                other.rejectionReason == rejectionReason) &&
            (identical(other.uploadedAt, uploadedAt) ||
                other.uploadedAt == uploadedAt) &&
            (identical(other.verifiedAt, verifiedAt) ||
                other.verifiedAt == verifiedAt) &&
            (identical(other.verifiedBy, verifiedBy) ||
                other.verifiedBy == verifiedBy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      organizationId,
      type,
      documentNumber,
      fileUrl,
      expiryDate,
      status,
      rejectionReason,
      uploadedAt,
      verifiedAt,
      verifiedBy);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeeDocumentImplCopyWith<_$EmployeeDocumentImpl> get copyWith =>
      __$$EmployeeDocumentImplCopyWithImpl<_$EmployeeDocumentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmployeeDocumentImplToJson(
      this,
    );
  }
}

abstract class _EmployeeDocument implements EmployeeDocument {
  const factory _EmployeeDocument(
      {@JsonKey(name: '_id') final String? id,
      required final String userId,
      required final String organizationId,
      required final String type,
      final String? documentNumber,
      required final String fileUrl,
      final DateTime? expiryDate,
      required final String status,
      final String? rejectionReason,
      final DateTime? uploadedAt,
      final DateTime? verifiedAt,
      final String? verifiedBy}) = _$EmployeeDocumentImpl;

  factory _EmployeeDocument.fromJson(Map<String, dynamic> json) =
      _$EmployeeDocumentImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  String get userId;
  @override
  String get organizationId;
  @override
  String get type;
  @override
  String? get documentNumber;
  @override
  String get fileUrl;
  @override
  DateTime? get expiryDate;
  @override
  String get status;
  @override
  String? get rejectionReason;
  @override
  DateTime? get uploadedAt;
  @override
  DateTime? get verifiedAt;
  @override
  String? get verifiedBy;
  @override
  @JsonKey(ignore: true)
  _$$EmployeeDocumentImplCopyWith<_$EmployeeDocumentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
