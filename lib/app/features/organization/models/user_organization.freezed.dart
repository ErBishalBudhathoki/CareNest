// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_organization.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserOrganization _$UserOrganizationFromJson(Map<String, dynamic> json) {
  return _UserOrganization.fromJson(json);
}

/// @nodoc
mixin _$UserOrganization {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  List<String> get permissions => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime get joinedAt => throw _privateConstructorUsedError;
  DateTime? get lastAccessedAt =>
      throw _privateConstructorUsedError; // Flattened organization details for UI convenience
  String? get organizationName => throw _privateConstructorUsedError;
  String? get organizationCode => throw _privateConstructorUsedError;
  String? get organizationLogoUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserOrganizationCopyWith<UserOrganization> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserOrganizationCopyWith<$Res> {
  factory $UserOrganizationCopyWith(
          UserOrganization value, $Res Function(UserOrganization) then) =
      _$UserOrganizationCopyWithImpl<$Res, UserOrganization>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String organizationId,
      String role,
      List<String> permissions,
      bool isActive,
      DateTime joinedAt,
      DateTime? lastAccessedAt,
      String? organizationName,
      String? organizationCode,
      String? organizationLogoUrl});
}

/// @nodoc
class _$UserOrganizationCopyWithImpl<$Res, $Val extends UserOrganization>
    implements $UserOrganizationCopyWith<$Res> {
  _$UserOrganizationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? organizationId = null,
    Object? role = null,
    Object? permissions = null,
    Object? isActive = null,
    Object? joinedAt = null,
    Object? lastAccessedAt = freezed,
    Object? organizationName = freezed,
    Object? organizationCode = freezed,
    Object? organizationLogoUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      permissions: null == permissions
          ? _value.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      joinedAt: null == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastAccessedAt: freezed == lastAccessedAt
          ? _value.lastAccessedAt
          : lastAccessedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      organizationName: freezed == organizationName
          ? _value.organizationName
          : organizationName // ignore: cast_nullable_to_non_nullable
              as String?,
      organizationCode: freezed == organizationCode
          ? _value.organizationCode
          : organizationCode // ignore: cast_nullable_to_non_nullable
              as String?,
      organizationLogoUrl: freezed == organizationLogoUrl
          ? _value.organizationLogoUrl
          : organizationLogoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserOrganizationImplCopyWith<$Res>
    implements $UserOrganizationCopyWith<$Res> {
  factory _$$UserOrganizationImplCopyWith(_$UserOrganizationImpl value,
          $Res Function(_$UserOrganizationImpl) then) =
      __$$UserOrganizationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String organizationId,
      String role,
      List<String> permissions,
      bool isActive,
      DateTime joinedAt,
      DateTime? lastAccessedAt,
      String? organizationName,
      String? organizationCode,
      String? organizationLogoUrl});
}

/// @nodoc
class __$$UserOrganizationImplCopyWithImpl<$Res>
    extends _$UserOrganizationCopyWithImpl<$Res, _$UserOrganizationImpl>
    implements _$$UserOrganizationImplCopyWith<$Res> {
  __$$UserOrganizationImplCopyWithImpl(_$UserOrganizationImpl _value,
      $Res Function(_$UserOrganizationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? organizationId = null,
    Object? role = null,
    Object? permissions = null,
    Object? isActive = null,
    Object? joinedAt = null,
    Object? lastAccessedAt = freezed,
    Object? organizationName = freezed,
    Object? organizationCode = freezed,
    Object? organizationLogoUrl = freezed,
  }) {
    return _then(_$UserOrganizationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      permissions: null == permissions
          ? _value._permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      joinedAt: null == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastAccessedAt: freezed == lastAccessedAt
          ? _value.lastAccessedAt
          : lastAccessedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      organizationName: freezed == organizationName
          ? _value.organizationName
          : organizationName // ignore: cast_nullable_to_non_nullable
              as String?,
      organizationCode: freezed == organizationCode
          ? _value.organizationCode
          : organizationCode // ignore: cast_nullable_to_non_nullable
              as String?,
      organizationLogoUrl: freezed == organizationLogoUrl
          ? _value.organizationLogoUrl
          : organizationLogoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserOrganizationImpl implements _UserOrganization {
  const _$UserOrganizationImpl(
      {required this.id,
      required this.userId,
      required this.organizationId,
      required this.role,
      final List<String> permissions = const [],
      this.isActive = true,
      required this.joinedAt,
      this.lastAccessedAt,
      this.organizationName,
      this.organizationCode,
      this.organizationLogoUrl})
      : _permissions = permissions;

  factory _$UserOrganizationImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserOrganizationImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String organizationId;
  @override
  final String role;
  final List<String> _permissions;
  @override
  @JsonKey()
  List<String> get permissions {
    if (_permissions is EqualUnmodifiableListView) return _permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_permissions);
  }

  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime joinedAt;
  @override
  final DateTime? lastAccessedAt;
// Flattened organization details for UI convenience
  @override
  final String? organizationName;
  @override
  final String? organizationCode;
  @override
  final String? organizationLogoUrl;

  @override
  String toString() {
    return 'UserOrganization(id: $id, userId: $userId, organizationId: $organizationId, role: $role, permissions: $permissions, isActive: $isActive, joinedAt: $joinedAt, lastAccessedAt: $lastAccessedAt, organizationName: $organizationName, organizationCode: $organizationCode, organizationLogoUrl: $organizationLogoUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserOrganizationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.role, role) || other.role == role) &&
            const DeepCollectionEquality()
                .equals(other._permissions, _permissions) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt) &&
            (identical(other.lastAccessedAt, lastAccessedAt) ||
                other.lastAccessedAt == lastAccessedAt) &&
            (identical(other.organizationName, organizationName) ||
                other.organizationName == organizationName) &&
            (identical(other.organizationCode, organizationCode) ||
                other.organizationCode == organizationCode) &&
            (identical(other.organizationLogoUrl, organizationLogoUrl) ||
                other.organizationLogoUrl == organizationLogoUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      organizationId,
      role,
      const DeepCollectionEquality().hash(_permissions),
      isActive,
      joinedAt,
      lastAccessedAt,
      organizationName,
      organizationCode,
      organizationLogoUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserOrganizationImplCopyWith<_$UserOrganizationImpl> get copyWith =>
      __$$UserOrganizationImplCopyWithImpl<_$UserOrganizationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserOrganizationImplToJson(
      this,
    );
  }
}

abstract class _UserOrganization implements UserOrganization {
  const factory _UserOrganization(
      {required final String id,
      required final String userId,
      required final String organizationId,
      required final String role,
      final List<String> permissions,
      final bool isActive,
      required final DateTime joinedAt,
      final DateTime? lastAccessedAt,
      final String? organizationName,
      final String? organizationCode,
      final String? organizationLogoUrl}) = _$UserOrganizationImpl;

  factory _UserOrganization.fromJson(Map<String, dynamic> json) =
      _$UserOrganizationImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get organizationId;
  @override
  String get role;
  @override
  List<String> get permissions;
  @override
  bool get isActive;
  @override
  DateTime get joinedAt;
  @override
  DateTime? get lastAccessedAt;
  @override // Flattened organization details for UI convenience
  String? get organizationName;
  @override
  String? get organizationCode;
  @override
  String? get organizationLogoUrl;
  @override
  @JsonKey(ignore: true)
  _$$UserOrganizationImplCopyWith<_$UserOrganizationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
