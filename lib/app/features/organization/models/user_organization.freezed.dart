// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_organization.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserOrganization {
  String get id;
  String get userId;
  String get organizationId;
  String get role;
  List<String> get permissions;
  bool get isActive;
  DateTime get joinedAt;
  DateTime?
      get lastAccessedAt; // Flattened organization details for UI convenience
  String? get organizationName;
  String? get organizationCode;
  String? get organizationLogoUrl;

  /// Create a copy of UserOrganization
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserOrganizationCopyWith<UserOrganization> get copyWith =>
      _$UserOrganizationCopyWithImpl<UserOrganization>(
          this as UserOrganization, _$identity);

  /// Serializes this UserOrganization to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserOrganization &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.role, role) || other.role == role) &&
            const DeepCollectionEquality()
                .equals(other.permissions, permissions) &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      organizationId,
      role,
      const DeepCollectionEquality().hash(permissions),
      isActive,
      joinedAt,
      lastAccessedAt,
      organizationName,
      organizationCode,
      organizationLogoUrl);

  @override
  String toString() {
    return 'UserOrganization(id: $id, userId: $userId, organizationId: $organizationId, role: $role, permissions: $permissions, isActive: $isActive, joinedAt: $joinedAt, lastAccessedAt: $lastAccessedAt, organizationName: $organizationName, organizationCode: $organizationCode, organizationLogoUrl: $organizationLogoUrl)';
  }
}

/// @nodoc
abstract mixin class $UserOrganizationCopyWith<$Res> {
  factory $UserOrganizationCopyWith(
          UserOrganization value, $Res Function(UserOrganization) _then) =
      _$UserOrganizationCopyWithImpl;
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
class _$UserOrganizationCopyWithImpl<$Res>
    implements $UserOrganizationCopyWith<$Res> {
  _$UserOrganizationCopyWithImpl(this._self, this._then);

  final UserOrganization _self;
  final $Res Function(UserOrganization) _then;

  /// Create a copy of UserOrganization
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _self.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      permissions: null == permissions
          ? _self.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      joinedAt: null == joinedAt
          ? _self.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastAccessedAt: freezed == lastAccessedAt
          ? _self.lastAccessedAt
          : lastAccessedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      organizationName: freezed == organizationName
          ? _self.organizationName
          : organizationName // ignore: cast_nullable_to_non_nullable
              as String?,
      organizationCode: freezed == organizationCode
          ? _self.organizationCode
          : organizationCode // ignore: cast_nullable_to_non_nullable
              as String?,
      organizationLogoUrl: freezed == organizationLogoUrl
          ? _self.organizationLogoUrl
          : organizationLogoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [UserOrganization].
extension UserOrganizationPatterns on UserOrganization {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_UserOrganization value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserOrganization() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_UserOrganization value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserOrganization():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_UserOrganization value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserOrganization() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String userId,
            String organizationId,
            String role,
            List<String> permissions,
            bool isActive,
            DateTime joinedAt,
            DateTime? lastAccessedAt,
            String? organizationName,
            String? organizationCode,
            String? organizationLogoUrl)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserOrganization() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.organizationId,
            _that.role,
            _that.permissions,
            _that.isActive,
            _that.joinedAt,
            _that.lastAccessedAt,
            _that.organizationName,
            _that.organizationCode,
            _that.organizationLogoUrl);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String userId,
            String organizationId,
            String role,
            List<String> permissions,
            bool isActive,
            DateTime joinedAt,
            DateTime? lastAccessedAt,
            String? organizationName,
            String? organizationCode,
            String? organizationLogoUrl)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserOrganization():
        return $default(
            _that.id,
            _that.userId,
            _that.organizationId,
            _that.role,
            _that.permissions,
            _that.isActive,
            _that.joinedAt,
            _that.lastAccessedAt,
            _that.organizationName,
            _that.organizationCode,
            _that.organizationLogoUrl);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String userId,
            String organizationId,
            String role,
            List<String> permissions,
            bool isActive,
            DateTime joinedAt,
            DateTime? lastAccessedAt,
            String? organizationName,
            String? organizationCode,
            String? organizationLogoUrl)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserOrganization() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.organizationId,
            _that.role,
            _that.permissions,
            _that.isActive,
            _that.joinedAt,
            _that.lastAccessedAt,
            _that.organizationName,
            _that.organizationCode,
            _that.organizationLogoUrl);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UserOrganization implements UserOrganization {
  const _UserOrganization(
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
  factory _UserOrganization.fromJson(Map<String, dynamic> json) =>
      _$UserOrganizationFromJson(json);

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

  /// Create a copy of UserOrganization
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserOrganizationCopyWith<_UserOrganization> get copyWith =>
      __$UserOrganizationCopyWithImpl<_UserOrganization>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserOrganizationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserOrganization &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  String toString() {
    return 'UserOrganization(id: $id, userId: $userId, organizationId: $organizationId, role: $role, permissions: $permissions, isActive: $isActive, joinedAt: $joinedAt, lastAccessedAt: $lastAccessedAt, organizationName: $organizationName, organizationCode: $organizationCode, organizationLogoUrl: $organizationLogoUrl)';
  }
}

/// @nodoc
abstract mixin class _$UserOrganizationCopyWith<$Res>
    implements $UserOrganizationCopyWith<$Res> {
  factory _$UserOrganizationCopyWith(
          _UserOrganization value, $Res Function(_UserOrganization) _then) =
      __$UserOrganizationCopyWithImpl;
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
class __$UserOrganizationCopyWithImpl<$Res>
    implements _$UserOrganizationCopyWith<$Res> {
  __$UserOrganizationCopyWithImpl(this._self, this._then);

  final _UserOrganization _self;
  final $Res Function(_UserOrganization) _then;

  /// Create a copy of UserOrganization
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_UserOrganization(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _self.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      permissions: null == permissions
          ? _self._permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      joinedAt: null == joinedAt
          ? _self.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastAccessedAt: freezed == lastAccessedAt
          ? _self.lastAccessedAt
          : lastAccessedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      organizationName: freezed == organizationName
          ? _self.organizationName
          : organizationName // ignore: cast_nullable_to_non_nullable
              as String?,
      organizationCode: freezed == organizationCode
          ? _self.organizationCode
          : organizationCode // ignore: cast_nullable_to_non_nullable
              as String?,
      organizationLogoUrl: freezed == organizationLogoUrl
          ? _self.organizationLogoUrl
          : organizationLogoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
