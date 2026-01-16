// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'certification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Certification _$CertificationFromJson(Map<String, dynamic> json) {
  return _Certification.fromJson(json);
}

/// @nodoc
mixin _$Certification {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get issuer => throw _privateConstructorUsedError;
  String get fileUrl => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime get expiryDate => throw _privateConstructorUsedError;
  DateTime get uploadedAt => throw _privateConstructorUsedError;
  String? get auditedBy => throw _privateConstructorUsedError;
  DateTime? get auditDate => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CertificationCopyWith<Certification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CertificationCopyWith<$Res> {
  factory $CertificationCopyWith(
          Certification value, $Res Function(Certification) then) =
      _$CertificationCopyWithImpl<$Res, Certification>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String userId,
      String name,
      String issuer,
      String fileUrl,
      String status,
      DateTime expiryDate,
      DateTime uploadedAt,
      String? auditedBy,
      DateTime? auditDate,
      String? notes});
}

/// @nodoc
class _$CertificationCopyWithImpl<$Res, $Val extends Certification>
    implements $CertificationCopyWith<$Res> {
  _$CertificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = null,
    Object? name = null,
    Object? issuer = null,
    Object? fileUrl = null,
    Object? status = null,
    Object? expiryDate = null,
    Object? uploadedAt = null,
    Object? auditedBy = freezed,
    Object? auditDate = freezed,
    Object? notes = freezed,
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
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      issuer: null == issuer
          ? _value.issuer
          : issuer // ignore: cast_nullable_to_non_nullable
              as String,
      fileUrl: null == fileUrl
          ? _value.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      expiryDate: null == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      uploadedAt: null == uploadedAt
          ? _value.uploadedAt
          : uploadedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      auditedBy: freezed == auditedBy
          ? _value.auditedBy
          : auditedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      auditDate: freezed == auditDate
          ? _value.auditDate
          : auditDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CertificationImplCopyWith<$Res>
    implements $CertificationCopyWith<$Res> {
  factory _$$CertificationImplCopyWith(
          _$CertificationImpl value, $Res Function(_$CertificationImpl) then) =
      __$$CertificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String userId,
      String name,
      String issuer,
      String fileUrl,
      String status,
      DateTime expiryDate,
      DateTime uploadedAt,
      String? auditedBy,
      DateTime? auditDate,
      String? notes});
}

/// @nodoc
class __$$CertificationImplCopyWithImpl<$Res>
    extends _$CertificationCopyWithImpl<$Res, _$CertificationImpl>
    implements _$$CertificationImplCopyWith<$Res> {
  __$$CertificationImplCopyWithImpl(
      _$CertificationImpl _value, $Res Function(_$CertificationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = null,
    Object? name = null,
    Object? issuer = null,
    Object? fileUrl = null,
    Object? status = null,
    Object? expiryDate = null,
    Object? uploadedAt = null,
    Object? auditedBy = freezed,
    Object? auditDate = freezed,
    Object? notes = freezed,
  }) {
    return _then(_$CertificationImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      issuer: null == issuer
          ? _value.issuer
          : issuer // ignore: cast_nullable_to_non_nullable
              as String,
      fileUrl: null == fileUrl
          ? _value.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      expiryDate: null == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      uploadedAt: null == uploadedAt
          ? _value.uploadedAt
          : uploadedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      auditedBy: freezed == auditedBy
          ? _value.auditedBy
          : auditedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      auditDate: freezed == auditDate
          ? _value.auditDate
          : auditDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CertificationImpl implements _Certification {
  const _$CertificationImpl(
      {@JsonKey(name: '_id') this.id,
      required this.userId,
      required this.name,
      required this.issuer,
      required this.fileUrl,
      this.status = 'Pending',
      required this.expiryDate,
      required this.uploadedAt,
      this.auditedBy,
      this.auditDate,
      this.notes});

  factory _$CertificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$CertificationImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final String userId;
  @override
  final String name;
  @override
  final String issuer;
  @override
  final String fileUrl;
  @override
  @JsonKey()
  final String status;
  @override
  final DateTime expiryDate;
  @override
  final DateTime uploadedAt;
  @override
  final String? auditedBy;
  @override
  final DateTime? auditDate;
  @override
  final String? notes;

  @override
  String toString() {
    return 'Certification(id: $id, userId: $userId, name: $name, issuer: $issuer, fileUrl: $fileUrl, status: $status, expiryDate: $expiryDate, uploadedAt: $uploadedAt, auditedBy: $auditedBy, auditDate: $auditDate, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CertificationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.issuer, issuer) || other.issuer == issuer) &&
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate) &&
            (identical(other.uploadedAt, uploadedAt) ||
                other.uploadedAt == uploadedAt) &&
            (identical(other.auditedBy, auditedBy) ||
                other.auditedBy == auditedBy) &&
            (identical(other.auditDate, auditDate) ||
                other.auditDate == auditDate) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, name, issuer,
      fileUrl, status, expiryDate, uploadedAt, auditedBy, auditDate, notes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CertificationImplCopyWith<_$CertificationImpl> get copyWith =>
      __$$CertificationImplCopyWithImpl<_$CertificationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CertificationImplToJson(
      this,
    );
  }
}

abstract class _Certification implements Certification {
  const factory _Certification(
      {@JsonKey(name: '_id') final String? id,
      required final String userId,
      required final String name,
      required final String issuer,
      required final String fileUrl,
      final String status,
      required final DateTime expiryDate,
      required final DateTime uploadedAt,
      final String? auditedBy,
      final DateTime? auditDate,
      final String? notes}) = _$CertificationImpl;

  factory _Certification.fromJson(Map<String, dynamic> json) =
      _$CertificationImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  String get userId;
  @override
  String get name;
  @override
  String get issuer;
  @override
  String get fileUrl;
  @override
  String get status;
  @override
  DateTime get expiryDate;
  @override
  DateTime get uploadedAt;
  @override
  String? get auditedBy;
  @override
  DateTime? get auditDate;
  @override
  String? get notes;
  @override
  @JsonKey(ignore: true)
  _$$CertificationImplCopyWith<_$CertificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
